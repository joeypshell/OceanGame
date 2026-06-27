# Expanded Region Prototype Status - 2026-06-26

Status: first playable side-route sequence implemented.

## What Landed

- Wider player world bounds and camera limits for a right-side side-view branch.
- `East Shelf Spur`, a first authored branch scaffold to the right of the central descent.
- `East Shelf Arch`, a stable landmark with return-current cues and `up-left` base direction readback.
- `PocketEntrance`, a far-end cave/wreck-pocket promise without an interior system yet.
- `Shelf Glimmer`, a seeded `Rare Signal` visual opportunity that is deliberately not a collectible or checklist item.
- `Sealed Shelf Hatch`, an `Echo Lens I`-locked future promise that changes from `ECHO LOCK` to `ECHO PING`.
- `East Shelf` pocket interaction, run-scoped research payoff, extraction result memory, and a compact route-goal fallback.
- `CurrentSurgeLane`, a non-combat timing/navigation cue that teaches route timing without damage, oxygen drain, blocking, or forced movement.
- `Shelf Drop Connector`, a short lower continuation with `Drop Arch`, up-left return cue, turnback hint, and `Drop Echo` research opportunity.
- Focused reset/state-ownership coverage for expanded-route restart behavior.
- Deterministic Playwright captures for staged East Shelf, pocket payoff, and lower connector states.

## Current Assessment

The prototype now points in the intended direction: side-view diving can expand into larger, wider spaces with remembered landmarks and daily variation. `East Shelf Spur` is no longer just spatial promise; it is a minimal playable route sequence with an entry reason, payoff, memory, timing cue, and lower continuation. The next work should add the next concrete route decision or narrow access promise rather than polishing the opening slice again.

## Next Implementation Priorities

1. Add a second reason to choose East Shelf or Shelf Drop on a specific expedition day.
2. Plan and prototype the narrow first access step behind `Sealed Shelf Hatch`.
3. Add one more connected pocket or branch that uses the no-minimap orientation guardrails.
4. Recheck route readability only where new route content makes the screen unclear.
5. Keep cheap logic coverage first and add Playwright capture only when route placement, camera, or readability changes.

## Guardrails

- Do not reopen broad first-screen readability polish unless a new gameplay change breaks it.
- Do not add a minimap, field guide, quest checklist, exact locator, broad procedural ocean, base-management layer, combat, capture, or harvesting yet.
- Keep branch content authored, inspectable, and small until the route sequence is fun.
- Prefer one concrete route decision over several new decorative cues.
