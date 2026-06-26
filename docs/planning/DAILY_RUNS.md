# Seeded Expedition Days

This note captures design guidance for the current seeded roguelite expedition loop. `docs/current/ROADMAP.md` tracks the active issue order, and `docs/current/GAMEPLAY.md` tracks implemented behavior.

The current system is not a calendar-based daily challenge. It uses deterministic session seeds to create repeatable expeditions. A shared daily challenge can be a later mode if the seed is derived from a calendar date and presented consistently for that day.

Related model:

- `docs/planning/HYBRID_OCEAN_MODEL.md`

## Intent

The intended game loop is closer to "Subnautica as short roguelite expeditions" than to one fixed solved map or a fully regenerated procedural ocean. Each dive is a seeded expedition day: the player launches from the surface base with persistent upgrades and knowledge, revisits recognizable ocean geography, adapts to the current expedition's active conditions, extracts whatever they can safely bring back, then uses the results to prepare for future expeditions.

The design shorthand is:

Persistent geography, variable opportunity.

## Expedition Shape

- Start from the surface boat/lab with persistent upgrades, banked resources, scan knowledge, and unlocked equipment.
- Preserve recognizable regions, landmarks, depth identities, route promises, and safe return orientation.
- Randomize or vary resource nodes, creature positions, hazards, currents, visibility, temporary entrances, and special discoveries within readable depth-band and authored-candidate rules.
- Dive downward, make oxygen/cargo/risk decisions, and extract before failure.
- Bank extracted cargo; lose carried cargo on failure; keep scans, banked resources, upgrades, and long-term knowledge.
- Use between-expedition progression to reach deeper bands, survive more dangerous routes, and identify better opportunities on future dives.

## Variation Layers

Introduce randomization in controlled layers:

1. Expedition start/result flow.
2. Expedition seed.
3. Starter resource placement using authored depth-band candidate points.
4. Typed spawn point data shared by later resources, hazards, creatures, discoveries, and clusters.
5. Resource cluster patterns.
6. Hazard and creature route variation.
7. Special discoveries and wreck/cave opportunities.
8. Expedition-day conditions such as current shifts, predator migrations, thermal blooms, low visibility, or rare signals.

The authored vertical slice is still the proving ground. Avoid full procedural biomes until expedition decisions are fun and readable.

## Persistent Geography Rules

- Regions and landmarks should be stable enough for the player to remember.
- Major gates should remain learnable promises, not hidden random walls.
- Safe return direction must never be randomized into confusion.
- Changes should be communicated as ocean conditions, migrations, currents, blooms, or temporary exposed routes rather than invisible dice rolls.
- Do not let "daily variation" erase what the player learned from a previous dive.

## Authored Spawn-Point Rules

- Use authored `SpawnPoint` nodes or equivalent data, not free-form random coordinates.
- Spawn points should define at least id, category, target id, depth band, cluster pattern, and position.
- Resource depth identity must stay consistent:
  - `Kelp Fiber`: shallow
  - `Shell Fragments`: midwater
  - `Glow Plankton`: deep
- Candidate placement should preserve the visible reward/risk relationship.
- Return-route readability matters more than surprise.
- Predator-controlled rewards must remain avoidable through observation or route choice.

## Current Cluster Patterns

- `Cautious shallows`: keeps the starter resource path more legible for shallow/midwater banking.
- `Deep reward route`: keeps depth identities intact while pulling the deeper `Glow Plankton` toward the predator-controlled route.

## Validation Methodology

Seeded-expedition changes should be tested across at least five seeds and with unfamiliar players when readability or motivation is being judged.

Current report:

- `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`

Checklist template:

- `docs/planning/RUN_PLAYTEST_CHECKLIST.md`

Current tuning pass:

- `docs/planning/OXYGEN_MARGIN_TUNING_2026_06_25.md`

For each seed, record:

- route chosen
- cargo collected
- scans attempted
- turnaround point
- closest oxygen moment
- extraction or failure result
- unreadable placements
- unavoidable hazards
- whether the seed felt strategically different

The playtest should answer:

- Did different seeds change the chosen route?
- Did they change the turnaround point?
- Did one expedition encourage cautious extraction and another encourage a deep attempt?
- Was the deep reward visible early enough to inform a choice?
- Did any placement create unavoidable predator damage?
- Did any seed violate shallow/mid/deep resource expectations?
- Did the expeditions feel strategically different, or merely visually rearranged?

Different placement is not enough. It must produce different decisions.

## Success Gate

The milestone succeeds when:

- at least one expedition encourages a cautious shallow or midwater extraction
- at least one expedition tempts a deeper high-value route
- at least one expedition creates a close oxygen return or failure
- rewards and risks remain readable before the player commits
- predator encounters remain avoidable through observation or route choice
- resource depth-band identities remain consistent
- no seed obscures the surface direction or safe return route

## Blind-Player Gate

Do not mark feel, readability, or strategic-variety milestones complete solely from code inspection or theoretical route review. At least two players who have not read the roadmap or implementation notes should be observed before concluding that a readability milestone is proven.
