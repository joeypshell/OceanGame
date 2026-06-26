# Hybrid Ocean Review - 2026-06-25

Status: applied review for #121.

## Review Method

This review applies `docs/planning/HYBRID_OCEAN_FIVE_SEED_REVIEW_TEMPLATE.md` to the current vertical slice.

Verification smoke:

- Normal timed launch: passed.
- Debug telemetry was not used for player-facing assumptions.

Scope:

- Surface Base,
- Shell Reef,
- Thermal Vent,
- Wreck Shelf / Pressure-Locked Research Wreck,
- Gulper Route,
- current seeded resource cluster patterns,
- current presentation-only expedition conditions.

This is a structured design/readability review, not a blind validation test.

## Five-Seed Review

| Expedition | Seed | Condition | Cluster Pattern | Readable Persistent Places | Meaningful Variation |
| --- | --- | --- | --- | --- | --- |
| 1 | `8919` | Kelp Bloom | Deep reward route | Surface Base, Shell Reef, Thermal Vent, pressure wreck, Gulper route | Deep-reward lure should tempt a lower route while Kelp Bloom is currently presentation-only. |
| 2 | `16838` | Predator Migration | Cautious shallows | Surface Base, Shell Reef, Thermal Vent, pressure wreck, Gulper route | Cautious resource pattern should support safer banking while Predator Migration is currently presentation-only. |
| 3 | `24757` | Rare Signal | Deep reward route | Surface Base, Shell Reef, Thermal Vent, pressure wreck, Gulper route | Deep-reward route plus Rare Signal thematically points toward wreck/cache interest, but signal mechanics are not condition-driven yet. |
| 4 | `32676` | Calm Current | Cautious shallows | Surface Base, Shell Reef, Thermal Vent, pressure wreck, Gulper route | Cautious layout plus Calm Current should be a readable safer-banking day once conditions gain effects. |
| 5 | `40595` | Thermal Bloom | Deep reward route | Surface Base, Shell Reef, Thermal Vent, pressure wreck, Gulper route | Thermal Bloom aligns well with Thermal Vent and optional glow route, but current condition is still briefing-only. |

## Persistent Geography

### Surface Base

Recognizable: yes.

The surface base remains the strongest persistent location. It owns start, extraction, result, upgrade, and next-expedition briefing. Safe-return cues are now stronger than optional route hints.

### Shell Reef

Recognizable: improving.

The latest landmark pass makes Shell Reef more readable as a midwater place. It supports the safer bank route fantasy and should remain stable across seeds.

Remaining risk:

- Shell Reef can still compete with reward and return-current visuals if future resources or route hints are added nearby.

### Thermal Vent

Recognizable: improving.

Thermal Vent now has a warmer silhouette and no longer depends on the removed route label. It clearly supports the pressure-seal clue and optional glow path.

Remaining risk:

- The optional warm-current route must stay soft enough to avoid reading as a mandatory objective arrow.

### Wreck Shelf / Pressure-Locked Research Wreck

Recognizable: yes, but visually dense.

The pressure gate now reads more firmly as a lock. The wreck/cache area is still the densest visual cluster because it combines lock, scan, future payoff, and deep reward context.

Remaining risk:

- Future signal/reward language near the wreck can still become confusing if more cues are added before marker rules are applied.

### Gulper Route

Recognizable: yes.

The Gulper route communicates danger before contact and remains tied to observation, warning, and non-lethal counterplay. It should remain a persistent learned danger route even when patrol route selection varies by seed.

Remaining risk:

- Predator warning plus deep reward can still create visual noise in lower-route decisions.

## What Currently Changes

Current meaningful variation:

- seeded resource cluster pattern,
- starter resource candidate selection,
- Gulper Eel route selection,
- deep reward lure visibility,
- current presentation-only expedition condition.

Current non-mechanical variation:

- Kelp Bloom,
- Predator Migration,
- Rare Signal,
- Calm Current,
- Thermal Bloom,
- and the other expedition-day conditions.

The condition system is now readable but not yet decision-changing. That is acceptable for this stage, but the next condition issue should make one condition create a small visible decision without changing core mechanics.

## Decision Impact

The current slice already supports:

- cautious Shell Reef banking,
- deeper Glow Plankton temptation,
- pressure-wreck return planning,
- Gulper route timing,
- extraction versus push-deeper decisions.

The hybrid model is only partially proven because current expedition conditions do not yet affect placement, visibility, warnings, or route hints. The seed/cluster systems create decisions; conditions currently explain the day rhythm.

## Cross-Seed Answers

- Which places felt persistent and learnable? Surface Base, Shell Reef, Thermal Vent, pressure wreck, and Gulper route.
- Which variation was visible before commitment? Cluster pattern and resource placement can become visible during descent; condition appears before dive but is currently copy-only.
- Did at least one seed encourage cautious banking? Yes, cautious shallows seeds support this.
- Did at least one seed tempt a deeper push? Yes, deep reward route seeds support this.
- Did at least one seed create a close return or failure? The current systems can, especially deep reward plus predator pressure, but this review did not record a fresh oxygen-margin run.
- Did any seed hide safe return? No known current seed does; safe-return cues were recently strengthened.
- Did any condition feel like invisible randomness? Not yet mechanically, because conditions are briefing-only.
- Did changed placement break depth-band identity? No known current resource rules break Kelp/Shell/Glow depth identity.
- Did predator pressure remain avoidable? Yes by current design: warning and route timing remain readable before contact.
- Did visual clutter block comprehension? The worst text clutter is fixed; remaining risk is dense lower-route visual overlap.

## Follow-Up Candidates

1. Add one presentation-to-visual condition effect for `Calm Current` or `Thermal Bloom`.
   - Keep it non-mechanical at first.
   - Example: Calm Current slightly emphasizes safe-return cues; Thermal Bloom slightly emphasizes Thermal Vent warmth.

2. Add condition id to debug telemetry only.
   - Keep player-facing copy clean.
   - Help future five-seed reviews record condition and cluster together.

3. Run a focused lower-route visual overlap review after marker prototypes are applied.
   - Pressure lock, future signal, deep reward, predator warning, scan marker, and safe return should be checked together.

4. Plan the first actual condition-driven authored candidate weighting.
   - Use authored candidates only.
   - Do not add procedural biome generation.

5. Re-run five-seed review after one condition has a visible effect.
   - The review should answer whether the condition changed planning or only added flavor.

## Conclusion

The project should stay on the hybrid ocean path. The current vertical slice already has persistent geography and seeded opportunity variation. The main missing piece is that expedition-day conditions need one narrow visible effect before they can be judged as gameplay-relevant rather than flavor.

Do not broaden into full procedural regions yet. The next step should be a small condition effect or condition telemetry issue, followed by another five-seed review.
