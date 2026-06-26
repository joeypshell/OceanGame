# Wreck Echo Lower-Route Capacity Review - 2026-06-26

Status: review artifact for issue #350. No scene nodes are added.

## Decision

The current lower route can support one future Wreck Echo pocket only if it is treated as a deeper-right extension, not as another object placed inside the existing pressure gate/cache/predator/reward cluster.

Use `deeper-right` as the preferred future placement direction.

Do not place the first Wreck Echo pocket directly on top of the current lower-right pressure/cache stack, reward lure, or Gulper warning lane. Defer implementation if a future screenshot cannot keep the route, HUD, safe return, pressure gate/cache, predator lane, and clue reward distinct at normal scale.

## Capacity Review

| Element | Current role | Capacity impact | Decision |
| --- | --- | --- | --- |
| Pressure gate | Owns blocked/open pressure access. | Must remain the clearest lower-route gate. | Do not add Wreck Echo art that competes with lock/open badge, shimmer, or rails. |
| Wreck Signal Cache | Owns the current pressure-route payoff and Echo Lens local pulse. | Already carries mystery/research meaning. | Keep Wreck Echo visually downstream of cache, not blended into it. |
| Gulper predator lane | Owns route danger and timing pressure. | Still the tightest overlap near the lower route. | Keep Wreck Echo away from warning lane edges and predator marker. |
| Deep reward lure | Owns optional resource temptation. | Warm/yellow reward color can compete with cache/clue reads. | Keep Wreck Echo cooler/darker and lower priority than player, predator, and gate. |
| Active HUD footprint | Fixed top-left compact HUD. | Can cover incidental left-side art, but not lower-route essentials in current reviews. | Prefer deeper-right pocket because it avoids the HUD footprint and left-side surface clutter. |
| Safe return | Owned by base direction, return column, and oxygen state. | Must stay more important than mystery. | Wreck Echo should never create a false return lane or exact arrow. |

## Placement Recommendation

Preferred: deeper-right pocket beyond the existing pressure/cache alcove.

Reason:

- avoids the fixed top-left HUD footprint,
- gives the pressure gate/cache their own read before the player sees the next mystery,
- creates a natural "push farther if oxygen allows" decision,
- leaves predator lane as danger rather than decoration,
- keeps the first Wreck Echo implementation to one route pocket instead of a crowded multi-node cluster.

Avoid:

- lower-right placement directly beside the current cache and reward lure,
- bright marker shapes over the pressure shell,
- route arrows, exact-locator pulses, or persistent objective badges,
- adding a second reward lure, second cache, or new predator lane in the same visual stack.

## Implementation Guardrails Later

If implementation is authorized later, require:

- one route holder only,
- small pressure-dark/echo visual footprint,
- clear negative space between Wreck Echo, cache, reward lure, and predator lane,
- no new collision or pressure zone unless the implementation issue explicitly scopes it,
- normal-scale screenshot or Playwright evidence with HUD visible,
- screenshots before and after clue recovery if the route has a state change.

## Defer Conditions

Defer route implementation if:

- the route pocket cannot fit without covering the pressure gate/cache,
- the predator lane no longer reads as danger,
- the deep reward lure and Wreck Echo clue look like one reward,
- the HUD covers the only route clue,
- safe return becomes less readable,
- the implementation needs more than one route pocket or more than one reward.

## Current Scope

This review changes no `Main.tscn` nodes, assets, collision, pressure zones, scan targets, resources, rewards, routes, or HUD behavior.
