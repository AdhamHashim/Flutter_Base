---
name: naming-and-cleanup
description: Naming conventions (PascalCase classes, snake_case files, camelCase variables, VerbNounCubit, NounEntity), access modifiers (private _ for internal), unused imports/parameters cleanup, const everywhere policy, and models/enums living in entity/ folder. Apply at end of every feature; run flutter analyze.
---

# Naming & Cleanup — Apply at End of Every Feature

> Run `flutter analyze` after every feature.

## 19. Access Modifiers — ALWAYS Apply

> Use proper Dart access modifiers when creating classes, methods, and fields.

```dart
// ✅ Private widget (used only inside same file / part-of file)
class _MyFeatureBody extends StatelessWidget { ... }

// ✅ Private method (not exposed outside class)
void _handleTap() { ... }

// ✅ Private field
final String _internalValue;

// ✅ Public API — only what needs to be accessed from outside
class MyFeatureCubit extends AsyncCubit<List<ItemEntity>> {
  Future<void> fetchItems() async { ... }  // public — called from view
  void _processData(List data) { ... }     // private — internal logic
}

// ❌ WRONG — everything public by default
class MyWidget {
  String helperValue = '';          // should be _helperValue if internal
  void processInternal() { ... }   // should be _processInternal if not needed outside
}
```

**Rules:**
- Widget classes used only within their feature file → prefix with `_` (private)
- Helper methods not called from outside → prefix with `_`
- Fields not exposed to other classes → prefix with `_`
- Only expose what is needed for the public API

---


---

## 20. Naming Conventions — MANDATORY

> Every variable, function, class, and file name MUST be descriptive and self-documenting.

| Element | Convention | Example |
|---|---|---|
| File names | `snake_case` | `category_factories_body.dart` |
| Class names | `PascalCase` | `CategoryFactoriesBody` |
| Variables / fields | `camelCase` | `selectedCategory`, `isLoading` |
| Constants | `camelCase` or `SCREAMING_SNAKE` | `maxRetryCount`, `API_TIMEOUT` |
| Functions / methods | `camelCase`, verb-first | `fetchCategories()`, `deleteItem()`, `handleSubmit()` |
| Cubits | `VerbNounCubit` | `GetCategoriesCubit`, `DeleteItemCubit` |
| Entities | `NounEntity` | `CategoryEntity`, `ProductEntity` |
| Params | `NounParams` | `AddProductParams`, `LoginParams` |
| Screens | `NounScreen` | `CategoryFactoriesScreen` |
| Body widgets | `NounBody` | `CategoryFactoriesBody` |

```dart
// ✅ GOOD — descriptive names
final List<CategoryEntity> availableCategories;
Future<void> fetchCategoryFactories() async { ... }
class GetCategoryFactoriesCubit extends AsyncCubit<...> { ... }

// ❌ BAD — vague/abbreviated
final List<CategoryEntity> data;    // "data" tells nothing
Future<void> fetch() async { ... }  // fetch what?
class MyCubit extends AsyncCubit<...> { ... } // "My" is meaningless
```

---


---

## 29. Clean Code — Remove Unused Imports & Parameters (MANDATORY)

> **كل ملف لازم يكون نظيف — لا imports مش مستخدمة ولا parameters مش مستخدمة.**

```dart
// ❌ FORBIDDEN — unused import
import 'package:flutter/foundation.dart'; // ← not used anywhere in file

// ❌ FORBIDDEN — unused optional parameter warning
class MyWidget extends StatelessWidget {
  final String? subtitle;  // ← never passed by any caller → REMOVE IT
  const MyWidget({super.key, this.subtitle});
}
// Warning: "A value for optional parameter 'subtitle' isn't ever given."

// ✅ CORRECT — only declare parameters that are actually used
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
}
```

**Rules:**
- بعد كل feature → شغّل `flutter analyze` وشيل كل unused imports
- لو parameter مش بيتبعت من أي caller → شيله
- لو parameter هيتحتاج في المستقبل → أضفه لما تحتاجه فعلاً، مش من الأول

---


---

## 30. const — Add to EVERY Widget That Can Be const (MANDATORY)

> **أي widget أو constructor ممكن يبقى const → لازم يبقى const.**

```dart
// ✅ CORRECT
const _MyBody()
const SizedBox.shrink()
const EdgeInsets.all(0)
children: const [Divider()]

// ❌ WRONG — missing const
_MyBody()           // ← can be const, add it!
SizedBox.shrink()   // ← can be const, add it!
```

**Quick rule:** لو Flutter analyzer بيقولك "Prefer const" → أضفها. دي بتقلل rebuilds وبتحسن performance.

---


---

## 31. Models & Enums → Entity Folder ONLY (NEVER Inside Widgets)

> **أي model, enum, helper class خاص بالـ feature لازم يكون في `entity/` folder — مش جوا widget class.**

```dart
// ✅ CORRECT — status model in entity folder
// entity/transaction_status_model.dart
class TransactionStatusModel {
  final String key;
  final String label;
  final Color bgColor;
  final Color textColor;

  const TransactionStatusModel({
    required this.key, required this.label,
    required this.bgColor, required this.textColor,
  });

  static TransactionStatusModel fromStatus(String status) {
    switch (status) {
      case 'paid':
        return TransactionStatusModel(
          key: status, label: LocaleKeys.paid.tr(),
          bgColor: AppColors.danger.withValues(alpha: 0.1),
          textColor: AppColors.danger,
        );
      case 'completed':
        return TransactionStatusModel(
          key: status, label: LocaleKeys.completed.tr(),
          bgColor: AppColors.green10,
          textColor: AppColors.green,
        );
      default:
        return TransactionStatusModel(
          key: status, label: status,
          bgColor: AppColors.grey1,
          textColor: AppColors.hintText,
        );
    }
  }
}

// ✅ Usage in widget — clean and simple
final statusModel = TransactionStatusModel.fromStatus(transaction.status);
Text(statusModel.label, style: const TextStyle().setColor(statusModel.textColor).s12.medium)

// ❌ FORBIDDEN — helper methods scattered inside widget class
class _TransactionCard extends StatelessWidget {
  String _statusKey(String status) { ... }      // ← move to model!
  Color _statusBgColor(String status) { ... }   // ← move to model!
  Color _statusTextColor(String status) { ... } // ← move to model!
}
```

**Rules:**
- كل logic خاص بتحويل data (status → color, status → label) → model/entity
- Widget = UI فقط، يستدعي الـ model ويعرض النتيجة
- لو الـ model مشترك بين أكثر من feature → `app_shared/entity/`

---

