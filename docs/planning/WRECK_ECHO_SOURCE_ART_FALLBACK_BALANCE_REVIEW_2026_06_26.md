# Wreck Echo Source-Art Fallback Balance Review - 2026-06-26

Status: pass with watchlist.

Issue: #374.

Evidence:

- Playwright visual smoke passed after the narrow Wreck Echo clue-marker source-art pass.
- Reviewed `test-results/playwright/visual-smoke-OceanGame-web-b76ec-e-and-result-readback-views-chromium/wreck-echo-route-staged.png`.
- The marker is scene-native runtime geometry that mirrors `assets/source/sprites/wreck_echo_clue_marker_v1.svg`, with matching export and provenance files.

## Readability Result

The new Wreck Echo clue marker improves recognition enough to keep it. It reads as a small local research/echo cue near the lower Wreck Echo route rather than as a cargo pickup, exact map marker, pressure gate, or predator warning.

The broader lower-route view is still busy. The Wreck Echo marker, reward lure, pressure/cache shapes, and predator lane all share the same screen band in the staged route screenshot. This is not a blocker for the selected source-art pass, but it remains the next visual risk to review.

## Fallback Geometry Decision

Keep:

- The new Wreck Echo marker polygons under `WreckEchoDescent/ClueTrigger`.
- The existing pressure gate/cache fallback geometry.
- The existing predator warning lane and reward lure until their next focused review.

Dim / keep subdued:

- `WreckEchoDescent/ClueTrigger/ClueCore` should remain subdued behind the new marker.
- `WreckEchoDescent/ClueTrigger/EchoRing` should remain subdued as atmosphere, not as the primary marker read.

Unchanged:

- Route ownership, scan behavior, pressure gating, predator behavior, cargo, oxygen, progression, and save/load rules.
- The no-minimap, no-checklist, no-exact-locator constraint for Wreck Echo.

## Follow-Up Issues

No new issue is needed from this review because the concrete follow-ups already exist in the current queue:

- #375: recheck lower-route visual pileup after Wreck Echo and source-art changes.
- #376: review resource and scan affordance readability after route and art changes.

## Verification

- `npm.cmd run test:visual` passed: 2 Playwright tests.
- `git diff --check` should pass before commit.
