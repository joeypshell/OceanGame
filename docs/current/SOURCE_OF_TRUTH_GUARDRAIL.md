# Source Of Truth Guardrail

Use this checklist before closing issues that change milestone direction, Area 01 visual truth, runtime map truth, or player-facing loop language.

## Current Authorities

- `docs/current/ROADMAP.md` owns the active milestone, immediate issue order, deferred scope, and next planning priority.
- `docs/current/GAMEPLAY.md` owns implemented behavior. Planning direction can appear only when clearly labeled as planning; do not describe unimplemented systems as current runtime behavior.
- `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md` owns the current Subnautica-like day/night planning reset.
- `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md` owns daylight multi-dive loop details until implementation replaces them in current docs.
- `docs/planning/maps/area_01_runtime_source_map_v3.json` owns current Area 01 runtime geometry/collision source truth.
- `tests/playwright/area01-capture-manifest.json` owns deterministic Area 01 shell capture states.

## Issue Closing Checklist

For any issue that changes visible terrain, collision, source maps, route hooks, cue-family language, capture states, milestone wording, or day/night loop wording:

- Update `docs/current/ROADMAP.md` if the active milestone, immediate issue order, deferred scope, or source-of-truth pointer changed.
- Update `docs/current/GAMEPLAY.md` only for implemented behavior, or clearly mark the paragraph as planning direction.
- Update `docs/current/TOOLING.md` when validation commands, capture manifests, overlays, or developer evidence workflows change.
- Update `docs/current/PROJECT_INDEX.md` when adding a new active planning anchor or current source-of-truth document.
- Update `README.md` only when the current milestone or project-doc index changes.
- Update the Area 01 source map and capture manifest together when capture states or runtime map truth change.
- Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs` for docs/workflow changes.
- Run the targeted Area 01 capture command when the change is visual or capture-state related: `npm.cmd run test:area01-shell-captures`.

## Drift Checks

- If README, ROADMAP, and GAMEPLAY name different active milestones, fix that before closing the issue.
- If GAMEPLAY describes a system as implemented but no code or tests support it, move that text to planning or label it as planning direction.
- If Area 01 collision, visible walls, rim/lip reads, hooks, or resource pockets move, update or validate the runtime source map before closing.
- If a report says source-map/runtime/harness/docs signatures changed, include the reason in the issue comment.
