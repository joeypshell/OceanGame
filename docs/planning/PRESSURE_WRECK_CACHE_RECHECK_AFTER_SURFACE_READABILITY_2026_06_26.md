# Pressure Wreck/Cache Recheck After Surface Readability - 2026-06-26

Status: review artifact for issue #270.

## Purpose

Recheck the pressure wreck/cache stack after the compact HUD, lower-route density, active `Discoveries`, surface moonpool/waterline, surface panel opacity, upgrade-tab, and no-debug surface sanity passes.

This review is not an implementation plan for `Wreck Echo Descent`. It only decides whether the existing pressure wreck/cache route remains readable enough for the current playable vertical slice.

## Evidence Reviewed

- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/planning/LOWER_ROUTE_READABILITY_RECHECK_2026_06_26.md`
- `docs/planning/SURFACE_MOONPOOL_WATERLINE_REVIEW_2026_06_26.md`
- `docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md`
- `docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`

No new Wreck Echo content was added for this recheck.

## Combined Readability Check

| Element | Current Read | Decision |
| --- | --- | --- |
| Locked gate | Blue shimmer, bars, and locked badge remain the dominant pressure-access signal. | Pass |
| Outside scan | Outside scan remains a practical route clue rather than a reward, map marker, or alternate entrance. | Pass |
| Open route | Open badge/softened gate still reads as first pressure route access after `Pressure Seal I`, not a safe fast-travel path. | Pass |
| Wreck Signal Cache | Cache stays a local mystery payoff inside the wreck stack. | Pass with watchlist |
| Echo Lens pulse | Pulse remains temporary and local around the cache; it does not become an exact locator. | Pass |
| Predator-lane overlap | Red predator lane remains close to the wreck/cache region and is still the main composition risk. | Pass with watchlist |
| Surface/HUD changes | Recent surface and HUD changes do not add new lower-route text overlap or debug clutter. | Pass |

## Decision

Pass with watchlist.

The route still has a dense lower-right composition, but the concepts remain separable:

- blue pressure access,
- pale outside scan clue,
- interior cache/mystery payoff,
- temporary local Echo Lens feedback,
- red predator danger below/nearby.

The next pressure-wreck/cache work should be a constrained art/readability pass only if the route becomes confusing in fresh normal-scale screenshots. It should not add new deeper-route behavior yet.

## Guardrails

- Do not implement `Wreck Echo Descent` from this recheck.
- Do not add a minimap, route graph, exact scanner locator, field-guide UI, objective checklist, or persistent quest marker.
- Do not use predator danger as combat/loot framing.
- Do not brighten cache, pulse, and pressure-gate cues all at once.
- Keep future Wreck Echo language local, broad, and curiosity-driven.
