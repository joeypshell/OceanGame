# Resource Economy Tuning I

Status: planning complete. Recommendation: no immediate cost or spawn changes.

## Purpose

This note reviews the first implemented upgrade costs after the `Shell Reef` pocket and `Predator Warning I` were added. The goal is to decide whether the prototype needs a narrow cost or spawn tuning pass before more content is added.

This is not a crafting-system expansion. It should not introduce new resource tiers, stack sizes, inventory-grid rules, rarity tiers, or resource-processing chains.

## Current Upgrade Costs

| Upgrade | Required Discovery | Kelp Fiber | Shell Fragments | Glow Plankton | Total Materials | Current Role |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| `Oxygen Tank I` | None | 2 | 1 | 1 | 4 | First resource-gated upgrade; proves bank/spend/progress loop. |
| `Pressure Seal I` | `Thermal Vent` | 1 | 2 | 2 | 5 | Opens the first pressure-locked wreck opportunity. |
| `Signal Lens I` | `Wreck Signal Cache` | 1 | 2 | 2 | 5 | Turns repeat resource scans into short local signal hints. |
| `Cargo Rack I` | None | 2 | 2 | 1 | 5 | Adds a fourth cargo slot while preserving cargo-loss rules. |
| `Predator Warning I` | `Gulper Eel` | 1 | 2 | 1 | 4 | Improves predator warning readability without changing contact rules. |

## Read On Current Balance

### Oxygen Tank I

The cost still does its job. It requires four total resources while the starting cargo limit is three, so the first upgrade needs at least two successful banking dives. That keeps the first extraction loop meaningful without requiring a scan prerequisite.

No change recommended.

### Pressure Seal I

The cost asks for two `Glow Plankton` and two `Shell Fragments`, plus `Thermal Vent` knowledge. This is appropriately heavier because it opens a visible blocked route and creates the first return payoff behind a pressure gate.

No change recommended.

### Signal Lens I

The cost mirrors `Pressure Seal I`, but it is gated behind `Wreck Signal Cache`, which already requires pressure-route progress. The mirrored cost is acceptable for now because the unlock chain, not only the materials, provides the progression step.

Watchpoint: if `Signal Lens I` feels late after more scan-marker readability work, tune its cost downward before adding a broader scanner tree.

No immediate change recommended.

### Cargo Rack I

The cost is shell-heavy and kelp-heavy with one `Glow Plankton`. That fits its role: it rewards players who are successfully banking shallow/midwater resources and makes the reef-to-deep route more tempting after purchase.

No change recommended.

### Predator Warning I

The cost is lighter than the pressure/scanner/cargo upgrades but requires `Gulper Eel` observation. That is appropriate because the effect improves readability and preparation rather than opening a new route or adding combat power.

No change recommended.

## Shell Reef Impact

The `Shell Reef` pocket makes `Shell Fragments` more central, but it does not currently flood the economy:

- There is still only one active `Shell Fragments` pickup per expedition.
- The reef contributes authored candidate positions rather than extra resource count.
- The five-seed review found two reef-hosted shell seeds and three seeds where shell remained nearby/deeper midwater.
- Shell-heavy costs now have a readable place identity: Shell Reef is where the player thinks about midwater banking.

The main risk is repetitiveness, not generosity. Three of the five current upgrades use `Shell Fragments x2`, so players may feel they are repeatedly checking the same material even if the total pickup count is controlled.

## Recommendation

Do not change costs or spawn counts yet.

The current economy is still serving the intended route decisions:

- `Oxygen Tank I` takes more than one starting-cargo trip.
- `Pressure Seal I` and `Signal Lens I` require deeper/progression knowledge.
- `Cargo Rack I` makes the Shell Reef route more attractive.
- `Predator Warning I` rewards predator observation without adding combat.
- Shell Reef gives `Shell Fragments` a clearer identity without adding extra pickups.

## Future Tuning Trigger

Only create a tuning issue if playtest or telemetry shows one of these concrete problems:

- `Shell Fragments` are banked so reliably that `Pressure Seal I`, `Signal Lens I`, `Cargo Rack I`, and `Predator Warning I` all feel like the same repeated task.
- Players stop considering `Glow Plankton` risk because shell costs dominate attention.
- Shell Reef becomes a mandatory chore rather than a bank-or-push-deeper choice.

If that happens, use one narrow issue title:

`Tune Shell Fragment cost pressure after first economy review`

That issue should change only one of:

- one upgrade's `Shell Fragments` cost by `1`,
- the number of Shell Reef candidate positions,
- or the cluster-pattern weighting for shell placement.

Do not combine cost tuning with new resources, inventory rules, or crafting chains.

## Out Of Scope

Do not add:

- new resource tiers,
- resource rarity,
- stack sizes,
- inventory grids,
- crafting recipes beyond upgrade costs,
- resource processing,
- vendor prices,
- drop tables,
- currency,
- base-management economy,
- or separate daily market rules.

## Verification Criteria For Any Future Tuning

- The starting cargo limit still makes `Oxygen Tank I` require more than one successful banking dive.
- `Shell Fragments` remain midwater by identity.
- `Glow Plankton` remains the deep-risk material.
- No upgrade becomes buyable without engaging with its intended route or discovery requirement.
- Shell Reef still presents a bank-vs-push-deeper choice rather than a guaranteed shopping stop.
