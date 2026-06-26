# Input Action Contract Review - 2026-06-26

Status: pass with follow-up planning.

Issue: #378.

## Purpose

Audit current input usage so future controller and landscape touch controls can map onto semantic Godot actions without rewriting gameplay rules.

This review does not add controller bindings, touch UI, mobile export settings, prompt abstraction, or settings menus.

## Search Evidence

Commands used:

```powershell
rg "Input\.|InputEvent|is_action|KEY_|move_left|move_right|move_up|move_down|interact|restart_dive|scan|burst_thruster" -n scripts scenes project.godot docs/current/ARCHITECTURE.md docs/current/GAMEPLAY.md docs/planning/FUTURE_PLATFORM_INPUT_TARGETS_2026_06_26.md
```

Relevant files:

- `project.godot`
- `scripts/main.gd`
- `scripts/player.gd`
- `docs/current/GAMEPLAY.md`
- `docs/current/ARCHITECTURE.md`
- `docs/planning/FUTURE_PLATFORM_INPUT_TARGETS_2026_06_26.md`

## Player-Facing Action Contract

Current player-facing actions are routed through the Godot InputMap:

| Action | Current keys | Current role | Future mapping expectation |
| --- | --- | --- | --- |
| `move_left` | A, Left | Active dive movement; surface tab left | D-pad/stick left; touch movement left |
| `move_right` | D, Right | Active dive movement; surface tab right | D-pad/stick right; touch movement right |
| `move_up` | W, Up | Active dive movement; upgrade selection up | D-pad/stick up; touch movement up |
| `move_down` | S, Down | Active dive movement; upgrade selection down | D-pad/stick down; touch movement down |
| `interact` | E, Enter | Start dive, extract, confirm/purchase, enter upgrade surface view | Face button / touch confirm |
| `restart_dive` | R | Prepare next expedition after result/failure | Face/menu button / touch next expedition |
| `scan` | F | Scan resources, landmarks, creatures, Wreck Signal Cache, and Decoy Pulse re-scan | Face/shoulder button / touch scan |
| `burst_thruster` | Space | Active dive burst tool | Face/shoulder button / touch burst |

`scripts/player.gd` uses `Input.get_vector("move_left", "move_right", "move_up", "move_down")` for movement and burst direction. `scripts/main.gd` uses `Input.is_action_just_pressed(...)` for player-facing interaction, surface tabs, upgrade selection, restart, burst, and scan.

## Debug-Only Keyboard Shortcuts

The following direct key checks exist in `scripts/main.gd` and are development-only:

| Key | Role | Player-facing? |
| --- | --- | --- |
| F3 | Toggle debug telemetry | No |
| F4 | Cycle expedition condition when debug telemetry is visible | No |
| F5 | Advance review seed when debug telemetry is visible | No |
| F6 | Stage Wreck Echo visual smoke states | No |
| F9 | Reset local prototype save | No |

These direct key checks are acceptable for now because they are debug tools. They should stay out of controller and mobile/touch requirements unless a later developer workflow issue explicitly promotes them.

## Current Gaps Before Controller Or Touch Work

- The `project.godot` InputMap currently contains keyboard events only.
- Player-facing prompts still name keyboard keys directly in several places, such as Spacebar, F, E/Enter, R, Left/Right, and Up/Down.
- Surface tab cycling reuses movement actions; this is acceptable for keyboard, but controller/touch planning should confirm whether tab actions need separate semantic names.
- `scan` and `burst_thruster` are separate actions, which is good for controller/touch, but the HUD prompt should eventually come from an input prompt helper rather than hard-coded key names.
- Touch controls will need an overlay/safe-area review so action buttons do not cover oxygen, scan target, player, return cues, predator warnings, pressure gates, or Wreck Echo markers.

## Follow-Up Issues

Existing next issues cover the required follow-up planning:

- #379: plan deferred controller support mapping and prompt requirements.
- #380: plan deferred mobile iPhone landscape touch-control and safe-area requirements.
- #381: review Playwright and screenshot workflow gaps for future route HUD and input states.

## Decision

Pass.

The current gameplay code is action-routed enough for future controller and mobile/touch work. The main future risk is prompt/UI coupling to keyboard labels, not gameplay logic coupling.

## Guardrails

- Keep gameplay input routed through semantic actions.
- Keep debug keys separate from player-facing action requirements.
- Do not add raw key checks for new player-facing mechanics.
- Do not add touch or controller implementation during the current slice unless a future issue explicitly promotes it.

## Verification

- Input usage audited with `rg`.
- `git diff --check` should pass before commit.
