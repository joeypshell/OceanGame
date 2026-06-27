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

This milestone temporarily takes priority over `Salvage Cutter 04` because adding another hazard or creature read to the salvage pocket would currently make the visual pileup worse.

## Ordered Implementation Queue

1. Done in #624: establish a visual hierarchy contract for Area 01 and make the docs honest about the new blocker.
2. Done in #625: quiet the Hollow Reef / Wide Reef / Mirror Kelp placeholder geometry so background and terrain stop competing with the sub, pickups, and payoffs.
3. Reduce label noise by keeping only necessary local labels and making future-promise labels smaller/quieter.
4. Clarify pickup/payoff language so resources, knowledge payoffs, and locked routes use distinct color/shape/opacity bands.
5. Add or update one deterministic visual capture for the cleaned Wide Reef / salvage / Mirror Kelp cluster.
6. Recheck the salvage hazard issue after the readability pass; only add the hazard if it stays visually distinct and improves the local decision.

## Guardrails

- Do not start a final art overhaul.
- Do not add a minimap, exact locators, objective checklist, or route graph.
- Do not remove current route gameplay, upgrades, pickups, or payoff state.
- Do not add new systems to solve a visual hierarchy problem.
- Prefer fewer, stronger, quieter shapes over more cue layers.
- Use quick tests for state safety and one targeted visual capture when the scene actually changes.
