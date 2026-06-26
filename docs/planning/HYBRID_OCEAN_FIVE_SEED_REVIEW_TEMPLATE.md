# Hybrid Ocean Five-Seed Review Template

Status: template for #120.

## Purpose

Use this template to review whether the hybrid ocean model is working across deterministic expedition seeds.

The review should answer two questions at the same time:

- What stayed familiar enough for the player to learn the ocean?
- What changed enough to affect the expedition decision?

Different placement is not enough. The variation must change a route, risk, scan, cargo, or turnaround decision without erasing persistent geography.

## Setup

- Review five deterministic expedition seeds.
- Keep debug telemetry hidden during the player-facing readability pass.
- Record seed, cluster pattern, condition, and predator route after the pass if debug telemetry is needed.
- Use normal camera scale.
- Use `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md` for visual checks.

Suggested seed set:

| Expedition | Seed |
| --- | --- |
| 1 | `8919` |
| 2 | `16838` |
| 3 | `24757` |
| 4 | `32676` |
| 5 | `40595` |

## Per-Seed Record

```text
Expedition:
Seed:
Condition:
Cluster pattern:
Predator route:

Persistent geography recognized:
- Surface/base:
- Shell Reef:
- Thermal Vent:
- Wreck/pressure gate:
- Gulper route:

What changed this expedition:
- Resources:
- Predator/warning:
- Current/route hints:
- Visibility/readability:
- Scan or wreck opportunity:

Decision impact:
- Planned route:
- Actual route:
- Cargo collected:
- Scans attempted:
- Turnaround point:
- Extraction/failure:
- Closest oxygen moment:

Readability:
- Player visible:
- Safe return visible:
- Text clutter:
- Scan/lock/danger/reward/return meanings distinct:

Issue candidates:
- Blocking fix:
- Tuning fix:
- Deferred polish:
```

## Cross-Seed Questions

After all five seeds, answer:

- Which places felt persistent and learnable?
- Which variation was visible before the player committed?
- Did at least one seed encourage cautious banking?
- Did at least one seed tempt a deeper push?
- Did at least one seed create a close return or failure?
- Did any seed hide the surface/base return route?
- Did any condition or cluster pattern feel like invisible randomness?
- Did any changed placement break depth-band identity?
- Did predator pressure remain avoidable through observation or route choice?
- Did visual clutter block comprehension of a route, lock, danger, reward, or scan target?

## Success Gate

The five-seed review succeeds when:

- the player can recognize the same core places across seeds,
- the player can identify at least one meaningful change per seed,
- at least one changed condition or placement affects planning,
- safe return remains readable in every seed,
- no seed violates resource depth identity,
- no seed relies on long world text to explain the route,
- and follow-up issues are specific enough to implement without inventing a broad new system.

## Failure Signals

Create follow-up issues if:

- the route feels different only because objects moved, not because decisions changed,
- the ocean feels fully rerolled and unlearnable,
- a condition is not visible before the dive decision,
- a pressure gate, current hint, reward, or predator warning is confused for another meaning,
- the player cannot tell whether a fact is permanent knowledge or current-expedition variation.
