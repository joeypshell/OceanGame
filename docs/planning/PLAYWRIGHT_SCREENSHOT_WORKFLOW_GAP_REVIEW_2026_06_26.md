# Playwright And Screenshot Workflow Gap Review - 2026-06-26

Status: pass with tooling watchlist.

Issue: #381.

## Purpose

Review whether the current screenshot and Playwright workflow covers the visual states now important to OceanGame: Wreck Echo, compact HUD, lower-route regression, result/upgrade panels, and future controller/touch input planning.

This review does not add mobile/device automation, controller automation, touch UI, or a new screenshot artifact format.

## Evidence Reviewed

- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/TOOLING.md`
- `docs/planning/FUTURE_PLATFORM_INPUT_TARGETS_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_AFTER_PLATFORM_INPUT_GUARDRAIL_2026_06_26.md`
- Recent Playwright artifacts under `test-results/playwright/`

## Current Coverage

The current Playwright smoke is useful and should remain part of visual regression review:

- exports the Godot Web build,
- serves it with required browser headers,
- resets local prototype progress,
- captures deterministic surface/active/lower-route states,
- captures staged Wreck Echo route and result readback states,
- gives repeatable local screenshot artifacts for review notes.

## Observed Gaps

| Gap | Current Risk | Worth automating now? |
| --- | --- | --- |
| True result view capture | Recent `extraction-result.png` artifact can still show active-dive state, making result review rely on Wreck Echo staged result or manual notes. | Yes, next tooling issue. |
| True upgrade tab capture | Recent `upgrade-tab.png` artifact can still show active-dive state, so upgrade-panel evidence is weaker than intended. | Yes, next tooling issue. |
| No-debug player-facing Wreck Echo result | Staged Wreck Echo result enables debug telemetry to use F6, so it is route/result evidence but not a normal player-facing capture. | Yes, when touching Wreck Echo/result UI. |
| Low/critical oxygen HUD | Current default smoke does not lock in low/critical oxygen and return-decision states. | Yes, after result/upgrade capture is reliable. |
| Input prompt states | Controller/touch planning needs prompt/copy state evidence, but current screenshots are keyboard-only and desktop-size. | Later, after prompt abstraction exists. |
| Mobile-like landscape viewport | Future iPhone/touch work needs safe-area and lower-corner overlay evidence. | Deferred until mobile/touch implementation is promoted. |
| Surface tabs and recent log | Result/upgrades/log are central to the loop, but current evidence can be state-fragile. | Yes, as part of result/upgrade capture hardening. |

## Recommended Next Automation

The next Playwright tooling pass should focus on current desktop slice reliability, not mobile/device scope:

1. Make `extraction-result.png` prove a completed extraction panel is visible.
2. Make `upgrade-tab.png` prove the surface upgrade tab is visible.
3. Add assertions or screenshot labels that fail if the captured state is still active dive.
4. Add a no-debug Wreck Echo result or ordinary result capture if it can be staged without relying on player traversal.
5. Add low/critical oxygen capture only after the result/upgrade state bug is resolved.

Do not automate mobile safe areas, touch overlays, controller prompts, or device/browser matrices yet.

## Documentation Updates Made

- `docs/current/SCREENSHOT_WORKFLOW.md` now distinguishes current default Playwright captures from known workflow gaps and next automation targets.
- `docs/current/TOOLING.md` now says the Playwright harness is useful but still has known result/upgrade and debug-staged limitations.

## Verification

- `npm.cmd run test:visual` should still pass after workflow documentation changes.
- `node .mcp/oceangame-context-server.mjs --self-test` should pass because tooling/screenshot resources changed.
- `git diff --check` should pass.
