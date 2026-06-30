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
- Current architecture: `docs/current/ARCHITECTURE.md`
- Planning docs: `docs/planning/`
- Archived plans/notes: `docs/archive/`
- Agent workflow docs: `docs/GITHUB_ISSUE_WORKFLOW.md`, `docs/AGENT_HANDOFF_TEMPLATE.md`
- MCP tooling: `.mcp/oceangame-context-server.mjs`, `.mcp/oceangame-context.example.json`, `docs/current/TOOLING.md`
- Generated files not to commit: `.godot/`, `.import/`, `*.import`, `builds/`, `exports/`, local editor state, secrets, and platform export artifacts.

## Source-of-Truth Rules

- `docs/current/` describes implemented behavior.
- `docs/current/TOOLING.md` describes implemented tooling and MCP support.
- `docs/current/AGENTIC_MAP_PIPELINE_PRACTICES.md` governs map, terrain, collision, and source-map work. For map topology, future agents must use a machine-readable map source -> deterministic converter/importer -> generated runtime geometry -> generated source/runtime/diff previews -> Godot builder/importer -> screenshot confirmation. Screenshots, concept art, and generated images may guide visual style, but they do not own collision, walls, routes, hooks, resources, gates, or playable water.
- `docs/planning/` contains proposals and feature plans that are not yet fully implemented.
- `docs/archive/` keeps old plans and decisions for reference.
- GitHub Issues are the active task contract once work is ticketed.
- If gameplay, runtime, deployment, testing, architecture, or workflow changes, update the matching current doc before closing the issue.
- Preserve state ownership: `DiveSession` owns temporary expedition state, `ProgressionState` owns durable progress, authored scene data owns inspectable route/content placement, and visual/readability assets communicate meaning without owning gameplay truth.

## Development Workflow

- Read the issue, linked docs, and nearby code before editing.
- Prefer existing project patterns over new abstractions.
- Keep changes scoped to the issue.
- For gameplay/backlog work, apply the roadmap north-star filter: the change should create curiosity, pressure, payoff, remembered-place progress, meaningful route choice, or a reason to try another expedition; otherwise treat it as tooling/polish and keep it proportional.
- For map/terrain work, do not visually interpret screenshots or hand-tune Godot polygons as topology fixes. Update the machine-readable source map or converter, regenerate runtime geometry and previews, then use Godot/Playwright screenshots only as final rendering confirmation.
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

## Main.gd Architecture Guardrail

`scripts/main.gd` is being decomposed into smaller modules. Do not add unrelated new responsibilities to `scripts/main.gd`.

When changing behavior currently touched by `main.gd`, consider whether the logic belongs in an extracted presenter, service, controller, helper, or state/model class.

Preferred direction:

- UI text, label formatting, warning copy, and compact HUD/status summaries belong in presenter/helper modules.
- Durable gameplay state belongs in state/model classes such as `DiveSession`, `ProgressionState`, and `SurvivalState`.
- Save/load coordination belongs in a save service.
- Route setup and route metadata helpers belong in route-focused services/helpers.
- Debug/dev staging belongs in debug-focused helpers.
- `main.gd` should primarily handle scene composition, node wiring, signal wiring, and high-level orchestration.

Do not create circular dependencies. Do not move code just for neatness. Every extraction must reduce complexity, clarify ownership, improve testability, or reduce future agent context load.

## Refactor Testing Guardrail

When extracting code from `scripts/main.gd`, agents must add or preserve tests for the extracted behavior.

- Prefer small, direct unit tests against the new module.
- Do not move logic into a new file without proving behavior is preserved through tests or clearly documenting why only smoke/manual verification is possible.
- Do not accept "manual tested only" for logic that can reasonably be unit-tested.
- Preserve existing behavior unless the issue explicitly says otherwise.
- Use `docs/current/MAIN_GD_ARCHITECTURE_REFACTOR_EPIC.md` as the active decomposition plan for `main.gd`.

Every refactor issue must report:

- files changed
- responsibility extracted
- tests added or updated
- verification commands run
- exact command results
- lines removed or simplified in `scripts/main.gd`, where practical
- any behavior intentionally left unchanged

## Verification Commands

Prefer the tiered runner when possible:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier docs
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier visual
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier mobile-like
powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier full
```

Use `quick` for most code/gameplay changes, `docs` for documentation/MCP-only changes, `visual` or `mobile-like` only when layout/art/camera evidence is needed, and `full` for milestone closeout or export/tooling changes.

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
