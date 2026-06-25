# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains what should be tackled next and what should stay out of scope.

Current direction: build a 2D underwater roguelite about repeated dives into alien ocean biomes, where scanning, surviving, gathering, and monster hunting unlock deeper expeditions.

## Long-Term Loop Clarification

The intended game loop is closer to "Subnautica as daily roguelite dive runs" than to one fixed ocean map. Each dive should eventually feel like a run for that day: the player launches from the surface base with their persistent upgrades and knowledge, explores a randomized or reshuffled ocean layout, extracts whatever they can safely bring back, then uses the results to prepare for future dives.

Long-term run shape:

- Start from the surface boat/lab with persistent upgrades, banked resources, scan knowledge, and unlocked equipment.
- Generate or reshuffle the dive layout for the current day/run.
- Randomize or vary resource nodes, creature positions, hazards, wrecks, caves, and special discoveries within readable depth-band rules.
- Dive downward, make oxygen/cargo/risk decisions, and extract before failure.
- Bank extracted cargo; lose carried cargo on failure; keep scans, banked resources, upgrades, and long-term knowledge.
- Use between-run progression to reach deeper bands, survive more dangerous routes, and identify better opportunities on future dives.

The authored vertical slice is only the first proving ground. It should prove the core decision loop before procedural or randomized daily-run generation is added. Introduce randomization later in controlled layers: resource placement first, then hazards, then creature routes, then special discoveries.

## Design Pillars

- Dive runs start from a surface boat or shallow lab, then push downward through a side-view ocean column.
- Progression comes from repeated dives: gather materials, scan lifeforms, survive risk, extract, and upgrade the diver/submersible.
- The ocean should feel readable before it feels huge. Prefer authored prototype spaces, clear depth bands, and deliberate creature placement before procedural generation.
- Monster hunting should grow from observation first: scan, learn behavior, avoid danger, then later trap, wound, repel, or hunt specific predators.
- The base is a functional hub, not a management sim for now. It exists to start dives, extract, show results, and buy upgrades.
- Every new mechanic should strengthen one question: should the player continue downward or return safely now?

## Resolved Prototype Rules

- Player form: small submersible.
- Persistence: session persistence between dives; disk saves are deferred.
- Cargo: three slots.
- Failure: lose carried resources, retain scans, banked resources, and upgrades.
- Scanning: costs oxygen and reveals actionable information.
- Predator: controls access to deep rewards and causes oxygen loss plus knockback, not instant run failure.
- Upgrade pacing: `Oxygen Tank I` is purchasable after one ambitious dive or two cautious dives.
- Base: functional extraction and upgrade interface only.

## State Model

State should be split before resource collection is implemented.

Current-dive state:

- oxygen
- current cargo
- has left base
- current depth
- dive result

Persistent progression state:

- banked resources
- purchased upgrades
- scan discoveries
- best depth reached

Persistent means retained between dives during the current game session. Disk-backed saves are not required for the first vertical slice.

Expected near-term script shape:

```text
scripts/
  main.gd
  player.gd
  dive_session.gd
  progression_state.gd
  resource_definition.gd
```

## Current State

- The repository has an agentic workflow and planning structure.
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A minimal side-view vertical dive scene and placeholder controllable submersible exist as the runtime foundation.
- Placeholder underwater movement includes acceleration, drag, facing, and bounded vertical dive-area limits.
- The first scene includes a visible surface boat/shallow lab base where the player can trigger a successful extraction result.
- The first scene includes an oxygen timer, successful extraction before depletion, and placeholder failure when oxygen reaches zero.
- Dives start from a `Run Ready` panel and end with extraction/failure result summaries.
- Run state now tracks a session run number and deterministic seed for future placement variation.
- Starter resource placement now uses the current run seed to choose among authored candidate points while preserving shallow, midwater, and deep resource bands.
- Current-dive state is split into `DiveSession`; session-persistent progression state is split into `ProgressionState`.
- Extraction requires leaving the base before returning.
- The prototype has three cargo slots, three data-backed resource pickups by depth band, extraction banking, and carried-resource loss on oxygen failure.
- `Oxygen Tank I` can be purchased with banked starter resources and raises future dive max oxygen from 30 to 40.
- The scanner can scan `Lantern Fry`; scanning costs oxygen, records a discovery, and temporarily highlights nearby `Glow Plankton`.
- The scanner can scan `Thermal Vent`; scanning costs oxygen, records a discovery, and reveals a route hint plus hidden `Glow Plankton`.
- `Gulper Eel` patrols a deep route to a valuable `Glow Plankton`; contact causes oxygen loss, knockback, and brief movement disruption without instant failure.
- Re-scanning known discoveries does not cost oxygen and can refresh the discovery's practical effect.
- The HUD shows approximate depth, best depth, and base direction/distance; the scene uses landmarks and a deep glow hint to make return risk and deeper rewards easier to read.
- The initial design direction is selected, but most mechanics are still planning-level intent.

