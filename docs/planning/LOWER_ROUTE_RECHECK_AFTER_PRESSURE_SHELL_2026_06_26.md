# Lower-Route Recheck After Pressure Shell - 2026-06-26

Status: review artifact for issue #322.

## Scope

Rechecked the lower-route pressure/cache/predator stack after wiring the pressure wreck/cache source-art shell. This review is readability-only and does not add gameplay scope.

Related docs:

- `docs/planning/LOWER_ROUTE_RECHECK_AFTER_BACKGROUND_STUDY_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SOURCE_ART_SHELL_CONSTRAINTS_V2_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SHELL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`

Evidence:

- `scenes/Main.tscn`
- `scenes/readability/PressureWreckVisuals.tscn`
- wired pressure wreck/cache shell source and export assets

No committed screenshots or runtime changes are added by this pass.

## Recheck Matrix

| Element | Current Read After Shell Pass | Decision |
| --- | --- | --- |
| Pressure gate/cache | The shell reduces the old bright-triangle pileup and makes the wreck read as one calmer environment. Gate bars, lock/open badge, outside clue, and cache remain separate enough to understand their roles. | Pass with watchlist. |
| Predator lane | The Gulper lane is still visually adjacent to the lower wreck/cache stack. It reads as route danger rather than wreck decoration, but it is still the tightest overlap in this area. | Pass with watchlist. |
| Reward lure | Deep reward color remains tempting and distinct from the cooler shell, but warm reward shapes can compete with cache/route cues when clustered near pressure art. | Pass with watchlist. |
| Safe return | Base direction, return column, surface direction, and compact HUD remain higher-priority than the shell. The shell does not create a false return path. | Pass. |
| Active HUD contrast | Active HUD panels remain separate from world-space shell art. Remaining HUD concerns belong to the final compact HUD polish pass rather than the pressure shell. | Pass. |

## Shape-Pileup Decision

The shell pass reduces shape pileup. It replaces part of the earlier lower-route read, where hull, cache, pressure shimmer, reward, and predator support shapes all looked like similarly bright prototype polygons.

It does not create new confusion in the reviewed contract because:

- it stays behind the pressure gate/cache state,
- it uses cooler environment color instead of reward or warning color,
- it does not introduce route arrows, exact-locator shapes, or minimap-like symbols,
- it keeps the predator lane visually separate enough for the current vertical slice,
- it preserves the existing safe-return and HUD hierarchy.

## Follow-Up Decision

No new blocker issue is needed from this recheck.

Existing planned work already covers the remaining risks:

- #323 and #324: compact HUD final polish and normal-scale review.
- #326 and #327: Decoy Pulse/Gulper timing readability.
- #328: Wreck Echo readiness gate after shell and HUD polish.
- #331 and #332: resource/scan affordance readability and source-art target selection if needed.

Do not add more lower-route concepts until these watchlists are cleared.

## Guardrails

- Do not implement `Wreck Echo Descent` from this review.
- Do not add new routes, collision, pressure zones, resources, upgrades, predators, or scan targets.
- Do not add minimap, route graph, field guide, exact locator, objective checklist, or persistent marker UI.
- Do not brighten pressure gate, cache, Echo Lens pulse, reward lure, and predator lane at the same time.
- Keep predator danger avoidable and route-timing based.

## Recommendation

Pass with watchlist.

The pressure shell is doing the job it was chosen for: it calms the lower-route environment and gives the wreck a more coherent mass. The current next step should be HUD final polish, not another lower-route art change.
