# Area 01 Blockout Source Map - 2026-06-28

## Decision

Area 01 now needs a source-of-truth blockout contract before more cave, route, or polish work. Recent playtests exposed the core problem: terrain, collision, resource pockets, and scannables are not yet governed by one map rule, so players can see wall-looking shapes that do not block, hit blockers that do not read as walls, and notice interactables that appear inaccessible.

The source map lives at `docs/planning/maps/area_01_blockout_source_map_v1.json`.
The generated review map lives at `docs/planning/maps/area_01_wall_collision_authority_map_v1.svg`.

This is a developer planning and validation artifact. It is not an in-game minimap, checklist, or exact locator system.

## What The Source Map Owns

- Playable water lanes: the open movement spaces the diver should understand as explorable water.
- Solid terrain: every current Area 01 blocker that must have matching visible wall art, enabled collision, and a readable rim/lip.
- Nonblocking background policy: broad parallax, lighting, and old shallow shapes that must not create invisible walls.
- Resource pockets: the places where starter resources should teach left, right, and downward movement.
- Scannable and interactable policy: current-run targets must be reachable; future-locked promises must be quieter and honest.
- Validation rules: the checklist tests and debug overlays should enforce before more content is added.

## Why This Exists

The current screenshots show three defects that should not be fixed one-by-one by guessing:

- the diver can swim into a wall-looking right-side mass;
- the diver can get stopped by nothing while moving left;
- scannables and interactables can look like they are behind terrain or outside reachable lanes.

These are not only art issues. They are map-truth issues. The next fixes should compare the scene against the source map, then update either the scene or the map intentionally.

## Current Gate

Do not add or adjust Area 01 collision, terrain, pockets, or scannables unless one of these is true:

- the change already maps to a lane, solid terrain entry, pocket, or policy in `area_01_blockout_source_map_v1.json`;
- the change updates the source map first and preserves the validation rules;
- the change is a temporary debug overlay or test that helps verify the source map.

## Immediate Issue Order

1. #694: create the source-of-truth blockout map and validation rules.
2. #695: add a collision and placement debug overlay mode.
3. #696: rebuild the current shell from the source map and fix the reported blockers.
4. #692: add cave-mouth affordances only after blocker truth is reliable.
5. #693: validate the larger skeleton before returning to visual polish.

## Acceptance Signal

The source map is doing its job when a developer can answer these questions without wandering manually:

- Which water spaces are intended to be playable?
- Which shapes are real blockers?
- Does every blocker have visible terrain and a lip/rim?
- Which resource pockets are supposed to teach movement?
- Are current scannables reachable, or are they intentionally future-locked?

The player-facing result should come in the next implementation pass: no more invisible blockers, no wall-looking ghosts, and no reachable-looking objects trapped behind unclear terrain.
