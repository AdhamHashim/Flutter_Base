---
name: mock-data
description: Mock data switching system — environment variable based, unified across all cubits, centralized mock files in config/mocks/, with executeMockOrAsync helper to eliminate boilerplate.
---

# Skill: Mock Data System — Flutter_Base

<!-- centralized-rules -->
> **⚠️ Mock data ممنوع تلقائياً.** See `no-mock-without-permission` skill — لا تضيف mock data بدون طلب صريح من المستخدم.



## Purpose

نظام موحد للـ switch بين mock data و real API عبر environment variable.
يشتغل وقت الـ build (مش runtime) — زي الـ flavors.
Mock data مركزية في `config/mocks/` — الـ cubit يفضل نضيف ومقروء.

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
│   ├── mock_config.dart              ← single switch point + executeMockOrAsync helper
│   └── mocks/                        ← ALL mock data files (centralized)
│       ├── product_mock.dart
│       ├── order_mock.dart
│       ├── notification_mock.dart
│       ├── home_mock.dart
│       └── auth_mock.dart
│
lib/src/features/{feature}/
├── entity/
│   └── {feature}_entity.dart         ← real entity only (NO mock files here)
├── presentation/
│   └── cubits/
│       └── {feature}_cubit.dart      ← uses executeMockOrAsync — clean & readable
```

> **⚠️ Mock files NEVER inside `entity/` folder.**
> All mock files live in `lib/src/core/config/mocks/` — centralized, easy to find, keeps feature folders clean.

---

## Step 1: MockConfig Class (Core — Single Switch Point + Helper)

```dart
// File: lib/src/core/config/mock_config.dart

class MockConfig {
  MockConfig._();

  /// Read from --dart-define=USE_MOCK=true|false
  /// Default: false (real API)
  static const bool useMock =
      bool.fromEnvironment('USE_MOCK', defaultValue: false);

  /// Simulated network latency in mock mode
  static const Duration mockDelay = Duration(milliseconds: 800);

  /// Helper to simulate async loading
  static Future<void> simulateDelay() async {
    if (useMock) await Future.delayed(mockDelay);
  }
}
```

### executeMockOrAsync — Eliminate Boilerplate (MANDATORY)

> **الـ helper ده موجود في `AsyncCubit` كـ method — كل cubit يقدر يستخدمه مباشرة.**
> بيشيل الـ `if (MockConfig.useMock)` المتكرر ويخلي الـ cubit نضيف ومقروء.

```dart
// Inside AsyncCubit base class:

/// Executes mock data if USE_MOCK=true, otherwise calls real API.
/// Eliminates repetitive if(MockConfig.useMock) blocks in every cubit method.
Future<void> executeMockOrAsync({
  required T mockData,
  required Future<Result<T, Failure>> Function() operation,
}) async {
  if (MockConfig.useMock) {
    setLoading();
    await MockConfig.simulateDelay();
    setSuccess(data: mockData);
    return;
  }
  await executeAsync(operation: operation);
}
```

**Usage in cubit — Before vs After:**

```dart
// ❌ BEFORE — repetitive boilerplate in every method
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

// ✅ AFTER — clean, one-liner mock path
Future<void> fetchProducts() async {
  await executeMockOrAsync(
    mockData: ProductMock.list,
    operation: () => baseCrudUseCase.call(CrudBaseParams(
      api: ApiConstants.products,
      httpRequestType: HttpRequestType.get,
      mapper: (json) => (json['data']['data'] as List)
          .map((e) => ProductEntity.fromJson(e)).toList(),
    )),
  );
}
```

---

## Step 2: Mock Data Files (Centralized in config/mocks/)

### File Location Rule

```
lib/src/core/config/mocks/
├── {feature}_mock.dart     ← one file per feature
```

> **NEVER** put mock files inside `features/{feature}/entity/`.
> **ALWAYS** put them in `core/config/mocks/`.

### Mock File Template

```dart
// File: lib/src/core/config/mocks/product_mock.dart

class ProductMock {
  ProductMock._();

