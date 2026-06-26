# Pressure Gate Predator Warning Review - 2026-06-26

Status: screenshot/readability review for issue #168.

## Capture Method

Used the temporary-script screenshot workflow from `docs/current/SCREENSHOT_WORKFLOW.md`.

Build/commit under review: `0316133` plus local review note.
Viewport: `1365x768`.
View state: active dive.
Focused route: pressure-locked wreck route with predator warning visible.
Debug telemetry: hidden for player-facing readability.
Capture setup: camera/player placed near the lower pressure route; predator warning marker positioned in the same lower-route view to stress-test overlap.

Screenshots:

- Locked: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_pressure_gate_locked_predator_warning_2026_06_26.png`
- Open: `C:/Users/pirat/AppData/Roaming/Godot/app_userdata/OceanGame/oceangame_pressure_gate_open_predator_warning_2026_06_26.png`

## Findings

### Blockers

None.

The locked state remains understandable: the blue gate column, crossbars, and compact `LOCKED` badge are readable even with the red predator warning route crossing the same lower-route view. The predator warning does not hide the pressure label or make the route look safe.

The open state is also readable: the badge changes to `OPEN`, the gate color shifts green, and the softened bars read differently from the locked state. The player can distinguish an opened pressure route from the red predator lane.

### Polish

- The open green shimmer and red predator warning lane overlap in a visually busy way near the sub. This is acceptable for the prototype, but a future polish pass should reduce shimmer opacity or narrow the open-state column when predator warning is in the same view.
- The pressure gate and predator lane both use large translucent shapes. The color language is distinct enough, but future art should rely more on shape/detail separation instead of stacked transparent polygons.
- The active dive info panel remains off to the left and does not block the gate in this capture, but it still consumes a large horizontal band. Future HUD polish should keep pressure route captures in the screenshot checklist.

### No Action

- Do not change pressure-lock gameplay, upgrade gating, boundary denial, predator patrol, contact damage, or decoy behavior from this review.
- Do not add a map, checklist, new warning UI, or route marker.
- Do not create a follow-up bug solely from this review; the current state is acceptable for continuing the one-more-expedition milestone.

## Recommendation

Treat the current open pressure gate plus predator warning readability as pass-with-polish. Continue with the next roadmap issues. Revisit the overlap after broader HUD polish or after the predator/gate assets move from translucent placeholders to more final art.

