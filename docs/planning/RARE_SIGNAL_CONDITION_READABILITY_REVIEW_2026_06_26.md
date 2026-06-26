# Rare Signal Condition Readability Review - 2026-06-26

Status: review artifact for issues #230 and #232.

## Scope

Reviewed the `Rare Signal` expedition condition against the current Wreck Echo spine, `Echo Lens I` planning, and the condition review matrix.

Evidence reviewed:

- `scripts/expedition_condition.gd`
- `docs/planning/CONDITION_REVIEW_MATRIX_2026_06_26.md`
- `docs/planning/MYSTERY_SPINE_V1.md`
- `docs/planning/SCANNER_PROGRESSION_V2.md`
- `docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md`
- `docs/current/GAMEPLAY.md`

No new screenshots were committed for this pass.

## Current Player-Facing Read

Condition name: `Rare Signal`

Ready-panel briefing:

`A weak research ping is active below.`

Current status: presentation-only. It adds a faint Wreck Shelf signal shimmer, but does not change resource placement, scan range, Wreck Signal Cache behavior, Echo Lens behavior, pressure locks, predator routes, oxygen, cargo, or route layout.

## Readability Findings

| Check | Finding |
| --- | --- |
| Ready-panel copy | Pass. The copy is short and compatible with the existing `Today:` condition block. |
| Wreck Shelf relation | Pass. The phrase `weak research ping` fits Wreck Shelf, Wreck Signal Cache, and Wreck Echo curiosity without naming an exact target. |
| Route promise | Pass with watchlist. The faint signal shimmer makes the condition visible without naming an exact target. |
| No-overpromise | Pass with watchlist. It does not say a cache is exposed, a route is open, or an upgrade is guaranteed. |
| Debug gating | Pass by current condition system. Raw condition id, seed, and route telemetry remain F3-only. |
| Safe-return readability | Pass with watchlist. The shimmer is low-opacity and local, but future brightening should not obscure return cues. |

## Recommendation

The first visual effect is warranted and intentionally subtle/local.

Implemented first effect:

- a faint signal shimmer near Wreck Shelf / Wreck Signal Cache language,
- lower priority than oxygen, predator warning, pressure lock, and safe-return visuals,
- visible enough to make the condition feel different,
- not persistent enough to read as an objective marker.

Issue #244 tuning keeps the effect local by:

- softening the revealed future-cache signal shape so it reads as a broken echo rather than a directional arrow,
- changing Echo Lens/cache wording away from `deeper-right` locator language and toward `below the shelf` local mystery language,
- preserving broad curiosity without adding coordinates, map UI, checklist behavior, or remote objective markers.

Do not turn `Rare Signal` into:

- an exact locator,
- a minimap marker,
- a quest checklist,
- a guaranteed cache reveal,
- an upgrade shortcut,
- a broad hidden-object scanner,
- or a new route behavior without a separate implementation issue.

## Future Acceptance Notes

If a future issue prototypes Rare Signal visual emphasis, it should pass these checks:

- ready-panel copy remains one line,
- no exact coordinates or target names are added,
- Wreck Shelf remains a remembered region, not a quest node,
- pressure gate and Wreck Signal Cache behavior remain unchanged,
- result and scan copy continue to use broad curiosity language,
- debug telemetry remains gated behind F3.

## Decision

Keep the small visual-emphasis prototype. The effect should continue to reinforce Wreck Echo curiosity, not add a new mechanic.
