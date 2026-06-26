# Monster Research II State Ownership And Result Memory - 2026-06-26

Status: planning contract. No runtime state is added by this note.

Issue: #415.

## Purpose

Plan how the selected `Decoy response observed` evidence should be owned by the run, progression, and result surfaces without adding a field guide, quest checklist, minimap, route graph, creature inventory, combat log, or broad research tree.

## Selected Evidence

Selected by `docs/planning/MONSTER_RESEARCH_II_FIRST_EVIDENCE_TYPE_SELECTION_2026_06_26.md`:

`Decoy response observed`

Meaning: the player used preparation and timing to briefly bend the Gulper route, then survived or failed with that knowledge.

## Ownership Model

| Layer | Ownership | Allowed Data | Reset Behavior |
| --- | --- | --- | --- |
| Active expedition | Run-scoped | `decoy_response_observed_this_run` or equivalent, derived from spending `Decoy Pulse I`. | Clears on next expedition and clean-save reset. |
| Result summary | Player-facing memory | One compact `Research:` line if the run produced decoy response evidence. | Shown only for the completed expedition result. |
| Recent expeditions | Compact history | Existing summary can imply scans/contacts/banked cargo; no new verbose monster fields unless a future issue proves it is needed. | Last three completed expeditions only. |
| Durable progression | Optional readiness | A future upgrade-readiness flag may be introduced only if a later issue needs it. | Must be saved only as a narrow prerequisite, not a research journal. |
| Debug telemetry | Developer-only | Raw evidence flags may appear only behind F3/debug surfaces if implemented. | Hidden by default. |

## Result Memory Shape

Preferred compact result line:

```text
Research: Decoy response confirmed Gulper route timing.
```

Acceptable shorter variant:

```text
Research: Decoy timing bent the Gulper route briefly.
```

Avoid:

- multi-line creature dossiers,
- exact route coordinates,
- objective checklist language,
- combat result terms such as damage, stun, kill, loot, capture, harvest, or victory,
- promises that the route is now permanently safe.

## Priority Rules

If multiple Gulper evidence signals happen in the same expedition, the stronger result memory should win:

1. `Decoy response observed`
2. predator contact / warning-lane danger confirmed
3. Gulper scan / patrol timing observed

This preserves one compact research line rather than stacking creature notes.

## Implementation Notes For Later

- The existing `decoy_pulse_used_this_run` may be enough for the first implementation if the later issue only needs result copy.
- Add a separate run-scoped evidence flag only if future logic needs to distinguish "decoy used" from "decoy response observed."
- Do not save a durable Monster Research II flag until there is a specific upgrade or progression gate that needs it.
- Logic coverage should assert that evidence resets between expeditions and stays hidden from player-facing debug-free screens except the compact result line.
