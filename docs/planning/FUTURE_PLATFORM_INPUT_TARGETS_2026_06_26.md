# Future Platform And Input Targets - 2026-06-26

Status: future roadmap constraint. This is not a current implementation request.

## Purpose

Record long-term platform/input direction so current control, HUD, and scene decisions do not paint the project into a keyboard-only corner.

## Future Targets

- Mobile/iPhone support should be planned as a future target after the core vertical slice is stable.
- Mobile play should be landscape-only.
- Mobile should use touchscreen controls suitable for a side-view dive game.
- Controller support should be added later if it is not already fully covered by the input map.

## Current Decision

Keep desktop keyboard controls as the current playable target. Do not add touch UI, mobile export polish, controller prompts, save/profile UI, or platform-specific settings during the current slice unless a future issue explicitly promotes them.

Current input contract review: `docs/planning/INPUT_ACTION_CONTRACT_REVIEW_2026_06_26.md` confirms player-facing gameplay is routed through semantic Godot actions, while F3/F4/F5/F6/F9 remain debug-only keyboard shortcuts. The next risks are controller/touch mapping and keyboard-specific prompt copy, not gameplay rule coupling.

Current work should still preserve platform flexibility:

- route gameplay input through Godot actions rather than direct key checks,
- keep action names semantic, such as move, interact, scan, restart, and burst,
- keep HUD and prompts compact enough that later touch buttons can fit without covering route decisions,
- avoid gameplay rules that depend on keyboard-only concepts,
- keep debug-only keyboard shortcuts separate from player-facing control requirements.

## Mobile Design Constraints

Future mobile work should assume:

- locked landscape orientation,
- large touch targets with safe margins for notches and rounded display corners,
- no portrait layout requirement,
- a left-side movement control and right-side action controls are likely, but should be prototyped before locking,
- active HUD, touch controls, oxygen warning, scan target, and result panels must not overlap the player, safe-return cues, predator warnings, or pressure-gate/cache reads,
- touch controls should not add new mechanics or simplify oxygen, pressure, predator, cargo, extraction, or scan rules.

## Controller Design Constraints

Future controller work should assume:

- movement via analog stick or D-pad,
- face buttons for interact/confirm, scan, and burst,
- shoulder/trigger or face-button options for surface tab cycling if needed,
- controller prompts should come from action names or an input-prompt helper rather than hard-coded keyboard text,
- debug telemetry controls can remain keyboard-only unless a later issue defines a developer-controller workflow.

## Deferred Issue Candidates

These are future candidates, not current milestone scope:

- review the existing Godot InputMap for gamepad action coverage,
- add a controller prompt abstraction for player-facing copy,
- prototype a landscape touch-control overlay,
- add mobile landscape export settings and safe-area review,
- run a mobile-sized HUD/touch overlap screenshot pass,
- add controller smoke tests/manual verification notes.

## Non-Goals

- No mobile implementation during the current Wreck Echo preparation and slice-polish milestone.
- No portrait UI.
- No touch-first redesign of the core loop.
- No platform-specific economy, save, or progression behavior.
- No broad settings/options menu just to prepare for controller or touch support.

## Promotion Criteria

Promote mobile/controller work only after:

- the current playable slice remains pass-with-watchlist or better after Wreck Echo preparation,
- active HUD and surface panels remain readable at normal scale,
- the next control change has a specific playability problem to solve,
- Playwright/Godot screenshot workflow can cover the relevant layout state or a manual device/simulator smoke pass is documented.
