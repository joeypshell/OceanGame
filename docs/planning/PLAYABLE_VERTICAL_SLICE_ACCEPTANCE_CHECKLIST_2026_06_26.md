# Playable Vertical-Slice Acceptance Checklist - 2026-06-26

Status: formal acceptance checklist, refreshed through issue #340.

This defines the first playable vertical slice. It is a player-facing quality gate for the current prototype, not a final-game feature list or production-art lock.

Related docs:

- `docs/current/ROADMAP.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/SOLO_FIRST_RUN_READABILITY_RESULT_2026_06_26.md`
- `docs/planning/VERTICAL_SLICE_ACCEPTANCE_EVIDENCE_BUNDLE_2026_06_26.md`
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

## Current Acceptance Status

Updated after the latest compact HUD, pressure shell, lower-route, Decoy/Gulper, Wreck Echo planning and handoff, resource/scan, low-oxygen, upgrade, scanner-distinction, durable-progression, clean demo, surface-panel contrast, debug hidden-state, Playwright visual smoke, and MCP context refresh reviews: the current slice is accepted as structurally playable and ready for `Wreck Echo Preparation And Slice Polish`, but not final production polish.

It remains pass-with-watchlist because future visual changes can reintroduce lower-route, surface-panel, or HUD confusion, so this status should remain conservative.

This is internal development evidence, not blind validation.

| Area | Status | Evidence | Remaining Watchlist |
| --- | --- | --- | --- |
| Core loop | Pass | Clean-save two-expedition smoke, solo first-run result, compact evidence bundle | Keep normal play-feel checks when art, HUD, or route density changes. |
| Ready screen | Pass with watchlist | Solo first-run result, surface ready/result reviews, final compact HUD review, surface panel contrast review | Recheck only if boat scale, waterline placement, panel opacity, background art, or copy changes. |
| Active dive | Pass with watchlist | Active HUD review, compact HUD placement, low/critical oxygen review, final compact HUD evidence bundle | Fixed top-left HUD can cover incidental left-side art; do not expand UI to solve this yet. |
| Pickup/scan | Pass with watchlist | Evidence bundle, scanner/resource tests, Signal Lens/Echo Lens review, resource/scan affordance review | New resource/scan source-art is deferred unless future evidence shows concrete confusion. |
| Return/failure | Pass with watchlist | Clean-save smoke, result memory review, solo first-run result, durable progression/reset review | Maintain the distinction between durable progress and temporary active-dive state. |
| Upgrade view | Pass with watchlist | Upgrade bay review, Up/Down affordance tune, normal-scale affordance review, evidence bundle | Recheck if more upgrades are added or copy grows longer. |
| Blocked route | Pass with watchlist | Pressure wreck/cache reviews, pressure shell normal-scale review, lower-route shell recheck, evidence bundle | `Wreck Echo Descent` remains deferred until a separate implementation issue proves route readiness. |
| Danger route | Pass with watchlist | Gulper route danger review, Decoy Pulse smoke, Decoy/Gulper follow-up reviews, evidence bundle | Preserve mistimed-contact risk and avoid combat/capture/loot framing. |
| Optional clue route | Pass with watchlist | Thermal Vent, Shell Reef, Wreck Signal Cache, condition visuals, and evidence bundle | Keep condition visuals and mystery signals presentation-first. |
| No locator/checklist drift | Pass | Echo Lens pulse recheck, Signal/Echo distinction review, no-locator tests/docs | Recheck if Wreck Echo route or scanner copy changes. |

Accepted or cleared:

- clean-save two-expedition loop,
- active `Discoveries` compact HUD placement,
- surface moonpool/waterline readability as pass-with-watchlist,
- surface panel opacity over the boat/waterline pass,
- upgrade-tab wrapping at normal scale,
- normal no-debug surface views,
- pressure wreck/cache recheck after surface/HUD changes,
- condition visual normal-scale review,
- Decoy Pulse result-memory and HUD smoke note,
- Echo Lens cache pulse local/no-locator recheck,
- result and upgrade text-length guard coverage.
- solo first-run clean-save checklist result,
- compact acceptance evidence bundle.

Remaining before declaring the gate fully polished:

- continued lower-route, surface-panel, and active-HUD watchlist after any future visual change.

Deferred:

- future `Wreck Echo Descent` implementation,
- larger biome set,
- broad economy, audio, web export, base-management, and production-art polish.

Handoff status:

- `docs/planning/POST_CLOSEOUT_WRECK_ECHO_HANDOFF_STATUS_2026_06_26.md` confirms the handoff into Wreck Echo preparation while keeping the current slice pass-with-watchlist.
- Future Wreck Echo work remains narrow: one deeper-right route pocket, one compact research clue, no locator/checklist/minimap/field-guide/combat/broad-biome scope, and required normal-scale evidence before runtime implementation can close.

Out of scope for this gate:

- minimap, route graph, exact scanner locator, field-guide UI, quest log, objective checklist,
- weapons, predator harvesting, predator health, capture, combat rewards,
- full procedural ocean, daily challenge calendar, inventory grid, or tech tree UI.
