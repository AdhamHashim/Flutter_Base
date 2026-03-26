# كيف تستخدم المشروع مع Claude Code و Cursor (2026)

> آخر تحديث: مارس 2026

---

## Claude Code

### المفاهيم الأساسية (2026)

Claude Code بقى **منصة Agent كاملة** مش مجرد أداة كود. دلوقتي فيه 5 أنظمة أساسية:

| النظام | الوصف | الملف/المكان |
|--------|-------|--------------|
| **CLAUDE.md** | تعليمات ثابتة بيقرأها Claude تلقائياً في كل محادثة | `CLAUDE.md` في root المشروع |
| **Skills** | ملفات Markdown بتعلم Claude workflows معينة — بتتشغل كـ slash commands | `.claude/skills/*/SKILL.md` |
| **Hooks** | أوامر بتتنفذ تلقائياً في أوقات معينة (قبل/بعد كل أداة، بداية/نهاية المحادثة) | `.claude/settings.json` |
| **Subagents** | agents فرعية بتشتغل بشكل مستقل بأدوات وصلاحيات محددة | `.claude/agents/*.md` |
| **MCP Servers** | ربط Claude بأدوات خارجية (Figma, Postman, Sentry, Slack, etc.) | `.claude/settings.json` |

### CLAUDE.md — الملف الأساسي

الملف الأهم في المشروع. Claude Code بيقرأه **تلقائياً** أول كل محادثة.

**إيه اللي فيه:**
- ملخص المشروع والتكنولوجيا المستخدمة
- أوامر التشغيل (`flutter run`, `build_runner`, etc.)
- قواعد الـ Architecture (Clean Architecture + BLoC)
- قواعد RTL والعربي
- قواعد API والـ Mock Data
- قواعد Clean Code والتسمية
- قائمة الـ Skills والـ Rules المتاحة

**نصائح مهمة:**
- خليه مركز ومختصر — Claude بيقرأه كل مرة فـ Context Window بيتأثر
- حط القواعد الأهم في الأول
- استخدم Headers واضحة عشان Claude يلاقي المعلومة بسرعة
- ممكن يكون فيه `CLAUDE.md` في subfolders للقواعد الخاصة بالمجلد ده

### بدء فيشتر جديد

اكتب في الشات:

```
/feature-prompt

Feature: [اسم الفيشتر]
Figma Node: [لينك الفيجما]
Mode: [UI_ONLY / UI_AND_API]
API Source: [EXISTING_POSTMAN / AUTO_GENERATE / NONE]
```

#### الأسئلة الـ 3 (Claude هيسألك قبل ما يبدأ):

> **سؤال 1:** "عاوز تصميم UI بس ولا UI + API مع بعض؟"
>
> - **UI Only** → شاشات بـ static data مباشرة في الـ widgets، بدون cubits، بدون API، بدون Postman
> - **UI + API** → كمّل للسؤال 2

> **سؤال 2 (لو UI + API):** "عندك Postman Collection جاهزة ولا أولّدلك الـ API؟"
>
> - **عندي Postman جاهز** → ادّيه الـ link وهو هيقرأه وينفذه
> - **ولّدلي الـ API** → هيحلل شاشات Figma ويولّد Postman Collection JSON + mock data + entities أوتوماتيك

#### الأوضاع الـ 3:

| الوضع | Cubits | API Source | MockConfig | Postman |
|-------|--------|------------|------------|--------|
| **UI Only** | لا | — | لا | لا |
| **UI + API (Existing Postman)** | نعم | Postman Collection جاهزة | نعم | جاهز — تديه الـ link |
| **UI + API (Auto Generate)** | نعم | يتولّد من Figma | نعم | يتولّد في STEP 4 |

> **الفرق بين UI Only و Mock Mode:**
> - **UI Only** = مفيش cubits أصلاً — data ثابتة في الـ widget مباشرة
> - **Mock Mode** (`--dart-define=USE_MOCK=true`) = cubits موجودة بس بتسحب من mock files بدل الـ API — ده لـ UI+API mode بس

#### أمثلة عملية:

**مثال 1 — UI Only (بدون API):**

```
/feature-prompt

Feature: الإشعارات
Figma Node: https://figma.com/design/xxx?node-id=123-456
Mode: UI_ONLY
API Source: NONE
```

