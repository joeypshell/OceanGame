# Monster Research II Non-Combat Behavior Evidence - 2026-06-26

Status: planning contract for the next monster-research milestone.

Issue: #413.

## Purpose

Define `Monster Research II` as a behavior-evidence milestone. The player should learn how a dangerous creature controls a route, survive or retreat with that knowledge, and bring home one compact result-memory or upgrade-readiness payoff.

This is not a combat, harvesting, capture, or creature-collection milestone.

## Current Foundation

The project already has enough creature structure for a second research step:

- `Gulper Eel` route selection, warning lane, patrol, chase, contact, oxygen loss, and knockback.
- `Gulper Eel` scan discovery as a non-combat observation target.
- `Predator Warning I` as a route-readability preparation upgrade.
- `Decoy Pulse I` as a one-use timing/distraction window, not damage or stun.
- Compact result summaries that can record Gulper research evidence without adding a field guide.

## Monster Research II Contract

`Monster Research II` should add one narrow behavior-evidence contract:

1. The player encounters an existing creature route or creature-adjacent cue.
2. The game records one player-facing evidence type from behavior, not from killing or collecting.
3. The result panel explains the learning in one compact line.
4. Durable progression may mark upgrade readiness, but must not create a field-guide UI, checklist, route graph, minimap, or creature inventory.

Allowed evidence types include:

- patrol timing observed,
- warning-lane confirmation,
- decoy response observed,
- near-miss/escape evidence,
- passive creature route hint.

## Ownership Boundary

- Run-scoped evidence: what happened on this dive, such as scan, warning-lane entry, chase, contact, decoy use, or near miss.
- Durable memory: a compact discovery/unlock-ready flag only if it supports a later upgrade or route-readability payoff.
- Result memory: one player-facing `Research:` line, not a dossier.

## Explicit Non-Goals

- No weapons, harpoons, damage, stun, kill, harvest, trap, capture, cages, or monster parts.
- No predator health bars, combat UI, bestiary, field guide, checklist, minimap, route graph, or creature inventory.
- No new predator species for content volume.
- No permanent predator removal or permanent route control.
- No mobile/controller combat-control planning.

## Next Planning Questions

The next issue should select exactly one first evidence type for `Monster Research II`. The preferred candidates are:

- `Gulper patrol timing observed`
- `Decoy response observed`
- `Warning-lane confirmation`

Selection should favor whichever gives the clearest player learning while preserving the current Gulper, Decoy, oxygen, cargo, extraction, scan, and result behavior.
