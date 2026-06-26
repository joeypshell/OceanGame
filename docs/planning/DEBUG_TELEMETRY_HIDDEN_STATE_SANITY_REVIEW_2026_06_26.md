# Debug Telemetry Hidden-State Sanity Review - 2026-06-26

Status: review artifact for issue #337.

## Purpose

Confirm that debug telemetry remains hidden in normal player-facing states after the latest vertical-slice evidence updates.

This is a review-only pass. It does not remove debug tooling, change F3/F4/F5/F9 behavior, change result copy, or change HUD layout.

## Evidence Reviewed

- `docs/current/GAMEPLAY.md`
- `docs/current/TOOLING.md`
- `docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `scripts/main.gd`
- `tests/logic_tests.gd`

## Hidden-State Checklist

| State | Hidden Details Checked | Decision |
| --- | --- | --- |
| Ready | Raw seed, cluster pattern, condition id, predator route, and `F9 resets prototype save` copy stay hidden when `show_debug_telemetry` is false. Ready copy keeps only player-facing condition and goal text. | Pass |
| Result | `Playtest data`, raw seed, cluster pattern, raw condition id, predator route id, oxygen-at-result, failure cause internals, and raw scan ids stay hidden unless debug telemetry is enabled. | Pass |
| Failure | Failure copy stays player-facing; raw failure cause, oxygen telemetry, seed, pattern, condition id, and predator route id stay behind debug telemetry. | Pass |
| Log | Recent expedition entries show result, banked cargo, scans, contacts, and best depth. Seed and cluster pattern append only when debug telemetry is enabled. | Pass |
| Active dive | Active HUD shows O2, depth, base, cargo, discoveries, scan, prompt, status, and warning state. It does not expose seed, pattern, condition id, predator route id, or playtest telemetry. | Pass |
| F4/F5 hidden | F4 condition cycling and F5 review-seed cycling return immediately while debug telemetry is hidden, so they do not change player-facing condition, seed, placement, or status text. | Pass |

## Code And Test Notes

- `scripts/main.gd` keeps `show_debug_telemetry` defaulted to `false`.
- `_format_ready_panel_summary()` adds `Debug: F9 resets prototype save.` only while `show_debug_telemetry` is true.
- `_format_run_summary()` returns only the player summary while telemetry is hidden and appends `_format_run_telemetry()` only when enabled.
- `_format_recent_expedition_log()` appends seed and cluster-pattern text only while telemetry is enabled.
- `_cycle_debug_condition()` and `_cycle_debug_seed()` return immediately when telemetry is hidden.
- Logic tests cover result telemetry gating, condition-id hiding, recent-log debug separation, ready-panel F9-copy gating, active prompt non-telemetry, and compact surface-state visibility.

## F9 Clarification

The F9 development reset shortcut still exists for clean first-run review setup. This review only confirms the normal ready panel hides the F9 reset hint unless debug telemetry is enabled.

Do not remove F9 from development builds in this milestone. If a future player-facing reset affordance is needed, create a separate narrow issue after vertical-slice closeout.

## Decision

Pass.

Debug telemetry remains opt-in and hidden from normal ready, result, failure, log, and active-dive states. No runtime or copy change is needed.

## Watchlist

- Keep any future seed, condition id, predator route id, oxygen-at-result, failure-cause, or review-helper metadata behind `show_debug_telemetry`.
- Continue hiding debug telemetry before player-facing screenshots or demo passes.
- Do not turn debug review helpers into normal player guidance, quest text, route hints, or onboarding instructions.
