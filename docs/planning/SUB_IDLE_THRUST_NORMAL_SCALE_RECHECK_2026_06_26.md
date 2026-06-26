# Sub Idle/Thrust Normal-Scale Recheck - 2026-06-26

Status: review artifact for issue #288.

## Purpose

Recheck the player sub idle bubble, movement trail, thrust flare, and facing behavior after active HUD and first-run readability cleanup.

## Evidence Reviewed

- `docs/planning/SUB_IDLE_THRUST_POLISH_REVIEW_2026_06_26.md`
- `scenes/Player.tscn`
- `scripts/player.gd`
- `tests/logic_tests.gd`
- `docs/current/GAMEPLAY.md`

Existing tests cover visual-facing isolation and idle/thrust visibility states.

## Recheck

| Check | Decision |
| --- | --- |
| Idle bubble | Pass with watchlist. Reads as ambient bubble treatment, not thrust. |
| Moving bubble trail | Pass. Brightens while moving and stays subtle while idle. |
| Thrust flare | Pass with watchlist. Reads as rear propulsion rather than a second facing frame. |
| Facing changes | Pass. Only `VisualRoot` flips, so collision/physics/camera roots remain stable. |
| Double-direction artifact | Pass. Current structure should not show both facing directions at once. |
| Gameplay isolation | Pass. Visual states do not change movement, burst, oxygen, collision, or bounds. |

## Decision

Pass with watchlist.

The current sub visual-state setup is readable enough for the vertical-slice closeout. Future polish should target source-art/animation clarity, not movement or physics changes.

## Follow-Up

Issue #289 should define constraints for any future sub idle/thrust source-art polish.
