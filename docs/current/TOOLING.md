# Current Tooling

This file describes implemented repository tooling and agent workflow support.

## Godot AI MCP

OceanGame adopts `hi-godot/godot-ai` as optional local Godot editor MCP tooling for scene-aware development. It is not vendored into this repository and is separate from the repo-local read-only OceanGame context MCP server.

Policy and setup notes live in:

- `docs/current/GODOT_MCP.md`

## Screenshot Workflow

Repeatable visual review capture guidance lives in:

- `docs/current/SCREENSHOT_WORKFLOW.md`

Use it for surface-ready, active-dive, lower-route, condition, and UI readability screenshots. It documents manual capture, temporary local script capture, and optional Godot AI MCP capture without requiring unavailable automation.

## Playwright Web Visual Smoke

The project has a Playwright harness for repeatable Godot Web screenshot smoke tests. Use it when the question is visual layout/readability across known player-facing states, especially before or after HUD, route, surface panel, or lower-route art changes. Keep Godot headless logic tests as the source for deterministic gameplay/state assertions; Playwright is for exported-browser confidence and screenshot artifacts.

Setup:

```powershell
npm install
npm run playwright:install
```

Run the full export plus browser smoke:

```powershell
npm run test:visual
```

Useful split commands:

```powershell
npm run web:export
npm run test:visual:existing
```

The Web export preset writes to `exports/web/index.html`. The Playwright server serves that folder with the cross-origin isolation headers Godot Web builds need. Screenshots, traces, and reports are local artifacts under `test-results/` and `playwright-report/`; do not commit them unless a future issue explicitly asks for reference images.

Current scenarios are intended to capture surface ready, active dive, extraction result, upgrade tab, lower-route pressure-gate, staged Wreck Echo route, and staged Wreck Echo result-readback views. The test resets the prototype save with the existing F9 debug hook before capture so runs start from a deterministic first-expedition state. Reviewers should confirm that `extraction-result.png` and `upgrade-tab.png` actually show their named surface states before using them as evidence; `docs/planning/PLAYWRIGHT_SCREENSHOT_WORKFLOW_GAP_REVIEW_2026_06_26.md` records the current hardening targets. The Wreck Echo smoke path enables debug telemetry and uses the F6 review hook to stage route/result screenshots; this is visual layout evidence, not a replacement for Godot logic tests, no-debug player-facing result review, or manual gameplay validation.

## MCP Context Server

The first MCP slice is agent workflow support: a small repo-local context server exposes OceanGame source-of-truth docs as MCP resources. It does not control the Godot editor, mutate files, require secrets, or replace the GitHub issue workflow.

Server:

- `.mcp/oceangame-context-server.mjs`

Resources:

