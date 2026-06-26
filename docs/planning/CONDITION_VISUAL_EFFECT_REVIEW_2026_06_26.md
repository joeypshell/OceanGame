# Condition Visual Effect Review - 2026-06-26

## Status

Review completed after the first two non-mechanical condition visual effects:

- `Thermal Bloom`: warmer Thermal Vent visuals and stronger vent bubbles.
- `Calm Current`: slightly stronger safe-return lane/ribs/beacon.

This review checks whether condition presentation improves run identity or adds noise. It does not treat the visual effects as gameplay mechanics.

## Five-Seed Review

| Expedition | Seed | Condition | Cluster Pattern | Visible Effect | Readability | Decision Impact |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | `8919` | Kelp Bloom | Deep reward route | No special visual effect yet. | Baseline route readability. | Cluster still carries the decision; condition is flavor only. |
| 2 | `16838` | Predator Migration | Cautious shallows | No special visual effect yet. | Baseline predator warning readability. | Predator condition has no decision impact yet. |
| 3 | `24757` | Rare Signal | Deep reward route | No special visual effect yet. | Baseline wreck/cache readability. | Rare Signal is flavor only despite matching wreck interest. |
| 4 | `32676` | Calm Current | Cautious shallows | Safe-return lane/ribs/beacon are slightly stronger. | Improves orientation without reading as a mandatory arrow. | Supports cautious banking readability, but does not change mechanics. |
| 5 | `40595` | Thermal Bloom | Deep reward route | Thermal Vent warmth/plume/bubbles are stronger. | Improves Thermal Vent identity without overpowering Shell Reef. | Supports vent curiosity, but does not change placement or rewards. |

## Findings

### Flavor

The visual effects make the day condition feel less like pure text. `Thermal Bloom` is the stronger flavor win because it ties directly to a place the player can visit and scan. `Calm Current` is subtler but supports the survival loop by reinforcing the route home.

### Readability

Both visual effects are acceptable at current intensity.

- `Thermal Bloom` improves vent identity and does not currently hide the pressure gate, Shell Reef, or reward lure.
- `Calm Current` improves return orientation and stays below the threshold of feeling like a hard objective arrow.

The conditions without effects still read as briefing flavor only. That is fine temporarily, but repeated runs will make them feel hollow if they stay text-only.

### Decision Impact

Current condition effects do not change decisions by themselves. They help the player interpret existing authored opportunities:

- `Calm Current` supports cautious banking and safe-return confidence.
- `Thermal Bloom` supports vent curiosity and pressure-seal clue memory.

The decision-making still comes from cluster pattern, authored spawn candidates, pressure lock state, resource/cargo pressure, oxygen margin, and predator route.

## Weighting Candidate

First condition-driven authored weighting candidate: `Thermal Bloom`.

Reason:

- It maps cleanly to an existing authored candidate set: vent-adjacent `Glow Plankton`.
- It can bias existing deep/vent glow candidates without adding resources or changing depth identity.
- It has a clear review question: does warmer vent presentation plus vent-adjacent candidate preference make the day feel different without becoming procedural?

Do not choose `Calm Current` as the first weighting candidate yet. Its safest future mechanic would involve safe-return readability or route pressure, but those are easier to make accidentally mechanical or hidden. Keep `Calm Current` visual-only until the return/readability language has more review history.

## Follow-Up

1. Plan `Thermal Bloom` authored spawn weighting.
   - Bias existing `Glow Plankton` candidate selection toward vent-adjacent authored points.
   - Preserve one active deep `Glow Plankton` pickup.
   - Preserve deep depth-band identity.

2. Add deterministic tests for condition weighting.
   - Same seed and condition should select the same candidate.
   - Thermal Bloom should only bias existing candidates.
   - Non-Thermal Bloom conditions should preserve current behavior.

3. Re-review after weighting.
   - Confirm the condition changes opportunity placement enough to notice.
   - Confirm it does not obscure safe return or make Thermal Vent mandatory.

## Decision

Keep `Thermal Bloom` and `Calm Current` visual effects. Promote `Thermal Bloom` to the first condition-driven authored weighting plan. Keep all condition mechanics authored, deterministic, and bounded.
