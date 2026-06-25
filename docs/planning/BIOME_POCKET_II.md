# Biome Pocket II

Status: planning complete. Recommended future implementation issue title: `Add Thermal Vent pocket route variation`.

## Purpose

`Biome Pocket II` should add one more authored route pocket after `Shell Reef` without turning the prototype into broad procedural biome generation. The second pocket should prove that small, reusable place-making can support the expedition loop in another part of the water column.

The pocket should strengthen the core question: should the player spend oxygen following a visible opportunity, or bank current cargo and return safely?

## Candidate Pockets

### Thermal Vent Pocket

Concept: a warm-current pocket around the existing `Thermal Vent`, with a clearer vent silhouette, small bubble/current shapes, and a hinted path toward hidden or deep `Glow Plankton`.

Route decision:

- Spend oxygen following the vent current toward glow rewards or pressure-route knowledge, or leave with current cargo before deeper risk stacks up.

Strengths:

- Builds directly on the implemented `Thermal Vent` scan effect.
- Reinforces `Glow Plankton` as a deep reward without adding a new resource.
- Gives the pressure-upgrade clue more environmental identity.
- Can use authored visual shapes and typed placement data instead of procedural generation.

Risks:

- Could overlap the existing hidden-plankton reveal if it adds too much reward.
- Could confuse the pressure-wreck route if the pocket points too strongly at the locked route.
- Needs clear return readability because it sits near the midwater-to-deep transition.

### Kelp Thicket

Concept: a shallow-to-midwater kelp silhouette lane with a few readable gaps and optional `Kelp Fiber` placement candidates.

Route decision:

- Take a safer early material route, or skip it to preserve oxygen for deeper shell/glow objectives.

Strengths:

- Improves the shallow opening and surface-return mood.
- Low mechanical risk.
- Could become a reusable visual vocabulary for shallow depth.

Risks:

- May be too safe to create a meaningful choice after the player understands banking.
- Could become visual clutter around the first resources and base-return column.
- Less useful than a vent pocket for the current scan-gated progression arc.

### Wreck Debris Field

Concept: a small field of non-colliding wreck fragments outside the pressure-locked research wreck, with one practical scan clue or signal marker.

Route decision:

- Spend oxygen investigating future wreck context, or save oxygen for a return after `Pressure Seal I`.

Strengths:

- Supports the research fantasy and pressure-wreck promise.
- Gives `Wreck Signal Cache` and `Signal Lens I` more environmental context.
- Can foreshadow future wreck-focused content without opening a full wreck biome.

Risks:

- Too close to the current pressure gate, which is already visually busy.
- Could make the locked route feel like the only important next objective.
- Better after pressure-gate, signal-marker, and scan-marker visual language has been standardized.

### Lantern Bloom Pocket

Concept: a small bioluminescent life pocket around `Lantern Fry`, with faint pulse shapes that make nearby `Glow Plankton` feel like part of a living route.

Route decision:

- Spend oxygen scanning/following life cues toward glow, or avoid the deeper route and bank cargo.

Strengths:

- Supports the alien research tone.
- Could set up a future light/scanner upgrade from bioluminescent-life discovery.
- More creature-forward than another geology or wreck pocket.

Risks:

- Risks expanding creature systems before the first visual language pass is stable.
- Could blur with `Signal Lens I` and predator warning readability.
- Should wait until non-predator creature signaling has clearer conventions.

## Recommendation

Implement `Thermal Vent Pocket` next.

Concrete future implementation issue title: `Add Thermal Vent pocket route variation`.

The first version should stay narrow:

- Add authored vent-current and bubble silhouettes around the existing `Thermal Vent`.
- Keep the existing `Thermal Vent` discovery and scan effect; do not add another upgrade prerequisite.
- Add at most typed placement candidates or visual guidance that supports the current hidden/deep `Glow Plankton` route.
- Preserve the pressure-wreck lock and the Shell Reef bank-vs-push decision.

## Visual Identity

- Warm orange/yellow vent plumes against cooler midwater/deep blues.
- Small bubble strings and current ribbons that imply upward heat and lateral drift.
- Enough negative space that the base direction and pressure gate remain readable.
- No dense cave, maze, tilemap, large parallax set, or full biome art pass.

## Route Decision

The player should read the vent pocket as a tempting but oxygen-costly clue route:

- scan or revisit the vent,
- notice the warm-current path,
- decide whether to follow it toward glow/deeper opportunity,
- or return with current cargo before predator, pressure, or oxygen risk accumulates.

The pocket should not be mandatory for every run. It should feel like one route option among Shell Reef banking, pressure-wreck planning, and deep-reward risk.

## Resource And Discovery Role

- Primary resource relationship: `Glow Plankton`.
- Existing discovery: `Thermal Vent`.
- Future optional discovery candidate, if needed later: `Vent Bloom`, but do not add it in the first implementation unless a separate issue explicitly authorizes it.
- No new resource tier, rarity tier, crafting chain, oxygen refill, or upgrade recipe should be added by the first pocket implementation.

## Out Of Scope

Do not add:

- procedural biome generation,
- cave mazes or collision tunnels,
- new pressure rules,
- oxygen refills,
- new resources or resource tiers,
- new predators,
- a minimap or route overlay,
- a broad field-guide page,
- pressure-wreck access changes,
- changes to `Thermal Vent` as the `Pressure Seal I` prerequisite.

## Verification Criteria

- The pocket uses authored scene data or equivalent typed placement data.
- `Thermal Vent` remains the same persistent discovery for `Pressure Seal I`.
- The pocket improves route readability around the vent without making `Glow Plankton` free or guaranteed.
- The Shell Reef return/banking route remains readable and distinct.
- Pressure-wreck locked-route feedback remains clear and unchanged.
- Cautious and deep-reward cluster patterns still preserve resource depth identities.
