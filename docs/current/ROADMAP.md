# Current Roadmap

This roadmap is a compact guide for issue-driven Codex work. GitHub Issues remain the active task contract; this file explains the active milestone, immediate issue order, success gates, completed work, and deferred scope.

Current direction: build a 2D alien-ocean expedition game where every morning the ocean changes, the player dives for cargo and knowledge, and persistent discoveries plus upgrades unlock deeper remembered places.

Detailed design rules live in:

- `docs/planning/CORE_LOOP_RULES.md`
- `docs/planning/DAILY_RUNS.md`
- `docs/planning/EXPEDITION_CONDITION_BRIEFING.md`
- `docs/planning/EXPEDITION_DAY_CONDITIONS.md`
- `docs/planning/CONDITION_REVIEW_MATRIX_2026_06_26.md`
- `docs/planning/HYBRID_OCEAN_MODEL.md`
- `docs/planning/GAME_VISION.md`
- `docs/planning/PROGRESSION_LADDER.md`
- `docs/planning/PREDATOR_INTERACTION_DIRECTION.md`
- `docs/planning/BLIND_VALIDATION_KIT.md`
- `docs/planning/SCANNER_IMPROVEMENT_I.md`
- `docs/planning/SCANNER_PROGRESSION_V2.md`
- `docs/planning/CARGO_IMPROVEMENT_I.md`
- `docs/planning/EXPEDITION_GOAL_II.md`
- `docs/planning/BURST_THRUSTER_MILESTONE.md`
- `docs/planning/MONSTER_OBSERVATION_I.md`
- `docs/planning/MONSTER_RESEARCH_LOOP_V1.md`
- `docs/planning/NORMAL_SCALE_READABILITY_CHECKLIST.md`
- `docs/planning/LOWER_ROUTE_VISUAL_OVERLAP_REVIEW_2026_06_26.md`
- `docs/planning/PREDATOR_WARNING_I.md`
- `docs/planning/PREDATOR_COUNTERMEASURE_I.md`
- `docs/planning/REGION_LANDMARK_METADATA.md`
- `docs/planning/REGION_IDENTITY_MAP_V1.md`
- `docs/planning/BIOME_POCKET_I.md`
- `docs/planning/BIOME_POCKET_II.md`
- `docs/planning/SHELL_REEF_ROUTE_REVIEW.md`
- `docs/planning/SHELL_REEF_ROUTE_REVIEW_2026_06_25.md`
- `docs/planning/SURFACE_UI_LAYOUT_PASS.md`
- `docs/planning/VISUAL_LANGUAGE_READABILITY_ASSETS.md`
- `docs/planning/ART_DIRECTION.md`
- `docs/planning/VISUAL_REPLACEMENT_PLAN.md`
- `docs/planning/ASSET_SOURCE_PIPELINE_V1.md`
- `docs/planning/VISUAL_CLARITY_BASELINE_2026_06_26.md`
- `docs/planning/VISUAL_PASS_IMPACT_REVIEW_2026_06_26.md`
- `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md`
- `docs/planning/PRESSURE_GATE_PREDATOR_WARNING_REVIEW_2026_06_26.md`
- `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md`
- `docs/planning/NEXT_VERTICAL_SLICE_MILESTONE_2026_06_26.md`
- `docs/planning/ACTIVE_HUD_NORMAL_SCALE_SCREENSHOT_REVIEW_2026_06_26.md`
- `docs/planning/RESOURCE_ECONOMY_TUNING_I.md`
- `docs/planning/THERMAL_VENT_ROUTE_REVIEW_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_AFTER_SHELL_REEF_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_THERMAL_VENT_DECOY_2026_06_25.md`
- `docs/planning/BACKLOG_REPLENISHMENT_DEMO_READABILITY_HYBRID_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_VISUAL_CLARITY_FOUNDATION_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_AFTER_VISUAL_CLARITY_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_EXPEDITION_IDENTITY_VISUALS_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_PLAYABLE_LOOP_POLISH_2026_06_26.md`
- `docs/planning/BACKLOG_REPLENISHMENT_VERTICAL_SLICE_READABILITY_2026_06_26.md`
- `docs/planning/COMPULSION_IDENTITY_2026_06_26.md`
- `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_CHECKLIST_2026_06_26.md`
- `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_FINDINGS_2026_06_26.md`
- `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`
- `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`

Implemented architecture lives in `docs/current/ARCHITECTURE.md`.
Implemented behavior lives in `docs/current/GAMEPLAY.md`.
Implemented tooling lives in `docs/current/TOOLING.md`.
Screenshot workflow lives in `docs/current/SCREENSHOT_WORKFLOW.md`.
Optional local Godot editor MCP policy lives in `docs/current/GODOT_MCP.md`.

## Active Milestone

Playable Vertical Slice Readability And Cohesion.

Status: current planning updated after the Wreck Echo, source-art, HUD, and playable-slice acceptance passes. The next issue queue should come from `docs/planning/NEXT_VERTICAL_SLICE_MILESTONE_2026_06_26.md`.

