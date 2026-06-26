# Pressure Wreck/Cache Source-Art Shell Constraints V2 - 2026-06-26

Status: planning artifact for issue #309.

## Purpose

Define the implementation constraints for the selected pressure wreck/cache environment shell source-art pass.

This is not a request to implement `Wreck Echo Descent`, change route behavior, or replace the current pressure/cache interaction model. It is a tighter contract for a future visual shell issue.

## Current Scene Ownership

| Concept | Current Owner | Must Stay Separate |
| --- | --- | --- |
| Wreck shell and surrounding mood | `PressureLockedWreck/Visuals`, `PressureWreckVisuals.tscn` | Environment silhouette and atmosphere only. |
| Pressure access state | `PressureGateVisuals`, lock/open badge, pressure boundary handling | The gate still communicates blocked/open state. |
| Outside clue | `PressureLockedWreck/OuterScan` | A scannable clue, not a reward, route marker, or cache. |
| Cache payoff | `PressureLockedWreck/WreckSignalCache` | Local payoff after pressure access, not a global objective marker. |
| Echo Lens feedback | `WreckSignalCache/EchoPulse` | Temporary broad echo feedback, not exact navigation. |
| Predator danger | `Predators/GulperEel`, warning lane, patrol/chase state | Avoidable route pressure, not wreck loot or combat. |
| Future deeper promise | planning docs only | `Wreck Echo Descent` remains unimplemented. |

## Allowed Work

A future implementation issue may:

- add one source/export/provenance asset or a small matched set for the pressure wreck/cache environment shell,
- wire the art under existing pressure wreck/cache visual ownership,
- replace or reduce `PressureWreckVisuals.tscn` fallback hull, keel, broken bow, interior shadow, promise glow, signal halo, and nearby shell atmosphere if the new shell reads more clearly,
- tune local alpha, z-order, scale, and silhouette around the wreck shell,
- frame the gate, outside scan, and cache alcove as related but visually distinct areas,
- add or update normal-scale screenshot evidence for locked gate, outside scan, open gate, cache, Echo Lens pulse, and predator-overlap states.

## Preservation Rules

The pass must preserve:

- pressure boundary collision and denial behavior,
- `Pressure Seal I` upgrade ownership,
- locked/open pressure-gate readability,
- outside scan behavior and pressure-route clue copy,
- Wreck Signal Cache scan and repeat-scan behavior,
- Echo Lens broad/local/no-locator feedback rules,
- Gulper patrol, warning, chase, contact, decoy, and scan behavior,
- all player movement, oxygen, cargo, extraction, save/load, and progression rules,
- existing spawn points and route layout.

## Visual Hierarchy Rules

The environment shell should support the hierarchy below:

1. player sub and oxygen/HUD state,
2. predator danger and safe-return cues,
3. pressure gate locked/open state,
4. outside scan clue and Wreck Signal Cache,
5. Echo Lens pulse during its temporary feedback window,
6. background mood, hull silhouette, and wreck texture.

Preferred treatment:

- large calm hull mass,
- fewer bright polygon fragments,
- cooler wreck metal and interior shadow,
- gate frame with readable negative space,
- cache alcove separated by a small local glow,
- pressure-dark atmosphere kept behind the gate/cache rather than ahead of them,
- predator lane visually adjacent but not fused into the wreck silhouette.

Avoid:

- a new bright beacon,
- route arrows,
- minimap-like geometry,
- icon-only gate/cache shapes,
- text inside the world art,
- art that makes the cache look reachable before the gate opens,
- art that makes the predator read as wreck decoration,
- brightening gate, cache, Echo Lens pulse, reward lure, and predator lane all at once.

## Explicit No-Go Scope

Do not implement or imply:

- `Wreck Echo Descent`,
- a new route pocket,
- new pressure-dark collision or denial zones,
- a new scan target,
- a new resource, reward, upgrade, predator, biome, or procedural rule,
- exact locator behavior,
- minimap, route graph, field guide, quest log, objective checklist, or persistent marker,
- pressure bypasses or shortcuts around `Pressure Seal I`, `Signal Lens I`, `Echo Lens I`, oxygen margin, cargo choices, or safe return.

## Acceptance For Future Implementation

A future implementation issue should require:

- source file, runtime export, and provenance note,
- scene wiring under the existing pressure wreck/cache visual slot,
- no gameplay behavior changes,
- normal-scale evidence for locked gate, outside scan, open gate, cache, Echo Lens pulse, and predator-overlap states,
- Godot headless launch,
- logic tests if any scene contract, helper, signal, scan, or route behavior changes,
- MCP context self-test if docs or context resources change,
- `git diff --check`.

## Relationship To Earlier Plans

This v2 plan promotes the earlier backup constraints into the selected next source-art contract after the background readability review. `study_pressure_dark_threshold_v1` remains an unwired future-reference asset and should not be used in this pass unless a later issue explicitly reopens pressure-dark threshold scope.
