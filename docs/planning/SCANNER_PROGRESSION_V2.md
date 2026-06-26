# Scanner Progression v2

Status: planning recommendation for the next scanner payoff after `Signal Lens I`; the initial `Wreck Signal Cache` repeat-scan planning hint, `Echo Lens I` upgrade definition, first broad wreck echo, and compact result-memory line are implemented.

## Direction

The scanner should make the ocean feel more knowable without making it solved. It should reveal partial information that creates curiosity, route planning, and another-expedition motivation.

The current implemented scanner ladder is:

1. Basic scans identify resources, creatures, environment clues, and wreck signals.
2. `Pressure Seal I` opens the first research wreck.
3. `Wreck Signal Cache` unlocks `Signal Lens I`.
4. `Signal Lens I` lets repeat resource scans point toward a nearby matching visible uncollected deposit.

Scanner v2 should build on this, not replace it.

## Recommended Upgrade

Name: `Echo Lens I`.

Unlock source: `Wreck Signal Cache`, after `Signal Lens I` is owned.

Role: detect one nearby unresolved signal category as a vague route clue after the player has enough context to care.

Implemented cost target: `Kelp Fiber x1`, `Shell Fragments x2`, and `Glow Plankton x3`. This should still be tuned later against oxygen margin and cargo pressure, but it costs slightly more deep-biological material than `Signal Lens I` so the player has a reason to plan another glow/deep expedition before buying it.

Likely discovery gate: `wreck_signal_cache`.

Likely upgrade gate: `signal_lens_1`.

Player-facing effect:

- Re-scanning a known non-resource route clue can produce a short `echo` hint.
- The hint names a signal type and broad direction/depth band, not exact coordinates.
- The hint expires quickly and does not persist as a map marker.

Example status lines:

```text
Echo Lens: weak wreck signal deeper-right.
Echo Lens: warm biological echo below.
Echo Lens: no unresolved echo nearby.
```

## Why This Fits

`Signal Lens I` answers: "Where is another known material?"

`Echo Lens I` should answer: "Is there a strange route worth planning around tomorrow?"

It supports:

- route clarity: points toward category and broad direction,
- mystery: suggests unresolved signals without explaining everything,
- one-more-expedition motivation: gives the player a reason to return with oxygen, cargo space, or pressure access,
- hybrid-ocean structure: stable regions can hold remembered signal categories while seeded runs vary whether the route is attractive today.

## Difference From Signal Lens I

`Signal Lens I` is practical and material-facing:

- works on known resource scans,
- points toward another visible matching uncollected deposit,
- helps the current cargo/banking decision.

`Echo Lens I` should be curiosity-facing:

- works on known non-resource route clues such as the `Wreck Signal Cache`,
- names an unresolved signal category and broad direction/depth band,
- helps the next-expedition planning decision rather than guaranteeing immediate loot.

Do not let `Echo Lens I` replace `Signal Lens I`, reveal exact locations, or turn every scan target into a checklist entry.

## Partial Information Rule

The scanner may reveal:

- broad direction: left/right/up/down or deeper/shallower,
- broad signal category: wreck, thermal, biological, pressure, or rare signal,
- whether the signal is unresolved this expedition.

The scanner must not reveal:

- exact coordinates,
- a minimap marker,
- every objective in range,
- hidden content behind an unopened pressure gate unless the player has earned the relevant clue,
- complete route safety,
- full field-guide entries.

## First Signal Category

First implementation candidate: `wreck echo`.

Reason:

- It naturally follows the `Wreck Signal Cache`.
- It reinforces the pressure-wreck promise without adding a new region.
- It can point toward future scanner improvement or deeper research objective language already present in current gameplay.
- It avoids interfering with resource pickup readability, predator danger, or safe-return visuals.

Recommended first behavior:

- Re-scan `Wreck Signal Cache` after owning `Signal Lens I`.
- If no v2 upgrade exists yet, show a compact planning hint that the cache can be studied further. Implemented copy currently reads as a local unresolved `cache echo`, not a map marker or objective tracker.
- After `Echo Lens I` exists, the re-scan produces the first vague wreck echo: `Echo Lens: weak wreck signal deeper-right.`

## UI Surface

Use existing surfaces:

- active dive status line for the immediate echo,
- result summary for one compact route-planning line if an echo was followed or banked,
- upgrade bay for future `Echo Lens I` availability.

Visual support: `assets/source/sprites/ui_scan_echo_pulse_v1.svg` / `assets/exports/sprites/ui_scan_echo_pulse_v1.svg` is wired as a hidden local `EchoPulse` sprite on `WreckSignalCache`. It briefly expands/fades only when `Echo Lens I` fires from a repeat cache scan, reinforcing temporary partial scanner information without implying a persistent marker.

Avoid:

- field guide,
- minimap,
- persistent objective list,
- exact distance readout,
- multi-signal checklist,
- new scanner energy meter.

## Constraints

Preserve current `Signal Lens I` behavior:

- repeat resource scans should still pulse toward visible matching resources,
- hidden or pressure-locked content should not be spoiled,
- repeat tactical scans remain free for the current prototype,
- scan targeting stays nearest-target and deterministic.

Keep `Echo Lens I` lower priority than safe return and immediate danger. Echo hints should be curiosity cues, not emergency navigation.

## Data Needs

The first implementation can stay small:

- add an `Echo Lens I` upgrade definition with `wreck_signal_cache` and `signal_lens_1` gates,
- define a small set of echo categories in code or authored metadata,
- pick one target category for the first issue: `wreck`,
- format a broad direction/depth phrase,
- track whether a run generated an echo for result copy.

Do not add a general quest system or route graph yet.

## First Narrow Implementation Slice

Implement only the Wreck Signal Cache echo:

- add data-backed `Echo Lens I` to the upgrade bay,
- after ownership, repeat-scanning known `Wreck Signal Cache` produces one compact broad echo: `Echo Lens: weak wreck signal deeper-right`,
- if no unresolved echo is available, show `Echo Lens: no unresolved echo nearby`,
- add one compact result line only when an echo fired during the expedition,
- keep repeat scans free for the current prototype.

This slice should not add a minimap, field guide, exact distance, route graph, multi-echo list, scanner energy, or any new hidden object reveal beyond the broad wreck-echo phrase.

## Out Of Scope

- Minimap.
- Field guide.
- Exact-coordinate checklist.
- Scanner energy or cooldown economy.
- Automatic pathfinding.
- Global objective tracker.
- Broad scanner tree UI.
- Revealing every resource or discovery in a region.
- Superseding `Signal Lens I`.

## First Implementation Issue

Recommended next implementation issue:

`Add Wreck Signal Cache re-scan planning hint`

Acceptance sketch:

- Re-scanning `Wreck Signal Cache` after owning `Signal Lens I` gives a compact hint that future echo-lens study can reveal unresolved wreck signals.
- The hint uses active status/result language only; no minimap or field guide.
- Existing `Signal Lens I` resource pulse behavior is unchanged.
- Hidden pressure-locked or future content is not revealed as exact location data.
- Add logic coverage for scanner v2 copy and existing Signal Lens behavior.
- Verify with Godot headless launch, logic tests, normal timed launch, MCP self-test if docs/resources change, and `git diff --check`.
