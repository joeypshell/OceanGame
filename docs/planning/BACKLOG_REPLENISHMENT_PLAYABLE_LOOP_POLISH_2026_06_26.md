# Backlog Replenishment - Playable Loop Polish - 2026-06-26

Status: planning output for issue #199.

## Context

The #180-#199 batch delivered expedition-day framing, region/discovery memory, no-cargo scan usefulness, first resource art follow-through, reusable visual extraction, active HUD readability, scanner/mystery planning, and review checklists.

The next backlog should keep the project moving toward a more playable and legible first vertical slice. The queue should not jump to large new systems, broad art production, weapons, minimaps, field guides, or full biome generation.

## Next Ordered Batch

1. Add `Echo Lens I` upgrade definition.
2. Implement `Echo Lens I` Wreck Signal Cache broad echo.
3. Add Echo Lens result-memory line when an echo fires.
4. Run the expedition-day five-seed review and record findings.
5. Fix the highest-priority issue found in the five-seed expedition-day review.
6. Standardize `SurfaceBaseArt` into sprite/fallback visual groups.
7. Extract `ShellReefPocket` visuals into a reusable scene.
8. Add first source/export Lantern Fry sprite.
9. Add first source/export Gulper Eel sprite.
10. Add first source/export Thermal Vent sprite.
11. Add first source/export pressure-wreck/cache visual study.
12. Add compact scan/echo visual effect source asset.
13. Review active HUD after oxygen and cargo slot changes.
14. Add upgrade-bay affordance pass for newly planned scanner upgrade.
15. Add Wreck Shelf route review with Echo Lens planning active.
16. Add deeper-access planning note after Echo Lens I.
17. Review asset provenance coverage for all committed sprite sources.
18. Add screenshot checklist for first polished vertical-slice art kit.
19. Update MCP context resources after playable-loop polish planning.
20. Replenish backlog after playable-loop polish.

## Guardrails

- Keep issues narrow and evidence-driven.
- Prefer improving the first playable loop over adding broad content.
- Do not add minimap, field guide, exact-coordinate tracking, full inventory grid, broad scanner economy, weapons, predator loot, or procedural biome generation.
- Preserve state ownership: `DiveSession` for current expedition state, `ProgressionState` for durable progression, scene/authored data for placement, visual assets for readability only.
- Every implementation issue should update docs/tests when it changes player-facing behavior or scene contracts.

## Success Gate

This batch succeeds if:

- `Echo Lens I` becomes a narrow scanner curiosity upgrade without replacing `Signal Lens I`,
- expedition-day review evidence leads to at least one concrete readability fix,
- core visual slot structure becomes easier to replace,
- at least one creature/landmark visual moves from placeholder toward source/export/provenance workflow,
- the project still feels like a compact playable expedition loop, not a spreading systems prototype.
