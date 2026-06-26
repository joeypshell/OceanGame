# Pressure-Dark Threshold Use Decision - 2026-06-26

Status: planning decision for issue #295.

## Decision

Keep `study_pressure_dark_threshold_v1` as an unused visual study for later `Wreck Echo Descent` planning.

Do not wire it into `Main.tscn` during the current vertical-slice closeout. The pressure route, Wreck Signal Cache, Echo Lens pulse, predator lane, lower-route reward lure, and active HUD are already carrying enough meaning. Adding a pressure-dark threshold now would risk making the player read a new route, new objective, or exact hidden locator before that route exists.

## Why

`docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md` frames `Wreck Echo Descent` as a later prepared-route question:

- one authored deeper-right pressure route,
- broad echo/category/direction language,
- pressure access and oxygen preparation,
- no minimap, exact locator, field guide, objective checklist, or persistent marker.

`docs/planning/PRESSURE_WRECK_CACHE_BACKUP_ART_PASS_CONSTRAINTS_2026_06_26.md` says any pressure/wreck art pass should clarify the existing lower route, not add another bright object or new route implication. Current pressure gate/cache clarity should stay owned by:

- gate shimmer, bars, and lock/open badge,
- outside wreck scan target,
- Wreck Signal Cache,
- local Echo Lens pulse,
- predator warning lane and Gulper state,
- result/ready remembered-place copy.

## Current Asset Status

Study files:

- `assets/source/sprites/study_pressure_dark_threshold_v1.svg`
- `assets/exports/sprites/study_pressure_dark_threshold_v1.svg`
- `assets/licenses/study_pressure_dark_threshold_v1.txt`

These files may remain in the repository as planning/reference assets. They are not scene-wired, not a gameplay cue, not a route object, not a scan target, and not a collision source.

## Use Later Only If

The study or a replacement may be reconsidered when:

- the current vertical slice is readable at normal scale,
- pressure gate/cache/predator overlap passes review,
- `Echo Lens I` and Wreck Shelf memory are understood without extra explanation,
- a dedicated `Wreck Echo Descent` implementation issue chooses one reward type and one route question,
- the visual can be kept lower priority than danger, oxygen, return, pressure, scan, and HUD cues.

## No-Go For Now

- No new route.
- No new region or biome.
- No pressure-dark collision or denial zone.
- No exact echo locator.
- No map marker, route graph, field guide, quest log, or checklist.
- No brighter pressure signal competing with the current gate/cache.
- No shortcut around `Pressure Seal I`, `Signal Lens I`, `Echo Lens I`, oxygen margin, cargo choices, or safe-return decisions.
