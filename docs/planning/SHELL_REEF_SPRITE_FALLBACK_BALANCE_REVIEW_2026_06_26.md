# Shell Reef Sprite/Fallback Balance Review - 2026-06-26

Status: review artifact for issue #245.

## Scope

Reviewed whether the Shell Reef source-art sprites and fallback geometry are balanced for normal-scale readability.

Related docs:

- `docs/planning/SHELL_REEF_ROUTE_REVIEW_2026_06_25.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scenes/readability/ShellReefPocketVisuals.tscn`
- `scenes/Main.tscn`
- local screenshot capture: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_shell_reef_review_2026_06_26/oceangame_shell_reef_balance_review_2026_06_26.png`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshot remains local and is not committed as a source asset.

## Current Read

Shell Reef currently reads as a midwater banking landmark and scan target. The player-facing scan target label can select `Shell Reef Shelf`, and the reef area still communicates "safer route before deeper pressure/predator risk."

The fallback geometry is doing most of the recognitional work:

- broad `LandmarkWash`,
- dark `ReefShelf`,
- warm `ShellBedHighlight`,
- shell fan silhouettes,
- pale return-current shapes.

The source/export Shell Reef pocket sprite helps the region feel less purely geometric, but at normal scale it is partially buried by the fallback wash, shell fans, HUD, and nearby route cues.

## Keep Visible

- `ReefShelf`: keep as the broad ground silhouette. It anchors the route and keeps the reef from reading like a floating pickup.
- `LandmarkWash`: keep, but watch opacity during future art integration. It helps identify the pocket as a place rather than a single object.
- `ReefReturnCurrent` and `ReefReturnBeacon`: keep. They support the Shell Reef promise as a safer return/banking route.
- `Shell Reef Shelf` source sprite and scan marker: keep available because the scan target needs a distinct local object, not only a background landmark.

## Subdue Or Review Later

- `ShellFanA`, `ShellFanB`, and ribs: useful as fallback language, but they compete with the source sprite when all are bright. Review whether their alpha should drop after the source sprite becomes stronger.
- `CoralShardA` and `CoralShardB`: keep for biome flavor, but they should not become as bright as resources or scan targets.
- `ShellBedHighlight`: keep now, but re-check after lower-route density cleanup and HUD placement fixes.

## Deferred

- Do not remove fallback geometry yet. It still carries route readability.
- Do not add new Shell Reef mechanics, collision, resource count, or route rules in this review.
- Do not replace the whole pocket with final art before a broader vertical-slice art integration pass.

## Recommendation

Pass with watchlist.

For the next Shell Reef visual pass, strengthen the authored sprite/scan-target read first, then lower the brightest shell-fan fallback pieces only if the reef still reads as a place and the return-current cue remains obvious. The goal is not less reef; it is clearer hierarchy: place silhouette first, scan target second, decorative shell detail third.
