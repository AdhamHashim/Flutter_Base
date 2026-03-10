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
flutter run                                                    # Run app
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
- API calls → `AsyncCubit<T>` with `executeAsync()`
- Paginated lists → `PaginatedCubit<T>`
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
- Font size: Figma ≤12sp → reduce 1sp, 13–18sp → reduce 1–2sp, ≥20sp → reduce 2sp
- Font weight: may need to reduce if looks heavier than design
- Body padding > 12px: reduce by 2-4px
- Colors: match `AppColors` by purpose, not exact hex
- Sizes: `AppSize`, `AppPadding`, `AppMargin`, `AppCircular` only

### Platform Configuration
- Camera, gallery, microphone, maps → add Android/iOS config files
- Prefer method channels over `permission_handler` package
- Use existing packages (e.g. `flutter_rating_bar`) instead of building from scratch

## Skills & Rules (Synced)

Both `.claude/skills/` and `.cursor/rules/` contain the **same content and rules** — synced for equal power in Claude Code and Cursor IDE.

### Skills (.claude/skills/) — 19 total
Run `/skill-name` for detailed patterns:
- `feature-prompt` — **Start here**: full feature workflow prompt (fill in feature name + Figma + Postman)
- `coding-standards` — Master reference (colors, sizes, text, widgets, extensions, forms, navigation, naming)
- `feature-development` — Full 7-phase feature development workflow
- `bloc-patterns` — AsyncCubit, CRUD local updates, BlocListener, PaginatedCubit
- `flutter-patterns` — Widget patterns, file structure, key widgets, screen/body patterns
- `design-tokens` — Color/size/font/spacing mapping from Figma
- `figma-to-flutter` — Figma→Flutter conversion workflow with safety checks
- `figma-task-extractor` — Auto-generate tasks from Figma file
- `rtl-arabic` — RTL rules, layout mirroring prevention, directional APIs
- `scaffold-patterns` — Scaffold types, status bar rules
- `search-field-debounce` — Search field with rxdart debounce
- `clean-code-and-refactoring` — Widget splitting, deduplication
- `di-and-architecture` — DI patterns, layer separation
- `error-handling-and-resilience` — Error states, retry patterns
- `logging-and-debugging` — No print, AppBlocObserver
- `performance-and-memory` — Const, lists, dispose, lifecycle
- `pubspec-manager` — Package detection, platform config
- `accessibility` — Tap targets ≥44, semantic labels, contrast
- `post-feature-review` — **Auto code review** after completing any feature

### Cursor Rules (.cursor/rules/) — 20 total
Mirror of all skills above, plus:
- `flutter-base-coding-standards.mdc` — Same as `coding-standards` skill
- `flutter-feature-development.mdc` — Same as `feature-development` skill
- `scaffold-statusbar.mdc` — Same as `scaffold-patterns` skill
- `figma-mcp-mapping.mdc` — Figma MCP token mapping (supplementary to design-tokens)
- `error-handling-and-resilience.mdc` — Same as skill
- `post-feature-review.mdc` — **Always active** (alwaysApply: true)

### Feature Prompt (.cursor/prompt/)
- `feature_prompt.md` — Same content as `feature-prompt` skill, paste in Cursor chat with feature details
