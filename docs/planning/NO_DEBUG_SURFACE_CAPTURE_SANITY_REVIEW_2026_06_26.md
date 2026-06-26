# No-Debug Surface Capture Sanity Review - 2026-06-26

Status: review artifact for issue #269.

## Purpose

Confirm that normal player-facing surface views keep prototype/debug details hidden when `show_debug_telemetry` is false.

Views checked:

- surface ready,
- result,
- upgrade tab,
- recent expedition log.

## Evidence Sources

Builds reviewed:

- `1c441c2` for surface moonpool/waterline ready/result captures.
- `9fc8027` for upgrade-tab normal-scale captures.

Local screenshot evidence:

- Ready: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/oceangame_acceptance_2026_06_26_seed_8919_surface_ready_kelpbloom_pass_watchlist.png`
- Result: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/oceangame_acceptance_2026_06_26_seed_8919_result_kelpbloom_pass_watchlist.png`
- Upgrade tab: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_available_oxygen_pass_watchlist.png`
- Upgrade tab dependency state: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_upgrade_tab_review_2026_06_26/oceangame_acceptance_2026_06_26_upgrade_tab_dependency_locked_echo_lens_pass_watchlist.png`

Code and test checks:

- `scripts/main.gd` keeps `Debug: F9 resets prototype save.` behind `show_debug_telemetry`.
- `scripts/main.gd` keeps recent-log seed and cluster-pattern details behind `show_debug_telemetry`.
- `tests/logic_tests.gd` covers ready-panel F9 gating in `surface summary tabs`.
- `tests/logic_tests.gd` covers recent expedition log compactness and debug separation in `recent expedition log`.

## Leak Checklist

| Detail | Normal View Result |
| --- | --- |
| Seed | Hidden in normal ready, result, upgrade, and log views. |
| Raw condition id | Hidden; condition copy uses display names and player-facing briefing language. |
| Cluster pattern | Hidden unless debug telemetry is enabled. |
| Predator route id | Hidden; route copy uses player-facing danger/research language. |
| `F9 resets prototype save` | Hidden unless debug telemetry is enabled. |
| Oxygen-at-result internals | Hidden; result copy uses return/failure framing and banked cargo/scans. |
| Failure cause internals | Hidden; failure surface copy remains player-facing. |

## Decision

Pass.

The normal surface views are acceptable for the playable vertical-slice gate. No leak was found that needs a code fix or new follow-up issue.

## Watchlist

- Continue using debug telemetry only for review captures, then hide it before player-facing screenshots.
- If future surface panels add seed, condition, route, or failure metadata, keep those fields behind `show_debug_telemetry`.
- Do not expose raw ids, reset shortcuts, cluster patterns, or route ids as normal player guidance.
