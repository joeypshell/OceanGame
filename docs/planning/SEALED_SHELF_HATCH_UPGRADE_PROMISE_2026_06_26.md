# Sealed Shelf Hatch Upgrade Promise - 2026-06-26

Status: planning contract only. No upgrade resource, scene interior, hatch behavior, cost, save data, or quest state is implemented here.

## Selected Promise

Future upgrade candidate: `Resonance Key I`.

Role: a narrow hatch-specific access module that can eventually turn the visible `Sealed Shelf Hatch` promise into one small opened pocket or threshold interaction.

This is not a broad scanner tier, tech tree, interior system, or map objective. It is the next visible return promise after the player has learned:

- `Echo Lens I` can read broad unresolved signals,
- the East Shelf pocket records a sealed-route ping,
- `Drop Echo` confirms the lower connector continues below East Shelf,
- returning safely with research matters.

## Why This Fits

The hatch currently changes from `ECHO LOCK` to `ECHO PING` when `Echo Lens I` is owned. That should mean the player can now understand the hatch, not that the hatch is already open.

`Resonance Key I` gives the next loop a practical shape:

1. See the sealed hatch on East Shelf.
2. Buy or use `Echo Lens I` to recognize that it is echo-readable.
3. Recover East Shelf or lower-connector research during an expedition.
4. Return safely so the lab can prepare a narrow access module.
5. Later, return to open one small pocket or route threshold.

## Recommended Future Gate

Use existing progression concepts first:

- Required upgrade context: `Echo Lens I`.
- Required run evidence candidate: East Shelf pocket ping or `Drop Echo` result memory.
- Optional future discovery context: Wreck Echo clue if the route wants stronger mystery framing.
- Cost candidate if implemented later: existing materials only, with a small `Glow Plankton` emphasis.

Do not add new material tiers, crafting stations, base management, upgrade pages, or broad scanner economy for this promise.

## Player-Facing Language

Good language:

- `Hatch readable: needs a resonance key later.`
- `Echo Lens reads the seal, but cannot open it yet.`
- `Research recovered: lab can plan a hatch key.`

Avoid language:

- `Quest started`
- `Map updated`
- `Coordinates found`
- `Objective: open hatch`
- `Echo Lens unlocks all sealed doors`
- `Interior biome available`

## Out Of Scope

- Implementing `Resonance Key I`.
- Opening the hatch.
- Adding a hatch interior.
- Adding exact coordinates, minimap, field guide, quest checklist, route graph, or objective tracker.
- Adding broad upgrade tiers beyond the current compact upgrade bay.
- Changing `Echo Lens I`, pressure access, Wreck Echo, Drop Echo, cargo, oxygen, predator, save/load, or extraction rules.

## Next Implementation Guidance

Issue #471 should only add player-facing readiness/result copy around the existing hatch state:

- before `Echo Lens I`: the hatch remains an `ECHO LOCK`,
- after `Echo Lens I`: the hatch reads as understandable but not open,
- after East Shelf or Drop Echo research: result copy may imply the lab can plan a future key,
- no new upgrade should appear in the upgrade bay yet.
