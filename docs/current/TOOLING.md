# Current Tooling

This file describes implemented repository tooling and agent workflow support.

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
- `oceangame://project-status`
- `oceangame://core-loop`
- `oceangame://seeded-expeditions`
- `oceangame://game-vision`
- `oceangame://progression-ladder`
- `oceangame://predator-direction`
- `oceangame://blind-validation-kit`
- `oceangame://scanner-improvement-i`
- `oceangame://cargo-improvement-i`
- `oceangame://burst-thruster`

Run the local self-test from the repository root:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
```

If `node` is not on `PATH`, use the Codex bundled Node executable:

```powershell
& "C:\Users\pirat\.cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe" .mcp/oceangame-context-server.mjs --self-test
```

To connect an MCP client, copy `.mcp/oceangame-context.example.json` into the client's MCP configuration and replace `C:/path/to/OceanGame` with the local repository path. Keep this repository copy portable; do not commit user-specific absolute paths, tokens, or local client state.
