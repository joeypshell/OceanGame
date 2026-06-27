# Player-Visible Milestone Pivot - 2026-06-27

Status: completed as pass with watchlist by `docs/planning/FIRST_NOTICEABLY_LARGER_DIVE_MAP_VALIDATION_2026_06_27.md`. Keep these rules as process guidance for future player-visible milestones.

## Why This Pivot Exists

The project has resolved many issues, but normal play can still feel mostly unchanged. That means the process has become too optimized around small correctness, planning, review, and screenshot tasks rather than noticeable gameplay progress.

The next work should be organized around player-visible milestones:

> If the player starts the game and plays normally for five minutes, they should notice what changed without debug tools, screenshots, or reading the roadmap.

## New Issue Rules

Until this milestone is complete:

- Do not create 20-issue batches.
- Do not create docs-only review issues unless they unblock a concrete implementation issue.
- Do not create separate issues for metadata, reset guards, Playwright capture, and review unless the implementation is already large enough to justify separation.
- Prefer 3 to 5 larger issues that each produce a normal-play-visible result.
- Every issue must include a "Player-visible outcome" section.
- Verification should be sized to risk: logic tests for behavior, one visual smoke only when layout/art changed, and docs checks only for planning docs.

## Active Milestone

Milestone name: First Noticeably Larger Dive Map.

Goal:

Turn the current subtle route-pocket chain into an obvious first larger dive area that feels different in ordinary play.

Player-facing target:

- The player can leave the surface base and see that the ocean opens wider than the original column.
- The player can reach a clear mid-depth branch with left/right movement.
- The player can enter one cave-like pocket or alcove that reads as a real destination.
- The player can find one obvious reward, discovery, or research payoff in that pocket.
- The player can see one deeper locked or dangerous promise that makes the ocean feel larger.
- The ready/result copy points toward the new area in broad language without creating a checklist.

## Acceptance Gate

The milestone is not complete until a normal play session can answer yes to these questions:

1. Did the game visibly feel larger than it did before this pivot?
2. Did the player encounter a clear branch or cave-like destination without debug staging?
3. Did the destination contain something worth doing?
4. Did the player understand how to return?
5. Did the next possible deeper goal feel visible but not mandatory?

## Next Issue Batch

Create only the following implementation-sized issues:

1. Build an obvious mid-depth branch entrance and larger route silhouette.
2. Add one cave-like destination pocket with stronger landmark art and collision/readability.
3. Add one normal-play reward or discovery payoff inside the destination.
4. Add one visible deeper promise beyond the destination and broad ready/result guidance.
5. Add a compact milestone validation pass using existing tests and one targeted screenshot if needed.

These issues may include their own metadata, reset guards, copy, and focused verification inside the same issue. Do not split those into separate issues unless the change becomes genuinely too large to review safely.

## Out Of Scope

- Minimap, route graph, exact objective tracker, field-guide quest state, or checklist UI.
- Full procedural generation.
- Combat, harvesting, weapons, or capture systems.
- Broad economy expansion.
- Mobile/controller implementation.
- Another broad art-polish pass that does not add a new playable destination.

## Testing Policy

Testing should protect progress, not become the progress.

Use:

- `quick` for gameplay/state changes.
- `visual` only when the issue changes route layout, art readability, or HUD placement.
- `docs` only when editing planning/current docs.

Avoid:

- long manual traversal automation for every issue,
- new screenshot states for tiny text/copy changes,
- review-only issues after every small implementation.
