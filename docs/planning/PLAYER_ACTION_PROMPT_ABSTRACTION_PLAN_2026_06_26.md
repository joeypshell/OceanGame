# Player Action Prompt Abstraction Plan - 2026-06-26

Status: ready for first implementation.

Issue: #388.

## Purpose

Player-facing prompt text currently embeds keyboard labels directly in gameplay copy, such as `E/Enter`, `Space`, `R`, and `Up/Down`. That is acceptable for the current desktop keyboard prototype, but it will become brittle once controller and landscape mobile/touch support move from future planning into implementation.

The first abstraction should separate semantic actions from displayed labels without changing input behavior.

## Current Prompt Surfaces

| Surface | Current examples | Semantic actions |
| --- | --- | --- |
| Ready panel and prompt | `E/Enter begins`, `Press E or Enter to begin the dive` | start dive / interact |
| Active dive prompt | `At base: E/Enter extract`, `Space: burst -4 O2`, `F: decoy ready` | extract, burst, decoy |
| Surface result prompt | `press E for upgrades`, `press R for Expedition 2`, `Left/Right surface view` | open upgrades, next expedition, cycle tab |
| Upgrade bay | `Up/Down select`, `E/Enter buys` | select previous/next, purchase |
| Failure result | `press R for next expedition` | next expedition |

## First Implementation Contract

Add one small helper that maps semantic action ids to the current keyboard-facing labels.

Recommended ids:

- `interact`: `E/Enter`
- `restart_dive`: `R`
- `move_left_right`: `Left/Right`
- `move_up_down`: `Up/Down`
- `burst_thruster`: `Space`
- `decoy_pulse`: `F`

The helper may live in `scripts/main.gd` for the first pass because every current prompt is formatted there. Extract it later only if prompt formatting grows beyond this scene.

## Guardrails

- Do not add controller bindings in this issue batch.
- Do not add touch controls, virtual buttons, safe-area overlays, or mobile viewport behavior in this issue batch.
- Do not change gameplay inputs, action names, or `project.godot` bindings unless a later issue explicitly asks for it.
- Do not create a new settings menu or input-remapping UI.
- Keep prompt copy compact enough for the current active HUD limits.

## Follow-Up Order

1. Implement the keyboard label helper for current actions.
2. Route active HUD and surface prompts through the helper.
3. Add guard coverage for helper output and the most important prompt strings.
4. Review result, upgrade, and active HUD copy after the routing pass.

## Acceptance Notes

This plan intentionally keeps controller and mobile/touch support as future label profiles. The current work should make those future profiles possible without pretending they are already implemented.
