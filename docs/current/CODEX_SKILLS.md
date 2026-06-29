# Codex Skills

This repository keeps project-specific Codex skills in `.codex/skills/`. They are lightweight operating guides for recurring OceanGame work. Use them to load the right source-of-truth docs, respect project boundaries, and run the correct verification without re-establishing context every session.

## Available Skills

- `$oceangame-project`: default project context for OceanGame work. Use for general coding, docs, planning, testing, and repository maintenance.
- `$oceangame-gameplay-loop`: gameplay behavior and loop work involving expeditions, oxygen, cargo, scans, upgrades, seeded variation, predators, pressure gates, result memory, and progression.
- `$oceangame-frontend-qa`: visual readability and browser/export verification for HUD, panels, route communication, screenshots, and Playwright smoke checks.
- `$oceangame-art-pipeline`: art asset work covering source/export/provenance files, runtime sprites, fallback visuals, and scene wiring.
- `$oceangame-sprite-map-pipeline`: source-map-to-Godot workflow for turning uploaded/reference maps into reusable sprite kits, geometry JSON, preview composites, collision polygons, and scene hooks without treating a baked image as the runtime level.
- `$oceangame-release`: release, demo, web export, PR closeout, or publishable-checkpoint verification.
- `$oceangame-bugfix`: focused bug reproduction, diagnosis, fix, and verification workflow.
- `$godot-oceangame`: Godot-specific scene, node, GDScript, resource, input map, test, and optional Godot AI MCP workflow.
- `$godot-master`: upstream Godot 4.x expert reference library from `thedivergentai/GD-Agentic-Skills`, useful for broad Godot architecture, physics/collision, UI, performance, export, and engine-pattern guidance.

## Selection Guidance

Use `$oceangame-project` when the task is broad or ambiguous. Add a narrower skill when the task has a clear surface:

- Gameplay change: `$oceangame-gameplay-loop` and usually `$godot-oceangame`.
- Scene/script/resource edit: `$godot-oceangame`.
- Broad Godot engine pattern or collision/physics question: `$godot-master` plus `$godot-oceangame` so generic guidance is filtered through OceanGame ownership and tests.
- Visual layout or exported browser confidence: `$oceangame-frontend-qa`.
- Sprite, source art, or provenance work: `$oceangame-art-pipeline`.
- Sprite-map, cave/seafloor map, or source-reference-to-Godot geometry work: `$oceangame-sprite-map-pipeline`, usually with `$oceangame-art-pipeline` and `$godot-oceangame`.
- Regression fix: `$oceangame-bugfix`.
- Demo/release readiness: `$oceangame-release`.

The skills do not replace `AGENTS.md` or `docs/current/`. They point agents to those files and keep recurring workflow decisions consistent.

## Maintenance Rule

When project structure, verification commands, asset conventions, or gameplay ownership rules change, update the affected skill and the matching `docs/current/` source-of-truth file in the same change.
