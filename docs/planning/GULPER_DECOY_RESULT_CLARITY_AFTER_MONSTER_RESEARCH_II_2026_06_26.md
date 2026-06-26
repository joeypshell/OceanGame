# Gulper/Decoy Result Clarity After Monster Research II - 2026-06-26

Status: pass with watchlist; no copy or runtime change needed.

Issue: #417.

## Purpose

Review whether current Gulper scan/contact/Decoy result lines still read as research evidence after the `Monster Research II` planning updates selected `Decoy response observed`.

## Current Result Lines

| Evidence | Current Result Line | Decision |
| --- | --- | --- |
| Gulper scan | `Research: Gulper route timing observed.` | Pass. Reads as observation and route timing. |
| Predator contact | `Research: Gulper strike confirms the warning lane is dangerous.` | Pass. Reads as danger confirmation, not a reward. |
| Decoy use | `Research: Decoy timing bent the Gulper route briefly.` | Pass with watchlist. Reads as temporary timing evidence and matches the selected Monster Research II direction. |

## Priority Rule

The existing priority order remains correct:

1. Decoy evidence wins because it is the strongest preparation/timing lesson.
2. Contact evidence wins over scan because it confirms the warning lane is dangerous.
3. Scan evidence is the baseline observation.
4. No Gulper evidence produces no creature research line.

## Guardrail Evidence

`tests/logic_tests.gd` now includes `monster research non-combat guardrails`, which protects these result surfaces from combat, loot, harvest, capture, predator-health, field-guide, checklist, and durable creature-inventory drift.

## Watchlist

The phrase `bent the Gulper route briefly` is acceptable for now. If later playtests find it too abstract, the narrow copy-only alternative is:

```text
Research: Decoy timing opened a brief Gulper route window.
```

Do not add a field guide, minimap, checklist, health UI, combat reward, capture state, harvesting state, or hunting contract to explain this result.
