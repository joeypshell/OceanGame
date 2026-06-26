# Resource/Scan Source-Art Target Decision - 2026-06-26

Status: planning decision for issue #332.

## Decision

Defer a new resource/scan affordance source-art target for now.

The post-shell review found no concrete blocker. Kelp Fiber, Shell Fragments, Glow Plankton, non-resource scan markers, selected scan HUD copy, `Signal Lens I`, and `Echo Lens I` are readable enough for the current vertical-slice closeout.

## Candidate Comparison

| Candidate | Readability Impact Now | Risk | Decision |
| --- | --- | --- | --- |
| Resource sprites | Low to medium | Reworking them now may spend effort on already-readable cargo/material identities. | Defer |
| Non-resource scan markers | Medium | Could help polish scan readability, but the current pale diamond/bracket language passes. | Backup target if reopened |
| Signal Lens pulse | Medium | Practical material signal already reads separately from Echo Lens. New art could accidentally imply exact locator behavior. | Defer |
| Echo Lens pulse | Medium | Current local pulse and no-locator copy pass. More art could make it look like a persistent objective marker. | Defer |

## Backup Target If Reopened

If later screenshots or playtests show scan confusion, choose non-resource scan marker/source-art polish as the next target.

Why:

- resources already have distinct material silhouettes and cargo mini-icons,
- scan markers are shared across important non-resource targets,
- scan affordance polish could improve Thermal Vent, Shell Reef Shelf, outside wreck scan, Wreck Signal Cache, and creatures without adding new gameplay,
- it can preserve scanner behavior and no-locator constraints.

Scope for a future reopened issue:

- one small source/export/provenance marker or scan-focus asset,
- target-hugging treatment only,
- no persistent marker,
- no minimap/exact locator,
- no scanner energy economy,
- no field guide,
- no objective checklist.

## Guardrails

Do not add:

- new resources,
- new cargo/inventory UI,
- new scanner behavior,
- scanner cooldown/energy economy,
- exact target direction or distance,
- minimap, route graph, field guide, objective checklist, or persistent marker,
- new Wreck Echo route behavior.

## Follow-Up

No new source-art implementation issue is needed from this decision.

Continue with vertical-slice evidence and acceptance updates. Reopen resource/scan source-art only if future normal-scale evidence shows concrete confusion.
