# Vertical-Slice Acceptance Evidence Bundle - 2026-06-26

Status: compact internal evidence bundle, refreshed through issue #369.

## Scope

This is a compact internal evidence bundle for the current playable vertical slice.

It does not require external blind testers and does not claim final polish. Screenshot capture was not required for this pass; future screenshot evidence should follow `docs/current/SCREENSHOT_WORKFLOW.md`.

Baseline:

- Commit: `97b1546`
- Review type: documented solo/internal evidence bundle plus Playwright visual smoke
- Screenshot paths: local ignored artifacts under `test-results/playwright/`
- Related solo checklist: `docs/planning/SOLO_FIRST_RUN_READABILITY_RESULT_2026_06_26.md`

Latest review refresh:

- Compact HUD review: `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- Pressure shell review: `docs/planning/PRESSURE_WRECK_CACHE_SHELL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- Lower-route shell recheck: `docs/planning/LOWER_ROUTE_RECHECK_AFTER_PRESSURE_SHELL_2026_06_26.md`
- Decoy/Gulper reviews: `docs/planning/DECOY_PULSE_HUD_PREDATOR_REVIEW_AFTER_HUD_POLISH_2026_06_26.md` and `docs/planning/GULPER_TIMING_RESULT_CLARITY_REVIEW_2026_06_26.md`
- Wreck Echo implementation/readability reviews: `docs/planning/WRECK_ECHO_ROUTE_READABILITY_REVIEW_2026_06_26.md`, `docs/planning/WRECK_ECHO_REWARD_CHOICE_2026_06_26.md`, and current Playwright staged route/result smoke
- Resource/scan reviews: `docs/planning/RESOURCE_SCAN_AFFORDANCE_REVIEW_AFTER_PRESSURE_SHELL_2026_06_26.md` and `docs/planning/RESOURCE_SCAN_SOURCE_ART_TARGET_DECISION_2026_06_26.md`

This refresh does not claim blind validation. It consolidates internal evidence, current Playwright screenshots, and planning decisions tied to implemented behavior.

## Current Screenshot Evidence

Latest Playwright visual smoke passed with two scenarios:

- surface ready, active dive, extraction result, upgrade tab, and lower-route pressure-gate views,
- staged Wreck Echo route and staged Wreck Echo result-readback views.

Local ignored artifact paths from the latest run:

- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/surface-ready.png`
- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/active-dive.png`
- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/extraction-result.png`
- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/upgrade-tab.png`
- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/lower-route-pressure-gate.png`
- `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-route-staged.png`
- `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-result-readback.png`

## Evidence Matrix

| Required Evidence | Current Status | Evidence | Watchlist |
| --- | --- | --- | --- |
| Ready screen | Pass with watchlist | Ready panel owns E/Enter start, condition copy, and one goal line while active operational HUD rows and debug reset copy stay hidden by default. | Recheck surface panel contrast after final HUD polish. |
| Active dive | Pass with watchlist | Final compact HUD review confirms O2, depth, base, cargo slots, scan, prompt, status, low/critical warnings, result/failure hiding, and debug-on/off states are bounded at normal scale. | Fixed top-left HUD can cover incidental left-side art; keep future left-route art aware of that footprint. |
| Pickup/scan | Pass with watchlist | Resource and scan target labels are compact; Kelp Fiber, Shell Fragments, Glow Plankton, non-resource scan markers, selected scan HUD, Signal Lens pulse, and Echo Lens pulse remain distinct enough after the pressure shell. | New resource/scan source-art is deferred; reopen only if future evidence shows concrete confusion. |
| Return/failure | Pass with watchlist | Extraction/failure result copy distinguishes carried cargo from banked/durable progress, keeps one memory line, and makes R next expedition clear. Durable progression reset/onboarding review found no save or copy change needed. | Maintain clean separation between durable progression and temporary dive state. |
| Upgrade view | Pass with watchlist | Upgrade bay is one selected upgrade at a time, shows Up/Down selection in the panel title, and keeps cost/state/missing requirements explicit after normal-scale review. | Continue guarding long copy and avoid tech-tree/inventory-grid expansion. |
| Blocked route | Pass with watchlist | Pressure-Locked Research Wreck keeps locked/open state distinct, denies safely before Pressure Seal I, and the pressure shell reduces lower-route shape pileup. | Keep lower-route screenshots on the watchlist after any route/art change. |
| Danger route | Pass with watchlist | Gulper route reads as avoidable timing danger; Predator Warning I and Decoy Pulse I read as non-lethal preparation/distraction rather than combat, capture, loot, or victory. | Future timing changes should preserve contact risk after mistimed decoy use. |
| Optional clue route | Pass with watchlist | Thermal Vent, Shell Reef, Wreck Signal Cache, and current scan/echo signals remain optional clue/banking/mystery routes, not mandatory objectives or guaranteed safe paths. | Future condition visuals should stay presentation-first. |
| Wreck Echo route | Pass with watchlist | The first Wreck Echo pocket is implemented as one deeper-right optional research clue gated by Pressure Seal I plus Echo Lens I. Playwright staged route/result smoke passed after the first tuning pass. | Keep route small, run-scoped, no-locator, no-checklist, and no-combat; recheck lower-route density before any expansion. |

## Gate Read

The slice currently demonstrates:

- start expedition,
- dive under oxygen pressure,
- collect or scan,
- return or fail,
- read result,
- inspect upgrade progress,
- understand one blocked route,
- understand one danger route,
- notice one optional clue route,
- optionally recover one Wreck Echo research clue after pressure/scanner preparation,
- continue to another expedition.

## Remaining Before Fully Polished Acceptance

This bundle supports continued closeout, but the slice should stay `pass with watchlist` because lower-route density, active HUD compactness, source-art/fallback balance, and result/upgrade copy still need rechecks after Wreck Echo and future art changes.

## Non-Goals Confirmed

No new evidence in this bundle approves:

- final production-art lock,
- full procedural ocean,
- broad Wreck Echo Descent expansion beyond the first implemented pocket,
- minimap, route graph, exact locator, field guide, quest checklist,
- weapons, predator harvesting, capture, or combat rewards,
- inventory grid, tech tree, or base-management layer,
- outside-player blind validation claims.
