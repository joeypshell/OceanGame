# OceanGame

OceanGame is a 2D underwater roguelite prototype about short, seeded alien-ocean expeditions. You pilot a small research sub, gather resources, scan useful discoveries, avoid predators, extract safely, and use persistent knowledge and upgrades to reach deeper opportunities.

## Current Prototype

The current build is a Godot 4.7 side-view vertical dive slice. It includes a surface boat/lab, oxygen pressure, extraction and failure, seeded starter resource and predator-route placement, practical scanning, two upgrades, persistent prototype save data, a pressure-locked wreck opportunity, debug-gated telemetry, deterministic logic tests, and one route-control predator.

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

The active milestone is `Blind Validation Gate`: run the current prototype with unfamiliar players before adding more mechanics. `Signal Lens I`, `Cargo Rack I`, and `Burst Thruster` are planned candidates, but the next implementation choice should come from #37 validation evidence.

## Project Docs

- `docs/current/ROADMAP.md`: active milestone, issue order, success gates, deferred scope.
- `docs/current/GAMEPLAY.md`: implemented behavior.
- `docs/current/TOOLING.md`: implemented tooling and MCP support.
- `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`: current project-wide audit and next-decision summary.
- `docs/planning/BLIND_VALIDATION_KIT.md`: facilitator kit for #37 unfamiliar-player validation.
- `docs/planning/GAME_VISION.md`: compact design anchor.
- `docs/planning/CORE_LOOP_RULES.md`: core loop and system rules.
- `docs/planning/DAILY_RUNS.md`: seeded expedition guidance.
- `docs/planning/PROGRESSION_LADDER.md`: first progression steps.
- `docs/planning/PREDATOR_INTERACTION_DIRECTION.md`: predator interaction direction.
- `docs/planning/SCANNER_IMPROVEMENT_I.md`: `Signal Lens I` plan.
- `docs/planning/CARGO_IMPROVEMENT_I.md`: `Cargo Rack I` plan.
- `docs/planning/BURST_THRUSTER_MILESTONE.md`: future non-lethal active-tool plan.
