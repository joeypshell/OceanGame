# Lower Connector Plan - 2026-06-26

Status: implementation contract for the next East Shelf expansion batch.

## Purpose

The first lower connector should prove that OceanGame can grow from a narrow vertical slice into a wider Dave-the-Diver-like side-view dive space without jumping straight to a full large map. It should be a short authored passage that extends from `East Shelf Spur` downward and slightly right, giving the player a new return-pressure question after the East Shelf pocket exists.

## Selected Shape

Name: `Shelf Drop Connector`.

Placement:

- Starts just beyond or below the current `East Shelf` pocket area.
- Runs downward-right into a lower shelf gap.
- Ends at a small visible turnback point, not a new complete biome.
- Keeps the central base column, Shell Reef, pressure wreck, predator route, and Wreck Echo pocket unchanged.

Player-facing function:

- Teaches that wider levels can branch horizontally and then drop lower.
- Creates a small oxygen-return decision after the East Shelf pocket ping.
- Provides one local landmark and one optional research/resource opportunity.
- Points toward future larger cave/shelf networks without adding a minimap or objective tracker.

## First Implementation Scope

Issue #465 should scaffold only:

- a visible lower passage mouth or shelf gap,
- a short connector corridor using subdued geometry,
- camera/bounds extension only as much as needed,
- a named route stage for debug/Playwright evidence,
- no new interior system, collision maze, procedural generation, combat, harvesting, or durable quest state.

Issue #466 should add one landmark and return cue:

- suggested landmark: `Drop Arch` or `Blue Chimney Arch`,
- return cue should point back up-left toward East Shelf/base,
- copy should stay spatial and local, not exact-coordinate language.

Issue #467 should add one opportunity:

- prefer a run-scoped research ping or one authored resource candidate,
- do not introduce a new resource tier,
- do not require cargo space unless the reward is a normal existing pickup,
- keep payoff compact in status/result text.

Issue #468 should cover reset and bounds:

- connector route stage and prompts reset between expeditions,
- player cannot leave new bounds or clip above/around existing surface/base limits,
- existing East Shelf, Wreck Echo, pressure, predator, oxygen, cargo, save/reset, and upgrade behavior stay unchanged.

Issue #469 should add targeted Playwright evidence:

- stage the connector with a debug command rather than keyboard traversal,
- assert `result: diving`, active HUD visibility, and `route_stage: lower_connector`,
- capture a named screenshot only after the route exists.

## Guardrails

- No minimap, field guide, quest checklist, exact locator, or route graph.
- No broad procedural ocean or full cave network.
- No combat, capture, harvesting, or base-management layer.
- No new upgrade tier until the connector proves readable.
- No broad art overhaul; use subdued prototype geometry and existing visual language.
- Do not retune core oxygen drain until the connector has a playable path and the oxygen-margin review issue runs.

## Success Criteria

- A player can see that East Shelf leads to a lower continuation.
- The connector gives one concrete reason to enter, then asks whether there is enough oxygen to return.
- The route can be staged and screenshot deterministically.
- The implementation keeps the project moving into larger playable space instead of polishing the first screen again.
