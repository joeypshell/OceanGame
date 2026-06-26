# Monster Research II First Evidence Type Selection - 2026-06-26

Status: selected for follow-up planning.

Issue: #414.

## Selected Evidence Type

`Decoy response observed`

Player-facing meaning:

> The player learned that the Gulper route can be bent briefly by preparation and timing, but the predator remains dangerous.

## Why This Selection

`Decoy response observed` is the safest first `Monster Research II` evidence type because it already rests on implemented non-combat systems:

- `Gulper Eel` is already scannable.
- `Predator Warning I` already establishes route preparation.
- `Decoy Pulse I` already creates one temporary behavior response.
- Result summaries already have compact language for decoy timing.
- Existing tests already protect that decoy is distraction/timing, not damage, stun, capture, harvest, or permanent control.

This evidence type deepens the current loop instead of adding a new monster system. It asks the player to observe, prepare, trigger, survive, and extract.

## Rejected Candidates For First Pass

| Candidate | Reason To Defer |
| --- | --- |
| `Gulper patrol timing observed` | Good future baseline, but it overlaps heavily with the existing scan result and would need a new definition for "observed" that is not just proximity noise. |
| `Warning-lane confirmation` | Already covered by scan/contact result language; better as guardrail coverage than a new milestone. |
| `Passive creature route hint` | Interesting later, but it would pull Monster Research II away from the current Gulper/Decoy foundation. |
| `Lure response` | Risks implying bait, trapping, harvesting, or creature manipulation before the project has earned that scope. |

## Implementation Shape For Later

The later implementation should not add new controls or UI. It should formalize ownership around existing decoy evidence:

- run-scoped flag: decoy response observed this expedition,
- result memory: one compact `Research:` line,
- durable readiness: optional upgrade-readiness marker only if a later issue needs it,
- no field guide, checklist, minimap, route graph, combat log, health UI, monster parts, or capture state.

## Acceptance Guardrail

The phrase `Decoy response observed` should always read as timing evidence. It must not become predator damage, stun, capture, harvest, permanent route removal, or a creature-collection step.

State ownership follow-up: `docs/planning/MONSTER_RESEARCH_II_STATE_OWNERSHIP_RESULT_MEMORY_2026_06_26.md` keeps the selected evidence run-scoped by default, allows one compact result line, and defers durable progression state until a specific later upgrade or gate requires it.
