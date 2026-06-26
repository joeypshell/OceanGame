# Compact Upgrade Details Fix Plan - 2026-06-26

Status: implementation-ready plan.

Issue: #405.

## Purpose

Plan a narrow fix for selected-upgrade detail clipping without adding a tech tree, upgrade grid, inventory ledger, field guide, minimap, objective checklist, scroll view, controller support, touch UI, new upgrades, or economy tuning.

## Problem Summary

The latest Playwright upgrade-tab screenshot shows the selected-upgrade panel clipping bottom feedback text at `1280x720`.

Two causes are visible:

- `HUD/UpgradePanel` is positioned from `y=376` to `y=728`, which extends beyond a `720` viewport.
- Upgrade copy duplicates information across `Cost`, `State`, `Needs`, `Effect`, and `Feedback`, so a missing-resource state can exceed the panel even before more upgrades are added.

## Selected Fix

Use a combined bounds-and-copy fix:

1. Keep the one-selected-upgrade model.
2. Keep the panel on the surface `Upgrades` tab.
3. Move/resize the panel so it ends inside the `1280x720` viewport with a visible bottom margin.
4. Compact selected-upgrade copy by making each label own one job:
   - item label: selected upgrade name plus one short description,
   - cost label: cost only,
   - state label: owned/available/locked/missing status plus shortest missing requirement,
   - feedback label: last action feedback only, or blank when it would duplicate state.
5. Replace long effect text in state lines with short role/effect summaries.
6. Keep `Echo Lens I` no-locator role language, but make it compact.

## Implementation Constraints For #406

Recommended scene/layout changes:

- Keep `UpgradePanel.offset_bottom <= 704` for a `1280x720` viewport.
- Keep `UpgradeMenuFeedback` inside the panel with a fixed bottom margin.
- Do not allow labels to draw outside the panel; clipping is acceptable only if tests/reviews prove the visible copy remains complete.

Recommended copy/helper changes:

- Add a compact effect/role helper, for example `_format_upgrade_effect_summary(upgrade)`.
- Use short effect summaries such as:
  - `Effect: +10 max O2.`,
  - `Effect: opens first pressure route.`,
  - `Effect: material scan pulse.`,
  - `Role: broad wreck echoes, not a locator.`,
  - `Effect: +1 cargo slot.`,
  - `Effect: earlier predator warning.`,
  - `Effect: one decoy window per expedition.`
- When the selected upgrade is missing resources, the feedback label should not repeat a full `Banked:` ledger unless the player just attempted purchase.
- Purchase/missing feedback should stay one or two short lines.

## Acceptance Target For #406

After implementation:

- `upgrade-tab.png` should show the full selected-upgrade panel within `1280x720`.
- The bottom panel border and final feedback line should be visible.
- `Oxygen Tank I`, `Echo Lens I`, and `Decoy Pulse I` states should remain understandable.
- No new upgrade UI model should be introduced.

## Coverage Target For #407

Add guard coverage around:

- panel metadata or scene bounds,
- compact effect summaries for all configured upgrades,
- no-locator wording for `Echo Lens I`,
- no duplicated full banked-resource ledger in default feedback,
- Playwright `upgrade-tab` state assertion continuing to prove `surface_tab: upgrades`.
