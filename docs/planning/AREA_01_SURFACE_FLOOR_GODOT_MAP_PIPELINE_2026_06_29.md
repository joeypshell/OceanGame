# Area 01 Surface-Floor Godot Map Pipeline - 2026-06-29

## Decision

Area 01 now has a promoted `side_scroll_mode` Godot map pipeline bundle for the open-surface-over-continuous-seafloor direction.

The editable source data remains separate from the reference PNG. Runtime v3 wires the map into the Area 01 builder through explicit playable-water polygons, a continuous terrain domain, generated collision partitions, water-edge metadata, and scene hooks; it does not use a baked map image as a runtime level.

## Pipeline Axes

- `map_mode`: `side_scroll_mode`
- `visual_model`: parallax underwater layers plus a continuous source-map terrain domain with carved playable-water cutouts
- `runtime_object_model`: platform objects plus interactive scene objects plus foreground/decor objects plus scene hooks
- `collision_model`: generated precise polygon collision partitions plus trigger zones
- `engine_target`: project-native Godot

## Artifacts

- Geometry source: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Playable-water trace: `docs/planning/maps/area_01_playable_water_trace_v1.json`
- Object-layer companion: `data/maps/area_01_surface_floor_objects_v1.json`
- Runtime authority: `docs/planning/maps/area_01_runtime_source_map_v3.json`
- Trace generator: `tools/trace_area01_playable_water_from_source.py`
- Runtime generator: `tools/create_area01_runtime_source_map_v3.py`
- Godot preview scene: `scenes/maps/Area01SurfaceFloorPipelinePreview.tscn`
- Preview builder script: `scripts/area01_surface_floor_pipeline_preview.gd`
- PNG preview renderer: `tools/render_area01_surface_floor_pipeline_preview.py`
- Full preview image: `docs/planning/maps/area_01_surface_floor_pipeline_preview_v1.png`
- Camera crop preview image: `docs/planning/maps/area_01_surface_floor_pipeline_camera_crop_v1.png`

## Runtime Status

`docs/planning/maps/area_01_runtime_source_map_v3.json` is the current runtime wall/collision authority.

`area_01_playable_water_trace_v1.json` is the primary cave/corridor/pocket topology input for runtime v3. `area_01_surface_floor_geometry_v1.json` remains the editable Godot-coordinate companion for open-surface, cave-mouth, placement, and scene-hook metadata. `docs/planning/maps/area_01_blockout_source_map_v1.json` and any hand-authored solid chunk list are historical/fallback context only.

## Representation

- Solid terrain visual: one continuous `terrain_domain` `Polygon2D`.
- Playable water: `playable_water_regions` cutout `Polygon2D` visuals plus water-edge `Line2D` cues.
- Blocking collision: generated `solid_terrain` collision partitions from `terrain_domain - playable_water_regions`.
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
- Do not hand-author `solid_terrain` chunks as the primary map design source.

## Next Step

Review runtime v3 through the source-truth validators, the runtime-vs-source side-by-side render, and Area 01 capture states when visible browser evidence is needed. Any terrain, cave-mouth, playable-water, gate, pickup, scan, or return-current move should update the source PNG, `area_01_playable_water_trace_v1.json`, or `area_01_surface_floor_geometry_v1.json` as appropriate, regenerate `area_01_runtime_source_map_v3.json`, refresh the side-by-side render for topology changes, and rerun the validators.
