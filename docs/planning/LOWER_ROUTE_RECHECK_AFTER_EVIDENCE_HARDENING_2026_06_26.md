# Lower Route Recheck After Evidence Hardening - 2026-06-26

Status: pass with lower-route density watchlist.

Issue: #394.

## Purpose

Recheck lower-route readability after the Playwright screenshot workflow gained state assertions, metadata sidecars, low/critical oxygen captures, no-debug Wreck Echo result capture, and prompt-label hardening.

This review does not add new route content, controller/touch scope, minimaps, quest UI, combat, Wreck Echo expansion, or procedural biome generation.

## Evidence

- `npm.cmd run test:visual` passed with 3 Playwright tests during #393/#394 work.
- Reviewed `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/lower-route-pressure-gate.png`.
- The matching metadata sidecar confirms the capture is an active dive state, not a mislabeled surface or result capture.

## Readability Findings

| Element | Read | Status |
| --- | --- | --- |
| Active HUD | O2, depth, base direction, cargo, scan target, prompt, and predator strike status remain readable in the upper-left panels. | Pass |
| Safe-return pressure | `Base: up 194m` plus O2 12/30 makes the return problem clear before the player pushes farther. | Pass |
| Predator danger | Gulper/predator lane reads as red route danger, and the status line names the predator strike consequence. | Pass |
| Pressure/cache stack | The blue pressure structure and cache-related cue stack remain distinguishable from red predator danger. | Pass with watchlist |
| Reward/clue lights | Bright yellow/green reward, cache, and route cue lights cluster in the same lower-right visual band. | Watchlist |
| Wreck Echo relationship | The current lower-route evidence still supports Wreck Echo as a downstream optional research clue, not a new map layer or checklist. | Pass |

## Decision

The lower route is acceptable for the current playable slice, but it is not visually polished. The next visual target should be narrow and should reduce cue competition rather than add new route concepts.

## Follow-Up Guidance

- Prefer one narrow source-art/readability target that separates lower-route meanings already on screen.
- Do not add another bright marker, minimap, route graph, objective list, or field-guide entry.
- Preserve the existing read hierarchy: oxygen/base safety first, predator danger second, pressure/cache opportunity third, optional research/reward curiosity last.
- Recheck this same Playwright lower-route capture after any selected visual target lands.
