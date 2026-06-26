# Backlog Replenishment After Wreck Echo And Platform Input - 2026-06-26

Status: planning output for issue #383. No implementation work is included in this note.

## Current Project Evaluation

OceanGame remains directionally coherent: a compact 2D side-view alien-ocean expedition game with persistent geography, seeded daily variation, resource/cargo pressure, practical scans, non-lethal predator research, route-opening upgrades, and a first narrow Wreck Echo research promise.

The first Wreck Echo route pocket is now implemented and reviewed as pass-with-watchlist. The platform/input direction is recorded as deferred controller and landscape mobile/touch planning, not current implementation. The screenshot workflow is useful but has known state-capture gaps.

## Direction, Scope, Regression, And Final-Purpose Risks

- Direction risk: adding more route concepts before the current lower-route stack and evidence workflow are easier to judge.
- Scope risk: Wreck Echo, Echo Lens, and future platform controls could drift into minimaps, route graphs, field guides, checklist UI, settings menus, or mobile/controller implementation before the current slice is stable.
- Regression risk: result/upgrade Playwright screenshots can misrepresent active-dive state as surface UI evidence; future agents may trust bad artifacts.
- Visual risk: source-art replacement can accidentally remove fallback meaning or stack more bright cues in the lower route.
- Final-purpose risk: the game should grow toward larger side-view dives and richer monster/research progression, but the next immediate work should still prove the current one-minute loop is understandable, replayable, and visually readable.

## Direction Decision

The next queue should focus on test/evidence hardening, prompt abstraction, and one more narrow readability/source-art pass. It should not add a new biome, broad procedural generation, combat loop, field guide, map UI, mobile touch overlay, controller implementation, or larger Wreck Echo expansion yet.

## Ordered Issue Batch

1. #384 Harden Playwright extraction result and upgrade-tab captures.
2. #385 Add Playwright low/critical oxygen HUD captures.
3. #386 Add a no-debug Wreck Echo result capture path or document the blocker.
4. #387 Add state assertions/metadata to Playwright visual artifacts.
5. #388 Plan the first player-facing action prompt abstraction.
6. #389 Implement a small keyboard prompt-label helper for current actions.
7. #390 Route active HUD and surface prompts through the prompt-label helper.
8. #391 Add prompt/formatter guard coverage.
9. #392 Review result, upgrade, and active HUD copy after prompt abstraction.
10. #393 Refresh vertical-slice acceptance evidence after screenshot/prompt hardening.
11. #394 Recheck lower-route readability after evidence workflow hardening.
12. #395 Select the next narrow source-art/readability target after the prompt/evidence pass.
13. #396 Implement the selected narrow source-art/readability target.
14. #397 Review fallback/source-art balance after that target.
15. #398 Review active HUD and touch-safe margins at desktop and mobile-like landscape widths without adding touch UI.
16. #399 Add a deferred mobile-like screenshot workflow note or capture scaffold if justified by #398.
17. #400 Review Wreck Echo no-locator/no-checklist drift after prompt and screenshot changes.
18. #401 Review monster-research next-step readiness without implementing combat or capture.
19. #402 Refresh MCP context after the new evidence/prompt/readability planning updates.
20. #403 Replenish the backlog after this evidence and prompt-hardening batch.

## Why This Order

The current weakest workflow risk is evidence reliability, so Playwright capture hardening comes first. Prompt abstraction follows because controller/touch planning identified hard-coded keyboard copy as the main future platform risk. Only after that should another source-art/readability implementation happen, because future art review should depend on trustworthy captures and clean player-facing prompt text.

## Guardrails For Issue Authors

- Read `docs/current/ROADMAP.md`, `docs/current/GAMEPLAY.md`, `docs/current/ARCHITECTURE.md`, and the specific linked planning docs before implementation.
- Keep mobile/touch and controller implementation deferred unless an issue explicitly promotes it.
- Keep Wreck Echo broad expansion deferred; current Wreck Echo is one optional local research clue.
- Do not add minimap, route graph, exact locator, field guide, quest log, objective checklist, inventory grid, tech tree, weapons, predator harvesting, capture systems, or broad procedural ocean generation.
- Do not trust a screenshot artifact by filename alone; assert or inspect the actual state.
- Preserve semantic Godot actions for player-facing input.
- Run verification appropriate to the issue: Playwright visual smoke for screenshot/HUD changes, Godot headless launch and logic tests for gameplay/state/helper changes, MCP self-test for context/tooling resources, and `git diff --check`.
