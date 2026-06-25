# Cargo Improvement I Plan

Date: 2026-06-25

Status: promoted to active implementation issue #55, `Add Cargo Rack I fourth cargo slot upgrade`.

## Context

The current prototype uses three carried cargo slots. Extraction banks carried resources; oxygen failure loses carried resources. This is readable and should remain the foundation.

Cargo Improvement I should create a new extraction decision without adding grid inventory, stacks, sorting, crafting logistics, or base management.

## Options Compared

### Fourth Cargo Slot

Effect: increase carried cargo from `3` to `4`.

Pros:

- Very easy to understand.
- Uses the existing cargo model and HUD.
- Creates a direct decision: use the extra slot by staying out longer, or return safely with enough cargo.
- Pairs naturally with deeper routes and `Signal Lens I` because better information can tempt one more pickup.

Cons:

- Can soften extraction tension if added too early.
- Could make future low-tier recipes too easy if costs are not tuned around it.
- Is less surprising than a more specialized cargo module.

### Protect One Carried Item On Failure

Effect: if oxygen failure happens, one carried item is banked or preserved instead of all carried cargo being lost.

Pros:

- Creates a strong risk-reward fantasy.
- Makes failure less punishing after deep expeditions.
- Could encourage dramatic last-second attempts.

Cons:

- Weakens the current clear failure rule.
- Requires new UI language so players know what is protected.
- Might teach players that failing is acceptable before extraction tension is validated.
- More complex than the first cargo progression needs to be.

### Fragile Research Sample Slot

Effect: add a special slot for research samples that are not normal resources.

Pros:

- Creates a distinct objective type.
- Supports future wreck/cave discoveries and research fantasy.
- Keeps normal resource cargo unchanged.

Cons:

- Requires new content types, UI, banking rules, and failure rules.
- Risks turning cargo into inventory design before the basic loop is validated.
- Better suited after the scanner/progression loop proves players understand current cargo.

## Recommendation

Recommend `Cargo Rack I` as the first cargo improvement when implementation is warranted.

Recommended effect:

- Increase carried cargo capacity from `3` to `4`.
- Keep carried cargo as a simple count/list.
- Keep oxygen failure rule unchanged: all carried cargo is lost on failure.
- Keep extraction banking unchanged.

This is the smallest cargo upgrade that creates a real route decision. One extra slot lets the player consider a deeper or wider route, but it still asks whether the extra pickup is worth oxygen, predator, and return risk.

## Unlock Requirements

Recommended unlock:

- Upgrade id: `cargo_rack_1`.
- Effect id: `cargo_limit_4`.
- Cost: `Kelp Fiber x2`, `Shell Fragments x2`, `Glow Plankton x1`.
- Required discovery: none for the first version, unless future play observations show players need cargo progression to be more narratively gated.

Reason:

- No discovery requirement keeps the first cargo upgrade easy to understand.
- The cost asks for shallow, midwater, and deep engagement without depending on the pressure-locked wreck.
- It should come after `Oxygen Tank I` in practical priority, because more cargo is only useful if the player can survive the route.

## Expected Player Decision

The desired decision is:

- Return with three items safely.
- Spend oxygen and risk predator/depth pressure to fill the fourth slot.
- Use better scanner knowledge to choose which fourth item is worth pursuing.

The upgrade should make extraction choices sharper, not remove the need to turn around.

## Implementation Constraints

Do not include in the first implementation:

- grid inventory,
- stack sizes,
- item rearranging,
- protected cargo,
- fragile samples,
- cargo processing,
- crafting minigames,
- base storage UI,
- multiple cargo upgrade tiers.

Do not change oxygen costs or resource pickup rules as part of this upgrade.

## Validation Criteria

A first implementation succeeds if:

- the HUD clearly shows `Cargo: 0 / 4` after purchase,
- players understand they can carry one more item,
- oxygen failure still clearly loses carried cargo,
- the fourth slot creates one more route decision rather than making every run feel safe,
- recipes and upgrade pacing remain readable.

## Implementation Issue

#55 `Add Cargo Rack I fourth cargo slot upgrade`
