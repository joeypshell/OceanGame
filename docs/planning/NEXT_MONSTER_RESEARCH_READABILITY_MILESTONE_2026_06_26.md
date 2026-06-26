# Next Monster Research Readability Milestone - 2026-06-26

Status: planning artifact for issue #316.

## Purpose

Plan the next monster-research readability milestone without adding combat, capture, harvesting, or loot.

The goal is to make `Gulper Eel` research feel learnable and useful before adding new predator systems.

## Current Foundation

The current slice already has:

- `Gulper Eel` as the first route-pressure predator,
- warning lane and patrol hint readability,
- scan discovery for observation,
- predator contact oxygen loss and knockback,
- `Predator Warning I` for earlier warning,
- `Decoy Pulse I` for a temporary non-lethal route-timing window,
- result research callouts for scan, contact, and decoy timing,
- no predator health, harvesting, capture, or combat rewards.

## Milestone Direction

Name: `Gulper Route Research Readability`.

Player-facing promise:

The player should understand that Gulper research teaches route timing and preparation, not how to kill or loot the predator.

The next milestone should answer two readability questions:

1. Does the player understand the Gulper route as a timing window rather than an impassable wall?
2. Does the player understand that `Predator Warning I` and `Decoy Pulse I` are research/preparation tools, not combat tools?

## Candidate Future Work

### 1. Decoy-Owned Manual Smoke Review

Review the active HUD and predator visual state with `Decoy Pulse I` owned.

Acceptance shape:

- locked, ready, spent, and already-spent prompt/status text are readable,
- temporary green decoy state reads as distraction, not damage or victory,
- predator contact remains possible after mistiming,
- pressure/cache/reward cues remain distinct nearby.

### 2. Gulper Timing Result Clarity Review

Review result-panel creature research copy after scan, warning-route entry, chase/contact, and decoy use.

Acceptance shape:

- result copy tells the player what was learned,
- copy stays compact and does not become a field guide,
- contact/failure still reads as a lesson without rewarding damage,
- no combat, loot, capture, or hunting-contract implication appears.

## Future Implementation Candidate

Only after the two readability reviews pass, consider a small `Gulper Timing Study` implementation.

Possible narrow payoff:

- a result or ready-panel line that remembers a learned timing pattern for the next expedition,
- or a minor route-planning affordance tied to existing warning/decoy ownership.

This should remain text/readability support on existing surfaces, not a new permanent bestiary or map.

## Explicit Non-Goals

Do not add:

- weapons,
- predator health,
- damage racing,
- stun-locks,
- capture,
- harvesting,
- monster parts,
- loot drops,
- hunting contracts,
- bounty boards,
- new predator species,
- field-guide UI,
- minimap or route graph,
- permanent route removal,
- broad predator AI rewrite.

## Success Criteria

This milestone succeeds when the current `Gulper Eel` loop reads as:

- observe,
- recognize warning/timing,
- decide whether to push or return,
- use non-lethal preparation if owned,
- bring home a compact research lesson.

It does not succeed by making the predator easier to defeat. It succeeds by making the route easier to understand.
