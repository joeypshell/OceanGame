# Backlog Replenishment After Visual Clarity - 2026-06-26

Status: next ordered issue queue after the visual clarity foundation batch.

## What Changed In The Completed Batch

The project now has:

- compact active/surface HUD separation,
- readable resource pickup silhouettes,
- improved player and base silhouettes,
- quieter depth bands,
- distinct Shell Reef, Thermal Vent, pressure lock/wreck, and Gulper danger visual language,
- lower-route overlap review,
- debug seed/condition helpers for repeatable reviews,
- screenshot workflow documentation,
- asset source/export/license folder conventions,
- monster research v1 planning,
- scanner progression v2 planning,
- visual pass impact review.

The main readability blocker shifted from overlapping playfield text to broader playable motivation and art appeal.

## Milestone Decision

Next milestone: `One More Expedition Motivation Slice`.

Goal: make a short loop feel more purposeful by connecting expedition-day framing, remembered places, creature/scanner research, first source-art replacement, and future mystery/access promises.

This milestone should not add a broad new system. It should turn the existing vertical slice into a clearer reason to dive again tomorrow.

## Direction Considered

### Day Rhythm

Needed now, but only lightly. The game should frame restarted runs as the next expedition day, not just a reset button. Avoid calendar systems, schedules, NPCs, or management UI.

### Region Memory

Needed next. The player should recognize Surface Base, Shell Reef, Thermal Vent, pressure wreck, and Gulper route as remembered places. Start with metadata/copy/planning and avoid a full map.

### Mystery Spine

Needed in planning before implementation. The Wreck Signal Cache and deeper echoes should imply a larger ocean mystery without becoming a quest checklist.

### Upgrade-As-Access

Keep this as the spine. `Pressure Seal I`, `Signal Lens I`, future `Echo Lens I`, predator research, and source-art readability should all help the player reach or understand previously promised routes.

### Monster Research

Ready for the first narrow implementation: result callout from Gulper route evidence. Do not add new predators, weapons, harvesting, or field-guide UI.

### Scanner Progression

Ready for a first v2 hint: Wreck Signal Cache re-scan planning language. Do not supersede `Signal Lens I` or add minimap/field guide behavior.

### Economy Depth

Not the immediate focus. Keep economy changes behind research/scanner motivation unless playtests show upgrade pacing is blocking the loop.

### Another Route Pocket

Defer. The current route pockets are finally readable enough to extract more value from them before adding a new biome pocket.

## Ordered Issue Batch

1. #163 Add next-expedition day framing to restart/result flow.
2. #164 Add Gulper route research result callout.
3. #165 Add Wreck Signal Cache re-scan planning hint.
4. #166 Replace Glow Plankton with first source/export asset.
5. #167 Extract pressure gate visuals into a reusable scene.
6. #168 Review open pressure-gate screenshots with predator warning visible.
7. #169 Plan first region identity map v1.
8. #170 Add stable region names to landmark metadata and review copy.
9. #171 Add condition review matrix using F3/F4/F5.
10. #172 Tune ready-panel changed-ocean copy.
11. #173 Plan first mystery spine v1.
12. #174 Replenish backlog after the one-more-expedition motivation slice.

## Guardrails

Do not add in this milestone:

- minimap,
- field guide,
- calendar simulation,
- NPC management,
- weapons,
- predator harvesting,
- new predator species,
- broad biome generation,
- large art pack import,
- route checklist UI,
- exact-coordinate scanner tracking.

## Success Gate

The milestone succeeds when:

- restarting feels like beginning the next expedition day,
- a Gulper route encounter can teach something in the result flow,
- the Wreck Signal Cache creates a next scanner curiosity without a minimap,
- at least one gameplay-readable object has a real source/export asset trail,
- one visual cluster begins moving out of `Main.tscn`,
- reviews can reproduce condition/seed states,
- the roadmap has a clearer region/mystery direction for the next batch.
