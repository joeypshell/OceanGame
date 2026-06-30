# Area 01 Runtime Source Map V3 - 2026-06-30

Superseded later on 2026-06-30 by the deterministic source-grid pipeline. Current Area 01 topology source truth is `data/maps/area_01_source_grid_v1.json`; current Godot-consumed runtime geometry is `data/maps/area_01_runtime_geometry.generated.json`; regenerate with `node .\tools\build-area01-map.mjs --validate --write --previews`. The runtime v3 bridge described below is historical context only.

## Decision

`docs/planning/maps/area_01_runtime_source_map_v3.json` is the current Area 01 runtime geometry/collision authority.

Runtime v3 promotes the uploaded surface-floor plan into explicit Godot data: open surface water across the full stage, one hidden continuous undersea terrain-domain reference, playable-water cave/corridor/pocket shapes carved through that reference, generated visible/colliding solid partitions, separate ship offload and oxygen refill hooks, and authored hooks for pickups, scans, gates, hazards, and return currents.

The reference PNG remains a source image, not a baked runtime map. Runtime v3 samples it only through the deterministic `area_01_playable_water_trace_v1.json` extraction step, then generates editable Godot geometry and collision from that trace.

The current v3 runtime geometry no longer treats hand-authored `solid_terrain` chunks as the primary design source. Source-PNG-traced `playable_water_regions` and cave-mouth polygons are the primary topology source, and generated `solid_terrain` entries are visible/colliding partitions created from `terrain_domain - playable_water_regions`.

This is an interim Area 01 bridge, not the long-term map-authoring standard. Future topology work is governed by `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md` and should move to a machine-readable source map with deterministic conversion, generated runtime geometry, source/runtime/diff previews, Godot builder/importer wiring, and screenshot confirmation. Arbitrary screenshots, generated concept images, and hand-placed Godot polygons are not valid collision or topology sources.

## Source Chain

- Human-readable topology: `docs/planning/maps/area_01_surface_floor_source_map_v1.png`
- Source contract: `docs/planning/maps/area_01_surface_floor_source_map_v1.json`
- Playable-water trace: `docs/planning/maps/area_01_playable_water_trace_v1.json`
- Editable Godot-coordinate geometry: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Object-layer companion: `data/maps/area_01_surface_floor_objects_v1.json`
- Runtime authority: `docs/planning/maps/area_01_runtime_source_map_v3.json`
- Trace generator: `tools/trace_area01_playable_water_from_source.py`
- Generator: `tools/create_area01_runtime_source_map_v3.py`

## Runtime Contract

- A single continuous `terrain_domain` remains in the data as a hidden reference guide, not a player-facing wall.
- `playable_water_regions` own source topology and hidden cutout/edge guide nodes for validation.
- `solid_terrain` entries are generated visible/colliding partitions. They block the player and render terrain/rim reads from the same polygons, but they are not the design source and should not be hand-authored as map chunks.
- Scene hooks are generated as inert `Area2D` / `CollisionPolygon2D` metadata until gameplay systems explicitly promote them.
- Ship/moonpool offload is separate from the full-width surface oxygen refill band.
- Resource, fish, scan, gate, hazard, and return-current placements must remain outside solid terrain.
- The pressure-wreck and future-exit reads depend on playable-water/cave-mouth source shapes carved out of the continuous terrain domain, not open-world edges or screenshot-only art.
- `camera_review_points` define representative camera-scale checks. The surface-entry point is intentionally open; underwater cave/pocket points must have nearby solid terrain framing so blank ocean views cannot pass as source-map parity.

## Visual Evidence

The side-by-side parity artifact is the cheapest full-map review:

- `docs/planning/maps/area_01_current_godot_runtime_map_2026_06_30.png`
- `docs/planning/maps/area_01_runtime_vs_source_side_by_side_2026_06_30.png`
- `docs/planning/maps/area_01_runtime_vs_source_side_by_side_2026_06_30.json`
- `artifacts/maps/area_01_source_preview.png`
- `artifacts/maps/area_01_runtime_preview.png`
- `artifacts/maps/area_01_diff_overlay.png`

The Area 01 shell capture manifest still includes `area01-future-exit` for camera-scale evidence. Run `npm.cmd run test:area01-shell-captures` and review the latest `test-results/playwright-area01-shell/**/area01-future-exit.png` plus `area01-shell-capture-evidence.json` when visible runtime terrain changes need browser evidence.

## Regeneration

```powershell
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\trace_area01_playable_water_from_source.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\build_area01_map.py --write-previews --validate
```

## Guardrail

Any Area 01 terrain, cave-mouth, playable-water region, camera review point, pickup, fish, scan, gate, hazard, return-current, capture-state, or route-hook change should update the machine-readable source map once that pipeline exists. Until then, update the source PNG trace, `area_01_playable_water_trace_v1.json`, or `area_01_surface_floor_geometry_v1.json` as appropriate, regenerate v3, refresh the side-by-side render when topology changed, and rerun the validators before closing the issue.
