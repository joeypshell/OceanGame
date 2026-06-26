# Expedition Day Conditions

Status: planning vocabulary for the hybrid ocean model.

## Purpose

Expedition-day conditions explain why a seeded dive feels different without making the ocean feel arbitrary. They should sound like observable ocean behavior: currents, blooms, migrations, visibility, rare signals, and wreck shifts.

This document defines the first condition vocabulary. It does not authorize mechanical effects by itself.

## Design Rules

- Conditions are in-game expedition-day states, not real-world daily challenges.
- Conditions should make the player form a simple plan before diving.
- Conditions must not erase persistent geography, depth-band identity, or safe return orientation.
- First implementation may be copy-only on the ready panel.
- Later effects should select from authored candidates instead of generating free-form map changes.
- A condition can make an opportunity more tempting, but it should not create unavoidable failure.

## Initial Condition Set

| Condition | Player-Facing Briefing | Later May Affect | Must Not Affect Yet |
| --- | --- | --- | --- |
| Calm Current | Calm Current: safe routes are easier to read today. | Softer current hints, safer starter resource layout, clearer return lanes. | Oxygen drain, cargo rules, pressure locks. |
| Kelp Bloom | Kelp Bloom: shallow growth is unusually thick. | More shallow kelp candidate emphasis, denser shallow silhouettes, early resource lure. | New resource tiers, blocked return paths. |
| Thermal Bloom | Thermal Bloom: warm water is stirring near the vent field. | Thermal Vent hint strength, vent-adjacent glow candidate weighting, warm-current visibility. | Free pressure unlocks, hidden oxygen refills. |
| Predator Migration | Predator Migration: Gulper movement is shifting near deep routes. | Predator route candidate selection, warning radius presentation, route timing pressure. | Predator damage values, unavoidable patrols, combat rewards. |
| Low Visibility | Low Visibility: deeper water is harder to read today. | Depth haze, shorter reveal distance, stronger safe-return beacons. | Scan range penalties or hidden hazards in the first pass. |
| Rare Signal | Rare Signal: a weak research ping is active below. | Wreck/cache signal emphasis, future scan opportunity selection, result callouts. | Guaranteed upgrade, random quest chains, new objective system. |
| Wreck Shift | Wreck Shift: pressure has exposed a different wreck angle. | Which authored wreck entrance, signal hint, or cache approach is active. | Moving major gate identity or bypassing `Pressure Seal I`. |

## First Implementation Recommendation

Start with a presentation-only condition:

- choose one condition deterministically from the expedition seed,
- show its name and one short line on the Expedition Ready panel,
- keep debug seed and cluster pattern hidden unless telemetry is enabled,
- do not change spawns, predator routes, oxygen, scan range, pressure gates, or resources yet.

This lets the player learn the morning-briefing rhythm before the conditions own mechanics.

Briefing layout guidance lives in `docs/planning/EXPEDITION_CONDITION_BRIEFING.md`.

## Copy Style

Use short, observable language:

- `Thermal Bloom: warm water stirs near the vent field.`
- `Predator Migration: deep patrols are shifting.`
- `Rare Signal: a weak research ping is active below.`

Avoid:

- `Random bonus day`,
- `+20% resources`,
- `Daily challenge seed`,
- or hidden system language that only describes the implementation.

## Later Success Gate

When conditions become mechanical, a five-seed review should confirm:

- the player can name the condition before diving,
- the condition changes at least one route or risk decision,
- the same region still feels recognizable,
- no condition obscures the safe return route,
- no condition replaces authored route readability with invisible randomness.
