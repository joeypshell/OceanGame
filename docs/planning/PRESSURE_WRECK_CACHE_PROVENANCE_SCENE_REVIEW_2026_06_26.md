# Pressure Wreck Cache Provenance-To-Scene Review - 2026-06-26

Status: review artifact for issue #236.

## Scope

Reviewed whether `assets/source/sprites/study_pressure_wreck_cache_signal_v1.svg` should become scene-wired art or remain a prototype-only study now that pressure wreck/cache scene slots have dedicated sprites.

Evidence reviewed:

- `assets/source/sprites/study_pressure_wreck_cache_signal_v1.svg`
- `assets/exports/sprites/study_pressure_wreck_cache_signal_v1.svg`
- `assets/licenses/study_pressure_wreck_cache_signal_v1.txt`
- `assets/source/sprites/pressure_wreck_outer_scan_sprite_v1.svg`
- `assets/source/sprites/wreck_signal_cache_sprite_v1.svg`
- `scenes/Main.tscn`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md`
- `docs/planning/ASSET_PROVENANCE_REVIEW_2026_06_26.md`

## Scene State

Current scene wiring:

- `PressureLockedWreck/OuterScan/SpriteAnchor/Sprite` uses `assets/exports/sprites/pressure_wreck_outer_scan_sprite_v1.svg`.
- `PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite` uses `assets/exports/sprites/wreck_signal_cache_sprite_v1.svg`.
- `PressureLockedWreck/Visuals` is an extracted visual holder with fallback hull/gate geometry.
- `WreckSignalCache/EchoPulse` uses the scan/echo pulse asset only when `Echo Lens I` fires.

Current gameplay ownership remains correct:

- pressure boundary denial stays in `PressureLockedWreck/PressureBoundary`,
- outside scan clue stays in `PressureLockedWreck/OuterScan`,
- cache scan payoff stays in `PressureLockedWreck/WreckSignalCache`,
- pressure gate open/locked state stays driven by `Pressure Seal I`.

## Study Asset Review

`study_pressure_wreck_cache_signal_v1.svg` is useful as a composition study because it combines broken hull language and cold cache/signal mood. It is not currently the best runtime sprite for any single scene slot:

- It is broader than the outside scan target.
- It is less focused than the cache sprite.
- It risks visually merging gate, wreck, and cache meanings if wired directly into the current dense lower-route cluster.
- It could imply a larger promise or remote objective if used as a single icon-like marker.

## Decision

Defer wiring. Keep `study_pressure_wreck_cache_signal_v1.svg` as a prototype-only study.

Do not wire it into `Main.tscn` now.

Future use should be one of:

- reference material for a later `PressureWreckVisuals` art replacement,
- reference material for a later cache alcove environment pass,
- or a split/revised source asset that separates hull silhouette, cache glow, and signal shimmer into distinct scene slots.

## Provenance Status

| Asset | Source | Export | Provenance | Scene status |
| --- | --- | --- | --- | --- |
| Outside pressure wreck scan | `assets/source/sprites/pressure_wreck_outer_scan_sprite_v1.svg` | `assets/exports/sprites/pressure_wreck_outer_scan_sprite_v1.svg` | `assets/licenses/pressure_wreck_outer_scan_sprite_v1.txt` | Wired to `OuterScan/SpriteAnchor/Sprite`. |
| Wreck Signal Cache | `assets/source/sprites/wreck_signal_cache_sprite_v1.svg` | `assets/exports/sprites/wreck_signal_cache_sprite_v1.svg` | `assets/licenses/wreck_signal_cache_sprite_v1.txt` | Wired to `WreckSignalCache/SpriteAnchor/Sprite`. |
| Pressure wreck/cache study | `assets/source/sprites/study_pressure_wreck_cache_signal_v1.svg` | `assets/exports/sprites/study_pressure_wreck_cache_signal_v1.svg` | `assets/licenses/study_pressure_wreck_cache_signal_v1.txt` | Remains unwired study. |

## Guardrails

- No new route or gate behavior from study art.
- No exact locator, minimap marker, quest checklist, or cache guarantee.
- No replacement of current scene-specific sprites until normal-scale review proves the replacement is clearer.
- Keep fallback geometry available until a future art pass separates pressure gate, wreck hull, cache, and signal roles cleanly.
