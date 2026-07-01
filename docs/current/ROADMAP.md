# Current Roadmap

This is the compact active roadmap for issue-driven work. Historical issue batches and completed milestone detail live in `docs/current/PROJECT_INDEX.md` and `docs/archive/ROADMAP_HISTORY_2026_06_27.md`.

## Current Direction

OceanGame is a 2D alien-ocean survival expedition roguelite. Each expedition starts from the surface boat/lab with a small diver-scale avatar, sends the player into persistent side-view geography with seeded daily variation, and asks them to return with whatever matters most: supplies that keep the base alive tonight, cargo that improves future dives, or knowledge that unlocks the deeper mystery.

North-star filter: every expedition should force a survival tradeoff. Bring back what keeps you alive tonight, what makes future dives safer, or what unlocks a remembered deeper place. Prefer player-visible loop progress over more route breadth until the survival day rhythm works.

Loop direction selected for the next planning pass: the game should move toward a compact side-view Subnautica-like day/night survival loop. A top-level sun-to-moon timer is the day budget; oxygen is a tactical sortie budget refilled by open surface water; health is a separate danger meter; cargo banks only at the ship through a fast offload action; night owns building, crafting, upgrades, lab analysis, food/power needs, and tomorrow preparation. Planning notes: `docs/planning/SUBNAUTICA_DAY_NIGHT_RECALIBRATION_2026_06_30.md` and `docs/planning/DAYLIGHT_MULTI_DIVE_LOOP_PLAN_2026_06_28.md`.

Map and terrain work for that loop is governed by `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md`: machine-readable map source, deterministic converter/importer, generated runtime geometry, generated source/runtime/diff previews, Godot builder/importer, then screenshot confirmation. Concept art and screenshots can guide visual style or final review, but they are not valid topology, collision, route, or hook sources.

## Active Milestone

Survival Day/Night Loop Closeout.

The next milestone is to make the implemented survival day understandable in normal play before more route/content expansion. The prototype now has the core pieces for a survival day: open surface oxygen refill, ship offload, a visible day timer, health as real danger, and food/power night resolution. The active goal is to prove the loop as a readable player experience: the player should understand when to surface, when to bank cargo, what night changed, and what to try tomorrow.

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

The next Survival Day/Night loop payoff batch should make the implemented loop create better player choices before adding route breadth:

1. #752 Make dawn pick one main day priority.
2. #753 Make weak-need supply choices readable before pickup.
3. #754 Warn about late-day banking risk before nightfall.
4. #755 Make night health recovery rules explicit after damage.
5. #756 Make recent expeditions remember survival tradeoffs.

The previous Survival Day/Night loop closeout batches were resolved in this order:

1. #741 Make a two-sortie day readable end-to-end in normal play.
2. #742 Add a pauseable expedition slate for needs, cargo, known requirements, and remaining daylight.
3. #743 Make starter resource roles obvious in collection, offload, and night/result copy.
4. #744 Make the night result create a clear tomorrow plan.
5. #745 Define nightfall away from ship as a real day-pressure consequence.
6. #747 Prove normal-play desktop loop visuals stay clean.
7. #748 Make cargo capacity and ship offload pressure readable across two sorties.
8. #749 Make one build or upgrade choice create a concrete tomorrow plan.
9. #750 Make health damage feedback distinct from oxygen pressure.
10. #751 Connect starter resources to a remembered next-day target.

After the survival-loop closeout, #734 added the first generated Area 01 wall-sprite visual pass: the generated continuous terrain domain now renders as the reef mass, playable-water regions render as source-owned water apertures, and generated cave-wall sprites decorate cave/pocket edges without owning collision.

Area 01 source-map/runtime work should resume only where it directly supports open surface, seafloor holes, cave pockets, ship return, or the generated source-grid pipeline. The deterministic Area 01 source-grid-to-runtime-geometry pipeline is already implemented; do not reopen manual polygon rescue or runtime-v3 parity work as the next milestone.

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
- #735 through #740 were closed as already satisfied by the current implementation: daylight timer, open-surface oxygen refill, daylight ship offload, repeated sorties, health damage/failure, and food/power night resolution are present in code, current docs, and quick-tier tests.
- #741 through #745 closed the current Survival Day/Night loop pass: two-sortie readability, the expedition slate, starter resource role copy, tomorrow-plan result copy, and a deterministic late-return consequence when nightfall catches the player away from the ship.
- #734 added a generated Area 01 wall-sprite visual pass over the source-grid runtime: continuous source-owned terrain mass, visible playable-water apertures, generated cave-edge sprites, hidden diagnostic Line2D edges, and collision still owned by generated solid partitions.

## Current Readability Rules

- Resource pickups should remain the clearest cargo-like objects.
- Knowledge payoffs should use compact cyan or amber cores with subdued halos.
- Locked/future route promises should use darker mouths, quieter seals, and low-alpha glints.
- Return-current and timing support should stay lower-opacity than recoverable objects.
- Labels should be sparse and reserved for compact place names or honest locked/open states.
- Active HUD copy must use reserved stats/prompt/status rows; long commands or feedback should clip or be shortened instead of wrapping into neighboring text.
- Area 01 collision boundaries must be readable as terrain lips/rims before contact; do not leave invisible or random-feeling blockers in normal play.
- Area 01 collision, terrain, pockets, scannables, and route hooks must map to `data/maps/area_01_source_grid_v1.json` through generated `data/maps/area_01_runtime_geometry.generated.json`, or the source grid/converter must be updated before the scene changes.
- During Area 01 wall rescue, do not hand-place separate wall visuals, collision, or lips; they must be generated from the same source-map polygon.
- Area 01 is now source-grid-first: update the machine-readable grid, run `node .\tools\build-area01-map.mjs --validate --write --previews`, and let generated visible/colliding `solid_terrain` partitions fill terrain around playable water. Do not hand-author isolated `solid_terrain` chunks as the primary map source, and do not draw a player-facing terrain domain that is not also collision.
- Follow `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md` for Area 01 and future map work. Do not use arbitrary generated concept images, screenshots, or hand-placed Godot polygons as collision/topology authority.
- Passive creature scan targets need visible silhouettes or outlines at normal play scale; scan labels should confirm the target, not be the only way to perceive it.
- Do not spend another batch polishing a tiny room if the level bones still do not support wider exploration. Block out readable map scale first, then decorate.
- Do not solve confusion by adding more bright shapes, exact locators, checklists, minimaps, or route graphs.

## Still Deferred

- Local clutter or readability work that does not make the playable level skeleton clearer.
- Broad `main.gd` architecture/refactor batches; reintroduce them only when a specific survival-loop issue is blocked by module size or ownership risk.
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
For player-visible survival-loop work, visual evidence is part of acceptance when the change affects HUD readability, camera framing, normal-play screen cleanliness, resource/cargo feedback, or night/result layout. Inspect the generated screenshots before closing the issue; passing Playwright only proves the state was reached.

For the current Area 01 shell, prefer the targeted command before manual screenshot wandering:

```powershell
npm run test:area01-shell-captures
```
