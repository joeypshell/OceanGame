# Vertical-Slice Art Kit Screenshot Checklist - 2026-06-26

Status: checklist for issue #217.

Use this when the first cohesive vertical-slice art kit is integrated. This checklist does not require final art production now.

Readiness review: `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md` applies this checklist to the current normal-scale asset state and identifies the highest-priority gaps before a cohesive art integration pass.

Related docs:

- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/ASSET_SOURCE_PIPELINE_V1.md`
- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md`

## Capture Rules

- Use the normal player-facing viewport and default camera zoom unless a specific issue says otherwise.
- Hide debug telemetry before player-facing captures.
- Record seed, condition, cluster pattern, view state, screenshot path, and immediate pass/fail observation.
- Store local screenshots outside the repo unless an issue explicitly asks for committed reference images.
- Compare against the current prototype goal: a readable 60-second dive, not final production polish.

## Required Views

| View | What To Capture | Pass Criteria | Fail Criteria |
| --- | --- | --- | --- |
| Surface ready | Boat/lab, waterline, ready panel, condition, goal line | Boat/base reads as the start point; ready panel owns instructions; no operational HUD clutter overlaps it. | Boat is visually broken, panel text overlaps, or debug/prototype reset text appears in normal player view. |
| Shallow start | Player sub near base, shallow depth band, safe return column | Sub, base, waterline, and safe return are immediately identifiable. | Sub blends into base/water, safe return is hidden, or cargo/scan text dominates the scene. |
| Shallow resource | Kelp/resource pickup and scan target state | Resource reads as collectible and distinct from route hints or mystery signals. | Resource is confused with scan marker, reward lure, or background decoration. |
| Midwater Shell Reef | Shell Reef pocket, shell pickup, return current | Shell Reef reads as a remembered banking landmark and leaves return lanes clear. | Reef art obscures pickups, safe return, or creates false objective-arrow language. |
| Thermal Vent | Vent pocket, Thermal Vent scan target, optional current hint | Vent reads as warm optional pressure knowledge, not a mandatory hard route. | Vent glow/route art looks like a guaranteed safe path or overwhelms Shell Reef and pressure gate reads. |
| Pressure wreck locked | Locked gate, outside scan, safe-return context | Gate reads as blocked promise; outside scan reads as practical clue; no hidden damage implication. | Gate looks passable, dangerous like predator, or like a map objective marker. |
| Pressure wreck open/cache | Open gate, Wreck Signal Cache, cache signal | Open route reads passable; cache reads as local reward/mystery hook. | Cache signal implies exact coordinates, checklist objective, or a remote marker. |
| Predator route | Gulper Eel, warning lane, patrol hint, nearby reward | Predator danger is distinct from reward, pressure lock, and safe return; timing risk is legible before contact. | Danger blends into red decoration, reward lure, or pressure gate; contact feels visually unfair. |
| Active HUD normal | Oxygen/depth/base/cargo/scan/status during ordinary dive | Operational HUD is compact and does not block route decisions. | HUD repeats surface-only info or covers the player/route. |
| Active HUD low/critical | Low and critical oxygen states near a return decision | Warning urgency increases while base direction stays readable. | Warning hides route/safe return or becomes visually louder than immediate danger. |
| Result UI | Extraction/failure result panel with result/upgrades/log tabs | Result summary, banked cargo, scan memory, route choice, and next expedition prompt are scannable. | Panel becomes a telemetry dump, quest list, or unreadable wall of text. |

## Visual Consistency Checks

- Surface/base, player sub, resources, creatures, landmarks, and HUD should feel like the same game.
- Important meanings keep separate color/shape language: safe return, reward, scan, current, lock, predator danger, biome landmark, mystery signal.
- New art should improve clarity at normal scale before it improves decorative detail.
- No single hue family should dominate the whole screen.
- New sprite assets should keep fallback/readability nodes available until the replacement is proven clear.

## Asset Pipeline Checks

- New committed art has source/export/provenance coverage.
- Generated bitmap assets include prompt/provenance notes.
- Godot `.import` files, local screenshots, and editor caches remain uncommitted.
- Runtime scene references point to committed export/runtime assets, not temporary local files.

## Pass / Fail Summary Template

```text
Commit:
Viewport:
Seed / condition / cluster:
Screenshot paths:
Views passed:
Views failed:
Most confusing element:
Immediate fix needed:
Deferred polish:
```

## Exit Criteria

The first vertical-slice art kit is acceptable when:

- the player can identify base, sub, safe return, resource, scan target, lock, cache, predator danger, and result state without reading every line,
- no view introduces map/checklist/exact-objective language,
- active HUD remains compact,
- pressure/mystery cues stay lower priority than oxygen, safe return, and predator danger,
- asset provenance is complete.
