# Dusk Trench Route Validation - 2026-06-27

Status: pass with watchlist.

This closes the Dusk Trench Route Continuation milestone. The goal was not to build a full cave system or a production-art lower biome; it was to prove that the route beyond Blackwater can widen into a darker lower-trench segment with one calm side pocket, one knowledge payoff, one daily-condition nudge, route memory, and deterministic evidence without leaning on a minimap, checklist, exact locator, combat, harvesting, or procedural cave generation.

## Validation Method

This is a compact solo milestone validation using:

- the implemented `Dusk Trench`, `Glass Kelp Ledge`, `Glass Kelp reading`, and `Low Visibility` condition nudge after the local readability pass;
- quick Godot logic coverage for scene ownership, return-current direction, no hidden collision/pressure/oxygen mutation, run-scoped result memory, reset behavior, and no durable Dusk state leakage;
- deterministic Playwright captures for the staged Dusk route, Glass Kelp payoff before recovery, and payoff recovered state;
- current no-minimap orientation guardrails and the player-visible milestone pivot.

No new review treadmill is created here. The next work should move to the next player-visible gameplay milestone.

## Acceptance Gate Answers

1. Does Dusk Trench read as a deliberate continuation beyond Blackwater?

Pass. `Dusk Trench` inherits the existing Blackwater route gate and presents a darker right/down continuation with a trench mouth, open-water negative space, lower shelf silhouette, far turnback, and broad up-left return current back through Blackwater, Silt Vein, and Blue Chimney.

2. Can normal play understand the route without a minimap, checklist, or exact locator?

Pass with watchlist. The implementation uses named landmarks, broad base-direction copy, scene-native return-current cues, result memory, and staged visual evidence instead of objective UI. The watchlist is that the route remains abstract prototype geometry; future work should add new readable content and landmarks rather than solve orientation by adding map UI.

3. Is there one clear reason to enter the trench and return safely?

Pass. `Glass Kelp Ledge` provides one calm side-pocket payoff. The `Glass Kelp reading` records one run-scoped knowledge note, visibly dims after recovery, repeats as already recorded, and can be remembered at extraction as a safer ledge route off Dusk.

4. Does low visibility add atmosphere without hidden punishment?

Pass. The `Low Visibility` condition strengthens the local Dusk murk/silt presentation and ready/status copy. It does not drain oxygen, mutate cargo, move the player, add collision, add knockback, change predator state, bypass route gates, or save active condition state.

5. Does route memory stay useful without becoming durable quest state?

Pass. Reaching Dusk can own the deepest run-scoped route-choice line and recent-log route memory, and Glass Kelp can add one compact research line on successful extraction. Reset/new-expedition coverage keeps this evidence out of durable progression data.

6. Is the evidence good enough to support future work?

Pass with watchlist. The deterministic Playwright captures now assert Dusk route and payoff states before screenshots. They are useful for visual regression and agent handoff, but they are still staged evidence. A later expedition-goal/tooling issue should add a cheap scripted traversal smoke for the longer lower-route chain so milestone evidence is not overly dependent on staged captures.

## Outcome

The milestone passes with watchlist.

Move on to the next player-visible gameplay milestone: `Lantern Ray`, a first non-combat lower-route creature presence. The Lantern Ray batch should make the trench feel inhabited and learnable through observation, scanning, timing, route memory, daily variation, and compact validation. It should not jump straight to weapons, harvesting, capture, monster-part economy, health bars, field-guide objectives, minimaps, or broad creature progression.

After Lantern Ray, the next planned route-growth milestone is `Hollow Reef`, a first side-cave branch off the lower route. That should be treated as map growth after the creature-readability step, not as another Dusk review pass.

## Ordered Risks

1. The lower ocean still needs player-visible new gameplay. `Lantern Ray` should add inhabited-route behavior before more readability-only tuning.
2. Evidence is strong but staged. The later scripted traversal smoke should make long-route verification cheaper and closer to normal play.
3. Visual identity is still prototype-first. Planned polish-gate issues should replace the most important lower-route placeholder clusters with reusable/source-art-backed readability scenes after gameplay shape is clearer.

## Verification

- Documentation-only validation; no runtime files changed by this note.
- Expected verification: docs tier plus `git diff --check`.

## Follow-Up Issues

No new issues were created from this validation. Existing issues #546 through #565 already cover the selected next work: Lantern Ray, Hollow Reef, expedition-goal support, and a small polish gate.
