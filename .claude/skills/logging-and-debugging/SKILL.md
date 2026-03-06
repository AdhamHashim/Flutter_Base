---
name: logging-and-debugging
description: Safe logging and debugging practices for Flutter_Base.
---

# Skill: Logging & Debugging — Flutter_Base

## When to Use

- أثناء تتبع bug في feature معينة.
- قبل تسليم الكود للتأكد من خلوه من `print` العشوائي.

## What to Do

1. **مسح سريع للـ prints:**
   - ابحث عن:
     - `print(`
     - `debugPrint(`
   - أي واحدة ليست خلف `kDebugMode` أو داخل logger مركزي → تُحذف.

2. **استخدام AppBlocObserver:**
   - لو bug متعلق بالـ Cubit:
     - راقب الـ logs الصادرة من `AppBlocObserver`.
     - تجنّب تكرار نفس logging داخل كل cubit.

3. **Debug مؤقت:**
   - لو تحتاج logging مؤقت:

```dart
if (kDebugMode) {
  debugPrint('GetOrdersCubit.fetchOrders page=$page search=$search');
}
```

   - وتأكد من إزالة هذا الكود قبل الدمج النهائي.

## Output

بعد استخدام هذا الـ skill:
- اذكر للمستخدم إن كان هناك أي `print`/`debugPrint` تم حذفها أو تركها عن قصد مع توضيح السبب. 

