# Lower-Route Readability Recheck - 2026-06-26

Status: review artifact for issue #263.

## Purpose

Recheck the lower-route cluster after the compact HUD skin, lower-route density tuning, and #260 active `Discoveries` HUD placement fix.

This review does not add lower-route content. It decides whether pressure gate, outside scan, Wreck Signal Cache, deep reward, predator lane, and Rare Signal/Echo Lens cues remain readable enough for the current playable vertical slice.

## Evidence Reviewed

- `docs/planning/LOWER_ROUTE_VISUAL_OVERLAP_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_WRECK_CACHE_SPRITE_FALLBACK_BALANCE_REVIEW_2026_06_26.md`
- `docs/planning/GULPER_ROUTE_DANGER_READABILITY_REVIEW_2026_06_26.md`
- #243 density tuning.
- #244 local mystery cue tuning.
- #260 active HUD `Discoveries` placement fix.

No new screenshots were committed for this recheck.

## Element Recheck

| Element | Current Read | Decision |
| --- | --- | --- |
| Pressure gate | Blue shimmer, bars, and compact `LOCKED`/`OPEN` badge still own blocked/open route meaning. | Pass |
| Outside scan | Outside wreck scan target remains a practical pressure-route clue, not a reward or map marker. | Pass |
| Wreck Signal Cache | Cache reads as local mystery payoff inside the wreck stack. | Pass with watchlist |
| Deep reward | Lime/yellow reward remains a temptation near risk, but no longer dominates the entire lower-right cluster after density tuning. | Pass with watchlist |
| Predator lane | Red warning lane, ribs, eye, and Gulper state remain distinct from pressure and reward cues. | Pass with watchlist |
| Rare Signal cue | Subtle/local shimmer remains acceptable as Wreck Echo curiosity. | Pass |
| Echo Lens pulse | Local cache pulse remains acceptable as temporary feedback, not a remote objective marker. | Pass |
| Active HUD | #260 moved `Discoveries` into the compact active stats panel, reducing loose-text interference in lower-route captures. | Pass with watchlist |

## Conflicts

No blocker-level conflict is present in the current reviewed state.

Watchlist conflicts:

- predator lane and pressure wreck/cache still occupy a tight lower-right region,
- deep reward and selected scan marker colors can compete if both are bright nearby,
- future Rare Signal, Wreck Shift, or Wreck Echo work could easily over-brighten this cluster,
- active prompt length can still matter when Burst Thruster and Decoy Pulse text appear together.

## Decision

Pass with watchlist.

The lower-route area is dense, but the current visual categories remain separable enough for the playable vertical slice:

- blue pressure access,
- pale scan focus,
- cyan/green safe return,
- lime reward temptation,
- red predator danger,
- subtle local mystery signal.

Do not add new lower-route content or Wreck Echo Descent implementation here until the surface moonpool/waterline and acceptance evidence passes are complete.

## Follow-Up Guidance

Future issues should only change this area when they either:

- reduce overlap,
- capture evidence,
- keep cue brightness capped,
- or preserve local-only mystery language.

Do not solve lower-route density by adding a minimap, route graph, objective checklist, exact locator, field guide, or larger text overlays.
