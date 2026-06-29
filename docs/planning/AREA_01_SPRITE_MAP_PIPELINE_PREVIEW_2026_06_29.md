# Area 01 Sprite Map Pipeline Preview - 2026-06-29

## Decision

This pass applies the sprite-map pipeline to Area 01 as a planning/reference artifact only. It does not change Godot runtime terrain, collision, triggers, resources, scan targets, or gameplay behavior.

The current runtime wall authority remains:

- `docs/planning/maps/area_01_blockout_source_map_v1.json`

The stronger visual/topology target remains:

- `docs/planning/maps/area_01_surface_floor_source_map_v1.png`
- `docs/planning/maps/area_01_surface_floor_source_map_v1.json`
- `docs/planning/maps/area_01_source_map_polished_terrain_concept_v1.png`

## Produced Preview Artifacts

- `docs/planning/maps/area_01_authoritative_wall_map_art_preview_v2.png`
- `docs/planning/maps/area_01_authoritative_wall_map_art_camera_crop_v2.png`
- `docs/planning/maps/area_01_authoritative_wall_map_art_geometry_overlay_v2.png`
- `docs/planning/maps/area_01_sprite_map_pipeline_preview_v1.json`

## What The Preview Proves

The current authoritative JSON can drive a visual map preview, but the current wall polygons still read like a blockout. Applying polished materials to those exact polygons improves wall/collision trust, but it does not yet create the natural reef/cave silhouettes seen in the concept reference.

The main gap is geometry, not just sprite quality:

- current `blockout_source_map` walls are long angular slabs;
- the polished concept uses continuous seafloor, cave holes, rounded reef masses, and layered depth;
- runtime wiring should wait until the authoritative source map is revised toward the surface-floor topology.

## Pipeline Classification

- Request type: reference-only plus geometry-review.
- Representation choice: future runtime should use `Polygon2D` terrain fills, `CollisionPolygon2D` solids, `Sprite2D` rim/trim/decor pieces, and `Area2D` hooks.
- Runtime status: not implemented.
- Collision status: no collision may be inferred from these PNGs.

## Next Correct Step

Before wiring terrain art into Godot, create a replacement or revision of the Area 01 source-map JSON that promotes the surface-floor topology into explicit Godot-coordinate geometry:

- open surface water region;
- continuous seafloor shelf polygons;
- cave mouth polygons;
- cave water regions;
- solid cave wall polygons;
- ship offload zone separate from oxygen surface refill;
- pickups, scans, gates, hazards, and return currents as scene hooks;
- validation rules that ensure solids, rims, and collision remain matched.

Only after that geometry pass should Godot scene/runtime work begin.
