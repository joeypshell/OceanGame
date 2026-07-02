# OceanGame Agentic 2D Map-Building Practices

Status: working playbook for Codex/Claude map tasks
Audience: Codex, Claude, and human review
Primary goal: make OceanGame map work deterministic, reproducible, and player-readable.

---

## 0. Core conclusion

OceanGame should stop asking an agent to “make the map look like the screenshot.”

For playable 2D maps, the agent must work from a machine-readable source of truth:

```text
machine-readable source map
→ deterministic converter/importer
→ generated runtime geometry
→ generated source/runtime/diff previews
→ Godot builder/importer
→ Playwright/Godot screenshot confirmation
```

Pretty concept art may guide style, but it must not define collision, walls, playable water, resources, scan targets, gates, or routes.

The map pipeline should be treated as gameplay infrastructure, not art polish.

---

## 1. Why the current process is failing

The current failure mode is predictable:

```text
visual source map / concept
→ Codex interprets intended walls
→ Codex edits JSON polygons or Godot scene nodes
→ Godot renders something different
→ screenshot review
→ more manual fixes
→ still not reproducible
```

This is unstable because Codex is doing visual interpretation and coordinate translation by intuition.

For OceanGame specifically, the mismatch is:

```text
Current rendered map:
- floating solid chunks
- mostly open water
- hand-tuned polygons and rims

Intended map:
- open water surface
- continuous seafloor / reef mass
- carved cave holes and corridors
- explicit hooks for oxygen, ship offload, pickups, scans, hazards, gates, return currents
```

The fix is not more hand-tuning. The fix is to make the map source deterministic.

---

## 2. Non-negotiable principles

### Principle 1: Topology is data, not art

The map source must explicitly say what is:

- solid terrain,
- playable water,
- open surface water,
- ship/offload zone,
- oxygen refill zone,
- resource spawn,
- scan target,
- hazard,
- gate / locked promise,
- return current,
- camera/review point.

Do not infer these from a pretty image.

### Principle 2: Visuals decorate topology

Terrain art, parallax, kelp, coral, lighting, rim sprites, wall decals, and foreground dressing must decorate the playable map. They must not own collision or route truth.

### Principle 3: Runtime geometry is generated

Generated runtime geometry may use polygons, rectangles, TileMap cells, or collision polygons. But it should be emitted by a converter/importer from a source map, not manually authored as the source.

### Principle 4: The same geometry source must drive visible terrain and collision

For every current Area 01 wall or solid:

```text
visible terrain source == collision source == rim/lip source
```

If these drift, players will hit invisible blockers or see walls they can swim through.

### Principle 5: Preview before Godot

The agent must generate a source preview, runtime preview, and preferably a diff/overlay before relying on Godot screenshots.

Godot/Playwright screenshots are the final confirmation, not the first debugging tool.

### Principle 6: Coarse and correct beats organic and wrong

A blocky grid map that matches the source topology is better than a beautiful irregular polygon map that does not.

Make the map correct first. Make it pretty later.

---

## 3. Recommended source-map ladder

### Stage 1: strict grid JSON

Best immediate fit for OceanGame.

Use a file like:

```text
data/maps/area_01_source_grid_v1.json
```

Benefits:

- easiest for Codex to edit safely,
- deterministic,
- diffable,
- no image interpretation,
- easy validation,
- easy preview generation.

Weakness:

- initially blocky unless later smoothed or decorated.

Use this now.

### Stage 2: strict-palette PNG

Good if Joey wants to “upload a map.”

Rules:

- exact colors only,
- no antialiasing,
- no gradients,
- fixed scale,
- every color has one meaning.

Example palette:

```text
#ffffff = playable water
#808080 = solid terrain
#00ffff = open surface / oxygen
#ff9900 = ship offload
#00ff00 = resource spawn
#ff00ff = scan target
#ff0000 = hazard
#ffff00 = gate / locked promise
#0000ff = return current
```

Weakness:

