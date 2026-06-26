# Visual Language And Readability Assets

Status: visual language style guide v1 for the visual clarity foundation batch.

## Purpose

The prototype has reached the point where placeholder shapes are no longer only rough; in places like the pressure-lock route, they can make the intended action harder to understand. The next visual work should create gameplay-clarity assets before final art production.

This is not a polish milestone. It is a readability milestone.

The current north star is: every morning the alien ocean changes. Dive, scan, and survive long enough to bring back the knowledge that lets you go deeper tomorrow.

This guide should make that fantasy visible. It is not enough for individual shapes to be pretty or bright; the player must be able to recognize stable places, notice today's changed opportunity, understand forbidden routes, read creature danger, and sense mystery below the current safe depth.

## Style Guide V1 Decisions

Visual clarity work should support five repeated meanings:

1. Stable geography: the player recognizes where they are.
2. Daily change: the player notices what is different this expedition.
3. Forbidden promise: the player sees something desirable they cannot reach yet.
4. Learnable danger: creatures and hazards signal rules before punishment.
5. Deeper mystery: strange signals and landmarks imply a coherent hidden world.

Every asset pass should answer:

- What should the player do or remember because of this visual?
- Is this stable world identity, current-day variation, durable progression, or temporary tactical feedback?
- Does this cue compete with safe return, the player, or immediate danger?
- Can the same meaning be communicated without adding more world text?

## Palette Discipline

Avoid solving readability by making every important thing bright. The palette must stay multi-family and role-based:

- safe return: cyan/seafoam, calm, stable, vertically oriented,
- resources/rewards: yellow-green plus material accents, compact and tempting,
- scan/knowledge: pale yellow or soft cyan, target-hugging and analytical,
- currents/route hints: low-opacity green/cyan, directional but soft,
- locks/progression gates: firmer blue/cyan with bars, seams, and blocked silhouettes,
- danger/predators: red/orange, angular, interruptive,
- landmarks/regions: pocket-specific accents that stay subordinate to player, return, danger, and locks,
- mystery/deep signals: restrained violet, pale blue, or cold white accents used sparingly for strange unreachable or not-yet-understood discoveries.

Do not create one-note screens dominated by only cyan/blue, green/yellow, or red/orange. A region may have a dominant accent, but interaction meanings must remain separable from that accent.

## Region Memory Rules

Depth bands organize the ocean, but regions make the place memorable.

Each region-like pocket should eventually have:

- one recognizable silhouette family,
- one accent material or color,
- one stable landmark shape,
- one daily-change surface that can vary without erasing identity,
- one likely mystery or progression promise.

Current region anchors:

- Surface Base / Surface Reef: calm safety, extraction, morning/evening rhythm.
- Shell Reef / Wreck Shelf edge: pale shell geometry, safer midwater banking, bank-or-push decision.
- Thermal Vent Field: warm plumes, cracked shelf, optional glow temptation, Thermal Bloom variation.
- Pressure Lock / Wreck Shelf: firm blue blocked route, wreck silhouette, future scanner promise.
- Gulper Route / Deep Trench edge: red warning lane, predator timing, contested deep reward.

If a player could not name or recognize the pocket after two dives, the visual language is not strong enough yet.

## Daily-Change Rules

Daily or expedition-condition variation should layer onto stable geography rather than repainting the whole place.

- Use condition effects as accents, not full scene replacements.
- Tie variation to a readable source, such as vent bloom, current shift, predator migration, rare signal, or visibility change.
- Keep stable landmarks visible underneath variation.
- Prefer small changes that affect planning: brighter vent opportunity, stronger safe-return calm, altered reward lure, migration warning, or exposed signal.
- Do not make daily change look like random noise or a new biome unless a future issue explicitly plans that region.

`Thermal Bloom` is the current example: it may warm Thermal Vent visuals and prefer authored vent-pocket `Glow Plankton`, but it should not hide safe return or imply a guaranteed safe route.

## Forbidden-Route And Mystery Rules

The game needs "I saw something I cannot reach yet" moments.

Forbidden-route visuals should:

- be visible before unlock,
- be clearly blocked,
- imply reward or knowledge beyond the blocker,
- name only the compact missing requirement if world text is necessary,
- become visibly passable after the upgrade.

