# Steam Visual Readiness Rework Framework - 2026-07-03

Status: planning framework and issue source. This document does not describe implemented behavior.

Scope: player-facing Area 01 visuals, terrain presentation, collision readability, HUD polish, motion/readability effects, and screenshot acceptance gates needed before OceanGame should be presented as Steam-store-ready.

Trigger: a player-facing screenshot review showed that the current build still reads as a prototype/blockout rather than a polished commercial demo. The gameplay loop may be progressing, but the first still image currently communicates unfinished art, debug tooling, sparse composition, and inconsistent visual language.

## Goal

Move OceanGame's first playable view from "functional prototype" to "Steam-demo visual baseline."

The target is not final full-game art. The target is that a stranger looking at the store screenshots understands the fantasy immediately:

- a tiny research sub in a large alien ocean;
- organic cave/reef terrain with collisions that look fair;
- readable resources, scan targets, danger, and return path;
- a compact sci-fi survival HUD that feels intentionally designed;
- enough lighting, motion, depth, and density that the scene looks alive.

## Current Visual Problems To Fix

These are the problems the screenshot communicates before the player reads any text:

- The map still reads as rectangular shelves, bands, and blockout fragments instead of natural cave or reef terrain.
- The environment is sparse, flat, and dark, with too much empty water around the player and too little authored visual payoff.
- Visual terrain and collision intent are not emotionally trusted yet. The player can see platform-like shapes, but not a pleasing underwater world with fair cave walls.
- The HUD dominates the screen and looks like debug instrumentation layered over the game rather than a shipped interface.
- Player-facing panels still include prototype/debug phrasing such as review/status copy that should not appear in promotional or normal-play captures.
- Art styles compete: generated/icon-like objects, simple Godot primitives, pixel-looking objects, vector HUD shapes, and map overlays do not yet feel like one art direction.
- The player focal point is small, and the surrounding scene does not do enough with light, bubbles, particles, flora, fauna, or silhouettes to sell scale and motion.
- The minimap and toolbelt are useful, but they currently add to the prototype-tool feeling instead of feeling integrated into the cockpit/survey fantasy.
- A still screenshot does not yet contain a clear "I want to explore there" hook. It shows UI state more strongly than place identity.

## Non-Negotiable Guardrails

Use these rules on every task produced from this framework.

- Source data owns topology. Do not hand-tune Godot polygons or generated JSON to make a screenshot look better.
- Generated runtime geometry owns collision. If collision shape needs to change, update the source map/converter path and regenerate.
- Visual art decorates and clarifies topology. It can add rims, fills, silhouettes, props, parallax, particles, and lighting, but it must not become the source of walls, routes, resources, gates, or hooks.
- The same source-map truth must drive visual terrain, collision, cave mouths, hooks, resources, scan targets, and capture staging.
- Screenshots are acceptance evidence, not source truth. Use generated previews first, then Godot/Playwright captures for rendering confirmation.
- Debug and review overlays must remain developer-only. Normal player-facing screenshots must not include debug copy, source-map labels, cue-family labels, or "Debug review" status text.
- Visual polish must preserve movement, oxygen, cargo, scan, predator, save/load, progression, and route behavior unless a separate gameplay issue explicitly changes them.

## Steam-Demo Visual Bar

A task is not done just because tests pass. It must improve what a first-time viewer sees.

Use this bar for manual review:

| Area | Fail | Passable Prototype | Steam-Demo Baseline |
| --- | --- | --- | --- |
| Terrain | Rectangles, shelves, floating chunks, or untextured bands dominate. | Source topology is correct but still visibly blockout-like. | Organic silhouettes, rim treatment, fill texture, and collision edges feel intentional and fair. |
| Composition | Mostly empty water or UI around a tiny player. | Player and objectives are readable. | Each capture has a focal point, a route invitation, and a visible place identity. |
| Art cohesion | Mixed primitives, icons, placeholder sprites, and debug shapes compete. | Important objects are readable. | Objects share palette, lighting, outline/edge treatment, and scale language. |
| HUD | Large black boxes, debug phrasing, and dense labels dominate. | Core survival info is readable. | HUD feels like a compact cockpit/survey instrument layer and supports the world instead of covering it. |
| Motion cues | Scene is mostly static. | Bubbles/thrust/scan effects exist. | Water, particles, fauna/flora, light, and pickup/scan feedback make the still frame feel alive. |
| Screenshot sell | Looks like an internal QA capture. | Looks playable. | Looks like a store screenshot from a cohesive 2D underwater exploration game. |

Do not mark a visual task complete if any primary capture still fails terrain, HUD, or screenshot-sell review.

## Workstream 1: Organic Terrain And Collision Readability

