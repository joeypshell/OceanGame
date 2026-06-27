# Blue Chimney Readability And Oxygen Review - 2026-06-27

Status: pass with local-readability watchlist; keep oxygen tuning unchanged.

## Context

This review follows the first playable `Blue Chimney` payoff batch:

- compact `Blue Chimney Pocket` below `Shelf Drop Connector`,
- named `Blue Chimney` landmark and metadata,
- pulsing `Reverse Draft` return cue toward `Drop Arch`,
- `Rare Signal` visual opportunity,
- optional existing `Glow Plankton` candidate near the pocket,
- one run-scoped `Blue Chimney Draft Reading` interaction,
- compact extraction memory,
- reset/save guards for the run-scoped reading,
- deterministic Playwright captures for the lower-pocket and payoff states.

## Judgment

Do not change global oxygen numbers yet.

The current route asks the right question: after the player reaches the lower connector, do they have enough margin to inspect one more optional pocket and return safely? `Blue Chimney` does not add a direct oxygen cost, cargo requirement, hidden pressure penalty, movement force, predator mutation, save-state burden, or mandatory objective. The oxygen risk comes from distance, return routing, existing pickup/scan/burst choices, and normal predator/oxygen pressure.

The first likely problem is not oxygen math. It is local readability if the lower-pocket visuals, optional glow candidate, signal wash, closed crack, reverse draft, and player sprite compete in the same small camera view. If playtest evidence shows confusion, fix the local scene before changing survival constants.

## Readability Review

Current pass:

- `Reverse Draft` points broadly up-left toward the known return route instead of acting as an exact marker.
- The payoff text says to return safely, so the interaction does not imply the player has finished the dive.
- The optional `Glow Plankton` candidate uses existing seeded resource selection, so it should not add extra pickup count or mandatory cargo pressure.
- The ready/goal copy keeps `Blue Chimney` framed as optional and uses `if oxygen allows`.
- The Playwright capture suite now has both `blue-chimney-pocket-staged.png` and `blue-chimney-payoff-staged.png` for future visual comparison.

Watchlist:

- If the lower pocket reads as a pile of translucent shapes, reduce local overlap before adding new systems.
- If the closed lower crack looks like the main objective, make it quieter or move the draft/payoff cue higher.
- If the optional glow candidate distracts from the draft payoff, move the candidate slightly away from the interaction focus.
- If players cannot find the return path, strengthen the `Reverse Draft` or nearby `Drop Arch` return-current cue before changing oxygen.
- If low/critical oxygen feedback is missed from Blue Chimney, review HUD/camera readability before changing drain or costs.

## Oxygen Review

Keep current constants:

- passive drain: `0.95` oxygen per second,
- pickup cost: `1` oxygen,
- first-time scan cost: `2` oxygen,
- burst cost: `4` oxygen,
- predator contact cost: `5` oxygen,
- base max oxygen: `30`,
- `Oxygen Tank I` max oxygen: `40`.

Reopen tuning only with evidence that a clean route with reasonable preparation is unfair, such as:

- `Oxygen Tank I` cannot support East Shelf -> Shelf Drop -> Blue Chimney -> return without extra actions or predator mistakes,
- low/critical warnings arrive too late for a player already at Blue Chimney to choose extraction,
- manual or Playwright review shows players mistake optional Blue Chimney content for a mandatory route objective and overcommit,
- local cue fixes fail to make the return route readable.

## Recommendation

Treat #503 as a review pass, not a rebalance.

Next fixes, if needed, should be local and evidence-driven:

1. Reduce lower-pocket visual pileup.
2. Reposition or strengthen the return-current cue.
3. Move optional resource temptation away from the payoff cue.
4. Tighten player-facing copy if it stops reading as optional.
5. Only after those fail, consider oxygen-number tuning.

Do not add decompression, ascent penalties, refills, oxygen gates, route tolls, minimap markers, exact locators, field-guide objectives, combat, harvesting, or a broader cave system as part of this review.

## Verification Note

This review changes no scripts, scenes, resources, oxygen constants, costs, movement, upgrades, save/load behavior, route collision, or Playwright tests. It documents the post-payoff readability and oxygen decision so the next route-fork issue can move forward without reopening broad early-slice tuning.
