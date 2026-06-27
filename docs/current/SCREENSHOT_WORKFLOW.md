# Screenshot Workflow

Use this workflow when a visual-readability issue needs comparable evidence. Screenshots are review artifacts, not committed source files, unless an issue explicitly asks for committed reference images.

## What To Record

For each screenshot or short capture note, record:

- build or commit hash,
- viewport size,
- screenshot path,
- expedition number,
- seed,
- condition,
- cluster pattern,
- view state: surface ready, active dive, result, or failure,
- focused route or landmark,
- immediate confusion or pass/fail observation.

Use `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md` for the full readability review template. Use `docs/planning/SOLO_FIRST_RUN_READABILITY_CHECKLIST_2026_06_26.md` when no outside helpers are available and the review specifically concerns first-run readability. Use `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_CHECKLIST_2026_06_26.md` when the review specifically concerns expedition-day framing across F5-driven seeds.

Use `docs/planning/WRECK_ECHO_NORMAL_SCALE_SCREENSHOT_CHECKLIST_2026_06_26.md` when the implemented first Wreck Echo pocket or any future Wreck Echo visual change needs route-readability evidence for surface prep, lower-route approach, pressure/cache context, Echo Lens cue, predator relationship, low oxygen, and result readback.

## Naming Convention

Use lowercase descriptive names with date and state:

```text
oceangame_<view>_<focus>_<condition-or-seed>_<yyyy_mm_dd>.png
```

Examples:

```text
oceangame_surface_ready_thermal_bloom_2026_06_26.png
oceangame_active_lower_route_seed_8920_2026_06_26.png
oceangame_result_upgrade_prompt_2026_06_26.png
```

Local screenshots can live outside the repo, such as Godot user data or a temp folder. In review docs, reference the absolute path used for the review.

## Vertical-Slice Acceptance Evidence Names

For playable vertical-slice acceptance evidence, use the checklist in `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md` and include date, seed or review state, view, condition, and a short pass/fail note in the filename:

```text
oceangame_acceptance_<yyyy_mm_dd>_<seed-or-review-state>_<view>_<condition>_<pass-or-fail-note>.png
```

Examples:

```text
oceangame_acceptance_2026_06_26_seed_8919_surface_ready_kelpbloom_pass.png
oceangame_acceptance_2026_06_26_clean_save_active_dive_calmcurrent_fail_discoveries_overlap.png
oceangame_acceptance_2026_06_26_seed_24757_pressure_gate_raresignal_pass_watchlist.png
oceangame_acceptance_2026_06_26_post_extract_upgrade_tab_thermalbloom_fail_text_overflow.png
```

Use short, stable view names such as `surface_ready`, `active_dive`, `low_oxygen`, `pressure_gate`, `predator_route`, `result`, `upgrade_tab`, or `expedition_log`.

Keep acceptance screenshots local unless an issue explicitly requests committed reference images. When writing the review note, record the local absolute path, commit hash, viewport size, seed/review state, condition, view, and pass/fail observation.

## Manual Capture

Use this when inspecting by hand:

1. Launch the project normally from the repository root:

   ```powershell
   & "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64.exe" --path .
   ```

2. Keep the default camera zoom and the intended test viewport.
3. Press F3 if you need debug telemetry for seed, condition, cluster pattern, or predator route.
4. With debug telemetry visible, press F4 to cycle conditions and F5 to advance the review seed.
5. Hide debug telemetry again with F3 before taking player-facing readability screenshots.
6. Use Windows screenshot tools or the Godot editor viewport capture, then record the file path and metadata in the review note.

## Surface And Active-Dive Views

For surface-ready screenshots:

- capture before pressing E or Enter,
- record the visible condition and goal line,
- confirm player-facing debug telemetry is hidden unless the screenshot is specifically a debug evidence shot.

For active-dive screenshots:

- press E or Enter to begin the dive,
- move the player/camera to the route under review,
- capture with only the active operational HUD visible,
- include whether the view is testing cargo, scan target, lock, reward, danger, safe return, or mystery/future promise.

## Temporary Script Capture

Use a temporary Godot script outside the repo when a repeatable camera position is useful but no committed capture tool is needed.

Example:

```powershell
$script = @'
extends SceneTree

func _initialize() -> void:
	var scene := load("res://scenes/Main.tscn") as PackedScene
	var root := scene.instantiate()
	root.show_debug_telemetry = false
	get_root().add_child(root)
	get_root().size = Vector2i(1365, 768)
	await process_frame
	await process_frame
	root.call("_start_dive")
	var player := root.get_node_or_null("Player") as Node2D
	if player != null:
		player.global_position = Vector2(980, 1660)
	await process_frame
	await process_frame
	var path := "user://oceangame_active_lower_route_seed_review.png"
	var err := get_root().get_texture().get_image().save_png(path)
	print("screenshot=", ProjectSettings.globalize_path(path), " err=", err)
	quit(0 if err == OK else 1)
'@
$temp = Join-Path $env:TEMP "oceangame_capture.gd"
Set-Content -LiteralPath $temp -Value $script -Encoding UTF8
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --script $temp
```

