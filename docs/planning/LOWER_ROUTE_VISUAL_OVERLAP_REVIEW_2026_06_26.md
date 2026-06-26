# Lower Route Visual Overlap Review - 2026-06-26

## Status

Review completed after compact marker passes for scan, lock, return, danger, and reward cues.

## Scope

Reviewed the lower-route cluster around:

- `Pressure-Locked Research Wreck`,
- `Wreck Signal Cache`,
- deep reward lure,
- `Gulper Eel` warning route,
- non-resource scan markers,
- safe-return column/ribs/beacon.

This is a structured visual/readability review, not a blind validation test.

## Current Read

The worst blocker from earlier screenshots, loose text covering the playfield, is no longer the main issue. The active dive now uses a compact HUD and marker language carries more of the route meaning.

The lower route is still visually dense, but it is more separable than before:

- safe return reads as cyan/green vertical lane plus beacon/ribs,
- pressure lock reads as blue gate bars plus compact `LOCKED`/`OPEN` badge,
- scan targets read as pale diamond/focus brackets,
- Gulper route reads as red warning current/ribs/eye/hazard badge,
- deep reward reads as lime glow/bloom/core/ping.

## Element Review

### Pressure Wreck And Cache

Readable: mostly yes.

The compact lock badge removes the long text label and the blue gate remains visually distinct from reward and danger language.

Remaining risk:

- The cache signal, scan diamond, wreck glow, and lock badge all sit in the same lower-right visual neighborhood. They are individually readable, but future additions near the wreck should be avoided until this area has more art separation.

### Deep Reward Lure

Readable: yes as optional temptation.

The new reward core gives the lure a clearer center without adding resource count or making the whole route brighter.

Remaining risk:

- The reward hue is intentionally close to Glow Plankton. That is useful, but it can compete with scan markers if both are selected nearby.

### Gulper Route

Readable: improved.

The warning marker no longer uses pickup-like yellow. The red hazard badge and warning eye better separate danger from reward.

Remaining risk:

- The predator warning lane can still visually intersect with the deep reward path on `Deep reward route` expeditions. That is desirable as a risk/reward read, but it should not hide the safe-return lane.

### Safe Return

Readable: yes.

The safe-return lane remains the highest-priority orientation cue and now has a compact beacon near the surface lane.

Remaining risk:

- In the deepest view, the return lane can become background texture if reward/danger effects become brighter. Future reward and danger passes should avoid increasing alpha before another review.

### Text Clutter

Current status: no longer a blocker for this area.

The lower-route issue is now visual density, not text density. Long world labels are not the primary failure mode after the HUD separation and compact marker passes.

## Follow-Up Candidates

1. Add slight depth-layer separation around the pressure wreck.
   - Keep the lock badge, cache signal, and scan marker from sitting on the same perceived plane.

2. Add condition-aware brightness caps.
   - If future `Thermal Bloom`, `Rare Signal`, or predator conditions brighten this area, cap reward/danger/scan alpha so safe return remains readable.

3. Add a focused deep-route screenshot checklist.
   - Capture the lower route with locked pressure, open pressure, selected scan target, predator warning, and deep reward visible.

4. Keep new lower-route content out of this cluster for now.
   - Prefer the next route pocket or condition effect elsewhere unless the issue specifically improves separation.

## Decision

Proceed with the planned condition telemetry and condition-visual-effect issues. Do not add more lower-route content until the first condition effects are reviewed.

Text clutter is no longer the blocker here. Visual separation and brightness priority are the remaining risks.
