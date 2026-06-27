# Area 02 Larger Route Progress - 2026-06-27

## Why This Exists

Area 01 now proves the upgrade-return loop, but the game still feels small after a short playtest. The next work should make the ocean feel wider and more expedition-shaped instead of spending another batch on local readability, screenshots, or micro-polish.

## Milestone Goal

Create the first larger-route pass beyond the current Hollow Reef / Wide Reef / Mirror Kelp / salvage-pocket cluster.

The target player sentence after two expeditions is:

`I saw a bigger place past Wide Reef, learned one thing about how to cross it, and know what I want to try tomorrow.`

## Player-Visible Requirements

- A larger authored side-view region with enough horizontal and vertical space to feel like a real area rather than a pocket.
- At least two named local landmarks that can be remembered without a minimap.
- One pressure, timing, current, or creature-read decision that changes how the player moves through the route.
- One cargo-vs-knowledge or safety-vs-depth decision.
- One extraction/result memory line that points back to the remembered place and suggests a next expedition.

## Guardrails

- Do not add exact map UI, checklist locators, quest arrows, or coordinate-style scanner output.
- Do not add broad combat, loot tables, crafting trees, restaurant/base management, or co-op-shaped systems.
- Do not start a final-art overhaul; use readable prototype assets and keep the sub/player as the focal point.
- Do not create a new upgrade unless it opens or clarifies a remembered place the player can already see.
- Keep testing focused: logic tests for state/guards, one staged screenshot only when a visible region changes.

## Ordered Work Batch

1. Area 02 route footprint and camera/world-bounds contract.
2. First memorable branch and return path.
3. One local pressure/timing traversal decision.
4. One passive creature/read behavior.
5. One payoff that creates result memory and a next-run hypothesis.
6. One surface/result update that makes the new route feel consequential.
7. One upgrade or lock promise only if it points back to a visible remembered place.
8. One deterministic staging/evidence pass after the visible route exists.

## Stop Conditions

Pause and recalibrate if the batch starts producing mostly docs, labels, UI polish, screenshots, or isolated tests without a bigger playable route on screen.
