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
- debug-gated telemetry,
- deterministic logic tests,
- MCP context tooling,
- blind-validation kit.

The project is no longer blocked by missing planning for the current slice. It is blocked by evidence: issue #37 still needs unfamiliar players to validate whether the loop is understandable without internal explanation.

First informal validation signal: testers were able to scan the first item, but did not understand what to do after that. The full #37 checklist is not complete, but this is enough evidence to create objective-clarity follow-up work before adding larger mechanics.

## Roadmap Decision

The active milestone should move from implementation prep to:

**Blind Validation Gate**

Meaning:

- Do not mark the current progression/readability slice complete from code inspection alone.
- Run #37 with at least two unfamiliar players using `docs/planning/BLIND_VALIDATION_KIT.md`.
- If testers will not fill out forms, use facilitator summaries as partial evidence and create issues from concrete observations.
- Turn observed confusion, boredom, unreadable route cues, scanner misses, banking misunderstandings, or predator unfairness into concrete follow-up issues.
- Keep #50 blocked until #37 or equivalent predator-readability evidence exists.

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
- Plans for `Signal Lens I`, `Cargo Rack I`, and `Burst Thruster`.

### Workflow

- Issue-driven workflow docs.
- MCP context server.
- Blind validation kit.
- Current gameplay/source-of-truth docs.

## What Still Needs Doing

### Immediate

1. Complete #37 with two unfamiliar players.
2. Link raw notes and concrete follow-up issues back to #37.
3. Resolve #52 so future validation can be captured without relying on tester-filled forms.
4. Resolve #51 so a successful first scan clearly points to the next action.
5. Decide whether the current route readability, scanning, banking, and predator warning are good enough to proceed.

### Post-Validation Candidates

Only after #37 or equivalent evidence:

1. Create and implement `Signal Lens I` if scanner usefulness needs the next progression reward.
2. Create and implement `Cargo Rack I` if cargo tension is understood and an extra slot would improve route choices.
3. Unblock #50 only if predator-readability evidence says Burst Thruster is the right next non-lethal tool.

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
