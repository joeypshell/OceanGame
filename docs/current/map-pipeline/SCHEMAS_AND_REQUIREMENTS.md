# Map Pipeline Schemas and Generated Geometry Requirements

## 5. Grid source-map schema

Use a simple JSON source file.

Example:

```json
{
  "schema_version": 1,
  "map_id": "area_01",
  "cell_size": 64,
  "width": 82,
  "height": 42,
  "legend": {
    "#": "solid_terrain",
    ".": "playable_water",
    "~": "open_surface_water"
  },
  "rows": [
    "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
    "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
    "############....##################....###################....######################",
    "############....##################....###################....######################"
  ],
  "required_regions": [
    {
      "id": "open_surface_water",
      "kind": "surface",
      "required": true
    },
    {
      "id": "starter_kelp_hole",
      "kind": "cave",
      "required": true
    },
    {
      "id": "shell_reef_route",
      "kind": "cave",
      "required": true
    },
    {
      "id": "thermal_vent_pocket",
      "kind": "pocket",
      "required": true
    },
    {
      "id": "blue_chimney_route",
      "kind": "cave",
      "required": true
    },
    {
      "id": "pressure_wreck_branch",
      "kind": "branch",
      "required": true
    },
    {
      "id": "future_deep_exit",
      "kind": "locked_promise",
      "required": true
    }
  ],
  "hooks": [
    {
      "id": "ship_offload",
      "type": "offload",
      "cell": [8, 3]
    },
    {
      "id": "oxygen_surface",
      "type": "oxygen",
      "rect_cells": [0, 0, 82, 3]
    },
    {
      "id": "starter_food",
      "type": "pickup",
      "resource": "food",
      "cell": [12, 12]
    }
  ],
  "review_points": [
    {
      "id": "surface_entry",
      "cell": [8, 4]
    },
    {
      "id": "starter_kelp_hole",
      "cell": [12, 12]
    },
    {
      "id": "central_drop",
      "cell": [38, 18]
    }
  ]
}
```

Rules:

- `#` blocks the player.
- `.` is playable underwater space.
- `~` is open surface playable water.
- Hooks must sit in playable cells unless explicitly documented otherwise.
- Generated runtime geometry must be treated as an output file.

---

## 6. Converter requirements

Create or maintain:

```text
tools/build-area01-map.mjs
```

The converter must:

1. Load the source grid JSON.
2. Validate grid size and allowed characters.
3. Convert cells to Godot world coordinates.
4. Identify solid cells.
5. Identify playable water cells.
6. Identify connected components of playable water.
7. Convert solid cells into runtime solid terrain.
8. Merge solid cells into larger rectangles or polygons.
9. Emit generated runtime geometry JSON.
10. Emit source/runtime/diff previews.
11. Validate hooks and review points.
12. Exit nonzero on validation failure.

Suggested commands:

```powershell
node tools/build-area01-map.mjs --validate
node tools/build-area01-map.mjs --write --previews
```

or one combined command:

```powershell
node tools/build-area01-map.mjs --validate --write --previews
```

---

## 7. Generated runtime geometry schema

Generated file:

```text
data/maps/area_01_runtime_geometry.generated.json
```

Example shape:

```json
{
  "schema_version": 1,
  "generated_from": "data/maps/area_01_source_grid_v1.json",
  "map_id": "area_01_runtime_geometry_generated",
  "cell_size": 64,
  "stage_bounds": [0, 0, 5248, 2688],
  "source_grid_water_cutouts": [
    {
      "id": "generated_grid_water_cutout_001",
      "source_cells": [8, 5, 6, 2],
      "polygon": [[512, 320], [896, 320], [896, 448], [512, 448]]
    }
  ],
  "source_grid_water_edges": [
    {
      "id": "generated_grid_water_edge_001",
      "solid_side": "left",
      "trim_type": "vertical_wall",
      "points": [[512, 320], [512, 448]]
    }
  ],
  "playable_water_regions": [
    {
      "id": "component_001",
      "cell_count": 300,
      "world_bounds": [0, 0, 5248, 512],
      "touches_surface": true
    }
  ],
  "solid_terrain": [
    {
      "id": "solid_001",
      "polygon": [[0, 512], [768, 512], [768, 832], [0, 832]],
      "blocks_player": true,
      "runtime_generation": {
        "visible_polygon2d_name": "Solid001Terrain",
        "collision_static_body2d_name": "Solid001Solid",
        "collision_polygon2d_name": "Solid001Collision",
        "rim_container_name": "Solid001Rims",
        "collision_points_source": "generated grid solid cells"
      }
    }
  ],
  "scene_hooks": [
    {
      "id": "ship_offload",
      "type": "offload",
      "world_rect": [512, 128, 128, 128]
    }
  ],
  "review_points": [
    {
      "id": "surface_entry",
      "world_position": [512, 256]
    }
  ]
}
```

This file is generated. Do not hand-edit it.

---

## 8. Godot builder requirements

The Godot builder should only:

- load generated runtime geometry,
- create visible terrain,
- create collision,
- create rim/lip/edge read,
- render source-grid water-cell apertures and water/solid boundary art from generated geometry,
- create hook `Area2D` nodes,
- optionally create debug overlays.

It should not:

- interpret a concept image,
- own the map topology,
- hide topology mismatch with decorations,
- require manual placement of collision,
- create visuals that do not align with collision.

Keep `Area01BlockoutBuilder` if useful, but point it at the generated geometry file.

---

## 9. Preview requirements

The converter should write previews to ignored artifacts unless repo policy says otherwise:

```text
artifacts/maps/area_01_source_grid_preview.svg
artifacts/maps/area_01_runtime_geometry_preview.svg
artifacts/maps/area_01_diff_overlay.svg
```

Source preview:

- solid cells gray,
- playable water pale blue/white,
- open surface cyan,
- hooks colored,
- review points labeled.

Runtime preview:

- generated terrain rectangles/polygons,
- generated playable water bounds,
- hooks and review points.

Diff/overlay:

- show source and runtime mismatch,
- fail hard if topology differs beyond tolerance.

---
