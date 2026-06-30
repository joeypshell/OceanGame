# Area 01 Authoritative Wall Map - 2026-06-29

## Decision

Area 01 wall geometry is source-map driven. The current blocker is not a content problem; it is a map-truth problem. Players are seeing wall-like shapes, invisible stops, and inaccessible-looking targets when wall visuals, collision, rim art, background dressing, and blockout intent drift apart.

2026-06-30 update: this document's original blockout-map authority has been superseded. Current runtime authority is `docs/planning/maps/area_01_runtime_source_map_v3.json`, generated from source-PNG-traced playable-water regions and cave mouths carved through one continuous terrain domain. `docs/planning/maps/area_01_blockout_source_map_v1.json` is historical/fallback context only.

The original repair was intentionally simple:

- `docs/planning/maps/area_01_blockout_source_map_v1.json` owned the rescue-pass Area 01 wall polygons.
- `scripts/area01_blockout_builder.gd` applies each wall polygon to the visible wall, the collision polygon, and the readable rim at runtime.
- Older Area 01 wall-like dressing is hidden during this rescue pass so collision truth is readable before decoration resumes.
- `docs/planning/maps/area_01_surface_floor_source_map_v1.png` is the higher-level first-level reference for the desired open-surface, continuous-seafloor, cave-hole topology; that direction now feeds runtime v3 through `docs/planning/maps/area_01_playable_water_trace_v1.json` plus editable Godot-coordinate cave-mouth/hook metadata.

## Simple Wall Map

This is the current readable blockout shape, not final art:

- Reviewable map file: `docs/planning/maps/area_01_wall_collision_authority_map_v1.svg`

```text
   surface / boat
   ----------------------------------------------------------------

   [west ceiling]      central drop       [long right ceiling]
   ---------------     open water     -----------------------------

   west chamber    |              mid crossing            right chamber
   open water      |              open water               open water
   ---------------                -----------------        | outer wall |
   [west floor]                    [right floor]            |            |

                  lower basin / deeper continuation
                  ----------------------------------
                  [deep floor]
```

## Hard Rule

For every current Area 01 generated collision partition:

```text
collision polygon == generated solid_terrain partition from terrain_domain minus playable_water_regions
```

For every current Area 01 visual terrain/water read:

```text
continuous terrain visual == terrain_domain
cave/corridor visual cutout == playable_water_regions polygon
scene hook trigger == source-map scene_hooks points
```

If a future issue changes any Area 01 wall, cave corridor, mouth, or pocket, it must update the source-map playable-water geometry first or in the same commit. Do not hand-place a visual wall, blocker, or lip that does not come from the generated runtime source map.

## Deferred Until Wall Truth Is Stable

- Decorative reef kits that imply collision.
- Foreground kelp/coral that sits directly on wall edges.
- Broad ambience passes that make playable water harder to read.
- New Area 01 content that depends on a path through unclear terrain.
