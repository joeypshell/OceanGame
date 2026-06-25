# Biome Pocket I

Status: planning complete. Recommended future implementation issue title: `Add Shell Reef pocket route variation`.

## Purpose

`Biome Pocket I` is the first small content expansion beyond the current vertical slice. It should add one authored route variation that changes expedition decisions without becoming a full procedural biome system, art set, or content-volume push.

The pocket should make a dive feel a little more place-like while still serving oxygen, cargo, scan, and route-risk choices.

## Candidate Pockets

### Kelp Thicket

Concept: a shallow-to-midwater tangle of tall kelp silhouettes with one or two `Kelp Fiber` opportunities and a visibility/readability tradeoff.

Route decision:

- Take an early safe material path through the thicket, or skip it to preserve oxygen for deeper goals.

Strengths:

- Fits the first resource and surface-return readability.
- Low risk for first implementation.
- Could make shallow expeditions feel less empty.

Risks:

- Too safe to change decisions once the player understands banking.
- Can become decorative if it does not interact with cargo or route planning.

### Thermal Vent Pocket

Concept: a midwater warm-current pocket near the existing `Thermal Vent`, with hidden or hinted `Glow Plankton` and stronger environmental identity.

Route decision:

- Spend oxygen following a scan clue through the vent pocket, or bank current cargo before pressure/predator risk increases.

Strengths:

- Builds on implemented `Thermal Vent` scan behavior.
- Reinforces scan-gated progression toward `Pressure Seal I`.
- Has a clear visual identity.

Risks:

- Overlaps current hidden-plankton and pressure-wreck route logic.
- Could confuse the first scan-gated upgrade if added before the current loop is fully readable.

### Shell Reef

Concept: a midwater reef shelf with shell fragments, broken coral shapes, and a tight choice between safe midwater banking and pushing past the reef toward the deeper predator route.

Route decision:

- Fill cargo with midwater `Shell Fragments` and extract, or pass through the reef with partial cargo to pursue deeper `Glow Plankton`, predator observation, or wreck goals.

Strengths:

- Uses an existing resource and depth identity.
- Naturally sits between cautious banking and deep-risk routes.
- Gives `Cargo Rack I` a clearer payoff because one extra slot makes the reef-to-deep route more tempting.
- Can be authored with simple silhouettes, spawn points, and one scannable clue without a broad art set.

Risks:

- Must not become a resource pile that trivializes upgrade costs.
- Needs enough negative space that it does not block return-route readability.

### Wreck Debris Field

Concept: a small debris scatter outside or near the pressure-locked wreck, offering a signal clue and a future route tease.

Route decision:

- Spend oxygen scanning debris for future wreck context, or save oxygen for the pressure route once `Pressure Seal I` is installed.

Strengths:

- Connects to existing wreck and `Wreck Signal Cache` progression.
- Strongly supports the research fantasy.

Risks:

- Too close to existing pressure-wreck content.
- Better saved for a later wreck-focused milestone after the first pocket proves the format.

## Recommendation

Implement `Shell Reef` first.

Concrete future implementation issue title: `Add Shell Reef pocket route variation`.

The first version should be an authored midwater pocket, not a procedural biome. It should add:

- a compact shell/coral silhouette cluster,
- a small number of typed spawn points for `Shell Fragments`,
- one optional scannable reef clue,
- route spacing that makes the player choose between midwater banking and pushing deeper.

## Visual Identity

- Broken pale shell shapes and low reef shelves.
- Slightly brighter midwater contrast than the deep predator band.
- Open gaps that keep the surface/base direction readable.
- No dense maze, tilemap, parallax set, or large art production pass.

## Resource And Discovery Role

- Primary resource: `Shell Fragments`.
- Optional discovery: `Shell Reef Shelf`, a practical clue that says the reef is a safer midwater bank route before deeper pressure and predator risk.
- The pocket should support existing upgrade costs without flooding the bank.

## Predator And Risk Relationship

- The pocket should sit before the strongest `Gulper Eel` route pressure.
- It should not add a new predator.
- It may visually point toward the deep route so the player can decide whether to leave the safer reef with partial or full cargo.
- It should preserve avoidable predator contact and clear return paths.

## What Not To Build Yet

Do not add:

- full procedural biomes,
- large new art sets,
- new resource rarity tiers,
- new crafting chains,
- maze caves,
- biome-specific oxygen rules,
- new predators for content volume,
- minimaps or field-guide pages,
- broad random coordinate placement.

## Verification Criteria

- The pocket changes at least one route decision: bank midwater cargo or push deeper.
- Resource depth identity remains intact: `Shell Fragments` stay midwater.
- The pocket does not trivialize `Oxygen Tank I`, `Pressure Seal I`, `Signal Lens I`, or `Cargo Rack I` costs.
- Return-route readability remains clear.
- Predator risk remains avoidable and is not forced by the pocket.
- Implementation uses authored spawn points or equivalent typed placement data.
- Seeded variation remains inspectable through debug telemetry, not visible to normal players.
