# Playable Exploration Skeleton Plan - 2026-06-28

## Decision

OceanGame should keep the visual polish track active, but visual work must now support a larger playable level skeleton. The current Outer Shelf / Glass Rim work proved useful for readability and route payoff, but it is too narrow to make the game feel like an explorable survival dive.

The active milestone should shift to a Safe Shallows-style first level framework: a wider side-view map with solid reef walls, chambers, cave mouths, resource pockets, and early survival/resource goals that justify moving sideways and downward.

## Target Player Feeling

The first playable area should feel like a small but real underwater place:

- the boat or surface lab is the safe return point;
- the player can swim left, right, and down into authored terrain;
- reef walls and cave pockets create readable exploration lanes;
- resources are found in places that make sense instead of floating as abstract markers;
- the run asks for practical survival materials, not only route lore;
- visual polish makes the level easier to parse and more inviting to explore.

## Near-Term Content Shape

Build the first map as a compact Safe Shallows prototype, not a final world:

- surface boat / moonpool / offload zone;
- shallow open-water entry lane;
- left reef shelf with one shallow cave pocket;
- right reef shelf with one ledge and one tighter cave mouth;
- deeper central drop toward current Area 01 / Area 02 content;
- resource clusters placed on ledges, in caves, and near landmarks;
- route landmarks kept as memory anchors, not the whole content model.

## Starter Resource Families

Early resource play should start with recognizable survival materials:

- scrap metal or iron for basic equipment;
- driftwood / kelp fiber for repairs and simple crafting;
- glass / quartz for scanner, lens, or light upgrades;
- food and water pickups or harvestables for base survival pressure;
- existing special materials can remain, but they should no longer carry the whole loop alone.

## Visual Track Rule

Visual tasks remain valuable when they do one of these jobs:

- make walls, caves, ledges, or playable water easier to read;
- make resources, cargo, and scan targets distinct without label spam;
- improve focal clarity around the diver and nearby choice;
- reduce wasted screen space so exploration feels larger;
- create reusable assets that will serve larger levels.

Visual tasks should be delayed when they only decorate a tiny landmark, add more abstract overlays, or make a screenshot prettier without improving the playable area.

## Non-Goals For This Milestone

- Full procedural world generation.
- A finished crafting tree.
- Combat or weapon progression.
- A final minimap system.
- Broad architecture refactors unless they unblock visible level work.
- Pausing all visual work.
- Exact copying of any reference game's assets or map.

## Recommended Issue Order

1. Build the Safe Shallows exploration shell with authored walls, chambers, and cave pockets.
2. Add starter survival resource node families with temporary readable art.
3. Place resource pockets inside the shell so collection teaches exploration.
4. Tie one surface upgrade or night choice to starter resources.
5. Apply the reef visual kit to the exploration shell, not isolated landmarks.
6. Convert route/status HUD into compact objectives and contextual alerts.
7. Improve ocean color, parallax, dressing, and ambient life only where it supports the shell.
8. Add deterministic capture coverage for the larger exploration skeleton.
9. Compare against the visual reference after the level bones exist.

## Acceptance Signal

This milestone is working when a fresh playtest no longer feels like the same small cluster with new labels. The player should be able to say where they went, what kind of place they entered, what resources they found, and what they want to try on the next dive.
