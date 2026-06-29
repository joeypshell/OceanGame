---
name: oceangame-sprite-map-pipeline
description: Convert OceanGame uploaded/reference maps into repeatable source-map geometry, modular terrain/object sprite kits, Godot-ready preview composites, collision polygons, scene-hook metadata, and runtime builder inputs. Use when Codex needs to turn an AI/reference map, Area 01 surface-floor map, cave/seafloor layout, terrain sprite kit, uploaded screenshot, or generated map concept into authored Godot data instead of a baked image; also use when deciding between TileMapLayer, Polygon2D terrain chunks, Sprite2D pieces, CollisionPolygon2D, Area2D triggers, and source-map JSON for OceanGame level implementation.
---

# OceanGame Sprite Map Pipeline

## Load First

Read the relevant current/planning docs before editing:

- `docs/planning/AREA_01_SURFACE_FLOOR_SOURCE_MAP_2026_06_29.md`
- `docs/planning/maps/area_01_surface_floor_source_map_v1.json`
- `docs/planning/AREA_01_BLOCKOUT_SOURCE_MAP_2026_06_28.md`
- `docs/planning/maps/area_01_blockout_source_map_v1.json`
- `docs/current/ARCHITECTURE.md`
- `docs/current/GAMEPLAY.md`
- `.codex/skills/godot-oceangame/SKILL.md`
- `.codex/skills/oceangame-art-pipeline/SKILL.md`

For implementation details, load only the reference that matches the task:

- Read `references/uploaded-map-to-terrain-kit.md` when the user provides or asks for a map/reference image to become reusable OceanGame terrain sprites and source-map data.
- Read `references/source-map-to-godot.md` for workflow and ownership rules.
- Read `references/geometry-json-contract.md` before creating or changing source-map geometry metadata.
- Read `.codex/skills/godot-master/references/2d-physics.md` before changing collisions, `Area2D`, or physics layers.
- Read `.codex/skills/godot-master/references/tilemap-mastery.md` only when considering `TileMapLayer`, tilesets, or autotiling.

## Core Rule

Do not make a baked map image the runtime level. Treat images as references, previews, or art sources. Runtime truth must live in explicit Godot data: polygons, sprite/object placements, collision shapes, trigger zones, and scene hooks.

For Area 01, preserve this topology unless the user explicitly changes direction:

- open surface water spans the top of the level;
- surfacing anywhere refills oxygen;
- cargo banking/offload happens at the ship or moonpool;
- a continuous seafloor shelf sits below open water;
- cave holes in the seafloor lead to routes of different depth and complexity;
- deeper holes carry stronger oxygen, cargo, health, pressure, and upgrade tension.

## Pipeline

1. Classify the request.
   - Uploaded/reference map pipeline: convert a user-provided map or screenshot into source-map geometry, modular terrain requirements, a reusable sprite kit, and a preview before runtime wiring.
   - Reference-only: create or update planning art/docs, but do not claim runtime behavior.
   - Geometry pass: create or update source-map JSON and validation rules.
   - Runtime pass: build Godot scene/script/resource changes from source-map JSON.
   - Art pass: create reusable terrain/object sprites and provenance.

2. Choose the representation.
   - Use `Polygon2D` plus `CollisionPolygon2D` for natural seafloor/cave silhouettes.
   - Use `Sprite2D` pieces for reusable visual terrain trims, cave rims, props, wreck chunks, gates, and resources.
   - Use `Area2D` for oxygen zones, offload zones, pickups, scans, gates, hazards, return currents, and cave entrances.
   - Use `TileMapLayer` only for genuinely grid-friendly or repeated decorative layers. Do not force organic cave silhouettes into a tile grid unless the user accepts a tiled look.

3. Author source data before scene work.
   - Create or update geometry JSON with named regions, cave mouths, solid polygons, collision roles, sprite placements, trigger zones, and validation rules.
   - Keep source coordinates explicit and document any conversion from reference pixels to Godot world coordinates.
   - Do not infer collision by sampling a generated PNG.
   - For Area 01 runtime edits, update the generator and generated runtime source map rather than hand-editing runtime JSON.

4. Build or update the sprite kit.
   - Separate terrain fills, edge/rim strips, cave mouth trims, props, pickups, gates, hazards, and wreck pieces.
   - Keep generated prompts/provenance next to generated visual assets.
   - Preserve fallback visuals where the current scene relies on fallback geometry.
   - Every terrain sprite must have a named role such as `top_lip`, `underside`, `vertical_wall`, `diagonal_slope`, `deep_floor_lip`, `cave_mouth_frame`, `background_rock`, `prop`, `resource`, or `gate`. Do not place decorative wall sprites without a role.

5. Preview before runtime wiring.
   - Apply the kit to the source-map geometry in a preview artifact first.
   - Show the preview/crop to the user when the task is visual-directional or when the sprite kit changes materially.
   - Do not wire a new sprite kit into the runtime until the source-map preview is acceptable, unless the user explicitly asks to skip preview review.

6. Implement in Godot.
   - Generate or edit scene nodes from source-map data.
   - Ensure each solid terrain region has matching visible terrain, readable rim/lip, and collision polygon.
   - For Area 01 terrain trims, update `SEMANTIC_TRIM_SEGMENTS` in `tools/create_area01_runtime_source_map_v2.py`; do not eyeball trim sprites into `Main.tscn`.
   - Keep gameplay state in scripts/resources, not in visual-only nodes or image filenames.

7. Validate.
   - Parse changed JSON.
   - Run `node tools/validate-area01-runtime-source-map.mjs` when Area 01 runtime source geometry or trim roles change.
   - Run `git diff --check` for touched files.
   - For scene/script/resource changes, run the Godot headless launch from `$godot-oceangame`.
   - Run logic tests when gameplay state or source-map validation changes.
   - Run visual smoke/screenshots when terrain readability, HUD, route communication, or exported-web view changes.

## Output Expectations

For planning/source-map work, produce:

- a reference image or SVG only when useful;
- a `.prompt.txt` or provenance note for generated art;
- a source-map JSON contract;
- a planning doc that states whether the artifact is runtime authority or reference only.
- a short repeatability note naming the source map, generator, sprite kit manifest, preview artifact, and validation commands.

For runtime work, produce:

- source-map JSON changes;
- Godot scene/script/resource changes that consume or mirror the source map;
- explicit collision and `Area2D` trigger data;
- a validation summary with commands run.
 - a screenshot/capture only when the runtime output changed visually.

## Avoid

- Do not create another pretty map image without structured geometry metadata.
- Do not make collision depend on pixels, colors, or manual visual guessing.
- Do not use `TileMapLayer` as the default answer for natural OceanGame caves.
- Do not turn the source map into a player-facing minimap, checklist, exact marker system, or quest log.
- Do not mix cargo, scan, pressure, predator, oxygen, or upgrade ownership into art nodes.
