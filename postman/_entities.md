# Entity Reference — Unified API Shapes

> **هذا الملف مرجع للـ Backend team. كل entity لازم يتبع نفس الـ structure في كل مكان.**

---

## Unified Response Envelope

```json
{
  "status": "success | fail",
  "code": 200,
  "message": "رسالة عربية",
  "data": { ... }
}
```

### Paginated List Response

```json
{
  "status": "success",
  "code": 200,
  "message": "تم جلب البيانات بنجاح",
  "data": {
    "data": [ ... ],
    "pagination": {
      "current_page": 1,
      "last_page": 5,
      "per_page": 10,
      "total": 47
    }
  }
}
```

### Error Response — Validation

```json
{
  "status": "fail",
  "code": 422,
  "message": "بيانات غير صالحة",
  "errors": {
    "field_name": ["رسالة الخطأ"]
  }
}
```

---

## Standard Error Codes

| Code | Usage | Message Example |
|------|-------|----------------|
| 200 | Success | تمت العملية بنجاح |
| 201 | Created | تم الإنشاء بنجاح |
| 401 | Unauthorized | بيانات الدخول غير صحيحة |
| 403 | Forbidden | ليس لديك صلاحية |
| 404 | Not Found | العنصر غير موجود |
| 409 | Conflict | البيانات موجودة مسبقاً |
| 422 | Validation Error | بيانات غير صالحة |
| 429 | Rate Limited | يرجى الانتظار قبل المحاولة مرة أخرى |
| 500 | Server Error | حدث خطأ في السيرفر |

---

## UserEntity (Shared)

> **يُستخدم في: login, register, profile, order.customer, review.user**

```json
{
  "id": 7,
  "name": "أحمد محمد",
  "email": "user@example.com",
  "phone": "+501234561",
  "country_code": "+966",
  "full_phone": "+966501234561",
  "image": "https://example.com/storage/uploads/users/avatar.png",
  "lang": "ar",
  "is_active": 1,
  "is_notify": 1,
  "address": "الرياض، حي النخيل",
  "latitude": "24.7136000",
  "longitude": "46.6753000",
  "created_at": "2026-03-07T01:15:40.000000Z",
  "token": "Bearer ..."
}
```

**Notes:**
- `token` يرجع فقط مع login/register
- في nested objects (مثل order.customer) → نفس الـ shape بدون token

---

## ImageEntity (Shared)

> **يرجع من `POST /upload-file`**

```json
{
  "id": 15,
  "url": "https://example.com/storage/uploads/file.jpg",
  "type": "image"
}
```

---

## Rules for Backend Team

1. **Unified Entity Shape**: نفس الـ entity structure في كل مكان (list, detail, nested)
2. **Consistent Keys**: لا تغير اسم الـ key بين endpoints (`name` يفضل `name` مش `product_name`)
3. **Always Include**: `id`, `created_at` في كل entity
4. **Pagination**: كل list endpoint لازم يدعم `?page=1&per_page=10`
5. **File Upload**: سيرفيس واحدة `POST /upload-file` ترجع `{id, url, type}` — الـ id يتبعت في باقي السيرفسات
6. **Arabic Messages**: كل response message بالعربي
7. **Error Consistency**: نفس الـ error format في كل مكان
8. **Null Safety**: لو field مش موجود → ابعته `null` — لا تحذفه من الـ response
