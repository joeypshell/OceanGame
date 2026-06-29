---
name: oceangame-art-pipeline
description: Add, replace, review, or document OceanGame art assets while preserving source/export/provenance conventions, placeholder fallback structure, Godot scene ownership, and gameplay-readability separation. Use for sprites, SVGs, generated art, visual clusters, asset provenance, and runtime art wiring.
---

# OceanGame Art Pipeline

## Load First

Read:

- `docs/current/ARCHITECTURE.md` asset pipeline and visual/readability sections.
- `docs/current/GAMEPLAY.md` entries for the affected asset.
- `assets/README.md`
- Relevant `assets/source/**/README.md`, `assets/exports/**/README.md`, and `assets/licenses/README.md` files.

## Asset Locations

- Editable/source assets: `assets/source/`.
- Runtime-ready committed exports: `assets/exports/` or `assets/sprites/`, depending on current local convention for that asset family.
- Provenance and license notes: `assets/licenses/`.
- Reusable resource visuals: `scenes/resources/`.
- Reusable route/readability visuals: `scenes/readability/`.

## Rules

- Preserve gameplay ownership in gameplay nodes, resources, and scripts. Art must not become the source of scan, cargo, pressure, predator, route, or progression truth.
- Keep fallback geometry or placeholder references when the scene already uses `FallbackVisual`, `FallbackGeometry`, `SpriteAnchor`, or `Sprite` slots.
- Add provenance for generated, sourced, or transformed assets.
- Do not commit Godot import cache files, `.import`, `*.import`, exports, or local screenshots unless explicitly requested.
- For generated images, prefer committed runtime assets plus a compact provenance note over undocumented one-off files.
- Avoid changing collision, scan groups, pressure gates, spawn candidates, or gameplay scripts as part of a visual-only art swap unless the task explicitly includes behavior.

## Review Checklist

- Runtime asset is wired at the expected node path.
- Source/export/provenance triplet is present when applicable.
- Fallback visuals remain available or intentionally documented as removed.
- Normal-scale readability was checked for the affected route or UI state.
- The asset does not imply an unimplemented mechanic, objective, minimap, exact locator, inventory system, or quest system.

## Verification

Run headless launch after scene/resource wiring:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

Use `npm run test:visual` for route, HUD, or exported-web visual risk.
