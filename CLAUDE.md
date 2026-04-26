# Flutter_Base — Claude / Cursor Project Context

This file gives Claude (and Cursor) the baseline context every conversation needs without requiring it to load any skill. Skills add depth on demand; this file establishes the terrain.

---

## Project at a Glance

- **Type:** Flutter mobile app (Android + iOS, with desktop targets present)
- **Language:** Arabic-first, RTL by default
- **Architecture:** Clean Architecture — `presentation` (BLoC + widgets), `domain` (use-cases + entities), `data` (Dio + DTOs)
- **State management:** `flutter_bloc` with custom `AsyncCubit<T>` / `PaginatedCubit<T>` base classes
- **DI:** `injectable` + `get_it` — accessed via `injector<T>()`
- **Localization:** `easy_localization` with `lang.json` source → `LocaleKeys` generated file
- **Networking:** `dio` via `baseCrudUseCase` + `CrudBaseParams` — never raw Dio calls in features
- **Design source:** Figma via Figma MCP (mandatory read before writing UI code)

---

## Folder Structure

```
lib/src/
├── config/res/                   ← AppColors, AppSize, AppPadding, AppCircular, FontSizeManager, AppAssets, LocaleKeys
├── core/
│   ├── widgets/                  ← shared widgets (LoadingButton, CustomTextFiled, AsyncBlocBuilder, CachedImage, DefaultScaffold, ...)
│   ├── helpers/                  ← Validators, InputFormatters, Helpers, ImageHelper, LauncherHelper, CacheStorage
│   ├── extensions/               ← TextStyleEx, FormatString, ContextExtension, PaddingExtension, MarginExtension, OnClick, SizedBoxHelper, SliverExtension, FormMixin
│   ├── network/                  ← ApiConstants, baseCrudUseCase, CrudBaseParams, DioService
│   ├── shared/                   ← BaseModel, UserModel, ImageEntity, UserCubit, AppBlocObserver
│   └── config/
│       ├── mock_config.dart
│       └── mocks/
└── features/
    └── <feature_name>/
        ├── entity/
        └── presentation/
            ├── imports/view_imports.dart
            ├── cubits/<feature>_cubit.dart
            ├── view/<feature>_screen.dart
            └── widgets/
```

---

## Non-Negotiable Conventions

- **RTL is the default.** Use `start`/`end` directional APIs everywhere. See `rtl-arabic` skill.
- **No raw values in code.** Colors → `AppColors`, sizes → `AppSize`/`AppPadding`/`AppCircular`, text → `LocaleKeys.*.tr()`, icons → `AppAssets`.
- **Read Figma MCP before writing UI.** If MCP fails → stop. See `figma-mcp-read-first`.
- **No mock data without explicit permission.** See `no-mock-without-permission`.
- **One cubit per endpoint.** Local update on add/edit/delete (never re-fetch).
- **Body widget = layout only.** Each section/card in its own file under `widgets/`.
- **`view_imports.dart` part-of system.** Every feature file: `part of '../imports/view_imports.dart';`.
- **ViewController class for stateful UI.** See `view-controller-pattern`.

---

## Workflow Entry Point

For any new feature, the canonical workflow is in **`feature-prompt`** skill (orchestrator).

---

## Skills Sync

Skills live in two mirrored locations:

- `.claude/skills/<name>/SKILL.md` — canonical source
- `.cursor/rules/<name>.mdc` — generated from canonical

After any edit: `bash scripts/sync-cursor.sh` (or rely on the pre-commit hook).
**Never edit `.cursor/rules/*.mdc` directly.**

Cursor metadata (`globs`, `alwaysApply`) lives in `.claude/skills/<name>/.cursor.yaml`.

---

## Where to Look First

- Adding a feature? `feature-prompt`.
- API? `api-pipeline` (Postman جاهز من فريق الباك إند).
- Form? `form-api-pipeline`.
- RTL? `rtl-arabic`.
- Review finished work? `post-feature-review`.
- Master coding-standards? `coding-standards` (entity safety + slivers + part-of system + pointers to subdomain skills)
- Extensions/helpers? `extensions-and-helpers`
- Naming + cleanup? `naming-and-cleanup`
- Widget catalog? `widget-reference`
- ViewController? `view-controller-pattern`
- Localization? `localization-keys`
