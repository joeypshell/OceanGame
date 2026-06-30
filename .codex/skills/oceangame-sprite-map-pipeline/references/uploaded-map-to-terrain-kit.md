# Uploaded Map To Terrain Kit

Use this reference when the user provides a level map, screenshot, sketch, or generated concept and wants it turned into OceanGame terrain sprites and editable Godot data.

## Goal

Convert a visual map into a repeatable pipeline:

```text
uploaded/reference map
-> interpreted topology
-> source-map geometry JSON
-> modular terrain/object kit requirements
-> generated or selected sprite kit
-> source-map preview composite
-> runtime builder input
-> validation and screenshot
```

The output must stay editable. Do not produce a one-off baked level image and call it the runtime map.

## Required Stages

### 1. Intake

Extract only the durable level facts from the reference:

- stage bounds and camera scale;
- open water regions;
- solid terrain silhouettes;
- cave mouths and route entrances;
- main travel corridors;
- current-run resources, scan targets, hazards, gates, and offload/oxygen hooks;
- visual style notes for terrain, plants, crystals, wreck parts, and background depth.

Keep copied screenshots and prompt files as provenance or preview artifacts, not runtime source.

### 2. Source-Map Geometry

Before generating sprites or editing Godot, create or update source-map geometry:

- named regions;
- a continuous terrain-domain polygon;
- playable-water/cave/corridor/pocket polygons;
- generated solid-collision partition policy;
- cave mouth entrance polygons;
- non-colliding background regions;
- sprite/object placements;
- scene hooks;
- validation rules.

For Area 01, prefer the current runtime path:

- source geometry: `docs/planning/maps/area_01_surface_floor_geometry_v1.json` or accepted successor;
- playable-water trace: `docs/planning/maps/area_01_playable_water_trace_v1.json`;
- trace generator: `tools/trace_area01_playable_water_from_source.py`;
- generator: `tools/create_area01_runtime_source_map_v3.py`;
- runtime source map: `docs/planning/maps/area_01_runtime_source_map_v3.json`;
- validator: `tools/validate-area01-runtime-source-map.mjs`.

Do not hand-edit generated runtime source-map JSON when a generator owns the output.

### 3. Terrain Kit Requirements

Define the minimum reusable kit before generation. Required terrain roles:

- `terrain_fill`: broad wall/floor texture used inside solid polygons;
- `top_lip`: readable upper ledges;
- `underside`: readable ceilings/overhangs;
- `vertical_wall`: readable side walls;
- `diagonal_slope`: sloped corridor edges;
- `deep_floor_lip`: lower/deeper shelf edges;
- `cave_mouth_frame`: nonblocking entrance framing;
- `corner_cap`: joins between edge roles;
- `background_rock`: non-colliding depth shapes;
- `foreground_occluder`: non-colliding atmosphere, used sparingly.

Required object roles:

- `plant_cluster`;
- `crystal_cluster`;
- `resource_node`;
- `scan_target`;
- `gate_or_lock`;
- `hazard_marker`;
- `wreck_piece`;
- `return_current_marker`.

Reject sprite kits that only provide repeated full platforms or random wall chunks. The pieces must be role-specific and composable.

### 4. Generate Or Select Sprites

Use generated art only after the source-map needs are clear.

Rules:

- Generate small modular pieces, not one giant terrain image.
- Keep transparent exports and prompt/provenance files next to assets.
- Keep source/raw images separate from exported runtime frames.
- Prefer a small accepted kit over many unreviewed variants.
- Do not wire generated sprites into runtime until a source-map preview looks acceptable.

### 5. Preview Composite

Apply the sprite kit to the source-map geometry in a preview artifact before runtime wiring.

The preview must show:

- continuous terrain domain filled from source geometry;
- playable-water cutouts carved through the domain;
- edge-role trims placed only on matching source-map trim segments;
- cave mouth frames that do not block entrances;
- props/resources/gates separate from collision;
- optional geometry overlay for review.

If sprites look randomly placed, stop and fix role assignment or geometry. Do not hide the problem with more decoration.

### 6. Runtime Wiring

Wire into Godot only after the preview passes review.

Implementation rules:

- `Polygon2D` renders the continuous terrain-domain fill and playable-water cutouts.
- `CollisionPolygon2D` blocks player movement from generated solid partitions derived from the playable-water source.
- `Sprite2D` renders trims, props, resources, gates, and decor.
- `Area2D` owns triggers for oxygen, offload, pickups, scans, cave entrances, gates, hazards, and return currents.
- Visual nodes do not own gameplay state.
- Sprites never define collision.

For Area 01 topology, update the source map or playable-water trace, run `tools/trace_area01_playable_water_from_source.py`, then regenerate with `tools/create_area01_runtime_source_map_v3.py`.

### 7. Validation

Use the cheapest validation tier that proves the change:

```powershell
# Use `python` or the Codex bundled Python if the current shell has no Python on PATH.
python tools/trace_area01_playable_water_from_source.py
python tools/create_area01_runtime_source_map_v3.py
python tools/render_area01_runtime_vs_source_comparison.py
node tools/validate-area01-runtime-source-map.mjs
node tools/validate-area01-runtime-placements.mjs
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs
git diff --check
```

For runtime visual changes:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm.cmd run test:area01-shell-captures
```

Do not run broad visual/mobile/full suites unless the change touches those surfaces.

## Stop Conditions

Stop and report instead of continuing when:

- the uploaded map cannot be translated into explicit solid/open/cave regions;
- the sprite kit does not contain role-specific pieces;
- preview placement looks random or tile-stamped;
- collision and visible terrain no longer derive from the same source polygon;
- a generated preview is acceptable visually but cannot be represented as editable Godot data.

## Repeatability Note

Every completed pass should name:

- source reference path;
- source-map JSON path;
- generator or edit path;
- sprite kit manifest path;
- preview image path;
- runtime files touched, if any;
- validation commands run.
