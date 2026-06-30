# Area 01 Runtime Source Map V3 - 2026-06-30

## Decision

`docs/planning/maps/area_01_runtime_source_map_v3.json` is the current Area 01 runtime geometry/collision authority.

Runtime v3 promotes the uploaded surface-floor plan into explicit Godot data: open surface water across the full stage, a continuous seafloor shelf, cave holes into deeper routes, separate ship offload and oxygen refill hooks, and authored hooks for pickups, scans, gates, hazards, and return currents.

The reference PNG remains a human-readable source image. It is not sampled for collision and is not used as a baked runtime map.

The current v3 runtime geometry also includes explicit pressure-wreck and future-exit corridor framing masses. Those extra solid polygons close the sparse lower-right/right-side gaps that otherwise made the runtime read as blank rectangular water instead of the uploaded surface-floor plan's cave pockets and deeper corridor.

## Source Chain

- Human-readable topology: `docs/planning/maps/area_01_surface_floor_source_map_v1.png`
- Source contract: `docs/planning/maps/area_01_surface_floor_source_map_v1.json`
- Editable Godot-coordinate geometry: `docs/planning/maps/area_01_surface_floor_geometry_v1.json`
- Object-layer companion: `data/maps/area_01_surface_floor_objects_v1.json`
- Runtime authority: `docs/planning/maps/area_01_runtime_source_map_v3.json`
- Generator: `tools/create_area01_runtime_source_map_v3.py`

## Runtime Contract

- Solid terrain is generated as `Polygon2D` visuals plus `CollisionPolygon2D` blockers from the same source polygon points.
- Rim/lip visuals and semantic trim segments derive from the same terrain entries.
- Scene hooks are generated as inert `Area2D` / `CollisionPolygon2D` metadata until gameplay systems explicitly promote them.
- Ship/moonpool offload is separate from the full-width surface oxygen refill band.
- Resource, fish, scan, gate, hazard, and return-current placements must remain outside solid terrain.
- The lower-right pressure-wreck and future-exit reads depend on authored ceiling, shelf, and pillar polygons, not rectangular filler or screenshot-only art.

## Regeneration

```powershell
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\create_area01_runtime_source_map_v3.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe' tools\validate-area01-runtime-source-map.mjs
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe' tools\validate-area01-runtime-placements.mjs
```

## Guardrail

Any Area 01 terrain, cave-mouth, pickup, fish, scan, gate, hazard, return-current, capture-state, or route-hook change should update `area_01_surface_floor_geometry_v1.json`, regenerate v3, and rerun the validators before closing the issue.
