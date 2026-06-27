# Lower Route Oxygen Margin Review - 2026-06-27

Status: pass with route-evidence watchlist; keep oxygen tuning unchanged.

## Context

This review follows the Blackwater, Dusk Trench, Lantern Ray, and Hollow Reef route-growth batches. The lower route now reaches from `Blue Chimney` through `Silt Vein Fork`, `Blackwater Crack`, `Blackwater Sill`, `Dusk Trench`, and the first `Hollow Reef` side-cave reading.

The purpose is to decide whether the longer route needs a global oxygen retune now, or whether current local cues, preparation pressure, and route placement remain enough.

## Current Oxygen Rules

Keep the current constants:

- base max oxygen: `30`
- `Oxygen Tank I` max oxygen: `40`
- passive drain: `0.95` oxygen per second
- pickup cost: `1` oxygen
- first-time scan cost: `2` oxygen
- burst cost: `4` oxygen
- predator contact cost: `5` oxygen

Low oxygen starts at 25 percent of max oxygen: about `7.5` oxygen with the base tank and `10` with `Oxygen Tank I`. Critical oxygen starts at 10 percent: about `3` oxygen with the base tank and `4` with `Oxygen Tank I`. At the current drain rate, low oxygen is the practical turnback warning, while critical oxygen is an emergency state.

## Route Evidence

The authored lower route adds distance and decision pressure, but the new Blackwater, Dusk, Lantern Ray, and Hollow Reef content does not add a hidden oxygen tax.

- `Blackwater` pressure cues are visual/timing readability only.
- `Dusk Trench` murk and low-visibility cues are presentation only.
- `LanternRayRoute` is passive; only the normal first scan cost applies if the player scans it.
- `Hollow Reef cave reading` is run-scoped knowledge with no direct oxygen, cargo, progression, predator, pressure, or lock mutation.
- The #561 no-screenshot lower-route smoke proves the route stages can be exercised cheaply and repeatably, but it is still state/route evidence rather than a measured manual travel-time proof.

Using current scene positions, the direct authored chain from base/start to the `Hollow Reef` reading is roughly `3,598` pixels one way. At the current `320` px/s player max speed, that is a lower-bound `11.2` seconds one way, or `22.5` seconds round trip before player hesitation, detours, acceleration, collisions, scans, payoffs, predator contact, or burst use. That consumes about `21.4` oxygen from passive drain alone.

This means the base tank can technically support a clean lower-route read, but the intended comfortable route is still prepared play with `Oxygen Tank I`, readable return cues, and a willingness to turn back.

## Required Scenarios

### Clean Route

Decision: pass with watchlist.

A clean prepared route through Blackwater, Dusk, and Hollow Reef should remain viable under current oxygen rules. The route should feel like a push-your-luck lower-route attempt, not a guaranteed checklist objective. If clean prepared runs fail, first check route geometry, camera framing, return-current clarity, and route copy before changing oxygen constants.

### Route With One Payoff

Decision: pass with watchlist.

Recovering one route payoff, such as the Hollow Reef reading, should be fair when the player has prepared and turns back promptly. The payoff does not cost oxygen directly. If the payoff causes failures, the likely issue is interaction placement, cue timing, or the player not understanding that the reading is optional, not the oxygen value itself.

### Creature Pressure

Decision: pass with watchlist.

The passive Lantern Ray does not create direct damage or oxygen loss outside the normal scan cost. Existing predator pressure still matters through the `5` oxygen contact penalty and knockback. If predator contact plus the longer route produces unfair failures, the first fix should be local route spacing, warning-lane readability, or decoy/turnback copy, not a global oxygen buff.

### Return Timing

Decision: pass with watchlist.

Low oxygen is the meaningful return warning. Critical oxygen is too late to be treated as the normal turnback point from the deep lower route. The current design should continue teaching players to leave lower routes before critical oxygen, using base-direction copy and return-current cues rather than extra HUD objectives or route maps.

## Decision

Do not change oxygen constants for this milestone.

The current evidence says the risk is still route readability and player overcommitment, not proven survival math failure. The project should avoid blind retuning until normal-play or scripted route evidence shows a clean prepared route is unfair despite local cue fixes.

## Follow-Up Triggers

Open scoped tuning or route-fairness issues only if evidence shows one of these failures:

1. A clean prepared Blackwater -> Dusk -> Hollow Reef -> return route regularly fails without scans, predator mistakes, cargo detours, or excess burst use.
2. One payoff interaction causes repeated failures because placement or interaction timing traps the player.
3. Predator pressure makes the longer route fail even after warning-lane and spacing fixes.
4. Low oxygen feedback arrives too late for a reasonable return from Hollow Reef.
5. Players interpret the lower route as mandatory and overcommit because ready/result copy or route cues imply an objective chain.

Concrete follow-up work should prefer:

- a no-screenshot route readback that records oxygen at staged lower-route points,
- a normal-play route capture from base to Hollow Reef and back,
- local Hollow Reef/Dusk return-cue strengthening,
- payoff or predator-lane placement adjustments,
- scoped oxygen tuning only after those fixes fail.

## Verification Note

This review changes no scripts, scenes, resources, oxygen constants, movement, collision, upgrades, save data, Playwright tests, or gameplay costs. It records the oxygen-margin decision so the next route-growth issues can continue without reopening broad early-slice tuning.
