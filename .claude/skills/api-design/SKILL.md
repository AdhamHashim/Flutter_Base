---
name: api-design
description: Auto-generate API contracts (Postman Collection JSON) from Figma screens — unified entities, pagination, multi-step forms, file upload, and mock data support.
---

# Skill: API Design — Figma Screen → Postman Collection + Flutter Integration

## When to Use

- عند قراءة أي شاشة من Figma وتحتاج تصمم الـ API ليها
- عند إضافة endpoints جديدة لأي feature
- عند إنشاء Postman Collection للـ backend team
- عند ربط الـ API بالـ Flutter code (cubits + entities + ApiConstants)

---

## The Pipeline (6 Steps)

```
Figma Screen
    ↓
Step 1: Analyze UI → identify required services
    ↓
Step 2: Design endpoints (naming, method, pagination, entities)
    ↓
Step 3: Generate ONE Postman Collection JSON (with internal folders per section)
    ↓
Step 4: Add to ApiConstants
    ↓
Step 5: Create Entity + Cubit (with mock support)
    ↓
Step 6: Connect to UI (mock-first, then real API)
```

---

## Step 1: Analyze UI — Service Extraction Rules

> **لكل شاشة من Figma، حلل الـ UI واستخرج الـ services المطلوبة بالقواعد دي:**

### Rule 1: Multi-Section Screen → Separate Service Per Section

```
شاشة فيها: Banners + Categories + Products
    ↓
GET /banners          ← service 1
GET /categories       ← service 2
GET /products         ← service 3

❌ FORBIDDEN: GET /home-data (كل حاجة في service واحدة)
```

### Rule 2: List Screens → Pagination Required

```
أي شاشة فيها list (products, orders, notifications)
    ↓
GET /products?page=1&per_page=10
    ↓
Response يشمل: data[] + pagination object
```

### Rule 3: Multi-Step Forms → Validate Per Step + Final Create

```
فورم على 3 صفحات:
    ↓
POST /products/validate-step-1    ← validates page 1 fields
POST /products/validate-step-2    ← validates page 2 fields
POST /products/validate-step-3    ← validates page 3 fields
POST /products                    ← final create (all data)
```

### Rule 4: File Uploads → Separate Upload Service

```
أي شاشة فيها رفع صور/ملفات:
    ↓
POST /upload-file    ← generic, returns file ID/URL
    ↓
ثم تبعت الـ file_id في الـ create/edit service

❌ FORBIDDEN: ارفع الصورة مع باقي الداتا في نفس الـ service
```

### Rule 5: CRUD Operations → 5 Standard Services

```
Feature: Products
    ↓
GET    /products              ← list (paginated)
GET    /products/{id}         ← detail (same entity structure)
POST   /products              ← create
PUT    /products/{id}         ← update
DELETE /products/{id}         ← delete
```

### Rule 6: Unified Entities (CRITICAL)

> **الـ Entity واحدة في كل مكان. الـ product entity في list = نفسها في detail = نفسها جوا order.**

```json
// GET /products → returns list of ProductEntity
// GET /products/{id} → returns single ProductEntity (same structure, more fields allowed)
// GET /orders/{id} → order.product = ProductEntity (same structure)

// ❌ FORBIDDEN: Different response shapes for same entity
```

---

## Step 2: Endpoint Naming Convention

### URL Structure

```
{prefix}/{resource}                    ← list/create
{prefix}/{resource}/{id}               ← detail/update/delete
{prefix}/{resource}/{action}           ← custom action
{prefix}/{resource}/validate-step-{n}  ← multi-step validation

prefix for user features:    user/
prefix for public features:  (none)
prefix for auth:             user/auth/
```

### Naming Rules

