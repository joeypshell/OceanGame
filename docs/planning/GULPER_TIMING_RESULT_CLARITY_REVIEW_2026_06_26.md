# Gulper Timing Result Clarity Review - 2026-06-26

Status: review artifact for issue #327.

## Scope

Reviewed result-panel creature research copy across `Gulper Eel` scan, predator contact, and `Decoy Pulse I` use. This review is documentation-only and does not change result copy or monster behavior.

Related docs:

- `docs/planning/MONSTER_RESEARCH_LOOP_V1.md`
- `docs/planning/NEXT_MONSTER_RESEARCH_READABILITY_MILESTONE_2026_06_26.md`
- `docs/planning/DECOY_PULSE_HUD_PREDATOR_REVIEW_AFTER_HUD_POLISH_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

Evidence:

- `scripts/main.gd`
- `tests/logic_tests.gd`

## Result Copy Matrix

| Evidence | Current Result Read | Decision |
| --- | --- | --- |
| No Gulper evidence | No `Research:` Gulper line appears. | Pass. The result panel does not invent monster progress. |
| Gulper scan only | `Research: Gulper route timing observed.` | Pass. It says the player learned timing, not combat technique. |
| Predator contact | `Research: Gulper strike confirms the warning lane is dangerous.` | Pass. Contact reads as a route-danger lesson, not a reward for damaging the predator. |
| Decoy use | `Research: Decoy timing bent the Gulper route briefly.` | Pass with watchlist. It captures temporary route manipulation without claiming safety or victory. |
| Scan plus contact | Contact line takes priority. | Pass. The stronger lesson is the danger of mistiming. |
| Scan/contact plus decoy | Decoy line takes priority. | Pass. The stronger lesson is preparation changing the timing window. |

## Failure And Return Framing

Extraction and oxygen failure can both include Gulper research evidence, but the result remains compact:

- a scan says the route timing was observed,
- contact says the warning lane is dangerous,
- decoy says timing briefly changed the route,
- failure still keeps cargo-loss framing separate from research memory.

This is acceptable because the result panel tells the player what was learned without becoming a bestiary, field guide, combat log, or checklist.

## Priority Rule

The current priority order is correct for the vertical slice:

1. Decoy use: learned that preparation can briefly bend route timing.
2. Predator contact: learned that the warning lane is dangerous if mistimed.
3. Gulper scan: learned that the route has observable timing.
4. No evidence: no creature research callout.

This order matches the monster-research direction: observe, recognize timing, prepare, decide whether to push or return.

## Guardrails

Current copy avoids:

- damage,
- health,
- stun,
- kill,
- harvest,
- capture,
- loot,
- bounty,
- contract,
- victory,
- permanent predator control,
- field-guide UI,
- minimap or route graph.

Keep future copy in route-learning language: `timing`, `warning lane`, `briefly`, `route`, `observed`, `dangerous`, `preparation`.

## Follow-Up Decision

No new blocker issue is needed from this review.

If later playtests show that `bent the Gulper route briefly` sounds too abstract, the narrow follow-up should be a copy-only tune such as `Decoy timing opened a brief Gulper route window.` Do not add a field guide, predator health/status UI, combat reward, or hunting contract to explain the result.

## Recommendation

Pass with watchlist.

The current Gulper result copy communicates learning without turning the predator into loot or combat progression. It is good enough for the current playable vertical-slice gate.
