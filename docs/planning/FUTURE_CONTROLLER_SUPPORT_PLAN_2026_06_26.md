# Future Controller Support Plan - 2026-06-26

Status: deferred planning note.

Issue: #379.

## Purpose

Plan future controller support while keeping the current desktop keyboard slice unchanged.

This plan does not implement controller bindings, controller UI, settings UI, input remapping, or platform-specific behavior.

## Dependency

This plan builds on `docs/planning/INPUT_ACTION_CONTRACT_REVIEW_2026_06_26.md`, which confirms player-facing gameplay is routed through semantic Godot actions.

## Proposed Mapping

| Godot action | Current keyboard | Future controller candidate | Notes |
| --- | --- | --- | --- |
| `move_left` / `move_right` / `move_up` / `move_down` | WASD / arrows | Left stick and D-pad | Movement should remain analog-friendly but preserve current acceleration/drag rules. |
| `interact` | E / Enter | South face button | Start dive, extract, confirm/purchase, and enter upgrade view. |
| `scan` | F | West or north face button | Must remain distinct from burst so scanning does not trigger accidental oxygen spend. |
| `burst_thruster` | Space | East face button or right shoulder | Needs an easy panic/escape press without interfering with movement. |
| `restart_dive` | R | Start/menu or a held confirm prompt | Use only on result/failure/surface flow, not during active dive by accident. |
| Surface tab left/right | `move_left` / `move_right` in surface state | Left/right shoulder or D-pad left/right | Current reuse is acceptable for keyboard, but controller may deserve explicit tab actions later. |
| Upgrade select up/down | `move_up` / `move_down` in upgrade view | D-pad/stick up/down | Keep one selected upgrade at a time; do not add a grid just for controller. |

## Prompt-Copy Requirements

Current player-facing text names keyboard keys directly. Before controller support becomes current scope, add a prompt abstraction or small formatter that can display action-aware labels.

Prompt copy should cover:

- start/extract/confirm: `interact`,
- next expedition: `restart_dive`,
- scan: `scan`,
- burst: `burst_thruster`,
- surface tab cycling,
- upgrade selection and purchase.

Avoid duplicating full keyboard/controller prompt strings throughout `main.gd`. A later implementation should centralize labels so keyboard, controller, and touch prompts can change together.

## Verification Expectations For Future Implementation

When controller work is promoted, verify:

- active dive movement with left stick and D-pad,
- burst direction uses held stick/D-pad direction or last facing direction,
- scan and burst are distinct and do not conflict near predators or pressure gates,
- start/extract/upgrade purchase use the same `interact` behavior as keyboard,
- result/failure next-expedition input cannot accidentally restart during active dive,
- surface tab cycling remains understandable,
- prompts match the detected input scheme or use neutral action labels,
- debug-only F3/F4/F5/F6/F9 shortcuts remain keyboard-only unless a developer-controller workflow is explicitly planned.

## Non-Goals

- No controller implementation now.
- No settings/options menu.
- No input rebinding UI.
- No aim reticle, weapon targeting, or combat-specific controls.
- No platform-specific save/profile behavior.
- No redesign of oxygen, cargo, scan, predator, pressure, Wreck Echo, or progression rules.

## Promotion Criteria

Promote controller implementation only after:

- current vertical-slice readability remains pass-with-watchlist or better,
- prompt abstraction is planned tightly enough to avoid copy drift,
- Playwright/Godot/manual verification can cover active dive and surface/result states,
- touch/mobile scope remains separate so controller work does not become a broad platform rewrite.
