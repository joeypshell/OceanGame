# Backlog Replenishment: After Vertical-Slice Readability - 2026-06-26

Status: planning output for issue #259.

## Context

After issues #240-#258, the open GitHub issue queue dropped below the desired rolling backlog. The current slice is structurally playable and substantially clearer, but the vertical-slice acceptance gate is not fully polished accepted yet.

Resolved during the previous batch:

- compact active HUD skin,
- normal-scale active/surface reviews,
- lower-route density tuning,
- local Echo Lens/Rare Signal mystery guardrails,
- Shell Reef, Thermal Vent, pressure wreck/cache, and Gulper route balance reviews,
- acceptance-status docs,
- result-memory, condition, upgrade-bay, and MCP context refreshes,
- upgrade tab wrapping/panel polish.

Remaining acceptance blockers and watchlists:

- active `Discoveries` count still needs to move or restyle away from the HUD panel gap,
- a clean-save two-expedition smoke pass is still needed,
- `Decoy Pulse I` needs a manual/HUD/status recheck while owned,
- lower-route screenshots should be rechecked after visual changes,
- surface moonpool/waterline integration is the next source-art readability target,
- acceptance evidence should be updated after those changes.

## Direction

The next batch should finish the current playable-slice gate before adding broad new mechanics. The work should be small, ordered, and evidence-driven:

1. clear the remaining active HUD/readability blockers,
2. gather clean acceptance evidence,
3. perform the next surface readability art pass,
4. recheck affected surface/lower-route/result views,
5. update context and replenish again only if needed.

## Created Issue Batch

1. #260 Move active Discoveries count into compact HUD panel.
2. #261 Add clean-save two-expedition smoke acceptance pass.
3. #262 Recheck Decoy Pulse HUD/status with upgrade owned.
4. #263 Recheck lower-route readability after recent HUD and density changes.
5. #264 Wire surface moonpool and waterline source-art pass.
6. #265 Add surface moonpool and waterline normal-scale review.
7. #266 Tune surface panel opacity or placement after boat/waterline pass.
8. #267 Add active HUD Discoveries placement regression coverage.
9. #268 Add upgrade tab normal-scale review after wrapping fix.
10. #269 Add no-debug normal surface capture sanity review.
11. #270 Recheck pressure wreck/cache readability after lower-route watchlist.
12. #271 Plan pressure wreck/cache backup art-pass constraints.
13. #272 Update playable-slice acceptance status after smoke/art reviews.
14. #273 Add result and upgrade text-length guard coverage.
15. #274 Review condition visuals with normal-scale screenshots.
16. #275 Add Decoy Pulse result-memory and HUD smoke note.
17. #276 Recheck Echo Lens pulse readability at Wreck Signal Cache.
18. #277 Plan source/provenance requirements for moonpool asset.
19. #278 Update MCP context after acceptance evidence batch.
20. #279 Replenish backlog after surface-readability acceptance batch.

## Guardrails

Do not add:

- broad biome generation,
- minimap, route graph, exact scanner locator, or field-guide UI,
- objective checklist or quest log,
- weapons, predator harvesting, predator health, or combat rewards,
- full production-art lock,
- inventory grid, broad crafting tree, or base-management layer,
- Wreck Echo Descent implementation before the current slice reads cleanly.

## Verification

- GitHub issues #260-#279 created.
- MCP context self-test.
- `git diff --check`.
- `git status --short`.