Mystery visuals should:

- imply that scans are partial interpretations, not exact checklist coordinates,
- use restrained signal language rather than bright objective arrows,
- avoid competing with immediate pickups or danger,
- point toward future curiosity in HUD/status text rather than through large world labels.

The pressure-locked wreck is the current model: the player should see the wreck/cache promise, understand `Pressure Seal I` is needed, and remember to return.

## Creature Behavior Rules

Creature and predator visuals should make behavior learnable.

- Danger markers should appear before contact, not only after damage.
- Creature silhouettes should be distinct from resources and decorative background.
- Warning shapes should imply behavior: patrol, territory, sound sensitivity, charge lane, lure, mimicry, or migration.
- Scan markers should identify a creature as knowledge-bearing without making it look like cargo.
- No creature visual should imply weapons, harvesting, or combat unless a future issue changes the genre direction.

The `Gulper Eel` should evolve toward a memorable behavior read: dangerous route controller first, research subject second, never generic enemy sprite.

## Architecture Pattern To Follow

The useful pattern from reference projects such as Sunny Town is not the exact renderer or tech stack. It is the ownership split:

- authored world data defines what exists and where,
- runtime state defines what is currently happening,
- durable progression defines what survives between sessions,
- rendering/readability assets communicate the state without owning it.

For OceanGame, this means readability assets should be authored and reusable, but they should not become hidden gameplay state. A `PressureGate` can show that a route is locked, but `ProgressionState` and the upgrade effect decide whether it is actually open. A `CurrentHint` can point toward a route, but the route decision still comes from authored placement, oxygen, cargo, and scan/progression rules.

## Proposed Asset Ownership

Use this model when turning placeholder polygons into reusable prototype assets:

| Layer | Owns | Examples | Should Not Own |
| --- | --- | --- | --- |
| Authored scene/data | Inspectable placement and route identity | spawn points, scan targets, pressure gate location, biome pocket landmarks | player progress, oxygen, cargo |
| Runtime dive state | Temporary expedition facts | oxygen, current cargo, result, predator contacts, route telemetry | durable unlocks, final art identity |
| Durable progression | Long-lived player progress | banked resources, upgrades, discoveries, best depth | active hints, temporary highlights |
| Readability assets | Visual communication | gate shapes, current bands, signal pings, scan markers, warning ribs | unlock rules, costs, save data |
| HUD/surface UI | Concise mode/action feedback | result tabs, prompts, status text, upgrade bay | route geometry, hidden objective systems |

## Godot Implementation Direction

Prefer small reusable Godot-native assets before final art:

- `PressureGate` scene or grouped nodes for locked/open route language,
- `CurrentHint` scene or grouped nodes for soft route suggestions,
- `SignalHint` scene or grouped nodes for future payoff signals,
- `ScanMarker` scene or script for consistent scannable target readability,
- named color/shape rules documented here before adding many one-off polygons.

These may start as `Polygon2D`, `Label`, `Node2D`, and small scripts. They should be authored in scenes and wired by `main.gd` or small helper scripts, not generated procedurally without inspection.

Current shared runtime helper:

- `scripts/readability_marker_patterns.gd`: shared compact scan marker polygons, focus bracket polygons, and selected/idle colors used by both generic scannables and predator scan targets.

This helper is the first central pattern owner. It keeps repeated marker data out of individual gameplay scripts while still leaving gameplay truth in scanner, predator, progression, and scene systems.

Current reusable prototype scenes:

- `scenes/readability/PressureGatePrototype.tscn`: locked/open route language for pressure or future progression gates.
- `scenes/readability/CurrentHintPrototype.tscn`: low-opacity directional current language for optional route clues.
- `scenes/readability/SignalHintPrototype.tscn`: future payoff or signal language for subdued route rewards.
- `scenes/readability/CompactScanMarkerPrototype.tscn`: compact scan diamond/bracket marker that hugs a target.
- `scenes/readability/CompactLockMarkerPrototype.tscn`: compact firm lock marker with bars and a short label.
- `scenes/readability/CompactDangerMarkerPrototype.tscn`: compact danger lane/ribs/eye marker.
- `scenes/readability/CompactRewardMarkerPrototype.tscn`: compact reward bloom/ping marker.
- `scenes/readability/CompactReturnMarkerPrototype.tscn`: compact safe-return lane/rib/beacon marker.

