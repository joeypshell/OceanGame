# GitHub Issue Workflow

Use GitHub Issues as the execution backlog for meaningful work. Keep the process light: tiny cleanups do not need tickets.

## Rolling Backlog Target

Keep about 10 open actionable issues available for Codex work.

Create more issues when:

- the open queue falls below the target after issue resolution,
- a milestone completes and the roadmap needs the next batch,
- planning docs identify enough scoped work to support more implementation,
- the user asks to stock the backlog.

Do not create more issues when:

- the direction is unclear and needs planning first,
- the issue would be a vague epic rather than a finishable task,
- the scope duplicates an existing issue,
- the work is intentionally deferred by the roadmap,
- the issue would require systems the current milestone explicitly excludes.

Each backlog issue should be small enough for one agent pass, linked to current or planning docs, and include verification steps. If there are not enough good issues, update the roadmap or write a planning note before creating more.

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
- For milestone, Area 01 source-map, visual-truth, or capture-state changes, use `docs/current/SOURCE_OF_TRUTH_GUARDRAIL.md` before closing the issue.

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
- `docs/current/SOURCE_OF_TRUTH_GUARDRAIL.md`

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
