# Visual Replacement Plan

Status: integration plan for moving from placeholder visuals toward a polished OceanGame visual identity. This plan does not implement a full visual overhaul.

Latest slot review: `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md` audits the current player, surface base, resource, creature, landmark, pressure-wreck, and cache visual slots after recent extraction work.

## Current Visual Inventory

Current runtime visuals are mostly simple Godot nodes:

- `ColorRect` ocean depth bands: `Sky`, `OceanShallows`, `OceanMidwater`, `OceanDeep`, `ShallowMidwaterTransition`, `MidwaterDeepTransition`, `SurfaceLine`.
- `Polygon2D` surface/base art: `SurfaceSafetyGlow`, base return column/ribs/beacon, surface boat/lab pieces, moonpool cues.
- `Polygon2D` light rays and atmosphere: `ShallowLightRays`, `DeepPressureHaze`, depth transition bands.
- `Polygon2D` landmark pockets: `ShellReefPocket`, `ThermalVentPocket`, `PressureLockedWreck`, `DeepRewardLure`.
- `Polygon2D` route hints: reef return current, vent route hint, wreck signal hint, deep reward current trail, pressure shimmer, predator warning lane.
- `Polygon2D` player sub pieces in `scenes/Player.tscn`: body, tail fin, top/bottom fins, viewport, nose light.
- `Polygon2D` resources: Kelp Fiber fronds/stem, Shell Fragment shard/ribs, Glow Plankton visual/core/halo.
- `Polygon2D` creatures and predators: Lantern Fry body/glow, Gulper Eel body/tail/jaw/spine/eye, warning ribs/current/marker.
- Simple HUD `Label` and `Panel` nodes for oxygen, depth, cargo, scan target, status, run panel, upgrade panel, and debug-gated telemetry.

The current pass improves readability but remains placeholder-heavy. It is useful as an interaction map and visual language source, not final art.

## Preserve Gameplay Nodes

Visual replacement must preserve:

- `Player`,
- `BaseZone`,
- `ResourcePickups`,
- `StarterResourceCandidates`,
- `Scannables` / `Discoveries`,
- `Predators`,
- `HUD`,
- collision shapes,
- spawn points,
- predator patrol points,
- extraction behavior,
- save/load behavior,
- oxygen/cargo/scanning logic.

Do not move gameplay-critical nodes unless an implementation issue explicitly authorizes it and verifies behavior. Visual work should skin, wrap, or replace child visuals while leaving state ownership intact.

## Proposed Asset Folder Structure

Planned production-facing art structure:

```text
assets/
  art/
    player/
    environment/
      surface_base/
      shallows/
      midwater/
      wreck_shelf/
      thermal_vents/
      pressure_trench/
      foreground/
      backgrounds/
    creatures/
      gulper_eel/
      lantern_fry/
    resources/
      kelp_fiber/
      shell_fragments/
      glow_plankton/
    effects/
      scan/
      bubbles/
      glow/
    ui/
  source/
    aseprite/
    krita/
    blender/
```

Existing `assets/source/`, `assets/exports/`, and `assets/licenses/` conventions can support this by storing source files, runtime exports, and provenance notes. Do not move gameplay scripts into visual folders.

## Proposed Scene Hierarchy

Future `Player` structure:

```text
Player
  CollisionShape2D
  VisualRoot
    SubSprite or AnimatedSprite2D
    NoseLight
    BubbleTrail
    ScannerMount
```

Future `Main` structure:

```text
Main
  WorldVisuals
    BackgroundFar
    BackgroundMid
    DepthAtmosphere
    Landmarks
    PlayLayerDecor
    ForegroundFrame
    Particles
  GameplayNodes
    Player
    BaseZone
    ResourcePickups
    Scannables
    Predators
    SpawnPoints
  HUD
```

Do not restructure the whole scene in one pass. Use this as a direction for small extraction issues, starting with stable visual clusters.

## Phased Replacement Plan

### Phase 0: Art Direction And Integration Planning

- Add art direction and visual replacement planning.
- Preserve current prototype behavior.
- Do not add final production art from a generated reference image.

### Phase 1: Player Sub Visual Replacement

- Replace polygon sub placeholder with sprite-ready visual hierarchy.
- Preserve movement, collision, facing, burst behavior, and world bounds.
- Add room for nose light, bubble trail, and scanner mount as visual children.

### Phase 2: First Environment Layering Pass

- Convert the flat depth-band impression into organized visual layers.
- Add background/foreground separation for surface, shallows, midwater, and deep.
- Preserve all gameplay nodes, spawn points, collisions, and readable return routes.

### Phase 3: Resource And Scan Affordance Pass

- Add distinct visuals for Kelp Fiber, Shell Fragments, Glow Plankton.
- Add scan target feedback and highlight conventions.
- Preserve resource pickup identity, scan targeting, cargo behavior, and oxygen costs.

