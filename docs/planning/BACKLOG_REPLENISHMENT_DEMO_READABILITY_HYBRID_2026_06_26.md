# Backlog Replenishment - Demo Readability And Hybrid Variation - 2026-06-26

## Purpose

This batch follows the completed hybrid-ocean review and the immediate HUD readability fixes from playtest screenshots.

The next work should make the prototype easier to repeatedly test from a clean state, then convert the hybrid-ocean model from briefing flavor into visible run-to-run variation without expanding into full procedural regions.

## Current Read

The dive loop is functional, but the prototype is still fragile as a playtest experience:

- persistent save data makes the first-run experience hard to retest,
- the HUD has only just been separated into surface and dive modes,
- the scene still relies on placeholder shapes and text-heavy cues,
- expedition conditions exist but do not yet change play,
- lower-route visual density remains the largest readability risk,
- marker prototypes exist but are not applied broadly to the runtime scene.

The project should stay on the hybrid ocean path: persistent geography, authored route pockets, and seeded expedition-day variation.

## Batch Principles

- Fix repeat testing friction before adding new content.
- Prefer readable UI and markers over more text.
- Make one expedition condition visible before making conditions mechanical.
- Keep condition effects authored and narrow.
- Re-review the current slice after each meaningful readability or condition pass.
- Do not add weapons, a minimap, field guide, full procedural biomes, cargo grid inventory, or a region-select screen in this batch.

## Ordered Issue Batch

1. Add a local prototype save reset option.
   - Purpose: let the early-game experience be retested without manually deleting `user://progression_save.json`.

2. Document clean-save playtest steps.
   - Purpose: make future screenshot/playtest feedback reproducible.

3. Commit the HUD mode separation and add focused readability coverage.
   - Purpose: preserve the surface-versus-dive HUD fix and guard against regression.

4. Move scan, prompt, and status text into a compact dive HUD panel.
   - Purpose: prevent loose white text from floating over the playfield.

5. Move surface instructions into the ready panel.
   - Purpose: remove duplicate pre-dive tutorial text from the left side.

6. Apply compact scan marker prototype to runtime scan targets.
   - Purpose: make nearby scan targets readable without relying on labels.

7. Apply compact lock marker prototype to the pressure wreck.
   - Purpose: distinguish upgrade gates from route hints and rewards.

8. Apply compact return marker prototype to safe-return cues.
   - Purpose: keep return-to-base orientation stronger than optional routes.

9. Apply compact danger marker prototype to the Gulper route.
   - Purpose: make predator danger visible before contact.

10. Apply compact reward marker prototype to deep reward lures.
    - Purpose: make optional deeper temptation readable without looking mandatory.

11. Run lower-route visual overlap review after marker application.
    - Purpose: check pressure lock, signal/cache, deep reward, predator warning, and return cues together.

12. Add debug-only condition and cluster telemetry.
    - Purpose: make five-seed reviews easier without exposing debug text to players.

13. Add first non-mechanical `Thermal Bloom` visual condition effect.
    - Purpose: make one expedition condition visible while preserving mechanics.

14. Add first non-mechanical `Calm Current` visual condition effect.
    - Purpose: make safe-return/route calmness visible as day flavor.

15. Review condition effects across five seeds.
    - Purpose: determine whether condition presentation helps planning or only adds noise.

16. Plan first condition-driven authored spawn weighting.
    - Purpose: define how conditions can bias existing authored candidates without procedural generation.

17. Implement one condition-driven authored candidate weighting.
    - Purpose: make one condition slightly alter opportunity placement while preserving depth bands.

18. Add tests for condition-driven candidate weighting.
    - Purpose: ensure deterministic, bounded, depth-safe condition variation.

19. Update current gameplay and architecture docs after condition weighting.
    - Purpose: keep durable state, authored scene data, and condition ownership clear.

20. Replenish the backlog after the demo readability and hybrid-variation batch.
    - Purpose: decide whether the next milestone should be art/readability, monster research, or progression depth.

## Success Gate

This batch succeeds when:

- a fresh prototype run can be started from inside the game,
- pre-dive and active-dive HUD modes no longer overlap,
- scan, lock, return, danger, and reward cues have compact runtime markers,
- at least one expedition condition has visible impact,
- at least one condition has a narrow authored gameplay bias,
- five-seed reviews can record seed, condition, cluster, and route observations cleanly,
- no new variation hides safe return, breaks depth identity, or turns optional routes into mandatory arrows.
