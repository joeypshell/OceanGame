# Thermal Bloom Authored Weighting Plan

## Decision

First condition-driven authored weighting rule:

- Condition: `thermal_bloom`
- Candidate set: authored `Glow Plankton` resource spawn points
- Intended effect: prefer vent-adjacent `Glow Plankton` candidates when Thermal Bloom is active

This is the first gameplay-relevant hybrid-ocean condition step. It must remain deterministic, authored, bounded, and readable.

## Why This Candidate

`Thermal Bloom` is the safest first weighting condition because it already has:

- a player-facing briefing line,
- a visible Thermal Vent place,
- a non-mechanical vent visual effect,
- existing vent-adjacent `Glow Plankton` authored candidates,
- a natural relationship to deep glow reward without inventing a new biome.

`Calm Current` should remain visual-only for now because safe-return readability is more sensitive; making return routes feel mechanically easier could become hidden assistance.

## What Changes

When current condition id is `thermal_bloom`:

- selection for `Glow Plankton` may prefer existing authored candidates tagged by cluster pattern or located near the Thermal Vent pocket,
- the active pickup count remains unchanged,
- the selected pickup remains a normal `Glow Plankton` pickup,
- `Glow Plankton` remains a deep-band resource,
- cluster pattern still matters.

## What Must Not Change

Do not:

- add extra `Glow Plankton`,
- add new resource types,
- move Kelp or Shell candidates,
- change oxygen, cargo, scan range, upgrade costs, pressure locks, predator routes, or movement,
- introduce procedural biome generation,
- hide safe return,
- make Thermal Vent mandatory for every route,
- select candidates outside authored `SpawnPoint` data.

## Implementation Shape

Preferred narrow implementation:

1. Extend spawn selection with an optional condition id parameter.
2. Keep default behavior unchanged for empty or non-target conditions.
3. For `thermal_bloom` + resource target `glow_plankton`, sort or weight candidate positions so vent-adjacent authored candidates are preferred.
4. Keep deterministic seed selection inside the bounded candidate list.

The implementation may use an authored marker field later, but the first version can use existing authored candidate metadata if enough signal already exists. If metadata is insufficient, add only a small typed field to `SpawnPoint`; do not infer from arbitrary node names.

## Test Expectations

Tests should prove:

- same seed, cluster, condition, category, and target produce the same selection,
- `thermal_bloom` affects only `glow_plankton` candidate preference,
- non-Thermal Bloom conditions preserve current selection behavior,
- selected `Glow Plankton` candidates remain in the deep depth band,
- active pickup count does not increase,
- no condition weighting occurs when condition id is empty.

## Review Questions After Implementation

- Does Thermal Bloom make the vent day feel different before reading debug telemetry?
- Does the warmer vent visual plus candidate preference create a readable opportunity?
- Does the route still preserve safe return and predator risk?
- Does the condition feel authored rather than random?

## Verification

- Godot headless launch.
- Deterministic logic tests for condition weighting.
- Normal timed launch.
- `git diff --check`.
