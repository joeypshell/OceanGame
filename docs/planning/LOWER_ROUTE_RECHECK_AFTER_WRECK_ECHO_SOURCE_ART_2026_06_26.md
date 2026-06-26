# Lower-Route Recheck After Wreck Echo Source Art - 2026-06-26

Status: pass with watchlist.

Issue: #375.

## Purpose

Recheck the lower-route visual stack after the first `Wreck Echo Descent` implementation, route tuning, and the narrow Wreck Echo clue-marker source-art pass.

This review does not add new content, broaden Wreck Echo, or change route behavior.

## Evidence Reviewed

- `docs/planning/LOWER_ROUTE_ACCEPTANCE_CLEANUP_RECHECK_2026_06_26.md`
- `docs/planning/LOWER_ROUTE_RECHECK_AFTER_BACKGROUND_STUDY_2026_06_26.md`
- `docs/planning/WRECK_ECHO_SOURCE_ART_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- Playwright screenshot: `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-route-staged.png`

No screenshot artifact is committed by this review.

## Recheck Matrix

| Element | Current Read After Wreck Echo Source Art | Decision |
| --- | --- | --- |
| Pressure gate | The lock/open stack remains the primary blocked-route read. It is still visually heavier than the clue marker. | Pass |
| Wreck Signal Cache | Cache/mystery shapes remain local and tied to the pressure-wreck area, not an exact map marker. | Pass with watchlist |
| Predator lane | Red Gulper lane remains separable from the pale Wreck Echo marker, but it shares the lower-route band with reward and cache shapes. | Pass with watchlist |
| Wreck Echo clue | The new small pale marker reads as a distinct local research/echo cue and does not look like cargo, predator danger, or a pressure lock. | Pass |
| Resource reward | The glow reward remains tempting and readable, but yellow/green brightness can compete with cache and marker highlights when stacked. | Pass with watchlist |
| Safe return | Base direction and compact HUD remain readable in the staged route view. World-space return cues are still lower priority at this depth. | Pass with watchlist |

## Decision

The lower route remains acceptable for the current playable slice, but it is still the main visual-density watchlist.

There is no blocker-level pileup after the selected source-art pass. The current risk is cumulative: pressure, cache, reward, predator, and Wreck Echo cues all occupy the same late-dive decision band. Future work should reduce competition between existing meanings before adding new lower-route concepts.

## Follow-Up Issues

No new issue is required from this review.

Existing concrete follow-ups cover the next useful checks:

- #376: resource and scan affordance readability after route and art changes.
- #381: Playwright and screenshot workflow gaps for future route HUD and input states.

## Guardrails

- Do not add another lower-route target, route, collectible, or marker until the current stack has another normal-scale review.
- Do not brighten pressure gate, cache, reward, predator warning, and Wreck Echo marker in the same pass.
- Do not introduce minimap, exact locator, field guide, quest log, or objective checklist language to solve lower-route density.
- Keep Wreck Echo as one optional local research clue for now.

## Verification

- `npm.cmd run test:visual` passed: 2 Playwright tests.
- `git diff --check` should pass before commit.
