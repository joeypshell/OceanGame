# Post-Closeout Wreck Echo Handoff Status - 2026-06-26

Status: planning/status artifact for issue #340.

## Decision

The playable vertical slice is accepted as structurally playable and ready to hand off into `Wreck Echo Preparation And Slice Polish`.

It is not final production polish. It remains `pass with watchlist` because future visual, HUD, source-art, and route changes can reintroduce lower-route, surface-panel, or active-HUD confusion.

## Cleared

The current closeout/evidence set clears the earlier blocker-level concerns:

- surface ready/result panel overlap,
- active dive loose text clutter,
- result panel overflow,
- upgrade-tab wrapping,
- debug telemetry appearing by default,
- confusing owned-progress persistence after relaunch,
- surface boat/moonpool extraction read,
- player/boat overlap at surface extraction,
- lower-route visual pileup reduced by pressure shell and fallback dimming,
- Echo Lens no-locator language,
- Signal Lens versus Echo Lens distinction,
- Decoy/Gulper non-combat readability,
- normal screenshot workflow and Playwright visual smoke harness.

## Still Pass-With-Watchlist

Keep watchlists on:

- lower-route pressure gate/cache/predator/reward density after any visual or route change,
- fixed top-left active HUD footprint if new left-side route art appears,
- surface result/ready panel contrast if boat, waterline, or panel art changes,
- result and upgrade copy length if new upgrades or route results are added,
- scan/resource marker distinction if future art makes scanner feedback look like exact navigation,
- Wreck Echo implementation evidence once runtime route work begins.

## Wreck Echo Handoff

Wreck Echo work is now well-scoped as preparation, not broad expansion.

The current planning batch establishes:

- one future route promise: deeper-right `Wreck Echo Descent`,
- one reward shape: compact research clue,
- route placement preference: deeper-right, not inside the current pressure/cache/predator/reward pile,
- prep pressure: pressure/scanner context plus oxygen margin, not cargo requirement,
- ownership: authored scene placement, `main.gd` orchestration, run-scoped clue state, no durable objective state by default,
- copy: broad/local/category-based, no exact locator or checklist language,
- visuals: pressure-dark mood only, below oxygen, safe return, predator, pressure gate, cache, and player,
- evidence: normal-scale screenshots or Playwright visual smoke plus logic tests before implementation closes.

## What Must Stay Narrow

Future Wreck Echo route implementation must not add:

- minimap,
- exact locator,
- field guide,
- quest log,
- objective checklist,
- route graph,
- persistent marker,
- broad biome/procedural generation,
- combat, weapons, predator harvest/capture/loot,
- new resource economy,
- new upgrade tier,
- durable Wreck Echo objective state by default.

## Next Correct Work

After this handoff, the next work should stay in one of two lanes:

1. Current-slice polish: HUD skin/icon-frame source-art, screenshot evidence, and regression checks that protect the playable loop.
2. Narrow Wreck Echo implementation planning/execution: only after the first-pass acceptance contract is used as the issue scope.

Do not treat the closeout as permission for broad content expansion.

## Current Scope

This status update changes no runtime behavior, scenes, scripts, tests, assets, or GitHub issue backlog by itself.
