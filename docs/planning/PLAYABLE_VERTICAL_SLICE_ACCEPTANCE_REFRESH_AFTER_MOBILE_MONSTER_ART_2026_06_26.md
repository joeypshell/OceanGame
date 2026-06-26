# Playable Vertical-Slice Acceptance Refresh After Mobile, Monster, And Art Planning - 2026-06-26

Status: pass with watchlist; not final production polish.

Issue: #421.

## Purpose

Refresh playable vertical-slice acceptance after the compact upgrade fix, mobile-like screenshot coverage, Monster Research II planning/guardrails, lower-route pileup review, and cohesive art-kit integration plan.

## New Evidence Since The Previous Acceptance Refresh

- Compact upgrade details implementation keeps selected-upgrade feedback inside the `1280x720` panel.
- Mobile-like Playwright smoke now covers surface, active, lower-route, low oxygen, critical oxygen, Wreck Echo route, Wreck Echo result, and player-facing Wreck Echo result at `960x540`.
- Future touch safe-zone constraints are documented without implementing mobile/touch controls.
- Monster Research II is constrained to non-combat behavior evidence, with `Decoy response observed` selected and guarded by logic tests.
- Lower-route pileup review keeps the route acceptable but recommends a narrow cue-priority tuning pass before adding more content.
- Cohesive art-kit planning now orders future visual work without final production art lock.

## Current Gate Read

The slice remains structurally playable and internally validated:

- start from surface boat/lab,
- dive under oxygen pressure,
- collect and scan,
- return or fail,
- read result memory,
- inspect upgrade progress,
- understand pressure blocking,
- understand predator danger and non-lethal preparation,
- notice optional clue routes including the first Wreck Echo pocket,
- begin another expedition.

## Current Status

Pass with watchlist.

This is stronger than the earlier state because upgrade overflow and mobile-like evidence gaps have been reduced. It is still not fully polished because lower-route cue pileup, future HUD skinning, surface/moonpool polish, and art-kit integration can still regress readability.

## Main Watchlist

- Lower-route reward/pressure/cache/Wreck Echo/predator/player overlap.
- Active HUD and future touch safe zones.
- Surface waterline/moonpool polish.
- Landmark sprite/fallback balance.
- Any future result copy growth.
- Any future Wreck Echo expansion.

## Still Deferred

- Final production art lock.
- Mobile/touch implementation.
- Controller implementation.
- Broad procedural ocean generation.
- Broad Wreck Echo expansion.
- Minimap, field guide, route graph, objective checklist, exact locator, combat, capture, harvesting, creature inventory, tech tree, or base-management layer.
