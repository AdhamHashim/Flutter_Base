---
name: widget-reference
description: Reference catalog of core widgets in core/widgets/ — buttons (LoadingButton, DefaultButton), text fields (CustomTextFiled, DefaultTextField, CustomPinTextField), dropdowns (AppDropdown), dialogs (successDialog, showCustomDialog, showDefaultBottomSheet), state handlers (AsyncBlocBuilder, PaginatedListWidget, EmptyWidget, ErrorView), images (CachedImage, CustomAvatar, UploadImageWidget), icons (IconWidget), and misc widgets. Use these instead of building from scratch.
---

# Widget Reference — USE BEFORE BUILDING NEW

> **Golden rule:** Search `core/widgets/` before writing any widget. If it exists → use it.

## 11. Core Widgets — USE BEFORE BUILDING NEW

> **Golden Rule:** Search `core/widgets/` before writing any widget. If it exists → use it.

### 11.1 — Buttons (`core/widgets/buttons/`)

| Widget | Usage |
|--------|-------|
| `LoadingButton(title, onTap)` | Async button with built-in loading state — use for ALL form submits |
| `DefaultButton(title, onTap)` | Simple non-async button |
| `ButtonClose()` | Standard close/dismiss button |
| `CustomAnimatedButton(...)` | Animated press-effect button |

```dart
// ✅ CORRECT — async form submit
LoadingButton(
  title: LocaleKeys.submit.tr(),
  color: AppColors.primary,
  borderRadius: AppCircular.r12,
  onTap: () async => context.read<MyCubit>().submit(params),
)
```

---

### 11.2 — Text Fields (`core/widgets/fields/text_fields/`)

| Widget | Usage |
|--------|-------|
| `CustomTextFiled(hint, title, controller, validator, textInputType, textInputAction)` | **Primary field** — includes label + asterisk + validation styling. Use for all form fields. |
| `DefaultTextField(...)` | Base field — used inside CustomTextFiled. Use directly only if no label needed. |
| `CustomPinTextField(controller, onCompleted)` | OTP / PIN 4-digit field with pinput |

```dart
// ✅ CORRECT — form field with label
CustomTextFiled(
  title: LocaleKeys.phoneLabel.tr(),
  hint: LocaleKeys.phoneHint.tr(),
  controller: params.phoneController,
  textInputType: TextInputType.phone,
  textInputAction: TextInputAction.next,
  validator: Validators.validatePhone,
  inputFormatters: [PhoneNumberFormatter()],
)

// ❌ WRONG — don't build a custom labeled field from scratch
```

---

### 11.3 — Dropdowns (`core/widgets/fields/drop_downs/`)

| Widget | Usage |
|--------|-------|
| `AppDropdown<T>(items, onChanged, itemAsString, label, hint)` | Full-featured dropdown with search, multi-select, loading/error states |

```dart
// ✅ CORRECT
AppDropdown<CityEntity>(
  items: cities,
  label: LocaleKeys.city.tr(),
  hint: LocaleKeys.selectCity.tr(),
  value: selectedCity,
  itemAsString: (c) => c.name,
  onChanged: (c) => setState(() => selectedCity = c),
  validator: Validators.validateDropDown,
  isLoading: cubit.isLoading,
)
```

Key params: `isMultiSelect`, `showSearchBox`, `isLoading`, `isFailer`, `readonly`, `maxHeight`

---

### 11.4 — Dialogs & Bottom Sheets (`core/widgets/dialogs/` + `core/widgets/pickers/`)

| Function | Usage |
|----------|-------|
| `successDialog(context, title: ..., desc: ...)` | Standard success popup with Lottie animation + auto-close |
| `showCustomDialog(context, child: ...)` | Generic styled dialog with scale+fade animation |
| `showDefaultBottomSheet(child: ...)` | Standard bottom sheet with drag handle |
| `CustomDatePicker` | Date picker widget |

```dart
// ✅ CORRECT — success after API call
successDialog(context, title: LocaleKeys.savedSuccessfully.tr());

// ✅ CORRECT — custom dialog
showCustomDialog(
  context,
  child: MyDialogContent(),
  barrierDismissible: true,
);

// ✅ CORRECT — bottom sheet
showDefaultBottomSheet(child: MySheetContent());
```

