# Steam Visual Readiness Baseline Audit - 2026-07-03

Status: Task 1 evidence from `docs/planning/STEAM_VISUAL_READINESS_REWORK_FRAMEWORK_2026_07_03.md`.

Command:

```powershell
npm.cmd run test:area01-shell-captures
```

Result: passed. PowerShell blocked `npm` through `npm.ps1`, so the command was run through `npm.cmd`.

Evidence folder:

```text
test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/
```

Report:

```text
test-results/playwright-area01-shell/area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium/area01-shell-capture-evidence.md
```

## Summary

The automated Area 01 visual truth gate passed, but the current player-facing screenshots do not yet pass the Steam-demo visual bar.

The level is much better than the earlier uploaded critique in the left shelf and surface-entry views: terrain texture, cave edges, and surface-base art are now present. The remaining blockers are concentrated in two categories:

- player-facing HUD/status copy still exposes capture/debug language;
- right chamber and deep spine still read too sparse and rectangular compared with the best left-shelf view.

## Manual Scores

Scale: `0` blocker, `1` prototype pass, `2` Steam-demo baseline.

| Capture | Terrain | Composition | Art cohesion | HUD | Motion cues | Screenshot sell | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `area01-surface-entry.png` | 2 | 1 | 1 | 0 | 1 | 1 | Stronger ship/surface/reef read, but normal HUD shows `Debug review` status copy. |
| `area01-left-shelf-cave.png` | 2 | 1 | 1 | 0 | 1 | 1 | Best cave-wall read in the set; this is the local quality target for other regions. |
| `area01-right-shelf-pocket.png` | 1 | 1 | 1 | 0 | 1 | 1 | Readable pocket, but still more rectangular and flatter than left shelf. |
| `area01-central-drop.png` | 1 | 1 | 1 | 0 | 1 | 1 | Useful route framing, but still not rich enough for a Steam screenshot. |
| `area01-west-chamber.png` | 1 | 1 | 1 | 0 | 1 | 1 | Resource pocket reads, but broad water areas remain sparse. |
| `area01-right-chamber.png` | 0 | 1 | 1 | 0 | 1 | 0 | Main blocker: large rectangular negative space, thin wall read, and debug status copy. |
| `area01-deep-spine.png` | 0 | 0 | 1 | 0 | 1 | 0 | Main blocker: mostly blank water with weak place identity and debug status copy. |
| `area01-future-exit.png` | 1 | 1 | 1 | 0 | 1 | 1 | Quiet future-promise read, but not store-shot quality yet. |

## Blockers

- `status_debug_copy` is `true` in all player-facing Area 01 capture metadata because staged status text uses `Debug review: ...`.
- The right chamber capture still looks too close to a map/debug view: rectangular water volumes, sparse surrounding terrain density, and weak environmental identity.
- The deep spine capture is mostly empty water; it needs passive atmosphere, terrain framing, or a clearer route invitation.
- The HUD is functional but too dominant for Steam screenshots, especially when the objective/status card carries non-player-facing text.

## First Fixes Chosen

1. Replace Area 01 staged status text with player-facing route/status copy.
2. Add passive, source-derived water ambience inside large generated water cutouts so right/deep captures have more depth without changing topology or collision.

## Remaining Work After First Fixes

- Re-score the fresh Area 01 captures after the HUD/status and water-ambience changes.
- If right chamber and deep spine still score below `2` for terrain/composition, continue with source-derived rim/fill and localized dressing around those capture states.
- Run the broader HUD pass only after Area 01 status copy is clean; the active HUD still needs a full cockpit/survey skin pass before Steam-demo closeout.

## Loop 1 Result

Implemented the first targeted fixes from this audit:

- Area 01 staged status text now uses player-facing route copy instead of `Debug review` capture language.
- Large generated water cutouts now receive deterministic passive ambience: distant reef silhouettes, silt/current ribbons, depth veils, and suspended motes.
- The added ambience is tagged as passive background and does not add collision.

Verification after the loop:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm.cmd run test:area01-shell-captures
git diff --check
```

Result: all passed. The refreshed capture report was generated at `2026-07-03T01:10:17.525Z` and reported no automated capture blockers.

Manual review: surface entry and left shelf remain the strongest shots. Right chamber and deep spine are improved because debug text is gone and blank-water space now has subtle depth structure, but both still need another art/composition pass before they should be treated as Steam-demo screenshots.

## Loop 2 Result

Implemented a second targeted visual pass:

- Long generated water corridors now receive deterministic passive breakup: low-alpha reef shadows and faint depth seams for both horizontal and vertical cutouts.
- The active HUD panel style now uses lighter cockpit-glass opacity, softer shadowing, and quieter borders so it no longer reads as heavy black debug boxes.
- Corridor breakup is tested as visual-only and collision-free.

Verification after the loop:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm.cmd run test:area01-shell-captures
```

Result: all passed. The refreshed capture report was generated at `2026-07-03T01:28:44.163Z` and reported no automated capture blockers.

Manual review: right chamber and deep spine read less empty, and the HUD sits back more cleanly over the world. This is still not a Steam-ready visual baseline because the weak shots remain mostly environmental atmosphere plus UI, not strong store-screenshot compositions. Next pass should add localized place identity: recognizable chamber silhouettes, cave-mouth frames, and a clearer reward/route focal point in the right chamber and deep spine.
