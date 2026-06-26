# Deeper Access After Echo Lens I - 2026-06-26

Status: planning note for issues #215 and #224.

## Purpose

Define what the next access promise should mean after `Echo Lens I` without implementing a new region, minimap, field guide, exact locator, or quest checklist.

## Recommendation

The next access promise should be a remembered route question, not a new region yet:

`Wreck Echo Descent`

Player-facing idea:

> The cache proved there is a weak wreck signal deeper-right. Can I prepare a future expedition well enough to investigate that pressure-dark route?

This keeps the next step tied to existing memory: the player saw Wreck Shelf, opened the first pressure route, scanned Wreck Signal Cache, installed better scanner tools, and now has a broad reason to plan another dive.

## What Deeper Access Means

Deeper access should combine four existing pillars:

| Pillar | Current Foundation | Next Promise |
| --- | --- | --- |
| Scanner curiosity | `Echo Lens I` reports a broad weak wreck signal. | A future scan can identify the route category without solving the route. |
| Pressure access | `Pressure Seal I` opens the first wreck alcove. | A later access tool or tuned seal can make one deeper pressure pocket approachable. |
| Region memory | Wreck Shelf is already a remembered blocked-promise place. | Result/ready copy can ask whether today is a good day to revisit that remembered place. |
| One-more-expedition motivation | Cargo, oxygen, upgrades, and daily condition already shape run planning. | The player prepares oxygen/cargo/scanner access before trying the deeper echo. |

## First Future Slice Shape

When this becomes implementation work, the first slice should be narrow:

1. Add one authored deeper-access promise near or below Wreck Shelf.
2. Let `Echo Lens I` point broadly toward it with category/direction language.
3. Require practical preparation before entry, such as oxygen margin, cargo space, or a later pressure/scanner upgrade.
4. Reward reaching it with one compact research clue or material opportunity.

This should be one route pocket, not a new biome system.

## Wreck Echo Descent Pocket Candidate

Working name: `Wreck Echo Descent`.

Purpose: create one prepared-route question below/right of the existing Wreck Shelf memory after `Echo Lens I` proves that a weak wreck signal exists. The pocket should make the player ask whether today's expedition has enough oxygen, cargo space, pressure access, and predator timing to investigate a deeper signal, then return safely.

## Implementation Constraints

Do not implement `Wreck Echo Descent` until the current vertical slice stays readable at normal scale. The current gate is the playable-slice checklist, active HUD review, surface review, lower-route density pass, and pressure wreck/cache balance review. If the current Wreck Shelf, pressure gate, cache, predator route, or HUD text is still visually confusing, this pocket should remain planning-only.

Trigger:

- player has discovered `Wreck Signal Cache`,
- player owns `Signal Lens I` and `Echo Lens I`,
- player has opened or understood the first pressure route through `Pressure Seal I`,
- the current expedition context can frame the attempt as optional preparation, not a required objective.

Route promise:

- one authored deeper-right pressure route related to the Wreck Shelf memory,
- broad local Echo Lens language such as "weak wreck signal deeper-right" or "deeper pressure echo",
- readable route risk before commitment: pressure-dark threshold, return distance, predator timing, oxygen margin, or cargo-space tradeoff.

Constraints:

- one pocket, one route question, one reward choice,
- no map node, exact coordinate, minimap arrow, objective checklist, quest journal, or field-guide entry,
- no broad procedural region generation, new biome family, daily challenge system, or multi-step story screen,
- no upgrade bypass: `Echo Lens I` motivates the route but does not replace pressure access, oxygen preparation, or safe-return decisions.

Reward rule:

- choose exactly one first reward type when implemented: compact research clue, rare material opportunity, or later prerequisite discovery,
- the result should support "I learned enough to plan another dive," not "I completed a quest chain."

Acceptance for a future implementation issue:

- a player can notice the route promise without reading a paragraph,
- a player can understand why they should not always enter it,
- the result panel remembers the attempt in one compact line,
- screenshots still pass the current visual-readability bar with the existing HUD and lower-route elements visible.

Suggested placement relationship:

- anchored near or below the current Wreck Shelf / pressure wreck memory,
- directionally described as `deeper-right`,
- visually separated from the first pressure-locked wreck so it reads as a later descent route, not a missed cache in the same room,
- reachable only after current route language, oxygen pressure, and pressure-dark readability are strong enough to support another decision layer.

Required preparation:

- `Pressure Seal I` or later pressure access so the player understands this is an access-gated route family,
- `Signal Lens I` and `Echo Lens I` so the route is motivated by scanner curiosity rather than a visible objective marker,
- enough oxygen margin to descend, inspect, and return,
- at least one empty cargo slot if the route promises a material sample.

Likely risks:

- pressure-dark threshold that makes the route feel deeper and less safe,
- predator route proximity or timing pressure without forcing combat,
- longer return distance from the surface base,
- tempting reward placement that competes with safe extraction.

Reward type:

- one compact research clue about deeper wreck signals,
- one rare material opportunity or prototype sample,
- or a later upgrade prerequisite discovery.

The first implementation should choose one reward type. Do not make the pocket a multi-objective checklist.

Scene/data shape when implemented:

- one authored route holder under `Main.tscn` or a future placed region holder,
- one reusable readability scene under `scenes/readability/` for pressure-dark threshold and echo pocket visuals,
- typed `SpawnPoint` candidates for any resource or condition variation,
- one scannable route clue if needed,
- no persistent marker, no minimap node, no exact locator, and no broad procedural region generation.

Prototype visual study: `assets/source/sprites/study_pressure_dark_threshold_v1.svg` and `assets/exports/sprites/study_pressure_dark_threshold_v1.svg` explore the threshold mood for this pocket, with provenance in `assets/licenses/study_pressure_dark_threshold_v1.txt`. The asset is not scene-wired and does not add route behavior.

## Copy Rules

Allowed language:

- "weak wreck signal deeper-right"
- "deeper pressure echo"
- "Wreck Shelf signal grew clearer"
- "return with better oxygen or pressure access"

Avoid language:

- exact coordinates,
- map markers,
- objective checklists,
- "go to X now",
- guaranteed safe route,
- full region names before the player has seen the place.

## Out Of Scope

- Broad biome generation.
- Region-select screen.
- Minimap or route graph.
- Field guide.
- Persistent quest log.
- Exact signal locator.
- Multiple unresolved echoes.
- New daily challenge system.
- Full Abyssal Ruins implementation.

## Later Candidate Issues

These are candidates for a later backlog, not immediate implementation commitments:

- Define a later pressure/scanner access upgrade after `Echo Lens I`.
- Prototype a temporary local echo pulse around the cache or route edge.
- Review oxygen/cargo cost pressure for a deeper echo attempt.
- Add one visual study for a pressure-dark route threshold.

## Decision

Use `Wreck Echo Descent` as the selected later direction for deeper access after `Echo Lens I`.

Do not start by adding a full new region. Start by making the existing Wreck Shelf memory create one stronger, prepared-route question.
