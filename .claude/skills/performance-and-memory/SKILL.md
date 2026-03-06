---
name: performance-and-memory
description: Performance tuning + memory/lifecycle checklist for Flutter_Base features.
---

# Skill: Performance & Memory — Flutter_Base

## When to Use

- قبل تسليم أي feature فيها:
  - Lists كبيرة، شبكات (Grids)، أو شاشات multi-section.
  - Animations, search مع debounce, أو scroll مع data كثيرة.
- عند ملاحظة:
  - jank أثناء الـ scroll.
  - frame drops وقت загруз البيانات.

## What to Check

### 1. Const Usage

- مرّ على الملف وابحث عن أماكن تقدر تحط فيها `const`:
  - Widgets ثابتة في الـ tree (Text, IconWidget, Containers...).
  - Constructors بدون params متغيرة.

### 2. Lists & Slivers

- تأكد أن:
  - تستخدم `ListView.builder` / `SliverList.builder` للقوائم.
  - لا يوجد `shrinkWrap: true` داخل `SingleChildScrollView` لقوائم بيانات.
  - للشاشات متعددة الأقسام: `CustomScrollView + Slivers` كما هو موضّح في `flutter-feature-development.mdc`.

### 3. Heavy JSON Parsing

- لو الشاشة home/dashboard أو فيها 4+ API calls:
  - فكّر تستخدم `compute()` في الـ mapper كما في القاعدة:
    - top-level function `_parseX`.
    - `mapper: (json) => compute(_parseX, json)`.

### 4. Lifecycle & Disposal

- لكل `StatefulWidget`:
  - راجع:
    - `TextEditingController`
    - `ScrollController`
    - `AnimationController`
    - `StreamSubscription`
    - `PublishSubject` / `BehaviorSubject`
  - تأكد أن كل واحد منهم يُعمل له `dispose()` / `cancel()` / `close()` في `dispose()`.
  - تأكد من `if (!mounted) return;` قبل أي `setState` بعد `await`.

## Output

عند استخدام هذا الـ skill، قدّم للمستخدم:
- قائمة مختصرة بما تم تحسينه (consts, lists, dispose).
- أي أماكن ما زالت تحتاج refactor أكبر (لو موجودة). 

