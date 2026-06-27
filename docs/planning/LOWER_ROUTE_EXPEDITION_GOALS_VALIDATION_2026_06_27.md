# Lower Route Expedition Goals Validation - 2026-06-27

Status: pass with watchlist.

This closes the `Lower-Route Expedition Goals` milestone. The goal was to make the Blackwater, Dusk Trench, Lantern Ray, and Hollow Reef chain feel more coherent in normal expedition planning and results before extending the map again.

## Validation Method

This is a compact solo milestone validation using:

- lower-route ready-panel suggestions for prepared players;
- route-choice, result, and recent-log priority across Blackwater, Dusk Trench, Hollow Reef, and Lantern Ray;
- the no-screenshot Playwright lower-route smoke that stages Blackwater, Dusk, Hollow Reef entrance, and Hollow Reef return states cheaply;
- the lower-route oxygen margin review that kept current oxygen constants unchanged;
- prior Blackwater, Dusk Trench, Lantern Ray, and Hollow Reef milestone validations.

No blind playtest is claimed here. This validation is a planning checkpoint so the next work can move forward instead of reopening the same local oxygen, copy, or screenshot questions.

## What Is Now Playable

- The lower route has a readable chain of named places: `Blue Chimney`, `Silt Vein Fork`, `Blackwater Crack`, `Blackwater Sill`, `Dusk Trench`, `Lantern Ray Route`, and `Hollow Reef`.
- Prepared players can receive broad lower-route nudges without exact locator UI, checklist objectives, quest markers, minimaps, or route graphs.
- Extraction results and the recent expedition log can remember deeper route evidence in a useful priority order instead of flattening everything into generic route text.
- The route can be checked cheaply through scripted lower-route smoke without spending tokens or wall time on long screenshot-heavy traversal for every small change.
- Oxygen tuning has an evidence gate: current constants stay unchanged, and future tuning must be tied to clean-route, one-payoff, creature-pressure, or return-timing failures.
- The route remains knowledge-first. Hollow Reef, Glass Kelp, Blackwater Trace, and related payoffs do not add hidden oxygen tax, cargo mutation, durable quest state, combat, harvesting, or procedural cave behavior.

## What Remains Rough

- The route still looks like a prototype. Some lower-route landmarks and cue clusters use overlapping placeholder geometry and need stronger reusable/source-art readability.
- Hollow Reef is currently a cave-like branch and payoff, not a true interior lane with choices.
- The route is longer than the opening slice, but normal play still needs more obvious side-to-side breadth so players feel the map has grown without debug staging.
- The creature layer is promising but still observation-first. Lantern Ray proves passive route life; it does not yet make a monster-hunting loop.
- Surface progression is functional but not yet deep enough to be the next main milestone. The player needs more route breadth and reasons to dive before surface systems can carry more weight.

## What Must Wait

Do not open broad systems from this validation:

- no minimap, route graph, exact objective tracker, or field-guide checklist;
- no full procedural cave generation or daily biome reroll system;
- no combat, harvesting, capture, monster parts, health bars, bounties, or weapon economy;
- no broad surface base-management loop;
- no mobile/controller implementation beyond existing planning guardrails.

Those directions can be revisited only after larger normal-play route space creates a clear need.

## Next Milestone Decision

Select route breadth as the next player-visible milestone.

Milestone name: `Hollow Reef Interior And Wide Chamber`.

Reasoning:

- The strongest user-facing gap is still that ordinary play can feel similar after many issues.
- Monster hunting needs a larger, clearer route space before new creature behavior has room to matter.
- Surface progression needs more meaningful diving destinations before it becomes interesting rather than menu work.
- The open issue queue already contains concrete route-breadth work that extends Hollow Reef into an interior lane, then into a wider chamber.

## Ordered Follow-Ups

Use the existing open issues; do not create another broad batch from this validation.

1. Complete #564 and #565 as a small polish gate for the most important lower-route landmark/readability asset. This should support route breadth, not become a broad art pass.
2. Complete #568 through #573 to turn Hollow Reef from a side-cave branch into a short interior lane with a choice, resource value, passive creature observation, timing cue, and route memory.
3. Complete #574 through #579 to add the first wider chamber beyond Hollow Reef with stronger walkable-space silhouettes, landmarks, return-current chain, daily variation, and normal-play route goal.
4. Then use #580 through #584 for a larger passive creature route only after the new space exists.
5. Keep #585 through #598 as later salvage, navigation, progression, visual-smoke, milestone, and backlog-refresh work.

## Completion Gate For The Next Milestone

The next milestone should not close until normal play can answer yes to:

1. Does Hollow Reef feel like more than one room or one marker?
2. Can the player move side-to-side through a wider lower-route space?
3. Are there at least two readable landmarks or choices in the expanded space?
4. Can the player understand how to return without a minimap?
5. Does the route include one new reason to enter and one visible future promise without implying a checklist?

## Verification

This validation changes no scripts, scenes, resources, oxygen constants, movement, collision, upgrades, save data, or Playwright tests. It updates planning so the issue queue can move from goal/readability validation into player-visible route breadth.
