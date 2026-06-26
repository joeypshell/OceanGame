# Wreck Echo Entry Readability States - 2026-06-26

Status: planning artifact for issue #343. No runtime state changes are made here.

## Purpose

Define how a future `Wreck Echo Descent` entry should read before, during, and after route access while keeping pressure gate, cache, predator lane, and Echo Lens signal distinct.

## Planned States

| State | Player Read | Visual/Copy Direction | Must Stay Distinct From |
| --- | --- | --- | --- |
| Unavailable | No Wreck Echo route is currently readable. | No marker. Existing pressure/cache/safe-return reads remain unchanged. | Hidden objective, map marker, field-guide entry. |
| Locked by pressure/context | Pressure/cache promise exists, but Wreck Echo attempt is not prepared. | Pressure gate and Wreck Signal Cache own this read; Echo Lens copy may stay broad. | Pressure gate must not look like Wreck Echo route itself. |
| Prepared | Player has the required pressure/scanner context and can consider the route if oxygen allows. | One subdued deeper-right cue or scan/status line. | Deep reward lure, predator warning lane, exact locator. |
| Route attempt | Player is pushing into the future pocket. | Oxygen/base direction and predator danger remain louder; Wreck Echo status stays one line. | Objective panel, route graph, multi-step checklist. |
| Clue recovered | Player has the run-scoped clue and should return. | Short status such as `clue carried - get home`; result memory waits for extraction. | Persistent marker, durable quest completion, field guide unlock. |
| No clue/quiet | Route or scan produced no clear clue this time. | Quiet/unresolved status only. | Failure state, punishment, required objective. |
| Result readback | Successful extraction with clue shows one compact `Research:` line. | Surface result panel owns the memory. | Active HUD, permanent objective, map pin. |

## State Priority

Wreck Echo entry states must remain below:

1. low/critical oxygen,
2. base return/extraction,
3. predator danger,
4. pressure gate denial/open state,
5. Wreck Signal Cache scan/payoff,
6. player/sub readability.

If a Wreck Echo cue competes with any of these, dim or remove the Wreck Echo cue first.

## Locked And Prepared Distinction

Locked/context state should feel like:

> There is still a deeper wreck mystery here, but I am not ready to act on it.

Prepared state should feel like:

> I understand enough to try this if oxygen allows.

Do not use:

- `Objective ready`,
- `Route unlocked`,
- `Go to Wreck Echo`,
- exact direction/distance,
- persistent badge,
- checklist progress.

## Scene Relationship

Future Wreck Echo entry should be downstream of the current Wreck Shelf flow:

- pressure gate remains the access gate,
- outside scan remains the pressure-route clue,
- Wreck Signal Cache remains the current payoff,
- Echo Lens remains a broad signal reader,
- Wreck Echo pocket becomes a deeper-right optional attempt after those reads are understood.

Do not merge Wreck Echo with:

- the lock/open badge,
- the Wreck Signal Cache core,
- the Echo Lens pulse,
- the Gulper warning lane,
- the deep reward lure.

## Future Test Needs

When implementation begins, test or review:

- unavailable state has no visible route marker,
- locked/prepared state copy stays broad and local,
- route attempt state resets between expeditions,
- clue recovered state produces result readback only after extraction,
- no-clue return does not show a research reward,
- pressure gate/cache/predator/oxygen behavior remains unchanged,
- screenshots cover locked/prepared/attempt/result states if those states are visible.

## Current Scope

This plan adds no scene nodes, route state, copy strings, tests, assets, scan targets, collision, pressure zones, or save data.
