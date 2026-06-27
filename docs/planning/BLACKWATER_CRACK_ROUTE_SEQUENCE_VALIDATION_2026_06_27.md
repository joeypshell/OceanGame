# Blackwater Crack Route Sequence Validation - 2026-06-27

Status: pass with watchlist.

This closes the Blackwater Crack Route Sequence milestone. The goal was not to build a full cave system; it was to prove that the lower ocean could become a connected route sequence with a gated branch, one payoff, local pressure/readability, route memory, and no minimap/checklist crutch.

## Validation Method

This is a compact solo milestone validation using:

- the implemented Blackwater route sequence after the local readability pass;
- existing quick Godot logic coverage for gate state, trace payoff, return memory, route-callout priority, no durable route-state leakage, pressure-cue isolation, and camera/backdrop bounds;
- the deterministic Playwright Blackwater route capture;
- current roadmap/gameplay contracts and the no-minimap orientation guardrails.

No new review treadmill is created here. The next work should move to the next player-visible route-growth milestone.

## Acceptance Gate Answers

1. Does `Blackwater Crack` read as a deliberate deeper-route gate?

Pass. The route starts as `RESONANCE SEAL`, progresses through `KEY NEEDED`, and becomes `KEY READY` from existing `Echo Lens I` / `Resonance Key I` preparation. It is presented as an authored route promise, not a collision bug or hidden progression flag.

2. Can the player enter a short Blackwater route sequence after the scoped preparation?

Pass. `Blackwater Sill` appears only after the existing key preparation is ready. The route remains a short authored extension, not a full cave network or broad biome.

3. Is there one clear reason to risk the Blackwater edge and return safely?

Pass. `Blackwater Trace` is a visible, run-scoped knowledge payoff. Interacting records the trace, visibly dims the core, and extraction can acknowledge that the right branch carries a deeper route signal.

4. Does the route pressure come from readable distance, darkness, timing, or local cues rather than hidden punishment?

Pass with watchlist. The route uses dark-water staging, distance from base, a subtle non-damaging pressure pulse, and return-current cues. The watchlist is that the route still uses abstract prototype geometry near the current world edge, so the next route milestone should create more readable negative space and stronger landmark identity instead of stacking more translucent cue shapes.

5. Does extraction/failure copy remember the route without becoming a checklist?

Pass. Result and recent-log memory prioritize Blackwater as the deepest reached route while keeping it to compact route/research language. Raw seed/pattern telemetry remains hidden unless debug telemetry is enabled.

6. Does the route stay understandable without minimap, exact locator, broad quest UI, combat, harvesting, or procedural cave generation?

Pass with watchlist. The implementation stays within named landmarks, broad return direction, scene-native cues, and compact result memory. The watchlist is evidence quality: staged screenshots are useful, but future milestone closeouts should prefer one cheap scripted traversal or normal-play capture so progress is visible without repeated manual screenshots.

## Outcome

The milestone passes with watchlist.

Move on to the next player-visible route/content milestone: `Dusk Trench`, a compact continuation beyond Blackwater that should make the lower route feel wider and more explorable. The first Dusk Trench batch should add one reachable route segment, one safe ledge/pocket, one knowledge payoff, one non-damaging low-visibility cue, one daily-condition nudge, route memory, targeted evidence, and a closeout validation.

Do not create additional Blackwater follow-up issues from this validation. The watchlist should guide the Dusk Trench work rather than pull the project back into repeated Blackwater polishing.

## Verification

- Documentation-only validation; no runtime files changed.
- Expected verification: docs tier plus `git diff --check`.

## Follow-Up Issues

None created from this validation. Existing issues #536 through #545 already cover the next Dusk Trench milestone shape.
