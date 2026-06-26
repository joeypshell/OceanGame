# Wreck Echo Oxygen/Cargo Preparation Review - 2026-06-26

Status: planning review for issue #307.

## Decision

A future `Wreck Echo Descent` attempt should use both oxygen margin and cargo space as preparation pressure, but not as a new checklist UI or hard objective chain.

Recommendation:

- Oxygen should be the primary pressure.
- Cargo space should be a secondary opportunity-cost pressure only if the future route chooses a material/sample reward.
- Do not change current oxygen drain, scan costs, cargo capacity, upgrade costs, resources, or route behavior for this issue.

## Current Baseline

Current run state:

- `DiveSession.max_oxygen` starts at `30`.
- `Oxygen Tank I` raises future max oxygen to `40`.
- Active dives drain oxygen continuously.
- Resource pickup costs `1` oxygen.
- First-time scans cost `2` oxygen.
- `Burst Thruster` costs `4` oxygen with cooldown.
- Predator contact costs oxygen and knocks the player back.
- Oxygen failure clears carried cargo but keeps durable banked progress.

Current cargo:

- Starting cargo limit is `3`.
- `Cargo Rack I` raises future cargo capacity to `4`.
- Extraction banks carried cargo.
- Oxygen failure loses carried cargo.
- Cargo is a simple capacity pressure, not an inventory grid.

## Why Oxygen Should Lead

`Wreck Echo Descent` is framed as a deeper prepared-route question. The player should ask:

> Do I have enough oxygen to inspect this, make a decision, and still return?

Oxygen is already the clearest risk language:

- HUD is always visible during active dives.
- Low and critical states already escalate.
- Safe return is already tied to base direction and oxygen survival.
- It does not require a new UI mode.

Future Wreck Echo implementation should therefore make the route feel longer, deeper, or less safe through distance and return pressure before adding any new cost rules.

## Why Cargo Should Be Secondary

Cargo pressure works only if the route reward is a material/sample opportunity.

If the first Wreck Echo reward is a compact research clue, cargo should not be required.

If the first Wreck Echo reward is a rare material opportunity or prototype sample, cargo should matter as an empty-slot decision:

- carry existing bankable resources home now,
- or leave a slot open for the risky echo sample.

Cargo should remain a tradeoff, not a checklist step. Do not add a "bring empty slot" objective line unless a future implementation issue proves players cannot understand the choice from the route and result copy.

## Upgrade Relationship

Future Wreck Echo planning should respect existing upgrade meanings:

- `Pressure Seal I` teaches that pressure access opens remembered places.
- `Signal Lens I` remains practical material scanning.
- `Echo Lens I` provides broad wreck curiosity, not pressure bypass.
- `Oxygen Tank I` makes deeper inspection more realistic.
- `Cargo Rack I` makes optional sample routes less punishing but should not be mandatory by default.

Do not add a new pressure/scanner/oxygen/cargo upgrade as part of this planning review.

## Future Implementation Guidance

When a future implementation issue is authorized, start with this pressure shape:

1. Route is visible or hinted only after the Wreck Shelf/cache/Echo Lens context exists.
2. The attempt is optional and framed as "if oxygen allows."
3. The route is far/deep enough that low oxygen matters before entry.
4. A player can turn back without failing the expedition.
5. If a material/sample reward is selected, one empty cargo slot matters.
6. Result copy records the attempt in one compact line.

Avoid:

- exact route guidance,
- objective checklist,
- mandatory cargo-slot UI,
- new cargo grid,
- new oxygen penalty rules,
- hidden decompression or ascent costs,
- pressure bypass from `Echo Lens I`,
- broad resource/economy changes.

## Current Decision

No costs, resources, upgrades, cargo limits, oxygen drain, scan costs, route behavior, or scene nodes change now.

This review sets planning guidance only: oxygen first, cargo second when the chosen reward makes cargo relevant.
