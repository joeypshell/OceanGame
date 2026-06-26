# Wreck Echo First-Pass Acceptance Contract - 2026-06-26

Status: planning artifact for issue #341. This contract must be satisfied before or during any first-pass Wreck Echo runtime implementation.

## First-Pass Promise

Exactly one first-pass route promise:

`Wreck Echo Descent`: one deeper-right prepared route pocket downstream of the existing Wreck Shelf, pressure gate, Wreck Signal Cache, and Echo Lens handoff.

The player promise:

> If I have pressure/scanner context and enough oxygen margin, I can risk one deeper Wreck Echo attempt and return with one strange research clue.

## Reward Shape

Exactly one first-pass reward:

One compact research clue result line after clue recovery plus successful extraction.

Primary result line:

`Research: Wreck Echo clue carried a deeper pressure signal below the shelf.`

No first-pass material, prototype sample, upgrade unlock, prerequisite discovery, field-guide entry, quest completion, or new economy.

## Required Access/Preparation Contract

The route must respect:

- `Pressure Seal I` as pressure access context,
- `Signal Lens I` as practical scanner prerequisite through `Echo Lens I`,
- `Echo Lens I` as broad Wreck Echo curiosity and handoff,
- `Oxygen Tank I` as soft survival preparation through route distance/return pressure,
- `Cargo Rack I` as optional and not required for the research clue.

`Echo Lens I` must not bypass `Pressure Seal I`.

## Required Behavior Contract

A future implementation must satisfy:

- one route pocket only,
- one route question only,
- one run-scoped clue flag only,
- active attempt/clue state resets between expeditions,
- successful clue recovery plus extraction produces the compact `Research:` line,
- returning without the clue produces no Wreck Echo reward line,
- oxygen failure preserves existing cargo-loss/durable-progress rules only,
- no new oxygen cost, cargo requirement, pressure damage, route cooldown, or permanent penalty unless a later issue explicitly scopes it.

## Required Ownership Contract

Future implementation should use:

- `scenes/Main.tscn` for authored holder/placement,
- optional `SpawnPoint` nodes only if route placement needs authored candidates,
- optional `scenes/readability/WreckEchoDescentVisuals.tscn` for presentation-only visuals,
- `main.gd` for orchestration, HUD/status, and result formatting,
- `DiveSession` or a run helper for temporary attempt/clue state,
- `ProgressionState` only for existing durable categories unless a later issue promotes durable Wreck Echo research.

## Out Of Scope

Do not add:

- minimap,
- exact locator,
- route graph,
- field guide,
- quest log,
- objective checklist,
- persistent marker,
- combat, weapon, hunting, capture, harvest, loot, predator health, or route removal,
- broad biome/procedural generation,
- new resource economy,
- new upgrade tier,
- new persistent Wreck Echo save data,
- pressure bypass or shortcut around current pressure access.

## Implementation Blockers

Do not start implementation if any of these remain unresolved:

- route pocket cannot be placed deeper-right without visual pileup,
- pressure gate/cache/predator/reward/HUD reads are not distinct at normal scale,
- active HUD cannot fit Wreck Echo prompt/status copy without overflow,
- result panel cannot contain the research line,
- no-locator/no-quest copy guardrails are missing from tests or review,
- route requires more than one pocket, one reward, or one new system to feel meaningful,
- pressure-dark art needs to be wired before route behavior is scoped.

## Required Evidence Before Closing Implementation

Future implementation must include:

- Godot headless launch,
- deterministic logic tests,
- MCP context self-test if docs/context change,
- `git diff --check`,
- Playwright visual smoke or documented normal-scale screenshots covering active route view and result readback,
- evidence that pressure gate/cache, Echo Lens, Signal Lens, Gulper, Decoy, resources, oxygen, cargo, extraction, failure, save/load, and upgrades still behave as before.

Use `docs/planning/WRECK_ECHO_NORMAL_SCALE_SCREENSHOT_CHECKLIST_2026_06_26.md` for visual evidence.

## Current Scope

This contract does not implement Wreck Echo, create route nodes, add assets, change copy, add tests, tune costs, or open a runtime implementation issue.
