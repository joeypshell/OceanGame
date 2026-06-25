# Backlog Replenishment - Thermal Vent And Decoy - 2026-06-25

Status: current queue replenishment after completing the Predator Warning And Route Tuning and first visual-readability batches.

## Decision

The next active batch should move into:

**Thermal Vent And Predator Countermeasure**

The prototype now has readable first-pass route language, a completed `Predator Warning I` upgrade, `Shell Reef` route tuning, and a planned second biome pocket. The next work should add one more authored route pocket around the existing `Thermal Vent`, then add the first narrow non-lethal predator countermeasure from the completed `Predator Countermeasure I` plan.

This is still not the moment for broad procedural biomes, weapons, a field guide, a tool wheel, or final art production. The batch should answer two practical questions:

- Does the `Thermal Vent` area create another readable oxygen-cost route decision without confusing Shell Reef, pressure-wreck, or safe-return language?
- Can `Decoy Pulse I` make the `Gulper Eel` route more playable while preserving observation-first, non-lethal predator progression?

## Created Issues

1. #92 `Add Thermal Vent pocket route variation`
2. #93 `Add Thermal Vent pocket scan/result clarity pass`
3. #94 `Add typed Thermal Vent pocket placement candidates`
4. #95 `Run Thermal Vent pocket five-seed route review`
5. #96 `Tune Thermal Vent pocket readability after route review`
6. #97 `Add Decoy Pulse I upgrade definition and purchase gate`
7. #98 `Implement Decoy Pulse I predator distraction behavior`
8. #99 `Add Decoy Pulse I feedback, cooldown, and HUD status`
9. #100 `Add Decoy Pulse I tests and docs coverage`
10. #101 `Update MCP context and roadmap after vent and decoy planning batch`

## Ordering Rationale

Start with the `Thermal Vent` pocket because its planning is complete and it extends an existing scan discovery rather than adding a new mechanic. Add scan/result clarity and typed placement support while the pocket is fresh, then run a five-seed review before tuning. The route review should decide whether the vent reads as an optional opportunity or becomes visual clutter near existing pressure and deep-reward language.

After the vent route is established, add `Decoy Pulse I` in layers: first the upgrade definition and purchase gate, then the predator-distraction behavior, then feedback and tests. This keeps the first predator countermeasure from sprawling into combat, ammo crafting, tool wheels, or permanent predator control.

The final MCP/roadmap issue keeps planning context synchronized after new review docs or implemented behavior appear.

## Success Gate

This queue succeeds when:

- `Thermal Vent` has a distinct authored pocket identity without changing its discovery role for `Pressure Seal I`.
- The vent route supports a clear spend-oxygen-or-return decision without making `Glow Plankton` free or guaranteed.
- Shell Reef banking, pressure-wreck locks, predator warnings, and safe-return cues remain readable.
- Typed authored placement remains the preferred growth path over hidden coordinates or broad procedural generation.
- `Decoy Pulse I` is gated by `Gulper Eel` observation and `Predator Warning I`.
- `Decoy Pulse I` creates a short non-lethal route-timing window without damaging, harvesting, stun-locking, trapping, or removing the predator.
- HUD and visual feedback distinguish Decoy Pulse from `Burst Thruster`, scan hints, and passive predator warning.
- Tests and current docs cover new upgrade/predator-countermeasure behavior before the batch is considered complete.

## Explicit Non-Goals

Do not add:

- procedural biome generation,
- cave mazes or collision tunnels,
- oxygen refills,
- new resources, rarity tiers, or crafting chains,
- new predators for content volume,
- weapons, damage, health bars, harvesting, hunting contracts, or combat traps,
- broad tool wheels or ammo inventories,
- minimaps, route overlays, or field-guide pages,
- final art/audio production passes.

## Queue Count

After this replenishment, the open queue should contain 10 issues: #92-#101.
