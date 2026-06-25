# AGENTS.md

## Project Posture

This is an AI-assisted game project. Treat this file as the living operating guide for Codex and other coding agents working in this repository.

Keep guidance practical and compact. Add rules only when they prevent repeated mistakes or preserve workflow future agents need.

## Repository Shape

- Source: not selected yet; record the engine and source layout here after the first playable prototype is scaffolded.
- Tests: not selected yet; record automated checks here once the runtime exists.
- Runtime/config: engine and project files after scaffold.
- GitHub Actions: `.github/workflows/` when CI is added.
- Current-state docs: `docs/current/`
- Planning docs: `docs/planning/`
- Archived plans/notes: `docs/archive/`
- Agent workflow docs: `docs/GITHUB_ISSUE_WORKFLOW.md`, `docs/AGENT_HANDOFF_TEMPLATE.md`
- Generated files not to commit: engine imports, cache folders, build output, local editor state, secrets, and platform export artifacts.

## Source-of-Truth Rules

- `docs/current/` describes implemented behavior.
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
git diff --check
```

Documentation-only checks:

```powershell
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
