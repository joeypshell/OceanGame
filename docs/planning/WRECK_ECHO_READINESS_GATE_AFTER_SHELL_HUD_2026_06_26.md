# Wreck Echo Readiness Gate After Shell And HUD Polish - 2026-06-26

Status: gate review artifact for issue #328.

## Decision

Not ready for a Wreck Echo implementation issue yet.

The current slice is closer than before: pressure wreck/cache shell readability, lower-route overlap, compact HUD, low/critical oxygen priority, Echo Lens no-locator language, upgrade affordances, oxygen/cargo preparation, and route-pocket data ownership are all at pass or pass-with-watchlist. However, the implementation gate still requires one selected reward type, and that choice is not made yet.

The next correct step is #329: choose the first Wreck Echo reward candidate. Do not wire `Wreck Echo Descent` before that choice.

## Gate Checklist

| Requirement | Current Status | Gate Result |
| --- | --- | --- |
| Playable-slice readability | Structurally playable with pass-with-watchlist evidence. | Pass with watchlist |
| Lower-route pressure/cache/predator overlap | Pressure shell reduces shape pileup; lower route remains dense but not blocker-level. | Pass with watchlist |
| HUD low/critical oxygen priority | Final compact HUD review confirms low/critical O2 outranks mystery/reward cues. | Pass |
| Scanner no-locator language | Echo Lens copy remains broad/local/category-based and avoids exact navigation. | Pass |
| Upgrade readability | Upgrade bay one-selected-upgrade model remains readable after copy/layout reviews. | Pass with watchlist |
| Route-pocket data plan | Future ownership, spawn-point shape, scan-clue rules, and no-go scope are documented. | Pass |
| Oxygen/cargo preparation | Oxygen-first, cargo-secondary guidance is documented. | Pass |
| Single reward type selected | Not selected yet. Current docs list research clue, rare material/sample, or later prerequisite discovery as options. | Blocker for implementation |
| Safe return during route attempt | Guidance exists, but no implemented route evidence can exist until a reward/route issue is authorized. | Pending future implementation acceptance |

## What Is Ready

Wreck Echo planning may now proceed to a single reward-choice issue.

Allowed next work:

- select exactly one first reward type,
- write implementation acceptance criteria,
- clarify result-copy rules for that reward,
- keep pressure, oxygen, cargo, scanner, and return requirements explicit,
- keep route implementation deferred until the reward choice is documented.

## What Is Not Ready

Do not yet add:

- `Main.tscn` route nodes,
- new scan targets,
- new resource pickups,
- new collision or pressure boundary,
- pressure-dark threshold scene wiring,
- exact locator behavior,
- minimap, route graph, field guide, quest log, or objective checklist,
- new predator behavior,
- new upgrade or resource economy,
- broad biome/procedural scope.

## Rationale

The shell and HUD polish removed the biggest readability blockers for considering deeper Wreck Shelf work. The lower route is now readable enough to plan the next promise, but not clean enough to absorb extra concepts casually.

The no-implementation criteria require `one route pocket, one route question, one reward choice`. The first two are planned; the third still needs a decision. Choosing the reward first prevents the route from turning into a multi-objective quest chain.

## Follow-Up

Proceed with #329.

The reward-choice issue should decide among:

1. compact research clue,
2. rare material opportunity or prototype sample,
3. later prerequisite discovery.

Until #329 lands, `Wreck Echo Descent` remains planning-only.
