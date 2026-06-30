# Current Roadmap

This is the compact active roadmap for issue-driven work. Historical issue batches and completed milestone detail live in `docs/current/PROJECT_INDEX.md` and `docs/archive/ROADMAP_HISTORY_2026_06_27.md`.

## Current Direction

OceanGame is a 2D alien-ocean survival expedition roguelite. Each expedition starts from the surface boat/lab with a small diver-scale avatar, sends the player into persistent side-view geography with seeded daily variation, and asks them to return with whatever matters most: supplies that keep the base alive tonight, cargo that improves future dives, or knowledge that unlocks the deeper mystery.

North-star filter: every expedition should force a survival tradeoff. Bring back what keeps you alive tonight, what makes future dives safer, or what unlocks a remembered deeper place. Prefer player-visible loop progress over more route breadth until the survival day rhythm works.

Loop direction selected for the next planning pass: the game should move toward a compact side-view Subnautica-like day/night survival loop. A top-level sun-to-moon timer is the day budget; oxygen is a tactical sortie budget refilled by open surface water; health is a separate danger meter; cargo banks only at the ship through a fast offload action; night owns building, crafting, upgrades, lab analysis, food/power needs, and tomorrow preparation. Planning notes: `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md` and `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md`.

## Active Milestone

Survival Day/Night Loop Recalibration.

The next milestone is a direction reset before more route/content expansion. The prototype has enough systems to prove a survival day, but current planning is split between older one-oxygen-run assumptions, Area 01 blockout rescue, Emergency Week needs, and newer surface/refill/offload ideas. The active goal is to make the player loop coherent: open surface for oxygen, ship offload for cargo, a visible day timer, health as real danger, resources that matter at night, and a small night build/upgrade phase.

Area 01 blockout work remains important only where it supports the new loop: open surface, continuous seafloor, cave holes, readable ship return, starter resource pockets, and enough shallow/deep contrast to make repeated sorties meaningful.

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
- `docs/planning/AREA_01_BLOCKOUT_SOURCE_MAP_2026_06_28.md`
- `docs/planning/FIRST_REAL_2D_ENVIRONMENT_SLICE_2026_06_28.md`
- `docs/planning/AREA_01_SKELETON_VALIDATION_2026_06_28.md`
- `docs/planning/AREA_01_AUTHORITATIVE_WALL_MAP_2026_06_29.md`
- `docs/planning/AREA_01_MODULAR_WALL_ART_SYSTEM_2026_06_29.md`
- `docs/planning/AREA_01_SURFACE_FLOOR_SOURCE_MAP_2026_06_29.md`
- `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md`

## Immediate Issue Order

1. Align docs and open issues around `SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md` so future work stops mixing old one-run assumptions with the new day loop.
2. Add the visible daylight sun-to-moon timer as a state/display slice before adding more route breadth.
3. Add open-surface oxygen refill zones that do not bank cargo.
4. Add one-button ship/moonpool offload so cargo banking is distinct from surfacing.
5. Allow repeated dive sorties inside one daylight day.
6. Add a basic health meter and one controlled damage source so health and oxygen read as different survival risks.
7. Reclassify starter resources into food, power, building material, and research value, then make the night screen consume or use at least food and power.
8. Return to Area 01 source-map/runtime work only as needed to support open surface, seafloor holes, cave pockets, and repeated surface-to-ship routing.

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
- #694 created the Area 01 blockout source map and validation contract so walls, playable water lanes, resource pockets, and scannable reachability can be checked before more content expands the level.
- #695 added a developer-only Area 01 source-map overlay toggle so playable lanes, mapped collision, pockets, resources, scannables, and scan range can be inspected without manual screenshot guessing.
- #696 moved Area 01 pocket anchors and starter spawn points out of enabled collision, widened the left world bound to remove an invisible clamp, and aligned the source-map lanes with the current larger shell.
- #692 added source-map-backed cave-mouth affordances so reachable openings, solid reef, and quiet future seals read differently without exact route markers, labels, new interiors, or new collision.
- #693 validated the larger Area 01 skeleton and decided one more level-bones pass is needed before broad visual polish; #697 is now the next active issue.
- #697 expanded Area 01 with far-west, mid-crossing, deep-spine, and far-right blockout terrain; added matching collision and lip reads; updated the source-map lanes; and added deterministic capture states for the expanded footprint.
- A source-map-driven Area 01 wall builder now applies the same authored polygon to visible walls, collision, and rims so the first playable shell can stop drifting between art and blockers.

## Current Readability Rules

- Resource pickups should remain the clearest cargo-like objects.
- Knowledge payoffs should use compact cyan or amber cores with subdued halos.
- Locked/future route promises should use darker mouths, quieter seals, and low-alpha glints.
- Return-current and timing support should stay lower-opacity than recoverable objects.
- Labels should be sparse and reserved for compact place names or honest locked/open states.
- Active HUD copy must use reserved stats/prompt/status rows; long commands or feedback should clip or be shortened instead of wrapping into neighboring text.
- Area 01 collision boundaries must be readable as terrain lips/rims before contact; do not leave invisible or random-feeling blockers in normal play.
- Area 01 collision, terrain, pockets, and scannables must map to `docs/planning/maps/area_01_blockout_source_map_v1.json`, or the source map must be updated before the scene changes.
- During Area 01 wall rescue, do not hand-place separate wall visuals, collision, or lips; they must be generated from the same source-map polygon.
- Passive creature scan targets need visible silhouettes or outlines at normal play scale; scan labels should confirm the target, not be the only way to perceive it.
- Do not spend another batch polishing a tiny room if the level bones still do not support wider exploration. Block out readable map scale first, then decorate.
- Do not solve confusion by adding more bright shapes, exact locators, checklists, minimaps, or route graphs.

## Still Deferred

- Local clutter or readability work that does not make the playable level skeleton clearer.
- Starting with a bulky submarine-scale avatar; compact vehicles belong to later upgrades.
- Broader mobile/controller work beyond preserving semantic input guardrails.
- Final art overhaul, large UI reskin, broad visual regression suite, or golden-image infrastructure.
- Route expansion, broad terrain-art polish, and deeper biome growth until the daylight/surface/offload/night loop is playable.

## Stable Guardrails

- Preserve current gameplay behavior unless an issue explicitly asks for a gameplay change.
- Before closing milestone, Area 01 source-map, visual-truth, or capture-state issues, use `docs/current/SOURCE_OF_TRUTH_GUARDRAIL.md` to keep README, ROADMAP, GAMEPLAY, planning anchors, source maps, and capture manifests aligned.
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
