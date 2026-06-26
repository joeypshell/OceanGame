# Active HUD Normal-Scale Screenshot Review - 2026-06-26

Status: review artifact for issue #241.

## Scope

Reviewed the active-dive HUD at normal player scale after the compact HUD skin implementation.

Related docs:

- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md`
- `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshots were written to local Godot user data and are not committed source assets.

Commit reviewed: `e6119d7`

Viewport: `1365x768`

Debug telemetry: hidden

Screenshot directory:

`C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_active_hud_review_2026_06_26/`

## Captures

| View | Screenshot | Observation | Result |
| --- | --- | --- | --- |
| Normal dive | `oceangame_active_hud_normal_dive_2026_06_26.png` | Active stats and dive-info panels read clearly. HUD no longer floats as loose full-screen text. The player, base, and resource remain visible. | Pass with follow-up |
| Selected scan target | `oceangame_active_hud_selected_scan_target_2026_06_26.png` | Scan target line is readable and bounded. The selected `Kelp Fiber` target remains visible in the playfield. | Pass |
| Cargo slots | `oceangame_active_hud_cargo_slots_2026_06_26.png` | Mini-icons and filled cargo slots are much easier to scan than text-only cargo. Full cargo state reads quickly. | Pass with follow-up |
| Low oxygen | `oceangame_active_hud_low_oxygen_2026_06_26.png` | Warm warning panel is clear without blocking route decisions. Oxygen and base direction tint together and remain readable. | Pass |
| Critical oxygen | `oceangame_active_hud_critical_oxygen_2026_06_26.png` | Critical warning has strong urgency while leaving the pressure route and player readable. Base direction remains visible. | Pass |

## Immediate Fixes

1. Move or restyle the active `Discoveries` count.
   - Current issue: `Discoveries: 7` sits between the stats panel and dive-info panel, and can visually collide with the cargo slot row when cargo is full.
   - Recommended fix: keep the count, but either include it inside the stats panel with a taller panel, move it into the dive-info panel, or replace it with a smaller compact icon/count treatment.

## Deferred Polish

- Consider slightly shortening the active prompt when both `Burst Thruster` and `Decoy Pulse` text are present.
- Consider an eventual icon-first oxygen/cargo presentation, but only after the current text remains proven readable.
- Re-run this review after lower-route density cleanup, because the critical-oxygen view overlaps the busiest pressure/wreck/predator area.

## Acceptance Notes

- The compact active HUD now supports the playable-slice requirement that operational text not dominate the playfield.
- Low and critical oxygen warnings increase urgency without hiding the safe-return direction.
- Cargo slot readability improved and should remain in the active HUD.
- The only immediate readability miss is the `Discoveries` count placement.
