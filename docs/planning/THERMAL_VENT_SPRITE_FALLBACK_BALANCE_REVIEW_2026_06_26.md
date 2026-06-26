# Thermal Vent Sprite/Fallback Balance Review - 2026-06-26

Status: review artifact for issue #246.

## Scope

Reviewed whether the Thermal Vent source-art and fallback geometry are balanced for normal-scale readability.

Related docs:

- `docs/planning/THERMAL_VENT_ROUTE_REVIEW_2026_06_25.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/readability/ThermalVentPocketVisuals.tscn`
- `scenes/Main.tscn`
- local screenshot capture: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_thermal_vent_review_2026_06_26/oceangame_thermal_vent_balance_review_2026_06_26.png`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshot remains local and is not committed as a source asset.

## Current Read

Thermal Vent currently reads as a warm midwater/deep landmark and optional pressure-knowledge clue. It does not read as a mandatory objective path in the reviewed normal-scale capture.

The source-art vent sprite helps the scan target feel more authored, but the fallback pocket geometry still carries the place identity:

- `WarmWash` gives the pocket its thermal read,
- `CrackedShelf` and `VentMouthShadow` anchor it as a place,
- chimney shapes and plume core make it read as a vent,
- bubble strings and warm current ribbon communicate optional motion/heat.

## Keep Visible

- `CrackedShelf`, `VentMouthShadow`, and chimney silhouettes: keep. These make the vent a place rather than a floating icon.
- `WarmWash`: keep subdued. It gives the route a thermal identity without becoming a route arrow.
- `HeatPlume` and `HeatPlumeCore`: keep as the main optional-current clue.
- `BubbleStringA/B`: keep as flavor and motion, especially for `Thermal Bloom`.
- Thermal Vent source sprite and scan marker: keep as the local scan target.

## Subdue Or Review Later

- `WarmCurrentRibbon`: keep low opacity. If brightened, it risks becoming a hard path arrow.
- `VentRimGlow`: useful, but should not be brighter than the scan target or hidden `Glow Plankton` reward.
- Thermal Bloom emphasis should stay a presentation modifier, not a promise of extra mechanics beyond existing authored glow weighting.

## Deferred

- Do not remove fallback geometry yet. The sprite alone does not carry enough place identity.
- Do not add new vent resources, oxygen refills, damage, heat mechanics, or safe-route guarantees in this review.
- Do not make Thermal Bloom imply a new biome or procedural event.

## Recommendation

Pass with watchlist.

For the next Thermal Vent visual pass, keep the shelf/mouth/chimney/plume fallback stack while testing whether the source sprite can become the main scan-target read. The pocket should continue to say "optional pressure knowledge if oxygen allows," not "mandatory route" or "guaranteed safe path."
