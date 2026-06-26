# Visual Asset Slot Review - 2026-06-26

Status: review note for issue #198 after resource and landmark visual extraction.

## Purpose

Review whether major gameplay-readable objects have consistent, replaceable visual slots after the recent player, surface base, resource, creature, predator, pressure gate, and thermal vent work.

This review does not replace any additional art. Larger visual replacements should become follow-up issues.

## Findings

| Target | Current Slot Structure | Review |
| --- | --- | --- |
| Player sub | `Player/VisualRoot/SubSpriteAnchor/SubSprite`, fallback polygons under `SubSpriteAnchor`, separate `NoseLight`, `BubbleTrail`, `ThrustFlare` | Replaceable and covered by tests. Slightly different from `FallbackVisual` naming, but acceptable because player uses a dedicated `VisualRoot` for facing/motion state. |
| Surface base / boat | `SurfaceBaseArt/ResearchBoatSprite`, fallback boat/moonpool polygons under `SurfaceBaseArt` | Replaceable and now covered by tests. This is the least standardized structure because it predates the `SpriteAnchor/FallbackVisual` pattern. Future work can split it into `SpriteAnchor` and `FallbackGeometry` if the base receives more art states. |
| Kelp Fiber | `ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/KelpFiberVisual.tscn` | Consistent reusable resource scene. Covered by tests. |
| Shell Fragments | `ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/ShellFragmentsVisual.tscn` | Consistent reusable resource scene. Covered by tests. |
| Glow Plankton | `ResourcePickups/*GlowPlankton/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/GlowPlanktonVisual.tscn` | Consistent reusable resource scene shared by visible/hidden/deep variants. Covered by tests. |
| Lantern Fry | `Creatures/LanternFry/SpriteAnchor/Sprite` plus `FallbackVisual` and separate `ScanMarker` | Consistent enough for a gameplay creature. Covered by tests. |
| Gulper Eel | `Predators/GulperEel/SpriteAnchor/Sprite` plus `FallbackVisual`, `PatrolHint`, and `ScanMarker` | Replaceable while preserving predator behavior/state visuals. Covered by tests. Future sprite work should preserve state tint/hint nodes. |
| Thermal Vent pocket | `ThermalVentPocket/Visuals/SpriteAnchor/Sprite` plus `FallbackGeometry` in `scenes/readability/ThermalVentPocketVisuals.tscn` | Good extracted landmark-readability scene. Covered by tests. |
| Thermal Vent scan target | `Discoveries/ThermalVent/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable pattern. Covered by tests. |
| Shell Reef pocket | `ShellReefPocket/SpriteAnchor/Sprite` plus `FallbackGeometry` | Consistent landmark pocket pattern. Covered by tests. |
| Shell Reef Shelf scan target | `Discoveries/ShellReefShelf/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable pattern. Covered by tests. |
| Pressure-Locked Research Wreck | `PressureLockedWreck/SpriteAnchor/Sprite` plus `FallbackGeometry`; pressure gate visuals extracted as child scene | Consistent landmark/gate pattern. Covered by tests. |
| Wreck outside scan target | `PressureLockedWreck/OuterScan/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable pattern. Covered by tests. |
| Wreck Signal Cache | `PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable/cache pattern. Covered by tests. |

## Standard To Preserve

For static landmarks:

```text
Target
  SpriteAnchor
    Sprite
  FallbackGeometry
```

For scannable or collectible gameplay nodes:

```text
Area2D
  SpriteAnchor
    Sprite
  FallbackVisual
  ScanMarker
  CollisionShape2D
```

For reusable extracted visuals:

```text
Visuals
  SpriteAnchor
    Sprite
  FallbackVisual or FallbackGeometry
```

The player may keep its dedicated `VisualRoot` because it owns facing/motion presentation. Surface base may keep `SurfaceBaseArt` for now, but should be standardized if it gains more animated/art states.

## Follow-Up Candidates

- Standardize `SurfaceBaseArt` into `SpriteAnchor` plus `FallbackGeometry` if future surface/base art work expands.
- Consider extracting `ShellReefPocket` into `scenes/readability/` if its geometry grows the way Thermal Vent did.
- Consider extracting `PressureLockedWreck` hull/cache visuals only after the pressure gate, cache, and Echo Lens direction stabilize.
- Add source/export/provenance assets for Lantern Fry, Gulper Eel, Thermal Vent, pressure wreck, and cache in separate visual replacement issues.

## Verification

Updated `tests/logic_tests.gd` to include player and surface base visual slot checks in the sprite-ready scene contract test. Existing tests already cover resource scenes, Lantern Fry, Gulper Eel, Thermal Vent, Shell Reef, pressure wreck, outside scan target, and Wreck Signal Cache paths.
