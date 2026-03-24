---
name: mock-data
description: Mock data switching system — environment variable based, unified across all cubits, with mock data file patterns per feature.
---

# Skill: Mock Data System — Flutter_Base

## Purpose

نظام موحد للـ switch بين mock data و real API عبر environment variable.
يشتغل وقت الـ build (مش runtime) — زي الـ flavors.

---

## How It Works

```
flutter run --dart-define=USE_MOCK=true     ← mock mode (design review)
flutter run --dart-define=USE_MOCK=false    ← real API (production)
flutter run                                 ← default = false (real API)
```

---

## Architecture

```
lib/src/core/
├── config/
│   └── mock_config.dart          ← single switch point
│
lib/src/features/{feature}/
├── entity/
│   ├── {feature}_entity.dart     ← real entity (used everywhere)
│   └── {feature}_mock.dart       ← mock data for this feature
├── presentation/
│   └── cubits/
│       └── {feature}_cubit.dart  ← checks MockConfig.useMock
```

---

## Step 1: MockConfig Class (Core — Single Switch Point)

```dart
// File: lib/src/core/config/mock_config.dart

class MockConfig {
  /// Read from --dart-define=USE_MOCK=true|false
  /// Default: false (real API)
  static const bool useMock = bool.fromEnvironment('USE_MOCK', defaultValue: false);

  /// Optional: delay to simulate network latency in mock mode
  static const Duration mockDelay = Duration(milliseconds: 800);

  /// Helper to simulate async loading
  static Future<void> simulateDelay() async {
    if (useMock) await Future.delayed(mockDelay);
  }
}
```

> **`bool.fromEnvironment`** يقرأ `--dart-define` وقت الـ compile.
> مش محتاج packages — built-in في Dart.

---

## Step 2: Mock Data Files (Per Feature)

### Pattern

```dart
// File: lib/src/features/products/entity/product_mock.dart

part of '../presentation/imports/view_imports.dart';

class ProductMock {
  ProductMock._();

  // ---- List ----
  static List<ProductEntity> get list => List.generate(
    10,
    (i) => ProductEntity(
      id: '${i + 1}',
      name: 'منتج تجريبي ${i + 1}',
      image: 'https://picsum.photos/seed/product$i/200/200',
      price: (i + 1) * 50.0,
      categoryName: 'فئة ${(i % 3) + 1}',
      createdAt: DateTime(2026, 1, i + 1),
    ),
  );

  // ---- Detail ----
  static ProductEntity get detail => list.first;

  // ---- Paginated Response (simulates API structure) ----
  static Map<String, dynamic> paginatedResponse(int page, {int perPage = 10}) => {
    'data': {
      'data': list.skip((page - 1) * perPage).take(perPage)
          .map((e) => e.toJson()).toList(),
      'pagination': {
        'current_page': page,
        'last_page': 3,
        'per_page': perPage,
        'total': 25,
      },
    },
  };
}
```

### Naming Convention

| Feature | Mock File | Class |
|---------|-----------|-------|
| Products | `product_mock.dart` | `ProductMock` |
| Orders | `order_mock.dart` | `OrderMock` |
| Notifications | `notification_mock.dart` | `NotificationMock` |
| Auth | `auth_mock.dart` | `AuthMock` |

---

## Step 3: Cubit Integration

### GET List (AsyncCubit)

```dart
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async {
    if (MockConfig.useMock) {
      setLoading();
      await MockConfig.simulateDelay();
      setSuccess(data: ProductMock.list);
      return;
    }
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => (json['data']['data'] as List)
            .map((e) => ProductEntity.fromJson(e)).toList(),
      )),
    );
  }
}
```

### GET Detail (AsyncCubit)

```dart
@injectable
class ProductDetailCubit extends AsyncCubit<ProductEntity> {
  ProductDetailCubit() : super(ProductEntity.initial());

  Future<void> fetchProduct(String id) async {
    if (MockConfig.useMock) {
      setLoading();
      await MockConfig.simulateDelay();
      setSuccess(data: ProductMock.detail);
      return;
    }
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.productDetail(id),
        httpRequestType: HttpRequestType.get,
        mapper: (json) => ProductEntity.fromJson(json['data']),
      )),
    );
  }
}
```

### POST/PUT (Action Cubit)

```dart
@injectable
class CreateProductCubit extends AsyncCubit<ProductEntity> {
  CreateProductCubit() : super(ProductEntity.initial());

  Future<void> createProduct(ProductParams params) async {
    if (MockConfig.useMock) {
      setLoading();
      await MockConfig.simulateDelay();
      // Return mock entity with generated ID
      setSuccess(data: ProductEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: params.name,
        image: 'https://picsum.photos/200',
        price: params.price,
        categoryName: 'فئة تجريبية',
        createdAt: DateTime.now(),
      ));
      return;
    }
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.post,
        body: params.toJson(),
        mapper: (json) => ProductEntity.fromJson(json['data']),
      )),
    );
  }
}
```

