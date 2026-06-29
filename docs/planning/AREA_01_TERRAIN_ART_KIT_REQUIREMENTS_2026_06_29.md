# Area 01 Terrain Art Kit Requirements - 2026-06-29

## Decision

Area 01 needs a reusable terrain art kit before more wall art is wired into the game.

This pass defines requirements from the current source maps. It does not generate new art, change runtime collision, or wire sprites into `scenes/Main.tscn`.

The kit must support the current `side_scroll_mode` direction:

- open surface water across the top of the map;
- a continuous seafloor shelf below the surface;
- readable cave mouths cut through that shelf;
- organic reef/cave silhouettes made from source-map polygons;
- explicit `CollisionPolygon2D` blockers independent from pixels;
- separate `Sprite2D` trims, props, resources, gates, and decor;
- separate `Area2D` hooks for oxygen, offload, pickups, scans, hazards, gates, currents, and route triggers.

## Source Inputs

- Surface-floor topology: `docs/planning/maps/area_01_surface_floor_source_map_v1.json`
- Candidate Godot geometry: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Current runtime wall authority: `docs/planning/maps/area_01_blockout_source_map_v1.json`
- Object-layer companion: `data/maps/area_01_surface_floor_objects_v1.json`
- Existing modular wall plan: `docs/planning/AREA_01_MODULAR_WALL_ART_SYSTEM_2026_06_29.md`
- Machine-readable requirements: `docs/planning/maps/area_01_terrain_art_kit_requirements_v1.json`

## Pipeline

- `map_mode`: `side_scroll_mode`
- `visual_model`: parallax underwater layers plus source-map-driven terrain chunks
- `runtime_object_model`: platform objects plus interactive scene objects plus foreground occluders plus scene hooks
- `collision_model`: precise polygon solids plus trigger zones
- `engine_target`: project-native Godot
- `art_style`: pixel-inspired underwater reef/cave art with readable silhouettes, layered depth, and restrained texture noise

The selected style is intended to move toward the user's recent underwater cave references: organic rock clusters, readable cave walls, dark interior mass, brighter playable water, plants/coral/crystals as separate dressing, and no flat repeated rectangle stamps.

## Required Asset Families

### 1. Parallax Scenery Layers

Purpose: make the map feel underwater without implying blockers.

Required layers:

- `sky_surface`: surface/sky/waterline band above the ocean.
- `far_reef_silhouettes`: distant reef towers and cave forms, non-colliding.
- `mid_water_rays`: water haze, light shafts, caustics, depth gradients.
- `near_back_rock`: darker near-background rock behind the foreground terrain.
- `foreground_water_occluder`: optional soft foreground haze/seaweed silhouettes, non-colliding.

Rules:

- Primary layers share the Area 01 stage aspect and camera framing.
- These layers must not contain walkable floors, solid cave walls, pickups, gates, vents, ship offload props, hazards, or scan targets.
- They can be generated as wide scenery plates or repeatable strips, but they are never collision sources.

### 2. Structural Terrain Kit

Purpose: skin source-map polygons so collision and visible terrain read as the same thing.

Required pieces:

- `reef_wall_fill_material`: repeatable interior rock/coral texture for filled `Polygon2D` terrain.
- `seafloor_top_lip_strip`: left cap, middle repeat, right cap, and slope/transition variant for open-water seafloor edges.
- `cave_ceiling_underside_strip`: dark underside strip for overhangs and cave ceilings.
- `vertical_wall_edge_strip`: left/right wall trims for readable vertical descent lanes.
- `diagonal_slope_edge_strip`: sloped/irregular trim for non-horizontal polygon edges.
- `inside_corner_cap`: caps where ledges, walls, and cave mouths meet.
- `outside_corner_cap`: caps for protruding shelf corners.
- `thin_ledge_strip`: narrow shelf top/underside pieces for Shell Reef ledges.
- `deep_floor_lip_strip`: darker floor trim for Blue Chimney and future deep routes.

Rules:

- These are visual assets only. Collision remains generated from source-map polygons.
- Strip pieces must have declared anchors and repeat direction.
- Fill material must tile or repeat without obvious square stamping at normal camera scale.
- Edge strips must make the playable boundary readable even when background parallax is dark.

### 3. Cave Mouth And Route Frames

Purpose: make entrances readable while keeping the center of each mouth navigable.

Required frames:

