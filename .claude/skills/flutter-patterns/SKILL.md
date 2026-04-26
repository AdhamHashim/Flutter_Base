---
name: flutter-patterns
description: Widget patterns, file structure, key widgets reference, and screen/body patterns for Flutter_Base.
---

# Skill: Flutter_Base Widget Patterns

## Purpose
Quick reference for using Flutter_Base base widgets and patterns when building features.
For full coding standards, see `coding-standards`.
For full development workflow, see `feature-development`.

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
| Text field with label | `CustomTextFiled(title, hint, controller, validator)` | Primary form field (wraps DefaultTextField + label+asterisk) |
| Text field raw (no label) | `DefaultTextField(controller, hint)` | Base field — use directly for search bars or fields without labels |
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

## ViewController Class Pattern (MANDATORY)

> **⚠️ ممنوع نهائياً: أي Controller أو ValueNotifier داخل الـ View مباشرة.**
> **كل حاجة تتعلق بالـ UI state + handlers بتاعتها لازم تكون في ViewController class. الـ View تستدعي الـ class بس.**

### Why?
- الـ View تبقى نظيفة — layout فقط
- سهولة الاختبار والصيانة
- تجنب setState — استخدم `ValueNotifier` + `ValueListenableBuilder`

### ✅ CORRECT — ViewController class

```dart
class ChatViewController {
  final TextEditingController messageController = TextEditingController();
  final ValueNotifier<bool> isSending = ValueNotifier(false);

  void onSend(BuildContext context) {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    context.read<ChatCubit>().sendMessage(text);
    messageController.clear();
  }

  void dispose() {
    messageController.dispose();
    isSending.dispose();
  }
}
```

### ✅ CORRECT — View uses ViewController object

```dart
class _ChatInputState extends State<_ChatInput> {
  late final ChatViewController _vc = ChatViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DefaultTextField(
            controller: _vc.messageController,
            title: LocaleKeys.typeMessage.tr(),
          ),
        ),
        8.szW,
        ValueListenableBuilder<bool>(
          valueListenable: _vc.isSending,
          builder: (_, sending, __) => _SendButton(
            onTap: () => _vc.onSend(context),
            isLoading: sending,
          ),
        ),
      ],
    );
  }
}
```

### ❌ FORBIDDEN — Controllers/logic directly in View

```dart
// ❌ WRONG — controllers, dispose, business logic scattered in view
class _ChatInputState extends State<_ChatInput> {
  final _controller = TextEditingController();
  bool _isSending = false;

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _isSending = true);
    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### ViewController Rules:
- **ممنوع** وضع Controller أو ValueNotifier داخل الـ View/State — لازم في ViewController فقط
- **كل** `TextEditingController`, `ValueNotifier`, `AnimationController`, `ScrollController`, `FocusNode` → داخل الـ ViewController
- **كل** function متعلقة بالـ UI logic (onSend, onSearch, selectTab, onFilter) → داخل الـ ViewController
- الـ View تستخدم **object واحد** من الـ ViewController وتنادي منه بس — `_vc.xxx`
- استخدم `ValueNotifier` + `ValueListenableBuilder` بدل `setState`
- الـ ViewController يعمل `dispose()` لكل الـ controllers/notifiers
- الـ View تنادي `_vc.dispose()` في `dispose()` بتاعها

---

## LoadingButton — Golden Path (Form Submits)

> **كل form submit لازم يستخدم `LoadingButton` مش `DefaultButton`.**
> **الـ LoadingButton بيعمل handle لحالة الـ loading تلقائياً — بيمنع double-tap وبيوري spinner.**

```dart
// ✅ CORRECT — LoadingButton with BlocListener for success/error
BlocListener<SubmitCubit, AsyncState<bool>>(
  listener: (context, state) {
    if (state.isSuccess) {
      MessageUtils.showSnackBar(message: LocaleKeys.success.tr(), baseStatus: BaseStatus.success);
      Go.back();
    }
  },
  child: LoadingButton(
    title: LocaleKeys.submit.tr(),
    onTap: () {
      if (!params.validateAndScroll()) return;
      context.read<SubmitCubit>().submit(params.toJson());
    },
    cubit: context.read<SubmitCubit>(),  // ← LoadingButton يعرف يعرض loading من الـ cubit
  ),
)
```

**LoadingButton بيعمل إيه تلقائياً:**
- بيسمع على `cubit.state.isLoading` → يعرض spinner بدل النص
- بيمنع tap تاني وهو loading
- بيرجع للحالة الطبيعية لما الـ cubit يخلص (success أو error)

**متى تستخدم DefaultButton بدل LoadingButton:**
- أزرار navigation (مش API call)
- أزرار cancel / back
- أزرار filter / sort (مش async)

---

## Icon Inside Container → Center Widget (MANDATORY)

> **أي أيقونة داخل Container بـ background لازم تتلف في `Center` widget عشان حجمها ميبقاش بحجم الـ Container.**

```dart
// ✅ CORRECT — Icon wrapped in Center inside Container
Container(
  width: AppSize.sH48,
  height: AppSize.sH48,
  decoration: BoxDecoration(
    color: AppColors.grey1,
    borderRadius: BorderRadius.circular(AppCircular.r8),
  ),
  child: Center(
    child: IconWidget(
      icon: AppAssets.svg.appSvg.sent.path,
      width: AppSize.sW24,
      height: AppSize.sH24,
      color: AppColors.main,
    ),
  ),
)

// ❌ WRONG — Icon without Center → stretches to Container size
Container(
  width: AppSize.sH48,
  height: AppSize.sH48,
  decoration: BoxDecoration(color: AppColors.grey1),
  child: IconWidget(  // ← will stretch to fill container!
    icon: AppAssets.svg.appSvg.sent.path,
    width: AppSize.sW24,
    height: AppSize.sH24,
  ),
)
```

---

## Section Sub-Folders — For Complex Screens

> **لما الشاشة فيها widgets كتير، كل مجموعة sections مرتبطة ببعض حطها في folder يعبر عنها.**

```
lib/src/features/home/presentation/
├── widgets/
│   ├── home_body.dart                ← layout only
│   ├── header/                       ← header-related widgets
│   │   ├── home_header_widget.dart
│   │   ├── home_search_bar.dart
│   │   └── home_notification_icon.dart
│   ├── categories/                   ← category section widgets
│   │   ├── categories_section.dart
│   │   └── category_card.dart
│   ├── products/                     ← product section widgets
│   │   ├── products_section.dart
│   │   └── product_card.dart
│   └── banners/                      ← banner section widgets
│       └── banner_carousel.dart
```

**متى تستخدم sub-folders:**
- الشاشة فيها **4+ sections** مختلفة
- كل section فيها **2+ widgets** مرتبطة

**متى تبقى flat (بدون folders):**
- الشاشة بسيطة (body + card + filter فقط)
- كل section = widget واحد فقط

---

## Cubit, Entity & Form Patterns

> **See `bloc-patterns` skill for full AsyncCubit/CRUD/BlocListener patterns.**
> **See `coding-standards` section 8.5 for entity safety rules.**
> **See `coding-standards` section 8.1 for FormMixin pattern.**

Quick reminders:
- AsyncCubit: `@injectable` + `executeAsync()` + local CRUD updates (never re-fetch)
- Entity: `factory initial()` + `fromJson` with `??` + `tryParse` (never `parse`)
- Form: `with FormMixin` + `params.validateAndScroll()` + `LoadingButton`
