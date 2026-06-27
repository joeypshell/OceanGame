# Area 01 Readability Decision Report - 2026-06-27

## Decision

Pass with watchlist after tiny fixes.

The Area 01 Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket cluster is readable enough to resume the next light content issue. This is not final art, but the worst HUD overlap and return-current cue pileup are no longer blocking normal-scale playtest review. #622 may resume under the existing light/sparse timing-read constraint. #623 should remain ordered after #622 because it validates the Salvage Cutter Return Payoff milestone.

## Capture Set

Captured with existing Godot Web export plus Playwright staging at `1280x720`.

- `hollow_reef_route`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/hollow_reef_route.png`
- `hollow_reef_return`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/hollow_reef_return.png`
- `wide_reef_chamber`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/wide_reef_chamber.png`
- `wide_reef_salvage_open`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/wide_reef_salvage_open.png`

Follow-up capture set after the tiny readability fix pass:

- `hollow_reef_route`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-fix-2026-06-27-final2/hollow_reef_route.png`
- `hollow_reef_return`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-fix-2026-06-27-final2/hollow_reef_return.png`
- `wide_reef_chamber`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-fix-2026-06-27-final2/wide_reef_chamber.png`
- `wide_reef_salvage_open`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-fix-2026-06-27-final2/wide_reef_salvage_open.png`

Metadata JSON files were written beside each screenshot in the same temp folder.

## Review Notes

- Player/sub focal point: pass. The sub remains readable in all four staged captures.
- Pickup vs knowledge payoff distinction: pass with watchlist. Green cargo-like pickups, cyan data shards, and amber document payoff now read as different cue families.
- Locked/future promises: pass. `DEEP CLOSED`, `CUTTER NEEDED`, `SALVAGE`, and `KELP SEALED` read quieter than recoverable objects.
- Return/timing support: pass with watchlist. Safe-return bands are quieter than recoverable objects and no longer dominate the Wide Reef corridor, though this should stay watched as #622 adds one timing read.
- Playable water vs terrain/background: pass with watchlist. The authored polygon style is still placeholder-heavy, but the intended lane, cargo/payoff objects, and locked/future promises can be parsed without adding labels.
- Active HUD overlap: pass with watchlist. The active panel is narrower and lower-route prompt/status copy no longer wraps into unreadable overlap in the staged captures.
- Labels: pass with watchlist. World labels are sparse enough; future additions should avoid solving comprehension by adding more text.

## Recommended Tiny Fix List

1. Done: reduced active lower-route HUD obstruction with a narrower dive info panel, shorter prompt/status copy, and compact Burst Thruster command text.
2. Done: quieted Hollow Reef and Wide Reef return/current support shapes so they sit behind cargo, knowledge payoffs, and current goals.
3. Done: repeated the same four staged captures and accepted Area 01 readability with watchlist.

## Next Issue Order

1. Resume #622 with one light salvage-pocket timing/read addition.
2. Keep #622 visually sparse: no new bright reward/lock/label pile, no new route branch, and no additional resource/upgrades.
3. Run #623 only after #622 is completed, rewritten, or intentionally skipped.

## Verification

- `npm.cmd run web:export`
- Targeted Playwright staged capture script using `tests/playwright/visual-helpers.mjs`
- `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick`