Goal: make the existing side-view expedition slice playable and understandable at normal scale without developer explanation. The focus is not more breadth; it is loop clarity, active HUD skinning, lower-route readability, source-art/fallback balance, and acceptance evidence for the current upgrade and route promises.

Current implemented signal: the prototype now has practical scan/cargo upgrades, `Gulper Eel` observation, `Predator Warning I`, `Decoy Pulse I`, `Echo Lens I`, surface result memory, compact surface views, clean-save reset, HUD mode separation, runtime compact markers, authored and reviewed `Shell Reef` and `Thermal Vent` route pockets, pressure wreck/cache follow-through, a documented hybrid-ocean model, expedition-day condition data, first source/export sprites for the player, boat, resources, creatures, and major landmarks, reusable readability scenes, screenshot workflow, debug seed/condition helpers, asset source conventions, and a playable vertical-slice acceptance checklist.

Latest direction update: `docs/planning/BACKLOG_REPLENISHMENT_AFTER_VISUAL_CLARITY_2026_06_26.md` promotes the next milestone around the "one more expedition day" loop: day framing, remembered regions, creature/scanner research payoff, first source-art replacement, and mystery/access planning.

Visual identity update: `docs/planning/ART_DIRECTION.md` and `docs/planning/VISUAL_REPLACEMENT_PLAN.md` define the desired polished direction as a cozy research expedition into a beautiful but increasingly impossible alien ocean. Polished visuals remain deferred until the gameplay loop is validated, and the current task is planning/integration only, not a full art overhaul.

Backlog replenishment update: `docs/planning/BACKLOG_REPLENISHMENT_EXPEDITION_IDENTITY_VISUALS_2026_06_26.md` adds the next ordered twenty-issue queue after the current one-more-expedition motivation set. The queue keeps the focus on expedition-day identity, scan/result memory, source-art follow-through, reusable visual extraction, player-facing HUD readability, and mystery/scanner planning.

Playable-loop polish update: `docs/planning/BACKLOG_REPLENISHMENT_PLAYABLE_LOOP_POLISH_2026_06_26.md` defines the next ordered queue after #180-#199. The focus moves to narrow `Echo Lens I` implementation, expedition-day review evidence, visual slot standardization, first creature/landmark source-art follow-through, HUD review, provenance, and another backlog refresh.

Vertical-slice polish queue: `docs/planning/BACKLOG_REPLENISHMENT_AFTER_PLAYABLE_LOOP_POLISH_2026_06_26.md` creates issues #220-#239. The focus is Wreck Echo visual follow-through, pressure wreck/cache sprite decisions, local scan/echo feedback, Shell Reef and HUD polish, condition readability review, and first vertical-slice acceptance planning.

Selected scanner curiosity plan: `docs/planning/SCANNER_PROGRESSION_V2.md` now defines `Echo Lens I` as the next scanner upgrade candidate after `Signal Lens I`. It should stay gated by `Wreck Signal Cache` plus `Signal Lens I`, use vague echo/category/direction language, and avoid minimaps, exact-coordinate tracking, field-guide UI, broad scanner economy, or checklist behavior.

Mystery signal note: `docs/planning/MYSTERY_SPINE_V1.md` now frames the pressure wreck and `Wreck Signal Cache` as a remembered-place signal chain. The intended read is future deeper access and scanner curiosity, not a quest log, exact locator, or guaranteed safe route.

Deeper-access direction: `docs/planning/DEEPER_ACCESS_AFTER_ECHO_LENS_2026_06_26.md` selects `Wreck Echo Descent` as the later post-`Echo Lens I` promise and now defines it as one authored deeper-right route pocket candidate. The pocket should require preparation around pressure access, scanner curiosity, oxygen margin, and optional cargo space; it should reward one compact research clue, rare material opportunity, or later prerequisite discovery, not a new generated biome, minimap, field guide, exact locator, or quest checklist.

Expedition-day review checklist: `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_CHECKLIST_2026_06_26.md` defines five F5-driven review passes for ready panel, result panel, remembered region, condition copy, scan-only usefulness, and safe-return readability using the screenshot workflow.

Expedition-day review findings: `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_FINDINGS_2026_06_26.md` reviewed seeds `8919`, `16838`, `24757`, `32676`, and `40595`. The highest-priority follow-up is to remove or debug-gate the `F9 resets prototype save` instruction from the normal ready panel.

Visual asset slot review: `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md` confirms the current sprite/fallback slot coverage for player, surface base, resources, Lantern Fry, Gulper Eel, Thermal Vent, Shell Reef, pressure wreck, and Wreck Signal Cache, with follow-ups for larger art replacements.

Compact HUD skin plan: `docs/planning/COMPACT_HUD_SKIN_PLAN_2026_06_26.md` defines the first HUD skin pass for oxygen, depth, base direction, cargo slots, scan target, prompt/status, and warning panel. The implementation should keep debug telemetry gated, preserve active/surface mode separation, and avoid minimap, inventory-grid, field-guide, or objective-checklist scope.

