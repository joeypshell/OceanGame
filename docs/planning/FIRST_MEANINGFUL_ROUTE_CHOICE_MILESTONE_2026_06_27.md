# First Meaningful Route Choice Milestone - 2026-06-27

Status: active planning control.

## Why This Milestone

The previous milestone made the map visibly larger. The next player-visible step should make that larger space matter during ordinary play.

The goal is not another broad art polish pass. The goal is that a normal player can recognize a practical choice:

- take the safer Shell Reef / midwater banking route for cargo and return confidence;
- push toward East Shelf / lower pockets for research, sealed-route clues, and future-depth curiosity.

## Player-Facing Target

Within a short normal play session, the player should see at least one clear route-choice moment and understand what kind of value each route offers.

Target outcome:

- the midwater decision band visually contrasts safe resource banking versus research/deeper-route curiosity;
- the East Shelf / lower route has a second concrete reason to visit beyond the first SignalCore;
- result copy remembers the chosen style of expedition without turning it into a checklist;
- return cues remain broad and readable without a minimap;
- the milestone ends with a compact validation instead of another long review treadmill.

## Issue Batch

Create only these implementation-sized issues:

1. Add a readable midwater route-choice band between Shell Reef safety and East Shelf research.
2. Add one lower-route route-value payoff that makes pushing past East Shelf useful in normal play.
3. Add compact route-choice result memory for safe banking versus research push expeditions.
4. Add one daily-condition nudge that changes route preference without forcing an objective.
5. Validate the first meaningful route-choice milestone and update the roadmap.

Each issue may include local scene art, copy, state ownership, docs, and focused tests. Do not split metadata, screenshot, and review work into separate issues unless the implementation becomes too large to review safely.

## Acceptance Gate

The milestone is complete only when a normal play session can answer yes to these questions:

1. Did the player see a real route choice before simply drifting through the same old path?
2. Did the safe route and research route communicate different value?
3. Did at least one lower-route action feel worth the oxygen risk?
4. Did the result screen remember the route choice in plain language?
5. Did the route choice stay readable without a minimap, checklist, exact locator, or debug telemetry?

## Out Of Scope

- Minimap, route graph, objective checklist, field-guide quest state, or exact scanner locator.
- Full procedural cave generation or broad biome expansion.
- Weapons, combat rewards, harvesting, capture, or monster parts.
- New resource tier or broad economy expansion.
- Another general art-polish pass that does not add a route decision.

## Testing Policy

- Use `quick` for gameplay/state/copy changes.
- Use `visual` only when changing route layout, route art, HUD placement, or staged route screenshots.
- Use `docs` for planning/current docs only.
- At milestone closeout, prefer one compact validation report over creating a new batch of review-only issues.
