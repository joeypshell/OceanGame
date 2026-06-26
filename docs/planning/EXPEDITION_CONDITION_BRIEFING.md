# Expedition Condition Briefing

Status: planning source for #107.

## Purpose

The surface base should tell the player what kind of expedition day they are about to enter before oxygen pressure begins. This gives seeded variation a readable fiction and helps the player make a plan.

The briefing should be compact enough to live inside the existing `Expedition Ready` panel. It is not a new screen, region selector, quest log, or management layer.

## Briefing Shape

Use one condition headline and one short effect/prompt line:

```text
Condition: Thermal Bloom
Warm water stirs near the vent field.
```

Optional later expansion may add one second line only if it directly improves the dive decision:

```text
Plan: scan the vent route if oxygen allows.
```

Do not show more than two condition lines on the ready panel during the first implementation.

## Placement

The ready panel priority should be:

1. expedition title,
2. current expedition condition,
3. current goal line,
4. start prompt.

The condition should support the goal, not replace it. Upgrade/resource/scan goals remain the main progression prompt until the condition system has real mechanical effects.

## Copy Rules

Good condition copy:

- names an observable ocean state,
- uses one short sentence,
- hints at a decision without becoming an objective checklist,
- avoids implementation terms such as seed, roll, or random.

Examples:

- `Condition: Calm Current`
- `Safe routes are easier to read today.`
- `Condition: Predator Migration`
- `Deep patrols are shifting.`
- `Condition: Rare Signal`
- `A weak research ping is active below.`

Avoid:

- `Daily modifier: +20% glow`,
- `Random condition selected`,
- `Complete these tasks today`,
- `New quest available`.

## Debug Telemetry Boundary

The condition is player-facing. Debug data remains separate:

- seed,
- cluster pattern,
- predator route id,
- raw condition id,
- placement telemetry.

Raw debug values should remain hidden unless F3 or the exported debug flag enables telemetry.

## First Implementation Limits

The first implementation should be presentation-only:

- choose a deterministic condition from the expedition seed,
- show name and one short line on the ready panel,
- preserve the existing goal formatter,
- preserve the existing start controls,
- do not add region select,
- do not change resource spawns, predator routes, pressure gates, scan range, oxygen, cargo, or upgrades.

## Result And Evening Use

Extraction/failure results do not need full condition analysis yet. A later issue may add one compact result callout if a condition actually changes mechanics.

For now, results should continue to prioritize:

- cargo banked or lost,
- scans kept,
- upgrade progress,
- route choice,
- best depth.

## Success Gate

The briefing design is ready when:

- the ready panel can show one condition headline and one short line,
- the goal remains visible and higher priority than flavor,
- debug seed/pattern telemetry stays separate,
- the design does not require a new surface screen,
- the briefing helps the player ask what kind of dive this is without creating a chore list.
