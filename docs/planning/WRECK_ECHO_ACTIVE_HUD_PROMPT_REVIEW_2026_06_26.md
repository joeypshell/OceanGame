# Wreck Echo Active HUD/Prompt Review - 2026-06-26

Status: review artifact for issue #351. No runtime HUD copy or layout changes are made here.

## Decision

Existing active HUD surfaces are sufficient for the first future `Wreck Echo Descent` attempt.

Do not add a Wreck Echo route panel, objective tracker, minimap, field-guide surface, active upgrade/log view, or new persistent route UI. Use the current compact active HUD slots:

- `Scan:` line for the selected target or no nearby target,
- prompt line for return/burst/decoy/action affordance,
- status line for one compact temporary outcome,
- existing O2/depth/base/cargo panels for survival pressure.

## HUD Priority

Future Wreck Echo prompt/status language must respect this order:

1. Critical oxygen and return-to-base warning.
2. Immediate extraction/base prompt.
3. Predator warning/contact/decoy state.
4. Pressure-gate denial or open-route safety.
5. Current scan target/action.
6. Wreck Echo curiosity/status.

Wreck Echo text is curiosity guidance, not emergency guidance. It should never outrank low/critical oxygen, base direction, predator danger, pressure denial, or extraction.

## Existing Slots Are Enough

| Need | Use existing slot | Notes |
| --- | --- | --- |
| Before entry | `Scan:` and status | Broad local wording such as `Scan: weak wreck echo` or a short status line is enough. |
| During attempt | prompt/status | Keep one line: return pressure, not objective steps. |
| Clue recovered | status | One temporary confirmation can appear before result memory. |
| No clue nearby | status | Say the echo is quiet or unresolved; do not create a marker. |
| Low oxygen | oxygen warning/base direction | Oxygen remains louder than Wreck Echo. |
| Result memory | surface result panel | The active HUD should not become the memory surface. |

## Copy Constraints For Future Implementation

Future active copy should:

- stay within the existing compact status/prompt limits,
- avoid line breaks,
- avoid exact direction, exact distance, coordinates, map, marker, objective, quest, checklist, and field-guide language,
- avoid adding a numbered route step,
- avoid repeating long upgrade or prerequisite text during active play,
- tell the player to turn back through oxygen/return pressure, not through a route objective.

Allowed direction style:

- `weak wreck echo below the shelf`,
- `echo fades deeper in pressure`,
- `return if oxygen is thin`,
- `clue carried - get home`.

These are examples for tone, not approved runtime strings.

## Regression Tests Needed Later

When Wreck Echo is implemented, add or update tests to prove:

- combined active prompt remains compact with Burst, Decoy, and any Wreck Echo hint,
- status copy is compacted to one bounded line,
- no Wreck Echo active copy contains forbidden locator/objective words,
- low/critical oxygen warning remains visible and higher priority than Wreck Echo text,
- surface ready/result/failure still hide active dive HUD rows,
- Playwright or normal-scale screenshots include active attempt and result views.

## Non-Goals

Do not add:

- route panel,
- quest/objective tracker,
- minimap,
- route graph,
- field guide,
- active-dive upgrade or log surface,
- new debug telemetry fields,
- new oxygen, cargo, scan, route, save/load, or upgrade behavior.

## Current Scope

This review changes no scenes, scripts, tests, HUD layout, or runtime text. It records that the future Wreck Echo attempt should fit the existing compact HUD model.
