---
name: oceangame-frontend-qa
description: Verify OceanGame visual readability, HUD layout, surface panels, route communication, and Godot Web browser behavior using the repo's screenshot workflow and Playwright visual smoke tests. Use after UI, HUD, scene readability, route-art, or exported-web changes.
---

# OceanGame Frontend QA

## Load First

Read:

- `docs/current/TOOLING.md`
- `docs/current/SCREENSHOT_WORKFLOW.md`
- `docs/current/GAMEPLAY.md` sections relevant to the changed state.

## When To Use

Use this skill for:

- active dive HUD changes,
- surface ready/result/upgrade/log panels,
- route readability,
- scan marker readability,
- low oxygen and warning states,
- Godot Web export checks,
- screenshot capture or review.

## Checks

1. Inspect `git status --short` and identify changed visual/UI files.
2. Run deterministic checks when behavior could have changed.
3. For browser/export confidence, run:

```powershell
npm run test:visual
```

4. If only an existing export needs review, run:

```powershell
npm run test:visual:existing
```

5. Review produced screenshots/traces under `test-results/` and `playwright-report/`. Do not commit those artifacts unless explicitly requested.

## Visual Acceptance Heuristics

- Text must fit inside panels at normal scale.
- Active dive HUD should not compete with route/scan readability.
- Surface panels should own ready/result/upgrade/log information without loose duplicate labels.
- Player-facing text should avoid prototype/debug terminology unless debug telemetry is intentionally visible.
- Route risk, route reward, pressure lock, return orientation, and scan target state should be visible in the scene, not only described in HUD text.
- Debug controls and telemetry should remain hidden by default.

## Close-Out

Report:

- scenarios checked,
- commands run,
- screenshots or reports reviewed,
- any visual risks that remain.
