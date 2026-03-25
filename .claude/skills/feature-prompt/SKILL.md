---
name: feature-prompt
description: Full feature development workflow — fill in feature name, Figma link, and Postman link, then follow all phases from audit to verify.
---

# Feature Development Prompt

Feature: [FEATURE_NAME]
Figma Node: [FIGMA_URL]
Mode: [UI_ONLY / UI_AND_API]
API Source: [EXISTING_POSTMAN / AUTO_GENERATE / NONE]

> If **EXISTING_POSTMAN** → provide: Postman Collection: [POSTMAN_URL]
> If **AUTO_GENERATE** → will be generated from Figma in STEP 4
> If **NONE** → UI_ONLY mode (no API)

---

## ⚠️ FIRST — ASK THE USER (3 أسئلة):

> **قبل ما تبدأ أي شغل — لازم تسأل المستخدم:**
>
> ### السؤال 1: "عاوز تصميم UI بس ولا UI + API مع بعض؟"
>
> - **UI Only** → اعمل الشاشات بـ static data مباشرة في الـ widgets، بدون cubits، بدون API calls، بدون Postman. لا تحتاج MockConfig.
> - **UI + API** → كمّل للسؤال 2.
>
> ### السؤال 2 (لو UI + API): "عندك Postman Collection جاهزة ولا أولّدلك الـ API؟"
>
> - **A) عندي Postman جاهز** → ادّيني الـ link وأنا هقرأه وأنفذه (الطريقة القديمة — STEP 4 يتخطى، STEP 5 يشتغل)
> - **B) ولّدلي الـ API** → هحلل شاشات Figma وأولّد Postman Collection JSON + mock data + entities أوتوماتيك (الطريقة الجديدة — STEP 4 يشتغل كامل)
>
> ### ملخص الأوضاع الثلاثة:
>
> | الوضع | Cubits | API Source | MockConfig | Postman |
> |-------|--------|------------|------------|--------|
> | **UI Only** | ❌ لا | — | ❌ لا | ❌ لا |
> | **UI + API (Existing Postman)** | ✅ نعم | Postman Collection جاهزة | ✅ نعم | ✅ جاهز |
> | **UI + API (Auto Generate)** | ✅ نعم | يتولّد من Figma | ✅ نعم | ✅ يتولّد في STEP 4 |
>
> **الفرق بين UI Only و Mock Mode:**
> - **UI Only** = مفيش cubits أصلاً — data ثابتة في الـ widget مباشرة
> - **Mock Mode** (`--dart-define=USE_MOCK=true`) = cubits موجودة بس بتسحب من mock files بدل الـ API — ده لـ UI+API mode بس (سواء existing أو auto-generated)

---

Before writing ANY code, follow this exact order:

══════════════════════════════════════════════════════════════
STEP 1 — LOAD SKILLS (إلزامي)
══════════════════════════════════════════════════════════════

All skills in `.claude/skills/` are available. Ensure you've internalized:

**Workflow & Entry Points:**
- `feature-development` — full workflow, phases, cubit patterns, CRUD, checklist
- `post-feature-review` — auto code review after completing any feature

**Architecture & Patterns:**
- `coding-standards` — colors, sizes, text styles, RTL, core widgets, entity safety, extensions, helpers, slivers
- `bloc-patterns` — AsyncCubit, CRUD local updates, BlocListener, PaginatedCubit
- `flutter-patterns` — Widget patterns, file structure, key widgets, screen/body patterns
- `di-and-architecture` — injector<T>(), layering, ApiConstants
- `bloc-provider-scoping` — where to provide cubits, single vs multi, shared vs isolated, decision tree

**API & Data Flow:**
- `api-pipeline` — Complete Postman → ApiConstants → Entity → CrudBaseParams → Cubit → UI pipeline
- `api-design` — Auto-generate Postman Collection JSON from Figma screens (unified entities, pagination, multi-step forms, file upload)
- `mock-data` — Mock data switching system via `--dart-define=USE_MOCK=true/false`, unified across all cubits
- `form-api-pipeline` — Complete form → ViewController → Params → validation → API submit → success
- `navigation-patterns` — Go.to() with arguments, back with result, refresh parent, tab navigation
- `multi-screen-flow` — List/detail/edit/create patterns with data passing and screen linking

