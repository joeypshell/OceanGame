# Visual Language And Readability Assets

Status: active planning seed for a small readability-asset batch.

## Purpose

The prototype has reached the point where placeholder shapes are no longer only rough; in places like the pressure-lock route, they can make the intended action harder to understand. The next visual work should create gameplay-clarity assets before final art production.

This is not a polish milestone. It is a readability milestone.

## Architecture Pattern To Follow

The useful pattern from reference projects such as Sunny Town is not the exact renderer or tech stack. It is the ownership split:

- authored world data defines what exists and where,
- runtime state defines what is currently happening,
- durable progression defines what survives between sessions,
- rendering/readability assets communicate the state without owning it.

For OceanGame, this means readability assets should be authored and reusable, but they should not become hidden gameplay state. A `PressureGate` can show that a route is locked, but `ProgressionState` and the upgrade effect decide whether it is actually open. A `CurrentHint` can point toward a route, but the route decision still comes from authored placement, oxygen, cargo, and scan/progression rules.

## Proposed Asset Ownership

Use this model when turning placeholder polygons into reusable prototype assets:

| Layer | Owns | Examples | Should Not Own |
| --- | --- | --- | --- |
| Authored scene/data | Inspectable placement and route identity | spawn points, scan targets, pressure gate location, biome pocket landmarks | player progress, oxygen, cargo |
| Runtime dive state | Temporary expedition facts | oxygen, current cargo, result, predator contacts, route telemetry | durable unlocks, final art identity |
| Durable progression | Long-lived player progress | banked resources, upgrades, discoveries, best depth | active hints, temporary highlights |
| Readability assets | Visual communication | gate shapes, current bands, signal pings, scan markers, warning ribs | unlock rules, costs, save data |
| HUD/surface UI | Concise mode/action feedback | result tabs, prompts, status text, upgrade bay | route geometry, hidden objective systems |

## Godot Implementation Direction

Prefer small reusable Godot-native assets before final art:

- `PressureGate` scene or grouped nodes for locked/open route language,
- `CurrentHint` scene or grouped nodes for soft route suggestions,
- `SignalHint` scene or grouped nodes for future payoff signals,
- `ScanMarker` scene or script for consistent scannable target readability,
- named color/shape rules documented here before adding many one-off polygons.

These may start as `Polygon2D`, `Label`, `Node2D`, and small scripts. They should be authored in scenes and wired by `main.gd` or small helper scripts, not generated procedurally without inspection.

## Current Problem

Several important meanings are currently communicated by overlapping labels, translucent polygons, and one-off colors:

- safe base and return route,
- resource/reward hints,
- scan targets,
- environmental current hints,
- pressure-locked progression gates,
- predator warning routes,
- biome-pocket landmarks.

The player should be able to understand these meanings from repeated visual language before reading every HUD line.

## First Visual Vocabulary

### Safe / Return

- Shape language: vertical columns, beacons, simple repeated light ribs.
- Color direction: cool cyan/green, low opacity, stable.
- Meaning: this is how to orient and return.

### Resource / Reward

- Shape language: small clustered deposits, glows, compact pings.
- Color direction: yellow-green for valuable signals, resource-specific accents for pickups.
- Meaning: this may be worth oxygen or cargo space.

### Scan / Knowledge

- Shape language: small brackets, reticles, or highlighted silhouettes around a target.
- Color direction: readable but not louder than danger or locks.
- Meaning: scan this to learn or unlock a route.

### Current / Route Hint

- Shape language: soft directional bands or arrowlets, not hard UI arrows.
- Color direction: low-opacity green/cyan.
- Meaning: this suggests a path, but does not guarantee safety.

### Locked / Progression Gate

- Shape language: clear doorway/gate/barrier silhouette with caps or bars.
- Color direction: cyan/blue shimmer with firm edges.
- Meaning: blocked now; upgrade or discovery needed before entry.

### Danger / Predator

- Shape language: warning ribs, pulses, harsh angles.
- Color direction: red/orange danger accents.
- Meaning: avoid, observe, or prepare before crossing.

### Biome Pocket / Landmark

- Shape language: larger readable silhouettes with open route gaps.
- Color direction: pocket-specific accent that still fits depth band.
- Meaning: this is a place with a route choice, not just decoration.

## Recommended Small Batch

Create issues for:

1. a first visual language guide,
2. reusable pressure-gate/current/signal prototype assets,
3. current and route-hint visual consistency,
4. scan-target marker consistency,
5. depth-band and landmark readability pass.

## Constraints

Do not add:

- final art production,
- large asset packs,
- animation systems,
- particle-heavy effects,
- minimaps,
- route overlays,
- tutorial walls,
- new mechanics,
- new biomes,
- decorative assets that do not improve player decisions.

## Success Gate

The batch succeeds when a player can distinguish:

- blocked route versus route hint,
- future payoff versus immediate pickup,
- scan target versus resource,
- danger warning versus reward signal,
- safe return language versus decorative background.

## Relationship To Final Art

These assets should be simple, reusable, and easy to replace later. They are prototype readability assets that define the game language before committing to final sprites, animations, lighting, or production art direction.

Final art should replace or skin these prototype assets without moving gameplay rules into the art layer.
