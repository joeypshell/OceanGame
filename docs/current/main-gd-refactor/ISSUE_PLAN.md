# Main.gd Refactor Issue Plan

## Issue Plan

### Parent Epic

Title: `Epic: Decompose main.gd into stable architecture modules`

Summary: Track the safe decomposition of `scripts/main.gd` into presenters, services, and controllers while preserving current behavior.

Player-visible outcome: No immediate behavior change. Future feature work should become faster and less regression-prone.

Scope: Planning, guardrails, and child issues for incremental extraction.

Out of scope: Direct refactor implementation in the epic issue itself.

Files likely touched: `docs/current/MAIN_GD_ARCHITECTURE_REFACTOR_EPIC.md`, `AGENTS.md`, child issue files as implemented later.

Acceptance criteria: Parent issue links to this document and child issues; every child issue includes a test plan; child work remains independently reviewable.

Testing / verification: Docs tier for the planning issue; quick tier plus direct extracted-module tests for child issues that touch runtime code. Do not claim tests passed unless they actually ran.

Risk level: Low for planning; medium across the full epic.

Rollback plan: Close or revise child issues if extraction proves too risky; keep gameplay code unchanged until specific child issues are accepted.

Follow-up notes: Recalibrate after the first three child issues to confirm file size is shrinking without churn.

### Main.gd Shrinking Issues

#### 1. Extract active HUD formatting into `HudPresenter`

Summary: Move pure active-dive label text and oxygen warning formatting out of `main.gd`.

Player-visible outcome: HUD text should look and behave exactly the same.

Scope: Extract `_format_oxygen_label`, `_oxygen_state`, `_oxygen_warning_text`, `_oxygen_state_color`, `_compact_dive_status`, prompt fragments that can be passed explicit state, and related tests.

Out of scope: Moving node references, changing layout, changing oxygen rules.

Files likely touched: `scripts/main.gd`, `scripts/ui/hud_presenter.gd`, `tests/logic_tests.gd`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Extracted methods are pure/static where possible; existing HUD tests pass; `main.gd` line count decreases.

Verification steps: `powershell -ExecutionPolicy Bypass -File .\scripts\test.ps1 -Tier quick`.

Risk level: Low.

Rollback plan: Revert the new presenter and restore the original helper functions.

Follow-up notes: Keep scene-node assignment in `main.gd` for this first pass.

#### 2. Extract cargo slot presentation helpers

Summary: Move cargo slot state/color/icon helper logic into the HUD presenter or a small `CargoSlotPresenter`.

Player-visible outcome: Cargo slots keep the same number, colors, icons, and empty/full/readability states.

Scope: Extract `_cargo_slot_states`, `_cargo_slot_color`, `_cargo_slot_icon_polygon`, `_cargo_slot_icon_color`, and related tests.

Out of scope: Changing cargo capacity, inventory rules, or HUD layout.

Files likely touched: `scripts/main.gd`, `scripts/ui/hud_presenter.gd` or `scripts/ui/cargo_slot_presenter.gd`, `tests/logic_tests.gd`.

Acceptance criteria: Existing cargo-slot tests pass and new tests cover the extracted helper directly.

Verification steps: Quick tier.

Risk level: Low.

Rollback plan: Restore helper functions to `main.gd`.

Follow-up notes: This should reduce future inventory UI bugs without touching `DiveSession`.

#### 3. Extract upgrade menu formatting into `UpgradePresenter`

Summary: Move upgrade menu title, cost, state, prerequisite, and feedback formatting out of `main.gd`.

Player-visible outcome: Upgrade panel copy remains unchanged.

Scope: Extract formatting helpers such as `_format_upgrade_menu_title`, `_format_upgrade_cost`, `_format_missing_resources`, `_format_upgrade_state`, `_format_upgrade_effect_summary`, and related display-name helpers.

Out of scope: Upgrade purchase behavior, resource banking, upgrade effects.

Files likely touched: `scripts/main.gd`, `scripts/ui/upgrade_presenter.gd`, `tests/logic_tests.gd`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Upgrade panel regression tests target the presenter and continue to pass.

Verification steps: Quick tier.

Risk level: Medium-low because upgrade copy has many prerequisites.

Rollback plan: Revert presenter and tests for this issue only.

Follow-up notes: Keep `UpgradePurchase` as rules helper; presenter should not purchase upgrades.

#### 4. Extract expedition result formatting into `ExpeditionResultService`