### Phase 4: Predator Readability Pass

- Replace predator placeholder with readable eel-like visual.
- Add warning/chase/contact visual states.
- Preserve predator movement, detection radius, contact oxygen cost, knockback, decoy behavior, and route selection.

### Phase 5: UI Skin And Debug Toggle

- Make oxygen/cargo/depth/scan UI player-friendly.
- Keep seed/pattern/telemetry behind debug mode.
- Preserve HUD information hierarchy and compact active/surface modes.

### Phase 6: First Vertical-Slice Art Kit

- Surface base.
- Shallow-to-midwater background.
- Wreck/pressure hint.
- Three resources.
- One predator.
- One passive creature.
- Scan effect.
- Cargo/oxygen UI.

## First Art Kit List

Minimum art kit needed to make one 60-second dive look good:

- sub sprite,
- surface lab/boat sprite,
- moonpool/base light,
- shallow background,
- midwater background,
- deep background,
- foreground coral/rock silhouettes,
- Kelp Fiber sprite,
- Shell Fragment sprite,
- Glow Plankton sprite,
- Lantern Fry sprite,
- Gulper Eel sprite,
- thermal vent sprite,
- pressure-locked wreck/door sprite,
- scan beam/effect,
- bubble/silt particles,
- oxygen/cargo/depth UI skin.

## Follow-Up Issue Drafts

### 1. Replace player sub placeholder with sprite-ready visual scene

Summary: Replace the current Polygon2D sub placeholder with a sprite-ready visual hierarchy while preserving movement and collision.

User story/problem: As a player, I should immediately recognize that I pilot a small warm-lit research sub, not a human diver or abstract polygon.

Acceptance criteria:

- `Player` keeps the same movement, collision, bounds, burst behavior, and facing behavior.
- A `VisualRoot` or equivalent child hierarchy supports sub body, nose light, scanner mount, and future bubbles.
- The sub reads left/right at normal camera scale.
- Current docs note the new visual structure without claiming final art is complete.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/current/GAMEPLAY.md`

Relevant code/scenes:

- `scenes/Player.tscn`
- `scripts/player.gd`

Verification steps:

- Godot headless launch.
- Normal timed launch or screenshot check.
- `git diff --check`

Explicit non-goals:

- No movement changes.
- No collision changes.
- No weapons or combat.
- No final animation set.

### 2. Add first parallax shallow/midwater background pass

Summary: Add a first layered background structure for surface, shallows, and midwater without moving gameplay nodes.

User story/problem: As a player, I should feel depth and region identity while still reading routes, pickups, locks, and safe return.

Acceptance criteria:

- Background layers are organized separately from gameplay nodes.
- Shallows and midwater read as distinct regions.
- Safe return, resources, scan targets, predator warnings, and pressure gate remain readable.
- Existing spawn points and collisions are preserved.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`

Relevant code/scenes:

- `scenes/Main.tscn`
- `scripts/main.gd`

Verification steps:

- Godot headless launch.
- Normal timed launch or screenshot review.
- `git diff --check`

Explicit non-goals:

- No procedural biome generation.
- No new gameplay regions.
- No moving spawn points.
- No full production background pack.

### 3. Add resource and scan-target visual affordances

Summary: Improve resource and scan target visuals so cargo, scannables, and tactical scan effects are distinct and readable.

User story/problem: As a player, I should know what is cargo, what is scannable, and what the scanner is affecting without reading a paragraph.

Acceptance criteria:

- Kelp Fiber, Shell Fragments, and Glow Plankton remain distinct by silhouette, color, and depth identity.
- Non-resource scan targets keep a consistent target/reticle language.
- Tactical scan pulses remain temporary and do not become map markers.
- Pickup count, scan cost, cargo, and spawn behavior are unchanged.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`

Relevant code/scenes:

- `scenes/Main.tscn`
- `scripts/resource_pickup.gd`
- `scripts/scannable.gd`
- `scripts/readability_marker_patterns.gd`

Verification steps:

- Godot headless launch.
- Logic tests if marker helper behavior changes.
- Normal timed launch or screenshot check.
- `git diff --check`

Explicit non-goals:

- No new resources.
- No inventory redesign.
- No scanner energy/cooldown economy.
- No field guide UI.

### 4. Add predator visual readability pass

Summary: Replace or skin the Gulper Eel and warning lane with clearer eel-like predator states.

User story/problem: As a player, I should understand patrol, warning, chase, and contact danger before losing oxygen.

Acceptance criteria:

- Gulper Eel reads as an eel-like hostile creature at normal scale.
- Patrol/safe, warning, chase, contact, and return-to-patrol states have visual language.
- Existing predator behavior values are unchanged unless a separate gameplay issue authorizes tuning.
- Predator danger remains distinct from rewards and pressure locks.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/MONSTER_RESEARCH_LOOP_V1.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`

