---
name: feature-prompt
description: Orchestrate feature development from Figma → working screen. Coordinates all phases (audit, Figma read, API source, plan, implement, verify) by delegating to canonical skills. Fill the inputs below and follow the phases in order.
---

# Feature Development Orchestrator

> **هذا الـ prompt orchestrator فقط.** كل القواعد التنفيذية في skills مختلفة — اتبع الـ pointers في كل phase.

---

## Inputs (يعبّيهم المستخدم قبل ما يبعت)

```
Feature:     [FEATURE_NAME]
Figma Node:  [FIGMA_URL]
Mode:        [UI_ONLY | UI_AND_API]
Postman:     [POSTMAN_URL لو UI_AND_API، اتركه فاضي لو UI_ONLY]
```

> **UI_AND_API** → provide Postman Collection: `[POSTMAN_URL]` (جاهز من فريق الباك إند)
> **UI_ONLY** → no API, no cubits, no Postman — static data في الـ widgets

---

## Decision Tree — لو الـ Inputs مش واضحة، اسأل أولاً

### السؤال الوحيد — UI بس ولا UI + API؟
- **UI Only** → static data في الـ widgets مباشرة، بدون cubits، بدون API
- **UI + API** → ادّيني link الـ Postman Collection (جاهز من الباك إند)

### ملخص الأوضاع

| الوضع | Cubits | Postman | MockConfig |
|-------|--------|---------|------------|
| **UI Only** | ❌ | ❌ | ❌ |
| **UI + API** | ✅ | جاهز من الباك إند | ✅ بطلب صريح |

> **Mock data:** ممنوع تلقائياً. See `no-mock-without-permission` skill.

---

## PHASE 1 — Audit (إلزامي)

اقرأ الموجود في المشروع قبل ما تكتب أي كود جديد:

1. `lib/src/config/res/color_manager.dart` → AppColors المتاحة
2. `lib/src/config/res/app_sizes.dart` → AppSize / AppPadding / AppMargin / AppCircular / FontSizeManager
3. `lib/src/config/res/assets.gen.dart` → AppAssets
4. `lib/src/core/widgets/` → core buttons, fields, dialogs, scaffolds, image widgets
5. `lib/src/features/**/app_shared/widgets/` → shared widgets الموجودة
6. `lib/src/features/` → entities أو widgets شبه اللي هتعمله

> **Golden rule:** لو موجود في `core/` أو `config/` → استخدمه. لا تخترع.

→ تفاصيل أكثر: `feature-development` skill PHASE 1

---

## PHASE 2 — Read Figma (إلزامي ما لم UI_ONLY بدون Figma)

> **See `figma-mcp-read-first` skill** — قراءة Figma MCP إلزامية. لو فشلت → STOP.
> **See `figma-mcp-mapping` skill** — جداول التحويل (sizes, padding, fonts, screen-level adjustment).
> **See `figma-widget-mapping` skill** — Figma element → Flutter widget table.
> **See `design-tokens` skill** — Color reuse rule + AppColors table.
> **See `rtl-arabic` skill** — RTL section verification + conversion.
> **See `localization-keys` skill** — extract all text into lang.json.

اقرأ كل الـ states: main, empty, loading, error, modals, bottom sheets, success/failure.

---

## PHASE 3 — Postman Collection (skip if UI_ONLY)

> **See `api-pipeline` skill** — Postman → ApiConstants → Entity → Cubit → UI.

اقرأ الـ Postman Collection اللي ادّاه المستخدم → استخرج الـ endpoints + الـ entities → نفّذ الـ pipeline.

→ بعد ما تخلص PHASE 3، روح PHASE 4.

---

## PHASE 4 — Plan (انتظر الموافقة)

اعرض على المستخدم خطة كاملة قبل الكود:

1. Folder structure (each section/card في ملف منفصل — see `flutter-patterns`)
2. Entity fields + fromJson types
3. List of cubits (one per endpoint)
4. New AppColors / AppSizes / Locale keys needed
5. Scaffold type per screen (see `scaffold-patterns`)
6. CRUD local-update plan (see `bloc-patterns`)
7. Shared widgets to reuse vs. create
8. Isolate / compute() needed?

**انتظر موافقة المستخدم قبل الانتقال لـ PHASE 5.**

---

## PHASE 5 — Implement

| الجانب | Skills |
|--------|--------|
| Architecture & DI | `di-and-architecture` |
| BLoC patterns + CRUD | `bloc-patterns`, `bloc-provider-scoping` |
| Folder structure + widget splitting | `flutter-patterns` |
| Coding standards (entity safety, slivers) | `coding-standards` |
| Scaffold + status bar | `scaffold-patterns` |
| RTL | `rtl-arabic` |
| Forms | `form-api-pipeline`, `view-controller-pattern` |
| Localization | `localization-keys` |
| Navigation | `navigation-patterns`, `multi-screen-flow` |
| Search field | `search-field-debounce` |
| Mock data (only if user asked) | `mock-data` (gate: `no-mock-without-permission`) |
| Performance | `performance-and-memory` |
| Errors & resilience | `error-handling-and-resilience` |
| Logging | `logging-and-debugging` |
| Accessibility | `accessibility` |
| Packages | `pubspec-manager` |
| Tokens reference | `design-tokens` |
| Extensions/helpers | `extensions-and-helpers` |
| Naming + cleanup | `naming-and-cleanup` |
| Widget reference | `widget-reference` |

---

## PHASE 6 — Verify

> **See `post-feature-review` skill** — هي الـ canonical checklist للـ verification.

```bash
flutter analyze
dart run generate/strings/main.dart       # if locale keys added
dart run build_runner build --delete-conflicting-outputs  # if @injectable cubit added
```

---

## Quick Sanity Check

- مفيش raw Color(), Icons.*, SizedBox(N), hardcoded text
- كل entity فيها factory initial() + safe fromJson
- Body widgets = layout only
- ViewController موجود للـ controllers/notifiers
- RefreshIndicator على كل data screens
- Mock data مش متضافة بدون طلب صريح
- flutter analyze يطلع zero warnings
