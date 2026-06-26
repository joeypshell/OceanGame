# Expedition-Day Five-Seed Review Checklist - 2026-06-26

Status: review checklist for issue #197. This is not completed evidence yet.

## Purpose

Use this checklist to review whether the current expedition-day loop reads clearly across five deterministic review passes. The focus is player-facing framing: ready panel, result panel, region memory, condition copy, scan-only usefulness, and safe return readability.

Use `docs/current/SCREENSHOT_WORKFLOW.md` for screenshot metadata, naming, manual capture, temporary script capture, and optional Godot AI MCP capture.

## Setup

1. Launch the project from the repository root.
2. Press F3 to show debug telemetry.
3. Record the current expedition number, seed, condition, cluster pattern, and predator route.
4. Press F5 between passes to advance the review seed.
5. Hide debug telemetry with F3 before taking player-facing screenshots.
6. Capture surface-ready, active-dive, and result/failure views as needed.

Suggested first five review passes:

| Pass | Seed Source | Required Capture |
| --- | --- | --- |
| 1 | Current fresh/default run | Ready panel, first shallow route, result/failure panel |
| 2 | F5 once | Ready panel, scan-only or low-cargo return if feasible |
| 3 | F5 twice | Ready panel, deepest meaningful landmark reached |
| 4 | F5 three times | Condition-copy contrast and safe-return route |
| 5 | F5 four times | Wreck/cache or predator-route pressure if reachable |

If a pass cannot reach a target feature naturally, record that honestly and focus on what the seed made readable.

## Per-Pass Checklist

Ready panel:

- Expedition day number is visible.
- `Today:` condition copy is compact and does not expose raw seed, condition id, cluster pattern, or predator route while F3 is hidden.
- The goal line points to one useful next action, not a tutorial wall.
- Starting the dive with E or Enter is clear.

Active dive:

- Surface/base return direction stays readable after leaving the moonpool.
- Cargo, oxygen, depth, scan target, and low-oxygen cues do not overlap.
- Condition visual emphasis, if present, supports route planning without implying unimplemented mechanics.
- At least one stable place remains recognizable: Surface Base, Shell Reef, Thermal Vent Field, Wreck Shelf, Pressure-Locked Research Wreck, or Gulper Route.

Scan-only usefulness:

- A first-time scan with no cargo still feels useful if the player extracts safely.
- The result panel does not imply phantom cargo.
- Discovery or scan copy avoids checklist or map language.

Result/failure panel:

- The completed expedition day is named first.
- Cargo banking or cargo loss is clear.
- One remembered-region line appears when there is meaningful evidence.
- Route choice or research copy is compact and does not crowd the next action.
- Best depth and next-expedition prompt are easy to find.
- Debug telemetry appears only when F3 is enabled.

Safe return:

- Base direction and surface return visuals remain readable from the reviewed route.
- Predator warning, pressure-gate feedback, resource glow, and condition cues do not drown out return information.
- Low/critical oxygen feedback increases urgency without changing the route rules.

## Review Matrix

| Pass | Seed | Condition | Cluster Pattern | Ready Panel | Region Memory | Scan-Only Usefulness | Result Panel | Return Readability | Notes / Screenshot Path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | fill | fill | fill | fill | fill | fill | fill | fill | fill |
| 2 | fill | fill | fill | fill | fill | fill | fill | fill | fill |
| 3 | fill | fill | fill | fill | fill | fill | fill | fill | fill |
| 4 | fill | fill | fill | fill | fill | fill | fill | fill | fill |
| 5 | fill | fill | fill | fill | fill | fill | fill | fill | fill |

## Pass Criteria

The review passes if:

- at least three of five passes clearly communicate the day/condition framing before the dive,
- at least three of five passes produce a readable result/failure panel,
- no pass exposes debug-only telemetry with F3 hidden,
- no pass makes scan-only extraction look worthless when a new scan was banked,
- no pass loses safe-return readability to condition, predator, pressure-gate, or resource visuals.

If one of these fails, create a narrow issue for the specific failure rather than broadening the review into a new UI system.