This is appropriate for issue notes and planning reviews. Do not commit the temporary script or generated screenshots unless the issue explicitly asks for reference assets.

## Playwright Web Capture

Use Playwright when a visual smoke pass should be repeatable in the exported browser build rather than driven by hand or by temporary Godot scripts. The harness exports the Web build, serves it with Godot-compatible cross-origin isolation headers, resets the local prototype save, drives deterministic keyboard scenarios, and writes named screenshots as local test artifacts.

Setup once:

```powershell
npm install
npm run playwright:install
```

Run export plus smoke screenshots:

```powershell
npm run test:visual
```

Run against an already-exported build:

```powershell
npm run test:visual:existing
```

Default captures include:

- `surface-ready.png`
- `active-dive.png`
- `extraction-result.png`
- `upgrade-tab.png`
- `lower-route-pressure-gate.png`
- `expanded-east-shelf-route-staged.png`
- `east-shelf-pocket-ping-staged.png`
- `lower-connector-staged.png`
- `active-low-oxygen.png`
- `active-critical-oxygen.png`
- `wreck-echo-route-staged.png`
- `wreck-echo-result-readback.png`
- `wreck-echo-result-player-facing.png`

The screenshots live under `test-results/playwright/` with Playwright traces/reports in ignored local artifact folders. Each `.png` has a same-name `.json` metadata sidecar recording the expected state, the exported game's reported visual state, and viewport size. Use this flow for repeated HUD/layout/route-readability checks. The expanded East Shelf and lower-connector captures use the Web debug-command bridge to stage the side-route, pocket-ping, and Shelf Drop Connector views without long keyboard traversal. The Wreck Echo screenshots use the debug-gated F6 staging hook after F3 telemetry is enabled, so they are route/result visual evidence rather than gameplay-traversal proof. The `wreck-echo-result-player-facing.png` capture hides telemetry after staging so reviewers can inspect the player-facing result panel without debug text. Use Godot headless logic tests for state ownership, economy, progression, scan rules, pressure rules, predator behavior, and other deterministic gameplay assertions.

Current workflow gap review: `docs/planning/PLAYWRIGHT_SCREENSHOT_WORKFLOW_GAP_REVIEW_2026_06_26.md`.

Current hardening status:

- `extraction-result.png` and `upgrade-tab.png` now follow a leave-base, return, extract, then open-upgrade-tab flow. Reviewers should still confirm the image actually shows the named surface state before relying on it.
- Playwright now fails before capture if the exported game reports the wrong visual state for the screenshot name, such as an active dive under `extraction-result.png`, a non-critical state under `active-critical-oxygen.png`, the wrong route stage under `expanded-east-shelf-route-staged.png` or `lower-connector-staged.png`, or a missing pocket ping under `east-shelf-pocket-ping-staged.png`.
- Wreck Echo route/result screenshots still use the F6 review hook. Treat them as route/result layout evidence, not normal gameplay-traversal proof.
- The no-debug Wreck Echo result panel is automated as `wreck-echo-result-player-facing.png`, but it is still staged before telemetry is hidden.
- Future controller/touch prompt states are not fully automated yet.

## Mobile-Like Landscape Capture

Use the mobile-like Playwright smoke when reviewing future iPhone/phone landscape safe-area risk before touch controls exist. This is evidence-only: it does not implement touch UI, mobile export settings, controller support, or device automation.

Run export plus mobile-like landscape smoke:

```powershell
npm run test:visual:mobile-like
```

Run against an already-exported build:

```powershell
npm run test:visual:mobile-like:existing
```

The scaffold uses a `960x540` viewport with device scale factor `2` and writes local artifacts under `test-results/playwright-mobile-like/`. Current captures include:

- `mobile-like-surface-ready.png`
- `mobile-like-active-dive.png`
- `mobile-like-lower-route-pressure-gate.png`
- `mobile-like-active-low-oxygen.png`
- `mobile-like-active-critical-oxygen.png`
- `mobile-like-wreck-echo-route-staged.png`
- `mobile-like-wreck-echo-result-readback.png`
- `mobile-like-wreck-echo-result-player-facing.png`

Use this workflow to inspect whether the active HUD, warning panel, surface panel, player, lower-route pressure/cache cluster, and future virtual-control safe zones remain plausible at a phone-like landscape width. Passing this smoke does not mean mobile support is complete; it only provides repeatable evidence before future touch-control planning.

## Optional Godot AI MCP Capture

If the local `hi-godot/godot-ai` plugin is installed, enabled in Godot, and its MCP server is running, it may be used for live editor screenshots and scene inspection. This repository does not vendor that plugin and does not require it for normal verification.

When using Godot AI MCP, record:

- plugin/server was active,
- whether the capture came from the editor viewport or running game,
- seed/condition/cluster metadata from debug telemetry if relevant,
- screenshot path or attachment id.

If Godot AI MCP is not active, use manual capture or the temporary script workflow instead.

## Verification Expectations

Screenshot workflow changes are documentation/tooling changes. Run:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
```
