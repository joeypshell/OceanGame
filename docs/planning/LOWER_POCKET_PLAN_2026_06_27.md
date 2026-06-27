# Lower Pocket Plan - 2026-06-27

Status: implementation contract for the next connected pocket after `Shelf Drop Connector`.

## Purpose

The next route step should make the current ocean feel wider and more connected without starting a full cave system. It should extend the existing East Shelf -> Shelf Drop chain by one small lower pocket that a player can see, enter, understand, and retreat from.

This is a map-growth issue, not a polish pass. The goal is to prove one more readable side-view space below the current connector while preserving oxygen, cargo, scan, predator, pressure, Wreck Echo, East Shelf, Shelf Drop, save/reset, and upgrade behavior.

## Selected Route

Name: `Blue Chimney Pocket`.

Starting landmark: `Drop Arch`.

Route shape:

- Starts after the `Shelf Drop Connector` turnback hint.
- Runs slightly down-right into a compact pocket rather than a long corridor.
- Fits inside the current expanded route family: East Shelf, hatch/alcove, Shelf Drop, then lower pocket.
- Keeps the return line visually connected to `Drop Arch`, then up-left toward East Shelf and the base.

Player-facing role:

- Shows that lower routes can contain small remembered spaces, not only dead-end pings.
- Creates a mild oxygen decision: inspect the pocket now or return after banking/restarting.
- Establishes a future pattern for cave-like pockets before larger Dave-the-Diver-style maps.

## Payoff

First payoff: `Blue Chimney` landmark plus one run-scoped research opportunity or expedition-day signal.

The payoff should be knowledge-first and small:

- no new resource tier,
- no combat, capture, or harvesting,
- no field guide objective or quest checklist,
- no durable map pin or exact locator,
- no broad upgrade family.

The current recommended first payoff is a session-only `Chimney Draft` or `Blue Chimney Signal` note that can appear in status/result copy after interaction. A later issue may add an existing-material candidate if the route needs a cargo reason, but the first pocket should prove readability before adding economy pressure.

## Return Cue And Turnback

Return cue: a soft up-left `Reverse Draft` current cue inside the pocket, visually pointing back toward `Drop Arch`.

Turnback point: a visible closed lower crack or dark shelf lip at the pocket's far edge. It should promise future depth without allowing hidden traversal or implying an immediate objective.

The pocket should still rely on broad base-direction HUD copy such as `up-left`, named landmarks, depth bands, and result memory. It should not add a minimap, route graph, exact coordinates, objective arrow, or persistent checklist.

## Guardrails

- Keep the pocket authored and small.
- Place only the geometry required for readability, camera evidence, and future expansion.
- Do not add collision mazes, procedural assembly, interiors, or multi-room caves.
- Do not change oxygen drain, cargo limit, extraction rules, save schema, predator behavior, pressure gates, Wreck Echo, East Shelf, or Shelf Drop behavior.
- Any temporary run state belongs to `DiveSession`/main-scene run fields and resets between expeditions.
- Any durable progress must be explicit `ProgressionState` data and should not be added unless a follow-up issue specifically asks for it.
- Use no-locator copy: broad place memory is allowed; exact reward location language is not.

## Follow-Up Implementation Order

1. #488 scaffold `Blue Chimney Pocket` geometry, camera/bounds needs, and a route-stage name only.
2. #489 add `Blue Chimney` as the named landmark plus `Reverse Draft` return cue.
3. #490 add one expedition-day opportunity that can point toward the pocket without guaranteeing a reward.
4. #491 add one non-combat timing/navigation cue in the pocket.
5. #492 add no-minimap orientation and reset coverage for pocket state and bounds.
6. #493 add deterministic Playwright capture for the lower pocket route stage.
7. #494 review oxygen margin after the hatch, alcove, and lower-pocket route are playable.
8. #495 refresh roadmap/backlog once the pocket is in-game and evidenced.

## Success Criteria

- The player can understand that `Shelf Drop Connector` leads to a lower pocket.
- The pocket has one remembered name, one local payoff, one return cue, and one obvious turnback.
- Automated checks can assert reset/state ownership and route stage evidence.
- The work moves OceanGame toward larger side-view expedition maps without using a minimap or broad new systems as a shortcut.
