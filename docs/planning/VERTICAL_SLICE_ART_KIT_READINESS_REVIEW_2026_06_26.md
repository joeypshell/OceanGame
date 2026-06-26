# Vertical-Slice Art Kit Readiness Review - 2026-06-26

Status: review artifact for issue #233.

## Scope

Reviewed whether the current normal-scale prototype assets are ready for a cohesive vertical-slice art integration pass using `docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md`.

Evidence reviewed:

- `docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/planning/ASSET_PROVENANCE_REVIEW_2026_06_26.md`
- `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md`
- `docs/planning/VISUAL_CLARITY_BASELINE_2026_06_26.md`
- current source/export/provenance asset coverage

No new screenshots were committed for this pass.

## Checklist View Review

| View | Readiness | Notes |
| --- | --- | --- |
| Surface ready | Pass with polish | Boat/lab sprite and panel separation are much stronger. Remaining gap: waterline/moonpool integration still needs polish. |
| Shallow start | Pass with polish | Sub sprite, base, and safe-return language exist. Remaining gap: sub bubbles/thrust state should be reviewed after sprite integration. |
| Shallow resource | Pass | Resource sprites and fallback slots exist for Kelp, Shell, and Glow. |
| Midwater Shell Reef | Pass with watchlist | Shell Reef pocket and Shell Reef Shelf scan target now have source/export sprites. Sprite/fallback balance should be reviewed at normal scale. |
| Thermal Vent | Pass with watchlist | Thermal Vent scan target has source/export art and pocket geometry is extracted. Pocket still depends heavily on fallback geometry for place identity. |
| Pressure wreck locked | Pass with watchlist | Pressure gate and outside scan sprite are wired. Lower-route density remains the largest readability risk. |
| Pressure wreck open/cache | Pass with watchlist | Wreck Signal Cache sprite and Echo Lens local pulse are wired. Cache must stay local mystery, not objective-marker language. |
| Predator route | Pass with polish | Gulper Eel sprite exists and fallback warning overlays remain. Creature state polish is still needed for idle/threat readability. |
| Active HUD normal | Pass with polish | Active HUD is compact; cargo mini-icons improve slot readability. Full HUD skin is still planned, not implemented. |
| Active HUD low/critical | Pass with watchlist | Warning behavior exists. Future HUD skin must not overpower safe return or predator danger. |
| Result UI | Pass | Surface result/upgrades/log separation keeps result copy scannable and debug telemetry gated. |

## Highest-Priority Gaps

1. Waterline and boat moonpool polish.
   - The surface base is now a strong sprite, but the under-boat entry/exit area still needs integrated waterline/moonpool readability.

2. Player sub state polish.
   - The sub sprite is strong, but idle bubbles and thrust state should be tuned so movement direction and activity are readable at normal scale.

3. Lower-route density.
   - Pressure gate, outside scan, Wreck Signal Cache, rare signal shimmer, deep reward, and predator language are all close together. Future art should reduce overlap, not add more bright cues there.

4. HUD skin.
   - The HUD is functional and compact, but the cohesive sci-fi panel skin is still a planned pass.

5. Sprite/fallback balance for landmarks.
   - Shell Reef and Thermal Vent still rely on fallback geometry. That is acceptable for the next integration pass, but normal-scale review should decide what stays visible.

## Readiness Decision

The project is ready for a cohesive vertical-slice art integration pass, but not for final production art lock.

Recommended next work:

- finish waterline/moonpool readability polish,
- review sub idle bubble and thrust readability,
- keep the compact HUD skin as a planned follow-up,
- avoid adding new lower-route content until existing pressure/wreck/predator cues are reviewed at normal scale.

## Non-Goals

- No final art production requirement.
- No committed screenshot requirement from this review.
- No minimap, field guide, quest checklist, exact locator, or route graph.
- No gameplay behavior changes.
- No replacement of fallback/readability nodes until a normal-scale review proves the replacement is clearer.
