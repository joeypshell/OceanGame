# Area 01 Runtime V2 Visual/Collision Review - 2026-06-29

## Decision

Accept `docs/planning/maps/area_01_runtime_source_map_v2.json` as the current Area 01 geometry/collision source for runtime validation.

This is not an acceptance of final terrain art polish. The staged captures show that visible generated terrain, collision-source outlines, and traversal space are now driven from the same source-map candidate, but the presentation still needs a focused visual cleanup pass before content expansion resumes.

## Evidence

Command:

```powershell
npm.cmd run test:area01-shell-captures
```

Result: passed, 1 Playwright test, 8 screenshots.

Generated evidence directory:

```text
test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/
```

Representative captures:

- `area01-surface-entry.png`
- `area01-left-shelf-cave.png`
- `area01-right-shelf-pocket.png`
- `area01-central-drop.png`
- `area01-west-chamber.png`
- `area01-right-chamber.png`
- `area01-deep-spine.png`
- `area01-source-map-overlay.png`

The overlay capture is the important collision evidence. It shows the source-map collision outlines over the same generated terrain shapes used in the staged runtime view.

## Findings

- The staged route commands successfully hit all expected Area 01 positions, including surface entry, left shelf cave, right shelf pocket, central drop, west chamber, right chamber, and deep spine.
- The F10 source-map overlay toggled correctly and rendered over the runtime view.
- Runtime v2 currently provides 8 regions, 13 solid terrain polygons, 6 cave-mouth definitions, and 12 scene hooks.
- The main previous failure mode, invisible blockers that do not correspond to any planned wall, is not reproduced in these staged captures.
- The remaining problem is visual layering/readability: old translucent blockout/route/background shapes and broad lighting bands still compete with the new generated terrain, especially around the central and lower chambers.
- Terrain is readable enough for geometry/collision validation, but not yet close enough to the target screenshot art direction.

## Watchlist

Before adding more Area 01 content, do one focused visual cleanup pass:

1. Hide or demote obsolete translucent blockout shapes that are no longer collision authority.
2. Keep generated collision-source terrain as the visible traversal boundary.
3. Reduce broad decorative bands that look like terrain but do not block.
4. Preserve `source polygon == visible terrain polygon == collision polygon source`.
5. Keep hooks and pickups separate from solid terrain; hooks must stay nonblocking unless explicitly promoted.

## Follow-Up Cleanup

Completed a bounded terrain presentation pass after the staged review:

- Generated source-map terrain now renders as solid wall/floor material rather than translucent background dressing.
- Far background, parallax silhouettes, lighting stack, and water shafts are demoted so they do not compete with the collision-source terrain.
- Existing source-map collision and hook behavior were not changed.
- Logic coverage now guards the visual hierarchy so future terrain passes do not accidentally reintroduce wall-like background clutter.
- Terrain sprite trims must be authored as semantic source-map segments such as `top_lip`, `underside`, `vertical_wall`, or `diagonal_slope`. Do not infer trim placement from arbitrary polygon edge angles; that causes sprites to appear in places where the art kit piece does not make structural sense.
- Runtime v2 now hides legacy route illustration roots such as `SafeShallowsExplorationShell`, `EastShelfSpur`, `ShellReefPocket`, `ThermalVentPocket`, and `WreckEchoDescent` as visuals while preserving interaction/collision children. The source-map terrain should own wall/floor readability; legacy route art should not compete with it.

## Next Step

Review the refreshed staged captures, then expand semantic sprite/trim segments in `area_01_runtime_source_map_v2.json` only where the source map explicitly identifies what terrain role the sprite piece is serving.

Do not add new route content, creatures, upgrades, resources, or promises until the source-map terrain remains readable in the same staged capture suite.