- easy to accidentally introduce antialiasing or ambiguous pixels.

Use after grid JSON proves the pipeline.

### Stage 3: Tiled or LDtk

Best long-term professional authoring path.

Tiled and LDtk are better when the map needs:

- layered tile data,
- object layers,
- custom properties,
- parallax layers,
- entity/object placement,
- human visual editing.

Use after OceanGame’s source schema stabilizes.

---

## 4. Preferred immediate architecture

Use this pipeline now:

```text
data/maps/area_01_source_grid_v1.json
  ↓
tools/build-area01-map.mjs
  ↓
data/maps/area_01_runtime_geometry.generated.json
  ↓
artifacts/maps/area_01_source_grid_preview.svg
artifacts/maps/area_01_runtime_geometry_preview.svg
artifacts/maps/area_01_diff_overlay.svg
  ↓
scripts/area01_blockout_builder.gd
  ↓
Godot runtime terrain + collision + hooks
```

Godot should consume the generated geometry, not hand-edited geometry.

---

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

## 10. Map validation checklist

The validator must fail if any of these occur:

- unknown grid character,
- inconsistent row width,
- no open surface band,
- open surface not broad enough,
- ship offload hook missing,
- oxygen surface/refill hook missing,
- player spawn missing,
- player spawn not in playable water,
- required region missing,
- resource hook inside solid terrain,
- scan hook inside solid terrain,
- hazard/gate improperly placed,
- review point inside solid terrain,
- playable water connectivity does not match expected route graph,
- camera review point is mostly blank water when it should show a cave/pocket,
- generated runtime preview does not resemble source topology,
- generated file was hand-edited.

Connectivity checks should be grid-based first. Do not use screenshots to discover basic topology errors.

---

## 11. Acceptance gate for Codex map tasks

A Codex map task is not complete unless:

- source map was updated or intentionally unchanged,
- converter was run,
- generated runtime geometry was updated,
- validation passed,
- source/runtime/diff previews were generated,
- Godot consumed generated geometry,
- Godot launched,
- logic tests passed,
- Playwright/Godot screenshot only confirms rendering, not topology.

Do not accept “looks okay in one screenshot” as proof.

---

## 12. When to use Godot TileMapLayer

Godot’s `TileMapLayer` is appropriate when:

- the map is grid/tile-based,
- terrain should be painted quickly,
- the level is large,
- repeated tile art is available,
- collision can live in tile data,
- foreground/background tile layers need separation.

Use TileMapLayer later if the grid source stabilizes and terrain art becomes tile-based.

Short-term OceanGame can still use generated `Polygon2D` and `CollisionPolygon2D` if the source map is deterministic.

---

## 13. When to use Tiled

Use Tiled when you want an external visual editor with:

- tile layers,
- object layers,
- polygon/point/rectangle objects,
- custom properties,
- parallax layer factors,
- JSON export.

Recommended Tiled layer names for OceanGame:

```text
Solid
PlayableWater
OxygenSurface
ShipOffload
ResourceSpawns
ScanTargets
Hazards
Gates
ReturnCurrents
ReviewPoints
ParallaxFar
ParallaxMid
ForegroundDecor
```

Codex should parse Tiled JSON and not manually infer objects from screenshots.

---

## 14. When to use LDtk

Use LDtk when you want:

- structured game-oriented level data,
- levels with layer instances,
- entity definitions,
- fields/custom data,
- strong editor-side structure.

Recommended LDtk entities:

```text
PlayerStart
ShipOffload
OxygenSurface
ResourceSpawn
ScanTarget
HazardZone
Gate
ReturnCurrent
ReviewPoint
RegionMarker
```

Use LDtk after the simpler source-grid pipeline proves the map schema.

---

## 15. Agent-sprite-forge usage rules

The `generate2dmap` skill is useful, but do not let it drive topology from images.

Use it for these decisions:

