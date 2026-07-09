# Godot MCP Tooling

This file records the current decision for Godot editor MCP tooling in OceanGame.

## Decision

Track the evaluated `hi-godot/godot-ai` 2.7.6 snapshot under `addons/godot_ai/` as optional editor tooling for scene-aware Codex work. It is not a gameplay or release runtime dependency.

Godot AI MCP is useful when an issue benefits from a live Godot editor view, such as scene tree inspection, node property checks, screenshots, UI/layout debugging, material setup, signal wiring, project setting inspection, or editor-visible validation. It does not replace GitHub Issues, current docs, deterministic checks, or manual smoke testing as the project workflow.

## Distinction From OceanGame Context MCP

OceanGame now has two different MCP-related tools:

| Tool | Location | Purpose | Godot Plugin? | Commit To Repo? |
| --- | --- | --- | --- | --- |
| OceanGame context MCP | `.mcp/oceangame-context-server.mjs` | Read-only access to OceanGame docs as MCP resources | No | Yes, already committed |
| Godot AI MCP | `addons/godot_ai/` | Live Godot editor inspection and editor-assist tools | Yes | Yes, pinned editor-tool snapshot |

The repo-local OceanGame context MCP helps agents read project docs. Godot AI MCP helps agents inspect or interact with a running Godot editor. They are complementary, not replacements for each other.

## Evaluated Tool

- Tool: Godot AI
- Source: https://github.com/hi-godot/godot-ai
- Godot Asset Library page: https://godotengine.org/asset-library/asset/5050
- Reported requirements: Godot 4.3+ with Godot 4.7+ recommended, `uv`, and an MCP-compatible client.
- Reported Codex MCP endpoint: `http://127.0.0.1:8000/mcp`

Godot AI advertises MCP tools for live scene, node, script, UI, material, animation, particle, camera, input map, project setting, screenshot, and test workflows. That is a good fit for OceanGame because near-term work includes scene readability, UI clarity, Godot scene inspection, and visual iteration.

## Repository Policy

- Treat Godot AI MCP as an optional local editor-assist tool, not a required runtime dependency.
- Keep addon upgrades issue-scoped and preserve its tracked license and version metadata.
- Keep the `_mcp_game_helper` autoload pointed at `scripts/debug/godot_ai_game_helper_loader.gd`. The loader starts the real addon helper only when an editor debugger is active, so standalone/headless/Web builds do not load editor-only code.
- Keep `addons/**` excluded from release exports.
- Do not commit local MCP client configs, Godot AI cache files, generated plugin state, secrets, local editor state, or user-specific paths.
- Keep work issue-driven. Agents must still read the GitHub issue, `AGENTS.md`, current docs, and linked planning docs before editing.
- If Godot AI MCP is available, agents may use it to inspect scenes and verify editor state before changing `.tscn` files.
- If Godot AI MCP is not available, agents should continue with normal text-based scene/script edits and document that limitation when relevant.
- Durable lessons from using Godot AI MCP should be promoted into `AGENTS.md` only if they prevent repeated future mistakes.

## Local Setup Notes

These are local-machine steps, not repository setup steps:

1. Install `uv` if needed.
2. Open the OceanGame checkout in Godot; the evaluated addon snapshot is already present.
3. Enable the plugin in Godot: Project Settings -> Plugins -> Godot AI.
4. Keep the Godot editor open with OceanGame loaded when using the MCP server.
5. Open the Godot AI dock and configure Codex, or add this to `~/.codex/config.toml`:

```toml
[mcp_servers."godot-ai"]
url = "http://127.0.0.1:8000/mcp"
enabled = true
```

6. If telemetry is not desired, set `GODOT_AI_DISABLE_TELEMETRY=true` or `DISABLE_TELEMETRY=true` in the local environment before running the tool.

## Good Uses

- Inspect the current scene hierarchy before editing a scene file.
- Check node positions, sizes, visibility, collision shapes, anchors, groups, and signal wiring.
- Capture screenshots during UI, readability, or layout work.
- Validate editor-visible scene or script errors after changing `.tscn` or `.gd` files.
- Compare selected nodes against visual-language rules during scene-heavy readability tasks.
- Explore scene-heavy issues where text diffs alone are slow or risky.

## Poor Uses

- Replacing GitHub Issues as the task contract.
- Making broad scene rewrites without a focused issue.
- Updating the tracked addon snapshot or its integration path without a focused issue and release/editor verification.
- Treating the tool as a substitute for deterministic logic tests, Godot headless launch, `git diff --check`, or manual smoke checks.
- Using editor automation to add mechanics that are out of scope for the current milestone.
- Storing secrets, tokens, local paths, cache files, or generated plugin state in the repository.

## Current Status

Adopted as tracked optional editor tooling. Local MCP client configuration is still machine-specific. Release exports keep the addon excluded and use the debugger-aware loader autoload, while editor-launched play dynamically loads the real helper for capture and evaluation tools.
