# Area 01 Readability Rescue - 2026-06-27

## Why This Exists

Recent playtesting feedback says the current route is hard to read and unpleasant to test because the authored placeholder geometry has become visually messy. This is now a playability blocker, not optional polish.

The project should pause additional route clutter, hazard additions, and new sealed promises until the current Area 01 route can be understood during normal play.

## Current Problem

- Too many translucent polygons overlap in the Hollow Reef, Wide Reef, Mirror Kelp, and salvage-pocket cluster.
- Background, terrain, return currents, timing cues, locked promises, pickups, and knowledge payoffs compete at similar opacity and brightness.
- Labels and cue text sometimes add more noise instead of clarifying intent.
- New content can technically work while still feeling invisible or confusing to the player.

## Readability Goal

Make the current playable Area 01 route easier on the eyes and easier to playtest without pretending this is final art.

A successful pass should let the player quickly distinguish:

- playable water,
- solid/terrain-like silhouettes,
- safe return-current language,
- timing/hazard language,
- pickups,
- interactable knowledge payoffs,
- locked/future route promises,
- passive background atmosphere.

## Current Milestone

Area 01 Readability Rescue.

This milestone takes priority over `Salvage Cutter 04` because adding another hazard or creature read to the salvage pocket would currently make the visual pileup worse. Content expansion is paused until source-of-truth docs are reconciled and the current route is accepted as readable enough for another content step.

## Ordered Implementation Queue

1. Done in #624: establish a visual hierarchy contract for Area 01 and make the docs honest about the new blocker.
2. Done in #625: quiet the Hollow Reef / Wide Reef / Mirror Kelp placeholder geometry so background and terrain stop competing with the sub, pickups, and payoffs.
3. Done in #626: reduce label noise by hiding redundant normal-play return labels and shortening local promise/place labels.
4. Done in #627: clarify pickup/payoff language so resources, knowledge payoffs, locked routes, and return/timing support use distinct color/shape/opacity bands.
5. Done in #628: add/update one deterministic visual capture record for the cleaned Wide Reef / salvage / Mirror Kelp cluster.
6. Current source-of-truth cleanup: reconcile README, ROADMAP, GAMEPLAY, and current planning docs so they all name this milestone and the same next-work order.
7. After cleanup, continue readability-only review or fixes if needed.
8. Keep #622 paused until readability is explicitly accepted. If resumed, the salvage hazard issue can add only one light, visually distinct read that improves the local decision without adding another bright reward/lock/label pile.

## Guardrails

- Do not start a final art overhaul.
- Do not add a minimap, exact locators, objective checklist, or route graph.
- Do not remove current route gameplay, upgrades, pickups, or payoff state.
- Do not add new systems to solve a visual hierarchy problem.
- Prefer fewer, stronger, quieter shapes over more cue layers.
- Use quick tests for state safety and one targeted visual capture when the scene actually changes.
