# Decoy Pulse Owned-State Review - 2026-06-26

Status: review artifact for issue #262.

## Purpose

Review `Decoy Pulse I` player-facing prompt, scan feedback, and result/status language when the upgrade is owned.

The countermeasure should read as a one-use non-lethal route-timing tool for the known `Gulper Eel` route. It must not imply combat, stun-locking, harvesting, trapping, capture, predator removal, or permanent control.

## Evidence Reviewed

- `scripts/main.gd` Decoy Pulse prompt, scan feedback, activation, and result research callout.
- `scripts/predator.gd` temporary decoy target/time behavior.
- `tests/logic_tests.gd` coverage for unavailable, locked, ready, activated, spent, and predator helper behavior.
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`.
- `docs/planning/PREDATOR_COUNTERMEASURE_I.md`.

No new screenshots were committed for this pass.

## State Review

| State | Current Player-Facing Read | Review |
| --- | --- | --- |
| Unavailable | `Predator route warning refreshed. Decoy Pulse unavailable.` | Pass. It does not imply the player has an active tool before the upgrade path exists. |
| Locked | `Decoy: locked in upgrades` after Gulper discovery but before ownership. | Pass with polish. It is compact, but future copy could name `Predator Warning I` if players miss the dependency. |
| Ready owned state | `F on Gulper: Decoy ready` in the active prompt and `Decoy Pulse ready on re-scan.` in scan feedback. | Pass with watchlist. It communicates owned-state readiness and ties use to re-scanning the Gulper. Watch prompt length when paired with `Burst Thruster`. |
| Activated | `Decoy Pulse: Gulper Eel distracted briefly.` and scan feedback reports the pulse was spent for about 3 seconds. | Pass. `distracted briefly` reads as temporary non-lethal route timing, not damage or defeat. |
| Spent | `Decoy: spent` and `Decoy Pulse already spent this expedition.` | Pass. It clearly marks one-use-per-expedition behavior without adding ammo/inventory language. |
| Result memory | `Research: Decoy timing bent the Gulper route briefly.` | Pass. It records route learning without combat rewards or field-guide scope. |

## Acceptance Decision

`Decoy Pulse I` owned-state language is acceptable for the current vertical slice.

The only watchlist is active prompt length when `Burst Thruster` and Decoy text appear together. That should be checked with normal-scale HUD screenshots before final polished acceptance, but it does not require a code change in this issue.

## Follow-Up Guidance

If the prompt feels too long in screenshots, prefer shortening rather than adding UI:

- `F: decoy ready`
- `Decoy ready`
- `Decoy spent`

Do not solve prompt length by adding a combat tool wheel, inventory charge display, field guide, or predator health/status UI.

## Non-Goals

- No weapons.
- No predator damage, harvest, capture, stun-lock, trap, or removal.
- No decoy ammo crafting or inventory charges.
- No permanent predator-control state.
- No changes to seeded predator route selection, oxygen/cargo rules, pressure locks, extraction, or `Burst Thruster`.
