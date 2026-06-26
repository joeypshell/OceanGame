# Future Expansive Dive Levels - 2026-06-26

Status: future direction clarification. This is not a current implementation request.

## Purpose

Clarify that the current vertical slice is a small proof of the dive loop, not the intended final map scale.

The long-term game should grow toward larger side-view expedition spaces with meaningful horizontal movement, branching routes, cave-like pockets, deeper layers, and authored region layouts. The current narrow ocean column exists so movement, oxygen pressure, scanning, cargo, upgrades, predator risk, and readability can be proven before the map expands.

## Long-Term Level Shape

Future dive levels should feel closer to a compact side-view expedition map than a single straight shaft:

- a surface base or lab at the top,
- broad left/right navigation inside depth bands,
- vertical descent routes that branch and reconnect,
- caves, wreck interiors, trenches, reefs, vents, and narrow pockets,
- optional side routes that tempt the player away from the safe return line,
- deeper regions that require preparation, upgrades, and route knowledge,
- landmarks that help players remember where they are across expeditions,
- authored candidate locations for resources, predators, currents, oxygen opportunities, route hints, and rare discoveries.

This is compatible with Dave the Diver-style readable side-view maps, but OceanGame should keep its own focus: alien research, route risk, persistent place memory, seeded expedition variation, and non-lethal creature learning.

## Persistent Geography With Variable Opportunity

The larger map direction should still follow the hybrid ocean model:

- persistent geography: region shape, major landmarks, pressure gates, wrecks, caves, safe-return orientation, and upgrade-locked promises remain learnable;
- variable opportunity: resources, predator patrols, currents, visibility, rare signals, exposed entrances, and route hints can vary by expedition day from authored candidates.

Do not treat future map expansion as a complete daily reroll that erases place memory.

## Expansion Path

Map scale should expand in stages:

1. Current vertical slice: prove the loop, HUD, extraction, upgrades, route promises, and readability.
2. Route pockets: add one small authored extension such as `Wreck Echo Descent` without broad biome scope.
3. Connected pockets: let several authored pockets create side-to-side route decisions inside the same learned region.
4. Larger regions: create wider authored region layouts with multiple routes, hazards, and stable landmarks.
5. Region families: add new regions such as Pressure Trench or Abyssal Ruins after the first larger region is readable.
6. Broader procedural support: only later, consider procedural assembly or daily challenge variants from authored pieces.

## Near-Term Guardrail

The current Wreck Echo plan is a stepping stone toward larger maps, not the full map expansion itself. It should stay one deeper-right route pocket with one compact research clue.

Do not use the first Wreck Echo implementation to add:

- a full cave system,
- a large generated map,
- a region-select screen,
- a minimap or route graph,
- a quest checklist,
- a full field guide,
- a new biome family,
- a new economy,
- weapons, hunting loot, or combat progression.

## Future Design Questions

Before implementing a larger level, answer these in planning:

- How wide and deep should one expedition map be for a few-minute run?
- How does the camera support both side-to-side exploration and quick return orientation?
- What visual language marks caves, safe return, pressure routes, predator territory, and optional reward pockets?
- How does the player remember a side route across expedition days without a minimap?
- Which opportunities vary daily, and which landmarks remain fixed?
- How much oxygen margin is needed for side routes to feel tempting rather than punishing?
- What is the smallest larger-region test that proves this direction?

## Acceptance For Future Larger-Level Implementation

A future larger-level issue should include:

- an authored map/region layout plan before scene wiring,
- clear route readability goals,
- safe-return orientation evidence,
- depth-band identity preservation,
- tests or smoke coverage for bounds, extraction, pressure gates, and state reset,
- normal-scale screenshots or Playwright evidence,
- explicit non-goals for minimap, full procedural generation, and broad content systems.
