# Surface Panel Contrast Review After Final HUD Polish - 2026-06-26

Status: review artifact for issue #336.

## Purpose

Review surface panel contrast after the final compact HUD polish pass, with focus on whether boat/moonpool art remains a strong first-read signal without sitting behind unreadable surface copy.

This is a review-only pass. It does not change panel opacity, panel placement, boat scale, moonpool art, upgrade layout, or HUD behavior.

## Evidence Reviewed

- `docs/planning/SURFACE_READY_RESULT_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/SURFACE_MOONPOOL_WATERLINE_REVIEW_2026_06_26.md`
- `docs/planning/SURFACE_LAUNCH_RETURN_READABILITY_REVIEW_2026_06_26.md`
- `docs/planning/UPGRADE_TAB_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md`
- `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- `scenes/Main.tscn`
- `scripts/main.gd`

Scene note: `scenes/Main.tscn` uses `StyleBoxFlat_surface_panel` with a dark surface-panel background at high opacity. Ready/result/log share `RunPanel`; the upgrade view uses the same surface style on `UpgradePanel`.

## State Review

| Surface View | Current Read | Decision |
| --- | --- | --- |
| Ready | Boat, waterline, and moonpool remain visible as the start location while the ready panel owns start, condition, and goal copy. Active operational HUD rows stay hidden. | Pass with watchlist |
| Result | Result copy owns the readback state. Boat/moonpool art remains recognizable behind the panel but does not compete with banked cargo, memory, upgrade progress, or next-expedition copy. | Pass |
| Failure | Failure surface remains panel-led; cargo loss and preserved durable progress are readable without active HUD clutter. | Pass |
| Upgrade | The wrapping/taller-panel pass cleared the earlier overflow problem. The darker surface skin keeps one selected upgrade, cost, state, feedback, and role hint readable over surface art. | Pass with watchlist |
| Log | Recent expedition entries remain compact and readable with debug telemetry hidden by default. | Pass |

## Boat/Moonpool Signal

The boat/moonpool art remains strong enough for the current vertical slice:

- the boat is still visible as the first surface landmark,
- the waterline and moonpool column support launch/return orientation,
- `BaseZone` remains separate gameplay ownership,
- surface panels do not need to move to preserve the boat read,
- active HUD rows do not leak into ready/result/failure/log surfaces.

## Narrow Follow-Up Guidance

No immediate runtime change is needed.

If future screenshots show surface art behind copy becoming confusing again, prefer one narrow follow-up:

- slightly increase surface panel opacity,
- move the panel only enough to avoid the boat cabin/title overlap,
- shorten the affected surface copy,
- keep the boat/moonpool visible as the first-read surface signal.

Do not solve surface contrast by adding a new menu layer, field guide, objective checklist, minimap, route graph, inventory grid, or broad surface UI redesign.

## Decision

Pass with watchlist.

The current surface panel contrast is acceptable for playable vertical-slice closeout. The watchlist should stay active for future boat scale, waterline placement, background art, or panel-copy changes, but no new implementation issue is needed from this review.
