# OceanGame

OceanGame is a 2D alien-ocean survival expedition roguelite prototype. You pilot a small research sub, gather survival supplies and resources, scan useful discoveries, avoid predators, extract safely, and use persistent knowledge and upgrades to keep the base alive long enough to reach deeper opportunities.

## Current Prototype

The current build is a Godot 4.7 side-view expedition slice. It includes a surface boat/lab, oxygen pressure, extraction and failure, a first Emergency Week survival state, seeded resource and route variation, practical scanning, persistent prototype save data, several narrow upgrades, a growing authored Area 01 route, debug-gated telemetry, deterministic logic tests, and repeatable web/Playwright visual-smoke support.

## Controls

- Move: WASD or arrow keys
- Interact / start / extract: E or Enter
- Scan: F
- Restart after result: R
- Toggle development telemetry: F3

## Run Locally

From the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64.exe" --path .
```

Headless smoke check:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
git diff --check
```

MCP context server self-test:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
```

## Current Milestone

The active milestone is `Survival Expedition Loop Prototype`. Route/content expansion is paused while the core day loop becomes playable: start a day with survival needs and an ocean condition, dive for supplies/cargo/knowledge, extract or fail, resolve the night, and either advance the Emergency Week or collapse and restart it.

## Project Docs

- `docs/current/ROADMAP.md`: active milestone, issue order, success gates, deferred scope.
- `docs/current/GAMEPLAY.md`: implemented behavior.
- `docs/current/TOOLING.md`: implemented tooling and MCP support.
- `docs/current/PROJECT_INDEX.md`: index of active docs, planning anchors, and historical roadmap archive.
- `docs/archive/ROADMAP_HISTORY_2026_06_27.md`: historical roadmap and issue-batch record from before roadmap compaction.
- `docs/planning/AREA_01_READABILITY_RESCUE_2026_06_27.md`: active readability milestone plan.
- `docs/planning/AREA_01_READABILITY_EVIDENCE_2026_06_27.md`: current readability evidence and next-work decision.
- `docs/planning/GAME_VISION.md`: compact design anchor.
- `docs/planning/CORE_LOOP_RULES.md`: core loop and system rules.
- `docs/planning/DAILY_RUNS.md`: seeded expedition guidance.
- `docs/planning/PROGRESSION_LADDER.md`: first progression steps.
- `docs/planning/PREDATOR_INTERACTION_DIRECTION.md`: predator interaction direction.
