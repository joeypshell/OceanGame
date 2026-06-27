# Lower-Route Creature Progression Validation

Date: 2026-06-27

## Question

Lantern Ray and Glassfin Swarm now prove two non-combat creature reads in the lower-route chain. This note validates whether the next milestone should deepen creature progression immediately or return to route/payoff/upgrades first.

## Current Evidence

- `LanternRayRoute` proves a passive lower-route creature can teach movement timing through scan copy, a pale timing lane, seeded authored route variation, extraction memory, and recent-log memory.
- `HollowReefSkitter` proves a small cave creature can support place memory without becoming a monster objective.
- `GlassfinSwarm` proves the wide chamber can host passive creature-route pressure: it is scannable, has a deterministic spacing-window cue, leaves the return route clear, and can produce compact result/recent-log memory.
- Guardrail tests already protect against collision, harvest areas, health bars, predator reuse, monster-part economy, creature inventory, field-guide/checklist copy, and durable route state for these passive creatures.

## Validation

### Readability

Pass with watchlist. Lantern Ray reads as broad lower-route timing, while Glassfin Swarm reads as chamber-specific spacing. The current risk is not creature system depth; it is that the wide chamber still needs stronger destination identity and payoff so the creature behavior feels like part of a place rather than another isolated cue.

### Route Safety

Pass. Current creatures do not block extraction, apply damage, mutate oxygen beyond the normal first-scan cost, change cargo, or create hidden pressure rules. Glassfin explicitly preserves the lower return-current route. Future creature work should keep this pattern until the chamber has a validated return route under low-oxygen pressure.

### Scan Value

Pass. First scans cost oxygen, record normal durable discoveries, and provide compact behavior guidance. Repeat scans stay free and refresh practical observation copy. This is enough scan value for the current milestone; more scan depth should wait for a chamber payoff or tool promise that gives the observation a reason to matter on a later dive.

### Memory Value

Pass with priority guardrails. Lantern Ray and Glassfin can produce compact result/recent-log memories when no deeper route evidence wins. Dusk, Hollow Reef, and other stronger route evidence should continue to own the main route story. Creature memory should stay secondary unless a future issue deliberately makes a creature the main destination.

## Decision

Continue observation-first creature progression, but do not make creature depth the next primary milestone.

The immediate direction should be:

1. Make the wide chamber a named destination the player can recognize.
2. Add one obvious chamber payoff or reason to return.
3. Harden the chamber return route under normal oxygen pressure.
4. Then add one more chamber creature behavior only if it uses the larger horizontal space and supports route choice.
5. Tie chamber evidence into one narrow future tool/upgrade promise.

Avoid combat, capture, harvesting, monster-part economy, bounties, creature inventory, health bars, broad field-guide UI, and quest/checklist framing. Those systems should stay postponed until the core larger-map loop is visibly fun: reach a place, understand why it matters, make a route decision, recover something, and return.

## Ordered Follow-Ups

Use the existing open issues rather than creating duplicates:

1. #599 - Turn the wide chamber into a named expedition destination.
2. #600 - Add one obvious chamber payoff that is worth returning with.
3. #601 - Add a wide-chamber return route that survives low oxygen pressure.
4. #602 - Add one creature behavior that uses the wide chamber space.
5. #603 - Add one chamber-linked upgrade promise that motivates another dive.
6. #604 - Add one daily variation that changes how the chamber is approached.
7. #605 - Build a single normal-play chamber expedition goal chain.
8. #606 - Add one salvage pocket branching from the chamber.

No new GitHub issues are needed for this validation. The current open queue already contains concrete, ordered work that moves the demo forward without padding the backlog or returning to abstract polish.

## Stop Conditions

Pause creature expansion if:

- the chamber still lacks a named destination or payoff,
- screenshots show the chamber route is unreadable under normal play,
- creature copy starts implying combat, capture, loot, checklist objectives, or a field guide,
- scan/recent-log memory starts overriding stronger route evidence,
- the player can no longer tell how to return to Hollow Reef/Dusk/base.

