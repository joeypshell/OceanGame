# Wreck Shift Condition Readability Review - 2026-06-26

Status: review artifact for issue #231.

## Scope

Reviewed the `Wreck Shift` expedition condition against the current Pressure-Locked Research Wreck, Wreck Shelf memory, and Wreck Echo planning.

Evidence reviewed:

- `scripts/expedition_condition.gd`
- `docs/planning/CONDITION_REVIEW_MATRIX_2026_06_26.md`
- `docs/planning/WRECK_SHELF_ECHO_LENS_ROUTE_REVIEW_2026_06_26.md`
- `docs/planning/REGION_IDENTITY_MAP_V1.md`
- `docs/current/GAMEPLAY.md`

No new screenshots were committed for this pass.

## Current Player-Facing Read

Condition name: `Wreck Shift`

Ready-panel briefing:

`Pressure has exposed a different wreck angle.`

Current status: flavor-only. It does not move or open the pressure gate, change `Pressure Seal I`, alter the Wreck Signal Cache, change collision, add a new entrance, move scan targets, or change route layout.

## Readability Findings

| Check | Finding |
| --- | --- |
| Ready-panel copy | Pass with watchlist. The line is compact, but `exposed` can imply access if later visuals are too strong. |
| Gate moved/opened risk | Watch. The condition must never imply the route is open before `Pressure Seal I`; current copy is acceptable only because no visual effect exists yet. |
| Wreck Shelf relation | Pass. The condition fits the region identity plan: Wreck Shelf can vary by approach/cache angle in the future. |
| Pressure Seal clarity | Pass by current mechanics. The gate still owns `LOCKED`/`OPEN` state and pressure-boundary denial. |
| Flavor versus mechanics | Pass. Wreck Shift remains flavor-only today. |
| Future visual need | Warranted, but only as approach-angle emphasis, not a gate-state change. |

## Recommendation

A future Wreck Shift visual effect may be useful after Rare Signal emphasis, but it should be stricter than Rare Signal because it sits next to an actual access gate.

Recommended first effect:

- subtly emphasize wreck silhouette angle, broken hull edge, or outside scan approach,
- keep the pressure gate badge/bars/shimmer as the loudest access-state language,
- avoid drawing a new open route line,
- avoid highlighting the inside cache before `Pressure Seal I`,
- avoid any effect that looks like the boundary moved.

Do not turn `Wreck Shift` into:

- a gate bypass,
- an alternate entrance,
- a free `Pressure Seal I` day,
- a moved pressure boundary,
- a guaranteed cache reveal,
- a minimap marker,
- a quest checklist,
- or a new route behavior without a separate implementation issue.

## Future Acceptance Notes

If a future issue prototypes Wreck Shift emphasis, it should pass these checks:

- `LOCKED` and `OPEN` gate states remain more readable than the condition effect,
- pressure denial still works before `Pressure Seal I`,
- outside scan and Wreck Signal Cache behavior remain unchanged,
- Wreck Shelf memory is reinforced without exact coordinates,
- no new route or gate behavior is added,
- debug telemetry remains gated behind F3.

## Decision

Keep `Wreck Shift` flavor-only for now. Future work can prototype a subtle wreck-angle emphasis, but only if it cannot be mistaken for a moved/open pressure gate.
