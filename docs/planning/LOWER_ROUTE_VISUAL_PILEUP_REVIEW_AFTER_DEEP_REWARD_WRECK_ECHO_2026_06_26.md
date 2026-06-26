# Lower-Route Visual Pileup Review After Deep Reward And Wreck Echo - 2026-06-26

Status: pass with tuning-needed watchlist.

Issue: #419.

## Purpose

Recheck lower-route visual density after the deep reward lure pass, Wreck Echo no-locator guardrails, and mobile-like screenshot scaffold work.

## Evidence

Reviewed local Playwright artifacts:

- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/lower-route-pressure-gate.png`
- `test-results/playwright-mobile-like/mobile-landscape-smoke-Oce-db3fc-one-like-landscape-viewport-mobile-like-landscape/mobile-like-lower-route-pressure-gate.png`
- `test-results/playwright-mobile-like/mobile-landscape-smoke-Oce-ec622-one-like-landscape-viewport-mobile-like-landscape/mobile-like-wreck-echo-route-staged.png`

Note: the mobile-like capture uses a `960x540` viewport with device scale factor `2`, so the PNG pixel dimensions are larger than the logical viewport.

## Findings

| Element | Result | Notes |
| --- | --- | --- |
| HUD and safe return | Pass | Oxygen, depth, base direction, cargo, scan target, prompt, and status remain readable. |
| Predator danger | Pass | Red danger language remains clear and louder than reward/cached mystery cues. |
| Deep reward lure | Pass with watchlist | The amber lure now separates better from green/cyan signal language, but it can still overlap the player/sub and predator silhouette. |
| Pressure/cache opportunity | Pass with watchlist | The blue pressure/cache column and cache cues remain readable, but the upper-right cluster is crowded at smaller landscape width. |
| Wreck Echo relationship | Watchlist | Wreck Echo stays narrow and non-locator, but any future expansion near this stack would likely overfill the route. |
| Player/sub | Watchlist | The sub remains visible, but can sit under the amber reward/predator stack during lower-route captures. |

## Decision

The lower route is acceptable for the current playable slice but should not receive more concepts in this area before a narrow tuning pass. The problem is visual pileup, not missing explanation. Do not add labels, minimaps, field guides, objective checklists, route graphs, or new source art as the first response.

## Recommended Next Implementation Candidate

Plan a small lower-route cue-priority tuning pass:

- reduce overlap between the reward lure, predator silhouette, and player/sub,
- keep predator danger louder than reward,
- keep pressure/cache and Wreck Echo readable without enlarging them,
- dim or hide fallback geometry that no longer carries meaning,
- preserve all gameplay nodes, routes, collision, scan targets, pickups, pressure gates, Wreck Echo triggers, predator behavior, and progression.

## Non-Goals

- No new route content.
- No broad art-kit integration.
- No new source-art pass unless tuning fails.
- No minimap, field guide, checklist, labels, combat, capture, harvesting, mobile/touch implementation, controller implementation, or procedural generation.
