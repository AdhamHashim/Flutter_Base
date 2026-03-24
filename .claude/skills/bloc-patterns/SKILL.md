---
name: bloc-patterns
description: AsyncCubit templates, CRUD local updates, AsyncBlocBuilder, PaginatedCubit, executeMockOrAsync, and BlocListener patterns for Flutter_Base.
---

# Skill: BLoC/Cubit Patterns — Flutter_Base

## Architecture Overview

All cubits that do API calls extend `AsyncCubit<T>`. Never create raw `Cubit` for data-fetching.

---

## AsyncCubit — Base Pattern

```dart
abstract class AsyncCubit<T> extends Cubit<AsyncState<T>> {
  // Built-in: setLoading(), setSuccess(data), setError(msg), reset(), updateData()
  // Built-in: executeAsync(operation, successEmitter, showErrorToast)
  // Built-in: executeMockOrAsync(mockData, operation) ← mock/real switch helper
  // Built-in: baseCrudUseCase (auto-injected)
}
```

## AsyncState<T> — Built-in States

```dart
state.status        // BaseStatus enum: initial, loading, loadingMore, success, error
state.data          // T
state.errorMessage  // String?
state.isInitial / state.isLoading / state.isSuccess / state.isError / state.isLoadingMore
```

---

## executeMockOrAsync — Mock/Real Switch Helper (MANDATORY)

> **بيشيل الـ `if (MockConfig.useMock)` المتكرر — يخلي الـ cubit نضيف.**
> **Method موجود في `AsyncCubit` — يتسخدم مباشرة بدون setup.**

```dart
// Definition (inside AsyncCubit base class):
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

```dart
// ❌ BEFORE — repetitive boilerplate
Future<void> fetchProducts() async {
  if (MockConfig.useMock) {
    setLoading();
    await MockConfig.simulateDelay();
    setSuccess(data: ProductMock.list);
    return;
  }
  await executeAsync(operation: () => baseCrudUseCase.call(...));
}

// ✅ AFTER — clean one-liner mock path
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

> **Mock files location:** `lib/src/core/config/mocks/{feature}_mock.dart` (centralized, NOT in entity/)

---

## Standard Cubit Template (with Mock Support)

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

## Standard Cubit Template (without Mock — real API only)

```dart
@injectable
class ProductsCubit extends AsyncCubit<List<ProductEntity>> {
  ProductsCubit() : super([]);

  Future<void> fetchProducts() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(CrudBaseParams(
        api: ApiConstants.products,
        httpRequestType: HttpRequestType.get,
        mapper: (json) => (json['data']['data'] as List)
            .map((e) => ProductEntity.fromJson(e)).toList(),
      )),
    );
  }
}
```

---

## CRUD Local Update Rule (NON-NEGOTIABLE)

**NEVER re-fetch the list after add/edit/delete.** Update state locally.

```dart
// Add → insert at index 0
(newItem) => setSuccess(data: [newItem, ...state.data])

// Edit → map + replace matching item
(updated) => setSuccess(data: state.data.map((e) => e.id == id ? updated : e).toList())

// Delete → removeWhere
mapper: (_) => state.data..removeWhere((e) => e.id == id)
```

---

### CRUD Response Merge — Use API Response (CRITICAL)

> **بعد الـ add/edit: استخدم الـ entity من response الـ API (اللي فيه id و server-generated fields).**
> **متستخدمش الـ user input اللي كتبه المستخدم — السيرفر ممكن يضيف/يعدل fields.**

```dart
// ✅ CORRECT — use newItem FROM API response (has server-generated id, timestamps, etc.)
result.when(
  (newItem) => setSuccess(data: [newItem, ...state.data]),
  (failure) => setError(errorMessage: failure.message, showToast: true),
);

// ❌ WRONG — using the params the user submitted (missing id, created_at, etc.)
result.when(
  (_) => setSuccess(data: [ItemEntity(name: params.name, ...), ...state.data]),
  (failure) => ...,
);
```

### Paginated CRUD — Add/Delete in PaginatedCubit

> **الـ PaginatedCubit عنده list من عدة pages. لازم تتعامل مع الـ CRUD فيه بحذر.**

```dart
// Add to paginated list — insert at index 0
(newItem) {
  final currentItems = state.data;
  setSuccess(data: [newItem, ...currentItems]);
}

// Delete from paginated list — remove by id
(id) {
  final currentItems = state.data.where((e) => e.id != id).toList();
  setSuccess(data: currentItems);
}
```

---

## AsyncBlocBuilder Usage

