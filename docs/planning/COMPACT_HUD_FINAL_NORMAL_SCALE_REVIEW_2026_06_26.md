# Compact HUD Final Normal-Scale Review - 2026-06-26

Status: review artifact for issue #324.

## Scope

Reviewed the final compact HUD polish pass at normal scale after issue #323.

Related docs:

- `docs/planning/COMPACT_HUD_FINAL_POLISH_PLAN_2026_06_26.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/GAMEPLAY.md`

Commit reviewed: `b671ec7`

Viewport: `1365x768`

Capture method: temporary Godot scripts outside the repo, using the screenshot workflow. Screenshots remain local and are not committed source assets.

Screenshot directory:

`C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_compact_hud_final_review_2026_06_26/`

## Captures

| View | Screenshot | Result |
| --- | --- | --- |
| Surface ready | `oceangame_compact_hud_final_surface_ready_2026_06_26.png` | Pass. Surface panel owns the view; active operational rows are hidden. |
| Normal active dive | `oceangame_compact_hud_final_active_normal_2026_06_26.png` | Pass. O2, depth, base, cargo, discoveries, scan, prompt, and status are bounded in two panels. |
| Selected scan target | `oceangame_compact_hud_final_selected_scan_target_2026_06_26.png` | Pass with watchlist. Scan target copy is compact and the pressure route remains readable; fixed top-left HUD can still cover some left-side world art if the camera is parked there. |
| One cargo | `oceangame_compact_hud_final_one_cargo_2026_06_26.png` | Pass. Filled slot icon reads without needing cargo text expansion. |
| Full cargo, locked fourth slot | `oceangame_compact_hud_final_full_cargo_locked_slot_2026_06_26.png` | Pass. Three filled slots plus one dim locked slot communicate current capacity. |
| Fourth slot unlocked | `oceangame_compact_hud_final_fourth_slot_unlocked_2026_06_26.png` | Pass. The fourth slot reads as available capacity without changing collection behavior. |
| Low oxygen | `oceangame_compact_hud_final_low_oxygen_2026_06_26.png` | Pass. Warm warning panel and O2/base tint are clear without hiding prompt or status. |
| Critical oxygen | `oceangame_compact_hud_final_critical_oxygen_2026_06_26.png` | Pass. Critical state is loudest, while player, route, and return direction remain readable. |
| Extraction prompt | `oceangame_compact_hud_final_extraction_prompt_2026_06_26.png` | Pass. `At base: E/Enter extract` stays inside the dive info panel. |
| Result surface | `oceangame_compact_hud_final_result_surface_2026_06_26.png` | Pass. Surface result panel hides active HUD rows. |
| Failure surface | `oceangame_compact_hud_final_failure_surface_2026_06_26.png` | Pass. Failure panel hides active HUD rows. |
| Debug telemetry on | `oceangame_compact_hud_final_debug_telemetry_on_2026_06_26.png` | Pass. Telemetry appears only when debug is enabled. |

## State Review

| State | Decision | Notes |
| --- | --- | --- |
| Surface ready | Pass | Ready panel stays panel-led and does not show active O2/depth/cargo rows. |
| Normal active dive | Pass | Active HUD is smaller and no longer dominates the playfield. |
| Selected scan target | Pass with watchlist | The `Scan:` line is compact; future left-side route art should account for the fixed top-left HUD footprint. |
| One cargo | Pass | Cargo text and slot icon agree. |
| Full cargo | Pass | Slot row remains inside the stats panel. |
| Fourth slot locked/unlocked | Pass | Locked capacity is visible-but-dim; unlocked capacity reads as an empty slot. |
| Low oxygen | Pass | Warning panel does not cover the dive info panel or lower-route decisions. |
| Critical oxygen | Pass | Critical O2/base emphasis is clear without adding oxygen mechanics. |
| Extraction prompt | Pass | Prompt is short enough for the panel. |
| Result/failure | Pass | Active operational rows stay hidden. |
| Debug hidden/on | Pass | Normal captures hide raw telemetry; debug-on capture exposes it for review only. |

## Overlap Review

The compact HUD does not block the player, pressure gate, predator lane, safe-return cue, or resource pickup in the reviewed normal, low-oxygen, critical-oxygen, and selected-scan captures.

Watchlist: because the HUD is anchored top-left, it can cover incidental left-side background or landmark art when the camera is centered on left-side route content. This is acceptable for the current slice because it does not hide the player, core scan target read, pressure gate, predator lane, cargo/resource feedback, or safe-return direction. Do not solve this by adding a minimap, objective panel, route graph, or movable HUD system yet.

## Follow-Up Decision

No new blocker issue is needed from this review.

Existing queued issues cover the useful next checks:

- #325 adds active HUD regression coverage.
- #326 and #327 recheck Decoy Pulse/Gulper readability.
- #336 rechecks surface panel contrast after the HUD polish.
- #337 rechecks debug hidden-state sanity after the latest evidence.

## Guardrails

Do not add:

- minimap,
- inventory grid,
- objective checklist,
- field-guide UI,
- route graph,
- exact locator,
- active-dive upgrade/log surfaces,
- new debug telemetry fields,
- oxygen, cargo, scan, extraction, save/load, upgrade, or route behavior changes.

## Recommendation

Pass with watchlist.

The final compact HUD polish clears the immediate readability problem: the active dive no longer reads as loose oversized text covering the game. The remaining HUD work should be regression coverage and follow-up reviews, not another layout rewrite.
