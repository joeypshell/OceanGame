# Area 01 Surface-Floor Sprite Kit Preview

Date: 2026-06-29

## Decision

The Area 01 terrain kit was applied to the earlier candidate surface-floor geometry as a non-runtime preview.

The v4 terrain-kit/source-floor direction has been accepted for map-truth reconciliation and is runtime-wired for source-map review.

This pass does not define current runtime topology. Current Area 01 topology is `docs/planning/maps/area_01_runtime_source_map_v3.json`, generated from playable-water regions carved through one continuous terrain domain.

Future topology work should follow `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md`. This sprite-kit preview can guide wall-art treatment, but generated images, preview PNGs, and screenshots do not define collision, playable water, hooks, routes, resources, scans, hazards, or gates.

Update: the runtime review path now uses `area_01_terrain_art_kit_v4`, which supersedes v3 with clearer cap/repeat/wall module roles. Earlier v1/v2/v3 outputs remain useful comparison artifacts, but v4 is the current terrain-art path.

## Outputs

- Renderer: `tools/render_area01_surface_floor_sprite_kit_preview.py`
- Historical preview geometry source: `docs/planning/maps/area_01_runtime_source_map_v2.json`
- Current runtime topology source: `docs/planning/maps/area_01_runtime_source_map_v3.json`
- Current kit manifest: `docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json`
- Current annotated full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_v4_preview_v1.png`
- Current annotated camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v4_camera_crop_v1.png`
- Current clean full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_v4_clean_preview_v1.png`
- Current clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v4_clean_camera_crop_v1.png`
- Current preview metadata: `docs/planning/maps/area_01_surface_floor_sprite_kit_v4_preview_v1.json`

Historical comparison outputs:

- V1 clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_clean_camera_crop_v1.png`
- V2 clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v2_clean_camera_crop_v1.png`
- V3 clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_clean_camera_crop_v1.png`

## What It Proves

- The generated kit can be applied from structured geometry rather than by baking a single map image.
- Terrain fill can be clipped to source-map polygons.
- Edge sprites can be placed along polygon edges as a preview of future `Sprite2D` trim placement.
- Annotated and clean outputs can be generated from the same data, so art review and source-map review can be separated.
- The same repeatable renderer can be rerun after geometry changes, which gives us a review loop before touching runtime scenes.
- V4 is strong enough to use as the visual direction for the next reconciled runtime source map.

## What It Does Not Prove Yet

The first preview exposed a geometry problem: the original candidate source-map polygons were too rectangular and shelf-box-like for the target visual direction. The organic revision improves that. V3 improves the terrain kit by treating fill as low-contrast material and ledge/ceiling/side sprites as trims, but the preview is still not final-quality terrain art.

The original next useful pass was Godot builder promotion. That pass has been superseded by runtime v3's water-shape-first model:

- load `docs/planning/maps/area_01_runtime_source_map_v3.json`;
- generate hidden terrain-domain/playable-water guides, visible/colliding solid partitions, matching rims, and `Area2D` hooks from that one file;
- preserve relevant defect-prevention validation rules from the current blockout map during implementation checks;
- keep collision generated from simplified polygons, not from sprite pixels;
- keep sprite trims as visual dressing, not gameplay truth;
- do not wire the preview PNG as a baked map.

See `docs/planning/AREA_01_ORGANIC_GEOMETRY_PIPELINE_PASS_2026_06_29.md` for the repeatable process and current gate.
See `docs/planning/AREA_01_MAP_TRUTH_RECONCILIATION_2026_06_29.md` for the accepted comparison and promotion rule.

## Runtime Recommendation

Use this art direction with the current runtime implementation:

- `Polygon2D` for generated solid terrain partition fill, with hidden terrain-domain/playable-water guides for validation;
- `Sprite2D` for rim strips, caps, cave-mouth frames, props, resources, gates, and decor;
- `StaticBody2D` plus `CollisionPolygon2D` for generated terrain solid partitions;
- `Area2D` for oxygen, offload, pickups, scans, gates, hazards, return currents, and route triggers.

Do not switch the main terrain pipeline to `MeshInstance2D` now. Consider `MeshInstance2D` later only for targeted fill-rate optimization after profiling, especially for large alpha-heavy decorations on mobile/web.
