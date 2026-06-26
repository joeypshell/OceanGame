# Future Touch Safe-Zone Constraints From Mobile Evidence - 2026-06-26

Status: future planning constraint. No touch controls are implemented by this note.

Issue: #410.

## Purpose

Convert the current `960x540` mobile-like Playwright evidence into constraints for a later landscape touch-control prototype. This keeps future mobile work from covering the pieces that already carry the dive's meaning.

## Evidence Used

- `docs/planning/MOBILE_LIKE_SURFACE_ACTIVE_REVIEW_2026_06_26.md`
- `docs/planning/MOBILE_LIKE_LOWER_ROUTE_READABILITY_REVIEW_2026_06_26.md`
- `tests/playwright/mobile-landscape-smoke.spec.mjs`

The current evidence says the smaller landscape view is readable enough for planning, but not mobile-ready. Surface ready has a large right-side briefing panel. Active dive has left-side HUD pressure. Lower-route views put major danger/reward/pressure information on the right and upper-right.

## Reserved Meaning Zones

Future touch controls must not cover these areas without a specific follow-up redesign:

| Zone | Must Remain Readable | Current Risk |
| --- | --- | --- |
| Upper-left | Oxygen, depth, base direction, cargo, scan, prompt, and status stack. | Likely movement thumb zone conflicts with active HUD. |
| Upper-right | Surface ready briefing, scan target panel, pressure/cache/reward clues, and Wreck Echo route cues. | Likely action button cluster could cover route decisions. |
| Center-right | Player/sub, predator lane, pressure gate, and reward lure during lower-route play. | Highest risk at phone-like width because player and danger often sit here. |
| Bottom-left | Result/upgrade panels and future movement control candidate area. | Overlay controls could compete with panel text after extraction. |
| Bottom-right | Future action buttons and current lower-route player/danger composition. | Unsafe for large persistent buttons during active dives. |

## Future Layout Constraints

- Treat touch controls as temporary overlays until proven with screenshots; do not assume desktop HUD can simply coexist with them.
- Prefer translucent controls only if they remain legible over both bright surface water and dark lower-route water.
- Keep movement controls away from the current active HUD unless the active HUD is deliberately moved or compacted.
- Keep action controls away from the lower-route right side while pressure/cache, predator, Wreck Echo, or reward cues are in view.
- Preserve safe-return readability: `Base: up/down/here` must remain visible during touch-control tests.
- Preserve low/critical oxygen readability before accepting any mobile layout.
- Use the mobile-like Playwright scaffold before and after any touch/HUD experiment.

## Evidence Gates For Future Touch Work

A future touch prototype should not be accepted until it captures at least:

- surface ready at `960x540`,
- active dive at `960x540`,
- lower-route pressure/cache/predator view at `960x540`,
- low oxygen and critical oxygen at `960x540`,
- extraction result and upgrade panel at `960x540`,
- one screenshot with controls visible and one with controls hidden or minimized if the design supports that.

## Non-Goals

- No mobile export settings.
- No touch-control implementation.
- No controller implementation.
- No minimap, field guide, quest checklist, combat, harvesting, capture, or procedural expansion.
- No redesign of the current desktop HUD in this issue.
