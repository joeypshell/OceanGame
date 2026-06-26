# Compact HUD Final Polish Plan - 2026-06-26

Status: planning artifact for issue #312.

## Purpose

Plan the final compact HUD polish pass for the current vertical slice.

This is a polish plan, not a new interface system. It should make the existing active HUD feel cohesive and readable at normal scale while preserving the current active/surface mode split.

## Existing HUD Owners

| HUD Area | Current Owner | Final Polish Goal |
| --- | --- | --- |
| Oxygen | `HUD/Oxygen`, `LOW_OXYGEN_RATIO`, `CRITICAL_OXYGEN_RATIO` | Highest-priority active-dive read with clear low/critical states. |
| Depth | `HUD/Depth` | Quick navigation read, not headline text. |
| Base direction | `HUD/BaseDirection` | Return confidence, especially during low oxygen. |
| Cargo | `HUD/Cargo`, `HUD/CargoSlots` | Count plus slots, with filled/empty/locked states clear at a glance. |
| Scan target | `HUD/ScanTarget` inside `DiveInfoPanel` | One compact selected-target read. |
| Prompt/status | `HUD/ExtractionPrompt`, `HUD/Status` inside `DiveInfoPanel` | Short action/status lines without returning to world-space text clutter. |
| Warnings | `HUD/OxygenWarningPanel` | Visible low/critical oxygen state without covering route decisions. |
| Debug telemetry | `show_debug_telemetry`, result/log formatting, F3/F4/F5/F9 rules | Development-only data stays hidden from normal player-facing views. |

## Polish Scope

Allowed:

- tune panel spacing, label hierarchy, font sizes, color modulation, borders, and padding,
- tighten oxygen/depth/base/cargo copy if it remains semantically equivalent,
- tune cargo-slot icon contrast and locked-slot treatment,
- tune scan target/status/prompt wrapping and max line behavior,
- tune low/critical warning placement, color, and pulse strength,
- keep surface ready/result/failure panels hiding active operational HUD rows,
- add focused regression checks if helper behavior changes.

Preserve:

- oxygen drain, warning thresholds, and failure behavior,
- depth and best-depth tracking,
- base-direction calculation,
- cargo capacity and pickup/banking behavior,
- scan target selection, scan cost, repeat-scan rules, and scan highlight behavior,
- Burst Thruster and Decoy Pulse prompt meanings,
- active/surface HUD visibility gating,
- debug telemetry hidden by default.

## Review States

A future implementation issue should verify the HUD in these states:

- surface ready before dive,
- normal active dive near the surface,
- active dive near a resource,
- active dive with selected scan target,
- active dive after one cargo pickup,
- full cargo,
- fourth cargo slot locked and unlocked,
- low oxygen,
- critical oxygen,
- near base extraction prompt,
- after extraction result,
- after oxygen failure,
- debug telemetry off and on.

## Distinguish Polish From New Systems

This pass may make existing information clearer. It should not add new information categories.

Do not add:

- minimap,
- inventory grid,
- objective checklist,
- field-guide UI,
- route graph,
- exact locator,
- banked-resource list during active dive,
- upgrade tree during active dive,
- recent expedition log during active dive,
- new debug telemetry fields.

## Acceptance For Future Implementation

A future implementation issue should require:

- active HUD remains bounded in existing panel surfaces,
- active HUD does not overlap the player, scan markers, pressure gate/cache, predator lane, resource pickups, or safe-return cues at normal scale,
- oxygen low/critical states are unmistakable but do not hide scan/prompt/status text,
- cargo slots still distinguish empty, filled, and locked states,
- scan target and prompt/status stay short enough for the dive info panel,
- surface/result/failure modes do not show active operational rows,
- debug telemetry remains gated behind F3,
- Godot headless launch,
- logic tests if formatter/helper behavior changes,
- normal-scale screenshot/manual review of the review states above,
- `git diff --check`.

## Relationship To Current Watchlists

This plan supports #313 low-oxygen review, #315 scanner feedback distinction, and lower-route readability watchlists. It should not compete with the selected pressure wreck/cache shell pass; HUD polish should clarify player state while the source-art pass clarifies lower-route world state.
