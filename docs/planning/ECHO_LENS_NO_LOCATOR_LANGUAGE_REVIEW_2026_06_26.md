# Echo Lens No-Locator Language Review - 2026-06-26

Status: review artifact for issue #305.

## Decision

Pass.

Current Echo Lens and Wreck Echo language remains broad/local/category-based. It does not add exact navigation, minimap, field-guide, checklist, persistent marker, route graph, or hidden-object locator behavior.

No runtime copy change is needed for this issue.

## Runtime Status Text

Current implemented repeat cache scan copy:

- before `Signal Lens I`: `Cache clue refreshed for Signal Lens I.`
- after `Signal Lens I`: `Cache echo unresolved: future Echo Lens study may read deeper wreck signals.`
- after `Echo Lens I`: `Echo Lens: weak wreck echo lingers below the shelf.`

Review:

- Pass. The copy is compact and local.
- Pass. It names category and remembered place relation, not coordinates.
- Pass. It does not say go to a precise target, add an objective, or reveal an exact route.

## Result Text

Current implemented Echo Lens result memory:

- `Research: Echo Lens caught a weak wreck echo below the shelf.`

Review:

- Pass. It preserves one compact memory line.
- Pass. It does not create a persistent quest log or route checklist.
- Pass. It is lower priority than extraction/failure, cargo, oxygen, and safe-return outcome text.

## Upgrade Role Copy

Current upgrade data and upgrade-bay role:

- `Tunes known route clues into broad unresolved signal echoes.`
- `Owned: future cache scans can study broad unresolved echoes.`
- `Role: broad wreck echoes, not material pings.`

Review:

- Pass. It distinguishes `Echo Lens I` from `Signal Lens I`.
- Pass. It does not promise exact object tracking, map behavior, field-guide entries, or material pings.
- Watchlist. Issue #315 should still review scanner distinction because both scanner upgrades now exist in the same upgrade ladder.

## Planning Docs

`SCANNER_PROGRESSION_V2.md` still uses `deeper-right` as an example broad phrase. That is acceptable as future planning language when tied to Wreck Shelf memory and no-locator constraints. The current runtime copy uses `below the shelf`, which is even more local and less coordinate-like.

`MYSTERY_SPINE_V1.md` and `WRECK_ECHO_DESCENT_NO_IMPLEMENTATION_CRITERIA_2026_06_26.md` keep the mystery spine and future route planning below immediate safety, oxygen, cargo, predator warning, and safe return.

## No-Locator Checklist

Current language avoids:

- exact coordinates,
- exact distance readout,
- minimap or route graph,
- field-guide entry,
- objective checklist,
- persistent marker,
- scanner energy/cooldown economy,
- hidden object reveal,
- pressure bypass,
- multi-signal list.

## Tests

Existing logic tests already guard no-locator language for:

- Echo Lens result callout,
- Echo Lens repeat cache scan echo,
- Signal Lens behavior staying separate from Wreck Signal Cache echo behavior.

## Follow-Up

No new issue is required from this review.

Continue with #315 to review scanner feedback distinction between `Signal Lens I` and `Echo Lens I`.
