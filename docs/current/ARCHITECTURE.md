# Current Architecture

OceanGame is a Godot 4.7 project for a 2D side-view underwater roguelite. The current architecture should keep gameplay truth, authored content, durable progression, and visual readability separate enough that the prototype can grow without turning every scene edit into a state-management problem.

## Runtime Shape

```text
Godot Main Scene
  Authored ocean slice
  Player submersible
  Resource pickups
  Scannable discoveries
  Predator route
  Pressure-locked route
  HUD and surface panels

        |
        v

Scene orchestration
  scripts/main.gd
  Applies run setup, input, scan effects, upgrade effects, HUD updates

        |
        +--> Current-dive state
        |      scripts/dive_session.gd
        |
        +--> Durable prototype progression
        |      scripts/progression_state.gd
        |      user://progression_save.json
        |
        +--> Data/helpers
               resource definitions
               upgrade definitions
               expedition conditions
               spawn points
               scan target resolver
               spawn selection
```

## Ownership Rules

### Hybrid Ocean State Model

The current architectural direction is persistent geography with seeded expedition variation. See `docs/planning/HYBRID_OCEAN_MODEL.md` for the planning model.

Persistent geography is authored and inspectable:

- surface base location,
- named landmarks and route pockets,
- depth-band identities,
- major pressure gates and wreck promises,
- safe return orientation,
- upgrade-locked route locations.

Seeded expedition variation is temporary and selected from authored candidates:

- starter resource positions,
- creature route candidates,
- route/reward cluster patterns,
- future expedition-day conditions such as currents, visibility, migrations, blooms, and rare signals.

Current expedition conditions are presentation-only deterministic data selected from the expedition seed. They may be shown to the player as briefing context, but they must not change resource placement, predator routes, pressure locks, oxygen, cargo, or upgrades until a future issue explicitly adds a mechanical effect.

Do not let seeded variation erase persistent place memory. Broad procedural biome generation remains deferred until the authored route decisions are readable and testable.

### Current-Dive State

`DiveSession` owns temporary run state:

- oxygen,
- current cargo,
- current depth,
- cargo capacity for this run,
- whether the player has left base,
- whether the one-use `Decoy Pulse I` countermeasure has been spent this expedition,
- active result state.

This state is reset between expeditions and should not be saved as durable progress.

### Durable Progression State

`ProgressionState` owns player progress that survives extraction, failure, and relaunch:

- banked resources,
- purchased upgrades,
- scan discoveries,
- best depth reached,
- current save schema version.

Progression state should be updated only through explicit progression events such as extraction, scan completion, upgrade purchase, best-depth recording, and save/load migration.

### Authored Content Data

Scene-authored content owns inspectable placement and route definitions:

- resource pickup nodes,
- typed `SpawnPoint` candidate nodes,
- creature route candidates,
- pressure gate and wreck nodes,
- scannable discovery nodes,
- biome-pocket landmarks.
- pocket-specific placement candidates such as Shell Reef shell candidates and Thermal Vent glow-route candidates.

When route or placement logic grows, prefer typed authored data or small resources over hidden hard-coded coordinates. Randomization should select among readable authored candidates rather than generate broad uninspected layouts.

### Visual And Readability Assets

Visual/readability assets communicate meaning but do not own gameplay truth:

- pressure gates,
- current hints,
- future signal hints,
- scan markers,
- predator warning shapes,
- safe-return beacons,
- biome landmarks.

They may be Godot scenes, named node groups, reusable scripts, resources, or simple polygons during the prototype. They should be easy to replace later with final art without changing gameplay state.

### Scene Orchestration

`scripts/main.gd` coordinates the vertical slice:

- starts, extracts, fails, and restarts expeditions,
- applies resource pickup, scan, predator, pressure-lock, and upgrade effects,
- maps progression state into visible scene state,
- updates HUD and surface panels.

Keep `main.gd` as orchestration, not as the long-term owner of every domain rule. When logic becomes reusable or test-worthy, extract it into small helper scripts or resources.

## Asset Pipeline Direction

OceanGame should adopt a two-stage asset process:

1. Prototype readability assets:
   - simple, reusable, meaning-first visuals;
   - tied to route comprehension and player decisions;
   - verified by manual smoke and issue-specific observations.

2. Production art assets:
   - richer sprites, animation, lighting, audio, and polish;
   - only after the visual language is stable enough that final art is not chasing changing mechanics.

Final art should replace readable prototypes, not redefine the gameplay state model.

## State-Management Guardrails

- Do not let visual effects mutate durable progression directly.
- Do not save active oxygen, active cargo, temporary highlights, selected scan target, current seed telemetry, or surface tab selection as progression.
- Do not make HUD labels the only source of route meaning; important route states should have visible scene language.
- Do not add a parallel objective/quest state system while the expedition prep goal formatter is enough.
- Do not add broad procedural biome generation until authored route decisions are readable and testable.

## Testing And Verification

Architecture-sensitive changes should be covered by the existing verification shape:

- Godot headless launch for scene/script validity,
- deterministic logic tests for reusable state and formatter behavior,
- `git diff --check`,
- manual smoke for visual readability, route comprehension, and player-facing flow.

When a gameplay, runtime, tooling, or architecture decision changes, update this file or the matching `docs/current/` source-of-truth document before closing the issue.
