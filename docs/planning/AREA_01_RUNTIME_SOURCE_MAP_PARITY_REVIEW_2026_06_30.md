# Area 01 Runtime Source Map Parity Review - 2026-06-30

## Verdict

The current Godot runtime map is not the same as the source-of-truth map image.

Godot is currently building Area 01 from `docs/planning/maps/area_01_runtime_source_map_v3.json` through `Area01BlockoutBuilder`. That runtime data is valid and collision-safe, but the full-map render shows a sparse set of authored solid polygons rather than the source image's continuous gray terrain mass with white cave corridors carved through it.

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
- Runtime solid terrain polygons: `18`
- Runtime cave mouths: `6`
- Runtime scene hooks: `16`
- Runtime sprite placements: `8`
- Live authored spawn, pickup, creature, and scan positions rendered from `Main.tscn`: `82`

## Main Mismatches

1. The source map is a continuous terrain/cave silhouette.
   - Gray terrain wraps the white cave spaces almost everywhere.
   - The runtime map is a collection of separate gray polygons in a mostly open water field.
   - Result: large gaps can read as ocean or empty water even when the source image implies solid rock around a cave.

2. The right-side pressure-wreck area is only approximate.
   - The source map shows a compact enclosed wreck pocket with the gate, wreck object, minerals, scans, and cave boundary all in one contained chamber.
   - The runtime map has the broad pressure branch, but its enclosing terrain is much simpler and less faithful to the source outline.

3. The lower-right future-exit route is still structurally simplified.
   - The source map shows a winding, enclosed lower-right route with a locked gate and a small pocket beyond it.
   - The runtime map now has an endcap wall so it no longer reads as open ocean, but it is still a broad simplified corridor, not the source route shape.

4. The lower/central cave network is not traced to the source.
   - The source map has a distinctive thermal pocket, Blue Chimney, lower-left return-current pocket, and lower connector shape.
   - The runtime map preserves some named route intent, but the cave contours and solid masses are not the same.

5. Placement density is different.
   - The source image includes many readable map icons distributed inside enclosed cave spaces.
   - The runtime render includes 82 live placement markers, but they sit inside the simplified runtime negative space rather than a faithful copy of the source cave silhouette.

## What Does Match

- The top-level direction is present: open surface, seafloor shelf, starter cave, Shell Reef, thermal pocket, Blue Chimney, pressure-wreck branch, future-exit promise.
- The current runtime source map is internally valid:
  - `node tools\validate-area01-runtime-source-map.mjs`
  - `node tools\validate-area01-runtime-placements.mjs`
- The placement validator reports that authored spawn, pickup, creature, and scan positions are outside runtime solid terrain.

## Correct Next Step

Do not continue patching isolated gaps one at a time.

The next implementation pass should replace the sparse-block model with a source-map parity pass that traces the full solid-terrain silhouette from the accepted source image or from a more faithful editable geometry layer. The runtime should still use explicit polygons, but those polygons need to represent the source map's large continuous terrain masses and carved cave interiors, not only a few shelves, floors, and endcaps.

Recommended follow-up issue: add a source-map parity validator that compares full-map playable-water regions and solid-terrain coverage, not only whether authored points avoid the current collision polygons.
