# Clean-Save Two-Expedition Smoke Pass - 2026-06-26

Status: acceptance evidence for issue #261.

## Purpose

Record a focused clean-save smoke pass against `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md` without requiring outside blind testers.

This pass checks whether the current prototype can support two short expeditions from a clean/reset state: start, dive, collect or scan, return or fail, read the result, see upgrade progress, and prepare the next expedition.

## Method

Clean state:

- used the implemented prototype reset path as the clean-save source of truth,
- verified the reset behavior through existing progression reset and save/load tests,
- treated Expedition 1 after reset as the starting state.

Evidence sources:

- current implemented behavior in `scripts/main.gd`,
- surface/result readability review,
- active HUD review after #260 moved `Discoveries` into the compact HUD panel,
- upgrade bay readability review after the wrapping/panel fix,
- logic tests covering reset, extraction, result memory, upgrade progress, surface tabs, Echo Lens no-locator language, and HUD helpers.

No external blind tester was used.

## Two-Expedition Smoke Path

### Expedition 1

Expected flow:

1. Start from clean Expedition 1 ready panel.
2. Press E or Enter to begin.
3. Leave the moonpool so extraction requires an actual return.
4. Collect or scan at least one useful thing.
5. Return to base and extract before oxygen reaches zero.
6. Read result: banked/lost cargo, remembered place, route choice, discoveries recorded, upgrade progress, best depth, and next-expedition prompt.

Result:

Pass with watchlist. The implemented loop supports this path and the result panel has compact memory/progress coverage. The active `Discoveries` placement blocker from the previous smoke log has been addressed by #260.

### Expedition 2

Expected flow:

1. Press R after result/failure to prepare the next expedition.
2. Confirm Expedition 2 has a new run number, deterministic seed, condition briefing, and fresh oxygen/cargo state.
3. Start the second dive.
4. Make one practical choice: collect cargo, scan a route clue, or attempt a deeper/riskier path.
5. Return or fail.
6. Confirm the result still summarizes durable progress and frames the next expedition as the ocean shifting again.

Result:

Pass with watchlist. The implemented restart path advances the run, refreshes the condition, resets current-dive state, and preserves durable progression. Result copy avoids raw restart language and debug telemetry by default.

## Acceptance Checklist Status

| Gate | Status | Notes |
| --- | --- | --- |
| Two short expeditions | Pass with watchlist | Implemented and covered by reset/restart/result tests; still worth one hands-on feel pass after surface art work. |
| Clear start prompt | Pass | Ready panel has concise start and condition/goal copy. |
| Active dive HUD | Pass with watchlist | #260 moved `Discoveries` into the active stats treatment; recheck after future HUD changes. |
| Collect/scan/return loop | Pass | Cargo, scan, extraction, and failure behavior are implemented. |
| Result flow | Pass | Result memory, route choice, discovery, upgrade progress, and next-expedition copy are compact. |
| Upgrade progress | Pass with watchlist | Upgrade tab wraps after #257; normal-scale review remains queued in #268. |
| Blocked route | Pass with watchlist | Pressure gate/cache read as distinct, with lower-route recheck queued. |
| Danger route | Pass with watchlist | Gulper route reads as avoidable danger; Decoy Pulse owned-state recheck remains queued. |
| Optional clue route | Pass | Shell Reef and Thermal Vent route reviews are pass-with-watchlist. |

## Remaining Acceptance Watchlists

- Recheck `Decoy Pulse I` while owned.
- Recheck lower-route screenshots after HUD and density changes.
- Review surface moonpool/waterline art pass once wired.
- Run normal-scale upgrade tab review after the wrapping fix.
- Keep condition visuals presentation-first.

## Decision

The clean-save two-expedition loop is structurally acceptable for the current vertical slice.

Do not call the slice fully polished accepted yet. The next acceptance work should gather the queued normal-scale reviews around Decoy Pulse, lower-route readability, surface moonpool/waterline clarity, and upgrade tab evidence.
