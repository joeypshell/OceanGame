# Active HUD Low-Oxygen Review After Prompt Tune - 2026-06-26

Status: review artifact for issue #313.

## Purpose

Review normal, low, and critical active HUD oxygen states after recent prompt/title copy changes.

This is a docs-only review. It does not change oxygen thresholds, oxygen drain, HUD layout, warning behavior, or runtime copy.

## Evidence Reviewed

- `docs/planning/ACTIVE_HUD_NORMAL_SCALE_SCREENSHOT_REVIEW_2026_06_26.md`
- `docs/planning/ACTIVE_PROMPT_BURST_DECOY_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_FINAL_POLISH_PLAN_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- `scenes/Main.tscn`
- `scripts/main.gd`

No new screenshots were committed for this review.

## State Review

| State | Current Read | Decision |
| --- | --- | --- |
| Normal oxygen | Oxygen, depth, base direction, cargo count, cargo slots, scan target, prompt, and status stay in bounded active HUD surfaces. Recent prompt trims reduce width pressure. | Pass |
| Low oxygen | Low state shows inline oxygen emphasis plus the upper-right warning panel. It remains louder than mystery shimmer, reward lure, scan target, and normal prompt/status text without covering the dive info panel. | Pass |
| Critical oxygen | Critical state escalates color and pulse on oxygen/base direction and shows stronger warning copy. It should remain the loudest active HUD state short of failure. | Pass with watchlist |
| Cargo visible | Cargo count and slots remain readable alongside oxygen states. Fourth-slot locked/unlocked treatment is still a final-polish review state, not a blocker here. | Pass with watchlist |
| Scan/prompt/status visible | Scan target, Burst Thruster prompt, Decoy Pulse prompt, and status remain inside the dive info panel. Prompt trims make low-oxygen states less likely to collide with action text. | Pass |

## Mystery/Reward Cue Comparison

Low and critical oxygen must outrank:

- Wreck Signal Cache glow,
- Echo Lens pulse,
- Rare Signal shimmer,
- deep reward lure,
- Glow Plankton/resource highlights,
- pressure wreck promise glow.

The current plan and reviewed HUD treatment support that hierarchy because oxygen warnings live in player-facing HUD surfaces and use warm warning colors, while mystery/reward cues remain world-space, local, and lower priority.

## Narrow Tune Guidance

No runtime tune is required from this review.

If a future normal-scale screenshot shows conflict, prefer narrow behavior-neutral changes:

- shorten prompt/status copy further,
- reduce warning pulse scale before moving panels,
- tune warning panel opacity or padding,
- keep low/critical warning above mystery/reward cues,
- avoid adding new indicators or new oxygen mechanics.

## Guardrails

Do not add:

- oxygen penalties,
- decompression/ascent rules,
- minimap or exact return locator,
- objective checklist,
- field-guide UI,
- inventory grid,
- more debug telemetry,
- persistent quest warnings.

## Decision

Pass with watchlist.

The low-oxygen HUD state is currently louder than mystery and reward cues while preserving cargo, scan target, prompt, and status readability. The next useful action is normal-scale evidence during the final compact HUD polish pass, not immediate runtime change.
