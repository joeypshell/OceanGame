# Backlog Replenishment After Evidence, Prompt, And Readability Hardening - 2026-06-26

Status: planning output for issue #403.

## Current Project Evaluation

OceanGame has a much stronger vertical-slice foundation than it did before this batch. The current prototype now has state-asserted Playwright visual evidence, a mobile-like landscape capture scaffold, semantic keyboard prompt labels, an implemented first Wreck Echo research pocket, no-locator Wreck Echo guardrails, a clearer deep reward lure, refreshed MCP context, and a non-combat direction for the next monster-research step.

The project should still avoid broad expansion. The clearest remaining risks are polish and evidence risks:

- upgrade detail copy can still crowd or overflow the upgrade panel,
- lower-route meaning can still get dense after art changes,
- mobile-like landscape evidence exists but has not been reviewed as a design artifact,
- Wreck Echo and Monster Research could drift into objective/checklist/field-guide/combat scope if the next issues are not explicit,
- visual source-art replacement can still outpace readability evidence.

## Direction Decision

The next queue should focus on:

1. fixing or constraining the upgrade-panel copy/layout watchlist,
2. using the new mobile-like screenshot scaffold for evidence-only reviews,
3. planning Monster Research II as non-combat behavior evidence,
4. keeping Wreck Echo and lower-route readability guarded,
5. preparing a narrow polished-slice acceptance refresh.

Do not add mobile controls, controller implementation, combat, capture, harvesting, creature collection, minimaps, field guides, quest checklists, broad Wreck Echo expansion, or procedural biome generation in this queue.

## Ordered Issue Batch

1. #404 Review upgrade details overflow after prompt and evidence hardening.
2. #405 Plan a compact upgrade details layout/copy fix.
3. #406 Implement the compact upgrade details layout/copy fix.
4. #407 Add upgrade panel overflow guard coverage.
5. #408 Review mobile-like surface and active captures from the new scaffold.
6. #409 Review mobile-like lower-route readability from the new scaffold.
7. #410 Plan future touch safe-zone constraints from mobile-like evidence.
8. #411 Add mobile-like low/critical oxygen capture coverage if justified.
9. #412 Review Wreck Echo route/result at mobile-like landscape width.
10. #413 Define Monster Research II as non-combat behavior evidence.
11. #414 Select the first Monster Research II evidence type.
12. #415 Plan Monster Research II state ownership and result memory.
13. #416 Add Monster Research II non-combat guardrail coverage.
14. #417 Review Gulper/Decoy research result clarity after monster-readiness planning.
15. #418 Select the next narrow source-art/readability target after deep reward lure.
16. #419 Review lower-route visual pileup after deep reward and Wreck Echo guardrails.
17. #420 Plan a cohesive vertical-slice art-kit integration pass without final art lock.
18. #421 Refresh playable vertical-slice acceptance status after this polish/evidence pass.
19. #422 Refresh MCP context after the new backlog and planning updates.
20. #423 Replenish backlog after upgrade, mobile-like, and Monster Research II planning.

## Why This Order

The upgrade panel is the most concrete remaining readability watchlist, so it comes first. Mobile-like evidence follows because the scaffold is now available but has not been interpreted. Monster Research II is then planned carefully as observation and behavior evidence, not combat. Only after those guardrails should the queue select another source-art target or refresh vertical-slice acceptance.

## Guardrails For Issue Authors

- Keep current desktop behavior intact unless the issue explicitly changes it.
- Use Playwright visual smoke for HUD/layout/screenshot workflow changes.
- Use Godot logic tests for formatter, state, upgrade, scan, predator, or save behavior.
- Use MCP self-test when context resources or tooling docs change.
- Do not add mobile/touch controls, controller support, combat, capture, harvesting, field-guide UI, minimaps, route graphs, objective checklists, or broad procedural generation.
- Keep Wreck Echo as one optional research clue until a separate issue promotes broader scope.
- Keep monster research observational: scan, notice, survive, return, and learn.
