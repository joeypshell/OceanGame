# Source Of Truth Guardrail

Use this checklist before closing issues that change milestone direction, Area 01 visual truth, runtime map truth, or player-facing loop language.

## Current Authorities

- `docs/current/ROADMAP.md` owns the active milestone, immediate issue order, deferred scope, and next planning priority.
- `docs/current/GAMEPLAY.md` owns implemented behavior. Planning direction can appear only when clearly labeled as planning; do not describe unimplemented systems as current runtime behavior.
- `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md` owns the current Subnautica-like day/night planning reset.
- `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md` owns daylight multi-dive loop details until implementation replaces them in current docs.
- `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md` governs map-topology workflow. Playable map topology must come from a machine-readable source and deterministic converter/importer, not hand-placed Godot polygons, screenshot interpretation, or arbitrary generated concept images.
- `docs/planning/maps/area_01_runtime_source_map_v3.json` owns current Area 01 runtime geometry/collision source truth. Its topology model is playable-water-first: one hidden continuous `terrain_domain` reference, `playable_water_regions` from the source PNG trace plus cave mouths, generated visible/colliding `solid_terrain` partitions, generated rims from those same partition polygons, and explicit scene hooks.
- `tests/playwright/area01-capture-manifest.json` owns deterministic Area 01 shell capture states.

## Issue Closing Checklist

For any issue that changes visible terrain, collision, source maps, route hooks, cue-family language, capture states, milestone wording, or day/night loop wording:

- Update `docs/current/ROADMAP.md` if the active milestone, immediate issue order, deferred scope, or source-of-truth pointer changed.
- Update `docs/current/GAMEPLAY.md` only for implemented behavior, or clearly mark the paragraph as planning direction.
- Update `docs/current/TOOLING.md` when validation commands, capture manifests, overlays, or developer evidence workflows change.
- Update `docs/current/PROJECT_INDEX.md` when adding a new active planning anchor or current source-of-truth document.
- Update `README.md` only when the current milestone or project-doc index changes.
- Update the Area 01 source map and capture manifest together when capture states or runtime map truth change.
- For Area 01 topology changes, follow `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md`: update the machine-readable topology source or converter, regenerate runtime geometry, generate source/runtime/diff previews, and only then use Godot/Playwright screenshots as rendering confirmation. Until the source-grid pipeline exists, the current interim v3 process may update `docs/planning/maps/area_01_surface_floor_source_map_v1.png` or `docs/planning/maps/area_01_surface_floor_geometry_v1.json` as appropriate, regenerate `area_01_playable_water_trace_v1.json`, run `tools/build_area01_map.py --write-previews --validate`, and inspect `artifacts/maps/area_01_source_preview.png`, `artifacts/maps/area_01_runtime_preview.png`, and `artifacts/maps/area_01_diff_overlay.png`.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs` for docs/workflow changes.
- Run the targeted Area 01 capture command when the change is visual or capture-state related: `npm.cmd run test:area01-shell-captures`.
- Run `node .\tools\validate-area01-playable-water-framing.mjs` before closing source-map issues that could make planned cave/pocket camera regions read as mostly blank open water.

## Drift Checks

- If README, ROADMAP, and GAMEPLAY name different active milestones, fix that before closing the issue.
- If GAMEPLAY describes a system as implemented but no code or tests support it, move that text to planning or label it as planning direction.
- If Area 01 collision, visible walls, rim/lip reads, hooks, or resource pockets move, update or validate the runtime source map before closing.
- If Area 01 visible terrain and enabled collision come from different polygons, treat it as source-map/runtime drift even when both sets of polygons are internally valid.
- If Area 01 renders as sparse floating solid chunks in mostly open water, do not accept it as source-map parity. Runtime topology must show open surface over continuous terrain with carved cave/corridor/pocket water.
- If an underwater Area 01 review view has no nearby terrain framing, treat that as source-map/runtime drift even if polygon ownership checks pass. The open surface is the only intentionally unframed water band.
- If a map task asks Codex to make topology match a screenshot or generated image, reframe it as a machine-readable source-map task before editing. Pretty images can guide art style only; they are not collision, wall, route, resource, scan, hazard, gate, return-current, or review-point authority.
- If a report says source-map/runtime/harness/docs signatures changed, include the reason in the issue comment.
