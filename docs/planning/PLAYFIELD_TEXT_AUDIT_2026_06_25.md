# Playfield Text Audit - 2026-06-25

Status: baseline audit for #103.

## Purpose

Recent playtest feedback says the current dive view is hard to understand because prototype text and placeholder graphics compete for the same space. This audit identifies the main text sources in `scenes/Main.tscn` and `scripts/main.gd`, then assigns the next action for each one.

This is an audit only. It does not change runtime behavior.

## Classification Key

- Keep: useful text that is already in a proper HUD/surface location.
- Shorten: text can remain but should use fewer words.
- Move to HUD/status: useful explanation should leave the world space.
- Replace with visual language: repeated meaning should become shape, color, marker, animation, or landmark design.
- Remove: text no longer earns its space.

## High-Priority World Text

| Source | Current Role | Problem | Action |
| --- | --- | --- | --- |
| `PressureLockedWreck/PressureLabel` | Names the pressure blocker and required upgrade. | It is useful, but it is a long sentence near a dense gate/wreck/scan area. When combined with cache and scan hints, it can crowd the route. | Shorten. Keep a compact blocker label for now, then rely more on gate bars/shimmer state. |
| `WreckSignalHint/SignalLabel` | Revealed future cache signal after scanning the outside wreck. | It labels a future payoff inside an already noisy pressure-lock area. It can look like another objective label instead of a subdued signal. | Replace with visual language or move explanation to HUD/status. |
| `VentRouteHint/RouteLabel` | Revealed optional warm-current clue after Thermal Vent scan. | It appears inside an active route area and can overlap with Shell Reef/Thermal Vent decisions. The arrow/ribbon should carry most of this meaning. | Remove or replace with a small marker. Keep explanation in scan status text. |
| Depth marker labels | Shows depth scale. | These are low-risk orientation labels on the side, but they still add text density. | Keep for now; revisit only if they compete with future art. |

## HUD And Surface Text

| Source | Current Role | Problem | Action |
| --- | --- | --- | --- |
| `HUD/Hint` and `HUD/BoundsHint` | Prototype control and loop hints. | Helpful for first launch, but they stay visible during dives and add constant text pressure. | Shorten or hide after expedition begins in a later issue. |
| `HUD/Upgrade` | Summarizes upgrade progress. | Can become long and competes with scan/status text. It is HUD text, not world text, so it is less harmful than labels over the route. | Keep, but consider compacting in a HUD cleanup issue. |
| `HUD/Status` | Reports scan, collection, warning, and action feedback. | This is the correct home for explanation, but some strings are long. | Keep and use more aggressively as the replacement for world labels. |
| `HUD/ScanTarget` | Names the selected scan target. | Correctly avoids labels over every target. | Keep. It should become the primary way to name scan focus. |
| `HUD/RunPanel/RunSummary` | Ready/result/surface explanation. | Correct location for longer explanation because it is not drawn over the play route. | Keep. Use for route summaries and condition briefings. |
| `HUD/RecentExpeditionLog` | Shows recent run history during active dive. | Useful, but it can add vertical HUD clutter while playing. | Keep for now; consider hiding/collapsing during active dives if HUD density remains high. |

## Scan Result And Route Copy

| Source | Current Role | Problem | Action |
| --- | --- | --- | --- |
| Shell Reef first scan guidance | Explains safer midwater bank route. | Useful, and currently delivered through status/result text rather than a world paragraph. | Keep in HUD/status, but keep compact. |
| Thermal Vent first scan guidance | Explains optional glow path and pressure-seal knowledge. | Useful, but should not require a world label to understand the revealed route. | Move to HUD/status only; remove or minimize route label. |
| Pressure-Locked Research Wreck guidance | Explains `Pressure Seal I` return step. | This is important progression guidance, but it currently stacks with a world pressure label and signal label. | Keep blocker label short; move return-step explanation to HUD/status/result. |
| Wreck Signal Cache guidance | Explains future scanner improvement. | Useful after entry, but not useful as persistent world text. | Keep in scan/result surfaces only. |
| Gulper Eel scan guidance | Explains warning current, patrol hint, and route timing. | It is already status/result text and should remain there. | Keep in HUD/status. Avoid adding predator world labels. |

## Visual Systems That Should Carry More Meaning

| Meaning | Current Visual Source | Next Action |
| --- | --- | --- |
| Safe return | `BaseReturnColumn`, `SurfaceSafetyGlow`, `ReefReturnCurrent`, `ReefReturnBeacon`, base direction HUD | Preserve as higher priority than optional route hints. |
| Pressure lock | `PressureShimmer`, `PressureGateTop/Bottom/Bars`, compact blocker label | Make bars/shimmer carry more lock meaning so label can shrink. |
| Future cache signal | `SignalArrow`, `SignalLight`, `SignalHalo` | Remove text label and make subdued signal shape do the work. |
| Optional Thermal Vent route | `WarmCurrentRibbon`, `VentRouteHint/RouteArrow`, hidden glow reveal | Remove route label and rely on low-opacity current/arrow plus scan status. |
| Shell Reef bank route | `ShellReefPocket`, `ReefReturnCurrent`, shell spawn candidates | Keep as landmark and return-current language, not label text. |
| Predator warning | `PredatorWarning`, `WarningCurrent`, `WarningMarker`, `GulperEel/PatrolHint` | Keep visual-only. Do not add world text near predator route. |

## Recommended Cleanup Order

1. Remove or replace `VentRouteHint/RouteLabel`.
2. Remove or replace `WreckSignalHint/SignalLabel`.
3. Shorten `PressureLockedWreck/PressureLabel`.
4. Move pressure-wreck return-step explanation fully into status/result text.
5. Consider hiding first-launch control hints after the expedition begins.
6. Review active-dive HUD density after the world-label cleanup.

## Success Check For Follow-Up Issues

At normal camera scale, the player should be able to see:

- the sub/player,
- the nearest pickup,
- the selected scan target marker,
- the pressure gate state,
- the predator warning route,
- the optional current hint,
- and the safe return direction,

without reading or fighting overlapping paragraphs in the ocean.
