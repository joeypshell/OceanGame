# Next Route Fork After Blue Chimney - 2026-06-27

Status: planning contract for the next small route fork. No runtime behavior is implemented by this document.

## Purpose

The current expanded route is readable but mostly linear:

`Surface Base -> East Shelf Spur -> Shelf Drop Connector -> Blue Chimney Pocket`.

The next route step should create the first true lower-route choice without adding a full cave network, minimap, procedural map layer, quest checklist, combat, harvesting, or broad economy work.

## Selected Fork

Name: `Silt Vein Fork`.

Starting landmark: `Blue Chimney`.

Route role: a compact split just beyond or below the `Blue Chimney` closed lower crack that teaches the player the lower ocean can branch.

Player-facing read:

> The Blue Chimney draft points into a silt-veined split. One branch looks like a readable research/resource nook; the other promises deeper pressure-dark water for later.

## Fork Shape

The fork should be small and authored:

- It begins from the `Blue Chimney` lower edge after the player understands the draft payoff.
- It splits into two short visible branches, not a multi-room cave.
- The safe branch bends slightly left/down into a compact `Lantern Silt Nook`.
- The deeper branch bends right/down into a closed `Blackwater Crack` promise.
- Both branches keep a broad return line back up-left through `Blue Chimney` and `Drop Arch`.

This is the first map-shape step toward larger Dave-the-Diver-like side-view levels: a memorable choice point, not a large region.

## Branch A: Lantern Silt Nook

Player-facing role: a small lower-route destination the player can inspect and leave.

Allowed first payoff:

- one run-scoped research ping,
- or one existing-resource candidate from current resource types,
- or one seeded expedition-day glimmer.

Preferred first payoff: one compact research interaction called `Lantern Silt Sample`.

Non-goals:

- no new resource tier,
- no durable quest state,
- no new upgrade requirement,
- no combat or harvesting,
- no exact locator language.

## Branch B: Blackwater Crack

Player-facing role: a visible deeper promise that tells the player there is more ocean below, but not yet.

Allowed first behavior:

- sealed visual state,
- compact no-entry prompt,
- broad result or scan language that says pressure-dark water needs future preparation.

Non-goals:

- no immediate interior,
- no pressure damage,
- no new oxygen penalty,
- no new upgrade tier unless a later issue scopes it,
- no map marker, field-guide objective, or checklist entry.

## Orientation Rules

The fork must stay readable without a minimap:

- `Blue Chimney` remains the named parent landmark.
- `Silt Vein Fork` should get one visible landmark feature such as pale silt ribs or glowing sediment veins.
- `Lantern Silt Nook` should have a local return-current cue pointing back to the fork.
- `Blackwater Crack` should read as closed or too dark, not as a missing collision bug.
- HUD/base direction may use broad copy such as `up-left`.
- Result text may remember broad places, not coordinates.

## Oxygen And Risk

Do not change oxygen constants for the first fork pass.

The route should create risk through distance and choice:

- inspect the safer nook,
- peek at the sealed deeper promise,
- or return before oxygen pressure becomes dangerous.

If the fork feels unfair, first adjust local placement, cue strength, visual density, or optional temptation. Only retune oxygen after route evidence shows local fixes are insufficient.

## State Ownership

First pass state should be run-scoped only:

- proximity fields belong in main-scene run state,
- temporary research flags reset between expeditions,
- `ProgressionState` should not gain durable `silt_vein`, `lantern_silt`, or `blackwater_crack` fields unless a later issue explicitly promotes them.

Save/load, extraction, failure, upgrades, scans, pressure gates, predators, cargo, and existing route payoffs should remain unchanged.

## Suggested Implementation Order

1. Scaffold `Silt Vein Fork` geometry and camera/bounds needs.
2. Add `Silt Vein Fork` landmark metadata and broad return orientation.
3. Add `Lantern Silt Nook` as the safe short branch.
4. Add `Blackwater Crack` as a closed deeper promise.
5. Add one run-scoped `Lantern Silt Sample` interaction or equivalent compact payoff.
6. Add result memory and reset/save guard coverage for that payoff.
7. Add one deterministic Playwright capture for the staged fork.
8. Review readability/oxygen after the fork exists.

## Acceptance For Future Issues

Future implementation issues should prove:

- the lower route now contains a visible choice,
- both branches can be understood from normal camera scale,
- the return path remains readable,
- no minimap, exact locator, quest checklist, combat, harvesting, broad cave network, or procedural system is introduced,
- focused logic tests cover state ownership and reset behavior,
- Playwright evidence exists only when route placement or visual layout changes.
