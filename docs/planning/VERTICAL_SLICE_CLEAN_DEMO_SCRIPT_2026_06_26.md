# Vertical-Slice Clean Demo Script - 2026-06-26

Status: manual demo script for issue #368, refreshed after the first Wreck Echo implementation pass.

## Purpose

Use this for a short solo review or live demo of the current playable vertical slice. It is not blind validation and does not require automation, helpers, or committed screenshots.

Target length: 5 to 8 minutes.

## Setup

1. Launch the game from the repository root.
2. For a clean first-run demo, enable debug telemetry only long enough to press F9 and reset prototype progression.
3. Hide debug telemetry again before judging player-facing readability.
4. Start from `Expedition 1 Ready`.

Expected read: surface boat/lab, start prompt, today's condition, and one useful goal line are visible without active-dive HUD clutter.

## Demo Pass

1. Start the expedition with E or Enter.
2. Move away from the moonpool and dive until the active HUD is visible.
3. Point out only the core active information: O2, depth, base direction, cargo slots, scan target, prompt, and status.
4. Collect a nearby resource or scan the first useful target.
5. Return to the surface base and extract with E or Enter before oxygen failure.
6. Read the result panel: banked cargo or useful scan data, one memory/result line, upgrade progress, and R for the next expedition.
7. Switch to the `Upgrades` surface view, use Up/Down once, and show that one selected upgrade explains cost, state, and missing requirements.
8. Start one more expedition or describe that R advances to a shifted ocean day while durable progress stays.

Expected read: the loop is understandable as dive, decide, return or fail, read result, prepare, and dive again.

## Route Promises To Show If Time Allows

- Pressure/wreck promise: approach or describe the pressure-locked research wreck. It should read as blocked until `Pressure Seal I`, then as an opened route to the `Wreck Signal Cache` after ownership.
- Predator route: approach the Gulper route far enough to see warning language and route danger. It should read as avoidable timing risk, not combat.
- Optional clue route: point out Shell Reef or Thermal Vent as useful optional route knowledge rather than a mandatory objective.
- Optional Wreck Echo route: only if the demo state already owns `Pressure Seal I` and `Echo Lens I`, show the single deeper-right `Wreck Echo Descent` pocket as a small research curiosity. Recovering its clue should ask the player to return, and successful extraction should add one compact `Research:` line. Do not spend a first-run demo trying to grind prerequisites just to show it.

Wreck Echo note: the current build now includes only the first narrow route pocket and one run-scoped clue. It is safe to describe as an implemented research-route promise, not as a new biome, map system, quest chain, durable collection, exact locator, or guaranteed safe route.

## Failure Variant

If the demo naturally fails by oxygen depletion:

1. Let the failure panel own the screen.
2. Confirm carried cargo is lost while durable banked progress/discoveries remain.
3. Press R to show the next expedition setup.

Expected read: failure is understandable and recoverable, not a broken state.

## Things Not To Claim

- Do not call this blind validation.
- Do not claim final art, final UI, or production polish.
- Do not imply a minimap, exact scanner locator, field guide, quest log, inventory grid, combat loop, or full procedural ocean exists.
- Do not claim `Wreck Echo Descent` is a full biome, full level layer, broad route system, durable research collection, or production-polished feature.
- Do not describe the Wreck Echo clue as a quest objective, map marker, exact scanner locator, field-guide entry, upgrade unlock, cargo reward, or combat reward.

## Pass Criteria

The demo passes if the reviewer can follow:

- where to start,
- how to dive,
- what oxygen pressure means,
- how to collect or scan something useful,
- how to return or understand failure,
- where upgrade progress is shown,
- why the pressure/wreck route is an upgrade-gated route promise,
- why the first Wreck Echo pocket is a later optional research curiosity after pressure/scanner preparation,
- why the predator route is risk/timing rather than combat.

## Watchlist Notes

Record any confusion as a future issue only if it blocks the loop or contradicts current planning. Useful narrow notes include:

- surface panel contrast problem,
- active HUD covering a core route target,
- pressure lock or Wreck Signal Cache reading as an exact objective marker,
- predator route reading as combat, loot, or random unavoidable damage,
- upgrade view becoming too long or hard to scan.
