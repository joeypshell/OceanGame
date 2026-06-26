# Wreck Echo Descent Route-Pocket Data Shape - 2026-06-26

Status: planning artifact for issue #306.

## Purpose

Sketch the future data and scene ownership shape for `Wreck Echo Descent` without wiring it into gameplay.

This is planning-only under `docs/planning/WRECK_ECHO_DESCENT_NO_IMPLEMENTATION_CRITERIA_2026_06_26.md`.

## Ownership Model

Future ownership should follow the existing architecture:

| Concern | Future Owner | Notes |
| --- | --- | --- |
| Durable discovery/progression | `ProgressionState` and stable discovery/upgrade ids | Only after a future issue chooses a real discovery or reward. |
| Active expedition state | `DiveSession` and `main.gd` orchestration | No active state should be saved as durable route state. |
| Placement candidates | typed `SpawnPoint` nodes | Candidate points should be authored and inspectable, not generated from hidden coordinates. |
| Route selection | `SpawnSelection` or a small helper/resource | Select one authored pocket/entry candidate from seed/condition when implementation is authorized. |
| Visual shell | future `scenes/readability/` scene | Presentation-only, like Thermal Vent and Pressure Wreck visuals. |
| Scan clue | one future scannable route clue if needed | Must be broad/local and temporary; no map marker or persistent objective. |
| Reward | one selected reward type | Choose exactly one: compact research clue, rare material opportunity, or later prerequisite discovery. |

## Likely Node Shape When Implementation Is Authorized

Do not add these nodes yet. This is the likely future shape:

```text
Main
  WreckEchoDescentCandidates
    EntryLeftOrUpper       SpawnPoint(category="discovery", target_id="wreck_echo_descent", route_id="...")
    EntryRightOrLower      SpawnPoint(category="discovery", target_id="wreck_echo_descent", route_id="...")
    RewardCandidate        SpawnPoint(category="resource_cluster" or "discovery", target_id="<chosen_reward>")
  WreckEchoDescent         Node2D or Area2D holder
    Visuals               instance of scenes/readability/WreckEchoDescentVisuals.tscn
    OptionalScanClue       Scannable only if the future issue chooses a clue
    OptionalReward         only one future reward type
```

## Spawn-Point Needs

If implementation is later authorized, candidate spawn points should include:

- stable `spawn_id`,
- category such as `discovery`, `resource_cluster`, or a future route-specific category if justified,
- target id `wreck_echo_descent` for route candidates,
- depth band `deep`,
- cluster pattern `any` unless a future issue proves a bounded pattern distinction,
- optional `preferred_condition_id` only if a condition-specific route feel is explicitly planned,
- `route_id` for grouping entry/reward/support points.

Do not use untyped hard-coded coordinates for route decisions.

## Scan Clue Needs

A future scan clue may exist only if it helps the player understand a prepared-route question. It should:

- require prior Wreck Shelf/cache context,
- remain broad and local,
- say why preparation matters,
- expire as active status/result memory rather than becoming a persistent marker,
- avoid exact direction/distance, objective lists, map icons, and field-guide entries.

Allowed direction language:

- `below the shelf`,
- `deeper pressure echo`,
- `weak wreck signal deeper-right`,
- `return with better oxygen or pressure access`.

## Reward Shape

The first future implementation must choose exactly one reward type:

1. Compact research clue about deeper wreck signals.
2. Rare material opportunity or prototype sample.
3. Later prerequisite discovery.

Do not combine these into a multi-step quest. The result should support "I learned enough to plan another dive," not "I completed a checklist."

## Preservation Rules

Future implementation must preserve:

- current pressure gate and `Pressure Seal I` behavior,
- current outside scan and Wreck Signal Cache behavior,
- current Echo Lens pulse and no-locator copy rules,
- current Gulper route behavior and Decoy Pulse behavior,
- current resource pickup count and starter placement unless separately authorized,
- safe-return readability,
- no broad procedural biome generation.

## Current Decision

This issue does not edit `Main.tscn`, add route nodes, add scan targets, add rewards, add collision, add markers, or wire pressure-dark art.

The route-pocket data shape is now documented for future implementation gating.