Rare Signal condition review: `docs/planning/RARE_SIGNAL_CONDITION_READABILITY_REVIEW_2026_06_26.md` confirms the current `Rare Signal` copy and faint Wreck Shelf shimmer are acceptable as presentation-only Wreck Echo curiosity. The emphasis must stay subtle/local and avoid exact locators, persistent markers, quest checklists, cache guarantees, and upgrade shortcuts.

Wreck Shift condition review: `docs/planning/WRECK_SHIFT_CONDITION_READABILITY_REVIEW_2026_06_26.md` keeps `Wreck Shift` flavor-only for now. Any future visual emphasis must read as wreck-angle/approach variation, not a moved/open pressure gate, alternate entrance, pressure-boundary change, cache reveal, or `Pressure Seal I` bypass.

Vertical-slice art-kit readiness: `docs/planning/VERTICAL_SLICE_ART_KIT_READINESS_REVIEW_2026_06_26.md` says the project is ready for a cohesive vertical-slice art integration pass, but not final production art lock. Highest-priority gaps are waterline/moonpool polish, sub idle/thrust state readability, lower-route density, compact HUD skin, and landmark sprite/fallback balance.

Playable vertical-slice acceptance: `docs/planning/PLAYABLE_VERTICAL_SLICE_ACCEPTANCE_CHECKLIST_2026_06_26.md` defines the first playable/polished slice gate across loop playability, visual readability, upgrade/route coverage, non-goals, and verification. It is the quality bar for the next milestone, not a request to expand final-game scope.

Next milestone definition: `docs/planning/NEXT_VERTICAL_SLICE_MILESTONE_2026_06_26.md` distinguishes current, next, deferred, and out-of-scope work for the playable vertical slice. Current work should improve the existing loop and readability; next work can plan deeper Wreck Echo promise only after the slice is clearer; deferred work stays out of the immediate queue.

Backlog replenishment update: `docs/planning/BACKLOG_REPLENISHMENT_VERTICAL_SLICE_READABILITY_2026_06_26.md` creates issues #240-#259 from the current milestone. The batch prioritizes compact HUD skinning, normal-scale readability evidence, lower-route density cleanup, sprite/fallback reviews, acceptance evidence, and narrow Wreck Echo planning.

Active HUD screenshot review: `docs/planning/ACTIVE_HUD_NORMAL_SCALE_SCREENSHOT_REVIEW_2026_06_26.md` confirms the compact active HUD skin is directionally working at normal scale. The immediate follow-up is to move or restyle the active `Discoveries` count, which currently sits between the stats and dive-info panels.

## Immediate Issue Order

Current playable-slice track:

- Implement the compact active-dive HUD skin without restoring playfield text clutter.
- Capture normal-scale screenshot evidence for surface ready, active dive, pressure lock/open, predator route, and result UI.
- Reduce lower-route density where pressure wreck, cache, rare-signal shimmer, deep reward, and predator danger overlap.
- Review sprite/fallback balance for Shell Reef, Thermal Vent, pressure wreck, Wreck Signal Cache, and Gulper route.
- Verify the acceptance checklist through short manual smoke runs once the HUD/readability passes land.

Next planning track:

- Plan the later `Wreck Echo Descent` pocket only after the current slice reads cleanly.
- Keep Echo Lens curiosity broad and local; avoid locator, map, field-guide, or checklist UI.
- Select the next source-art replacement based on readability impact, not asset novelty.

Deferred and out-of-scope track:

- Defer large biomes, broad economy, advanced monster-hunting systems, production animation, audio, web polish, save-slot UI, and base-management layers.
- Keep minimap, route graph, exact scanner locator, objective checklist, weapons, predator harvesting, full procedural ocean, daily challenge calendar, inventory grid, and final production-art lock out of this milestone.

Historical ordered issue batches:

Next vertical-slice readability batch from `docs/planning/BACKLOG_REPLENISHMENT_VERTICAL_SLICE_READABILITY_2026_06_26.md`:

1. #240 Implement compact active-dive HUD skin.
2. #241 Add normal-scale active HUD screenshot review.
3. #242 Add surface ready and result readability review.
4. #243 Reduce lower-route visual density around pressure wreck and predator route.
5. #244 Tune Rare Signal and cache cues for local mystery readability.
6. #245 Review Shell Reef sprite and fallback balance.
7. #246 Review Thermal Vent sprite and fallback balance.
8. #247 Review pressure wreck and Wreck Signal Cache sprite/fallback balance.
9. #248 Review Gulper route danger readability with current sprites.
10. #249 Add playable vertical-slice manual smoke acceptance log.
11. #250 Add vertical-slice acceptance status summary to current docs.
12. #251 Add Echo Lens no-locator regression coverage.
13. #252 Plan Wreck Echo Descent implementation constraints.
14. #253 Plan the next source-art replacement priority after readability reviews.
15. #254 Review expedition condition visuals against playable-slice acceptance.
16. #255 Add screenshot workflow note for acceptance evidence naming.
17. #256 Add compact result-memory readability review.
18. #257 Review upgrade bay readability against current upgrade set.
19. #258 Update MCP context resources after vertical-slice readability planning.
20. #259 Replenish backlog after vertical-slice readability batch.

