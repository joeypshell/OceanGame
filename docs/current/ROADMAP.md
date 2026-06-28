# Current Roadmap

This is the compact active roadmap for issue-driven work. Historical issue batches and completed milestone detail live in `docs/current/PROJECT_INDEX.md` and `docs/archive/ROADMAP_HISTORY_2026_06_27.md`.

## Current Direction

OceanGame is a 2D alien-ocean survival expedition roguelite. Each expedition starts from the surface boat/lab with a small diver-scale avatar, sends the player into persistent side-view geography with seeded daily variation, and asks them to return with whatever matters most: supplies that keep the base alive tonight, cargo that improves future dives, or knowledge that unlocks the deeper mystery.

North-star filter: every expedition should force a survival tradeoff. Bring back what keeps you alive tonight, what makes future dives safer, or what unlocks a remembered deeper place. Prefer player-visible loop progress over more route breadth until the survival day rhythm works.

Loop direction under review: the next survival-loop shape is a daylight multi-dive expedition day. A top-level sun-to-moon timer would become the day budget; oxygen would become a tactical sortie budget that can be refilled by surfacing; cargo would only bank at the ship through a fast offload action; night would own upgrades, crafting, lab analysis, and Emergency Week resolution. Planning note: `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md`.

## Active Milestone

First Playable Area 01 Blockout Skeleton.

The next milestone is a correction pass before more route/content expansion. The prototype has enough working systems to prove the loop shape, but the playable map is still too small and its collision/art relationship has not been trustworthy enough. The active goal is to build a larger Safe Shallows-style Area 01 blockout with obvious open water, visible solid reef boundaries, ledges, cave pockets, resource spaces, and enough room to explore sideways and downward. Visual work remains active only where it makes the larger blockout easier to parse.

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
- `docs/planning/FIRST_REAL_2D_ENVIRONMENT_SLICE_2026_06_28.md`

## Immediate Issue Order

1. #692: add cave-mouth affordances without exact route locators.
2. #693: validate the larger level skeleton before returning to more visual polish.
3. Re-evaluate #675-#678 after the skeleton validation; keep only the parts that support the larger playable map.
4. Resume architecture issues #640-#658 only in small slices when they reduce future implementation cost without replacing player-visible progress.

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
- #686 built the first real Area 01 art/playability slice and hid the debug-like broad exploration shell in normal play.
- #681 placed starter resource candidates into four readable Area 01 pockets so supplies and materials start teaching the room layout.
- #683 added reusable reef-wall and resource-pocket visual modules to the Area 01 shell walls, starter ledges, and resource pockets.
- #684/#670 replaced the active route/status text stack with one compact `SURVIVAL ROUTE` objective card, contextual scan card behavior, and reserved prompt/status rows.
- #682 added `Water Filter I`, a first starter-material upgrade that spends `Driftwood` and `Quartz Glass` for an immediate `+1 Water` reserve so shallow resource pockets feed the Emergency Week loop.
- #685 added a cheap targeted Area 01 Playwright capture workflow for `area01-surface-entry`, `area01-left-shelf-cave`, `area01-right-shelf-pocket`, and `area01-central-drop`.
- #671 added a reusable Area 01 ocean lighting stack with brighter surface wash, stronger blue depth haze, subtle play-space light, caustic ribbons, and edge/lower vignettes so the first room reads less flat without changing gameplay.
- #672 added a reusable Area 01 parallax-background scene with distant reef walls, stepped shelves, open-water pockets, mid-depth plates, and deep silhouettes so the room reads more like layered geography than flat teal bands.
- #673 added a reusable Area 01 reef-platform kit and placed it on the starter shelves/ledges so terrain reads more like stacked explorable reef platforms while collision and route ownership stay unchanged.
- #674 added restrained reusable Area 01 dressing clusters with kelp, coral, dim crystals, tube coral, and pebbles around existing shelves/pockets so the room feels more authored without adding collectible or scan behavior.
- #687 added dedicated Area 01 blocking-rim visuals that trace existing wall and ledge collision so players can see where terrain blocks movement before bumping into it.
- #688 restored Glassfin Swarm readability with dark body outlines and brighter clustered fish shapes while preserving its passive, scan-only, non-colliding behavior.
- #689 removed the misleading shallow upper-water blockers, disabled their collision, and started a larger Area 01 blockout with visible solid reef masses and matching collision/lip reads.
- #690 added left/right chamber framing masses with matching collision and visible lips so Area 01 starts reading less like one tiny room and more like a larger level skeleton.
- #691 added left/right chamber resource-pocket anchors and spread starter survival/material candidates into the larger shell so collection starts teaching movement beyond the original pocket cluster.

## Current Readability Rules

- Resource pickups should remain the clearest cargo-like objects.
- Knowledge payoffs should use compact cyan or amber cores with subdued halos.
- Locked/future route promises should use darker mouths, quieter seals, and low-alpha glints.
- Return-current and timing support should stay lower-opacity than recoverable objects.
- Labels should be sparse and reserved for compact place names or honest locked/open states.
- Active HUD copy must use reserved stats/prompt/status rows; long commands or feedback should clip or be shortened instead of wrapping into neighboring text.
- Area 01 collision boundaries must be readable as terrain lips/rims before contact; do not leave invisible or random-feeling blockers in normal play.
- Passive creature scan targets need visible silhouettes or outlines at normal play scale; scan labels should confirm the target, not be the only way to perceive it.
- Do not spend another batch polishing a tiny room if the level bones still do not support wider exploration. Block out readable map scale first, then decorate.
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

For the current Area 01 shell, prefer the targeted command before manual screenshot wandering:

```powershell
npm run test:area01-shell-captures
```
