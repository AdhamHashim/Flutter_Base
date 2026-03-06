# ايه اللي اتعمل

## 1. Cursor Skill — .claude/skills/figma-task-extractor/SKILL.md

ده الـ skill اللي بيعرّفني (الـ AI) ازاي أنفذ العملية كاملة. لما تقولي "extract tasks from Figma" او "جهزلي التاسكات"، هتبع الـ skill ده اوتوماتيك.

## 2. Python Script — scripts/generate_figma_tasks.py

ده الـ automation script اللي بيعمل كل حاجة في أمر واحد:

```bash
# Setup (مرة واحدة بس)
export FIGMA_ACCESS_TOKEN="figd_your_token_here"

# Run (لأي مشروع)
python3 scripts/generate_figma_tasks.py "https://figma.com/design/ABC123/MyApp"
```

اللي بيعمله:

- ياخد لينك الـ Figma الكامل
- يتصل بـ Figma API ويجيب كل الـ pages والـ frames
- يفلتر الـ screens الحقيقية (يشيل الـ components, icons, design system)
- يجمّع الـ states لنفس الـ screen (مثلاً Login + Login Error + Login Loading = task واحد)
- يولّد ملف task لكل screen في .cursor/prompt/tasks/{feature_name}.md
- يولّد master schedule في .cursor/prompt/tasks/_schedule.md

## 3. Task Files Structure

```
.cursor/prompt/tasks/
├── _schedule.md           ← جدول كل التاسكات + الترتيب + حالة التنفيذ
├── login.md               ← تاسك Login (feature_prompt.md معدل)
├── register.md            ← تاسك Register
├── home.md                ← تاسك Home
├── product_details.md     ← تاسك Product Details
└── ...
```

---

# طريقتين للاستخدام

## الطريقة 1: Script (أسرع — مرة واحدة)

```bash
# 1. هات الـ token من Figma (Settings → Account → Personal access tokens)
export FIGMA_ACCESS_TOKEN="figd_xxx"

# 2. شغّل
python3 scripts/generate_figma_tasks.py "https://figma.com/design/ABC123/MyApp"

# 3. راجع _schedule.md واضف الـ Postman URLs
# 4. قولي "نفذ التاسك الأول"
```

## الطريقة 2: Chat-based (بدون token — من خلال MCP)

ابعتلي لينك الـ Figma وقولي "جهزلي التاسكات" → هستخدم Figma MCP مباشرة عشان أعمل نفس الحاجة من جوا الـ chat.

---

# بعد التوليد — خطوات التنفيذ

- تراجع الـ _schedule.md — تعدل الترتيب لو عاوز
- تضيف الـ Postman URLs في كل ملف task (لو في API)
- تملا الـ Navigation Map (مين بيروح لمين)
- تقولي "نفذ التاسك الأول" → هنفذ task بـ task بالترتيب
- كل task يخلص → الـ schedule يتحدث + الـ navigation يترابط

---

# Setup لمرة واحدة

محتاج بس تعمل Figma Personal Access Token:

1. روح Figma → Settings → Account → Personal access tokens
2. اعمل token جديد
3. حطه في environment variable: export FIGMA_ACCESS_TOKEN="figd_xxx"

هل تحب تجرب دلوقتي بلينك Figma حقيقي؟
