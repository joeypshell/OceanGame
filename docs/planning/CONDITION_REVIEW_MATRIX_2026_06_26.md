# Condition Review Matrix - 2026-06-26

Status: solo review matrix for issue #171.

## Purpose

Use this matrix to review expedition-day condition readability with F3/F4/F5 without requiring blind testers. The goal is to confirm that condition copy and visible cues support planning while still preserving stable geography.

This matrix is a review artifact. It does not authorize hidden condition mechanics.

## How To Use

1. Start from the ready panel.
2. Press F3 to show debug telemetry.
3. Press F4 to cycle the condition until the target row is active.
4. Press F5 if a different seed/cluster/predator route is needed.
5. Hide debug telemetry with F3 before taking player-facing screenshots.
6. Capture the target view and fill the screenshot path plus observations.

Record:

- expedition number,
- seed,
- condition,
- cluster pattern,
- target view,
- screenshot path,
- expected cue,
- observed risk,
- pass/polish/blocker.

## Matrix

| Review row | Condition | Current status | Target view | Expected cue | Observed risk field | Screenshot path |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Calm Current | Implemented readability effect | Active midwater return route near Surface Base/Shell Reef | Safe-return column/ribs/beacon and return-current language should read slightly clearer; no cargo, oxygen, predator, or pressure-gate rules change. | Does the return cue look like a reward or objective arrow? | fill during review |
| 2 | Thermal Bloom | Implemented readability/placement emphasis | Thermal Vent Field and vent-adjacent Glow Plankton route | Warm wash, heat plume, bubbles, and vent-adjacent glow opportunity should read more strongly while still optional. | Does the warm route look mandatory or safe when oxygen is low? | fill during review |
| 3 | Kelp Bloom | Flavor-only today | Surface ready and shallow resource view | Ready-panel copy says shallow growth is thick; no spawn, oxygen, cargo, or return-rule change should be inferred. | Does flavor-only copy imply extra resources that are not actually present? | fill during review |
| 4 | Predator Migration | Flavor-only today | Gulper Route warning lane | Ready-panel copy says patrols are shifting; current seeded route selection remains normal and debug-only route id stays hidden. | Does the player-facing copy overpromise a visible predator behavior change? | fill during review |
| 5 | Low Visibility | Flavor-only today | Midwater/deep transition | Copy says deeper water is harder to read; do not infer scan range penalties or hidden hazards. | Does the current visual haze already make the route too hard to parse? | fill during review |
| 6 | Rare Signal | Presentation-only subtle shimmer; reviewed in `RARE_SIGNAL_CONDITION_READABILITY_REVIEW_2026_06_26.md` | Wreck Shelf / Wreck Signal Cache promise | Copy says weak ping below; faint shimmer should support curiosity without becoming a quest marker. | Watch for overpromising a hidden target; visual emphasis must stay subtle/local only. | not captured |
| 7 | Wreck Shift | Reviewed in `WRECK_SHIFT_CONDITION_READABILITY_REVIEW_2026_06_26.md`; flavor-only today | Pressure-Locked Research Wreck | Copy says pressure exposed a different angle; should support future variation without bypassing Pressure Seal I. | Watch that any future emphasis does not imply the gate moved/opened or reveal the cache before `Pressure Seal I`. | not captured |

## Pass Criteria

- Player-facing condition name and one-line briefing are readable on the ready panel.
- Debug seed, raw condition id, cluster pattern, and predator route remain hidden unless F3 is enabled.
- Implemented conditions have visible cues that match their current behavior.
- Flavor-only conditions are interesting but do not imply hidden mechanical changes.
- Stable regions remain recognizable across condition review.

## First Follow-Up Rule

Create a follow-up issue only if a row produces a blocker:

- a condition hides safe return,
- a condition implies a mechanic that does not exist,
- a condition makes pressure gate, predator warning, resource, or scan target meanings conflict,
- the ready panel cannot show condition plus goal without crowding.
