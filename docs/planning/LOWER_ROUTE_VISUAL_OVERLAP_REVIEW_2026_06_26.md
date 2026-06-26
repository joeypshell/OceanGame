# Lower Route Visual Overlap Review - 2026-06-26

## Status

Review completed after compact marker passes for scan, lock, return, danger, and reward cues. Post-asset addendum added after the Shell Reef, Thermal Vent, pressure-lock/wreck, and Gulper route visual passes.

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

## Post-Asset Addendum - Lower Route Screenshot Review

Reviewed after the first visual-clarity asset passes:

- Shell Reef landmark and route visual pass.
- Thermal Vent pocket visual pass.
- Pressure lock and wreck visual pass.
- Gulper route danger visual pass.

Captured views:

- Ready-state lower route: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/lower_route_overlap_review_2026_06_26.png`
- Active-dive lower route: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/lower_route_overlap_review_active_2026_06_26.png`

Capture context:

- Viewport: 1365 x 768.
- Player/camera review position: approximately `Vector2(980, 1660)`.
- Active review HUD state: dive started through `_start_dive()` before moving the player.
- Visible scan target during active review: `Pressure-Locked Research Wreck`.
- Visible route states: pressure route locked, deep reward visible, predator warning lane visible, safe-return column visible.

### Current Read After Asset Pass

The lower route is dense but now understandable at normal scale. The main route categories are visually separable:

- Safe return: vertical cyan return lane remains readable on the left side of the reviewed cluster.
- Pressure lock: blue vertical shimmer, rails, crossbars, and compact `LOCKED` badge read as the clearest blocked-route cue.
- Wreck promise: hull silhouette and subdued cache glow read as a future payoff behind the gate rather than an immediate pickup.
- Predator danger: red warning lane, ribs, bite marker, and the Gulper silhouette read as the most dangerous route cue.
- Reward temptation: lime/yellow glow remains readable as valuable cargo, but it no longer owns the whole lower-right cluster.

### Blockers

No new blocker-level follow-up is required from this review.

The previous blocker, overlapping playfield text, is outside this lower-route view after the HUD separation work. The remaining concern is visual density, not an inability to understand what the route is asking.

### Polish Risks

- The lower-right area still stacks pressure gate, reward glow, future cache signal, and predator lane in a tight cluster. This is acceptable for the current risk/reward promise, but future content should avoid this exact area until layout spacing is revisited.
- The pressure gate is now intentionally dominant while locked. If the route is open, a later screenshot review should confirm the softened green passable state is still clear when the predator lane is also visible.
- The active dive HUD is readable in this lower-route capture, but it takes meaningful left-side space. Future HUD expansion should remain panel-bounded and avoid adding loose world text.
- The deep reward and scan marker colors can still become similar when selected nearby. This is polish unless a player mistakes the reward for an objective marker.

### Follow-Up Recommendation

Do not open a new lower-route fix issue from this review alone. Continue with the already planned visual review checklist, screenshot workflow, debug seed/condition helper, and performance/readability review issues. Those issues are better owners for repeatable captures, open-state comparison, and any later concrete overlap bug.
