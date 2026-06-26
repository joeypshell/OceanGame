# Echo Lens Cache Pulse Readability Recheck - 2026-06-26

Status: review artifact for issue #276.

## Purpose

Recheck the `Echo Lens I` local pulse around `Wreck Signal Cache` after the no-locator copy guards, lower-route density changes, HUD readability work, and pressure wreck/cache rechecks.

The pulse should read as local feedback at the cache. It must not become a remote objective marker, minimap substitute, field-guide entry, exact locator, or checklist item.

## Evidence Reviewed

- `scripts/main.gd`
- `scenes/Main.tscn`
- `tests/logic_tests.gd`
- `docs/planning/SCANNER_PROGRESSION_V2.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_RECHECK_AFTER_SURFACE_READABILITY_2026_06_26.md`
- `docs/planning/RESULT_MEMORY_READABILITY_REVIEW_2026_06_26.md`

Existing tests confirm:

- `PressureLockedWreck/WreckSignalCache/EchoPulse` has the scan/echo pulse texture available,
- `EchoPulse` starts hidden so it reads as temporary local feedback,
- Echo Lens repeat-scan copy says `weak wreck echo lingers below the shelf`,
- Echo Lens result copy says `weak wreck echo below the shelf`,
- Echo Lens copy avoids locator, map, marker, objective, quest, checklist, field-guide, exact-coordinate, and GPS language.

## Recheck

| Element | Current Read | Decision |
| --- | --- | --- |
| Pulse placement | Local child of `WreckSignalCache`, not a world/global marker. | Pass |
| Pulse default state | Hidden until Echo Lens feedback fires. | Pass |
| Repeat-scan copy | Broad local echo below the shelf. | Pass |
| Result memory | One compact `Research:` line if the echo fired. | Pass |
| Lower-route overlap | Pressure gate, cache, predator lane, and mystery cue remain dense but separable. | Pass with watchlist |
| Future deeper route | Still planning-only through `Wreck Echo Descent` docs. | Pass |

## Decision

Pass with watchlist.

The Echo Lens pulse is acceptable for the current vertical slice because it is local, temporary, and paired with broad local copy. It does not currently introduce route solving, exact location, a quest log, field guide, or a minimap.

The watchlist remains visual density around the lower-route stack. If future art brightens the cache, pressure gate, Rare Signal shimmer, deep reward, or predator lane, recheck the pulse so it does not become the loudest object in the cluster.

## Guardrails

- Keep the pulse local to the cache.
- Keep it temporary.
- Keep copy broad: `below the shelf`, `weak wreck echo`, `deeper pressure echo`.
- Do not add exact coordinates, arrows, persistent markers, minimap nodes, field-guide entries, objective language, or checklist state.
- Do not implement `Wreck Echo Descent` from this recheck.
