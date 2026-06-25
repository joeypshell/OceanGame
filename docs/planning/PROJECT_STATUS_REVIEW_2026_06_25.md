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
- `Signal Lens I`,
- `Cargo Rack I`,
- one route-control predator,
- prototype `Burst Thruster`,
- debug-gated telemetry,
- deterministic logic tests,
- MCP context tooling,
- blind-validation kit.
- first `Shell Reef` biome pocket, compact surface views, route-objective fallback, clarified pressure-lock readability, first visual-language/readability assets, optional Godot AI MCP policy, and replenished Thermal Vent/Decoy Pulse issue queue.

The project is no longer blocked by missing planning or validation requirements for the current slice. The full two-helper blind validation requirement and solo evidence replacement are skipped; the current prototype is considered good enough to move forward.

The first informal validation signal has been addressed: first-time scan feedback now gives post-scan next steps. The prototype also now includes `Burst Thruster` as a non-lethal oxygen-spending movement tool.

## Roadmap Decision

The active milestone should move to:

**Thermal Vent And Predator Countermeasure**

Meaning:

- Treat scanner/cargo progression, monster-observation foundation, Shell Reef, Predator Warning, first visual-readability assets, and optional Godot AI MCP policy as completed milestone work.
- Use #92-#101 as the replenished active issue queue.
- Add the planned `Thermal Vent Pocket` before broader biome systems.
- Add `Decoy Pulse I` as the first narrow predator countermeasure after `Predator Warning I`.
- Keep predator progression non-lethal and observation-first.
- Keep a rolling backlog of about 10 open actionable issues so Codex can continue without repeated replanning stops.
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
- `Signal Lens I`.
- `Cargo Rack I`.
- `Predator Warning I`.
- Prototype `Burst Thruster`.
- `Gulper Eel` observation scan.
- `Shell Reef` biome pocket, scan clue, authored spawn candidates, route-review checklist, and route-objective fallback.
- Compact surface result/upgrade/log views.
- Active issues #76-#84 for the predator-warning and route-tuning batch.
- Active issues #86-#90 for the first visual language and readability-assets batch.

### Workflow

- Issue-driven workflow docs.
- MCP context server.
- Blind validation kit.
- Current gameplay/source-of-truth docs.

## What Still Needs Doing

### Immediate

1. Resolve #92 `Add Thermal Vent pocket route variation`.
2. Resolve #93 `Add Thermal Vent pocket scan/result clarity pass`.
3. Resolve #94 `Add typed Thermal Vent pocket placement candidates`.
4. Resolve #95 `Run Thermal Vent pocket five-seed route review`.
5. Resolve #96 `Tune Thermal Vent pocket readability after route review`.
6. Resolve #97 `Add Decoy Pulse I upgrade definition and purchase gate`.
7. Resolve #98 `Implement Decoy Pulse I predator distraction behavior`.
8. Resolve #99 `Add Decoy Pulse I feedback, cooldown, and HUD status`.
9. Resolve #100 `Add Decoy Pulse I tests and docs coverage`.
10. Resolve #101 `Update MCP context and roadmap after vent and decoy planning batch`.

### Progression Candidates

1. Thermal Vent pocket implementation and five-seed review.
2. Thermal Vent pocket readability tuning.
3. Decoy Pulse I upgrade gate.
4. Decoy Pulse I non-lethal predator distraction behavior.
5. Decoy Pulse I HUD/status feedback and test/docs coverage.
6. MCP planning-context refresh after the new batch creates docs or implemented behavior.

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
- `docs/planning/MONSTER_OBSERVATION_I.md`
- `docs/planning/PREDATOR_WARNING_I.md`
- `docs/planning/BIOME_POCKET_I.md`
- `docs/planning/EXPEDITION_GOAL_II.md`
- `docs/planning/SHELL_REEF_ROUTE_REVIEW.md`
- `docs/planning/SURFACE_UI_LAYOUT_PASS.md`
- `docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md`
- `docs/planning/BACKLOG_REPLENISHMENT_AFTER_SHELL_REEF_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_THERMAL_VENT_DECOY_2026_06_25.md`
- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/PROGRESSION_LADDER.md`

## Planning Docs That Are Historical Context

- `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`
- `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`
- `docs/planning/OXYGEN_MARGIN_TUNING_2026_06_25.md`

These are still useful, but the status in this review supersedes their "next work" ordering.
