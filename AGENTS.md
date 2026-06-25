# AGENTS.md

## Project Posture

This is an AI-assisted game project. Treat this file as the living operating guide for Codex and other coding agents working in this repository.

Keep guidance practical and compact. Add rules only when they prevent repeated mistakes or preserve workflow future agents need.

## Repository Shape

- Source: Godot 4.7 project using GDScript; scenes live in `scenes/`, scripts live in `scripts/`.
- Tests: GitHub Actions runs a Godot headless launch smoke check, deterministic logic tests, and `git diff --check`; use documented manual smoke checks for gameplay issues.
- Runtime/config: `project.godot`, `icon.svg`, Godot scenes, and GDScript files.
- GitHub Actions: `.github/workflows/godot-smoke.yml`
- Current-state docs: `docs/current/`
- Planning docs: `docs/planning/`
- Archived plans/notes: `docs/archive/`
- Agent workflow docs: `docs/GITHUB_ISSUE_WORKFLOW.md`, `docs/AGENT_HANDOFF_TEMPLATE.md`
- MCP tooling: `.mcp/oceangame-context-server.mjs`, `.mcp/oceangame-context.example.json`, `docs/current/TOOLING.md`
- Generated files not to commit: `.godot/`, `.import/`, `*.import`, `builds/`, `exports/`, local editor state, secrets, and platform export artifacts.

## Source-of-Truth Rules

- `docs/current/` describes implemented behavior.
- `docs/current/TOOLING.md` describes implemented tooling and MCP support.
- `docs/planning/` contains proposals and feature plans that are not yet fully implemented.
- `docs/archive/` keeps old plans and decisions for reference.
- GitHub Issues are the active task contract once work is ticketed.
- If gameplay, runtime, deployment, testing, architecture, or workflow changes, update the matching current doc before closing the issue.

## Development Workflow

- Read the issue, linked docs, and nearby code before editing.
- Prefer existing project patterns over new abstractions.
- Keep changes scoped to the issue.
- If new work appears, create or request a follow-up issue instead of expanding the ticket.
- Do not revert unrelated user changes.
- Do not commit generated files, local caches, secrets, or build output.

## GitHub Issue Workflow

Use GitHub Issues for meaningful feature, bug, workflow, tooling, and demo work.

Maintain a rolling backlog of about 10 open actionable issues. When the queue drops well below that target, expand the roadmap or planning docs first, then create scoped issues from that plan. Do not pad the queue with vague epics, duplicate work, or intentionally deferred ideas.

Issues should include:

- summary or user story
- acceptance criteria
- relevant docs and code areas
- dependencies or blockers
- implementation notes
- verification steps

Record durable decisions, blockers, commit hashes, and verification results in issue comments.

## Feature Planning Workflow

For broad features, write a compact plan under `docs/planning/` before implementation. Split the plan into small issues that one agent can complete and verify. Use an integration branch only when multiple issues must be reviewed together before merging.

## Verification Commands

Primary verification:

```powershell
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --quit-after 1
& "C:\Program Files\Godot\Godot_v4.7-stable_windows_arm64_console.exe" --path . --headless --script res://tests/logic_tests.gd
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
```

CI verification:

```bash
godot --headless --path . --quit-after 1
godot --headless --path . --script res://tests/logic_tests.gd
git diff --check
```

Documentation-only checks:

```powershell
node .mcp/oceangame-context-server.mjs --self-test
git diff --check
git status --short
```

Manual smoke checks:

- After the engine scaffold exists, launch the project locally and confirm the first scene runs.
- For gameplay changes, confirm the affected loop works from a fresh run.

## Commit Hygiene

- Run `git status --short` before staging and before final response.
- Stage files explicitly.
- Keep commits small and issue-focused.
- Reference the issue number in commit messages when practical.
- PR descriptions should reference issues and include verification commands.

## Agent Learning Loop

When a bug or workflow takes real effort to understand, propose a short `AGENTS.md` update. Keep it specific enough that future agents will actually read it.
