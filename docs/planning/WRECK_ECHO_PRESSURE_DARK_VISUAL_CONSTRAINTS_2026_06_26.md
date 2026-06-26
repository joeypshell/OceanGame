# Wreck Echo Pressure-Dark Visual Constraints - 2026-06-26

Status: planning artifact for issue #347. No pressure-dark art is wired into runtime.

## Decision

Pressure-dark visuals may support a future `Wreck Echo Descent` pocket only as subdued atmosphere and threshold mood.

They must stay below:

1. oxygen and critical return warnings,
2. safe-return/base direction,
3. predator danger and warning lane,
4. pressure gate lock/open state,
5. Wreck Signal Cache and temporary Echo Lens pulse,
6. player sub readability.

The existing `study_pressure_dark_threshold_v1` remains an unwired reference asset. Do not add it to `Main.tscn` until a future Wreck Echo implementation issue explicitly authorizes route art and screenshot acceptance.

## Allowed Visual Language

Allowed for a future authorized Wreck Echo pocket:

- dark cyan/navy pressure wash,
- low-contrast wreck-shelf silhouette,
- faint edge glow or silt shimmer,
- narrow threshold shadow behind the route pocket,
- small local echo glints that disappear or remain subdued,
- negative space that suggests depth without pointing to exact coordinates,
- cooler palette than deep reward lures and predator warnings.

The visual should say:

> This area feels deeper, stranger, and worth caution.

It should not say:

> Here is the objective marker.

## Forbidden Signals

Do not use:

- bright beacon or route pin,
- arrow, chevron, compass, or minimap-like shape,
- exact line from cache to route,
- persistent pulse after the scan/result moment,
- numbered markers,
- text embedded in world art,
- red/orange danger language that competes with the predator,
- yellow/green reward language that competes with cargo/reward lures,
- lock/badge language that competes with the pressure gate,
- field-guide, quest, checklist, or objective iconography.

## Priority Rules

If pressure-dark art competes with any of these, dim or remove the pressure-dark art first:

- low or critical oxygen warning,
- base return direction,
- extraction zone,
- Gulper warning lane or predator body,
- pressure gate lock/open badge,
- outside scan target,
- Wreck Signal Cache,
- player sub silhouette.

Pressure-dark atmosphere should never be the loudest thing on screen.

## Relationship To Existing Assets

Current reference files:

- `assets/source/sprites/study_pressure_dark_threshold_v1.svg`,
- `assets/exports/sprites/study_pressure_dark_threshold_v1.svg`,
- `assets/licenses/study_pressure_dark_threshold_v1.txt`.

These remain planning/reference assets only. They are not:

- gameplay nodes,
- route markers,
- collision,
- scan targets,
- pressure zones,
- rewards,
- persistent objectives.

## Future Implementation Acceptance

If a future issue wires pressure-dark visuals, require:

- explicit route-pocket ownership,
- no new gameplay state from the visual scene,
- alpha/z-order review against HUD, return, predator, pressure gate, cache, and player,
- normal-scale screenshot or Playwright evidence before and after clue interaction,
- no pressure bypass from `Echo Lens I`,
- no route art before route behavior is actually scoped.

## Current Scope

This document changes no scenes, assets, scripts, tests, route behavior, collision, scan targets, pressure zones, or runtime visuals.
