# Gulper Route Danger Readability Review - 2026-06-26

Status: review artifact for issue #248.

## Scope

Reviewed whether the Gulper route reads as avoidable danger with the current source sprite, warning overlays, patrol hint, reward lure, pressure lock proximity, and decoy visual state.

Related docs:

- `docs/planning/PREDATOR_WARNING_I.md`
- `docs/planning/PREDATOR_COUNTERMEASURE_I.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/Main.tscn`
- `scripts/predator.gd`
- local screenshot: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_gulper_route_review_2026_06_26/oceangame_gulper_route_warning_route_2026_06_26.png`
- local screenshot: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_gulper_route_review_2026_06_26/oceangame_gulper_route_close_chase_2026_06_26.png`
- local screenshot: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_gulper_route_review_2026_06_26/oceangame_gulper_route_decoy_window_2026_06_26.png`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshots remain local and are not committed as source assets.

## Readability Review

| Element | Current Read | Decision |
| --- | --- | --- |
| Warning lane | Red lane, ribs, bite mark, and eye read as danger before contact. It is distinct from the blue pressure gate and green reward lure. | Pass |
| Patrol | Gulper sprite and patrol hint read as a creature-controlled route, not a static wall. | Pass |
| Close/chase | Bright red state clearly communicates immediate danger. It does not resemble pressure lock, cache, or reward language. | Pass |
| Nearby reward | Glow/reward remains visible near the route, so the risk/reward relationship is clear. | Pass with watchlist |
| Decoy visual | Green decoy state reads as temporary interruption inside the red lane. It does not look like damage, harvesting, or predator defeat. | Pass |
| Decoy HUD hint | Existing HUD prompt distinguishes locked, ready, and spent states. The local screenshot only captured the locked prompt because ownership was not simulated. | Review later during upgrade-bay/decoy manual smoke |

## Guardrails Confirmed

- No combat UI.
- No health bar.
- No predator damage or harvesting read.
- No permanent route removal.
- No capture/trap language.
- No pressure-lock or cache confusion in reviewed frames.

## Watchlist

- The predator route remains close to pressure wreck/cache cues. Lower-route screenshots should keep checking that red danger stays separate from blue pressure and yellow/green reward/mystery signals.
- The active HUD covers some upper route context at this camera position. This is acceptable for danger readability but should be considered alongside the active HUD `Discoveries` placement follow-up.
- Decoy state should be rechecked in a manual smoke pass with `Decoy Pulse I` owned so the HUD prompt, status text, and predator visual state can be reviewed together.

## Recommendation

Pass with watchlist.

The current Gulper route reads as avoidable danger and supports the monster-observation direction: scan/learn, prepare warning/decoy tools, and decide whether the reward route is worth the oxygen risk. Do not add combat, harvesting, health, or stronger control language to improve readability.
