# Backlog Replenishment After Acceptance Evidence - 2026-06-26

Status: planning output for issue #279.

## Context

Issues #260-#278 cleared the surface-readability acceptance batch. The current slice is structurally playable and close to polished acceptance, but the queue is below the desired rolling backlog.

Cleared or documented:

- active `Discoveries` moved into compact HUD and guarded by tests,
- clean-save two-expedition smoke pass,
- Decoy Pulse owned-state/result-memory smoke,
- lower-route and pressure wreck/cache rechecks,
- surface moonpool/waterline source-art pass and review,
- surface panel opacity tuning,
- upgrade-tab normal-scale review,
- no-debug surface sanity review,
- condition visual review,
- Echo Lens local pulse recheck,
- moonpool asset provenance requirements,
- MCP context refresh.

Roadmap correction: result/upgrade text-length guard coverage landed in #273 and is no longer a remaining acceptance blocker.

## Direction

The next batch should close the current vertical-slice gate honestly and then move into the smallest next readability/art-integration decisions.

Priorities:

1. finish vertical-slice acceptance closeout,
2. keep lower-route and active HUD readable after all recent changes,
3. improve first-run/player-facing clarity without adding tutorial panels or checklists,
4. choose the next visual pass by readability impact,
5. preserve non-goals: no minimap, field guide, objective checklist, combat loop, full procedural ocean, broad biome expansion, or production-art lock.

## Planned Issue Batch

1. #280 Update final vertical-slice acceptance status after evidence cleanup.
2. #281 Add final playable vertical-slice closeout review.
3. #282 Add lower-route normal-scale screenshot recheck after acceptance cleanup.
4. #283 Review active prompt length with Burst Thruster and Decoy Pulse together.
5. #284 Add active prompt compactness regression coverage.
6. #285 Add first-run surface ready comprehension review.
7. #286 Add first-run active dive comprehension review.
8. #287 Add save/progression persistence expectation note for owned upgrades.
9. #288 Review sub idle/thrust readability at normal scale.
10. #289 Plan sub idle/thrust source-art polish constraints.
11. #290 Review surface launch/return readability after moonpool and panel changes.
12. #291 Select next source-art replacement after moonpool acceptance evidence.
13. #292 Plan shallow/midwater background art-pass constraints.
14. #293 Wire first shallow/midwater background source-art study.
15. #294 Review background source-art study against gameplay readability.
16. #295 Plan pressure-dark threshold use/no-use decision.
17. #296 Review upgrade bay selection affordance for Up/Down cycling.
18. #297 Add solo first-run readability checklist to replace blind validation.
19. #298 Update MCP context after vertical-slice closeout batch.
20. #299 Replenish backlog after vertical-slice closeout batch.

## Verification

- GitHub issues #280-#299 created from this batch.
- MCP context self-test.
- `git diff --check`.
- `git status --short`.
