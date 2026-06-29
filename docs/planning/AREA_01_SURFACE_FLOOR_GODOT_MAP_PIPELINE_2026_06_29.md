# Area 01 Surface-Floor Godot Map Pipeline - 2026-06-29

## Decision

Area 01 now has a candidate `side_scroll_mode` Godot map pipeline bundle for the open-surface-over-continuous-seafloor direction.

This pass creates editable source data and a standalone Godot preview scene. It does not wire the new map into `scenes/Main.tscn`, replace the current runtime collision authority, or use a baked map image as a runtime level.

## Pipeline Axes

- `map_mode`: `side_scroll_mode`
- `visual_model`: parallax underwater layers plus source-map terrain chunks
- `runtime_object_model`: platform objects plus interactive scene objects plus foreground/decor objects plus scene hooks
- `collision_model`: precise polygon solids plus trigger zones
- `engine_target`: project-native Godot

## Artifacts

- Geometry source: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Object-layer companion: `data/maps/area_01_surface_floor_objects_v1.json`
- Godot preview scene: `scenes/maps/Area01SurfaceFloorPipelinePreview.tscn`
- Preview builder script: `scripts/area01_surface_floor_pipeline_preview.gd`
- PNG preview renderer: `tools/render_area01_surface_floor_pipeline_preview.py`
- Full preview image: `docs/planning/maps/area_01_surface_floor_pipeline_preview_v1.png`
- Camera crop preview image: `docs/planning/maps/area_01_surface_floor_pipeline_camera_crop_v1.png`

## Runtime Status

`docs/planning/maps/area_01_blockout_source_map_v1.json` remains the current runtime wall/collision authority.

`area_01_surface_floor_geometry_v1.json` is a candidate source-map contract. It should be reviewed and iterated before promotion. Promotion should be explicit and should update `docs/current/GAMEPLAY.md`, `docs/current/ARCHITECTURE.md`, and the affected runtime scene/scripts in the same implementation pass.

## Representation

- Solid terrain: `Polygon2D` visuals plus `StaticBody2D` / `CollisionPolygon2D` solids generated from the same source polygons.
- Terrain trims and props: `Sprite2D` placements listed separately from gameplay hooks.
- Oxygen, offload, cave entrances, pickups, scans, hazards, pressure gates, return currents, and route triggers: explicit `Area2D` scene hooks.
- Parallax and lighting: visual-only; no collision ownership.

## Guardrails

- Do not infer collision from pixels.
- Do not make preview PNGs the runtime map.
- Do not attach gameplay state to art nodes.
- Keep oxygen surface refill separate from ship/moonpool cargo offload.
- Keep cave mouths open unless an explicit gate hook owns the blocking behavior.
- Keep future-locked objects quieter than current-run pickups and scans.

## Next Step

Open `scenes/maps/Area01SurfaceFloorPipelinePreview.tscn` in Godot and review the generated geometry at normal camera scale. If the topology is accepted, the next implementation pass should create or update a builder that consumes `area_01_surface_floor_geometry_v1.json` into the actual Area 01 scene while preserving existing gameplay ownership.