---

### 11.5 — State Handling (`core/widgets/handling_views/` + `core/widgets/tools/`)

| Widget | Usage |
|--------|-------|
| `AsyncBlocBuilder<Cubit, DataType>(builder: ..., skeletonBuilder: ...)` | Wraps loading/error/success states automatically |
| `AsyncSliverBlocBuilder<Cubit, DataType>(...)` | Sliver version for CustomScrollView |
| `PaginatedListWidget<Cubit, ItemType>(itemBuilder: ..., config: ...)` | Paginated list with infinite scroll |
| `EmptyWidget(title: ..., desc: ..., path: ...)` | Empty state with image/lottie |
| `ErrorView(error: ...)` | Error state with Lottie animation |

```dart
// ✅ CORRECT — API-driven list
AsyncBlocBuilder<GetItemsCubit, List<ItemEntity>>(
  skeletonBuilder: (ctx) => ItemSkeleton(),
  builder: (ctx, items) => items.isEmpty
      ? EmptyWidget(title: LocaleKeys.noItems.tr(), desc: '')
      : ListView.builder(itemBuilder: ...),
)

// ✅ CORRECT — paginated list
PaginatedListWidget<GetItemsCubit, ItemEntity>(
  itemBuilder: (ctx, item, idx) => ItemCard(item: item),
  emptyWidget: EmptyWidget(title: LocaleKeys.noItems.tr(), desc: ''),
)
```

---

### 11.6 — Image Widgets (`core/widgets/image_widgets/`)

| Widget | Usage |
|--------|-------|
| `CachedImage(url, width, height)` | Cached network image with placeholder + tap-to-view |
| `CustomAvatar(url, radius)` | Circular avatar from network |
| `UploadImageWidget(onUpload)` | Image upload with native picker, single or multi |
| `ImageView(mediaPath, mediaType, mediaSource)` | Full-screen image/video viewer |

```dart
// ✅ Network image
CachedImage(url: item.image, width: AppSize.sW60, height: AppSize.sH60,
  borderRadius: BorderRadius.circular(AppCircular.r8))

// ✅ Circular avatar
CachedImage(url: user.photo, width: AppSize.sW44, height: AppSize.sH44,
  boxShape: BoxShape.circle)

// ✅ Upload
UploadImageWidget(
  uploadImageType: UploadImageType.single,
  onUpload: (files) => params.imageFile = files.first,
)
```

---

### 11.7 — Other Widgets

| Widget | Usage |
|--------|-------|
| `IconWidget(icon, color, height, width)` | Versatile — handles SVG/PNG/Lottie/network/IconData automatically |
| `BadgeIconWidget(child, badgeCount)` | Badge overlay on any widget |
| `CustomHtmlWidget(data)` | Renders HTML content with project styles |
| `RiyalPriceText(price)` | Saudi Riyal symbol with correct font |
| `CustomLoading.showLoadingView()` | Centered SpinKit loading indicator |
| `CustomLoading.showFullScreenLoading()` | Full-screen overlay loader |
| `MessageUtils.showSnackBar(context, baseStatus, message)` | Themed snackbar |

```dart
// ✅ Icon (SVG from assets)
IconWidget(icon: AppAssets.svg.baseSvg.search.path, color: AppColors.primary, height: AppSize.sH20)

// ✅ Badge
BadgeIconWidget(child: IconWidget(...), badgeCount: unreadCount)

// ✅ Price
RiyalPriceText(price: '250.00', priceTextStyle: const TextStyle().setMainTextColor.s14.bold)
// OR
Text('250.00', style: ...).withRiyalPrice(color: AppColors.primary)

// ✅ Snackbar
MessageUtils.showSnackBar(context: context, baseStatus: BaseStatus.success, message: LocaleKeys.saved.tr())
```

---

### 11.8 — Scaffold + Status Bar

> **See `scaffold-patterns` for full scaffold selection guide and status bar rules.**

- Inner screens → `DefaultScaffold` (handles header + status bar automatically)
- Auth screens → plain `Scaffold` + `SafeArea` (no appbar)
- Home → custom `Scaffold` + `CustomNavigationBar`
- **NEVER** build custom header containers in body widgets

---

