# GDQuest Godot Tutorial Import - 2026-07-04

Status: planning source and issue batch. This document does not describe implemented behavior.

Source: the GDQuest Godot tutorial index at `https://www.gdquest.com/tutorial/godot/`, checked as a site index rather than search snippets. The page metadata reported a 2025-06-25 modified date and listed dozens of Godot tutorial entries across learning paths, best practices, design patterns, 2D, audio, GDScript, shaders, UI, networking, PCG, and 3D.

Purpose: turn the useful GDQuest patterns into OceanGame work without importing broad systems that fight the current architecture. The right outcome is a small set of scoped issues that improve the playable survival day, Area 01 readability, and future implementation quality.

## Current Fit

OceanGame's active milestone is still `Survival Day/Night Loop Closeout`. Any imported tutorial pattern should support one of these:

- clearer surface, oxygen, offload, daylight, cargo, health, and night-result pressure;
- better Area 01 terrain/collision/readability confidence;
- stronger route memory, camera framing, or place identity;
- cheaper future work by clarifying ownership, layers, asset settings, or test gates.

The import should not restart architecture, add a broad quest system, add procedural world generation, or add feature volume just because the tutorial catalog contains those topics.

This plan supplements `docs/planning/STEAM_VISUAL_READINESS_REWORK_FRAMEWORK_2026_07_03.md`. That framework owns the Steam-demo visual bar; this plan adds Godot-practice sources and the first follow-up issue batch.

## High-Value Imports

| Priority | GDQuest topic family | OceanGame adoption | Guardrail |
| --- | --- | --- | --- |
| P0 | `Area2D`, physics layers/masks, hit/hurt boxes | Define a collision and sensor layer matrix for player body, solid terrain, pickups, scan zones, ship/offload, surface oxygen, hazards, predators, debug/source-map overlays, and passive visuals. | Do not change topology through scene-only collision edits; Area 01 topology stays source-grid-first. |
| P0 | Dynamic camera targets | Add route-aware camera anchor zones for surface return, first pockets, right chamber, deep spine, and future-exit review states. | Do not create exact locator/minimap behavior; camera supports readability only. |
| P0 | Pixel art setup in Godot 4 | Lock import/render scale expectations for pixel-inspired sprites, source exports, and runtime scaling so future assets do not drift. | Do not reskin the whole game in one issue; define the contract before broad replacement. |
| P1 | 2D lighting, normal maps, silhouette shader, gradient-map shader | Prototype underwater depth, player/scannable silhouettes, and readable depth-band treatment for Area 01. | Lighting and shaders must not hide resources, return cues, terrain collision, or predator danger. |
| P1 | Audio crossfades, persistent BGM, volume slider | Add a small audio-state plan for surface, active day, depth, low oxygen, night result, scan, pickup, offload, damage, and failure feedback. | Audio state follows existing gameplay state; it does not own survival or progression rules. |
| P1 | Signals, mediator, event bus | Tighten communication around pickups, scan completion, offload, night result, damage, and HUD updates. Prefer scene-local signals and mediator/service calls. | Avoid a broad global event bus unless multiple unrelated systems prove they need it. |
| P2 | Finite state machine | Use small FSMs only where states are visible and local: diver movement/boost, predator warn/chase/recover, or a branching day/night presentation flow. | Do not turn `DiveSession`, `ProgressionState`, or `SurvivalState` into scene-node FSMs. |
| P2 | Save/load formats, typed GDScript, performance measurement | Preserve schema/migration discipline, type service boundaries, and profile before optimizing visual work. | Keep active-run state out of durable save data. |

## Defer

- 3D character, PBR, GIProbe, 3D maze, and most 3D lighting tutorials do not fit the current 2D milestone.
- Networking, split-screen, local multiplayer, and multiplayer sync remain out of scope.
- Broad procedural world-map generation conflicts with the current authored persistent geography and source-map-first topology guardrail.
- TRPG/tilemap/pathfinding topics should be kept for future tooling or creature route authoring only.
- UI beginner tutorials can inform small panel layout fixes, but should not trigger a broad UI reskin before survival-loop readability is stable.

## Issue Batch

Create these in order unless a newer roadmap decision supersedes them.

1. #891 `GDQuest import 01: formalize OceanGame collision and sensor layers`
   - Milestone value: prevents invisible blockers, pickup/sensor ambiguity, and source-map/collision drift as Area 01 grows.
   - Verification: docs/quick tier plus `git diff --check`; visual evidence if normal-play collision readability changes.

2. #892 `GDQuest import 02: add route-aware camera anchors for Area 01 readability`
   - Player-visible outcome: the surface, starter pockets, right chamber, deep spine, and future-exit views frame the player and route invitation more clearly.
   - Verification: quick tier plus `npm run test:area01-shell-captures` when camera/capture staging changes.

3. #893 `GDQuest import 03: define pixel-art import and sprite scale rules`
   - Milestone value: gives future sprite work one crisp import/render contract before replacing more placeholders.
   - Verification: docs tier for the contract; quick/visual tier only if project settings or runtime assets change.

4. #894 `GDQuest import 04: prototype underwater shader and lighting readability`
   - Player-visible outcome: depth, player/scannable silhouettes, and cave/reef materials read more intentionally without weakening gameplay cues.
   - Verification: quick tier, Area 01 shell captures, and manual screenshot scoring against the Steam visual bar.

5. #895 `GDQuest import 05: add an audio-state plan and first feedback slice`
   - Player-visible outcome: surface safety, active dive, low oxygen, offload, scan completion, damage, night, and failure have distinct audio feedback.
   - Verification: quick tier plus manual smoke because audio quality is partly experiential.

6. #896 `GDQuest import 06: tighten scene communication around survival-loop events`
   - Milestone value: reduces controller coupling around pickup, scan, offload, damage, night-result, and HUD update flows without adding broad architecture.
   - Verification: quick tier and focused tests for any extracted event/presenter behavior.

## Done Criteria For This Import

- The selected GDQuest ideas are represented by scoped GitHub issues.
- Each issue names the OceanGame player-visible or milestone value.
- Every issue preserves the source-map, state-ownership, and `main.gd` guardrails.
- Deferred tutorial categories are documented so future agents do not reopen them as urgent work without a roadmap reason.
