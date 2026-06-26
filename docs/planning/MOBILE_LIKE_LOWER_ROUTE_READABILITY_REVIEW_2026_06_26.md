# Mobile-Like Lower-Route Readability Review - 2026-06-26

Status: pass with lower-route pileup watchlist.

Issue: #409.

## Purpose

Review the mobile-like `960x540` lower-route capture for pressure/cache, reward, predator, HUD, and return readability without adding touch controls, controller support, minimaps, field guides, quest checklists, combat, capture, harvesting, broad Wreck Echo expansion, or procedural generation.

## Evidence

Command:

```powershell
npm.cmd run test:visual:mobile-like:existing
```

Artifacts:

- `test-results/playwright-mobile-like/mobile-landscape-smoke-Oce-db3fc-one-like-landscape-viewport-mobile-like-landscape/mobile-like-lower-route-pressure-gate.png`
- `test-results/playwright-mobile-like/mobile-landscape-smoke-Oce-db3fc-one-like-landscape-viewport-mobile-like-landscape/mobile-like-lower-route-pressure-gate.json`

Metadata:

- `result: diving`
- `active_stats_visible: true`
- `debug_telemetry: false`
- `depth_meters: 208`
- `oxygen: 18`
- viewport: `960x540`

## Findings

| Element | Result | Notes |
| --- | --- | --- |
| HUD/readout | Pass | O2, depth, base direction, cargo, scan, prompt, and status are readable on the left. |
| Safe return | Pass | `Base: up 194m` remains clear even at the smaller viewport. |
| Predator lane | Pass | The red predator lane dominates the center-right and reads as danger. |
| Player/sub | Pass | The sub remains visible near the lower-right and is not hidden by HUD. |
| Pressure/cache relationship | Pass with watchlist | The pressure/cache gate area is visible, but partially cropped toward the upper/right route cluster. |
| Reward/resource cues | Pass with watchlist | Bright reward/resource cues near the top-right/top edge are partly clipped and contribute to visual pileup. |
| Mobile safe zones | Watchlist | The lower-route view uses a lot of right-side visual weight; future touch controls must avoid covering the player and predator lane. |

## Decision

The mobile-like lower route is usable as evidence and is not a blocker for the current desktop-first slice. It is not polished and not mobile-ready. The main concern is no longer HUD text; it is reduced composition room around the pressure/cache/reward/predator cluster at the smaller landscape width.

## Follow-Up

- #410 should turn this into future touch safe-zone constraints.
- #419 should recheck lower-route pileup after the mobile-like and source-art reviews.
- Do not add route labels, minimap, field guide, objective checklist, or touch controls from this review.
