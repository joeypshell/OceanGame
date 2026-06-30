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

The project also has a no-screenshot lower-route scripted smoke for cheap regression checks of the current long route chain. Run `npm run test:lower-route-smoke` to export Web and assert the route stages, or `npm run test:lower-route-smoke:existing` against an already-exported build. It verifies hidden-telemetry F6 staging stays inert, then uses the existing Web debug-command bridge to stage Blackwater, Dusk Trench, Hollow Reef entrance, Hollow Reef return/recovered, Wide Reef Chamber, and opened Wide Reef salvage-pocket states. Treat this as a fast route-staging regression check that complements Godot logic tests and screenshot review; it does not replace gameplay tests or make the debug bridge gameplay truth.

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
npm run test:area01-shell-captures
npm run test:area01-shell-captures:existing
npm run test:visual:mobile-like
npm run test:visual:mobile-like:existing
```

The Web export preset writes to `exports/web/index.html`. The Playwright server serves that folder with the cross-origin isolation headers Godot Web builds need. Screenshots, traces, and reports are local artifacts under `test-results/` and `playwright-report/`; do not commit them unless a future issue explicitly asks for reference images.

Current desktop scenarios capture surface ready, active dive, extraction result, upgrade tab, lower-route pressure-gate, staged expanded East Shelf route, staged East Shelf signal-core payoff, staged lower connector, staged Blue Chimney, staged Silt Vein, staged Blackwater, staged Dusk Trench route/payoff states, staged Hollow Reef entrance/payoff/return states, staged Outer Shelf survey/Glass Rim context, active low oxygen, active critical oxygen, staged Wreck Echo route, staged Wreck Echo result-readback, and no-debug Wreck Echo result player-facing views. The no-screenshot lower-route smoke asserts the same Blackwater/Dusk/Hollow/Wide Reef Chamber route chain plus opened salvage-pocket state cheaply without writing screenshot artifacts unless Playwright fails. The test resets the prototype save with the existing F9 debug hook before capture so runs start from a deterministic first-expedition state. The extraction/upgrade path now leaves base, returns to the moonpool, extracts, and opens the upgrade tab before capturing those named states; reviewers should still confirm the screenshot content when using artifacts as evidence. The exported Web build publishes a small `window.__oceangameVisualState` object so Playwright can assert result state, surface tab, debug telemetry visibility, oxygen state, route stage, East Shelf signal-core recovery state, lower-connector echo state, Dusk reach/payoff state, Hollow Reef reading state, Outer Shelf survey state, salvage-pocket open state, and panel visibility before each screenshot or no-screenshot route smoke. Each screenshot also gets a same-name `.json` metadata sidecar in `test-results/playwright/`. `docs/planning/PLAYWRIGHT_SCREENSHOT_WORKFLOW_GAP_REVIEW_2026_06_26.md` records remaining hardening targets. The low/critical oxygen, expanded East Shelf, lower connector, Dusk Trench, Hollow Reef, Wide Reef Chamber, opened salvage-pocket, and Outer Shelf paths use the `window.__oceangameDebugCommand` Web bridge so captures and the lower-route smoke do not spend time waiting on oxygen drain, long route traversal, or browser function-key delivery. The Wreck Echo smoke path enables debug telemetry and uses the F6 review hook to stage route/result screenshots, then hides telemetry for the player-facing result capture; this is visual layout evidence, not a replacement for Godot logic tests or manual gameplay validation.

The optional mobile-like landscape smoke uses a separate Playwright config at `tests/playwright/mobile-landscape.config.mjs`. It captures surface ready, active dive, lower-route pressure-gate, active low oxygen, active critical oxygen, staged Wreck Echo route, staged Wreck Echo result-readback, and no-debug Wreck Echo result player-facing views at `960x540` with device scale factor `2`, storing local artifacts under `test-results/playwright-mobile-like/`. This is safe-area evidence for future phone landscape work, not touch-control implementation or mobile support certification.

The Area 01 shell capture harness uses `tests/playwright/area01-capture-manifest.json` as its capture source of truth. Run `npm run test:area01-shell-captures` when Area 01 terrain, collision, cue ownership, or camera staging changes. It captures the current first-room shell states plus the developer-only source-map overlay and writes `area01-shell-capture-evidence.json` and `.md` beside the screenshots under `test-results/playwright-area01-shell/`. The report includes capture IDs, source-map revision, cue-family diagnostic counts/warnings from `window.__oceangameVisualState`, validation status for the capture assertions, change signatures for source-map/runtime/harness/docs files, a `visual_truth_gate_summary`, and a manual review checklist. Treat those reports as review evidence, not golden-image infrastructure.

The Area 01 visual truth gate is intentionally stricter than state assertions. A passing Playwright run means the deterministic captures, metadata, player-visibility assertions, and report were generated; it does not mean the cave walls are visually accepted. Before closing Area 01 visual/map issues, open or attach the generated screenshots and check the report's `visual_truth_gate_summary`. If `automated_gate_passed` is false, or if `blocker_signals` names cue warnings or missing expected cue families, do not close the visual/map issue until the blocker is resolved or explicitly carried by a follow-up issue. The manual review must also confirm that cave walls read as natural terrain rather than debug outlines, terrain fill/texture covers central and right-side walls, solid terrain separates from playable water, scan targets/resources are visually identifiable near prompts, and horizontal banding or flat placeholder polygons are absent from primary cave views.

## GitHub Pages Web Demo

The project has a GitHub Actions deployment workflow at `.github/workflows/deploy-github-pages.yml`. It runs on pushes to the current default project branch, `codex/setup-agentic-workflow`, and can also be started manually from the Actions tab.

Deployment flow:

1. Set up Godot 4.7.
2. Launch the project headlessly.
3. Run deterministic logic tests.
4. Export the `Web` preset to `exports/web/index.html`.
5. Upload `exports/web/` as a GitHub Pages artifact.
6. Deploy to GitHub Pages.

Expected tester URL after Pages is enabled and the first workflow succeeds:

```text
https://joeypshell.github.io/OceanGame/
```

Local preflight:

```powershell
npm run web:export
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
git diff --check
```

Do not commit `exports/`; the workflow generates the deployable web build from source.

## Tiered Verification Runner

Use `scripts/test.ps1` as the default validation dispatcher so Codex and humans can choose the cheapest useful test tier instead of running screenshot/export checks for every issue.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier visual
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier mobile-like
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier full
```

