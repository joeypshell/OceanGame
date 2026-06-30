# Area 01 Visual Reference Comparison

Date: 2026-06-30

Status: planning evidence for issue #678. This report compares the current playable Area 01 captures against the uploaded underwater reference direction. It does not add gameplay promises, new art scope, route objectives, scanner locators, resources, or progression rules.

## Evidence Sources

Refreshed local captures:

- `test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-surface-entry.png`
- `test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-right-shelf-pocket.png`
- `test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-right-chamber.png`
- `test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-deep-spine.png`
- `test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-source-map-overlay.png`

Reference direction, summarized from the uploaded image and later map-planning discussion:

- Side-view underwater play space with an open surface, layered reef/cave masses, resource pockets, fish/life, and visible depth.
- Compact edge HUD with oxygen/depth/cargo/base-needs/tool information separated into readable instruments.
- Player/sub/diver remains the focal point through light, silhouette, and nearby opportunity contrast.
- Cargo, scan targets, locks, and knowledge payoffs should be readable without relying on long labels.

## Closer To Reference

| Area | Current evidence | Read |
| --- | --- | --- |
| HUD structure | Active captures now show oxygen/health/depth at top-left, cargo at top-center, daylight at top-center/right, base needs at top-right, tool belt, objective card, depth rail, and minimap. | Much closer to the reference composition. |
| Day budget | The sun-to-moon `DAYLIGHT` bar is visible during active play. | Matches the requested timer direction without replacing oxygen. |
| Player focal read | The diver now has a subtle local halo, forward nose-light cone, bubbles, thrust flare, and swim-sheet motion. | Better focal hierarchy, especially around nearby cargo/scan targets. |
| Terrain readability | Runtime-v3 Area 01 source-map terrain, generated walls, rims, reef/platform kits, parallax, and lighting give larger solid masses and cave openings. | Closer to the source-map direction than the old small-room/blockout look. |
| Object language | Resource pickups, selected scan cards/reticles, cargo slots, survival supplies, knowledge cores, locks, and route cues have clearer color/opacity roles. | Sufficient for current prototype use. |

## Still Different

| Difference | Impact | Recommendation |
| --- | --- | --- |
| Art density remains lower than the reference screenshot. | The world is readable but less lush and less animated than the target. | Defer broad density. Add density only where a specific route/cargo read is too empty. |
| Terrain is source-map-correct but not final natural art. | The level finally matches the open-surface/seafloor/cave-hole plan, but rock surfaces still show kit/prototype repetition. | Keep source-map correctness as priority; replace terrain art in localized passes. |
| Player light is a subtle polygon cone, not a full shader/light system. | The player focal read improved without render or performance risk. | Keep for now. Upgrade only if future captures show the diver is lost in darker zones. |
| Scan/cargo glows still depend on prototype silhouettes. | They are understandable but not final asset quality. | Continue only through targeted sprite/source-art issues, not a broad polish batch. |
| The HUD is denser than the reference fantasy screenshot. | It supports current survival systems but can feel busier. | Do not remove survival information during the day/night loop. Tune only if overlap/readability evidence appears. |

## Decision

The visual direction is good enough to resume gameplay expansion. Area 01 now has the major reference-direction signals: open surface, visible day timer, separate survival instruments, broader cave geography, clearer terrain blockers, readable cargo/scan opportunities, and a player focal light.

Do not start another broad visual polish batch now. The next work should return to player-visible loop progress or source-map/runtime fixes that directly support repeated day sorties. Visual work should be issue-scoped to concrete evidence, such as a specific unreadable pickup, lost player silhouette, unclear cave opening, or route cue that competes with cargo.

## Verification

Commands used for this comparison pass:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs
npm.cmd run test:area01-shell-captures
git diff --check
```
