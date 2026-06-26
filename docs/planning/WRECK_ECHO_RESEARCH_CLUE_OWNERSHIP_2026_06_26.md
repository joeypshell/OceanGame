# Wreck Echo Research Clue Ownership - 2026-06-26

Status: planning artifact for issue #355. No runtime state, save data, scene node, scan target, or route behavior is implemented here.

## Decision

The first future `Wreck Echo Descent` research clue should be owned as run result memory first, not as a new quest, field-guide, or objective state.

If the player reaches or scans the first Wreck Echo pocket and returns safely, the active expedition may record one temporary clue flag in `DiveSession` or a small run-scoped helper owned by `main.gd`. Extraction can then format one compact `Research:` line in the result panel. That temporary flag resets with the expedition.

Do not add durable clue progression for the first implementation unless a later issue explicitly needs it after playtesting the result-only version.

## Ownership Split

| State | Owner | Persistence | Notes |
| --- | --- | --- | --- |
| Active attempt started, clue seen this dive, local echo pulse, temporary route prompt | `DiveSession` or run-scoped orchestration helper | Current expedition only | Resets on extraction, failure, restart, or expedition advance. |
| Result-panel research line after a successful return | `main.gd` result formatting from current expedition state | Visible for the current surface result view/log moment | Should stay one compact line and avoid checklist language. |
| Existing scan discoveries such as `Wreck Signal Cache` | `ProgressionState.scan_discoveries` | Durable | Existing behavior remains unchanged. |
| Future promoted Wreck Echo discovery, if later approved | `ProgressionState.scan_discoveries` or a narrow durable research collection | Durable only after a separate issue | Requires save-schema review, copy guardrails, and tests. |

## Why Result Memory First

A result-only clue fits the current vertical-slice promise:

- it rewards a risky dive with a concrete memory,
- it keeps the focus on oxygen margin and return planning,
- it avoids turning `Echo Lens I` into a hidden-object locator,
- it avoids broad field-guide, quest-log, and objective-list scope,
- it lets the team test whether the clue feels rewarding before adding save-schema surface area.

The clue can still influence player memory through the recent expedition log and result panel, but it should not create a persistent marker, route instruction, map pin, checklist item, or new upgrade unlock.

## Durable Persistence Gate

Promote Wreck Echo clue state into durable progression only if a later implementation or playtest issue proves one of these needs:

- the player must see a stable "you learned this" line after relaunch,
- a later feature needs to know that the Wreck Echo research clue was confirmed,
- a future upgrade or route requires the clue as an explicit prerequisite,
- result-only memory proves too easy to miss.

If promoted, use the smallest existing durable shape first: a named scan discovery or a narrow research record. Do not create a broad field guide, quest system, codex, route graph, or map objective just for the first clue.

## Future Implementation Acceptance

The first implementation issue should require:

- one run-scoped Wreck Echo clue flag,
- extraction-only result copy for the primary research reward,
- reset coverage proving no stale prompt, marker, or clue flag survives into the next expedition,
- no save-schema change unless the issue explicitly promotes durable persistence,
- no exact locator language,
- no field guide, quest log, objective checklist, minimap marker, or broad research UI,
- no pressure bypass from `Echo Lens I`.

## Current Scope

This planning note changes no runtime behavior. It records where the future clue should live so the first Wreck Echo implementation can stay small and testable.
