# Playable Vertical-Slice Acceptance Checklist - 2026-06-26

Status: checklist for issue #237.

This defines the first playable vertical slice. It is a player-facing quality gate for the current prototype, not a final-game feature list or production-art lock.

Related docs:

- `docs/current/ROADMAP.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md`

## Playable Criteria

- The game starts at a surface boat/lab ready state with a clear start prompt and no active-dive HUD clutter.
- Pressing E or Enter begins an expedition from the surface and starts oxygen pressure.
- The player can move, turn, dive, ascend, and use `Burst Thruster` without visual direction or collision confusion.
- Oxygen drains during active dives, low/critical oxygen states are readable, and oxygen failure clearly loses carried cargo while preserving durable progress.
- The player can collect cargo, see cargo capacity, return to base, extract, and see banked resources summarized.
- The player can scan at least one resource, one landmark clue, and one predator/creature target with compact, useful status feedback.
- The result flow makes another expedition feel intentional: day number advances, the ocean changes, useful discoveries are remembered, and the next dive can begin quickly.
- The upgrade bay lets the player inspect, understand, and buy at least one meaningful upgrade path from extracted resources or scan prerequisites.

## Visual Readability Criteria

- At normal scale, the player can identify the surface base, player sub, waterline, safe-return direction, depth band, collectible resource, scan target, pressure lock, cache, predator danger, and result state without reading every line of text.
- Surface ready/result panels own their screens; loose operational HUD rows stay hidden until active diving.
- Active diving uses a compact HUD that does not cover the player, route choices, or major scan targets.
- Color and shape language stays distinct: safe return, reward, scan, current hint, pressure lock, predator danger, biome landmark, and mystery signal should not read as the same object type.
- Pressure and mystery cues remain secondary to oxygen, safe return, and predator danger.
- The Wreck Signal Cache and Echo Lens cues suggest local curiosity, not exact coordinates, minimap markers, field-guide entries, or quest checklists.
- Sprite replacements improve recognition while fallback/readability geometry remains available until the art pass proves clear.

## Polished-Slice Criteria

- The slice should support a short repeatable loop: start expedition, make one risk/reward decision, return or fail, read the result, and choose whether to dive again.
- A cautious route should allow at least one successful extraction.
- A deeper route should tempt `Glow Plankton`, pressure-wreck curiosity, or predator-adjacent reward without feeling visually unfair.
- The player should understand one blocked promise before owning the upgrade, then understand that the route opens after the right upgrade.
- The predator route should read as avoidable risk first, not random damage.
- Expedition conditions may add mood or slight authored variation, but they must not imply unavailable mechanics.
- Result memory should acknowledge useful discoveries or route choices without becoming a quest log.

## Current Slice Upgrade And Route Coverage

The first slice is acceptable when the current prototype can demonstrate these promises in a small loop:

- `Oxygen Tank I`: cargo-bank pressure and longer-run payoff.
- `Pressure Seal I`: scan-gated route opening.
- `Signal Lens I`: practical scanner improvement from the Wreck Signal Cache chain.
- `Echo Lens I`: broad wreck curiosity, not exact tracking.
- `Cargo Rack I`: simple capacity expansion without inventory management.
- `Predator Warning I`: safer predator reading through preparation.
- `Decoy Pulse I`: one-use non-lethal predator counterplay.
- Shell Reef, Thermal Vent, pressure wreck, Wreck Signal Cache, and Gulper route all remain identifiable as different kinds of places.

## Non-Goals For This Gate

- No final production-art lock.
- No full procedural ocean generation.
- No minimap, exact locator, field guide, objective checklist, or region-select screen.
- No broad crafting economy, cargo grid, base management, or restaurant/colony layer.
- No weapons, predator harvesting, capture systems, or combat loop.
- No expanded biome set beyond the current authored slice.
- No new daily challenge or real-calendar system.

## Verification Bundle

Run automated checks for changes that affect this gate:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
```

Manual smoke checks for acceptance:

- Surface ready: confirm the boat/lab, start prompt, condition, and goal line are readable with debug telemetry hidden.
- Normal dive: start, collect or scan one thing, use `Burst Thruster`, and return.
- Low oxygen: confirm warning urgency rises without hiding base direction.
- Pressure route: confirm the locked route denies before `Pressure Seal I` and reads open after ownership.
- Predator route: confirm warning/counterplay reads before contact.
- Result flow: confirm extracted cargo, scan memory, route choice, upgrade progress, and next-expedition prompt are scannable.

## Acceptance Summary

The vertical slice is playable when a tester can complete two short expeditions, buy or clearly progress toward one upgrade, understand one blocked route, understand one danger route, notice one optional clue route, and want to try another expedition without being overwhelmed by overlapping text or unreadable shapes.
