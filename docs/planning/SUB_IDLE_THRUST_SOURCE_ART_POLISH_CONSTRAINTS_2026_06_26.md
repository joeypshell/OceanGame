# Sub Idle/Thrust Source-Art Polish Constraints - 2026-06-26

Status: planning artifact for issue #289.

## Purpose

Define constraints for a future player-sub idle/thrust source-art polish pass.

This is not an implementation issue and does not authorize a full animation system.

## May Tune Or Replace

- `IdleBubble` visual treatment.
- `BubbleTrail` visual treatment.
- `ThrustFlare` visual treatment.
- `NoseLight`/scanner visual support.
- `VisualRoot/SubSpriteAnchor` source-art organization if it remains behavior-neutral.
- Source/export/provenance files for small visual effects.

## Must Preserve

- Player movement acceleration/drag.
- Collision shape and physics root.
- Camera follow behavior.
- Facing rule: flip only `VisualRoot`, not the physics root.
- Burst Thruster input, oxygen cost, cooldown, direction, and denial rules.
- World bounds.
- Save/load and progression state.

## Avoid

- Full animation-state-machine scope.
- New movement physics.
- New oxygen rules.
- Particle systems that obscure resources, scan targets, pressure gates, or predators.
- Double-direction sprite frames.
- Combat/weapon thrust language.
- Replacing gameplay nodes with art-only nodes.

## Acceptance For A Future Implementation Issue

A future implementation issue should require:

- source/export/provenance files for any new assets,
- normal-scale idle, moving, thrust, and facing review,
- Godot headless launch,
- logic tests if scene contracts or visual-facing behavior change,
- `git diff --check`.
