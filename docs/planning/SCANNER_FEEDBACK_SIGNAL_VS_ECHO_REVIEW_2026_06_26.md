# Scanner Feedback Signal Lens Vs Echo Lens Review - 2026-06-26

Status: review artifact for issue #315.

## Purpose

Review whether `Signal Lens I` and `Echo Lens I` read as distinct scanner upgrades.

This is a docs-only review. No runtime copy or tests were changed because the current distinction is already explicit and covered.

## Evidence Reviewed

- `docs/planning/SCANNER_PROGRESSION_V2.md`
- `docs/planning/ECHO_LENS_NO_LOCATOR_LANGUAGE_REVIEW_2026_06_26.md`
- `docs/current/GAMEPLAY.md`
- `scripts/main.gd`
- `tests/logic_tests.gd`

## Distinction Summary

| Upgrade | Player Question | Current Feedback | Decision |
| --- | --- | --- | --- |
| `Signal Lens I` | Where is another known material I can collect? | Repeat known resource scans say the pulse leans toward another visible matching deposit, or that no matching visible deposits are nearby. | Pass |
| `Echo Lens I` | Is there an unresolved wreck signal worth remembering for future planning? | Repeat known `Wreck Signal Cache` scans produce broad local wreck-echo text plus a temporary local pulse at the cache. | Pass |

## Runtime Status Text

`Signal Lens I`:

- Practical resource-facing copy.
- Only applies to `ResourcePickup` repeat scans.
- Mentions another matching visible deposit.
- Returns quiet copy when no matching visible deposit exists.

`Echo Lens I`:

- Curiosity-facing wreck-route copy.
- Applies to the known `Wreck Signal Cache` repeat scan.
- Uses broad local language: weak wreck echo below the shelf.
- Triggers a temporary local `EchoPulse`, not a persistent marker.

Decision: pass. The active status text separates material support from wreck curiosity.

## Result Text

`Echo Lens I` can add:

```text
Research: Echo Lens caught a weak wreck echo below the shelf.
```

`Signal Lens I` does not create a separate result-memory line. It is immediate practical scan support for the current dive.

Decision: pass. Echo Lens result text reinforces remembered mystery, while Signal Lens remains tactical and current-run practical.

## Upgrade Bay Role Hints

`Echo Lens I` keeps the role hint:

```text
Role: broad wreck echoes, not material pings.
```

This appears across scan-locked, upgrade-locked, missing-resource, available, and owned states in existing logic coverage.

Decision: pass. The role hint directly prevents the most likely confusion.

## Test Coverage

Existing logic tests cover:

- `Echo Lens I` requires `Wreck Signal Cache` and `Signal Lens I`,
- `Echo Lens I` effect isolation,
- Echo Lens result callout and no-locator language,
- Echo Lens upgrade bay role hint across states,
- cache repeat scan after `Signal Lens I` hints at future Echo Lens study,
- cache repeat scan after `Echo Lens I` produces broad local wreck echo,
- Wreck Signal Cache repeat hint does not reuse resource pulse behavior,
- no locator/map/checklist-style language in Echo Lens copy.

Decision: pass. No new test is needed because no copy changed in this review.

## Guardrails

Keep `Signal Lens I`:

- resource-facing,
- visible-deposit-facing,
- current-run practical,
- non-global,
- non-map.

Keep `Echo Lens I`:

- wreck/cache-facing,
- broad/local/category-facing,
- future-planning curiosity,
- temporary,
- non-material,
- non-locator.

Do not add:

- exact coordinates,
- minimap,
- route graph,
- objective checklist,
- field-guide UI,
- hidden material detector,
- multi-signal list,
- scanner energy/cooldown economy.

## Decision

Pass.

The scanner ladder currently reads as two different tools: `Signal Lens I` helps with practical material collection, while `Echo Lens I` supports broad Wreck Echo curiosity and remembered-place planning. No runtime copy or layout change is needed from this review.
