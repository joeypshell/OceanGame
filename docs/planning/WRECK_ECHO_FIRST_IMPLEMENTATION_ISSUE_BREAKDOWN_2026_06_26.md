# Wreck Echo First Implementation Issue Breakdown - 2026-06-26

Status: planning artifact for issue #352. This is a draft issue spec, not runtime implementation.

## Recommendation

Use one first implementation issue.

Do not split the first runtime pass unless the implementation issue discovers a concrete blocker. The current plans are narrow enough for one scoped ticket:

- one Wreck Echo route pocket,
- one prepared-route question,
- one compact research clue,
- run-scoped state only,
- no broad route system or new economy.

## Recommended Future Issue

Title: Implement first Wreck Echo route pocket with one compact research clue

### Summary

Add the first playable `Wreck Echo Descent` route pocket as a small prepared-route extension from the existing Wreck Shelf/pressure-cache promise. The route should reward a successful return with one compact research clue and should preserve current pressure, predator, scan, oxygen, cargo, and save/progression behavior.

### User Story

As a player who has learned the pressure wreck/cache and bought the scanner context, I want to risk a deeper Wreck Echo attempt when oxygen allows, then return with one strange research clue rather than a quest objective or map marker.

### Scope

Allowed:

- one authored route pocket near the existing lower Wreck Shelf/pressure-cache area,
- one route holder scene or node group owned separately from current pressure/cache gameplay,
- one optional scannable or touch/entry trigger for the Wreck Echo clue, whichever the implementation contract selects,
- one run-scoped clue flag in `DiveSession` or a small run helper owned by `main.gd`,
- one extraction result `Research:` line when the clue is recovered and the player returns,
- normal-scale screenshot or Playwright evidence for the route view and result view,
- focused logic tests for state reset, no-locator copy, and non-interference.

Preserve:

- `Pressure Seal I` remains required for pressure access,
- `Echo Lens I` remains broad curiosity and must not bypass pressure access,
- existing pressure gate, outside scan, Wreck Signal Cache, and cache repeat-scan behavior,
- existing Gulper Eel route, predator warning, contact, `Predator Warning I`, and `Decoy Pulse I`,
- existing oxygen drain, pickup costs, scan costs, cargo limits, extraction, failure, save/load, and upgrade behavior,
- existing starter resource counts and seeded resource placement.

Avoid:

- minimap, field guide, route graph, objective checklist, quest log, exact locator, persistent marker, or map pin,
- new resources, upgrade tier, crafting economy, prerequisite discovery, predator, combat, loot, capture, or harvesting,
- broad procedural biome generation,
- pressure-dark art that overpowers the HUD, pressure gate/cache, safe return, or predator warning,
- any durable Wreck Echo clue state unless a separate issue explicitly promotes it.

### Likely Files

- `scenes/Main.tscn`: authored route holder, candidate point, clue trigger or scannable, and visual instance.
- `scenes/readability/WreckEchoDescentVisuals.tscn`: small presentation-only route pocket visual, if the scene grows beyond a few nodes.
- `scripts/main.gd`: run orchestration, clue trigger handling, result line formatting, HUD/status copy.
- `scripts/dive_session.gd`: optional run-scoped clue flag if this is cleaner than keeping it in `main.gd`.
- `tests/logic_tests.gd`: state reset, result line, no-locator language, pressure/cache/predator/resource non-interference.
- `tests/playwright/visual-smoke.spec.mjs`: lower-route or Wreck Echo screenshot path if the route is visible in the exported build.
- `docs/current/GAMEPLAY.md`: implemented behavior after the route exists.
- `docs/current/ARCHITECTURE.md`: only if the state ownership shape changes from the current plan.
- `docs/current/ROADMAP.md`: implementation status update.

### Acceptance Criteria

- The route exists as one authored pocket and one route question, not a new biome.
- The route is reachable only through the existing pressure-access path after the selected prerequisites are met.
- The player can turn back without failure and can fail only through existing oxygen/cargo rules.
- Successful clue recovery plus extraction adds one compact `Research:` result line.
- Returning without the clue does not show a Wreck Echo reward line and does not scold the player.
- Oxygen failure loses carried cargo only under existing rules and does not add extra Wreck Echo punishment.
- Active clue/attempt state resets when the next expedition is prepared.
- No persistent marker, exact locator, field guide entry, quest state, checklist, route graph, or minimap is added.
- Existing pressure gate/cache, Echo Lens, Signal Lens, Gulper, Decoy, resources, cargo, oxygen, extraction, failure, save/load, and upgrade behavior still pass.
- Normal-scale evidence shows the route, HUD, safe return, pressure gate/cache, predator lane, and result text remain readable.

### Verification

Required:

- Godot headless launch.
- `tests/logic_tests.gd`.
- MCP context self-test.
- `git diff --check`.
- Playwright visual smoke or a documented normal-scale screenshot pass covering the active route view and extraction result.

Optional but useful:

- One clean manual smoke from ready state through route attempt, clue recovery, extraction, restart, and no-stale-state check.

## Follow-Up Splits

Do not create follow-ups by default.

Split only if one of these blockers appears:

- visual route pocket cannot stay readable without a separate source-art issue,
- HUD/result copy overflows and needs a dedicated UI issue,
- durable persistence becomes necessary after playtest, requiring a save-schema issue,
- lower-route pressure/cache/predator overlap regresses enough to need a dedicated readability fix.

## Current Scope

This issue breakdown creates no route nodes, scene files, runtime copy, tests, assets, or GitHub implementation issue yet. It defines the recommended first implementation ticket for use after the remaining Wreck Echo prep issues finish.
