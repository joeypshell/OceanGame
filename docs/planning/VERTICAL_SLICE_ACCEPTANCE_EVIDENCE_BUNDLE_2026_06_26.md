# Vertical-Slice Acceptance Evidence Bundle - 2026-06-26

Status: compact internal evidence bundle, refreshed through issue #333.

## Scope

This is a compact internal evidence bundle for the current playable vertical slice.

It does not require external blind testers and does not claim final polish. Screenshot capture was not required for this pass; future screenshot evidence should follow `docs/current/SCREENSHOT_WORKFLOW.md`.

Baseline:

- Commit: `0272e8e`
- Review type: documented solo/internal evidence bundle
- Screenshot paths: none recorded for this pass
- Related solo checklist: `docs/planning/SOLO_FIRST_RUN_READABILITY_RESULT_2026_06_26.md`

Latest review refresh:

- Compact HUD review: `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- Pressure shell review: `docs/planning/PRESSURE_WRECK_CACHE_SHELL_NORMAL_SCALE_REVIEW_2026_06_26.md`
- Lower-route shell recheck: `docs/planning/LOWER_ROUTE_RECHECK_AFTER_PRESSURE_SHELL_2026_06_26.md`
- Decoy/Gulper reviews: `docs/planning/DECOY_PULSE_HUD_PREDATOR_REVIEW_AFTER_HUD_POLISH_2026_06_26.md` and `docs/planning/GULPER_TIMING_RESULT_CLARITY_REVIEW_2026_06_26.md`
- Wreck Echo planning reviews: `docs/planning/WRECK_ECHO_READINESS_GATE_AFTER_SHELL_HUD_2026_06_26.md` and `docs/planning/WRECK_ECHO_REWARD_CHOICE_2026_06_26.md`
- Resource/scan reviews: `docs/planning/RESOURCE_SCAN_AFFORDANCE_REVIEW_AFTER_PRESSURE_SHELL_2026_06_26.md` and `docs/planning/RESOURCE_SCAN_SOURCE_ART_TARGET_DECISION_2026_06_26.md`

This refresh does not claim blind validation. It only consolidates internal evidence and planning decisions tied to implemented behavior.

## Evidence Matrix

| Required Evidence | Current Status | Evidence | Watchlist |
| --- | --- | --- | --- |
| Ready screen | Pass with watchlist | Ready panel owns E/Enter start, condition copy, and one goal line while active operational HUD rows and debug reset copy stay hidden by default. | Recheck surface panel contrast after final HUD polish. |
| Active dive | Pass with watchlist | Final compact HUD review confirms O2, depth, base, cargo slots, scan, prompt, status, low/critical warnings, result/failure hiding, and debug-on/off states are bounded at normal scale. | Fixed top-left HUD can cover incidental left-side art; keep future left-route art aware of that footprint. |
| Pickup/scan | Pass with watchlist | Resource and scan target labels are compact; Kelp Fiber, Shell Fragments, Glow Plankton, non-resource scan markers, selected scan HUD, Signal Lens pulse, and Echo Lens pulse remain distinct enough after the pressure shell. | New resource/scan source-art is deferred; reopen only if future evidence shows concrete confusion. |
| Return/failure | Pass with watchlist | Extraction/failure result copy distinguishes carried cargo from banked/durable progress, keeps one memory line, and makes R next expedition clear. Durable progression reset/onboarding review found no save or copy change needed. | Maintain clean separation between durable progression and temporary dive state. |
| Upgrade view | Pass with watchlist | Upgrade bay is one selected upgrade at a time, shows Up/Down selection in the panel title, and keeps cost/state/missing requirements explicit after normal-scale review. | Continue guarding long copy and avoid tech-tree/inventory-grid expansion. |
| Blocked route | Pass with watchlist | Pressure-Locked Research Wreck keeps locked/open state distinct, denies safely before Pressure Seal I, and the pressure shell reduces lower-route shape pileup without implying new route behavior. | Wreck Echo Descent remains unimplemented until a separate route issue proves readiness. |
| Danger route | Pass with watchlist | Gulper route reads as avoidable timing danger; Predator Warning I and Decoy Pulse I read as non-lethal preparation/distraction rather than combat, capture, loot, or victory. | Future timing changes should preserve contact risk after mistimed decoy use. |
| Optional clue route | Pass with watchlist | Thermal Vent, Shell Reef, Wreck Signal Cache, and current scan/echo signals remain optional clue/banking/mystery routes, not mandatory objectives or guaranteed safe paths. | Future condition visuals should stay presentation-first. |

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

- #334 updates the formal acceptance status after this refreshed evidence,
- #335 adds a clean playable demo script,
- #336 reviews surface panel contrast after final HUD polish,
- #337 reviews debug hidden-state sanity after the latest evidence,
- #338 refreshes MCP context after the playable-loop polish batch.

## Non-Goals Confirmed

No new evidence in this bundle approves:

- final production-art lock,
- full procedural ocean,
- Wreck Echo Descent implementation,
- minimap, route graph, exact locator, field guide, quest checklist,
- weapons, predator harvesting, capture, or combat rewards,
- inventory grid, tech tree, or base-management layer,
- outside-player blind validation claims.
