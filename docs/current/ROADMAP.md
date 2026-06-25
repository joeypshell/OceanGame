# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains the active milestone, immediate issue order, success gates, completed work, and deferred scope.

Current direction: build a 2D underwater roguelite about repeated dives into alien ocean biomes, where scanning, surviving, gathering, and monster hunting unlock deeper expeditions.

Detailed design rules live in:

- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/DAILY_RUNS.md`

Implemented behavior lives in `docs/current/GAMEPLAY.md`.

## Active Milestone

Progression And Run Variety Expansion.

Goal: move the most mature planning items into playable prototype work: practical resource scan outcomes, the first scan-gated upgrade, seeded risk variation, and a first special discovery opportunity. Keep each addition small, readable, and tied to the core dive-run question of continuing downward or returning safely.

## Immediate Issue Order

1. #32 Add first MCP integration for project tooling.
2. #33 Add practical resource scan outcomes.
3. #34 Add `Pressure Seal I` as first scan-gated upgrade.
4. #35 Add seeded hazard and creature route variation.
5. #36 Add first special discovery or wreck opportunity.

Issue #32 is a workflow/tooling track and can run independently of the gameplay sequence. Issues #33-#36 are the next gameplay planning items moved into current work.

## Latest Completed Milestone

Daily Run Feel And Readability.

Goal completed: the daily-run structure is clearer, fairer, and more playtestable. Deep reward routes now have a visual lure, predator danger is telegraphed before contact, run result telemetry supports repeatable playtests, and a first oxygen-margin tuning pass is documented.

This milestone comes directly from `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`.

Previous completed milestone:

Daily Roguelite Dive Runs.

Goal completed: the current authored slice can run as discrete daily dives with seeded resource variation, cluster patterns, result flow, a prototype upgrade bay, progression save/load, and a first milestone playtest report.

The playtest report found the system is directionally working, with follow-up risks around real-time oxygen margins, deep-reward visibility, and predator readability.

## Daily-Run Success Gate

The daily-run milestone succeeds only if controlled randomization creates meaningfully different player decisions.

Across tested seeds:

- At least one run should encourage a cautious shallow or midwater extraction.
- At least one run should tempt a deeper high-value route.
- At least one run should create a close oxygen return or failure.
- Rewards and risks must remain readable before the player commits.
- Predator encounters must be avoidable through observation or route choice.
- Resource depth-band identities must remain consistent.
- No seed should obscure the surface direction or safe return route.

Different placement is not enough. It must produce different decisions.

## Core Design Constraints

- Dive runs start from a surface boat or shallow lab, then push downward through a side-view ocean column.
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
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A side-view vertical dive scene and placeholder controllable submersible exist as the runtime foundation.
- The first scene includes a visible surface boat/shallow lab base, oxygen pressure, extraction, oxygen failure, run start/result panels, depth/base HUD, resource pickup, scanning, one upgrade, one route-control predator, and seeded starter resource placement.
- Current-dive state is split into `DiveSession`; session-persistent progression state is split into `ProgressionState`.
- Starter resource placement uses typed authored `SpawnPoint` nodes selected by the current run seed while preserving shallow, midwater, and deep resource bands.
- A first daily-run playtest report exists under `docs/planning/`, with follow-up risks around real-time oxygen margins and predator readability.
- Long-term progression has a single local prototype save slot; active dive state remains temporary.
- Low-oxygen and critical-oxygen HUD feedback increases return urgency without changing oxygen mechanics.
- A first oxygen-margin tuning pass reduced passive drain slightly to support deep-reward routes with one scan or one predator contact.

## Epics

- [x] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [x] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [x] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [ ] Epic: Ocean Readability And Feel
  Improve the prototype dive space so depth, risk, resources, and safe return are visually understandable without tutorial text.
- [ ] Epic: Progression And Run Variety Expansion
  Promote the next planning-ready systems into the prototype: practical resource scanning, one scan-gated upgrade, seeded risk variation, and one special discovery opportunity.
- [x] #27 Epic: Daily Run Feel And Readability
  Make seeded daily runs more readable, fair, and measurable before adding larger content systems.
- [x] Epic: Daily Roguelite Dive Runs
  Turn the authored slice into replayable daily dives with controlled randomization, clear run start/result flow, and data-driven placement rules.

## Completed Issues

- Completed: create engine scaffold and first scene.
- Completed: implement basic 2D underwater movement.
- Completed: add safe base and extraction interaction.
- Completed: add oxygen timer and run failure.
- Completed: reframe prototype around side-view dive descent.
- Completed: formalize dive/progression state, add resource banking, improve depth readability, add `Oxygen Tank I`, add scanner discoveries, and add the first route-control predator.
- Completed: add run start/result screens, deterministic run seeds, and seeded starter resource variation inside typed authored depth-band candidate points.
- Completed: add seeded resource cluster patterns and first daily-run milestone playtest report.
- Completed: add disk-backed progression save/load for long-term state only.
- Completed: add critical-oxygen and safe-return presentation feedback.
- Completed: add deep-reward visual lure, predator warning feedback, run telemetry/checklist, and oxygen-margin tuning pass.

## Deferred Work

- Large open-world ocean generation.
- Full procedural biomes.
- Full crafting economy, recipe trees, resource rarity tiers, stack sizes, grid inventory, or inventory rearranging.
- Physical cargo processing, base management, crafting minigames, elaborate environmental upgrades, or restaurant/colony systems.
- Multiple upgrade tiers beyond the first scan-gated `Pressure Seal I` slice.
- Combat or hunting systems beyond observation, warning, avoidance, and future setup.
- Full field guide UI beyond practical scan results.
- Disk save slots beyond one prototype progression save.
- Multiplayer.
- Polished art, animation, sound design, or final UI styling before the daily-run loop proves itself.
