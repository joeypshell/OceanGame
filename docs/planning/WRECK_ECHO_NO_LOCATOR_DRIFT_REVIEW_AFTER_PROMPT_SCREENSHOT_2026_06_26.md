# Wreck Echo No-Locator Drift Review After Prompt And Screenshot Changes - 2026-06-26

Status: pass with lower-route visual watchlist.

Issue: #400.

## Purpose

Recheck Wreck Echo player-facing copy, visual evidence, and test guardrails after the prompt-label abstraction and Playwright screenshot hardening work. This review protects the current Wreck Echo implementation from drifting into a map, checklist, exact locator, field guide, objective tracker, route graph, or broader Wreck Echo expansion.

## Evidence

- `npm.cmd run test:visual` passed during the #399 scaffold work after the Playwright helper refactor.
- Current Playwright desktop smoke includes staged Wreck Echo route, staged Wreck Echo result readback, and no-debug Wreck Echo result player-facing captures.
- `tests/logic_tests.gd` guards Wreck Echo/Echo Lens callouts with `_expect_no_echo_lens_locator_language`.
- `docs/current/GAMEPLAY.md` describes Wreck Echo as one deeper-right authored route pocket with one run-scoped research clue and no durable Wreck Echo save data.
- Runtime inspection in `scripts/main.gd` shows Wreck Echo recovery uses one active status line and one extraction result research line.

## Player-Facing Copy Review

| Surface | Current Shape | Drift Result |
| --- | --- | --- |
| Active clue recovery status | `Wreck Echo clue recovered: return to base to keep the research.` | Pass. It asks for safe return, not a map or next objective. |
| Result readback | `Research: Wreck Echo clue carried a deeper pressure signal below the shelf.` | Pass. Broad/local memory, no coordinates, exact direction, checklist, field guide, or route graph. |
| Prompt abstraction | Existing active prompt remains base/explore plus Burst/Decoy snippets. | Pass. Wreck Echo does not gain a new prompt segment. |
| Debug F6 staging | Debug-gated route/result staging for screenshot evidence. | Pass with note. It is tooling evidence, not normal player traversal. |
| Roadmap/gameplay docs | Repeated no-locator/no-checklist constraints remain present. | Pass. |

## Decision

No runtime copy, HUD layout, state ownership, save schema, or visual marker change is needed.

The Wreck Echo implementation still fits the intended first-pocket scope:

- one authored route pocket,
- one optional clue trigger,
- one run-scoped clue flag,
- one extraction-only research line,
- no durable Wreck Echo progression,
- no map/checklist/exact-locator/field-guide UI.

## Watchlist

The lower-route visual stack remains dense. Future Wreck Echo art, route, or reward work should continue to use Playwright route/result captures and logic no-locator tests before merging. The next risk is visual pileup, not copy drift.

## Non-Goals

- No new Wreck Echo route node.
- No new scanner behavior.
- No minimap, field guide, quest checklist, route graph, or objective tracker.
- No controller/touch implementation.
- No combat, capture, or monster-hunting system.
