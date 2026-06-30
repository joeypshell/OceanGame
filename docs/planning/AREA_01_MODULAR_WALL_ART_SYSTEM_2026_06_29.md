# Area 01 Modular Wall Art System

## Decision

Area 01 walls should use a source-map-driven terrain-chunk system, not bespoke full-wall images and not repeated rectangular stamp sprites as the main wall read.

Map topology process is governed by `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md`. Wall art can decorate terrain, but future wall/cave/collision topology must come from machine-readable source data and deterministic generated runtime geometry, not screenshots, generated concept images, or hand-placed Godot polygons.

The source map remains the authority for terrain:

- `docs/planning/maps/area_01_runtime_source_map_v3.json` owns the current runtime topology.
- `docs/planning/maps/area_01_blockout_source_map_v1.json` and `area_01_runtime_source_map_v2.json` are historical reference/fallback artifacts only.
- `Area01BlockoutBuilder` creates one hidden terrain-domain guide plus hidden playable-water cutout/edge guides from the runtime source map.
- `Area01BlockoutBuilder` generates visible/colliding terrain partitions from `terrain_domain - playable_water_regions`; those partitions own the primary runtime terrain read.

The implementation pipeline is:

- `map_mode`: `side_scroll_mode`
- `visual_model`: parallax depth plus generated solid terrain partitions around carved playable-water cave spaces
- `runtime_object_model`: platform objects, interactive scene objects, and scene hooks
- `collision_model`: generated solid partitions plus precise trigger shapes
- `engine_target`: project-native Godot scene

This intentionally defers a Godot `TileMapLayer`/autotile conversion. A TileMap can be useful later if the level editor workflow needs grid-stamped terrain, but the current screenshot target needs irregular natural shelves and caves first.

## Current Modular Sprite Kit

Editable sources live in `assets/source/sprites/environment/`.

Runtime exports live in `assets/exports/sprites/environment/`.

Current first-pass pieces:

- `area01_reef_wall_face_tile_v1.svg`
- `area01_reef_wall_fill_texture_v2.png`
- `area01_reef_wall_top_lip_v1.svg`
- `area01_reef_wall_underside_shadow_v1.svg`
- `area01_reef_wall_corner_cap_v1.svg`
- `area01_reef_wall_crack_decal_v1.svg`
- `area01_reef_wall_kelp_decal_v1.svg`
- `area01_reef_wall_coral_decal_v1.svg`

These are support/decal/fill pieces. They are not collision and do not define level shape. The primary wall read now comes from generated solid partitions whose visible terrain, collision, and rim/lip reads share one source polygon.

## How This Avoids One Sprite Per Wall

The terrain-domain source gets generated terrain-accent groups. Those groups combine:

- textured generated solid terrain partition polygons;
- generated collision and rim/lip reads derived from the same partition polygons;
- hidden water-edge/rim guides from source-map cutout edges;
- continuous inset/depth planes derived from the same source geometry;
- top/side/underside edge bands;
- semantic `trim_segments` from the source map, such as `top_lip`, `underside`, `vertical_wall`, and `deep_floor_lip`;
- semantic material bands: tapered lit shelf faces, thin top-edge glow, overhang occlusion, and side-wall occlusion derived from those same trim segments;
- cap-aware trim placement: `top_lip` and `underside` use left cap, middle repeat, and right cap sprites; `vertical_wall` uses top cap, middle repeat, and bottom cap sprites; single-piece roles such as `deep_floor_lip` and `diagonal_slope` remain sparse repeat strips;
- generated blend bands behind each semantic trim so sprite detail sits in a local cap/shadow bed instead of looking pasted on top of the wall body;
- occasional crack, kelp, coral, or corner decals.

That lets one long ceiling, one shelf edge, or one vertical wall reuse the same treatment without implying that rectangular sprites define collision. Future art can replace the fill texture, decals, or edge materials with painted PNG tiles or atlas regions without changing collision ownership.

## Guardrails

- Do not hand-place collision to match art.
- Do not hand-place unrelated wall art that implies blockers.
- Do not generate a unique full-wall sprite for every source-map polygon.
- Do not make repeated rectangular sprites the main terrain silhouette.
- Do not infer terrain sprite placement from arbitrary polygon edge angles. A terrain sprite should only appear when the source map explicitly names the terrain role it serves.
- Do not darken the terrain fill so much that the approved rock material disappears. Source-map terrain should read as solid, but the player must still see rock texture, bevel light, and overhang shadow.
- Do not use large rectangular lighting overlays on shelf faces. Broad lighting bands should taper along the authored edge so they read as beveling, not UI-like panels.
- Do not place only middle/repeat sprites on authored terrain edges. If an art-kit role has caps, the builder must place start cap, middle repeat, and end cap sprites so strips read as modular terrain rather than random stickers.
- Do not render semantic trim sprites directly on bare polygon fill; add a role-specific blend band first, then the sprite trim at lower opacity.
- Keep semantic trim coverage sparse enough that it clarifies ledges, undersides, walls, and deep floor boundaries without becoming a noisy wallpaper layer.
- If a wall shape changes, update the source map first, then let the builder regenerate collision/visuals/dressing.
- Decorative sprites may clarify wall texture, but collision and playable lanes must remain readable from the source-map fill, continuous planes, and rim.

## Next Steps

1. Improve the primitive art quality while preserving the semantic trim roles and adding versioned replacements.
2. Blend the filled polygon body, edge bands, and trim sprites so shelves look like continuous natural reef rather than a polygon with strips on top.
3. Use staged captures to review each semantic role in context before adding more route content.
4. Consider a later atlas or TileSet only after the source-map pipeline proves stable.
