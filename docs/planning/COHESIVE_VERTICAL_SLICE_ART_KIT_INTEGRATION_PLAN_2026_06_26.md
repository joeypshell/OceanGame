# Cohesive Vertical-Slice Art-Kit Integration Plan - 2026-06-26

Status: planning contract; final production art lock remains deferred.

Issue: #420.

## Purpose

Plan a narrow cohesive art-kit integration pass that makes the current vertical slice feel more intentional without replacing the whole visual system or changing gameplay.

## Principle

Integrate around readable roles, not decoration. Every art-kit task must preserve the player's ability to understand:

- where base/safe return is,
- where pressure access is blocked or open,
- where optional reward is,
- where predator danger is,
- what can be scanned,
- what is cargo,
- what should be ignored as background.

## Proposed Pass Order

1. Lower-route cue-priority tuning.
   - Use #419 findings before adding more art.
   - Reduce overlap between reward lure, predator, player/sub, pressure/cache, and Wreck Echo cues.

2. HUD skin alignment.
   - Keep the current compact active/surface information hierarchy.
   - Add panel polish only after checking normal and mobile-like screenshots.

3. Surface base/waterline/moonpool polish.
   - Preserve the boat/lab launch origin and extraction clarity.
   - Do not move `BaseZone` or gameplay nodes.

4. Landmark sprite/fallback balance pass.
   - Review Shell Reef, Thermal Vent, Pressure Wreck, Wreck Echo, and Deep Reward fallback geometry.
   - Dim or remove only the fallback shapes that no longer carry meaning.

5. Player/sub and creature state cohesion pass.
   - Recheck sub idle/thrust readability after HUD and lower-route tuning.
   - Keep Gulper states readable as patrol/warning/chase/decoy, not combat states.

## Implementation Rules

- Preserve gameplay node ownership, routes, collisions, spawn candidates, pickups, scan targets, pressure gates, Wreck Echo triggers, predator behavior, oxygen/cargo/extraction, progression, and save/load.
- Prefer tuning scene-native visual children before adding new source assets.
- Add source/export/provenance assets only when a cue's role is stable and tuning cannot separate it.
- Keep fallback geometry available until screenshot evidence proves the replacement carries the read alone.
- Verify each implementation with the relevant Playwright visual smoke and/or Godot logic tests.

## Evidence Gates

Before calling the art-kit pass cohesive, capture or review:

- surface ready,
- active dive,
- lower-route pressure/cache/predator/reward,
- Wreck Echo route/result,
- low and critical oxygen,
- result panel,
- upgrade panel,
- mobile-like active/lower-route/low-oxygen screenshots.

## Deferred Scope

- No final production art lock.
- No broad biome repaint.
- No full scene hierarchy rewrite.
- No new gameplay, routes, resources, upgrades, scans, monster systems, Wreck Echo expansion, minimap, field guide, checklist, combat, capture, harvesting, mobile/touch implementation, or controller implementation.

## Next Issue Recommendation

Create a narrow implementation issue for lower-route cue-priority tuning before starting HUD skinning or broader art-kit work.