Problem: The world currently reads as blockout rectangles and horizontal strips. Even if generated collision is correct, the player does not yet see pleasing cave/reef shapes.

Instructions:

- Start from `data/maps/area_01_source_grid_v1.json` and the generated runtime geometry path.
- Use `npm run map:area01:all` or the equivalent converter command before Godot review.
- Preserve source-map route truth, hook placement, playable water connectivity, and collision ownership.
- Add or improve visual layers that make generated solids read as natural terrain:
  - continuous terrain fill;
  - organic edge/rim/lip treatment;
  - cave-mouth frames;
  - darker interior mass behind walls;
  - foreground silhouettes that do not imply false collision;
  - light/dark separation between playable water and solid terrain.
- If smoothing or organic polygon generation is needed, implement it in the deterministic converter or a presentation layer derived from generated geometry. Do not freehand-edit generated collision.
- Confirm the player never collides with an invisible wall and never swims through something that reads as solid terrain.

Acceptance criteria:

- Primary Area 01 captures no longer read as rectangular shelves or flat horizontal map bands.
- Solid terrain and playable water are visually separable in surface, right chamber, and deep-spine captures.
- Terrain rims/lips follow generated collision closely enough that contact feels fair.
- Source/runtime/diff previews remain generated and reviewable.
- Collision, hooks, scan targets, resources, gates, and playable water still validate from source data.

Candidate files:

- `data/maps/area_01_source_grid_v1.json`
- `data/maps/area_01_runtime_geometry.generated.json`
- `tools/build-area01-map.mjs`
- `tools/area01-map/runtime-geometry.mjs`
- `scripts/area01_blockout_builder*.gd`
- `scripts/area01_visual_cue_contract.gd`
- `tests/logic_test_suite_*.gd`
- `tests/playwright/area01-shell-captures.spec.mjs`

## Workstream 2: Cohesive Environment Art Kit

Problem: The current scene has readable objects, but the combined frame does not yet look like one intentionally produced world.

Instructions:

- Build a small reusable Area 01 art kit before adding one-off decorations.
- Follow the asset source/export/provenance split under `assets/`.
- Treat generated images, sketches, and screenshot paintovers as style references only.
- Prioritize assets that improve every screenshot:
  - seafloor/cave wall fill;
  - terrain edge trims;
  - shallow flora clusters;
  - midwater silhouettes;
  - cave entrance frames;
  - rock/reef prop clusters;
  - resource nodes with matching material treatment;
  - scan target shells or supply crates that do not look like UI icons;
  - soft particle sheets or simple procedural particles.
- Keep gameplay nodes intact. Skin or add child visuals around existing nodes instead of moving ownership.

Acceptance criteria:

- New art has source, export, and provenance notes where applicable.
- The art kit uses a shared palette, edge treatment, and lighting role.
- Resources, scannables, locks, and return cues stay distinct by silhouette and color role.
- Decorative props cannot be mistaken for pickups, hazards, or blocked routes.
- At least three capture states show improved density without reducing route readability.

Candidate files:

- `assets/source/`
- `assets/exports/`
- `assets/licenses/`
- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `scripts/area01_blockout_builder*.gd`
- `scenes/Main.tscn`

## Workstream 3: Scene Composition And Place Identity

Problem: A store screenshot must sell a place, not just a functional level.

Instructions:

- Define 5 primary capture states for Steam-demo visual review:
  - surface entry and base return;
  - first resource pocket;
  - right chamber scan target;
  - deeper cave spine;
  - one danger or locked-promise view.
- For each capture, ensure the frame includes:
  - player or strong player light;
  - one immediate decision or attraction;
  - foreground/background depth cue;
  - terrain silhouette framing the route;
  - at least one small life/motion cue;
  - no debug text or developer-only overlay.
- Do not add decoration evenly everywhere. Concentrate polish around camera-reviewed states and route decision points.
- Use source-map hook centers for capture staging. Do not hard-code old freehand camera coordinates if source hooks moved.

Acceptance criteria:

- Each primary capture has a named focal read and route invitation.
- No primary capture is mostly empty water unless the emptiness is intentional and visually supported by scale, light, and atmosphere.
- Review notes can describe what the player wants to do next from the image alone.
- Capture metadata and screenshots are generated by the current Playwright/Godot workflow.

Candidate files:

- `tests/playwright/area01-capture-manifest.json`
- `tests/playwright/area01-shell-captures.spec.mjs`
- `scripts/debug/visual_smoke_bridge.gd`
- `docs/current/SCREENSHOT_WORKFLOW.md`

## Workstream 4: HUD And Debug-Text Cleanup

Problem: The current HUD tells the player useful things, but it visually reads like debug QA tooling in the screenshot.

Instructions:

