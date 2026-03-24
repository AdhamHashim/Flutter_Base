# Flutter_Base 

## Project Overview
Flutter RTL Arabic-first mobile application built with Clean Architecture + BLoC/Cubit pattern.
- **Language:** Dart / Flutter
- **State Management:** flutter_bloc (AsyncCubit<T>, PaginatedCubit<T>)
- **DI:** GetIt + Injectable via `injector<T>()`
- **Localization:** easy_localization (ar.json / en.json)
- **Font:** Expo Arabic
- **Direction:** RTL by default — use `start`/`end`, never `left`/`right`

## Quick Commands
```bash
flutter run                                                    # Run app (real API)
flutter run --dart-define=USE_MOCK=true                        # Run app (mock data)
flutter pub get                                                # Install dependencies
dart run build_runner build --delete-conflicting-outputs        # Generate injectable/freezed
dart run generate/strings/main.dart                            # Generate locale keys
```

## Architecture Rules (Summary)

### DI & Layers
- All cubits/usecases → `@injectable`, accessed via `injector<T>()`
- Presentation: Widgets + Cubits (Entity only, no Dio/HTTP)
- Domain: UseCases + Repository interfaces + Entities
- Data: RemoteDatasource + DTOs + Dio

### State Management
- API calls → `AsyncCubit<T>` with `executeAsync()` or `executeMockOrAsync()`
- Paginated lists → `PaginatedCubit<T>` — **mandatory for any list endpoint with standalone screen**
- `AsyncCubit<List<T>>` only for dropdowns, sub-sections, filter chips
- CRUD → update state locally, NEVER re-fetch after add/edit/delete
- UI state (controllers, notifiers) → `ViewController` class, not directly in view

### Feature Structure
```
lib/src/features/{name}/
├── entity/{name}_entity.dart
├── presentation/
│   ├── imports/view_imports.dart    ← all imports + part declarations
│   ├── cubits/{name}_cubit.dart
│   ├── view/{name}_screen.dart     ← thin: scaffold + body
│   └── widgets/
│       ├── {name}_body.dart        ← layout only
│       ├── {section}_widget.dart   ← one file per section
│       └── {section}/              ← sub-folder if many related widgets
```

### Key Patterns
- All files: `part of '../imports/view_imports.dart'`
- Entity: always provide `factory initial()` for Skeletonizer
- Forms: `FormMixin` + `params.validateAndScroll()` + `LoadingButton`
- Search: `DefaultTextField` + rxdart `PublishSubject` + debounce(500ms)
- Scaffold: inner → `DefaultScaffold`, auth → plain `Scaffold` + `SafeArea`
- Images: always `CachedImage`, never `Image.network`
- Navigation: `Go.to()` / `Go.back()`, never `Navigator.push`
- Icons: `IconWidget`, never `Icons.*`
- Icon in Container with background → always wrap icon in `Center` widget

### RTL Rules
- `start` = physical RIGHT (Arabic text side)
- `end` = physical LEFT
- Row first child = physical RIGHT
- Never use `Positioned`, `Alignment`, `EdgeInsets` with left/right → use Directional versions
- **NEVER use `Directionality` widget on layouts** — app is RTL via MaterialApp. Exception: wrapping a single Text/RichText widget with `Directionality(textDirection: TextDirection.rtl)` to fix mirrored text inside complex components (e.g. Slider labels, DropdownButton items)
- Figma MCP may mirror RTL layout → always verify against screenshot

### API Integration
- All endpoints in `ApiConstants` only — no hardcoded strings in cubits/views
- HTTP calls via `baseCrudUseCase.call(CrudBaseParams(...))` inside cubits
- Mapper: `(json) => Entity.fromJson(json['data'])` or list mapping
- Error handling: `AsyncBlocBuilder` handles loading/error/success automatically
- Network errors: `ErrorView(error, onRetry)` with retry button

### Design Token Conversion (Figma → Code)
- Font size: Figma ≤13sp → **keep as-is**, 14–18sp → reduce 1–2sp, ≥20sp → reduce 2sp
- Font weight: may need to reduce if looks heavier than design
- Body padding > 12px: reduce by 2-4px
- Colors: match `AppColors` by purpose, not exact hex
- Sizes: `AppSize`, `AppPadding`, `AppMargin`, `AppCircular` only

### Clean Code Rules
- Spacing: `.szH`/`.szW` extensions ONLY — never raw `SizedBox`
- Padding: `.paddingAll()`, `.paddingStart()` extensions — never `Padding(...)` widget
- `const` on every widget/constructor that can be const
- Delete unused imports + remove unused optional parameters
- Models/enums/helpers (status→color, status→label) → `entity/` folder, not inside widget class
- Dropdown/small widget API → isolate `BlocBuilder` on the widget itself, not entire screen
- **All text → `lang.json` first, then `LocaleKeys` in code — MANDATORY:**
  - Format: `"snake_key #$ English": "عربي"` in `assets/translations/lang.json`
  - Generate: `dart run generate/strings/main.dart` after any change
  - Figma MCP: extract ALL text nodes → add to `lang.json` → use `LocaleKeys` only
  - Zero hardcoded strings — even "OK", "لا", placeholders, tab labels
