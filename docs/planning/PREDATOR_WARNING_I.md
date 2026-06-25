# Predator Warning I

Status: implemented in the current prototype. Follow-up tuning should keep the upgrade focused on readability instead of predator control.

## Purpose

`Predator Warning I` is the first upgrade candidate that uses `Gulper Eel` observation data. It should make danger easier to read before contact without damaging, stunning, trapping, repelling, harvesting, or removing the predator.

The upgrade should support the monster-hunting direction as ecological preparation: observe a dangerous animal, then prepare better route-reading equipment.

## Candidate Payoffs

### Wider Warning Range

Effect: after buying the upgrade, the existing predator warning feedback begins slightly farther from the `Gulper Eel`.

Strengths:

- Directly improves avoidable danger.
- Uses current predator warning behavior instead of adding new UI.
- Makes the `Gulper Eel` observation feel useful without controlling the predator.

Risks:

- Too much range can flatten risk and make the predator feel toothless.
- Needs conservative tuning and verification against deep-reward routes.

### Longer Warning Pulse

Effect: predator warning visuals linger or pulse longer after the player enters the warning area.

Strengths:

- Helps players notice danger without changing patrol or contact rules.
- Low implementation risk.

Risks:

- Less meaningful if the warning is already visible.
- Can become visual noise if the player is near the route for too long.

### Route-Direction Hint

Effect: after observation, a short text or visual hint points toward the predator patrol route or safer timing.

Strengths:

- Strongly connects observation to route planning.
- Could help players understand the relationship between Shell Reef, deep reward, and predator route.

Risks:

- Can drift toward minimap/route overlay behavior.
- More UI work and more chance of over-explaining.

### Safer Scan Distance

Effect: after observation, predator-related scan targets can be scanned from slightly farther away.

Strengths:

- Keeps the upgrade scanner-adjacent.
- Helps observation feel safer without changing the predator.

Risks:

- Too narrow after the player has already observed the eel once.
- Could overlap future scanner upgrades rather than predator preparation.

## Recommendation

`Wider Warning Range` is the first implemented payoff.

The current implementation adds a small data-backed upgrade unlocked by the `Gulper Eel` discovery. It increases warning feedback lead distance through the reusable `Predator.warning_radius()` / `set_warning_radius_multiplier()` helper pair, while leaving the predator patrol, chase radius, contact damage, knockback, and route selection unchanged.

## Unlock Requirements

- Required discovery: `gulper_eel`.
- Candidate cost: `Kelp Fiber x1`, `Shell Fragments x2`, `Glow Plankton x1`.
- Purchase through the existing upgrade bay.

This cost asks the player to engage with shallow, midwater, and deep resources without requiring pressure-wreck completion.

## Expected Player Decision

The player should ask:

- Is it worth buying route-warning preparation before pushing deep routes?
- Does the improved warning give enough confidence to cross near the predator route?
- Should I still bank current cargo instead of taking a deep reward risk?

The upgrade should make the decision more readable, not automatically safe.

## Non-Lethal Constraints

Do not add:

- predator damage,
- stun, slow, fear, or repel effects,
- traps,
- predator harvesting,
- hunting contracts,
- health bars,
- broad tool wheels,
- permanent route removal,
- new predator types for content volume.

## Verification Criteria

- `Predator Warning I` stays locked until `Gulper Eel` is discovered.
- Buying it uses the existing upgrade bay and banked resources.
- Warning feedback begins earlier or is more readable after purchase.
- Predator patrol, chase/contact radius, oxygen loss, knockback, and seeded route selection remain unchanged.
- The upgrade does not affect resources, pressure locks, extraction, or `Burst Thruster`.
- Logic tests cover the discovery prerequisite and effect metadata.
- Logic tests cover the warning-radius helper and verify the effect does not grant or mutate unrelated upgrade behavior.
- Manual smoke confirms predator contact is still possible if the player ignores the warning.
