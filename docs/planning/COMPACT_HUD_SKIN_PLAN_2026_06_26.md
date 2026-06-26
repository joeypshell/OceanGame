# Compact HUD Skin Plan - 2026-06-26

Status: planning artifact for issue #228.

## Purpose

Define the first compact HUD skin pass before implementation. This plan builds on `docs/planning/ACTIVE_DIVE_HUD_REVIEW_2026_06_26.md` and the UI item in `docs/planning/VISUAL_REPLACEMENT_PLAN.md`.

The goal is to make oxygen, depth, base direction, cargo, scan target, prompt/status, and warnings feel like a cohesive cozy sci-fi research HUD without bringing back the earlier playfield text clutter.

## Visual Goals

- Use compact dark translucent panels with thin cyan/blue-gray borders and warm accent pips for warnings.
- Treat oxygen as the highest-priority active-dive read, with low/critical states visible but not overpowering route visibility.
- Keep depth and base direction as quick-glance navigation data rather than large labels.
- Keep cargo as slots and tiny resource mini-icons first and text second; avoid item-name lists during active dives.
- Keep scan target, prompt, and status inside the bounded dive info panel.
- Make empty, filled, and locked cargo states visually distinct before adding more inventory affordances.
- Reserve stronger animation/pulse for critical oxygen and temporary scan/echo events only.

## HUD Surfaces

Active dive:

- upper-left operational cluster: oxygen, depth, base direction, compact cargo count,
- cargo slot row near the cargo count,
- bounded dive info panel for scan target, prompt, and one-line status,
- upper-right oxygen warning panel only for low/critical oxygen.

Surface/result:

- keep the existing ready/result/failure panel ownership,
- keep active-dive operational rows hidden while ready/result panels are active,
- keep upgrade bay and recent expedition log in surface tabs rather than active dive UI.

Debug:

- seed, pattern, condition id, predator route, failure cause, and oxygen-at-result remain behind debug telemetry,
- no debug values should be styled as player-facing HUD elements.

## Non-Goals

- No minimap.
- No inventory grid.
- No field guide.
- No permanent objective checklist.
- No route graph or exact locator.
- No new debug data.
- No banked resources, upgrade details, recent expedition history, or full discovery lore in active dive mode.
- No change to oxygen, cargo, scan, extraction, save/load, or upgrade rules.

## Implementation Shape

Recommended first implementation issue:

1. Add reusable style resources or local theme overrides for the active HUD panels and labels.
2. Skin `Oxygen`, `Depth`, `BaseDirection`, `Cargo`, `CargoSlots`, `DiveInfoPanel`, and `OxygenWarningPanel`.
3. Preserve the current active/surface visibility gating in `scripts/main.gd`.
4. Keep label text and formatter behavior compact; do not expand copy to fit the skin.
5. Verify at surface-ready, normal dive, low oxygen, critical oxygen, full cargo, locked fourth slot, selected scan target, and result panel states.

## Acceptance Checklist For Implementation

- Active dive HUD remains panel-bounded and does not overlap the player, route gates, scan markers, or resource pickups.
- Low/critical oxygen warnings are clear but do not hide scan/status text.
- Cargo slots still show filled, empty, and locked states.
- Scan target, prompt, and status remain compact.
- Surface ready/result/failure modes do not show active operational rows.
- Debug telemetry remains gated behind F3.
- Logic tests continue to cover compact HUD helper behavior and cargo slot states.
- Manual screenshot review covers at least one normal dive and one low/critical oxygen state.