| Rule | Example ✅ | Example ❌ |
|------|-----------|-----------|
| Short, descriptive | `/products` | `/get-all-products-list` |
| Plural for collections | `/products` | `/product` |
| Kebab-case | `/upload-file` | `/uploadFile` |
| Resource-first | `/products/{id}` | `/get-product-by-id/{id}` |
| Action as suffix | `/products/validate-step-1` | `/validate-product-step-1` |

---

## Step 3: Postman Collection JSON Structure

### File Location — SINGLE Collection File (MANDATORY)

> **⚠️ فايل واحد بس لكل الـ API — مش ملف لكل feature.**
> الـ endpoints بتتقسم بـ **folders داخل الـ collection نفسها.**

```
postman/
├── _environment.json                         ← base URL + token variables
├── app_name.postman_collection.json          ← <<<< ONE FILE — all endpoints
└── _entities.md                              ← entity reference (unified shapes)
```

### Collection Internal Structure (Folders)

> **كل مجموعة endpoints بتبقى في folder جوا الـ collection:**

```json
{
  "info": {
    "name": "App Name API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Auth",
      "item": [
        // login, register, verify, forget-password, logout
      ]
    },
    {
      "name": "Home",
      "item": [
        // banners, categories, featured-products
      ]
    },
    {
      "name": "Products",
      "item": [
        // list, detail, create, update, delete, validate-steps
      ]
    },
    {
      "name": "Orders",
      "item": [
        // list, detail, cancel, rate
      ]
    },
    {
      "name": "Settings",
      "item": [
        // profile, update-profile, change-password, notifications
      ]
    },
    {
      "name": "Shared",
      "item": [
        // upload-file, countries, cities
      ]
    }
  ]
}
```

### Folder Naming Convention

| Folder | Contents |
|--------|----------|
| `Auth` | login, register, verify-otp, forget-password, reset-password, logout |
| `Home` | banners, categories, featured items (multi-section screen services) |
| `{Feature}` | CRUD endpoints for the feature (products, orders, etc.) |
| `Settings` | profile, update-profile, change-password, notifications, delete-account |
| `Shared` | upload-file, countries, cities, app-config — reusable across features |

### Rules

```
❌ FORBIDDEN: ملف لكل feature (auth.postman_collection.json, products.postman_collection.json)
❌ FORBIDDEN: flat list بدون folders
✅ CORRECT: ملف واحد + folders داخلية لكل section
```

### Unified Response Format

```json
// Success (no data)
{
  "status": "success",
  "code": 200,
  "message": "تمت العملية بنجاح"
}

// Success (with data)
{
  "status": "success",
  "code": 200,
  "message": "تم جلب البيانات بنجاح",
  "data": { ... }
}

// Success (with paginated list)
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

// Error — validation
{
  "status": "fail",
  "code": 422,
  "message": "بيانات غير صالحة",
  "errors": {
    "email": ["البريد الإلكتروني مطلوب"],
    "phone": ["رقم الجوال غير صحيح"]
  }
}

// Error — auth
{
  "status": "fail",
  "code": 401,
  "message": "بيانات الدخول غير صحيحة"
}

// Error — not found
{
  "status": "fail",
  "code": 404,
  "message": "العنصر غير موجود"
}

// Error — rate limit
{
  "status": "fail",
  "code": 429,
  "message": "يرجى الانتظار 51 ثانية قبل طلب كود جديد."
}

// Error — server
{
  "status": "fail",
  "code": 500,
  "message": "حدث خطأ في السيرفر"
}
```

### Collection Item Template

