# Wreck Echo Route Pocket Ownership Plan - 2026-06-26

Status: planning artifact for issue #342. No route nodes are wired here.

## Decision

The first future Wreck Echo pocket should follow the existing scene/data/state split:

- authored scene nodes own placement and inspectable route structure,
- `main.gd` owns orchestration and HUD/result formatting,
- `DiveSession` or a small run helper owns temporary attempt/clue state,
- `ProgressionState` does not gain Wreck Echo objective state for the first implementation,
- readability scenes own presentation only.

## Ownership Table

| Concern | Future Owner | Notes |
| --- | --- | --- |
| Route holder placement | `scenes/Main.tscn` | One `WreckEchoDescent` holder or equivalent near the deeper-right lower route. |
| Placement candidates | `SpawnPoint` nodes in `Main.tscn` if needed | Authored, named, inspectable; no hidden hard-coded route coordinates. |
| Route visuals | `scenes/readability/WreckEchoDescentVisuals.tscn` if the visual cluster is non-trivial | Presentation-only. No scan, collision, save, or progression logic. |
| Optional scan/clue trigger | `Area2D`/`Scannable` under the route holder if chosen by implementation | One trigger only; broad/local copy; no persistent marker. |
| Active attempt/clue state | `DiveSession` or a run-scoped helper owned by `main.gd` | Resets on extraction, failure, restart, and next expedition. |
| Result line formatting | `scripts/main.gd` | One compact `Research:` line after clue recovery plus extraction. |
| Durable progression | `scripts/progression_state.gd` | No new Wreck Echo durable state by default. Existing resources/upgrades/scans/best depth remain. |
| Scanner distinction | Existing `Signal Lens I`/`Echo Lens I` logic in `main.gd` and upgrade resources | Echo Lens may gate or hint; Signal Lens remains material-facing. |
| Screenshot evidence | `docs/current/SCREENSHOT_WORKFLOW.md` plus Wreck Echo checklist | Local/CI artifacts unless an issue asks for committed references. |

## Likely Future Files

Likely implementation files:

- `scenes/Main.tscn`,
- `scripts/main.gd`,
- `scripts/dive_session.gd` if run-scoped state belongs there,
- `tests/logic_tests.gd`,
- `tests/playwright/visual-smoke.spec.mjs` if Playwright drives the route,
- `docs/current/GAMEPLAY.md`,
- `docs/current/ROADMAP.md`.

Possible but not required:

- `scenes/readability/WreckEchoDescentVisuals.tscn`,
- a small helper/resource only if route selection or copy becomes reusable.

## State Boundaries

Temporary state may include:

- Wreck Echo attempt started this expedition,
- Wreck Echo clue recovered this expedition,
- temporary pulse/status already shown,
- route quiet/no-clue result for this expedition.

Temporary state must not be saved as:

- objective progress,
- persistent marker,
- map/route graph entry,
- field-guide page,
- broad research journal,
- exact route coordinate,
- next-step checklist.

Durable progression may be reconsidered only through a later issue that adds save/load tests and no-locator copy checks.

## Visual Ownership Rules

Wreck Echo visuals may:

- communicate pressure-dark mood,
- suggest a deeper-right threshold,
- frame one route pocket,
- support a local clue interaction.

Wreck Echo visuals must not:

- mutate gameplay state,
- own collision or pressure denial unless explicitly scoped,
- function as a persistent marker,
- replace the pressure gate/cache read,
- out-prioritize oxygen, safe return, predator danger, or the player.

## Current Scope

This plan does not edit `Main.tscn`, add nodes, create scenes, add scripts, change save data, tune gameplay, add scan targets, or implement Wreck Echo route behavior.