  // ---- List (8-15 items, realistic Arabic data) ----
  static List<ProductEntity> get list => List.generate(
    12,
    (i) => ProductEntity(
      id: '${i + 1}',
      name: _names[i % _names.length],
      image: 'https://picsum.photos/seed/product$i/200/200',
      price: (i + 1) * 75.0,
      categoryName: _categories[i % _categories.length],
      createdAt: DateTime(2026, 1, i + 1),
    ),
  );

  // ---- Detail ----
  static ProductEntity get detail => list.first;

  // ---- Paginated Response (simulates API structure) ----
  static Map<String, dynamic> paginatedResponse(int page, {int perPage = 10}) {
    final allItems = List.generate(25, (i) => ProductEntity(
      id: '${i + 1}',
      name: _names[i % _names.length],
      image: 'https://picsum.photos/seed/product$i/200/200',
      price: (i + 1) * 75.0,
      categoryName: _categories[i % _categories.length],
      createdAt: DateTime(2026, 1, (i % 28) + 1),
    ));
    final start = (page - 1) * perPage;
    final end = (start + perPage).clamp(0, allItems.length);
    final pageItems = start < allItems.length ? allItems.sublist(start, end) : <ProductEntity>[];
    return {
      'data': {
        'data': pageItems.map((e) => e.toMap).toList(),
        'pagination': {
          'total_items': allItems.length,
          'count_items': pageItems.length,
          'per_page': perPage,
          'total_pages': (allItems.length / perPage).ceil(),
          'current_page': page,
          'next_page_url': page < (allItems.length / perPage).ceil() ? '?page=${page + 1}' : '',
          'prev_page_url': page > 1 ? '?page=${page - 1}' : '',
        },
      },
    };
  }

  // ---- Realistic Arabic Data ----
  static const _names = [
    'آيفون 15 برو ماكس',
    'سامسونج جالكسي S24',
    'ماك بوك برو M3',
    'آيباد إير',
    'سماعة أيربودز برو',
    'ساعة أبل ألترا',
    'شاشة LG 4K',
    'كيبورد ميكانيكي',
    'ماوس لوجيتك',
    'شاحن أنكر السريع',
    'حافظة جلدية فاخرة',
    'كابل USB-C مضفر',
  ];

