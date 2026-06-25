# GitHub Issue Workflow

Use GitHub Issues as the execution backlog for meaningful work. Keep the process light: tiny cleanups do not need tickets.

## When To Create An Issue

Create or select an issue before starting:

- new user-visible gameplay features
- user-visible bugs
- runtime, engine, export, or deployment changes
- workflow or documentation changes meant to guide future agents
- refactors that change maintainability risk

Do not require an issue for:

- typo fixes
- tiny formatting edits
- local experiments that will not be committed
- small follow-up edits already covered by an active issue

## Agent Rules

- Treat the issue as the active task contract.
- Read `AGENTS.md`, linked docs, and nearby code before editing.
- Keep scope tight. If new work appears, create or request a linked follow-up issue.
- Record durable decisions, blockers, commit hashes, and verification results in issue comments.
- Update `docs/current/` when accepted gameplay, runtime, architecture, testing, or workflow changes.

## Issue Template

```markdown
## Summary

<One or two sentences describing the task.>

## User Story or Problem Statement

As a <player/developer/reviewer>, I want <capability/fix>, so that <outcome>.

## Acceptance Criteria

- [ ] <Observable result>
- [ ] <Observable result>
- [ ] Existing behavior that must not regress: <behavior>

## Relevant Docs

- `AGENTS.md`
- `docs/current/ROADMAP.md`
- `docs/current/GAMEPLAY.md`

## Relevant Code Areas

- `<path>`
- `<path>`

## Dependencies / Blockers

- None, or list issue/doc/decision blockers.

## Implementation Notes

- Keep the first slice small.
- Prefer existing project patterns.
- Do not commit generated output.

## Verification Steps

- [ ] Run `<command>`.
- [ ] Manual smoke: <specific check>.

## Follow-up Work

- <Optional linked future issue ideas.>
```