- `starter_kelp_mouth_frame`
- `shell_reef_mouth_frame`
- `thermal_vent_drop_frame`
- `blue_chimney_mouth_frame`
- `pressure_wreck_mouth_frame`
- `future_exit_locked_frame`

Rules:

- These are `Sprite2D` or trim groups aligned to cave-mouth polygons.
- Frames may overlap terrain visually, but must not create hidden blocking collision.
- Current-route mouths should read brighter and more open than future-locked mouths.
- Pressure/future frames should signal gates without looking like collectible rewards.

### 4. Region Dressing Props

Purpose: make each route visually distinct without changing collision truth.

Required prop groups:

- `starter_kelp_cluster`: shallow kelp, small coral, safe early-route plants.
- `shell_reef_cluster`: shells, soft coral, pale reef detail.
- `thermal_vent_stack`: warm vent chimney pieces, bubbles, heat glow source.
- `blue_chimney_crystal_cluster`: blue vertical crystals and mineral growth.
- `pressure_wreck_chunks`: wreck ribs, metal plates, broken hull silhouettes.
- `future_locked_gate`: quieter deep locked exit marker.
- `pressure_gate`: readable pressure lock art.
- `return_current_visual`: current stream/flow visual that does not read as cargo.

Rules:

- Compact plants, shell clusters, and minerals can be generated as prop packs.
- Vents, gates, wreck chunks, and route frames must be generated one-by-one or as custom wide packs.
- Props do not own pickup, scan, pressure, or route behavior.
- Props must not obscure cave-mouth openness or make inaccessible areas look reachable.

### 5. Resource And Scan Readability Props

Purpose: make current-run rewards, scan targets, and future promises readable without clutter.

Required prop groups:

- `common_mineral_node`
- `rare_mineral_node`
- `exotic_mineral_node`
- `scan_target_marker`
- `food_supply_cache`
- `water_supply_cache`
- `power_supply_cache`

Rules:

- These visuals stay separate from pickup/scan `Area2D` hooks.
- Cargo resources should read differently from scan targets.
- Future-locked scan or gate promises should be quieter than current-run cargo.
- Resource sprites should be small enough for exploration scale and not compete with cave wall silhouettes.

## Source-Map Coverage

The first art kit must cover these geometry groups before runtime promotion:

- Seafloor shelf segments: `surface_shelf_west`, `ship_shelf_left`, `ship_shelf_right`, `mid_seafloor_shelf`, `east_seafloor_shelf`.
- Starter/Shell cave terrain: `starter_kelp_left_wall`, `starter_shell_divider`, `shell_reef_inner_ledges`.
- Vent/Blue Chimney terrain: `thermal_vent_floor`, `blue_chimney_west_wall`, `blue_chimney_floor`.
- Pressure/future terrain: `pressure_wreck_wall`, `future_exit_floor`.
- Cave mouths: `starter_kelp_hole`, `shell_reef_bank_hole`, `thermal_vent_drop`, `blue_chimney_hole`, `pressure_wreck_hole`, `future_deep_exit_hole`.

## Generation Strategy

Use `generate2dsprite` after this requirements pass:

- Use `platform_strip_1x4` for repeatable terrain strips: top lips, underside strips, wall edges, deep floor lips.
- Use `one_by_one` for collision-critical or identity-sensitive assets: cave mouth frames, gates, vent stack, wreck chunks.
- Use `prop_pack_3x3` for compact decor: kelp, coral, shells, crystals, small minerals.
- Use `custom_wide_pack` only for related wide route-frame pieces with explicit non-square cells.
- Do not use square prop packs for terrain walls, cave mouths, gates, ledge strips, or anything that must align to collision.

## Acceptance Criteria

- Every current solid terrain polygon can be skinned with fill plus readable rim/lip assets.
- Every cave mouth has a visual frame that leaves the navigable center visually open.
- Collision can still be generated from source-map polygons without sampling art pixels.
- The player can distinguish foreground solid terrain from background parallax at normal camera scale.
- Current-run pickups and scan targets remain visually separate from decorative plants and future-locked promises.
- The kit can be reused when Area 01 expands horizontally or downward.
- The preview can be composed from source geometry plus separate assets; no baked stage-reference image becomes the runtime level.

## Next Step

Use these requirements to generate the first actual terrain kit assets:

1. structural strip set;
2. cave-mouth frame set;
3. route dressing prop pack;
4. resource/scan prop pack;
5. composed preview over `area_01_surface_floor_geometry_v1.json`.
