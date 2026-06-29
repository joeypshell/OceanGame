# Area 01 Organic Geometry Pipeline Pass - 2026-06-29

## Decision

Area 01 terrain should be solved from authored geometry first, then skinned with reusable terrain art. This pass applies that recommendation to the current planning map without wiring anything into runtime.

This is planning/source-map work only. It does not change `scenes/Main.tscn`, runtime collision, resources, route content, or gameplay behavior.

## Changed Artifacts

- Source geometry: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Renderer: `tools/render_area01_surface_floor_sprite_kit_preview.py`
- Clean full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_clean_preview_v1.png`
- Clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_clean_camera_crop_v1.png`
- Annotated full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_preview_v1.png`
- Annotated camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_camera_crop_v1.png`
- Preview metadata: `docs/planning/maps/area_01_surface_floor_sprite_kit_preview_v1.json`

Current v3 terrain-kit outputs supersede the v1 preview for art review:

- Clean camera crop: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_clean_camera_crop_v1.png`
- Annotated full preview: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_preview_v1.png`
- Preview metadata: `docs/planning/maps/area_01_surface_floor_sprite_kit_v3_preview_v1.json`

## What Changed

The solid terrain polygons were revised from rectangular shelf-boxes into larger irregular reef masses while preserving the existing topology:

- open surface water remains open across the top;
- ship/offload and oxygen surface refill remain separate future hooks;
- the continuous seafloor still has starter, Shell Reef, Thermal Vent, Blue Chimney, Pressure Wreck, and future deep-exit openings;
- cave-mouth centers stay open instead of being implied by texture pixels;
- future locks and hazards remain scene hooks, not terrain pixels.

The preview renderer now treats sprites as material and edge dressing over continuous source-map polygons. It uses the same source JSON and terrain kit, but reduces cap stamping and obvious repeated platform-tile reads.

## Repeatable Workflow

Use this process for future Area 01 edits or new regions:

1. Update the source map or authoritative geometry JSON first.
2. Keep every solid wall/floor as an explicit named polygon.
3. Keep cave mouths, gates, pickups, scans, oxygen, offload, hazards, and return currents as separate scene hooks.
4. Render the planning preview from the geometry JSON and terrain kit.
5. Review the clean camera crop at normal play scale.
6. Only after approval, generate Godot `Polygon2D`, `StaticBody2D`/`CollisionPolygon2D`, `Sprite2D` trims, and `Area2D` hooks from the same data.

Do not infer collision from screenshots, generated art, alpha masks, or sprite pixels.

## Current Result

This pass proves the core pipeline is viable:

- geometry is editable data;
- terrain art can be applied to that data repeatedly;
- clean and annotated previews come from the same source;
- collision can later be generated from simplified polygons instead of visual guesses.

The result is not final-quality terrain art yet. It is a better structural preview. The remaining visual gap is mainly art-kit and renderer quality: the terrain still needs more purpose-built edge strips, undercut strips, cave-mouth trims, coral/kelp dressing, and parallax background layers before it approaches the reference screenshots.

## Mesh Decision

Do not switch the terrain plan to `MeshInstance2D` just to solve blockiness. Meshes can help later with textured polygon surfaces, UV control, deformation, or fill-rate optimization, but they do not fix rectangular source geometry. The first-order fix is authored organic geometry plus separated collision.

The likely runtime path remains:

- `Polygon2D` or generated mesh surfaces for terrain fill;
- `Sprite2D` trims and props for rims, cave-mouth frames, plants, crystals, resources, gates, and wreck pieces;
- `StaticBody2D` plus `CollisionPolygon2D` for blocking terrain;
- `Area2D` for oxygen, offload, pickups, scans, gates, hazards, return currents, and route triggers.

## Next Gate

Before runtime wiring, do one bounded review of the clean preview and decide whether to:

- revise the organic geometry again;
- improve the terrain art kit with more natural edge/undercut/cave-mouth strips;
- create the Godot builder that converts this geometry into scene nodes.

Do not wire the current preview image into the game as a baked map.
