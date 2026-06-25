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
- active expedition result
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

Separate scanner outcomes into two layers:

### Permanent Discovery Knowledge

Persistent discoveries can record:

- creature behavior
- resource depth identity
- resource upgrade relevance
- environmental information
- upgrade clues or progression prerequisites

Permanent knowledge should help the player make future expedition decisions.

### Current-Expedition Tactical Scan Effect

Tactical scan effects can provide:

- temporary highlights
- route reveals
- current creature location
- current resource-cluster information
- nearby target direction

Tactical effects should help the current dive without becoming a full field guide.

Current recommendation: keep repeat tactical scans free for the prototype. First-time scans cost oxygen; re-scanning already discovered targets costs no oxygen and may refresh practical effects. See `docs/planning/REPEAT_SCAN_COST_RECOMMENDATION.md` for the reviewed cooldown, smaller oxygen cost, and scanner-energy alternatives. Do not change repeat-scan costs unless an active implementation issue authorizes it.

Planned first scanner improvement: `Signal Lens I` should use the `Wreck Signal Cache` discovery to turn repeat resource scans into a short nearest-resource direction pulse. See `docs/planning/SCANNER_IMPROVEMENT_I.md`.

Scanner targeting must be legible:

- show the current target name before scanning
- visually highlight the selected target
- use deterministic targeting when multiple scannables are nearby

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

## Pressure Seal I Arc

Do not implement `Pressure Seal I` as only a larger movement boundary. The first pressure progression should create a visible promise, a clear blocker, and a return payoff:

1. The player sees a desirable but inaccessible pressure-locked opportunity.
2. The game clearly communicates why it cannot yet be entered.
3. Scanning the `Thermal Vent` supplies the relevant pressure-stability knowledge.
4. The player gathers and banks the required resources.
5. The player buys `Pressure Seal I`.
6. The player returns and accesses the previously visible opportunity.

First-slice definition:

- Boundary location: lower midwater/deep transition, near the existing deeper reward route but offset so it does not block the normal surface return.
- Visual and UI communication: visible pressure shimmer, blocked-entry prompt, and upgrade-bay locked reason.
- Behavior without upgrade: the player is pushed back or denied entry safely, with no surprise oxygen punishment.
- Exact cost: `Kelp Fiber x1`, `Shell Fragments x2`, `Glow Plankton x2`, plus `Thermal Vent` discovery.
- Target effort: about two successful expeditions after the player understands banking and has seen why the wreck matters.
- New opportunity: one authored pressure-locked research wreck or pressure pocket, not an empty deeper region.
- Accessible area: a small wreck alcove behind the pressure shimmer.
- Reward inside: `Wreck Signal Cache`, a practical discovery that can point toward a future scanner improvement or deeper research objective.

## Surface Base Feedback Rule

The surface base remains a functional hub rather than a management simulation. Successful extraction should provide clear emotional payoff:

- oxygen pressure stops immediately
- carried resources visibly move into the persistent bank
- discoveries and upgrade availability are clearly acknowledged
- purchase feedback makes permanent progression obvious
- the player can quickly begin the next dive

Physical cargo-processing systems, base management, crafting minigames, and elaborate environmental upgrades remain deferred.
