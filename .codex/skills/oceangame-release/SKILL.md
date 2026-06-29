---
name: oceangame-release
description: Prepare or verify an OceanGame release, demo build, web export, or publishable checkpoint using the repo's Godot, Playwright, documentation, git hygiene, and artifact rules. Use for release readiness, demo packaging, PR closeout, or deployment-oriented tasks.
---

# OceanGame Release

## Load First

Read:

- `AGENTS.md`
- `docs/current/TOOLING.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/ROADMAP.md`
- `export_presets.cfg` when export behavior is in scope.

## Release Readiness Checklist

1. Confirm working tree state with `git status --short --branch`.
2. Confirm current docs match implemented behavior.
3. Run core validation:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
```

4. For web/demo confidence, run:

```powershell
npm run test:visual
```

5. Inspect generated artifacts locally but do not commit `exports/`, `test-results/`, or `playwright-report/` unless the release task explicitly asks for evidence artifacts.

## Demo Smoke Focus

- Clean first-run ready state is understandable.
- Active dive starts only after player input.
- Oxygen, cargo, scan target, base return, and low-oxygen states are readable.
- Extraction, oxygen failure, upgrade bay, and recent expedition log fit their panels.
- Debug telemetry is hidden by default.
- Save reset and progression persistence behave as currently documented.

## Close-Out

Report exact validation commands, result status, build/export status, and any known release risk. If a check is skipped, state why and what risk remains.
