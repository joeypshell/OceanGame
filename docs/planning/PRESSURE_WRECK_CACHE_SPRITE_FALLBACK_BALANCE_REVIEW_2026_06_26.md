# Pressure Wreck And Cache Sprite/Fallback Balance Review - 2026-06-26

Status: review artifact for issue #247.

## Scope

Reviewed pressure wreck, pressure gate, outside scan, Wreck Signal Cache, and Echo Lens pulse readability after recent sprite wiring, scene extraction, and lower-route density tuning.

Related docs:

- `docs/planning/PRESSURE_WRECK_CACHE_PROVENANCE_SCENE_REVIEW_2026_06_26.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/planning/RARE_SIGNAL_CONDITION_READABILITY_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/readability/PressureWreckVisuals.tscn`
- `scenes/Main.tscn`
- local screenshot: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_pressure_wreck_review_2026_06_26/oceangame_pressure_wreck_locked_outside_scan_2026_06_26.png`
- local screenshot: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_pressure_wreck_review_2026_06_26/oceangame_pressure_wreck_open_cache_echo_2026_06_26.png`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshots remain local and are not committed as source assets.

## Readability Review

| Element | Current Read | Decision |
| --- | --- | --- |
| Locked gate | The blue bars, shimmer, and `LOCKED` badge clearly communicate a blocked route. | Keep visible. |
| Outside scan | The outside wreck scan target is selectable and distinct from the lock. The player can read it as a practical clue before opening the route. | Keep sprite plus subdued scan marker. |
| Open route | `OPEN` badge and green softened gate communicate passability without implying a new safe path. | Keep. |
| Inside cache | Cache sprite and fallback glow read as a local reward/mystery object inside the wreck alcove. | Keep sprite and core fallback. |
| Echo Lens pulse | Pulse is temporary and local around the cache. It does not read as a remote marker in the reviewed capture. | Keep local-only. |
| Predator overlap | Predator warning lane sits close below the wreck/cache area and remains the main overlap risk. | Continue watchlist. |

## Keep Visible

- `PressureGateVisuals` bars/badge/label: primary lock/open state.
- `WreckHull`, `WreckKeel`, `WreckBrokenBow`, and `WreckInteriorShadow`: place identity for the wreck.
- Outside scan sprite: practical pressure-seal clue.
- Cache sprite and compact `CacheVisual`: local mystery payoff.
- `EchoPulse`: temporary local Echo Lens feedback only.

## Subdue Or Review Later

- `PromiseGlow` and `SignalHalo`: keep subdued. Brightening these risks making the whole wreck look like a remote objective.
- Outside/cache scan markers: keep lower priority than the pressure badge until the player is close.
- Predator lane fills below the wreck: already toned down, but still the highest overlap risk in screenshots.

## Guardrails

- No map marker.
- No exact locator.
- No field-guide entry.
- No objective checklist.
- No guaranteed safe route.
- No pressure bypass.
- No new cache rewards or deeper route behavior from this review.

## Recommendation

Pass with watchlist.

The pressure wreck/cache stack is now separated enough for the current vertical slice: lock/open state, outside clue, inside cache, and local Echo Lens pulse each read as distinct concepts. Future art should avoid merging the hull, gate, cache, and signal into one icon-like marker.
