# Hybrid Ocean Model

Status: planning source for the next roadmap update.

## Core Model

OceanGame should use persistent geography with seeded expedition variation.

The player should learn the ocean as a place, but each expedition should change what is active inside that place.

Use this phrase as the design shorthand:

Persistent geography, variable opportunity.

## Why This Fits

This model keeps the strongest parts of the current direction:

- Subnautica-style place memory, mystery, return trips, upgrade gates, and dangerous depth zones.
- Dave the Diver-style short dives, side-view readability, surface return rhythm, and "one more expedition" pacing.
- Roguelite replayability through changing resources, patrols, currents, and rare opportunities.

It also matches the current architecture. The prototype already uses authored landmarks, typed spawn candidates, deterministic expedition seeds, depth-band resource identities, route pockets, scan discoveries, and durable upgrades.

This is a refinement of the current plan, not a replacement.

## Fixed Versus Variable

### Persistent World

These should remain stable enough for the player to learn:

- surface boat or shallow lab base,
- named regions,
- major landmarks,
- known wrecks,
- depth bands,
- major pressure gates,
- region identities,
- safe return orientation,
- upgrade-locked route promises.

Initial persistent region candidates:

- Surface Base,
- Surface Reef,
- Wreck Shelf,
- Thermal Vent Field,
- Pressure Trench,
- Abyssal Ruins.

The prototype does not need all of these regions immediately. The current vertical slice can keep proving the model with Shell Reef, Thermal Vent, the pressure wreck, the Gulper Eel route, and the planned `Wreck Echo Descent` pocket before expanding into a region-select flow.

Long-term region layouts should become wider side-view expedition spaces with meaningful lateral movement, caves, branching descent routes, and deeper layers. `docs/planning/FUTURE_EXPANSIVE_DIVE_LEVELS_2026_06_26.md` defines this as the future map-scale direction while keeping the current slice and Wreck Echo pocket intentionally narrow.

Each region should eventually be planned as a memory anchor:

- fixed landmark,
- variable daily opportunity,
- major secret,
- progression gate or promise,
- creature behavior theme.

### Seeded Expedition Variation

These may change by expedition day:

- resource cluster locations,
- predator patrol route selection,
- current direction or intensity,
- visibility and depth haze,
- active scan opportunities,
- temporary creature migrations,
- exposed or blocked wreck entrances,
- rare material opportunities,
- route hints revealed by the current condition.

Variation should select from authored candidates whenever possible. Do not use full free-form procedural map generation until authored route decisions are readable and fun.

`Wreck Echo Descent` is the next planned authored pocket candidate for this model: a persistent deeper-right route question motivated by `Echo Lens I`, with any expedition variation limited to authored pressure, resource, risk, or condition candidates rather than broad map rerolls.

## Expedition Day Loop

Use "expedition day" as an in-game rhythm, not a real-world daily challenge.

1. Morning: the surface base reports current ocean conditions.
2. Dive: the player explores one active expedition with oxygen, cargo, scan, predator, and route risk.
3. Extraction or failure: cargo, discoveries, and lessons are resolved.
4. Evening: scans and banked resources unlock or clarify upgrades.
5. Night: the ocean state shifts and the next expedition seed becomes active.

This creates daily rhythm without adding a restaurant, colony, or management game.

The purpose of the day loop is compulsion: a player should end one expedition with a clearer reason to begin the next.

## Player Communication

The player must understand whether something is:

- permanent world knowledge,
- a current expedition condition,
- a durable progression unlock,
- or a temporary tactical hint.

If the game cannot communicate that distinction cleanly, do not add more variation yet.

Preferred language:

- "Today's current exposes a lower wreck gap."
- "Gulper Eel migration near the Wreck Shelf."
- "Thermal bloom shifted deeper."
- "Pressure Seal I required for this route."

Avoid language that makes randomization feel arbitrary or invisible.

## Readability Dependency

The hybrid model depends on visual clarity. Persistent geography only matters if players can recognize places, and variation only matters if players can notice what changed.

Before broadening the ocean model, the prototype needs a playfield readability pass:

- reduce or remove overlapping world text,
- reserve world labels for true blockers and selected scan focus,
- keep route explanations in HUD/surface panels instead of over the playfield,
- make scan targets, gates, currents, rewards, danger, and return paths visually distinct,
- make each persistent landmark recognizable without needing paragraph labels.

If text obscures the playfield, the next issue should fix that before adding new mechanics.

## Implementation Direction

Near-term implementation should extend existing systems:

- keep authored scene data as the source for route and landmark placement,
- keep `SpawnPoint` candidates inspectable and typed,
- add region or landmark metadata only when needed by a narrow issue,
- let `DiveSession` own temporary expedition facts,
- let `ProgressionState` own durable discoveries, upgrades, banked cargo, and best depth,
- keep generated variation as seeded selection from authored candidates.

Do not start with:

- a giant continuous world map,
- full procedural biome generation,
- a large cave/region map before smaller authored route pockets prove readability and safe-return orientation,
- a real-calendar daily challenge mode,
- a management sim,
- or a large final-art production pass.

## Success Gate

The model is working when:

- the player can name or recognize where they are returning to,
- the player can notice what changed this expedition,
- at least one changed condition affects the dive plan,
- persistent discoveries help future expedition decisions,
- no variation obscures the safe return route,
- no world text blocks the player from reading the scene,
- and each new mechanic still strengthens the decision to continue downward or return safely.
