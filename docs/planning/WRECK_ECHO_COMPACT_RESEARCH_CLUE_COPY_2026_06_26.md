# Wreck Echo Compact Research Clue Copy - 2026-06-26

Status: planning artifact for issue #344. No runtime copy is added here.

## Approved Copy Direction

Use short, broad, local language. Wreck Echo copy should sound like a strange research trace, not a route objective.

## Scan/Target Context

Approved direction:

- `Scan: Wreck Echo`
- `Scan: weak wreck echo`
- `Scan: pressure echo`

Avoid:

- `Scan objective`,
- `Wreck Echo marker`,
- exact meters,
- `go to`,
- `route found`.

## Active Status Context

Approved direction:

- `Wreck Echo: weak pressure trace below the shelf.`
- `Wreck Echo: signal is strange, not a safe route.`
- `Wreck Echo clue carried - return if oxygen is thin.`
- `Wreck Echo quiet; no clear trace nearby.`

Keep these as one-line status messages. Do not add multi-line route steps.

## Result Context

Primary result line:

`Research: Wreck Echo clue carried a deeper pressure signal below the shelf.`

Acceptable alternate result lines:

- `Research: Wreck Echo signal came home as a deeper pressure question.`
- `Research: Wreck Echo trace points below the shelf, not to a safe route.`

Result copy should appear only after clue recovery plus extraction.

## No-Clue/Turnback Context

Approved direction if a future result or route-choice formatter needs it:

- `Route choice: turned back before the Wreck Echo pull became risky.`
- `Route choice: left the Wreck Echo for a better oxygen margin.`

Avoid implying failure or task incompletion.

## Forbidden Copy

Do not use:

- `objective`,
- `quest`,
- `checklist`,
- `map`,
- `marker`,
- `field guide`,
- `coordinates`,
- `meters to target`,
- `go to the Wreck Echo`,
- `complete Wreck Echo`,
- `route unlocked`,
- `safe route found`,
- `required next step`.

## Tone Rule

The intended player read is:

> I found a strange pressure clue and got home.

Not:

> The game assigned me the next task.

## Future Test Needs

When these strings are implemented, add tests that:

- enforce one-line active status copy,
- assert result copy contains `Research:` and `Wreck Echo`,
- assert no forbidden locator/objective words appear,
- assert no result line appears on no-clue return or oxygen failure by default,
- assert active status remains below oxygen, return, and predator priority.

## Current Scope

This copy plan changes no scripts, scenes, tests, save data, scan targets, HUD layout, or result formatter.
