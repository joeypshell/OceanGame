# Monster Research Loop v1

Status: planning recommendation for the next creature-research slice after the visual clarity foundation.

## Direction

Monster-hunting inspiration should read as alien-ocean field research first: observe dangerous behavior, survive the route, bring data home, and turn that knowledge into a practical non-lethal advantage. The player should feel clever for learning a creature, not powerful because they can kill or harvest it.

This loop supports the daily expedition fantasy:

1. Morning condition hints that the ocean is different today.
2. Dive to a remembered creature route.
3. Observe or nearly miss a danger pattern.
4. Return to the surface lab with data or a lesson.
5. Unlock a better plan for tomorrow's run.

## First Target

First research target: `Gulper Eel`.

Reason: it already has route pressure, warning visuals, scannable observation, predator route telemetry, `Predator Warning I`, and `Decoy Pulse I`. The next step should deepen this known creature before adding a second predator.

## Narrow Loop Candidate

Name: `Gulper Eel Pattern Study`.

Player-facing loop:

- The player enters a Gulper route during an active dive.
- The route shows a readable warning lane and patrol hint before contact.
- The player can scan the Gulper, survive a near miss, trigger a chase, or suffer contact.
- The run result records a compact creature-research note.
- Returning to the lab turns accumulated observation into a practical route-planning payoff.

The first payoff should not be damage, capture, or loot. It should be better preparation:

- clearer route timing text after observation,
- a stronger one-line result callout after a near miss,
- a future unlock path toward a route tag or decoy tuning,
- or a small upgrade prerequisite for a later non-lethal tool.

## Learnable Rule

The first learnable rule should be:

`Gulper Eel controls a timing window, not an impassable wall.`

Readable behavior:

- red warning lane marks the contested path,
- patrol hint grows urgent as the player approaches,
- contact means oxygen loss and knockback, not instant failure,
- decoy or burst movement can create recovery, but mistiming still matters.

The player should learn whether to wait, detour, push through, or return with cargo.

## Practical Payoff

Recommended first implementation payoff:

`Creature Research Note`.

After a dive that includes a Gulper scan, near miss, chase, contact, or decoy use, the result panel should add one compact research line such as:

```text
Research: Gulper route timing observed.
```

If the player already has the scan discovery, the line can focus on route learning rather than rediscovering lore:

```text
Research: Gulper warning lane helped plan the return.
```

This is intentionally modest. It creates an evidence trail for later upgrades without adding a new system surface yet.

## Failure And Near-Miss Data

Failure should still teach something if the player interacted with the creature route.

Useful signals:

- scanned `Gulper Eel`,
- entered warning radius,
- triggered chase,
- made contact,
- used `Decoy Pulse I`,
- failed after predator contact,
- escaped after predator contact and extracted.

Near-miss examples:

- player entered warning radius but avoided contact,
- player triggered chase but extracted,
- player used decoy and crossed the route,
- player abandoned deep reward after warning feedback.

The prototype does not need a full research notebook yet. It only needs run telemetry and result language that make the creature route feel learnable.

## Required Changes For First Implementation

- Track one or two session-only Gulper route research flags during the dive.
- Add compact result-summary copy for creature route learning.
- Keep recent expedition log short; do not turn it into a field guide.
- Add focused logic coverage that result callouts can mention creature research without exposing debug telemetry.
- Update current gameplay docs after implementation.

## UI Needs

Use existing surfaces:

- active dive HUD: keep current scan/prompt/status behavior,
- result panel: add one compact research line only when relevant,
- upgrade bay: no change for the first implementation,
- recent expedition log: no new verbose fields unless a later issue proves it is needed.

Avoid:

- permanent bestiary UI,
- minimap,
- creature health/status panels,
- large world labels,
- multi-line research dossiers during active dives.

## Behavior-Readability Needs

Before expanding creature research, the current Gulper route must remain visually readable:

- warning lane is danger, not reward,
- creature silhouette is the moving risk,
- safe return remains visible near the route,
- pressure lock and reward cues remain distinct from predator danger.

Use `docs/current/SCREENSHOT_WORKFLOW.md` and `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md` for future visual review.

## In Scope

- One creature: `Gulper Eel`.
- One loop: observe route behavior, survive or fail, record a compact research result.
- Non-lethal route-planning payoff.
- Result-summary and telemetry support.
- Logic tests for callout priority and debug hiding.

## Out Of Scope

- Weapons.
- Predator health, damage, stun, kill, capture, or harvest states.
- Monster parts, hunting contracts, or bounty boards.
- New predator species.
- Field guide or codex UI.
- Persistent multi-step research tree.
- Route removal or permanent predator control.
- Broad AI behavior rewrite.

## First Implementation Issue

Recommended next implementation issue:

`Add Gulper route research result callout`

Acceptance sketch:

- Track whether the current dive produced useful Gulper research evidence through scan, warning-route entry, chase, contact, or decoy use.
- Add one compact result-summary line when research evidence exists.
- Preserve current predator patrol, chase/contact radius, oxygen loss, knockback, decoy behavior, seeded route selection, and debug telemetry gates.
- Add logic tests for result copy and hidden debug data.
- Verify with Godot headless launch, logic tests, normal timed launch, and `git diff --check`.

## Monster Research II Boundary

`docs/planning/MONSTER_RESEARCH_II_NON_COMBAT_BEHAVIOR_EVIDENCE_2026_06_26.md` defines the next monster-research milestone as one narrow behavior-evidence contract. It should record what the player learned from existing creature behavior, preserve one compact result-memory line, and avoid weapons, damage, harvesting, capture, bestiary UI, checklists, minimaps, route graphs, monster parts, or permanent predator control.
