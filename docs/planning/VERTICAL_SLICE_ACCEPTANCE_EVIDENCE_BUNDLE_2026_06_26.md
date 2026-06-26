# Vertical-Slice Acceptance Evidence Bundle - 2026-06-26

Status: compact evidence bundle for issue #301.

## Scope

This is a compact internal evidence bundle for the current playable vertical slice.

It does not require external blind testers and does not claim final polish. Screenshot capture was not required for this pass; future screenshot evidence should follow `docs/current/SCREENSHOT_WORKFLOW.md`.

Baseline:

- Commit: `0272e8e`
- Review type: documented solo/internal evidence bundle
- Screenshot paths: none recorded for this pass
- Related solo checklist: `docs/planning/SOLO_FIRST_RUN_READABILITY_RESULT_2026_06_26.md`

## Evidence Matrix

| Required Evidence | Current Status | Evidence | Watchlist |
| --- | --- | --- | --- |
| Ready screen | Pass with watchlist | Ready panel owns E/Enter start, condition copy, and one goal line while active HUD clutter/debug reset copy stays hidden by default. | Recheck surface panel/art if boat or moonpool changes. |
| Active dive | Pass with watchlist | Active HUD separates oxygen, depth, base direction, cargo, scan target, prompt, and status from the surface panel. Sub/background contrast is acceptable for current source-art state. | Low/critical oxygen review remains #313. |
| Pickup/scan | Pass | Resource and scan target labels are compact; first resource scan points toward collect-and-bank; scan feedback avoids minimap/locator/checklist language. | Signal Lens/Echo Lens distinction remains #315. |
| Return/failure | Pass with watchlist | Extraction/failure result copy distinguishes carried cargo from banked/durable progress, keeps one memory line, and makes R next expedition clear. | Durable reset/onboarding wording remains #317. |
| Upgrade view | Pass with watchlist | Upgrade bay is one selected upgrade at a time, now shows Up/Down selection in the panel title, and keeps cost/state/missing requirements explicit. | Normal-scale upgrade affordance remains #314. |
| Blocked route | Pass | Pressure-Locked Research Wreck keeps locked/open state distinct, denies safely before Pressure Seal I, and does not create hidden oxygen damage or bypass. | Lower-route pileup recheck remains #310. |
| Danger route | Pass with watchlist | Gulper route reads as avoidable danger through warning lane, predator sprite/state, contact oxygen cost, knockback, and non-combat Decoy Pulse framing. | Recheck with future lower-route art and HUD changes. |
| Optional clue route | Pass with watchlist | Thermal Vent and Shell Reef remain optional clue/banking routes, not mandatory objectives or guaranteed safe paths. | Keep future condition visuals presentation-first. |

## Gate Read

The slice currently demonstrates:

- start expedition,
- dive under oxygen pressure,
- collect or scan,
- return or fail,
- read result,
- inspect upgrade progress,
- understand one blocked route,
- understand one danger route,
- notice one optional clue route,
- continue to another expedition.

## Remaining Before Fully Polished Acceptance

This bundle supports continued closeout, but the slice should stay `pass with watchlist` until the next issues land:

- #302 updates the formal acceptance checklist after this evidence,
- #310 rechecks the lower route with the background study wired,
- #313 reviews low/critical oxygen after prompt/title changes,
- #314 reviews upgrade bay normal-scale affordance,
- #315 reviews scanner feedback distinction,
- #317 reviews durable progression reset/onboarding copy.

## Non-Goals Confirmed

No new evidence in this bundle approves:

- final production-art lock,
- full procedural ocean,
- minimap, route graph, exact locator, field guide, quest checklist,
- weapons, predator harvesting, capture, or combat rewards,
- inventory grid, tech tree, or base-management layer,
- outside-player blind validation claims.
