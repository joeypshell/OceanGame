# Wreck Echo Return And Failure Language - 2026-06-26

Status: planning artifact for issue #353. This note does not add runtime copy or formatter behavior.

## Purpose

Plan how a future `Wreck Echo Descent` attempt should read on successful return, no-clue return, and oxygen failure while preserving the current non-punitive expedition loop.

## Decision

Use the existing result-panel model:

- successful extraction can show one compact `Research:` line if the Wreck Echo clue was recovered,
- extraction with no clue should not scold the player or imply a failed quest,
- oxygen failure should keep the normal recoverable failure framing,
- cargo loss should follow existing oxygen-failure rules only,
- durable banked resources, upgrades, scans, and best depth remain kept according to current rules.

Do not add new runtime copy until the first Wreck Echo implementation issue defines the route entry, clue trigger, and result flag.

## Planned Result States

| State | Future read | Persistence | Guardrail |
| --- | --- | --- | --- |
| Successful clue recovery | One compact `Research:` line says the dive brought back a broad Wreck Echo clue. | Run result memory only by default. | Do not imply a completed quest, exact route, map marker, or upgrade unlock. |
| No-clue return | Result remains a normal extraction with banked cargo/scans/place memory. Optional route-choice copy may say the deeper echo was left for another dive. | No Wreck Echo state persists. | Do not say "failed objective" or pressure the player with checklist language. |
| Failed attempt with no cargo | Failure says cargo was lost only if applicable, while banked resources, upgrades, scans, and best depth are kept. | Current durable state rules only. | Keep it recoverable; the player learned route pressure even if no new clue came home. |
| Failed attempt with carried cargo | Failure uses existing cargo-loss framing; carried cargo is gone, durable progress remains. | Banked progress and scans remain according to existing rules. | Do not add extra Wreck Echo penalties, debt, damage, injury, route lockout, or clue loss beyond the run-scoped result flag. |

## Copy Direction

Final wording should be decided during implementation, but the tone should follow these examples:

- Successful clue recovery: `Research: Wreck Echo clue confirms a deeper pressure signal below the shelf.`
- Successful clue recovery, more cautious: `Research: Wreck Echo signal came home as a deeper question, not a safe route.`
- No-clue return: `Route choice: turned back before the Wreck Echo pull became risky.`
- Failed attempt with no cargo: `The echo run was lost to oxygen pressure. Banked progress and scans remain.`
- Failed attempt with cargo lost: `Cargo lost. The Wreck Echo can wait for a better-prepared return.`

These are planning examples, not approved runtime strings.

## Failure Tone

Wreck Echo failure should feel like a recoverable expedition lesson:

- "I pushed too far and need more margin next time,"
- not "I failed a quest,"
- not "the game took away permanent progress,"
- not "the route is now closed."

The current failure model is enough. Do not add new punishments, explicit injury states, repair bills, route cooldowns, clue debt, or permanent lockouts.

## Relationship To Current Systems

Keep these current behaviors:

- oxygen failure clears carried cargo,
- banked resources remain,
- purchased upgrades remain,
- scan discoveries remain,
- best depth remains,
- result debug telemetry remains hidden unless enabled,
- recent-expedition log stays compact,
- restart prepares the next shifted expedition.

If a future Wreck Echo clue is result-only, failure should not persist it. If a later issue promotes Wreck Echo research into durable progression, that issue must separately define whether oxygen failure can keep a partial scan discovery.

## Implementation Acceptance Later

A future runtime issue should verify:

- extraction with clue adds one compact research line,
- extraction without clue has no Wreck Echo reward line,
- oxygen failure with and without carried cargo uses existing recoverable framing,
- no Wreck Echo result text contains quest, checklist, field-guide, minimap, marker, exact-coordinate, or permanent objective language,
- no new penalty exists beyond current oxygen/cargo failure rules,
- result panel remains bounded at normal scale.

## Current Scope

No runtime strings, tests, scenes, state variables, penalties, route behavior, or save schema change here.
