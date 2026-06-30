# Area 01 Runtime Source Map V3 - 2026-06-30

## Decision

`docs/planning/maps/area_01_runtime_source_map_v3.json` is the current Area 01 runtime geometry/collision authority.

Runtime v3 promotes the uploaded surface-floor plan into explicit Godot data: open surface water across the full stage, one continuous undersea terrain domain, playable-water cave/corridor/pocket shapes carved through that domain, separate ship offload and oxygen refill hooks, and authored hooks for pickups, scans, gates, hazards, and return currents.

The reference PNG remains a source image, not a baked runtime map. Runtime v3 samples it only through the deterministic `area_01_playable_water_trace_v1.json` extraction step, then generates editable Godot geometry and collision from that trace.

The current v3 runtime geometry no longer treats hand-authored `solid_terrain` chunks as the primary design source. Source-PNG-traced `playable_water_regions` and cave-mouth polygons are the primary topology source, and generated `solid_terrain` entries are collision-only partitions created from `terrain_domain - playable_water_regions`.

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

- A single continuous `terrain_domain` Polygon2D owns the readable solid terrain mass.
- `playable_water_regions` own cave/corridor/pocket cutout visuals and water-edge cues.
- `solid_terrain` entries are generated collision partitions. They block the player, but they are not the design source and should not be hand-authored as map chunks.
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

The Area 01 shell capture manifest still includes `area01-future-exit` for camera-scale evidence. Run `npm.cmd run test:area01-shell-captures` and review the latest `test-results/playwright-area01-shell/**/area01-future-exit.png` plus `area01-shell-capture-evidence.json` when visible runtime terrain changes need browser evidence.

## Regeneration

```powershell
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\trace_area01_playable_water_from_source.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\create_area01_runtime_source_map_v3.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\render_area01_runtime_vs_source_comparison.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe' tools\validate-area01-runtime-source-map.mjs
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe' tools\validate-area01-runtime-placements.mjs
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe' tools\validate-area01-playable-water-framing.mjs
```

## Guardrail

Any Area 01 terrain, cave-mouth, playable-water region, camera review point, pickup, fish, scan, gate, hazard, return-current, capture-state, or route-hook change should update the source PNG, trace, or `area_01_surface_floor_geometry_v1.json` as appropriate, regenerate v3, refresh the side-by-side render when topology changed, and rerun the validators before closing the issue.
