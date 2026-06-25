# Backlog Replenishment After Shell Reef - 2026-06-25

Status: current queue replenishment after issues #65-#74.

## Decision

The next active batch should move from:

**Biome Pocket And Expedition Variety**

into:

**Predator Warning And Route Tuning**

The Shell Reef batch added the first authored midwater pocket, a practical reef scan clue, typed Shell Reef spawn candidates, a compact surface-view selector, a route-objective planning layer, and the first Shell Reef prep-goal fallback. The project is now ready to test whether the new route layer actually changes decisions while adding the first predator-preparation payoff from `Gulper Eel` observation.

This milestone should not open larger procedural biomes yet. It should use the current authored slice to answer whether the player can read:

- a safe midwater banking route,
- a deeper reward route,
- predator-warning preparation,
- result feedback that explains route choices,
- and the next content-pocket direction.

## Created Issues

1. #75 `Add Predator Warning I upgrade`
2. #76 `Add Predator Warning I upgrade tests and metadata coverage`
3. #77 `Run Shell Reef five-seed route review`
4. #78 `Tune Shell Reef return readability after route review`
5. #79 `Tune deep-reward lure relative to Shell Reef route`
6. #80 `Plan Biome Pocket II candidate`
7. #81 `Plan first resource economy tuning pass`
8. #82 `Add route-choice result callout`
9. #83 `Update MCP context server with latest planning docs`
10. #84 `Plan Predator Countermeasure I after warning upgrade`

## Ordering Rationale

Start with `Predator Warning I` because its planning is complete and it is the clearest non-lethal monster-observation payoff. Add focused metadata/test coverage while the implementation is fresh.

Then run the Shell Reef five-seed review before making tuning changes. Tuning should follow observed route readability, not guesses. The route review can validate whether Shell Reef, deep-reward lure, and predator warning are competing cleanly or confusing each other.

After route tuning, plan the next biome pocket and first resource-economy pass. Those planning issues should prevent content expansion from outrunning the current resource and route-decision model.

Add route-choice result callouts only after the project has enough route vocabulary to summarize. Update MCP context once the planning surface changes. Predator Countermeasure I remains planning-only until the warning upgrade proves observation-first predator progression works.

## Success Gate

This queue succeeds when:

- `Predator Warning I` is implemented without changing predator contact rules or adding combat.
- The Shell Reef route review produces concrete observations.
- Shell Reef/deep-reward/predator-warning tuning remains narrow and route-readable.
- The next biome pocket is planned before implementation.
- Resource-economy tuning is considered before adding new resource volume.
- Result summaries can communicate route decisions without becoming a checklist.
- MCP context reflects the current planning docs.
- Predator countermeasure planning stays non-lethal and preparation-first.

## Explicit Non-Goals

Do not add:

- weapons,
- predator harvesting,
- health bars,
- hunting contracts,
- new predator types for content volume,
- full procedural biomes,
- full field guide UI,
- minimaps or route overlays,
- inventory grids,
- broad crafting chains,
- base-management systems,
- polished art/audio production passes.

## Queue Count

After #74 closes, the open queue should contain 10 issues: #75-#84.
