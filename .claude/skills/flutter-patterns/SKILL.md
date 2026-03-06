# Skill: Flutter_Base Widget Patterns

## Purpose
Quick reference for using Flutter_Base base widgets and patterns when building features.
For full coding standards, see `flutter-base-coding-standards.mdc`.
For full development workflow, see `flutter-feature-development.mdc`.

---

## File Structure — Separate Files Per Widget (MANDATORY)

```
lib/src/features/{feature_name}/
├── entity/
│   └── {feature}_entity.dart
├── presentation/
│   ├── imports/
│   │   └── view_imports.dart              ← all imports + part declarations
│   ├── cubits/
│   │   └── {feature}_cubit.dart           ← extends AsyncCubit<T>
│   ├── view/
│   │   └── {feature}_screen.dart          ← thin: scaffold + body
│   └── widgets/
│       ├── {feature}_body.dart            ← layout ONLY — assembles sections
│       ├── {feature}_header_widget.dart   ← separate file per section
│       ├── {feature}_filter_widget.dart
│       ├── {feature}_list_widget.dart
│       └── {feature}_card_widget.dart
```

**Body = layout only.** No `_buildXxx()` methods returning 10+ lines.

---

## view_imports.dart Part Ordering

```dart
// 1. Cubits
part '../cubits/feature_cubit.dart';
// 2. View (screen)
part '../view/feature_screen.dart';
// 3. Body
part '../widgets/feature_body.dart';
// 4. Section widgets (alphabetical)
part '../widgets/feature_filter_widget.dart';
part '../widgets/feature_header_widget.dart';
// 5. Card/item widgets last
part '../widgets/feature_card_widget.dart';
```

---

## Shared Widget Reuse — AUDIT BEFORE CREATING

Before creating ANY widget → search `app_shared/widgets/` and existing features.
Same design → reuse. Minor differences → add optional params. Used in 2+ features → move to `app_shared/`.

---

## Key Widget Quick Reference

| Need | Widget | Notes |
|---|---|---|
| Screen scaffold | `DefaultScaffold(title, body)` | Inner screens only. Auth → plain `Scaffold` |
| Async submit button | `LoadingButton(title, onTap)` | All form submits |
| Simple button | `DefaultButton(title, onTap)` | Non-async actions |
| Text field with label | `CustomTextFiled(title, hint, controller, validator)` | Primary field widget |
| OTP/PIN | `CustomPinTextField(controller, onCompleted)` | 4-digit input |
| Dropdown | `AppDropdown<T>(items, label, onChanged, itemAsString)` | Search, multi-select, loading |
| API state wrapper | `AsyncBlocBuilder<C, T>(builder, skeletonBuilder)` | Loading/error/success auto |
| Sliver API wrapper | `AsyncSliverBlocBuilder<C, T>(builder)` | For CustomScrollView |
| Paginated list | `PaginatedListWidget<C, T>(itemBuilder)` | Infinite scroll |
| Network image | `CachedImage(url, width, height)` | Never use `Image.network` |
| Icon (SVG/PNG/etc.) | `IconWidget(icon, color, height)` | Never use `Icons.*` |
| Badge on icon | `BadgeIconWidget(child, badgeCount)` | Notification badge |
| Empty state | `EmptyWidget(title, desc, path)` | Full-screen empty only |
| Error state | `ErrorView(error, onRetry)` | With retry button |
| Success popup | `successDialog(context, title)` | Auto-closes 2s |
| Custom dialog | `showCustomDialog(context, child)` | Scale+fade animation |
| Bottom sheet | `showDefaultBottomSheet(child)` | Drag handle |
| Snackbar | `MessageUtils.showSnackBar(context, baseStatus, message)` | Themed |
| Full-screen loading | `CustomLoading.showFullScreenLoading()` | Overlay |
| Price with Riyal | `RiyalPriceText(price)` or `.withRiyalPrice()` | SAR symbol |
| HTML content | `CustomHtmlWidget(data)` | Styled HTML renderer |

---

## Screen Pattern

```dart
class MyFeatureScreen extends StatelessWidget {
  const MyFeatureScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MyFeatureCubit>()..fetchData(),
      child: DefaultScaffold(
        title: LocaleKeys.myFeatureTitle.tr(),
        body: const _MyFeatureBody(),
      ),
    );
  }
}
```

---

## Body Pattern — RefreshIndicator + AsyncBlocBuilder

```dart
class _MyFeatureBody extends StatelessWidget {
  const _MyFeatureBody();
  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<MyFeatureCubit, List<MyFeatureEntity>>(
      builder: (context, data) {
        if (data.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => context.read<MyFeatureCubit>().fetchItems(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [SliverFillRemaining(hasScrollBody: false, child: EmptyWidget(...))],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<MyFeatureCubit>().fetchItems(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, i) => _MyFeatureCard(item: data[i]),
          ),
        );
      },
      skeletonBuilder: (_) => ListView.builder(
        itemCount: 8,
        itemBuilder: (_, __) => _MyFeatureCard(item: MyFeatureEntity.initial()),
      ),
    );
  }
}
```

---

## Multi-Section → CustomScrollView + Slivers

```dart
RefreshIndicator(
  onRefresh: () async { /* refresh all cubits */ },
  child: CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: [
      const _FeatureHeader().toSliver(),
      AsyncSliverBlocBuilder<BannersCubit, List<BannerEntity>>(
        builder: (ctx, banners) {
          if (banners.isEmpty) return const SizedBox.shrink().toSliver();
          return BannerCarousel(banners: banners).toSliver();
        },
      ),
      // More sliver sections...
    ],
  ),
)
```

**Never:** `SingleChildScrollView` + nested `ListView(shrinkWrap: true)` for data.

---

## Cubit, Entity & Form Patterns

> **See `bloc-patterns` skill for full AsyncCubit/CRUD/BlocListener patterns.**
> **See `flutter-base-coding-standards.mdc` section 8.5 for entity safety rules.**
> **See `flutter-base-coding-standards.mdc` section 8.1 for FormMixin pattern.**

Quick reminders:
- AsyncCubit: `@injectable` + `executeAsync()` + local CRUD updates (never re-fetch)
- Entity: `factory initial()` + `fromJson` with `??` + `tryParse` (never `parse`)
- Form: `with FormMixin` + `params.validateAndScroll()` + `LoadingButton`
