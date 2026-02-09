# هندسة وحدة الإشعارات (Notification Module Architecture)

شرح مبني على **OOP** و **SOLID** و **Design Patterns** المستخدمة في الكود، مع التبسيط الذي تم (إزالة الـ Resolver).

---

## 1. مبادئ SOLID المستخدمة

### S — Single Responsibility Principle (مسؤولية واحدة)

كل كلاس له مسؤولية واحدة واضحة:

| الكلاس | المسؤولية |
|--------|-----------|
| `NotificationService` | تنسيق FCM + الإشعارات المحلية (لا يعرف تفاصيل Android/iOS) |
| `AndroidNotificationHandler` | كل ما يخص الإشعارات على Android (صلاحيات، قناة، تفاصيل العرض) |
| `IosNotificationHandler` | نفس الشيء لـ iOS |
| `AndroidNotificationConfig` / `IosNotificationConfig` | إعدادات العرض فقط (قناة، أيقونة، صوت، إلخ) |
| `NotificationNavigator` | التعامل مع الضغط على الإشعار والرسالة الابتدائية فقط |
| `NotificationRoutes` | تحويل نوع الإشعار إلى شاشة (استدعاء الـ navigation المناسب) |
| `downloadImageToTempFile` (في الـ helper) | تحميل صورة من رابط وحفظها في ملف مؤقت فقط |

**مثال من الكود:**  
`NotificationService` لا يبني أبداً `AndroidNotificationDetails` أو `DarwinNotificationDetails`؛ الـ Handler هو من يفعل ذلك. الـ Service يكتفي باستدعاء `_handler.buildTextNotificationDetails(...)` أو `buildImageNotificationDetails(...)`.

---

### O — Open/Closed Principle (مفتوح للتوسع مغلق للتعديل)

- **التوسع:** إضافة منصة جديدة (مثلاً Desktop) = إضافة كلاس جديد `DesktopNotificationHandler` يطبق `NotificationPlatformHandler` وتعديل `_resolveHandler()` فقط. لا تحتاج تعديل `NotificationService` الداخلي.
- **التوسع في أنواع الإشعارات:** نوعان حالياً (نص فقط / صورة + نص). إضافة نوع ثالث = إضافة method في الـ Handler واختيار النوع في الـ Service دون كسر الكود الحالي.
- **التوسع في الـ Navigation:** إضافة نوع إشعار جديد = إضافة قيمة في `NotificationType` وكلاس يطبق `NotificationNavigation` (مثل `ComplainDetailsNavigation`). لا تعديل على `NotificationRoutes.navigateByType`.

**مثال:**  
`NotificationNavigation` (interface) والكلاسات التي تطبقه (`HomeNavigation`, `BlockNotificationNavigation`, …) تسمح بإضافة مسارات جديدة بدون تغيير منطق `NotificationRoutes`.

---

### L — Liskov Substitution Principle (استبدال الفرع بالأصل)

- أي `NotificationPlatformHandler` (مثل `AndroidNotificationHandler` أو `IosNotificationHandler`) يمكن استبداله بالآخر من وجهة نظر الـ Service؛ الـ Service يتعامل فقط مع الـ interface.
- أي `NotificationNavigation` يمكن استبداله بآخر؛ `NotificationRoutes` يستدعي `navigation.navigate(data)` دون معرفة التنفيذ الفعلي.

**مثال:**  
في الـ Service: `_handler` من نوع `NotificationPlatformHandler`. يمكن في الاختبارات حقن `FakeNotificationHandler` دون تغيير باقي الـ Service.

---

### I — Interface Segregation Principle (فصل الواجهات)

- **NotificationPlatformHandler:** واجهة خاصة بمنصة الإشعارات فقط (صلاحيات، قناة، تفاصيل عرض نصي، تفاصيل عرض صورة). لا تحتوي على أمور أخرى مثل الـ navigation.
- **BaseNotificationConfig:** واجهة صغيرة (مثلاً `defaultIcon`, `appName`) فقط للإعدادات المشتركة.
- **NotificationNavigation:** واجهة من method واحدة `navigate({required Map<String, dynamic> data})` لمن يريد تنفيذ الانتقال فقط.

لا توجد واجهة ضخمة واحدة تجمع كل السلوك؛ كل مستهلك يعتمد على الواجهة التي يحتاجها فقط.

---

### D — Dependency Inversion Principle (اعتماد على التجريد)

- `NotificationService` يعتمد على **التجريد** `NotificationPlatformHandler` وليس على `AndroidNotificationHandler` أو `IosNotificationHandler` مباشرة في المنطق الداخلي. اختيار التنفيذ يتم مرة واحدة (في `_resolveHandler()` أو عبر الـ constructor عند الحقن).
- الـ Handler بدوره يعتمد على `BaseNotificationConfig` (تجريد)؛ الـ Android config والـ iOS config هما التنفيذ.

**مثال:**  
```dart
// NotificationService
final NotificationPlatformHandler _handler;  // تعتمد على الواجهة
// لا يوجد: AndroidNotificationHandler _androidHandler;
```

---

## 2. أنماط التصميم (Design Patterns) المستخدمة

### Strategy (الاستراتيجية)

- **الفكرة:** سلوك يختلف حسب المنصة (Android vs iOS) دون تغيير الكود الذي يستدعيه.
- **التطبيق:**  
  - `NotificationPlatformHandler` = الاستراتيجية (واجهة).  
  - `AndroidNotificationHandler` و `IosNotificationHandler` = استراتيجيتان مختلفتان.  
  - `NotificationService` = الـ Client الذي يستخدم الاستراتيجية عبر `_handler.buildTextNotificationDetails(...)` و `buildImageNotificationDetails(...)` و `requestPermissions(...)` إلخ.

