# Backlog Replenishment - Visual Clarity Foundation - 2026-06-26

## Purpose

This batch follows the demo readability and hybrid-variation work that added clean-save reset, HUD mode separation, compact markers, condition visuals, and the first authored condition weighting rule.

The next milestone should make the prototype readable and appealing enough that playtests can judge the game loop instead of fighting placeholder shapes, overlapping cues, and unclear route language.

## Current Read

The core loop is now viable:

- expeditions start from a side-view surface/base state,
- durable progression is separated from active expedition state,
- starter resources and predator routes use authored seeded candidates,
- `Thermal Bloom` can now bias authored `Glow Plankton` candidates,
- compact HUD panels and markers replaced the worst loose text overlap.

The biggest remaining risk is visual communication:

- placeholder polygons make pickups, landmarks, locks, danger, and rewards hard to distinguish,
- depth bands and route pockets need a consistent art language,
- lower-route visuals can still compete with each other,
- screenshots should be used as the main review artifact,
- future monster/progression work should wait until the current route language is readable.

## Milestone Choice

Choose visual language and playable clarity before monster research, progression depth, or another route pocket.

Reasoning:

- Monster research and progression depth will add more UI and more world cues; doing them before a visual language pass risks increasing confusion.
- Another route pocket would expand authored content before the existing pockets are readable.
- The current prototype already has enough loop to test if players can see where to go, what is dangerous, what is optional, and how to return.

## Batch Principles

- Replace confusing placeholder visuals with small reusable assets before adding new mechanics.
- Keep the player, safe return, scan targets, danger, rewards, and locks visually distinct at normal zoom.
- Prefer reusable Godot scenes/resources and style rules over one-off polygons.
- Keep world text minimal; explanations belong in compact HUD, ready/result panels, or docs.
- Preserve authored hybrid-ocean constraints: no broad procedural regions, no minimap, no field guide, no weapons, no cargo grid inventory.
- Verify with screenshots and normal-scale play checks, not only code tests.

## Ordered Issue Batch

1. Capture a visual clarity baseline screenshot set.
   - Purpose: collect surface-ready, early dive, midwater reef, Thermal Vent, pressure lock, and Gulper route screenshots before asset changes.

2. Define visual language style guide v1.
   - Purpose: document palette, silhouette, marker, opacity, and depth-band rules for readable prototype art.

3. Create reusable marker scene patterns.
   - Purpose: centralize scan, lock, return, danger, and reward marker shapes so future tuning is consistent.

4. Replace resource pickup placeholder visuals v1.
   - Purpose: make Kelp Fiber, Shell Fragments, and Glow Plankton distinct without relying on labels.

5. Improve player and surface base silhouettes v1.
   - Purpose: make the player, boat/lab, and extraction origin instantly recognizable.

6. Improve depth-band background readability v1.
   - Purpose: reduce noisy overlapping polygons and make shallow, midwater, deep, and lower-route spaces easier to read.

7. Rework Shell Reef visual pocket v1.
   - Purpose: make the safer midwater banking route visually distinct from deeper optional routes.

8. Rework Thermal Vent visual pocket v1.
   - Purpose: make warmth, optional glow temptation, and Thermal Bloom emphasis readable without implying a mandatory path.

9. Rework pressure lock and wreck visuals v1.
   - Purpose: make the locked route, open state, and future cache promise clear without large text.

10. Rework Gulper route danger visuals v1.
    - Purpose: make predator danger and route timing readable before contact.

11. Run a post-asset lower-route overlap review.
    - Purpose: check pressure lock, wreck signal, deep reward, predator warning, and safe return after the first asset pass.

12. Add a visual review playtest checklist.
    - Purpose: give future feedback a consistent script for screenshots, seed/condition notes, and readability observations.

13. Add a debug seed and condition selection helper.
    - Purpose: make visual reviews repeatable without manually fishing for seeds or conditions.

14. Add screenshot capture documentation for Godot and MCP workflows.
    - Purpose: clarify how to capture comparable images from the editor, local launch, or context tools.

15. Plan Monster Research Loop v1.
    - Purpose: define the next non-combat monster hunting/research step after visual clarity improves.

16. Plan Scanner Progression v2 from Wreck Signal Cache.
    - Purpose: decide the next scanner upgrade payoff without adding a field guide or minimap.

17. Plan first art asset source pipeline.
    - Purpose: decide whether assets start as generated bitmap sprites, hand-authored vector/polygon scenes, or a hybrid source folder.

18. Add asset source folder conventions.
    - Purpose: create repo structure and docs for source art, exported runtime assets, and attribution/license notes.

19. Review performance and readability impact of visual pass.
    - Purpose: confirm new assets do not obscure gameplay, break web viability, or degrade launch/test stability.

20. Replenish backlog after visual clarity foundation.
    - Purpose: choose whether to move next into monster research, scanner progression, economy depth, or another authored route pocket.

## Success Gate

This batch succeeds when:

- normal-scale screenshots clearly show the player, base, safe return, pickups, scan targets, locks, rewards, and danger,
- the first asset pass reduces reliance on on-playfield text,
- major route pockets have distinct silhouettes and color/opacity rules,
- future assets have a documented source/export convention,
- visual reviews are repeatable by seed and condition,
- monster/progression planning is ready but not implemented ahead of visual clarity.
