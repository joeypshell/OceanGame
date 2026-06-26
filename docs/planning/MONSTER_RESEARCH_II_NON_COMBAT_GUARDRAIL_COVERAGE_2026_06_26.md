# Monster Research II Non-Combat Guardrail Coverage - 2026-06-26

Status: implemented as logic-test guardrails.

Issue: #416.

## Purpose

Protect the `Monster Research II` planning direction from drifting into combat, harvesting, capture, predator health, field-guide UI, checklist UI, or durable creature-inventory state.

## Coverage Added

`tests/logic_tests.gd` now includes `monster research non-combat guardrails`, which checks:

- Gulper scan research uses non-combat language.
- Gulper contact research stays framed as warning-lane danger.
- Decoy response research stays framed as timing evidence.
- Result summaries do not introduce blocked combat, loot, harvest, capture, health, bounty, or victory language.
- Result summaries do not introduce field-guide or checklist language.
- Progression save data does not gain durable `monster_research` or `creature_inventory` keys from the current planning pass.

## Scope Boundary

This does not add new monster research behavior. It only protects the existing scan/contact/decoy result surfaces so later issues can build from a stable non-combat foundation.
