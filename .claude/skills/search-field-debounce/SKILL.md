# Skill: Search Field with Debounce

## When to Use

- عند وجود search bar في أي شاشة (header search, filter search, etc.).
- عند ملاحظة fake search bar (static Container + Text بدل TextField حقيقي).

## What to Do

> **See `search-field-debounce.mdc` for full implementation pattern and code.**

### Quick Rules:
1. Search MUST be real `DefaultTextField` — never a static Container with Text
2. Use `rxdart` `PublishSubject` + `debounceTime(500ms)` + `.distinct()`
3. Screen MUST be `StatefulWidget` for controller + subscription lifecycle
4. Dispose: `_searchController.dispose()`, `_searchSubscription.cancel()`, `_searchSubject.close()`
5. For `PaginatedCubit` → add `search()` method that calls `fetchInitialData()`
6. For `AsyncCubit` → add `search` parameter to `fetchItems()`

## Output

- أي search bars تم تحويلها من fake لـ real TextField.
- أي debounce patterns تم إضافتها أو إصلاحها.
