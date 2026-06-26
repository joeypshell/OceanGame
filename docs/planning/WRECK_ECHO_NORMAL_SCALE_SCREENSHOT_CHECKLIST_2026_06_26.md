# Wreck Echo Normal-Scale Screenshot Checklist - 2026-06-26

Status: planning artifact for issue #346. This checklist does not require committed screenshots yet.

Use this checklist when a future Wreck Echo implementation or visual review needs normal-scale evidence.

## Capture Metadata

Record the standard screenshot workflow metadata:

- commit hash,
- viewport size,
- screenshot path,
- expedition number,
- seed,
- condition,
- cluster pattern,
- debug telemetry hidden or visible,
- route state being reviewed,
- pass/fail/watchlist note.

Use local screenshot paths or Playwright artifacts. Do not commit screenshots unless a future issue explicitly asks for reference images.

## Required Views

| View | Purpose | Pass Criteria |
| --- | --- | --- |
| Surface prep | Confirm Wreck Echo setup does not crowd ready/goal/condition text. | Ready panel is readable; no active HUD clutter; no quest/checklist language. |
| Active descent before lower route | Confirm normal HUD/return pressure survives before the route. | O2, depth, base, cargo, scan, prompt, and status are bounded; player and return direction are visible. |
| Lower-route approach | Review pressure gate, cache, predator lane, deep reward, and future pocket approach together. | Pressure gate/cache remain distinct; predator lane reads as danger; Wreck Echo cue does not merge with reward lure. |
| Pressure/cache context | Confirm Wreck Echo still reads downstream of the existing pressure/cache promise. | Gate lock/open state, outside scan, cache, and Echo Lens pulse remain separable. |
| Echo Lens cue | Capture after repeat cache scan or equivalent handoff. | Echo cue is temporary/local and does not look like a persistent objective marker. |
| Wreck Echo pocket | Capture the future pocket at normal scale. | Pocket reads as one deeper-right route question, not a new biome or multi-objective hub. |
| Predator relationship | Capture with the Gulper lane visible or nearby. | Predator danger outranks mystery art and does not look like wreck decoration. |
| Low or critical oxygen near route | Confirm survival pressure remains louder than curiosity. | Low/critical warning and base direction outrank Wreck Echo visuals and text. |
| Clue recovered, active view | Capture immediately after clue interaction if implementation has one. | Status is compact; no exact locator, objective, or marker appears. |
| Extraction result | Confirm result readback. | One compact `Research:` line appears only when clue recovery plus extraction happens, and result text stays inside panel bounds. |
| No-clue return or failure | Capture if the issue changes result/failure copy. | No Wreck Echo reward line appears without clue recovery; failure remains recoverable under existing cargo/oxygen rules. |

## Naming

Follow `docs/current/SCREENSHOT_WORKFLOW.md` naming conventions.

Suggested filenames:

```text
oceangame_wreck_echo_surface_prep_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_lower_route_approach_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_pressure_cache_context_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_echo_lens_cue_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_pocket_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_predator_relationship_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_low_oxygen_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_result_clue_<seed-or-state>_<yyyy_mm_dd>.png
oceangame_wreck_echo_result_no_clue_<seed-or-state>_<yyyy_mm_dd>.png
```

## Playwright Use

Prefer the existing Playwright harness when the route is present in the Web export:

```powershell
npm run test:visual
```

Future route implementation may extend the harness with a Wreck Echo state only after the route exists. Until then, the existing `lower-route-pressure-gate.png` capture is the closest repeatable proxy.

## Manual Or Temporary Script Use

Use the manual or temporary Godot script flow from `docs/current/SCREENSHOT_WORKFLOW.md` if:

- the route requires a camera position Playwright does not yet drive,
- the review needs a precise seed/condition combination,
- the route exists only in a local branch before Web export support is updated.

Keep temporary scripts outside the repo and record the absolute screenshot path in the review note.

## Failure Conditions

Fail or defer the future Wreck Echo visual review if screenshots show:

- Wreck Echo cue hiding the pressure gate/cache,
- predator danger reading as wreck decoration,
- reward lure and Wreck Echo clue reading as the same reward,
- oxygen/base return state losing priority,
- result text overflowing panel bounds,
- active HUD becoming a route panel or checklist,
- pressure-dark art looking like a persistent objective marker.

## Current Scope

This checklist adds no screenshots, runtime capture tool, Playwright route step, scene nodes, or visual assets.
