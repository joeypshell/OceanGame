# Solo First-Run Readability Result - 2026-06-26

Status: solo review result for issue #300.

## Scope

This is a one-developer review using `docs/planning/SOLO_FIRST_RUN_READABILITY_CHECKLIST_2026_06_26.md`.

It is not blind validation and does not claim outside-player evidence.

Baseline:

- Commit: `78152f3`
- Viewport: normal/default project viewport expectation
- Save state: clean first-run assumption after F9 reset flow
- Screenshots: not captured for this pass; use issue #301 for the compact evidence bundle

## Overall Result

Pass with watchlist.

The first-run flow is usable enough to proceed into compact acceptance evidence, but it should still be reviewed visually through #301, #310, #314, and #317 before declaring the slice fully polished.

## Pass 1: First Ready Screen

Result: Pass with watchlist.

What reads:

- The ready panel owns the first action and says E/Enter begins.
- Condition copy is player-facing and avoids seed/debug language.
- The goal line points toward a practical next action rather than a broad checklist.
- Debug reset copy is hidden unless debug telemetry is visible.

Watchlist:

- Boat/moonpool art and panel opacity should stay under review whenever surface art changes.
- Durable progression reset expectations should be checked through #317 so owned items after relaunch do not feel like a bug during first-run testing.

## Pass 2: First Dive Start

Result: Pass with watchlist.

What reads:

- Oxygen, depth, base direction, cargo, scan target, prompt, and status are separated from the surface panel.
- The sub sprite reads clearly against the current shallow/midwater background treatment.
- Base direction and upward return language remain understandable.

Watchlist:

- Low-oxygen and critical states should be rechecked after the recent prompt/title copy work through #313.
- Lower-route and background-study contrast should be rechecked through #310.

## Pass 3: First Pickup Or Scan

Result: Pass.

What reads:

- Resource and scan target labels are compact and tied to visible highlighted objects.
- First-time resource scan text points toward collect-and-bank behavior.
- Scanner feedback does not imply a minimap, exact locator, field guide, or objective checklist.

Watchlist:

- Signal Lens versus Echo Lens distinction should be reviewed through #315 because both are scanner upgrades with intentionally different meanings.

## Pass 4: First Return Or Failure

Result: Pass with watchlist.

What reads:

- Extraction and failure distinguish carried cargo from banked/durable progress.
- Result copy preserves one useful memory line without becoming a checklist.
- R next-expedition framing keeps the loop moving.

Watchlist:

- Durable progression persistence and reset/onboarding copy should be reviewed through #317.
- Compact vertical-slice evidence should include at least one return or failure result through #301.

## Pass 5: First Upgrade View

Result: Pass with watchlist.

What reads:

- The upgrade tab is one selected upgrade at a time.
- The selected-upgrade title now exposes Up/Down selection.
- Cost, state, missing scan, missing upgrade, and missing resources remain explicit.
- The view does not become a tech tree or inventory grid.

Watchlist:

- Normal-scale affordance should be reviewed after the recent copy tune through #314.

## Follow-Up Issue Decision

No new issues were created from this pass.

The concrete watchlist areas are already covered by the newly created queue:

- #301: compact acceptance evidence bundle,
- #310: lower-route readability with background study wired,
- #313: active HUD low-oxygen review,
- #314: upgrade bay normal-scale affordance,
- #315: scanner feedback distinction,
- #317: durable progression reset/onboarding copy.

## Final Note

This solo pass supports continuing the closeout sequence, but it should not be used as a replacement for future outside-player validation when helpers become available.
