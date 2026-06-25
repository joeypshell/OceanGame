# Project Status Review - 2026-06-25

## Current Assessment

OceanGame now has a coherent first playable prototype loop:

- side-view surface-to-depth expedition structure,
- oxygen pressure and extraction/failure results,
- carried versus banked resource distinction,
- seeded resource placement and route variation,
- practical scanning,
- deterministic scan targeting,
- `Oxygen Tank I`,
- `Pressure Seal I`,
- pressure-locked wreck payoff,
- one route-control predator,
- prototype `Burst Thruster`,
- debug-gated telemetry,
- deterministic logic tests,
- MCP context tooling,
- blind-validation kit.

The project is no longer blocked by missing planning or validation requirements for the current slice. The full two-helper blind validation requirement and solo evidence replacement are skipped; the current prototype is considered good enough to move forward.

The first informal validation signal has been addressed: first-time scan feedback now gives post-scan next steps. The prototype also now includes `Burst Thruster` as a non-lethal oxygen-spending movement tool.

## Roadmap Decision

The active milestone should move to:

**Scanner And Cargo Progression**

Meaning:

- Treat #51 and #50 as completed milestone work.
- Implement #54 `Signal Lens I` so `Wreck Signal Cache` becomes a practical scanner reward.
- Implement #55 `Cargo Rack I` as the first simple cargo-capacity upgrade.
- If testers are available later, use facilitator summaries as bonus evidence and create issues from concrete observations, but do not block roadmap progress on them.
- Turn observed confusion, boredom, unreadable route cues, scanner misses, banking misunderstandings, or predator unfairness into concrete follow-up issues.
- Avoid broadening this milestone into a field guide, minimap, cargo grid, protected cargo, new active-tool suite, or weapons.

## What Is Done

### Runtime Foundation

- Godot 4.7 project scaffold.
- Local desktop target with optional web demo compatibility.
- Main side-view ocean scene.
- Player movement, camera, depth bounds, and surface base.
- Headless launch and deterministic logic tests.

### Expedition Loop

- Start/result panels.
- Oxygen drain, low/critical oxygen feedback, extraction, oxygen failure.
- Carried cargo, banked resources, persistent discoveries, upgrades, best depth.
- Single local prototype save slot with schema versioning and migration behavior.
- Debug telemetry hidden by default, available with F3.

### Seeded Variety

- Deterministic expedition seeds.
- Resource cluster patterns.
- Authored spawn-point selection.
- Seeded `Gulper Eel` route selection.
- Deep-reward visual lure.
- Route readability and atmosphere pass.

### Progression

- `Oxygen Tank I`.
- Practical resource scan outcomes.
- Pressure-locked wreck.
- `Pressure Seal I`.
- `Wreck Signal Cache`.
- Prototype `Burst Thruster`.
- Plans and active issues for `Signal Lens I` and `Cargo Rack I`.

### Workflow

- Issue-driven workflow docs.
- MCP context server.
- Blind validation kit.
- Current gameplay/source-of-truth docs.

## What Still Needs Doing

### Immediate

1. Resolve #54 `Signal Lens I` resource direction pulse.
2. Resolve #55 `Cargo Rack I` fourth cargo slot upgrade.
3. Re-evaluate whether the next milestone should emphasize predator observation, monster-hunting setup, a new biome pocket, or a richer surface upgrade/result loop.

### Progression Candidates

1. #54 `Signal Lens I` resource direction pulse.
2. #55 `Cargo Rack I` fourth cargo slot upgrade.
3. New milestone planning after #54/#55 are complete.

### Deferred

- Full field guide.
- Multiple active tools.
- Weapons or predator harvesting.
- Full procedural biomes.
- Large crafting economy.
- Inventory grid or stack management.
- Base management systems.
- Polished art and sound before the current loop is validated.

## Planning Docs To Treat As Current

- `docs/current/ROADMAP.md`
- `docs/current/GAMEPLAY.md`
- `docs/planning/BLIND_VALIDATION_KIT.md`
- `docs/planning/SCANNER_IMPROVEMENT_I.md`
- `docs/planning/CARGO_IMPROVEMENT_I.md`
- `docs/planning/BURST_THRUSTER_MILESTONE.md`
- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/PROGRESSION_LADDER.md`

## Planning Docs That Are Historical Context

- `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`
- `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`
- `docs/planning/OXYGEN_MARGIN_TUNING_2026_06_25.md`

These are still useful, but the status in this review supersedes their "next work" ordering.
