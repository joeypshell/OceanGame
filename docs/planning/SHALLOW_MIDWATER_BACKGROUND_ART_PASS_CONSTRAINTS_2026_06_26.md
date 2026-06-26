# Shallow/Midwater Background Art-Pass Constraints - 2026-06-26

Status: planning artifact for issue #292.

## Purpose

Define constraints for a first shallow/midwater background source-art study.

This pass should improve first-run depth and mood readability while staying behind gameplay cues.

## Allowed

- One source/export/provenance background study or small matched set.
- Shallow/midwater silhouettes, soft reef shapes, distant kelp/coral, and atmospheric depth separation.
- Subtle color/value variation that supports depth-band identity.
- Minor scene wiring as background support only.

## Contrast Rules

Background must stay lower priority than:

- player sub,
- oxygen/base/cargo/scan HUD,
- resources,
- scan markers,
- safe-return cues,
- pressure gate,
- Wreck Signal Cache/Echo Lens pulse,
- predator warning lane and Gulper sprite,
- Shell Reef/Thermal Vent landmark reads.

Avoid saturated red, lime, hot cyan, or bright yellow accents that could be mistaken for danger, reward, scan, pressure, or mystery cues.

## Preserve

- Gameplay nodes and spawn points.
- Existing depth bands and route layouts.
- Resource pickup positions and visibility.
- Scan target selection and markers.
- Safe return readability.
- Predator and pressure-route readability.
- HUD mode separation.
- Save/load and progression behavior.

## Avoid

- Broad parallax system.
- New biome or region.
- New resource/predator/route.
- Procedural background generation.
- Foreground obstruction.
- Production-art lock.
- Moving gameplay nodes into visual background groups.

## Future Implementation Acceptance

A future wiring issue should require:

- source/export/provenance files,
- Godot import if assets are added,
- Godot headless launch,
- logic tests if scene contracts change,
- normal-scale review against gameplay cues,
- `git diff --check`.
