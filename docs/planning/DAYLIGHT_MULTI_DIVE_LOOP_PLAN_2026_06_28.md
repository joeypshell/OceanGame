# Daylight Multi-Dive Loop Plan - 2026-06-28

Status: planning direction only. This does not describe implemented behavior yet. `docs/current/GAMEPLAY.md` remains the source of truth for current runtime behavior.

## Goal

Clarify the future expedition day loop around one readable daylight budget:

Start the day from the research boat, make multiple dives, surface for oxygen, return to the ship to bank limited cargo, then use nightfall for upgrades, crafting, analysis, and Emergency Week resolution.

## Core Model

One expedition day has three nested pressures:

- Daylight timer: the strategic run budget. A clear top-of-screen sun-to-moon bar shows how much day remains before nightfall.
- Oxygen: the tactical underwater sortie budget. Surfacing refills oxygen, but does not bank cargo unless the player returns to the ship.
- Cargo space: the inventory pressure. Supplies, resources, and some samples compete for limited carried slots until offloaded at the ship.

Health or hull integrity can become a fourth pressure, but only when danger is active. It should represent predators, hazards, collision, or route danger rather than duplicating the day timer or oxygen timer.

## Intended Day Flow

1. Dawn planning: show tonight's base needs, current ocean condition, known upgrade/crafting requirements, and a small set of pinnable goals.
2. Dive sortie: leave the ship with empty or partially filled cargo slots and full oxygen.
3. Surface for air: reaching open surface water refills oxygen, but cargo remains carried and daylight keeps moving.
4. Return to ship: entering the ship/moonpool lets the player offload carried supplies and resources with one clear button press.
5. Repeat: the player chooses whether there is time for another push before nightfall.
6. Nightfall: the day ends. The player reviews banked supplies, resolves base needs, performs upgrades/crafting/lab analysis, and prepares for the next expedition day.

## Ship Versus Surface Rule

Surfacing and returning to the ship are intentionally different verbs:

- Surface water gives oxygen.
- The ship banks cargo and provides the night/upgrades interface.
- The ship should remain visually and mechanically easy to find from nearby surface water.
- Offloading at the ship should be a single fast action, not a cargo-management minigame.

This keeps surfacing useful without making it a free full reset. The player can breathe anywhere open to the surface, but must still spend daylight and route distance to bring supplies home.

## Information Access

The loop needs a pauseable expedition slate so the player can make informed cargo and route decisions without overloading the HUD.

The slate should pause the game and show:

- tonight's base needs and current shortages,
- current cargo and remaining slots,
- known upgrade/crafting requirements,
- pinned goals or wishlist items,
- recent route discoveries and broad resource hints,
- the current ocean condition and remaining daylight,
- one compact recommendation only when the game can infer it honestly.

The normal HUD should stay sparse:

- top: daylight sun-to-moon timer,
- active dive: oxygen,
- small cargo slots,
- health/hull only prominent when damaged or threatened,
- one pinned objective line.

Do not solve planning uncertainty with a full minimap, exact locator, quest checklist, route graph, field guide, or broad crafting UI during the dive.

## Night Phase

Night is the upgrade and resolution phase:

- resolve Emergency Week Food/Water/Power needs from banked supplies,
- show consequences for unmet needs,
- process discoveries and lab analysis,
- buy or craft upgrades from banked resources and known requirements,
- select or pin goals for the next day,
- advance the ocean condition/seed.

Night should feel like relief, analysis, and preparation. It should not become base management, production chains, or a separate economy sim.

## Failure And End Conditions

Candidate rules for implementation issues to test:

- Oxygen reaches zero underwater: the dive sortie fails and carried cargo is lost under existing failure rules.
- Health reaches zero: the sortie fails; decide separately whether this loses only carried cargo or also ends the day.
- Daylight reaches zero while away from the ship: the day ends with whatever was already banked. Unbanked cargo should be lost or heavily penalized unless a later issue proves a better rule.
- Daylight reaches zero at the ship/night screen: resolve night normally.

Do not introduce multiple new penalties at once. The first slice should prove the daylight/offload rhythm before adding health loss, harsher nightfall penalties, or complex rescue rules.

## First Implementation Slice

Recommended first slice:

1. Add a visible daylight timer to the active HUD and ready/result copy.
2. Keep current oxygen drain and cargo rules unchanged.
3. Treat extraction/ship return as the only banking point.
4. Add planning copy for future oxygen-refill-at-surface behavior, but do not change oxygen refill until the daylight timer is readable.
5. Add tests for day timer state transitions and display formatting where practical.

Recommended second slice:

1. Add open-surface oxygen refill zones separate from ship offload.
2. Keep cargo carried until the ship offload action.
3. Add one-button offload at the ship.
4. Add direct tests for oxygen refill, cargo retention, and ship banking behavior.

## Open Questions

- Does daylight pause during menus, or only during the pauseable expedition slate?
- Does surfacing at any open water refill instantly, refill over time, or require staying near the surface briefly?
- What happens if nightfall arrives while the player is underwater but still alive?
- Does health failure end only the current sortie or the whole day?
- Should offloaded supplies be immediately counted toward tonight's needs, or only resolved at night?
- How many goals can the player pin before the HUD feels like a checklist?

## Non-Goals

- No implementation in this planning note.
- No minimap or exact route tracker.
- No broad crafting tree.
- No grid inventory.
- No base-management sim.
- No combat/weapon pivot.
- No hidden oxygen or daylight tax.
- No replacement of persistent geography with a complete daily reroll.

## Acceptance Standard For Future Issues

Future daylight-loop issues should prove that the new model creates clearer choices:

- Do I spend daylight going back to the ship now or push for one more pickup?
- Do I surface for air and continue, or bank cargo while I am near the ship?
- Do I prioritize tonight's base need, upgrade materials, or knowledge?
- Is there enough day left for another safe sortie?

If the timer only adds pressure without making those choices clearer, pause and recalibrate before adding health, crafting, or more route breadth.
