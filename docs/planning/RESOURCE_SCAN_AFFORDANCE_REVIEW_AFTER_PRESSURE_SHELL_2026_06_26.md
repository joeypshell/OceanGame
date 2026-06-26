# Resource And Scan Affordance Review After Pressure Shell - 2026-06-26

Status: review artifact for issue #331.

## Scope

Reviewed cargo/resource and scan-target readability after the pressure wreck/cache shell and compact HUD polish.

This review does not add resources, inventory UI, scanner economy, field-guide UI, minimap behavior, or new route logic.

Related docs:

- `docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md`
- `docs/planning/SCANNER_FEEDBACK_SIGNAL_VS_ECHO_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SHELL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/Main.tscn`
- `scripts/main.gd`
- resource visual scenes under `scenes/resources/`
- scan marker/helper coverage in `tests/logic_tests.gd`

## Resource Review

| Resource | Current Read | Decision |
| --- | --- | --- |
| Kelp Fiber | Green frond/stem silhouette and matching cargo mini-icon stay distinct from the cooler pressure shell. | Pass |
| Shell Fragments | Pale shell shard silhouette remains material/cargo language, not pressure-wreck shell environment language. | Pass with watchlist |
| Glow Plankton | Yellow-green bloom/core remains the loudest reward/resource language near deep temptation. | Pass |

The pressure shell does not make cargo pickups harder to distinguish. It is larger, cooler, and lower-priority environment mass; resource pickups remain compact, brighter, and tied to cargo slots.

Watchlist: Shell Fragments and pressure wreck shell both use "shell" language in planning names, but in-game shape/color roles are separate enough. If future art makes wreck plating too pale/yellow, recheck Shell Fragments.

## Scan Target Review

| Scan Affordance | Current Read | Decision |
| --- | --- | --- |
| Non-resource scan markers | Pale diamond/bracket marker language still hugs scannable targets. | Pass |
| Outside pressure scan | Still reads as a pressure-route clue, separate from the gate and cache. | Pass |
| Wreck Signal Cache | Still reads as a local payoff/mystery object, not a global objective marker. | Pass |
| Thermal Vent / Shell Reef Shelf | Existing landmark scan targets remain visually separate from the lower pressure shell. | Pass |
| Selected scan target HUD | `Scan:` line names one target compactly and keeps discovery/type metadata bounded. | Pass with watchlist |

The pressure shell did not add a competing scan-marker shape, route arrow, exact locator, or permanent objective icon.

## Signal Lens Pulse Language

`Signal Lens I` remains practical resource-signal behavior. It should continue to read as local material help, not Wreck Echo navigation.

The pressure shell does not change:

- scan target selection,
- first-time scan costs,
- repeat-scan free refresh behavior,
- matching-deposit highlight behavior,
- `Signal Lens I` resource pulse scope,
- `Echo Lens I` broad/no-locator language.

## Affordance Separation

Current role separation remains acceptable:

- resources: compact material shapes and cargo-slot colors,
- scan/knowledge: pale diamonds/brackets plus `Scan:` HUD target line,
- pressure shell: cool environmental wreck mass,
- pressure gate: firmer blue bars/badge,
- cache/Echo Lens: local mystery pulse,
- predator: red/orange danger lane,
- safe return: cyan/seafoam route orientation.

## Follow-Up Decision

No blocker issue is needed from this review.

#332 should still decide whether a future source-art target is needed. If it is, the likely target should be scan affordance polish rather than a new resource set, because resources currently read well enough and the remaining watchlist is about keeping selected scan, resource signal, and Echo Lens language distinct.

## Guardrails

Do not add:

- new resource types,
- inventory grid,
- scanner energy economy,
- field guide,
- minimap,
- exact locator,
- objective checklist,
- route graph,
- persistent scan marker,
- new Wreck Echo route behavior.

## Recommendation

Pass with watchlist.

The pressure shell improves lower-route environment readability without stealing the visual language used by cargo/resources or scan targets. The next decision should be whether scan affordance source art is needed for polish, not whether resources need immediate replacement.