الـ Service لا يفحص `if (Platform.isAndroid)` عند كل استدعاء؛ الاختيار تم مرة واحدة عند إنشاء الـ Handler.

---

### Template / Interface (واجهة موحدة للسلوك)

- **NotificationNavigation:** كل نوع انتقال (Home، Block، Wallet، …) ينفذ نفس العقدة: `navigate({required Map<String, dynamic> data})`.
- **NotificationRoutes.navigateByType:** يحدد النوع من الـ data ثم يستدعي `notificationType.navigation.navigate(data: navigationData)` دون معرفة أي كلاس بالاسم.

هذا يعطي سلوكاً شبيهاً بـ Template Method أو استخدام واجهة موحدة لسلوك متعدد.

---

### Singleton (مثيل واحد)

- **NotificationNavigator:** يُنشأ مرة واحدة عبر factory ويُحفظ في `_instance`. يستخدم للتعامل مع الضغط على الإشعار والرسالة الابتدائية من FCM في مكان واحد.

---

### Factory (مبسطة)

- **اختيار الـ Handler:** كان سابقاً عبر كلاس `NotificationPlatformResolver`. تم **تبسيطه** إلى دالة خاصة داخل الـ Service:
  - `NotificationService._resolveHandler()` تعيد `AndroidNotificationHandler()` أو `IosNotificationHandler()` حسب `Platform.isAndroid`.
- لا يزال بإمكانك حقن Handler من الخارج للاختبار: `NotificationService(myCustomHandler)`.

---

## 3. OOP المستخدم

### التجريد (Abstraction)

- **Interfaces:**  
  `NotificationPlatformHandler`, `BaseNotificationConfig`, `NotificationNavigation` تعرّف العقد دون تنفيذ. التنفيذ في كلاسات منفصلة.

### التغليف (Encapsulation)

- تفاصيل المنصة (قنوات Android، صلاحيات iOS، بناء `NotificationDetails`) مخفية داخل الـ Handlers والـ Configs. الـ Service لا يتعامل مع `BigPictureStyleInformation` أو `DarwinNotificationDetails` مباشرة.
- الـ Config يغلّف كل الإعدادات (قناة، أيقونة، صوت، اهتزاز) في مكان واحد.

### تعدد الأشكال (Polymorphism)

- استدعاء `_handler.buildTextNotificationDetails(...)` يعمل سواء كان الـ Handler أندرويد أو iOS؛ السلوك يختلف حسب النوع الفعلي.
- استدعاء `notificationType.navigation.navigate(data: ...)` يعمل لأي نوع إشعار؛ التنفيذ يختلف (Home، Block، Wallet، إلخ).

---

## 4. التبسيط الذي تم (إزالة Over-Engineering)

- **قبل:** كان هناك `NotificationPlatformResolver` و `DefaultNotificationPlatformResolver` كلاس منفصل فقط ليختار بين Android و iOS.
- **بعد:** تم حذف الملف `notification_platform_resolver.dart` واستبدال دوره بدالة خاصة داخل الـ Service:
  - `NotificationService._resolveHandler()` تستخدم `Platform.isAndroid` وتعيد `AndroidNotificationHandler()` أو `IosNotificationHandler()`.
- **النتيجة:** نفس السلوك مع عدد أقل من الملفات والطبقات، مع الإبقاء على إمكانية حقن Handler للاختبار عبر `NotificationService(handler)`.

---

## 5. هيكل الملفات (آخر وضع)

```
notification/
├── config/
│   ├── base_notification_config.dart    # واجهة إعدادات (defaultIcon, appName)
│   ├── android_notification_config.dart # إعدادات Android + تفاصيل نصية + BigPicture
│   └── ios_notification_config.dart    # إعدادات iOS
├── platform/
│   ├── notification_platform_handler.dart # واجهة سلوك المنصة (Strategy)
│   ├── android_notification_handler.dart   # تنفيذ Android
│   └── ios_notification_handler.dart      # تنفيذ iOS
├── models/
│   └── notification_display_type.dart   # enum: text | image
├── helpers/
│   └── notification_image_downloader.dart # تحميل صورة من URL لملف مؤقت
├── notification_service.dart           # نقطة الدخول + تنسيق FCM والإشعارات
├── notification_navigator.dart         # Singleton للضغط والرسالة الابتدائية
├── notification_navigation.dart        # واجهة + كلاسات الانتقال (Home, Block, …)
├── notification_routes.dart            # navigateByType + extension للنوع
├── navigation_types.dart               # enum NotificationType وربطه بالـ navigation
└── NOTIFICATION_ARCHITECTURE.md        # هذا الملف
```

---

## 6. ملخص سريع

| المبدأ / النمط | أين في الكود |
|----------------|---------------|
| **SRP** | فصل Service / Handler / Config / Navigator / Routes |
| **OCP** | إضافة Handler أو NotificationNavigation جديد دون تعديل المنطق المركزي |
| **LSP** | استبدال أي Handler أو أي Navigation بآخر دون كسر المستهلك |
| **ISP** | واجهات صغيرة: NotificationPlatformHandler, BaseNotificationConfig, NotificationNavigation |
| **DIP** | Service يعتمد على NotificationPlatformHandler وليس على Android/iOS مباشرة |
| **Strategy** | AndroidNotificationHandler و IosNotificationHandler كاستراتيجيات للعرض والصلاحيات |
| **Singleton** | NotificationNavigator |
| **Factory (مبسطة)** | _resolveHandler() داخل NotificationService |

لو حابب نضيف قسم أمثلة كود (سطور محددة من الملفات) أو نترجم الملف للإنجليزية، نقدر نكمّل في نفس الملف.
