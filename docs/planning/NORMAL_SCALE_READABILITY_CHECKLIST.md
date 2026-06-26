# Normal-Scale Readability Checklist

Status: solo visual review checklist for normal-scale playtests.

## Purpose

Use this checklist to review whether the current game can be understood while actually playing at normal camera scale. It is meant for Codex or the project owner to run without blind-test helpers.

This is not a final-art critique. It asks whether the player can read the route, state, next decision, and alien-ocean expedition fantasy from the current view.

## Setup

- Launch the project normally.
- Keep the default camera scale and viewport.
- Keep debug telemetry hidden unless a prompt explicitly asks for it.
- Use the current deterministic expedition sequence.
- Record expedition number, seed, condition, and cluster pattern only if debug telemetry is enabled after the readability pass or a debug helper makes those values available.
- Save or reference at least one screenshot path for every failed or confusing view.

## Solo Review Header

Record this before judging a screenshot or play moment:

```text
Review date:
Reviewer:
Build/commit:
Viewport:
Screenshot path:
Expedition number:
Seed:
Condition:
Cluster pattern:
View/state: surface ready / active dive / result / failure
Current objective:
Visible route or landmark:
Immediate confusion:
```

## Scenario Set

Review at least these moments:

1. Expedition ready panel before the dive begins.
2. Shallow departure from the surface base.
3. Midwater Shell Reef route.
4. Thermal Vent scan/revealed route hint.
5. Pressure-locked wreck before `Pressure Seal I`.
6. Gulper Eel warning route.
7. Deep reward push and return path.
8. Low-oxygen return toward the base.
9. Extraction/failure result panel.

## Surface-Ready Prompts

Use these before starting the dive:

- Can I tell this is the beginning of a new expedition day rather than an in-progress dive?
- Can I identify the surface boat/lab as the safe origin?
- Does the condition line suggest the ocean is different today without implying a new rule that is not implemented?
- Does the goal line give one useful reason to dive now?
- Do banked resources, upgrades, and past discoveries stay out of the way unless the selected surface view is about them?
- Does the view create curiosity about what changed below the surface?

## Active-Dive Prompts

Use these while moving:

- Can I identify where I am: surface, Shell Reef, Thermal Vent, pressure wreck, Gulper route, or deep reward lane?
- Can I identify the safest direction back to base within two seconds?
- Can I tell what is stable geography versus what appears to vary this expedition?
- Can I tell whether the next object is cargo, scan target, route hint, lock, danger, or future promise?
- Does the current view create a reason to keep pushing, return safely, or plan another expedition?
- If I fail here, would I know what to try differently tomorrow?

## Pass/Fail Checks

### Player And Movement

- Pass if the player/sub is visible against the background in shallow, midwater, and deep water.
- Pass if the player is not hidden by labels, translucent route hints, predator warning shapes, or landmarks.
- Fail if the player disappears inside overlapping text or same-value shapes.

### Pickups And Rewards

- Pass if the nearest pickup reads as cargo before it reads as decoration.
- Pass if resource color/shape remains distinct from scan markers, warning shapes, and pressure gates.
- Fail if a reward lure looks like a locked gate or predator warning.

### Scan Targets

- Pass if the selected scan target is identifiable without placing a label directly over every target.
- Pass if scan markers hug the target rather than pointing across the whole route.
- Fail if scan feedback requires reading a world paragraph over the playfield.

### Pressure Gate

- Pass if the pressure gate reads as blocked before `Pressure Seal I`.
- Pass if the compact blocker label does not cover the player, cache, return route, or nearby pickup.
- Pass if the open state reads differently after `Pressure Seal I`.
- Fail if the gate looks like a soft current hint or optional reward signal.

### Current And Route Hints

- Pass if current hints read as suggestions, not guaranteed safe routes.
- Pass if Thermal Vent and Shell Reef hints do not overpower safe-return language.
- Fail if arrows, ribbons, or labels imply a mandatory objective.

### Predator Warning

- Pass if the Gulper route communicates danger before contact.
- Pass if danger color/shape remains distinct from reward glow and pressure locks.
- Fail if the predator warning hides the player, pickup, or route opening.

### Safe Return

- Pass if the player can identify the direction back to the surface/base from midwater and deep routes.
- Pass if safe-return language is visually calmer but more reliable than optional route hints.
- Fail if any seed or route hint obscures the return direction.

### HUD And Text

- Pass if active-dive HUD text is short and mode-specific.
- Pass if world labels are limited to true blockers or selected focus.
- Fail if two labels overlap, a long sentence covers the route, or the player must stop moving to parse a paragraph.

### Surface Panels

- Pass if the ready panel shows condition, goal, and start prompt without a wall of text.
- Pass if extraction/failure results prioritize cargo, scans, upgrade progress, route choice, and best depth.
- Fail if debug seed/pattern telemetry appears while debug mode is hidden.

### Stable Places And Daily Change

- Pass if the player can recognize stable places such as Surface Base, Shell Reef, Thermal Vent, pressure wreck, and Gulper route after seeing them more than once.
- Pass if condition and cluster changes feel like today's ocean variation, not a completely unrelated map.
- Fail if the view feels randomly noisy with no learnable place identity.

### Forbidden Routes And Mystery

- Pass if locked routes, weak signals, cache hints, and deeper glows create desire to return after upgrading.
- Pass if mystery cues remain quieter than immediate safety, cargo, lock, and danger cues.
- Fail if future promise looks like an immediate objective, open path, or collectible.

### Another Expedition Pull

- Pass if the current view suggests at least one next-run intention: buy an upgrade, return to a marked route, gather a missing material, test a condition, avoid a danger lane, or chase a mystery signal.
- Fail if the view only says "continue downward" with no remembered place, route choice, or future plan.

## Recording Template

```text
Review date:
Reviewer:
Build/commit:
Viewport:
Screenshot path:
Expedition:
Seed:
Condition:
Cluster pattern:
View/state:
Scenario:
Current objective:

Player visible: pass/fail
Base/safe return readable: pass/fail
Nearest pickup readable: pass/fail
Selected scan target readable: pass/fail
Pressure gate state readable: pass/fail/not present
Predator warning readable before contact: pass/fail/not present
Stable place recognizable: pass/fail
Daily-change cue readable: pass/fail/not present
Forbidden-route or mystery pull: pass/fail/not present
World text overlap: pass/fail
Reason to start another expedition: pass/fail

Blocking issue:
Recommended narrow fix:
Deferred art polish:
```

## Success Gate

A readability pass is acceptable when:

- no long world text obscures the active route,
- the player can see themselves and the next relevant object,
- safe return remains legible from the current route,
- blocked, dangerous, rewarding, and scannable meanings are visually distinct,
- stable places and day-to-day variation can coexist without noise,
- at least one view creates a concrete reason to return for another expedition,
- and any remaining problem can be described as future art polish rather than basic comprehension failure.
