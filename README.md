# OceanGame

OceanGame is a 2D underwater roguelite prototype about short, seeded alien-ocean expeditions. You pilot a small research sub, gather resources, scan useful discoveries, avoid predators, extract safely, and use persistent knowledge and upgrades to reach deeper opportunities.

## Current Prototype

The current build is a Godot 4.7 side-view vertical dive slice. It includes a surface boat/lab, oxygen pressure, extraction and failure, seeded starter resource placement, scanning, one upgrade, persistent prototype save data, and one route-control predator.

## Controls

- Move: WASD or arrow keys
- Interact / start / extract: E or Enter
- Scan: F
- Restart after result: R

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

The active milestone is `Progression And Run Variety Expansion`: validate the current prototype with unfamiliar players, then add practical resource scanning, seeded risk variation, a pressure-locked research wreck, generic upgrade definitions, and `Pressure Seal I`.

## Project Docs

- `docs/current/ROADMAP.md`: active milestone, issue order, success gates, deferred scope.
- `docs/current/GAMEPLAY.md`: implemented behavior.
- `docs/current/TOOLING.md`: implemented tooling and MCP support.
- `docs/planning/GAME_VISION.md`: compact design anchor.
- `docs/planning/CORE_LOOP_RULES.md`: core loop and system rules.
- `docs/planning/DAILY_RUNS.md`: seeded expedition guidance.
- `docs/planning/PROGRESSION_LADDER.md`: first progression steps.
- `docs/planning/PREDATOR_INTERACTION_DIRECTION.md`: predator interaction direction.