### DELETE (Action Cubit)

```dart
@injectable
class DeleteProductCubit extends AsyncCubit<BaseModel?> {
  DeleteProductCubit() : super(null);

  Future<void> deleteProduct(String id) async {
    if (MockConfig.useMock) {
      setLoading();
      await MockConfig.simulateDelay();
      setSuccess(data: BaseModel(message: 'تم الحذف بنجاح'));
      return;
    }
    await executeAsync(
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.deleteProduct(id),
        httpRequestType: HttpRequestType.delete,
        mapper: (json) => BaseModel.fromJson(json),
      )),
    );
  }
}
```

### PaginatedCubit

```dart
@injectable
class ProductsCubit extends PaginatedCubit<ProductEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page, {String? key}) async {
    if (MockConfig.useMock) {
      await MockConfig.simulateDelay();
      return Success(ProductMock.paginatedResponse(page));
    }
    return baseCrudUseCase.call(CrudBaseParams(
      api: ApiConstants.products,
      httpRequestType: HttpRequestType.get,
      queryParameters: ConstantManager.paginateJson(page),
      mapper: (json) => json,
    ));
  }

  @override
  List<ProductEntity> parseItems(json) =>
      (json['data'] as List).map((e) => ProductEntity.fromJson(e)).toList();

  @override
  PaginationMeta parsePagination(json) => PaginationMeta.fromJson(json['pagination']);
}
```

---

## Step 4: Run Commands

```bash
# Design review mode (mock data)
flutter run --dart-define=USE_MOCK=true

# Real API mode (default)
flutter run --dart-define=USE_MOCK=false
flutter run  # same as false

# VS Code launch.json
{
  "configurations": [
    {
      "name": "Flutter (Mock)",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=USE_MOCK=true"]
    },
    {
      "name": "Flutter (Real API)",
      "request": "launch",
      "type": "dart",
      "args": ["--dart-define=USE_MOCK=false"]
    }
  ]
}

# Android Studio run configuration
# Edit Configurations → Additional run args: --dart-define=USE_MOCK=true
```

---

## Mock Data Quality Rules

### Rule 1: Realistic Data

```dart
// ✅ CORRECT — realistic Arabic data
ProductEntity(name: 'آيفون 15 برو ماكس', price: 5499.0, categoryName: 'هواتف ذكية')

// ❌ WRONG — placeholder nonsense
ProductEntity(name: 'Test', price: 0, categoryName: 'Cat1')
```

### Rule 2: Match Entity Fields

```dart
// ✅ CORRECT — all required fields filled
ProductEntity(
  id: '1',
  name: 'منتج تجريبي',
  image: 'https://picsum.photos/200',  // ← real image URL for visual testing
  price: 150.0,
  categoryName: 'إلكترونيات',
  createdAt: DateTime(2026, 1, 15),
)

// ❌ WRONG — missing fields or empty strings
ProductEntity(id: '', name: '', image: '', price: 0, ...)
```

### Rule 3: Enough Items for Testing

```dart
// ✅ List: 8-15 items (tests scrolling, pagination feel)
// ✅ Empty: test empty state separately
// ✅ Variety: different names, prices, categories, dates
```

### Rule 4: Simulate Delay

```dart
// ✅ Always simulate network delay — tests loading/skeleton states
await MockConfig.simulateDelay();  // 800ms default

// ❌ WRONG — instant mock (skips loading state testing)
setSuccess(data: ProductMock.list);  // no delay
```

---

## Mock Data Checklist (Per Feature)

- [ ] `{feature}_mock.dart` created in `entity/` folder
- [ ] Mock class has `list`, `detail` getters (and `paginatedResponse` if paginated)
- [ ] Mock data is realistic (Arabic names, real image URLs, varied values)
- [ ] 8-15 items in lists (enough for scroll testing)
- [ ] All entity fields populated (no empty strings for required fields)
- [ ] Cubit checks `MockConfig.useMock` before API call
- [ ] `MockConfig.simulateDelay()` called in mock path (tests loading states)
- [ ] `MockConfig` imported from `core/config/mock_config.dart`
- [ ] Mock file added as `part` in `view_imports.dart`
- [ ] Tested with `--dart-define=USE_MOCK=true` — screens show mock data correctly

---

## When to Switch to Real API

```
1. Design review phase     → USE_MOCK=true  (focus on UI accuracy)
2. API integration phase   → USE_MOCK=false (connect real endpoints)
3. Testing phase           → USE_MOCK=false (real data flow)
4. Production              → USE_MOCK=false (always)
```

> **الـ mock code يفضل موجود في الـ codebase — مش بنحذفه.**
> **مفيد لـ: UI testing, demo builds, offline development, onboarding new devs.**
