# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains the active milestone, immediate issue order, success gates, completed work, and deferred scope.

Current direction: build a 2D underwater roguelite about repeated expeditions into alien ocean biomes, where scanning, surviving, gathering, and predator counterplay unlock deeper opportunities.

Detailed design rules live in:

- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/DAILY_RUNS.md`
- `docs/planning/GAME_VISION.md`
- `docs/planning/PROGRESSION_LADDER.md`
- `docs/planning/PREDATOR_INTERACTION_DIRECTION.md`
- `docs/planning/BLIND_VALIDATION_KIT.md`
- `docs/planning/SCANNER_IMPROVEMENT_I.md`
- `docs/planning/CARGO_IMPROVEMENT_I.md`
- `docs/planning/BURST_THRUSTER_MILESTONE.md`
- `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`
- `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`

Implemented behavior lives in `docs/current/GAMEPLAY.md`.
Implemented tooling lives in `docs/current/TOOLING.md`.

## Active Milestone

Scanner And Cargo Progression.

Goal: turn the pressure-wreck reward and early extraction economy into the next two concrete progression upgrades. The first-scan clarity fix and prototype `Burst Thruster` are complete, validation gates are skipped, and the project can now move into `Signal Lens I` and `Cargo Rack I`.

Current progression signal: the prototype now has resource scanning, a pressure-locked wreck route, `Wreck Signal Cache`, `Burst Thruster`, and an upgrade bay. The next milestone should make the scanner reward useful across future expeditions, then add one readable cargo-capacity upgrade.

## Immediate Issue Order

Tooling track:

No active tooling issues are currently queued.

Gameplay and validation track:

1. #59 Plan `Monster Observation I` progression slice.
2. #60 Add `Gulper Eel` observation scan.
3. #61 Plan first small biome pocket.
4. #62 Polish surface upgrade bay readability.
5. #63 Add recent expedition log.

Technical support track:

No active technical support issues are currently queued.

Later design and demo-readiness issues:

No active later design issues are currently queued.

Keep both issues narrow. Do not add a field guide, minimap, cargo grid, protected cargo, extra active tools, weapons, or new resource systems during this milestone.

## Rolling Backlog Policy

Maintain about 10 open actionable GitHub issues. When the queue drops below that target, expand planning docs first if needed, then create scoped issues with acceptance criteria, relevant docs/code areas, dependencies, and verification steps.

Do not create filler issues just to hit the number. Prefer a slightly smaller queue over vague epics, duplicate work, or issues for intentionally deferred systems.

## Active Milestone Success Gate

The milestone succeeds only when:

- #54 turns `Wreck Signal Cache` into a practical scanner upgrade without adding a minimap or field guide.
- #55 adds one extra cargo slot through the existing upgrade bay without changing extraction or oxygen-failure rules.
- The active issue queue remains stocked near the rolling target or any shortfall is explained by missing planning direction.
- Concrete follow-up issues are created only for newly observed confusion, boredom, unreadable cues, unfair risk, or unintended strategies.

Technical implementation alone is not sufficient.

## Progression Candidate Order

Choose from these candidates rather than starting all of them:

1. #62 upgrade bay readability polish.
2. #63 recent expedition log.
3. #59/#60 monster observation planning and first implementation.
4. #61 first small biome pocket planning.
5. After this batch, evaluate whether the next milestone should emphasize predator observation, monster-hunting setup, a new biome pocket, or a richer surface upgrade/result loop.

## Latest Completed Milestone

First-Scan Clarity And Prototype Burst.

Goal completed: first-time scan feedback now tells players what to do after scanning, and `Burst Thruster` is implemented as a non-lethal Spacebar tool that spends oxygen, has cooldown feedback, and preserves pressure-lock and predator rules.

Previous completed milestone:

Validation Prep And Readability.

Goal completed: the current prototype is ready to be tested with unfamiliar players. The project now has a blind validation kit, a route-readability/atmosphere pass, a scanner improvement plan, a cargo improvement plan, a Burst Thruster plan, and a project status review.

Previous completed milestone:

Seeded Expedition Feel And Readability.

Goal completed: the seeded-expedition structure is clearer, fairer, and more playtestable. Deep reward routes now have a visual lure, predator danger is telegraphed before contact, expedition result telemetry supports repeatable playtests, and a first oxygen-margin tuning pass is documented.

This milestone comes directly from `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`.

Earlier completed milestone:

Seeded Roguelite Expeditions.

Goal completed: the current authored slice can run as discrete seeded expeditions with resource variation, cluster patterns, result flow, a prototype upgrade bay, progression save/load, and a first milestone playtest report.

The playtest report found the system is directionally working, with follow-up risks around real-time oxygen margins, deep-reward visibility, and predator readability.

## Completed Seeded-Expedition Success Gate

The seeded-expedition milestone succeeds only if controlled randomization creates meaningfully different player decisions.

Across tested seeds:

- At least one expedition should encourage a cautious shallow or midwater extraction.
- At least one expedition should tempt a deeper high-value route.
- At least one expedition should create a close oxygen return or failure.
- Rewards and risks must remain readable before the player commits.
- Predator encounters must be avoidable through observation or route choice.
- Resource depth-band identities must remain consistent.
- No seed should obscure the surface direction or safe return route.

Different placement is not enough. It must produce different decisions.

## Core Design Constraints

- Expeditions start from a surface boat or shallow lab, then push downward through a side-view ocean column.
- The base is a functional hub, not a management sim. It exists to start dives, extract, show results, and buy upgrades.
- Extraction must provide emotional payoff: danger stops, cargo is counted visibly, discoveries and upgrades are acknowledged, and the next dive can begin quickly.
- Progression comes from repeated dives: gather materials, scan lifeforms, survive risk, extract, and upgrade the diver/submersible.
- `Oxygen Tank I` remains resource-gated only. Later upgrades may require a thematically related scan discovery.
- Randomization must preserve readable depth-band rules, surface direction, and safe return routes.
- Low-oxygen feedback may increase presentation urgency, but should not add decompression, ascent drain, or hidden oxygen penalties.
- Monster hunting should grow from observation first: scan, learn behavior, avoid danger, then later trap, wound, repel, or hunt specific predators.
- Every new mechanic should strengthen one question: should the player continue downward or return safely now?

## Current State

- The repository has an agentic workflow and planning structure.
- The repository includes an MCP context server for project-source documentation, including current status, validation, scanner, cargo, and future-tool plans.
- The first informal blind-validation signal was converted into implemented post-scan guidance; validation gates are no longer roadmap blockers.
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A side-view vertical dive scene and placeholder controllable submersible exist as the runtime foundation.
- The first scene includes a visible surface boat/shallow lab base, oxygen pressure, extraction, oxygen failure, run start/result panels, depth/base HUD, resource pickup, scanning, two upgrades, one pressure-locked wreck opportunity, one route-control predator, seeded starter resource/predator placement, and prototype `Burst Thruster`.
- Current-dive state is split into `DiveSession`; session-persistent progression state is split into `ProgressionState`.
- Starter resource placement uses typed authored `SpawnPoint` nodes selected by the current expedition seed while preserving shallow, midwater, and deep resource bands.
- A first seeded-expedition playtest report exists under `docs/planning/`, with follow-up risks around real-time oxygen margins, predator readability, and blind-player validation.
- Long-term progression has a single local prototype save slot; active dive state remains temporary.
- Low-oxygen and critical-oxygen HUD feedback increases return urgency without changing oxygen mechanics.
- A first oxygen-margin tuning pass reduced passive drain slightly to support deep-reward routes with one scan or one predator contact.
- The next backlog evaluation lives in `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`.
- The current project status review lives in `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`.

## Epics

- [x] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [x] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [x] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [x] Epic: Atmosphere And Presentation Pass
  Improve the prototype dive space so depth, risk, resources, safe return, and mood are visually understandable without tutorial text. This replaces the older overlapping ocean-readability label.
- [ ] Epic: Progression And Run Variety Expansion
  Promote the next planning-ready systems into the prototype: practical resource scanning, one scan-gated upgrade, seeded risk variation, and one special discovery opportunity.
- [x] #27 Epic: Daily Run Feel And Readability
  Make seeded expeditions more readable, fair, and measurable before adding larger content systems. Historical issue title retained.
- [x] Epic: Seeded Roguelite Expeditions
  Turn the authored slice into replayable seeded expeditions with controlled randomization, clear start/result flow, and data-driven placement rules.

## Completed Issues

- Completed: create engine scaffold and first scene.
- Completed: implement basic 2D underwater movement.
- Completed: add safe base and extraction interaction.
- Completed: add oxygen timer and run failure.
- Completed: reframe prototype around side-view dive descent.
- Completed: formalize dive/progression state, add resource banking, improve depth readability, add `Oxygen Tank I`, add scanner discoveries, and add the first route-control predator.
- Completed: add start/result screens, deterministic expedition seeds, and seeded starter resource variation inside typed authored depth-band candidate points.
- Completed: add seeded resource cluster patterns and first seeded-expedition milestone playtest report.
- Completed: add disk-backed progression save/load for long-term state only.
- Completed: add critical-oxygen and safe-return presentation feedback.
- Completed: add deep-reward visual lure, predator warning feedback, run telemetry/checklist, and oxygen-margin tuning pass.
- Completed: add first MCP context server for project tooling.
- Completed: add practical resource scan outcomes and deterministic scanner targeting feedback.
- Completed: generalize upgrade definitions, selection, state display, and purchase handling.
- Completed: add seeded `Gulper Eel` route variation through authored creature route spawn points.
- Completed: add visible pressure-locked research wreck, outside scan clue, safe boundary denial, and signal hint.
- Completed: add `Pressure Seal I` as the first scan-gated upgrade and open the pressure-locked wreck route to the `Wreck Signal Cache`.
- Completed: add progression save schema versioning and legacy/current/unknown-version migration behavior.
- Completed: add deterministic headless logic tests for core expedition and progression rules.
- Completed: extract narrow upgrade purchase, scanner targeting, and seeded spawn-selection helpers out of `main.gd`.
- Completed: evaluate repeat tactical scan costs and keep repeat scans free for the current prototype.
- Completed: hide raw seed, pattern, and result telemetry by default behind a simple development telemetry flag.
- Completed: plan the future non-lethal `Burst Thruster` active tool milestone.
- Completed: #46 prepare the blind validation kit for #37.
- Closed as impractical: #37 full two-helper blind validation requirement.
- Completed: #52 support lightweight facilitator summaries for validation evidence.
- Closed as skipped: #53 solo evidence pass.
- Completed: #51 clarify the post-scan next step in the first expedition.
- Completed: #50 add prototype `Burst Thruster` with oxygen cost and cooldown.
- Completed: #54 add `Signal Lens I` resource direction pulse.
- Completed: #55 add `Cargo Rack I` fourth cargo slot upgrade.
- Completed: #56 add compact scanner target preview metadata.
- Completed: #57 add expedition prep goal summary.
- Completed: #58 improve expedition result progress callouts.
- Completed: #47 add a narrow atmosphere and route-readability pass for blind validation.
- Completed: #48 plan `Signal Lens I` as Scanner Improvement I from the `Wreck Signal Cache`.
- Completed: #49 plan `Cargo Rack I` as the first cargo improvement.
- Completed: refresh project-wide status review, roadmap gate, README summary, and MCP planning context.

## Deferred Work

- Large open-world ocean generation.
- Full procedural biomes.
- Full crafting economy, recipe trees, resource rarity tiers, stack sizes, grid inventory, or inventory rearranging.
- Physical cargo processing, base management, crafting minigames, elaborate environmental upgrades, or restaurant/colony systems.
- Multiple upgrade tiers beyond the first scan-gated `Pressure Seal I` slice.
- Combat or hunting systems beyond observation, warning, avoidance, and future setup.
- Full field guide UI beyond practical scan results.
- Daily challenge mode with calendar-derived shared seeds.
- Disk save slots beyond one prototype progression save.
- Multiplayer.
- Polished art, animation, sound design, or final UI styling before the expedition loop proves itself.

## Future Tool Milestone

The first active non-lethal submersible tool is implemented:

- `Burst Thruster`: a short traversal or escape burst that spends oxygen, helps recover from predator mistakes, and creates a decision between immediate safety and return margin.

The plan lives in `docs/planning/BURST_THRUSTER_MILESTONE.md` as historical/current-reference context. Do not add multiple tools or weapons until the scanner/cargo progression milestone has a clearer next direction.
