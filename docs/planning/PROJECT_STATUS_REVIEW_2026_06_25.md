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
- first `Shell Reef` biome pocket, compact surface views, route-objective fallback, clarified pressure-lock readability, and replenished post-Shell-Reef issue queues.

The project is no longer blocked by missing planning or validation requirements for the current slice. The full two-helper blind validation requirement and solo evidence replacement are skipped; the current prototype is considered good enough to move forward.

The first informal validation signal has been addressed: first-time scan feedback now gives post-scan next steps. The prototype also now includes `Burst Thruster` as a non-lethal oxygen-spending movement tool.

## Roadmap Decision

The active milestone should move to:

**Predator Warning And Route Tuning**

Meaning:

- Treat scanner/cargo progression as completed milestone work.
- Treat #59/#60 as completed monster-observation foundation work.
- Treat #65-#74 as completed Shell Reef/readability/replenishment work.
- Use #75-#84 as the replenished active issue queue.
- Add `Predator Warning I` before broader predator countermeasures.
- Review and tune the authored `Shell Reef` pocket before expanding into broader biome systems.
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
- Prototype `Burst Thruster`.
- `Gulper Eel` observation scan.
- `Shell Reef` biome pocket, scan clue, authored spawn candidates, route-review checklist, and route-objective fallback.
- Compact surface result/upgrade/log views.
- Active issues #75-#84 for the predator-warning and route-tuning batch.
- Active issues #86-#90 for the first visual language and readability-assets batch.

### Workflow

- Issue-driven workflow docs.
- MCP context server.
- Blind validation kit.
- Current gameplay/source-of-truth docs.

## What Still Needs Doing

### Immediate

1. Resolve #75 `Add Predator Warning I upgrade`.
2. Resolve #76 `Add Predator Warning I upgrade tests and metadata coverage`.
3. Resolve #77 `Run Shell Reef five-seed route review`.
4. Resolve #78 `Tune Shell Reef return readability after route review`.
5. Resolve #79 `Tune deep-reward lure relative to Shell Reef route`.
6. Resolve #80 `Plan Biome Pocket II candidate`.
7. Resolve #81 `Plan first resource economy tuning pass`.
8. Resolve #82 `Add route-choice result callout`.
9. Resolve #83 `Update MCP context server with latest planning docs`.
10. Resolve #84 `Plan Predator Countermeasure I after warning upgrade`.
11. Resolve #86 `Create first visual language guide`.
12. Resolve #87 `Extract reusable pressure gate, current hint, and signal hint prototypes`.
13. Resolve #88 `Standardize current and route-hint visuals`.
14. Resolve #89 `Standardize scan target marker readability`.
15. Resolve #90 `Run first depth-band and landmark readability asset pass`.

### Progression Candidates

1. `Predator Warning I` implementation.
2. Shell Reef route review and narrow tuning.
3. Biome Pocket II planning.
4. First resource economy tuning.
5. Route-choice result feedback.
6. MCP planning-context refresh.
7. Predator Countermeasure I planning after warning upgrade.
8. Visual language guide and reusable readability assets before final art production.

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
- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/PROGRESSION_LADDER.md`

## Planning Docs That Are Historical Context

- `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`
- `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`
- `docs/planning/OXYGEN_MARGIN_TUNING_2026_06_25.md`

These are still useful, but the status in this review supersedes their "next work" ordering.
