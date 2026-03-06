---
name: di-and-architecture
description: Keep DI usage and high-level layering consistent in Flutter_Base.
---

# Skill: DI & Architecture — Flutter_Base

## When to Use

- عند إضافة Cubit جديد، UseCase، أو Repository.
- عند ملاحظة إنشاء يدوي لـ services داخل الـ UI.

## What to Do

1. **تحقق من Cubits:**
   - كل Cubit جديد:
     - عليه `@injectable`.
     - يتم إنشاؤه في الـ UI عن طريق `injector<MyCubit>()` داخل `BlocProvider`.

2. **تحقق من أماكن استخدام Dio / HTTP:**
   - يجب أن تكون محصورة في:
     - data layer (datasources, repositories).
   - لا يوجد:
     - `Dio()` أو `http.get` داخل presentation.

3. **الـ Endpoints:**
   - كل URL في `ApiConstants` فقط.
   - لا يوجد string ثابت للـ endpoint في cubits أو views.

## Output

بعد تشغيل هذا الـ skill:
- لخّص أي:
  - Cubits تم تعديلها لتستخدم `injector`.
  - أماكن تم نقل `Dio` منها إلى data layer. 

