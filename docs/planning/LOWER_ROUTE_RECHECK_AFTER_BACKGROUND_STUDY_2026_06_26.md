# Lower-Route Recheck After Background Study - 2026-06-26

Status: review artifact for issue #310.

## Purpose

Recheck lower-route readability now that `ShallowMidwaterBackgroundStudy` is wired as a subdued source-art layer.

This review does not add gameplay, change the scene, or approve new lower-route content. It only decides whether the current background art creates new shape pileup or remains acceptable behind the existing route cues.

## Evidence Reviewed

- `docs/planning/LOWER_ROUTE_READABILITY_RECHECK_2026_06_26.md`
- `docs/planning/SHALLOW_MIDWATER_BACKGROUND_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `scenes/Main.tscn`
- `scenes/readability/PressureWreckVisuals.tscn`

No new screenshots were committed for this recheck.

## Scene Layer Notes

`ShallowMidwaterBackgroundStudy` is a `Sprite2D` placed after the shallow/midwater color bands and before transition bands, return cues, shallow silhouettes, midwater shelves, deep reward lure, pressure wreck/cache nodes, player, gameplay pickups, predators, and HUD.

The lower-route cluster remains owned by:

- `DeepRewardLure`,
- `PressureLockedWreck/Visuals`,
- `PressureLockedWreck/OuterScan`,
- `PressureLockedWreck/WreckSignalCache`,
- `WreckSignalCache/EchoPulse`,
- Gulper warning/patrol/chase visuals,
- compact active HUD panels.

## Element Recheck

| Element | Readability After Background Study | Decision |
| --- | --- | --- |
| Pressure gate/cache | The background study does not use gate bars, lock badges, cache-core brightness, or pressure shimmer language. The lower-route pressure/cache stack remains the main blocked-promise/mystery read. | Pass with watchlist |
| Predator lane | The study avoids red, tooth/jaw silhouettes, warning-current geometry, and predator marker contrast. Predator/wreck overlap remains a lower-route watchlist, but not because of the background. | Pass with watchlist |
| Reward lure | The study avoids the brighter lime/yellow reward language used by `DeepRewardLure` and Glow Plankton. Reward temptation can still compete with scan/cache brightness if all are visible together. | Pass with watchlist |
| Safe return | Return column, ribs, and beacon remain higher-priority safe-return language than the background. If return comprehension weakens, tune return cues or HUD copy before making background shapes more directional. | Pass |
| Active HUD contrast | The background is world-space and low-priority. Compact HUD panels remain visually above it; remaining HUD watchlists belong to prompt/title/low-oxygen polish, not this background layer. | Pass |

## Decision

Pass with watchlist.

The shallow/midwater background study does not introduce new lower-route shape pileup in the current reviewed state. It should remain subdued and behind gameplay cues.

The lower route is still dense, but the active risks are the already-known pressure wreck/cache, reward lure, predator lane, and HUD-state intersections. Those should be handled through the selected pressure wreck/cache shell pass, compact HUD polish, or focused screenshot rechecks rather than by changing the background.

## Guardrails

Do not use this review to add:

- new lower-route gameplay,
- Wreck Echo Descent implementation,
- new scan targets,
- new pressure-dark threshold wiring,
- background parallax,
- foreground occluders near the Gulper route,
- minimap, route graph, field guide, exact locator, quest log, or objective checklist.

## Follow-Up Guidance

Future source-art work should keep the background behind:

1. the player sub,
2. oxygen/HUD state,
3. safe return cues,
4. pressure gate/cache state,
5. predator danger,
6. resources and scan targets.

If normal-scale screenshots later show confusion in the lower route, tune the pressure/cache shell or predator/reward contrast first. Do not brighten or animate the background to solve a lower-route decision problem.
