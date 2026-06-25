# Daily Run Playtest Report - 2026-06-25

This report reviews the first seeded daily-run milestone after adding resource cluster patterns. It is a first-pass route/playtest review using the implemented seed display, authored spawn points, and Godot launch verification. A follow-up hands-on timing pass should still validate exact oxygen margins with real piloting.

## Summary

Seeded variation now creates two recognizable run shapes:

- `Cautious shallows`: easier to read as an early bank route through shallow and midwater resources.
- `Deep reward route`: pulls the deeper `Glow Plankton` toward the predator-controlled route, making the player decide whether the upgrade material is worth the danger.

Different placement is starting to produce different decisions, not just different object positions. The current slice still needs tuning around reward visibility, predator telegraphing, and oxygen-margin feedback before this can be called fully proven.

## Five-Seed Review

| Run | Seed | Pattern | Likely Route Choice | Turnaround / Risk Note | Result Read |
| --- | --- | --- | --- | --- | --- |
| 1 | 8919 | Deep reward route | Push down the right-side route toward `Glow Plankton`. | Turnaround should happen after seeing the predator patrol unless oxygen is already low. | Tempts a deeper attempt and possible close return. |
| 2 | 16838 | Cautious shallows | Collect shallow `Kelp Fiber`, then midwater `Shell Fragments`, then consider extracting. | Turnaround after two resources is reasonable because the deep reward is less central. | Supports cautious banking. |
| 3 | 24757 | Deep reward route | Follow the resource chain downward toward the predator band. | The deeper `Glow Plankton` is attractive but risks contact near the patrol. | Creates a route/cargo decision distinct from run 2. |
| 4 | 32676 | Cautious shallows | Bank shallow/midwater cargo before committing to the deep band. | Best candidate for early extraction and upgrade setup over multiple dives. | Reinforces safe return behavior. |
| 5 | 40595 | Deep reward route | Attempt deeper material after shallow/midwater setup. | Could create a close oxygen return or failure if the player scans or takes predator contact. | Tests whether the predator reward remains avoidable. |

## Decision Findings

- Route choice changed between patterns: cautious runs encourage shallow/midwater banking, while deep-reward runs pull the route toward the predator band.
- Cargo plan changed: cautious runs make partial banking feel sensible; deep-reward runs encourage holding cargo space for `Glow Plankton`.
- Turnaround point changed: cautious runs have a natural turn after midwater; deep-reward runs delay the turn until the player evaluates the predator route.
- Scan plan changed only modestly. `Thermal Vent` and `Lantern Fry` remain useful, but the current resource pattern system does not yet create scan-specific alternatives.
- No reviewed seed violates resource depth identity: `Kelp Fiber` remains shallow, `Shell Fragments` midwater, and `Glow Plankton` deep.
- No reviewed seed obscures surface direction or the safe return route; the HUD base indicator remains the primary return aid.

## Risks Observed

- Deep reward visibility may still depend too much on already knowing the map; players need to see enough of the reward before committing.
- The predator patrol is avoidable in layout terms, but contact readability should be checked in a real piloting pass.
- The current pattern label is useful for development, but it is too explicit for final player-facing UI.
- Oxygen margins are plausible but not yet measured from real movement timing across five complete hands-on runs.

## Follow-Up Issues

Create or use follow-up issues for:

- #28 Add a subtle deep-reward visual lure that is visible before the player commits to the predator route.
- #29 Add predator warning/telegraph feedback so avoidable damage feels fair.
- #30 Add a lightweight run telemetry/debug readout or playtest checklist for seed, pattern, cargo, scans, oxygen at extraction, and failure cause.
- #31 Tune oxygen margins after a hands-on five-seed pass, especially for deep-reward routes with one scan or one predator contact.

## Milestone Judgment

The daily-run system is directionally working: controlled variation now changes the intended route and turnaround decision. It is not fully validated yet because real-time oxygen margins and predator readability still need hands-on playtest confirmation.
