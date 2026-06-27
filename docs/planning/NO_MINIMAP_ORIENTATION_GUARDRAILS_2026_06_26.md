# No-Minimap Orientation Guardrails - 2026-06-26

Status: current planning guardrail for larger side-view dive levels.

## Purpose

OceanGame should grow toward wider, Dave-the-Diver-like side-view expedition spaces without solving orientation by adding a minimap, exact locator, quest checklist, or route graph too early.

The player should learn the ocean as a place. That means the first larger-level work should make routes readable through visible geography, stable landmarks, depth-band identity, local return cues, and compact result memory.

## Current Rule

The current larger-map path is:

1. Keep the surface base/boat as the strongest return reference.
2. Use the HUD base direction for broad return orientation such as `up`, `up-left`, or `up-right`.
3. Give every side branch at least one named landmark before its payoff.
4. Give every connector a visible turnback point and a return-current cue before it asks for deeper commitment.
5. Let result copy remember broad places and research signals, not coordinates or objective steps.
6. Capture new route stages with deterministic Playwright screenshots when visual placement changes.

## Required Vocabulary For New Branches

Every larger side-view route issue should define:

- route name,
- starting landmark,
- payoff or reason to enter,
- safe return cue,
- turnback point,
- reset ownership,
- cheapest verification evidence.

For the current route sequence, `East Shelf Spur`, `East Shelf Arch`, `Shelf Drop Connector`, `Drop Arch`, and `Drop Echo` are the reference pattern.

## Prohibited First Solutions

Do not add these to solve early larger-level orientation:

- minimap,
- route graph,
- exact coordinates,
- exact objective locator,
- persistent map pin,
- field guide objective entry,
- quest checklist,
- broad route journal,
- compass that points to every reward.

These may be reconsidered only after larger levels become confusing even with landmarks, return cues, depth bands, and route-stage screenshots.

## Acceptance For Future Larger-Level Work

A future larger-level implementation should include:

- a planning note that names route, landmark, payoff, return cue, and turnback point,
- logic coverage for bounds, reset ownership, and broad base direction,
- no-locator/no-quest copy coverage for new result or scan lines,
- Playwright evidence for any meaningful camera, route, or visual layout change,
- explicit non-goals for minimap, quest checklist, exact locator, combat, full procedural generation, and broad content systems.

## Why This Matters

The project has already spent a lot of effort polishing the first slice. The next progress should be player-visible map growth: side-to-side movement, connected pockets, lower connectors, and eventually cave-like spaces. These guardrails keep that growth readable without pulling the project into UI systems before the route design proves it needs them.
