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
  Thin Godot scene script that extends the current controller/context split
  scripts/main_scene_controller.gd
  Applies remaining run setup, input, scan effects, upgrade effects, survival/night coordination, HUD updates
  scripts/main_scene_context.gd
  Owns inherited scene node references, exported tuning, constants, and run fields

        |
        +--> Current-dive state
        |      scripts/dive_session.gd
        |
        +--> Durable prototype progression
        |      scripts/progression_state.gd
        |      user://progression_save.json
        |
        +--> Chapter survival state
        |      scripts/survival_state.gd
        |      stored under survival_state in user://progression_save.json
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

Current expedition conditions are deterministic data selected from the expedition seed. Most effects remain presentation/readability-only, but a condition may apply a narrow authored weighting rule when an issue explicitly defines the target candidate set and guardrails. `Low Visibility` now strengthens the authored Dusk Trench murk cue and ready/status copy only; it does not save active condition state or change route access. `Kelp Bloom` now thickens the authored Mirror Kelp approach presentation and copy only; it does not change geography, access, oxygen, cargo, progression, save behavior, Tideglass interaction, or Mirrorfin non-combat rules. The first implemented weighting rule is `Thermal Bloom` preferring existing authored vent-pocket `Glow Plankton` candidates; it does not increase pickup count, move other resources, change predator routes, pressure locks, oxygen, cargo, movement, or upgrades.

Conditions are active-run context, not durable progression. Do not save active condition state directly; relaunch should load durable progress and prepare a fresh expedition from the current seed/session flow.

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

### Chapter Survival State

`SurvivalState` owns the Emergency Week survival pressure:

- current day and max days,
- Food, Water, and Power,
- staged oxygen penalty when a need reaches 0,
- chapter collapse when a need drops below 0,
- chapter stabilization after the week is survived.

Survival supplies may travel through `DiveSession.current_cargo` during a dive, but extraction routes them into `SurvivalState` instead of `ProgressionState.banked_resources`. This keeps survival pressure separate from upgrade resources while still making cargo space a real tradeoff.

Compact research clues, such as the first `Wreck Echo Descent` clue, begin as run result memory rather than durable progression. Promote them into `ProgressionState` only when a later issue explicitly needs persistence after relaunch, prerequisite checks, or a stable learned-state surface.

### Authored Content Data

Scene-authored content owns inspectable placement and route definitions:

- resource pickup nodes,
- typed `SpawnPoint` candidate nodes,
- creature route candidates,
- pressure gate and wreck nodes,
- the first Wreck Echo route pocket and clue trigger,
- scannable discovery nodes,
- biome-pocket landmarks.
- pocket-specific placement candidates such as Shell Reef shell candidates and Thermal Vent glow-route candidates.
- optional `SpawnPoint` condition-preference ids for bounded authored weighting.
- passive `LandmarkMetadata` nodes that describe persistent place identity without driving gameplay behavior.

When route or placement logic grows, prefer typed authored data or small resources over hidden hard-coded coordinates. Randomization and condition weighting should select among readable authored candidates rather than generate broad uninspected layouts.

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

`scripts/main.gd` is now a thin scene-script shell that extends `scripts/main_scene_controller.gd`. `scripts/main_scene_context.gd` owns the inherited scene node references, exported tuning, constants, and run fields needed by the controller and extracted services. This split keeps the Godot scene script path stable while reducing `main.gd` context load; the residual controller is now under the 500-line guardrail but remains an orchestration layer and should not become a new dumping ground.

The main scene controller coordinates the vertical slice:

- starts, extracts, fails, and restarts expeditions,
- applies resource pickup, scan, predator, pressure-lock, and upgrade effects,
- maps progression state into visible scene state,
- updates HUD and surface panels.

Keep `main.gd` thin and keep shrinking `main_scene_controller.gd` toward orchestration, not long-term ownership of every domain rule. When logic becomes reusable or test-worthy, extract it into small helper scripts or resources.

