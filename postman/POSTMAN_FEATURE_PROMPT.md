# برومبت توليد Postman Collection لفيتشر جديدة (Wzein / Flutter_Base)

انسخ القالب التالي في رسالة جديدة مع تعبئة الأقواس، ثم أرفق مسارات المجلدات أو ملفات الـ feature من المشروع.

---

## القالب (انسخ من هنا)

```
أنت تعمل على مشروع Flutter (Wzein) مع معمارية Flutter_Base.

المهمة: أنشئ ملف JSON لمجموعة Postman v2.1.0 collection واحدة للفيتشر التالية فقط.

### 1) نطاق الفيتشر
- اسم الفيتشر: [FEATURE_NAME]
- مسارات الكود (للمرجعية): 
  - [مثال: lib/src/features/xxx/ ...]

### 2) مصادر الحقيقة (بالترتيب)
1. اقرأ `lib/src/core/network/api_endpoints.dart` — أي endpoint موجود هناك يجب أن يطابق **نفس المسار النسبي** (بدون domain) في Postman.
2. اقرأ الـ Cubits / UseCases في الفيتشر لمعرفة: HTTP method، query parameters، شكل الـ mapper (مثلاً `json['data']`, `json['data']['data']`, `json['pagination']`).
3. اقرأ الـ Entity / Params classes لاستخراج **أسماء الحقول في JSON** (snake_case للـ API إن أمكن لتطابق `fromJson` و `toJson`).
4. إن كانت الشاشة UI-only بدون API بعد، ضع مجلداً في الـ collection باسم "(suggested)" واذكر أن المسار مقترح وأن `ApiConstants` يحتاج إضافة لاحقاً.

### 3) متطلبات الـ JSON
- `info.name`: واضح ومسبوق برقم أو اسم الفيتشر.
- `variable`: على الأقل `baseUrl` (ينتهي بـ `/`)، و`accessToken` لأي route يحتاج Bearer.
- لكل طلب:
  - `name` وصفي بالإنجليزية أو العربية.
  - `request.method`, `request.url` = `{{baseUrl}}` + المسار كما في `ApiConstants`.
  - Headers: `Accept: application/json`, `Accept-Language: ar`, و`Content-Type` لـ POST/PATCH/PUT، و`Authorization: Bearer {{accessToken}}` عند الحاجة.
  - `body` (raw JSON) بقيم placeholder واقعية.
  - **`response` (إلزامي):** مصفوفة فيها Example واحد على الأقل بصيغة Postman v2.1 (`name`, `code`, `status`, `_postman_previewlanguage: json`, `header`, `body` كنص JSON كامل يمثل **نجاح** 200/201، مع `msg`/`key`/`data` عندما ينطبق `BaseModel`.
  - `description` (Markdown) يحتوي:
    - جدول أو قائمة **مفاتيح الـ request body / query** مع معنى كل حقل وارتباطه بالـ UI أو Params class.
    - **شكل الـ response** المتوقع: المفاتيح داخل `data` أو القائمة + `pagination` إن وُجدت — متوافق مع `PaginationMeta` في المشروع (`total_items`, `count_items`, `per_page`, `total_pages`, `current_page`, `next_page_url`, `perv_page_url`).
    - إن وُجدت رسائل عامة: `msg`, `key` كما في `BaseModel`.

### 4) التنظيم
- folders حسب التدفق (مثلاً: List → Detail → Create → Update → Delete).
- لا تضف endpoints عشوائية؛ كل مسار إما من الكود أو مُعلَّم صراحةً كـ **suggested** مع تبرير من الـ Entity/UI.

### 5) المخرجات
- ملف واحد: `postman/[feature_snake_case].postman_collection.json`
- لا تضف شرح خارج الملف إلا إذا طُلب؛ المحتوى التوضيحي داخل `description` لكل request.
```

---

## ملاحظات سريعة لمطابقة المشروع

| الموضوع | المرجع في الكود |
|--------|------------------|
| ترقيم الصفحات | `ConstantManager.paginateJson` → `page`, `paginate` |
| إشعارات | قائمة: `data` + `pagination`؛ العدد غير المقروء: `data.count` |
| اتصل بنا | `name`, `phone`, `text` |
| FAQ | عناصر: `id`, `question`, `answer` تحت `data` كقائمة |
| فاتورة (`BillEntity`) | `id`, `display_number`, `amount`, `item_type`, `purchase_date`, `warranty_end_date`, `attachment_name` |

---

## مثال استخدام قصير

```
اسم الفيتشر: Orders
المسارات: lib/src/features/orders/...
```

ثم الصق القالب كاملاً بعد تعبئة `[FEATURE_NAME]` والمسارات.
