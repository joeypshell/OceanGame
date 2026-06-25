# Surface UI Layout Pass

Status: planning complete. Recommended future implementation issue title: `Add compact surface summary tabs`.

## Purpose

The surface state now carries more information than the first prototype HUD was built for: expedition results, recent expedition history, upgrade choices, banked resources, discoveries, prompts, and debug telemetry. Before adding more panels or content, the surface UI should be organized so the player can quickly answer:

- What happened on the last dive?
- What changed permanently?
- What can I buy or pursue next?
- How do I start the next expedition?

## Current UI Pressures

### Run Panel

The run panel owns the start and result summaries. It is the most important post-dive surface element because it explains extraction/failure and next action.

Pressure:

- Result summaries now include banked cargo, upgrade progress, discoveries, and best depth.
- Debug telemetry can expand the panel when F3 is enabled.

### Recent Expedition Log

The recent log gives continuity across the last three completed dives.

Pressure:

- It competes with banked resources, discoveries, status, prompts, scan target text, and oxygen warning on the left side.
- It is useful after results, but less important during active diving.

### Upgrade Bay

The upgrade bay is the main spend/progression surface after extraction.

Pressure:

- It must show selection, description, cost, state, missing requirements, and purchase feedback.
- It currently shares the right side with the run panel.

### Banked Resources

Banked resources explain purchase readiness.

Pressure:

- This list can grow as resources expand.
- It is important at the surface and less important during active movement unless the player is planning extraction.

### Discovery List

Discoveries help explain scan progress and unlocks.

Pressure:

- Discovery entries can become verbose.
- It can collide conceptually with a future field guide if it grows unchecked.

### Prompts And Status

Prompts and status are necessary because the prototype has several modes: ready, diving, extracted, failed, base safe, upgrade bay selection, purchase, scan, and debug telemetry.

Pressure:

- Prompt/status text should stay short and mode-specific.
- It should not become a tutorial wall.

## Recommendation

Implement compact surface summary tabs.

Concrete future implementation issue title: `Add compact surface summary tabs`.

This should be a simple surface-mode organization pass, not a new screen. When the dive is ready, extracted, or failed, the right-side surface area can present compact sections or simple tab-like modes for:

- `Result`,
- `Upgrades`,
- `Log`.

The first implementation may use keyboard cycling or simple labels rather than clickable UI. It should preserve the existing run panel and upgrade bay behavior while reducing simultaneous text density.

## Constraints

Do not add:

- a landing page,
- tutorial wall,
- nested card-heavy UI,
- base-management screen,
- crafting/inventory management UI,
- full field guide,
- minimap,
- mouse-driven shop redesign,
- decorative UI panels that do not reduce decision load.

Keep the surface base as a functional hub: read result, review progress, buy upgrade, start next dive.

## Expected Player Decision

The player should be able to quickly choose:

- restart immediately,
- buy an available upgrade,
- review recent expedition outcomes,
- check banked resources or discoveries only when relevant.

## Verification Criteria

- Result, upgrade, and recent-log information remain accessible at the surface.
- Text fits in the default desktop viewport.
- Dive start, extraction/failure results, upgrade selection, purchase, restart, and F3 telemetry still work.
- No in-game text becomes a tutorial wall.
- Active diving HUD remains readable and does not prioritize surface-only details.
- The implementation does not introduce a management sim layer.
