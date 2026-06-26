# Surface Ready And Result Readability Review - 2026-06-26

Status: review artifact for issue #242.

## Scope

Reviewed the surface ready/result/failure screens against the playable vertical-slice acceptance gate after the active HUD skin pass.

Related docs:

- `docs/current/GAMEPLAY.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/planning/VERTICAL_SLICE_ART_KIT_SCREENSHOT_CHECKLIST_2026_06_26.md`

Capture method: temporary Godot script outside the repo, using the screenshot workflow. Screenshots were written to local Godot user data and are not committed source assets.

Commit reviewed: `9899f05`

Viewport: `1365x768`

Debug telemetry: hidden

Screenshot directory:

`C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_surface_review_2026_06_26/`

## Captures

| View | Screenshot | Observation | Result |
| --- | --- | --- | --- |
| Ready panel | `oceangame_surface_ready_panel_2026_06_26.png` | Active operational HUD rows are hidden. The start prompt, condition, and goal line are readable. Boat/sub art shows through the translucent panel around the title and first lines. | Pass with polish |
| Result panel | `oceangame_surface_result_panel_2026_06_26.png` | Result memory, banked cargo, upgrade progress, and next expedition prompt are scannable. No active HUD clutter leaks in. Background boat/sub art is visible through the panel but does not block reading. | Pass with polish |
| Failure panel | `oceangame_surface_failure_panel_2026_06_26.png` | Failure summary owns the screen, cargo loss and preserved progress read clearly, and active dive HUD rows stay hidden. | Pass with polish |
| Upgrade tab | `oceangame_surface_upgrade_tab_2026_06_26.png` | Upgrade bay state is understandable, but long upgrade description/feedback text extends beyond the panel bounds and can run into the viewport edge/bottom. | Fail for polish |
| Log tab | `oceangame_surface_log_tab_2026_06_26.png` | Recent expedition log is compact and readable. No debug telemetry or active HUD rows are visible. | Pass |

## Immediate Fixes

1. Tighten the upgrade tab layout.
   - Current issue: long upgrade description/feedback copy exceeds the upgrade panel bounds.
   - Recommended fix: wrap/shorten upgrade description and feedback, increase panel height only if needed, and keep the view from becoming a full tech-tree/crafting screen.
   - Existing follow-up: #257 reviews upgrade bay readability against the current seven-upgrade set.

2. Consider a surface-panel opacity or placement tune.
   - Current issue: the boat/sub sprites show through the translucent panel behind titles and first lines.
   - Recommended fix: slightly increase panel opacity or shift the surface panel enough that the boat remains a first-viewport signal without sitting behind core copy.

## Deferred Polish

- Re-check ready/result panels after any boat/waterline layout change.
- Keep debug-only reset/seed/pattern/condition ids hidden in normal captures.
- Keep surface tabs compact; do not add a full quest log, checklist, or field guide to solve result readability.

## Acceptance Notes

- Surface ready, result, failure, and log states satisfy the core gate that active dive HUD clutter stays hidden.
- Upgrade tab is the only surface view that currently fails the polish bar due to text overflow.
- No debug/prototype reset text appeared in normal player-facing captures.
