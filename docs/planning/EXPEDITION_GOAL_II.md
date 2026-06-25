# Expedition Goal II

Status: planning complete. Recommended future implementation issue title: `Add route objective goal for Shell Reef`.

## Purpose

`Expedition Goal II` should keep the start panel useful as the game adds route variety. The current prep goal already points at upgrade purchases, missing resources, and scan prerequisites. The next layer should add one concise route objective only when it helps the player choose a dive purpose without turning the start panel into a quest log.

The goal line should still answer one question:

Should the player continue downward or return safely now?

## Goal Sources Compared

### Upgrade Requirements

Current role: the strongest source. Upgrade goals already tell the player to bank missing materials, scan required discoveries, or buy an affordable upgrade.

Strengths:

- Directly tied to durable progression.
- Keeps the collect, extract, spend loop clear.
- Easy to keep concise because each upgrade has one next blocker.

Risks:

- Can become repetitive when the next upgrade needs a familiar material.
- Does not always explain why a route matters, especially once the map has multiple midwater opportunities.

Recommendation: keep upgrade requirements as the highest-priority goal source until all configured upgrades are owned or the selected upgrade goal is too generic to explain the current route decision.

### Unresolved Scan Discoveries

Current role: scan-locked upgrades already point to `Thermal Vent` or `Wreck Signal Cache` when those discoveries block progression.

Strengths:

- Helps players understand what to do after seeing a scannable point of interest.
- Fits the research fantasy and persistent knowledge model.
- Can make predator and wreck routes feel purposeful without adding combat or a field guide.

Risks:

- If every unscanned target becomes a goal, the start panel becomes a checklist.
- Some scans are optional route clues, not required upgrade blockers.

Recommendation: only promote a scan discovery into the start goal when it gates a configured upgrade or is the single selected route objective for the current milestone.

### Biome Pocket Opportunities

Current role: `Shell Reef` now exists as a midwater pocket with a practical scan clue and typed `Shell Fragments` spawn candidates.

Strengths:

- Gives the next dive a clear route choice: bank midwater shell cargo or push past the reef toward deeper risk.
- Makes authored biome pockets serve oxygen/cargo decisions instead of decoration.
- Supports `Cargo Rack I` and pressure-wreck preparation without adding new resources.

Risks:

- Easy to overstate into a quest objective when the pocket is only one route option.
- Could clutter the prep panel if every future pocket gets equal priority.

Recommendation: implement the first route objective for `Shell Reef` as the narrow `Expedition Goal II` candidate.

### Predator Observations

Current role: `Gulper Eel` observation is implemented as a non-combat scan that teaches contested-route behavior and can support future `Predator Warning I` planning.

Strengths:

- Supports monster-hunting progression through observation and preparation.
- Gives risky routes a reason beyond resource pickup.
- Can eventually unlock predator-warning or route-readability upgrades.

Risks:

- Too early to make predator objectives primary; this can pressure players toward danger before they understand midwater banking.
- Can imply combat, contracts, or hunting goals if written too aggressively.

Recommendation: keep predator observations below Shell Reef route objectives until `Predator Warning I` is implemented or specifically active in the roadmap.

## Recommended Candidate

Implement `Add route objective goal for Shell Reef` first.

The first implementation should add a compact start-panel goal when the player has not yet bought every near-term upgrade and would benefit from a route-purpose hint, such as:

`Goal: use Shell Reef to bank Shell Fragments, or push deeper if oxygen allows.`

This should be a formatter rule, not a quest system.

## Ordering Rules

1. If an unowned upgrade is affordable, tell the player to buy it after this dive.
2. If an unowned upgrade has a missing required discovery, tell the player to scan that discovery and bank the listed cost.
3. If an unowned upgrade is missing resources, keep the missing-resource banking goal.
4. If no configured upgrade blocker creates a useful next step, show one selected route objective.
5. For the first route objective, prefer `Shell Reef` because it is implemented, readable, and tied to an existing midwater banking decision.
6. Predator observation route goals should wait until predator-warning progression becomes active.

## Text Constraints

- One sentence.
- Prefer `Goal:` prefix to match the current formatter.
- Name one route or object only.
- Name one decision only: bank now, scan now, buy now, or push deeper if oxygen allows.
- Do not list multiple tasks, multiple locations, or multiple future upgrades.
- Do not expose seed, cluster pattern, predator route id, debug telemetry, or hidden spawn logic.
- Keep the line short enough for the existing `Expedition Ready` panel.

## Out Of Scope

Do not add:

- quest logs,
- checklists,
- objective tracking widgets,
- minimaps,
- field-guide pages,
- route arrows,
- daily mission contracts,
- rewards separate from existing resources/scans/upgrades,
- new save fields for active objectives,
- procedural objective generation,
- predator hunting objectives,
- combat, traps, or harvest goals.

## Verification Criteria For The Future Issue

- The start panel still shows exactly one concise goal line.
- Upgrade purchase, missing-resource, and scan-prerequisite goals keep priority.
- The Shell Reef route objective appears only as a narrow fallback or clearly selected route-purpose goal.
- The text helps the player choose between midwater banking and pushing deeper.
- The implementation stays inside the existing formatter and tests rather than adding a quest system.
