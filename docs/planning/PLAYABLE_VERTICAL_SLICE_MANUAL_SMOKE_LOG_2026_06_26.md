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
| Two short expeditions | Needs hands-on pass | Implemented loop and surface result reviews | Requires manual play from clean save or scripted smoke to confirm pacing. |
| One upgrade path | Pass with polish | Current gameplay docs and upgrade tests | Upgrade bay works, but `SURFACE_READY_RESULT_READABILITY_REVIEW_2026_06_26.md` flags upgrade-tab text overflow. |
| One blocked route | Pass | Pressure wreck/cache review | `LOCKED`/`OPEN` pressure states are distinct and pressure bypass is not added. |
| One danger route | Pass with watchlist | Gulper route review | Gulper route reads as avoidable danger; decoy HUD/status should be rechecked with upgrade owned. |
| One optional clue route | Pass with watchlist | Thermal Vent and Shell Reef reviews | Thermal Vent reads optional, Shell Reef reads as a midwater banking landmark. |
| Active HUD readability | Pass with immediate fix | Active HUD screenshot review | Move or restyle active `Discoveries` count. |
| Surface readability | Pass with immediate fix | Surface ready/result review | Upgrade tab text can overflow. |
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

1. Active `Discoveries` count sits between HUD panels and can collide visually with the cargo row.
2. Upgrade tab copy can overflow the panel with the current seven-upgrade set.
3. Surface ready/result panels are readable, but the translucent panel lets boat/sub art show behind titles and first lines.
4. Lower-route pressure/cache/predator area is pass-with-watchlist; continue checking it after each visual change.

## Current Decision

The slice is structurally playable and close enough to keep moving, but it is not yet a polished accepted vertical slice.

Next work should fix the active `Discoveries` placement and upgrade-tab overflow before declaring the vertical-slice acceptance gate fully passed.