Tier guidance:

- `quick`: Godot headless launch, logic tests, Area 01 source truth validation, Area 01 placement validation, and `git diff --check`. Use for most gameplay/code changes.
- `docs`: MCP context self-test, Area 01 runtime source-map validation, Area 01 placement validation, and `git diff --check`. Use for docs, planning, and MCP resource changes.
- `visual`: desktop Playwright visual smoke against the existing export. Use after HUD, UI, camera, route, or art changes when the Web export already exists.
- `mobile-like`: mobile-like Playwright smoke against the existing export. Use only for mobile-like safe-area, HUD, panel, or route-layout questions.
- `full`: Godot checks, MCP self-test, Web export, desktop visual smoke, mobile-like visual smoke, and `git diff --check`. Reserve for milestone closeout, export/tooling changes, or major visual/camera route changes.

The runner prints compact step summaries and leaves detailed tool output to the underlying command only when needed. Prefer `quick` or `docs` unless the issue actually changes visual layout or export tooling.

Set `OCEANGAME_TEST_VERBOSE=1` before running a tier when you need the full underlying command output on success.

## Area 01 Source Truth Validation

Area 01 has a dedicated Godot-side source-truth validator for runtime terrain/collision/rim drift. It loads `docs/planning/maps/area_01_runtime_source_map_v3.json`, builds the same runtime terrain used by `Main.tscn`, and fails if generated visible terrain, `CollisionPolygon2D` blockers, rim/lip polygons, or source-owned `Area2D` hooks no longer match the source-map IDs and polygons.

Runtime v3 is playable-water-first: `tools/trace_area01_playable_water_from_source.py` extracts cave/corridor/pocket water from `area_01_surface_floor_source_map_v1.png`, `area_01_surface_floor_geometry_v1.json` supplies cave mouths and semantic hooks, and `tools/create_area01_runtime_source_map_v3.py` generates one continuous terrain domain plus collision-only solid partitions around those water shapes. Do not hand-edit generated `solid_terrain` partitions to fix map topology.

