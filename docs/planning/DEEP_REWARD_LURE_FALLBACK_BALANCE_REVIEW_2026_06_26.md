# Deep Reward Lure Fallback Balance Review - 2026-06-26

Status: pass with lower-route watchlist.

Issue: #397.

## Purpose

Review whether the new `deep_reward_lure_sprite_v1.svg` source-art pass can carry the optional material-opportunity read while the older `DeepRewardLure` fallback geometry stays dimmed but available.

This review does not change gameplay, route layout, scanner behavior, predator behavior, Wreck Echo scope, controller/touch support, minimaps, field guides, quest checklists, combat, or procedural generation.

## Evidence

- `npm.cmd run test:visual` passed after the source-art pass.
- Reviewed `lower-route-pressure-gate.png` from the current Playwright run.
- `tests/logic_tests.gd` now guards the sprite slot, texture presence, sprite alpha, and dimmed fallback alpha.

## Findings

| Element | Read | Decision |
| --- | --- | --- |
| Deep reward sprite | Amber/material shell reads more like optional reward than green/cyan signal or red danger. | Keep |
| Fallback core | Still present but subdued under the sprite. | Keep dimmed |
| Distant bloom and particles | Lower alpha reduces competition with cache/Wreck Echo and predator lane. | Keep dimmed |
| Current trail | Warm, very low-alpha trail is less likely to be confused with cache/Wreck Echo signal language. | Keep dimmed |
| Predator lane relationship | Red danger remains louder than the reward cue. | Pass |
| Pressure/cache relationship | Cache and pressure structure remain readable; reward cue no longer shares as much green/yellow signal language. | Pass with watchlist |

## Decision

Keep the source sprite and the dimmed fallback stack. Do not remove fallback geometry yet; it still provides local reward presence if the sprite is partially obscured at normal scale.

The reward cue is improved enough to proceed to the next lower-route review, but the broader lower-right cluster should stay on the watchlist before polished acceptance.

## Follow-Up

- Recheck lower-route screenshots after any additional pressure/cache, Wreck Echo, or predator visual changes.
- Do not brighten the reward cue unless evidence shows players miss it entirely.
- Do not add a map marker, objective label, inventory grid, or new reward system to solve readability.
