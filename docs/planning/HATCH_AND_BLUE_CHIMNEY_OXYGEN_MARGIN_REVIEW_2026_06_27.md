# Hatch And Blue Chimney Oxygen Margin Review - 2026-06-27

Status: keep current oxygen tuning; pass with watchlist.

## Context

Reviewed oxygen fairness after the route-growth batch added:

- `Resonance Key I` as a narrow hatch-specific upgrade,
- an opened `Sealed Shelf Hatch` visual state,
- `Resonance Alcove` as one small hatch-adjacent research pocket,
- `Blue Chimney Pocket` below `Shelf Drop Connector`,
- `Blue Chimney` landmark metadata,
- `Reverse Draft` as a visual-only timing/navigation cue,
- `Rare Signal` lower-pocket temptation,
- deterministic Playwright captures for the opened hatch/alcove and Blue Chimney pocket.

Current oxygen model remains:

- passive drain: `0.95` oxygen per second,
- pickup cost: `1` oxygen,
- first-time scan cost: `2` oxygen,
- burst cost: `4` oxygen,
- predator contact cost: `5` oxygen,
- base max oxygen: `30`,
- `Oxygen Tank I` max oxygen: `40`.

## Judgment

Do not tune oxygen yet.

The new route additions are intentionally optional and mostly knowledge/readability focused. `Resonance Alcove` adds one run-scoped research note after the player has already invested in `Resonance Key I`; `Blue Chimney Pocket` adds a compact lower-pocket shell, landmark, return cue, visual timing cue, and optional `Rare Signal` temptation. None of these add hidden oxygen drains, depth penalties, pressure damage, movement force, cargo requirements, combat, or mandatory route objectives.

The current oxygen pressure is doing the right job: it asks whether the player should inspect one more branch or return safely. Retuning now would risk weakening the core return decision before the lower pocket has a real interaction/payoff and before there is manual traversal evidence from ordinary play.

## Watchlist

Reopen tuning only if evidence shows one of these:

- a clean base-oxygen route to East Shelf plus `Resonance Alcove` fails without scans, pickups, burst, or predator contact,
- `Oxygen Tank I` cannot support a reasonable East Shelf -> Shelf Drop -> Blue Chimney look-and-return route,
- low/critical oxygen warnings arrive too late to make a return decision from Blue Chimney,
- players interpret `Rare Signal` as mandatory and fail because they overcommit before the route is readable,
- Playwright/manual captures show the return cue is too weak, causing route confusion that looks like oxygen unfairness.

## Recommendation

Keep oxygen constants unchanged for now.

If future evidence requires a change, prefer local route/readability fixes before global oxygen tuning:

1. Strengthen or reposition the `Reverse Draft` return cue.
2. Move the Blue Chimney pocket slightly up-left or reduce visual temptation before `Oxygen Tank I`.
3. Add clearer result/ready copy that frames Blue Chimney as optional.
4. Only after those fail, consider small passive drain or action-cost changes.

Do not add decompression, ascent drain, depth-based drain, pressure damage, connector tolls, oxygen refills, or hidden route penalties.

## Verification Note

This review changes no scripts, scenes, resources, oxygen constants, costs, movement, upgrades, save/load behavior, route collision, or Playwright tests. It records the tuning decision after the hatch/alcove/lower-pocket expansion so future issues do not retune oxygen without evidence.