Run it directly from the repository root when changing Area 01 terrain, collision, cave entrances, resource/scan hooks, or source-map ownership:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --headless --path . --script res://tests/area01_source_truth_validation.gd
```

It is also part of the `quick` and `full` test tiers. Keep using the Node source-map validators for static JSON and authored placement checks; this Godot validator covers the instantiated runtime scene after the blockout builder runs.

For full-map topology review, refresh the side-by-side render after changing Area 01 source geometry:

```powershell
& "C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" .\tools\trace_area01_playable_water_from_source.py
& "C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" .\tools\create_area01_runtime_source_map_v3.py
& "C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" .\tools\render_area01_runtime_vs_source_comparison.py
node .\tools\validate-area01-runtime-source-map.mjs
node .\tools\validate-area01-runtime-placements.mjs
```

The renderer writes `docs/planning/maps/area_01_current_godot_runtime_map_2026_06_30.png`, `docs/planning/maps/area_01_runtime_vs_source_side_by_side_2026_06_30.png`, and matching JSON metadata. Treat those as topology evidence; Playwright captures remain camera-scale browser evidence.

## Area 01 Visual Cue Contract

Area 01 visual cue budgets are centralized in `scripts/area01_visual_cue_contract.gd`. The registry names the cue family, intended z-index band, alpha range, color family, label policy, and relative brightness rules for solid terrain, terrain rims/lips, passive atmosphere, return currents, timing/hazard support, resource pickups, knowledge payoffs, locked/future promises, active prompt/status labels, and debug/source-map overlays.

`scripts/area01_visual_director.gd` is the first small Area 01 presentation extraction from `main.gd`. It owns source-map overlay creation/sync and cue-family diagnostic reporting for visual evidence. It does not own durable progression, oxygen, cargo, route unlock truth, resource banking, or core gameplay rules; callers pass it current presentation state through a small API.

Generated source-map terrain and hooks are tagged with cue-family metadata by `Area01BlockoutBuilder`. Tests can call `Area01VisualCueContract.debug_report(root, camera_region)` to count visible nodes by cue family and warn when a review region has too many bright support cues competing for attention. This report is metadata-based; it does not replace screenshots or image analysis for final visual judgment.

During local Godot review, press F10 to show or hide the developer-only Area 01 readability overlay. The overlay also forces debug telemetry on so it stays out of normal play by default. It draws source-map lanes, collision truth, generated hooks, resource/scan markers, cue-family labels, and a compact screenshot summary with map revision, capture/camera state, cue-family counts, unread collision count, and untagged visible-cue count.

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
- `oceangame://source-of-truth-guardrail`
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
- `oceangame://player-action-prompt-abstraction-plan-2026-06-26`
- `oceangame://result-upgrade-active-copy-review-after-prompt-abstraction-2026-06-26`
- `oceangame://scanner-feedback-signal-vs-echo-review-2026-06-26`
- `oceangame://next-monster-research-readability-milestone-2026-06-26`
- `oceangame://monster-research-next-step-readiness-review-2026-06-26`
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
- `oceangame://lower-route-recheck-after-evidence-hardening-2026-06-26`
- `oceangame://next-source-art-after-evidence-hardening-2026-06-26`
- `oceangame://deep-reward-lure-fallback-balance-review-2026-06-26`
- `oceangame://active-hud-touch-safe-margin-review-2026-06-26`
- `oceangame://mobile-like-landscape-screenshot-scaffold-2026-06-26`
- `oceangame://mobile-like-lower-route-readability-review-2026-06-26`
- `oceangame://future-touch-safe-zone-constraints-from-mobile-evidence-2026-06-26`
- `oceangame://mobile-like-low-critical-oxygen-capture-coverage-2026-06-26`
- `oceangame://mobile-like-wreck-echo-route-result-review-2026-06-26`
- `oceangame://wreck-echo-no-locator-drift-review-after-prompt-screenshot-2026-06-26`
- `oceangame://upgrade-details-overflow-review-after-prompt-evidence-2026-06-26`
- `oceangame://compact-upgrade-details-fix-plan-2026-06-26`
- `oceangame://monster-research-ii-non-combat-behavior-evidence-2026-06-26`
- `oceangame://monster-research-ii-first-evidence-type-selection-2026-06-26`
- `oceangame://monster-research-ii-state-ownership-result-memory-2026-06-26`
- `oceangame://monster-research-ii-non-combat-guardrail-coverage-2026-06-26`
- `oceangame://gulper-decoy-result-clarity-after-monster-research-ii-2026-06-26`
- `oceangame://next-readability-target-after-deep-reward-lure-2026-06-26`
- `oceangame://lower-route-visual-pileup-review-after-deep-reward-wreck-echo-2026-06-26`
- `oceangame://cohesive-vertical-slice-art-kit-integration-plan-2026-06-26`
- `oceangame://playable-vertical-slice-acceptance-refresh-after-mobile-monster-art-2026-06-26`
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
- `oceangame://backlog-replenishment-after-wreck-echo-platform-input-2026-06-26`
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
