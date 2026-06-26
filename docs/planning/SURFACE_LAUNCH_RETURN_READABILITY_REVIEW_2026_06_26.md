# Surface Launch/Return Readability Review - 2026-06-26

Status: review artifact for issue #290.

## Purpose

Review the surface launch and return loop after the moonpool/waterline source-art pass and surface panel opacity tuning.

## Evidence Reviewed

- `docs/planning/SURFACE_MOONPOOL_WATERLINE_REVIEW_2026_06_26.md`
- `docs/planning/SURFACE_MOONPOOL_ASSET_PROVENANCE_REQUIREMENTS_2026_06_26.md`
- `docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- `scenes/Main.tscn`

## State Review

| State | Expected Read | Decision |
| --- | --- | --- |
| Ready | Boat/lab, waterline, and moonpool read as the start location behind a readable panel. | Pass with watchlist |
| Launch | Sub starts below the boat and descends through the moonpool/waterline column. | Pass |
| Return/extract | Base direction and moonpool/surface relationship support safe return. | Pass with watchlist |
| Result | Surface panels own readback while surface base remains recognizable behind them. | Pass |

## Decision

Pass with watchlist.

The boat, moonpool, waterline, sub, and `BaseZone` now read as one surface system for the current vertical slice. `BaseZone` remains the gameplay start/extraction owner; the moonpool/waterline asset is visual support only.

## Watchlist

- Recheck if boat scale, waterline placement, panel opacity, or background art changes.
- Keep surface panels readable over the boat/lab art.
- Do not move extraction behavior into visual art nodes.