Completed ordered replenishment batch from `docs/planning/BACKLOG_REPLENISHMENT_EXPEDITION_IDENTITY_VISUALS_2026_06_26.md`:

1. #180 Add expedition day number to result and ready panel state.
2. #181 Add remembered-region result line from the deepest meaningful landmark reached.
3. #182 Add first-time discovery memory line for Thermal Vent, Shell Reef, Wreck, and Gulper scans.
4. #183 Add no-cargo useful-dive result copy when the player returns with scans only.
5. #184 Replace Kelp Fiber with a first source/export sprite.
6. #185 Replace Shell Fragments with a first source/export sprite.
7. #186 Add sprite-ready Lantern Fry visual slot and idle motion polish.
8. #187 Add sprite-ready Gulper Eel visual slot and state color polish.
9. #188 Extract resource pickup visuals into reusable child scenes.
10. #189 Extract Thermal Vent pocket visuals into a reusable scene.
11. #190 Add scan pulse visual helper for resource highlight feedback.
12. #191 Add low-oxygen visual warning treatment to player-facing HUD.
13. #192 Add cargo slot UI placeholders for player-facing cargo readability.
14. #193 Add surface result panel hierarchy review and copy tightening.
15. #194 Add scanner echo copy for Wreck Signal Cache repeat scans.
16. #195 Plan Echo Lens I as the next scanner curiosity upgrade.
17. #196 Add mystery signal planning notes to pressure-wreck and cache docs.
18. #197 Add five-seed expedition-day review checklist.
19. #198 Review visual asset slots after resource/landmark extraction.
20. #199 Replenish backlog after expedition identity and visual follow-through.

Candidate backlog should stay focused on clean playtesting, readability, and narrow hybrid-ocean variation, not new systems for their own sake.

Next ordered replenishment batch from `docs/planning/BACKLOG_REPLENISHMENT_PLAYABLE_LOOP_POLISH_2026_06_26.md`:

1. #200 Add `Echo Lens I` upgrade definition.
2. #201 Implement `Echo Lens I` Wreck Signal Cache broad echo.
3. #202 Add Echo Lens result-memory line when an echo fires.
4. #203 Run the expedition-day five-seed review and record findings.
5. #204 Fix the highest-priority issue found in the five-seed expedition-day review.
6. #205 Standardize `SurfaceBaseArt` into sprite/fallback visual groups.
7. #206 Extract `ShellReefPocket` visuals into a reusable scene.
8. #207 Add first source/export Lantern Fry sprite.
9. #208 Add first source/export Gulper Eel sprite.
10. #209 Add first source/export Thermal Vent sprite.
11. #210 Add first source/export pressure-wreck/cache visual study.
12. #211 Add compact scan/echo visual effect source asset.
13. #212 Review active HUD after oxygen and cargo slot changes.
14. #213 Add upgrade-bay affordance pass for newly planned scanner upgrade.
15. #214 Add Wreck Shelf route review with Echo Lens planning active.
16. #215 Add deeper-access planning note after Echo Lens I.
17. #216 Review asset provenance coverage for all committed sprite sources.
18. #217 Add screenshot checklist for first polished vertical-slice art kit.
19. #218 Update MCP context resources after playable-loop polish planning.
20. #219 Replenish backlog after playable-loop polish.

Next vertical-slice polish batch from `docs/planning/BACKLOG_REPLENISHMENT_AFTER_PLAYABLE_LOOP_POLISH_2026_06_26.md`:

1. #220 Add `Wreck Signal Cache` first source/export sprite.
2. #221 Add pressure wreck outside scan source/export sprite.
3. #222 Extract `PressureLockedWreck` fallback visuals into reusable scene.
4. #223 Prototype local `Echo Lens` pulse visual using scan echo asset.
5. #224 Add Wreck Echo Descent route pocket plan.
6. #225 Add pressure-dark threshold visual study asset.
7. #226 Add Shell Reef pocket first source/export landmark asset.
8. #227 Add Shell Reef Shelf scan target source/export sprite.
9. #228 Plan compact HUD skin for oxygen depth cargo and scan.
10. #229 Prototype cargo slot resource mini-icons.
11. #230 Add Rare Signal condition readability review.
12. #231 Add Wreck Shift condition readability review.
13. #232 Prototype Rare Signal visual emphasis without objective marker.
14. #233 Review normal-scale vertical-slice art kit readiness.
15. #234 Add waterline and boat moonpool readability polish.
16. #235 Add sub idle bubble and thrust sprite polish review.
17. #236 Add pressure wreck cache provenance-to-scene review.
18. #237 Add playable vertical-slice acceptance checklist.
19. #238 Update roadmap around next vertical-slice milestone.
20. #239 Replenish backlog after vertical-slice milestone update.

Keep all issues narrow. Do not add a field guide, minimap, cargo grid, protected cargo, broad active-tool suite, weapons, predator harvesting, full procedural biomes, large art sets, oxygen refills, new resource systems, a region-select screen, or real-calendar daily challenges during this milestone.

