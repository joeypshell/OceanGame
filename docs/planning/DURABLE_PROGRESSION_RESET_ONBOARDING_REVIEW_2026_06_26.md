# Durable Progression Reset Onboarding Review - 2026-06-26

Status: review artifact for issue #317.

## Purpose

Review durable progression, reset, and onboarding copy using the solo first-run checklist.

This is a docs-only review. It does not change save behavior, reset behavior, or runtime copy.

## Evidence Reviewed

- `docs/planning/SAVE_PROGRESSION_PERSISTENCE_EXPECTATION_2026_06_26.md`
- `docs/planning/SOLO_FIRST_RUN_READABILITY_CHECKLIST_2026_06_26.md`
- `docs/planning/SOLO_FIRST_RUN_READABILITY_RESULT_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- `scripts/main.gd`

## Review

| Area | Current State | Decision |
| --- | --- | --- |
| F9 reset copy | Ready-panel reset hint is appended only when `show_debug_telemetry` is true. Normal ready panels hide it. | Pass |
| Reset behavior | F9 clears banked resources, purchased upgrades, scan discoveries, best depth, and save file, then returns to clean Expedition 1 ready state. | Pass |
| Relaunch persistence | Durable progression reloads after close/relaunch; active oxygen, carried cargo, current active/result state, temporary effects, and run-in-progress context do not restore. | Pass |
| First-run checklist | Setup step says to use F9 for clean onboarding review, then hide debug telemetry before judging player-facing readability. | Pass |
| User confusion risk | Owned upgrades after relaunch can feel surprising if the player expected a full reset, but current docs clearly mark this as intentional durable progression. | Pass with watchlist |

## Decision

Pass with watchlist.

No copy or behavior tune is required right now. The project documentation now clearly distinguishes:

- clean first-run review: enable debug if needed, press F9, then hide debug telemetry,
- normal relaunch: durable progression persists,
- active expedition state: not restored across launch.

This directly addresses the earlier confusion around owned items appearing after closing and reopening the game.

## Guardrails

Do not change:

- save schema,
- durable progression persistence,
- active expedition reset-on-launch behavior,
- F9 development reset behavior,
- debug gating for F9 copy,
- onboarding copy into a public settings menu.

## Follow-Up Guidance

If this confusion appears again during playtest, create a narrow issue for a player-facing reset/settings affordance after the vertical-slice closeout. Do not add that now; for the current prototype, debug-gated F9 plus documented first-run checklist is enough.
