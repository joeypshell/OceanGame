# First Real 2D Environment Slice - 2026-06-28

## Decision

OceanGame needs one controlled art-playability room before more route/content expansion. The current prototype has many working systems, but normal play still reads too much like layered debug geometry. The next useful visual milestone is not a full art overhaul; it is a small, real-feeling 2D environment slice that proves the level can have walls, ledges, readable swim space, object pockets, and compact HUD framing.

## Scope

Create and maintain an `Area01ArtSlice` hierarchy in the main scene:

- `BackgroundFar`
- `BackgroundMid`
- `WaterLightShafts`
- `TerrainBackWalls`
- `TerrainCollision`
- `TerrainVisualEdges`
- `GameplayObjects`
- `ForegroundDecor`

This layer stack is the contract for replacing placeholder polygons with reusable sprites or tile pieces later. Gameplay truth stays in existing resource, scan, progression, and dive-session nodes.

## What Changed

- A first-pass `Area01ArtSlice` now sits behind the active play space with opaque terrain masses, quieter far/mid background pockets, visible ledge edges, light shafts, foreground kelp, and explicit object-slot glows.
- The previous broad `SafeShallowsExplorationShell` remains in the scene as historical scaffolding but is hidden by default because it made normal play feel like overlapping route/debug overlays.
- The slice uses simple polygons as temporary art slots. It is not final art and should not be treated as the finished Area 01 look.
- Starter resource spawn candidates now align to four readable pockets in the slice: a shallow left supply pocket, a shallow/right shelf pocket, a left cave material pocket, and a deeper right material pocket. These are still authored spawn candidates, not new resource families or procedural generation.

## Acceptance

At normal 1280x720 play scale:

- the player can tell where open water is;
- walls and ledges read as terrain rather than route hints;
- background shapes are quieter than solid terrain;
- cargo/scan object slots do not look like walls;
- old debug-like area scaffolding does not dominate the view;
- the HUD and player remain smaller than the room.

## Next Work

1. Replace the most important `Area01ArtSlice` polygons with reusable reef-wall and ledge sprite modules.
2. Replace the temporary pocket washes/deposit shelves with reusable reef-wall, ledge, cargo-pocket, and resource-bed art modules.
3. Add one passive scan target or existing scan target placement inside the slice only if it improves the room's teachable focus.
4. Keep route expansion paused until the slice reads like a playable room rather than a diagram.

## Guardrails

- Do not add new routes, creatures, upgrades, hazards, resources, promises, checklist UI, or map systems as part of this slice.
- Do not copy reference-game assets; use them as composition and readability targets only.
- Prefer fewer, stronger terrain silhouettes over more translucent explanation layers.
- Use screenshots as evidence artifacts, not committed source assets, unless a future issue explicitly asks for committed references.
