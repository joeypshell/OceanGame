# Subnautica Day/Night Recalibration - 2026-06-30

Status: planning direction only. This does not describe implemented behavior yet. `docs/current/GAMEPLAY.md` remains the source of truth for current runtime behavior.

## Current Direction

OceanGame should now aim at a compact side-view Subnautica-like survival day:

The player starts from a surface ship, explores open water and seafloor holes during daylight, surfaces as often as needed for oxygen, returns to the ship to offload limited cargo, repeats until the sun-to-moon timer reaches night, then uses the night phase to build, craft, upgrade, eat, power the base, and prepare for tomorrow.

The game should still keep OceanGame's expedition identity: persistent geography, variable daily opportunity, readable route memories, and upgrades that open places the player has seen. The change is that one "run" is no longer one oxygen tank. One day contains many oxygen sorties.

## What Changed

- Oxygen is no longer the strategic day timer. It is the tactical underwater breath timer.
- The surface is no longer only an extraction destination. Open surface water is a repeatable oxygen refill.
- The ship is still special. It banks/offloads cargo and leads into night/upgrades.
- The day is bounded by a visible sun-to-moon timer.
- Health is now a target core meter beside oxygen. Oxygen or health reaching zero can kill the sortie/player.
- Resources are more survival/crafting oriented: fish/food, wood/driftwood, iron/scrap, kelp/fiber, quartz/glass, shell, power/fuel parts, and later rare alien materials.
- Night is no longer just a result screen. It is the build, craft, upgrade, food, power, and preparation phase.

## Core Loop

1. Dawn: show daylight, base needs, current condition, and a small set of useful goals.
2. Surface launch: the ship/moonpool is visible and reachable from open surface water.
3. Day dive: choose a cave hole, seafloor route, wreck, reef shelf, or resource pocket.
4. Oxygen refill: surface anywhere open to air to restore oxygen while daylight continues.
5. Cargo decision: return to the ship to offload, or carry the load into another dive.
6. Risk decision: health, predators, hazards, depth, and remaining daylight decide whether to push.
7. Nightfall: stop the day, resolve banked food/power/base needs, build/craft/upgrade, and set up tomorrow.

## Surface, Ship, And Night

Surface water and ship return are separate verbs:

- Open surface water restores oxygen.
- The ship/moonpool banks resources and supplies.
- Night/building starts at the ship or when daylight expires.
- Surfacing away from the ship does not bank cargo, heal all damage, buy upgrades, or resolve food/power.

This gives the player a readable rhythm: breathe often, bank intentionally.

## Health Direction

Health should represent body/hull danger, not time pressure.

Health can be damaged by:

- predator contact,
- thermal vents or environmental hazards,
- pressure or collision hazards if later approved,
- aggressive creature behaviors once those exist.

First implementation guidance:

- Add a clear health bar before adding many damage sources.
- Health at zero kills the current sortie/player under the same carried-cargo-loss rule unless a later issue defines a softer rescue state.
- Surfacing should not automatically full-heal by default. Healing should happen through ship/night support, food/medkit crafting, or specific safe equipment.
- Keep health feedback distinct from oxygen warnings.

## Resource Direction

The resource model should be legible before it is broad.

Near-term resource groups:

| Group | Examples | Primary Use |
| --- | --- | --- |
| Food | fish, edible kelp, ration cache | Night survival, health/energy support |
| Power | battery cells, fuel scrap, biofuel, generator parts | Night base power and tool/sub upgrades |
| Building | wood/driftwood, iron/scrap, shell, quartz/glass | Crafting stations, tools, ship/base improvements |
| Research | scans, samples, wreck data, alien fragments | Unlock recipes, routes, and upgrade knowledge |
| Rare route materials | glow plankton, pressure crystals, alien alloys | Deeper upgrades and route unlocks |

Do not add a broad crafting tree immediately. First prove that the player understands why they are picking up fish, wood, iron/scrap, and power parts before night.

## Night Phase

Night should answer:

- What did I bring back?
- Did I meet food and power needs?
- What can I build or upgrade?
- What did scans teach me?
- What should I try tomorrow?

Night can include:

- food and power consumption,
- simple build/craft/upgrades,
- lab analysis of scans and samples,
- a short recent-expedition summary,
- a preview of tomorrow's ocean condition.

Night should not become a colony sim, restaurant sim, production-chain game, or grid-inventory minigame.

## Area 01 Layout Implication

The first level should support repeated surface-to-hole dives:

- the full top surface stays open;
- the ship sits on the surface and is easy to find;
- the seafloor is the first major terrain horizon;
- holes in the seafloor lead to caves of varying depth and complexity;
- shallow holes teach oxygen refill and ship offload;
- deeper holes teach health risk, better materials, route memory, and night planning.

Current source-map reference:

- `docs/planning/AREA_01_SURFACE_FLOOR_SOURCE_MAP_2026_06_29.md`
- `docs/planning/maps/area_01_surface_floor_source_map_v1.json`

## Next Implementation Order

1. Align docs and backlog around this day/night survival direction.
2. Add a visible daylight sun-to-moon HUD timer with no other behavior changes.
3. Add open-surface oxygen refill separate from ship banking.
4. Add one-button ship offload while daylight continues.
5. Allow multiple sorties in one daylight day.
6. Add a basic health meter and one controlled damage source.
7. Reclassify starter resources into food, power, building material, and research value.
8. Make night resolve food/power needs and offer a tiny build/upgrade set.
9. Rebuild Area 01 around open surface, seafloor holes, cave pockets, and ship return.

## Stop Doing For Now

- Do not keep expanding lower-route geography before the daylight survival loop is playable.
- Do not spend another batch polishing old route readability unless it blocks the new surface/seafloor loop.
- Do not make a minimap, quest checklist, exact locator, broad crafting tree, or base-management sim to solve planning confusion.
- Do not treat a generated reference image as runtime collision or runtime map truth.

## Acceptance Standard

The recalibration is working when a player can say:

- I can always surface for air.
- I know where the ship is and why I need to return there.
- I know how much day is left.
- I understand why health and oxygen are different risks.
- I chose between food/power for tonight, building materials for upgrades, and research for future routes.
- Night made tomorrow's dive clearer.
