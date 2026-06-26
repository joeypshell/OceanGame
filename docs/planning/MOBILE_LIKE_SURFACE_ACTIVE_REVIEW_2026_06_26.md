# Mobile-Like Surface And Active Review - 2026-06-26

Status: pass with safe-zone watchlist.

Issue: #408.

## Purpose

Review the new mobile-like Playwright scaffold captures for surface-ready and active-dive readability at a smaller landscape viewport. This review does not implement touch controls, controller support, mobile export settings, device safe areas, minimaps, field guides, quest checklists, combat, capture, harvesting, or broad UI redesign.

## Evidence

Command:

```powershell
npm.cmd run test:visual:mobile-like:existing
```

Artifacts:

- `test-results/playwright-mobile-like/.../mobile-like-surface-ready.png`
- `test-results/playwright-mobile-like/.../mobile-like-active-dive.png`

Metadata:

- `mobile-like-surface-ready.json`: `result: ready`, `run_panel_visible: true`, `debug_telemetry: false`, viewport `960x540`.
- `mobile-like-active-dive.json`: `result: diving`, `active_stats_visible: true`, `oxygen_state: normal`, `debug_telemetry: false`, viewport `960x540`.

## Findings

| View | Result | Notes |
| --- | --- | --- |
| Surface ready | Pass with watchlist | The ready panel is readable and the start/goal/condition copy fits. It occupies most of the smaller viewport, which is acceptable before touch UI exists but should be revisited before mobile support. |
| Active dive | Pass with watchlist | O2, depth, base direction, cargo, scan, prompt, and status remain bounded and readable. The left-side HUD would likely compete with future virtual movement controls. |
| Debug state | Pass | Debug telemetry is hidden in both captures. |
| Unsupported platform claims | Pass | The captures do not imply touch/controller support exists. |

## Decision

Keep the current desktop-first HUD and surface panel for now. The mobile-like scaffold is useful evidence, and the current surface/active views are readable enough to continue planning, but they should not be called mobile-ready.

## Follow-Up

- #409 should review the lower-route mobile-like capture separately.
- #410 should convert these observations into future touch safe-zone constraints.
- Do not add touch controls or mobile export settings until a later issue explicitly promotes that work.
