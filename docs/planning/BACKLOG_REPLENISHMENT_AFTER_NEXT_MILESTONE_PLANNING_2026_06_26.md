# Backlog Replenishment After Next-Milestone Planning - 2026-06-26

Status: replenishment artifact for issue #319.

## Purpose

Replenish the open GitHub issue queue after the post-closeout planning batch.

The current open queue was below the desired range, with only the replenishment issue left open. This batch creates concrete work from the latest roadmap and planning docs while keeping focus on playable loop quality and narrow next-slice planning.

## Queue Focus

This batch should:

- improve lower-route readability through the selected pressure wreck/cache shell pass,
- finish compact HUD polish and evidence,
- recheck Decoy Pulse owned readability and monster-research result clarity,
- update vertical-slice evidence after the watchlist reviews,
- prepare `Wreck Echo Descent` for a later implementation decision without implementing it yet,
- refresh MCP/planning context after the batch.

## Ordered Issue Batch

1. #320 Wire pressure wreck/cache source-art shell pass.
2. #321 Add normal-scale pressure wreck/cache shell review.
3. #322 Recheck lower-route pressure/cache/predator overlap after shell pass.
4. #323 Implement compact HUD final polish pass.
5. #324 Add compact HUD final normal-scale review.
6. #325 Add active HUD final polish regression coverage.
7. #326 Review Decoy Pulse owned HUD and predator visual state.
8. #327 Review Gulper timing result clarity across scan/contact/decoy outcomes.
9. #328 Add Wreck Echo readiness gate review after shell and HUD polish.
10. #329 Plan Wreck Echo implementation candidate reward choice.
11. #330 Review source-art provenance checklist use on the pressure shell pass.
12. #331 Review resource/scan affordance readability after pressure shell pass.
13. #332 Plan resource/scan affordance source-art target if still needed.
14. #333 Update compact vertical-slice evidence bundle after latest reviews.
15. #334 Update playable vertical-slice acceptance status after watchlist reviews.
16. #335 Add vertical-slice demo script for a clean playable pass.
17. #336 Review surface panel contrast after final HUD polish.
18. #337 Review debug telemetry hidden-state sanity after new evidence.
19. #338 Update MCP context after playable-loop polish batch.
20. #339 Replenish backlog after playable-loop polish batch.

## Issue Creation Notes

Each issue should include:

- concrete acceptance criteria,
- relevant docs/code,
- explicit non-goals when scope could drift,
- verification steps.

Implementation issues should run Godot headless launch and logic tests when runtime behavior or scene contracts change. Docs/review issues should run MCP context self-test, `git diff --check`, and `git status --short`.

## Scope Guard

Do not use this batch to add:

- full `Wreck Echo Descent` implementation before readiness gates pass,
- new biomes or procedural generation,
- minimap, route graph, exact locator, field-guide UI, or objective checklist,
- weapons, health, harvesting, capture, loot, or combat rewards,
- inventory grid, tech tree, or broader economy changes,
- final production-art lock.
