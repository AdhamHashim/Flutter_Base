# Cursor Paste-able Prompts

Files in this folder are **auto-generated** by `scripts/sync-cursor.sh` from canonical
skills under `.claude/skills/`. They exist so Cursor users can paste a workflow prompt
directly into chat (or `@`-reference it) instead of relying on auto-attach rules.

## Available prompts

| File | Purpose |
|------|---------|
| `feature_prompt.md` | Orchestrate building a feature from Figma → working screen. Fill the inputs (feature name, Figma URL, mode) before pasting. |

## How to use in Cursor

1. Open Cursor's chat (Cmd/Ctrl+L).
2. Type `@` and pick the prompt file (e.g. `feature_prompt.md`).
3. Replace any `[PLACEHOLDERS]` (FEATURE_NAME, FIGMA_URL, etc.) with real values.
4. Send.

## Editing rules

**Never edit these files directly.** Edit the canonical `.claude/skills/<name>/SKILL.md`
and run `bash scripts/sync-cursor.sh` (or commit — the pre-commit hook handles it).
