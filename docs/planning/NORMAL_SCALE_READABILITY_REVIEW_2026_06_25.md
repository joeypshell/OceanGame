# Normal-Scale Readability Review - 2026-06-25

Status: baseline review for #114.

## Review Method

This review applies `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md` to the current vertical slice after the first label cleanup. It combines normal launch smoke, scene inspection, and representative route review for the current deterministic expedition sequence.

Verification smoke:

- Normal timed launch: passed.
- Debug telemetry: kept hidden for the player-facing readability assumptions.

Representative expedition seeds:

- Expedition 1: `8919`
- Expedition 2: `16838`
- Expedition 3: `24757`

## Summary

The worst world-text blocker has improved. The Thermal Vent route label and future cache signal label are gone, and the pressure label is now compact. The scene is still visually rough, but the most serious readability risk has shifted from overlapping sentences to visual priority: safe return, route hints, reward glow, pressure lock, and predator warning all need clearer hierarchy.

## Scenario Notes

### Expedition Ready Panel

- Player visible: not applicable before dive.
- Safe return readable: not applicable.
- World text overlap: pass.
- Notes: The ready panel now includes a current expedition condition plus the goal and start prompt. This is readable in structure, but future copy should stay strict because this panel can become a new text wall if condition effects grow.

Recommended narrow fix:

- Keep condition briefing to one headline plus one short line.

### Shallow Departure

- Player visible: pass.
- Nearest pickup readable: pass.
- Safe return readable: pass.
- World text overlap: pass with caution.
- Notes: The surface/base orientation reads through the base art, return column, and base HUD. The persistent left HUD is still dense, but it is not covering the playfield.

Recommended narrow fix:

- Later active-dive HUD compaction could hide surface-only hints after the player leaves base.

### Shell Reef Route

- Player visible: pass with caution.
- Nearest pickup readable: pass.
- Selected scan target readable: pass.
- Safe return readable: pass with caution.
- World text overlap: pass.
- Notes: Shell Reef reads better as a landmark because it is visual rather than labeled. The return-current language exists, but reward colors and reef shapes can still compete with safe-return meaning.

Recommended narrow fix:

- Clarify safe-return visual priority over optional route hints.

### Thermal Vent Scan And Revealed Route

- Player visible: pass.
- Selected scan target readable: pass.
- Current/route hint readable: pass with caution.
- Safe return readable: pass with caution.
- World text overlap: pass.
- Notes: Removing `VentRouteHint/RouteLabel` helps. The remaining arrow/ribbon is less text-heavy, but it still risks reading like an objective arrow if too visually strong.

Recommended narrow fix:

- Keep Thermal Vent route hints soft and make sure they do not overpower base-return language.

### Pressure-Locked Wreck Before `Pressure Seal I`

- Player visible: pass with caution.
- Pressure gate state readable: pass.
- Selected scan target readable: pass with caution.
- Safe return readable: pass with caution.
- World text overlap: pass.
- Notes: The compact `LOCKED: Pressure Seal I` label is a major improvement over the longer route label. The remaining risk is visual overlap among pressure shimmer, gate bars, wreck glow, scan marker, cache signal, and deep reward colors.

Recommended narrow fix:

- Differentiate pressure gate visuals from current-route hints and reward signals.

### Gulper Eel Warning Route

- Player visible: pass with caution.
- Predator warning readable before contact: pass.
- Nearest pickup readable: pass with caution.
- Safe return readable: pass with caution.
- World text overlap: pass.
- Notes: Predator warning uses a distinct danger color and is not label-driven. The route can still feel visually busy when reward lure, predator warning, and deep haze are all visible.

Recommended narrow fix:

- Preserve predator warning as sharp danger language, but ensure it does not hide pickup silhouettes or route openings.

### Deep Reward Push And Return

- Player visible: pass with caution.
- Reward readable: pass with caution.
- Safe return readable: caution.
- World text overlap: pass.
- Notes: The deep reward lure communicates temptation, but it can compete with safe-return cues. The main remaining comprehension risk is whether the player can confidently identify how to retreat once committed.

Recommended narrow fix:

- Clarify safe-return visual priority over route hints.

### Low-Oxygen Return

- Player visible: pass.
- Safe return readable: pass.
- HUD text overlap: pass with caution.
- Notes: Low-oxygen HUD feedback points back to base and increases urgency without changing mechanics. The left HUD can become visually loud, but it is useful and does not cover the playfield.

Recommended narrow fix:

- Keep low-oxygen emphasis focused on oxygen and base direction, not additional warning copy.

### Extraction / Failure Result

- Surface panel readable: pass.
- Debug telemetry hidden: pass.
- Notes: Result panels prioritize cargo, scans, route choice, upgrade progress, and best depth. This is not the current readability blocker.

Recommended narrow fix:

- None for this milestone unless condition results are added later.

## Blocking Readability Issues

1. Safe-return cues need stronger priority over optional route hints and reward lures.
2. Pressure gate visuals need clearer distinction from current hints and reward/future signal language.
3. Shell Reef and Thermal Vent should become recognizable landmarks with less reliance on text or temporary status guidance.
4. Deep route reward, predator warning, and pressure promise can still produce visual noise in the same lower-screen area.

## Follow-Up Candidates

- Clarify safe-return visual priority over route hints.
- Differentiate pressure gate visuals from current-route hints.
- Tighten Shell Reef and Thermal Vent landmark readability.
- Create icon and marker rules for scan, lock, danger, reward, and return.

## Deferred Art Polish

- Final sprites, lighting, animation, particles, and sound.
- A full visual identity pass for biomes.
- Production-quality UI skins.
- Large asset packs.

## Conclusion

The prototype has moved past the worst text-overlap failure, but it is not yet visually clear. The next implementation work should focus on visual hierarchy rather than adding new mechanics: safe return first, then lock/danger/reward/scan differentiation, then landmark identity.
