---
name: godot-oceangame
description: Work on OceanGame's Godot 4.7 project structure, scenes, nodes, GDScript, input map, resources, tests, and optional Godot AI MCP workflow. Use when editing Godot scene files, scripts, project settings, resources, or editor-driven structure.
---

# Godot OceanGame

## Load First

Read:

- `AGENTS.md`
- `docs/current/ARCHITECTURE.md`
- `docs/current/GAMEPLAY.md`
- `docs/current/GODOT_MCP.md` when editor/MCP interaction is relevant.

## Project Facts

- Engine: Godot 4.7.
- Language: GDScript.
- First scene: `scenes/Main.tscn`.
- Player scene: `scenes/Player.tscn`.
- Main orchestration: `scripts/main.gd`.
- Reusable state/helpers live in `scripts/*.gd`.
- Logic tests live in `tests/logic_tests.gd`.
- Godot input should route through semantic actions, not direct key checks for gameplay behavior.

## Scene And Script Rules

- Preserve node ownership boundaries from `docs/current/ARCHITECTURE.md`.
- Keep gameplay state out of visual-only nodes.
- Use authored scene data for route and placement definitions where possible.
- Avoid editing generated/import cache files.
- When scene edits are mechanical and large, inspect diffs carefully before finalizing.
- If using Godot AI MCP, connect to the active editor session first and verify writes succeed; otherwise edit files directly and validate with headless launch.

## Verification

After Godot scene, script, resource, or project setting edits, run:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
```

For state/helper/gameplay logic:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
```

Run `npm run test:visual` when scene or UI changes could affect browser/export readability.

## Close-Out

State whether changes were file-based or editor/MCP-based, then report validation.
