# Mobile-Like Low/Critical Oxygen Capture Coverage - 2026-06-26

Status: implemented as evidence-only Playwright coverage.

Issue: #411.

## Decision

Add mobile-like low and critical oxygen captures. The review is justified because the future touch safe-zone plan depends on oxygen warnings remaining visible at phone-like landscape width, and the normal-scale visual smoke already has deterministic low/critical oxygen captures.

## Scope

This issue adds two screenshots to the mobile-like Playwright smoke:

- `mobile-like-active-low-oxygen.png`
- `mobile-like-active-critical-oxygen.png`

The captures use the existing `960x540` mobile-like viewport and the same `window.__oceangameVisualState` assertions as the desktop visual smoke.

## Non-Goals

- No mobile controls.
- No controller controls.
- No mobile export settings.
- No HUD redesign.
- No gameplay/state/economy changes.
- No minimap, field guide, quest checklist, combat, capture, harvesting, or broad route expansion.

## Acceptance Notes

These captures prove only that the exported web build can deterministically reach and record low/critical oxygen states at the smaller landscape viewport. They do not certify mobile readiness. Future touch-control work must still show that controls do not cover oxygen, safe return, player/sub, predator, pressure/cache, or reward cues.