```dart
AsyncBlocBuilder<ProductsCubit, List<ProductEntity>>(
  builder: (context, products) {
    if (products.isEmpty) return const EmptyWidget();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (_, i) => ProductCard(product: products[i]),
    );
  },
  skeletonBuilder: (_) => const ProductsSkeletonList(),
  errorBuilder: (ctx, error) => ErrorView(error: error, onRetry: () => ctx.read<ProductsCubit>().fetchProducts()),
)
```

### Sliver Version (CustomScrollView)
```dart
AsyncSliverBlocBuilder<ItemsCubit, List<ItemEntity>>(
  builder: (ctx, items) => SliverList.builder(
    itemCount: items.length,
    itemBuilder: (_, i) => ItemCard(item: items[i]),
  ),
)
```

---

## Multiple Cubits — MultiBlocProvider

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => injector<BannersCubit>()..fetchBanners()),
    BlocProvider(create: (_) => injector<CategoriesCubit>()..fetchCategories()),
  ],
  child: DefaultScaffold(title: LocaleKeys.home.tr(), body: const HomeBody()),
)
```

**Multi-section empty:** `SizedBox.shrink()` (not `EmptyWidget`).
**Heavy screens (4+ APIs):** Consider `compute()` for JSON parsing.

---

## BlocListener — For Actions

```dart
BlocListener<SubmitCubit, AsyncState<bool>>(
  listener: (context, state) {
    if (state.isSuccess) {
      MessageUtils.showSnackBar(message: LocaleKeys.success.tr(), baseStatus: BaseStatus.success);
      Go.back();
    }
  },
  child: bodyWidget,
)
```

---

## Pagination — PaginatedCubit

### List Services = Always Paginated (MANDATORY)

> **أي endpoint بيرجع list وليه شاشة مستقلة → لازم يكون `PaginatedCubit`.**
> **`AsyncCubit<List<T>>` مسموح بس للـ dropdowns والـ sub-sections الصغيرة.**

```dart
// ❌ FORBIDDEN — standalone list screen without pagination
class ProductsCubit extends AsyncCubit<List<ProductEntity>> { ... }

// ✅ CORRECT — paginated
class ProductsCubit extends PaginatedCubit<ProductEntity> { ... }
```

**Exceptions (AsyncCubit<List<T>> is OK):**
- Dropdown data (cities, categories) — small fixed list
- Multi-section sub-lists (banners inside home) — short list
- Filter chips / tags — rarely exceeds 20 items

### PaginatedCubit with Mock Support

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

### UI Widget

```dart
PaginatedListWidget<ItemEntity>(
  cubit: context.read<ItemsCubit>(),
  itemBuilder: (item) => ItemCard(item: item),
  skeletonBuilder: () => const ItemCardSkeleton(),
)
```

---

## Dropdown & Small Widget API — Isolate BlocBuilder (CRITICAL)

> **لما dropdown أو widget صغير بيجيب data من API → الـ BlocBuilder يكون عليه هو بس.**
> **لو الـ service فشلت → الـ widget ده بس يتأثر — باقي الشاشة تشتغل عادي.**

```dart
// ✅ CORRECT — isolated BlocProvider inside the dropdown widget
class _CityDropdown extends StatelessWidget {
  const _CityDropdown({required this.onChanged});
  final ValueChanged<CityEntity?> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<GetCitiesCubit>()..fetchCities(),
      child: AsyncBlocBuilder<GetCitiesCubit, List<CityEntity>>(
        builder: (ctx, cities) => AppDropdown<CityEntity>(
          items: cities, label: LocaleKeys.city.tr(),
          itemAsString: (c) => c.name, onChanged: onChanged,
        ),
      ),
    );
  }
}

// ❌ FORBIDDEN — wrapping entire screen with BlocBuilder for a dropdown
AsyncBlocBuilder<GetCitiesCubit, List<CityEntity>>(
  builder: (ctx, cities) => Column(children: [
    _Header(), _Form(), AppDropdown(items: cities), _SubmitButton(),
  ]),
)
// ← if cities API fails, ENTIRE screen stops!
```

---

## Figma State Mapping

```
Figma "Loading"      → state.isLoading  → skeletonBuilder
Figma "Empty"        → state.isSuccess + data.isEmpty → EmptyWidget
Figma "Error"        → state.isError    → errorBuilder / ErrorView
Figma "Default"      → state.isSuccess + data.notEmpty → builder
Figma "Loading More" → state.isLoadingMore → list + loader at bottom
```

## Entity Safety

Every entity MUST have `factory initial()`, `fromJson` with `??` defaults, `tryParse` (never `parse`).
See `flutter-base-coding-standards.mdc` section 8.5 for full rules.
