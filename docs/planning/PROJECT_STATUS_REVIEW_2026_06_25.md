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

The project is no longer blocked by missing planning or validation requirements for the current slice. The full two-helper blind validation requirement and solo evidence replacement are skipped; the current prototype is considered good enough to move forward.

First informal validation signal: testers were able to scan the first item, but did not understand what to do after that. The former #37 checklist and #53 solo evidence pass are no longer required gates, but this evidence is enough to keep objective-clarity follow-up work at the front of the queue.

## Roadmap Decision

The active milestone should move from implementation prep to:

**First-Scan Clarity And Progression Expansion**

Meaning:

- Do not mark the current progression/readability slice complete from code inspection alone.
- Resolve #51 so the known post-scan confusion is addressed.
- Proceed into planned progression and tool work after #51.
- If testers are available later, use facilitator summaries as bonus evidence and create issues from concrete observations, but do not block roadmap progress on them.
- Turn observed confusion, boredom, unreadable route cues, scanner misses, banking misunderstandings, or predator unfairness into concrete follow-up issues.
- #50 is no longer blocked by validation evidence.

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

1. Resolve #51 so a successful first scan clearly points to the next action.
2. Decide whether to implement `Signal Lens I`, `Cargo Rack I`, or #50 next.
3. Create focused issues for the selected progression addition.

### Progression Candidates

1. Create and implement `Signal Lens I` if scanner usefulness needs the next progression reward.
2. Create and implement `Cargo Rack I` if cargo tension is understood and an extra slot would improve route choices.
3. Implement #50 if Burst Thruster is the right next non-lethal tool.

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
