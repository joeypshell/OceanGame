# Main.gd Architecture Refactor Epic

## Goal

Reduce `scripts/main.gd` into smaller, well-named modules with stable responsibilities while preserving current player-visible behavior. The refactor should make OceanGame easier for humans and AI agents to work on by reducing oversized file context, clarifying ownership, improving reuse, and keeping deterministic tests meaningful.

## Non-goals

- No gameplay redesign.
- No route/content expansion.
- No save-format rewrite unless a child issue separately justifies it.
- No broad visual redesign.
- No large one-shot rewrite.
- No unrelated cleanup outside each issue scope.
- No public-facing rename of game concepts unless a child issue proves the need.
- No movement of code that does not reduce file size, clarify ownership, or improve testability.

## Current Findings

Checkpoint: `scripts/main.gd` has been reduced to a thin shell under the 500-line guardrail by splitting inherited scene context into `scripts/main_scene_context.gd`, residual scene orchestration into `scripts/main_scene_controller.gd`, and focused services for ready wiring, run preparation, lifecycle flow, survival/night orchestration, active-dive tool actions, route interaction/proximity, input, frame processing, scan action/runtime, scene events, surface oxygen/mobile controls, daylight, expedition slate, upgrade purchase/effects, route setup, HUD updates, and controller state helpers. `main_scene_controller.gd` is also now under 500 lines and should remain a transitional orchestration layer rather than a new dumping ground.

Before this checkpoint, `scripts/main.gd` was about 4,804 lines. It was the vertical-slice scene script, but it had grown beyond scene composition into many mixed responsibilities:

- Scene wiring and node references for nearly every authored route, pickup, marker, HUD panel, and debug staging node.
- Expedition lifecycle orchestration: start, extract, fail, restart, prepare next run, resolve night, reset local save.
- Input handling for interact, scan, upgrade purchase, burst, surface tabs, debug condition/seed/staging commands.
- Resource, supply, knowledge, and route interaction handlers for many individual authored nodes.
- Spawn and route selection wrappers around `SpawnSelection`.
- Scan target selection, scan effects, repeat scan copy, and scan target feedback.
- Upgrade selection, purchase, effect application, readiness copy, cost formatting, and upgrade menu rendering.
- Survival supply banking and night-resolution coordination around `SurvivalState`.
- HUD layout, active dive stats, cargo slot presentation, surface result tabs, upgrade panel presentation, warning copy, and prompt formatting.
- Route/readability visual state synchronization for pressure locks, rare signals, Blackwater, Hollow Reef, salvage, Outer Shelf, and timing cues.
- Debug visual review staging and visual-smoke state publishing.
- Expedition result formatting, route memory callouts, recent expedition log formatting, and result panel content.
- Save/load/delete coordination for `ProgressionState` and nested `SurvivalState`.

Existing modules already own useful pieces:

- `DiveSession` owns temporary expedition oxygen, cargo, depth, result, and extraction state.
- `ProgressionState` owns banked resources, purchased upgrades, discoveries, best depth, and save data shape.
- `SurvivalState` owns Emergency Week needs, night resolution, collapse/stabilization, and survival supply helpers.
- `SpawnSelection` owns deterministic spawn/route candidate selection and condition weighting.
- `ScanTargetResolver` owns nearest valid scan target selection and target identity helpers.
- `ExpeditionGoalFormatter` owns ready-goal copy based on progression, upgrades, condition, and recent route memory.
- `ExpeditionCondition`, `UpgradePurchase`, `ReadabilityMarkerPatterns`, and `ScanPulseVisual` are small focused helpers.

Repeated patterns in `main.gd`:

- Many `player_near_*` booleans plus matching `_on_*_body_entered`, `_on_*_body_exited`, and `_try_*_interaction` functions.
- Repeated payoff visual dim/bright synchronization for run-scoped knowledge interactables.
- Repeated timing-cue update functions that differ mostly by nodes, period, and alpha helper.
- Repeated formatters for resources, supplies, upgrades, result lines, and route callouts.
- Debug staging functions that directly mutate large groups of scene nodes.
- HUD layout constants and label clipping/formatting rules mixed with gameplay state changes.

Places where `main.gd` should eventually call a service/controller/presenter instead of owning logic directly:

- HUD and surface-panel text rendering should move toward presenter scripts.
- Expedition result summary, research callouts, route memory, and recent log formatting should move toward an `ExpeditionResultService`.
- Save/load/delete coordination should move toward a `SaveService`, while `ProgressionState` remains the durable data owner.
- Debug visual staging should move toward a `DebugCommandService` or staged review helper.
- Spawn/run setup should call a route or expedition setup service rather than wrapping helper calls in `main.gd`.
- Repeated proximity/interaction state should be represented with a small interaction helper before adding more bespoke booleans.
- Repeated route visual synchronization should move toward focused route presenters or data-driven helper functions.

Highest-risk areas that should not be moved first:

- `_process`, `_unhandled_input`, `_start_dive`, `_try_extract`, `_fail_dive`, `_prepare_next_run`, and `_restart_dive`, because they tie together run state, scene state, UI state, and save state.
- Save/load behavior until existing state boundaries are documented in tests.
- Upgrade effect application and prerequisite logic until presenter-only formatting has been separated.
- Route payoff interactions that mutate both run-scoped flags and visuals.
- Broad scene node references that may depend on Godot ready-order and authored scene paths.

Lowest-risk extraction candidates:

- Pure formatting helpers for resources, supplies, surface tabs, upgrade costs, oxygen labels, and compact text.
- Expedition result summary and route/research callout formatting when passed explicit state.
- Debug seed/condition helpers and debug visual staging groups.
- Cargo slot state/color/icon helper logic.
- Save service wrapper after a narrow characterization test.
- Repeated timing alpha helpers and scan/readability presentation helpers.

