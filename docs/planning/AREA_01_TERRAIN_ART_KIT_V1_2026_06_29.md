# Area 01 Terrain Art Kit V1

Date: 2026-06-29

This pass produced a small modular reef/seafloor sprite kit for Area 01 review. It is an art asset package only. It is not wired into runtime terrain, collision, pickups, routes, or any gameplay behavior.

## Outputs

- Raw source atlas: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v1_raw.png`
- Transparent atlas export: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v1.png`
- Individual frame exports: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v1_frames/`
- Processing metadata: `assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v1.pipeline-meta.json`
- Prompt/provenance: `assets/source/sprites/environment/area01_reef_seafloor_terrain_kit_v1.prompt.txt`
- Cell manifest: `docs/planning/maps/area_01_terrain_art_kit_v1_manifest.json`

## Kit Intent

The kit is meant to replace flat blockout wall visuals with modular reef pieces that can be arranged over the authoritative Area 01 source maps:

- reef wall fill material;
- seafloor ledge caps and repeat strips;
- cave ceiling underside caps and repeat strips;
- vertical wall caps and repeat strips;
- a slope trim;
- inside/outside corner pieces;
- thin ledge and deep floor lip strips.

Collision should remain separate from the sprites. Use the authoritative wall/source maps and simplified CollisionPolygon2D shapes for gameplay blockers. The sprites are visual dressing for those blockers, not the source of truth.

## QC Notes

The exported atlas uses a 4x4 grid of 313 px cells. The final selected processing pass used largest-component extraction to remove stray generated fragments while preserving attached plant/coral details. Remaining magenta-like edge pixels are minimal and should be checked against the in-game water background before final runtime adoption.

## Next Step

Create a non-runtime preview that places these pieces over the current Area 01 source-map geometry. Only wire into Godot after the preview shows that the pieces can read as continuous shelves/caves without mismatching the collision plan.

## Follow-Up

The first non-runtime geometry preview was produced in `docs/planning/AREA_01_SURFACE_FLOOR_SPRITE_KIT_PREVIEW_2026_06_29.md`. It confirms the kit can be applied from source-map geometry, but the current geometry needs an organic silhouette revision before runtime wiring.