- `oceangame://agents`
- `oceangame://architecture`
- `oceangame://roadmap`
- `oceangame://gameplay`
- `oceangame://tooling`
- `oceangame://godot-mcp`
- `oceangame://screenshot-workflow`
- `oceangame://project-status`
- `oceangame://core-loop`
- `oceangame://seeded-expeditions`
- `oceangame://game-vision`
- `oceangame://future-expansive-dive-levels-2026-06-26`
- `oceangame://future-platform-input-targets-2026-06-26`
- `oceangame://input-action-contract-review-2026-06-26`
- `oceangame://future-controller-support-plan-2026-06-26`
- `oceangame://future-mobile-landscape-touch-plan-2026-06-26`
- `oceangame://compulsion-identity-2026-06-26`
- `oceangame://progression-ladder`
- `oceangame://predator-direction`
- `oceangame://blind-validation-kit`
- `oceangame://solo-first-run-readability-checklist-2026-06-26`
- `oceangame://expedition-goal-ii`
- `oceangame://scanner-improvement-i`
- `oceangame://scanner-progression-v2`
- `oceangame://deeper-access-after-echo-lens-2026-06-26`
- `oceangame://next-milestone-after-vertical-slice-closeout-2026-06-26`
- `oceangame://wreck-echo-descent-no-implementation-criteria-2026-06-26`
- `oceangame://wreck-echo-descent-route-pocket-data-shape-2026-06-26`
- `oceangame://wreck-echo-oxygen-cargo-preparation-review-2026-06-26`
- `oceangame://cargo-improvement-i`
- `oceangame://burst-thruster`
- `oceangame://monster-observation-i`
- `oceangame://predator-warning-i`
- `oceangame://biome-pocket-i`
- `oceangame://biome-pocket-ii`
- `oceangame://shell-reef-route-review`
- `oceangame://shell-reef-route-review-2026-06-25`
- `oceangame://surface-ui-layout-pass`
- `oceangame://visual-language-readability-assets`
- `oceangame://visual-replacement-plan`
- `oceangame://visual-asset-slot-review-2026-06-26`
- `oceangame://asset-source-pipeline-v1`
- `oceangame://asset-provenance-review-2026-06-26`
- `oceangame://active-dive-hud-review-2026-06-26`
- `oceangame://playable-vertical-slice-acceptance-checklist-2026-06-26`
- `oceangame://vertical-slice-acceptance-evidence-bundle-2026-06-26`
- `oceangame://playable-vertical-slice-closeout-review-2026-06-26`
- `oceangame://vertical-slice-clean-demo-script-2026-06-26`
- `oceangame://next-vertical-slice-milestone-2026-06-26`
- `oceangame://active-hud-normal-scale-screenshot-review-2026-06-26`
- `oceangame://surface-ready-result-readability-review-2026-06-26`
- `oceangame://shell-reef-sprite-fallback-balance-review-2026-06-26`
- `oceangame://thermal-vent-sprite-fallback-balance-review-2026-06-26`
- `oceangame://pressure-wreck-cache-sprite-fallback-balance-review-2026-06-26`
- `oceangame://gulper-route-danger-readability-review-2026-06-26`
- `oceangame://playable-vertical-slice-manual-smoke-log-2026-06-26`
- `oceangame://next-source-art-replacement-priority-2026-06-26`
- `oceangame://expedition-condition-visual-acceptance-review-2026-06-26`
- `oceangame://result-memory-readability-review-2026-06-26`
- `oceangame://upgrade-bay-readability-review-2026-06-26`
- `oceangame://clean-save-two-expedition-smoke-pass-2026-06-26`
- `oceangame://decoy-pulse-owned-state-review-2026-06-26`
- `oceangame://lower-route-readability-recheck-2026-06-26`
- `oceangame://lower-route-acceptance-cleanup-recheck-2026-06-26`
- `oceangame://surface-moonpool-waterline-review-2026-06-26`
- `oceangame://upgrade-tab-normal-scale-review-2026-06-26`
- `oceangame://no-debug-surface-capture-sanity-review-2026-06-26`
- `oceangame://pressure-wreck-cache-recheck-after-surface-readability-2026-06-26`
- `oceangame://pressure-wreck-cache-backup-art-pass-constraints-2026-06-26`
- `oceangame://pressure-dark-threshold-use-decision-2026-06-26`
- `oceangame://condition-visual-normal-scale-review-2026-06-26`
- `oceangame://decoy-pulse-result-memory-hud-smoke-2026-06-26`
- `oceangame://echo-lens-cache-pulse-readability-recheck-2026-06-26`
- `oceangame://surface-moonpool-asset-provenance-requirements-2026-06-26`
- `oceangame://active-prompt-burst-decoy-review-2026-06-26`
- `oceangame://first-run-surface-ready-comprehension-review-2026-06-26`
- `oceangame://first-run-active-dive-comprehension-review-2026-06-26`
- `oceangame://save-progression-persistence-expectation-2026-06-26`
- `oceangame://sub-idle-thrust-normal-scale-recheck-2026-06-26`
- `oceangame://sub-idle-thrust-source-art-polish-constraints-2026-06-26`
- `oceangame://surface-launch-return-readability-review-2026-06-26`
- `oceangame://next-source-art-after-moonpool-decision-2026-06-26`
- `oceangame://surface-panel-contrast-review-after-final-hud-2026-06-26`
- `oceangame://debug-telemetry-hidden-state-sanity-review-2026-06-26`
- `oceangame://shallow-midwater-background-art-pass-constraints-2026-06-26`
- `oceangame://shallow-midwater-background-study-wiring-2026-06-26`
- `oceangame://shallow-midwater-background-readability-review-2026-06-26`
- `oceangame://next-source-art-after-background-review-2026-06-26`
- `oceangame://pressure-wreck-cache-source-art-shell-constraints-v2-2026-06-26`
- `oceangame://pressure-wreck-cache-shell-normal-scale-review-2026-06-26`
- `oceangame://lower-route-recheck-after-pressure-shell-2026-06-26`
- `oceangame://lower-route-recheck-after-background-study-2026-06-26`
- `oceangame://source-art-provenance-checklist-2026-06-26`
- `oceangame://pressure-shell-provenance-checklist-review-2026-06-26`
- `oceangame://compact-hud-final-polish-plan-2026-06-26`
- `oceangame://compact-hud-final-normal-scale-review-2026-06-26`
- `oceangame://active-hud-low-oxygen-review-after-prompt-tune-2026-06-26`
- `oceangame://upgrade-bay-normal-scale-affordance-review-after-copy-tune-2026-06-26`
- `oceangame://scanner-feedback-signal-vs-echo-review-2026-06-26`
- `oceangame://next-monster-research-readability-milestone-2026-06-26`
- `oceangame://decoy-pulse-hud-predator-review-after-hud-polish-2026-06-26`
- `oceangame://gulper-timing-result-clarity-review-2026-06-26`
- `oceangame://durable-progression-reset-onboarding-review-2026-06-26`
- `oceangame://upgrade-bay-selection-affordance-review-2026-06-26`
- `oceangame://wreck-shelf-echo-lens-route-review-2026-06-26`
- `oceangame://wreck-echo-readiness-gate-after-shell-hud-2026-06-26`
- `oceangame://wreck-echo-reward-choice-2026-06-26`
- `oceangame://wreck-echo-source-art-fallback-balance-review-2026-06-26`
- `oceangame://lower-route-recheck-after-wreck-echo-source-art-2026-06-26`
- `oceangame://resource-scan-affordance-review-after-wreck-echo-2026-06-26`
- `oceangame://result-upgrade-copy-review-after-wreck-echo-2026-06-26`
- `oceangame://vertical-slice-art-kit-screenshot-checklist-2026-06-26`
- `oceangame://resource-scan-affordance-review-after-pressure-shell-2026-06-26`
- `oceangame://resource-scan-source-art-target-decision-2026-06-26`
- `oceangame://resource-economy-tuning-i`
- `oceangame://expedition-day-five-seed-review-findings-2026-06-26`
- `oceangame://backlog-replenishment-playable-loop-polish-2026-06-26`
- `oceangame://backlog-replenishment-after-playable-loop-polish-2026-06-26`
- `oceangame://backlog-replenishment-after-playable-loop-closeout-2026-06-26`
- `oceangame://backlog-replenishment-vertical-slice-readability-2026-06-26`
- `oceangame://backlog-replenishment-after-vertical-slice-readability-2026-06-26`
- `oceangame://backlog-replenishment-after-vertical-slice-closeout-2026-06-26`
- `oceangame://backlog-replenishment-wreck-echo-prep-review-2026-06-26`
- `oceangame://backlog-replenishment-after-platform-input-guardrail-2026-06-26`
- `oceangame://playwright-screenshot-workflow-gap-review-2026-06-26`
- `oceangame://backlog-replenishment-after-visual-clarity-2026-06-26`
- `oceangame://thermal-vent-route-review-2026-06-25`
- `oceangame://backlog-replenishment-thermal-vent-decoy`
- `oceangame://backlog-replenishment-visual-clarity-foundation-2026-06-26`
- `oceangame://backlog-replenishment-after-shell-reef`
- `oceangame://backlog-replenishment-2026-06-25`

Run the local self-test from the repository root:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
```

If `node` is not on `PATH`, use the Codex bundled Node executable:

```powershell
& "C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe" .mcp/oceangame-context-server.mjs --self-test
```

To connect an MCP client, copy `.mcp/oceangame-context.example.json` into the client's MCP configuration and replace `C:/path/to/OceanGame` with the local repository path. Keep this repository copy portable; do not commit user-specific absolute paths, tokens, or local client state.