`scripts/services/survival_controller_service.gd` owns the scene-facing survival orchestration around extraction: survival supply banking, night resolution, health-recovery night copy, and the one-night Power Patch craft. `DiveLifecycleService` sequences dive extraction/failure and delegates those survival-specific rules rather than owning them directly.

`scripts/services/dive_tool_action_service.gd` owns active-dive tool actions that mutate the player and `DiveSession`, starting with Burst Thruster activation and cooldown/oxygen feedback. Input and touch adapters should call through the main scene wrapper or this service rather than reimplementing tool rules.

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

Committed asset source conventions live under `assets/`: `assets/source/` for editable source files and prompts, `assets/exports/` for runtime-ready committed art used by the Godot project, and `assets/licenses/` for attribution/provenance notes. Godot caches, `.import` metadata, local screenshots, and platform builds stay out of source control.

Resource pickup gameplay nodes stay in `scenes/Main.tscn` as `Area2D` owners for definitions, collision, scan groups, spawn placement, and cargo behavior. Replaceable resource art lives in reusable child scenes under `scenes/resources/`, with `SpriteAnchor/Sprite` and `FallbackVisual` children preserving the placeholder-to-asset workflow.

Landmark readability clusters should follow the same split when they grow too large for `Main.tscn`: the placed gameplay/landmark holder can remain in the main scene while reusable visual geometry moves into `scenes/readability/`. The Thermal Vent pocket follows this pattern with `scenes/readability/ThermalVentPocketVisuals.tscn`; the scannable Thermal Vent and route reveal behavior remain separate gameplay nodes. The Pressure-Locked Research Wreck follows the same pattern with `scenes/readability/PressureWreckVisuals.tscn`; the pressure boundary, outside scan, Wreck Signal Cache, and upgrade behavior remain owned by the gameplay nodes in `Main.tscn`.

Small reusable visual helpers such as `scripts/scan_pulse_visual.gd` may centralize color/intensity language for repeated readability effects. They should remain presentation-only and should not own scan targeting, cargo, progression, or map state.

## State-Management Guardrails

- Do not let visual effects mutate durable progression directly.
- Do not bank survival supplies as upgrade resources.
- Do not save active oxygen, active cargo, temporary highlights, selected scan target, current seed telemetry, or surface tab selection as progression.
- Do not make HUD labels the only source of route meaning; important route states should have visible scene language.
- Do not add a parallel objective/quest state system while the expedition prep goal formatter is enough.
- Do not create a broad field guide, quest log, route graph, or map marker to persist one compact research clue before result-only memory has been tested.
- Do not add broad procedural biome generation until authored route decisions are readable and testable.
- Do not couple gameplay rules to keyboard-specific checks. Player-facing input should route through semantic Godot actions. The first-pass mobile/web touch overlay injects those same actions, and future controller support should do the same without changing dive, scan, cargo, predator, pressure, or progression rules.

## Future Platform/Input Direction

Mobile and coarse-touch web controls now exist as a first-pass input adapter layered over the main scene. They do not own gameplay state; they emit semantic press/release requests into `main.gd`, which owns held scan timing and gameplay effects. Desktop browsers keep the overlay hidden even when the hardware reports incidental touch points, unless a mobile/coarse pointer is the primary input. Full landscape mobile packaging, safe-area/layout tuning, and controller support remain future work. See `docs/planning/FUTURE_PLATFORM_INPUT_TARGETS_2026_06_26.md`.

## Testing And Verification

Architecture-sensitive changes should be covered by the existing verification shape:

- Godot headless launch for scene/script validity,
- deterministic logic tests for reusable state and formatter behavior,
- `git diff --check`,
- manual smoke for visual readability, route comprehension, and player-facing flow.

When a gameplay, runtime, tooling, or architecture decision changes, update this file or the matching `docs/current/` source-of-truth document before closing the issue.
