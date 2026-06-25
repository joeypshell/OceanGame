# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains what should be tackled next and what should stay out of scope.

Current direction: build a 2D underwater roguelite about repeated dives into alien ocean biomes, where scanning, surviving, gathering, and monster hunting unlock deeper expeditions.

## Design Pillars

- Dive runs start from a surface boat or shallow lab, then push downward through a side-view ocean column.
- Progression comes from repeated dives: gather materials, scan lifeforms, survive risk, extract, and upgrade the diver/submersible.
- The ocean should feel readable before it feels huge. Prefer authored prototype spaces, clear depth bands, and deliberate creature placement before procedural generation.
- Monster hunting should grow from observation first: scan, learn behavior, avoid danger, then later trap, wound, repel, or hunt specific predators.
- The base is a functional hub, not a management sim for now. It exists to start dives, extract, show results, and buy upgrades.

## Current State

- The repository has an agentic workflow and planning structure.
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A minimal side-view vertical dive scene and placeholder controllable submersible exist as the runtime foundation.
- Placeholder underwater movement includes acceleration, drag, facing, and bounded vertical dive-area limits.
- The first scene includes a visible surface boat/shallow lab base where the player can trigger a successful extraction result.
- The first scene includes an oxygen timer, successful extraction before depletion, and placeholder failure when oxygen reaches zero.
- The initial design direction is selected, but most mechanics are still planning-level intent.

## Near-Term Epics

- [ ] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [ ] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [ ] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [ ] Epic: Ocean Readability And Feel
  Improve the prototype dive space so depth, risk, resources, and safe return are visually understandable without tutorial text.

## Immediate Issue Order

- Add first resources and upgrade
  Acceptance: the player can collect three resources placed across shallow and mid-depth zones, extract them successfully, and spend them on one persistent oxygen upgrade.
  Verification: collect resources, extract, buy the oxygen upgrade, restart, and confirm the new oxygen value applies.
- Add scanner and field guide stub
  Acceptance: the player can scan at least one resource node, one passive creature placeholder, and one environmental point of interest; discovered entries appear in a basic field guide view.
  Verification: scan entries at different depths, return to base, reopen the field guide, and confirm discoveries remain visible in the session.
- Add passive creature movement
  Acceptance: at least two simple non-hostile ocean creatures move in readable patterns and can coexist with resource pickups.
  Verification: launch the scene, observe creatures moving without blocking extraction or player bounds, and confirm existing oxygen/extraction behavior still works.
- Add one predator hazard
  Acceptance: one dangerous creature patrols a deeper band and can force a placeholder failure, oxygen penalty, or knockback when contacted.
  Verification: encounter the predator, confirm its consequence triggers, then restart and confirm a safe extraction path still exists.
- Add depth readability pass
  Acceptance: the scene communicates shallow, midwater, and deep areas with simple visuals, depth markers, and resource/creature placement that rewards downward exploration.
  Verification: launch the scene and confirm the player can understand where the surface, safe base, deeper risk, and return route are.

## First Vertical Slice Target

The first satisfying slice should answer: "Can I dive down, find something useful or strange, decide whether to go deeper, and return before oxygen runs out?"

Target behavior:

- Start at the surface boat/lab with full oxygen.
- Dive into a vertical ocean column with shallow, midwater, and deep bands.
- Pick up three early resources:
  - `Kelp Fiber`: common shallow crafting material.
  - `Shell Fragments`: mid-depth material that encourages leaving the surface.
  - `Glow Plankton`: rarer deeper material that hints at risk/reward.
- Extract at the surface base to bank collected resources.
- Spend resources on `Oxygen Tank I`, increasing max oxygen for future dives.
- Scan at least three discoveries:
  - a passive creature
  - a resource node
  - a point of interest such as a vent, wreck fragment, or alien coral
- Encounter one deeper predator or hazard later, after the resource/scan loop is stable.

## First Upgrade Shape

- `Oxygen Tank I`
  Cost: a small mix of all three starter resources.
  Effect: increases max oxygen enough that the second dive obviously lasts longer.
  Reason: oxygen is already the core pressure system, so this validates persistent progression without adding a full crafting economy.

Future upgrade candidates:

- `Pressure Seal I`: allows entry below a depth gate.
- `Cargo Pouch I`: increases retained pickups per dive.
- `Scanner Range I`: lets the player scan from farther away.
- `Fin Tuning I`: improves acceleration or drag.

## First Creature / Ecology Shape

- Passive fish-like creature: moves horizontally in shallow water, useful for testing scanner targeting.
- Drifting jelly-like creature: slow vertical bobbing in midwater, maybe harmless contact later.
- Predator placeholder: patrols a deeper band and teaches that some creatures should be observed before approached.

Keep creature behavior data simple at first: patrol points, speed, scan entry, contact consequence, and depth band.

## Current Completed Issues

- Completed: create engine scaffold and first scene.
- Completed: implement basic 2D underwater movement.
- Completed: add safe base and extraction interaction.
- Completed: add oxygen timer and run failure.
- Completed: reframe prototype around side-view dive descent.

## Out Of Scope For Now

- Large open-world ocean generation.
- Full crafting economy.
- Multiplayer.
- Complex colony, settlement, or restaurant management.
- Full Pokemon-style capture, breeding, or party battle systems.
- Boss rush or extensive weapon roster before the first dive loop is fun.
- Polished art, animation, sound design, or final UI styling before the first loop proves itself.
- Procedural biomes before the authored vertical slice is readable and fun.

## Later Tooling / Testing Work

- Add CI for Godot project validation once the prototype has stable launch behavior.
- Add automated smoke tests for project launch if supported by the engine.
- Add content validation for data-driven creatures, resources, upgrades, and biomes.

## Later Design Questions

- Is the player a diver, a tiny submersible, or a hybrid suit?
- Does the boat/lab become an upgradeable hub, or stay mostly as a dive launcher?
- Are monsters primarily hunted, studied, trapped, or harvested?
- How much of the ocean should be authored versus procedurally rearranged per run?
- Should failed dives preserve scan discoveries, partial resources, or only long-term knowledge?
