---
name: oceangame-gameplay-loop
description: Design, implement, or review OceanGame gameplay-loop changes involving expeditions, oxygen, cargo, scans, upgrades, seeded routes, predators, pressure gates, result memory, and durable progression. Use when gameplay behavior or player-facing loop decisions are in scope.
---

# OceanGame Gameplay Loop

## Load First

Read:

- `AGENTS.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/ARCHITECTURE.md`
- `docs/current/PROJECT_GLOSSARY.txt`

For planned or adjacent mechanics, read only the specific linked file under `docs/planning/`.

## Core Model

OceanGame is a 2D side-view underwater roguelite prototype.

Current loop:

1. Start at the surface ready panel.
2. Begin an expedition.
3. Dive, manage oxygen, scan discoveries, collect cargo, read route risk, and avoid or time predator danger.
4. Return to the surface base before oxygen failure.
5. Bank cargo, preserve discoveries, buy upgrades, and prepare the next seeded expedition.

## Ownership Boundaries

- `DiveSession` owns current-run state: oxygen, cargo, active result, current depth, current cargo capacity, and temporary one-expedition effects.
- `ProgressionState` owns durable progress: banked resources, purchased upgrades, scan discoveries, best depth, save schema.
- Authored scene data owns persistent geography, route pockets, spawn candidates, pressure gates, and scan targets.
- Visual/readability assets communicate meaning but must not own gameplay truth.
- `scripts/main.gd` orchestrates the vertical slice; extract reusable or test-worthy logic instead of growing unrelated domain rules there.

## Gameplay Guardrails

- Do not save active oxygen, current cargo, current expedition condition, current seed telemetry, temporary highlights, surface tab selection, or selected scan target as durable progression.
- Do not add broad procedural biome generation while authored route readability is still the source of truth.
- Do not add field-guide, quest-log, map-marker, or route-graph systems for a compact clue unless a ticket explicitly promotes that clue into durable progression.
- Route future input through semantic Godot actions, not keyboard-specific gameplay checks.
- Keep upgrade effects narrow and explicit; do not let one upgrade bypass unrelated systems.
- Preserve current failure rules unless the issue explicitly changes them: oxygen failure loses carried cargo but keeps durable discoveries and banked resources.

## Verification

For logic changes, run:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
```

Also run headless launch for scene/script validity:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

Use manual smoke or Playwright visual smoke when HUD, route readability, surface panels, or route state communication changes.
