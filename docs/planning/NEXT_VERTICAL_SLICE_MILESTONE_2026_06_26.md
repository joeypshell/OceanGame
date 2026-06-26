# Next Vertical-Slice Milestone - 2026-06-26

Status: planning artifact for issue #238.

## Milestone Name

Playable Vertical Slice Readability And Cohesion.

## Purpose

Move the prototype from a feature-rich readable testbed into a coherent first vertical slice that can be played, understood, and judged without developer explanation.

This milestone should improve the current loop, HUD, route readability, source-art integration, and acceptance evidence. It should not expand into broad content, final art production, or new major systems.

## Current Work

Current work means items that directly help the existing slice meet `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`:

- implement the compact active-dive HUD skin from `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md`,
- run normal-scale screenshot reviews for surface ready, active dive, pressure gate, predator route, and result UI,
- reduce lower-route visual density around pressure wreck, cache, rare-signal shimmer, deep reward, and predator language,
- review and tune sprite/fallback balance for Shell Reef, Thermal Vent, pressure wreck, Wreck Signal Cache, and Gulper route,
- preserve surface/result panel ownership so text does not obscure the playfield,
- keep the daily expedition framing and result memory focused on "one more dive" motivation.

## Next Work

Next work means planning-ready items after the current readability gate is stable:

- plan the later `Wreck Echo Descent` pocket from `docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md`,
- define how Echo Lens curiosity can point toward deeper-right wreck pressure without exact locator UI,
- keep `Wreck Echo Descent` planning-only until the current HUD, surface panels, pressure wreck/cache, predator route, and lower-route visuals pass the playable-slice readability gate,
- use `docs/planning/NEXT_SOURCE_ART_REPLACEMENT_PRIORITY_2026_06_26.md` to keep the next source-art pass focused on surface moonpool/waterline readability, with pressure wreck/cache as backup,
- expand condition reviews only when they remain presentation-first and do not imply unavailable mechanics,
- capture a small acceptance evidence bundle using `docs/current/SCREENSHOT_WORKFLOW.md`.

## Deferred Work

Deferred work remains valid direction, but should wait until the playable slice is clearer:

- larger biome set,
- broader resource economy,
- advanced monster-hunting tools,
- production animation set,
- audio pass,
- web export polish,
- full save-slot or profile UI,
- base-management or cargo-processing layers.

## Out Of Scope

Do not add these during this milestone:

- minimap, route graph, exact scanner locator, or field-guide UI,
- objective checklist or quest log,
- weapons, predator harvesting, predator health, capture, or combat rewards,
- full procedural ocean generation,
- daily challenge calendar mode,
- inventory grid, item rearranging, or large crafting tree,
- final production-art lock.

## Success Gate

The milestone succeeds when the current prototype can satisfy the acceptance summary in `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`: two short expeditions, one clear upgrade path, one blocked route, one danger route, one optional clue route, and no unreadable text or shape pileup in normal player view.

## Backlog Direction

The next issue batch should prioritize:

1. active HUD skin implementation,
2. normal-scale readability screenshots,
3. lower-route density cleanup,
4. sprite/fallback balance reviews,
5. acceptance evidence,
6. narrow Wreck Echo planning only after the current slice is readable.

## Next Milestone Handoff

After the #300-#302 solo/evidence/status updates, the next milestone is defined in `docs/planning/NEXT_MILESTONE_AFTER_VERTICAL_SLICE_CLOSEOUT_2026_06_26.md`.

The handoff direction is `Wreck Echo Preparation And Slice Polish`: finish the remaining current-slice watchlists, select the next source-art target by readability impact, and plan Wreck Echo Descent without implementing a new route until the current slice stays readable.
