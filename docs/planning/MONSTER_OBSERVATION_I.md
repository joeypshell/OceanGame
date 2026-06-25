# Monster Observation I

Status: promoted to active implementation issue #60, `Add Gulper Eel observation scan`.

## Purpose

`Monster Observation I` is the first monster-hunting progression slice after the scanner/cargo milestone. It should make the player feel like they are learning a dangerous animal before the game adds stronger predator tools, traps, or hunting systems.

This is not a combat milestone. The first step should support route reading, oxygen timing, and future preparation.

## First-Step Options

### Predator Scan Profile

Effect: let the player scan the existing `Gulper Eel` or a nearby observation target to record a practical behavior note.

Strengths:

- Uses existing scan, discovery, result-log, and HUD language.
- Reinforces the ecological research fantasy.
- Gives the player a durable reason to approach danger without requiring contact.
- Can feed later upgrades such as warning range, route tagging, decoys, or repel tools.

Risks:

- If the scan requires getting too close, it can feel unfair.
- If the result is only flavor text, it will not change player decisions.

### Warning-Range Improvement

Effect: after observing a predator, the warning current or patrol hint becomes visible earlier or from farther away.

Strengths:

- Directly improves predator readability.
- Supports safer route planning without reducing oxygen pressure.

Risks:

- Easy to over-tune into removing predator risk.
- Better as a follow-up upgrade after the game proves that predator observations matter.

### Decoy Or Repel Setup

Effect: unlock a non-lethal tool or preparation that distracts, repels, or delays one predator encounter.

Strengths:

- Creates a strong route-preparation payoff.
- Moves toward the future monster-hunting fantasy without weapons.

Risks:

- Too much scope for the first observation step.
- Requires tool UI, cooldown/cost rules, and careful predator behavior tuning.
- Can overlap with the already implemented `Burst Thruster` if introduced too early.

### Route-Tagging Clue

Effect: observing the predator tags the currently contested route or records a clue about safer timing.

Strengths:

- Fits the seeded-expedition structure.
- Helps the player connect predator behavior to route choice.

Risks:

- Can become a minimap substitute if overbuilt.
- Needs a clear display surface so the tag is not lost in text.

## Recommendation

Implement `Predator Scan Profile` first as `Gulper Eel Observation`.

Concrete future implementation issue title: `Add Gulper Eel observation scan`.

The first implementation should add a scannable observation target for the current `Gulper Eel` route, not a new predator type or tool. The scan should record a discovery that explains:

- the eel controls a contested deep route,
- warning currents and patrol hints can be used to avoid contact,
- contact costs oxygen and knocks the player back,
- future non-lethal countermeasures may use this observation data.

## Unlock Requirements

- No new upgrade is required for the first observation scan.
- The target should be reachable in a normal dive but placed near the existing predator warning route so the player must decide whether the scan is worth oxygen and risk.
- Repeat scans should remain free under the current repeat-scan rule.

## Expected Player Decision

The player sees predator warning feedback and chooses whether to:

- approach close enough to scan and bank the observation for future progression,
- detour around the route and keep cargo safe,
- use `Burst Thruster` as an oxygen-cost recovery tool if they misjudge the route,
- abandon the deep reward and return with current cargo.

## Non-Lethal Constraints

Do not add:

- weapons,
- predator damage, stun, health, or kill states,
- predator harvesting,
- hunting contracts,
- multiple predator types for content volume,
- broad tool wheels,
- permanent route removal.

`Monster Observation I` should make the current predator more legible and more useful as progression context, not easier to defeat.

## Verification Criteria

- Scanning the observation target records a durable `Gulper Eel` discovery.
- The scan result names the practical behavior and next decision in player-facing language.
- The scan does not damage, stun, repel, or harvest the predator.
- Result summaries and the recent expedition log include the scan like other discoveries.
- Debug-only seed, cluster pattern, and predator route telemetry remain gated behind F3.
- Existing predator contact, knockback, oxygen cost, seeded route placement, extraction, and failure behavior do not regress.
