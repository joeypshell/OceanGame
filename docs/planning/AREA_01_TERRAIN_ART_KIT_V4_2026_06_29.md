# Area 01 Terrain Art Kit V4 - 2026-06-29

`area_01_terrain_art_kit_v4` is the current Area 01 terrain-art kit for runtime source-map review.

## Outputs

- Raw generated atlas: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v4_raw.png`
- Prompt: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v4.prompt.txt`
- Processed atlas: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4.png`
- Extracted frames: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/`
- Pipeline metadata: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4.pipeline-meta.json`
- Manifest: `docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json`
- Provenance/license note: `assets/licenses/area01_reef_seafloor_terrain_kit_v4.txt`

## Why V4 Replaces V3

V3 proved the role-based terrain-kit pipeline, but several pieces still read like decorative stamps rather than modular terrain parts.

V4 improves the kit by making cap, repeat, ceiling, vertical wall, slope, and floor roles more visually distinct. This gives the runtime builder better source material while keeping the same rule: terrain sprites are visual dressing only, and collision remains generated from the authoritative Area 01 source-map polygons.

## Runtime Policy

- Use `Polygon2D` terrain fills from `docs/planning/maps/area_01_runtime_source_map_v2.json`.
- Use `Sprite2D` terrain trims from the v4 frame directory.
- Use `StaticBody2D` and `CollisionPolygon2D` from the same source-map polygons.
- Do not infer collision, pickups, gates, cave entrances, or route logic from sprite pixels.
- Do not wire the atlas as a baked level image.

## Repeatable Process

1. Generate a 4x4 terrain kit atlas from `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v4.prompt.txt` or a versioned replacement.
2. Process it with `generate2dsprite.py process` using `--rows 4 --cols 4 --cell-size 313 --fit-scale 0.9 --component-mode all`.
3. Remove disconnected components smaller than 1000 pixels from extracted frames if grid drift creates tiny cross-cell fragments.
4. Rebuild `area01_reef_seafloor_terrain_kit_v4.png` from cleaned frames.
5. Update `docs/planning/maps/area_01_terrain_art_kit_v4_manifest.json`.
6. Point `docs/planning/maps/area_01_runtime_source_map_v2.json` at the accepted manifest and frame directory.
7. Validate with quick logic tests, shell captures, docs tests, and `git diff --check`.
