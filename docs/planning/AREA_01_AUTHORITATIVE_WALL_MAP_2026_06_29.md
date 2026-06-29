# Area 01 Authoritative Wall Map - 2026-06-29

## Decision

Area 01 wall geometry is now source-map driven. The current blocker is not a content problem; it is a map-truth problem. Players are seeing wall-like shapes, invisible stops, and inaccessible-looking targets because wall visuals, collision, rim art, background dressing, and blockout intent have been allowed to drift apart.

The repair is intentionally simple:

- `docs/planning/maps/area_01_blockout_source_map_v1.json` owns the current Area 01 wall polygons.
- `scripts/area01_blockout_builder.gd` applies each wall polygon to the visible wall, the collision polygon, and the readable rim at runtime.
- Older Area 01 wall-like dressing is hidden during this rescue pass so collision truth is readable before decoration resumes.
- `docs/planning/maps/area_01_surface_floor_source_map_v1.png` is the higher-level first-level reference for the desired open-surface, continuous-seafloor, cave-hole topology; it is not runtime collision authority until converted back into `area_01_blockout_source_map_v1.json`.

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

For every current Area 01 wall:

```text
visible wall polygon == collision polygon == rim polygon == source-map polygon
```

If a future issue changes any Area 01 wall, it must update the source-map polygon first or in the same commit. Do not hand-place a visual wall, blocker, or lip that does not come from the same polygon data.

## Deferred Until Wall Truth Is Stable

- Decorative reef kits that imply collision.
- Foreground kelp/coral that sits directly on wall edges.
- Broad ambience passes that make playable water harder to read.
- New Area 01 content that depends on a path through unclear terrain.
