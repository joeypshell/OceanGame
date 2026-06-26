# Upgrade Tab Normal-Scale Review - 2026-06-26

Status: review artifact for issue #268.

## Purpose

Recheck the surface upgrade tab at normal scale after the wrapping and taller-panel pass from issue #257, then after the surface moonpool/waterline and panel-opacity changes.

The upgrade bay should stay readable as one selected upgrade at a time. It should not become a tech tree, crafting grid, inventory view, field guide, minimap, route graph, or checklist UI.

## Evidence

Build: `92b1a1e`.

Viewport: `1365x768`.

Capture method: temporary Godot script outside the repository using the screenshot workflow. Debug telemetry was hidden.

Local screenshots:

- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_missing_resources_oxygen_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_available_oxygen_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_owned_oxygen_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_scan_locked_pressure_seal_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_dependency_locked_echo_lens_pass_watchlist.png`

## State Coverage

| State | Representative Capture | Result |
| --- | --- | --- |
| Missing resources | `Oxygen Tank I` without banked materials | Pass. Missing resource copy stays inside the panel. |
| Available | `Oxygen Tank I` with exact banked materials | Pass. Purchase prompt remains clear and does not crowd the cost line. |
| Owned | `Oxygen Tank I` installed | Pass. Owned copy reads as durable progression, not inventory management. |
| Scan-locked | `Pressure Seal I` without `Thermal Vent` scan | Pass. Missing scan copy stays within the panel and ties the upgrade to a remembered place. |
| Dependency-locked | `Echo Lens I` with cache scan but without `Signal Lens I` | Pass. Cost wraps, dependency state is visible, and the role hint stays inside the panel. |

## Decision

Pass with watchlist.

The upgrade tab now satisfies the playable vertical-slice readability bar at normal scale. Long upgrade names, descriptions, costs, state copy, and feedback fit inside the panel after wrapping. The interaction model remains deliberately small: one selected upgrade, left/right cycling, and `E/Enter` purchase.

The surface art remains visible behind the panels, but the darker panel skin keeps text readable. This is acceptable for the current slice because the upgrade tab is a surface review mode, not an active navigation view.

## Watchlist

- Recheck the upgrade tab if more upgrades are added or current upgrade descriptions get longer.
- Keep selected-upgrade navigation as the current scope until a separate issue proves the need for a broader upgrade UI.
- Do not add a scrollable tech tree, full material inventory, field guide, route map, or objective checklist during this milestone.
