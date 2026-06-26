# Region And Landmark Metadata

Status: planning source for #111.

## Purpose

Persistent geography needs names, roles, and boundaries that future systems can reference without turning every landmark into hidden gameplay state. This document defines lightweight metadata for the current route pockets and future regions.

This is a planning document. It does not implement metadata yet.

## Metadata Shape

Use lightweight authored metadata with these fields:

| Field | Purpose |
| --- | --- |
| `id` | Stable machine id such as `shell_reef` or `thermal_vent_field`. |
| `display_name` | Player-facing place name. |
| `kind` | `base`, `region`, `landmark`, `route`, `gate`, or `threat_route`. |
| `depth_band` | `surface`, `shallow`, `midwater`, `deep`, or `trench`. |
| `role` | Why the place exists in the current loop. |
| `persistent_facts` | What the player can learn and rely on across expeditions. |
| `variable_hooks` | What may change by seed or expedition-day condition. |
| `related_discoveries` | Scan ids that reveal or explain the place. |
| `related_upgrades` | Upgrades that open, improve, or respond to the place. |
| `readability_priority` | The most important visual meaning to preserve. |

Metadata should support briefing, review, and future condition logic. It should not directly own oxygen, cargo, scan, pressure, predator, or upgrade rules.

## Current Places

| id | display_name | kind | depth_band | role |
| --- | --- | --- | --- | --- |
| `surface_base` | Surface Base | `base` | `surface` | Safe start, extraction, result, upgrade, and next-expedition hub. |
| `shell_reef` | Shell Reef | `landmark` | `midwater` | Safer bank route and first persistent midwater place memory. |
| `thermal_vent_field` | Thermal Vent Field | `landmark` | `midwater`/`deep` | Optional warm-current clue route and `Pressure Seal I` knowledge source. |
| `wreck_shelf` | Wreck Shelf | `region` | `midwater`/`deep` | Pressure-locked promise, future cache payoff, and later wreck-route variation space. |
| `pressure_locked_wreck` | Pressure-Locked Research Wreck | `gate` | `deep` | Visible blocked route that returns payoff after `Pressure Seal I`. |
| `gulper_route` | Gulper Route | `threat_route` | `deep` | Predator-controlled risk/reward route and observation/countermeasure learning space. |

## Persistent Facts

### Surface Base

- Player starts here.
- Extraction only succeeds after leaving and returning.
- Surface UI owns results, upgrades, log, and ready briefing.
- Safe return orientation should always point back toward this place.

### Shell Reef

- Midwater landmark.
- Associated with safer banking and `Shell Fragments`.
- Should stay recognizable across seeds.
- Can host authored shell candidate points without increasing active pickup count.

### Thermal Vent Field

- Warm-current landmark near the midwater/deep transition.
- Scanning `Thermal Vent` supplies pressure-seal knowledge.
- Revealed route hints must remain optional, not objective arrows.
- Vent-adjacent `Glow Plankton` candidates can be selected by seed.

### Wreck Shelf And Pressure-Locked Wreck

- Wreck promise is visible before the player can enter.
- `Pressure Seal I` opens the first pressure-locked route.
- Outside scan explains the return loop.
- Inside `Wreck Signal Cache` is a later payoff.

### Gulper Route

- Deep predator route controls high-value pressure.
- Warning current and patrol hint must communicate danger before contact.
- Observation, warning, and decoy upgrades interact with this route without turning it into combat loot.

## Variable Hooks

These are allowed future hooks, not current behavior requirements:

| Place | Variable Hook |
| --- | --- |
| `shell_reef` | Which authored shell candidate is active; return-current emphasis under Calm Current. |
| `thermal_vent_field` | Vent-adjacent glow candidate weighting; route hint intensity under Thermal Bloom. |
| `wreck_shelf` | Which authored wreck signal or entrance angle is emphasized under Wreck Shift or Rare Signal. |
| `gulper_route` | Which authored predator route is selected; warning presentation under Predator Migration. |
| `surface_base` | Which condition briefing is shown before the dive. |

## Guardrails

- Metadata should be authored and inspectable.
- Metadata may describe a place, but gameplay rules still live in current systems.
- Metadata should not become a parallel quest system.
- Metadata should not bypass scan discoveries or upgrade gates.
- Metadata should not imply region select is required for the current vertical slice.
- Metadata should make review and future condition work clearer before adding broad procedural content.

## First Implementation Candidate

The next narrow implementation should add inspectable metadata for existing scene landmarks only:

- `surface_base`,
- `shell_reef`,
- `thermal_vent_field`,
- `wreck_shelf`,
- `pressure_locked_wreck`,
- `gulper_route`.

It should not change placement, scans, upgrades, predator behavior, resource selection, or UI.