## Near-Term Epics

- [x] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [x] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [x] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [ ] Epic: Ocean Readability And Feel
  Improve the prototype dive space so depth, risk, resources, and safe return are visually understandable without tutorial text.
- [ ] Epic: Daily Roguelite Dive Runs
  Turn the authored slice into replayable daily dives with controlled randomization, a clearer run start/result flow, and data-driven placement rules.

## Immediate Issue Order

1. Add data-driven spawn point definitions
   Acceptance: resource, hazard, creature, and discovery candidate locations are represented as simple typed spawn point nodes or data instead of ad hoc scene placement.
   Verification: changing a spawn point definition changes what can appear there without editing core run logic.
2. Add lightweight upgrade menu
   Acceptance: the base exposes a compact upgrade menu that shows available upgrades, costs, owned status, and purchase feedback.
   Verification: buy `Oxygen Tank I` through the menu and confirm future dives still start with 40 oxygen.
3. Add second resource cluster pattern
   Acceptance: at least one alternative cluster pattern changes the route/cargo decision without adding new resource types.
   Verification: across several runs, one layout creates a cautious shallow/midwater route and another tempts a deeper reward path.
4. Add session save/load for progression
   Acceptance: banked resources, purchased upgrades, discoveries, and best depth can survive closing and reopening the project.
   Verification: save, quit/relaunch, load, and confirm session progression remains while current-dive cargo does not persist.
5. Create next milestone playtest report
   Acceptance: record observations from at least three generated runs and identify whether daily variation improves the return-or-continue decision.
   Verification: update `docs/current/GAMEPLAY.md` or a planning note with run observations, issues found, and follow-up tasks.

## Next Milestone: Daily Roguelite Dive Runs

Goal: prove the current authored slice can become a replayable daily run structure without losing readability.

This milestone should introduce controlled randomization in layers:

- Run start and result flow first, so each dive feels like a discrete attempt.
- A run/day seed second, so variation has a stable place to live.
- Starter resource placement third, using authored depth-band candidate points.
- Spawn point data fourth, so future hazards, creatures, discoveries, and resource clusters can share the same placement model.
- Upgrade menu and session save/load after the run loop is clearer.

Promoted from previous out-of-scope:

- Controlled randomization of resource placement.
- Lightweight procedural layout rules through authored candidate points.
- Better run results flow.
- Compact upgrade interface.
- Disk-backed save/load for progression, but only after run state is separated from progression state.

Still intentionally deferred:

- Large open-world ocean generation.
- Full procedural biomes.
- Full crafting economy.
- Combat or hunting.
- Base upgrading.
- Multiple upgrade tiers.
- Polished art/audio.
- Full field guide.

Design rule: randomization should preserve readable depth-band rules. A run can surprise the player with where rewards and risks appear, but it should not make the surface, deeper direction, base return route, or approximate risk level confusing.

## First Vertical Slice Target

The first satisfying slice should answer: "Can I dive down, find something useful or strange, decide whether to go deeper, and return before oxygen runs out?"

Target behavior:

- Start at the surface boat/lab with full oxygen.
- Dive into a vertical ocean column with shallow, midwater, and deep bands.
- Track approximate current depth and best depth reached.
- Carry at most three resource pickups before extraction.
- Pick up three early resources:
  - `Kelp Fiber`: common shallow crafting material.
  - `Shell Fragments`: mid-depth material that encourages leaving the surface.
  - `Glow Plankton`: rarer deeper material that hints at risk/reward.
- Extract at the surface base to bank collected resources.
- Lose carried resources on oxygen failure while retaining banked resources, scans, and upgrades.
- Spend resources on `Oxygen Tank I`, increasing max oxygen from 30 to 40 for future dives.
- Scan a passive creature and receive actionable information, not just a field-guide entry.
- Encounter one deeper predator that controls access to a valuable area.

## First Upgrade Shape

- `Oxygen Tank I`
  Cost: `2 Kelp Fiber`, `1 Shell Fragment`, `1 Glow Plankton`.
  Effect: increases max oxygen from 30 to 40.
  Reason: oxygen is already the core pressure system, so this validates persistent progression without adding a full crafting economy.
  Pacing note: because cargo has three slots and this costs four total resources, the upgrade requires at least two successful banking dives in the current slice.

Future upgrade candidates:

