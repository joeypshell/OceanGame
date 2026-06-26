# Playable Vertical-Slice Manual Smoke Log - 2026-06-26

Status: manual smoke log artifact for issue #249.

## Scope

This is a solo acceptance log for the first playable vertical slice. It does not require external blind testers and does not claim final polish is complete.

Related docs:

- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/GAMEPLAY.md`
- `docs/planning/ACTIVE_HUD_NORMAL_SCALE_SCREENSHOT_REVIEW_2026_06_26.md`
- `docs/planning/SURFACE_READY_RESULT_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`

## Current Evidence

Automated checks recently passing:

- Godot headless launch.
- Logic tests: 446 checks.
- MCP context self-test: 47 resources.
- `git diff --check`.

Local screenshot/review evidence exists for:

- active HUD normal, scan target, cargo slots, low oxygen, and critical oxygen,
- surface ready, extraction result, failure result, upgrade tab, and log tab,
- Shell Reef balance,
- Thermal Vent balance,
- pressure wreck locked/open/cache/Echo Lens pulse,
- Gulper warning/chase/decoy visual states.

Screenshots are local review artifacts under Godot user data and are not committed source files.

## Smoke Acceptance Matrix

| Gate | Current Status | Evidence | Notes |
| --- | --- | --- | --- |
| Two short expeditions | Pass with watchlist | Clean-save smoke pass and implemented loop reviews | Structurally acceptable; still worth one hands-on feel pass after surface art work. |
| One upgrade path | Pass with watchlist | Current gameplay docs, upgrade tests, and upgrade bay review | Upgrade bay now wraps in a taller panel; normal-scale review remains queued. |
| One blocked route | Pass | Pressure wreck/cache review | `LOCKED`/`OPEN` pressure states are distinct and pressure bypass is not added. |
| One danger route | Pass with watchlist | Gulper route review | Gulper route reads as avoidable danger; decoy HUD/status should be rechecked with upgrade owned. |
| One optional clue route | Pass with watchlist | Thermal Vent and Shell Reef reviews | Thermal Vent reads optional, Shell Reef reads as a midwater banking landmark. |
| Active HUD readability | Pass with watchlist | Active HUD screenshot review and #260 HUD placement fix | Recheck after future HUD changes. |
| Surface readability | Pass with watchlist | Surface ready/result review and #257 upgrade bay fix | Upgrade tab normal-scale review remains queued. |
| No map/checklist/locator drift | Pass | Echo Lens/local mystery tests and docs | Echo Lens wording now uses local `below the shelf` language. |

## Manual Smoke Script

Use this when doing the next actual hands-on acceptance run:

1. Press F9 with debug visible if a clean save is required, then hide debug telemetry.
2. Start Expedition 1 from the ready panel.
3. Collect one shallow/midwater resource and return to base.
4. Confirm extraction result summarizes banked cargo and advances the next expedition prompt.
5. Start a second expedition.
6. Scan a practical clue target such as Thermal Vent, Shell Reef Shelf, pressure wreck outside scan, or Gulper Eel.
7. Push far enough to see either pressure lock or predator warning, then return or intentionally fail.
8. Check the result panel for route/discovery memory and upgrade progress.
9. Visit the upgrade tab and confirm at least one upgrade path is understandable.

## Known Readability Blockers

1. Surface ready/result panels are readable, but the translucent panel lets boat/sub art show behind titles and first lines.
2. Lower-route pressure/cache/predator area is pass-with-watchlist; continue checking it after each visual change.
3. `Decoy Pulse I` HUD/status should be rechecked with the upgrade owned.
4. Upgrade tab wrapping should be rechecked at normal scale after #257.

## Current Decision

Update after #260 and #261: `docs/planning/CLEAN_SAVE_TWO_EXPEDITION_SMOKE_PASS_2026_06_26.md` records the two-expedition clean-save loop as structurally acceptable. The active `Discoveries` placement issue has been addressed by moving the count into the compact active stats HUD treatment, and the upgrade tab has a wrapping/panel fix from #257. The slice still needs queued normal-scale evidence for Decoy Pulse owned-state, lower-route recheck, surface moonpool/waterline readability, and the upgrade-tab wrapping fix before calling the gate fully polished accepted.

The slice is structurally playable and close enough to keep moving, but it is not yet a polished accepted vertical slice.

Next work should gather the queued normal-scale acceptance evidence before declaring the vertical-slice acceptance gate fully passed.
