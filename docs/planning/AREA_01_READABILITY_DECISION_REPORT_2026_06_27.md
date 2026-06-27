# Area 01 Readability Decision Report - 2026-06-27

## Decision

Needs readability fixes.

The Area 01 Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket cluster is no longer blocked by the worst bright-cue pileup, but it is still borderline for comfortable playtesting. Keep #622 and #623 paused. Do one more small readability-only pass before adding a salvage-pocket timing hazard, passive creature read, route content, upgrade, resource, or new promise.

## Capture Set

Captured with existing Godot Web export plus Playwright staging at `1280x720`.

- `hollow_reef_route`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/hollow_reef_route.png`
- `hollow_reef_return`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/hollow_reef_return.png`
- `wide_reef_chamber`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/wide_reef_chamber.png`
- `wide_reef_salvage_open`: `C:/Users/pirat/AppData/Local/Temp/oceangame-area01-readability-review-2026-06-27/wide_reef_salvage_open.png`

Metadata JSON files were written beside each screenshot in the same temp folder.

## Review Notes

- Player/sub focal point: pass. The sub remains readable in all four staged captures.
- Pickup vs knowledge payoff distinction: pass with watchlist. Green cargo-like pickups, cyan data shards, and amber document payoff now read as different cue families.
- Locked/future promises: pass. `DEEP CLOSED`, `CUTTER NEEDED`, `SALVAGE`, and `KELP SEALED` read quieter than recoverable objects.
- Return/timing support: pass with watchlist. Safe-return bands generally stay below payoff brightness, but the central Wide Reef current chain still occupies a lot of screen weight.
- Playable water vs terrain/background: needs one more pass. The Hollow Reef and Wide Reef route bands are improved but still visually busy where return-current ribbons, cave shelf silhouettes, and payoff glows overlap.
- Active HUD overlap: needs one more pass. In the Hollow Reef route/return captures, the active info panel covers a large portion of the left-side route and makes the local route harder to inspect.
- Labels: pass with watchlist. World labels are sparse enough, but the active prompt still carries much of the interaction comprehension.

## Recommended Tiny Fix List

1. Reduce active lower-route HUD obstruction during staged/deep route play by tightening the dive info panel or shortening/wrapping its prompt/status text so it covers less route space.
2. Quiet the Hollow Reef return/current ribbon stack one more notch where it overlaps cave shelf silhouettes and payoff glows.
3. Recheck the same four staged captures after those fixes. If they pass, mark Area 01 readability accepted with watchlist and unpause #622 under the existing light/sparse hazard constraint.

## Next Issue Order

1. Area 01 readability-only fixes from this report.
2. Repeat the four-state readability capture check.
3. If accepted, resume #622 with one light salvage-pocket timing/read addition.
4. Run #623 only after #622 is completed, rewritten, or intentionally skipped.

## Verification

- `npm.cmd run web:export`
- Targeted Playwright staged capture script using `tests/playwright/visual-helpers.mjs`
