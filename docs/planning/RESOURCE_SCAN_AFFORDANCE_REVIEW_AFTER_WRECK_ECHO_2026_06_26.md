# Resource And Scan Affordance Review After Wreck Echo - 2026-06-26

Status: pass with watchlist.

Issue: #376.

## Scope

Reviewed resource and scan-target readability after the first `Wreck Echo Descent` implementation, lower-route tuning, and Wreck Echo clue-marker source-art pass.

This review does not add resources, field-guide UI, scanner economy, minimap behavior, objective markers, or route logic.

## Evidence Reviewed

- `docs/planning/RESOURCE_SCAN_AFFORDANCE_REVIEW_AFTER_PRESSURE_SHELL_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- `docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md`
- Playwright screenshots:
  - `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/active-dive.png`
  - `test-results/playwright/visual-smoke-OceanGame-web-4f607-grade-and-lower-route-views-chromium/lower-route-pressure-gate.png`
  - `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-route-staged.png`

No screenshot artifact is committed by this review.

## Resource Review

| Resource / Reward | Current Read After Wreck Echo | Decision |
| --- | --- | --- |
| Kelp Fiber | Green frond cluster remains compact and cargo-like in the active-dive view. It does not read as a route marker or scan-only target. | Pass |
| Shell Fragments | Existing pale shard/material language remains acceptable, with the earlier watchlist against future pressure-shell color drift. | Pass with watchlist |
| Glow Plankton / deep reward | Yellow-green reward language remains readable and tempting. In lower-route screenshots it can compete with cache/marker brightness, but still reads as reward rather than scan target or predator. | Pass with watchlist |

## Scan Affordance Review

| Scan Affordance | Current Read After Wreck Echo | Decision |
| --- | --- | --- |
| Non-resource scan markers | Pale diamond/bracket language still hugs scannable targets rather than drawing long objective arrows across the scene. | Pass |
| Selected-target tint | The selected Gulper scan target uses local brackets/tint and a bounded HUD `Scan:` line. It reads as "scan this nearby subject," not cargo. | Pass |
| Wreck Echo cue | The new pale clue marker remains a local research/echo cue and does not take over generic scan-marker language. | Pass |
| Scan status copy | Active HUD status remains bounded in the dive info panel and does not place explanatory paragraphs in the playfield. | Pass |
| Signal/Echo language | No exact locator, checklist, field-guide, route graph, or minimap language is introduced by the Wreck Echo source-art pass. | Pass |

## Decision

Resources and scan targets remain distinguishable after the Wreck Echo work.

The remaining risk is not that the player will confuse every affordance, but that deep-route brightness can stack: Glow Plankton reward, cache/mystery, selected scan brackets, predator danger, and Wreck Echo cues can appear in the same late-dive band. Keep future passes focused on contrast and source-art replacement, not new symbols or text.

## Follow-Up Decision

No new issue is needed from this review.

Existing issues cover the next relevant work:

- #377: result/upgrade copy review after the new research clue.
- #381: Playwright and screenshot workflow gaps for future route HUD and input states.

## Guardrails

- Do not add new resource types, scan economy, inventory grid, field guide, minimap, route graph, exact locator, or objective checklist to solve visual density.
- Keep resource pickups cargo-first and scan markers knowledge-first.
- Keep selected-target names in HUD/status text rather than adding world labels.
- Keep Wreck Echo and Echo Lens language broad, local, and curiosity-oriented.

## Verification

- `npm.cmd run test:visual` passed: 2 Playwright tests.
- `git diff --check` should pass before commit.
