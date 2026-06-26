# Wreck Echo Active HUD Compactness Review - 2026-06-26

Status: pass with watchlist.

Issue: #371.

## Purpose

Review whether the first implemented `Wreck Echo Descent` pocket adds active HUD or prompt pressure that weakens oxygen, base direction, scan target, prompt/status, or safe-return readability.

This is a review artifact only. It does not add runtime behavior, a new HUD system, objective checklist, minimap, route graph, field guide, or active Wreck Echo panel.

## Evidence

- Current active HUD model in `docs/current/GAMEPLAY.md`.
- Compact HUD plan and review in `docs/planning/COMPACT_HUD_FINAL_POLISH_PLAN_2026_06_26.md` and `docs/planning/COMPACT_HUD_FINAL_NORMAL_SCALE_REVIEW_2026_06_26.md`.
- Existing Burst/Decoy prompt review in `docs/planning/ACTIVE_PROMPT_BURST_DECOY_REVIEW_2026_06_26.md`.
- Prior Wreck Echo prompt plan in `docs/planning/WRECK_ECHO_ACTIVE_HUD_PROMPT_REVIEW_2026_06_26.md`.
- Current Playwright visual smoke for active dive, lower-route pressure gate, staged Wreck Echo route, and staged Wreck Echo result readback.
- Runtime copy and layout inspection in `scripts/main.gd`.

## Findings

| Surface | Finding | Status |
| --- | --- | --- |
| Oxygen | Wreck Echo adds no oxygen label, warning, or cost text. Low/critical oxygen remains owned by the existing oxygen label and warning panel. | Pass |
| Base direction | Wreck Echo clue recovery asks the player to return, but it does not replace the base direction label or extraction prompt. | Pass |
| Scan target | The implemented Wreck Echo clue is a route trigger, not a new active scan target. `Scan:` remains focused on nearby scan candidates. | Pass |
| Prompt | The active prompt remains `Explore, bank at base` plus Burst and optional Decoy snippets. Wreck Echo adds no new prompt segment. | Pass |
| Status | Clue recovery uses one active status line: `Wreck Echo clue recovered: return to base to keep the research.` It fits under the existing `DIVE_STATUS_MAX_CHARS := 76` compacting rule. | Pass with watchlist |
| Surface result | The Wreck Echo clue moves to one compact extraction `Research:` line after successful return. The active HUD does not become the memory surface. | Pass |

## Decision

No copy or layout change is needed for the first Wreck Echo pocket.

The current implementation follows the compact HUD model:

- Wreck Echo curiosity uses the existing status surface only.
- The active prompt stays reserved for base/explore, Burst Thruster, and Decoy Pulse.
- Oxygen and base return remain higher priority than Wreck Echo copy.
- The result panel, not the active HUD, owns the durable-feeling readback.

The status is still pass-with-watchlist because Wreck Echo sits near the already dense lower-route pressure/cache/predator/reward area. Future Wreck Echo expansion, source-art swaps, or longer result/copy work should recheck active HUD screenshots before closing.

## Guardrails

- Do not add a Wreck Echo active route panel.
- Do not add objective steps, checklist text, exact locators, map markers, or field-guide entries.
- Do not add Wreck Echo prompt segments unless a future issue proves the status-only model is insufficient.
- Do not let Wreck Echo copy outrank low oxygen, base direction, pressure denial, predator danger, or extraction feedback.
- Keep Wreck Echo result memory extraction-only unless a later issue explicitly promotes durable research state.

## Follow-Up

Existing open issues cover the next risks:

- #375 should recheck lower-route visual pileup after Wreck Echo and source-art changes.
- #376 should review resource/scan affordances after route and art changes.
- #377 should review upgrade and result panel copy after the new research clue exists.

No new issue is required from this review.
