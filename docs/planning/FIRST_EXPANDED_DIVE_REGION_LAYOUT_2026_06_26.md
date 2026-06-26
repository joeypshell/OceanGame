# First Expanded Dive Region Layout - 2026-06-26

Status: implementation plan for issues #446-#451.

Issue: #445.

## Purpose

Define the first wider side-view expedition region so the next implementation work changes the playable map, not just the current vertical slice polish.

## Region Name

`East Shelf Spur`

This is a persistent side-route extension from the current surface-to-wreck column. It should feel like the first hint that the ocean is a wider place with remembered side paths.

## Layout Shape

The first pass should expand the playable area to the right of the current column:

- Surface base remains near the top center/left.
- The existing vertical descent remains valid and familiar.
- A midwater/right branch opens from the Shell Reef to Wreck Shelf band.
- The branch curves down into a small cave or wreck-pocket entrance.
- The branch reconnects visually toward the lower pressure/wreck stack but does not need a second full route yet.

Recommended first-pass coordinate intent:

- Keep current base and early shallow resource path stable.
- Extend camera/world bounds roughly one screen width to the right.
- Place the side-route branch in the midwater-to-deep transition so it is reachable within a normal oxygen run.
- Keep the first implementation shallow enough that `Oxygen Tank I` helps but is not mandatory just to see the branch.

## Required Pieces

1. Wider camera/world bounds. Implemented in #446 with expanded right-side travel room, matching camera limits, and widened base ocean bands.
2. One side-route branch with placeholder terrain/readability shapes. Implemented in #447 as the first `East Shelf Spur` scaffold with current wash, shelf silhouettes, route ribs, gap cue, and terminal pocket hint.
3. One pocket entrance, either cave-like or wreck-hatch-like. Implemented in #448 as a visible far-end pocket mouth with rim, threshold glow, and leftward exit-current cue; no interior system yet.
4. One stable landmark: `East Shelf Arch`.
5. Safe-return cues pointing back toward the surface/base column.
6. One seeded daily opportunity using authored candidates.
7. One visible upgrade-locked promise.

## Stable Landmark

`East Shelf Arch`

Role:

- persistent memory anchor,
- side-route orientation clue,
- return-path cue back to the main column,
- not a collectible, objective marker, minimap substitute, or checklist item.

## Variable Daily Opportunity

First candidate:

`Shelf Glimmer`

Possible daily variants selected from authored candidates:

- extra `Shell Fragments`,
- faint scan clue,
- rare signal shimmer,
- safe-current emphasis.

Only one should be active in the first implementation. It must not increase resource count unpredictably without clear tuning; if in doubt, implement as a scan clue or visual opportunity first.

## Upgrade-Locked Promise

First candidate:

`Sealed Shelf Hatch`

Gate:

- visible in the side pocket,
- locked by existing `Pressure Seal I` or future `Echo Lens I` planning,
- communicates "return later with the right preparation",
- does not add a full interior, quest checklist, minimap, or exact locator in the first pass.

## Safe-Return Readability

The side branch must keep return orientation clear without UI bloat:

- subtle current/rib shapes should point left/up toward the main base column,
- HUD `Base: up/left/up-left` direction should remain meaningful,
- no persistent world text should be required to escape,
- branch geometry should avoid trapping the player behind visual clutter.

## Non-Goals

- No full cave system.
- No second biome family.
- No procedural map generation.
- No minimap, route graph, field guide, objective checklist, or exact locator.
- No combat, capture, harvesting, or creature collection.
- No final art lock.
- No broad scene hierarchy rewrite.

## Implementation Order

1. #446: camera/world bounds.
2. #447: side-route branch.
3. #448: pocket entrance.
4. #449: stable landmark and safe-return cues.
5. #450: variable daily opportunity.
6. #451: upgrade-locked promise.
7. #452: reset/bounds coverage.
8. #453: one targeted screenshot capture.
