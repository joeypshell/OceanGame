# Next Source-Art Replacement Priority - 2026-06-26

Status: planning artifact for issue #253.

## Purpose

Choose the next source-art replacement slot after the current readability reviews. This is a priority decision, not an art lock or a request for a large asset batch.

## Decision

Next candidate: surface base moonpool and waterline integration.

Backup candidate: pressure wreck and Wreck Signal Cache environment treatment.

The next source-art replacement should solve a readability problem first. It should not add new gameplay, final production art scope, or a broad visual overhaul.

## Candidate Comparison

| Candidate | Readability Impact | Implementation Risk | Notes |
| --- | --- | --- | --- |
| Surface base moonpool and waterline integration | High | Low to medium | The boat sprite reads well, but the under-boat launch column, waterline strip, safe base area, and surface panels still need to feel like one coherent launch/readback space. This is the first thing the player sees and has been a repeated visual confusion point. |
| Pressure wreck and Wreck Signal Cache environment treatment | High | Medium | The locked gate, outside scan, open route, cache, rare-signal shimmer, predator lane, and deep reward all compete in the lower route. A better source-art treatment could reduce shape pileup, but it risks disrupting already-working gate/cache readability. |
| Gulper Eel state readability | Medium to high | Medium | Predator danger currently reads as avoidable, but patrol/chase/decoy states still rely on overlays. More creature state art would help danger readability, but the current predator route already passes with watchlist. |
| Shell Reef or Thermal Vent landmark replacement | Medium | Low | Both landmarks pass with watchlist. Better sprites would help polish, but fallback geometry is still doing useful readability work and neither is the most confusing slot right now. |
| Broad background/parallax art layer | Medium | High | A cohesive ocean backdrop would improve mood, but it can easily reduce contrast around resources, pressure gates, predator warning, and HUD. Save this for a constrained integration pass after the immediate readability blockers are gone. |

## Why Surface Base Is Next

The surface base owns the first-read loop:

- start expedition,
- understand the boat/lab and waterline,
- see where the sub launches and returns,
- read safe-base extraction,
- review result, upgrade, and log panels.

Because the player sees this before every run, small confusion here repeats constantly. A focused moonpool/waterline source-art replacement can make the boat, launch column, water surface, and safe return zone feel intentional without touching movement, cargo, oxygen, upgrades, or route layout.

## Scope For The Next Implementation Issue

Allowed:

- one source/export/provenance asset or small matched set for the moonpool/waterline integration,
- scene wiring under the existing `SurfaceBaseArt` visual ownership,
- normal-scale screenshot review of ready state, launch state, and return/result state,
- minor fallback alpha/position tuning if the source art makes an old placeholder redundant.

Preserve:

- `BaseZone` gameplay ownership,
- surface/start/extraction behavior,
- player spawn/return rules,
- HUD mode separation,
- debug telemetry gating,
- existing boat sprite.

Avoid:

- final boat redesign,
- broad background art pass,
- new base-management gameplay,
- new UI layout system,
- moving gameplay nodes into art scenes,
- replacing every surface visual at once.

## Backup Scope

If surface base work is delayed, use the pressure wreck/cache backup:

- one source/export/provenance pass for the lower-route environment shell,
- preserve pressure lock, outside scan, cache scan, Echo Lens pulse, and predator danger ownership,
- reduce overlap rather than adding more bright shapes,
- keep the future Wreck Echo Descent route out of implementation scope.

## Non-Goals

- No final production-art approval.
- No large art kit batch.
- No copying generated reference images directly.
- No minimap, field guide, exact locator, route graph, or objective checklist.
- No new biome, route, resource, predator, upgrade, or procedural ocean scope.

## Follow-Up Issue Shape

Title: `Wire surface moonpool and waterline source-art pass`

Acceptance sketch:

- surface base has a clearer source/export moonpool or waterline integration asset wired under `SurfaceBaseArt`,
- boat sprite, launch column, safe base, and waterline read as one surface system at normal scale,
- old fallback pieces are only hidden or subdued when the replacement is clearer,
- ready, launch, and result screenshots remain readable,
- behavior and save/load are unchanged.
