# Decoy Pulse HUD And Predator Review After HUD Polish - 2026-06-26

Status: review artifact for issue #326.

## Scope

Reviewed `Decoy Pulse I` owned-state HUD and predator visual state after the final compact HUD polish. This is a readability review only; it does not change predator behavior, scan behavior, route layout, or HUD systems.

Related docs:

- `docs/planning/DECOY_PULSE_OWNED_STATE_REVIEW_2026_06_26.md`
- `docs/planning/DECOY_PULSE_RESULT_MEMORY_HUD_SMOKE_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scripts/main.gd`
- `scripts/predator.gd`
- `tests/logic_tests.gd`
- `scenes/Main.tscn`

No new screenshots or runtime changes are added by this pass.

## Prompt And Status Review

| State | Player-Facing Read | Decision |
| --- | --- | --- |
| Unavailable | `Predator route warning refreshed. Decoy Pulse unavailable.` | Pass. It does not imply an owned tool. |
| Locked | `Decoy locked` after Gulper discovery but before ownership. | Pass with watchlist. Compact enough for the polished HUD; dependency detail belongs in the upgrade bay, not the active prompt. |
| Ready | `F: decoy ready` plus `Decoy Pulse ready on re-scan.` | Pass. It communicates owned, unused, one-use availability without adding a tool wheel or ammo counter. |
| Activated | `Decoy Pulse: Gulper Eel distracted briefly.` plus `Decoy Pulse spent: predator distracted for 3s.` | Pass. `distracted briefly` and duration language read as route timing, not damage or victory. |
| Spent | `Decoy spent` plus `Decoy Pulse already spent this expedition.` | Pass. It communicates one-use-per-expedition behavior without inventory-charge language. |
| Already-spent scan | Repeat scan refreshes warning text and says the pulse is already spent. | Pass. It prevents cooldown/second-use confusion. |

## Predator Visual Review

The temporary green decoy state is acceptable for the current slice.

It reads as distraction because:

- it is temporary,
- the player-facing copy says `distracted` and `briefly`,
- the result memory says `Decoy timing bent the Gulper route briefly`,
- no health bar, hit flash, damage number, loot marker, capture marker, or victory language appears,
- the red warning/chase language remains the predator's danger identity outside the short decoy window.

It does not read as damage, stun-lock, capture, harvest, trap, taming, removal, or permanent control.

## Contact And Mistiming

Predator contact remains possible after mistiming or after the decoy window ends.

Confirmed ownership boundaries:

- `Decoy Pulse I` does not change `detect_radius`, patrol endpoints, route selection, contact oxygen cost, knockback, pressure locks, extraction, cargo failure, save/load, or `Burst Thruster`.
- `Predator Warning I` can widen warning lead distance, but it does not remove chase/contact risk.
- `Decoy Pulse I` creates one short route-timing window per expedition, not safety.

## Nearby Cue Separation

The final compact HUD and pressure-shell pass keep nearby cue families distinct enough:

- predator route: red warning lane, chase state, Gulper sprite/overlays,
- decoy state: temporary green distraction,
- pressure/cache: blue pressure gate, lock/open badge, cache core, Echo Lens pulse,
- reward lure: warm/green Glow Plankton temptation,
- safe return: base direction and return column/ribs.

Watchlist: the lower route remains dense, so future Wreck Echo or predator work should avoid brightening decoy, reward, cache, and pressure cues at the same time.

## Follow-Up Decision

No new blocker issue is needed from this review.

The next queued issue, #327, should review timing-result clarity across scan, contact, and decoy outcomes. That is the right place to check whether the result summary distinguishes learning-by-scan, learning-by-contact, and learning-by-decoy cleanly.

## Guardrails

Do not add:

- weapons,
- predator health,
- damage, stun, kill, harvest, trap, capture, tame, control, or loot language,
- decoy ammo crafting,
- permanent predator route removal,
- combat UI,
- minimap, field guide, objective checklist, or exact locator,
- pressure bypasses or route shortcuts.

## Recommendation

Pass with watchlist.

`Decoy Pulse I` now fits the polished active HUD: it is short enough to coexist with `Burst Thruster`, its feedback reads as one-use route timing, and the predator remains dangerous rather than defeated.
