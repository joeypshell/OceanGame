# Future Mobile Landscape Touch Plan - 2026-06-26

Status: deferred planning note.

Issue: #380.

## Purpose

Plan eventual mobile/iPhone landscape touch controls and safe-area requirements without implementing them.

This plan does not add portrait support, touch UI, mobile export settings, platform-specific prompts, platform-specific gameplay, or settings menus.

## Target Direction

- Mobile/iPhone support is future scope after the current vertical slice remains readable.
- Mobile should be landscape locked.
- Touch controls should map to the same semantic actions reviewed in `docs/planning/INPUT_ACTION_CONTRACT_REVIEW_2026_06_26.md`.
- Touch controls should not change oxygen, pressure, predator, scan, cargo, extraction, Wreck Echo, save/load, or progression rules.

## Likely Touch Layout

| Zone | Candidate controls | Design intent |
| --- | --- | --- |
| Left lower safe zone | Virtual movement stick or four-direction pad | Active dive movement without covering oxygen/depth/base HUD. |
| Right lower safe zone | `interact`, `scan`, `burst_thruster` buttons | Keep scan and burst distinct so oxygen-spending burst is not accidental. |
| Right or center lower result zone | `restart_dive` / next expedition button | Only visible in surface/result/failure states, not during active dive. |
| Surface panels | Larger touch rows/buttons for result/upgrades/log and upgrade selection | Do not force an inventory grid or tech tree. |
| Debug-only | No required touch controls | F3/F4/F5/F6/F9 can stay keyboard/editor-only unless a developer-mobile workflow is explicitly planned. |

## Safe-Area Requirements

Future mobile implementation should reserve margins for:

- iPhone notch / Dynamic Island area,
- rounded display corners,
- home indicator area,
- accidental edge-swipe zones,
- large thumbs in the lower corners,
- landscape left/right orientation changes.

Touch controls and HUD must not overlap:

- oxygen, low/critical warning, and base direction,
- scan target and prompt/status panel,
- the player sub,
- surface boat/moonpool/extraction cue,
- safe-return lane cues,
- predator warning lane and Gulper route,
- pressure gate/cache and Wreck Echo clue marker,
- active resource pickups.

## Visual Overlap Risks

The current desktop active HUD occupies the upper-left and a left-side info panel. That leaves lower corners as the likely touch-control area, but the lower route is also where pressure, predator, reward, and Wreck Echo cues live. A mobile pass must test deep-route views specifically before locking button placement.

The result/surface panels are large and central. Future touch affordances should be integrated into those panel states rather than overlaid as permanent floating buttons.

## Prompt-Copy Requirements

Before touch support is implemented, prompt copy should be action-aware:

- `interact`: start/extract/confirm,
- `scan`: scan target / Decoy Pulse re-scan,
- `burst_thruster`: burst action and oxygen cost,
- `restart_dive`: next expedition,
- surface tab/select actions.

Avoid hard-coded keyboard-only prompt strings in future mobile-facing views.

## Evidence Required Before Implementation

A future implementation issue should provide:

- landscape mobile viewport captures at one or more iPhone-like aspect ratios,
- surface ready, active dive, lower-route pressure/predator/Wreck Echo, low oxygen, result, and upgrade views,
- safe-area notes for notch/home indicator assumptions,
- touch target size and spacing notes,
- confirmation that active controls do not cover player, route decisions, scan targets, or safe return,
- Godot headless launch and `git diff --check`,
- logic tests only if input, formatter, or gameplay helpers change.

## Non-Goals

- No portrait layout.
- No touch implementation now.
- No mobile export settings now.
- No mobile-specific economy, save, progression, oxygen, predator, pressure, cargo, scan, or Wreck Echo behavior.
- No new field guide, minimap, route graph, inventory grid, or objective checklist for mobile.
- No broad settings/options menu.

## Promotion Criteria

Promote mobile implementation only after:

- desktop vertical-slice readability remains stable,
- Playwright/Godot screenshot workflow can capture mobile-like viewports or a manual device/simulator workflow is documented,
- controller and touch prompt needs are separated from gameplay rules,
- the intended touch overlay has passed at least one route/HUD overlap review.
