# Wreck Echo Result Memory And No-Quest Guardrails - 2026-06-26

Status: planning artifact for issue #349. No runtime formatter or progression change is made here.

## Decision

The first future Wreck Echo clue should use one result-memory line:

`Research: Wreck Echo clue carried a deeper pressure signal below the shelf.`

This is the target line shape, not a quest step. It should appear only after the player recovers the clue and extracts successfully.

## Result-Memory Shape

The line must:

- begin with `Research:`,
- name `Wreck Echo`,
- imply one deeper pressure mystery,
- tie back to `below the shelf` rather than an exact route,
- fit as one compact result-panel line,
- avoid saying the route is solved or safe,
- avoid promising a specific next upgrade, material, coordinate, or objective.

Acceptable alternate wording may keep the same shape, for example:

- `Research: Wreck Echo signal came home as a deeper pressure question.`
- `Research: Wreck Echo trace points below the shelf, not to a safe route.`

## What Must Not Persist

Do not persist any of these as durable state for the first implementation:

- active Wreck Echo attempt flag,
- clue-pulse visibility,
- selected route prompt,
- exact route direction,
- target marker,
- result-panel line after the surface result moment,
- objective/checklist completion,
- map/minimap pin,
- field-guide page,
- route graph node,
- "next step" quest text.

The clue may be visible in the current result surface and short recent-expedition memory if the implementation explicitly routes it there, but it should not become a separate permanent objective system.

## Durable Progression Ownership

Current durable owner remains `ProgressionState`, with only these implemented categories:

- `banked_resources`,
- `purchased_upgrades`,
- `scan_discoveries`,
- `best_depth_reached`,
- save schema version.

For the first Wreck Echo implementation, do not add a new durable collection, quest log, objective list, map marker table, or research journal table.

If later playtesting proves persistence is needed, the smallest acceptable durable promotion is a named scan discovery or narrow research record behind a separate issue with save/load tests and no-locator copy checks.

## No-Quest Copy Guardrails

Avoid these words and patterns in player-facing Wreck Echo result memory:

- `objective`,
- `quest`,
- `checklist`,
- `map`,
- `marker`,
- `field guide`,
- `coordinates`,
- exact meters or compass directions,
- `go to`,
- `complete`,
- `step 1`,
- `required route`,
- `unlock guaranteed`.

The line should feel like:

> I learned something strange and got home.

Not:

> I received the next objective.

## Future Tests

When runtime copy is added, tests should verify:

- Wreck Echo result memory appears only after clue recovery plus extraction,
- returning without the clue does not show the research line,
- oxygen failure does not persist the run-scoped clue by default,
- the line contains `Research:` and `Wreck Echo`,
- the line avoids locator/objective/field-guide/checklist words,
- save data does not gain Wreck Echo objective state unless a later issue explicitly adds it.

## Current Scope

This plan changes no scripts, tests, scenes, save schema, result formatter, or progression data.
