# Backlog Replenishment - After First Lower Connector - 2026-06-26

Status: next ordered issue batch.

## Purpose

Keep OceanGame moving from a small vertical slice into a larger side-view expedition game after `East Shelf Spur` and `Shelf Drop Connector` became the first playable route sequence.

This batch should make the ocean feel bigger in the running game. It prioritizes narrow route access, one sealed-hatch payoff, one additional connected pocket, and cheap guard coverage. It deliberately avoids broad polish, full procedural generation, minimaps, quest checklists, combat, harvesting, and final art lock.

## Direction

The next route-growth step should prove three things:

1. A visible locked promise can become a narrow access upgrade without becoming a broad tech tree.
2. A hatch can open into one small authored pocket without requiring a full cave/interior system.
3. A second connected lower pocket can extend side-to-side exploration while staying readable through landmarks, return cues, broad base direction, and Playwright evidence.

## Issue Batch

1. Plan the first `Resonance Key I` implementation contract.
2. Add `Resonance Key I` as a narrow hatch-specific upgrade definition.
3. Add upgrade bay copy and readiness states for `Resonance Key I`.
4. Add save/load and purchase coverage for `Resonance Key I`.
5. Make `Sealed Shelf Hatch` visibly open when `Resonance Key I` is owned.
6. Add hatch-open no-interior guard coverage.
7. Scaffold a small `Resonance Alcove` pocket behind the hatch.
8. Add one run-scoped `Resonance Alcove` research payoff.
9. Add extraction result memory for `Resonance Alcove` research.
10. Add reset/state coverage for `Resonance Alcove`.
11. Add a targeted Playwright capture for the opened hatch and alcove.
12. Plan the next connected lower pocket beyond `Shelf Drop Connector`.
13. Scaffold the next connected lower pocket geometry.
14. Add a named lower-pocket landmark and return cue.
15. Add one expedition-day opportunity that points toward the lower pocket.
16. Add one non-combat timing/navigation cue in the lower pocket.
17. Add no-minimap orientation and reset coverage for the lower pocket.
18. Add a targeted Playwright capture for the lower pocket.
19. Review oxygen margin after hatch and lower-pocket expansion.
20. Refresh roadmap/backlog after the next connected pocket is playable.

## Guardrails

- At least half of the batch should change player-visible gameplay, route behavior, or route evidence.
- Review-only issues must directly unblock or verify implementation work in this batch.
- Use existing materials, upgrades, scan/result memory, authored scene nodes, and current screenshot workflow before adding new systems.
- Keep `Resonance Key I` narrow: one hatch-specific access module, not a broad scanner tier or route key family.
- Keep new route content authored and small until it proves fun and readable.
- Preserve oxygen, cargo, scan, extraction, save/reset, predator, pressure, Wreck Echo, East Shelf, and Shelf Drop behavior unless a ticket explicitly scopes a narrow change.

## Deferred Scope

- Full cave network or interior system.
- Minimap, route graph, exact locator, field-guide objective, quest checklist, or broad route journal.
- Combat, capture, harvesting, weapon upgrades, or monster loot.
- Full procedural ocean generation or daily full-map rerolls.
- Broad upgrade tiers, crafting stations, base management, or economy expansion.
- Final production art lock.

## Verification Pattern

- Use `quick` for GDScript behavior, state ownership, save/load, and upgrade changes.
- Use `docs` for planning-only issues.
- Use Playwright visual checks only when route placement, camera, screenshot workflow, or visual readability changes.
- Always run `git diff --check` before close.
