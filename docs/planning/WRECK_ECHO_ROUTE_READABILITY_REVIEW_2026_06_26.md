# Wreck Echo Route Readability Review - 2026-06-26

Status: pass with watchlist.

Issue: #366.

## Evidence

Verification source: Playwright Web visual smoke after the first Wreck Echo implementation and staged Wreck Echo visual coverage.

Local artifact paths:

- `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-route-staged.png`
- `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-result-readback.png`
- `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/lower-route-pressure-gate.png`

Metadata:

- Viewport: 1280 x 720.
- Route state: F3 debug telemetry enabled, F6 staged Wreck Echo route/result visual smoke state.
- Expedition: 1.
- Seed: 8919 in the staged result telemetry.
- Condition: Kelp Bloom in the staged result telemetry.
- Pattern: Deep reward route in the staged result telemetry.
- Screenshots are local artifacts only and should not be committed as golden images.

## Result

The first Wreck Echo route is acceptable as a narrow runtime pass, but it should remain on the readability watchlist before any route expansion.

Pass points:

- Active HUD panels stay bounded and readable at normal scale.
- Oxygen, depth, base direction, cargo, scan, and prompt/status text remain readable.
- The Wreck Echo clue reads as one local deeper-right point rather than a full biome, map, or checklist.
- The clue does not add exact locator, objective, field-guide, minimap, or quest language.
- The extraction result now shows the compact `Research:` line inside the result panel without raw format placeholders or overflow.
- The result readback keeps Wreck Echo as run evidence rather than durable progression.

Watchlist points:

- The staged route view puts Wreck Echo close to the Gulper/predator lane, and predator feedback currently dominates the status line.
- The Wreck Echo clue, deep reward lure, predator lane, and pressure/cache shell all occupy the same lower-right visual family of translucent shapes.
- The staged Wreck Echo route capture does not fully show pressure gate/cache context at the same time as the pocket, so the route's downstream relationship is implied more than proven in one frame.
- The route is readable at current scale, but a later source-art or lower-route density change could easily make it feel like another reward lure instead of a research clue.

## Follow-Up Fixes

Use existing open follow-ups before expanding Wreck Echo:

- #367 should tune Wreck Echo route visuals and clue copy from this evidence, with emphasis on separating the clue core from predator/reward shapes without adding markers.
- #371 should check whether the active status line overemphasizes predator contact during Wreck Echo staging or real attempts.
- #375 should recheck lower-route pileup after any Wreck Echo/source-art adjustment.

Avoid in the tuning pass:

- minimap or route panel,
- exact locator language,
- persistent objective marker,
- field-guide or checklist UI,
- new Wreck Echo economy/resource,
- predator combat or harvesting.

## Decision

Pass with watchlist. The route can stay implemented, but the next Wreck Echo issue should tune from evidence rather than add new route scope.