- Keep oxygen, health, depth, cargo, daylight, survival supplies, scan target, toolbelt, and minimap information available.
- Reduce black-box dominance and visual noise in normal active-dive captures.
- Replace debug/review copy with player-facing language or hide it behind debug mode.
- Keep route-critical prompts short. Use icons, meters, and compact labels where possible.
- Make panel weights intentional:
  - oxygen and immediate danger are highest priority;
  - cargo/daylight/supplies are secondary;
  - task/status cards are tertiary;
  - debug telemetry is hidden in normal play.
- Integrate the minimap/toolbelt into the same visual language as the HUD, rather than letting them feel like separate tools pasted on top.

Acceptance criteria:

- Normal player-facing captures do not show debug review text, source-map overlay text, internal capture labels, or telemetry.
- HUD no longer dominates the player/world focal point in primary captures.
- All survival-critical information remains readable at desktop and mobile-like landscape sizes.
- Logic tests cover any formatter/debug-gating behavior that can be unit-tested.

Candidate files:

- `scenes/Main.tscn`
- `scripts/main.gd`
- `scripts/*hud*.gd`
- `scripts/*presenter*.gd`
- `scripts/debug/visual_smoke_bridge.gd`
- `tests/playwright/*.spec.mjs`

## Workstream 5: Lighting, Motion, And Feedback Polish

Problem: The screenshot feels static. A small amount of consistent motion language can make the game feel alive without changing gameplay.

Instructions:

- Add polish where it supports existing actions:
  - sub nose light and local halo;
  - bubbles and thrust wake;
  - scan pulse and target outline;
  - resource pickup shimmer;
  - subtle current movement near return currents;
  - soft silt/particle drift;
  - faint caustic or depth-band movement;
  - small passive life silhouettes in safe areas.
- Avoid high-brightness clutter near rewards, locks, predator warnings, and scan targets.
- Keep effects tied to cue-family brightness budgets where possible.
- Prefer reusable effect nodes or helper scripts over one-off effects scattered in `main.gd`.

Acceptance criteria:

- Still screenshots show at least one motion cue, even though the image is static.
- Effects improve player focal read and route readability.
- Effects do not hide collision edges, resources, prompts, or predator danger.
- Performance and export smoke remain acceptable.

Candidate files:

- `scenes/Player.tscn`
- `scripts/player.gd`
- `scripts/area01_visual_cue_contract.gd`
- `scripts/area01_blockout_builder*.gd`
- `assets/exports/`

## Workstream 6: Steam Screenshot Acceptance Gate

Problem: A passing Playwright run proves deterministic capture, not visual readiness.

Instructions:

- Add a manual visual review checklist to every visual issue closeout.
- Require before/after screenshots for the affected capture states.
- Keep generated source/runtime/diff previews attached or referenced for map/terrain work.
- Use a 0/1/2 score for each rubric category:
  - 0 means blocker for Steam-demo baseline;
  - 1 means acceptable only as prototype evidence;
  - 2 means acceptable for Steam-demo baseline.
- Do not close a Steam-readiness visual issue unless terrain, HUD, composition, and screenshot-sell categories score 2 in the affected primary captures.

Acceptance criteria:

- The visual issue includes command output, screenshot artifact paths, and manual review notes.
- The reviewer can compare source preview, runtime preview, and Godot/Playwright captures.
- Any remaining 0 or 1 score becomes a follow-up issue with explicit acceptance criteria.

Candidate files:

- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/TOOLING.md`
- `tests/playwright/area01-shell-captures.spec.mjs`
- `tests/playwright/area01-capture-manifest.json`

## Issue-Ready Task Breakdown

Use these as the initial backlog for this workstream. Create one issue per task or execute them sequentially from this framework.

### Task 1: Steam Screenshot Baseline Audit

Summary: Score the current primary Area 01 captures against the Steam-demo visual bar and identify blocker screenshots.

Acceptance criteria:

- Captures reviewed: surface entry, first resource pocket, right chamber, deep spine, source-map overlay for developer comparison.
- Each capture gets terrain, composition, art cohesion, HUD, motion, and screenshot-sell scores.
- The audit lists exact blocker signals such as rectangular terrain, debug copy, empty-water framing, style mismatch, or HUD dominance.
- No gameplay or art code changes are included.

Verification:

```powershell
npm run test:area01-shell-captures
git diff --check
```

### Task 2: Area 01 Organic Terrain Presentation Pass

Summary: Make generated Area 01 terrain read as organic cave/reef mass while preserving source-map collision truth.

Acceptance criteria:

- Runtime geometry is regenerated from source data.
- Visual terrain fill, rim/lip treatment, and cave-mouth framing improve the primary captures.
- No hand-edited generated geometry or scene-only topology edits are used.
- Source/runtime/diff previews and Area 01 shell screenshots are reviewed.

Verification:

```powershell
npm run map:area01:all
node tools/validate-area01-runtime-source-map.mjs
node tools/validate-area01-runtime-placements.mjs
node tools/validate-area01-playable-water-framing.mjs
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
npm run test:area01-shell-captures
git diff --check
```

### Task 3: Area 01 Cohesive Terrain And Object Art Kit

Summary: Add a small source/export/provenance-backed art kit for terrain fills, rims, flora, props, resources, and scan-target dressing.

Acceptance criteria:

- Assets follow `assets/source/`, `assets/exports/`, and `assets/licenses/` conventions.
- At least terrain fill, edge trims, two flora/reef props, one resource treatment, and one scan-target treatment are represented.
- New visuals share palette and edge/lighting treatment.
- Decorative props do not own gameplay state or confuse collision/readability.

Verification:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm run test:area01-shell-captures
git diff --check
```

