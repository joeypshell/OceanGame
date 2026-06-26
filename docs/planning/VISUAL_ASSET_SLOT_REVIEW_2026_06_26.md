# Visual Asset Slot Review - 2026-06-26

Status: review note for issue #198 after resource and landmark visual extraction.

## Purpose

Review whether major gameplay-readable objects have consistent, replaceable visual slots after the recent player, surface base, resource, creature, predator, pressure gate, and thermal vent work.

This review does not replace any additional art. Larger visual replacements should become follow-up issues.

## Findings

| Target | Current Slot Structure | Review |
| --- | --- | --- |
| Player sub | `Player/VisualRoot/SubSpriteAnchor/SubSprite`, fallback polygons under `SubSpriteAnchor`, separate `NoseLight`, `BubbleTrail`, `ThrustFlare` | Replaceable and covered by tests. Slightly different from `FallbackVisual` naming, but acceptable because player uses a dedicated `VisualRoot` for facing/motion state. |
| Surface base / boat | `SurfaceBaseArt/SpriteAnchor/ResearchBoatSprite`, fallback boat/moonpool polygons under `SurfaceBaseArt/FallbackGeometry` | Standardized and covered by tests. `BaseZone` remains the separate gameplay extraction/start node. |
| Kelp Fiber | `ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/KelpFiberVisual.tscn` | Consistent reusable resource scene. Covered by tests. |
| Shell Fragments | `ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/ShellFragmentsVisual.tscn` | Consistent reusable resource scene. Covered by tests. |
| Glow Plankton | `ResourcePickups/*GlowPlankton/Visuals/SpriteAnchor/Sprite` plus `FallbackVisual` in `scenes/resources/GlowPlanktonVisual.tscn` | Consistent reusable resource scene shared by visible/hidden/deep variants. Covered by tests. |
| Lantern Fry | `Creatures/LanternFry/SpriteAnchor/Sprite` using `assets/exports/sprites/creature_lantern_fry_sprite_v1.svg`, plus `FallbackVisual/Glow` and separate `ScanMarker` | First source/export sprite is wired. Body fallback is hidden while glow fallback remains active for idle pulse. Covered by tests. |
| Gulper Eel | `Predators/GulperEel/SpriteAnchor/Sprite` using `assets/exports/sprites/creature_gulper_eel_sprite_v1.svg`, plus `FallbackVisual`, `PatrolHint`, and `ScanMarker` | First source/export sprite is wired while preserving fallback state tint/hint overlays. Covered by tests. Future sprite work should preserve state tint/hint nodes. |
| Thermal Vent pocket | `ThermalVentPocket/Visuals/SpriteAnchor/Sprite` plus `FallbackGeometry` in `scenes/readability/ThermalVentPocketVisuals.tscn` | Good extracted landmark-readability scene. Covered by tests. |
| Thermal Vent scan target | `Discoveries/ThermalVent/SpriteAnchor/Sprite` using `assets/exports/sprites/landmark_thermal_vent_sprite_v1.svg`, plus `FallbackVisual`, `ScanMarker`, and collision | First source/export sprite is wired while preserving optional-route fallback and bubble readability. Covered by tests. |
| Shell Reef pocket | `ShellReefPocket/Visuals/SpriteAnchor/Sprite` plus `FallbackGeometry` in `scenes/readability/ShellReefPocketVisuals.tscn` | Good extracted landmark-readability scene. Covered by tests. |
| Shell Reef Shelf scan target | `Discoveries/ShellReefShelf/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable pattern. Covered by tests. |
| Pressure-Locked Research Wreck | `PressureLockedWreck/SpriteAnchor/Sprite` plus `FallbackGeometry`; pressure gate visuals extracted as child scene | Consistent landmark/gate pattern. Covered by tests. |
| Wreck outside scan target | `PressureLockedWreck/OuterScan/SpriteAnchor/Sprite` plus `FallbackVisual`, `ScanMarker`, and collision | Consistent scannable pattern. Covered by tests. |
| Wreck Signal Cache | `PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite` using `assets/exports/sprites/wreck_signal_cache_sprite_v1.svg`, plus `FallbackVisual`, `ScanMarker`, and collision | First source/export cache sprite is wired while preserving fallback glow and scan behavior. Covered by tests. |

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

The player may keep its dedicated `VisualRoot` because it owns facing/motion presentation. Surface base now follows the `SpriteAnchor` plus `FallbackGeometry` pattern.

## Follow-Up Candidates

- Shell Reef pocket extraction is complete; future work should focus on a source/export art replacement once the landmark composition is stable.
- Consider extracting `PressureLockedWreck` hull/cache visuals only after the pressure gate, cache, and Echo Lens direction stabilize.
- Add source/export/provenance assets for Lantern Fry, Gulper Eel, Thermal Vent, pressure wreck, and cache in separate visual replacement issues.

## Verification

Updated `tests/logic_tests.gd` to include player, surface base, and extracted Shell Reef pocket visual slot checks in the sprite-ready scene contract test. Existing tests also cover resource scenes, Lantern Fry, Gulper Eel, Thermal Vent, pressure wreck, outside scan target, and Wreck Signal Cache paths.
