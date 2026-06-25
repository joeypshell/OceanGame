# Next Backlog Evaluation - 2026-06-25

Status update: this note is historical context. Its recommended issue order has been executed through #49. The current project-wide status and next decision gate are now captured in `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`, and the active issue order lives in `docs/current/ROADMAP.md`.

## Current Read

The implementation backlog is mostly caught up with the current progression-and-variety milestone. The remaining proof gap is not code: issue #37 still requires unfamiliar players to validate whether the current loop is understandable, whether the deep route is tempting, and whether predator risk feels fair.

The roadmap should not mark the milestone complete until #37 produces notes and follow-up issues. Still, there is useful planning and prep work that can happen without pretending the blind validation already happened.

## What Should Move Forward Now

### 1. Blind Validation Kit

The next unblocked task should make #37 easier to run:

- create a compact notes template,
- define the minimal setup script,
- document how to expose development telemetry with F3,
- make the expected output a small follow-up issue list.

This does not replace the actual blind test. It reduces friction so the test can happen cleanly.

### 2. Atmosphere And Readability Pass

The active visual slice has functional depth bands, landmarks, lure, pressure wreck, and predator warning, but it is still placeholder-heavy. A narrow readability pass is mature enough to queue because it supports blind validation without adding new systems.

The pass should improve:

- first-screen identity of the surface boat/lab,
- shallow/mid/deep visual distinction,
- readable return route,
- pressure wreck promise,
- predator route warning clarity.

It should not add polished art production, sound, animation, new biomes, or a tutorial wall.

### 3. Scanner Improvement I Planning

`Wreck Signal Cache` currently points toward a future scanner improvement. That should become a planning issue before implementation. The planning should define whether Scanner Improvement I gives longer tactical highlights, nearest-resource direction, safer predator observation, or better target preview.

The safest first candidate is probably a stronger tactical scan layer, not a full field guide.

### 4. Cargo Improvement I Planning

Cargo improvement is a clear progression-ladder candidate, but it should stay behind scanner/readability work. It needs a planning issue that compares:

- fourth cargo slot,
- protect one carried item on failure,
- fragile research sample slot.

The recommendation should preserve extraction tension and avoid grid inventory.

### 5. Burst Thruster Prototype

The Burst Thruster plan is ready enough to become a future implementation issue, but it should remain blocked by #37 or equivalent predator-readability evidence. Implementing it before validating current predator pressure would make it harder to know whether the current predator route works.

## Recommended New Issue Order

Outcome:

1. #46 prepared the blind validation kit for #37.
2. #47 added the atmosphere and route-readability pass.
3. #48 planned Scanner Improvement I as `Signal Lens I`.
4. #49 planned Cargo Improvement I as `Cargo Rack I`.
5. #50 remains open and blocked by #37 or equivalent predator-readability evidence.

## Do Not Promote Yet

- Multiple tools or weapons.
- Full field guide UI.
- Full procedural biomes.
- Cargo grid inventory or broad crafting economy.
- Additional predator types for content volume alone.
