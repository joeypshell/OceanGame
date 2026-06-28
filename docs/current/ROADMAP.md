# Current Roadmap

This is the compact active roadmap for issue-driven work. Historical issue batches and completed milestone detail live in `docs/current/PROJECT_INDEX.md` and `docs/archive/ROADMAP_HISTORY_2026_06_27.md`.

## Current Direction

OceanGame is a 2D alien-ocean survival expedition roguelite. Each expedition starts from the surface boat/lab with a small diver-scale avatar, sends the player into persistent side-view geography with seeded daily variation, and asks them to return with whatever matters most: supplies that keep the base alive tonight, cargo that improves future dives, or knowledge that unlocks the deeper mystery.

North-star filter: every expedition should force a survival tradeoff. Bring back what keeps you alive tonight, what makes future dives safer, or what unlocks a remembered deeper place. Prefer player-visible loop progress over more route breadth until the survival day rhythm works.

Loop direction under review: the next survival-loop shape is a daylight multi-dive expedition day. A top-level sun-to-moon timer would become the day budget; oxygen would become a tactical sortie budget that can be refilled by surfacing; cargo would only bank at the ship through a fast offload action; night would own upgrades, crafting, lab analysis, and Emergency Week resolution. Planning note: `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md`.

## Active Milestone

Playable Exploration Skeleton With Visual Readability.

The next milestone is no longer a narrow landmark-by-landmark expansion. The active goal is to turn the first dive space into a Safe Shallows-style playable framework: a wider side-view area with reef walls, chambers, cave mouths, resource pockets, and early survival/resource goals. Visual polish remains active, but it should now make the level bones clearer and more inviting instead of polishing isolated artifacts.

Primary planning docs:

- `docs/planning/AREA_01_READABILITY_RESCUE_2026_06_27.md`
- `docs/planning/AREA_01_READABILITY_EVIDENCE_2026_06_27.md`
- `docs/planning/AREA_01_READABILITY_DECISION_REPORT_2026_06_27.md`
- `docs/planning/AREA_01_BLUE_HOLE_ATLAS_2026_06_27.md`
- `docs/planning/SALVAGE_CUTTER_RETURN_PAYOFF_VALIDATION_2026_06_27.md`
- `docs/planning/AREA_02_LARGER_ROUTE_PROGRESS_2026_06_27.md`
- `docs/planning/AREA_02_OUTER_SHELF_EVIDENCE_2026_06_27.md`
- `docs/planning/AREA_02_GLASS_RIM_EXPANSION_2026_06_28.md`
- `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md`
- `docs/planning/PLAYABLE_EXPLORATION_SKELETON_2026_06_28.md`

## Immediate Issue Order

1. #679: build the Safe Shallows exploration shell with authored walls, side-to-side lanes, chambers, and cave pockets.
2. #680: add starter survival resource families: scrap/iron, driftwood or fiber, glass/quartz, food, and water.
3. #681: place those resources inside readable pockets so exploration teaches collection.
4. #682: tie one surface upgrade or night choice to starter resources.
5. #683: apply the reef visual kit to the larger shell rather than isolated landmarks.
6. #684 and #670: compact the survival objective, route/status, scan, and alert HUD around the new exploration loop.
7. #671-#677: continue visual direction work only where it supports the larger shell.
8. #685: add deterministic captures for the exploration shell.
9. #678: compare against the visual reference after the larger shell exists.
10. Resume architecture issues #640-#658 only in small slices when they reduce future implementation cost without replacing player-visible progress.

## Completed In This Readability Rescue

- #624 established the Area 01 visual hierarchy contract and made the readability blocker explicit.
- #625 quieted the Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket placeholder pileup.
- #626 reduced redundant normal-play route labels in the same cluster.
- #627 separated resources, knowledge payoffs, locked promises, and return/timing support into clearer color/opacity bands.
- #628 recorded deterministic `wide_reef_salvage_open` evidence in `docs/planning/AREA_01_READABILITY_EVIDENCE_2026_06_27.md`.
- The bounded decision review accepted Area 01 readability with watchlist after a tiny HUD/current-cue pass and four refreshed staged captures.
- #622 added one subtle salvage-pocket timing read after the Area 01 readability pass.
- #623 validated the Salvage Cutter Return Payoff milestone and moved the next direction to larger route progress.
- #637 and #638 fixed the active HUD overlap and clarified Emergency Week base-needs/result copy enough to resume one Area 02 payoff slice.
- #633 added one Outer Shelf cargo-vs-knowledge payoff choice.
- #634 made extraction results, recent expedition memory, and the next ready goal tease a compact Outer Shelf return hypothesis without adding checklist/map behavior.
- #635 added a quiet `RIM SEAL NEEDED` future promise beyond Glass Rim Cut so Area 02 has a remembered upgrade-return target without adding new route state.
- #636 added deterministic `outer_shelf_survey` staging and one targeted Playwright evidence capture path for the Area 02 route without changing durable progression.

## Current Readability Rules

- Resource pickups should remain the clearest cargo-like objects.
- Knowledge payoffs should use compact cyan or amber cores with subdued halos.
- Locked/future route promises should use darker mouths, quieter seals, and low-alpha glints.
- Return-current and timing support should stay lower-opacity than recoverable objects.
- Labels should be sparse and reserved for compact place names or honest locked/open states.
- Active HUD copy must use reserved stats/prompt/status rows; long commands or feedback should clip or be shortened instead of wrapping into neighboring text.
- Do not solve confusion by adding more bright shapes, exact locators, checklists, minimaps, or route graphs.

## Still Deferred

- Local clutter or readability work that does not make the playable level skeleton clearer.
- Starting with a bulky submarine-scale avatar; compact vehicles belong to later upgrades.
- Broader mobile/controller work beyond preserving semantic input guardrails.
- Final art overhaul, large UI reskin, broad visual regression suite, or golden-image infrastructure.
- Daylight multi-dive implementation until the timer/offload plan is split into small issues with tests.

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