```text
map_mode = side_scroll_mode
visual_model = parallax_layers or layered_tilemap
runtime_object_model = platform_objects + interactive_scene_objects + foreground_occluders + scene_hooks
collision_model = precise_shapes or tile_collision
engine_target = Godot_TileMap or project-native
```

For OceanGame, the useful part is the layer/runtime/collision contract.

Do not ask it to “generate a pretty map and make that playable” unless the map also exports structured terrain, hooks, collision, and preview metadata.

Use `generate2dsprite` separately for:

- diver sprites,
- sub sprites,
- fish,
- predators,
- resources,
- UI icons,
- wall tile sprites,
- platform strips.

Do not use `generate2dsprite` for map topology.

---

## 16. Prompt rules for Codex

### Bad prompt

```text
Make the terrain match this image.
Fix the map.
Make it look like the generated screenshot.
```

### Better prompt

```text
Do not edit wall polygons manually.
Edit the machine-readable source map or converter only.
Regenerate runtime geometry.
Generate source/runtime/diff previews.
Validation must pass before Godot screenshot review.
Godot must consume generated geometry.
```

### Map task standard opening

```text
This is a map-source reproducibility task, not a visual polish task.
Do not add new gameplay, routes, resources, creatures, or art polish.
The only accepted topology source is the machine-readable map source.
Generated runtime geometry must not be hand-edited.
```

---

## 17. Codex master prompt for new map-pipeline work

```text
Use the OceanGame map-source pipeline.

Do not infer collision or routes from screenshots.

Source of truth:
data/maps/area_01_source_grid_v1.json

Generated output:
data/maps/area_01_runtime_geometry.generated.json

Run:
node tools/build-area01-map.mjs --validate --write --previews

Godot must consume generated geometry only.

Acceptance:
- open surface water exists,
- continuous seafloor mass exists,
- cave holes and corridors are carved through it,
- resources/scans/hooks are in playable water,
- generated runtime preview matches source preview,
- Godot renders the same topology,
- no manual polygon tuning,
- no new gameplay/content/polish.
```

---

## 18. Visual-art workflow after topology is stable

Only after source/runtime parity works:

1. Build a terrain tile/strip kit.
2. Add wall top/middle/bottom/corner/slope pieces.
3. Add cave-mouth frames.
4. Add parallax background layers.
5. Add foreground occluders.
6. Add resource sprites.
7. Add scan-target sprites.
8. Add vegetation/coral decoration.

Rules:

- collision remains from map data,
- art does not own collision,
- collision-critical terrain pieces are not generated in square prop packs,
- platforms/walls use strips, tiles, or one-by-one assets,
- final art is accepted only if preview and Godot map still match.

---

## 19. Review cadence

For each map change:

1. Review source grid.
2. Run converter.
3. Review source/runtime/diff preview.
4. Run validation.
5. Run Godot headless.
6. Run logic tests.
7. Capture one targeted screenshot.
8. Compare against gameplay intent.

Do not run broad screenshot passes before the source/runtime preview is correct.

---

## 20. Recommended next steps for OceanGame

1. Freeze manual Area 01 polygon fixing.
2. Add grid-source file.
3. Add converter.
4. Add generated runtime geometry.
5. Wire Godot builder to generated geometry.
6. Add validator.
7. Add preview artifacts.
8. Then resume survival day/night gameplay work.

The map pipeline is the blocker. Fixing it will make future map uploads realistic.

---

## 21. What to avoid

Do not:

- hand-author generated geometry,
- keep multiple competing map authority files,
- let Main.tscn own map topology,
- use pretty generated maps as collision authority,
- infer collision from antialiased PNGs,
- fix topology with labels,
- add route content while topology is unstable,
- treat one Playwright screenshot as map correctness,
- ask Codex to visually guess wall shapes.

---

## 22. Definition of done for the map pipeline

The pipeline is working when this is true:

```text
Edit source map
→ run one command
→ generated geometry updates
→ previews update
→ validation passes
→ Godot map matches the source topology
```

If that is not true, the pipeline is not done.
