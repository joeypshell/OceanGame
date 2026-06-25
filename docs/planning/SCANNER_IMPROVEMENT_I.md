# Scanner Improvement I Plan

Date: 2026-06-25

## Context

`Wreck Signal Cache` is the first reward behind `Pressure Seal I`. It should point toward a scanner improvement that changes future expedition decisions without turning the prototype into a full field-guide UI.

The scanner already supports:

- target name preview,
- deterministic nearest-target selection,
- first-time scan discoveries,
- repeat tactical scan refreshes,
- resource deposit highlighting,
- route hints from `Thermal Vent`,
- pressure-wreck signal reveal.

Scanner Improvement I should build on those patterns.

## Candidates Compared

### Longer Tactical Highlights

Effect: resource and discovery scan effects last longer after the upgrade.

Pros:

- Simple and low-risk.
- Reinforces existing scan behavior.
- Helps players who need more time to act on scan information.

Cons:

- Mostly improves comfort, not decision quality.
- May feel like a passive number upgrade rather than a new capability.
- Does not make the `Wreck Signal Cache` feel like meaningful technology.

### Nearest-Resource Direction Pulse

Effect: scanning a resource discovery can point toward the nearest visible uncollected deposit of that same resource in the current expedition.

Pros:

- Directly supports the core question: continue toward the signal or return safely.
- Uses existing resource scan knowledge and seeded placements.
- Helps the player turn persistent knowledge into a current-route decision.
- Can stay lightweight: HUD/status text plus a brief directional pulse is enough for the first slice.

Cons:

- Needs careful tuning so it does not become a full minimap.
- Should only point to scan-relevant resources, not every objective.
- Must respect hidden or locked content; it should not reveal pressure-locked rewards before the player earns the clue.

### Safer Predator Observation

Effect: scanning predator-related targets improves warning feedback or shows the predator patrol direction for a short time.

Pros:

- Strongly supports the monster-hunting and ecological-observation direction.
- Creates a clear non-lethal safety upgrade.
- Could pair well with future Burst Thruster or predator countermeasure work.

Cons:

- Predator readability is still awaiting blind validation under #37.
- Adding this now could hide whether the current warning route is understandable.
- More likely to overlap future predator-countermeasure design.

### Better Target Preview

Effect: the scan target HUD shows whether the target is new, already discovered, resource, creature, or environmental before scanning.

Pros:

- Improves first-time scanner clarity.
- Low implementation risk.
- Helps players understand why scanning matters.

Cons:

- Mostly UI clarity, not a progression reward.
- Could be a general scanner polish issue rather than a wreck-cache payoff.
- Does not create a strong new expedition decision.

## Recommendation

Implement `Signal Lens I` as the first scanner improvement when this becomes implementation work.

Recommended effect:

- Repeat-scanning a discovered resource target sends a short directional pulse toward the nearest visible, uncollected deposit of that same resource in the current expedition.
- If no matching deposit is available, the status text should say the signal is quiet.
- The pulse should be temporary and local-feeling, not a persistent map marker.

This is the best first scanner upgrade because it turns earned resource knowledge into a current expedition decision. The player can ask: is following this signal worth the oxygen and route risk, or should I return with what I already have?

## Unlock Requirements

Recommended unlock:

- Required discovery: `wreck_signal_cache`.
- Cost: `Shell Fragments x2`, `Glow Plankton x2`, `Kelp Fiber x1`.
- Upgrade id: `signal_lens_1`.
- Effect id: `resource_signal_pulse`.

Reason:

- The `Wreck Signal Cache` supplies the signal-processing clue.
- `Glow Plankton` anchors the bioluminescent signal theme.
- `Shell Fragments` and `Kelp Fiber` keep the recipe tied to extracted materials without adding new resource types.
- The cost should require at least one deliberate return after reaching the pressure-locked wreck, but should not become a long grind.

## Expected Player Decision

The upgrade should create this decision:

- Use a repeat scan to locate a known material route.
- Decide whether to follow the pulse deeper or bank current cargo.
- Use persistent discovery knowledge to make future expeditions feel smarter, not just statistically stronger.

## Implementation Constraints

Do not include in the first implementation:

- full field guide UI,
- minimap,
- global objective markers,
- exact distance readouts,
- automatic pathfinding,
- scanner energy,
- broad scanner upgrade tree,
- predator-control effects.

Do not change repeat scan cost behavior as part of this upgrade unless a separate issue reopens that design. Repeat tactical scans should remain free for the current prototype.

## Validation Criteria

A first implementation succeeds if:

- players can tell the scanner is pointing toward a resource signal,
- the signal helps choose a route without replacing navigation,
- hidden or pressure-locked content is not spoiled,
- the upgrade makes `Wreck Signal Cache` feel like a practical reward,
- the player still faces oxygen/cargo/return tradeoffs.

## Suggested Implementation Issue

`Add Signal Lens I resource direction pulse`
