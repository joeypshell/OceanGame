# Resonance Key I Implementation Contract - 2026-06-27

Status: implementation contract for the next hatch-access issues. No runtime behavior is implemented by this document.

## Purpose

`Resonance Key I` should turn the visible `Sealed Shelf Hatch` promise into the smallest useful access upgrade. It should make the player feel that returning with East Shelf/Shelf Drop research mattered, without creating a broad key system, scanner tier, quest chain, field guide, minimap, or full cave network.

## Selected Role

Upgrade name: `Resonance Key I`.

Role: a narrow hatch-specific access module for the current `Sealed Shelf Hatch` only.

Player fantasy: the lab can now tune a small resonance module from recovered East Shelf/Drop Echo data and let the sub open one sealed threshold.

## Prerequisite Context

The first implementation should require:

- `Echo Lens I` owned, because the hatch is echo-readable only after that scanner context exists.
- At least one recovered run memory from the current East Shelf route sequence:
  - East Shelf pocket ping, or
  - `Drop Echo` lower-connector research.

The implementation may also require existing resources, with a small `Glow Plankton` emphasis. It should not add a new material tier, crafting station, recipe tree, or base-management step.

## Cost Direction

Use existing materials only.

Recommended first cost candidate:

- `Glow Plankton x2`
- `Shell Fragments x1`

This cost asks the player to return from deeper/route-oriented dives without blocking the feature behind a long economy grind. Adjust only with evidence from oxygen-margin or resource-pressure review.

## Ownership

- `ProgressionState` owns whether `Resonance Key I` is purchased.
- `DiveSession` owns no durable hatch state.
- Authored scene nodes own hatch placement, alcove placement, and local prompts.
- Run telemetry may remember whether a new alcove research ping was recovered during the current expedition.
- No quest, map-marker, field-guide objective, route-graph, or broad journal state is introduced.

## Player-Facing Copy Shape

Good copy:

- `Resonance Key I`
- `Opens the East Shelf hatch.`
- `Needs Echo Lens I and East Shelf research.`
- `Hatch open: small alcove beyond.`
- `Research recovered: resonance key plan ready.`

Avoid:

- `Quest started`
- `Map updated`
- `Coordinates found`
- `Objective: open the hatch`
- `Unlocks all sealed doors`
- `New biome available`

## First Implementation Order

1. Add `Resonance Key I` as a data-backed upgrade definition.
2. Add compact upgrade bay readiness and locked-state copy.
3. Add purchase/save/load coverage.
4. Make `Sealed Shelf Hatch` visibly open when the key is owned.
5. Add a no-interior guard test so the open state remains a threshold, not a new system.
6. Scaffold one small `Resonance Alcove` behind the hatch.
7. Add one run-scoped alcove research payoff and extraction memory.
8. Add route/reset and Playwright evidence only after visual placement exists.

## Guardrails

- One hatch, one key, one small pocket.
- No broad route-key family.
- No full cave/interior system.
- No minimap, route graph, exact locator, field-guide objective, quest checklist, or broad route journal.
- No combat, capture, harvesting, weapon upgrades, or monster loot.
- No new resource tier, crafting station, base-management surface, or broad economy pass.
- No oxygen retune unless later route evidence shows the hatch/alcove path is unfair.

## Success Criteria

The player should understand:

1. The hatch was noticed before it was usable.
2. `Echo Lens I` made the hatch readable.
3. East Shelf/Shelf Drop research gave the lab enough context to plan a key.
4. Buying `Resonance Key I` opens one narrow new place to inspect.
5. The game is growing through learned geography, not through checklist UI.
