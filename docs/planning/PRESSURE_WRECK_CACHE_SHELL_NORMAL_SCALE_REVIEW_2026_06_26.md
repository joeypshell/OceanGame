# Pressure Wreck/Cache Shell Normal-Scale Review - 2026-06-26

Status: review artifact for issue #321.

## Scope

Reviewed the wired pressure wreck/cache source-art shell after the first shell pass. This review is limited to normal-scale readability and fallback-geometry balance. It does not approve new route behavior.

Related docs:

- `docs/planning/PRESSURE_WRECK_CACHE_SOURCE_ART_SHELL_CONSTRAINTS_V2_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/readability/PressureWreckVisuals.tscn`
- `scenes/Main.tscn`
- `assets/source/sprites/pressure_wreck_cache_shell_sprite_v1.svg`
- `assets/exports/sprites/pressure_wreck_cache_shell_sprite_v1.svg`

Capture note: this review uses the normal-scale scene and wiring contract after the source-art shell pass. No screenshots are committed as source artifacts.

## Readability Review

| State | Review | Decision |
| --- | --- | --- |
| Locked gate | The lock bars, badge, and pressure shimmer still own the blocked-route read. The shell supports wreck context without replacing the gate. | Pass. Keep gate visuals primary. |
| Outside scan | The outside clue remains distinct from the gate and from the inside cache. It still reads as a pressure-route clue rather than a reward. | Pass. Keep scan marker and clue sprite visible. |
| Open route | The green/open gate treatment still communicates passability after `Pressure Seal I`. The shell does not imply a separate shortcut or new path. | Pass with watchlist. Keep open badge stronger than shell glow. |
| Wreck Signal Cache | The cache remains the local payoff inside the pressure route. The shell frames the alcove but does not become the reward marker itself. | Pass. Keep cache sprite and compact fallback glow. |
| Echo Lens pulse | Echo feedback remains temporary and local to the cache. The shell does not turn the pulse into an exact locator. | Pass. Keep pulse broad/local only. |
| Predator-overlap state | The shell reduces the earlier pile of bright fallback polygons, but the predator lane still sits close to the gate/cache stack. | Pass with watchlist. Recheck in #322. |
| Reward-lure adjacency | Deep reward lure, cache, and gate now have more separation than before, but warm/yellow lures still need caution near the shell. | Pass with watchlist. Keep lures lower priority than player, predator, and gate. |

## Fallback Geometry Decision

Keep these visible:

- `PressureGateVisuals` bars, badge, and pressure shimmer.
- Outside clue sprite and scan marker.
- `WreckSignalCache` sprite, compact fallback core, and temporary `EchoPulse`.
- The new pressure wreck/cache shell source art.

Keep subdued for now:

- `WreckHull`, `WreckKeel`, `WreckBrokenBow`, `WreckInteriorShadow`, `SignalLight`, and `SignalHalo`.
- Nearby pressure/wreck atmosphere used for layout context.

Do not delete fallback geometry yet. The source-art shell improves the silhouette, but the existing fallback pieces still provide route-frame and gate/cache separation at the current prototype scale. Cleanup should wait until normal-scale screenshots prove the shell can carry the read without weakening the lock, cache, predator, or safe-return hierarchy.

## Explicit Non-Goals Confirmed

This pass introduced no:

- `Wreck Echo Descent` route,
- new route pocket,
- new scan target,
- new resource, reward, upgrade, predator, biome, or procedural rule,
- minimap, route graph, field guide, quest log, exact locator, objective checklist, or persistent marker,
- pressure bypass, shortcut, collision change, oxygen change, cargo change, save/load change, or progression change.

## Recommendation

Pass with watchlist.

The pressure wreck/cache shell is an improvement because it turns the lower-route wreck into a calmer environmental mass instead of a pile of bright triangles. The next risk is not the shell itself; it is the tight visual adjacency among pressure gate, cache, reward lure, and Gulper route. Resolve that with the dedicated lower-route overlap recheck before treating the pressure area as fully accepted.
