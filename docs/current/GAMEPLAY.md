# Current Gameplay

This file describes implemented behavior. If gameplay, controls, runtime, deployment, or workflow changes, update this file before closing the related issue.

Near-term work is tracked in `docs/current/ROADMAP.md` and GitHub Issues.

## Product Behavior

- The project launches into a side-view vertical ocean slice with a placeholder controllable submersible.
- The selected direction is a 2D underwater roguelite where each dive is an expedition into alien ocean biomes.
- Intended first loop: dive from a safe base, gather resources, scan lifeforms, avoid or hunt predators, return before oxygen runs out, and craft upgrades that allow deeper future dives.
- Current controls: move with WASD or arrow keys.
- Extraction controls: return to the safe base and press E or Enter to end the dive successfully.
- Test reset: press R after extraction or oxygen failure to restart the prototype dive.
- Input is routed through Godot actions: `move_left`, `move_right`, `move_up`, `move_down`, `interact`, `restart_dive`, and reserved `scan`.
- Current movement uses acceleration, drag, and a bounded vertical dive area so the placeholder submersible cannot leave the prototype space.
- The first scene starts the player at a visible surface boat/shallow lab base near the top of the water column.
- The camera follows the player through a vertical descent with limits that keep the side-view dive space readable.
- Oxygen drains during an active dive. Extracting before oxygen reaches zero succeeds; reaching zero shows a placeholder failure result with cargo loss text.
- Current-dive state lives in `DiveSession`: oxygen, cargo, has-left-base, current depth, and dive result.
- Session progression lives in `ProgressionState`: banked resources, purchased upgrades, scan discoveries, and best depth reached.
- Extraction only succeeds after the player has left the base and returned.

## Runtime / Setup

- Engine: Godot 4.7 with GDScript.
- Primary target: local desktop.
- Secondary target: optional web demo. The project uses Godot's Compatibility renderer so web export remains plausible; avoid Godot C# unless the web target is intentionally abandoned.
- Launch locally from the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64.exe" --path .
```

- Headless launch smoke from the repository root:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

- Source layout:
  - `project.godot`: Godot project configuration.
  - `scenes/Main.tscn`: first scene.
  - `scenes/Player.tscn`: placeholder submersible scene.
  - `scripts/main.gd`: prototype dive state, safe base detection, and extraction result.
  - `scripts/dive_session.gd`: current-dive oxygen, cargo, depth, extraction, and failure state.
  - `scripts/progression_state.gd`: session-persistent resources, upgrades, discoveries, and best depth.
  - `scripts/player.gd`: basic placeholder player movement.
  - `scripts/resource_definition.gd`: typed resource data definition for upcoming pickup/resource work.
- GitHub Actions:
  - `.github/workflows/godot-smoke.yml`: runs a Godot headless launch smoke check and `git diff --check`.
- Do not commit `.godot/`, `.import/`, `*.import`, local editor cache, build output, secrets, or export artifacts.

## Verification

Preferred checks:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
git diff --check
```

Manual smoke:

- Launch the project and confirm the first scene runs.
- Move the placeholder submersible with WASD or arrow keys and confirm it accelerates, slows under drag, turns toward velocity, dives downward from the surface, and stays inside the test bounds.
- Return to the safe base, press E or Enter, and confirm the HUD shows a successful extraction result.
- Confirm immediate extraction at the starting base does not succeed until the player leaves and returns.
- Confirm oxygen decreases during the active dive.
- Let oxygen reach zero and confirm the HUD shows a failure result.
- After first dive loop: start a dive, collect or scan something, return to base, and confirm the result is recorded.
