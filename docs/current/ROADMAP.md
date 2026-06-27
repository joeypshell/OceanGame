# Current Roadmap

This is the compact active roadmap for issue-driven work. Historical issue batches and completed milestone detail live in `docs/current/PROJECT_INDEX.md` and `docs/archive/ROADMAP_HISTORY_2026_06_27.md`.

## Current Direction

OceanGame is a 2D alien-ocean expedition game. Each expedition starts from the surface boat/lab, sends the player into persistent side-view geography with seeded daily variation, and asks them to return with cargo or knowledge that makes the next dive smarter.

North-star filter: current work should help the player see something tempting, risk a dive, return with cargo or knowledge, understand what changed, and want to try one smarter expedition tomorrow. Prefer remembered places, readable route choices, useful surface results, and upgrades that open or clarify known destinations.

## Active Milestone

Area 01 Readability Rescue / Salvage Cutter Return Payoff close-out.

Recent playtesting said the Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket cluster was too visually messy to test comfortably. The bounded readability review now accepts Area 01 readability with a watchlist, so content expansion may resume carefully through #622.

The Salvage Cutter return payoff validation accepts the opened-pocket loop with a watchlist. The next batch should move away from local readability rescue and back toward player-visible route growth.

Primary planning docs:

- `docs/planning/AREA_01_READABILITY_RESCUE_2026_06_27.md`
- `docs/planning/AREA_01_READABILITY_EVIDENCE_2026_06_27.md`
- `docs/planning/AREA_01_READABILITY_DECISION_REPORT_2026_06_27.md`
- `docs/planning/AREA_01_BLUE_HOLE_ATLAS_2026_06_27.md`
- `docs/planning/SALVAGE_CUTTER_RETURN_PAYOFF_VALIDATION_2026_06_27.md`

## Immediate Issue Order

1. Done in #622: add one light salvage-pocket timing/read addition that is sparse, visually distinct, and does not introduce a new route branch, resource, upgrade, or bright label pile.
2. Done in #623: validate the Salvage Cutter Return Payoff milestone, preserve staging/guard coverage, and choose the next player-visible direction.
3. After #623, create a larger-route progress batch. Prioritize a bigger authored side-view region, a memorable branch, a pressure/timing choice, a creature/read behavior, and a result-memory payoff that gives the player a reason to try another expedition.

## Completed In This Readability Rescue

- #624 established the Area 01 visual hierarchy contract and made the readability blocker explicit.
- #625 quieted the Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket placeholder pileup.
- #626 reduced redundant normal-play route labels in the same cluster.
- #627 separated resources, knowledge payoffs, locked promises, and return/timing support into clearer color/opacity bands.
- #628 recorded deterministic `wide_reef_salvage_open` evidence in `docs/planning/AREA_01_READABILITY_EVIDENCE_2026_06_27.md`.
- The bounded decision review accepted Area 01 readability with watchlist after a tiny HUD/current-cue pass and four refreshed staged captures.
- #622 added one subtle salvage-pocket timing read after the Area 01 readability pass.

## Current Readability Rules

- Resource pickups should remain the clearest cargo-like objects.
- Knowledge payoffs should use compact cyan or amber cores with subdued halos.
- Locked/future route promises should use darker mouths, quieter seals, and low-alpha glints.
- Return-current and timing support should stay lower-opacity than recoverable objects.
- Labels should be sparse and reserved for compact place names or honest locked/open states.
- Do not solve confusion by adding more bright shapes, exact locators, checklists, minimaps, or route graphs.

## Deferred Until Readability Is Accepted

- Local clutter or readability work that does not unblock a specific next playable route.
- Broader mobile/controller work beyond preserving semantic input guardrails.
- Final art overhaul, large UI reskin, broad visual regression suite, or golden-image infrastructure.

## Stable Guardrails

- Preserve current gameplay behavior unless an issue explicitly asks for a gameplay change.
- `DiveSession` owns temporary expedition state.
- `ProgressionState` owns durable progress.
- Authored scene data owns route/content placement.
- Visual/readability assets communicate meaning without owning gameplay truth.
- Avoid full open-world scope, co-op, restaurant/base management, broad crafting trees, exact scanner locators, minigame sprawl, combat/loot pivots, and feature volume that weakens the expedition loop.

## Verification Preference

Use the cheapest test that proves the change:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
git diff --check
```

Use visual/export/Playwright captures only when a visible scene, HUD, camera, or layout change needs evidence.
