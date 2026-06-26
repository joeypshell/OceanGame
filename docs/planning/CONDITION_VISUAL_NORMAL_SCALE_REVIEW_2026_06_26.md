# Condition Visual Normal-Scale Review - 2026-06-26

Status: review artifact for issue #274.

## Purpose

Review condition visuals after the latest HUD, surface, moonpool/waterline, and lower-route readability passes.

Conditions should make an expedition day feel different without implying unavailable mechanics. This review does not add condition behavior, Wreck Echo behavior, route changes, or new UI.

## Evidence

Available normal-scale local evidence:

- Surface ready/result no-debug captures from `docs/planning/NO_DEBUG_SURFACE_CAPTURE_SANITY_REVIEW_2026_06_26.md`.
- Surface moonpool/waterline captures from `docs/planning/SURFACE_MOONPOOL_WATERLINE_REVIEW_2026_06_26.md`.
- Pressure/lower-route reviews from `docs/planning/LOWER_ROUTE_READABILITY_RECHECK_2026_06_26.md` and `docs/planning/PRESSURE_WRECK_CACHE_RECHECK_AFTER_SURFACE_READABILITY_2026_06_26.md`.
- Earlier condition review evidence from `docs/planning/EXPEDITION_CONDITION_VISUAL_ACCEPTANCE_REVIEW_2026_06_26.md` and `docs/planning/CONDITION_VISUAL_EFFECT_REVIEW_2026_06_26.md`.

Representative local paths already recorded:

- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/oceangame_acceptance_2026_06_26_seed_8919_surface_ready_kelpbloom_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/oceangame_acceptance_2026_06_26_seed_8919_active_launch_kelpbloom_pass_watchlist.png`
- `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/oceangame_acceptance_2026_06_26_seed_8919_result_kelpbloom_pass_watchlist.png`

No new condition mechanic was added for this review.

## Condition Recheck

| Condition | Current Cue | Normal-Scale Decision | Mechanic Promise Check |
| --- | --- | --- | --- |
| `Calm Current` | Subtle safe-return emphasis and calmer return language. | Pass with watchlist. It supports orientation without needing a stronger arrow. | Does not change oxygen, cargo, pressure locks, predator rules, route selection, or rewards. |
| `Thermal Bloom` | Warm Thermal Vent emphasis plus existing authored vent-adjacent `Glow Plankton` candidate preference. | Pass with watchlist. It helps the vent read as a place, but must stay optional. | Does not add resource count, oxygen refill, pressure access, safe path, or mandatory objective. |
| `Rare Signal` | Faint Wreck Shelf/Wreck Signal curiosity and local mystery copy. | Pass with watchlist. Lower-route reviews keep it subtle enough after HUD changes. | Does not add locator, map marker, guaranteed cache, upgrade shortcut, or quest checklist. |
| `Wreck Shift` | Flavor-only condition copy today. | Pass. Keep flavor-only. | Does not move/open the pressure gate, reveal the cache, create an alternate entrance, or bypass `Pressure Seal I`. |

## Decision

Pass with watchlist.

The current condition visuals and copy remain acceptable for the playable vertical slice. `Calm Current`, `Thermal Bloom`, and `Rare Signal` support readability/mood while staying below the major gameplay cues. `Wreck Shift` should remain flavor-only until a separate issue scopes a visual treatment and proves the pressure gate/cache still read correctly.

## Guardrails

- Safe return must remain clearer than condition flavor.
- Pressure lock state must remain clearer than Wreck Shift, Rare Signal, or Echo Lens atmosphere.
- Predator danger must remain clearer than thermal or rare-signal mood lighting.
- Condition copy must not expose raw ids, seeds, cluster patterns, or predator route ids.
- Do not add minimap, exact locator, field guide, objective checklist, daily challenge UI, new biome, new resource count, new predator behavior, oxygen change, cargo change, or pressure-lock change from condition visuals.