Relevant code/scenes:

- `scenes/Main.tscn`
- `scripts/predator.gd`
- `scripts/main.gd`

Verification steps:

- Godot headless launch.
- Logic tests if predator helper/state code changes.
- Normal timed launch or screenshot check.
- `git diff --check`

Explicit non-goals:

- No weapons.
- No predator health, loot, harvest, stun, capture, or route removal.

### Pressure Wreck / Cache Visual Study

Current study asset: `assets/source/sprites/study_pressure_wreck_cache_signal_v1.svg`
Runtime export: `assets/exports/sprites/study_pressure_wreck_cache_signal_v1.svg`
Provenance: `assets/licenses/study_pressure_wreck_cache_signal_v1.txt`

Status: prototype-only visual study, not wired into `Main.tscn`.

Intent: explore a compact broken-hull plus cold signal-glow read for the Wreck Echo spine. The study should inform a future pressure-wreck or cache sprite pass without changing the current pressure gate, cache scan target, boundary denial, Echo Lens planning copy, route layout, or hidden objective behavior.

Scene review: `docs/planning/PRESSURE_WRECK_CACHE_PROVENANCE_SCENE_REVIEW_2026_06_26.md` keeps this as an unwired study for now because the current outside scan and cache scene slots already have more focused source/export sprites.

Non-goals:

- No new route or map marker.
- No exact deeper-signal coordinates.
- No replacement of the current pressure gate/cache scene nodes.
- No production-art approval until a later visual review issue.
- No new predator species.

### Pressure-Dark Threshold Visual Study

Current study asset: `assets/source/sprites/study_pressure_dark_threshold_v1.svg`
Runtime export: `assets/exports/sprites/study_pressure_dark_threshold_v1.svg`
Provenance: `assets/licenses/study_pressure_dark_threshold_v1.txt`

Status: prototype-only visual study, not wired into `Main.tscn`.

Intent: explore a darker cyan-to-navy route-threshold read for the future `Wreck Echo Descent` pocket. The study should support pressure-dark mood, faint echo promise, and deeper-right route readability without adding a route, marker, gate, region, or objective.

Non-goals:

- No new route behavior.
- No minimap, exact locator, or persistent objective marker.
- No replacement of current pressure gate or wreck cache assets.
- No broad biome generation.
- No production-art approval until a later visual review issue.

### 5. Add player-facing UI skin and debug UI toggle

Summary: Skin the core oxygen/depth/cargo/scan UI toward a clean cozy sci-fi style while keeping debug telemetry gated.

Planning status: `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md` defines the first compact active HUD skin pass. Implementation should follow that plan rather than expanding active HUD text.

User story/problem: As a player, I should see oxygen, depth, cargo, base direction, and scan target as polished game UI instead of raw debug text.

Acceptance criteria:

- Player-facing UI covers oxygen, depth, base direction, cargo slots, scan target, and low/critical oxygen warning.
- Seed, pattern, telemetry, oxygen-at-result, and failure cause remain hidden unless debug telemetry is enabled.
- Surface and active HUD modes remain compact.
- UI does not obscure the player or core route decisions.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/current/GAMEPLAY.md`

Relevant code/scenes:

- `scenes/Main.tscn`
- `scripts/main.gd`

Verification steps:

- Godot headless launch.
- Logic tests if formatter/debug gating changes.
- Normal timed launch or screenshot check.
- `git diff --check`

Explicit non-goals:

- No new inventory grid.
- No minimap.
- No field guide.
- No new debug data.

### 6. Integrate first vertical-slice art kit

Summary: Integrate the first cohesive art kit for a short readable dive using the established art direction and replacement plan.

User story/problem: As a player, a 60-second dive should look like a coherent cozy research expedition into a beautiful but dangerous alien ocean.

Acceptance criteria:

- Includes sub, surface base, depth backgrounds, three resources, Lantern Fry, Gulper Eel, thermal vent, pressure gate/wreck, scan effect, bubbles/silt, and core UI skin.
- Gameplay behavior, save/load, movement, oxygen, cargo, scans, predator rules, and spawn placement are preserved.
- Asset source/export/provenance conventions are followed.
- Screenshots show surface, shallow, midwater, pressure/wreck, predator route, and result UI.

Relevant docs:

- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/planning/ASSET_SOURCE_PIPELINE_V1.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`

Relevant code/scenes:

- `scenes/Main.tscn`
- `scenes/Player.tscn`
- `assets/`
- `scripts/main.gd`

Verification steps:

- Godot headless launch.
- Logic tests.
- Normal timed launch and screenshot review.
- `git diff --check`

Explicit non-goals:

- No new gameplay systems.
- No copying the generated reference image.
- No unlicensed assets.
- No broad procedural generation.
- No final full-game art production.
