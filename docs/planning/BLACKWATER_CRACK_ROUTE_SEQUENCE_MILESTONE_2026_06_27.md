# Blackwater Crack Route Sequence Milestone - 2026-06-27

Status: completed as pass with watchlist by `docs/planning/BLACKWATER_CRACK_ROUTE_SEQUENCE_VALIDATION_2026_06_27.md`.

## Why This Milestone

The first meaningful route-choice milestone proved that ordinary play can distinguish safer Shell Reef banking from East Shelf / lower-route research. The next step should make the lower route feel less like a chain of isolated pockets and more like a short connected route sequence.

The selected route sequence is:

`Surface Base -> East Shelf -> Shelf Drop -> Blue Chimney -> Silt Vein Fork -> Blackwater Crack`.

This does not mean building a full cave system. It means giving the existing sealed `Blackwater Crack` promise a readable, gated, player-visible sequence with one payoff, one hazard/readability pressure, one daily variation hook, and one compact validation pass.

## Batch Shape

This batch intentionally uses fewer but larger issues than the earlier micro-issue style. Each implementation issue may include scene changes, runtime state, copy, docs, focused tests, and targeted screenshot evidence when route layout changes.

Preferred batch size: 10 issues.

The issues should be completed in order, but each should be large enough that a player can notice the result in a normal playtest.

## Player-Facing Target

After the batch, a normal player should understand:

- the right branch at `Silt Vein Fork` is a deeper Blackwater route, not a collision bug;
- access is gated by existing preparation, not a new broad upgrade tier;
- entering the Blackwater edge offers one concrete knowledge payoff;
- the route applies pressure through distance, darkness, and local hazard/readability cues rather than hidden damage;
- successful extraction remembers the deepest route choice in plain language;
- the game still works without a minimap, checklist, exact locator, combat, harvesting, or procedural cave system.

## Issue Batch

1. Blackwater 01: Define and surface the Blackwater route gate using existing progression.
2. Blackwater 02: Open a short Blackwater Sill route beyond the crack.
3. Blackwater 03: Add one Blackwater knowledge payoff with recovery, result memory, reset, and tests.
4. Blackwater 04: Add one local Blackwater pressure cue that affects route readability/timing without damage.
5. Blackwater 05: Add a Blackwater daily-condition nudge using existing condition infrastructure.
6. Blackwater 06: Strengthen return orientation from Blackwater back through Silt Vein and Blue Chimney.
7. Blackwater 07: Add compact result/recent-log memory for the deepest reached route.
8. Blackwater 08: Add deterministic visual evidence for the Blackwater route sequence.
9. Blackwater 09: Tune local readability after evidence without changing global oxygen numbers.
10. Blackwater 10: Validate the Blackwater route sequence and select the next player-visible milestone.

## Acceptance Gate

The milestone is complete only when a normal play session can answer yes to these questions:

1. Does `Blackwater Crack` read as a deliberate deeper-route gate?
2. Can the player enter a short Blackwater route sequence after the scoped preparation?
3. Is there one clear reason to risk the Blackwater edge and return safely?
4. Does the route pressure come from readable distance, darkness, timing, or local cues rather than hidden punishment?
5. Does extraction/failure copy remember the route without becoming a checklist?
6. Does the route stay understandable without minimap, exact locator, broad quest UI, combat, harvesting, or procedural cave generation?

## Closeout Outcome

The milestone passes with watchlist. Blackwater now functions as a short connected lower-route sequence with a gated branch, one run-scoped trace payoff, one local pressure/readability cue, Rare Signal nudge support, compact result/recent-log memory, return-chain copy, and deterministic visual evidence.

The watchlist is not a blocker for moving on: Blackwater remains abstract prototype geometry near the current world edge, so the next route milestone should create more readable negative space and stronger landmark identity rather than repeatedly polishing this same short sill. The selected next milestone is `Dusk Trench`, a compact route continuation beyond Blackwater.

## Scope Guardrails

Allowed:

- one narrow access rule derived from existing upgrades/discoveries;
- one short authored route segment;
- one run-scoped knowledge payoff;
- one local visual/timing pressure cue;
- one condition presentation nudge;
- focused tests and targeted screenshots where route layout changes;
- small docs updates that keep planning/current behavior aligned.

Out of scope:

- broad cave network or procedural map generation;
- new resource tier, crafting category, monster parts, harvesting, or combat reward;
- minimap, route graph, objective checklist, field-guide quest state, or exact scanner locator;
- new broad upgrade family or durable route state unless a specific issue promotes it;
- global oxygen retuning before route evidence shows local cue fixes are insufficient.

## Testing Policy

- Use `quick` for runtime/state/copy changes.
- Use `visual` when changing route layout, route art, HUD placement, or screenshot staging.
- Use `docs` for planning/current docs only.
- Prefer one validation issue at the end over a new review treadmill.
