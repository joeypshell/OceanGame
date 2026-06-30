# Source Map To Godot Workflow

Use this reference when converting OceanGame level reference art into an implemented Godot scene.

## Practical Interpretation

The useful workflow is:

1. Generate or choose a visual reference.
2. Translate the reference into explicit geometry and placement data.
3. Generate or reuse a sprite kit.
4. Assemble the level in Godot from data and reusable assets.
5. Validate collision, trigger zones, and readability.

The reference image is not the level. It is a design input.

## OceanGame Representation

Prefer this split:

- `Polygon2D`: filled seafloor/cave/reef masses and readable silhouettes.
- `CollisionPolygon2D`: simplified solid collision that matches each real terrain mass.
- `Sprite2D`: visual trims, cave rims, terrain edge caps, wreck pieces, gates, resources, plants, and decorations.
- `Area2D`: oxygen refill, ship offload, pickups, scan targets, cave entrances, gates, hazards, return currents, and route triggers.
- JSON: named source-map truth for regions, terrain domain, playable-water shapes, generated solids, cave mouths, object placements, and validation rules.

Use `TileMapLayer` only when a layer is truly tile-like: repeated background details, grid-friendly decoration, destructible tiles, or a deliberately tiled terrain pass.

## Area 01 Surface-Floor Rule

For the first-level map:

- keep the full top water surface open;
- put the ship/moonpool on the surface;
- make surfacing an oxygen action, not cargo banking;
- require ship/moonpool return plus offload input for cargo banking;
- put the continuous seafloor below the open water;
- put route complexity under the seafloor through holes/cave mouths;
- vary hole depth, route length, resources, hazards, gates, and return-current support.

## Implementation Order

1. Source geometry:
   - `open_surface_water`
   - source PNG playable-water trace (`area_01_playable_water_trace_v1.json`)
   - `terrain_domain`
   - `playable_water_regions`
   - `cave_mouths`
   - generated `solid_terrain` collision partitions
   - `water_edge` / collision-edge cues
   - `resource_spawns`
   - `scan_targets`
   - `gates`
   - `hazards`
   - `return_currents`
   - `ship_offload_zone`

2. Visual kit:
   - seafloor top strip
   - cave wall fill
   - cave rim/edge trims
   - cave mouth frame
   - kelp/coral clusters
   - mineral nodes
   - vent pieces
   - wreck chunks
   - pressure gate and locked gate sprites
   - return-current visual

3. Godot builder:
   - read JSON;
   - treat source-PNG trace polygons as the Area 01 cave/corridor/pocket topology source;
   - create continuous terrain-domain visual nodes;
   - create playable-water cutout and edge nodes;
   - create `StaticBody2D` terrain body;
   - create generated `CollisionPolygon2D` partition children;
   - place sprite objects;
   - create `Area2D` hooks;
   - attach existing scripts/resources only where ownership already belongs.

## Validation

- JSON parses.
- Every solid terrain entry has visual, collision, and rim/lip ownership.
- Every cave mouth connects open water to a named cave region.
- Every current-run scan/pickup is reachable or explicitly marked future-locked.
- Surface oxygen and ship offload are separate hooks.
- Generated art has prompt/provenance metadata.
- Runtime scene launches headlessly after scene/script/resource edits.
