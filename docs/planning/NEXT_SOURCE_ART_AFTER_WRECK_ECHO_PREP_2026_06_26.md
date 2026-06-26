# Next Source-Art After Wreck Echo Prep - 2026-06-26

Status: planning artifact for issue #354.

## Decision

Next source-art target: compact HUD skin and icon/frame polish.

Backup target: non-resource scan marker polish, only if future normal-scale evidence reopens scan confusion.

Defer Wreck Echo route-marker art until the first Wreck Echo implementation contract explicitly authorizes route nodes, entry states, and screenshot evidence. Defer additional pressure wreck/cache shell art because the first shell pass is already wired and reviewed as pass-with-watchlist rather than blocked.

This is a prototype readability target, not a final UI art lock.

## Candidate Comparison

| Candidate | Readability Impact Now | Risk | Decision |
| --- | --- | --- | --- |
| Pressure wreck/cache shell | Medium | Further art churn could hide whether the current shell/fallback balance is enough. | Defer. The first source-art shell is already wired; keep watchlist reviews rather than another immediate shell pass. |
| Wreck Echo route marker | Medium later, low now | Premature marker art could imply an implemented route, exact locator, map objective, or persistent target. | Defer until route implementation is explicitly authorized. |
| Resource/scan marker | Medium | Current resource and scan affordances pass; stronger marker art could make scanner output look like exact navigation. | Backup only if future screenshots show concrete confusion. |
| Compact HUD skin | High | Must stay compact and avoid inventory/minimap/quest scope. | Select next. It improves oxygen, depth, cargo, scan target, prompts, result panels, and future Wreck Echo attempt clarity across the whole slice. |

## Why HUD Skin Is Next

The latest Wreck Echo planning makes the next implementation depend on player-readable pressure, return, scan, and result information. HUD/panel clarity is therefore the highest-leverage source-art target because it supports:

- active dive oxygen and return pressure,
- cargo capacity and optional future sample decisions,
- scan target distinction without extra tutorial text,
- compact result/research clue presentation,
- Playwright screenshot review across surface, active dive, result, upgrade, and lower-route states.

HUD polish also avoids adding new route geometry before Wreck Echo ownership, entry states, return/failure language, and acceptance contract are fully settled.

## Scope For The Next HUD Source-Art Issue

Allowed:

- one small source/export/provenance set for HUD panels, icon frames, cargo slots, oxygen/depth shells, and scan target framing,
- replacing or skinning existing HUD/panel backgrounds without moving gameplay state,
- small icon treatment for oxygen, cargo, scan, and lock/return cues where it reduces text pressure,
- Playwright screenshots for surface-ready, active dive, extraction result, upgrade tab, and lower-route states.

Preserve:

- active/surface HUD mode separation,
- debug telemetry hidden by default,
- existing oxygen, cargo, scan, upgrade, result, and save/progression behavior,
- bounded panels that do not cover the player, route reads, pressure gate/cache, predator lane, or safe return.

Avoid:

- minimap, field guide, quest log, objective checklist, inventory grid, route graph, or exact locator UI,
- final art lock,
- new gameplay systems, resources, upgrades, or Wreck Echo route behavior,
- expanding active dive text blocks instead of reducing them.

## Deferred Candidate Rules

Do not start Wreck Echo route-marker art until a future implementation issue confirms:

- the route entry state,
- the route pocket owner scene,
- whether the clue is reached, scanned, or extracted,
- result/failure language,
- no-locator copy guardrails,
- normal-scale screenshot acceptance.

Do not reopen resource/scan marker art unless a screenshot or playtest shows a concrete confusion between cargo resources, non-resource scan targets, Signal Lens feedback, and Echo Lens feedback.

## Current Scope

This note creates no runtime assets and changes no scenes. It selects the next source-art target so future issues can stay focused.
