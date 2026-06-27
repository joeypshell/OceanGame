# Lantern Ray Creature Route Validation - 2026-06-27

Status: pass with watchlist.

This closes the Lantern Ray Creature Route milestone. The goal was to prove that the lower route can feel inhabited by a readable non-combat creature without jumping to weapons, harvesting, capture, monster parts, health bars, field-guide objectives, minimaps, or broad creature progression.

## Validation Method

This is a compact solo milestone validation using:

- the implemented `LanternRayRoute` scene presence near Dusk Trench;
- scan behavior that records `Lantern Ray` through normal discovery storage;
- the pale timing/avoidance lane and deterministic authored route variation;
- extraction and recent-log memory for the observation;
- quick logic coverage for scan behavior, visual-only timing, route bounds, deterministic route selection, result/log priority, no hidden punishment, and no durable active-route state leakage.

No new review treadmill is created here. The next work should move to map growth through `Hollow Reef`, not repeat Lantern Ray polish unless a playtest reveals a concrete readability regression.

## Acceptance Gate Answers

1. Does the creature read as route life rather than visual noise?

Pass with watchlist. The ray uses cool creature color language, a small focal fleck, an ambient route lane, and a pale timing lane distinct from red predator warnings, green return currents, yellow resources, and dark pressure cues. The watchlist is normal-scale visual density as Hollow Reef adds more lower-route geometry.

2. Is scan readability good enough?

Pass. `LanternRayRoute` is a passive scannable area with disabled collision layers and normal scan discovery storage. First scan copy points to observation and broad return through Blackwater; repeat scan copy is compact and free like other known scans.

3. Is timing readability good enough without hidden punishment?

Pass. The timing lane pulses visually and follows the ray patrol, giving the player a wait/pass/route-around read. It does not add collision, contact damage, oxygen drain, cargo mutation, pressure behavior, harvest behavior, predator behavior, or progression mutation.

4. Does route variation stay controlled?

Pass. Lantern Ray variation uses authored route candidates selected deterministically from the current seed, route cluster, and condition. `Low Visibility` can prefer a higher safer glide. The selected route is runtime/debug telemetry only and is not saved as durable progress.

5. Does result memory stay useful without becoming a checklist?

Pass. Extraction can remember `Lantern Ray Route`, discovery memory frames the observation as non-combat, and the recent log can show `route Lantern Ray`. Deeper route evidence such as Dusk, Blackwater, Blue Chimney, Silt Vein, Shelf Drop, and East Shelf still takes priority.

## Monster-Hunting Direction

Future monster-hunting work should continue from observation first, avoidance second, and upgrades third.

- Observation means scan, movement tells, route memory, and environmental behavior.
- Avoidance means timing windows, safe-route cues, and non-lethal tools.
- Upgrades should support preparation and readability before they support direct confrontation.

Do not add combat, capture, harvesting, monster parts, health bars, bounties, or field-guide objectives until at least one broader creature route proves that observation and avoidance are fun in normal play.

## Ordered Follow-Ups

1. Move to `Hollow Reef` map growth through issues #552-#558 so the game visibly expands beyond another creature-only pass.
2. Use issues #559-#563 to add lower-route goals, route-choice memory, traversal smoke, oxygen-margin review, and milestone validation after Hollow Reef exists.
3. Use issues #564-#565 for a small polish gate only after the larger lower-route slice is playable.

No new GitHub issues were created from this validation. The existing open batch already covers the concrete next work.

## Verification

- Documentation validation issue.
- Expected verification: docs tier plus `git diff --check`.
