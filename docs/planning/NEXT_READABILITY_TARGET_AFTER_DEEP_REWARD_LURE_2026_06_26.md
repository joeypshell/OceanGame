# Next Readability Target After Deep Reward Lure - 2026-06-26

Status: selected planning target; no broad art pass.

Issue: #418.

## Decision

Select the lower-route pressure/cache/reward/predator cue stack as the next narrow readability target.

This is not a new source-art implementation by default. The deep reward lure source-art pass improved the reward read enough that the next risk is composition pileup: pressure gate, cache signal, reward lure, predator lane, Wreck Echo cue, and player/sub all compete in the same lower-route band, especially at `960x540`.

## Why This Target

Recent evidence says:

- the deep reward lure now reads more like optional material opportunity,
- predator danger remains readable,
- Wreck Echo remains a narrow clue/result promise,
- mobile-like lower-route captures are usable but compressed,
- pressure/cache/reward cues are partly cropped or visually dense near the right/top route cluster.

The next work should evaluate and, if needed, tune relative opacity, fallback visibility, cue spacing, and marker priority before adding another asset.

## Allowed Follow-Up Shape

A later implementation issue may:

- reduce fallback geometry that no longer carries meaning,
- tune cue alpha/scale/order for pressure/cache/reward/predator/Wreck Echo separation,
- move small non-gameplay visual children only if it does not move routes, collisions, gates, pickups, scan targets, or triggers,
- add one small source/export/provenance asset only if the review proves an existing cue cannot be separated by tuning.

## Do Not Do

- Do not start a broad art-kit integration pass from this target.
- Do not add new routes, resources, scans, upgrades, Wreck Echo behavior, monster behavior, or procedural generation.
- Do not add labels, minimaps, field guides, route graphs, objective checklists, combat, capture, harvesting, or touch/controller implementation.
- Do not brighten every cue; priority should be meaning separation, not spectacle.

## Next Issue Relationship

#419 should perform the lower-route visual pileup review and decide whether this selected target needs a tuning implementation, a tiny source-art pass, or no change.
