# First Real 2D Environment Slice - 2026-06-28

## Decision

OceanGame needs one controlled art-playability room before more route/content expansion. The current prototype has many working systems, but normal play still reads too much like layered debug geometry. The next useful visual milestone is not a full art overhaul; it is a small, real-feeling 2D environment slice that proves the level can have walls, ledges, readable swim space, object pockets, and compact HUD framing.

## Scope

Create and maintain an `Area01ArtSlice` hierarchy in the main scene:

- `BackgroundFar`
- `OceanParallaxBackground`
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
- The main shell walls, starter ledges, and resource pockets now use reusable reef-wall and resource-pocket visual modules. The modules add denser silhouettes, ledge lips, algae/coral flecks, and subdued cargo beds while preserving the existing collision and resource behavior.
- The active HUD now frames the room with one compact `SURVIVAL ROUTE` objective card, contextual scan card visibility, and clipped prompt/status rows instead of paragraph-like route/status blocks.
- `Water Filter I` now spends `Driftwood x1` and `Quartz Glass x1` for an immediate `+1 Water` reserve, tying the first starter material pockets to Emergency Week survival instead of leaving them as decorative cargo.
- A targeted Area 01 shell capture suite now stages `area01-surface-entry`, `area01-left-shelf-cave`, `area01-right-shelf-pocket`, and `area01-central-drop` through web debug commands and Playwright screenshots.
- A reusable `OceanLightingStack` now grades the room from brighter surface water into deeper blue haze, adds a subtle center play-space light, and uses caustic/vignette overlays to make the dive feel richer without adding route content or gameplay state.
- A reusable `OceanParallaxBackground` now places distant reef walls, stepped shelf silhouettes, open-water pockets, mid-depth plates, and a deep center silhouette behind the lighting stack so the room reads less like flat background bands.

## Acceptance

At normal 1280x720 play scale:

- the player can tell where open water is;
- walls and ledges read as terrain rather than route hints;
- background shapes are quieter than solid terrain;
- cargo/scan object slots do not look like walls;
- old debug-like area scaffolding does not dominate the view;
- the HUD and player remain smaller than the room.

## Next Work

1. Add one passive scan target or existing scan target placement inside the slice only if it improves the room's teachable focus.
2. Continue visual direction issues only where they make this first room easier to parse, especially terrain/module clarity and reference-matched HUD/world composition.
3. Keep route expansion paused until the slice reads like a playable room rather than a diagram.

## Capture Workflow

Use this targeted command before manual wandering when reviewing Area 01 shell changes:

```powershell
npm run test:area01-shell-captures
```

The stable capture names are:

- `area01-surface-entry`
- `area01-left-shelf-cave`
- `area01-right-shelf-pocket`
- `area01-central-drop`

## Guardrails

- Do not add new routes, creatures, hazards, resources, promises, checklist UI, or map systems as part of this slice. Additional upgrades should wait unless they directly connect existing starter materials to the core survival loop like `Water Filter I`.
- Do not copy reference-game assets; use them as composition and readability targets only.
- Prefer fewer, stronger terrain silhouettes over more translucent explanation layers.
- Use screenshots as evidence artifacts, not committed source assets, unless a future issue explicitly asks for committed references.
