# Upgrade Bay Normal-Scale Affordance Review After Copy Tune - 2026-06-26

Status: review artifact for issue #314.

## Purpose

Review the surface upgrade bay at normal scale after the Up/Down selection copy tune.

This review does not change runtime layout, upgrade data, costs, prerequisites, or purchase behavior.

## Evidence Reviewed

- `docs/planning/UPGRADE_BAY_SELECTION_AFFORDANCE_REVIEW_2026_06_26.md`
- `docs/planning/UPGRADE_BAY_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/UPGRADE_TAB_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `scenes/Main.tscn`
- `scripts/main.gd`

No new screenshots were committed for this review.

## Affordance Review

| Area | Current Read | Decision |
| --- | --- | --- |
| Selected upgrade title | `Upgrade Bay (N/7) - Up/Down select` names both current selection position and selection input. | Pass |
| Upgrade item | Selected upgrade name and description remain one-at-a-time and wrapped in the upgrade panel. | Pass |
| Cost | `Cost:` line remains compact and does not become a full banked inventory view. | Pass |
| State | `State:` labels remain explicit for owned, available, scan-locked, upgrade-locked, and missing-resource states. | Pass |
| Feedback | Purchase and missing-requirement feedback stays inside the upgrade panel after the taller/wrapped layout pass. | Pass with watchlist |
| Surface prompt | Surface prompt says `Upgrade bay: Up/Down select, E purchase, R next expedition | Left/Right surface view`. | Pass |
| Panel contrast | Darker panel skin keeps upgrade copy readable over the surface boat/moonpool scene. | Pass with watchlist |

## Decision

Pass with watchlist.

The Up/Down and E/Enter actions are understandable without adding a grid, tree, inventory view, or field-guide UI. The current one-selected-upgrade model remains the right fit for the vertical slice because it keeps the player focused on the next practical preparation choice rather than browsing a full progression system.

## Watchlist

- Recheck if more upgrades are added or descriptions become longer.
- Keep purchase feedback compact; do not let the panel become a banked-resource ledger.
- Recheck panel contrast after any major surface art or HUD skin changes.

## No Follow-Up Issue Needed

No narrow blocker was found in this review. Future work can stay under the compact HUD final polish pass unless a screenshot later shows overflow, poor contrast, or missing input affordance.

## Guardrails

Do not add:

- tech tree,
- upgrade grid,
- inventory grid,
- scroll list,
- field-guide UI,
- quest checklist,
- minimap or route graph,
- new upgrades,
- economy tuning.
