# Result Memory Readability Review - 2026-06-26

Status: review artifact for issue #256.

## Purpose

Review result-memory lines for scannability and one-more-expedition motivation. Result copy should help the player understand what mattered during the dive, what persisted, and why another expedition is worth starting, without becoming a quest log, telemetry dump, or checklist.

## Summary Decision

The current result-memory model is acceptable for the playable vertical-slice gate with two watchlists:

- keep upgrade progress and scan memory compact as more upgrades are added,
- keep debug-only seed, condition id, route id, oxygen-at-result, and failure-cause details behind F3 telemetry.

No immediate copy change is required from this review. The upgrade tab overflow remains tracked separately by the surface readability review and issue #257.

## Result Line Review

| Result Element | Current Role | Readability Result | Watchlist |
| --- | --- | --- | --- |
| Completed expedition title | Names the completed day and result state. | Pass. It anchors the result as an expedition memory instead of a raw restart screen. | Keep day/result title short. |
| Banked cargo or cargo loss | States what came home or was lost. | Pass. It answers the first player question after extraction/failure. | Do not bury this below research flavor. |
| Remembered place | Names one meaningful place such as Surface Base, Shell Reef, Thermal Vent Field, Wreck Shelf, or Gulper Route. | Pass. It supports hybrid-ocean place memory without a map. | Keep to one place; do not list every landmark touched. |
| First discovery memory | Adds one optional first-time discovery line. | Pass. It rewards scanning without turning every scan into a journal entry. | Keep priority order strict so repeated ids do not duplicate. |
| Route choice | Summarizes the practical route decision. | Pass. It gives "what I did" memory in one line. | Avoid multi-step route summaries or objective phrasing. |
| Gulper research | Adds one compact creature-learning line only when evidence exists. | Pass. It makes predator encounters learnable without combat rewards. | Keep weapons, harvesting, health, and capture language out. |
| Echo Lens research | Adds one compact broad wreck-echo line only when an echo fires. | Pass. Current no-locator tests guard against map/checklist/field-guide language. | Keep it local mystery, not exact routing. |
| Upgrade progress | Calls out ready upgrades or missing scan prerequisites. | Pass with watchlist. It helps the next expedition feel intentional. | As the upgrade list grows, avoid turning this into a tech-tree checklist. |
| Scan progress | Shows discoveries recorded or scans kept. | Pass. It preserves useful no-cargo dives. | Keep debug ids hidden and names compact. |
| Next expedition copy | Frames R as preparing the next shifted ocean day. | Pass. It supports the daily-run loop better than raw restart language. | Do not imply a real-world daily challenge calendar. |
| Debug telemetry | F3-only playtest block. | Pass by current tests and docs. | Never expose seed, cluster pattern, raw condition id, predator route, oxygen result, or failure cause by default. |

## Checklist And Telemetry Risks

Copy would fail this review if it:

- lists every scanned object as a required task,
- says `objective`, `quest`, `checklist`, `map`, `marker`, `field guide`, or exact coordinates,
- exposes raw ids such as condition id, resource id, predator route id, or cluster pattern in normal result UI,
- reports oxygen-at-result or failure-cause debugging by default,
- turns Echo Lens or Rare Signal into a hidden-object locator,
- presents Gulper evidence as combat loot or a monster-hunting completion goal.

## Acceptance Alignment

This review supports the playable-slice acceptance checklist by keeping result flow focused on:

- what was banked or lost,
- what place mattered,
- what discovery or route was learned,
- which upgrade or scan path is next,
- why another expedition is worth starting.

It intentionally avoids a full journal, field guide, objective tracker, minimap, route graph, or broad post-run analytics screen.

## Follow-Up Guidance

Future result-copy issues should run logic tests if they change formatter behavior. They should also verify that:

- `Playtest data:` stays hidden unless debug telemetry is enabled,
- result panels remain scannable at normal scale,
- upgrade progress stays one compact callout,
- no-cargo scan-only returns still feel useful without implying free resources.
