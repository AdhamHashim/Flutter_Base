# كيف تستخدم المشروع مع Claude Code و Cursor

## Cursor

### بدء فيشتر جديد

1. افتح الملف `.cursor/prompt/feature_prompt.md`
2. انسخ المحتوى
3. حط البيانات:
   - **Feature:** اسم الفيشتر
   - **Figma Node:** لينك الفيجما
   - **Postman Collection:** لينك البوستمان (أو: لا يوجد حالياً)
4. ابعت في شات Cursor

### القواعد التلقائية (Auto-Applied Rules)

Cursor بيطبق تلقائياً 20 rule من `.cursor/rules/` على ملفات `lib/**/*.dart`:

| القاعدة | الوصف |
|---------|-------|
| `flutter-base-coding-standards.mdc` | المرجع الأساسي — ألوان، أحجام، نصوص، ويدجتس |
| `flutter-feature-development.mdc` | Workflow كامل من Figma لحد التسليم |
| `feature-prompt.mdc` | برومبت الفيشتر الكامل |
| `scaffold-statusbar.mdc` | أنواع الـ Scaffold + Status Bar |
| `clean-code-and-refactoring.mdc` | تقسيم الويدجتس + إعادة الاستخدام |
| `design-tokens.mdc` | تحويل Figma → Flutter tokens |
| `figma-mcp-mapping.mdc` | ربط قيم Figma بالكود |
| `figma-to-flutter.mdc` | تحويل Figma لـ Flutter بالكامل |
| `performance-and-memory.mdc` | أداء + ذاكرة + dispose |
| `error-handling-and-resilience.mdc` | معالجة الأخطاء + retry |
| `di-and-architecture.mdc` | Dependency Injection + طبقات |
| `search-field-debounce.mdc` | حقل بحث حقيقي + debounce |
| `logging-and-debugging.mdc` | لا print/debugPrint في الكود النهائي |
| `accessibility.mdc` | Tap targets + semantic labels |
| `bloc-patterns.mdc` | AsyncCubit + CRUD + BlocListener |
| `rtl-arabic.mdc` | قواعد RTL + منع الانعكاس |
| `post-feature-review.mdc` | مراجعة تلقائية بعد كل فيشتر |
| `pubspec-manager.mdc` | إدارة الباكدجات + إعدادات المنصات |
| `figma-task-extractor.mdc` | استخراج مهام من ملف Figma |
| `flutter-patterns.mdc` | أنماط الويدجتس + هيكل الملفات |

---

## Claude Code

### بدء فيشتر جديد

اكتب في الشات:

```
/feature-prompt

Feature: الإشعارات
Figma Node: https://figma.com/design/xxx?node-id=123-456
Postman Collection: https://www.postman.com/xxx/collection/xxx
```

الـ skill هتتحمل تلقائي وهتمشي على كل الـ skills الـ 19 وتبدأ الـ 7 steps:

| الخطوة | الوصف | إيه اللي بيحصل |
|--------|-------|----------------|
| **STEP 1** | تحميل القواعد | بيقرأ كل الـ 19 skill (coding-standards, bloc-patterns, rtl-arabic, etc.) |
| **STEP 2** | فحص الكود الموجود | بيقرأ `color_manager.dart` + `app_sizes.dart` + `assets.gen.dart` + `core/widgets/` + الفيشترز الموجودة — عشان يستخدم اللي موجود ومايكررش |
| **STEP 3** | قراءة Figma (MCP) | بيقرأ **كل** الشاشات: main + empty + loading + error + modals + bottom sheets. بيحول الألوان والأحجام والخطوط لـ AppColors/AppSize/FontSizeManager |
| **STEP 4** | قراءة API (Postman MCP) | بيقرأ الـ request/response schema، بيحدد إذا فيه pagination، بيخطط الـ CRUD local updates |
| **STEP 5** | الخطة (تنتظر موافقتك) | بيعرضلك: هيكل الملفات، Entity fields، قائمة الـ cubits، ألوان/أحجام جديدة، locale keys، نوع الـ Scaffold، خطة CRUD |
| **STEP 6** | التنفيذ | بيكتب الكود كامل — entity + cubits + view + widgets — كل ملف في مكانه الصح |
| **STEP 7** | التحقق والمراجعة | `flutter analyze` + RTL check + فحص 19 نقطة + تشغيل `/post-feature-review` تلقائي |

### مثال عملي

```
/feature-prompt

Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Postman Collection: https://www.postman.com/team-name/workspace/collection/abc123
```

بعد ما تبعت ده، Claude هيبدأ من STEP 1 لحد STEP 7 تلقائي.
في STEP 5 هيوقف ويستناك توافق على الخطة قبل ما يكتب أي كود.

### الـ Skills المتاحة (19 skill)

اكتب `/اسم-الـskill` لتشغيل أي واحد:

| الأمر | الوصف |
|-------|-------|
| `/feature-prompt` | **ابدأ هنا** — برومبت الفيشتر الكامل |
| `/coding-standards` | المرجع الأساسي — ألوان، أحجام، نصوص، ويدجتس |
| `/feature-development` | Workflow كامل 7 مراحل |
| `/bloc-patterns` | AsyncCubit + CRUD + BlocListener |
| `/flutter-patterns` | أنماط الويدجتس + هيكل الملفات |
| `/design-tokens` | تحويل Figma → Flutter tokens |
| `/figma-to-flutter` | تحويل Figma لـ Flutter |
| `/figma-task-extractor` | استخراج مهام من Figma |
| `/rtl-arabic` | قواعد RTL + منع الانعكاس |
| `/scaffold-patterns` | أنواع الـ Scaffold + Status Bar |
| `/search-field-debounce` | حقل بحث + debounce |
| `/clean-code-and-refactoring` | تقسيم + إعادة استخدام |
| `/di-and-architecture` | DI + طبقات |
| `/error-handling-and-resilience` | معالجة الأخطاء + retry |
| `/logging-and-debugging` | لا print في الكود النهائي |
| `/performance-and-memory` | أداء + ذاكرة + dispose |
| `/pubspec-manager` | باكدجات + إعدادات المنصات |
| `/accessibility` | Tap targets + semantic labels |
| `/post-feature-review` | مراجعة تلقائية بعد كل فيشتر |

### الملف الأساسي

`CLAUDE.md` في root المشروع — Claude Code بيقرأه تلقائياً في كل محادثة. فيه ملخص القواعد والأوامر الأساسية.

---

## الفرق بين الاتنين

| | Cursor | Claude Code |
|---|--------|-------------|
| القواعد | `.cursor/rules/*.mdc` — تتطبق تلقائياً | `.claude/skills/*/SKILL.md` — تتشغل بـ `/اسم` |
| البرومبت | انسخ `feature_prompt.md` وابعته | اكتب `/feature-prompt` |
| Figma MCP | متاح | متاح |
| Postman MCP | متاح | متاح |
| المحتوى | **متطابق 100%** — نفس القواعد في الاتنين | **متطابق 100%** |
