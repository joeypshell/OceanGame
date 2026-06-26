# Mobile-Like Wreck Echo Route/Result Review - 2026-06-26

Status: implemented as evidence-only Playwright coverage and pass-with-watchlist review.

Issue: #412.

## Purpose

Review staged Wreck Echo route and result readability at the `960x540` mobile-like landscape viewport without adding Wreck Echo behavior, touch controls, controller support, minimaps, field guides, checklists, combat, capture, harvesting, or procedural route expansion.

## Evidence Added

The mobile-like Playwright smoke now captures:

- `mobile-like-wreck-echo-route-staged.png`
- `mobile-like-wreck-echo-result-readback.png`
- `mobile-like-wreck-echo-result-player-facing.png`

These use the same debug-gated F6 staging hook as the normal-scale Wreck Echo visual smoke. They are route/result layout evidence, not proof of normal gameplay traversal.

## Review Decision

Wreck Echo remains acceptable at mobile-like landscape width as a narrow promise: one staged route pocket and one extraction result readback. The watchlist risk is not missing behavior; it is composition pressure. The route view shares space with lower-route pressure/cache/reward/predator cues, and the result view must keep the research line readable without growing into a quest log.

## Guardrails

- Keep Wreck Echo as a clue and result readback, not a minimap, checklist, field guide, exact locator, or durable route graph.
- Do not add a new active prompt segment for Wreck Echo unless a future issue proves the existing status/panel readback is insufficient.
- Treat mobile-like screenshots as planning evidence only; they do not certify mobile support.
- Recheck the result panel if future copy adds more research lines.
