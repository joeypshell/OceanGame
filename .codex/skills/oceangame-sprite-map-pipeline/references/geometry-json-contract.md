# Geometry JSON Contract

Use this contract when creating or changing OceanGame source-map geometry files.

## Required Top-Level Fields

```json
{
  "schema_version": 1,
  "map_id": "area_01_surface_floor_geometry_v1",
  "purpose": "Short source-truth statement.",
  "coordinate_space": {},
  "topology": {},
  "regions": [],
  "solid_terrain": [],
  "cave_mouths": [],
  "sprite_placements": [],
  "scene_hooks": [],
  "validation_rules": []
}
```

## Coordinate Space

Record:

- `units`: `Godot 2D scene pixels` or `reference image pixels`.
- `origin`: exact origin.
- `conversion`: scale/offset if converting from reference pixels to Godot world coordinates.
- `runtime_authority`: whether this file is runtime authority or planning-only.

## Regions

Each region should include:

```json
{
  "id": "shell_reef_bank_cave",
  "display_name": "Shell Reef Bank Cave",
  "role": "First cargo banking route.",
  "kind": "open_surface | seafloor | cave | pocket | locked_promise",
  "approx_polygon": [[0, 0], [1, 0], [1, 1]],
  "connects_to": ["open_surface_water"],
  "status": "current | planned | future_locked"
}
```

## Solid Terrain

Each solid terrain entry should include:

```json
{
  "id": "main_seafloor_shelf",
  "role": "Continuous floor beneath open water.",
  "polygon": [[0, 0], [100, 0], [100, 40]],
  "visual_strategy": "Polygon2D fill plus sprite rim pieces",
  "collision_strategy": "CollisionPolygon2D from simplified polygon",
  "rim_strategy": "Sprite2D or Polygon2D edge treatment",
  "blocks_player": true
}
```

Do not list visual-only parallax, plants, lighting, or background rock as solid terrain.

## Cave Mouths

Each cave mouth should include:

```json
{
  "id": "starter_kelp_hole",
  "from_region": "open_surface_water",
  "to_region": "starter_kelp_cave",
  "entrance_polygon": [[0, 0], [60, 0], [60, 40]],
  "readability_role": "Visible opening in seafloor.",
  "collision_rule": "No blocking collision across entrance center.",
  "scene_hook": "starter_kelp_hole_trigger"
}
```

## Sprite Placements

Use sprite placements for art objects, not gameplay truth:

```json
{
  "id": "shell_reef_rim_left",
  "asset_family": "cave_rim",
  "position": [100, 200],
  "rotation_degrees": 0,
  "scale": [1, 1],
  "z_index": 2,
  "collision_role": "none | decorative | matches_solid_edge"
}
```

## Scene Hooks

Use scene hooks for behavior:

```json
{
  "id": "ship_offload_zone",
  "type": "offload | oxygen | pickup | scan | gate | hazard | return_current | cave_entrance",
  "region_id": "open_surface_water",
  "shape": "rect | circle | polygon",
  "points": [[0, 0], [100, 0], [100, 50]],
  "owner": "script_or_scene_owner",
  "status": "current | planned | future_locked"
}
```

## Validation Rules

Always include rules that another agent can test:

- Open surface spans the top of the map.
- Ship offload zone is separate from oxygen refill.
- Cave mouths are not blocked by collision.
- Solid terrain has visible terrain, rim/lip, and collision.
- Current pickups/scans are reachable.
- Future-locked objects are marked and visually quieter than current-run goals.
