# Result And Upgrade Copy Review After Wreck Echo - 2026-06-26

Status: pass with watchlist.

Issue: #377.

## Purpose

Review whether result and upgrade panels remain readable after the Wreck Echo research clue and route memory copy were added.

This review does not change formatter behavior, upgrade data, route logic, or UI layout.

## Evidence Reviewed

- `docs/planning/UPGRADE_BAY_NORMAL_SCALE_AFFORDANCE_REVIEW_AFTER_COPY_TUNE_2026_06_26.md`
- `docs/planning/RESULT_MEMORY_READABILITY_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- Playwright screenshot: `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-result-readback.png`

The current named `extraction-result.png` and `upgrade-tab.png` artifacts in the other Playwright smoke folder show an active-dive state rather than the intended surface result/upgrade views. That is a screenshot workflow gap, not a #377 copy blocker, and should be handled by #381.

No screenshot artifact is committed by this review.

## Result Panel Review

| Area | Current Read After Wreck Echo | Decision |
| --- | --- | --- |
| Result title | `Expedition Day 1 Result: Extraction` remains short and readable. | Pass |
| Banked/lost cargo | Banked resource summary remains near the top, before research flavor. | Pass |
| Remembered place | One remembered-place line remains compact and does not become a map. | Pass |
| Route choice | One route-choice line remains a short memory, not a quest step. | Pass |
| Wreck Echo research | `Research: Wreck Echo clue carried a deeper pressure signal below the shelf.` fits inside the panel and reads as run evidence. | Pass |
| Upgrade progress | One compact missing-resource line remains useful without becoming a tech tree. | Pass with watchlist |
| Next expedition | Next-day prompt remains concise. | Pass |
| Debug telemetry | Debug `Playtest data:` appears in the staged screenshot because the visual smoke state is debug-enabled. Normal player-facing docs/tests still require it to stay hidden unless telemetry is on. | Pass with workflow watchlist |

## Upgrade View Review

The upgrade model remains one selected upgrade at a time with compact cost/state/feedback language. `Echo Lens I` continues to read as broad wreck curiosity, not material pinging or exact navigation. There is no evidence from the Wreck Echo copy that the upgrade view now implies a tech tree, grid inventory, field guide, or broad progression map.

Watchlist: the current Playwright upgrade screenshot artifact did not actually capture the upgrade tab state. Until #381 improves screenshot coverage, upgrade-view review still relies on the earlier normal-scale upgrade review plus documented surface-smoke steps.

## Checklist / Locator Drift Check

No new player-facing copy introduces:

- objective checklist language,
- minimap or route graph language,
- exact coordinates,
- field-guide entry language,
- durable Wreck Echo collection tracking,
- combat, harvest, capture, or loot framing.

## Required Copy Or Guard Updates

No immediate copy or line-length guard update is required.

Future formatter changes should add or update tests only if they alter:

- result line priority,
- debug telemetry gating,
- Wreck Echo result wording,
- upgrade progress wording,
- line wrapping or panel sizing.

## Follow-Up

No new issue is needed from this review.

The existing #381 should improve Playwright/screenshot coverage so result and upgrade states are captured intentionally rather than inferred from debug-staged screenshots.

## Verification

- `npm.cmd run test:visual` passed: 2 Playwright tests.
- `git diff --check` should pass before commit.
