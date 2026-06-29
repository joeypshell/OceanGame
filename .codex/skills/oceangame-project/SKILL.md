---
name: oceangame-project
description: Work effectively in the OceanGame repository by loading its project context, source-of-truth docs, layout, verification commands, GitHub issue workflow, and state ownership rules before making changes. Use for any OceanGame coding, documentation, planning, testing, or repository-maintenance task.
---

# OceanGame Project

## Startup

1. Read `AGENTS.md` first.
2. Read only the current docs relevant to the request:
   - `docs/current/ARCHITECTURE.md` for state ownership and code boundaries.
   - `docs/current/GAMEPLAY.md` for implemented player-facing behavior.
   - `docs/current/ROADMAP.md` for current priorities.
   - `docs/current/TOOLING.md` for MCP, screenshots, and verification.
   - `docs/current/PROJECT_GLOSSARY.txt` for canonical terms.
3. Check `git status --short --branch` before edits. Preserve unrelated user changes.
4. If the task is ticketed, read the GitHub issue and linked docs before editing.

## Repository Shape

- Godot 4.7 GDScript project.
- Main scene: `scenes/Main.tscn`.
- Player scene: `scenes/Player.tscn`.
- Scripts: `scripts/`.
- Deterministic tests: `tests/logic_tests.gd`.
- Playwright web visual smoke: `tests/playwright/`.
- Current-state docs: `docs/current/`.
- Planning docs: `docs/planning/`.
- Runtime art: `assets/exports/`, `assets/sprites/`.
- Editable/source art and provenance: `assets/source/`, `assets/licenses/`.

## Source-Of-Truth Rules

- `docs/current/` describes implemented behavior.
- `docs/planning/` contains proposals, reviews, and not-yet-implemented plans.
- GitHub Issues are the active task contract once a task is ticketed.
- Update the relevant current doc when gameplay, architecture, tooling, testing, deployment, or workflow behavior changes.
- Do not commit `.godot/`, `.import/`, `*.import`, `exports/`, `test-results/`, `playwright-report/`, secrets, or local editor state unless a task explicitly asks for artifact capture.

## Verification

Prefer the smallest verification set that proves the change.

Core commands from repo root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
```

For visual/browser confidence:

```powershell
npm run test:visual
```

If `node` is unavailable, use the bundled Codex Node path documented in `docs/current/TOOLING.md`.

## Close-Out

End with changed files, verification run, and any skipped checks with the exact reason.
