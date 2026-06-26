# Backlog Replenishment After Platform/Input Guardrail - 2026-06-26

Status: planning output for the next open-issue refresh. No implementation work is included in this note.

## Current Project Evaluation

OceanGame is still directionally coherent: a compact side-view alien-ocean expedition loop with persistent places, seeded daily variation, practical scans, non-lethal predator research, and upgrades that open remembered routes.

The project is no longer blocked on initial readability. The current slice is structurally playable and accepted as pass-with-watchlist, but future visual and route additions can still regress the core promise: the player must understand oxygen pressure, safe return, cargo, scan value, route danger, blocked promises, and extraction without developer explanation.

The next risk is not lack of ideas. The next risk is scope drift:

- Wreck Echo could accidentally become a new biome, quest chain, map-marker system, or exact locator.
- Visual source-art work could obscure route readability if it replaces fallback meaning too aggressively.
- HUD/control work could creep into inventory, objective, field-guide, platform UI, or settings scope.
- Mobile/iPhone and controller support are real future targets, but should stay deferred until the slice remains stable after the next route promise.

## Direction Decision

Proceed toward one first-pass `Wreck Echo Descent` runtime implementation, then immediately validate and tune readability. Keep it narrow:

- one authored deeper-right route pocket,
- one compact research clue,
- run-scoped state only,
- existing pressure, predator, oxygen, cargo, scanner, upgrade, extraction, failure, save/load, and progression rules preserved,
- no minimap, route graph, field guide, quest log, objective checklist, exact locator, combat, new economy, or broad biome generation.

Future mobile/iPhone landscape touch controls and controller support should remain a planning/input-contract constraint, not current implementation.

## Ordered Issue Batch

1. #364 Implement first Wreck Echo route pocket with one compact research clue.
2. #365 Add Playwright Wreck Echo route and result visual smoke coverage.
3. #366 Review Wreck Echo route readability at normal scale after implementation.
4. #367 Tune Wreck Echo route visuals and clue copy from the first readability review.
5. #368 Update current docs and clean demo script after Wreck Echo implementation.
6. #369 Refresh vertical-slice acceptance evidence after the Wreck Echo first pass.
7. #370 Update roadmap status after Wreck Echo first pass.
8. #371 Review active HUD and prompt compactness after Wreck Echo route additions.
9. #372 Select next source-art/readability target after Wreck Echo evidence.
10. #373 Implement the selected narrow source-art/readability pass.
11. #374 Review source-art and fallback balance after the selected pass.
12. #375 Recheck lower-route visual pileup after Wreck Echo and source-art changes.
13. #376 Review resource and scan affordance readability after the route/art changes.
14. #377 Review upgrade/result panel copy after the new research clue exists.
15. #378 Add an input action contract review for future controller and touch support.
16. #379 Plan deferred controller support mapping and prompt requirements.
17. #380 Plan deferred mobile/iPhone landscape touch-control and safe-area requirements.
18. #381 Review Playwright/screenshot workflow gaps for future route, HUD, and input states.
19. #382 Refresh MCP context after Wreck Echo and platform-input planning updates.
20. #383 Replenish backlog after Wreck Echo implementation and platform-input planning.

## Why This Order

The first issue creates the next playable promise. Issues 2-8 protect the current slice from the most likely regressions. Issues 9-14 keep visual work tied to readability evidence rather than novelty. Issues 15-17 record the user's mobile/controller direction without prematurely implementing platform UI. Issues 18-20 keep the agentic workflow healthy after the batch.

## Guardrails For Issue Authors

- Read `docs/current/ROADMAP.md`, `docs/current/GAMEPLAY.md`, and `docs/current/ARCHITECTURE.md` before implementation.
- For Wreck Echo work, read the Wreck Echo planning docs linked from the roadmap before editing scenes or scripts.
- Keep visual assets presentation-only unless the issue explicitly changes gameplay ownership.
- Preserve semantic Godot actions for player-facing input.
- Do not add mobile touch UI or controller implementation unless the issue explicitly scopes it; the current platform issues are planning-only.
- Run the standard checks appropriate to the issue: Godot headless launch, logic tests, MCP self-test, Playwright visual smoke when visual states change, and `git diff --check`.
