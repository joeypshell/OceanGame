# Active Prompt Burst/Decoy Review - 2026-06-26

Status: review and narrow copy tune for issue #283.

## Purpose

Review the active dive prompt when `Burst Thruster` and `Decoy Pulse I` are both visible.

## Decision

Pass with a narrow copy trim.

The combined prompt was understandable, but it was still one of the remaining active HUD watchlists. The prompt snippets now use shorter command-first copy:

- `Space: burst -4 O2`
- `Burst: 3s cooldown`
- `F: decoy ready`
- `Decoy spent`
- `Decoy locked`

This keeps the same behavior and input model while reducing prompt width.

## Guardrails

- No tool wheel.
- No inventory charge display.
- No objective checklist.
- No combat UI.
- No predator health/status UI.
- No behavior change to Burst Thruster, Decoy Pulse, scanning, predator route selection, pressure locks, oxygen, cargo, extraction, or save/load.