Summary: Move extraction/failure summaries, route choice, research callouts, recent route memory, and recent expedition log formatting out of `main.gd`.

Player-visible outcome: Result panel copy remains unchanged after extraction/failure.

Scope: Extract pure formatting and memory-priority helpers that can receive explicit run/progression/survival state.

Out of scope: Changing what is banked, save behavior, or night resolution.

Files likely touched: `scripts/main.gd`, `scripts/services/expedition_result_service.gd`, `tests/logic_tests.gd`, `docs/current/GAMEPLAY.md`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Current result-summary tests pass; at least one new direct service test covers route memory priority.

Verification steps: Quick tier.

Risk level: Medium.

Rollback plan: Restore formatting helpers to `main.gd`.

Follow-up notes: This is a major agent-context win because many result helpers currently live near the end of `main.gd`.

#### 5. Extract save/load coordination into `SaveService`

Summary: Move JSON file open/read/write/delete and nested survival-state serialization coordination out of `main.gd`.

Player-visible outcome: Existing local save/load/delete behavior is unchanged.

Scope: Extract `_load_progression`, `_save_progression`, and `_delete_progression_save` behavior into `scripts/services/save_service.gd`.

Out of scope: Save schema changes, new save slots, cloud saves, migration rewrite.

Files likely touched: `scripts/main.gd`, `scripts/services/save_service.gd`, `tests/logic_tests.gd`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Existing save/load tests pass; service has a testable API that accepts path/state objects.

Verification steps: Quick tier.

Risk level: Medium-high because it touches persistence.

Rollback plan: Revert service and restore original save functions.

Follow-up notes: Do this after presenter extractions have proven the pattern.

#### 6. Extract debug visual staging into `DebugCommandService`

Summary: Move debug seed/condition helpers and visual review staging orchestration out of the main gameplay flow.

Player-visible outcome: No normal gameplay change; debug staging commands still work for screenshots/tests.

Scope: Extract `_debug_next_condition_from_id`, `_debug_seed_for_delta`, `_stage_debug_*`, `_consume_visual_smoke_command`, and `_publish_visual_smoke_state` where practical.

Out of scope: Adding new debug stages, changing Playwright tests, changing gameplay route content.

Files likely touched: `scripts/main.gd`, `scripts/debug/debug_command_service.gd`, `tests/logic_tests.gd`, `docs/current/SCREENSHOT_WORKFLOW.md`.

Acceptance criteria: Existing debug helper tests pass; visual-smoke state names remain stable.

Verification steps: Quick tier; visual tier only if a staged capture contract changes.

Risk level: Medium because staging functions touch many scene nodes.

Rollback plan: Revert service extraction and leave debug code in `main.gd`.

Follow-up notes: Prefer extracting pure seed/condition helpers before scene-mutating staging commands.

#### 7. Extract deterministic route setup wrappers into `RouteSetupService`

Summary: Move run setup wrappers around resource placement, predator route placement, lantern route placement, and condition visual selection into a focused service.

Player-visible outcome: Daily variation should remain deterministic for the same run seed.

Scope: Extract `_place_starter_resources_for_run`, `_place_predator_route_for_run`, `_place_lantern_ray_route_for_run`, `_resource_cluster_pattern_for_seed`, `_spawn_positions_for_target`, and `_spawn_routes_for_target` if the dependencies are clean.

Out of scope: New spawn points, new condition effects, procedural generation.

Files likely touched: `scripts/main.gd`, `scripts/services/route_setup_service.gd`, `tests/logic_tests.gd`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Existing spawn/condition tests pass; deterministic seed behavior is unchanged.

Verification steps: Quick tier.

Risk level: Medium.

Rollback plan: Restore route setup functions to `main.gd`.

Follow-up notes: Keep authored scene nodes as the source of placement truth.

#### 8. Extract scan effect formatting and scan feedback helpers

Summary: Move scan target copy, first/repeat scan guidance, depth band text, and resource upgrade need formatting out of `main.gd`.

Player-visible outcome: Scan feedback text remains unchanged.

Scope: Extract `_format_first_scan_guidance`, `_format_repeat_scan_effect_text`, `_format_signal_lens_pulse_text`, `_format_wreck_cache_repeat_hint`, `_format_resource_upgrade_need`, `_format_depth_band`, and scan-target display helpers that are not already owned by `ScanTargetResolver`.

