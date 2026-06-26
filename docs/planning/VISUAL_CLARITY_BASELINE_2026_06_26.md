# Visual Clarity Baseline - 2026-06-26

## Status

Baseline captured for #143 before the visual language and asset replacement batch.

This review consolidates the current normal-scale readability state after the HUD separation, compact marker, condition-visual, and first condition-weighting work. It uses the existing scene/readability reviews plus the latest user-provided screenshots as baseline evidence.

## Evidence

Recent local screenshot evidence:

- `C:/Users/pirat/AppData/Local/Temp/codex-clipboard-089accf8-0489-4eb4-bd17-3623dfb31bd2.png`
- `C:/Users/pirat/AppData/Local/Temp/codex-clipboard-866ab801-a5c5-46d9-bd88-a6c014407356.png`
- `C:/Users/pirat/AppData/Local/Temp/codex-clipboard-8306afb1-94b7-4d57-b9c7-f1f2c41c4b44.png`
- `C:/Users/pirat/AppData/Local/Temp/codex-clipboard-0aae9333-7566-43ca-9a1e-82e34cab173e.png`

Supporting review docs:

- `docs/planning/PLAYFIELD_TEXT_AUDIT_2026_06_25.md`
- `docs/planning/NORMAL_SCALE_READABILITY_REVIEW_2026_06_25.md`
- `docs/planning/LOWER_ROUTE_VISUAL_OVERLAP_REVIEW_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_VISUAL_CLARITY_FOUNDATION_2026_06_26.md`

Repeatable capture tooling is still pending in #155 and #156. Until then, this baseline records the current view requirements, known screenshot evidence, and visual blockers for the asset/readability batch.

## Baseline View Set

### Surface Ready

Expected baseline view:

- surface/base origin visible,
- expedition ready panel visible,
- active dive HUD rows hidden,
- start/reset instructions readable,
- current condition and goal copy bounded to the panel.

Current read:

- Much improved after the HUD mode separation.
- A previous pre-dive screenshot showed loose text overlap; current implementation should keep surface instructions inside the ready panel.
- The surface base still needs a stronger silhouette so it reads as a place, not just a start marker.

Visual blocker:

- The base/boat/lab identity is not yet emotionally strong enough for the future morning/evening/sleep rhythm.

### Early Dive

Expected baseline view:

- player visible,
- base/safe return visible,
- first reachable resource visible,
- compact operational HUD visible,
- no loose surface tutorial text covering play.

Current read:

- The active dive HUD is now significantly less obstructive than the earlier screenshot with large overlapping text.
- Safe return is present through the base direction text, return column, and return visual language.
- Resource silhouettes still look like placeholder polygons and depend too much on color/position.

Visual blocker:

- First resource readability is adequate for testing but not strong enough for "one more expedition day" appeal.

### Midwater Shell Reef

Expected baseline view:

- Shell Reef reads as a safer midwater banking pocket,
- Shell Fragments remain readable,
- safe return is stronger than optional deeper temptation,
- player can understand bank-or-push choice.

Current read:

- Shell Reef benefits from being a visual landmark instead of a paragraph label.
- The reef pocket, return-current shapes, and shell pickups are still visually close to other translucent route/background shapes.
- The pocket needs a clearer material/silhouette family so it becomes a remembered place.

Visual blocker:

- Shell Reef is functionally meaningful but not yet memorable as a region-like anchor.

### Thermal Vent

Expected baseline view:

- Thermal Vent reads as warm and different from Shell Reef,
- optional glow temptation is visible but not mandatory-looking,
- `Thermal Bloom` can emphasize the vent without overwhelming safe return,
- scan/current cue remains partial information, not a checklist arrow.

Current read:

- Thermal Vent has warmer visual language and can receive condition emphasis.
- Vent-adjacent Glow Plankton now has authored weighting under `Thermal Bloom`.
- The vent pocket still needs clearer silhouette and atmospheric separation from generic translucent polygons.

Visual blocker:

- Thermal Vent is currently readable as a cue, but not yet strong enough as a mysterious place that explains why the ocean changed today.

### Pressure Lock And Wreck

Expected baseline view:

- locked route reads as blocked,
- pressure gate differs from current hints and reward glow,
- wreck/cache promise is visible but not louder than return/danger cues,
- player wants to return after `Pressure Seal I`.

Current read:

- Compact `LOCKED`/`OPEN` marker and pressure bars are a major improvement over long world text.
- The lower route remains visually dense: pressure shimmer, wreck signal, cache cue, scan marker, reward glow, and predator visuals compete in the same neighborhood.
- The pressure wreck is the clearest current example of "I saw something I cannot reach yet," so it should receive careful visual priority.

Visual blocker:

- The forbidden-route promise exists mechanically, but the wreck needs a stronger silhouette and separation so it creates desire instead of confusion.

### Gulper Route

Expected baseline view:

- predator danger is readable before contact,
- danger language is distinct from reward and pressure lock,
- route timing is learnable,
- Glow Plankton reward remains visible without hiding safe return.

Current read:

- Red warning current, warning eye, and compact danger marker distinguish the route better than earlier versions.
- The route can still become visually noisy when deep reward lure, predator warning, haze, and lower-route signals are all visible.
- The `Gulper Eel` needs a more recognizable creature silhouette for the future learnable-behavior loop.

Visual blocker:

- Danger is present, but the creature does not yet feel memorable enough to support monster research as a future compulsion hook.

## Cross-Cutting Findings

1. Text is no longer the worst blocker.
   - The worst current issue is visual priority: translucent placeholders, similar polygon language, and overlapping cue families.

2. Safe return must remain the highest-priority cue.
   - Any asset pass that brightens rewards, danger, or condition effects must re-check base orientation.

3. Region memory is weak.
   - Shell Reef, Thermal Vent, pressure wreck, and Gulper route are mechanically distinct, but their silhouettes are still too placeholder-like.

4. The first asset pass should prioritize meaning over beauty.
   - Player/base, resources, locks, rewards, danger, and landmark pockets need distinct shape families before polish.

5. The compulsion identity depends on readability.
   - The day/sleep/ocean-change loop will only work if players can recognize what stayed stable and what changed today.

## Recommended Use For Next Issues

- #144 should turn this baseline into visual language rules.
- #145 should centralize reusable marker patterns so cue meaning is tunable.
- #146 through #152 should use this baseline as the before-state for resource, base/player, depth-band, Shell Reef, Thermal Vent, pressure/wreck, and Gulper-route passes.
- #153 should compare post-asset screenshots against this baseline, especially in the lower-route cluster.

## Verification

- `git diff --check`