- AppBar/BottomSheet/Dialog → check RTL with `Directionality` wrapper if content reversed
- Dotted borders → use `dotted_border` package

### API Design & Mock Data
- Postman Collection: **ONE file** `postman/app_name.postman_collection.json` with internal folders (Auth, Products, Settings, Shared, etc.) — NEVER separate files per feature
- Unified response: `{status, code, message, data?}` — Arabic messages
- Multi-section screens → separate service per section (never one mega-endpoint)
- Lists → pagination required (`?page=1&per_page=10`) → always `PaginatedCubit`
- Multi-step forms → `validate-step-{n}` per step + final create
- File uploads → separate `POST /upload-file` returns `{id, url, type}`, then pass `file_id`
- Mock data: `--dart-define=USE_MOCK=true` → `executeMockOrAsync` in AsyncCubit, `MockConfig.useMock` in PaginatedCubit
- Mock files: `core/config/mocks/{feature}_mock.dart` (centralized, NOT in entity/) — realistic Arabic data, 8-15 items
- Mock files are plain classes with direct import — NOT `part of` any imports file

### UI-Only Mode
- Before starting any feature → ask: "UI Only or UI + API?" then "Existing Postman or Auto Generate?"
- **UI Only** → static data in widgets, no cubits, no API, no Postman
- **UI + API (Existing Postman)** → provide Postman link → read & implement
- **UI + API (Auto Generate)** → analyze Figma → generate Postman JSON + entities + cubits + mock data
- Never create fake API endpoints — they crash the app

### Platform Configuration
- Camera, gallery, microphone, maps → add Android/iOS config files
- Prefer method channels over `permission_handler` package
- Use existing packages (e.g. `flutter_rating_bar`, `dotted_border`) instead of building from scratch

## Skills & Rules (Synced)

Both `.claude/skills/` and `.cursor/rules/` contain the **same content and rules** — synced for equal power in Claude Code and Cursor IDE.

### Skills (.claude/skills/) — 28 total
Run `/skill-name` for detailed patterns:

**Workflow & Entry Points:**
- `feature-prompt` — **Start here**: full feature workflow prompt (fill in feature name + Figma + Postman)
- `feature-development` — Full 7-phase feature development workflow
- `post-feature-review` — **Auto code review** after completing any feature

**Architecture & Patterns:**
- `coding-standards` — Master reference (colors, sizes, text, widgets, extensions, forms, navigation, naming, slivers)
- `bloc-patterns` — AsyncCubit, CRUD local updates, BlocListener, PaginatedCubit
- `flutter-patterns` — Widget patterns, file structure, key widgets, screen/body patterns
- `di-and-architecture` — DI patterns, layer separation
- `bloc-provider-scoping` — Where to provide cubits, single vs multi, shared vs isolated, decision tree

**API & Data Flow:**
- `api-pipeline` — Complete Postman → ApiConstants → Entity → CrudBaseParams → Cubit → UI pipeline
- `api-design` — Auto-generate Postman Collection JSON from Figma screens (unified entities, pagination, multi-step forms, file upload)
- `mock-data` — Mock data switching system via `--dart-define=USE_MOCK=true/false`, unified across all cubits
- `form-api-pipeline` — Complete form → ViewController → Params → validation → API submit → success
- `navigation-patterns` — Go.to() with arguments, back with result, refresh parent, tab navigation
- `multi-screen-flow` — List/detail/edit/create patterns with data passing and screen linking

**Figma & Design:**
- `design-tokens` — Color/size/font/spacing mapping from Figma
- `figma-to-flutter` — Figma→Flutter conversion workflow with safety checks
- `figma-widget-mapping` — Comprehensive Figma element → Flutter widget mapping table
- `figma-mcp-mapping` — Figma MCP token conversion cheatsheet
- `figma-task-extractor` — Auto-generate tasks from Figma file

**RTL & Localization:**
- `rtl-arabic` — RTL rules, layout mirroring prevention, directional APIs

**UI Patterns:**
- `scaffold-patterns` — Scaffold types, status bar rules
- `search-field-debounce` — Search field with rxdart debounce

**Quality & Standards:**
- `clean-code-and-refactoring` — Widget splitting, deduplication, const everywhere
- `error-handling-and-resilience` — Error states, retry patterns, defensive coding
- `logging-and-debugging` — No print, AppBlocObserver
- `performance-and-memory` — Const, lists, dispose, lifecycle
- `pubspec-manager` — Package detection, platform config
- `accessibility` — Tap targets ≥44, semantic labels, contrast

### Cursor Rules (.cursor/rules/) — 28 total
Mirror of all skills above, plus:
- `flutter-base-coding-standards.mdc` — Same as `coding-standards` skill
- `flutter-feature-development.mdc` — Same as `feature-development` skill
- `scaffold-statusbar.mdc` — Same as `scaffold-patterns` skill
- `api-design.mdc` — Same as `api-design` skill (Postman Collection generation)
- `mock-data.mdc` — Same as `mock-data` skill (mock/real API switching)
- `error-handling-and-resilience.mdc` — **Always active** (alwaysApply: true)
- `post-feature-review.mdc` — **Always active** (alwaysApply: true)

### Feature Prompt (.cursor/prompt/)
- `feature_prompt.md` — Same content as `feature-prompt` skill, paste in Cursor chat with feature details
