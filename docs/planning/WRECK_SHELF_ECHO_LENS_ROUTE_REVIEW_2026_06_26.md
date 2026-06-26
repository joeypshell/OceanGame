# Wreck Shelf Echo Lens Route Review - 2026-06-26

Status: review artifact for issue #214.

## Scope

Reviewed Wreck Shelf route readability now that the Wreck Echo spine, cache repeat-scan hint, `Echo Lens I` upgrade definition, broad cache echo, and Echo Lens result-memory line are active.

Evidence reviewed:

- `docs/planning/MYSTERY_SPINE_V1.md`
- `docs/planning/SCANNER_PROGRESSION_V2.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `scenes/Main.tscn`
- `scripts/main.gd`
- `tests/logic_tests.gd`
- Earlier overlap/readability notes including `LOWER_ROUTE_VISUAL_OVERLAP_REVIEW_2026_06_26.md`

No new screenshots were committed for this pass.

## Route Readability Matrix

| Route Element | Current Read | Finding |
| --- | --- | --- |
| Locked gate | Blue rails, bars, shimmer, pressure badge, boundary denial, and outside scan target communicate a blocked promise. | Pass. The gate reads as progression-blocked rather than oxygen damage or predator danger. |
| Open gate | Pressure gate visuals soften to the open state after `Pressure Seal I`. | Pass with watchlist. Future art should keep the route opening visually calmer than predator warning lanes. |
| Outside scan | `Pressure-Locked Research Wreck` scan points to `Pressure Seal I` and future cache payoff. | Pass. It is practical progression copy, not a map marker. |
| Wreck Signal Cache | Inside cache scan unlocks scanner progression and repeat scans now support unresolved echo curiosity. | Pass. Cache meaning is now stronger than before, but it still depends on reaching the alcove instead of broadcasting a remote objective. |
| Safe return | Base direction HUD, return lane language, and oxygen warnings remain higher-priority than wreck curiosity. | Pass with watchlist. Future Wreck Shelf visual art must leave return lanes visible during low oxygen. |
| Predator proximity | Gulper route remains a separate danger vocabulary: red/orange, patrol hint, scan target, contact risk. | Pass. Predator danger is visually and mechanically distinct from pressure gate/mystery signal language. |
| Mystery language | `Cache echo unresolved`, `Echo Lens: weak wreck signal deeper-right`, and result `Research:` copy are broad and compact. | Pass. Current copy avoids map, exact-coordinate, field-guide, and checklist language. |

## Current Readability Issues

No blocking implementation failure was found in the current Wreck Shelf route plan.

The main current risk is visual priority, not mechanics: the pressure wreck, cache signal, safe return, predator route, and deep reward all live near the lower route. The existing docs and tests keep the meanings separate, but future visual replacement work should avoid making the Wreck Echo glow brighter than immediate safety or predator danger.

The placeholder wreck/cache art is still crude. That is a polish/readability-art issue, not an Echo Lens behavior issue.

## Future Echo Lens Needs

Future Echo Lens work should focus on:

- reinforcing broad category/direction language,
- making the local echo pulse temporary and low-priority,
- preserving `Signal Lens I` as the material-finding scanner,
- keeping Wreck Shelf memory tied to a place the player saw and returned to.

Future Echo Lens work should not add:

- minimap markers,
- exact coordinates,
- objective checklists,
- field-guide entries,
- route graphs,
- guaranteed safe paths,
- hidden content reveals beyond broad route curiosity.

## Follow-Up Recommendation

No new issue is required from this review alone.

Use the existing planned deeper-access note and future visual replacement issues to continue:

- pressure-wreck/cache sprite replacement or extraction,
- temporary scan/echo pulse polish,
- deeper-access planning after `Echo Lens I`.

## Verification

- MCP context self-test.
- `git diff --check`.
- `git status --short`.
