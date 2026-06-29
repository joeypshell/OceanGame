# Area 01 Terrain Art Kit V3 - 2026-06-29

## Decision

`area_01_terrain_art_kit_v3` was accepted as an Area 01 structural terrain-art direction for map-truth reconciliation, but it has been superseded by `area_01_terrain_art_kit_v4` for current runtime review.

This is still a planning/source-map asset pass only. It does not change `scenes/Main.tscn`, runtime collision, player movement, pickups, scans, resources, route content, or gameplay behavior.

## Source Artifacts

- Raw generated atlas: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v3_raw.png`
- Prompt: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v3.prompt.txt`
- Processed atlas: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v3.png`
- Extracted frames: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v3_frames/`
- Pipeline metadata: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v3.pipeline-meta.json`
- Manifest: `docs/planning/maps/area_01_terrain_art_kit_v3_manifest.json`
- Provenance/license note: `assets/licenses/area01_reef_seafloor_terrain_kit_v3.txt`

## Preview Outputs

- Renderer: `tools/render_area01_surface_floor_sprite_kit_preview.py`
- Annotated full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_preview_v1.png`
- Annotated camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_camera_crop_v1.png`
- Clean full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_clean_preview_v1.png`
- Clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_clean_camera_crop_v1.png`
- Preview metadata: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_preview_v1.json`
- Promoted runtime-source candidate: `docs/planning/maps/area_01_runtime_source_map_v2.json`

## What Changed From Earlier Passes

V1 and V2 proved that sprite-kit placement could be driven from source geometry, but the assets read too much like repeated wall blocks or stamped platform chunks.

V3 changes the asset target:

- the first cell is a low-contrast reef material fill swatch instead of a wall block;
- rim/ledge/ceiling pieces are smaller and more consistent;
- vertical and diagonal pieces are trim assets, not full columns;
- the renderer reduces fill opacity and varies mirrored/rotated fill placement to avoid obvious wallpaper repetition;
- collision remains separate from visual pixels.

## Repeatable Process

Use this exact loop for future terrain-kit revisions:

1. Update the source map or geometry first.
2. Generate a 4x4 terrain kit atlas from `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v3.prompt.txt` or a versioned replacement.
3. Save the raw generated image in `assets/source/sprites/environment/`.
4. Process the raw atlas with `generate2dsprite.py process --mode sheet --rows 4 --cols 4`.
5. Copy `sheet-transparent.png` to a versioned atlas path in `assets/exports/sprites/environment/`.
6. Copy `pipeline-meta.json` to a versioned metadata path.
7. Create a versioned manifest in `docs/planning/maps/`.
8. Point `tools/render_area01_surface_floor_sprite_kit_preview.py` at the new manifest.
9. Render annotated and clean previews.
10. Review the clean camera crop before touching runtime scenes.

Do not infer blockers from generated images, alpha masks, or sprite pixels. Runtime collision must come from explicit source-map polygons.

## Current Assessment

V3 is good enough to use as the visual direction for the next promoted Area 01 runtime source map. It is not final production art.

Known remaining gaps:

- the fill still has visible repetition in some large wall masses;
- cave-mouth framing is still generic and needs custom route-specific trims;
- plants, crystals, wreck pieces, gates, and resources still need separated prop packs;
- parallax background layers are still schematic in this preview;
- runtime Godot wiring has not started for this terrain kit.

## Next Gate

Before runtime promotion:

- review the v3 clean camera crop at normal play scale generated from `area_01_runtime_source_map_v2.json`;
- create route-specific cave-mouth frames and foreground dressing props;
- then build the Godot scene generator from the same source geometry.

The runtime target remains `Polygon2D`/terrain fill plus `Sprite2D` trims and props, with `StaticBody2D`/`CollisionPolygon2D` blockers and `Area2D` interaction zones.
