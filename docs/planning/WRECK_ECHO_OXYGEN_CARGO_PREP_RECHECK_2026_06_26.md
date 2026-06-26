# Wreck Echo Oxygen/Cargo Prep Recheck - 2026-06-26

Status: review artifact for issue #345. No runtime costs, spawn counts, upgrade costs, or cargo rules are tuned here.

## Decision

The current progression can support one future Wreck Echo attempt without extra systems.

For the first implementation, the route should require survival and scanner/context preparation, not cargo space:

- `Pressure Seal I`: hard requirement for the pressure route context.
- `Signal Lens I`: prerequisite through `Echo Lens I`, preserving scanner ladder order.
- `Echo Lens I`: hard requirement or explicit route-understanding requirement for the first Wreck Echo attempt.
- `Oxygen Tank I`: strongly recommended by route distance/oxygen pressure, but not a new checklist gate by default.
- `Cargo Rack I`: not required while the selected reward is a compact research clue.

## Upgrade Relationship Review

| Upgrade | Relationship To Wreck Echo | Decision |
| --- | --- | --- |
| `Pressure Seal I` | Teaches that pressure access opens remembered places and already gates the pressure wreck/cache route. | Required context. Do not let `Echo Lens I` bypass it. |
| `Signal Lens I` | Practical scanner upgrade required before `Echo Lens I`. | Keep as prerequisite through `Echo Lens I`; do not turn Wreck Echo into material scanning. |
| `Echo Lens I` | Broad wreck curiosity and Wreck Echo handoff. | Required for first Wreck Echo route understanding unless a later implementation contract chooses a softer hint. |
| `Oxygen Tank I` | Makes deeper inspection and safe return more realistic. | Soft preparation pressure. Let distance, oxygen drain, and return route make it valuable. |
| `Cargo Rack I` | Expands bankable cargo capacity. | Not needed for a research clue. Use only if a later material/sample reward replaces the first clue plan. |

## Why Cargo Should Not Gate The First Route

The selected first reward is a compact research clue, not a material/sample.

Requiring cargo space now would create the wrong player question:

> Did I bring enough inventory capacity?

The desired first Wreck Echo question is:

> Do I understand the signal and have enough oxygen to investigate and get home?

Cargo can remain a background opportunity cost because players may still choose to carry resources during the same dive, but the Wreck Echo clue itself should not need an empty cargo slot, cargo prompt, inventory grid, or `Cargo Rack I`.

## Oxygen Pressure Shape

Use existing oxygen rules:

- continuous active-dive drain,
- first-time scan cost if the future clue is scannable,
- Burst Thruster oxygen cost if the player uses it,
- predator contact oxygen risk if route timing is poor,
- low/critical HUD warnings,
- extraction before oxygen reaches zero.

Do not add:

- new route oxygen tax,
- decompression/ascent cost,
- pressure damage over time,
- hidden failure timer,
- new oxygen upgrade,
- new cargo/oxygen UI.

## Future Implementation Guidance

The first route should be tuned by placement and return pressure, not new systems:

- place the pocket deep/far enough that oxygen margin matters,
- keep turn-back possible before failure,
- make `Oxygen Tank I` feel helpful through safety margin,
- keep `Cargo Rack I` optional unless a future material/sample reward is selected,
- use result copy to reward learning, not cargo capacity.

## Test Needs Later

When implementation begins, tests should prove:

- `Echo Lens I` does not grant `Pressure Seal I`,
- Wreck Echo access does not bypass pressure access,
- cargo capacity and carried cargo are unchanged by clue recovery,
- oxygen failure still clears carried cargo under existing rules,
- no new oxygen/cargo costs are introduced unless explicitly scoped,
- result clue recovery is independent of empty cargo slots.

## Current Scope

This review changes no scripts, scenes, route nodes, costs, resources, cargo limits, oxygen drain, scan costs, spawn counts, upgrades, or save data.
