# Region Identity Map V1

Status: planning output for issue #169.

## Purpose

OceanGame needs remembered places before it needs a map. This plan defines the first stable region and landmark identity layer so changing expedition days feel like variations inside a coherent ocean instead of disconnected random layouts.

This plan does not add a minimap, region-select screen, quest checklist, or procedural biome system.

## Memory Goals

Players should be able to say:

- the surface base is safe and always above me,
- Shell Reef is the safer midwater bank route,
- Thermal Vent Field is an optional warm clue route for pressure knowledge,
- Wreck Shelf is the blocked promise that becomes a return payoff,
- Gulper Route is a learnable predator timing lane,
- deeper water is not just harder; it is where unresolved signals and future mysteries live.

## First Region/Landmark Set

| Memory layer | Current metadata id | Player-facing name | Role | Stable memory | Daily variation |
| --- | --- | --- | --- | --- | --- |
| Safe hub | `surface_base` | Surface Base | Start, extraction, upgrades, result review, next expedition briefing. | Safety, return direction, moonpool/lab silhouette. | Condition briefing and what the next useful goal emphasizes. |
| Midwater bank route | `shell_reef` | Shell Reef | First remembered midwater landmark and safer shell banking route. | Pale shell/coral shelf, return-current cue, safer bank decision. | Which shell candidate is active and how return-current emphasis reads. |
| Optional clue route | `thermal_vent_field` | Thermal Vent Field | Warm-current pocket, pressure knowledge, optional glow temptation. | Warm vent silhouette, bubbles, heat plume, Pressure Seal knowledge. | Thermal Bloom emphasis and vent-adjacent glow selection. |
| Blocked promise | `wreck_shelf` | Wreck Shelf | Pressure-locked promise and future scanner/wreck payoff space. | Rusted wreck silhouette, pressure gate, outside scan clue. | Wreck Shift or future rare signal can emphasize approach/cache angle. |
| First access gate | `pressure_locked_wreck` | Pressure-Locked Research Wreck | Upgrade-gated route that proves returning later matters. | `LOCKED`/`OPEN` gate language and Wreck Signal Cache payoff. | Open/locked state depends on `Pressure Seal I`; future cache signal emphasis may vary. |
| Creature timing lane | `gulper_route` | Gulper Route | Non-combat monster research, predator timing, risk/reward route. | Red warning lane, Gulper patrol, scan/decoy learning. | Seeded route selection and future predator-migration presentation. |

## How This Supports One More Expedition

The player should start another expedition because a remembered place changed meaning:

- a prior scan makes a region more useful,
- an upgrade opens a blocked route,
- a condition changes a familiar landmark's opportunity,
- a predator route can be read better after research,
- a cache or echo points deeper without giving exact coordinates.

Region memory should show up through result lines, ready-panel copy, scan clues, stable landmark names, and visual landmarks. It should not require a map.

## What Varies Versus What Persists

Persists:

- place names,
- depth-band identity,
- safe-return orientation,
- major route promise,
- scan discovery identity,
- upgrade-gated access logic,
- predator as a learnable route pressure.

Varies:

- resource candidate choice,
- cluster pattern,
- condition presentation,
- predator route candidate,
- optional clue emphasis,
- future signal or cache emphasis.

## First Implementation Recommendation

Implement issue #170 next: add stable region names to landmark metadata and review copy.

Narrow acceptance for that issue:

- keep the current `LandmarkMetadata` nodes as passive scene data,
- tune player-facing copy so Shell Reef, Thermal Vent Field, Wreck Shelf, Pressure-Locked Research Wreck, and Gulper Route are named consistently,
- avoid minimap, region-select, checklist, or new gameplay rules,
- verify with documentation checks and logic tests only if formatter behavior changes.