**مثال 2 — UI + API (عندي Postman):**

```
/feature-prompt

Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Mode: UI_AND_API
API Source: EXISTING_POSTMAN
Postman Collection: https://www.postman.com/team-name/workspace/collection/abc123
```

**مثال 3 — UI + API (ولّدلي الـ API):**

```
/feature-prompt

Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Mode: UI_AND_API
API Source: AUTO_GENERATE
```

#### الخطوات الـ 8:

الـ skill هتتحمل تلقائي وهتمشي على كل الـ 28 skill وتبدأ الـ 8 steps:

| الخطوة | الوصف | إيه اللي بيحصل |
|--------|-------|----------------|
| **STEP 1** | تحميل القواعد | بيقرأ كل الـ 28 skill (coding-standards, bloc-patterns, rtl-arabic, etc.) |
| **STEP 2** | فحص الكود الموجود | بيقرأ `color_manager.dart` + `app_sizes.dart` + `assets.gen.dart` + `core/widgets/` + الفيشترز الموجودة — عشان يستخدم اللي موجود ومايكررش |
| **STEP 3** | قراءة Figma (MCP) | بيقرأ **كل** الشاشات: main + empty + loading + error + modals + bottom sheets. بيحول الألوان والأحجام والخطوط لـ AppColors/AppSize/FontSizeManager |
| **STEP 4** | مصدر الـ API | **يتخطى لو UI_ONLY.** لو Existing Postman → بيقرأ الـ Collection ويستخرج الـ endpoints والـ entities. لو Auto Generate → بيحلل Figma ويولّد Postman Collection JSON + entities + mock data أوتوماتيك (بينتظر موافقتك قبل التوليد) |
| **STEP 5** | (محجوز) | مدمج في STEP 4 — روح STEP 6 مباشرة |
| **STEP 6** | الخطة (تنتظر موافقتك) | بيعرضلك: هيكل الملفات، Entity fields، قائمة الـ cubits، ألوان/أحجام جديدة، locale keys، نوع الـ Scaffold، خطة CRUD |
| **STEP 7** | التنفيذ | بيكتب الكود كامل — entity + cubits + view + widgets — كل ملف في مكانه الصح |
| **STEP 8** | التحقق والمراجعة | `flutter analyze` + RTL check + فحص 21 نقطة + تشغيل `/post-feature-review` تلقائي |

بعد ما تبعت البرومبت، Claude هيسألك الأسئلة الأول، وبعدين يبدأ من STEP 1 لحد STEP 8 تلقائي.
في STEP 6 هيوقف ويستناك توافق على الخطة قبل ما يكتب أي كود.
لو Auto Generate — هيوقف كمان في STEP 4 يستناك توافق على الـ API design.

### الـ Skills المتاحة (28 skill)

اكتب `/اسم-الـskill` لتشغيل أي واحد:

**Workflow & Entry Points:**

| الأمر | الوصف |
|-------|-------|
| `/feature-prompt` | **ابدأ هنا** — برومبت الفيشتر الكامل |
| `/feature-development` | Workflow كامل 7 مراحل |
| `/post-feature-review` | مراجعة تلقائية بعد كل فيشتر |

**Architecture & Patterns:**

| الأمر | الوصف |
|-------|-------|
| `/coding-standards` | المرجع الأساسي — ألوان، أحجام، نصوص، ويدجتس |
| `/bloc-patterns` | AsyncCubit + CRUD + BlocListener + PaginatedCubit |
| `/flutter-patterns` | أنماط الويدجتس + هيكل الملفات |
| `/di-and-architecture` | DI + طبقات + Injectable |
| `/bloc-provider-scoping` | وين تحط الـ BlocProvider + قرارات الـ scoping |

**API & Data Flow:**

| الأمر | الوصف |
|-------|-------|
| `/api-pipeline` | خط أنابيب كامل: Postman → ApiConstants → Entity → Cubit → UI |
| `/api-design` | توليد Postman Collection JSON تلقائي من Figma |
| `/mock-data` | نظام التبديل بين Mock و Real API |
| `/form-api-pipeline` | خط أنابيب الفورمات: Form → ViewController → Params → API |
| `/navigation-patterns` | Go.to() + arguments + back with result |
| `/multi-screen-flow` | List/Detail/Edit/Create patterns |

