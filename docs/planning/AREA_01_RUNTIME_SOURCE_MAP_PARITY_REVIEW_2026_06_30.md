# Area 01 Runtime Source Map Parity Review - 2026-06-30

## Verdict

The previous full-map topology mismatch has been corrected at the runtime source-map level.

Godot still builds Area 01 from `docs/planning/maps/area_01_runtime_source_map_v3.json` through `Area01BlockoutBuilder`, but v3 is now generated from playable-water shapes first:

- open surface water remains open across the top of the map;
- one continuous undersea `terrain_domain` owns the gray/solid mass;
- source-PNG-traced `playable_water_regions` and cave-mouth polygons carve the white/cave spaces through that mass;
- `solid_terrain` entries are generated collision partitions, not hand-authored design chunks.

This fixes the specific bad equivalence where the runtime map was a sparse set of floating solid polygons in mostly open water while the source map was continuous terrain with cave holes.

## Evidence

- Current runtime render: `docs/planning/maps/area_01_current_godot_runtime_map_2026_06_30.png`
- Side-by-side comparison: `docs/planning/maps/area_01_runtime_vs_source_side_by_side_2026_06_30.png`
- Comparison metadata: `docs/planning/maps/area_01_runtime_vs_source_side_by_side_2026_06_30.json`

The renderer uses the same runtime source map that Godot loads, plus live placement roots from `scenes/Main.tscn`.

## Runtime Snapshot

- Runtime source: `docs/planning/maps/area_01_runtime_source_map_v3.json`
- Source image: `docs/planning/maps/area_01_surface_floor_source_map_v1.png`
- Runtime canvas: `5200 x 2600`
- Source image size: `1536 x 1024`
- Runtime playable-water shapes: `13`
- Runtime generated collision partitions: `73`
- Runtime cave mouths: `6`
- Runtime scene hooks: `16`
- Runtime sprite placements: `8`
- Live authored spawn, pickup, creature, and scan positions rendered from `Main.tscn`: `82`

## What Now Matches

1. The runtime map is no longer sparse floating terrain in open water.
   - The continuous undersea terrain domain wraps the cave spaces.
   - Water/cave shapes are cutouts, not leftover empty ocean.

2. The open surface remains explicit.
   - The surface oxygen hook spans the top band.
   - Ship offload remains a separate hook.

3. Right-side and lower-route pockets are enclosed by generated terrain.
   - Pressure-wreck and future-exit areas now sit inside carved water shapes in a continuous mass.

4. Authored placements are validated against generated collision.
   - The placement validator now checks the generated collision partitions.
   - Current authored spawn, pickup, creature, and scan targets are outside solid terrain.

## Remaining Limits

The runtime source map now traces playable cave/corridor water from `area_01_surface_floor_source_map_v1.png`, but it is still blockout/runtime geometry rather than final hand-painted terrain art.

The continuous `terrain_domain` outer silhouette remains a simple undersea mass, while the carved cave topology comes from `area_01_playable_water_trace_v1.json`. Future fidelity work should improve the source PNG trace/mapping or terrain-domain source, regenerate v3, and refresh this side-by-side artifact. Do not edit generated runtime collision partitions by hand.

## Guardrail

Do not close future Area 01 map issues by saying "both maps are valid" unless the side-by-side artifact shows the same topology model:

```text
open surface water
+ continuous undersea terrain domain
+ carved playable-water caves/corridors/pockets
+ explicit scene hooks
```

Required checks after topology changes:

```powershell
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\trace_area01_playable_water_from_source.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\create_area01_runtime_source_map_v3.py
& 'C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' tools\render_area01_runtime_vs_source_comparison.py
node tools\validate-area01-runtime-source-map.mjs
node tools\validate-area01-runtime-placements.mjs
```