```json
{
  "name": "Service Name (Arabic Description)",
  "request": {
    "method": "GET|POST|PUT|DELETE",
    "header": [
      {"key": "Accept", "value": "application/json"},
      {"key": "Content-Type", "value": "application/json"},
      {"key": "Authorization", "value": "Bearer {{token}}"},
      {"key": "Accept-Language", "value": "{{lang}}"}
    ],
    "url": {
      "raw": "{{base_url}}/endpoint",
      "host": ["{{base_url}}"],
      "path": ["endpoint"]
    },
    "body": {
      "mode": "raw",
      "raw": "{ ... }",
      "options": {"raw": {"language": "json"}}
    }
  },
  "response": [
    {
      "name": "Success (200)",
      "status": "OK",
      "code": 200,
      "body": "{ ... }"
    },
    {
      "name": "Validation Error (422)",
      "status": "Unprocessable Entity",
      "code": 422,
      "body": "{ ... }"
    },
    {
      "name": "Unauthorized (401)",
      "status": "Unauthorized",
      "code": 401,
      "body": "{ ... }"
    }
  ]
}
```

---

## Step 4: Add to ApiConstants

> **كل endpoint جديد لازم يتضاف في `ApiConstants` فوراً.**

```dart
// File: lib/src/core/network/api_endpoints.dart

class ApiConstants {
  // ---- Shared ----
  static const String uploadFile = 'upload-file';

  // ---- Products ----
  static const String products = 'user/products';
  static String productDetail(String id) => 'user/products/$id';
  static String deleteProduct(String id) => 'user/products/$id';
  static const String validateProductStep1 = 'user/products/validate-step-1';
  static const String validateProductStep2 = 'user/products/validate-step-2';
}
```

---

## Step 5: Entity + Cubit (with Mock Support)

### Entity — Unified Structure

```dart
class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;
  final String categoryName;
  final DateTime createdAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.categoryName,
    required this.createdAt,
  });

  factory ProductEntity.initial() => ProductEntity(
    id: SkeltonizerManager.short,
    name: SkeltonizerManager.medium,
    image: '',
    price: 0.0,
    categoryName: SkeltonizerManager.short,
    createdAt: DateTime(2000),
  );

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json['id']?.toString() ?? '',
    name: json['name']?.toString() ?? '',
    image: json['image']?.toString() ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    categoryName: json['category_name']?.toString() ?? '',
    createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(2000),
  );
}
```

### Cubit — with Mock Data Support (executeMockOrAsync)

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

### Mock Data File (Centralized)

> **Mock files live in `core/config/mocks/` — NOT in entity/.**

```dart
// File: lib/src/core/config/mocks/product_mock.dart  ← centralized

class ProductMock {
  ProductMock._();

  static List<ProductEntity> get list => List.generate(12, (i) => ProductEntity(
    id: '${i + 1}',
    name: _names[i % _names.length],
    image: 'https://picsum.photos/seed/product$i/200/200',
    price: (i + 1) * 75.0,
    categoryName: _categories[i % _categories.length],
    createdAt: DateTime(2026, 1, i + 1),
  ));

  static ProductEntity get detail => list.first;

  static Map<String, dynamic> paginatedResponse(int page, {int perPage = 10}) {
    // ... sliced paginated data
  }

  static const _names = ['آيفون 15 برو ماكس', 'سامسونج جالكسي S24', ...];
  static const _categories = ['هواتف ذكية', 'لابتوب', 'إكسسوارات'];
}
```

---

## Step 6: Connect to UI

> **عادي زي ما بنعمل — BlocProvider + AsyncBlocBuilder. الـ mock/real switch موحد.**

```dart
// Screen — same pattern, no changes needed
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ProductsCubit>()..fetchProducts(),
      child: DefaultScaffold(
        title: LocaleKeys.products.tr(),
        body: const _ProductsBody(),
      ),
    );
  }
}
```

---

## Postman Collection Generation Checklist

تأكد من:

