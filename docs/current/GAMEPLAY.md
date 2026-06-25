# Current Gameplay

This file describes implemented behavior. If gameplay, controls, runtime, deployment, or workflow changes, update this file before closing the related issue.

Near-term work is tracked in `docs/current/ROADMAP.md` and GitHub Issues.

## Product Behavior

- No playable game behavior exists yet.
- The selected direction is a 2D underwater roguelite where each dive is an expedition into alien ocean biomes.
- Intended first loop: dive from a safe base, gather resources, scan lifeforms, avoid or hunt predators, return before oxygen runs out, and craft upgrades that allow deeper future dives.

## Runtime / Setup

- No engine project has been scaffolded yet.
- The engine, launch command, source layout, and generated-file rules should be recorded here when the first prototype is created.
- Do not commit local editor cache, generated imports, build output, secrets, or export artifacts.

## Verification

Preferred checks:

```powershell
git diff --check
```

Manual smoke:

- After engine scaffold: launch the project and confirm the first scene runs.
- After first dive loop: start a dive, collect or scan something, return to base, and confirm the result is recorded.
