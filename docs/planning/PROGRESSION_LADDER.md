# Progression Ladder

This is not a tech tree. It is a compact ladder for the first prototype progression steps. Every upgrade should unlock a route, choice, interaction, or strategy.

## 1. Oxygen Tank I

- Purpose: larger action and return margin.
- Current role: lets the player afford an extra scan, pickup, predator recovery, or deeper return.
- Constraint: remains resource-gated only so the basic collect, extract, spend, and upgrade loop stays clear.

## 2. Pressure Seal I

- Purpose: access the first pressure-locked opportunity.
- Unlock logic: requires `Thermal Vent` discovery plus `Kelp Fiber x1`, `Shell Fragments x2`, and `Glow Plankton x2`.
- Behavior change: opens a previously visible pressure-locked research wreck alcove.
- First reward: `Wreck Signal Cache`, a practical discovery that can point toward a future scanner improvement or deeper research objective.
- Constraint: should not be only a larger movement boundary; it must pay off a visible blocked opportunity.

## 3. Scanner Improvement

- Purpose: safer or more useful information gathering.
- Recommended first upgrade: `Signal Lens I`, unlocked from `Wreck Signal Cache`.
- Recommended behavior change: repeat-scanning a discovered resource target sends a short directional pulse toward the nearest visible uncollected deposit of that same resource in the current expedition.
- Constraint: avoid a full field guide until practical scan outcomes are proven.
- Planning note: `docs/planning/SCANNER_IMPROVEMENT_I.md`.

## 4. Cargo Improvement

- Purpose: create different extraction choices.
- Implemented first upgrade: `Cargo Rack I`.
- Behavior change: increase carried cargo capacity from `3` to `4` while preserving the existing failure rule that carried cargo is lost on oxygen failure.
- Constraint: avoid grid inventory, stack management, or broad crafting economy.
- Planning note: `docs/planning/CARGO_IMPROVEMENT_I.md`.

## 5. Predator Countermeasure

- Purpose: access contested routes through preparation.
- Possible behavior change: distract, repel, tag, or trap one predator type long enough to choose a route.
- Constraint: non-lethal counterplay first; hunting or harvesting only after the ecological fantasy is clarified and validated.
- Planning note: first add `Monster Observation I` as a scan/profile step before a true countermeasure. See `docs/planning/MONSTER_OBSERVATION_I.md`.

## Future Candidate: Burst Thruster

- Purpose: spend oxygen for a short emergency traversal or escape burst.
- Recommended first cost: oxygen, not a new energy resource.
- Possible gate: a later implementation issue should decide whether it starts unlocked for testing or becomes a scan/material-gated module.
- Constraint: non-lethal and recovery-focused. It should not damage predators or bypass pressure/progression gates.
- Planning note: `docs/planning/BURST_THRUSTER_MILESTONE.md`.
