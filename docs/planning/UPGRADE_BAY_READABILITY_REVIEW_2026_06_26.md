# Upgrade Bay Readability Review - 2026-06-26

Status: review artifact and small layout fix for issue #257.

## Purpose

Review the surface upgrade bay against the current seven-upgrade set: `Oxygen Tank I`, `Pressure Seal I`, `Signal Lens I`, `Echo Lens I`, `Cargo Rack I`, `Predator Warning I`, and `Decoy Pulse I`.

The upgrade bay should help the player pick one practical next upgrade without becoming a tech tree, crafting grid, inventory UI, field guide, or objective checklist.

## Summary Decision

The upgrade state model is readable enough for the playable vertical-slice gate after one layout tune:

- the upgrade panel is taller,
- upgrade item, cost, state, and feedback labels now wrap inside the panel,
- the view still presents one selected upgrade at a time instead of a full tree.

The bay remains a surface-only review/purchase view. It should not appear during active diving and should not replace result memory or route readability.

## State Coverage

| State | Current Read | Review |
| --- | --- | --- |
| Owned | `State: Owned` plus the owned text and compact role hint when relevant. | Pass. It confirms durable progression without adding inventory management. |
| Available | `State: Available now` plus cost and purchase prompt. | Pass. It makes the next action clear. |
| Scan-locked | `State: Locked by scan` plus the missing discovery name. | Pass. It connects upgrades to remembered places without adding a quest checklist. |
| Missing resources | `State: Missing resources` plus only the remaining material gap. | Pass. It avoids dumping the full bank/inventory state. |
| Dependency-locked | `State: Locked by upgrade` plus the required upgrade name. | Pass. It supports Echo Lens and Decoy Pulse dependencies without drawing a tree. |

## Upgrade Role Reads

| Upgrade | Readability Role | Watchlist |
| --- | --- | --- |
| `Oxygen Tank I` | Longer, safer runs. | Keep oxygen benefit concrete and do not imply oxygen refills. |
| `Pressure Seal I` | First pressure route access. | Keep pressure gate state clearer than any upgrade prose. |
| `Signal Lens I` | Practical repeat resource scan pulse. | Do not let it become a hidden-object scanner or minimap. |
| `Echo Lens I` | Broad wreck echoes, not material pings. | Keep no-locator language guarded by tests. |
| `Cargo Rack I` | One extra carried cargo slot. | Do not introduce inventory-grid management. |
| `Predator Warning I` | Earlier predator route warning. | Do not imply safety, combat, or predator removal. |
| `Decoy Pulse I` | One-use non-lethal route timing countermeasure. | Keep it non-combat and dependency-gated behind predator observation. |

## Layout Fix

The surface readiness review found the upgrade tab failed polish because long upgrade copy could overflow the panel. This pass keeps the same interaction model but gives the upgrade panel more vertical room and enables wrapping on:

- selected upgrade name/description,
- cost,
- state,
- purchase feedback.

This is intentionally narrow. It does not add a scroll list, grid, tree, or new upgrade UI mode.

## Remaining Watchlist

- Recheck the upgrade tab after the next surface moonpool/waterline art pass, because the panel sits over the surface scene.
- If more upgrades are added, keep the bay one-selected-upgrade-at-a-time until a separate UI issue justifies a broader view.
- Keep purchase feedback compact; long owned/locked prose should move back into upgrade data only if it still wraps cleanly.

## Non-Goals

- No tech tree.
- No crafting grid.
- No inventory rearranging.
- No field guide.
- No quest checklist.
- No minimap or route graph.
- No new upgrades or economy changes.
