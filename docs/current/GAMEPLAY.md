# Current Gameplay

This file describes implemented behavior. If gameplay, controls, runtime, deployment, or workflow changes, update this file before closing the related issue.

Near-term work is tracked in `docs/current/ROADMAP.md` and GitHub Issues.

## Product Behavior

- The project launches into a minimal Godot scene with a placeholder controllable submersible.
- The selected direction is a 2D underwater roguelite where each dive is an expedition into alien ocean biomes.
- Intended first loop: dive from a safe base, gather resources, scan lifeforms, avoid or hunt predators, return before oxygen runs out, and craft upgrades that allow deeper future dives.
- Current controls: move with WASD or arrow keys.
- Extraction controls: return to the safe base and press E or Enter to end the dive successfully.
- Current movement uses acceleration, drag, and a bounded test area so the placeholder submersible cannot leave the prototype space.
- The first scene has a visible safe base/extraction area on the left side of the test space.

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
  - `scripts/player.gd`: basic placeholder player movement.
- Do not commit `.godot/`, `.import/`, `*.import`, local editor cache, build output, secrets, or export artifacts.

## Verification

Preferred checks:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
git diff --check
```

Manual smoke:

- Launch the project and confirm the first scene runs.
- Move the placeholder submersible with WASD or arrow keys and confirm it accelerates, slows under drag, turns toward velocity, and stays inside the test bounds.
- Return to the safe base, press E or Enter, and confirm the HUD shows a successful extraction result.
- After first dive loop: start a dive, collect or scan something, return to base, and confirm the result is recorded.
