# Asset Provenance Review - 2026-06-26

Status: review artifact for issue #216.

## Scope

Reviewed committed sprite/source asset coverage for matching source, export, and provenance notes.

Covered:

- Player sub bitmap sprites.
- Surface boat/base bitmap sprites.
- `Glow Plankton`, `Kelp Fiber`, and `Shell Fragments` SVG source/export assets.
- `Lantern Fry`, `Gulper Eel`, and `Thermal Vent` SVG source/export assets.
- Pressure wreck/cache scene sprites and visual study SVG.
- Scan/echo pulse SVG.

## Findings

| Asset Set | Source | Export / Runtime Asset | Provenance | Finding |
| --- | --- | --- | --- | --- |
| Player sub | No separate editable source; generated bitmap variants live in `assets/sprites/player/` | `assets/sprites/player/research_sub.png` | `assets/licenses/player_research_sub_generated.txt` | Fixed in this review. |
| Surface boat/base | No separate editable source; generated bitmap variants live in `assets/sprites/base/` | `assets/sprites/base/research_boat_clean.png` plus variants | `assets/licenses/surface_research_boat_generated.txt` | Fixed in this review. |
| Glow Plankton | `assets/source/sprites/resource_glow_plankton_sprite_v1.svg` | `assets/exports/sprites/resource_glow_plankton_sprite_v1.svg` | `assets/licenses/resource_glow_plankton_sprite_v1.txt` | Pass. |
| Kelp Fiber | `assets/source/sprites/resource_kelp_fiber_sprite_v1.svg` | `assets/exports/sprites/resource_kelp_fiber_sprite_v1.svg` | `assets/licenses/resource_kelp_fiber_sprite_v1.txt` | Pass. |
| Shell Fragments | `assets/source/sprites/resource_shell_fragments_sprite_v1.svg` | `assets/exports/sprites/resource_shell_fragments_sprite_v1.svg` | `assets/licenses/resource_shell_fragments_sprite_v1.txt` | Pass. |
| Lantern Fry | `assets/source/sprites/creature_lantern_fry_sprite_v1.svg` | `assets/exports/sprites/creature_lantern_fry_sprite_v1.svg` | `assets/licenses/creature_lantern_fry_sprite_v1.txt` | Pass. |
| Gulper Eel | `assets/source/sprites/creature_gulper_eel_sprite_v1.svg` | `assets/exports/sprites/creature_gulper_eel_sprite_v1.svg` | `assets/licenses/creature_gulper_eel_sprite_v1.txt` | Pass. |
| Thermal Vent | `assets/source/sprites/landmark_thermal_vent_sprite_v1.svg` | `assets/exports/sprites/landmark_thermal_vent_sprite_v1.svg` | `assets/licenses/landmark_thermal_vent_sprite_v1.txt` | Pass. |
| Pressure wreck outside scan | `assets/source/sprites/pressure_wreck_outer_scan_sprite_v1.svg` | `assets/exports/sprites/pressure_wreck_outer_scan_sprite_v1.svg` | `assets/licenses/pressure_wreck_outer_scan_sprite_v1.txt` | Pass; wired to `PressureLockedWreck/OuterScan`. |
| Wreck Signal Cache | `assets/source/sprites/wreck_signal_cache_sprite_v1.svg` | `assets/exports/sprites/wreck_signal_cache_sprite_v1.svg` | `assets/licenses/wreck_signal_cache_sprite_v1.txt` | Pass; wired to `PressureLockedWreck/WreckSignalCache`. |
| Pressure wreck/cache study | `assets/source/sprites/study_pressure_wreck_cache_signal_v1.svg` | `assets/exports/sprites/study_pressure_wreck_cache_signal_v1.svg` | `assets/licenses/study_pressure_wreck_cache_signal_v1.txt` | Pass; prototype-only study. |
| Scan/echo pulse | `assets/source/sprites/ui_scan_echo_pulse_v1.svg` | `assets/exports/sprites/ui_scan_echo_pulse_v1.svg` | `assets/licenses/ui_scan_echo_pulse_v1.txt` | Pass; future feedback asset only. |

## Import Cache Check

`*.import` files are ignored by `.gitignore` and are not tracked in the committed asset set reviewed here. Godot import/cache files should remain uncommitted.

## Follow-Up

No larger cleanup issue is required from this review.

Pressure wreck/cache study wiring was reviewed in `docs/planning/PRESSURE_WRECK_CACHE_PROVENANCE_SCENE_REVIEW_2026_06_26.md`; decision is to keep the combined study unwired while the scene-specific outside scan and cache sprites remain active.

Future generated bitmap assets should receive provenance notes in the same commit that adds them, even if they do not have a separate editable source file.

## Verification

- MCP context self-test.
- `git diff --check`.
- `git status --short`.
