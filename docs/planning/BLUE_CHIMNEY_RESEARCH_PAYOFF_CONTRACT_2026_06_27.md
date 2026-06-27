# Blue Chimney Research Payoff Contract - 2026-06-27

Status: implementation contract for the first `Blue Chimney` payoff. No runtime behavior is implemented by this document.

## Purpose

`Blue Chimney Pocket` already exists as a visible lower pocket below `Shelf Drop Connector`, but ordinary play needs one small reason to enter it. The first payoff should make the player feel that the lower route taught the lab something useful while staying inside the current route-growth milestone.

This payoff is knowledge-first. It should not become a cargo reward, combat encounter, cave system, map pin, field-guide objective, or durable quest chain.

## Selected Payoff

Payoff name: `Blue Chimney Draft Reading`.

Player-facing role: a brief local research interaction at the Blue Chimney pocket that records how the reverse draft resonates below the closed lower crack.

What the player learns:

- `Blue Chimney` is not just decoration; it is a remembered lower pocket.
- The reverse draft hints that the pocket vents from a deeper side-route.
- The next route fork can grow from this lower pocket later, but the current expedition only carries home a reading.

## Interaction Contract

The first implementation should add one proximity interaction near the `Blue Chimney` landmark or closed lower crack.

Recommended prompt shape:

- `Blue Chimney: E record draft reading`

Recommended first-record status:

- `Blue Chimney draft recorded. Return safely to keep the lower-pocket reading.`

Recommended repeat status:

- `Blue Chimney draft already recorded this expedition.`

The interaction should:

- work only during an active dive,
- require player proximity to the pocket,
- set one run-scoped flag for the current expedition,
- leave the visual `Reverse Draft` cue as navigation/timing presentation only,
- not consume oxygen beyond existing movement/time pressure,
- not add cargo, resources, discoveries, upgrade purchases, durable save fields, or route access.

## Extraction Memory

Successful extraction after recording the reading should add one compact result line.

Recommended result copy:

- `Research: Blue Chimney draft hints at a deeper side-route below Shelf Drop.`

Failure or restarting without extraction should not preserve the reading.

The result line should use broad place language. It may name `Blue Chimney` and `Shelf Drop`, but must not provide exact coordinates, objective steps, map-marker language, or guaranteed reward language.

## State Ownership

- `DiveSession` and main-scene run telemetry own the current-expedition flag.
- `ProgressionState` should not gain a `blue_chimney`, `blue_chimney_draft`, or route-journal save field for this first payoff.
- Authored scene nodes own the trigger placement and visual context.
- `LandmarkMetadata` may continue to describe broad place identity only.

## Relationship To Existing Systems

- This is similar in scope to `Drop Echo` and `Resonance Alcove` research: one run-scoped note plus compact extraction memory.
- It should not unlock `Resonance Key I`, `Pressure Seal I`, `Echo Lens I`, or a new upgrade yet.
- It may later support next-route planning, but that later plan should be a separate issue.
- It should coexist with the `Rare Signal` Blue Chimney wash without requiring that expedition condition.

## Explicit Non-Goals

- No minimap, route graph, exact locator, field-guide objective, quest checklist, route journal, or objective arrow.
- No combat, capture, harvesting, weapons, creature loot, or monster collection.
- No new resource tier, recipe tree, crafting station, or base-management surface.
- No full cave network, procedural generation, lower-biome implementation, or region select.
- No oxygen tuning change unless a later evidence review shows local placement/readability fixes are insufficient.
- No new durable save schema field for this first Blue Chimney reading.

## First Implementation Order

1. Add a Blue Chimney proximity field and active prompt.
2. Add one run-scoped `Blue Chimney Draft Reading` flag.
3. Add first-record and repeat interaction status copy.
4. Add extraction result memory for successful returns.
5. Add reset/save guard coverage proving the reading is run-scoped.
6. Add an optional existing-resource candidate only after the research payoff works.
7. Add deterministic Playwright payoff-state evidence only after runtime placement exists.

## Success Criteria

The player should understand that:

1. Blue Chimney is a real place below Shelf Drop.
2. Entering it can produce a small research payoff.
3. The payoff matters only if the player returns safely.
4. The pocket hints at future deeper side-route growth without exposing a checklist or map.