## Rolling Backlog Policy

Maintain about 10-20 open actionable GitHub issues. When the queue drops below that target, expand planning docs first if needed, then create scoped issues with acceptance criteria, relevant docs/code areas, dependencies, and verification steps.

Do not create filler issues just to hit the number. Prefer a slightly smaller queue over vague epics, duplicate work, or issues for intentionally deferred systems.

## Active Milestone Success Gate

The milestone succeeds only when:

- restarting reads as another expedition day rather than a technical reset,
- at least one creature-route encounter can produce useful research feedback,
- the Wreck Signal Cache creates a scanner curiosity hook without map/checklist UI,
- `Echo Lens I` has a scoped next-upgrade plan that extends scanner curiosity without replacing `Signal Lens I`,
- one source-art asset replaces a gameplay-readable placeholder with provenance,
- one heavy visual cluster begins moving out of `Main.tscn`,
- region and mystery planning identify what the player should remember tomorrow,
- condition/seed reviews are repeatable using the documented screenshot/debug workflow,
- no new feature obscures surface direction, safe return, depth-band identity, or major upgrade-gated route promises.

Technical implementation alone is not sufficient.

## Progression Candidate Order

Choose from these candidates rather than starting all of them:

Current ordered batch:

The next issues are defined in `docs/planning/BACKLOG_REPLENISHMENT_AFTER_VISUAL_CLARITY_2026_06_26.md`. Work them in order unless a blocking implementation detail forces a narrow reorder.

Current queue: the next GitHub issue batch created from `docs/planning/BACKLOG_REPLENISHMENT_PLAYABLE_LOOP_POLISH_2026_06_26.md`. Work these in order unless an implementation dependency forces a narrow reorder.

Recently completed:

