# Wreck Echo Test Coverage Plan - 2026-06-26

Status: planning artifact for issue #356. No runtime tests are added yet because the first implementation contract is still being settled.

## Purpose

Define the coverage expected before or during the first authorized `Wreck Echo Descent` implementation. The goal is to make the future route testable without accidentally freezing premature behavior or implying the route exists today.

## Existing Test Patterns To Reuse

Use the current `tests/logic_tests.gd` style:

- upgrade metadata and prerequisite tests, as used for `Pressure Seal I`, `Signal Lens I`, and `Echo Lens I`,
- effect-isolation tests, as used for predator warning, decoy pulse, and Echo Lens,
- compact copy/no-forbidden-language guards, as used for result, upgrade, cache, and scanner text,
- scene-contract checks for required visual/behavior nodes and visual hierarchy,
- pressure-lock guidance and scan-clue text tests,
- result memory callout tests,
- spawn-selection helper tests if the route uses authored candidates.

## Coverage Required When Implementation Is Authorized

### Gating

- `Wreck Echo Descent` must require the selected prerequisites from the implementation contract.
- `Echo Lens I` may provide broad curiosity or route understanding, but must not bypass `Pressure Seal I` or existing pressure access.
- If the route uses authored candidate points, selection must be deterministic from seed/pattern and must not rely on hidden hard-coded coordinates.

### No-Locator And Copy Guardrails

- Active status, scan text, upgrade text, result text, and route copy must avoid minimap, quest log, checklist, exact-coordinate, exact-distance, and persistent-marker language.
- Allowed copy should stay broad/local/category-based, such as `below the shelf`, `deeper pressure echo`, or `weak wreck signal`.
- Repeat scans must not create a durable objective marker or exact route instruction.

### Result Memory And Reward

- The primary reward should be one compact research clue result line.
- The result line should connect to Wreck Shelf or Wreck Echo memory without implying a completed quest chain.
- The reward must not grant a new upgrade, field-guide entry, broad economy, or prerequisite discovery unless a later issue explicitly changes the reward contract.

### State Reset And Persistence

- Active Wreck Echo attempt state must reset between expeditions.
- Durable progression should keep only the explicitly selected discovery or research outcome.
- Failed dives should preserve durable discoveries according to existing scan/failure rules, while carried cargo remains subject to existing cargo-loss rules.
- Restarting or advancing the expedition must not leave stale route prompts, pulses, markers, or temporary scan feedback.

### Non-Interference

- Existing pressure gate denial/open behavior must remain unchanged.
- Existing `Wreck Signal Cache`, `Signal Lens I`, and `Echo Lens I` behavior must remain distinct.
- Existing Gulper route, `Predator Warning I`, `Decoy Pulse I`, predator contact, and burst-thruster rules must remain unchanged.
- Existing starter resource counts, cargo limits, oxygen costs, scan costs, and extraction/failure rules must remain unchanged unless the future implementation issue explicitly scopes a change.

### Visual And Screenshot Evidence

- Add scene-contract checks for any new future route holder, visual scene, scan clue, and reward node.
- Add Playwright screenshot coverage or a documented normal-scale screenshot pass for the lower-route/Wreck Echo view, including HUD, return direction, pressure gate/cache, predator lane, and route reward/clue readability.
- Keep screenshot artifacts local/CI-only unless a later issue explicitly asks for committed references.

## Tests Not To Add Yet

Do not add failing placeholder tests for route nodes, scan targets, rewards, or pressure-dark art before an implementation issue authorizes those objects. Until then, planning docs and existing no-locator/Echo Lens tests are enough.

## First Useful Test Batch

When implementation begins, add tests in this order:

1. prerequisite and gating logic,
2. no-locator copy guard,
3. state reset and no stale temporary marker/pulse,
4. result research-clue memory line,
5. pressure/predator/resource non-interference,
6. scene-contract and Playwright/normal-scale evidence.

## Decision

This plan ties future Wreck Echo coverage to existing test patterns without adding premature tests before the behavior contract is finalized.
