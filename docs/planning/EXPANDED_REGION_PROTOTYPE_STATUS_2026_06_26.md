# Expanded Region Prototype Status - 2026-06-26

Status: first pass implemented.

## What Landed

- Wider player world bounds and camera limits for a right-side side-view branch.
- `East Shelf Spur`, a first authored branch scaffold to the right of the central descent.
- `East Shelf Arch`, a stable landmark with return-current cues and `up-left` base direction readback.
- `PocketEntrance`, a far-end cave/wreck-pocket promise without an interior system yet.
- `Shelf Glimmer`, a seeded `Rare Signal` visual opportunity that is deliberately not a collectible or checklist item.
- `Sealed Shelf Hatch`, an `Echo Lens I`-locked future promise that changes from `ECHO LOCK` to `ECHO PING`.
- Focused reset/state-ownership coverage for expanded-route restart behavior.
- A deterministic Playwright capture named `expanded-east-shelf-route-staged.png`.

## Current Assessment

The prototype now points in the intended direction: side-view diving can expand into larger, wider spaces with remembered landmarks and daily variation. It is still mostly spatial promise rather than a route-gameplay loop. The next work should make the East Shelf branch ask the player to make choices, not just view scenery.

## Next Implementation Priorities

1. Add a minimal pocket interaction at `PocketEntrance`.
2. Add one route reward or research payoff that makes East Shelf worth visiting.
3. Add one branch-specific risk, timing, or navigation choice that remains non-combat for now.
4. Add result memory for visiting or resolving the branch so the run feels acknowledged.
5. Add cheap logic coverage first and visual capture only when route readability changes.

## Guardrails

- Do not reopen broad first-screen readability polish unless a new gameplay change breaks it.
- Do not add a minimap, field guide, quest checklist, exact locator, broad procedural ocean, base-management layer, combat, capture, or harvesting yet.
- Keep branch content authored, inspectable, and small until one expanded route is fun.
- Prefer one concrete interaction over several new decorative cues.
