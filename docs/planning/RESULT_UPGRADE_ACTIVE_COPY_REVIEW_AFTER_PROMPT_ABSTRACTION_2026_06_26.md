# Result Upgrade Active Copy Review After Prompt Abstraction - 2026-06-26

Status: pass with upgrade-panel watchlist.

Issue: #392.

## Purpose

Review the player-facing result, upgrade, and active HUD copy after the first prompt-label abstraction pass. This review checks readability and scope boundaries only; it does not add controller support, touch controls, input remapping, minimaps, field guides, quest checklists, combat, or broader Wreck Echo scope.

## Evidence

- `npm.cmd run test:visual` was attempted after prompt abstraction and exposed that the low/critical oxygen screenshot timing could overshoot into oxygen failure.
- `tests/playwright/visual-smoke.spec.mjs` was tightened from a 4.2 second low-to-critical wait to 3.2 seconds.
- `npm.cmd run test:visual:existing` then passed with 3 Playwright tests.
- Reviewed current artifacts:
  - `extraction-result.png`
  - `upgrade-tab.png`
  - `active-dive.png`
  - low/critical oxygen captures and metadata sidecars

## Findings

| Area | Result | Notes |
| --- | --- | --- |
| Result panel | Pass | Result copy remains scannable. Prompt abstraction keeps keyboard labels visible without adding controller/touch language. |
| Active HUD prompt/status | Pass | `Explore, bank at base | Space: burst -4 O2` remains compact and does not turn the active HUD into a route panel or objective list. |
| Low/critical oxygen HUD | Pass | Oxygen warning states remain louder than curiosity/reward language, and the Playwright capture now hits the critical window before failure. |
| Upgrade summary prompt | Pass | `Up/Down choose; E/Enter buys` and next-expedition copy remain understandable and keyboard-only. |
| Upgrade details panel | Pass with watchlist | The selected-upgrade detail text still runs close to or beyond the lower panel edge in the current screenshot. This predates the prompt abstraction but remains the clearest copy/layout risk. |
| Controller/touch scope | Pass | No runtime copy claims controller or touch support exists. Future label profiles remain planning-only. |

## Decision

Keep the prompt abstraction changes. They improve future input-label flexibility without changing current keyboard behavior or adding unsupported platform scope.

Do not expand input work yet. The next copy/layout risk is still upgrade details density, not controller/touch implementation.

## Follow-Up

- Keep upgrade details copy/layout on the polish watchlist before a polished playable build.
- If a new issue is created, keep it narrow: reduce or paginate selected-upgrade detail text, or adjust the upgrade panel layout without adding a tech tree, inventory grid, field guide, or settings UI.
- Continue using Playwright metadata sidecars when reviewing result/upgrade/active captures.
