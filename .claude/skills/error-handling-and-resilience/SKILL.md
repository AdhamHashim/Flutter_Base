---
name: error-handling-and-resilience
description: Ensure robust error handling, retries, and user feedback for API-driven features.
---

# Skill: Error Handling & Resilience — Flutter_Base

## When to Use

- بعد ربط أي شاشة بـ API.
- عند حدوث:
  - شاشة فاضية بدون رسائل واضحة.
  - أخطاء بدون feedback للمستخدم.
  - شكاوى أن التطبيق "يسكت" عند فشل الطلب.

## What to Do

1. **راجع Cubit:**
   - استخدم `executeAsync` في كل API call.
   - عرّف بوضوح:
     - حالات النجاح `setSuccess`.
     - حالات الخطأ `setError(errorMessage: ..., showToast: true/false)`.

2. **راجع الـ View مع `AsyncBlocBuilder`:**
   - هل يوجد:
     - `skeletonBuilder` صحيح؟
     - `builder` يتعامل مع `data.isEmpty`؟
     - `errorBuilder` يعرض `ErrorView` مع `onRetry`؟

3. **راجع رسائل الـ Toast / SnackBar:**
   - استخدم `MessageUtils.showSnackBar`.
   - تأكد أن:
     - رسائل النجاح/الفشل مفهومة (من LocaleKeys).

4. **تحقق من fromJson:**
   - لا يوجد `parse` مباشر.
   - كل الحقول محمية بـ `??` أو `tryParse`.

## Output

قدّم للمستخدم:
- ملخص عن:
  - شكل الـ error states (UI).
  - أماكن retry.
  - أماكن تم إصلاحها لتمنع crashes بسبب JSON. 

