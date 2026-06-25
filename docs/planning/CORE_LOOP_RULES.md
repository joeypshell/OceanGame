# Core Loop Rules

This note keeps design rules that are not all implemented yet but should guide issue creation and future Codex work. `docs/current/GAMEPLAY.md` remains the source of truth for implemented behavior.

## Core Question

Every new mechanic should strengthen one question:

Should the player continue downward or return safely now?

## Current-Dive State

Current-dive state should remain temporary:

- oxygen
- current cargo
- has left base
- current depth
- active run result
- temporary effects

Current-dive cargo is lost on oxygen failure and should not be restored by disk-backed progression saves.

## Persistent Progression State

Progression should survive across dives during a session, and later across launches:

- banked resources
- purchased upgrades
- scan discoveries
- best depth reached

Persistent progression does not mean restoring an in-progress dive.

## Oxygen Decision Rules

Keep the oxygen model readable:

- Passive drain: 0.95 oxygen per second.
- Collect resource: 1 oxygen.
- Complete scan: 2 oxygen.
- Predator contact: 5 oxygen.

Depth-based oxygen modifiers, ascent drain, and decompression penalties are deferred. Low-oxygen feedback should increase tension through presentation, not hidden mechanics.

Future feedback rule:

- Below 25 percent oxygen: make the HUD more urgent.
- Below 10 percent oxygen: add stronger warning feedback and emphasize direction/distance to the surface base.
- Do not change oxygen costs as part of this warning layer.

## Cargo And Failure Rules

- The player can carry three pickups before extraction.
- Extraction banks carried resources into persistent progression.
- Oxygen failure loses carried resources.
- Banked resources, upgrades, discoveries, and best depth remain after failure.

## Scanner Outcome Rules

The scanner must be useful from its first implementation. Scan results should reveal practical information:

- Resource scan: where the resource tends to occur and what upgrade uses it.
- Creature scan: movement pattern, aggression trigger, safe distance, or avoidance behavior.
- Environmental scan: route hint, hidden resource cluster, oxygen refill location, or future depth-gate clue.

Do not add scans that are only flavor before the core loop is proven.

## Progression Unlock Rule

- `Oxygen Tank I` remains resource-gated only. It proves the basic collect, extract, spend, and upgrade loop.
- Later upgrades may require both resources and a thematically related scan discovery.
- Scan requirements must clearly explain why that knowledge unlocks the technology.
- Do not add scan requirements merely to lengthen progression.

Initial candidates:

- `Thermal Vent` discovery may unlock `Pressure Seal I`.
- `Gulper Eel` discovery may unlock a predator-warning, decoy, or repellent module.
- A bioluminescent-life discovery may unlock a lighting or scanner upgrade.
- Wreck technology discovery may unlock a submersible module.

## Surface Base Feedback Rule

The surface base remains a functional hub rather than a management simulation. Successful extraction should provide clear emotional payoff:

- oxygen pressure stops immediately
- carried resources visibly move into the persistent bank
- discoveries and upgrade availability are clearly acknowledged
- purchase feedback makes permanent progression obvious
- the player can quickly begin the next dive

Physical cargo-processing systems, base management, crafting minigames, and elaborate environmental upgrades remain deferred.
