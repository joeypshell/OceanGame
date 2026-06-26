# Backlog Replenishment: Vertical-Slice Readability - 2026-06-26

Status: planning output for issue #239.

## Context

After the Wreck Echo, source-art, HUD planning, and playable-slice acceptance work, the open GitHub issue queue dropped below the desired rolling backlog. The roadmap now names the active milestone as `Playable Vertical Slice Readability And Cohesion`.

This replenishment turns `docs/planning/NEXT_VERTICAL_SLICE_MILESTONE_2026_06_26.md` into an ordered issue batch. The batch is intentionally focused on making the current slice clearer and easier to playtest, not adding broad new systems.

## Direction

Priorities:

- make the active-dive HUD feel cohesive while keeping it compact,
- gather normal-scale readability evidence,
- reduce lower-route visual density before adding deeper content,
- review sprite/fallback balance for the major places and hazards,
- verify the playable vertical-slice acceptance gate,
- plan later Wreck Echo work only after the current slice is readable.

## Created Issue Batch

1. #240 Implement compact active-dive HUD skin.
2. #241 Add normal-scale active HUD screenshot review.
3. #242 Add surface ready and result readability review.
4. #243 Reduce lower-route visual density around pressure wreck and predator route.
5. #244 Tune Rare Signal and cache cues for local mystery readability.
6. #245 Review Shell Reef sprite and fallback balance.
7. #246 Review Thermal Vent sprite and fallback balance.
8. #247 Review pressure wreck and Wreck Signal Cache sprite/fallback balance.
9. #248 Review Gulper route danger readability with current sprites.
10. #249 Add playable vertical-slice manual smoke acceptance log.
11. #250 Add vertical-slice acceptance status summary to current docs.
12. #251 Add Echo Lens no-locator regression coverage.
13. #252 Plan Wreck Echo Descent implementation constraints.
14. #253 Plan the next source-art replacement priority after readability reviews.
15. #254 Review expedition condition visuals against playable-slice acceptance.
16. #255 Add screenshot workflow note for acceptance evidence naming.
17. #256 Add compact result-memory readability review.
18. #257 Review upgrade bay readability against current upgrade set.
19. #258 Update MCP context resources after vertical-slice readability planning.
20. #259 Replenish backlog after vertical-slice readability batch.

## Guardrails

Do not add:

- broad biome generation,
- minimap, route graph, exact scanner locator, or field-guide UI,
- objective checklist or quest log,
- weapons, predator harvesting, predator health, or combat rewards,
- large new art set before normal-scale readability is verified,
- inventory grid, broad crafting tree, or base-management loop,
- final production-art lock.

## Verification

- GitHub issues #240-#259 created.
- MCP context self-test.
- `git diff --check`.
- `git status --short`.
