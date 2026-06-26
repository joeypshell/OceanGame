# Decoy Pulse Result-Memory And HUD Smoke Note - 2026-06-26

Status: review artifact for issue #275.

## Purpose

Confirm that spending `Decoy Pulse I` produces understandable active feedback and result memory without drifting into combat, harvesting, stun/capture, or permanent predator-control language.

## Evidence Reviewed

- `docs/planning/DECOY_PULSE_OWNED_STATE_REVIEW_2026_06_26.md`
- `docs/planning/PREDATOR_COUNTERMEASURE_I.md`
- `docs/planning/MONSTER_RESEARCH_LOOP_V1.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `scripts/main.gd`
- `scripts/predator.gd`
- `tests/logic_tests.gd`

No code change is required for this pass.

## Smoke Read

| Moment | Player-Facing Read | Decision |
| --- | --- | --- |
| Owned, unused prompt | `F on Gulper: Decoy ready` | Pass with watchlist. It tells the player the action is tied to the known Gulper scan target. |
| Activation status | `Decoy Pulse: Gulper Eel distracted briefly.` | Pass. `distracted briefly` is temporary and non-lethal. |
| Scan feedback after activation | `Decoy Pulse spent: predator distracted for 3s.` | Pass. It explains duration without ammo/crafting UI. |
| Spent prompt | `Decoy: spent` | Pass. It keeps one-use-per-expedition behavior compact. |
| Repeat spent scan | `Decoy Pulse already spent this expedition.` | Pass. It prevents re-use confusion without implying cooldown or charges. |
| Result memory | `Research: Decoy timing bent the Gulper route briefly.` | Pass. It frames the payoff as route learning, not combat reward. |

## Decision

Pass with watchlist.

The current Decoy Pulse copy is understandable enough for the vertical-slice gate. It creates a short route-timing window and records a compact research result. It does not imply the predator was damaged, stunned, captured, harvested, removed, or permanently controlled.

The only remaining watchlist is active prompt length when `Burst Thruster` and Decoy prompt text appear together. If normal-scale HUD captures feel crowded, shorten the prompt copy rather than adding a tool wheel, ammo counter, inventory charge display, or predator status UI.

## Guardrails

- Use route-timing language: `briefly`, `distracted`, `decoy timing`, `route`.
- Avoid combat language: damage, stun, kill, trap, capture, harvest, tame, control, defeat, loot.
- Keep Decoy Pulse one-use-per-expedition.
- Keep predator contact possible after the short distraction window or on mistiming.
- Do not change pressure locks, extraction, cargo failure, seeded predator route selection, or `Burst Thruster`.
