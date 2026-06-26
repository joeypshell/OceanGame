# Mystery Spine V1

Status: planning output for issue #173.

## Purpose

OceanGame's first mystery spine should make the player feel that the ocean has a coherent hidden layer below the current safe route. It should create curiosity, route planning, and another-expedition motivation without becoming a quest log, field guide, minimap, or exact-marker system.

## Spine Name

The first spine is the Wreck Echo spine.

Player-facing question:

> What is still transmitting from below the pressure wreck?

This question is narrow enough for the current vertical slice and broad enough to support future scanner, region, and deeper-route work.

## Signal Chain

1. Surface Base frames the day.
   The ready panel says what feels different today and gives one practical goal.

2. Thermal Vent Field teaches pressure knowledge.
   Scanning the vent supports `Pressure Seal I` and makes the first locked route feel like a research problem, not a wall.

3. Wreck Shelf creates the blocked promise.
   The player can see the pressure-locked research wreck before they can fully use it.

4. `Pressure Seal I` turns memory into access.
   Returning with the seal opens a place the player already saw.

5. Wreck Signal Cache proves the promise.
   The cache is the first interior reward and unlocks `Signal Lens I`.

6. `Signal Lens I` makes scanner research practical.
   Known resource scans can point toward matching visible deposits, proving that wreck data improves future dives.

7. Wreck Signal Cache repeat scans hint at unresolved echoes.
   After `Signal Lens I`, the cache can say that future Echo Lens study may read deeper wreck signals.

8. Future `Echo Lens I` turns the hint into a route question.
   It should report broad echo category and direction, not a location checklist.

## Pressure Wreck And Cache Meaning

The pressure wreck and cache should imply a layered signal, not a quest chain.

What the player should infer:

- Wreck Shelf is a remembered place worth returning to.
- The pressure gate is a visible promise that upgrades can turn memory into access.
- `Wreck Signal Cache` is proof that reaching a blocked place can produce useful research.
- The unresolved cache echo suggests deeper wreck signals exist below or beyond the current safe route.
- Future scanner upgrades can make those echoes more readable, but only as broad route questions.

What this does not implement yet:

- exact signal coordinates,
- a persistent objective list,
- a map marker,
- a field-guide entry,
- a new story screen,
- a guaranteed safe route to the deeper signal.

The mystery signal should sit below practical priorities. If oxygen, cargo, predator warning, or safe return is urgent, those signals should remain louder than the wreck echo.

## Mystery Questions

The current slice should only raise a few questions:

- Why does the pressure wreck still transmit?
- What kind of signal is deeper than the current route?
- Is tomorrow's condition a good day to risk checking that signal?
- Which remembered place should I return to with better oxygen, cargo space, pressure access, or scanner tools?

The current slice should not answer:

- who built every wreck,
- the full history of the ocean,
- exact coordinates for future areas,
- a complete upgrade tree,
- every hidden object in a region.

## Player-Facing Surfaces

Use existing surfaces:

- ready panel: one compact reason today's ocean feels different,
- scan/status text: immediate practical or mysterious clue,
- result panel: one memory line about what the player learned or preserved,
- upgrade bay: practical next upgrade availability,
- visuals: silhouettes, cold signal glints, pressure gate state, scan pulse language.

Avoid:

- field guide entries,
- persistent quest journal,
- minimap,
- exact distance readouts,
- world-space paragraphs,
- multi-step objective checklist.

## Region Memory Connection

The Wreck Echo spine depends on remembered places:

- Surface Base is safe review and preparation.
- Thermal Vent Field is pressure knowledge.
- Wreck Shelf is the blocked promise.
- Pressure-Locked Research Wreck is the return payoff.
- Deeper water is the unresolved echo space.

Result copy and planning language should reinforce that chain as memory: "I saw Wreck Shelf, returned with Pressure Seal I, found the cache, and now know there may be a deeper wreck signal." It should not become "complete these objectives in order."

Daily variation should change whether a remembered place feels tempting today, not erase what the player learned yesterday.

## One-More-Expedition Pull

The spine should make a completed dive end with a simple intention:

- return with `Pressure Seal I`,
- buy `Signal Lens I`,
- re-scan the cache,
- gather resources for a scanner upgrade,
- use a favorable condition to check the wreck route,
- bank a scan even if no cargo came home.

This works because each step turns a prior observation into a future decision.

## Constraints

- Keep immediate safety, oxygen, cargo, and predator warning higher priority than mystery.
- Mystery hints should be compact and lower urgency than danger cues.
- Do not reveal exact hidden content behind an unopened pressure gate.
- Do not add a general story system before the scanner and route loop are readable.
- Do not make `Echo Lens I` replace `Signal Lens I`; it should answer a different question.
- Do not add a new scanner energy economy for this spine.

## First Implementation Recommendation

Recommended next issue:

`Add scanner echo copy for Wreck Signal Cache repeat scans`

Acceptance sketch:

- Re-scanning `Wreck Signal Cache` after `Signal Lens I` is owned keeps the current unresolved-echo hint compact and player-facing.
- The copy links the cache to future `Echo Lens I` curiosity without implying that the upgrade already exists.
- Result or status copy can remember that the dive preserved a useful mystery clue even if cargo is empty.
- Existing `Signal Lens I` resource-pulse behavior is unchanged.
- No minimap, field guide, exact coordinate, route graph, or persistent objective list is added.
