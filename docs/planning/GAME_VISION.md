# Game Vision

## Pitch

Every morning the alien ocean changes. Dive from a fragile research boat, scan what the sea reveals today, and survive long enough to bring back the supplies and knowledge that let you go deeper tomorrow.

Short form:

Guide a small diver through compact Subnautica-like alien-ocean expedition days where daylight, oxygen, health, and cargo space force choices about what to bring back before nightfall: food and power for tonight, materials for building and upgrades, or knowledge that unlocks the deeper mystery.

## Player Role

The player is an expedition diver and field researcher working from a surface boat or shallow lab. They gather materials, scan useful discoveries, read predator behavior, and upgrade gear into stronger tools, suits, scooters, and eventually compact submersibles that reach stranger and riskier opportunities.

## Core Fantasy

The player is a researcher-pilot slowly learning a dangerous alien ocean that changes each expedition day.

The fantasy should be instantly legible:

- the ocean is a coherent place,
- today's conditions change the opportunity landscape,
- knowledge survives failed dives,
- upgrades open forbidden routes,
- creatures have learnable behaviors,
- deeper water implies a strange hidden mystery.

## Expedition Length

Target a short-session loop: a single expedition day should be readable in a few minutes, with quick ship offloads, clear nightfall payoff, and fast transition into upgrades or the next day. Longer sessions come from chaining expedition days, not from one huge uninterrupted ocean.

## Emotional Arc

Each expedition day should start calm and promising, become tense as daylight, oxygen, cargo, and predator risk accumulate, then resolve with either relief at the ship/night phase or a clear lesson from failure. The best moments should happen when the player sees a deeper opportunity and consciously chooses whether it is worth the remaining daylight and return risk.

## Why Start Another Expedition

The next expedition should offer a different route, a visible goal left behind, a newly understood resource, or an upgrade that changes what is reachable. Persistent knowledge should make the player feel smarter, not just stronger.

The "one more expedition day" pull should come from:

- a survival need that makes today's cargo choice matter,
- a morning report that hints at today's condition or opportunity,
- a visible route or discovery the player could not reach yet,
- lab analysis that turns scans and failure into useful knowledge,
- an upgrade that opens a remembered place,
- a mystery clue that points below the current safe depth.

## World Model

The core world model is persistent geography with variable opportunity.

The player should learn stable places, landmarks, depth bands, and upgrade-locked promises, then adapt because each expedition day changes some active opportunities inside those places. Resource clusters, predator routes, currents, visibility, rare scans, and temporary entrances may shift, but the surface base, region identities, safe return orientation, and major route promises should remain learnable.

This is an in-game expedition-day rhythm, not a required real-world daily challenge.

Regions should become memory anchors, not only depth labels. Each major region should eventually have a fixed landmark, a variable daily opportunity, one major secret, one progression gate or promise, and one creature behavior theme. Initial region candidates are Surface Reef, Wreck Shelf, Thermal Vent Field, Pressure Trench, and Abyssal Ruins.

The current prototype is intentionally small, but the intended long-term dive space is larger than a single vertical shaft: broad side-view expedition maps with left/right route choices, cave-like pockets, branching descents, deeper layers, and authored region layouts. The expansion path is documented in `docs/planning/FUTURE_EXPANSIVE_DIVE_LEVELS_2026_06_26.md`.

## Surface Rhythm

The surface phase should feel emotionally different from the ocean without becoming a management sim:

- oxygen pressure stops,
- open surface can refill oxygen once the daylight loop supports it,
- the ship/moonpool banks carried cargo through one fast offload action,
- cargo and scans are counted at the ship and night screen,
- lab analysis clarifies what was learned,
- building, crafting, upgrades, and locked-route promises are surfaced,
- food, power, and other survival supplies are consumed or checked overnight and consequences are shown,
- the player sleeps or advances to the next expedition day,
- the ocean condition shifts.

This is the game's answer to a second loop: relief, analysis, upgrade, and changed opportunity.

The planned daylight loop makes the ship different from generic surface water. Surfacing gives air; returning to the ship banks supplies and opens the night build/upgrades phase. See `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md` and `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md`.

## Distinction

The game borrows underwater wonder from Subnautica but uses compact, seeded expedition days instead of a large fixed open world or a fully procedural ocean. It borrows the readable side-view descent and surface-return rhythm from Dave the Diver, but the focus is alien research, route risk, and roguelite expedition planning rather than restaurant/base management.

It should also borrow the useful lesson from exploration hits without copying their systems: upgrades should open places, failures should teach, creatures should mean something, and secrets should imply a world deeper than the current prototype.

## Non-Goals

- No full open-world ocean generation in the prototype.
- No full procedural biomes until authored expedition decisions are fun.
- No large map expansion until the current slice and smaller route pockets prove readability, oxygen pressure, and safe-return orientation.
- No complete ocean reroll that erases persistent place memory.
- No real-calendar daily challenge mode until the in-game expedition-day loop works.
- No restaurant, colony, or base-management layer.
- No full crafting economy or grid inventory.
- No full field guide before scans prove useful in the core loop.
- No combat or weapons before observation, avoidance, and non-lethal counterplay are validated.