Out of scope: Scan range, scan targeting, discovery persistence, scan costs.

Files likely touched: `scripts/main.gd`, `scripts/ui/scan_feedback_presenter.gd`, `tests/logic_tests.gd`.

Acceptance criteria: Existing scan copy tests pass and presenter tests cover repeated scan states.

Verification steps: Quick tier.

Risk level: Medium-low.

Rollback plan: Restore helper methods to `main.gd`.

Follow-up notes: Do not duplicate `ScanTargetResolver` ownership.

#### 9. Consolidate repeated proximity interaction state

Summary: Replace the growing set of `player_near_*` booleans and matching body-enter/body-exit handlers with a small interaction-state helper.

Player-visible outcome: Interact prompts and proximity triggers behave the same.

Scope: Introduce a helper that records proximity by stable interaction id, then migrate a small group of low-risk interactables first.

Out of scope: Rewriting every interaction in one pass, changing interaction priority, changing prompts.

Files likely touched: `scripts/main.gd`, `scripts/controllers/interaction_state.gd`, `tests/logic_tests.gd`, maybe `scenes/Main.tscn`.

Acceptance criteria: Migrated interactions preserve prompts and one-shot/repeat behavior; tests cover priority or explicit migrated ids.

Verification steps: Quick tier plus focused manual smoke if prompts are touched.

Risk level: Medium-high because interaction priority affects play.

Rollback plan: Restore migrated booleans and handlers.

Follow-up notes: Start with one or two knowledge interactables, not base extraction.

#### 10. Extract repeated timing cue visual helpers

Summary: Reduce repeated visual-only update functions for timing/current cues into a shared helper or route presenter.

Player-visible outcome: Timing cues keep the same alpha ranges and visual rhythm.

Scope: Extract common alpha pulse helpers and update application for East Shelf, Blue Chimney, Blackwater, Lantern Ray, Hollow Reef, Glassfin, Salvage, and Outer Shelf where safe.

Out of scope: Changing cue meaning, adding hazards, changing oxygen or movement.

Files likely touched: `scripts/main.gd`, `scripts/ui/route_presenter.gd`, `tests/logic_tests.gd`.

Acceptance criteria: Existing visual-only timing tests pass and common helper tests cover alpha ranges.

Verification steps: Quick tier; visual tier only if rendered contracts change.

Risk level: Medium.

Rollback plan: Restore individual update functions.

Follow-up notes: Keep visual helpers presentation-only.

#### 11. Split survival extraction orchestration from UI rendering

Summary: Move survival supply extraction routing and night report orchestration into a controller while leaving `SurvivalState` as the rules owner.

Player-visible outcome: Survival supplies, night reports, oxygen penalties, collapse, and stabilization behave the same.

Status: Implemented as `scripts/services/survival_controller_service.gd` for survival supply banking, night resolution, health-recovery night handling, and Power Patch night-build coordination. `DiveLifecycleService` still sequences the overall extraction/failure flow and delegates survival-specific rules.

Scope: Extract `_bank_extracted_survival_supplies`, `_resolve_night_after_result`, and survival-result coordination after result formatting has moved.

Out of scope: Changing survival balance, adding new needs, changing chapter length.

Files likely touched: `scripts/main.gd`, `scripts/controllers/survival_controller.gd`, `tests/logic_tests.gd`, `docs/current/ARCHITECTURE.md`.

Acceptance criteria: Survival tests pass and controller tests show supplies are not banked as upgrade resources.

Verification steps: Quick tier.

Risk level: Medium-high.

Rollback plan: Restore survival orchestration to `main.gd`.

Follow-up notes: Do after result formatting extraction to avoid crossing too many concerns.

#### 12. Characterize and shrink `main.gd` orchestration surface

Summary: After several extractions, document what remains in `main.gd` and remove dead wrappers or duplicate helpers.

Player-visible outcome: No behavior change.

Scope: Audit remaining responsibilities, update `ARCHITECTURE.md`, delete only clearly unused private wrappers confirmed by tests/search.

Out of scope: New modules, broad cleanup, feature work.

Files likely touched: `scripts/main.gd`, `docs/current/ARCHITECTURE.md`, `docs/current/MAIN_GD_ARCHITECTURE_REFACTOR_EPIC.md`.

Acceptance criteria: `main.gd` is smaller, remaining responsibilities are documented, and no broad behavior changed.

Verification steps: Quick tier.

Risk level: Low-medium.

