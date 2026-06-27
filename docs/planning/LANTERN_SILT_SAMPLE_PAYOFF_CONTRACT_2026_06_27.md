# Lantern Silt Sample Payoff Contract - 2026-06-27

Status: implementation contract for the first `Lantern Silt Nook` payoff. No runtime behavior is implemented by this document.

## Purpose

`Silt Vein Fork` now has a safe left branch, `Lantern Silt Nook`, and a sealed right promise, `Blackwater Crack`. The safe branch needs one compact reason to enter it so the fork feels like a route choice rather than scenery.

The first payoff should be knowledge-first and run-scoped, matching the current lower-route pattern.

## Selected Payoff

Payoff name: `Lantern Silt Sample`.

Player-facing role: a brief local research interaction inside `Lantern Silt Nook` that records a faint bioluminescent sediment sample for the current expedition.

What it teaches:

- `Lantern Silt Nook` is the safer short branch of `Silt Vein Fork`.
- The fork is a place where choosing a branch can produce knowledge.
- Returning safely still matters more than collecting every clue.
- `Blackwater Crack` remains a deferred deeper promise, not the current payoff.

## Interaction Shape

The first implementation should add one proximity interaction near the `Lantern Silt Nook` mouth or glow.

Suggested prompt:

- `Lantern Silt Nook: E collect silt sample`

Suggested success status:

- `Lantern silt sample stored. Return safely to keep the fork reading.`

Suggested repeat status:

- `Lantern silt sample already stored this expedition.`

This should be a local interaction only:

- no cargo item,
- no banked resource,
- no scan discovery,
- no new resource tier,
- no durable quest state,
- no field-guide entry,
- no exact locator.

## Result Memory

Successful extraction after recovering the sample may add one compact research line:

- `Research: Lantern Silt Sample confirms the left branch is the safer Silt Vein route.`

The result line should use broad place language. It may name `Lantern Silt`, `Silt Vein`, and `left branch`, but it should not provide coordinates, objective steps, map-marker language, or guaranteed reward language.

If the player does not recover the sample, no result line should appear. If oxygen failure discards run-scoped route evidence under the implementation issue's chosen rules, no durable sample memory should be saved.

## State Ownership

Use run-scoped state on the main scene or `DiveSession`-adjacent runtime fields.

Do not add durable `ProgressionState` fields for:

- `lantern_silt_sample`,
- `lantern_silt`,
- `silt_vein_fork`,
- `blackwater_crack`.

Reset the sample state between expeditions and on clean prototype reset. Save/load should not persist it.

## Non-Goals

Do not add:

- new resource tier,
- cargo pickup,
- material economy,
- combat, capture, harvesting, or weapons,
- minimap, route graph, exact locator, or objective arrow,
- field-guide objective or quest checklist,
- broad cave/interior system,
- Blackwater Crack access,
- oxygen penalties, decompression, pressure damage, or route tolls,
- new upgrade family or broad progression tier.

## Verification Expectations

Implementation should include focused logic coverage that:

- prompt appears only while nearby during an active dive,
- interaction records one run-scoped sample,
- repeat interaction does not duplicate the payoff,
- oxygen, cargo, scans, predator, pressure, upgrades, and durable progression are unchanged by the interaction,
- result memory appears only after successful extraction with the sample,
- reset/save guards keep the sample out of durable progression.

Use `quick` verification for behavior issues and `docs` for planning-only work. Use Playwright only if route placement/camera/readability evidence changes.