  static const _categories = ['هواتف ذكية', 'لابتوب', 'إكسسوارات', 'شاشات', 'أجهزة لوحية'];
}
```

### Naming Convention

| Feature | Mock File Path | Class |
|---------|---------------|-------|
| Products | `config/mocks/product_mock.dart` | `ProductMock` |
| Orders | `config/mocks/order_mock.dart` | `OrderMock` |
| Notifications | `config/mocks/notification_mock.dart` | `NotificationMock` |
| Home | `config/mocks/home_mock.dart` | `HomeMock` |
| Auth | `config/mocks/auth_mock.dart` | `AuthMock` |

> **Mock file is a plain class — NOT a `part of` any imports file.**
> Import directly: `import 'package:app/src/core/config/mocks/product_mock.dart';`

---

## Step 3: Cubit Integration (Using executeMockOrAsync)

### GET List (AsyncCubit)

```dart
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async {
    await executeMockOrAsync(
      mockData: ProductMock.list,
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
    await executeMockOrAsync(
      mockData: ProductMock.detail,
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
    await executeMockOrAsync(
      mockData: ProductEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: params.name,
        image: 'https://picsum.photos/200',
        price: params.price,
        categoryName: 'فئة تجريبية',
        createdAt: DateTime.now(),
      ),
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
    await executeMockOrAsync(
      mockData: BaseModel(message: 'تم الحذف بنجاح'),
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

> **PaginatedCubit يستخدم pattern مختلف — الـ mock check جوه `fetchPageData` مباشرة.**

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
```

---

## List Services = Always Paginated (MANDATORY RULE)

> **أي endpoint بيرجع list من الـ API → لازم يكون paginated.**
> مفيش حاجة اسمها "جيب كل الداتا مرة واحدة" — حتى لو الـ list صغيرة.
> الـ backend يبعت pagination, والـ frontend يستخدم `PaginatedCubit`.

```dart
// ❌ FORBIDDEN — GET list without pagination
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  Future<void> fetchProducts() async {
    await executeMockOrAsync(
      mockData: ProductMock.list,
      operation: () => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => (json['data'] as List)
            .map((e) => ProductEntity.fromJson(e)).toList(),
      )),
    );
  }
}

// ✅ CORRECT — paginated list
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

### Exceptions — When AsyncCubit<List<T>> is OK:

| Case | Why |
|------|-----|
| Dropdown data (cities, categories) | Small fixed list, no scroll/load-more needed |
| Multi-section screen sub-lists (e.g. home banners) | Short list within a larger screen, no standalone pagination |
| Filter chips / tags | Small, fixed, rarely exceeds 20 items |

> **Rule of thumb:** If the list has its own screen / can grow beyond 20 items → `PaginatedCubit`.
> If it's a dropdown or a section inside a bigger screen → `AsyncCubit<List<T>>` is fine.

---

## Mock Data Quality Rules

### Rule 1: Realistic Arabic Data
```dart
// ✅ CORRECT — realistic Arabic data
ProductEntity(name: 'آيفون 15 برو ماكس', price: 5499.0, categoryName: 'هواتف ذكية')

// ❌ WRONG — placeholder nonsense
ProductEntity(name: 'Test', price: 0, categoryName: 'Cat1')
```

### Rule 2: Match Entity Fields
```dart
// ✅ CORRECT — all required fields filled with realistic values
// ❌ WRONG — missing fields or empty strings
```

### Rule 3: Enough Items for Testing
```dart
// ✅ List: 8-15 items (tests scrolling, pagination feel)
// ✅ Paginated: 20-30 total items across 2-3 pages
// ✅ Variety: different names, prices, categories, dates
```

### Rule 4: Simulate Delay
```dart
// ✅ Always happens automatically via executeMockOrAsync or MockConfig.simulateDelay()
// ❌ WRONG — instant mock (skips loading state testing)
setSuccess(data: ProductMock.list);  // no delay — FORBIDDEN
```

### Rule 5: Paginated Mock Must Simulate Real API
```dart
// ✅ paginatedResponse(page) returns correct slice + pagination meta
// ✅ last_page is calculated from total items
// ✅ Beyond last page returns empty list
// ❌ WRONG — same data for every page
```

---

## Mock Data Checklist (Per Feature)

- [ ] `{feature}_mock.dart` created in `core/config/mocks/` (NOT in entity/)
- [ ] Mock class has `list`, `detail` getters (and `paginatedResponse` if paginated)
- [ ] Mock data is realistic (Arabic names, real image URLs, varied values)
- [ ] 8-15 items for simple lists, 20-30 for paginated mocks
- [ ] All entity fields populated (no empty strings for required fields)
- [ ] Cubit uses `executeMockOrAsync` (AsyncCubit) or `MockConfig.useMock` check (PaginatedCubit)
- [ ] Delay is simulated (via helper or `MockConfig.simulateDelay()`)
- [ ] Mock file imported directly (not part-of) — `import 'package:app/src/core/config/mocks/...'`
- [ ] List endpoints use `PaginatedCubit` + `paginatedResponse` (not AsyncCubit with list)
- [ ] Tested with `--dart-define=USE_MOCK=true` — screens show mock data correctly

---

## Migration from Old Pattern

> لو عندك mock files في `entity/` folder → انقلهم لـ `core/config/mocks/`:

```bash
# 1. Create mocks folder
mkdir -p lib/src/core/config/mocks

# 2. Move mock files
mv lib/src/features/products/entity/product_mock.dart lib/src/core/config/mocks/

# 3. Remove `part of` directive from mock file (no longer needed)
# 4. Add normal import in cubit: import 'package:app/src/core/config/mocks/product_mock.dart';
# 5. Remove old part declaration from view_imports.dart
```

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
