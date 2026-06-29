# Area 01 Skeleton Validation

Date: 2026-06-28

## Decision

Needs one more level-bones pass before broad visual polish.

Area 01 is no longer failing in the same way as the earlier playtests: the source map exists, the debug overlay exists, the reported invisible clamp/resource-in-wall class has targeted tests, and cave-mouth/opening language is clearer. But the captured shell still reads like a short decorated room rather than a first explorable zone. The next best step is to expand the authored blockout into a larger multi-screen first area before spending more issue cycles on ambient life, final visual comparison, or broad polish.

## Evidence Reviewed

Targeted captures from the existing Area 01 Playwright flow:

- `C:\Users\pirat\OneDrive\Documents\OceanGame\test-results\playwright-area01-shell\area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium\area01-surface-entry.png`
- `C:\Users\pirat\OneDrive\Documents\OceanGame\test-results\playwright-area01-shell\area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium\area01-left-shelf-cave.png`
- `C:\Users\pirat\OneDrive\Documents\OceanGame\test-results\playwright-area01-shell\area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium\area01-right-shelf-pocket.png`
- `C:\Users\pirat\OneDrive\Documents\OceanGame\test-results\playwright-area01-shell\area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium\area01-central-drop.png`
- `C:\Users\pirat\OneDrive\Documents\OceanGame\test-results\playwright-area01-shell\area01-shell-captures-Ocea-c787f-ive-first-room-shell-states-chromium\area01-source-map-overlay.png`

## What Is Working

- HUD and scan cards are compact enough that they no longer carry all scene comprehension.
- Player, cargo, and nearby scan targets are readable at normal capture scale.
- Terrain lips and cave-mouth affordances make some openings more legible than the previous flat blockout.
- The source-map contract and tests now catch several earlier classes of invisible blockers and embedded pocket placements.
- The current skeleton can support targeted visual work, but only after the playable footprint grows.

## What Is Not Ready

- The first zone still feels compressed: the visible play space is closer to one authored shell than a map with multiple lanes.
- Several reef/background layers still overlap in a way that makes foreground terrain and distant shapes compete.
- Resource pockets hint at movement, but the player does not yet get enough side-to-side/downward route learning to form a strong next-run hypothesis.
- The minimap/captures show the same tight footprint repeatedly; this is a level-size problem before it is an art-polish problem.

## Issue Decisions

- #675 is kept but deferred. It should become useful after the next blockout expansion, when pickup/interactable language can be applied across a larger area.
- #676 is deferred. Ambient life and particles would make the current shell busier before the core lanes are large and readable enough.
- #677 is kept but deferred/narrowed. Player focal lighting remains valuable, but should support the larger blockout rather than polish the current tight room.
- #678 is deferred. A target-screenshot comparison should happen after the larger first-zone skeleton and the focused object/focal-light passes, not before.
- #697 was opened as the next active level-bones issue: expand Area 01 into a multi-screen blockout.

## Next Order

1. #697: expand Area 01 into a larger multi-screen blockout.
2. Re-evaluate #675 and #677 as focused readability/visual-support issues.
3. Defer #676 and #678 until the larger skeleton has enough area to judge ambience and comparison honestly.
4. Keep architecture issues behind player-visible level progress unless a refactor directly lowers implementation risk for the next blockout pass.

## Verification

- `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick` passed before this report.
- `npm.cmd run test:area01-shell-captures` passed before this report.
- `git diff --check` should pass with this report and roadmap update.
