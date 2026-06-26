# Echo Lens To Wreck Echo Handoff Review - 2026-06-26

Status: review artifact for issue #348. No runtime copy or tests are changed here.

## Decision

Current `Echo Lens I` language is a good handoff into future Wreck Echo work as long as it stays broad and local.

The handoff should read as:

> Echo Lens notices a weak unresolved wreck echo. A future Wreck Echo route lets the player risk investigating it if oxygen, pressure access, and return margin allow.

It should not read as:

> Echo Lens marks the next objective.

## Existing Language Review

| Surface | Current language | Handoff result |
| --- | --- | --- |
| Cache repeat scan before `Signal Lens I` | `Cache clue refreshed for Signal Lens I.` | Practical scanner ladder setup. No Wreck Echo route promise yet. |
| Cache repeat scan after `Signal Lens I` | `Cache echo unresolved: future Echo Lens study may read deeper wreck signals.` | Good bridge from practical scanner to mystery scanner without exact route. |
| Cache repeat scan after `Echo Lens I` | `Echo Lens: weak wreck echo lingers below the shelf.` | Good future-route hint because it names category and remembered place, not coordinates. |
| Echo Lens result memory | `Research: Echo Lens caught a weak wreck echo below the shelf.` | Good expedition memory. It does not create a quest or marker. |
| Upgrade role | `Role: broad wreck echoes, not material pings.` | Strong distinction from `Signal Lens I`. Keep this role language. |

## Signal Lens Distinction

Keep `Signal Lens I` material-facing:

- known resource repeat scans,
- visible matching deposits,
- current-run cargo/banking decisions,
- practical pulse language.

Keep `Echo Lens I` wreck-curiosity-facing:

- known Wreck Signal Cache repeat scan,
- broad unresolved wreck category,
- remembered-place language,
- future-run preparation pressure,
- temporary local pulse only.

Future Wreck Echo copy should not reuse `Signal Lens` language such as `matching deposit`, `visible deposit`, or material `pulse leans` unless it is intentionally talking about resources.

## Future Handoff Copy Rule

Allowed Wreck Echo handoff language:

- `weak wreck echo below the shelf`,
- `deeper pressure signal`,
- `unresolved cache echo`,
- `return if oxygen allows`,
- `not a safe route yet`.

Avoid:

- exact coordinates,
- exact distance,
- route arrows,
- multi-signal lists,
- `go to`,
- `objective`,
- `quest`,
- `checklist`,
- `marker`,
- `map`,
- `field guide`,
- `new route unlocked` unless the route is actually implemented and safely gated.

## Implementation Risks

Watch these risks when Wreck Echo is implemented:

- `deeper-right` can become too coordinate-like if paired with an arrow or persistent marker.
- A Wreck Echo entry prompt can look like an objective if it says "complete" or lists steps.
- Echo Lens pulse art can become a map marker if it persists after the scan/result moment.
- Signal Lens material language can accidentally make Echo Lens feel like a hidden resource detector.
- Result memory can become quest-log pressure if it promises the next upgrade or route.
- Active HUD copy can compete with oxygen or predator danger if the echo line is too long.

## Future Test Needs

When Wreck Echo runtime copy is added, tests should verify:

- Echo Lens repeat-scan copy remains broad/local,
- Wreck Echo entry/result copy avoids locator/objective words,
- Signal Lens material pulse behavior remains unchanged,
- Echo Lens does not bypass `Pressure Seal I`,
- the Wreck Echo result line and Echo Lens result line remain distinct if both exist,
- temporary pulse/marker state resets between expeditions.

## Current Scope

This review changes no runtime strings, tests, upgrade data, scan behavior, scene nodes, or route behavior.
