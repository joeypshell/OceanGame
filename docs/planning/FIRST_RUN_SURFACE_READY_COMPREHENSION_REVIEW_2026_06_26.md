# First-Run Surface Ready Comprehension Review - 2026-06-26

Status: solo review artifact for issue #285.

## Purpose

Review what a fresh player should understand before pressing `E` or Enter for the first dive.

This replaces blind-validation dependency with a solo, repeatable comprehension pass. It does not add tutorial panels, quest UI, or checklist UI.

## Review Checklist

| Element | Expected Read | Decision |
| --- | --- | --- |
| Start prompt | Player can see that `E/Enter` begins the dive. | Pass |
| Surface base | Boat/lab, waterline, and moonpool read as the launch origin. | Pass with watchlist |
| Condition copy | `Today:` block says why the ocean feels different without raw ids or hidden-mechanic promises. | Pass |
| Goal line | One concise next-step goal points toward useful cargo/scan/upgrade progress. | Pass |
| Debug details | Seed, condition id, cluster pattern, predator route, and F9 reset copy stay hidden. | Pass |
| Active HUD clutter | Oxygen/depth/cargo/scan/status operational clutter stays hidden until active dive. | Pass |

## Watchlist

- Surface art and panels are readable after the moonpool/panel-opacity pass, but future boat, background, or panel changes should recheck title/first-line overlap.
- Goal copy should remain one line or a short wrapped block. Do not turn it into a quest checklist.
- Condition copy should stay honest: presentation-first unless a scoped mechanic already exists.

## Decision

Pass with watchlist.

The first-run surface ready state is understandable enough for the current slice. The player sees a surface vessel/lab, a waterline/moonpool relationship, a clear start input, a condition, and one useful next goal without debug noise.

## Guardrails

- No tutorial overlay.
- No objective checklist.
- No minimap or route graph.
- No field guide.
- No raw seed/condition/route ids in normal view.
