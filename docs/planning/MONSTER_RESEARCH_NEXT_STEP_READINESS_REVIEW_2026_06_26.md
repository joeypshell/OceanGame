# Monster Research Next-Step Readiness Review - 2026-06-26

Status: plan next observational step; do not implement combat.

Issue: #401.

## Purpose

Evaluate what the next monster-research step should be after current slice polish while keeping weapons, harvesting, capture, predator health, combat, permanent predator control, field-guide UI, and broad monster systems out of scope.

## Current Implemented Base

OceanGame already has a small but useful non-combat creature foundation:

- `Lantern Fry` is a passive scannable creature that points toward nearby `Glow Plankton`.
- `Gulper Eel` is a seeded predator route with warning lanes, patrol/chase/contact behavior, oxygen risk, and knockback.
- `Predator Warning I` improves route warning readability without changing predator rules.
- `Decoy Pulse I` creates one temporary route-timing window after a `Gulper Eel` re-scan, without damaging, stunning, harvesting, trapping, or removing the predator.
- Result summaries can record compact session-only Gulper research evidence from scanning, contact, or decoy timing.

## Readiness Decision

The project is ready to plan a next monster-research step, but not ready to implement combat or capture.

The next step should be a behavior-observation contract, not a hunting system. It should answer:

- what evidence the player can gather,
- what behavior the creature demonstrates,
- what temporary or durable memory is allowed,
- what upgrade or route-readability payoff the evidence supports,
- how the result panel explains the learning without becoming a field guide.

## Recommended Next Step

Plan `Monster Research II` as a narrow observation/readability milestone before adding any new creature system.

Preferred first issue shape:

> Define Monster Research II as non-combat behavior evidence.

Acceptance should include:

- one selected evidence type, such as patrol timing, lure response, warning-lane confirmation, or passive-creature route hint,
- one result-memory or upgrade-readiness payoff,
- explicit ownership for run-scoped versus durable evidence,
- no weapons, damage, capture, harvesting, health bars, bestiary, field guide, checklist, or creature inventory,
- tests or review notes proving existing `Gulper Eel`, `Predator Warning I`, `Decoy Pulse I`, oxygen, cargo, extraction, and scan behavior are unchanged.

## Not Ready Yet

Do not implement these until a future milestone explicitly promotes them:

- weapons or harpoons,
- monster health,
- harvesting or loot tables,
- capture or cages,
- permanent predator removal,
- broad bestiary/field guide,
- creature collection,
- procedural predator ecosystems,
- mobile/controller combat controls.

## Why This Order

The current compulsion layer benefits more from "I learned how this creature behaves, so my next dive is smarter" than from combat. Observation keeps the game aligned with the current loop: dive, notice, scan, survive, return, improve, and try again with better route knowledge.

Combat can still be a future direction, but it should come after the project proves route readability, oxygen pressure, creature tells, result memory, and upgrade preparation are fun without extra verbs.
