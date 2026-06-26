# Next Source-Art After Wreck Echo Evidence - 2026-06-26

Status: planning decision for issue #372.

## Decision

Selected target: Wreck Echo clue-marker/source-art separation.

Backup target: non-resource scan marker polish, only if implementation risk makes the Wreck Echo marker pass too broad.

Do not select a broad HUD skin pass for the immediate next issue. The post-Wreck Echo active HUD review found that oxygen, base direction, scan target, prompt, and status already fit the existing compact surfaces. HUD polish remains useful later, but it is not the current sharper readability problem.

## Why This Target Now

Before the first Wreck Echo implementation, route-marker art was intentionally deferred because it could imply an unimplemented route, exact locator, or objective marker. That condition has changed: the first pocket now exists, and Playwright/staged route evidence shows a specific current risk.

The Wreck Echo clue, deep reward lure, predator lane, and pressure/cache shell all live in the same lower-route neighborhood and rely on translucent abstract shapes. The first tuning pass improved the cue, but the route remains pass-with-watchlist because it could still read as another reward glow or danger lane after future art changes.

A narrow source-art pass can improve this one meaning without adding scope:

- Wreck Echo = pale research echo,
- reward lure = green/yellow valuable cargo temptation,
- predator route = red/orange danger/timing pressure,
- pressure/cache = blue locked/open route mystery.

## Implementation Scope For #373

Allowed:

- one small source/export/provenance asset for the Wreck Echo clue core or clue/rib treatment,
- source file under `assets/source/sprites/`,
- runtime export under `assets/exports/sprites/`,
- provenance note under `assets/licenses/`,
- scene wiring under the existing `WreckEchoDescent` visual ownership,
- light fallback alpha/position tuning only if the source art carries the clue read more clearly,
- Playwright visual smoke or normal-scale screenshot review of staged Wreck Echo route/result states.

Preserve:

- `Pressure Seal I` plus `Echo Lens I` prerequisite gating,
- run-scoped clue state,
- extraction-only `Research:` result line,
- pressure gate/cache behavior,
- predator route behavior,
- reward/resource placement,
- oxygen, cargo, scan, upgrade, save/load, and debug staging behavior,
- the no-locator/no-checklist/no-field-guide guardrails.

Avoid:

- new Wreck Echo route nodes,
- new scan target behavior,
- new resource, cargo reward, or economy,
- exact marker, arrow, route line, minimap, field guide, objective checklist, or persistent map state,
- broad pressure-dark atmosphere wiring,
- final production-art claims,
- copying generated reference images or unlicensed assets.

## Backup Target

If the Wreck Echo marker pass proves too broad for one issue, choose non-resource scan marker polish instead.

Why:

- non-resource scan markers appear on Thermal Vent, Shell Reef Shelf, outside wreck scan, Wreck Signal Cache, creatures, and future clue targets,
- a small marker polish pass can improve affordance without changing scanner rules,
- it supports #376 resource/scan affordance review.

Backup scope:

- one small source/export/provenance scan marker asset,
- target-local treatment only,
- no persistent marker,
- no exact direction/distance,
- no field guide, minimap, route graph, objective checklist, or scanner economy.

## Provenance Requirements

Any committed asset must include:

- editable source asset or prompt/source notes,
- runtime export used by Godot,
- provenance/license note naming source, method, date, intended use, and prototype/production status,
- role-first filename tied to gameplay meaning, for example `wreck_echo_clue_marker_v1.svg`,
- no `.godot/`, `.import/`, generated export folders, editor caches, or local screenshots committed.

## Non-Goals

- No final art lock.
- No broad lower-route art overhaul.
- No full Wreck Echo biome or deeper-region expansion.
- No route map, locator, marker trail, checklist, field-guide, or objective UI.
- No new gameplay, economy, scan, predator, pressure, oxygen, cargo, upgrade, save/load, or input behavior.

## Follow-Up

#373 should implement only the selected narrow Wreck Echo clue-marker/source-art pass. #374 should then review source-art/fallback balance, and #375 should recheck lower-route pileup after the pass.
