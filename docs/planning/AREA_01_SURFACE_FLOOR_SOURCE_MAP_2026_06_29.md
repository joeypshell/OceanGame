# Area 01 Surface-Floor Source Map - 2026-06-29

## Decision

Area 01's first-level map should read as open ocean above a continuous seafloor, not as a sealed cave maze near the surface.

The corrected source reference lives at `docs/planning/maps/area_01_surface_floor_source_map_v1.png`.
Its topology and marker contract lives at `docs/planning/maps/area_01_surface_floor_source_map_v1.json`.

## Core Layout Rule

The entire water surface is open. The player can surface anywhere for air, then return to the ship/moonpool to offload cargo and immediately dive again.

Below that open water is the seafloor. The level's exploration comes from holes in that floor:

- a shallow starter kelp hole;
- a Shell Reef banking route;
- a thermal vent pocket;
- a deeper Blue Chimney route;
- a pressure-locked wreck branch;
- a deeper locked future exit.

## Loop Implication

This layout supports the daylight multi-dive loop:

- surface air is easy to understand because the top of the map is always open water;
- cargo banking still requires returning to the ship, so surfacing and offloading are related but distinct;
- each hole can be tuned as one oxygen/cargo decision rather than forcing the whole first level into one uninterrupted descent;
- deeper holes can carry better rewards, stronger hazards, return currents, and gates.

## Collision Rule

Do not bake the generated PNG into runtime collision or art. The promoted runtime source is `docs/planning/maps/area_01_runtime_source_map_v3.json`, generated from `docs/planning/maps/area_01_playable_water_trace_v1.json` plus Godot-coordinate cave-mouth, placement, and hook geometry.

The primary Area 01 topology source is playable water: open surface, source-PNG-traced cave corridors/pockets, and cave mouths. Runtime v3 generates one continuous undersea `terrain_domain` visual and collision-only `solid_terrain` partitions around those water shapes. Do not treat hand-authored solid chunks as the primary design source.

`docs/planning/maps/area_01_blockout_source_map_v1.json` is historical/fallback context only. It no longer owns current runtime collision truth.

## Non-Goals

- No player-facing minimap.
- No exact route checklist.
- No final terrain art pass.
- No collision inferred from generated image pixels.
