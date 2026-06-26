# Next Source-Art After Background Review - 2026-06-26

Status: planning artifact for issue #308.

## Decision

Next source-art target: pressure wreck/cache environment shell.

Backup target: compact HUD final skin pass.

This decision is based on readability impact, not asset novelty. The shallow/midwater background study is already wired and reviewed as subdued atmosphere, so the next source-art pass should clarify the densest remaining play-space decision instead of adding more environmental decoration.

## Candidate Comparison

| Candidate | Readability Impact | Risk | Decision |
| --- | --- | --- | --- |
| Pressure wreck/cache shell | High | Medium | Select next. It owns the lower-route pressure lock, outside clue, opened route, cache payoff, Echo Lens pulse adjacency, and predator-lane overlap. |
| Sub idle/thrust polish | Medium | Low | Keep planned, but current sub read is usable enough after the normal-scale recheck. It is polish, not the largest comprehension blocker. |
| Compact HUD skin | High | Medium | Use as backup. HUD clarity matters everywhere, but the current compact HUD is already bounded; finish it if lower-route art needs to wait. |
| Resource/scan affordances | Medium | Low/medium | Defer. Resource and scan reads are working with watchlists, and stronger lower-route shell art will show which affordances still need help. |
| Background/foreground needs | Medium | Medium/high | Do not expand now. The shallow/midwater study should stay quiet until lower-route and HUD watchlists are clearer. |

## Why Pressure Wreck/Cache Is Next

The lower route is the most information-dense place in the current slice:

- `Pressure Seal I` access language,
- locked/open pressure-gate state,
- outside scan clue,
- Wreck Signal Cache payoff,
- Echo Lens curiosity pulse,
- deep reward temptation,
- nearby Gulper danger lane.

Placeholder geometry can make those ideas stack into one noisy cluster. A calmer wreck/cache source-art shell can reduce shape pileup, frame the gate and cache as related but separate reads, and give the predator lane room to remain danger rather than visual clutter.

## Scope For The Next Implementation Issue

Allowed:

- one source/export/provenance asset or a small matched set for the pressure wreck/cache environment shell,
- scene wiring under the existing pressure wreck/cache visual ownership,
- fallback alpha, depth-order, or silhouette tuning only when the new art makes old placeholder pieces redundant,
- normal-scale screenshot review for locked gate, outside scan, open route, cache, Echo Lens pulse, and predator-overlap states.

Preserve:

- pressure lock behavior,
- `Pressure Seal I` ownership,
- outside scan clue behavior,
- Wreck Signal Cache scan/repeat-scan behavior,
- Echo Lens no-locator feedback rules,
- Gulper route behavior,
- player movement, oxygen, cargo, extraction, save/load, and progression state.

Avoid:

- implementing `Wreck Echo Descent`,
- adding new routes, resources, upgrades, predators, procedural biomes, or rewards,
- adding minimap, field guide, route graph, checklist, exact locator, or persistent marker behavior,
- brightening gate, cache, echo pulse, predator lane, and reward lure at the same time.

## Backup Target

If the pressure wreck/cache shell pass is delayed, use compact HUD final polish as the backup target.

The HUD backup should focus on oxygen, depth, base direction, cargo slots, scan target, prompt/status, and low-oxygen state polish within the existing bounded active/surface HUD separation. It should not add inventory, minimap, quest, field-guide, or debug-surface scope.