- #199 replenished the queue as `Playable Loop Polish` with narrow follow-through around `Echo Lens I`, expedition-day review evidence, visual slot standardization, first creature/landmark source-art assets, HUD review, and provenance.
- #198 reviewed current visual asset slots in `docs/planning/VISUAL_ASSET_SLOT_REVIEW_2026_06_26.md` and expanded scene-contract tests for player/surface visual slots.
- #197 added the five-seed/F5-driven expedition-day review checklist in `docs/planning/EXPEDITION_DAY_FIVE_SEED_REVIEW_CHECKLIST_2026_06_26.md`.
- #196 clarified the pressure-wreck/cache mystery signal in `docs/planning/MYSTERY_SPINE_V1.md`.
- #195 planned `Echo Lens I` as the next scanner curiosity upgrade in `docs/planning/SCANNER_PROGRESSION_V2.md`.
- #194 formalized the Wreck Signal Cache cache-echo repeat scan copy.
- #193 tightened surface result panel hierarchy and copy.
- #192 added compact cargo slot placeholders to the active HUD.
- #191 added low/critical oxygen HUD warning treatment.
- #190 added reusable scan pulse visual helper coverage.
- #189 extracted Thermal Vent pocket visuals into a reusable scene.
- #188 extracted resource pickup visuals into reusable child scenes.
- #187 added Gulper Eel visual state slots.
- #186 added Lantern Fry visual slot and idle polish.
- #185 replaced Shell Fragments with the first source/export sprite.
- #184 replaced Kelp Fiber with the first source/export sprite.
- #183 added no-cargo useful-dive result copy for scan-only returns.
- #182 added first-time discovery memory lines.
- #181 added remembered-region result lines.
- #180 added expedition-day number framing to ready/result states.
- #174 closed the one-more-expedition replenishment pass in `docs/planning/BACKLOG_REPLENISHMENT_ONE_MORE_EXPEDITION_CLOSEOUT_2026_06_26.md`, confirming #180 through #199 as the next ordered queue.
- #173 planned the first Wreck Echo mystery spine in `docs/planning/MYSTERY_SPINE_V1.md`, connecting pressure-wreck memory, Wreck Signal Cache, `Signal Lens I`, and future `Echo Lens I` without adding map or quest UI.
- #172 tuned ready-panel condition copy into a compact `Today:` briefing that points to implemented cues without exposing debug ids or implying unimplemented systems.
- #171 added the F3/F4/F5 condition review matrix in `docs/planning/CONDITION_REVIEW_MATRIX_2026_06_26.md`.
- #170 added stable region names and player memory goals to existing `LandmarkMetadata` nodes without adding map UI.
- #169 planned the first remembered-region identity map in `docs/planning/REGION_IDENTITY_MAP_V1.md` and selected stable region-name copy as the first implementation step.
- #168 reviewed the open pressure-gate state with predator warning visible and recorded pass-with-polish findings in `docs/planning/PRESSURE_GATE_PREDATOR_WARNING_REVIEW_2026_06_26.md`.
- #101 updated MCP context resources and roadmap status after the Thermal Vent and Decoy Pulse batch.
- #100 added explicit Decoy Pulse non-lethal/isolation test and docs coverage.
- #99 added Decoy Pulse prompt/status feedback and temporary predator hint color.
- #98 implemented one-use-per-expedition Decoy Pulse behavior through `Gulper Eel` re-scan.
- #97 added `Decoy Pulse I` as a data-backed upgrade gated by `Gulper Eel` discovery and `Predator Warning I`.
- #96 tuned the scan-revealed Thermal Vent route hint to read as optional rather than a hard objective arrow.
- #95 recorded the Thermal Vent five-seed route review in `docs/planning/THERMAL_VENT_ROUTE_REVIEW_2026_06_25.md`.
- #94 added typed vent-adjacent `Glow Plankton` placement candidates without increasing active pickup count.
- #93 clarified Thermal Vent scan/result language around optional glow temptation, pressure-seal knowledge, and safe return.
- #92 added the authored Thermal Vent pocket route variation.
- #91 documented optional local Godot AI MCP setup policy and distinguished it from the repo-local read-only OceanGame context MCP server.
- #90 added a first depth-band and landmark readability pass with transition bands, safe-return ribs, and Shell Reef landmark wash.
- #89 added a consistent pale diamond marker rule for non-resource scan targets while preserving resource pickup readability and scan behavior.
- #88 standardized current and route-hint visuals around low-opacity cyan/green suggestion language and shorter labels.
- #87 added reusable prototype scenes for pressure gates, current hints, and signal hints without changing runtime behavior.
- #86 expanded the first visual language guide with actionable color, shape, opacity, text-use, and current-scene example rules.
- #84 planned `Predator Countermeasure I` and selected `Add Decoy Pulse I predator countermeasure` as the future non-lethal implementation candidate.
- #83 refreshed the MCP context server with current Expedition Goal II, Shell Reef, biome pocket, resource economy, visual language, and backlog planning sources.
- #82 added one compact route-choice result callout while keeping debug seed/pattern/route telemetry behind F3.
- #81 reviewed first resource economy pressure and recommended no immediate cost/spawn changes.
- #80 planned `Biome Pocket II` and selected `Add Thermal Vent pocket route variation` as the narrow future implementation candidate.
- #79 moved the deep-reward lure onset slightly below the `Shell Reef` decision band so bank-vs-push-deeper reads more clearly.
- #78 added subtle `Shell Reef` return-current shapes so the reef points back toward the surface/base path after deeper route pushes.
- #77 recorded concrete `Shell Reef` route observations across five deterministic seeds in `docs/planning/SHELL_REEF_ROUTE_REVIEW_2026_06_25.md`.
- #76 added focused metadata, prerequisite, warning-helper, and effect-isolation coverage for `Predator Warning I`.
- #75 added `Predator Warning I` as the first non-lethal predator-preparation upgrade from `Gulper Eel` observation.
- #85 clarified the pressure-lock route by making the locked gate, future cache signal, and surface-upgrade return step more readable.
- #74 replenished the queue as `Predator Warning And Route Tuning` with issues #75-#84.
- #73 added the first `Expedition Goal II` route objective by pointing the completed-upgrade fallback at the `Shell Reef` bank-or-push-deeper choice.
- #72 planned `Expedition Goal II` and selected `Add route objective goal for Shell Reef` as the narrow next implementation.
- #71 added compact surface summary tabs so post-extraction `Result`, `Upgrades`, and `Log` views stay readable as the surface HUD grows.

## Latest Completed Milestone

Thermal Vent And Predator Countermeasure.

Goal completed: the prototype now has an authored Thermal Vent pocket, vent scan/result clarity, typed vent-adjacent Glow Plankton candidates, a five-seed route review, tuned optional-current readability, and `Decoy Pulse I` as a gated one-use non-lethal predator countermeasure with HUD/status feedback and focused tests.

Previous completed milestone:

Scanner And Cargo Progression.

Goal completed: `Signal Lens I` and `Cargo Rack I` are implemented, scan target metadata is clearer, expedition prep/result surfaces now call out useful progress, the upgrade bay is more readable, recent expedition history exists, and `Gulper Eel` observation is in place as the first non-combat monster-hunting step.

Previous completed milestone:

First-Scan Clarity And Prototype Burst.

Goal completed: first-time scan feedback now tells players what to do after scanning, and `Burst Thruster` is implemented as a non-lethal Spacebar tool that spends oxygen, has cooldown feedback, and preserves pressure-lock and predator rules.

Previous completed milestone:

Validation Prep And Readability.

Goal completed: the current prototype is ready to be tested with unfamiliar players. The project now has a blind validation kit, a route-readability/atmosphere pass, a scanner improvement plan, a cargo improvement plan, a Burst Thruster plan, and a project status review.

Previous completed milestone:

Seeded Expedition Feel And Readability.

Goal completed: the seeded-expedition structure is clearer, fairer, and more playtestable. Deep reward routes now have a visual lure, predator danger is telegraphed before contact, expedition result telemetry supports repeatable playtests, and a first oxygen-margin tuning pass is documented.

This milestone comes directly from `docs/planning/DAILY_RUN_PLAYTEST_2026_06_25.md`.

