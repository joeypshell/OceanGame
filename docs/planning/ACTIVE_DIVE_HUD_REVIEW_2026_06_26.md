# Active Dive HUD Review - 2026-06-26

Status: review artifact for issue #212.

## Scope

Reviewed the active operational HUD after the low/critical oxygen warning and cargo slot placeholder updates.

Evidence reviewed:

- `scenes/Main.tscn` HUD node layout.
- `scripts/main.gd` compact active/surface HUD helpers.
- `tests/logic_tests.gd` compact dive HUD coverage.
- `docs/current/GAMEPLAY.md` active HUD contract.
- `docs/current/SCREENSHOT_WORKFLOW.md` active-dive capture expectations.

No new screenshots were committed for this pass.

## State Coverage

| State | Review |
| --- | --- |
| Normal oxygen | Pass. Oxygen stays in the upper-left operational stack and does not need the warning panel. |
| Low oxygen | Pass. Inline `LOW` plus the upper-right warning panel adds urgency without moving gameplay rules. |
| Critical oxygen | Pass with watchlist. `CRITICAL` and return-focused warning copy are clear, but future UI skinning should avoid pulsing so strongly that scan/status text becomes secondary during a safe return. |
| Empty cargo | Pass. Cargo count plus empty slot placeholders explain remaining capacity. |
| Filled cargo | Pass. Filled slot tinting gives a compact carried-resource read without expanding the text stack. |
| Fourth cargo slot locked | Pass. Locked fourth slot remains dimmer than empty capacity until `Cargo Rack I` is owned. |
| Scan target | Pass. The scan target is contained in the bounded dive info panel instead of loose world labels. |
| Prompt/status | Pass with watchlist. `_compact_dive_status()` strips line breaks and limits active-dive status length, but new future status copy should keep the same compact constraint. |
| Safe-return text | Pass. Base direction remains in the left stack, and critical oxygen copy reinforces return without adding extra world labels. |
| Debug telemetry | Pass. Debug seed/condition/route telemetry remains separate from the player-facing active HUD and is gated behind debug visibility. |

## Findings

The current active HUD is acceptable for the next playable-loop issues. It is much less cluttered than the earlier overlapping text state because active dives now show only oxygen, depth, base direction, cargo, compact discovery count, and a bounded dive info panel.

The oxygen warning panel is appropriately separated to the upper right. It should remain a temporary urgency surface, not a permanent second status log.

The cargo slots are useful and low-risk. They should remain icon/slot-like placeholders until the broader UI skin pass; avoid adding item-name labels beside each slot.

No immediate implementation fix is needed. The next HUD work should be a deliberate skin/layout pass, not piecemeal text growth.

Follow-up plan: `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md` defines the first compact HUD skin pass for oxygen, depth, base direction, cargo slots, scan target, prompt/status, and warning panel.

## Watchlist

- Keep active status copy at or below the current compact limit.
- Do not reintroduce banked resources, upgrade details, recent expedition logs, or full discovery lore into active dive HUD mode.
- Keep low/critical oxygen warnings below safe-return readability; they should urge return, not hide route information.
- When adding future scan or echo feedback, prefer local visual pulses and concise HUD text over persistent markers.

## Verification

- MCP context self-test.
- `git diff --check`.
- `git status --short`.