### Task 4: Player-Facing HUD Polish And Debug Copy Removal

Summary: Make active-dive HUD captures look like designed cockpit/survey UI instead of debug boxes.

Acceptance criteria:

- Normal play hides debug review labels, telemetry, source-map labels, and internal capture/status copy.
- Oxygen, depth, cargo, daylight, supplies, scan target, toolbelt, and minimap remain readable.
- HUD layout no longer overwhelms the player/world in primary captures.
- Desktop and mobile-like landscape captures keep text inside panels without overlap.

Verification:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm run test:visual
npm run test:visual:mobile-like
git diff --check
```

### Task 5: Scene Density And Motion Pass

Summary: Add world-life polish around primary captures so still screenshots feel alive and directed.

Acceptance criteria:

- Primary captures include bubbles/thrust, particles, subtle current/caustic movement, and at least one flora/fauna or environmental life cue where appropriate.
- Effects improve focal hierarchy without bright-cue pileup.
- Cue-family brightness/readability warnings are clean or explicitly accepted with follow-up.
- No new gameplay systems are introduced.

Verification:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
npm run test:area01-shell-captures
git diff --check
```

### Task 6: Steam-Demo Visual Gate Closeout

Summary: Run the full visual acceptance gate after terrain, art kit, HUD, and motion passes.

Acceptance criteria:

- Five primary captures score 2 for terrain, composition, art cohesion, HUD, motion, and screenshot-sell.
- Normal player-facing captures contain no debug/review copy.
- Source/runtime/diff previews are regenerated and checked for topology/collision parity.
- A human review note states whether the build is acceptable for Steam-demo screenshots or names the remaining blockers.
- Any remaining blocker becomes a specific follow-up issue.

Verification:

```powershell
npm run map:area01:all
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier full
git diff --check
```

## Agent Execution Instructions

When taking a task from this framework:

1. Read `AGENTS.md`, this document, `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md`, `docs/current/SCREENSHOT_WORKFLOW.md`, `docs/planning/ART_DIRECTION.md`, and the relevant nearby planning review.
2. Identify which primary captures are affected before editing.
3. For terrain/collision changes, update source map or converter inputs first, regenerate runtime geometry, and review previews before opening Godot captures.
4. For art changes, follow source/export/provenance conventions and keep gameplay ownership unchanged.
5. For HUD/debug cleanup, preserve survival-critical information and add tests for formatter or debug-gating behavior where practical.
6. Run targeted validation before broad visual sweeps.
7. Open generated screenshots and score them manually against this framework. Do not rely on Playwright pass/fail alone.
8. Report files changed, responsibility extracted or visual area changed, tests run, exact command results, screenshot artifact paths, and remaining rubric scores.

## Do Not Do

- Do not hand-edit generated geometry.
- Do not move gameplay nodes just to make a screenshot look better.
- Do not use a painted screenshot as collision authority.
- Do not add new route promises, resources, predators, upgrades, or lore while doing visual polish unless a separate gameplay issue authorizes it.
- Do not hide required oxygen/cargo/depth/survival information to make the screen cleaner.
- Do not close a visual task because it "looks better" in one screenshot.
- Do not commit local screenshots, Playwright reports, `.godot/`, `.import/`, exports, or build artifacts unless an issue explicitly requests committed reference evidence.

## Definition Of Done For This Framework

This framework has been successfully executed when:

- Area 01 source-map previews, runtime previews, and Godot captures agree on terrain/collision truth.
- The primary Area 01 screenshots read as organic underwater cave/reef spaces, not rectangular blockout platforms.
- The HUD reads as player-facing sci-fi survival instrumentation, not debug tooling.
- Normal captures contain no debug/review copy.
- Resources, scans, return routes, danger, and locked promises are readable without long explanatory labels.
- At least five primary captures pass the Steam-demo visual bar.
- Remaining visual gaps are captured as specific follow-up issues instead of vague polish notes.