- `Pressure Seal I`: allows entry below a depth gate.
- `Cargo Pouch I`: increases retained pickups per dive.
- `Scanner Range I`: lets the player scan from farther away.
- `Fin Tuning I`: improves acceleration or drag.

## First Creature / Ecology Shape

- `Lantern Fry`: passive fish-like creature that travels near `Glow Plankton`.
  Scan outcome: nearby `Glow Plankton` pulses on the HUD for several seconds.
- Drifting jelly-like creature: slow vertical bobbing in midwater, maybe harmless contact later.
- Predator placeholder: patrols a deeper band and teaches route planning.
  Behavior: patrol between two points, detect the player within a radius, chase briefly, return to patrol, and cause oxygen loss plus knockback on contact.

Keep creature behavior data simple at first: patrol points, speed, scan entry, contact consequence, and depth band.

## Oxygen Decision Rules

Keep passive oxygen drain, but add one action-pressure layer:

- Passive drain: 1 oxygen per second.
- Collect resource: 1 oxygen.
- Complete scan: 2 oxygen.
- Predator contact: 5 oxygen.

Depth-based oxygen modifiers are deferred until pressure equipment exists. The immediate goal is to make the player ask, "I can return safely, but can I afford one more action?"

## Scanner Outcome Rules

The scanner must be useful from its first implementation.

- Resource scan: reveals where the resource occurs and what upgrade uses it; may highlight nearby matching nodes briefly.
- Creature scan: reveals movement pattern, aggression trigger, safe distance, or avoidance behavior.
- Environmental scan: reveals a route, hidden resource cluster, oxygen refill location, or future depth-gate clue.

The first discovery UI should be a small panel, not a full field guide:

```text
Discoveries: 2 / 3

Kelp Fiber
Lantern Fry
???
```

Each entry only needs a name, one-sentence description, and one gameplay fact.

## Playtest Gates

First-loop validation:

- A fresh player can identify the surface base without being told.
- A fresh player can identify which direction is deeper.
- A fresh player can see at least one reward before leaving safety.
- A fresh player understands that carried resources are not banked yet.
- A fresh player can return to base without searching for it.
- A fresh player can explain why they turned around.

Risk validation:

- Across three test dives, at least one dive ends in an early cautious extraction.
- Across three test dives, at least one dive involves pursuing a deeper reward.
- Across three test dives, at least one dive creates a close oxygen return or oxygen failure.
- If every run feels identical, the risk model is not working.

Upgrade validation:

- After buying `Oxygen Tank I`, the player reaches a location that previously felt unsafe or completes one additional action before returning.
- The effect should be felt without relying on a numerical explanation.

## Revised Required Vertical Slice

Required:

- Surface base
- Vertical authored dive area
- Three depth bands
- Oxygen pressure
- Three cargo slots
- Three resource types
- Extraction and banking
- Resource loss on failure
- One oxygen upgrade
- One passive creature
- One useful scanner interaction
- One deeper predator controlling a valuable area

Not required yet:

- Full field guide UI
- Multiple upgrade tiers
- Crafting recipes
- Multiple predator types
- Combat or hunting
- Procedural layouts
- Base upgrading
- Disk save slots
- Complex creature ecology
- Resource respawn logic beyond restarting a dive

## Current Completed Issues

- Completed: create engine scaffold and first scene.
- Completed: implement basic 2D underwater movement.
- Completed: add safe base and extraction interaction.
- Completed: add oxygen timer and run failure.
- Completed: reframe prototype around side-view dive descent.
- Completed: formalize dive/progression state, add resource banking, improve depth readability, add `Oxygen Tank I`, add scanner discoveries, and add the first route-control predator.
- Completed: add run start/result screens, deterministic run seeds, and seeded starter resource variation inside authored depth-band candidate points.

## Out Of Scope For Now

- Large open-world ocean generation.
- Full crafting economy, recipe trees, resource rarity tiers, stack sizes, grid inventory, or inventory rearranging.
- Multiplayer.
- Complex colony, settlement, or restaurant management.
- Full Pokemon-style capture, breeding, or party battle systems.
- Boss rush or extensive weapon roster before the first dive loop is fun.
- Polished art, animation, sound design, or final UI styling before the first loop proves itself.
- Procedural biomes before the authored vertical slice is readable and fun.
- Full field guide categories, tabs, search, sorting, illustrations, or detailed lore.

## Tooling / Testing Work

- CI runs Godot headless launch and `git diff --check`.
- Add automated smoke tests for project launch if supported by the engine.
- Add content validation for data-driven creatures, resources, upgrades, and biomes.

## Later Design Questions

- Are monsters primarily hunted, studied, trapped, or harvested?
- How much of the ocean should be authored versus procedurally rearranged per run?