These scenes are reference assets for future instance/copy work. They do not own pressure-lock state, scan reveal state, route safety, or progression unlock rules.

## Current Problem

Several important meanings are currently communicated by overlapping labels, translucent polygons, and one-off colors:

- safe base and return route,
- resource/reward hints,
- scan targets,
- environmental current hints,
- pressure-locked progression gates,
- predator warning routes,
- biome-pocket landmarks.

The player should be able to understand these meanings from repeated visual language before reading every HUD line.

Recent playtest feedback raised this from a polish concern to a blocking readability issue: the prototype is visually noisy, and world text can obscure the playfield so badly that it is hard to tell what action the game expects. The next visual batch should reduce on-playfield text, separate HUD explanation from world geometry, and make the first screen of any route decision readable without relying on overlapping labels.

## Text Clutter Reduction Rules

- Do not place long sentence labels directly over the dive route.
- Move explanatory scan results, upgrade clues, and route summaries into HUD/status/result surfaces where possible.
- Keep world labels only for selected scan focus, true blockers, or short prototype affordances that prevent immediate confusion.
- Prefer icons, silhouettes, shimmer states, current ribbons, scan brackets, and route color language over paragraphs in the ocean.
- Labels must not cover the player, active pickups, predator routes, pressure gates, or the visible path back to the surface.
- If two labels overlap, the issue is not solved until at least one label is removed, shortened, moved to HUD, or replaced with visual language.
- Every readability issue should include a manual playtest check at normal camera scale, not just scene inspection.

## First Visual Vocabulary

Use these rules for prototype readability assets. They are not final art direction; they are a shared gameplay language for placeholder and reusable assets.

## First-Pass Color Rules

| Meaning | Primary Color Direction | Current Scene Examples | Use For | Avoid |
| --- | --- | --- | --- | --- |
| Safe return | cyan/seafoam green | `BaseReturnColumn`, `SurfaceSafetyGlow`, `ReefReturnCurrent` | base path, return currents, extraction orientation | reward sparkle or predator warnings |
| Resource/reward | yellow-green with resource accent | `DeepGlowHint`, `DeepRewardLure`, pickup visuals | optional cargo, deep payoff, nearby material value | locked gates or danger language |
| Scan/knowledge | pale yellow or soft cyan highlight | `ShellReefShelf/Visual`, selected scan highlight behavior | scannable target focus, practical discoveries | permanent route arrows or broad tutorial text |
| Current/route hint | low-opacity green/cyan ribbons | `VentRouteHint`, `ReefCurrentGap`, deep lure trail | suggested path, optional clue route | guaranteed safe routes or hard UI arrows |
| Locked gate | bright cyan/blue shimmer with firm bars | `PressureShimmer`, `PressureGateTop/Bottom/Bars` | blocked progression route | optional hints or decorative background |
| Predator danger | red/orange with harsh accents | `PredatorWarning`, `GulperEel/PatrolHint` | avoid, time, observe, prepare | resource/reward glow |
| Biome landmark | pocket-specific accent in depth band | `ShellReefPocket`, `ThermalVent`, `MidwaterShelf` | place identity and route choice | hiding pickups, labels, or return lanes |
| Mystery/deep signal | restrained violet, cold white, or pale blue | `WreckSignalHint`, future abyssal cues | strange not-yet-understood findings, future route promises | immediate pickups, hard objective arrows, safe return |

Keep color categories distinct. Do not solve readability by making every important thing bright cyan, bright green, or bright red.

Prototype source/export scan-echo motif: `assets/source/sprites/ui_scan_echo_pulse_v1.svg` and `assets/exports/sprites/ui_scan_echo_pulse_v1.svg`, with provenance in `assets/licenses/ui_scan_echo_pulse_v1.txt`. This asset is intended for compact local scan/echo feedback experiments only. It should hug a target or HUD readout, expire quickly, and stay below oxygen/safe-return/predator urgency. It is not a minimap icon, scanner energy meter, persistent objective marker, exact-coordinate indicator, or route arrow.

