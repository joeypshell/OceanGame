# Sub Idle And Thrust Polish Review - 2026-06-26

Status: review artifact for issue #235.

## Scope

Reviewed the player sub idle bubble, bubble trail, thrust flare, and facing behavior after sprite integration.

Evidence reviewed:

- `scenes/Player.tscn`
- `scripts/player.gd`
- `tests/logic_tests.gd`
- `docs/current/GAMEPLAY.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md`

No new screenshots were committed for this pass.

## Findings

| Check | Finding |
| --- | --- |
| Idle state | Pass with polish. `IdleBubble` appears only while still; polygon was shifted upward/back so it reads as ambient bubbles rather than thrust. |
| Moving state | Pass. `BubbleTrail` brightens while moving and remains subtle while idle. |
| Thrust flare | Pass with polish. `ThrustFlare` is longer and narrower, so it reads more like rear propulsion behind the sprite. |
| Facing changes | Pass. `VisualRoot` is the only node flipped by `_set_facing_sign()`, so the physics root, collision, camera, and gameplay state remain unmirrored. Bubble and thrust nodes flip with the sprite instead of showing left/right simultaneously. |
| Gameplay isolation | Pass. Changes are visual-only scene polygon tuning; movement, collision, camera, oxygen, burst, and bounds behavior are unchanged. |

## Watchlist

- Re-check normal-scale screenshots after the compact HUD skin pass, because HUD and player readability compete near the surface.
- Keep `BubbleTrail`, `IdleBubble`, and `ThrustFlare` as separate nodes until a real animation setup replaces them.
- Do not add physics effects, speed changes, oxygen changes, or burst behavior changes from visual polish issues.

## Decision

Keep the current visual-state architecture. Future polish can replace these polygons with animation frames or particles, but should preserve the rule that facing flips only `VisualRoot` and movement/collision behavior is untouched.
