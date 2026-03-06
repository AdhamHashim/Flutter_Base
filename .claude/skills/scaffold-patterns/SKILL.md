# Skill: Scaffold & Status Bar Patterns

## When to Use

- عند إنشاء screen جديدة — لتحديد أي scaffold تستخدم.
- عند ملاحظة status bar مش متوافق مع header الشاشة.
- عند وجود custom header container في body widget بدل `DefaultScaffold`.

## What to Do

> **See `scaffold-statusbar.mdc` for the full rules and code examples.**

### Quick Decision:
- **Inner screen** (list, detail, sub-page) → `DefaultScaffold` (handles header + status bar)
- **Auth screen** (login, register, verify) → plain `Scaffold` + `SafeArea` + manual status bar
- **Home screen** (bottom nav) → custom `Scaffold` + `CustomNavigationBar` + manual status bar

### Common Mistakes to Fix:
- ❌ Custom `_buildHeader()` method in body widget → use `DefaultScaffold`
- ❌ Missing status bar color on auth/home screens → add `Helpers.changeStatusbarColor()` in initState
- ❌ Dark icons on dark header (or light icons on white) → match brightness to background

## Output

- أي screens تم تصحيح scaffold usage فيها.
- أي status bar mismatches تم إصلاحها.