## Shape Rules

- Safe return: vertical columns, upward lanes, beacon diamonds, and stable repeated ribs. Shapes should be calm and continuous.
- Resource/reward: compact clusters, blooms, shards, or small pings near a pickup or lure. Shapes should invite a detour but stay smaller than danger and locked-gate shapes.
- Scan/knowledge: brackets, rings, or highlighted silhouettes around a target. Shapes should hug the target rather than point across the whole screen.
- Current/route hint: soft ribbons, tapered bands, or small arrowlets embedded in the world. They should suggest direction without looking like an objective arrow.
- Locked gate: doorway silhouettes, bars, caps, shimmer planes, or sealed seams. Shapes should clearly block a route but preserve visual gaps around nearby safe paths.
- Predator danger: ribs, teeth, eye-like accents, pulses, and angular lanes. Shapes should feel sharp and interruptive.
- Biome landmark: larger silhouettes with readable negative space. The landmark should be recognizable at a glance while leaving route gaps open.

## Opacity And Layering Rules

- Background depth bands should be fully readable but quiet: `0.10` to `0.30` opacity for overlays and haze.
- Route hints should usually sit around `0.10` to `0.18` opacity unless they are revealed by a scan.
- Locked gates can use stronger opacity, roughly `0.40` to `0.65`, because they must communicate "not yet".
- Predator danger can pulse or use stronger accents, but the base warning field should not hide the player or pickups.
- Scan highlights should be readable for selection but should not obscure the target shape itself.
- Never stack two translucent meanings in the same place if they imply different actions, such as reward lure and predator warning.

## Text-Use Rules

- Prefer world shapes first and HUD/status text second.
- Use visible world labels only for locked gates, future payoff signals, or prototype-only clarification that prevents confusion.
- Keep labels short and action-oriented: `LOCKED: Pressure Seal I` works because it names the blocker and next upgrade without becoming a sentence.
- Do not put explanatory paragraphs into the playfield.
- Do not label decorative landmarks unless the label changes a player decision.
- HUD text may name the current scan target, result summary, or upgrade state; world assets should carry repeated meanings through color and shape.

## Marker And Icon Rules

These rules define the first reusable marker vocabulary. They are prototype readability rules, not final art direction.

| Meaning | Marker Shape | Color | Opacity | Placement | Text Rule |
| --- | --- | --- | --- | --- | --- |
| Scan | small diamond, bracket, or reticle hugging target | pale yellow or soft cyan | `0.18` to `0.30` idle, stronger only while selected | centered on the scannable silhouette, not across a route | no world label; selected target name belongs in HUD |
| Lock | firm bars, caps, shimmer plane, or sealed doorway | blue/cyan with firmer blue bias than current hints | `0.45` to `0.75` | across the blocked opening, preserving nearby return gaps | one compact blocker label allowed, such as `LOCKED: Pressure Seal I` |
| Danger | ribs, teeth, eye mark, angular pulse, or harsh lane | red/orange | `0.18` to `0.35` for fields, stronger for small accents | before the hazard/contact zone, not on top of the pickup | no explanatory label; HUD/status explains contact or scan facts |
| Reward | compact bloom, shard cluster, ping, or small lure | yellow-green or resource-specific accent | `0.15` to `0.35` for lures, full opacity for pickups | near the reward, smaller than lock/danger shapes | no label unless the reward is not reachable yet, then use signal language |
| Return | vertical lane, calm ribs, beacon diamond, or upward current | seafoam/cyan-green | `0.14` to `0.35` depending on depth and distance | along the safe route back to base/surface | no label unless the player is at the extraction boundary |

### Marker Priority

When markers overlap, resolve in this order:

1. Player visibility.
2. Safe return.
3. Immediate danger.
4. Locked gate.
5. Selected scan target.
6. Immediate pickup.
7. Optional reward lure.
8. Decorative landmark wash.

The lower-priority marker should become quieter, smaller, or move away from the overlap. Do not solve overlap by adding a text explanation.

### Marker Text Limits

- Scan: HUD-only target name.
- Lock: one compact world label is allowed.
- Danger: HUD/status only.
- Reward: no world text for immediate pickups.
- Return: extraction prompt only when at or near the safe base.

