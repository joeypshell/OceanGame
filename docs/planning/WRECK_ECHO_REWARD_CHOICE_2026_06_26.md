# Wreck Echo Reward Choice - 2026-06-26

Status: planning artifact for issue #329.

## Decision

Primary reward type: compact research clue.

Backup reward type: rare material opportunity or prototype sample.

Do not use later prerequisite discovery as the first Wreck Echo reward.

## Comparison

| Candidate | Strength | Risk | Decision |
| --- | --- | --- | --- |
| Compact research clue | Best fit for scanner curiosity, Wreck Shelf memory, and "one more expedition" motivation. It can reward survival with one result line and no new economy. | If too vague, players may not feel enough payoff. | Select as primary. |
| Rare material opportunity or prototype sample | Adds cargo-space tension and a more tangible reward. It can make `Cargo Rack I` feel useful. | Requires new material/sample identity, cargo-slot clarity, and economy follow-through before the route itself is proven. | Keep as backup. |
| Later prerequisite discovery | Could set up a future access upgrade cleanly. | Too close to a quest-chain/key item, and it risks making Wreck Echo feel mandatory rather than optional. | Do not use first. |

## Primary Reward Shape

The first future `Wreck Echo Descent` implementation should reward reaching or scanning the pocket with one compact research clue about deeper wreck signals.

Intended result feel:

> I pushed into the deeper wreck echo, learned something strange, and got home with a reason to plan another dive.

The clue should:

- be one result-panel line,
- tie back to Wreck Shelf memory,
- imply future deeper mystery without exact coordinates,
- avoid persistent objective markers,
- avoid creating a field guide entry,
- avoid granting a new upgrade immediately,
- avoid adding a new resource economy.

Example result-copy direction:

- `Research: Wreck Echo clue confirms a deeper pressure signal below the shelf.`
- `Research: Wreck Echo signal mapped a deeper wreck question, not a safe route.`

These are example directions, not final runtime copy.

## Backup Reward Shape

If future playtests show that a research clue feels too intangible, use a rare material opportunity or prototype sample as the backup.

Backup constraints:

- one item/sample type,
- one optional cargo-slot decision,
- no inventory grid,
- no crafting tree,
- no new broad economy,
- no guaranteed upgrade unlock on first pickup,
- result copy still frames the run as a risky route attempt.

Cargo-space pressure should only matter if this backup is chosen.

## Why Not A Later Prerequisite Discovery First

A later prerequisite discovery is useful eventually, but it is too strong for the first Wreck Echo implementation. It can make the route feel like a required quest step and may push the project toward checklist language before the route proves readable.

Use prerequisite discovery later only after:

- the Wreck Echo route is readable,
- the player understands oxygen/return pressure,
- reward/result copy is proven compact,
- the next upgrade or access promise is already scoped.

## Future Implementation Acceptance

A future implementation issue using the primary reward should require:

- one route pocket,
- one route question,
- one compact research reward,
- no new material, upgrade, or prerequisite discovery,
- no minimap, route graph, field guide, quest log, exact locator, or objective checklist,
- no persistent marker after the run/result moment,
- no pressure bypass from `Echo Lens I`,
- no broad biome/procedural scope,
- normal-scale evidence that HUD, safe return, pressure gate/cache, predator lane, and reward/clue read remain distinct.

## Current Scope

This issue does not implement `Wreck Echo Descent`, add scene nodes, add scan targets, add resources, add rewards, change progression, change oxygen/cargo rules, or wire pressure-dark art.
