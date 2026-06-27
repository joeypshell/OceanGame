# Salvage Cutter Return Payoff Validation - 2026-06-27

## Decision

Pass with watchlist.

The Salvage Cutter return payoff is coherent enough to close the Area 01 readability/cutter-payoff sequence. Prior exploration now has a visible consequence: the earlier salvage cache and cutter promise lead back to a remembered Wide Reef place, the owned cutter opens the wreck pocket, and the player can recover a manifest that creates compact result and recent-expedition memory.

## What Changed For The Player

- `CUTTER NEEDED` becomes an opened salvage pocket once `Salvage Cutter I` is owned.
- The opened pocket has a small local timing read, a quiet safe-return cue, optional nearby shell cargo, and one amber manifest knowledge payoff.
- Recovering the manifest is run-scoped until extraction/result readback; it does not create a salvage inventory, map marker, exact locator, or durable route-state flag.
- The result/recent log can remember `Salvage Pocket` as the run's meaningful route choice.

## Guard Coverage

- Existing `wide_reef_salvage_open` web staging remains the deterministic visual path for normal-scale captures.
- New logic coverage verifies that hidden debug staging does nothing outside web/debug review.
- New logic coverage verifies that opened-pocket staging prepares the cutter visual state without auto-completing the manifest or earlier cache payoff.
- New logic coverage verifies that the manifest payoff remains normal interaction state, resets between expeditions, and records only session/recent-route memory.

## Remaining Watchlist

- The payoff still happens inside a short Area 01 route. It proves the upgrade-return loop, but it does not yet make the ocean feel large.
- The placeholder polygon terrain remains acceptable for testing, not final art.
- The next batch should avoid another local polish/readability chain unless playtesting finds a new blocker.

## Next Player-Visible Direction

Move from Area 01 rescue into a larger-route progress batch: extend the authored ocean toward a bigger side-view region with at least one memorable branch, one pressure or timing choice, one creature/read behavior, and one surface result that makes the next expedition feel different.

The immediate next work should prioritize playable route growth and reasons to dive again over more HUD, screenshot, or label tuning.

## Verification

- `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick`
- `git diff --check`
