# Expedition Condition Visual Acceptance Review - 2026-06-26

Status: review artifact for issue #254.

## Purpose

Review `Calm Current`, `Thermal Bloom`, `Rare Signal`, and `Wreck Shift` visuals against the playable vertical-slice acceptance gate.

Conditions should make an expedition feel different while preserving stable geography, safe-return readability, and honest mechanical promises. They remain presentation-first unless a separate issue explicitly scopes behavior.

## Summary Decision

Current condition visuals are acceptable for the vertical-slice planning gate with watchlists.

- `Calm Current` helps readability when it reinforces safe return without becoming a reward arrow.
- `Thermal Bloom` helps readability when it points toward the existing vent/glow opportunity without implying safety or free pressure access.
- `Rare Signal` helps mystery when it stays faint and local around Wreck Shelf/Wreck Signal Cache.
- `Wreck Shift` should remain flavor-only for now; visual work risks implying an opened or moved pressure gate.

No immediate implementation tune-up is required from this review. Future issues should use the watchlists below before adding or brightening condition visuals.

## Condition Findings

| Condition | Current Visual/Read | Helps Readability | Main Risk | Decision |
| --- | --- | --- | --- | --- |
| `Calm Current` | Safe-return column/ribs/beacon and calmer route language can feel clearer during the dive. | Yes. It supports the current acceptance need: players must understand how to return to base. | If current/arrow shapes become too strong, they can read as a required objective or reward trail. | Keep as presentation-first readability support. Do not change oxygen, cargo, pressure, or predator rules. |
| `Thermal Bloom` | Warm wash, vent bubbles, and vent-adjacent glow emphasis around the Thermal Vent route. | Yes. It reinforces an optional clue route and makes the vent pocket feel like a meaningful remembered place. | If warm glow is too bright, it can imply a safe route, oxygen refill, or mandatory objective. | Keep the current vent/glow emphasis. Review after any Thermal Vent art replacement. |
| `Rare Signal` | Faint Wreck Shelf shimmer and broad local mystery copy. | Yes, with watchlist. It supports Wreck Echo curiosity without adding a map. | It can become an objective marker if made too bright, directional, persistent, or exact. | Keep subtle/local only. Existing #244 tuning is the right direction. |
| `Wreck Shift` | Flavor-only ready-panel condition today. | Indirectly. It supports future Wreck Shelf variation language. | Any visible effect near the gate can imply `Pressure Seal I` is bypassed, the gate moved, or the cache is exposed. | Keep flavor-only until pressure gate/cache readability is stronger. |

## Tiny Tune-Ups Or Deferrals

Immediate:

- none required from this review.

Defer to future issues:

- review `Calm Current` after any safe-return art or current-arrow changes,
- review `Thermal Bloom` after Thermal Vent sprite/fallback balance changes,
- keep `Rare Signal` brightness lower than oxygen warnings, pressure lock text, predator danger, and safe-return cues,
- prototype `Wreck Shift` only after locked/open pressure gate states remain unmistakable at normal scale.

## Acceptance Gate Rules

Condition visuals pass only when:

- the ready panel names the condition in one compact player-facing block,
- safe return remains more readable than flavor effects,
- pressure gate state remains more readable than condition effects,
- predator danger remains more readable than condition effects,
- condition effects do not imply resource count changes, oxygen changes, free upgrades, hidden objectives, exact locators, or route unlocks,
- debug seed, raw condition id, cluster pattern, and predator route telemetry remain F3-only.

## Non-Goals

- No condition-specific quest UI.
- No minimap, route graph, exact locator, field guide, or checklist.
- No daily challenge calendar.
- No new biome, resource tier, predator route behavior, oxygen rule, cargo rule, or pressure-lock rule.
- No production-art lock for condition visuals.

## Follow-Up Guidance

If a future implementation issue changes condition visuals, require normal-scale screenshots for:

- ready panel with condition visible,
- active dive near the affected route,
- nearest conflicting cue such as safe return, predator warning, pressure lock, scan target, or resource pickup,
- result panel to confirm the condition did not create debug or checklist language.
