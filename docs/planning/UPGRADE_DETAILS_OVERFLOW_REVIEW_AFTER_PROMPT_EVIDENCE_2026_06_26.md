# Upgrade Details Overflow Review After Prompt And Evidence Hardening - 2026-06-26

Status: fail for polish; narrow fix required.

Issue: #404.

## Purpose

Review the current upgrade details panel after prompt abstraction and Playwright evidence hardening. This review checks whether the one-selected-upgrade model remains readable without adding a tech tree, upgrade grid, inventory view, field guide, minimap, route graph, quest checklist, controller support, touch UI, combat, capture, or broader progression scope.

## Evidence

- Latest Playwright upgrade artifact:
  - `C:/Users/pirat/OneDrive/Documents/OceanGame/test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/upgrade-tab.png`
  - Metadata reports `result: extracted`, `surface_tab: upgrades`, `upgrade_panel_visible: true`, `debug_telemetry: false`, viewport `1280x720`.
- Earlier reviews:
  - `docs/planning/UPGRADE_TAB_NORMAL_SCALE_REVIEW_2026_06_26.md`
  - `docs/planning/UPGRADE_BAY_NORMAL_SCALE_AFFORDANCE_REVIEW_AFTER_COPY_TUNE_2026_06_26.md`
  - `docs/planning/RESULT_UPGRADE_ACTIVE_COPY_REVIEW_AFTER_PROMPT_ABSTRACTION_2026_06_26.md`

## Findings

| Area | Current Read | Result |
| --- | --- | --- |
| Surface tab state | Correct. The current Playwright artifact now shows the extracted surface upgrade tab, not an active-dive false positive. | Pass |
| Selected upgrade model | Still correct for the current slice: one upgrade, position count, Up/Down selection, E/Enter purchase. | Pass |
| Cost/state copy | Understandable, but multi-line cost and needs copy consume vertical room quickly. | Pass with watchlist |
| Effect/feedback copy | The bottom lines clip against the panel/viewport in the latest screenshot. | Fail for polish |
| Scope boundary | No need for tech tree, inventory grid, scroll list, field guide, minimap, or objective checklist. | Pass |

## Decision

The current upgrade panel is not a gameplay blocker, but it should not be accepted as polished. The next issue should plan a compact layout/copy fix that preserves the one-selected-upgrade model.

The fix should prefer one or more narrow changes:

- shorten or split `Effect:` and feedback copy,
- reduce duplicate resource lines between `Cost`, `State`, `Needs`, and feedback,
- reserve a fixed panel area for feedback,
- tune label bounds/wrapping,
- move nonessential explanatory text out of the selected-upgrade panel.

Do not solve this with:

- a tech tree,
- upgrade grid,
- inventory ledger,
- field guide,
- quest checklist,
- scrolling UI,
- new upgrade categories,
- platform/input implementation.

## Follow-Up

#405 should plan the exact compact layout/copy fix. #406 should implement only the selected narrow fix. #407 should add guard coverage so future upgrade descriptions do not silently reintroduce clipped panel text.