- [ ] **ملف واحد فقط** `postman/app_name.postman_collection.json` — مش ملف لكل feature
- [ ] الـ endpoints متقسمة في **folders داخلية** (Auth, Home, Products, Settings, Shared, ...)
- [ ] كل endpoint له اسم واضح وقصير
- [ ] الـ URL structure متسقة (`{prefix}/{resource}`)
- [ ] كل list endpoint فيه pagination
- [ ] Entities موحدة (نفس الـ shape في list و detail و nested)
- [ ] Multi-section screens → service لكل section
- [ ] Multi-step forms → validate per step + final create
- [ ] File uploads → separate `upload-file` service
- [ ] Headers موجودة (Accept, Content-Type, Authorization, Accept-Language)
- [ ] Response examples لكل حالة (success, validation error, auth error, not found)
- [ ] Response format موحد (`{status, code, message, data?}`)
- [ ] Mock data file in `core/config/mocks/` (NOT entity/)
- [ ] ApiConstants updated
- [ ] Cubit uses `executeMockOrAsync` (AsyncCubit) or `MockConfig.useMock` (PaginatedCubit)

---

## Entity Reuse Examples

> **الهدف: entity واحدة تتستخدم في كل مكان.**

```json
// GET /products → ProductEntity list
// GET /products/{id} → same ProductEntity (can have extra fields)
// GET /orders/{id} → OrderEntity { ..., "product": ProductEntity }
// GET /cart → CartEntity { ..., "items": [CartItemEntity { ..., "product": ProductEntity }] }

// ❌ WRONG: Different shapes
// /products returns { "name": "..." }
// /orders/{id}.product returns { "product_name": "..." }  ← different key!
```

### Nested Entity Pattern

```dart
class OrderEntity {
  final String id;
  final String status;
  final ProductEntity product;  // ← REUSE, don't duplicate
  final UserEntity customer;    // ← REUSE

  factory OrderEntity.fromJson(Map<String, dynamic> json) => OrderEntity(
    id: json['id']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
    product: json['product'] != null
        ? ProductEntity.fromJson(json['product'])
        : ProductEntity.initial(),
    customer: json['customer'] != null
        ? UserEntity.fromJson(json['customer'])
        : UserEntity.initial(),
  );
}
```

---

## Upload File Service (Shared)

```json
{
  "name": "Upload File (رفع ملف)",
  "request": {
    "method": "POST",
    "header": [
      {"key": "Authorization", "value": "Bearer {{token}}"},
      {"key": "Accept", "value": "application/json"}
    ],
    "url": "{{base_url}}/upload-file",
    "body": {
      "mode": "formdata",
      "formdata": [
        {"key": "file", "type": "file", "src": ""},
        {"key": "type", "value": "image", "description": "image | document | video"}
      ]
    }
  },
  "response": [
    {
      "name": "Success",
      "code": 200,
      "body": "{\"status\":\"success\",\"code\":200,\"message\":\"تم رفع الملف بنجاح\",\"data\":{\"id\":15,\"url\":\"https://example.com/storage/uploads/file.jpg\",\"type\":\"image\"}}"
    }
  ]
}
```

### Usage in Create Service

```json
{
  "name": "Create Product (إنشاء منتج)",
  "request": {
    "method": "POST",
    "url": "{{base_url}}/user/products",
    "body": {
      "mode": "raw",
      "raw": "{\"name\":\"منتج جديد\",\"price\":150,\"category_id\":1,\"image_id\":15}"
    }
  }
}
```

> **`image_id: 15`** ← الـ ID اللي رجع من `upload-file`

---

## Multi-Step Form Example

```json
// Step 1: Validate basic info
POST /user/products/validate-step-1
Body: { "name": "...", "category_id": 1 }
Response: { "status": "success", "code": 200, "message": "بيانات صحيحة" }

// Step 2: Validate pricing & details
POST /user/products/validate-step-2
Body: { "price": 150, "description": "...", "quantity": 10 }
Response: { "status": "success", "code": 200, "message": "بيانات صحيحة" }

// Step 3: Final create (all data)
POST /user/products
Body: { "name": "...", "category_id": 1, "price": 150, "description": "...", "quantity": 10, "image_id": 15 }
Response: { "status": "success", "code": 200, "message": "تم إنشاء المنتج بنجاح", "data": { ProductEntity } }
```
