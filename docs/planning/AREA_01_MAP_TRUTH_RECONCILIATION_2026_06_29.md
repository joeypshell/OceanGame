# Area 01 Map Truth Reconciliation - 2026-06-29

## Decision

The v4 terrain-kit/source-floor direction is accepted as the direction to reconcile into the next Area 01 runtime source of truth.

This does not mean the v4 preview image is runtime art. It means the next runtime map should be derived from `area_01_surface_floor_geometry_v1.json` plus `area_01_terrain_art_kit_v4_manifest.json`, not from ad hoc wall placement.

2026-06-30 update: the runtime v2 builder pass has landed. Current Area 01 geometry and collision now come from `docs/planning/maps/area_01_runtime_source_map_v2.json`; `docs/planning/maps/area_01_blockout_source_map_v1.json` remains only as a fallback load path and validation-rule source.

## Step 2 Comparison

Machine-readable comparison:

- `docs/planning/maps/area_01_map_truth_comparison_v1.json`

Inputs:

- Current runtime blockout authority: `docs/planning/maps/area_01_blockout_source_map_v1.json`
- Accepted geometry direction: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Accepted terrain art candidate: `docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json`
- High-level topology reference: `docs/planning/maps/area_01_surface_floor_source_map_v1.json`

## Key Findings

The current runtime blockout and accepted surface-floor geometry are not one-to-one versions of the same map.

The current runtime blockout is a rescue map:

- 13 solid terrain polygons;
- 11 playable water lane polygons;
- 6 resource pockets;
- 3 cave-mouth affordances;
- existing `visible_path`, `collision_path`, and `lip_path` fields for current runtime builder nodes.

The accepted surface-floor geometry is the intended next Area 01 topology:

- 13 solid terrain polygons;
- 8 named regions;
- 6 cave mouths;
- 8 sprite placements;
- 12 explicit scene hooks for oxygen, offload, cave entrances, hazards, gates, pickups, scans, and return currents.

The important mismatch is conceptual, not just coordinate drift:

- The blockout models readable lanes around rescue-pass wall chunks.
- The accepted map models open surface water over continuous seafloor with cave holes and named routes below.
- The blockout uses resource pockets and affordances.
- The accepted map uses explicit `scene_hooks`.
- The blockout has current scene-node paths.
- The accepted map has no runtime node paths yet because it is still planning geometry.

## Reconciliation Rule

Do not force the accepted source-floor geometry to match the old blockout polygon-for-polygon.

Instead, promote a new source-of-truth artifact:

- `docs/planning/maps/area_01_runtime_source_map_v2.json`

That artifact should merge:

- solid terrain polygons from `area_01_surface_floor_geometry_v1.json`;
- scene hooks from `area_01_surface_floor_geometry_v1.json`;
- defect-prevention validation rules from `area_01_blockout_source_map_v1.json`;
- terrain-kit pointer to `area_01_terrain_art_kit_v4_manifest.json`;
- runtime builder metadata for visible terrain, collision, rims, props, and `Area2D` hooks.

## Non-Negotiables

- Do not wire the v4 preview PNG as a baked runtime map.
- Do not keep old blockout collision while showing new source-floor terrain visuals.
- Do not hand-place visual walls that are not generated from the promoted source polygons.
- Do not infer cave-mouth blockers, routes, pickups, or collision from sprite pixels.

## Next Implementation Step

`area_01_runtime_source_map_v2.json` now exists as the single promoted Area 01 runtime-source candidate.

Supporting generator:

- `tools/create_area01_runtime_source_map_v2.py`

After that file exists and validates, the Godot implementation pass should generate or update:

- `Polygon2D` terrain fills from source polygons;
- `StaticBody2D` plus `CollisionPolygon2D` blockers from the same polygons;
- `Sprite2D` terrain trims from the v4 kit manifest;
- `Area2D` hooks for oxygen, offload, cave entrances, pickups, scans, gates, hazards, return currents, and route triggers;
- debug/QA overlays from the same source, not from manually placed scene objects.

This is the point where visual/collision drift should be prevented structurally instead of fixed by repeated playtest patching.
