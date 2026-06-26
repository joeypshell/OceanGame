# Visual Language And Readability Assets

Status: active planning seed for a small readability-asset batch.

## Purpose

The prototype has reached the point where placeholder shapes are no longer only rough; in places like the pressure-lock route, they can make the intended action harder to understand. The next visual work should create gameplay-clarity assets before final art production.

This is not a polish milestone. It is a readability milestone.

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

Current reusable prototype scenes:

- `scenes/readability/PressureGatePrototype.tscn`: locked/open route language for pressure or future progression gates.
- `scenes/readability/CurrentHintPrototype.tscn`: low-opacity directional current language for optional route clues.
- `scenes/readability/SignalHintPrototype.tscn`: future payoff or signal language for subdued route rewards.

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

Keep color categories distinct. Do not solve readability by making every important thing bright cyan, bright green, or bright red.

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
