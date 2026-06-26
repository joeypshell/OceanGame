# Mobile-Like Landscape Screenshot Scaffold - 2026-06-26

Status: implemented as optional evidence workflow.

Issue: #399.

## Purpose

Add repeatable phone-like landscape screenshot evidence without implementing touch controls, controller support, mobile export settings, device automation, minimaps, field guides, quest checklists, combat, or broad UI redesign.

## Decision

Add a separate Playwright scaffold rather than folding mobile-like captures into the default desktop visual smoke. This keeps normal desktop verification fast and stable while giving future HUD, route, surface-panel, and virtual-control safe-zone work a repeatable smaller landscape viewport.

## Implemented Scaffold

- `tests/playwright/visual-helpers.mjs` shares boot, key-hold, capture, visual-state assertion, and extraction helpers across desktop and mobile-like tests.
- `tests/playwright/mobile-landscape.config.mjs` runs a separate `960x540` landscape viewport with device scale factor `2`.
- `tests/playwright/mobile-landscape-smoke.spec.mjs` captures:
  - `mobile-like-surface-ready.png`,
  - `mobile-like-active-dive.png`,
  - `mobile-like-lower-route-pressure-gate.png`.
- `npm run test:visual:mobile-like` exports the web build and runs the mobile-like smoke.
- `npm run test:visual:mobile-like:existing` runs against an already-exported build.

## Boundaries

This workflow is safe-area evidence only. A passing mobile-like smoke means the current exported canvas can be inspected at a smaller landscape viewport; it does not mean:

- iPhone/mobile support is complete,
- touch controls exist,
- notches, rounded corners, browser chrome, or platform safe areas are solved,
- controller prompts are ready,
- mobile performance has been profiled.

## Follow-Up

When mobile/touch implementation is promoted, extend the scaffold with explicit virtual-control safe zones, mobile export settings, semantic action prompt labels for touch, and physical-device or simulator evidence.
