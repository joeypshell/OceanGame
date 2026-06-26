# Shallow/Midwater Background Study Wiring - 2026-06-26

Status: implemented for issue #293.

## What Changed

Added a first source/export/provenance background study:

- `assets/source/sprites/shallow_midwater_background_study_v1.svg`
- `assets/exports/sprites/shallow_midwater_background_study_v1.svg`
- `assets/licenses/shallow_midwater_background_study_v1.txt`

The study is wired into `scenes/Main.tscn` as `ShallowMidwaterBackgroundStudy` behind gameplay cues and existing route/readability helpers.

## Intent

The asset should add quieter depth-band mood and distant reef/kelp shapes in the shallow and midwater layers. It is not a route marker, interactable landmark, scan target, reward hint, pressure signal, predator warning, collision source, or objective.

## Preserved

- Player, spawn points, scan targets, pressure gate, predator route, resource pickup nodes, HUD nodes, and collisions are unchanged.
- Existing authored readability cues remain responsible for return direction, Shell Reef, Thermal Vent, pressure wreck/cache, rewards, and predator danger.
- The source/export/provenance convention from `VISUAL_REPLACEMENT_PLAN.md` is followed.

## Follow-Up Review

The next readability review should confirm the background stays quieter than:

- the player sub,
- active HUD and surface panels,
- resources and scan markers,
- safe-return cues,
- pressure gate and Wreck Signal Cache,
- predator warning lane and Gulper sprite,
- Shell Reef and Thermal Vent landmark reads.
