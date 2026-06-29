# Area 01 Modular Wall Art System

## Decision

Area 01 walls should use a source-map-driven modular sprite dressing system, not bespoke full-wall images.

The source map remains the authority for terrain:

- `docs/planning/maps/area_01_blockout_source_map_v1.json` owns solid wall polygons.
- `Area01BlockoutBuilder` applies the same polygon to visible wall fill, collision, and collision-read lip.
- `Area01BlockoutBuilder` also creates `Area01ArtSlice/TerrainVisualEdges/SourceMapWallDressing` and places reusable wall sprites from the same solid terrain entries.

## Current Modular Sprite Kit

Editable sources live in `assets/source/sprites/environment/`.

Runtime exports live in `assets/exports/sprites/environment/`.

Current first-pass pieces:

- `area01_reef_wall_face_tile_v1.svg`
- `area01_reef_wall_top_lip_v1.svg`
- `area01_reef_wall_underside_shadow_v1.svg`
- `area01_reef_wall_corner_cap_v1.svg`
- `area01_reef_wall_crack_decal_v1.svg`
- `area01_reef_wall_kelp_decal_v1.svg`
- `area01_reef_wall_coral_decal_v1.svg`

These are intentionally small repeatable pieces. They are not collision and do not define level shape.

## How This Avoids One Sprite Per Wall

Each wall polygon gets repeated wall-dressing groups. A group combines:

- a dark reef face tile;
- a readable top lip;
- an underside shadow;
- an occasional crack, kelp, coral, or corner decal.

That lets one long ceiling, one shelf edge, or one vertical wall reuse the same small pieces at different positions, scales, and rotations. Future art can replace these SVGs with painted PNG tiles or atlas regions without changing collision ownership.

## Guardrails

- Do not hand-place collision to match art.
- Do not hand-place unrelated wall art that implies blockers.
- Do not generate a unique full-wall sprite for every source-map polygon.
- If a wall shape changes, update the source map first, then let the builder regenerate collision/visuals/dressing.
- Decorative sprites may clarify wall texture, but collision and playable lanes must remain readable from the source-map fill and rim.

## Next Steps

1. Improve the primitive art quality while preserving the same filenames or adding versioned replacements.
2. Apply the sprite dressing more selectively so large flat walls read as continuous terrain rather than obvious repeated stamps.
3. Dress the remaining Area 01 source-map walls after normal play confirms the larger blockout lanes.
4. Consider a later atlas or TileSet only after the source-map pipeline proves stable.