Earlier completed milestone:

Seeded Roguelite Expeditions.

Goal completed: the current authored slice can run as discrete seeded expeditions with resource variation, cluster patterns, result flow, a prototype upgrade bay, progression save/load, and a first milestone playtest report.

The playtest report found the system is directionally working, with follow-up risks around real-time oxygen margins, deep-reward visibility, and predator readability.

## Completed Seeded-Expedition Success Gate

The seeded-expedition milestone succeeds only if controlled randomization creates meaningfully different player decisions.

Across tested seeds:

- At least one expedition should encourage a cautious shallow or midwater extraction.
- At least one expedition should tempt a deeper high-value route.
- At least one expedition should create a close oxygen return or failure.
- Rewards and risks must remain readable before the player commits.
- Predator encounters must be avoidable through observation or route choice.
- Resource depth-band identities must remain consistent.
- No seed should obscure the surface direction or safe return route.

Different placement is not enough. It must produce different decisions.

## Core Design Constraints

- Expeditions start from a surface boat or shallow lab, then push downward through a side-view ocean column.
- The base is a functional hub, not a management sim. It exists to start dives, extract, show results, and buy upgrades.
- Extraction must provide emotional payoff: danger stops, cargo is counted visibly, discoveries and upgrades are acknowledged, and the next dive can begin quickly.
- Progression comes from repeated dives: gather materials, scan lifeforms, survive risk, extract, and upgrade the diver/submersible.
- `Oxygen Tank I` remains resource-gated only. Later upgrades may require a thematically related scan discovery.
- Randomization must preserve readable depth-band rules, surface direction, and safe return routes.
- Low-oxygen feedback may increase presentation urgency, but should not add decompression, ascent drain, or hidden oxygen penalties.
- Monster hunting should grow from observation first: scan, learn behavior, avoid danger, then later trap, wound, repel, or hunt specific predators.
- Every new mechanic should strengthen one question: should the player continue downward or return safely now?
- State ownership should stay explicit: `DiveSession` owns temporary expedition state, `ProgressionState` owns durable progress, authored scene data owns inspectable route/content placement, and visual/readability assets communicate meaning without owning gameplay truth.

## Current State

- The repository has an agentic workflow and planning structure.
- The current architecture and ownership model are documented in `docs/current/ARCHITECTURE.md`.
- The repository includes an MCP context server for project-source documentation, including current status, validation, scanner, cargo, and future-tool plans.
- The first informal blind-validation signal was converted into implemented post-scan guidance; validation gates are no longer roadmap blockers.
- The game uses Godot 4.7 with GDScript, targeting local desktop first with optional web demo support.
- A side-view vertical dive scene and placeholder controllable submersible exist as the runtime foundation.
- The first scene includes a visible surface boat/shallow lab base, oxygen pressure, extraction, oxygen failure, run start/result panels, depth/base HUD, resource pickup, scanning, two upgrades, one pressure-locked wreck opportunity, one route-control predator, seeded starter resource/predator placement, and prototype `Burst Thruster`.
- Current-dive state is split into `DiveSession`; session-persistent progression state is split into `ProgressionState`.
- Starter resource placement uses typed authored `SpawnPoint` nodes selected by the current expedition seed while preserving shallow, midwater, and deep resource bands.
- Prototype readability assets should be reusable and meaning-first, then replaceable by final art once visual language stabilizes.
- A first seeded-expedition playtest report exists under `docs/planning/`, with follow-up risks around real-time oxygen margins, predator readability, and blind-player validation.
- Long-term progression has a single local prototype save slot; active dive state remains temporary.
- Low-oxygen and critical-oxygen HUD feedback increases return urgency without changing oxygen mechanics.
- A first oxygen-margin tuning pass reduced passive drain slightly to support deep-reward routes with one scan or one predator contact.
- The next backlog evaluation lives in `docs/planning/NEXT_BACKLOG_EVALUATION_2026_06_25.md`.
- The current project status review lives in `docs/planning/PROJECT_STATUS_REVIEW_2026_06_25.md`.

## Epics

- [x] Epic: Prototype Runtime And Movement
  Establish the game engine, project structure, first playable scene, swimming controls, and a safe base/extraction point.
- [x] Epic: First Dive Loop
  Create the first playable dive loop: oxygen pressure, resource pickup, scanning, return-to-base extraction, and one upgrade.
- [x] Epic: Creature And Hunt Foundation
  Add simple creature behaviors, a scanner field guide, and one dangerous predator encounter that teaches the monster-hunting direction.
- [x] Epic: Atmosphere And Presentation Pass
  Improve the prototype dive space so depth, risk, resources, safe return, and mood are visually understandable without tutorial text. This replaces the older overlapping ocean-readability label.
- [ ] Epic: Progression And Run Variety Expansion
  Promote the next planning-ready systems into the prototype: practical resource scanning, one scan-gated upgrade, seeded risk variation, and one special discovery opportunity.
- [x] #27 Epic: Daily Run Feel And Readability
  Make seeded expeditions more readable, fair, and measurable before adding larger content systems. Historical issue title retained.