**Figma & Design:**

| الأمر | الوصف |
|-------|-------|
| `/design-tokens` | تحويل Figma → Flutter tokens |
| `/figma-to-flutter` | تحويل Figma لـ Flutter بالكامل |
| `/figma-widget-mapping` | جدول شامل: عنصر Figma → Widget Flutter |
| `/figma-mcp-mapping` | ربط قيم Figma MCP بالكود |
| `/figma-task-extractor` | استخراج مهام من ملف Figma |

**RTL & Localization:**

| الأمر | الوصف |
|-------|-------|
| `/rtl-arabic` | قواعد RTL + منع الانعكاس |

**UI Patterns:**

| الأمر | الوصف |
|-------|-------|
| `/scaffold-patterns` | أنواع الـ Scaffold + Status Bar |
| `/search-field-debounce` | حقل بحث + rxdart debounce |

**Quality & Standards:**

| الأمر | الوصف |
|-------|-------|
| `/clean-code-and-refactoring` | تقسيم الويدجتس + إعادة الاستخدام |
| `/error-handling-and-resilience` | معالجة الأخطاء + retry patterns |
| `/logging-and-debugging` | لا print في الكود النهائي |
| `/performance-and-memory` | أداء + ذاكرة + dispose |
| `/pubspec-manager` | باكدجات + إعدادات المنصات |
| `/accessibility` | Tap targets + semantic labels |

### Hooks — الأوامر التلقائية (جديد 2026)

الـ Hooks أوامر أو prompts بتتنفذ **تلقائياً** في أوقات معينة أثناء شغل Claude. بتحول الـ guidelines من "نصائح" لـ "قواعد إجبارية".

**أنواع الـ Hooks:**

| النوع | الوصف |
|-------|-------|
| **Command Hook** | أمر shell بيتنفذ ويستقبل JSON عبر stdin |
| **Prompt Hook** | برومبت بيتبعت لـ Claude model للتقييم |
| **Agent Hook** | بيشغل subagent عنده أدوات (Read, Grep, Glob) للفحص العميق |

**أحداث الـ Hooks المتاحة (12 event):**

| الحدث | متى بيشتغل |
|-------|------------|
| `PreToolUse` | قبل ما Claude يستخدم أي أداة (Bash, Edit, Write, etc.) |
| `PostToolUse` | بعد ما الأداة تخلص |
| `Notification` | لما Claude يبعت notification |
| `Stop` | لما Claude يخلص الرد |
| `StopFailure` | لما المحادثة تقف بسبب خطأ API (rate limit, auth, etc.) |
| `SubagentStop` | لما subagent يخلص شغله |
| وغيرهم... | راجع الـ docs الرسمية |

**مثال: Hook يمنع حذف ملفات مهمة:**

```json
// .claude/settings.json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "check-no-delete-core.sh",
        "description": "يمنع حذف ملفات core/"
      }
    ]
  }
}
```

**مثال: Hook يشغل flutter analyze بعد كل تعديل:**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "command": "flutter analyze --no-fatal-infos",
        "description": "يحلل الكود بعد كل تعديل"
      }
    ]
  }
}
```

### Subagents — الـ Agents الفرعية (جديد 2026)

الـ Subagents هي agents مستقلة بتشتغل بأدوات وصلاحيات محددة. بتتعرف كملفات Markdown مع YAML frontmatter.

**إنشاء Subagent:**

```markdown
<!-- .claude/agents/review-agent.md -->
---
description: "Agent لمراجعة الكود"
model: claude-sonnet-4-6
tools:
  - Read
  - Grep
  - Glob
permissionMode: "bypassPermissions"
maxTurns: 10
---

# Review Agent

