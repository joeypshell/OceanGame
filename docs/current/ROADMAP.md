# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains what should be tackled next and what should stay out of scope.

Current direction: build a 2D underwater roguelite about repeated dives into alien ocean biomes, where scanning, surviving, gathering, and monster hunting unlock deeper expeditions.

## Current State

- The repository has an agentic workflow and planning structure.
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A minimal first scene and placeholder controllable submersible exist as the runtime foundation.
- The initial design direction is selected, but most mechanics are still planning-level intent.

## Near-Term Epics

- [ ] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [ ] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [ ] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.

## Near-Term Issue Order

- Create engine scaffold and first scene
  Acceptance: the project opens locally, launches a first scene, and displays a controllable placeholder diver or submersible.
  Verification: run the project locally and document the launch command in `docs/current/GAMEPLAY.md`.
- Implement basic 2D underwater movement
  Acceptance: the player can move fluidly in all directions with acceleration, drag, and bounded test-area collision.
  Verification: manual smoke test movement in the first scene.
- Add safe base and extraction interaction
  Acceptance: the player can return to a marked base/extraction area and trigger a simple end-of-dive result.
  Verification: start a run, move away, return to base, and see the result state.
- Add oxygen timer and run failure
  Acceptance: oxygen decreases during a dive, returning to base succeeds, and running out of oxygen ends the run with cargo loss or a placeholder failure result.
  Verification: manually test both extraction and oxygen depletion.
- Add first resources and upgrade
  Acceptance: the player can collect at least three resource types and spend them on one persistent oxygen or depth upgrade.
  Verification: collect resources, extract, buy upgrade, and confirm the upgraded value applies next dive.
- Add scanner and field guide stub
  Acceptance: the player can scan simple objects or creatures and see discovered entries persist in a basic field guide.
  Verification: scan an entity, return to base, reopen field guide, and confirm the entry is recorded.

## Out Of Scope For Now

- Large open-world ocean generation.
- Full crafting economy.
- Multiplayer.
- Complex colony, settlement, or restaurant management.
- Full Pokemon-style capture, breeding, or party battle systems.
- Boss rush or extensive weapon roster before the first dive loop is fun.

## Later Tooling / Testing Work

- Add CI for Godot project validation once the prototype has stable launch behavior.
- Add automated smoke tests for project launch if supported by the engine.
- Add content validation for data-driven creatures, resources, upgrades, and biomes.
