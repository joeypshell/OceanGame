# Save Progression Persistence Expectation - 2026-06-26

Status: documentation artifact for issue #287.

## Purpose

Clarify what should persist after closing/relaunching the prototype.

## Intended Behavior

Durable progression persists:

- banked resources,
- purchased upgrades,
- scan discoveries,
- best depth.

Active expedition state does not persist:

- current oxygen,
- carried cargo,
- active dive/result state,
- temporary Decoy Pulse spent state,
- current expedition seed/run-in-progress context.

On launch, the game should load durable progression but start from a fresh ready expedition instead of resuming mid-dive.

## Clean First-Run Testing

Use `F9` when debug telemetry is enabled to clear the prototype save and return to a clean Expedition 1 ready state.

This is intentional. Relaunching the game without `F9` should keep owned upgrades and discoveries.
