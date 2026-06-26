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
- `oceangame://compulsion-identity-2026-06-26`
- `oceangame://progression-ladder`
- `oceangame://predator-direction`
- `oceangame://blind-validation-kit`
- `oceangame://expedition-goal-ii`
- `oceangame://scanner-improvement-i`
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
- `oceangame://resource-economy-tuning-i`
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
