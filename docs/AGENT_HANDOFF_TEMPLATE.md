# Agent Handoff Template

Use this template when a future Codex agent needs more startup context than fits comfortably in a GitHub issue. Do not create handoff docs for every tiny task.

```markdown
# <Task Name> Agent Handoff

## Issue Link or Task ID

<GitHub issue URL or number>

## Goal

<One-sentence outcome.>

## Context

<Brief project context needed to avoid rediscovery.>

## Files / Docs To Read First

- `AGENTS.md`
- `<GitHub issue>`
- `docs/current/ROADMAP.md`
- `docs/current/GAMEPLAY.md`
- `<specific source paths>`

## Constraints

- Keep scope to the issue.
- Do not commit generated files or build output.
- Preserve current behavior unless the issue says otherwise.

## Expected Implementation Areas

- `<path>`
- `<path>`
- `docs/current/GAMEPLAY.md` if accepted behavior changes
- `docs/current/ROADMAP.md` if priority or scope changes

## Verification Commands

```powershell
<test or verify command>
```

## Definition of Done

- Acceptance criteria are met.
- Verification results are recorded.
- `docs/current/` is updated if accepted behavior changed.
- Git status is clean or only expected ignored/generated files remain.

## What Not To Change

- <Explicitly out-of-scope files or behavior.>
```
