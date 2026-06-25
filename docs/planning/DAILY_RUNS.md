# Daily Runs

This note captures design guidance for the daily roguelite dive-run milestone. `docs/current/ROADMAP.md` tracks the active issue order, and `docs/current/GAMEPLAY.md` tracks implemented behavior.

## Intent

The intended game loop is closer to "Subnautica as daily roguelite dive runs" than to one fixed ocean map. Each dive should feel like a run for that day: the player launches from the surface base with persistent upgrades and knowledge, explores a randomized or reshuffled ocean layout, extracts whatever they can safely bring back, then uses the results to prepare for future dives.

## Run Shape

- Start from the surface boat/lab with persistent upgrades, banked resources, scan knowledge, and unlocked equipment.
- Generate or reshuffle the dive layout for the current day/run.
- Randomize or vary resource nodes, creature positions, hazards, wrecks, caves, and special discoveries within readable depth-band rules.
- Dive downward, make oxygen/cargo/risk decisions, and extract before failure.
- Bank extracted cargo; lose carried cargo on failure; keep scans, banked resources, upgrades, and long-term knowledge.
- Use between-run progression to reach deeper bands, survive more dangerous routes, and identify better opportunities on future dives.

## Variation Layers

Introduce randomization in controlled layers:

1. Run start/result flow.
2. Run/day seed.
3. Starter resource placement using authored depth-band candidate points.
4. Typed spawn point data shared by later resources, hazards, creatures, discoveries, and clusters.
5. Resource cluster patterns.
6. Hazard and creature route variation.
7. Special discoveries and wreck/cave opportunities.

The authored vertical slice is still the proving ground. Avoid full procedural biomes until the run decisions are fun and readable.

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

## Playtest Methodology

The daily-run milestone should be tested across at least five seeds.

Current report:

- `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`

Checklist template:

- `docs/planning/RUN_PLAYTEST_CHECKLIST.md`

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
- Did one run encourage cautious extraction and another encourage a deep attempt?
- Was the deep reward visible early enough to inform a choice?
- Did any placement create unavoidable predator damage?
- Did any seed violate shallow/mid/deep resource expectations?
- Did the runs feel strategically different, or merely visually rearranged?

Different placement is not enough. It must produce different decisions.

## Success Gate

The milestone succeeds when:

- at least one run encourages a cautious shallow or midwater extraction
- at least one run tempts a deeper high-value route
- at least one run creates a close oxygen return or failure
- rewards and risks remain readable before the player commits
- predator encounters remain avoidable through observation or route choice
- resource depth-band identities remain consistent
- no seed obscures the surface direction or safe return route
