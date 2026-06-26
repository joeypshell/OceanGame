# First-Run Active Dive Comprehension Review - 2026-06-26

Status: solo review artifact for issue #286.

## Purpose

Review what a fresh player should understand during the first active dive minute after leaving the surface.

This is a solo comprehension pass. It does not add tutorial overlays, quest UI, objective checklists, minimaps, or field-guide UI.

## Review Checklist

| Element | Expected Read | Decision |
| --- | --- | --- |
| Oxygen | Player can see current oxygen and understand it is draining during the dive. | Pass |
| Depth | Player can see depth increasing as they descend. | Pass |
| Base direction | Player can tell the safe base is above/nearby and should return there. | Pass |
| Cargo slots | Player can see capacity and filled/empty slots without reading a long cargo list. | Pass |
| Scan target | Nearby target label and marker communicate what can be scanned. | Pass with watchlist |
| Burst prompt | `Space: burst -4 O2` reads as a movement tool with an oxygen cost. | Pass |
| First pickup/scan guidance | Status text nudges collect/scan then return without becoming a checklist. | Pass with watchlist |

## Watchlist

- Scan target, prompt, and status text share the dive-info panel; future copy should stay short.
- First-resource guidance should remain practical and contextual, not a tutorial paragraph.
- Lower-route clutter should not be used as the first active-dive comprehension target; first-run review should start near surface/shallow resources.

## Decision

Pass with watchlist.

The first active dive minute has enough player-facing structure: oxygen pressure, depth, safe return, cargo capacity, scan affordance, and burst movement are visible without a tutorial overlay. The next improvements should be copy/visual tightening, not new UI systems.

## Guardrails

- No objective checklist.
- No tutorial modal.
- No minimap or route graph.
- No field guide.
- No inventory grid.
- No hidden debug telemetry in normal active dive.
