# Upgrade Bay Selection Affordance Review - 2026-06-26

Status: review artifact and narrow copy tune for issue #296.

## Decision

Keep the one-selected-upgrade-at-a-time upgrade bay model.

The upgrade bay is readable enough for the current slice after one narrow affordance tune: the surface summary and selected-upgrade title now explicitly show Up/Down selection and E/Enter purchase language. Upgrade behavior, costs, states, prerequisites, purchase handling, and layout remain unchanged.

## Review

Selected upgrade title:

- Before: `Surface Upgrade Bay (1/7)` showed progress through the upgrade list but did not name how to cycle.
- Now: `Upgrade Bay (1/7) - Up/Down select` keeps the selection action on the panel itself.

Cost/state/feedback:

- Pass. Cost remains a single `Cost:` line.
- State remains explicit: owned, available, scan-locked, upgrade-locked, or missing resources.
- Feedback remains compact after purchase attempts and does not add inventory management.

Surface prompt:

- Pass. The extracted-surface prompt still says `Upgrade bay: Up/Down select, E purchase, R next expedition | Left/Right surface view` when upgrades remain.
- All-upgrades-owned and non-upgrade views keep their existing prompts.

Panel copy:

- Tuned from `Choose upgrade below; E/Enter buys.` to `Up/Down choose; E/Enter buys.` so the run panel and selected-upgrade panel agree.

## Scope Guard

This does not add:

- tech tree,
- upgrade grid,
- inventory UI,
- scroll list,
- field guide,
- quest checklist,
- new upgrades,
- economy changes,
- new purchase behavior.

## Verification Note

The title formatter is covered by logic tests so future copy changes should keep the Up/Down selection affordance visible.
