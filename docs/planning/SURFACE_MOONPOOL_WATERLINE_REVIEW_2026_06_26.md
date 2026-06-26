# Surface Moonpool And Waterline Review - 2026-06-26

Status: normal-scale review artifact for issue #265.

## Scope

Reviewed the surface base after the `surface_moonpool_waterline_v1.svg` source-art pass from #264.

Related docs:

- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/NEXT_SOURCE_ART_REPLACEMENT_PRIORITY_2026_06_26.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshots remain local and are not committed source assets.

Commit reviewed: `162690c`

Viewport: `1365x768`

Debug telemetry: hidden

Screenshot directory:

`C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_moonpool_review_2026_06_26/`

## Captures

| View | Screenshot | Observation | Result |
| --- | --- | --- | --- |
| Surface ready | `oceangame_acceptance_2026_06_26_seed_8919_surface_ready_kelpbloom_pass_watchlist.png` | Boat, waterline, and moonpool column read as one surface launch system. Ready panel remains readable, though panel translucency still lets surface art sit behind copy. | Pass with watchlist |
| Active launch | `oceangame_acceptance_2026_06_26_seed_8919_active_launch_kelpbloom_pass_watchlist.png` | Sub launches below the boat into the moonpool/waterline column. Safe base and waterline relationship is clearer than the previous loose polygon-only treatment. | Pass |
| Result surface | `oceangame_acceptance_2026_06_26_seed_8919_result_kelpbloom_pass_watchlist.png` | Result panel owns the readback state and the surface base remains recognizable behind it. The new waterline treatment does not break active/surface HUD separation. | Pass with watchlist |

## Readability Findings

- The moonpool/waterline sprite improves the relationship between boat, water surface, launch column, and safe base.
- The older fallback shadow, glow, launch column, and foam are now subdued enough to support the sprite without sitting on top of it as the primary read.
- `BaseZone` remains visually aligned with the moonpool/safe-return concept while staying separate from art ownership.
- The surface base now feels more like one authored launch/readback place rather than a boat sprite plus unrelated under-ship shapes.

## Watchlists

- Surface panels are still translucent enough that boat/waterline art can sit behind title and first-line copy. This belongs to #266.
- Recheck the surface after any future panel opacity, panel placement, or boat sprite scale change.
- Do not expand this into a broad background/parallax art pass before acceptance evidence is complete.

## Decision

Pass with watchlist.

The surface moonpool/waterline asset is good enough to keep wired for the current playable slice. The next narrow follow-up should tune panel opacity or placement only if the surface art continues to interfere with ready/result/upgrade text.
