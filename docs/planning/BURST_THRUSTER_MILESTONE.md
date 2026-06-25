# Burst Thruster Milestone Plan

Date: 2026-06-25

## Purpose

`Burst Thruster` is a single non-lethal active tool candidate for a future milestone. It gives the player a short emergency movement burst so predator mistakes, risky crossings, and late turnarounds create an explicit oxygen tradeoff instead of only passive avoidance.

It should answer one question:

Should I spend return margin now to recover from danger, or save oxygen for extraction?

## Recommended Rule

- Input: Spacebar, mapped through a future `burst_thruster` input action.
- Behavior: a short burst in the current movement direction, or the sub's facing direction if no movement input is held.
- Cost: `4` oxygen per burst.
- Limitation: a short cooldown, initially around `4` seconds, plus a minimum oxygen guard so the tool cannot be activated when it would immediately cause failure.
- Unlock: do not include by default in the starting kit until a small implementation issue decides whether it is an upgrade, a scan-gated module, or a temporary prototype ability.

Use oxygen as the first cost. Do not add scanner energy, stamina, battery charge, ammo, or a second temporary resource for the first version.

## Why Oxygen

Oxygen is already the core run clock and the player's clearest return-margin signal. Spending oxygen on a burst creates the right tactical shape:

- burst away from a predator now,
- lose time/capacity for scans or pickups,
- maybe turn a greedy route into a tense return,
- avoid adding another meter before the core loop is validated.

If oxygen cost makes the tool feel too punishing in blind tests, tune cost or cooldown before inventing a new resource.

## Predator Recovery Role

The burst should help the player recover from predator pressure without becoming a weapon.

Allowed:

- dodge out of a chase path,
- recover after a bad route commitment,
- create enough separation to return toward the base,
- cross a small risky gap when the player accepts oxygen cost.

Not allowed for the first version:

- damage, stun, harvest, or kill predators,
- bypass pressure locks or progression gates,
- cancel all predator risk on demand,
- become a general speedrun movement upgrade that makes route planning irrelevant.

Predators should still matter. The burst should convert one mistake into a costly recovery opportunity, not erase the mistake.

## Expected Player Decision

The desired decision is:

- Spend `4` oxygen to escape or reposition.
- Keep the oxygen and try to pilot out normally.
- Abandon a deeper reward because the burst cost would make extraction too tight.

The best outcome is not always using the burst. Sometimes the correct play should be turning back earlier.

## First Implementation Shape

When this becomes implementation work, keep the first slice small:

- one input action,
- one exported oxygen cost,
- one exported cooldown,
- one clear HUD/status feedback line,
- no new upgrade tree unless the issue explicitly includes it,
- no extra tool slots or tool wheel.

Suggested implementation issue title:

`Add prototype Burst Thruster with oxygen cost and cooldown`

## Validation Criteria

Do not implement broadly until the current predator route is validated enough to compare before/after behavior.

A first Burst Thruster slice succeeds only if:

- an unfamiliar player can describe that the burst spends oxygen to recover from danger,
- predator contact remains avoidable through observation and route choice,
- one burst can prevent or recover from a predator mistake without making the route feel safe for free,
- deep-reward routes still create close return decisions,
- the tool does not bypass `Pressure Seal I` or future route gates,
- the HUD/status feedback makes cooldown and oxygen cost understandable without a tutorial wall,
- at least one tested run ends with the player choosing not to burst because extraction margin matters more.

## Deferred

- Multiple active tools.
- Weapons.
- Predator damage, stun, or harvest loops.
- Dedicated energy resources.
- Upgrade tiers beyond one prototype version.