If a marker needs more than four words in the world, the visual language is not doing enough yet.

### Safe / Return

- Shape language: vertical columns, beacons, simple repeated light ribs.
- Color direction: cool cyan/green, low opacity, stable.
- Meaning: this is how to orient and return.
- Current examples: `BaseReturnColumn`, `SurfaceSafetyGlow`, `ReefReturnCurrent`, `ReefReturnBeacon`.

### Resource / Reward

- Shape language: small clustered deposits, glows, compact pings.
- Color direction: yellow-green for valuable signals, resource-specific accents for pickups.
- Meaning: this may be worth oxygen or cargo space.
- Current examples: `DeepGlowHint`, `DeepRewardLure`, `GlowPlankton/Visual`.

### Scan / Knowledge

- Shape language: small brackets, reticles, or highlighted silhouettes around a target.
- Color direction: readable but not louder than danger or locks.
- Meaning: scan this to learn or unlock a route.
- Current examples: `ShellReefShelf`, `ThermalVent`, `PressureLockedWreck/OuterScan`, `WreckSignalCache`.
- Prototype rule: non-resource scan targets use a subtle pale diamond `ScanMarker` that hugs the target silhouette. Resource pickups keep their material silhouette and use the existing selected-target tint so they still read first as immediate cargo.

### Current / Route Hint

- Shape language: soft directional bands or arrowlets, not hard UI arrows.
- Color direction: low-opacity green/cyan.
- Meaning: this suggests a path, but does not guarantee safety.
- Current examples: `VentRouteHint`, `ReefCurrentGap`, `ReefReturnCurrent`, `DeepRewardLure/CurrentTrail`.

### Locked / Progression Gate

- Shape language: clear doorway/gate/barrier silhouette with caps or bars.
- Color direction: cyan/blue shimmer with firm edges.
- Meaning: blocked now; upgrade or discovery needed before entry.
- Current examples: `PressureShimmer`, `PressureGateTop`, `PressureGateBottom`, `PressureGateBarA/B/C`, `PressureLabel`.

### Danger / Predator

- Shape language: warning ribs, pulses, harsh angles.
- Color direction: red/orange danger accents.
- Meaning: avoid, observe, or prepare before crossing.
- Current examples: `PredatorWarning/WarningRibs`, `PredatorWarning/WarningCurrent`, `PredatorWarning/WarningMarker`, `GulperEel/PatrolHint`.

### Biome Pocket / Landmark

- Shape language: larger readable silhouettes with open route gaps.
- Color direction: pocket-specific accent that still fits depth band.
- Meaning: this is a place with a route choice, not just decoration.
- Current examples: `ShellReefPocket`, `MidwaterShelf`, `ThermalVent`, `MidwaterWreckSilhouette`.

## Prototype Asset Versus Final Art

Prototype readability assets define what a player should understand:

- where to return,
- what can be scanned,
- what is blocked,
- what is dangerous,
- what is a tempting reward,
- what is a route landmark.

Final production art can replace the polygons, colors, animation, and materials later, but it should preserve the meaning established here. If final art makes a locked gate beautiful but less readable, the readability rule wins until the interaction is redesigned.

## Recommended Small Batch

Create issues for:

1. a first visual language guide,
2. reusable pressure-gate/current/signal prototype assets,
3. current and route-hint visual consistency,
4. scan-target marker consistency,
5. depth-band and landmark readability pass.

## Constraints

Do not add:

- final art production,
- large asset packs,
- animation systems,
- particle-heavy effects,
- minimaps,
- route overlays,
- tutorial walls,
- new mechanics,
- new biomes,
- decorative assets that do not improve player decisions.

## Success Gate

The batch succeeds when a player can distinguish:

- blocked route versus route hint,
- future payoff versus immediate pickup,
- scan target versus resource,
- danger warning versus reward signal,
- safe return language versus decorative background.

## Relationship To Final Art

These assets should be simple, reusable, and easy to replace later. They are prototype readability assets that define the game language before committing to final sprites, animations, lighting, or production art direction.

Final art should replace or skin these prototype assets without moving gameplay rules into the art layer.
