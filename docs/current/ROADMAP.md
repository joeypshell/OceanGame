# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains the active milestone, immediate issue order, success gates, completed work, and deferred scope.

Current direction: build a 2D underwater roguelite about repeated dives into alien ocean biomes, where scanning, surviving, gathering, and monster hunting unlock deeper expeditions.

Detailed design rules live in:

- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/DAILY_RUNS.md`

Implemented behavior lives in `docs/current/GAMEPLAY.md`.

## Active Milestone

Daily Roguelite Dive Runs.

Goal: prove the current authored slice can become replayable daily dive runs where seeded variation creates meaningfully different route, cargo, scan, and turnaround decisions without losing readability.

The main strategic focus is validation: finish evaluating daily-run variation before adding more progression infrastructure or more content.

## Immediate Issue Order

1. Add lightweight upgrade menu
   Acceptance: the surface base exposes a compact upgrade menu showing available upgrades, resource costs, owned status, and purchase feedback. Extraction results visibly count carried resources into the persistent bank before the menu is shown.
   Verification: bank the required resources, purchase `Oxygen Tank I`, begin a new dive, and confirm max oxygen is 40.
2. Add second resource cluster pattern
   Acceptance: at least one seeded pattern offers a cautious shallow/midwater route, while another visibly tempts the player toward a deeper reward near the predator-controlled route. All placements must preserve authored depth-band and return-route readability rules.
   Verification: test at least five seeds and confirm that the patterns create different route, cargo, or turnaround decisions rather than merely changing object positions.
3. Create daily-run milestone playtest report
   Acceptance: document observations from at least five generated runs and determine whether seeded variation improves the continue-or-return decision. Record route choices, turnaround points, close returns, failures, unreadable placements, and unavoidable hazards.
   Verification: update a planning or playtest document with findings and create focused follow-up issues for problems discovered.
4. Add disk-backed progression save/load
   Acceptance: banked resources, purchased upgrades, discoveries, and best depth survive closing and reopening the project. Active-dive oxygen, current cargo, active run state, and temporary effects are never restored.
   Verification: save progression, close and relaunch the project, load the save, and confirm only long-term progression is restored.
5. Add critical-oxygen and safe-return feedback
   Acceptance: low oxygen increases presentation urgency without changing the established oxygen-cost model. Below 25% oxygen, the HUD becomes more urgent. Below 10%, the game adds stronger warning feedback and emphasizes the direction and distance to the surface base.
   Verification: complete a low-oxygen return and confirm the feedback increases tension while the return remains mechanically predictable.

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

## Epics

- [x] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [x] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [x] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [ ] Epic: Ocean Readability And Feel
  Improve the prototype dive space so depth, risk, resources, and safe return are visually understandable without tutorial text.
- [ ] Epic: Daily Roguelite Dive Runs
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

## Deferred Work

- Large open-world ocean generation.
- Full procedural biomes.
- Full crafting economy, recipe trees, resource rarity tiers, stack sizes, grid inventory, or inventory rearranging.
- Physical cargo processing, base management, crafting minigames, elaborate environmental upgrades, or restaurant/colony systems.
- Multiple upgrade tiers.
- Combat or hunting systems.
- Full field guide UI.
- Disk save slots beyond one prototype progression save.
- Multiplayer.
- Polished art, animation, sound design, or final UI styling before the daily-run loop proves itself.