Rollback plan: Revert deleted wrappers if any test or search shows hidden coupling.

Follow-up notes: This issue should happen after at least three extraction issues.

### Broader Architecture Issues

#### 13. Add architecture dependency notes to `AGENTS.md`

Summary: Add compact guardrails so future agents avoid adding unrelated responsibilities to `main.gd`.

Player-visible outcome: None directly; future work should be safer.

Scope: Document dependency direction and the preferred presenter/service/controller extraction approach.

Out of scope: Code refactor.

Files likely touched: `AGENTS.md`.

Acceptance criteria: Guardrails are concise and consistent with this epic.

Verification steps: Docs tier.

Risk level: Low.

Rollback plan: Revert AGENTS change.

Follow-up notes: This can happen with the epic planning issue.

#### 14. Review scene-authored route data boundaries

Summary: Audit which route facts belong in `Main.tscn`, scripts, resources, or metadata nodes.

Player-visible outcome: None immediately; future route expansion should be less brittle.

Scope: Produce a short architecture note and identify one safe route-data extraction candidate.

Out of scope: Moving route content or changing layout.

Files likely touched: `docs/current/ARCHITECTURE.md`, optional planning note.

Acceptance criteria: Clear rules for authored scene data vs script logic are documented.

Verification steps: Docs tier.

Risk level: Low.

Rollback plan: Revert docs.

Follow-up notes: Do not combine with content expansion.

#### 15. Create module-size watchlist and refactor threshold

Summary: Add a lightweight project convention for when files need extraction planning.

Player-visible outcome: None directly.

Scope: Document thresholds and add a cheap script or docs-only checklist if useful.

Out of scope: Enforcing hard CI failures before the team wants them.

Files likely touched: `AGENTS.md`, `docs/current/ARCHITECTURE.md`, optional `scripts/`.

Acceptance criteria: Future agents know when to stop and plan instead of adding to oversized files.

Verification steps: Docs tier, or quick tier if a script is added.

Risk level: Low.

Rollback plan: Revert convention/script.

Follow-up notes: Keep this advisory at first.

#### 16. Move reusable visual marker patterns toward resources or small scenes

Summary: Review repeated readability marker scene/script patterns and identify safe reuse boundaries.

Player-visible outcome: Existing markers remain unchanged.

Scope: Consolidate only obvious repeated visual language after current readability behavior is stable.

Out of scope: Visual redesign, new art direction, gameplay changes.

Files likely touched: `scripts/readability_marker_patterns.gd`, `scenes/readability/*`, tests, docs.

Acceptance criteria: Any extraction is presentation-only and covered by tests or visual evidence.

Verification steps: Quick tier plus visual tier if rendered contracts change.

Risk level: Medium.

Rollback plan: Restore previous scene/script layout.

Follow-up notes: Avoid doing this before active gameplay progress issues unless marker duplication blocks work.

#### 17. Clarify test ownership for extracted modules

Summary: Update test organization conventions so extracted pure logic does not require scene-heavy tests.

Player-visible outcome: None directly; faster and cheaper future verification.

Scope: Document where to put direct unit-style tests in `tests/logic_tests.gd` or a future split test runner.

Out of scope: Building a new full test framework.

Files likely touched: `docs/current/ARCHITECTURE.md`, `tests/logic_tests.gd` if a small helper is extracted.

Acceptance criteria: Future module issues know whether to add direct logic tests, scene contract tests, or visual tests.

Verification steps: Docs tier unless code changes.

Risk level: Low.

Rollback plan: Revert docs.

Follow-up notes: Use this to reduce token and Playwright overuse.

#### 18. Recalibrate after first extraction batch

Summary: After 3-4 child refactor issues, reassess whether the architecture plan is reducing risk or creating churn.

Player-visible outcome: None directly; protects project momentum.

Scope: Compare `main.gd` line count, issue friction, test cost, and ability to continue player-visible work.

Out of scope: New refactors during the recalibration issue itself.

Files likely touched: `docs/current/MAIN_GD_ARCHITECTURE_REFACTOR_EPIC.md`, possibly `docs/current/ROADMAP.md`.

Acceptance criteria: Written recommendation to continue, pause, or adjust the refactor sequence.

Verification steps: Docs tier.

Risk level: Low.

Rollback plan: Revert docs if the recommendation is wrong or superseded.

Follow-up notes: This should happen before refactor work displaces too much visible game progress.