- [x] Epic: Seeded Roguelite Expeditions
  Turn the authored slice into replayable seeded expeditions with controlled randomization, clear start/result flow, and data-driven placement rules.

## Completed Issues

- Completed: create engine scaffold and first scene.
- Completed: implement basic 2D underwater movement.
- Completed: add safe base and extraction interaction.
- Completed: add oxygen timer and run failure.
- Completed: reframe prototype around side-view dive descent.
- Completed: formalize dive/progression state, add resource banking, improve depth readability, add `Oxygen Tank I`, add scanner discoveries, and add the first route-control predator.
- Completed: add start/result screens, deterministic expedition seeds, and seeded starter resource variation inside typed authored depth-band candidate points.
- Completed: add seeded resource cluster patterns and first seeded-expedition milestone playtest report.
- Completed: add disk-backed progression save/load for long-term state only.
- Completed: add critical-oxygen and safe-return presentation feedback.
- Completed: add deep-reward visual lure, predator warning feedback, run telemetry/checklist, and oxygen-margin tuning pass.
- Completed: add first MCP context server for project tooling.
- Completed: add practical resource scan outcomes and deterministic scanner targeting feedback.
- Completed: generalize upgrade definitions, selection, state display, and purchase handling.
- Completed: add seeded `Gulper Eel` route variation through authored creature route spawn points.
- Completed: add visible pressure-locked research wreck, outside scan clue, safe boundary denial, and signal hint.
- Completed: add `Pressure Seal I` as the first scan-gated upgrade and open the pressure-locked wreck route to the `Wreck Signal Cache`.
- Completed: add progression save schema versioning and legacy/current/unknown-version migration behavior.
- Completed: add deterministic headless logic tests for core expedition and progression rules.
- Completed: extract narrow upgrade purchase, scanner targeting, and seeded spawn-selection helpers out of `main.gd`.
- Completed: evaluate repeat tactical scan costs and keep repeat scans free for the current prototype.
- Completed: hide raw seed, pattern, and result telemetry by default behind a simple development telemetry flag.
- Completed: plan the future non-lethal `Burst Thruster` active tool milestone.
- Completed: #46 prepare the blind validation kit for #37.
- Closed as impractical: #37 full two-helper blind validation requirement.
- Completed: #52 support lightweight facilitator summaries for validation evidence.
- Closed as skipped: #53 solo evidence pass.
- Completed: #51 clarify the post-scan next step in the first expedition.
- Completed: #50 add prototype `Burst Thruster` with oxygen cost and cooldown.
- Completed: #54 add `Signal Lens I` resource direction pulse.
- Completed: #55 add `Cargo Rack I` fourth cargo slot upgrade.
- Completed: #56 add compact scanner target preview metadata.
- Completed: #57 add expedition prep goal summary.
- Completed: #58 improve expedition result progress callouts.
- Completed: #59 plan `Monster Observation I` progression slice.
- Completed: #60 add `Gulper Eel` observation scan.
- Completed: #61 plan first small biome pocket.
- Completed: #65 add `Shell Reef` pocket route variation.
- Completed: #66 add `Shell Reef Shelf` scan clue.
- Completed: #67 add `Shell Reef` authored spawn points.
- Completed: #68 plan `Shell Reef` five-seed route review.
- Completed: #69 plan `Predator Warning I` upgrade.
- Completed: #70 plan surface results and upgrade bay layout pass.
- Completed: #62 polish surface upgrade bay readability.
- Completed: #63 add recent expedition log.
- Completed: #47 add a narrow atmosphere and route-readability pass for blind validation.
- Completed: #48 plan `Signal Lens I` as Scanner Improvement I from the `Wreck Signal Cache`.
- Completed: #49 plan `Cargo Rack I` as the first cargo improvement.
- Completed: refresh project-wide status review, roadmap gate, README summary, and MCP planning context.

## Deferred Work

- Large open-world ocean generation.
- Full procedural biomes.
- Full crafting economy, recipe trees, resource rarity tiers, stack sizes, grid inventory, or inventory rearranging.
- Physical cargo processing, base management, crafting minigames, elaborate environmental upgrades, or restaurant/colony systems.
- Multiple upgrade tiers beyond the first scan-gated `Pressure Seal I` slice.
- Combat or hunting systems beyond observation, warning, avoidance, and future setup.
- Full field guide UI beyond practical scan results.
- Daily challenge mode with calendar-derived shared seeds.
- Disk save slots beyond one prototype progression save.
- Multiplayer.
- Polished art, animation, sound design, or final UI styling before the expedition loop proves itself.

## Future Tool Milestone

The first active non-lethal submersible tool is implemented:

- `Burst Thruster`: a short traversal or escape burst that spends oxygen, helps recover from predator mistakes, and creates a decision between immediate safety and return margin.

The plan lives in `docs/planning/BURST_THRUSTER_MILESTONE.md` as historical/current-reference context. Do not add multiple tools or weapons until the scanner/cargo progression milestone has a clearer next direction.
