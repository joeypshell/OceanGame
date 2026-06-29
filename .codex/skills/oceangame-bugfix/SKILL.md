---
name: oceangame-bugfix
description: Diagnose and fix OceanGame bugs by reproducing the issue, checking Godot logs/tests, preserving unrelated changes, applying the smallest correct fix, and verifying with focused Godot, logic, visual, or documentation checks. Use for runtime errors, failing tests, gameplay regressions, UI layout bugs, save/progression bugs, and visual-readability regressions.
---

# OceanGame Bugfix

## Triage

1. Read `AGENTS.md`.
2. Check `git status --short --branch` and preserve unrelated changes.
3. Identify the failing surface:
   - runtime or scene load,
   - deterministic logic,
   - gameplay behavior,
   - save/progression,
   - HUD/UI layout,
   - art/readability,
   - tooling/export.
4. Read the relevant current docs before editing.
5. Reproduce with the narrowest command or manual path available.

## Common Commands

Scene/script load:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

Deterministic logic:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
```

Tooling docs/MCP:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
```

Visual/export:

```powershell
npm run test:visual
```

Whitespace:

```powershell
git diff --check
```

## Fix Rules

- Fix the smallest root cause that satisfies the issue.
- Add or update tests when the bug is in reusable logic, state migration, upgrade gates, spawn selection, scan targeting, or progression.
- For scene/UI bugs, prefer existing scene structure and reusable visual helpers.
- Do not introduce new systems to fix one symptom unless the current pattern cannot support the behavior.
- Keep documentation updates scoped to behavior that actually changed.

## Close-Out

Report:

- cause,
- changed files,
- verification run,
- residual risk or skipped checks.