**Figma & Design:**
- `design-tokens` — Figma → Flutter token mapping
- `figma-to-flutter` — Figma MCP conversion workflow + safety checks
- `figma-widget-mapping` — Comprehensive Figma element → Flutter widget mapping table
- `figma-mcp-mapping` — Figma MCP token conversion cheatsheet
- `figma-task-extractor` — Auto-generate tasks from Figma file

**RTL & Localization:**
- `rtl-arabic` — RTL rules, layout mirroring prevention, directional APIs

**UI Patterns:**
- `scaffold-patterns` — 3 scaffold types + status bar rules
- `search-field-debounce` — real TextField + rxdart debounce

**Quality & Standards:**
- `clean-code-and-refactoring` — widget splitting (separate files!), shared reuse, naming
- `error-handling-and-resilience` — ErrorView, retries, fromJson safety
- `performance-and-memory` — const, lists, slivers, dispose
- `logging-and-debugging` — no print/debugPrint in final code
- `pubspec-manager` — package detection, platform config
- `accessibility` — tap targets >=44, semantic labels for icon-only buttons (consider when building UI)

══════════════════════════════════════════════════════════════
STEP 2 — AUDIT EXISTING CODE (إلزامي)
══════════════════════════════════════════════════════════════

1. Read `color_manager.dart` → list all AppColors (reuse by PURPOSE, not just hex)
2. Read `app_sizes.dart` → list AppSize, AppPadding, AppMargin, AppCircular, FontSizeManager
3. Read `assets.gen.dart` → list all AppAssets
4. Check `core/widgets/` — buttons, fields, dialogs, handling_views, image_widgets, scaffolds
5. Check `features/` — any existing entity or shared widget that matches (reuse, don't duplicate)
6. Check `app_shared/widgets/` — any card/component already built for another feature

Golden rule: If it exists in core/ or config/ → use it. Never reinvent.

══════════════════════════════════════════════════════════════
STEP 3 — READ FIGMA (via Figma MCP)
══════════════════════════════════════════════════════════════

- Read ALL screens: main state, empty state, loading state, error state, modals, bottom sheets
- For EVERY value: map color hex → AppColors, map px → AppSize/AppPadding/AppCircular, map font → FontSizeManager

Screen-Level Padding Adjustment (إلزامي):
- Body padding <= 12px → keep as-is
- Body padding > 12px → reduce by 2-4px (Figma 16 → 12 or 14, Figma 20 → 16)
- Applies ONLY to screen body padding — NOT card-internal or component padding

RTL Section Verification (إلزامي):
- Figma MCP sometimes returns sections MIRRORED/REVERSED from actual design
- ALWAYS cross-check each section with the Figma screenshot
- If MCP data contradicts the visual → TRUST THE SCREENSHOT

Icon Background Check (إلزامي):
- Some AppAssets icons already include their background (circle/rect with fill)
- Check asset BEFORE wrapping in Container — avoid double-background

Color Reuse Rule (إلزامي):
- Read color_manager.dart FIRST — match by PURPOSE, not just hex
- Close-match → use existing, DON'T create new
- Truly new → add with GENERIC name (never screen-prefixed like loginPrimary)

Font Size Adjustment (إلزامي):
- Figma ≤ 13sp (10, 11, 12, 13) → KEEP AS-IS — لا تقلل النصوص الصغيرة
- Figma 14-18sp → reduce by 1-2sp | Figma >= 20sp → reduce by 2sp

RTL Conversion (إلزامي):
- Figma RIGHT = Flutter "start" → CrossAxisAlignment.start, AlignmentDirectional.centerStart, PositionedDirectional(start:), paddingStart
- Figma LEFT = Flutter "end" → CrossAxisAlignment.end, AlignmentDirectional.centerEnd, PositionedDirectional(end:), paddingEnd
- Row: RIGHT element = FIRST child, LEFT element = LAST child
- NEVER: Positioned(left:/right:), Align(centerLeft/Right), EdgeInsets.only(left/right:), TextAlign.left, Directionality on layouts (exception: single Text widget fix inside complex components)

══════════════════════════════════════════════════════════════
STEP 4 — API SOURCE — SKIP IF UI_ONLY MODE
══════════════════════════════════════════════════════════════

**If UI_ONLY mode:** Skip STEP 4 + STEP 5 entirely.

---

### Path A: EXISTING_POSTMAN (عندي Postman جاهز)

> المستخدم عنده Postman Collection جاهزة — اقرأها ونفّذها.

- Read full request/response schema from the provided Postman Collection
- Check pagination → PaginatedCubit + PaginatedListWidget if yes
- Check actions (delete/update/toggle) → plan local state update (NEVER re-fetch):
  - Add: insert at index 0 → setSuccess(data: [newItem, ...state.data])
  - Edit: map + replace → state.data.map((e) => e.id == id ? updated : e).toList()
  - Delete: removeWhere → state.data..removeWhere((e) => e.id == id)
- One cubit per endpoint — never merge
- Entity safety: factory initial(), fromJson with ?? defaults, tryParse only (never parse)
- Create mock data files using `mock-data` skill (for `--dart-define=USE_MOCK=true` support)

→ **بعد ما تخلص، روح STEP 6 (Plan)**

---

### Path B: AUTO_GENERATE (ولّدلي الـ API من Figma)

> مفيش Postman — هنولّد كل حاجة أوتوماتيك من شاشات Figma باستخدام `api-design` skill.

**Phase 1: Analyze & Design**

1. Analyze the Figma screens → extract required services using extraction rules:
   - Multi-section screen → separate service per section
   - List screens → pagination required
   - Multi-step forms → validate-step-{n} per step + final create
   - File uploads → separate `upload-file` service
   - CRUD → 5 standard services (list/detail/create/update/delete)

2. Design endpoints (naming, method, URL structure, unified entities)

3. **عرض التحليل على المستخدم والانتظار للموافقة قبل التوليد:**
   - عدد الـ services المستخرجة
   - كل endpoint: method + URL + وصف
   - الـ entities الموحدة وحقولها

**Phase 2: Generate (بعد الموافقة)**

4. Generate endpoints into **ONE single Postman Collection** `postman/app_name.postman_collection.json`:
   - Add endpoints as a **folder** inside the existing collection (Auth, Products, Settings, Shared, etc.)
   - If collection doesn't exist → create it with all folders
   - If collection exists → add/update the relevant folder only
   - Unified response format: `{status, code, message, data?}`
   - Arabic messages for all responses
   - Success + Error response examples for every endpoint
   - Unified entities (same shape everywhere)
   - **❌ NEVER create separate files** like `auth.postman_collection.json`, `products.postman_collection.json`

5. Add endpoints to `ApiConstants`

6. Create entities with `factory initial()` + safe `fromJson`

7. Create mock data files in `core/config/mocks/{feature}_mock.dart` (centralized, NOT in entity/):
   - Realistic Arabic data, 8-15 items in lists
   - All entity fields populated
   - `paginatedResponse(page)` for list endpoints

8. Create cubits with `executeMockOrAsync` (AsyncCubit) or `MockConfig.useMock` (PaginatedCubit)

→ **بعد ما تخلص، روح STEP 6 (Plan) — الـ entities والـ cubits جاهزين، فالـ plan هيركز على الـ UI**

**⚠️ API Design Rules (لازم تتبع في الـ Postman generation):**
- Pagination key: `data.pagination` (NOT `data.meta`)
- Body mode: `urlencoded` for text, `formdata` for files, `raw JSON` for complex nested only
- Boolean values: integer `1`/`0` in responses, string `"1"`/`"0"` in requests
- Validation errors: `data.items.{field}: [errors]` (NOT `errors.{field}`)
- All success = HTTP 200 (no 201, 204)
- Status/enum fields: rich objects `{value, text_ar, text_en, tag_color}` (NOT plain strings)
- Emoji-commented JSON body sections (👤📱🎂🌍🏦📄🔐)
- Every endpoint: Figma link(s) + Arabic description
- Response examples: scenario-based names (`success first step`, `fail validation`, `empty response`)

---

══════════════════════════════════════════════════════════════
STEP 5 — (RESERVED — merged into STEP 4 paths above)
══════════════════════════════════════════════════════════════

> **This step is now handled within STEP 4 Path A and Path B above.**
> Proceed directly to STEP 6.

══════════════════════════════════════════════════════════════
STEP 6 — PLAN BEFORE CODING (انتظر الموافقة)
══════════════════════════════════════════════════════════════

Show me:
1. Feature folder structure (each section/card in separate widget file — NOT methods in body)
2. Entity fields with fromJson types
3. List of cubits (one per endpoint) — each with @injectable
4. New AppColors/AppSizes needed (justify why existing ones don't match)
5. New locale keys needed
6. Scaffold type per screen (DefaultScaffold / plain Scaffold+SafeArea / Home custom)
7. CRUD local update plan (how add/edit/delete will update state locally)
8. Shared widgets — any card/component from existing features → plan to reuse or move to app_shared/
9. Isolate needed? (4+ concurrent services → yes)

Wait for my approval before writing code.

══════════════════════════════════════════════════════════════
STEP 7 — IMPLEMENT
══════════════════════════════════════════════════════════════

Structure:
- Every file: `part of '../imports/view_imports.dart'`
- view_imports.dart: all imports + part declarations (cubits → view → body → section widgets → card widgets)
- Feature folder: entity/, presentation/{imports/, cubits/, view/, widgets/}

Widget Splitting (إلزامي):
- Body widget = layout ONLY — assembles sections
- Each section / card / component in a SEPARATE file inside widgets/
- NO `_buildXxx()` methods returning 10+ lines in body files
- Each widget file added as `part` in view_imports.dart

Widget Reuse (إلزامي):
- Before creating ANY widget → search app_shared/widgets/ AND existing features (especially recent screens)
- Same design 100% → reuse directly
- Minor differences → add optional params to existing widget (don't create a copy)
- Used in 2+ features → move to app_shared/widgets/
- NEVER duplicate card widgets across features

Entity:
- factory initial() with sensible defaults
- fromJson: String ?? '', int/double ?? 0, bool ?? false, List ?? [], Object ?? Model.initial(), nullable → no ??
- NEVER int.parse() / double.parse() → ONLY tryParse with fallback

State:
- AsyncCubit<T> for GET, one cubit per endpoint, @injectable
- PaginatedCubit<T> if pagination
- CRUD Local Updates (NEVER re-fetch after add/edit/delete)
- Heavy screens (4+ services): use compute() for JSON parsing

Scaffold:
- Inner screens → DefaultScaffold(title, body) — NEVER build custom header in body
- Auth screens → plain Scaffold + SafeArea + Helpers.changeStatusbarColor(scaffoldBackground, dark)
- Home → custom Scaffold + CustomNavigationBar + Helpers.changeStatusbarColor(loginPrimary, light)

UI — Core Widgets (use these, do NOT create from scratch):
- Buttons: LoadingButton (async submit), DefaultButton (simple)
- Fields: CustomTextFiled (label + validator + inputFormatters), DefaultTextField (raw, for search bars)
- Dropdown: AppDropdown<T>
- State: AsyncBlocBuilder / AsyncSliverBlocBuilder / PaginatedListWidget
- Images: CachedImage for ALL network images — NEVER Image.network()
- Icons: IconWidget(icon: AppAssets.xxx.path) — never Icons.* — check icon bg before wrapping
- Icon inside Container with background → always wrap icon in Center widget
- Dialogs: successDialog, showCustomDialog, showDefaultBottomSheet
- Messages: MessageUtils.showSnackBar
- Empty: EmptyWidget (full-screen only) | SizedBox.shrink() (multi-section empty)

Search Fields (if Figma has search bar):
- MUST be real DefaultTextField — NEVER static Container + Text
- Debounce: rxdart PublishSubject + debounceTime(500ms) + .distinct()
- StatefulWidget for controller + subscription lifecycle (dispose all in dispose())

Scroll Performance:
- Multi-section → CustomScrollView + Slivers (NEVER SingleChildScrollView + nested ListView)
- shrinkWrap: true on nested lists = FORBIDDEN
- Static → .toSliver() | Lists → SliverList.builder | Grids → SliverGrid.builder
- Multi-API → AsyncSliverBlocBuilder per section
- Sliver sections: widget returns Box (Column, etc.) and parent uses .toSliver() once — never double-wrap

Body Widget Pattern:
- RefreshIndicator MANDATORY on ALL data screens + AlwaysScrollableScrollPhysics
- Empty sections in multi-section → SizedBox.shrink() (NOT EmptyWidget)
- Skeleton: Entity.initial() for Skeletonizer

ViewController Pattern (إلزامي — ممنوع خرقها):
- **ممنوع** وضع Controller أو ValueNotifier داخل الـ View — لازم في ViewController class
- All TextEditingController, ValueNotifier, AnimationController, ScrollController, FocusNode → inside ViewController class ONLY
- All UI logic functions (onSend, onSearch, selectTab, onFilter) → inside ViewController
- View uses ONE ViewController object → يستدعيه بس (_vc.xxx)
- Use ValueNotifier + ValueListenableBuilder instead of setState
- ViewController provides dispose() for all controllers/notifiers
- View calls _vc.dispose() in its dispose()

Forms:
- Params class MUST use `with FormMixin`
- Submit MUST use `params.validateAndScroll()`
- Every field: validator from Validators + inputFormatters from core/helpers
- Number/phone: ArabicNumbersFormatter + .toEnglishNumbers() before API calls

RTL (every screen):
- Column text: CrossAxisAlignment.start (aligns right)
- Row: RIGHT = first child, LEFT = last child
- Align: AlignmentDirectional.centerStart (right), centerEnd (left)
- Stack: PositionedDirectional(start:) for right, (end:) for left
- Padding/Margin: paddingStart/End — never Left/Right
- NEVER: Positioned(left/right), Directionality on layouts, TextAlign.left (Directionality exception: single Text widget fix inside complex components like Slider/DropdownButton)

Values:
- Colors: AppColors only — reuse by purpose first, generic names only
- Sizes: AppSize/AppPadding/AppMargin/AppCircular — never raw numbers
- Text: const TextStyle().setMainTextColor.s14.medium — font ≤13sp keep as-is, 14+ reduce per rule
- Spacing: 12.szH, 16.szW — NEVER SizedBox(height/width:) | Text: LocaleKeys.xxx.tr() only
- Padding: .paddingAll(), .paddingStart() extensions — NEVER Padding(...) widget
- Margin: .marginAll(), .marginStart() extensions
- const: add to EVERY widget/constructor that can be const
- Navigation: Go.to/back/off/offAll — never Navigator.push
- API: ApiConstants.xxx — never raw URL strings (skip if UI_ONLY)
- Models: status/color/label mappers in entity/ — NEVER helper methods inside widget
- Imports: delete ALL unused imports | Parameters: remove unused optional params
- Dropdown API: isolate BlocBuilder on the dropdown itself, not wrapping whole screen

══════════════════════════════════════════════════════════════
STEP 8 — VERIFY
══════════════════════════════════════════════════════════════

1. Run: `flutter analyze` — zero errors/warnings
2. Run: `dart run generate/strings/main.dart` (if locale keys added)
3. Run: `dart run build_runner build` (if new @injectable cubit added)
4. RTL visual check: titles/labels on RIGHT, sections match Figma screenshot
5. No raw Color(), Icons.*, SizedBox(N), hardcoded text — all from AppColors/AppAssets/AppSize/LocaleKeys
6. Every entity: factory initial() + fromJson with ?? + tryParse only
7. Scaffold correct per screen + status bar synced
8. Font sizes ≤13sp kept as-is, 14+ reduced from Figma | Screen body padding > 12px reduced 2-4px
9. Colors reused by purpose | Icon backgrounds checked (no double-bg) | Icon SIZES match Figma exactly
10. All network images → CachedImage | Search fields → real DefaultTextField + debounce
11. Card CONTENT verified RTL: titles RIGHT, icon+text rows correct order, every Column has CrossAxisAlignment.start
12. CRUD: local updates only (no re-fetch) | RefreshIndicator on all data screens
13. Multi-section → CustomScrollView + Slivers (no shrinkWrap nested lists) | Sliver sections: no double-wrap with .toSliver()
14. Widget splitting: body = layout only, each section in separate file
15. Widget reuse: no duplicate cards across features, shared moved to app_shared/
16. Forms: FormMixin + validateAndScroll() + ArabicNumbersFormatter + .toEnglishNumbers()
17. Controllers/subscriptions disposed | No print()/debugPrint() in final code
18. DI: @injectable + injector<T>() | Access modifiers: private _ for internal
19. Mock data: if UI_AND_API → `executeMockOrAsync` in cubit + mock file in `core/config/mocks/` (UI_ONLY features skip — no cubits)
20. Pre-delivery checklist from `feature-development` skill PHASE 7 — all items passed
21. Run `/post-feature-review` skill — fix any critical/high issues found