أنت agent متخصص في مراجعة كود Flutter.
- راجع كل ملف جديد أو معدل
- تأكد من اتباع قواعد RTL
- تأكد من استخدام LocaleKeys مش hardcoded strings
- تأكد من const على كل widget ممكن
```

**خصائص الـ Subagent:**

| الخاصية | الوصف |
|---------|-------|
| `description` | وصف مختصر للـ agent |
| `model` | الموديل المستخدم (claude-opus-4-6, claude-sonnet-4-6, etc.) |
| `tools` | الأدوات المتاحة (Read, Grep, Glob, Bash, Edit, Write) |
| `disallowedTools` | أدوات ممنوعة |
| `permissionMode` | نوع الصلاحيات |
| `mcpServers` | MCP servers متاحة للـ agent |
| `hooks` | hooks خاصة بالـ agent |
| `maxTurns` | أقصى عدد خطوات |
| `skills` | skills متاحة للـ agent |
| `memory` | ذاكرة الـ agent |
| `isolation` | تشغيل في worktree منفصل |

**تشغيل الـ Subagents:**
- من خلال `/agents` في الشات
- أو بالاسم مباشرة في المحادثة

**ملاحظة:** الـ Subagents مش بتقدر تشغل subagents تانية — مفيش recursion.

### MCP Servers — الربط بالأدوات الخارجية

المشروع مربوط بالـ MCP servers دي:

| الـ MCP | الاستخدام |
|---------|----------|
| **Figma (TalkToFigma)** | قراءة التصميمات وتحويلها لكود |
| **Postman** | قراءة الـ API collections وتوليد entities |
| **Sentry** | تتبع الأخطاء ومراقبة الأداء |

**إضافة MCP Server جديد:**

```json
// .claude/settings.json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["talk-to-figma-mcp"]
    }
  }
}
```

---

## Cursor

### المفاهيم الأساسية (2026)

Cursor دلوقتي بقى **Agent-first IDE** مع أنظمة متقدمة:

| النظام | الوصف | المكان |
|--------|-------|--------|
| **Project Rules** | قواعد خاصة بالمشروع بتتطبق تلقائياً | `.cursor/rules/*.mdc` |
| **User Rules** | قواعد شخصية بتتطبق على كل المشاريع | Settings → Rules |
| **Team Rules** | قواعد الفريق بتتدار من الـ Dashboard | Cursor Dashboard |
| **AGENTS.md** | تعريف agents مخصصة | `.cursor/agents/*.md` |
| **Skills (Commands)** | أوامر مخصصة بتتشغل في الشات | `.cursor/skills/*.md` |
| **Context (@mentions)** | تحكم في السياق اللي الـ AI بيشوفه | `@Files`, `@Docs`, `@Web`, `@Codebase` |
| **MCP Servers** | ربط بأدوات خارجية | `.cursor/mcp.json` |
| **Automations** | مهام مجدولة بتشتغل تلقائي | Cursor Dashboard |

### أنواع القواعد (Rules)

**1. Project Rules (`.cursor/rules/*.mdc`):**

القواعد دي خاصة بالمشروع وبتتطبق تلقائياً على ملفات `lib/**/*.dart`. المشروع فيه **28 rule**:

| القاعدة | الوصف |
|---------|-------|
| `flutter-base-coding-standards.mdc` | المرجع الأساسي — ألوان، أحجام، نصوص، ويدجتس |
| `flutter-feature-development.mdc` | Workflow كامل من Figma لحد التسليم |
| `feature-prompt.mdc` | برومبت الفيشتر الكامل |
| `scaffold-statusbar.mdc` | أنواع الـ Scaffold + Status Bar |
| `clean-code-and-refactoring.mdc` | تقسيم الويدجتس + إعادة الاستخدام |
| `design-tokens.mdc` | تحويل Figma → Flutter tokens |
| `figma-mcp-mapping.mdc` | ربط قيم Figma بالكود |
| `figma-to-flutter.mdc` | تحويل Figma لـ Flutter بالكامل |
| `figma-widget-mapping.mdc` | جدول عناصر Figma → Flutter widgets |
| `figma-task-extractor.mdc` | استخراج مهام من ملف Figma |
| `performance-and-memory.mdc` | أداء + ذاكرة + dispose |
| `error-handling-and-resilience.mdc` | معالجة الأخطاء + retry (**always active**) |
| `di-and-architecture.mdc` | Dependency Injection + طبقات |
| `search-field-debounce.mdc` | حقل بحث حقيقي + debounce |
| `logging-and-debugging.mdc` | لا print/debugPrint في الكود النهائي |
| `accessibility.mdc` | Tap targets + semantic labels |
| `bloc-patterns.mdc` | AsyncCubit + CRUD + BlocListener |
| `bloc-provider-scoping.mdc` | BlocProvider scoping + قرارات |
| `rtl-arabic.mdc` | قواعد RTL + منع الانعكاس |
| `post-feature-review.mdc` | مراجعة تلقائية بعد كل فيشتر (**always active**) |
| `pubspec-manager.mdc` | إدارة الباكدجات + إعدادات المنصات |
| `flutter-patterns.mdc` | أنماط الويدجتس + هيكل الملفات |
| `api-pipeline.mdc` | خط أنابيب API كامل |
| `api-design.mdc` | توليد Postman Collection |
| `mock-data.mdc` | نظام Mock/Real API |
| `form-api-pipeline.mdc` | خط أنابيب الفورمات |
| `multi-screen-flow.mdc` | List/Detail/Edit/Create patterns |
| `navigation-patterns.mdc` | Go.to() + arguments |

**2. User Rules (إعدادات شخصية):**

من `Settings → Rules` — بتتطبق على كل مشاريعك. مثال:
```
- Always write clean, well-documented code
- Use Arabic for comments in Flutter projects
- Follow RTL-first approach
```

**3. Team Rules (إعدادات الفريق — جديد 2026):**

بتتدار من Cursor Dashboard وبتتطبق على كل أعضاء الفريق تلقائياً من غير ملفات محلية.

### بدء فيشتر جديد

1. افتح الملف `.cursor/prompt/feature_prompt.md`
2. انسخ المحتوى
3. حط البيانات:
   - **Feature:** اسم الفيشتر
   - **Figma Node:** لينك الفيجما
   - **Mode:** `UI_ONLY` أو `UI_AND_API`
   - **API Source:** `EXISTING_POSTMAN` أو `AUTO_GENERATE` أو `NONE`
   - **Postman Collection:** لينك البوستمان (لو Existing فقط)
4. ابعت في شات Cursor (Agent Mode)

#### الأوضاع الـ 3 (نفس Claude Code بالظبط):

| الوضع | Cubits | API Source | MockConfig | Postman |
|-------|--------|------------|------------|--------|
| **UI Only** | لا | — | لا | لا |
| **UI + API (Existing Postman)** | نعم | Postman Collection جاهزة | نعم | جاهز — تديه الـ link |
| **UI + API (Auto Generate)** | نعم | يتولّد من Figma | نعم | يتولّد في STEP 4 |

**مثال — UI + API (Auto Generate):**

```
Feature: المحفظة
Figma Node: https://figma.com/design/AbCdEf/App?node-id=850-1234
Mode: UI_AND_API
API Source: AUTO_GENERATE
```

**مثال — UI Only:**

```
Feature: الإشعارات
Figma Node: https://figma.com/design/xxx?node-id=123-456
Mode: UI_ONLY
API Source: NONE
```

### Agent Mode (2026)

الـ Agent Mode في Cursor بقى متقدم جداً:

- **Auto Context Gathering:** الـ Agent بيجمع السياق لوحده — مش محتاج تعمل `@` لكل ملف
- **Multi-step Execution:** بيقدر ينفذ مهام متعددة الخطوات تلقائي
- **Tool Integration:** بيستخدم الأدوات المتاحة (Terminal, File Edit, MCP) تلقائي
- **Checkpoints:** بيعمل نقاط حفظ تقدر ترجع لها لو حصل مشكلة

### Context (@mentions)

تحكم في السياق اللي الـ AI بيشوفه:

| الأمر | الوصف |
|-------|-------|
| `@Files` | إضافة ملفات محددة للسياق |
| `@Folders` | إضافة مجلد كامل |
| `@Codebase` | بحث في كل الكود |
| `@Web` | بحث على الإنترنت |
| `@Docs` | الوثائق الرسمية لمكتبات معينة |
| `@Git` | معلومات الـ Git (commits, diffs, branches) |
| `@Recent` | الملفات اللي اتفتحت مؤخراً |

**نصيحة:** في Agent Mode، Cursor بيجمع السياق تلقائي. استخدم `@` بس لما عاوز تأكد إنه يشوف ملف معين.

### Automations — المهام المجدولة (جديد 2026)

الـ Automations بتخليك تبني agents بتشتغل تلقائي:
- على **جدول زمني** (كل يوم، كل أسبوع)
- أو بناءً على **حدث خارجي** (push, PR, webhook)
- بتشتغل في **cloud sandbox** منفصل
- بتقدر تستخدم MCPs وتتذكر نتائج الـ runs السابقة

### AGENTS.md — الـ Agents المخصصة (جديد 2026)

زي الـ Subagents في Claude Code، Cursor دلوقتي بيدعم agents مخصصة:

```markdown
<!-- .cursor/agents/review.md -->
---
description: "مراجعة كود Flutter"
tools: ["terminal", "file_edit", "file_read"]
---

