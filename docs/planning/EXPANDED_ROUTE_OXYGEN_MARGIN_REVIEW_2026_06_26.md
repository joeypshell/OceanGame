# Expanded Route Oxygen Margin Review - 2026-06-26

Status: keep current oxygen tuning.

## Context

Reviewed the East Shelf pocket payoff and first `Shelf Drop Connector` route now that the branch has:

- East Shelf pocket interaction,
- current-surge timing cue,
- `Drop Arch` landmark and up-left return cue,
- `Drop Echo` run-scoped research opportunity,
- deterministic Playwright captures for East Shelf and lower connector.

Current oxygen model:

- passive drain: `0.95` oxygen per second,
- pickup cost: `1` oxygen,
- first-time scan cost: `2` oxygen,
- burst cost: `4` oxygen,
- predator contact cost: `5` oxygen,
- base max oxygen: `30`,
- `Oxygen Tank I` max oxygen: `40`.

## Judgment

Do not tune oxygen yet.

The new branch is intended to create a return-pressure question. The current implementation adds no hidden oxygen costs, no depth penalty, no pressure damage, and no extra scan cost. The player can also choose how far to push:

- inspect East Shelf pocket and return,
- continue into `Shelf Drop Connector`,
- record `Drop Echo`,
- turn back before lower-route research if oxygen feels low.

Because the route is still a prototype scaffold, tuning global drain or action costs now would risk weakening the already-proven central descent and lower-route pressure model. The right next evidence is a manual route pass after the connector is more naturally traversable, not immediate numeric tuning.

## Watchlist

Reopen tuning only if playtest or screenshot/video evidence shows one of these:

- a clean route to East Shelf pocket and back regularly fails at base `30` oxygen with no scans, pickups, burst, or predator contact,
- `Oxygen Tank I` at `40` oxygen still cannot support East Shelf pocket plus `Drop Echo` with normal piloting,
- low/critical oxygen feedback appears too late to make a meaningful return decision from the connector,
- players feel punished for entering the connector before they can read it as optional.

## Narrow Future Tuning Options

If evidence requires tuning, prefer the smallest local change first:

1. Move `Drop Echo` or the connector turnback slightly closer/up-left.
2. Improve return-current readability before changing oxygen numbers.
3. Slightly reduce route visual temptation before `Oxygen Tank I`.
4. Only then consider passive drain or action-cost tuning.

Do not add decompression, ascent drain, depth-based drain, pressure damage, connector tolls, or hidden oxygen penalties.

## Verification Note

This review changes no scripts, scenes, resources, oxygen constants, costs, movement, upgrades, save/load behavior, or route collision. It records the current tuning decision so future implementation issues do not retune oxygen preemptively.