## Target Architecture

The target should be practical for a Godot 4.7 prototype and should evolve through small issues:

```text
scenes/Main.tscn
  scripts/main.gd
    thin Godot scene script shell
  scripts/main_scene_context.gd
    inherited scene node references, exported tuning, constants, run fields
  scripts/main_scene_controller.gd
    residual scene orchestration to keep shrinking into focused services

scripts/state/
  existing RefCounted state may stay in scripts/ until a later broad cleanup
  DiveSession, ProgressionState, SurvivalState remain gameplay truth owners

scripts/controllers/
  dive_controller.gd
    start/extract/fail/restart orchestration around DiveSession and scene reset
  survival_controller.gd
    extraction supply routing and night-resolution orchestration
  progression_controller.gd
    upgrade purchase/application coordination when it grows beyond helpers

scripts/ui/
  hud_presenter.gd
    active HUD labels, oxygen warning copy, cargo slot states, prompt copy
  surface_presenter.gd
    result/upgrades/log tab text and layout-safe panel summaries
  route_presenter.gd
    route/lock/payoff visual state sync where logic is presentation-only

scripts/services/
  save_service.gd
    JSON save/load/delete coordination for progression and survival data
  expedition_result_service.gd
    extraction/failure summaries, route memory, research callouts, recent log data
  route_setup_service.gd
    deterministic spawn/route setup wrappers around SpawnSelection

scripts/debug/
  debug_command_service.gd
    review seed/condition helpers, visual-smoke staging commands, debug state publishing
```

Only introduce these files when a child issue extracts a real responsibility and proves behavior with tests. Do not create empty architecture folders just for neatness.

## Dependency Direction

- State/model classes should not depend on UI nodes, scene nodes, or presenters.
- Services/controllers may depend on state/model classes and focused helper scripts.
- UI presenters should format/render state but not own durable gameplay rules.
- Route/readability presenters may mutate visual nodes, but should not write durable progression or session state.
- `main.gd` should eventually become scene composition, signal wiring, and high-level orchestration.
- Tests should target extracted pure logic where practical and keep scene-level checks for Godot node wiring.
- Avoid circular dependencies. If a helper needs to call back into `main.gd`, the extraction is probably not ready.

## Testing Requirement

Every refactor issue must include a test plan.

For each extracted presenter, service, controller, or helper:

- Add unit tests for pure logic, formatting, state transitions, and decision rules.
- Prefer tests against the extracted module instead of testing behavior indirectly through `main.gd`.
- If the extracted code formats HUD text, route labels, survival summaries, scan feedback, upgrade text, cargo summaries, result summaries, debug output, or warning messages, add direct tests for representative inputs and expected outputs.
- If the extracted code coordinates state changes, add tests for important state transitions.
- If behavior already has coverage, move or adapt the existing tests so they target the new module.
- If unit testing is not practical because the code is tightly bound to Godot scene nodes, document that in the issue and add the smallest useful smoke/regression test instead.
- Do not accept "manual tested only" for logic that can reasonably be unit-tested.
- Do not refactor behavior without either preserving existing coverage or adding new coverage.
- Do not claim tests passed unless they actually ran.

Every child issue must report the exact commands run and results:

- Run the existing quick tier from the README or package scripts when runtime code changes: `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick`.
- Run any new unit tests added for the extraction.
- Run Godot headless smoke tests if available through the quick tier.
- Run `git diff --check`.
- For documentation-only architecture issues, run `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs`.

## Issue Plan

The detailed issue breakdown lives in [`main-gd-refactor/ISSUE_PLAN.md`](main-gd-refactor/ISSUE_PLAN.md) so this current-state epic stays short enough for future agents to load.

## Recommended First Issue

Start with issue 1: extract active HUD formatting into `HudPresenter`. It is a low-risk slice because most of the logic is pure formatting, existing HUD tests already cover readability constraints, and it reduces future overlap bugs without changing gameplay state.

## Created GitHub Issue Index

- Parent epic: #640 `Epic: Decompose main.gd into stable architecture modules`
- #641 `Refactor main.gd 01: Extract active HUD formatting into HudPresenter`
- #642 `Refactor main.gd 02: Extract cargo slot presentation helpers`
- #643 `Refactor main.gd 03: Extract upgrade menu formatting into UpgradePresenter`
- #644 `Refactor main.gd 04: Extract expedition result formatting into ExpeditionResultService`
- #645 `Refactor main.gd 05: Extract save/load coordination into SaveService`
- #646 `Refactor main.gd 06: Extract debug visual staging into DebugCommandService`
- #647 `Refactor main.gd 07: Extract deterministic route setup wrappers into RouteSetupService`
- #648 `Refactor main.gd 08: Extract scan feedback formatting helpers`
- #649 `Refactor main.gd 09: Consolidate repeated proximity interaction state`
- #650 `Refactor main.gd 10: Extract repeated timing cue visual helpers`
- #651 `Refactor main.gd 11: Split survival extraction orchestration from UI rendering`
- #652 `Refactor main.gd 12: Characterize and shrink remaining orchestration surface`
- #653 `Architecture 13: Keep AGENTS guardrails aligned with main.gd decomposition`
- #654 `Architecture 14: Review scene-authored route data boundaries`
- #655 `Architecture 15: Create module-size watchlist and refactor threshold`
- #656 `Architecture 16: Move reusable visual marker patterns toward resources or small scenes`
- #657 `Architecture 17: Clarify test ownership for extracted modules`
- #658 `Architecture 18: Recalibrate after first main.gd extraction batch`

## Verification Guidance

- Planning/docs-only changes: `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs`.
- Runtime refactor changes: `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick`.
- Visual tiers should be reserved for issues that change rendered scene/HUD contracts.
