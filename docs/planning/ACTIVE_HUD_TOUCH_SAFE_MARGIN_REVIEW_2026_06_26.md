# Active HUD Touch-Safe Margin Review - 2026-06-26

Status: desktop pass, mobile-like landscape unverified.

Issue: #398.

## Purpose

Review current active HUD placement at the proven desktop landscape viewport and against future mobile/iPhone landscape constraints without adding touch controls, mobile export settings, controller support, minimaps, field guides, quest checklists, combat, or broad UI redesign.

## Evidence

- Current Playwright visual smoke metadata records the active HUD captures at `1280x720`.
- Recent captures include active dive, lower-route pressure gate, Wreck Echo staged route, low oxygen, and critical oxygen states.
- `scenes/Main.tscn` active HUD surfaces are fixed desktop-layout controls: `ActiveStatsPanel` at the top-left, `DiveInfoPanel` below it, and `OxygenWarningPanel` near the top-right.

## Findings

| Area | Desktop Landscape Read | Mobile-Like Landscape Risk | Decision |
| --- | --- | --- | --- |
| Top-left active stats | Pass. O2, depth, base direction, cargo, discoveries, and cargo slots stay bounded in the active HUD. | Could become too close to the left edge or future virtual movement controls if touch controls occupy a left thumb zone. | Keep for current desktop slice. |
| Dive info panel | Pass with watchlist. Scan target, prompt, and status stay in one bounded panel and no longer spill across the playfield. | The panel may compete with a future bottom/side touch-control region if the same layout is simply scaled down. | Keep for current slice; re-evaluate with mobile-like captures. |
| Oxygen warning panel | Pass on `1280x720`. Warning lives away from the main stats and keeps oxygen urgency visible. | Fixed right-edge placement needs safe-area testing for phone notches, rounded corners, and browser canvas scaling. | Keep, but mark as unverified for mobile-like landscape. |
| World readability | Pass with watchlist. HUD does not cover the lower-route pressure/cache/predator/reward cluster in current desktop captures. | Smaller landscape widths may reduce readable world space if HUD remains the same relative footprint. | Require mobile-like evidence before mobile UI work. |
| Future touch controls | Not implemented and not needed for the current desktop slice. | Touch zones could conflict with active HUD unless semantic actions and safe areas are planned first. | Defer implementation; feed into #399. |

## Decision

The current active HUD is acceptable for the desktop vertical slice and should not be redesigned in this issue.

Mobile/iPhone landscape support remains a future target, but it is not proven by the current screenshot workflow. Before implementing touch controls, the project needs a mobile-like screenshot/capture plan that checks at least:

- active normal dive,
- active low and critical oxygen,
- lower-route pressure/cache view,
- Wreck Echo route view,
- extraction/result surface panel,
- future virtual-control safe zones.

## Follow-Up For #399

Add either a documented mobile-like viewport workflow or a small Playwright capture scaffold. The first version should be evidence-only: it should capture or document mobile-like landscape views without adding touch controls, changing gameplay, or declaring mobile support complete.

## Non-Goals

- No touch overlay.
- No controller implementation.
- No mobile export preset.
- No HUD redesign.
- No minimap, field guide, quest checklist, or objective panel.