راجع الكود وتأكد من:
- اتباع قواعد RTL
- استخدام LocaleKeys
- const على كل widget
```

---

## الفرق بين الاتنين (2026)

| | Cursor | Claude Code |
|---|--------|-------------|
| **القواعد** | `.cursor/rules/*.mdc` — تتطبق تلقائياً | `.claude/skills/*/SKILL.md` — تتشغل بـ `/اسم` |
| **الملف الأساسي** | Project Rules + User Rules | `CLAUDE.md` — يتقرأ تلقائي كل محادثة |
| **البرومبت** | انسخ `feature_prompt.md` وابعته | اكتب `/feature-prompt` |
| **Agents** | `AGENTS.md` + Automations | Subagents (`.claude/agents/*.md`) |
| **Hooks** | مفيش (القواعد بتتطبق تلقائي) | 12 event متاح (PreToolUse, PostToolUse, Stop, etc.) |
| **MCP** | `.cursor/mcp.json` | `.claude/settings.json` → `mcpServers` |
| **Context** | `@mentions` + auto-gathering | `CLAUDE.md` + Skills + Subagents |
| **Team** | Team Rules من Dashboard | CLAUDE.md مشترك في الـ repo |
| **Automations** | Cloud Agents + Scheduled Tasks | Hooks + `/loop` command |
| **Figma MCP** | متاح | متاح |
| **Postman MCP** | متاح | متاح |
| **المحتوى** | **متطابق 100%** — نفس القواعد في الاتنين | **متطابق 100%** |

---

## نصائح عامة لأفضل نتيجة

### لـ Claude Code:
1. **خلي `CLAUDE.md` مختصر ومركز** — بيتقرأ كل محادثة فـ حافظ على الـ context
2. **استخدم الـ Skills** — `/feature-prompt` هي نقطة البداية لأي فيشتر
3. **فعّل الـ Hooks** — خلي `flutter analyze` يشتغل تلقائي بعد كل تعديل
4. **استخدم Subagents** — للمهام المتكررة زي code review و testing
5. **استخدم MCP** — Figma + Postman بيوفروا وقت كبير في التحليل

### لـ Cursor:
1. **Agent Mode دايماً** — خليه يجمع السياق لوحده
2. **استخدم `@Codebase`** — لما عاوز يفهم pattern موجود في المشروع
3. **Team Rules** — لو شغال مع فريق، حط القواعد المشتركة في الـ Dashboard
4. **الـ Rules بتتطبق تلقائي** — مش محتاج تفكر فيها، هي شغالة في الخلفية
5. **Automations** — اعمل automated review أو لinting على كل PR

### لأي أداة:
1. **ابدأ بـ "UI Only or UI + API?"** — قبل أي فيشتر
2. **وفر Figma + Postman** — كل ما المعلومات أكتر، النتيجة أحسن
3. **راجع الخطة في STEP 5** — دي فرصتك تعدل قبل التنفيذ
4. **شغّل `/post-feature-review`** — بعد كل فيشتر للتأكد من الجودة

---

## مصادر ومراجع

- [Claude Code Docs](https://code.claude.com/docs/en/overview)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks)
- [Claude Code Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [Cursor Docs — Rules](https://cursor.com/docs/context/rules)
- [Cursor Docs — Agent](https://cursor.com/product)
- [Cursor Docs — Skills/Commands](https://cursor.com/docs/context/commands)
- [Cursor Changelog](https://cursor.com/changelog)