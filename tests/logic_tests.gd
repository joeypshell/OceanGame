extends SceneTree

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SurvivalStateScript := preload("res://scripts/survival_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const PlayerScript := preload("res://scripts/player.gd")
const PlayerScene := preload("res://scenes/Player.tscn")
const MainScene := preload("res://scenes/Main.tscn")
const ReadabilityMarkerPatternsScript := preload("res://scripts/readability_marker_patterns.gd")
const ScanPulseVisualScript := preload("res://scripts/scan_pulse_visual.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const MainScript := preload("res://scripts/main.gd")
const Area01SourceMapOverlayScript := preload("res://scripts/area01_source_map_overlay.gd")
const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")
const Area01SourceTruthValidatorScript := preload("res://scripts/area01_source_truth_validator.gd")
const Area01VisualCueContractScript := preload("res://scripts/area01_visual_cue_contract.gd")
const Area01VisualDirectorScript := preload("res://scripts/area01_visual_director.gd")
const MobileTouchControlsScript := preload("res://scripts/mobile_touch_controls.gd")
const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const CargoSlotPresenterScript := preload("res://scripts/ui/cargo_slot_presenter.gd")
const InventorySummaryPresenterScript := preload("res://scripts/ui/inventory_summary_presenter.gd")
const NightBuildPresenterScript := preload("res://scripts/ui/night_build_presenter.gd")
const ResourcePresenterScript := preload("res://scripts/ui/resource_presenter.gd")
const ResourceRoleVisualPresenterScript := preload("res://scripts/ui/resource_role_visual_presenter.gd")
const RecentExpeditionPresenterScript := preload("res://scripts/ui/recent_expedition_presenter.gd")
const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const SurfaceResultPresenterScript := preload("res://scripts/ui/surface_result_presenter.gd")
const SurvivalSupplyCachePresenterScript := preload("res://scripts/ui/survival_supply_cache_presenter.gd")
const ToolBeltPresenterScript := preload("res://scripts/ui/tool_belt_presenter.gd")
const RouteMemoryPresenterScript := preload("res://scripts/ui/route_memory_presenter.gd")
const RoutePresenterScript := preload("res://scripts/ui/route_presenter.gd")
const ResearchResultPresenterScript := preload("res://scripts/ui/research_result_presenter.gd")
const UpgradeCopyPresenterScript := preload("res://scripts/ui/upgrade_copy_presenter.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const ScannableScript := preload("res://scripts/scannable.gd")
const PredatorScript := preload("res://scripts/predator.gd")
const OxygenTankUpgrade := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PressureSealUpgrade := preload("res://resources/upgrades/pressure_seal_1.tres")
const SignalLensUpgrade := preload("res://resources/upgrades/signal_lens_1.tres")
const EchoLensUpgrade := preload("res://resources/upgrades/echo_lens_1.tres")
const ResonanceKeyUpgrade := preload("res://resources/upgrades/resonance_key_1.tres")
const CargoRackUpgrade := preload("res://resources/upgrades/cargo_rack_1.tres")
const WaterFilterUpgrade := preload("res://resources/upgrades/water_filter_1.tres")
const PredatorWarningUpgrade := preload("res://resources/upgrades/predator_warning_1.tres")
const DecoyPulseUpgrade := preload("res://resources/upgrades/decoy_pulse_1.tres")
const SalvageCutterUpgrade := preload("res://resources/upgrades/salvage_cutter_1.tres")
const StarterResourceDefinitions := [
	preload("res://resources/driftwood.tres"),
	preload("res://resources/food_supply.tres"),
	preload("res://resources/glow_plankton.tres"),
	preload("res://resources/kelp_fiber.tres"),
	preload("res://resources/power_supply.tres"),
	preload("res://resources/quartz_glass.tres"),
	preload("res://resources/scrap_metal.tres"),
	preload("res://resources/shell_fragments.tres"),
	preload("res://resources/water_supply.tres"),
]

class DummyScanTarget:
	extends Node2D

	var discovery_id := ""
	var display_name := ""
	var description := ""

	func set_scan_selected(_selected: bool) -> void:
		pass

var _failures: Array[String] = []
var _passes := 0

func _initialize() -> void:
	_run("cargo limit", _test_cargo_limit)
	_run("upgraded cargo limit", _test_upgraded_cargo_limit)
	_run("extraction requirements", _test_extraction_requirements)
	_run("oxygen failure", _test_oxygen_failure)
	_run("health feedback presenter", _test_health_feedback_presenter)
	_run("health damage and vent failure", _test_health_damage_and_vent_failure)
	_run("health damage night resolution copy", _test_health_damage_night_resolution_copy)
	_run("surface oxygen refill isolation", _test_surface_oxygen_refill_isolation)
	_run("ship offload repeat daylight sortie", _test_ship_offload_repeat_daylight_sortie)
	_run("night phase end day and upgrade choice", _test_night_phase_end_day_and_upgrade_choice)
	_run("night build presenter", _test_night_build_presenter)
	_run("night power patch build choice", _test_night_power_patch_build_choice)
	_run("nightfall away from ship late return consequence", _test_nightfall_away_from_ship_late_return_consequence)
	_run("debug unlimited oxygen", _test_debug_unlimited_oxygen)
	_run("survival night consumption", _test_survival_night_consumption)
	_run("survival collapse and reset", _test_survival_collapse_and_reset)
	_run("survival supply banking isolation", _test_survival_supply_banking_isolation)
	_run("survival supply cache presenter", _test_survival_supply_cache_presenter)
	_run("survival supply cache target copy", _test_survival_supply_cache_target_copy)
	_run("starter survival resource families", _test_starter_survival_resource_families)
	_run("resource taxonomy offload copy", _test_resource_taxonomy_offload_copy)
	_run("survival oxygen penalty", _test_survival_oxygen_penalty)
	_run("upgrade affordability", _test_upgrade_affordability)
	_run("progression reset", _test_progression_reset)
	_run("save/load behavior", _test_save_load_behavior)
	_run("save service", _test_save_service)
	_run("deterministic seed generation", _test_deterministic_seed_generation)
	_run("expedition condition selection", _test_expedition_condition_selection)
	_run("spawn-point matching", _test_spawn_point_matching)
	_run("spawn selection", _test_spawn_selection)
	_run("condition-weighted spawn selection", _test_condition_weighted_spawn_selection)
	_run("Lantern Ray route variation", _test_lantern_ray_route_variation)
	_run("debug review seed and condition helpers", _test_debug_review_helpers)
	_run("debug Wreck Echo visual staging", _test_debug_wreck_echo_visual_staging)
	_run("debug Wide Reef salvage staging guardrails", _test_debug_wide_reef_salvage_staging_guardrails)
	_run("debug Mirror Kelp evidence staging", _test_debug_mirror_kelp_evidence_staging)
	_run("debug Outer Shelf evidence staging", _test_debug_outer_shelf_evidence_staging)
	_run("scanner target resolver", _test_scanner_target_resolver)
	_run("scan hold timing helper", _test_scan_hold_timing_helper)
	_run("compact scan marker", _test_compact_scan_marker)
	_run("Lantern Ray scan behavior", _test_lantern_ray_scan_behavior)
	_run("Hollow Reef passive creature scan behavior", _test_hollow_reef_passive_creature_scan_behavior)
	_run("Glassfin Swarm scan behavior", _test_glassfin_swarm_scan_behavior)
	_run("Mirrorfin route-read behavior", _test_mirrorfin_route_read_behavior)
	_run("Mirror Kelp deep promise", _test_mirror_kelp_deep_promise)
	_run("Outer Shelf route footprint", _test_outer_shelf_route_footprint)
	_run("Outer Shelf Glass Rim branch", _test_outer_shelf_glass_rim_branch)
	_run("Outer Shelf slackwater timing cue visual only", _test_outer_shelf_slackwater_timing_cue_visual_only)
	_run("Outer Shelf cargo knowledge payoff choice", _test_outer_shelf_cargo_knowledge_payoff_choice)
	_run("Glass Rim reading payoff choice", _test_glass_rim_reading_payoff_choice)
	_run("Glass Ray Drifter passive route read", _test_glass_ray_drifter_passive_route_read)
	_run("wide chamber salvage pocket entrance", _test_wide_chamber_salvage_pocket_entrance)
	_run("salvage data cache interaction", _test_salvage_data_cache_interaction)
	_run("Salvage Manifest interaction", _test_salvage_manifest_interaction)
	_run("Salvage pocket silt timing cue visual only", _test_salvage_pocket_silt_timing_cue_visual_only)
	_run("Tideglass Sample interaction", _test_tideglass_sample_interaction)
	_run("Glassfin Swarm spacing cue visual only", _test_glassfin_swarm_spacing_cue_visual_only)
	_run("Lantern Ray timing lane is visual only", _test_lantern_ray_timing_lane_is_visual_only)
	_run("scan pulse visual helper", _test_scan_pulse_visual_helper)
	_run("sprite-ready scene asset slots", _test_sprite_ready_scene_asset_slots)
	_run("Area 01 first art slice scene contract", _test_area_01_first_art_slice_scene_contract)
	_run("Area 01 source map contract", _test_area_01_source_map_contract)
	_run("Area 01 source truth validator", _test_area_01_source_truth_validator)
	_run("Area 01 source truth validator catches drift", _test_area_01_source_truth_validator_catches_drift)
	_run("Area 01 visual cue contract registry", _test_area_01_visual_cue_contract_registry)
	_run("Area 01 visual cue diagnostic report", _test_area_01_visual_cue_diagnostic_report)
	_run("Area 01 visual director", _test_area_01_visual_director)
	_run("Area 01 surface oxygen hook runtime", _test_area_01_surface_oxygen_hook_runtime)
	_run("Area 01 authoritative wall builder", _test_area_01_authoritative_wall_builder)
	_run("Area 01 source map debug overlay", _test_area_01_source_map_debug_overlay)
	_run("Area 01 starter resource pocket placement", _test_area_01_starter_resource_pocket_placement)
	_run("Area 01 cave mouth affordances", _test_area_01_cave_mouth_affordances)
	_run("Area 01 reusable reef visual kit", _test_area_01_reusable_reef_visual_kit)
	_run("east shelf spur branch scene contract", _test_east_shelf_spur_branch_scene_contract)
	_run("landmark region identity metadata", _test_landmark_region_identity_metadata)
	_run("predator scan target", _test_predator_scan_target)
	_run("discovery prerequisites", _test_discovery_prerequisites)
	_run("predator warning upgrade metadata", _test_predator_warning_upgrade_metadata)
	_run("predator warning effect isolation", _test_predator_warning_effect_isolation)
	_run("decoy pulse effect isolation", _test_decoy_pulse_effect_isolation)
	_run("echo lens effect isolation", _test_echo_lens_effect_isolation)
	_run("expedition prep goals", _test_expedition_prep_goals)
	_run("result progress callouts", _test_result_progress_callouts)
	_run("extraction banking result copy", _test_extraction_banking_result_copy)
	_run("next expedition framing", _test_next_expedition_framing)
	_run("region memory result callout", _test_region_memory_result_callout)
	_run("discovery memory result callout", _test_discovery_memory_result_callout)
	_run("route memory presenter", _test_route_memory_presenter)
	_run("route choice result callout", _test_route_choice_result_callout)
	_run("gulper research result callout", _test_gulper_research_result_callout)
	_run("research result presenter", _test_research_result_presenter)
	_run("monster research non-combat guardrails", _test_monster_research_non_combat_guardrails)
	_run("echo lens result callout", _test_echo_lens_result_callout)
	_run("wreck echo route first pass", _test_wreck_echo_route_first_pass)
	_run("East Shelf pocket result callout", _test_east_shelf_pocket_result_callout)
	_run("lower connector echo opportunity", _test_lower_connector_echo_opportunity)
	_run("Resonance Alcove research payoff", _test_resonance_alcove_research_payoff)
	_run("Blue Chimney draft interaction", _test_blue_chimney_draft_interaction)
	_run("Lantern Silt Sample interaction", _test_lantern_silt_sample_interaction)
	_run("Blackwater Crack gate state", _test_blackwater_crack_gate_state)
	_run("Blackwater Trace payoff", _test_blackwater_trace_payoff)
	_run("Glass Kelp reading payoff", _test_glass_kelp_reading_payoff)
	_run("Hollow Reef cave reading payoff", _test_hollow_reef_cave_reading_payoff)
	_run("upgrade copy presenter", _test_upgrade_copy_presenter)
	_run("upgrade bay readability states", _test_upgrade_bay_readability_states)
	_run("result and upgrade copy length guards", _test_result_and_upgrade_copy_length_guards)
	_run("recent expedition presenter", _test_recent_expedition_presenter)
	_run("recent expedition log", _test_recent_expedition_log)
	_run("recent expedition survival memory", _test_recent_expedition_survival_memory)
	_run("thermal vent scan clue text", _test_thermal_vent_scan_clue_text)
	_run("shell reef scan clue text", _test_shell_reef_scan_clue_text)
	_run("wreck signal cache repeat scan hint", _test_wreck_signal_cache_repeat_scan_hint)
	_run("pressure lock guidance text", _test_pressure_lock_guidance_text)
	_run("surface summary tabs", _test_surface_summary_tabs)
	_run("keyboard action prompt labels", _test_keyboard_action_prompt_labels)
	_run("prompt formatter guard coverage", _test_prompt_formatter_guard_coverage)
	_run("condition presenter", _test_condition_presenter)
	_run("condition briefing copy", _test_condition_briefing_copy)
	_run("Dusk Trench low-visibility condition nudge", _test_dusk_trench_low_visibility_condition_nudge)
	_run("Wide Reef Chamber calm-current condition nudge", _test_wide_chamber_calm_current_condition_nudge)
	_run("Mirror Kelp kelp-bloom condition nudge", _test_mirror_kelp_kelp_bloom_condition_nudge)
	_run("daylight timer HUD", _test_daylight_timer_hud)
	_run("late-day cargo banking warning", _test_late_day_cargo_banking_warning)
	_run("expedition slate context", _test_expedition_slate_context)
	_run("expedition slate pressure pause", _test_expedition_slate_pressure_pause)
	_run("HUD presenter", _test_hud_presenter)
	_run("tool belt presenter", _test_tool_belt_presenter)
	_run("compact dive hud helpers", _test_compact_dive_hud_helpers)
	_run("mobile touch controls adapter", _test_mobile_touch_controls_adapter)
	_run("active HUD final polish regression", _test_active_hud_final_polish_regression)
	_run("expanded region world bounds", _test_expanded_region_world_bounds)
	_run("expanded region base direction", _test_expanded_region_base_direction)
	_run("no-minimap orientation guardrails", _test_no_minimap_orientation_guardrails)
	_run("expanded region reset state ownership", _test_expanded_region_reset_state_ownership)
	_run("lower connector reset and bounds coverage", _test_lower_connector_reset_and_bounds_coverage)
	_run("East Shelf pocket prompt interaction", _test_east_shelf_pocket_prompt_interaction)
	_run("East Shelf current surge visual timing", _test_east_shelf_current_surge_visual_timing)
	_run("Blue Chimney reverse draft visual timing", _test_blue_chimney_reverse_draft_visual_timing)
	_run("Blackwater pressure cue visual timing", _test_blackwater_pressure_cue_visual_timing)
	_run("Hollow Reef timing current visual only", _test_hollow_reef_timing_current_visual_only)
	_run("sealed shelf hatch promise state", _test_sealed_shelf_hatch_promise_state)
	_run("burst thruster movement helper", _test_burst_thruster_movement_helper)
	_run("player visual facing isolation", _test_player_visual_facing_isolation)
	_run("player idle and thrust visual states", _test_player_idle_and_thrust_visual_states)
	_run("predator decoy pulse helper", _test_predator_decoy_pulse_helper)
	_run("decoy pulse feedback text", _test_decoy_pulse_feedback_text)

	if _failures.is_empty():
		print("Logic tests passed: %d checks." % _passes)
		quit(0)
		return

	for failure in _failures:
		push_error(failure)
	print("Logic tests failed: %d failure(s), %d passed checks." % [_failures.size(), _passes])
	quit(1)

func _run(test_name: String, test_callable: Callable) -> void:
	var failures_before := _failures.size()
	test_callable.call()
	if _failures.size() == failures_before:
		print("PASS: %s" % test_name)

func _test_cargo_limit() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	_expect(session.add_cargo("kelp_fiber"), "first cargo slot should accept an item")
	_expect(session.add_cargo("shell_fragments"), "second cargo slot should accept an item")
	_expect(session.add_cargo("glow_plankton"), "third cargo slot should accept an item")
	_expect(not session.add_cargo("extra_resource"), "cargo should reject items beyond the limit")
	_expect(session.current_cargo.size() == session.cargo_limit, "cargo should stay at the configured limit")

func _test_upgraded_cargo_limit() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.cargo_limit = 4
	session.start()

	_expect(session.add_cargo("kelp_fiber"), "upgraded first cargo slot should accept an item")
	_expect(session.add_cargo("shell_fragments"), "upgraded second cargo slot should accept an item")
	_expect(session.add_cargo("glow_plankton"), "upgraded third cargo slot should accept an item")
	_expect(session.add_cargo("kelp_fiber"), "upgraded fourth cargo slot should accept an item")
	_expect(not session.add_cargo("extra_resource"), "upgraded cargo should reject items beyond four slots")
	session.fail()
	_expect(session.current_cargo.is_empty(), "oxygen failure should still discard upgraded cargo")

func _test_extraction_requirements() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	_expect(not session.can_extract(true), "player should not extract before leaving base")
	session.has_left_base = true
	_expect(not session.can_extract(false), "player should not extract away from base")
	_expect(session.can_extract(true), "player should extract only after leaving and returning to base")
	session.extract()
	_expect(session.result == DiveSessionScript.Result.EXTRACTED, "extract should set extracted result")

func _test_oxygen_failure() -> void:
	var session := DiveSessionScript.new()
	session.reset(10.0)
	session.start()
	session.add_cargo("kelp_fiber")

	session.drain_oxygen(12.0)

	_expect(session.oxygen == 0.0, "oxygen should clamp to zero")
	_expect(session.result == DiveSessionScript.Result.FAILED, "oxygen depletion should fail the dive")
	_expect(session.current_cargo.is_empty(), "oxygen failure should discard current cargo")

func _test_health_feedback_presenter() -> void:
	_expect(HealthFeedbackPresenterScript.format_damage_source_short("thermal vent heat") == "Thermal vent", "thermal vent damage source should be compact")
	_expect(HealthFeedbackPresenterScript.format_damage_source_short("") == "Damage", "empty damage source should fall back safely")
	_expect(HealthFeedbackPresenterScript.format_damage_status("thermal vent heat", 18.0).contains("-18 health"), "thermal vent damage copy should name the health loss amount")
	_expect(HealthFeedbackPresenterScript.format_damage_status("thermal vent heat", 18.0).contains("O2 unchanged"), "thermal vent damage copy should stay distinct from oxygen loss")
	_expect(HealthFeedbackPresenterScript.format_recovery_line(82.0, 100.0).contains("Health: 82/100 returned"), "night health recovery copy should report return health")
	_expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("health depleted by thermal vent") == "health depleted", "health failure copy should stay distinct from oxygen failure copy")
	_expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("predator warning ignored") == "oxygen depleted after predator contact", "predator failure copy should preserve oxygen framing")
	_expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("none") == "oxygen depleted", "unknown failure causes should preserve oxygen fallback")

func _test_health_damage_and_vent_failure() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0, 100.0)
	session.start()
	session.oxygen = 18.0
	session.add_cargo("driftwood")

	session.damage_health(22.0)

	_expect(is_equal_approx(session.health, 78.0), "health damage should reduce health")
	_expect(is_equal_approx(session.oxygen, 18.0), "health damage should not spend oxygen")
	_expect(session.current_cargo == ["driftwood"], "nonfatal health damage should preserve carried cargo")
	_expect(session.result == DiveSessionScript.Result.DIVING, "nonfatal health damage should keep the dive active")

	session.refill_oxygen(20.0)
	_expect(is_equal_approx(session.oxygen, session.max_oxygen), "oxygen refill should still refill oxygen")
	_expect(is_equal_approx(session.health, 78.0), "oxygen refill should not heal health")

	session.damage_health(100.0)
	_expect(session.result == DiveSessionScript.Result.FAILED, "health reaching zero should fail the dive")
	_expect(session.current_cargo.is_empty(), "health failure should discard carried cargo")

	var main := MainScript.new()
	main.dive_session.reset(30.0, 100.0)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.dive_session.current_cargo.append("driftwood")
	main.thermal_vent_health_damage = 18.0
	main.call("_apply_health_damage", main.thermal_vent_health_damage, "thermal vent heat")
	_expect(is_equal_approx(main.dive_session.health, 82.0), "thermal vent damage should reduce health by the configured amount")
	_expect(is_equal_approx(main.dive_session.oxygen, 24.0), "thermal vent damage should leave oxygen unchanged")
	_expect(main.run_health_damage_events == 1, "thermal vent damage should count as health damage telemetry")
	_expect(main.last_health_damage_source == "thermal vent heat", "thermal vent damage should record a distinct source")
	_expect(is_equal_approx(main.last_health_damage_amount, 18.0), "thermal vent damage should record the health loss amount")
	_expect(main.call("_format_active_objective_line").contains("Health hit"), "recent health damage should take over the generic active objective")
	_expect(main.call("_format_hud_prompt").contains("Surface O2 only"), "recent health damage prompt should say surfacing is oxygen-only")
	main.player_in_surface_oxygen_refill = true
	_expect(main.call("_format_active_objective_line").contains("O2 only"), "surface objective after damage should not imply healing")
	main.dive_session.current_cargo.append("food_supply")
	main.call("_apply_health_damage", 200.0, "thermal vent heat")
	_expect(main.dive_session.result == DiveSessionScript.Result.FAILED, "fatal thermal vent damage should fail the dive")
	_expect(main.run_failure_cause.contains("health depleted"), "fatal thermal vent damage should record health as the failure cause")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 19.0
	scene_main.dive_session.health = scene_main.dive_session.max_health
	scene_main.call("_on_thermal_vent_hazard_body_entered", scene_main.player)
	_expect(is_equal_approx(scene_main.dive_session.health, scene_main.dive_session.max_health - scene_main.thermal_vent_health_damage), "scene thermal vent collision should damage health")
	_expect(is_equal_approx(scene_main.dive_session.oxygen, 19.0), "scene thermal vent collision should not drain oxygen")
	_expect(scene_main.status_label.text.contains("-18 health"), "scene thermal vent feedback should show the health loss amount")
	_expect(scene_main.status_label.text.contains("O2 unchanged"), "scene thermal vent feedback should be distinct from oxygen warning copy")
	var health_bar_fill := scene_main.get_node("HUD/HealthBarFill") as ColorRect
	_expect(is_equal_approx(health_bar_fill.color.r, HudPresenterScript.HEALTH_DAMAGED_COLOR.r) and is_equal_approx(health_bar_fill.color.g, HudPresenterScript.HEALTH_DAMAGED_COLOR.g), "recent health damage should tint the health bar separately from oxygen")
	scene_main.queue_free()

func _test_health_damage_night_resolution_copy() -> void:
	var damaged := MainScene.instantiate()
	root.add_child(damaged)
	damaged.dive_session.start()
	damaged.dive_session.oxygen = damaged.dive_session.max_oxygen
	damaged.dive_session.has_left_base = true
	damaged.player_in_base = false
	damaged.progression_state.banked_resources = {
		"scrap_metal": 1,
	}
	damaged.call("_apply_health_damage", damaged.thermal_vent_health_damage, "thermal vent heat")
	damaged.player_in_base = true
	damaged.call("_try_extract")

	_expect(damaged.dive_session.result == DiveSessionScript.Result.EXTRACTED, "damaged return should still extract successfully")
	_expect(damaged.last_night_report.contains("Health: 82/100 returned"), "night report should record the damaged return health value")
	_expect(damaged.last_night_report.contains("no surface heal"), "night report should state that surfacing did not heal health")
	_expect(damaged.last_night_report.contains("night med used build time") and damaged.last_night_report.contains("tomorrow health full"), "night report should name the health recovery cost and payoff")
	_expect(damaged.last_result_summary.contains("no surface heal"), "result summary should carry the health resolution line through the night report")
	_expect(damaged.run_summary_label.text.contains("no surface heal"), "default Night tab should show the health resolution line")
	_expect(damaged.night_health_recovery_used_build_time, "damaged extraction should reserve the one-night build window for medical recovery")
	_expect(damaged.call("_format_night_build_choice_line").contains("Night med used build time"), "Night tab should show that medical recovery consumed the build choice")
	_expect(damaged.call("_format_night_build_prompt").contains("review night med"), "Night prompt should point at the medical recovery tradeoff")
	_expect(not bool(damaged.call("_try_craft_night_power_patch")), "Power Patch craft should wait when night medical recovery used the build window")
	_expect(damaged.progression_state.resource_count("scrap_metal") == 1, "blocked Power Patch should not spend banked scrap")
	_expect(not damaged.last_night_report.contains("Power Patch spent"), "blocked Power Patch should not append a false build result")
	_expect(is_equal_approx(damaged.dive_session.health, 82.0), "extraction should not instantly heal health before the next expedition reset")
	damaged.call("_restart_dive")
	_expect(is_equal_approx(damaged.dive_session.health, damaged.dive_session.max_health), "next expedition should start after the night medical recovery")
	_expect(not damaged.night_health_recovery_used_build_time, "new expedition should clear the medical build reservation")
	damaged.queue_free()

	var clean := MainScene.instantiate()
	root.add_child(clean)
	clean.dive_session.start()
	clean.dive_session.has_left_base = true
	clean.player_in_base = true
	clean.call("_try_extract")

	_expect(not clean.last_night_report.contains("no surface heal"), "undamaged extraction should omit health resolution copy")
	_expect(not clean.last_result_summary.contains("no surface heal"), "undamaged result summary should omit health resolution copy")
	clean.queue_free()

func _test_surface_oxygen_refill_isolation() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()
	session.oxygen = 8.0
	session.has_left_base = true
	session.current_cargo.append("driftwood")

	session.refill_oxygen(7.0)

	_expect(is_equal_approx(session.oxygen, 15.0), "surface refill should increase oxygen without requiring extraction")
	_expect(session.result == DiveSessionScript.Result.DIVING, "surface refill should keep the dive active")
	_expect(session.current_cargo == ["driftwood"], "surface refill should preserve carried cargo")
	_expect(not session.can_extract(false), "surface refill away from the ship should not become extraction eligible")
	session.refill_oxygen(100.0)
	_expect(is_equal_approx(session.oxygen, session.max_oxygen), "surface refill should clamp at max oxygen")

	var main := MainScript.new()
	main.surface_oxygen_refill_per_second = 6.0
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 9.0
	main.dive_session.has_left_base = true
	main.dive_session.current_cargo.append("driftwood")
	main.player_in_base = false
	main.player_in_surface_oxygen_refill = true
	main.call("_update_active_dive_oxygen", 1.0)
	_expect(is_equal_approx(main.dive_session.oxygen, 15.0), "active dive oxygen tick should refill at open surface")
	_expect(main.dive_session.current_cargo == ["driftwood"], "active surface refill should not clear carried cargo")
	_expect(main.progression_state.banked_resources.is_empty(), "active surface refill should not bank resources")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "active surface refill should not resolve the dive")
	_expect(main.call("_surface_oxygen_status_text") == "Surface O2 refilling; ship still banks cargo.", "surface status should distinguish oxygen refill from ship banking")
	var surface_prompt: String = main.call("_format_hud_prompt")
	_expect(surface_prompt.contains("O2 refill") and surface_prompt.contains("Cargo 1/3") and surface_prompt.contains("Ship banks"), "surface prompt should separate oxygen refill from cargo banking and show carried capacity")
	main.player_in_base = true
	var ship_prompt: String = main.call("_format_hud_prompt")
	_expect(ship_prompt.contains("At ship") and ship_prompt.contains("offload cargo 1/3") and ship_prompt.contains("O2 full"), "ship prompt should remain the cargo banking/offload prompt with capacity")
	main.free()

func _test_ship_offload_repeat_daylight_sortie() -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 6.0
	main.dive_session.health = 64.0
	main.dive_session.has_left_base = true
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("food_supply")
	main.player_in_base = true
	main.daylight_elapsed_seconds = 123.0
	main.daylight_nightfall_announced = false
	var starting_day: int = main.survival_state.current_day
	var starting_water := main.survival_state.water
	var starting_power := main.survival_state.power

	_expect(bool(main.call("_try_ship_offload")), "ship offload should accept carried cargo during active daylight")

	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "ship offload should keep the same daylight dive active")
	_expect(main.dive_session.current_cargo.is_empty(), "ship offload should clear carried inventory")
	_expect(is_equal_approx(main.dive_session.oxygen, main.dive_session.max_oxygen), "ship offload should leave oxygen ready for the next sortie")
	_expect(is_equal_approx(main.dive_session.health, 64.0), "ship offload should not heal health")
	_expect(main.progression_state.resource_count("driftwood") == 1, "ship offload should bank resource cargo")
	_expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED + 1, "ship offload should bank survival supplies without waiting for night")
	_expect(main.survival_state.water == starting_water and main.survival_state.power == starting_power, "ship offload should only change supplied survival needs")
	_expect(main.survival_state.current_day == starting_day, "ship offload should not resolve the night or advance the survival day")
	_expect(is_equal_approx(main.daylight_elapsed_seconds, 123.0), "ship offload should preserve the current daylight timer")
	_expect(main.daylight_ship_offload_count == 1, "ship offload should count repeated daylight sorties")
	_expect(main.last_completed_survival_day == 0, "ship offload should not mark the day as completed")
	_expect(main.status_label.text == "Ship banked cargo; O2 full. Dive again.", "ship offload status should be concise enough for the active HUD row")
	var clear_prompt: String = main.call("_format_hud_prompt")
	_expect(clear_prompt.contains("cargo banked") and clear_prompt.contains("O2 full") and clear_prompt.contains("dive again"), "ship prompt should invite another sortie after offload")
	_expect(main.upgrade_menu_feedback.contains("Ship offload banked 2 cargo item") and main.upgrade_menu_feedback.contains("Oxygen full"), "ship offload feedback should explain cargo banking, oxygen refill, and continued daylight")

	main.dive_session.current_cargo.append("driftwood")
	main.daylight_nightfall_announced = true
	_expect(not bool(main.call("_try_ship_offload")), "nightfall should stop daylight offload and leave night-start handling separate")
	_expect(main.dive_session.current_cargo == ["driftwood"], "rejected nightfall offload should leave carried cargo untouched")
	main.free()

func _test_night_phase_end_day_and_upgrade_choice() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.start()
	main.player_in_base = true
	main.dive_session.has_left_base = true
	main.daylight_nightfall_announced = true
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("quartz_glass")
	main.dive_session.current_cargo.append("food_supply")
	main.dive_session.current_cargo.append("power_supply")
	main.daylight_ship_offload_count = 1
	var starting_day: int = main.survival_state.current_day

	main.call("_try_extract")

	_expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "returning to ship after nightfall should end the day")
	_expect(main.surface_tab_index == main.SURFACE_TAB_NIGHT, "successful end-of-day extraction should open the Night tab")
	_expect(main.last_completed_survival_day == starting_day, "night phase should remember the completed survival day")
	_expect(main.survival_state.current_day == starting_day + 1, "night resolution should prepare tomorrow")
	_expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED, "banked food/fish should pay tonight's food cost")
	_expect(main.survival_state.power == SurvivalStateScript.STARTING_NEED, "banked power should pay tonight's power cost")
	_expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED - 1, "missing water should show as a clear night consequence")
	var night_summary: String = main.call("_format_night_phase_summary")
	_expect(night_summary.contains("Night Report"), "Night tab should show the night report")
	_expect(night_summary.contains("Daylight closeout") and night_summary.contains("1 ship offload"), "Night tab should preserve the repeated-sortie day context")
	_expect(night_summary.contains("Power -1"), "Night tab should name power resolution")
	_expect(night_summary.contains("Base needs: Food"), "Night tab should show current base needs")
	_expect(night_summary.contains("Build choice: Water Filter I ready"), "Night tab should point to a compact build choice")
	_expect(night_summary.contains("build Water Filter I in Upgrades"), "Night tab should turn ready builds into a tomorrow plan")

	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	main.selected_upgrade_index = 0
	main.call("_try_purchase_selected_upgrade")

	_expect(main.progression_state.has_upgrade(WaterFilterUpgrade.id), "night upgrade choice should purchase Water Filter I")
	_expect(main.progression_state.resource_count("driftwood") == 0, "night upgrade should spend driftwood")
	_expect(main.progression_state.resource_count("quartz_glass") == 0, "night upgrade should spend quartz glass")
	_expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED, "Water Filter I should restore one water reserve during night")
	_expect(main.upgrade_menu_feedback.contains("Purchased Water Filter I"), "night purchase feedback should confirm the build choice")
	_expect(main.upgrade_menu_feedback.contains("Next:"), "night purchase feedback should include a concrete next-day plan")
	var post_purchase_prompt: String = main._format_next_expedition_prompt()
	_expect(not post_purchase_prompt.contains("build Water Filter I"), "tomorrow plan should move past Water Filter I after it is built")
	_expect(post_purchase_prompt.contains("Oxygen Tank I"), "tomorrow plan after Water Filter I should point back to the starter research upgrade path")

	main.call("_restart_dive")
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "restart after night should prepare the next day")
	_expect(main.survival_state.current_day == starting_day + 1, "restart after night should keep tomorrow's day number")
	main.queue_free()

func _test_night_build_presenter() -> void:
	var missing_choice := NightBuildPresenterScript.format_choice_line(
		false,
		false,
		true,
		false,
		"",
		"Upgrade progress: Oxygen Tank I needs Kelp Fiber x2",
		"Scrap Metal x1",
		"E/Enter",
		1
	)
	_expect(missing_choice.contains("Power Patch needs Scrap Metal x1"), "night build presenter should name missing Power Patch materials")
	_expect(missing_choice.contains("Oxygen Tank I needs Kelp Fiber x2"), "night build presenter should preserve compact upgrade progress")
	var ready_choice := NightBuildPresenterScript.format_choice_line(false, false, true, true, "", "", "Scrap Metal x1", "E/Enter", 1)
	_expect(ready_choice.contains("Power Patch ready"), "night build presenter should expose available Power Patch craft")
	_expect(ready_choice.contains("E or Enter craft"), "night build presenter should use readable craft action labels")
	_expect(NightBuildPresenterScript.format_choice_line(false, true, true, false, "", "", "Scrap Metal x1", "E/Enter", 1).contains("Power Patch installed"), "night build presenter should show installed craft state")
	_expect(NightBuildPresenterScript.format_choice_line(true, false, true, true, "", "", "Scrap Metal x1", "E/Enter", 1).contains("Night med used build time"), "night build presenter should prioritize health recovery build lockout")
	_expect(NightBuildPresenterScript.format_choice_line(false, false, true, false, "Water Filter I", "", "Scrap Metal x1", "E/Enter", 1).contains("Water Filter I ready"), "night build presenter should expose ready upgrades when Power Patch is not ready")
	_expect(NightBuildPresenterScript.format_prompt(true, false, true, true, "E/Enter", "R", "Left/Right").contains("review night med"), "night build prompt should expose the health recovery review")
	_expect(NightBuildPresenterScript.format_prompt(false, false, true, true, "E/Enter", "R", "Left/Right").contains("craft Power Patch"), "night build prompt should expose available craft action")
	_expect(NightBuildPresenterScript.format_prompt(false, false, true, false, "E/Enter", "R", "Left/Right").contains("check Power Patch"), "night build prompt should expose missing craft review")

func _test_night_power_patch_build_choice() -> void:
	var main := MainScript.new()
	main.dive_session.start()
	main.dive_session.extract()
	main.surface_tab_index = main.SURFACE_TAB_NIGHT
	main.survival_state.power = 1

	var missing_choice := main._format_night_build_choice_line()
	_expect(missing_choice.contains("Power Patch needs Scrap Metal x1"), "Night tab should name the tiny craft cost when missing")
	_expect(main._format_night_build_prompt().contains("check Power Patch"), "Night prompt should expose the build action even before materials are ready")

	main.progression_state.banked_resources = {
		"scrap_metal": 1,
	}
	var ready_choice := main._format_night_build_choice_line()
	_expect(ready_choice.contains("Power Patch ready"), "Night tab should expose an available craft when scrap is banked")
	_expect(ready_choice.contains("Power +1 tomorrow"), "Night tab should describe the next-day payoff")
	_expect(main._format_night_build_prompt().contains("craft Power Patch"), "Night prompt should make the available craft actionable")

	_expect(bool(main.call("_try_craft_night_power_patch")), "Night craft should succeed when scrap is banked")
	_expect(main.progression_state.resource_count("scrap_metal") == 0, "Night craft should spend banked scrap")
	_expect(main.survival_state.power == 2, "Night craft should add a visible Power reserve for tomorrow")
	_expect(main.night_build_completed_this_surface, "Night craft should be one-per-night")
	_expect(main.last_night_report.contains("Power Patch spent Scrap Metal x1"), "Night report should record the build result")
	_expect(main._format_night_build_choice_line().contains("Power Patch installed"), "Night tab should show the completed build instead of another available action")

	_expect(not bool(main.call("_try_craft_night_power_patch")), "Night craft should not repeat after the one-night build is complete")
	_expect(main.survival_state.power == 2, "Rejected repeat night craft should not add more Power")
	main.free()

func _test_nightfall_away_from_ship_late_return_consequence() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.start()
	main.player_in_base = false
	main.dive_session.has_left_base = true
	main.dive_session.oxygen = 12.0
	main.dive_session.health = 72.0
	main.daylight_elapsed_seconds = main.daylight_duration_seconds
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("food_supply")
	main.dive_session.current_cargo.append("power_supply")

	main.call("_advance_daylight_timer", 1.0)

	_expect(main.daylight_nightfall_announced, "nightfall away from ship should announce the day ending")
	_expect(main.daylight_nightfall_away_from_ship, "nightfall away from ship should mark the late-return consequence")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "nightfall away from ship should keep the dive active until final ship return")
	_expect(main.dive_session.current_cargo.size() == 3, "nightfall away from ship should keep cargo carried and at risk")
	_expect(is_equal_approx(main.dive_session.oxygen, 12.0), "nightfall away from ship should not change oxygen directly")
	_expect(is_equal_approx(main.dive_session.health, 72.0), "nightfall away from ship should not change health directly")
	var overstay_prompt: String = main.call("_format_hud_prompt")
	_expect(overstay_prompt.contains("return to ship") and overstay_prompt.contains("cargo at risk") and overstay_prompt.contains("late Power -1"), "overstay prompt should explain return, cargo risk, and power consequence")

	main.player_in_base = true
	_expect(not bool(main.call("_try_ship_offload")), "nightfall away from ship should disable daylight cargo offload")

	var extracted_cargo: Array[String] = []
	for item_id in main.dive_session.current_cargo:
		extracted_cargo.append(item_id)
	main.dive_session.extract()
	main.call("_bank_extracted_cargo", extracted_cargo)
	main.call("_bank_extracted_survival_supplies", extracted_cargo)
	main.last_completed_survival_day = main.survival_state.current_day
	main.call("_resolve_night_after_result")
	main.dive_session.clear_cargo()
	main.surface_tab_index = main.SURFACE_TAB_NIGHT

	_expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "late return to ship should resolve the day")
	_expect(main.dive_session.current_cargo.is_empty(), "late final return should clear carried cargo after banking")
	_expect(main.progression_state.resource_count("driftwood") == 1, "late final return should still bank carried material cargo")
	_expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED, "late final return should bank food before paying night food")
	_expect(main.survival_state.power == SurvivalStateScript.STARTING_NEED - 1, "late final return should bank power then pay normal night power plus late power")
	_expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED - 1, "late final return should still pay normal night water")
	_expect(main.last_night_report.contains("Late return cost: Power -1"), "Night tab should name the late return power cost")
	var closeout_line: String = main.call("_format_daylight_closeout_line")
	_expect(closeout_line.contains("nightfall caught the diver away from ship") and closeout_line.contains("cost extra Power"), "Night tab closeout should preserve the late-return context")
	var ship_prompt: String = main.call("_format_hud_prompt")
	_expect(ship_prompt.contains("Night build") and not ship_prompt.contains("return to ship"), "after late return extraction, HUD should leave active overstay prompts")
	main.queue_free()

func _test_debug_unlimited_oxygen() -> void:
	var session := DiveSessionScript.new()
	session.reset(10.0)
	session.start()
	session.add_cargo("kelp_fiber")
	session.unlimited_oxygen = true

	session.drain_oxygen(12.0)

	_expect(session.oxygen == 10.0, "debug unlimited oxygen should keep oxygen unchanged")
	_expect(session.result == DiveSessionScript.Result.DIVING, "debug unlimited oxygen should not fail the dive")
	_expect(session.current_cargo == ["kelp_fiber"], "debug unlimited oxygen should preserve carried cargo")

	var main := MainScript.new()
	main.dive_session.reset(10.0)
	main.dive_session.start()
	main.show_debug_telemetry = false
	main.call("_sync_debug_oxygen_mode")
	_expect(not main.dive_session.unlimited_oxygen, "hidden debug telemetry should keep normal oxygen rules")
	main.show_debug_telemetry = true
	main.call("_sync_debug_oxygen_mode")
	_expect(main.dive_session.unlimited_oxygen, "shown debug telemetry should enable unlimited oxygen for exploration")
	main.free()

func _test_survival_night_consumption() -> void:
	var survival := SurvivalStateScript.new()
	var cache_copy := SurvivalStateScript.new()

	var day_one_report := survival.resolve_night()

	_expect(survival.current_day == 2, "survival night should advance from day one to day two")
	_expect(survival.food == 2, "survival night should consume one food")
	_expect(survival.water == 2, "survival night should consume one water")
	_expect(survival.power == 2, "survival night should consume one power")
	_expect(day_one_report[0].contains("Night cost paid"), "survival report should explain night consumption")
	_expect(day_one_report[0].contains("Food -1") and day_one_report[0].contains("Water -1") and day_one_report[0].contains("Power -1"), "survival report should name each consumed need")
	_expect(survival.status_line().contains("Base needs: Food 2, Water 2, Power 2"), "survival status should use readable Food/Water/Power names")
	_expect(not survival.status_line().contains("F2 W2 P2"), "survival status should not use cryptic need abbreviations")
	_expect(survival.nightly_pressure_line().contains("Tonight"), "ready copy helper should explain nightly pressure")
	_expect(survival.supply_cache_hint_line().contains("cargo space"), "ready copy helper should explain the supply-cache cargo tradeoff")
	_expect(cache_copy.supply_cache_hint_line().contains("base needs are stable"), "ready copy helper should explain when the supply cache is backup")
	cache_copy.power = 1
	_expect(cache_copy.supply_cache_hint_line().contains("Power") and cache_copy.supply_cache_hint_line().contains("lowest need"), "ready copy helper should name the weakest need the cache targets")

	var late_return := SurvivalStateScript.new()
	var late_report := late_return.resolve_night(1)
	_expect(late_return.food == 2 and late_return.water == 2 and late_return.power == 1, "late return night should add one deterministic power cost without changing food or water")
	_expect("\n".join(late_report).contains("Power -2"), "late return night report should include total power cost")
	_expect("\n".join(late_report).contains("Late return cost"), "late return night report should explain the extra power cost")

	survival.resolve_night()
	var warning_report := survival.resolve_night()
	_expect(survival.current_day == 4, "survival should keep advancing while needs are at zero")
	_expect(survival.oxygen_penalty() == 12.0, "zero food, water, and power should create a staged oxygen penalty")
	_expect("\n".join(warning_report).contains("Tomorrow oxygen penalty"), "zero-need night should warn about reduced oxygen")
	_expect("\n".join(warning_report).contains("-12 max oxygen"), "zero-need night should quantify the next-day oxygen penalty")

func _test_survival_collapse_and_reset() -> void:
	var survival := SurvivalStateScript.new()
	survival.food = 0
	survival.water = 0
	survival.power = 0

	var collapse_report := survival.resolve_night()

	_expect(survival.chapter_failed, "survival should collapse when a need falls below zero")
	_expect("\n".join(collapse_report).contains("Collapse"), "collapse report should name the chapter failure")
	survival.reset_chapter()
	_expect(not survival.chapter_failed, "survival reset should clear chapter failure")
	_expect(survival.current_day == 1, "survival reset should return to day one")
	_expect(survival.food == 3 and survival.water == 3 and survival.power == 3, "survival reset should restore starting supplies")

func _test_survival_supply_banking_isolation() -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["kelp_fiber", "food_supply", "power_supply"]

	var resources: Array[String] = main.call("_bank_extracted_cargo", cargo)
	var supplies: Array[String] = main.call("_bank_extracted_survival_supplies", cargo)

	_expect(resources == ["kelp_fiber"], "survival supplies should not bank as upgrade resources")
	_expect(supplies == ["food_supply", "power_supply"], "survival supply banking should return only supply cargo")
	_expect(main.progression_state.resource_count("kelp_fiber") == 1, "resource cargo should still bank normally")
	_expect(main.progression_state.resource_count("food_supply") == 0, "food supply should not appear in resource bank")
	_expect(main.survival_state.food == 4, "food supply should increase survival food")
	_expect(main.survival_state.power == 4, "power supply should increase survival power")
	_expect(main.survival_state.water == 3, "unbanked water should remain unchanged")

func _test_survival_supply_cache_presenter() -> void:
	_expect(SurvivalSupplyCachePresenterScript.format_status_text(true, "Power").contains("base stable"), "stable cache status should say the cache is backup")
	_expect(SurvivalSupplyCachePresenterScript.format_status_text(false, "Power").contains("Power is lowest"), "cache status should name the currently weakest survival need")
	_expect(SurvivalSupplyCachePresenterScript.format_prompt(true, "Power", "E/Enter").contains("backup supply"), "stable cache prompt should avoid naming a false weak need")
	_expect(SurvivalSupplyCachePresenterScript.format_prompt(false, "Power", "E/Enter").contains("recover Power"), "cache prompt should name the currently weakest survival need")
	_expect(SurvivalSupplyCachePresenterScript.format_full_status(true, "Power") == "Cargo full: backup cache needs a slot.", "stable full-cache status should preserve backup copy")
	_expect(SurvivalSupplyCachePresenterScript.format_full_status(false, "Power") == "Cargo full: Power cache needs a slot.", "full-cache status should name the blocked target")
	_expect(SurvivalSupplyCachePresenterScript.format_recovered_status("Power Cell", "Power").contains("Power Cell") and SurvivalSupplyCachePresenterScript.format_recovered_status("Power Cell", "Power").contains("Ship banks"), "recovered cache status should name the supply role and ship banking")

func _test_survival_supply_cache_target_copy() -> void:
	var stable_status := SurvivalSupplyCachePresenterScript.format_status_text(true, "Power")
	var stable_prompt := SurvivalSupplyCachePresenterScript.format_prompt(true, "Power", "E/Enter")
	_expect(stable_status.contains("base stable"), "stable cache status should say the cache is backup")
	_expect(stable_prompt.contains("backup supply"), "stable cache prompt should avoid naming a false weak need")

	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.start()
	main.survival_state.food = 3
	main.survival_state.water = 2
	main.survival_state.power = 1
	main.player_near_survival_supply_cache = true

	var prompt: String = main.call("_format_hud_prompt")
	var status := SurvivalSupplyCachePresenterScript.format_status_text(false, main.survival_state.short_name_for_supply(main.survival_state.most_needed_supply_id()))
	_expect(prompt.contains("Power"), "cache prompt should name the currently weakest survival need before pickup")
	_expect(status.contains("Power is lowest"), "cache status should name the currently weakest survival need before pickup")

	main.call("_on_survival_supply_cache_body_entered", main.player)
	_expect(main.status_label.text.contains("Power is lowest"), "cache entry status should name the weakest need")

	var full_cargo: Array[String] = ["kelp_fiber", "shell_fragments", "driftwood"]
	main.dive_session.current_cargo = full_cargo
	var handled_full := bool(main.call("_try_survival_supply_cache_interaction"))
	_expect(handled_full, "full cargo cache interaction should be handled with feedback")
	_expect(main.status_label.text.contains("Cargo full") and main.status_label.text.contains("Power"), "full cargo cache status should stay short and name the blocked target")
	_expect(not main.run_survival_supply_cache_recovered, "full cargo should not mark the cache recovered")

	main.dive_session.current_cargo.clear()
	var handled_pickup := bool(main.call("_try_survival_supply_cache_interaction"))
	_expect(handled_pickup, "cache interaction should recover a supply when cargo has room")
	_expect(main.dive_session.current_cargo.size() == 1 and main.dive_session.current_cargo[0] == "power_supply", "cache pickup should add the weakest survival supply")
	_expect(main.status_label.text.contains("Power Cell") and main.status_label.text.contains("Power") and main.status_label.text.contains("Ship banks"), "recovered cache status should name the supply role and ship banking")
	_expect(String(main.call("_format_hud_prompt")).contains("recovered"), "recovered cache prompt should stay compact")
	main.queue_free()

func _test_starter_survival_resource_families() -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["scrap_metal", "driftwood", "quartz_glass", "food_supply", "water_supply", "power_supply"]
	var resources: Array[String] = main.call("_bank_extracted_cargo", cargo)
	var supplies: Array[String] = main.call("_bank_extracted_survival_supplies", cargo)

	_expect(resources == ["scrap_metal", "driftwood", "quartz_glass"], "starter crafting materials should bank as upgrade resources")
	_expect(supplies == ["food_supply", "water_supply", "power_supply"], "starter food, water, and power should bank as survival supplies")
	_expect(main.progression_state.resource_count("scrap_metal") == 1, "scrap metal should appear in the resource bank")
	_expect(main.progression_state.resource_count("driftwood") == 1, "driftwood should appear in the resource bank")
	_expect(main.progression_state.resource_count("quartz_glass") == 1, "quartz glass should appear in the resource bank")
	_expect(main.survival_state.food == 4, "food pickup should increase survival food")
	_expect(main.survival_state.water == 4, "water pickup should increase survival water")
	_expect(main.survival_state.power == 4, "power pickup should increase survival power")
	_expect(main.call("_format_resource_counts", resources).contains("Building: Scrap Metal"), "resource result copy should name building materials")
	_expect(main.call("_format_survival_supply_counts", supplies).contains("Food/Fish: Food/Fish Supply"), "survival result copy should name the food/fish role")
	_expect(main.call("_format_survival_supply_counts", supplies).contains("Power: Power Cell"), "survival result copy should name the power role")
	var summary_names := {
		"scrap_metal": "Scrap Metal",
		"food_supply": "Food/Fish Supply",
	}
	var summary_categories := {
		"scrap_metal": "Building",
		"food_supply": "Food/Fish",
	}
	_expect(InventorySummaryPresenterScript.format_item_counts(["scrap_metal", "scrap_metal"], summary_categories, summary_names).contains("Scrap Metal x2"), "inventory summary presenter should count repeated resources")
	_expect(InventorySummaryPresenterScript.format_cargo_counts_inline(["scrap_metal", "food_supply"], {"scrap_metal": "Scrap", "food_supply": "Food"}) == " - Scrap x1, Food x1", "inventory summary presenter should keep compact cargo copy")
	_expect(InventorySummaryPresenterScript.format_extraction_banking_line(0, "", true).contains("scan data"), "inventory summary presenter should preserve scan-only extraction copy")
	_expect(InventorySummaryPresenterScript.format_supply_names_inline(["food_supply", "power_supply"], {"food_supply": "Food", "power_supply": "Power"}) == "Food/Power", "inventory summary presenter should compact supply names")
	_expect(ResourcePresenterScript.resource_role_summary("food_supply", true, "Food/Fish", "fill tonight's Food reserve").contains("Food/Fish survival supply"), "food pickup role should read as survival supply")
	_expect(ResourcePresenterScript.resource_role_summary("power_supply", true, "Power", "fill tonight's Power reserve").contains("Power survival supply"), "power pickup role should read as survival supply")
	_expect(ResourcePresenterScript.resource_role_summary("scrap_metal", false, "Building", "").contains("Building material"), "scrap pickup role should read as building material")
	_expect(ResourcePresenterScript.resource_role_summary("kelp_fiber", false, "Research", "").contains("Research material"), "kelp pickup role should read as research material")
	_expect(ResourcePresenterScript.resource_collection_guidance(false, "Building", "").contains("repairs/upgrades"), "building resource guidance should stay exact enough for route copy")
	_expect(ResourcePresenterScript.resource_pickup_feedback("food_supply", 1, 3, true, "Food/Fish").contains("Food/Fish reserve"), "supply pickup feedback should keep base-need reserve copy")
	_expect(ResourcePresenterScript.resource_visual_role_family(false, "Building") == "building", "building resources should keep building role family")
	_expect(ResourcePresenterScript.resource_role_accent_color("food_supply") == Color(1.0, 0.32, 0.08, 0.95), "food supply role accent should stay exact")
	var role_host := Node2D.new()
	ResourceRoleVisualPresenterScript.ensure_resource_role_visual(role_host, "food_supply", "supply", ResourcePresenterScript.resource_role_accent_color("food_supply"))
	var direct_role_read := role_host.get_node_or_null("RoleRead") as Node2D
	_expect(direct_role_read != null and direct_role_read.get_child_count() >= 3, "resource role visual presenter should build readable marker geometry")
	_expect(String(direct_role_read.get_meta("role_family", "")) == "supply", "resource role visual presenter should preserve role family metadata")
	role_host.free()
	for definition in StarterResourceDefinitions:
		_expect(not definition.resource_category.is_empty(), "%s should declare a resource category" % definition.id)

	var scene := MainScene.instantiate()
	root.add_child(scene)
	scene.call("_ensure_resource_role_visuals")
	var expected_pickups := {
		"KelpFiber": {"id": "kelp_fiber", "family": "research"},
		"ShellFragments": {"id": "shell_fragments", "family": "research"},
		"GlowPlankton": {"id": "glow_plankton", "family": "research"},
		"ScrapMetal": {"id": "scrap_metal", "family": "building"},
		"Driftwood": {"id": "driftwood", "family": "building"},
		"QuartzGlass": {"id": "quartz_glass", "family": "building"},
		"FoodSupply": {"id": "food_supply", "family": "supply"},
		"WaterSupply": {"id": "water_supply", "family": "supply"},
		"PowerSupply": {"id": "power_supply", "family": "supply"},
	}
	for pickup_name in expected_pickups.keys():
		var expected := expected_pickups[pickup_name] as Dictionary
		var pickup := scene.get_node("ResourcePickups/%s" % pickup_name) as ResourcePickup
		var candidate := scene.get_node_or_null("StarterResourceCandidates/%s/A" % pickup_name)
		var role_read := pickup.get_node_or_null("RoleRead") as Node2D
		_expect(pickup.definition.id == String(expected.get("id", "")), "%s should use the expected resource definition" % pickup_name)
		_expect(candidate != null, "%s should have at least one authored spawn candidate" % pickup_name)
		_expect(role_read != null and role_read.visible, "%s should show a pre-pickup role read marker" % pickup_name)
		if role_read != null:
			_expect(String(role_read.get_meta("role_family", "")) == String(expected.get("family", "")), "%s role marker should declare the expected cargo family" % pickup_name)
			_expect(role_read.get_child_count() >= 3, "%s role marker should have enough visible shapes to read at play scale" % pickup_name)
	var food_guidance: String = main.call("_format_first_scan_guidance", scene.get_node("ResourcePickups/FoodSupply"))
	var power_fact: String = main.call("_scan_target_gameplay_fact", scene.get_node("ResourcePickups/PowerSupply"))
	var scrap_guidance: String = main.call("_format_first_scan_guidance", scene.get_node("ResourcePickups/ScrapMetal"))
	var kelp_fact: String = main.call("_scan_target_gameplay_fact", scene.get_node("ResourcePickups/KelpFiber"))
	_expect(food_guidance.contains("Food reserve") and food_guidance.contains("Return to ship"), "food scan guidance should explain the tonight/base decision")
	_expect(power_fact.contains("Power survival supply") and power_fact.contains("base needs for tonight"), "power scan fact should explain the survival role")
	_expect(scrap_guidance.contains("building material") and scrap_guidance.contains("repairs/upgrades"), "scrap scan guidance should explain the building role")
	_expect(kelp_fact.contains("Research material") and kelp_fact.contains("Oxygen Tank I"), "kelp scan fact should explain the research/upgrade role")
	scene.queue_free()

func _test_resource_taxonomy_offload_copy() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.start()
	main.player_in_base = true
	main.dive_session.has_left_base = true
	var mixed_cargo: Array[String] = ["food_supply", "power_supply", "scrap_metal", "kelp_fiber"]
	main.dive_session.current_cargo = mixed_cargo

	var offloaded := bool(main.call("_try_ship_offload"))

	_expect(offloaded, "ship offload should accept mixed taxonomy cargo")
	_expect(main.survival_state.food == 4, "food/fish offload should bank survival food")
	_expect(main.survival_state.power == 4, "power offload should bank survival power")
	_expect(main.progression_state.resource_count("scrap_metal") == 1, "building offload should bank scrap")
	_expect(main.progression_state.resource_count("kelp_fiber") == 1, "research offload should bank kelp fiber")
	_expect(main.upgrade_menu_feedback.contains("Food/Fish: Food/Fish Supply"), "offload copy should label food/fish survival value")
	_expect(main.upgrade_menu_feedback.contains("Power: Power Cell"), "offload copy should label power survival value")
	_expect(main.upgrade_menu_feedback.contains("Building: Scrap Metal"), "offload copy should label building value")
	_expect(main.upgrade_menu_feedback.contains("Research: Kelp Fiber"), "offload copy should label research value")
	_expect(main.status_label.text == "Ship banked cargo; O2 full. Dive again.", "active offload status should stay compact while detailed taxonomy remains in feedback")
	main.queue_free()

	var pickup_scene := MainScene.instantiate()
	root.add_child(pickup_scene)
	pickup_scene.dive_session.start()
	var power_pickup := pickup_scene.get_node("ResourcePickups/PowerSupply") as ResourcePickup
	pickup_scene.call("_on_resource_pickup_collected", power_pickup)
	_expect(pickup_scene.status_label.text.contains("Power Cell") and pickup_scene.status_label.text.contains("Cargo 1/3") and pickup_scene.status_label.text.contains("Power reserve"), "power pickup feedback should name capacity and night-survival role")
	pickup_scene.queue_free()

func _test_survival_oxygen_penalty() -> void:
	var main := MainScript.new()
	main.survival_state.food = 0

	_expect(main._current_max_oxygen() == 26.0, "one empty survival need should reduce next expedition oxygen")
	main.progression_state.purchased_upgrades[OxygenTankUpgrade.id] = true
	_expect(main._current_max_oxygen() == 36.0, "survival oxygen penalty should apply after oxygen upgrade max is calculated")

func _test_upgrade_affordability() -> void:
	var progression := ProgressionStateScript.new()

	_expect(not progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should not be affordable without resources")
	progression.banked_resources = {
		"kelp_fiber": 2,
		"shell_fragments": 1,
		"glow_plankton": 1,
	}

	_expect(progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should become affordable with exact resources")
	_expect(progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "affordable upgrade should purchase")
	_expect(progression.has_upgrade(OxygenTankUpgrade.id), "purchased upgrade id should be recorded")
	_expect(progression.resource_count("kelp_fiber") == 0, "purchase should spend kelp fiber")
	_expect(progression.resource_count("shell_fragments") == 0, "purchase should spend shell fragments")
	_expect(progression.resource_count("glow_plankton") == 0, "purchase should spend glow plankton")
	_expect(not progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "owned upgrade should not purchase again")

	var resonance_progression := ProgressionStateScript.new()
	resonance_progression.banked_resources = {
		"glow_plankton": 2,
		"shell_fragments": 1,
	}
	_expect(resonance_progression.can_afford(ResonanceKeyUpgrade.resource_cost), "Resonance Key I should use currently bankable materials")
	_expect(UpgradePurchaseScript.missing_upgrade(resonance_progression, ResonanceKeyUpgrade) == EchoLensUpgrade.id, "Resonance Key I purchase should require Echo Lens I first")
	_expect(not UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should not purchase before prerequisites")
	resonance_progression.purchased_upgrades[EchoLensUpgrade.id] = true
	resonance_progression.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	_expect(UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should purchase after route context, Echo Lens I, and resources")
	_expect(resonance_progression.has_upgrade(ResonanceKeyUpgrade.id), "Resonance Key I purchase should record the upgrade id")
	_expect(resonance_progression.resource_count("glow_plankton") == 0, "Resonance Key I purchase should spend glow plankton")
	_expect(resonance_progression.resource_count("shell_fragments") == 0, "Resonance Key I purchase should spend shell fragments")
	_expect(not UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should not purchase twice")

	var starter_progression := ProgressionStateScript.new()
	_expect(not starter_progression.can_afford(WaterFilterUpgrade.resource_cost), "Water Filter I should not be affordable without starter resources")
	starter_progression.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	_expect(starter_progression.can_afford(WaterFilterUpgrade.resource_cost), "Water Filter I should become affordable with starter resources")
	_expect(UpgradePurchaseScript.purchase(starter_progression, WaterFilterUpgrade), "Water Filter I should purchase without scan prerequisites")
	_expect(starter_progression.has_upgrade(WaterFilterUpgrade.id), "Water Filter I purchase should record ownership")
	_expect(starter_progression.resource_count("driftwood") == 0, "Water Filter I should spend driftwood")
	_expect(starter_progression.resource_count("quartz_glass") == 0, "Water Filter I should spend quartz glass")
	_expect(not UpgradePurchaseScript.purchase(starter_progression, WaterFilterUpgrade), "Water Filter I should not purchase twice")

func _test_progression_reset() -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)
	progression.advance_run()

	progression.reset()

	_expect(progression.banked_resources.is_empty(), "reset should clear banked resources")
	_expect(progression.purchased_upgrades.is_empty(), "reset should clear purchased upgrades")
	_expect(progression.scan_discoveries.is_empty(), "reset should clear scan discoveries")
	_expect(is_equal_approx(progression.best_depth_reached, 0.0), "reset should clear best depth")
	_expect(progression.current_run_number == 0, "reset should return run counter to pre-expedition state")
	_expect(progression.current_run_seed == 0, "reset should clear current seed")

	progression.advance_run()
	_expect(progression.current_run_number == 1, "first run after reset should be expedition 1")
	_expect(progression.current_run_seed == 8919, "first seed after reset should match expedition 1")

func _test_save_load_behavior() -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)

	var saved: Dictionary = progression.to_save_data()
	_expect(int(saved.get("save_version", -1)) == ProgressionStateScript.CURRENT_SAVE_VERSION, "save should include current save version")

	var loaded := ProgressionStateScript.new()
	loaded.load_save_data(saved)
	_expect(loaded.resource_count("kelp_fiber") == 3, "current save should reload banked resources")
	_expect(loaded.has_upgrade(OxygenTankUpgrade.id), "current save should reload purchased upgrades")
	_expect(loaded.has_discovery("thermal_vent"), "current save should reload scan discoveries")
	_expect(is_equal_approx(loaded.best_depth_reached, 144.5), "current save should reload best depth")

	var resonance_save_state := ProgressionStateScript.new()
	resonance_save_state.banked_resources = {"glow_plankton": 4, "shell_fragments": 2}
	resonance_save_state.purchased_upgrades = {
		EchoLensUpgrade.id: true,
		ResonanceKeyUpgrade.id: true,
	}
	resonance_save_state.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	var resonance_saved := resonance_save_state.to_save_data()
	var resonance_loaded := ProgressionStateScript.new()
	resonance_loaded.load_save_data(resonance_saved)
	_expect(resonance_loaded.has_upgrade(ResonanceKeyUpgrade.id), "current save should reload Resonance Key I purchase")
	_expect(resonance_loaded.has_upgrade(EchoLensUpgrade.id), "current save should preserve Resonance Key I prerequisite upgrade")
	_expect(resonance_loaded.has_discovery("east_shelf_route_research"), "current save should reload promoted route-research prerequisite")

	var legacy_save := saved.duplicate(true)
	legacy_save.erase("save_version")
	var legacy_loaded := ProgressionStateScript.new()
	legacy_loaded.load_save_data(legacy_save)
	_expect(legacy_loaded.loaded_save_version == ProgressionStateScript.LEGACY_SAVE_VERSION, "missing save version should load as legacy")
	_expect(legacy_loaded.has_discovery("thermal_vent"), "legacy save should reload known discovery fields")

	var future_save := saved.duplicate(true)
	future_save["save_version"] = 999
	var future_loaded := ProgressionStateScript.new()
	future_loaded.load_save_data(future_save)
	_expect(future_loaded.loaded_save_version == 999, "unknown future save version should be recorded")
	_expect(future_loaded.has_upgrade(OxygenTankUpgrade.id), "unknown future save should best-effort load known upgrade ids")

	var main := MainScene.instantiate()
	root.add_child(main)
	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_hollow_reef_reading_recovered = true
	main.player_near_east_shelf_pocket = true
	main.player_near_lower_connector_echo = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_blackwater_crack = true
	main.player_near_hollow_reef = true
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var main_saved: Dictionary = main.progression_state.to_save_data()
	_expect(not main_saved.has("run_east_shelf_pocket_ping_recovered"), "progression save should not leak East Shelf run state")
	_expect(not main_saved.has("run_lower_connector_echo_recovered"), "progression save should not leak Drop Echo run state")
	_expect(not main_saved.has("run_blue_chimney_draft_reading_recovered"), "progression save should not leak Blue Chimney draft state")
	_expect(not main_saved.has("run_lantern_silt_sample_recovered"), "progression save should not leak Lantern Silt run state")
	_expect(not main_saved.has("run_blackwater_trace_recovered"), "progression save should not leak Blackwater Trace run state")
	_expect(not main_saved.has("run_hollow_reef_reading_recovered"), "progression save should not leak Hollow Reef run state")
	_expect(not main_saved.has("player_near_east_shelf_pocket"), "progression save should not leak East Shelf proximity state")
	_expect(not main_saved.has("player_near_lower_connector_echo"), "progression save should not leak Drop Echo proximity state")
	_expect(not main_saved.has("player_near_blue_chimney"), "progression save should not leak Blue Chimney proximity state")
	_expect(not main_saved.has("player_near_lantern_silt_nook"), "progression save should not leak Lantern Silt proximity state")
	_expect(not main_saved.has("player_near_blackwater_crack"), "progression save should not leak Blackwater proximity state")
	_expect(not main_saved.has("player_near_hollow_reef"), "progression save should not leak Hollow Reef proximity state")
	_expect(not main_saved.has("blue_chimney_draft"), "progression save should not add durable Blue Chimney draft data")
	_expect(not main_saved.has("silt_vein"), "progression save should not add durable Silt Vein route data")
	_expect(not main_saved.has("silt_vein_fork"), "progression save should not add durable Silt Vein Fork route data")
	_expect(not main_saved.has("lantern_silt"), "progression save should not add durable Lantern Silt route data")
	_expect(not main_saved.has("lantern_silt_sample"), "progression save should not add durable Lantern Silt sample data")
	_expect(not main_saved.has("blackwater_crack"), "progression save should not add durable Blackwater Crack route data")
	_expect(not main_saved.has("blackwater_trace"), "progression save should not add durable Blackwater Trace data")
	_expect(not main_saved.has("dusk_trench"), "progression save should not add durable Dusk Trench route data")
	_expect(not main_saved.has("dusk_trench_reached"), "progression save should not add durable Dusk Trench reach memory")
	_expect(not main_saved.has("glass_kelp_reading"), "progression save should not add durable Glass Kelp reading data")
	_expect(not main_saved.has("hollow_reef"), "progression save should not add durable Hollow Reef route data")
	_expect(not main_saved.has("hollow_reef_reading"), "progression save should not add durable Hollow Reef reading data")
	_expect(main_saved.get("purchased_upgrades", {}).has(ResonanceKeyUpgrade.id), "progression save should keep Resonance Key I as durable upgrade state only")
	main.queue_free()

func _test_save_service() -> void:
	var save_path := "user://logic_test_save_service.json"
	SaveServiceScript.delete_progression_save(save_path)

	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)

	var survival := SurvivalStateScript.new()
	survival.current_day = 3
	survival.food = 2
	survival.water = 4
	survival.power = 1
	survival.chapter_complete = true

	_expect(SaveServiceScript.save_progression(save_path, progression, survival), "save service should write progression saves")

	var loaded_progression := ProgressionStateScript.new()
	var loaded_survival := SurvivalStateScript.new()
	_expect(SaveServiceScript.load_progression(save_path, loaded_progression, loaded_survival), "save service should load existing progression saves")
	_expect(loaded_progression.resource_count("kelp_fiber") == 3, "save service should reload banked resources")
	_expect(loaded_progression.has_upgrade(OxygenTankUpgrade.id), "save service should reload purchased upgrades")
	_expect(loaded_progression.has_discovery("thermal_vent"), "save service should reload scan discoveries")
	_expect(is_equal_approx(loaded_progression.best_depth_reached, 144.5), "save service should reload best depth")
	_expect(loaded_survival.current_day == 3, "save service should reload nested survival day")
	_expect(loaded_survival.food == 2 and loaded_survival.water == 4 and loaded_survival.power == 1, "save service should reload nested survival needs")
	_expect(loaded_survival.chapter_complete, "save service should reload nested survival chapter flags")

	_expect(SaveServiceScript.delete_progression_save(save_path), "save service should delete test save files")
	_expect(not SaveServiceScript.load_progression(save_path, loaded_progression, loaded_survival), "save service should report missing saves")

func _test_deterministic_seed_generation() -> void:
	var first := ProgressionStateScript.new()
	var second := ProgressionStateScript.new()

	for index in range(5):
		first.advance_run()
		second.advance_run()
		_expect(first.current_run_number == index + 1, "run number should advance deterministically")
		_expect(first.current_run_seed == 1000 + first.current_run_number * 7919, "run seed should follow the documented formula")
		_expect(first.current_run_seed == second.current_run_seed, "two progression states should generate the same seed sequence")

func _test_expedition_condition_selection() -> void:
	var first := ExpeditionConditionScript.condition_for_seed(8919)
	var first_again := ExpeditionConditionScript.condition_for_seed(8919)
	_expect(first.get("id", "") == first_again.get("id", ""), "same seed should select the same expedition condition")
	_expect(not String(first.get("display_name", "")).is_empty(), "condition should include a display name")
	_expect(not String(first.get("briefing", "")).is_empty(), "condition should include a briefing line")
	_expect(first.get("tags", []) is Array, "condition should include tag metadata")
	var low_visibility := ExpeditionConditionScript.condition_for_seed(4)
	_expect(low_visibility.get("id", "") == "low_visibility", "Low Visibility should remain deterministically selectable by seed")
	_expect(low_visibility.get("tags", []).has("visibility"), "Low Visibility should keep visibility tag metadata for route presentation")

	var ids := {}
	for seed in [8919, 16838, 24757, 32676, 40595]:
		ids[ExpeditionConditionScript.id_for_seed(seed)] = true

	_expect(ids.size() >= 2, "small seed set should produce at least two expedition conditions")
	_expect(ExpeditionConditionScript.id_for_seed(8919) == String(first.get("id", "")), "id_for_seed should match condition_for_seed")

func _test_spawn_point_matching() -> void:
	var point := SpawnPointScript.new()
	point.category = "resource"
	point.target_id = "kelp_fiber"
	point.depth_band = "shallow"
	point.cluster_pattern = "cautious"

	_expect(point.matches("resource", "kelp_fiber"), "spawn point should match category and target id")
	_expect(not point.matches("creature", "kelp_fiber"), "spawn point should reject different categories")
	_expect(not point.matches("resource", "glow_plankton"), "spawn point should reject different target ids")
	_expect(point.depth_band == "shallow", "spawn point should preserve authored depth band")
	_expect(point.cluster_pattern == "cautious", "spawn point should preserve authored cluster pattern")
	point.free()

func _test_spawn_selection() -> void:
	var root := Node2D.new()
	var shallow := _make_spawn_point("a", "resource", "kelp_fiber", "shallow", "any", Vector2(10.0, 20.0))
	var cautious := _make_spawn_point("b", "resource", "kelp_fiber", "shallow", "cautious", Vector2(30.0, 40.0))
	var deep_reward := _make_spawn_point("c", "resource", "kelp_fiber", "shallow", "deep_reward", Vector2(50.0, 60.0))
	root.add_child(shallow)
	root.add_child(cautious)
	root.add_child(deep_reward)

	var positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "kelp_fiber", "cautious")
	_expect(positions.size() == 2, "spawn selection should include any and matching cluster points")
	_expect(positions.has(Vector2(10.0, 20.0)), "spawn selection should include any-cluster point")
	_expect(positions.has(Vector2(30.0, 40.0)), "spawn selection should include matching cautious point")
	_expect(not positions.has(Vector2(50.0, 60.0)), "spawn selection should exclude nonmatching cluster point")
	_expect(SpawnSelectionScript.cluster_pattern_for_seed(1, ["cautious", "deep_reward"]) == "deep_reward", "spawn selection should map seeds to cluster patterns deterministically")
	var shell_reef := _make_spawn_point("reef", "resource", "shell_fragments", "midwater", "any", Vector2(70.0, 80.0))
	root.add_child(shell_reef)
	var shell_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward")
	_expect(shell_positions.size() == 1, "shell reef spawn selection should include one authored shell candidate without adding extra pickups")
	_expect(shell_positions.has(Vector2(70.0, 80.0)), "shell reef spawn selection should include any-pattern reef candidate")
	_expect(shell_reef.depth_band == "midwater", "shell reef spawn point should preserve midwater depth identity")

	var vent_glow := _make_spawn_point("vent", "resource", "glow_plankton", "deep", "deep_reward", Vector2(90.0, 100.0))
	root.add_child(vent_glow)
	var blue_chimney_glow := _make_spawn_point("blue_chimney", "resource", "glow_plankton", "deep", "deep_reward", Vector2(110.0, 130.0))
	root.add_child(blue_chimney_glow)
	var vent_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	_expect(vent_positions.size() == 2, "lower-route glow candidates should be selectable authored points without adding extra pickups")
	_expect(vent_positions.has(Vector2(90.0, 100.0)), "thermal vent pocket should expose inspectable glow placement")
	_expect(vent_positions.has(Vector2(110.0, 130.0)), "Blue Chimney should expose an optional existing-glow placement")
	_expect(vent_glow.depth_band == "deep", "thermal vent glow candidates should preserve deep resource identity")
	_expect(blue_chimney_glow.depth_band == "deep", "Blue Chimney glow candidate should preserve deep resource identity")
	root.free()

func _test_condition_weighted_spawn_selection() -> void:
	var root := Node2D.new()
	var glow_a := _make_spawn_point("glow_a", "resource", "glow_plankton", "deep", "deep_reward", Vector2(10.0, 100.0))
	var glow_b := _make_spawn_point("glow_b", "resource", "glow_plankton", "deep", "deep_reward", Vector2(20.0, 100.0))
	var vent_glow := _make_spawn_point("vent_glow", "resource", "glow_plankton", "deep", "deep_reward", Vector2(30.0, 100.0), "thermal_bloom")
	var shell := _make_spawn_point("shell", "resource", "shell_fragments", "midwater", "deep_reward", Vector2(40.0, 100.0), "thermal_bloom")
	root.add_child(glow_a)
	root.add_child(glow_b)
	root.add_child(vent_glow)
	root.add_child(shell)

	var unweighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	var calm_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "calm_current")
	var thermal_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var thermal_weighted_repeat := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var shell_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward", "thermal_bloom")

	_expect(unweighted.size() == 3, "unweighted glow selection should keep every authored matching candidate")
	_expect(calm_weighted == unweighted, "unaffected conditions should preserve glow selection behavior")
	_expect(thermal_weighted == thermal_weighted_repeat, "thermal bloom weighting should be deterministic for the same inputs")
	_expect(thermal_weighted.size() == 1, "thermal bloom weighting should not add active glow candidates")
	_expect(thermal_weighted.has(Vector2(30.0, 100.0)), "thermal bloom should prefer the authored vent glow candidate")
	_expect(vent_glow.depth_band == "deep", "condition-preferred glow should preserve deep depth-band identity")
	_expect(shell_weighted.size() == 1, "thermal bloom should not broaden non-glow resource selection")
	_expect(shell_weighted.has(Vector2(40.0, 100.0)), "thermal bloom should leave non-glow target positions intact")

	var default_route_start := _make_spawn_point("start", "creature", "lantern_ray", "deep", "cautious", Vector2(100.0, 200.0))
	default_route_start.route_id = "default_glide"
	var default_route_end := _make_spawn_point("end", "creature", "lantern_ray", "deep", "cautious", Vector2(180.0, 220.0))
	default_route_end.route_id = "default_glide"
	var low_visibility_start := _make_spawn_point("start", "creature", "lantern_ray", "deep", "cautious", Vector2(120.0, 180.0), "low_visibility")
	low_visibility_start.route_id = "low_visibility_glide"
	var low_visibility_end := _make_spawn_point("end", "creature", "lantern_ray", "deep", "cautious", Vector2(190.0, 190.0), "low_visibility")
	low_visibility_end.route_id = "low_visibility_glide"
	root.add_child(default_route_start)
	root.add_child(default_route_end)
	root.add_child(low_visibility_start)
	root.add_child(low_visibility_end)
	var calm_routes := SpawnSelectionScript.routes_for_target(root, SpawnPointScript, "creature", "lantern_ray", "cautious", "calm_current")
	var low_visibility_routes := SpawnSelectionScript.routes_for_target(root, SpawnPointScript, "creature", "lantern_ray", "cautious", "low_visibility")
	_expect(calm_routes.size() == 2, "nonmatching conditions should keep every authored Lantern Ray route candidate")
	_expect(low_visibility_routes.size() == 1 and low_visibility_routes.has("low_visibility_glide"), "matching conditions should prefer authored Lantern Ray route variants")
	root.free()

func _test_lantern_ray_route_variation() -> void:
	var main := MainScene.instantiate()
	var candidates := main.get_node("CreatureRouteCandidates") as Node2D
	var lantern_ray := main.get_node("Creatures/LanternRayRoute") as Area2D
	main.creature_route_candidates = candidates
	main.lantern_ray_route = lantern_ray

	for pattern in ["cautious", "deep_reward"]:
		var routes: Dictionary = SpawnSelectionScript.routes_for_target(candidates, SpawnPointScript, "creature", "lantern_ray", pattern)
		_expect(not routes.is_empty(), "Lantern Ray should have authored route candidates for %s runs" % pattern)
		for route_value in routes.values():
			var route: Dictionary = route_value
			var start: Vector2 = route["start"]
			var end: Vector2 = route["end"]
			_expect(start.x >= 2480.0 and end.x >= 2480.0, "Lantern Ray authored route should stay inside the lower-route creature area")
			_expect(start.x <= 2960.0 and end.x <= 2960.0, "Lantern Ray authored route should not bypass the current Dusk route bounds")
			_expect(start.y >= 2480.0 and end.y >= 2480.0, "Lantern Ray authored route should stay in the lower-route band")
			_expect(start.y <= 2740.0 and end.y <= 2740.0, "Lantern Ray authored route should leave the Blackwater/Dusk return gap readable")

	main.current_resource_cluster_pattern = "cautious"
	main.current_expedition_condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
	}
	var low_visibility_routes: Dictionary = main._spawn_routes_for_target("creature", "lantern_ray", "cautious")
	_expect(low_visibility_routes.size() == 1 and low_visibility_routes.has("lantern_ray_low_visibility_glide"), "Low Visibility should prefer the authored Lantern Ray high-safe route")
	var low_route: Dictionary = low_visibility_routes["lantern_ray_low_visibility_glide"]
	var low_rng := RandomNumberGenerator.new()
	low_rng.seed = 550
	main._place_lantern_ray_route_for_run(low_rng)
	_expect(main.current_lantern_ray_route_id == "lantern_ray_low_visibility_glide", "Lantern Ray route placement should use the condition-preferred route")
	_expect(lantern_ray.global_position == low_route["start"], "Lantern Ray should start at the selected authored route start")
	_expect(lantern_ray.get("move_start") == low_route["start"], "Lantern Ray move_start should follow the selected route")
	_expect(lantern_ray.get("move_end") == low_route["end"], "Lantern Ray move_end should follow the selected route")

	main.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
	}
	var first_rng := RandomNumberGenerator.new()
	first_rng.seed = 2026
	main._place_lantern_ray_route_for_run(first_rng)
	var first_route_id: String = main.current_lantern_ray_route_id
	var first_start: Vector2 = lantern_ray.global_position
	var second_rng := RandomNumberGenerator.new()
	second_rng.seed = 2026
	main._place_lantern_ray_route_for_run(second_rng)
	_expect(main.current_lantern_ray_route_id == first_route_id, "same seed and condition should select the same Lantern Ray route")
	_expect(lantern_ray.global_position == first_start, "same seed and condition should place the Lantern Ray at the same start")

	var telemetry: String = main._format_run_telemetry("Extracted")
	_expect(telemetry.contains("Lantern Ray route:"), "debug run telemetry should expose the runtime Lantern Ray route id")
	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("current_lantern_ray_route_id"), "Lantern Ray route variation should not save active-run route state")
	_expect(not saved.has("lantern_ray_route"), "Lantern Ray route variation should not add durable route state")
	main.queue_free()

func _test_debug_review_helpers() -> void:
	var main := MainScript.new()
	var next_condition := main._debug_next_condition_from_id("calm_current")
	_expect(next_condition.get("id", "") == "kelp_bloom", "debug condition helper should cycle from the current condition")

	var first_condition := main._debug_next_condition_from_id("unknown_condition")
	_expect(first_condition.get("id", "") == "calm_current", "debug condition helper should fall back to the first condition")
	_expect(main._debug_seed_for_delta(8919, 1) == 8920, "debug seed helper should increment review seed")
	_expect(main._debug_seed_for_delta(1, -10) == 1, "debug seed helper should keep review seed positive")
	main.free()

func _test_debug_wreck_echo_visual_staging() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.reset(main.max_oxygen)

	main.show_debug_telemetry = false
	main.call("_stage_debug_wide_chamber_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef Chamber web staging should be inaccessible outside the web debug bridge")
	_expect(main.visual_smoke_route_stage == "", "Wide Reef Chamber web staging should not set route state outside web visual smoke")

	main.call("_stage_debug_wreck_echo_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wreck Echo visual staging should be ignored while debug telemetry is hidden")

	main.show_debug_telemetry = true
	main.call("_stage_debug_wreck_echo_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Wreck Echo visual staging should start or keep a dive active")
	_expect(main.debug_wreck_echo_review_staged, "Wreck Echo visual staging should remember the active route view state")
	_expect(main._wreck_echo_route_available(), "Wreck Echo visual staging should prepare the route prerequisites")
	_expect(not main.run_wreck_echo_clue_recovered, "first Wreck Echo visual staging press should not auto-complete the clue")

	main.call("_stage_debug_wreck_echo_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "second Wreck Echo visual staging press should produce the result view")
	_expect(main.last_result_summary.contains("Wreck Echo clue carried"), "staged Wreck Echo result should include the compact clue readback")
	main.queue_free()

func _test_debug_wide_reef_salvage_staging_guardrails() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	main.call("_stage_debug_wide_chamber_visual_review", true)
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef salvage staging should be inaccessible outside web/debug review")
	_expect(main.visual_smoke_route_stage == "", "hidden Wide Reef salvage staging should not set visual route state")
	_expect(main.progression_state.to_save_data() == save_before, "hidden Wide Reef salvage staging should not mutate durable progression")

	main.show_debug_telemetry = true
	main.call("_stage_debug_wide_chamber_visual_review", true)
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef salvage staging should remain web-only even when debug telemetry is visible headlessly")
	_expect(main.visual_smoke_route_stage == "", "headless Wide Reef salvage staging should not set visual route state")
	_expect(main.progression_state.to_save_data() == save_before, "headless Wide Reef salvage staging should not mutate durable progression")

	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	main.call("_sync_salvage_pocket_open_state")
	var opened_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	var lock_bars := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/LockBars") as Polygon2D
	var manifest_core := opened_lane.get_node("SalvageManifest/ManifestCore") as Polygon2D
	_expect(opened_lane.visible, "owned Salvage Cutter I should reveal the opened pocket lane")
	_expect(not lock_bars.visible, "owned Salvage Cutter I should remove sealed lock bars")
	_expect(manifest_core.color.a >= 0.7, "owned Salvage Cutter I should leave the manifest visibly recoverable")
	_expect(not main.run_salvage_manifest_recovered, "opened pocket should not auto-complete the manifest payoff")
	_expect(not main.run_salvage_data_cache_recovered, "opened pocket should not auto-complete the earlier cache payoff")
	_expect(main._format_recent_route_memory() != "Salvage Pocket", "opened pocket alone should not claim Salvage Pocket route memory")
	var staged_save: Dictionary = main.progression_state.to_save_data()
	_expect(not staged_save.has("salvage_pocket_route"), "opened pocket should not create durable salvage route state")
	_expect(not staged_save.has("salvage_manifest"), "opened pocket should not create durable manifest state")
	_expect(not staged_save.has("salvage_inventory"), "opened pocket should not create salvage inventory state")

	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_manifest = true
	var handled: bool = main.call("_try_salvage_manifest_interaction")
	_expect(handled, "staged Wide Reef salvage payoff should remain interactable through the normal manifest path")
	_expect(main.run_salvage_manifest_recovered, "staged manifest interaction should set only run-scoped payoff evidence")
	_expect(main._format_recent_route_memory() == "Salvage Pocket", "manifest payoff should upgrade the current run memory to Salvage Pocket")
	var empty_cargo: Array[String] = []
	var summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(summary.contains("Salvage Manifest"), "staged manifest payoff should support extraction result memory")
	main.progression_state.current_run_number = 42
	main.progression_state.current_run_seed = 9042
	main.call("_record_recent_expedition", "Extracted", 0)
	var log_text: String = main.call("_format_recent_expedition_log")
	_expect(log_text.contains("route Salvage Pocket"), "staged manifest payoff should support compact recent-route memory")
	var payoff_save: Dictionary = main.progression_state.to_save_data()
	_expect(not payoff_save.has("salvage_pocket_route"), "Salvage Pocket route memory should remain session-only after payoff")
	_expect(not payoff_save.has("salvage_inventory"), "Salvage Manifest payoff should not create durable salvage inventory")

	main.call("_reset_run_telemetry")
	_expect(not main.run_salvage_manifest_recovered, "Salvage Manifest payoff should reset between expeditions")
	_expect(opened_lane.visible, "owned cutter should keep the opened lane visible after run reset")
	_expect(manifest_core.color.a >= 0.7, "Salvage Manifest should become recoverable again after run reset")
	_expect(main._format_recent_route_memory() != "Salvage Pocket", "run reset should clear active Salvage Pocket route memory")
	main.queue_free()

func _test_debug_mirror_kelp_evidence_staging() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	main.call("_stage_debug_mirror_kelp_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Mirror Kelp staging should be ignored while debug telemetry is hidden outside web visual smoke")
	_expect(main.visual_smoke_route_stage == "", "hidden Mirror Kelp staging should not set visual route state")
	_expect(main.progression_state.to_save_data() == save_before, "hidden Mirror Kelp staging should not mutate durable progression")

	main.show_debug_telemetry = true
	main.call("_stage_debug_mirror_kelp_visual_review")
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Mirror Kelp staging should start or keep a dive active")
	_expect(main.visual_smoke_route_stage == "mirror_kelp_pass", "Mirror Kelp route staging should expose a deterministic route stage")
	_expect(main.player.global_position.distance_to(mirror_kelp.global_position) < 180.0, "Mirror Kelp staging should place the player near the branch")
	_expect(main.dive_session.has_left_base, "Mirror Kelp staging should make extraction eligibility match an active route attempt")
	_expect(not main.run_tideglass_sample_recovered, "plain Mirror Kelp staging should not auto-complete the payoff")
	_expect(not main.run_completed_scans.has("mirrorfin_drift"), "plain Mirror Kelp staging should not auto-add Mirrorfin evidence")
	_expect(main.progression_state.to_save_data() == save_before, "plain Mirror Kelp staging should not mutate durable progression")

	main.call("_stage_debug_mirror_kelp_visual_review", true)
	_expect(main.visual_smoke_route_stage == "mirror_kelp_tideglass", "Tideglass staging should expose a deterministic payoff stage")
	_expect(main.run_tideglass_sample_recovered, "Tideglass staging should set only the run-scoped payoff evidence")
	_expect(main._format_route_choice_callout().contains("Mirror Kelp Pass"), "Tideglass staging should support Mirror Kelp result memory")
	_expect(main._format_recent_route_memory() == "Mirror Kelp Pass", "Tideglass staging should support recent route memory")
	_expect(main.progression_state.to_save_data() == save_before, "Tideglass staging should not mutate durable progression")

	main.call("_stage_debug_mirror_kelp_visual_review", false, true)
	_expect(main.visual_smoke_route_stage == "mirror_kelp_mirrorfin", "Mirrorfin staging should expose a deterministic observation stage")
	_expect(not main.run_tideglass_sample_recovered, "Mirrorfin staging should reset Tideglass payoff state for deterministic captures")
	_expect(main.run_completed_scans.has("mirrorfin_drift"), "Mirrorfin staging should set only current-run observation evidence")
	_expect(main._format_route_choice_callout().contains("reflection timing"), "Mirrorfin staging should support observation result memory")
	_expect(main._format_recent_route_memory() == "Mirror Kelp Pass", "Mirrorfin staging should support recent route memory")
	_expect(main.progression_state.to_save_data() == save_before, "Mirrorfin staging should not mutate durable progression")
	_expect(not main.progression_state.to_save_data().has("mirror_kelp_pass_route"), "Mirror Kelp staging should not add durable route state")
	main.queue_free()

func _test_debug_outer_shelf_evidence_staging() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	main.call("_stage_debug_outer_shelf_visual_review")
	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Outer Shelf staging should be ignored while debug telemetry is hidden outside web visual smoke")
	_expect(main.visual_smoke_route_stage == "", "hidden Outer Shelf staging should not set visual route state")
	_expect(main.progression_state.to_save_data() == save_before, "hidden Outer Shelf staging should not mutate durable progression")

	main.show_debug_telemetry = true
	main.call("_stage_debug_outer_shelf_visual_review")
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var survey_zone := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/InteractZone") as Area2D
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Outer Shelf staging should start or keep a dive active")
	_expect(main.visual_smoke_route_stage == "outer_shelf_survey", "Outer Shelf staging should expose a deterministic route stage")
	_expect(blackwater_sill.visible, "Outer Shelf staging should reveal the hidden route ancestor for visual review only")
	_expect(main.player.global_position.distance_to(survey_zone.global_position) < 120.0, "Outer Shelf staging should place the player near the survey payoff")
	_expect(main.dive_session.has_left_base, "Outer Shelf staging should make extraction eligibility match an active route attempt")
	_expect(main.player_near_outer_shelf_survey, "Outer Shelf staging should expose the survey prompt for readability review")
	_expect(not main.run_outer_shelf_survey_recovered, "Outer Shelf staging should not auto-complete the survey payoff")
	_expect(not main.run_tideglass_sample_recovered, "Outer Shelf staging should not inherit Mirror Kelp payoff state")
	_expect(not main.run_salvage_manifest_recovered, "Outer Shelf staging should not inherit salvage payoff state")
	_expect(not main.run_completed_scans.has("mirrorfin_drift"), "Outer Shelf staging should not auto-add Mirrorfin evidence")
	_expect(main.progression_state.to_save_data() == save_before, "Outer Shelf staging should not mutate durable progression")
	_expect(not main.progression_state.to_save_data().has("outer_shelf_survey"), "Outer Shelf staging should not add durable survey state")
	main.queue_free()

func _test_scanner_target_resolver() -> void:
	var farther_a := _make_scan_target("alpha", "Alpha", Vector2(10.0, 0.0))
	var farther_b := _make_scan_target("beta", "Beta", Vector2(10.0, 0.0))
	var nearest := _make_scan_target("gamma", "Gamma", Vector2(3.0, 0.0))
	var targets: Array[Node] = [farther_b, nearest, farther_a]

	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	_expect(selected == nearest, "scanner resolver should choose the nearest target")
	_expect(ScanTargetResolverScript.target_id(selected) == "gamma", "scanner resolver should expose target discovery id")
	_expect(ScanTargetResolverScript.display_name(selected) == "Gamma", "scanner resolver should expose target display name")

	targets = [farther_b, farther_a]
	selected = ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	_expect(selected == farther_a, "scanner resolver should break equal-distance ties by id")
	_expect(ScanTargetResolverScript.nearest(Vector2.ZERO, 2.0, targets) == null, "scanner resolver should ignore targets outside range")
	farther_a.free()
	farther_b.free()
	nearest.free()

func _test_scan_hold_timing_helper() -> void:
	var main := MainScript.new()
	var target := _make_scan_target("thermal_vent", "Thermal Vent", Vector2.ZERO)
	main.scan_hold_seconds = 1.0
	main.scan_charge_elapsed = 0.35

	_expect(is_equal_approx(main.call("_scan_charge_ratio"), 0.35), "scan hold ratio should report partial progress")
	_expect(String(main.call("_format_scan_charge_status", target)).contains("Thermal Vent: 35%"), "scan hold status should show target name and progress")
	_expect(ScanFeedbackPresenterScript.format_scan_charge_status("Thermal Vent", 0.35) == "Scanning Thermal Vent: 35%", "scan feedback presenter should format charge status")
	_expect(ScanFeedbackPresenterScript.format_wreck_cache_repeat_hint(true, true).contains("Echo Lens"), "scan feedback presenter should prioritize Echo Lens cache hints")
	_expect(ScanFeedbackPresenterScript.format_signal_lens_pulse_text(true, true, false, "", "Kelp Fiber").contains("quiet"), "scan feedback presenter should preserve quiet Signal Lens copy")
	_expect(ScanFeedbackPresenterScript.format_direction_to(Vector2.ZERO, Vector2(96.0, 96.0)) == "deeper-right", "scan feedback presenter should format directional hints")
	_expect(ScanFeedbackPresenterScript.format_first_scan_guidance("pressure_wreck_signal", false, "", 0, 3, false).contains("Locked: buy Pressure Seal I"), "scan feedback presenter should preserve pressure-locked guidance")
	_expect(ScanFeedbackPresenterScript.format_scan_target_type("lantern_ray", false) == "creature", "scan feedback presenter should classify creature scan targets")
	main.scan_charge_elapsed = 1.5
	_expect(is_equal_approx(main.call("_scan_charge_ratio"), 1.0), "scan hold ratio should clamp completed progress")
	main.scan_hold_seconds = 0.0
	_expect(is_equal_approx(main.call("_scan_charge_ratio"), 1.0), "scan hold ratio should treat zero-duration scans as complete")

	target.free()
	main.free()

func _test_compact_scan_marker() -> void:
	var scannable := ScannableScript.new()
	var marker := Polygon2D.new()
	marker.name = "ScanMarker"
	scannable.add_child(marker)
	scannable._ready()

	_expect(marker.polygon.size() == 8, "compact scan marker should use the standard diamond polygon")
	_expect(marker.polygon == ReadabilityMarkerPatternsScript.scan_marker_polygon(), "compact scan marker should use shared marker pattern data")
	_expect(marker.color.a < 0.3, "compact scan marker should be subtle while idle")
	_expect(scannable.get_node_or_null("ScanFocusBracketA") != null, "compact scan marker should create first focus bracket")
	_expect(scannable.get_node_or_null("ScanFocusBracketB") != null, "compact scan marker should create second focus bracket")

	scannable.set_scan_selected(true)
	_expect(marker.color.a > 0.5, "selected compact scan marker should brighten")
	scannable.free()

func _test_lantern_ray_scan_behavior() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var lantern_ray := main.get_node("Creatures/LanternRayRoute") as Area2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	lantern_ray.call("_ready")
	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = lantern_ray.global_position

	_expect(lantern_ray.is_in_group("scan_targets"), "Lantern Ray should register as a scan target once the scene is ready")
	var scan_candidates: Array[Node] = [lantern_ray]
	_expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == lantern_ray, "scanner target selection should find Lantern Ray reliably at close range")
	_expect(main.call("_format_scan_target_type", lantern_ray) == "creature", "Lantern Ray scan target should read as a creature")
	_expect(main.call("_scan_target_id", lantern_ray) == "lantern_ray", "Lantern Ray should expose a stable discovery id")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = main.call("_scan_target_id", lantern_ray)
	var display_name: String = main.call("_scan_target_display_name", lantern_ray)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		main.call("_scan_target_description", lantern_ray),
		main.call("_scan_target_gameplay_fact", lantern_ray)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", lantern_ray) + main.call("_format_first_scan_guidance", lantern_ray)
	])
	var first_scan_guidance: String = main.call("_format_first_scan_guidance", lantern_ray)
	_expect(main.progression_state.has_discovery("lantern_ray"), "first Lantern Ray scan should record a durable discovery")
	_expect(main.run_completed_scans == ["lantern_ray"], "first Lantern Ray scan should count as current-run scan evidence")
	_expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Lantern Ray scan should use the normal scan oxygen cost")
	_expect(first_scan_status.contains("Scanned Lantern Ray"), "first Lantern Ray scan status should name the creature")
	_expect(first_scan_guidance.contains("Observe its calm pass"), "first Lantern Ray scan guidance should stay route-observation focused")

	var no_cargo: Array[String] = []
	var summary: String = main.call("_format_extraction_result_summary", 0, no_cargo)
	_expect(summary.contains("Lantern Ray"), "Lantern Ray scan should appear in scan/discovery result copy")
	_expect_no_monster_combat_language(summary, "Lantern Ray scan result copy")
	_expect(not summary.to_lower().contains("field guide"), "Lantern Ray scan result should not imply field-guide UI")
	_expect(not summary.to_lower().contains("checklist"), "Lantern Ray scan result should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", lantern_ray) + main.call("_format_signal_lens_pulse_text", lantern_ray)
	])
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Lantern Ray scan should stay free like existing known scans")
	_expect(main.run_completed_scans == ["lantern_ray"], "repeat Lantern Ray scan should not duplicate current-run scan evidence")
	_expect(repeat_scan_status.contains("Lantern Ray known"), "repeat Lantern Ray scan should use compact known-target copy")
	_expect(repeat_scan_status.contains("observation refreshed"), "repeat Lantern Ray scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved.get("scan_discoveries", {}).has("lantern_ray"), "Lantern Ray discovery should persist through normal scan discovery storage")
	_expect(not saved.has("lantern_ray_objective"), "Lantern Ray scan should not create durable objective-chain state")
	_expect(not saved.has("monster_parts"), "Lantern Ray scan should not add monster-part economy state")
	_expect(not saved.has("creature_inventory"), "Lantern Ray scan should not add creature inventory state")
	main.queue_free()

func _test_hollow_reef_passive_creature_scan_behavior() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var skitter := main.get_node("Creatures/HollowReefSkitter") as Area2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var hollow_reef := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var skitter_body := main.get_node("Creatures/HollowReefSkitter/SkitterBody") as Polygon2D
	main.player = scene_player
	skitter.call("_ready")
	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = skitter.global_position

	_expect(skitter.is_in_group("scan_targets"), "Hollow Reef Skitter should register as a scan target once the scene is ready")
	var scan_candidates: Array[Node] = [skitter]
	_expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == skitter, "scanner target selection should find Hollow Reef Skitter reliably at close range")
	_expect(main.call("_format_scan_target_type", skitter) == "creature", "Hollow Reef Skitter scan target should read as a creature")
	_expect(main.call("_scan_target_id", skitter) == "hollow_reef_skitter", "Hollow Reef Skitter should expose a stable discovery id")
	_expect(skitter.global_position.distance_to(hollow_reef.global_position) < 520.0, "Hollow Reef Skitter should live inside the Hollow Reef side-cave neighborhood")
	_expect(skitter_body.color.g > skitter_body.color.r and skitter_body.color.b > skitter_body.color.r, "Hollow Reef Skitter should use cool passive reef colors instead of red warning language")
	_expect(skitter_body.polygon[3].x < lantern_ray_body.polygon[3].x, "Hollow Reef Skitter should read smaller and distinct from the broad Lantern Ray")
	_expect(skitter.collision_layer == 0 and skitter.collision_mask == 0, "Hollow Reef Skitter should not create contact collision")
	_expect(skitter.find_child("HarvestArea", true, false) == null, "Hollow Reef Skitter should not add harvesting behavior")
	_expect(skitter.find_child("HealthBar", true, false) == null, "Hollow Reef Skitter should not add combat health UI")
	_expect(skitter.find_child("Predator", true, false) == null, "Hollow Reef Skitter should not reuse predator behavior")

	var save_before_scan: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = main.call("_scan_target_id", skitter)
	var display_name: String = main.call("_scan_target_display_name", skitter)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		main.call("_scan_target_description", skitter),
		main.call("_scan_target_gameplay_fact", skitter)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", skitter) + main.call("_format_first_scan_guidance", skitter)
	])
	var first_scan_guidance: String = main.call("_format_first_scan_guidance", skitter)
	_expect(main.progression_state.has_discovery("hollow_reef_skitter"), "first Hollow Reef Skitter scan should record a normal durable discovery")
	_expect(main.run_completed_scans == ["hollow_reef_skitter"], "first Hollow Reef Skitter scan should count as current-run scan evidence")
	_expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Hollow Reef Skitter scan should use the normal scan oxygen cost")
	_expect(first_scan_status.contains("Scanned Hollow Reef Skitter"), "first Hollow Reef Skitter scan status should name the creature")
	_expect(first_scan_guidance.contains("Observe the upper shelf timing"), "first Hollow Reef Skitter scan guidance should teach a compact behavior clue")
	_expect_no_monster_combat_language(first_scan_status, "Hollow Reef Skitter first scan status")
	_expect(not first_scan_status.to_lower().contains("field guide"), "Hollow Reef Skitter first scan should not imply field-guide UI")
	_expect(not first_scan_status.to_lower().contains("checklist"), "Hollow Reef Skitter first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", skitter) + main.call("_format_signal_lens_pulse_text", skitter)
	])
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Hollow Reef Skitter scan should stay free like existing known scans")
	_expect(main.run_completed_scans == ["hollow_reef_skitter"], "repeat Hollow Reef Skitter scan should not duplicate current-run scan evidence")
	_expect(repeat_scan_status.contains("Hollow Reef Skitter known"), "repeat Hollow Reef Skitter scan should use compact known-target copy")
	_expect(repeat_scan_status.contains("observation refreshed"), "repeat Hollow Reef Skitter scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved.get("scan_discoveries", {}).has("hollow_reef_skitter"), "Hollow Reef Skitter discovery should persist through normal scan discovery storage")
	_expect(saved.get("banked_resources", {}) == save_before_scan.get("banked_resources", {}), "Hollow Reef Skitter scan should not mutate resources")
	_expect(saved.get("purchased_upgrades", {}) == save_before_scan.get("purchased_upgrades", {}), "Hollow Reef Skitter scan should not mutate upgrades")
	_expect(is_equal_approx(float(saved.get("best_depth_reached", 0.0)), float(save_before_scan.get("best_depth_reached", 0.0))), "Hollow Reef Skitter scan should not mutate best-depth state")
	_expect(not saved.has("hollow_reef_skitter_objective"), "Hollow Reef Skitter scan should not create durable objective-chain state")
	_expect(not saved.has("monster_parts"), "Hollow Reef Skitter scan should not add monster-part economy state")
	_expect(not saved.has("creature_inventory"), "Hollow Reef Skitter scan should not add creature inventory state")
	main.queue_free()

func _test_glassfin_swarm_scan_behavior() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var swarm := chamber.get_node("GlassfinSwarm") as Area2D
	var lane := swarm.get_node("SwarmRouteLane") as Polygon2D
	var body_a_outline := swarm.get_node("SwarmBodyAOutline") as Polygon2D
	var body_b_outline := swarm.get_node("SwarmBodyBOutline") as Polygon2D
	var body_c_outline := swarm.get_node("SwarmBodyCOutline") as Polygon2D
	var body_a := swarm.get_node("SwarmBodyA") as Polygon2D
	var body_b := swarm.get_node("SwarmBodyB") as Polygon2D
	var spacing_wake := swarm.get_node("SpacingWake") as Polygon2D
	var return_gap := swarm.get_node("ReturnGapCue") as Polygon2D
	var scan_marker := swarm.get_node("ScanMarker") as Polygon2D
	var return_current := chamber.get_node("ReturnCurrentBackToHollow") as Polygon2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var predator_warning := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var resource_glimmer := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()
	main.player = scene_player
	swarm.call("_ready")

	_expect(swarm.get_parent() == chamber, "Glassfin Swarm should be authored inside the wide chamber route space")
	_expect(swarm.position.x > 200.0 and swarm.position.x < 480.0, "Glassfin Swarm should sit in the chamber's mid/far open-water lane")
	_expect(swarm.position.y < return_current.polygon[0].y, "Glassfin Swarm should leave the lower return-current route readable")
	_expect(lane.color.b > lane.color.g and lane.color.g > lane.color.r, "Glassfin Swarm lane should use glassy blue timing language")
	_expect(body_a.color.b > body_a.color.g and body_a.color.g > body_a.color.r, "Glassfin Swarm body should avoid red predator and yellow resource language")
	_expect(body_a.color.a >= 0.78 and body_b.color.a >= 0.74, "Glassfin Swarm bodies should stay visible at normal play scale instead of becoming label-only targets")
	_expect(body_a_outline.color.a >= 0.68 and body_b_outline.color.a >= 0.68 and body_c_outline.color.a >= 0.64, "Glassfin Swarm should keep dark body outlines so the pale fish separate from chamber water")
	_expect(body_a_outline.color.b < body_a.color.b and body_a_outline.color.g < body_a.color.g, "Glassfin Swarm outline should frame the fish without reading as another bright timing cue")
	_expect(body_a.color.b > lantern_ray_body.color.b and body_a.color.r > lantern_ray_body.color.r, "Glassfin Swarm should read brighter and more glasslike than Lantern Ray")
	_expect(body_b.color.b > resource_glimmer.color.b, "Glassfin Swarm should stay distinct from yellow-green resource glimmers")
	_expect(body_a.color.r < predator_warning.color.r, "Glassfin Swarm should not reuse predator-warning red")
	_expect(return_gap.color.g > body_a.color.g and return_gap.color.a < return_current.color.a, "Glassfin Swarm return gap should remain softer than the main safe-return current")
	_expect(spacing_wake.color.a <= 0.18, "Glassfin Swarm spacing wake should be a subtle observation cue")
	_expect(swarm.is_in_group("scan_targets"), "Glassfin Swarm should register as a scan target once the scene is ready")
	_expect(scan_marker.color.a < 0.3, "Glassfin Swarm scan marker should stay subtle while idle")
	_expect(main.call("_format_scan_target_type", swarm) == "creature", "Glassfin Swarm scan target should read as a creature")
	_expect(main.call("_scan_target_id", swarm) == "glassfin_swarm", "Glassfin Swarm should expose a stable discovery id")
	_expect(swarm.find_child("CollisionShape2D", true, false) == null, "Glassfin Swarm should not add collision or physically block return")
	_expect(swarm.find_child("ResourcePickup", true, false) == null, "Glassfin Swarm should not add resource pickup behavior")
	_expect(swarm.find_child("HarvestArea", true, false) == null, "Glassfin Swarm should not add harvesting behavior")
	_expect(swarm.find_child("HealthBar", true, false) == null, "Glassfin Swarm should not add combat health UI")
	_expect(swarm.find_child("Predator", true, false) == null, "Glassfin Swarm should not reuse predator behavior")
	_expect(main.progression_state.to_save_data() == save_before, "Glassfin Swarm passive obstacle should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Glassfin Swarm passive obstacle should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "Glassfin Swarm passive obstacle should not mutate cargo")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = swarm.global_position
	var scan_candidates: Array[Node] = [swarm]
	_expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == swarm, "scanner target selection should find Glassfin Swarm reliably at close range")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = main.call("_scan_target_id", swarm)
	var display_name: String = main.call("_scan_target_display_name", swarm)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		main.call("_scan_target_description", swarm),
		main.call("_scan_target_gameplay_fact", swarm)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", swarm) + main.call("_format_first_scan_guidance", swarm)
	])
	var first_scan_guidance: String = main.call("_format_first_scan_guidance", swarm)
	_expect(main.progression_state.has_discovery("glassfin_swarm"), "first Glassfin Swarm scan should record a normal durable discovery")
	_expect(main.run_completed_scans == ["glassfin_swarm"], "first Glassfin Swarm scan should count as current-run scan evidence")
	_expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Glassfin Swarm scan should use the normal scan oxygen cost")
	_expect(first_scan_status.contains("Scanned Glassfin Swarm"), "first Glassfin Swarm scan status should name the creature")
	_expect(first_scan_guidance.contains("spacing lane"), "first Glassfin Swarm scan guidance should teach spacing")
	_expect(first_scan_guidance.contains("pass around"), "first Glassfin Swarm scan guidance should teach avoidance instead of fighting")
	_expect_no_monster_combat_language(first_scan_status, "Glassfin Swarm first scan status")
	_expect(not first_scan_status.to_lower().contains("field guide"), "Glassfin Swarm first scan should not imply field-guide UI")
	_expect(not first_scan_status.to_lower().contains("checklist"), "Glassfin Swarm first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", swarm) + main.call("_format_signal_lens_pulse_text", swarm)
	])
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Glassfin Swarm scan should stay free like existing known scans")
	_expect(main.run_completed_scans == ["glassfin_swarm"], "repeat Glassfin Swarm scan should not duplicate current-run scan evidence")
	_expect(repeat_scan_status.contains("Glassfin Swarm known"), "repeat Glassfin Swarm scan should use compact known-target copy")
	_expect(repeat_scan_status.contains("observation refreshed"), "repeat Glassfin Swarm scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved.get("scan_discoveries", {}).has("glassfin_swarm"), "Glassfin Swarm discovery should persist through normal scan discovery storage")
	_expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Glassfin Swarm scan should not mutate resources")
	_expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Glassfin Swarm scan should not mutate upgrades")
	_expect(is_equal_approx(float(saved.get("best_depth_reached", 0.0)), float(save_before.get("best_depth_reached", 0.0))), "Glassfin Swarm scan should not mutate best-depth state")
	_expect(not saved.has("glassfin_swarm_objective"), "Glassfin Swarm scan should not create durable objective-chain state")
	_expect(not saved.has("monster_parts"), "Glassfin Swarm scan should not add monster-part economy state")
	_expect(not saved.has("creature_inventory"), "Glassfin Swarm scan should not add creature inventory state")
	main.queue_free()

func _test_mirrorfin_route_read_behavior() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var mirrorfin := mirror_kelp.get_node("MirrorfinDrift") as Area2D
	var reflection_lane := mirrorfin.get_node("ReflectionLane") as Polygon2D
	var body := mirrorfin.get_node("MirrorfinBody") as Polygon2D
	var safe_break := mirrorfin.get_node("SafeBreakCue") as Polygon2D
	var scan_marker := mirrorfin.get_node("ScanMarker") as Polygon2D
	var tideglass_core := mirror_kelp.get_node("TideglassSample/SampleCore") as Polygon2D
	var predator_warning := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()
	main.player = scene_player
	mirrorfin.call("_ready")

	_expect(mirrorfin.get_parent() == mirror_kelp, "Mirrorfin should be authored inside Mirror Kelp Pass")
	_expect(mirrorfin.is_in_group("scan_targets"), "Mirrorfin should register as a scan target once the scene is ready")
	_expect(main.call("_format_scan_target_type", mirrorfin) == "creature", "Mirrorfin scan target should read as a creature")
	_expect(main.call("_scan_target_id", mirrorfin) == "mirrorfin_drift", "Mirrorfin should expose a stable discovery id")
	_expect(mirrorfin.collision_layer == 0 and mirrorfin.collision_mask == 0, "Mirrorfin should not collide, damage, or block the route")
	_expect(reflection_lane.color.b > reflection_lane.color.r and reflection_lane.color.a <= 0.16, "Mirrorfin reflection lane should use subtle cool timing language")
	_expect(body.color.b > body.color.r and body.color.g > body.color.r, "Mirrorfin body should avoid predator-warning red")
	_expect(body.color.b >= tideglass_core.color.b, "Mirrorfin should share branch reflection language without looking like cargo")
	_expect(body.color.r < predator_warning.color.r, "Mirrorfin should stay visually distinct from predator warnings")
	_expect(safe_break.color.g > safe_break.color.r and safe_break.color.a < 0.18, "Mirrorfin safe-break cue should be a subtle route read")
	_expect(scan_marker.color.a < 0.3, "Mirrorfin scan marker should stay subtle while idle")
	_expect(mirrorfin.find_child("CollisionShape2D", true, false) == null, "Mirrorfin should not add collision geometry")
	_expect(mirrorfin.find_child("HarvestArea", true, false) == null, "Mirrorfin should not add harvesting behavior")
	_expect(mirrorfin.find_child("HealthBar", true, false) == null, "Mirrorfin should not add combat health UI")
	_expect(mirrorfin.find_child("Predator", true, false) == null, "Mirrorfin should not reuse predator behavior")
	_expect(main.progression_state.to_save_data() == save_before, "Mirrorfin passive route read should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Mirrorfin passive route read should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "Mirrorfin passive route read should not mutate cargo")

	var start_position := mirrorfin.global_position
	var end_position: Vector2 = mirrorfin.get("move_end")
	mirrorfin.call("_physics_process", 1.0)
	_expect(mirrorfin.global_position != start_position, "Mirrorfin should drift instead of reading as static scenery")
	_expect(mirrorfin.global_position.distance_to(end_position) < start_position.distance_to(end_position), "Mirrorfin drift should move toward the reflection break")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = mirrorfin.global_position
	var scan_candidates: Array[Node] = [mirrorfin]
	_expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == mirrorfin, "scanner target selection should find Mirrorfin reliably at close range")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = main.call("_scan_target_id", mirrorfin)
	var display_name: String = main.call("_scan_target_display_name", mirrorfin)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		main.call("_scan_target_description", mirrorfin),
		main.call("_scan_target_gameplay_fact", mirrorfin)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", mirrorfin) + main.call("_format_first_scan_guidance", mirrorfin)
	])
	var first_scan_guidance: String = main.call("_format_first_scan_guidance", mirrorfin)
	_expect(main.progression_state.has_discovery("mirrorfin_drift"), "first Mirrorfin scan should record a normal durable discovery")
	_expect(main.run_completed_scans == ["mirrorfin_drift"], "first Mirrorfin scan should count as current-run scan evidence")
	_expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Mirrorfin scan should use the normal scan oxygen cost")
	_expect(first_scan_status.contains("Scanned Mirrorfin Drift"), "first Mirrorfin scan status should name the creature")
	_expect(first_scan_guidance.contains("reflection break"), "first Mirrorfin scan guidance should teach the route read")
	_expect(first_scan_guidance.contains("after the shimmer"), "first Mirrorfin scan guidance should teach timing instead of fighting")
	_expect_no_monster_combat_language(first_scan_status, "Mirrorfin first scan status")
	_expect(not first_scan_status.to_lower().contains("field guide"), "Mirrorfin first scan should not imply field-guide UI")
	_expect(not first_scan_status.to_lower().contains("checklist"), "Mirrorfin first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", mirrorfin) + main.call("_format_signal_lens_pulse_text", mirrorfin)
	])
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Mirrorfin scan should stay free like existing known scans")
	_expect(main.run_completed_scans == ["mirrorfin_drift"], "repeat Mirrorfin scan should not duplicate current-run scan evidence")
	_expect(repeat_scan_status.contains("Mirrorfin Drift known"), "repeat Mirrorfin scan should use compact known-target copy")
	_expect(repeat_scan_status.contains("observation refreshed"), "repeat Mirrorfin scan should refresh behavior text compactly")
	_expect(main._format_discovery_memory_callout().contains("Mirrorfin Drift"), "Mirrorfin first scan should produce compact discovery memory")
	_expect(main._format_discovery_memory_callout().contains("without fighting"), "Mirrorfin discovery memory should frame observation as non-combat")
	_expect(main._format_route_choice_callout().contains("Mirror Kelp"), "Mirrorfin scan should now support compact Mirror Kelp route memory")
	_expect(main._format_route_choice_callout().contains("reflection timing"), "Mirrorfin route memory should explain what the observation taught")
	main.run_reached_dusk_trench = true
	_expect(main._format_route_choice_callout().contains("Mirror Kelp"), "Mirrorfin branch evidence should stay more specific than upstream route reach memory")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved.get("scan_discoveries", {}).has("mirrorfin_drift"), "Mirrorfin discovery should persist through normal scan discovery storage")
	_expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Mirrorfin scan should not mutate resources")
	_expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Mirrorfin scan should not mutate upgrades")
	_expect(not saved.has("mirrorfin_objective"), "Mirrorfin scan should not create durable objective-chain state")
	_expect(not saved.has("monster_parts"), "Mirrorfin scan should not add monster-part economy state")
	_expect(not saved.has("creature_inventory"), "Mirrorfin scan should not add creature inventory state")
	main.queue_free()

func _test_mirror_kelp_deep_promise() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var promise := mirror_kelp.get_node("DeepKelpSealPromise") as Node2D
	var seal_mouth := promise.get_node("SealMouth") as Polygon2D
	var pressure_veil := promise.get_node("PressureVeil") as Polygon2D
	var kelp_bars := promise.get_node("KelpSealBars") as Polygon2D
	var future_glint := promise.get_node("FutureGlint") as Polygon2D
	var promise_label := promise.get_node("PromiseLabel") as Label
	var tideglass := mirror_kelp.get_node("TideglassSample") as Node2D
	var tideglass_core := mirror_kelp.get_node("TideglassSample/SampleCore") as Polygon2D
	var mirrorfin := mirror_kelp.get_node("MirrorfinDrift") as Area2D
	var return_label := mirror_kelp.get_node("ReturnLabel") as Label
	var landmark := main.get_node("LandmarkMetadata/MirrorKelpPass")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()

	_expect(promise.get_parent() == mirror_kelp, "deep kelp promise should be authored inside Mirror Kelp Pass")
	_expect(promise.position.x > tideglass.position.x, "deep kelp promise should sit beyond the Tideglass payoff")
	_expect(promise.position.x > mirrorfin.position.x, "deep kelp promise should sit beyond the Mirrorfin route-read lane")
	_expect(promise.position.y > tideglass.position.y, "deep kelp promise should point toward deeper branch growth")
	_expect(return_label.text.contains("WIDE REEF"), "Mirror Kelp return label should stay readable beside the future promise")
	_expect(seal_mouth.color.a >= 0.6, "deep kelp promise should read as a closed route mouth")
	_expect(pressure_veil.color.b > pressure_veil.color.r and pressure_veil.color.a <= 0.2, "deep kelp pressure veil should stay subtle and cool")
	_expect(kelp_bars.color.g > kelp_bars.color.r and kelp_bars.color.a <= 0.28, "deep kelp seal bars should use quiet route language instead of resource glow")
	_expect(future_glint.color.a <= 0.32 and future_glint.color.a < tideglass_core.color.a, "deep kelp promise glint should stay a future hint, not a collectible")
	_expect(tideglass_core.color.b >= tideglass_core.color.r and tideglass_core.color.a >= 0.8, "Tideglass should stay brighter than sealed-route promise language")
	_expect(promise_label.text == "KELP SEALED", "deep kelp promise label should be compact and honest")
	_expect(not promise_label.text.to_lower().contains("objective"), "deep kelp promise should not imply objective checklist language")
	_expect(not promise_label.text.to_lower().contains("map"), "deep kelp promise should not imply exact locator UI")
	_expect(not promise_label.text.to_lower().contains("open"), "deep kelp promise should not imply current access")
	_expect(promise.get_node_or_null("InteractZone") == null, "deep kelp promise should not add interaction yet")
	_expect(promise.find_child("CollisionShape2D", true, false) == null, "deep kelp promise should not add collision")
	_expect(promise.find_child("ResourcePickup", true, false) == null, "deep kelp promise should not add a pickup")
	_expect(promise.find_child("LootTable", true, false) == null, "deep kelp promise should not add loot tables")
	_expect(promise.find_child("HarvestArea", true, false) == null, "deep kelp promise should not add harvesting")
	_expect(promise.find_child("HealthBar", true, false) == null, "deep kelp promise should not add combat UI")
	_expect(promise.get_script() == null, "deep kelp promise should stay visual/readback only")
	var landmark_memory := "%s %s %s" % [
		String(landmark.get("display_name")),
		String(landmark.get("memory_goal")),
		String(landmark.get("persistent_facts")),
	]
	_expect(landmark_memory.contains("Mirror Kelp Pass"), "deep kelp promise should point back to the remembered Mirror Kelp place")
	_expect(landmark_memory.contains("closed deep-kelp route promise"), "Mirror Kelp metadata should record the promise as future route memory")
	_expect(not landmark_memory.to_lower().contains("coordinates"), "Mirror Kelp metadata should avoid exact locator framing")
	_expect(main.get_node_or_null("ResourcePickups/DeepKelp") == null, "deep kelp promise should not create a resource pickup")
	_expect(main.progression_state.to_save_data() == save_before, "deep kelp promise should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "deep kelp promise should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "deep kelp promise should not mutate cargo")
	main.queue_free()

func _test_outer_shelf_route_footprint() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var outer_shelf := mirror_kelp.get_node("OuterShelfReach") as Node2D
	var deep_backwater := outer_shelf.get_node("DeepBackwater") as Polygon2D
	var playable_lane := outer_shelf.get_node("PlayableWaterLane") as Polygon2D
	var mid_plate := outer_shelf.get_node("MidShelfBackPlate") as Polygon2D
	var upper_rim := outer_shelf.get_node("UpperRimSilhouette") as Polygon2D
	var lower_rim := outer_shelf.get_node("LowerRimSilhouette") as Polygon2D
	var glass_rim := outer_shelf.get_node("GlassRimLandmark") as Polygon2D
	var glass_steps := outer_shelf.get_node("GlassRimShelfSteps") as Polygon2D
	var low_shelf := outer_shelf.get_node("LowShelfLandmark") as Polygon2D
	var survey_perch := outer_shelf.get_node("SurveyPerchShadow") as Polygon2D
	var foreground_shelf := outer_shelf.get_node("OuterShelfForegroundShelf") as Polygon2D
	var return_wash := outer_shelf.get_node("ReturnWashToMirror") as Polygon2D
	var survey_core := outer_shelf.get_node("OuterShelfSurveyCore") as Node2D
	var survey_visual := survey_core.get_node("SurveyCore") as Polygon2D
	var outer_label := outer_shelf.get_node("OuterShelfLabel") as Label
	var glass_label := outer_shelf.get_node("GlassRimLabel") as Label
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()

	var min_x := INF
	var max_x := -INF
	for point in deep_backwater.polygon:
		min_x = minf(min_x, point.x)
		max_x = maxf(max_x, point.x)

	_expect(outer_shelf.get_parent() == mirror_kelp, "Outer Shelf should extend from the current Mirror Kelp edge")
	_expect(outer_shelf.position.x > 280.0, "Outer Shelf should sit beyond existing Mirror Kelp payoffs")
	_expect(max_x - min_x >= 1200.0, "Outer Shelf footprint should be wide enough for later branch and decision work")
	_expect(playable_lane.color.a <= 0.2, "Outer Shelf playable water should stay readable without becoming a bright pickup")
	_expect(deep_backwater.color.a > playable_lane.color.a, "Outer Shelf background should frame the route with darker mass")
	_expect(mid_plate.color.a > playable_lane.color.a and mid_plate.color.a < deep_backwater.color.a, "Outer Shelf mid plate should separate route mass from playable water")
	_expect(upper_rim.color.a >= 0.45 and lower_rim.color.a >= 0.45, "Outer Shelf terrain rims should be distinguishable from playable water")
	_expect(glass_rim.color.a <= 0.24 and low_shelf.color.a <= 0.32, "Outer Shelf landmarks should not compete with future payoffs")
	_expect(glass_steps.color.a > glass_rim.color.a and glass_steps.color.a < survey_visual.color.a, "Outer Shelf Glass Rim steps should frame the route without competing with the survey")
	_expect(survey_perch.color.a < survey_visual.color.a and survey_perch.polygon.size() >= 5, "Outer Shelf survey perch should anchor the payoff as terrain, not cargo")
	_expect(foreground_shelf.color.a >= 0.42 and foreground_shelf.color.a < upper_rim.color.a, "Outer Shelf foreground shelf should read as terrain while staying behind active rewards")
	_expect(return_wash.color.g > return_wash.color.r and return_wash.color.a <= 0.12, "Outer Shelf return wash should use quiet safe-current language")
	_expect(outer_label.text == "OUTER SHELF", "Outer Shelf should have one compact region label")
	_expect(glass_label.text == "GLASS RIM", "Outer Shelf should have one compact local landmark label")
	_expect(not outer_label.text.to_lower().contains("objective"), "Outer Shelf label should not become checklist copy")
	_expect(not glass_label.text.to_lower().contains("map"), "Glass Rim label should not imply exact map UI")
	_expect(survey_core.get_node_or_null("InteractZone/CollisionShape2D") != null, "Outer Shelf should own exactly one nested survey interaction")
	_expect(outer_shelf.get_node_or_null("InteractZone") == null, "Outer Shelf footprint should not add a route-wide interaction hotspot")
	_expect(outer_shelf.find_child("CollisionShape2D", true, false) == survey_core.get_node("InteractZone/CollisionShape2D"), "Outer Shelf footprint should only add collision for the survey trigger")
	_expect(outer_shelf.find_child("ResourcePickup", true, false) == null, "Outer Shelf footprint should not add pickups yet")
	_expect(outer_shelf.find_child("LootTable", true, false) == null, "Outer Shelf footprint should not add loot tables")
	_expect(outer_shelf.find_child("HealthBar", true, false) == null, "Outer Shelf footprint should not add combat UI")
	_expect(main.progression_state.to_save_data() == save_before, "Outer Shelf footprint should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Outer Shelf footprint should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "Outer Shelf footprint should not mutate cargo")

	var player_bounds := PlayerScript.new()
	var outer_center := outer_shelf.global_position + Vector2(940.0, 120.0)
	var clamped_outer := player_bounds.clamp_position_to_world_bounds(outer_center)
	_expect(clamped_outer == outer_center, "player bounds should include the first Outer Shelf footprint")
	player_bounds.free()

	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = outer_center
	var outer_direction: String = main.call("_format_base_direction")
	_expect(outer_direction.contains("up-left"), "Outer Shelf base direction should use broad return orientation")
	_expect(outer_direction.contains("Mirror/Wide/Hollow"), "Outer Shelf base direction should keep compact named return memory")
	_expect_no_echo_lens_locator_language(outer_direction, "Outer Shelf base direction")
	main.queue_free()

func _test_outer_shelf_glass_rim_branch() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var branch := outer_shelf.get_node("GlassRimCutBranch") as Node2D
	var mouth_shadow := branch.get_node("BranchMouthShadow") as Polygon2D
	var water_pocket := branch.get_node("BranchWaterPocket") as Polygon2D
	var upper_rim := branch.get_node("UpperCutRim") as Polygon2D
	var lower_rim := branch.get_node("LowerCutRim") as Polygon2D
	var return_wash := branch.get_node("BranchReturnWash") as Polygon2D
	var branch_label := branch.get_node("BranchLabel") as Label
	var rim_promise := outer_shelf.get_node("RimSealPromise") as Node2D
	var rim_promise_mouth := rim_promise.get_node("SealMouth") as Polygon2D
	var rim_promise_veil := rim_promise.get_node("SealVeil") as Polygon2D
	var rim_promise_bars := rim_promise.get_node("RimSealBars") as Polygon2D
	var rim_promise_glint := rim_promise.get_node("FutureGlint") as Polygon2D
	var rim_promise_label := rim_promise.get_node("PromiseLabel") as Label
	var survey_core := outer_shelf.get_node("OuterShelfSurveyCore/SurveyCore") as Polygon2D
	var outer_metadata := main.get_node("LandmarkMetadata/OuterShelf")
	var branch_metadata := main.get_node("LandmarkMetadata/GlassRimCut")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()

	_expect(branch.get_parent() == outer_shelf, "Glass Rim Cut should be authored inside the Outer Shelf footprint")
	_expect(branch.position.x > 700.0, "Glass Rim Cut should sit deeper inside Area 02 instead of at the entrance")
	_expect(branch.position.y < 0.0, "Glass Rim Cut should read as a high branch off the main water lane")
	_expect(branch_label.text == "GLASS RIM CUT", "Glass Rim Cut should have compact place-label copy")
	_expect(not branch_label.text.to_lower().contains("objective"), "Glass Rim Cut label should not read like a checklist")
	_expect(not branch_label.text.to_lower().contains("map"), "Glass Rim Cut label should not imply exact map UI")
	_expect(mouth_shadow.color.a >= 0.5, "Glass Rim Cut branch mouth should read as a deliberate side opening")
	_expect(water_pocket.color.a <= 0.18, "Glass Rim Cut water should stay readable without becoming a reward marker")
	_expect(upper_rim.color.a <= 0.24 and lower_rim.color.a <= 0.34, "Glass Rim Cut rims should frame the branch without overpowering the sub")
	_expect(return_wash.color.g > return_wash.color.r and return_wash.color.a <= 0.1, "Glass Rim Cut return wash should use quiet safe-current language")
	_expect(branch.find_child("InteractZone", true, false) == null, "Glass Rim Cut branch should not add interactions yet")
	_expect(branch.find_child("CollisionShape2D", true, false) == null, "Glass Rim Cut branch should not add collision yet")
	_expect(branch.find_child("ResourcePickup", true, false) == null, "Glass Rim Cut branch should not add pickups yet")
	_expect(branch.find_child("ScannerObjective", true, false) == null, "Glass Rim Cut branch should not add objective-like scanner UI")
	_expect(branch.find_child("LootTable", true, false) == null, "Glass Rim Cut branch should not add loot tables")
	_expect(branch.find_child("HealthBar", true, false) == null, "Glass Rim Cut branch should not add combat UI")
	_expect(rim_promise.position.x > branch.position.x, "Rim Seal Promise should sit beyond the visible Glass Rim Cut landmark")
	_expect(rim_promise_label.text == "RIM SEAL NEEDED", "Rim Seal Promise should name the missing capability compactly")
	_expect(not rim_promise_label.text.to_lower().contains("objective"), "Rim Seal Promise should not read like a checklist objective")
	_expect(not rim_promise_label.text.to_lower().contains("map"), "Rim Seal Promise should not imply exact map UI")
	_expect(rim_promise_mouth.color.a >= 0.5, "Rim Seal Promise should read as a blocked future route mouth")
	_expect(rim_promise_veil.color.a <= 0.14, "Rim Seal Promise veil should stay quieter than active goals")
	_expect(rim_promise_bars.color.a <= 0.24, "Rim Seal Promise bars should stay quieter than recoverable payoffs")
	_expect(rim_promise_glint.color.a <= 0.28, "Rim Seal Promise glint should be curiosity, not a reward marker")
	_expect(rim_promise_bars.color.a < survey_core.color.a, "Rim Seal Promise should be quieter than the active Outer Shelf survey payoff")
	_expect(rim_promise.get_node_or_null("InteractZone") == null, "Rim Seal Promise should not add an active interaction")
	_expect(rim_promise.find_child("CollisionShape2D", true, false) == null, "Rim Seal Promise should not add collision")
	_expect(rim_promise.find_child("ResourcePickup", true, false) == null, "Rim Seal Promise should not create cargo")
	_expect(rim_promise.find_child("UpgradeDefinition", true, false) == null, "Rim Seal Promise should not create a purchasable upgrade entry")
	var outer_memory := "%s %s %s" % [
		String(outer_metadata.get("display_name")),
		String(outer_metadata.get("memory_goal")),
		String(outer_metadata.get("persistent_facts")),
	]
	var branch_memory := "%s %s %s" % [
		String(branch_metadata.get("display_name")),
		String(branch_metadata.get("memory_goal")),
		String(branch_metadata.get("persistent_facts")),
	]
	_expect(outer_memory.contains("Outer Shelf"), "Outer Shelf metadata should support future result memory")
	_expect(outer_memory.contains("Mirror Kelp"), "Outer Shelf metadata should preserve broad return orientation")
	_expect(branch_memory.contains("Glass Rim Cut"), "Glass Rim Cut metadata should support future result memory")
	_expect(branch_memory.contains("up-left") or branch_memory.contains("back left"), "Glass Rim Cut metadata should preserve broad return orientation")
	_expect_no_echo_lens_locator_language(outer_memory, "Outer Shelf metadata")
	_expect_no_echo_lens_locator_language(branch_memory, "Glass Rim Cut metadata")
	_expect(main.progression_state.to_save_data() == save_before, "Glass Rim Cut branch should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Glass Rim Cut branch should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "Glass Rim Cut branch should not mutate cargo")
	main.queue_free()

func _test_outer_shelf_slackwater_timing_cue_visual_only() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_outer_shelf_slackwater_alpha", 0.0)
	var high_alpha: float = main.call("_outer_shelf_slackwater_alpha", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	var repeat_alpha: float = main.call("_outer_shelf_slackwater_alpha", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.5)
	var open_state: String = main.call("_outer_shelf_slackwater_decision_state", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	var surge_state: String = main.call("_outer_shelf_slackwater_decision_state", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.75)
	var open_prompt: String = main.call("_outer_shelf_slackwater_decision_prompt", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	var surge_prompt: String = main.call("_outer_shelf_slackwater_decision_prompt", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.75)
	_expect(high_alpha > low_alpha, "Outer Shelf slackwater timing cue alpha should pulse upward to suggest a crossing window")
	_expect(is_equal_approx(low_alpha, repeat_alpha), "Outer Shelf slackwater timing cue should repeat smoothly")
	_expect(open_state == "open", "Outer Shelf slackwater timing should expose a readable open-crossing state")
	_expect(surge_state == "surging", "Outer Shelf slackwater timing should expose a readable turn-back state")
	_expect(open_prompt.contains("cross now") and open_prompt.contains("bank cargo"), "Outer Shelf open timing prompt should present a local push-or-bank decision")
	_expect(surge_prompt.contains("turn back") and surge_prompt.contains("oxygen"), "Outer Shelf surge timing prompt should frame the cost of waiting")
	_expect(not open_prompt.to_lower().contains("map") and not open_prompt.to_lower().contains("objective"), "Outer Shelf timing prompt should not imply map or checklist UI")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	var branch := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch") as Node2D
	var wake := branch.get_node("SlackwaterTimingWake") as Polygon2D
	var window := branch.get_node("SlackwaterWindow") as Polygon2D
	var tick := branch.get_node("SlackwaterTickA") as Polygon2D
	var return_wash := branch.get_node("BranchReturnWash") as Polygon2D
	var branch_mouth := branch.get_node("BranchMouthShadow") as Polygon2D
	scene_main.dive_session.reset(24.0)
	scene_main.dive_session.start()
	scene_main.dive_session.has_left_base = true
	scene_main.dive_session.current_cargo.append("kelp_fiber")
	var save_before: Dictionary = scene_main.progression_state.to_save_data().duplicate(true)

	scene_main.call("_update_outer_shelf_slackwater_timing_cue", MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	_expect(window.color.b > window.color.g and window.color.r > return_wash.color.r, "Outer Shelf slackwater timing should use pale violet timing language instead of safe-current green")
	_expect(return_wash.color.g > window.color.g, "Glass Rim return wash should stay visually distinct from the timing window")
	_expect(wake.color.a <= 0.15 and window.color.a <= 0.2 and tick.color.a <= 0.23, "Outer Shelf slackwater timing cue should stay subtle and non-blocking")
	_expect(window.color.a > wake.color.a, "Outer Shelf slackwater window should become the clearest local crossing read")
	_expect(window.color.a < branch_mouth.color.a, "Outer Shelf slackwater timing cue should not overpower the branch mouth")
	_expect(is_equal_approx(scene_main.dive_session.oxygen, 24.0), "Outer Shelf slackwater timing cue should not drain oxygen")
	_expect(scene_main.dive_session.current_cargo == ["kelp_fiber"], "Outer Shelf slackwater timing cue should not mutate cargo")
	_expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Outer Shelf slackwater timing cue should not change dive result")
	_expect(scene_main.progression_state.to_save_data() == save_before, "Outer Shelf slackwater timing cue should not mutate durable progression")
	_expect(branch.find_child("PressureBoundary", true, false) == null, "Outer Shelf slackwater timing cue should not add hidden pressure behavior")
	_expect(branch.find_child("Predator", true, false) == null, "Outer Shelf slackwater timing cue should not add combat pressure")
	_expect(branch.find_child("ResourcePickup", true, false) == null, "Outer Shelf slackwater timing cue should not create cargo")
	scene_main.queue_free()

func _test_outer_shelf_cargo_knowledge_payoff_choice() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_outer_shelf_survey = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"kelp_fiber": 1}
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var survey := outer_shelf.get_node("OuterShelfSurveyCore") as Node2D
	var survey_core := survey.get_node("SurveyCore") as Polygon2D
	var survey_spark := survey.get_node("SurveySpark") as Polygon2D
	var kelp_candidate := main.get_node("StarterResourceCandidates/KelpFiber/OuterShelfA") as SpawnPoint
	main.call("_sync_outer_shelf_survey_state")
	_expect(survey_core.color.a >= 0.8, "Outer Shelf survey core should start visibly recoverable")
	_expect(survey_spark.visible, "Outer Shelf survey spark should start visible before recovery")
	_expect(kelp_candidate.target_id == "kelp_fiber", "Outer Shelf cargo choice should use existing Kelp Fiber")
	_expect(kelp_candidate.depth_band == "deep", "Outer Shelf cargo choice should stay in the deep branch context")
	_expect(kelp_candidate.cluster_pattern == "deep_reward", "Outer Shelf cargo choice should remain optional deep-reward pressure")
	_expect(kelp_candidate.global_position.distance_to(survey.global_position) >= 90.0, "Outer Shelf cargo and survey should not stack on each other")
	_expect(kelp_candidate.global_position.y > survey.global_position.y, "Outer Shelf cargo should sit below the survey so it reads as a separate commitment")
	_expect(main.get_node_or_null("ResourcePickups/OuterShelfKelpFiber") == null, "Outer Shelf cargo choice should reuse existing pickup placement instead of adding an extra active pickup")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Outer Shelf survey"), "Outer Shelf proximity should own the active dive prompt")
	_expect(prompt.contains("E/Enter"), "Outer Shelf prompt should keep the compact interaction command")

	var handled: bool = main.call("_try_outer_shelf_survey_interaction")
	_expect(handled, "Outer Shelf should handle interact while nearby during a dive")
	_expect(main.run_outer_shelf_survey_recovered, "Outer Shelf interaction should record one run-scoped survey")
	_expect(main.run_reached_dusk_trench, "Outer Shelf interaction should count as a deep-route reach for broad place memory")
	_expect(survey_core.color.a <= 0.2, "Outer Shelf survey should visibly dim after recovery")
	_expect(not survey_spark.visible, "Outer Shelf survey spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Outer Shelf survey should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Outer Shelf survey should not add or remove cargo")
	_expect(main.progression_state.resource_count("kelp_fiber") == 1, "Outer Shelf survey should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("return through Mirror/Wide/Hollow"), "Outer Shelf status should keep broad return language")
		_expect(main.status_label.text.contains("Kelp Fiber"), "Outer Shelf status should name the nearby cargo alternative")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Outer Shelf status")

	var repeat_handled: bool = main.call("_try_outer_shelf_survey_interaction")
	_expect(repeat_handled, "Outer Shelf should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Outer Shelf repeat interaction should not duplicate the payoff")

	main.player_near_outer_shelf_survey = false
	var not_handled: bool = main.call("_try_outer_shelf_survey_interaction")
	_expect(not not_handled, "Outer Shelf should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("outer_shelf_survey"), "Outer Shelf survey should not become durable save data")
	_expect(not saved.has("outer_shelf_route"), "Outer Shelf should not create durable route state")
	_expect(not saved.has("glass_rim_cut"), "Glass Rim Cut should not create durable route state")

	var callout: String = main.call("_format_outer_shelf_survey_research_callout")
	_expect(callout.contains("Outer Shelf"), "Outer Shelf result memory should name the area")
	_expect(callout.contains("Glass Rim Cut"), "Outer Shelf result memory should explain why the survey mattered")
	_expect(callout.contains("Kelp Fiber cargo"), "Outer Shelf result memory should preserve the cargo-vs-knowledge choice")
	_expect_no_echo_lens_locator_language(callout, "Outer Shelf result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Remembered place: Outer Shelf"), "Outer Shelf extraction summary should remember the newest area")
	_expect(extraction_summary.contains("Outer Shelf survey"), "Outer Shelf extraction summary should include recovered survey memory")
	_expect(extraction_summary.contains("try Glass Rim timing or bank the Outer Shelf cargo"), "Outer Shelf extraction summary should invite one next-run hypothesis")
	_expect(not extraction_summary.to_lower().contains("checklist"), "Outer Shelf extraction summary should not imply checklist UI")
	_expect(not extraction_summary.to_lower().contains("map"), "Outer Shelf extraction summary should not imply map UI")
	_expect(main._format_recent_route_memory() == "Outer Shelf", "recent route helper should expose Outer Shelf after survey evidence")
	_expect(not extraction_summary.contains("%s"), "Outer Shelf extraction summary should not leak string placeholders")
	main.progression_state.current_run_number = 8
	main.progression_state.current_run_seed = 1008
	main.call("_record_recent_expedition", "Extracted", 0)
	var recent_log: String = main.call("_format_recent_expedition_log")
	_expect(recent_log.contains("route Outer Shelf"), "Outer Shelf recent log should name the remembered place")
	_expect(recent_log.contains("next Glass Rim timing or cargo"), "Outer Shelf recent log should tease a compact next dive")
	_expect(not recent_log.to_lower().contains("checklist"), "Outer Shelf recent log should not imply checklist UI")
	_expect(not recent_log.to_lower().contains("map"), "Outer Shelf recent log should not imply map UI")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_outer_shelf_survey_research_callout() == "", "Outer Shelf result line should stay hidden before survey recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Outer Shelf survey"), "Outer Shelf extraction summary should stay hidden before survey recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_outer_shelf_survey_recovered, "Outer Shelf survey should reset between expeditions")
	_expect(survey_core.color.a >= 0.8, "Outer Shelf survey should become visible again on expedition reset")
	_expect(survey_spark.visible, "Outer Shelf survey spark should reset between expeditions")
	main.free()

func _test_glass_rim_reading_payoff_choice() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_rim_glass_reading = true
	main.dive_session.oxygen = 16.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"shell_fragments": 1}
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var branch := outer_shelf.get_node("GlassRimCutBranch") as Node2D
	var promise := outer_shelf.get_node("RimSealPromise") as Node2D
	var reading := outer_shelf.get_node("RimGlassReading") as Node2D
	var halo := reading.get_node("ReadingHalo") as Polygon2D
	var core := reading.get_node("ReadingCore") as Polygon2D
	var spark := reading.get_node("ReadingSpark") as Polygon2D
	var interact_zone := reading.get_node("InteractZone") as Area2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main.call("_sync_rim_glass_reading_state")
	_expect(reading.position.x > branch.position.x, "Glass Rim reading should sit beyond the timing branch")
	_expect(reading.position.x < promise.position.x, "Glass Rim reading should sit before the sealed future promise")
	_expect(interact_zone.collision_layer == 0, "Glass Rim reading interaction should not become route collision")
	_expect(halo.color.a <= 0.24 and core.color.a >= 0.8, "Glass Rim reading should read as a visible knowledge payoff")
	_expect(spark.visible, "Glass Rim reading spark should start visible before recovery")
	_expect(reading.find_child("ResourcePickup", true, false) == null, "Glass Rim reading should not be cargo")
	_expect(reading.find_child("LootTable", true, false) == null, "Glass Rim reading should not add loot tables")
	_expect(reading.find_child("HealthBar", true, false) == null, "Glass Rim reading should not add combat UI")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Glass Rim reading"), "Glass Rim reading proximity should own the active prompt")
	_expect(prompt.contains("E/Enter"), "Glass Rim reading prompt should expose the normal interact command")

	var handled: bool = main.call("_try_rim_glass_reading_interaction")
	_expect(handled, "Glass Rim reading should handle interact while nearby during a dive")
	_expect(main.run_rim_glass_reading_recovered, "Glass Rim interaction should record one run-scoped reading")
	_expect(main.run_reached_dusk_trench, "Glass Rim reading should count as a deeper route reach for broad place memory")
	_expect(core.color.a <= 0.2, "Glass Rim reading core should visibly dim after recovery")
	_expect(not spark.visible, "Glass Rim reading spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 16.0), "Glass Rim reading should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Rim reading should not add or remove cargo")
	_expect(main.progression_state.resource_count("shell_fragments") == 1, "Glass Rim reading should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Bank it now"), "Glass Rim status should name the safe return option")
		_expect(main.status_label.text.contains("Kelp Fiber"), "Glass Rim status should preserve the nearby cargo alternative")
		_expect(main.status_label.text.contains("oxygen"), "Glass Rim status should frame the oxygen risk")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Glass Rim reading status")

	var repeat_handled: bool = main.call("_try_rim_glass_reading_interaction")
	_expect(repeat_handled, "Glass Rim should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recovered"), "Glass Rim repeat interaction should not duplicate the payoff")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved == save_before, "Glass Rim reading should not mutate durable progression")
	_expect(not saved.has("rim_glass_reading"), "Glass Rim reading should not create durable reading state")
	_expect(not saved.has("glass_rim_route"), "Glass Rim reading should not create durable route state")
	_expect(not saved.has("route_graph"), "Glass Rim reading should not create route graph state")
	var callout: String = main.call("_format_rim_glass_reading_callout")
	_expect(callout.contains("Glass Rim reading"), "Glass Rim research line should name the new payoff")
	_expect(callout.contains("cargo remains optional"), "Glass Rim research line should preserve the cargo-vs-knowledge decision")
	_expect_no_echo_lens_locator_language(callout, "Glass Rim research line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Remembered place: Glass Rim"), "Glass Rim extraction summary should remember the specific payoff place")
	_expect(extraction_summary.contains("Route choice: recovered Glass Rim reading"), "Glass Rim extraction summary should distinguish this payoff from the survey")
	_expect(extraction_summary.contains("Research: Glass Rim reading"), "Glass Rim extraction summary should include the new research payoff")
	_expect(extraction_summary.contains("timing, cargo, or return"), "Glass Rim extraction summary should tease the next decision loop")
	_expect(not extraction_summary.to_lower().contains("checklist"), "Glass Rim extraction summary should not imply checklist UI")
	_expect(not extraction_summary.to_lower().contains("map"), "Glass Rim extraction summary should not imply map UI")
	_expect(main._format_recent_route_memory() == "Glass Rim", "recent route helper should prefer Glass Rim after the new payoff")
	main.progression_state.current_run_number = 9
	main.progression_state.current_run_seed = 1009
	main.call("_record_recent_expedition", "Extracted", 0)
	var recent_log: String = main.call("_format_recent_expedition_log")
	_expect(recent_log.contains("route Glass Rim"), "Glass Rim recent log should name the new payoff place")
	_expect(recent_log.contains("next timing, cargo, or return"), "Glass Rim recent log should tease the compact next dive")

	main.call("_reset_run_telemetry")
	_expect(not main.run_rim_glass_reading_recovered, "Glass Rim reading should reset between expeditions")
	_expect(core.color.a >= 0.8, "Glass Rim reading should become visible again on expedition reset")
	_expect(spark.visible, "Glass Rim reading spark should reset between expeditions")
	main.free()

func _test_glass_ray_drifter_passive_route_read() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var ray := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRayDrifter") as Area2D
	var wake := ray.get_node("RouteWake") as Polygon2D
	var body := ray.get_node("RayBody") as Polygon2D
	var scan_marker := ray.get_node("ScanMarker") as Polygon2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()

	_expect(ray.get("discovery_id") == "glass_ray_drifter", "Glass Ray should expose a stable scan id")
	_expect(ray.get("display_name") == "Glass Ray Drifter", "Glass Ray should expose a compact display name")
	var description: String = String(ray.get("description"))
	var gameplay_fact: String = String(ray.get("gameplay_fact"))
	_expect(description.contains("Glass Rim Cut"), "Glass Ray description should anchor to the remembered branch")
	_expect(gameplay_fact.contains("Glass Rim slackwater window"), "Glass Ray gameplay fact should teach the timing read")
	_expect(gameplay_fact.contains("wait"), "Glass Ray gameplay fact should encourage observation over forcing the route")
	_expect(gameplay_fact.contains("cross after the turn"), "Glass Ray gameplay fact should explain the local traversal timing")
	_expect(gameplay_fact.contains("bank cargo"), "Glass Ray gameplay fact should preserve the push-or-return choice")
	_expect(not gameplay_fact.to_lower().contains("coordinate") and not gameplay_fact.to_lower().contains("checklist"), "Glass Ray gameplay fact should not read like exact locator or checklist copy")
	_expect_no_monster_combat_language(description, "Glass Ray description")
	_expect_no_monster_combat_language(gameplay_fact, "Glass Ray gameplay fact")
	_expect(wake.color.a <= 0.14 and wake.color.b > wake.color.r, "Glass Ray route wake should stay subtle and not read as a reward")
	_expect(body.color.a <= 0.55, "Glass Ray should read as a passive translucent creature")
	_expect(scan_marker.color.a < 0.3, "Glass Ray scan marker should stay quiet while idle")
	_expect(Vector2(ray.get("move_start")).x < Vector2(ray.get("move_end")).x, "Glass Ray should drift across the Glass Rim route read instead of bobbing in place")
	_expect(Vector2(ray.get("move_start")).distance_to(Vector2(ray.get("move_end"))) >= 200.0, "Glass Ray drift should be long enough to imply a timing loop")
	_expect(ray.find_child("HealthBar", true, false) == null, "Glass Ray should not add combat health UI")
	_expect(ray.find_child("LootTable", true, false) == null, "Glass Ray should not add loot tables")
	_expect(ray.find_child("HarvestArea", true, false) == null, "Glass Ray should not add harvesting")
	_expect(ray.find_child("CaptureArea", true, false) == null, "Glass Ray should not add capture behavior")
	_expect(ray.find_child("Predator", true, false) == null, "Glass Ray should not use predator behavior")
	_expect(ray.get_node_or_null("ResourcePickup") == null, "Glass Ray should not be a resource pickup")

	var start_position := ray.global_position
	ray.call("_physics_process", 1.0)
	_expect(ray.global_position != start_position, "Glass Ray should drift instead of reading as static scenery")

	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = ray.global_position
	var scan_candidates: Array[Node] = [ray]
	_expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == ray, "scanner target selection should find Glass Ray reliably at close range")
	_expect(main.call("_scan_target_gameplay_fact", ray).contains("slackwater"), "scanner read should expose the route-timing lesson")
	_expect(main.progression_state.to_save_data() == save_before, "unscanned Glass Ray should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "unscanned Glass Ray should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "unscanned Glass Ray should not mutate cargo")

	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = main.call("_scan_target_id", ray)
	var display_name: String = main.call("_scan_target_display_name", ray)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		main.call("_scan_target_description", ray),
		main.call("_scan_target_gameplay_fact", ray)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		main.call("_format_repeat_scan_effect_text", ray) + main.call("_format_first_scan_guidance", ray)
	])
	var first_scan_guidance: String = main.call("_format_first_scan_guidance", ray)
	_expect(main.progression_state.has_discovery("glass_ray_drifter"), "first Glass Ray scan should record a normal durable discovery")
	_expect(main.run_completed_scans == ["glass_ray_drifter"], "first Glass Ray scan should count as current-run observation evidence")
	_expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Glass Ray scan should use the normal scan oxygen cost")
	_expect(first_scan_status.contains("Scanned Glass Ray Drifter"), "first Glass Ray scan status should name the creature")
	_expect(first_scan_status.contains("slackwater observation refreshed"), "first Glass Ray scan status should refresh the route lesson")
	_expect(first_scan_guidance.contains("cross on slackwater"), "first Glass Ray scan guidance should teach the Glass Rim timing decision")
	_expect(first_scan_guidance.contains("bank cargo"), "first Glass Ray scan guidance should preserve the return option")
	_expect_no_monster_combat_language(first_scan_status, "Glass Ray first scan status")
	_expect(not first_scan_status.to_lower().contains("field guide"), "Glass Ray scan should not imply field-guide UI")
	_expect(not first_scan_status.to_lower().contains("checklist"), "Glass Ray scan should not imply checklist UI")
	_expect(main._format_discovery_memory_callout().contains("Glass Ray Drifter"), "Glass Ray scan should produce compact discovery memory")
	_expect(main._format_discovery_memory_callout().contains("without fighting"), "Glass Ray discovery memory should frame observation as non-combat")
	_expect(main._format_route_choice_callout().contains("Glass Ray slackwater timing"), "Glass Ray scan should produce a compact Glass Rim route-choice memory")
	_expect(main._format_region_memory_callout().contains("Outer Shelf"), "Glass Ray scan should remember the broad Outer Shelf place")
	_expect(main._format_recent_route_memory() == "Outer Shelf", "Glass Ray scan should support current-run Outer Shelf route memory")
	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(saved.get("scan_discoveries", {}).has("glass_ray_drifter"), "Glass Ray discovery should persist through normal scan discovery storage")
	_expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Glass Ray scan should not mutate resources")
	_expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Glass Ray scan should not mutate upgrades")
	_expect(not saved.has("glass_ray_objective"), "Glass Ray scan should not create durable objective-chain state")
	_expect(not saved.has("monster_parts"), "Glass Ray scan should not add monster-part economy state")
	_expect(not saved.has("creature_inventory"), "Glass Ray scan should not add creature inventory state")
	main.queue_free()

func _test_wide_chamber_salvage_pocket_entrance() -> void:
	var root := Node.new()
	get_root().add_child(root)
	var main := MainScene.instantiate()
	root.add_child(main)
	var chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var salvage := chamber.get_node("WreckSalvagePocketEntrance") as Node2D
	var pocket_shadow := salvage.get_node("PocketShadow") as Polygon2D
	var hull_rim := salvage.get_node("WreckHullRim") as Polygon2D
	var hatch_panel := salvage.get_node("SealedHatchPanel") as Polygon2D
	var lock_bars := salvage.get_node("LockBars") as Polygon2D
	var salvage_glint := salvage.get_node("SalvageGlint") as Polygon2D
	var future_cutter_port := salvage.get_node("FutureCutterPort") as Node2D
	var cutter_port_plate := salvage.get_node("FutureCutterPort/PortPlate") as Polygon2D
	var cutter_port_socket := salvage.get_node("FutureCutterPort/PortSocket") as Polygon2D
	var cutter_port_label := salvage.get_node("FutureCutterPort/ToolLabel") as Label
	var data_cache := salvage.get_node("DataCache") as Node2D
	var data_cache_halo := salvage.get_node("DataCache/CacheHalo") as Polygon2D
	var data_cache_core := salvage.get_node("DataCache/CacheCore") as Polygon2D
	var data_cache_spark := salvage.get_node("DataCache/CacheSpark") as Polygon2D
	var interact_zone := salvage.get_node("InteractZone") as Area2D
	var promise_label := salvage.get_node("PromiseLabel") as Label
	var opened_lane := salvage.get_node("OpenedPocketLane") as Node2D
	var open_entry_water := salvage.get_node("OpenedPocketLane/EntryWater") as Polygon2D
	var open_return_cue := salvage.get_node("OpenedPocketLane/ReturnCurrentCue") as Polygon2D
	var silt_wake := salvage.get_node("OpenedPocketLane/SiltTimingWake") as Polygon2D
	var silt_window := salvage.get_node("OpenedPocketLane/SiltTimingWindow") as Polygon2D
	var silt_tick := salvage.get_node("OpenedPocketLane/SiltTimingTickA") as Polygon2D
	var open_label := salvage.get_node("OpenedPocketLane/OpenLabel") as Label
	var salvage_manifest := salvage.get_node("OpenedPocketLane/SalvageManifest") as Node2D
	var manifest_halo := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestHalo") as Polygon2D
	var manifest_core := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestCore") as Polygon2D
	var manifest_spark := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestSpark") as Polygon2D
	var manifest_interact := salvage.get_node("OpenedPocketLane/SalvageManifest/InteractZone") as Area2D
	var salvage_shell_candidate := main.get_node("StarterResourceCandidates/ShellFragments/SalvagePocketA") as SpawnPoint
	var chamber_backwater := chamber.get_node("ChamberBackwater") as Polygon2D
	var upper_chamber_shelf := chamber.get_node("UpperChamberShelf") as Polygon2D
	var lower_chamber_shelf := chamber.get_node("LowerChamberShelf") as Polygon2D
	var glass_rib_span := chamber.get_node("GlassRibSpan") as Polygon2D
	var future_choice_shadow := chamber.get_node("FutureChoiceShadow") as Polygon2D
	var return_current := chamber.get_node("ReturnCurrentBackToHollow") as Polygon2D
	var swarm := chamber.get_node("GlassfinSwarm") as Area2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()

	_expect(salvage.get_parent() == chamber, "salvage pocket entrance should be authored inside the wide chamber")
	_expect(salvage.position.x >= 520.0, "salvage pocket entrance should sit on the far side of the wide chamber")
	_expect(salvage.position.y < return_current.polygon[0].y - 120.0, "salvage pocket entrance should stay above the lower return-current route")
	_expect(salvage.position.x > swarm.position.x, "salvage pocket entrance should not overlap the current Glassfin Swarm lane")
	_expect(future_choice_shadow.color.a >= 0.3, "future-choice shadow should still frame the far chamber promise")
	_expect(pocket_shadow.color.a >= 0.6, "salvage pocket should read as a deliberate sealed opening")
	_expect(hull_rim.color.r > hull_rim.color.g and hull_rim.color.g > hull_rim.color.b, "salvage rim should use muted wreck/rust language")
	_expect(hatch_panel.color.b >= hatch_panel.color.g, "sealed hatch panel should read as cold wreck metal, not a resource")
	_expect(lock_bars.color.b > lock_bars.color.r and lock_bars.color.a <= 0.28, "salvage lock bars should read as sealed promise language without becoming a reward")
	_expect(salvage_glint.color.a <= 0.5, "salvage glint should stay a subtle promise, not a collectable reward")
	_expect(future_cutter_port.position.x > data_cache.position.x, "future cutter port should sit beside the cache rather than on top of the knowledge payoff")
	_expect(cutter_port_plate.color.r > cutter_port_plate.color.b and cutter_port_plate.color.g > cutter_port_plate.color.b, "future cutter port should use warm salvage-tool language, not pressure/echo blue")
	_expect(cutter_port_socket.color.a >= 0.7, "future cutter socket should read as a closed tool interface")
	_expect(cutter_port_label.text == "CUTTER NEEDED", "future salvage tool promise should name a compact missing tool")
	_expect(not cutter_port_label.text.to_lower().contains("open"), "future salvage tool copy should not imply the route is open")
	_expect(not cutter_port_label.text.to_lower().contains("pressure"), "future salvage tool copy should not conflict with Pressure Seal language")
	_expect(not cutter_port_label.text.to_lower().contains("echo"), "future salvage tool copy should not conflict with Echo Lens language")
	_expect(not cutter_port_label.text.to_lower().contains("key"), "future salvage tool copy should not conflict with Resonance Key language")
	_expect(data_cache.position.x >= -10.0 and data_cache.position.x <= 40.0, "salvage data cache should sit inside the sealed pocket mouth")
	_expect(data_cache_core.color.a >= 0.7, "salvage data cache should start visibly recoverable")
	_expect(data_cache_core.color.b >= data_cache_core.color.r, "salvage data cache should use cool knowledge-payoff color language")
	_expect(data_cache_halo.color.a < data_cache_core.color.a, "salvage data cache halo should stay subordinate to the payoff core")
	_expect(data_cache_spark.visible and data_cache_spark.color.b >= data_cache_spark.color.r, "salvage data cache spark should read as data, not shell or cargo")
	_expect(chamber_backwater.color.a <= 0.42, "Wide Reef Chamber backwater should stay below payoff brightness")
	_expect(upper_chamber_shelf.color.a <= 0.34 and lower_chamber_shelf.color.a <= 0.38, "Wide Reef Chamber shelf framing should stay quiet enough for normal play")
	_expect(glass_rib_span.color.a <= 0.16, "Wide Reef Chamber rib landmark should not compete with cache or pickup reads")
	_expect(return_current.color.a < data_cache_core.color.a, "safe-return current should be quieter than the salvage data cache payoff")
	_expect(salvage_shell_candidate.target_id == "shell_fragments", "salvage pocket cargo choice should use existing Shell Fragments")
	_expect(salvage_shell_candidate.depth_band == "midwater", "salvage pocket cargo choice should preserve existing shell depth identity")
	_expect(salvage_shell_candidate.cluster_pattern == "deep_reward", "salvage pocket cargo choice should stay optional in the deep-reward resource pool")
	_expect(salvage_shell_candidate.global_position.distance_to(data_cache.global_position) >= 120.0, "salvage pocket cargo and knowledge targets should not stack on each other")
	_expect(salvage_shell_candidate.global_position.y > data_cache.global_position.y, "salvage pocket cargo should sit below the cache so the choice reads as two branches")
	_expect(salvage_shell_candidate.global_position.distance_to(salvage.global_position) <= 180.0, "salvage pocket cargo should stay near the sealed pocket decision")
	_expect(salvage_shell_candidate.global_position.distance_to(chamber.global_position + return_current.polygon[0]) >= 90.0, "salvage pocket cargo should not block the visible return-current entry")
	_expect(interact_zone.collision_layer == 0 and interact_zone.collision_mask == 1, "salvage interact zone should be an explicit player trigger, not route collision")
	_expect(promise_label.text == "SALVAGE", "salvage promise label should be compact and honest about current implementation")
	_expect(not promise_label.text.to_lower().contains("objective"), "salvage promise label should not imply objective checklist language")
	_expect(not promise_label.text.to_lower().contains("map"), "salvage promise label should not imply exact locator UI")
	_expect(not promise_label.text.to_lower().contains("pressure"), "salvage promise label should not conflict with pressure-gate copy")
	_expect(not promise_label.text.to_lower().contains("echo"), "salvage promise label should not conflict with Echo Lens copy")
	_expect(not promise_label.text.to_lower().contains("key"), "salvage promise label should not conflict with Resonance Key copy")
	_expect(not opened_lane.visible, "salvage opened lane should stay hidden before Salvage Cutter I")
	_expect(salvage.get_node_or_null("Interior") == null, "salvage promise should not add a full interior system")
	_expect(salvage.get_node_or_null("ResourcePickup") == null, "salvage promise should not add loot pickup behavior")
	_expect(salvage.find_child("LootTable", true, false) == null, "salvage promise should not add a loot table")
	_expect(salvage.find_child("HarvestArea", true, false) == null, "salvage promise should not add harvesting")
	_expect(salvage.find_child("HealthBar", true, false) == null, "salvage promise should not add combat UI")
	_expect(future_cutter_port.find_child("CollisionShape2D", true, false) == null, "future cutter port should not add collision")
	_expect(future_cutter_port.get_node_or_null("InteractZone") == null, "future cutter port should not add interaction yet")
	_expect(future_cutter_port.get_script() == null, "future cutter port should stay visual-only")
	_expect(main.get_node_or_null("ResourcePickups/SalvageShellFragments") == null, "salvage cargo choice should not add an extra active resource pickup")
	_expect(main.progression_state.to_save_data() == save_before, "salvage promise should not mutate progression")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "salvage promise should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "salvage promise should not mutate cargo")

	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	var save_before_open_sync: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main.call("_sync_salvage_pocket_open_state")
	_expect(opened_lane.visible, "owned Salvage Cutter I should reveal a small opened salvage pocket lane")
	_expect(not lock_bars.visible, "owned Salvage Cutter I should visually remove the sealed lock bars")
	_expect(hatch_panel.color.a <= 0.24, "opened salvage hatch should read as cut open rather than sealed")
	_expect(cutter_port_label.text == "CUTTER READY", "owned cutter should update the port readback")
	_expect(not cutter_port_label.visible, "owned cutter should hide redundant world tool copy and leave the HUD prompt to explain interaction")
	_expect(promise_label.text == "OPEN", "owned cutter should update the broad pocket state with compact world copy")
	_expect(open_label.text.contains("RETURN VIA HOLLOW"), "opened salvage pocket should preserve broad safe-return language")
	_expect(not open_label.visible, "opened salvage return label should stay hidden because the HUD and current shape already carry return guidance")
	_expect(open_entry_water.color.a <= 0.22, "opened salvage pocket water should be readable but quieter than pickups")
	_expect(open_return_cue.color.g > open_return_cue.color.r, "opened salvage return cue should use safe-current color language")
	_expect(open_entry_water.color.a < manifest_core.color.a and open_return_cue.color.a < manifest_core.color.a, "opened salvage lane support should stay quieter than the manifest payoff")
	_expect(silt_wake.color.b > silt_wake.color.g and silt_window.color.b > silt_window.color.r, "opened salvage silt cue should use pale timing language instead of safe-current green")
	_expect(silt_wake.color.a <= 0.13 and silt_window.color.a <= 0.17 and silt_tick.color.a <= 0.23, "opened salvage silt timing should stay subtle beside the payoff")
	_expect(silt_window.color.a < manifest_core.color.a, "opened salvage silt timing should not read brighter than the manifest payoff")
	_expect(opened_lane.find_child("CollisionShape2D", true, false) == manifest_interact.get_node("CollisionShape2D"), "opened salvage silt timing should not add hidden collision or pressure behavior")
	_expect(salvage_manifest.get_parent() == opened_lane, "Salvage Manifest should live inside the opened pocket lane")
	_expect(manifest_core.color.a >= 0.7, "Salvage Manifest should start visibly recoverable when the pocket is open")
	_expect(manifest_core.color.r > manifest_core.color.b, "Salvage Manifest should use amber document language distinct from cyan data shards")
	_expect(manifest_halo.color.a < manifest_core.color.a, "Salvage Manifest halo should stay subordinate to the payoff core")
	_expect(manifest_spark.visible, "Salvage Manifest should have a bright recovery spark before interaction")
	_expect(manifest_interact.collision_layer == 0 and manifest_interact.collision_mask == 1, "Salvage Manifest hotspot should detect the player without becoming route collision")
	_expect(salvage_shell_candidate.global_position.distance_to(salvage_manifest.global_position) >= 90.0, "Salvage Manifest and shell cargo should ask for a local choice instead of stacking")
	_expect(salvage_manifest.get_node_or_null("ResourcePickup") == null, "Salvage Manifest should not be cargo or loot behavior")
	_expect(salvage_manifest.find_child("LootTable", true, false) == null, "Salvage Manifest should not add a salvage loot table")
	_expect(salvage_manifest.find_child("HarvestArea", true, false) == null, "Salvage Manifest should not add harvesting")
	_expect(salvage_manifest.get_script() == null, "Salvage Manifest scene node should stay presentation/trigger only")
	_expect(main.progression_state.to_save_data() == save_before_open_sync, "opening presentation should not mutate save state beyond owned cutter")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "opening presentation should not drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "opening presentation should not mutate cargo")
	main.queue_free()
	root.queue_free()

func _test_salvage_data_cache_interaction() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_data_cache = true
	main.dive_session.oxygen = 23.0
	main.dive_session.current_cargo = ["glow_plankton"]
	var cache_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheHalo") as Polygon2D
	var cache_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheCore") as Polygon2D
	var cache_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheSpark") as Polygon2D
	main.call("_sync_salvage_data_cache_state")
	_expect(cache_core.color.a >= 0.7, "salvage data cache should start visibly recoverable")
	_expect(cache_spark.visible, "salvage data cache spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Salvage"), "salvage proximity should own the active dive prompt")
	_expect(prompt.contains("cache"), "salvage prompt should name the concrete knowledge payoff")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_salvage_data_cache_interaction")
	_expect(handled, "salvage data cache should handle interact while nearby during a dive")
	_expect(main.run_salvage_data_cache_recovered, "salvage data cache interaction should record one run-scoped cache")
	_expect(main.run_reached_dusk_trench, "salvage cache recovery should count as meaningful lower-route reach evidence")
	_expect(cache_halo.color.a <= 0.08, "salvage data cache halo should visibly dim after recovery")
	_expect(cache_core.color.a <= 0.2, "salvage data cache core should visibly dim after recovery")
	_expect(not cache_spark.visible, "salvage data cache spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 23.0), "salvage data cache should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["glow_plankton"], "salvage data cache should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	_expect(save_after == save_before, "salvage data cache should not mutate durable progression")
	_expect(not save_after.has("salvage_data_cache"), "salvage data cache should not create durable salvage state")
	_expect(not save_after.has("salvage_inventory"), "salvage data cache should not create salvage inventory state")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "salvage data cache interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("data cache"), "salvage status should name the visible payoff")
		_expect(main.status_label.text.contains("Salvage Cutter I prep"), "salvage status should frame the cache as a narrow tool prerequisite signal")
		_expect(not main.status_label.text.to_lower().contains("buy"), "salvage status should not imply a purchasable tool yet")

	var repeat_handled: bool = main.call("_try_salvage_data_cache_interaction")
	_expect(repeat_handled, "salvage data cache should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recovered"), "salvage repeat interaction should not duplicate the payoff")

	main.player_near_salvage_data_cache = false
	var not_handled: bool = main.call("_try_salvage_data_cache_interaction")
	_expect(not not_handled, "salvage data cache should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_salvage_data_cache_research_callout")
	_expect(callout.contains("Salvage data cache"), "salvage result memory should name the recovered cache")
	_expect(callout.contains("sealed wreck pocket"), "salvage result memory should keep the future destination broad")
	_expect(callout.contains("Salvage Cutter I prep"), "salvage result memory should connect the cache to the narrow tool prerequisite")
	_expect(not callout.to_lower().contains("upgrade bay"), "salvage result memory should not turn into menu instructions")
	_expect(not callout.to_lower().contains("craft"), "salvage result memory should not introduce crafting")
	_expect_no_echo_lens_locator_language(callout, "salvage data cache result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Salvage data cache"), "salvage extraction summary should include recovered cache memory")
	_expect(extraction_summary.contains("Salvage Cutter I prep"), "salvage extraction summary should make the cache useful for tool planning")
	_expect(not extraction_summary.to_lower().contains("buy cutter"), "salvage extraction summary should not make the future cutter purchasable")
	_expect(not extraction_summary.to_lower().contains("loot table"), "salvage extraction summary should avoid loot-system language")
	_expect(not extraction_summary.to_lower().contains("inventory"), "salvage extraction summary should avoid inventory language")
	main.call("_record_salvage_data_cache_discovery_if_extracted")
	_expect(main.progression_state.has_discovery("salvage_data_cache"), "safe extraction should convert salvage cache evidence into the normal upgrade prerequisite discovery")
	var save_with_evidence: Dictionary = main.progression_state.to_save_data()
	_expect(save_with_evidence.has("scan_discoveries"), "salvage cache evidence should use existing discovery save state")
	_expect(not save_with_evidence.has("salvage_inventory"), "salvage cache evidence should not create salvage inventory state")
	main.call("_reset_run_telemetry")
	_expect(not main.run_salvage_data_cache_recovered, "salvage cache should reset between expeditions")
	_expect(cache_core.color.a >= 0.7, "salvage data cache should become visible again after expedition reset")
	_expect(cache_spark.visible, "salvage data cache spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_salvage_data_cache_research_callout() == "", "salvage result line should stay hidden before payoff recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Salvage data cache"), "salvage extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_salvage_manifest_interaction() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_manifest = true
	main.dive_session.oxygen = 19.0
	main.dive_session.current_cargo.append("shell_fragments")
	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	main.call("_sync_salvage_pocket_open_state")
	var manifest_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestHalo") as Polygon2D
	var manifest_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestCore") as Polygon2D
	var manifest_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestSpark") as Polygon2D
	var opened_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	_expect(opened_lane.visible, "owned Salvage Cutter I should make the manifest lane visible")
	_expect(manifest_core.color.a >= 0.7, "Salvage Manifest should start visibly recoverable")
	_expect(manifest_spark.visible, "Salvage Manifest spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Salvage manifest"), "Salvage Manifest proximity should own the active dive prompt")
	_expect(prompt.contains("E/Enter"), "Salvage Manifest prompt should keep the compact interaction command")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_salvage_manifest_interaction")
	_expect(handled, "Salvage Manifest should handle interact while nearby during a dive with the cutter")
	_expect(main.run_salvage_manifest_recovered, "Salvage Manifest interaction should record one run-scoped manifest")
	_expect(main.run_reached_dusk_trench, "Salvage Manifest recovery should count as meaningful lower-route reach evidence")
	_expect(manifest_halo.color.a <= 0.09, "Salvage Manifest halo should visibly dim after recovery")
	_expect(manifest_core.color.a <= 0.2, "Salvage Manifest core should visibly dim after recovery")
	_expect(not manifest_spark.visible, "Salvage Manifest spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 19.0), "Salvage Manifest should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Salvage Manifest should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	_expect(save_after == save_before, "Salvage Manifest should not mutate durable progression")
	_expect(not save_after.has("salvage_manifest"), "Salvage Manifest should not create durable manifest state")
	_expect(not save_after.has("salvage_inventory"), "Salvage Manifest should not create salvage inventory state")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Salvage Manifest interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("shell fragments"), "Salvage Manifest status should frame the nearby cargo-vs-knowledge choice")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Salvage Manifest status")

	var repeat_handled: bool = main.call("_try_salvage_manifest_interaction")
	_expect(repeat_handled, "Salvage Manifest should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recovered"), "Salvage Manifest repeat interaction should not duplicate the payoff")

	main.player_near_salvage_manifest = false
	var not_handled: bool = main.call("_try_salvage_manifest_interaction")
	_expect(not not_handled, "Salvage Manifest should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_salvage_manifest_research_callout")
	_expect(callout.contains("Salvage Manifest"), "Salvage Manifest result memory should name the recovered payoff")
	_expect(callout.contains("cut-open wreck pocket"), "Salvage Manifest result memory should name the opened-pocket context")
	_expect(callout.contains("shell cargo is optional"), "Salvage Manifest result memory should preserve the cargo-vs-knowledge decision")
	_expect(not callout.to_lower().contains("craft"), "Salvage Manifest result memory should not introduce crafting")
	_expect(not callout.to_lower().contains("loot table"), "Salvage Manifest result memory should avoid loot-system language")
	_expect_no_echo_lens_locator_language(callout, "Salvage Manifest result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Salvage Manifest"), "Salvage Manifest extraction summary should include recovered manifest memory")
	_expect(extraction_summary.contains("Salvage Pocket"), "Salvage Manifest extraction summary should remember the opened pocket place")
	_expect(not extraction_summary.to_lower().contains("inventory"), "Salvage Manifest extraction summary should avoid inventory language")
	var save_before_recent: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main.progression_state.current_run_number = 21
	main.progression_state.current_run_seed = 3021
	main._record_recent_expedition("Extracted", 1)
	var log_text: String = main._format_recent_expedition_log()
	_expect(log_text.contains("#21 Extracted"), "recent expedition log should include Salvage Manifest runs")
	_expect(log_text.contains("route Salvage Pocket"), "Salvage Manifest should produce compact salvage-pocket route memory")
	_expect(not log_text.contains("route Wide Reef Chamber"), "Salvage Pocket memory should take priority over upstream wide chamber memory")
	_expect(main._latest_recent_route_memory() == "Salvage Pocket", "latest route helper should expose Salvage Pocket after manifest evidence")
	_expect(main.progression_state.to_save_data() == save_before_recent, "Salvage Pocket recent route memory should remain session-only")
	_expect(not main.progression_state.to_save_data().has("salvage_pocket_route"), "recent Salvage Pocket memory should not create durable route state")
	main.call("_reset_run_telemetry")
	_expect(not main.run_salvage_manifest_recovered, "Salvage Manifest should reset between expeditions")
	_expect(manifest_core.color.a >= 0.7, "Salvage Manifest should become visible again after expedition reset")
	_expect(manifest_spark.visible, "Salvage Manifest spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_salvage_manifest_research_callout() == "", "Salvage Manifest result line should stay hidden before payoff recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Salvage Manifest"), "Salvage Manifest extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_salvage_pocket_silt_timing_cue_visual_only() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_salvage_silt_timing_alpha", 0.0)
	var high_alpha: float = main.call("_salvage_silt_timing_alpha", MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.25)
	var repeat_alpha: float = main.call("_salvage_silt_timing_alpha", MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.5)
	_expect(high_alpha > low_alpha, "Salvage silt timing cue alpha should pulse upward to suggest a safe read window")
	_expect(is_equal_approx(low_alpha, repeat_alpha), "Salvage silt timing cue pulse should repeat smoothly")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	scene_main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	scene_main.call("_sync_salvage_pocket_open_state")
	var opened_lane := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	var wake := opened_lane.get_node("SiltTimingWake") as Polygon2D
	var window := opened_lane.get_node("SiltTimingWindow") as Polygon2D
	var tick := opened_lane.get_node("SiltTimingTickA") as Polygon2D
	var manifest_core := opened_lane.get_node("SalvageManifest/ManifestCore") as Polygon2D
	var return_cue := opened_lane.get_node("ReturnCurrentCue") as Polygon2D
	scene_main.dive_session.reset(26.0)
	scene_main.dive_session.start()
	scene_main.dive_session.current_cargo.append("shell_fragments")
	var save_before: Dictionary = scene_main.progression_state.to_save_data().duplicate(true)

	scene_main.call("_update_salvage_silt_timing_cue", MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.25)
	_expect(opened_lane.visible, "Salvage silt timing cue should live in the opened pocket lane")
	_expect(window.color.b > window.color.g and window.color.b > window.color.r, "Salvage silt timing window should use pale silt timing color instead of safe-current green")
	_expect(return_cue.color.g > window.color.g, "Salvage safe-return cue should stay visually distinct from the timing window")
	_expect(wake.color.a <= 0.15 and window.color.a <= 0.17 and tick.color.a <= 0.23, "Salvage silt timing cue should stay subtle and non-blocking")
	_expect(window.color.a < manifest_core.color.a, "Salvage silt timing cue should not read as the main salvage payoff")
	_expect(is_equal_approx(scene_main.dive_session.oxygen, 26.0), "Salvage silt timing cue should not drain oxygen")
	_expect(scene_main.dive_session.current_cargo == ["shell_fragments"], "Salvage silt timing cue should not mutate cargo")
	_expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Salvage silt timing cue should not change dive result")
	_expect(scene_main.progression_state.to_save_data() == save_before, "Salvage silt timing cue should not mutate durable progression")
	_expect(opened_lane.find_child("PressureBoundary", true, false) == null, "Salvage silt timing cue should not add hidden pressure behavior")
	_expect(opened_lane.find_child("Predator", true, false) == null, "Salvage silt timing cue should not add combat pressure")
	scene_main.queue_free()

func _test_tideglass_sample_interaction() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_tideglass_sample = true
	main.dive_session.oxygen = 21.0
	main.dive_session.current_cargo.append("shell_fragments")
	var sample_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo") as Polygon2D
	var sample_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D
	var sample_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark") as Polygon2D
	main.call("_sync_tideglass_sample_state")
	_expect(sample_core.color.a >= 0.7, "Tideglass Sample should start visibly recoverable")
	_expect(sample_spark.visible, "Tideglass Sample spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Tideglass"), "Tideglass proximity should own the active dive prompt")
	_expect(prompt.contains("Tideglass"), "Tideglass prompt should name the concrete knowledge payoff")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_tideglass_sample_interaction")
	_expect(handled, "Tideglass Sample should handle interact while nearby during a dive")
	_expect(main.run_tideglass_sample_recovered, "Tideglass Sample interaction should record one run-scoped sample")
	_expect(main.run_reached_dusk_trench, "Tideglass Sample recovery should count as meaningful lower-route reach evidence")
	_expect(sample_halo.color.a <= 0.08, "Tideglass Sample halo should visibly dim after recovery")
	_expect(sample_core.color.a <= 0.2, "Tideglass Sample core should visibly dim after recovery")
	_expect(not sample_spark.visible, "Tideglass Sample spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 21.0), "Tideglass Sample should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Tideglass Sample should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	_expect(save_after == save_before, "Tideglass Sample should not mutate durable progression")
	_expect(not save_after.has("tideglass_sample"), "Tideglass Sample should not create durable sample state")
	_expect(not save_after.has("mirror_kelp_pass"), "Mirror Kelp Pass payoff should not create durable route state")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Tideglass Sample interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("Wide Reef"), "Tideglass status should keep broad return language")
		_expect(main.status_label.text.contains("Mirror Kelp"), "Tideglass status should name the branch payoff")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Tideglass status")

	var repeat_handled: bool = main.call("_try_tideglass_sample_interaction")
	_expect(repeat_handled, "Tideglass Sample should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Tideglass repeat interaction should not duplicate the payoff")

	main.player_near_tideglass_sample = false
	var not_handled: bool = main.call("_try_tideglass_sample_interaction")
	_expect(not not_handled, "Tideglass Sample should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_tideglass_sample_research_callout")
	_expect(callout.contains("Tideglass Sample"), "Tideglass result memory should name the recovered sample")
	_expect(callout.contains("Mirror Kelp"), "Tideglass result memory should name the branch context")
	_expect(callout.contains("return-current"), "Tideglass result memory should explain why the sample mattered")
	_expect_no_echo_lens_locator_language(callout, "Tideglass result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Tideglass Sample"), "Tideglass extraction summary should include recovered sample memory")
	_expect(extraction_summary.contains("Mirror Kelp"), "Tideglass extraction summary should keep the branch payoff readable")
	_expect(not extraction_summary.to_lower().contains("inventory"), "Tideglass extraction summary should avoid inventory language")
	main.call("_reset_run_telemetry")
	_expect(not main.run_tideglass_sample_recovered, "Tideglass Sample should reset between expeditions")
	_expect(sample_core.color.a >= 0.7, "Tideglass Sample should become visible again after expedition reset")
	_expect(sample_spark.visible, "Tideglass Sample spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_tideglass_sample_research_callout() == "", "Tideglass result line should stay hidden before payoff recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Tideglass Sample"), "Tideglass extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_glassfin_swarm_spacing_cue_visual_only() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_glassfin_swarm_spacing_alpha", 0.0)
	var high_alpha: float = main.call("_glassfin_swarm_spacing_alpha", MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.25)
	var repeat_alpha: float = main.call("_glassfin_swarm_spacing_alpha", MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.5)

	_expect(high_alpha > low_alpha, "Glassfin Swarm spacing cue alpha should pulse upward to suggest a pass window")
	_expect(is_equal_approx(low_alpha, repeat_alpha), "Glassfin Swarm spacing cue pulse should repeat smoothly")

	main.dive_session.reset(24.0)
	main.dive_session.start()
	main.dive_session.current_cargo.append("glow_plankton")
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.call("_update_glassfin_swarm_spacing_cue", 0.8)
	_expect(is_equal_approx(main.dive_session.oxygen, 24.0), "Glassfin Swarm spacing cue should not drain oxygen")
	_expect(main.dive_session.current_cargo == ["glow_plankton"], "Glassfin Swarm spacing cue should not change carried cargo")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Glassfin Swarm spacing cue should not change dive result")
	_expect(main.progression_state.to_save_data() == save_before, "Glassfin Swarm spacing cue should not mutate progression")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	var swarm := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm") as Area2D
	var window := swarm.get_node("SpacingWindowPulse") as Polygon2D
	var wake := swarm.get_node("SpacingWake") as Polygon2D
	var tick_a := swarm.get_node("SpacingTickA") as Polygon2D
	var return_gap := swarm.get_node("ReturnGapCue") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var resource_glimmer := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D

	scene_main.call("_update_glassfin_swarm_spacing_cue", MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.25)
	_expect(window.color.b > window.color.g and window.color.b > window.color.r, "Glassfin Swarm spacing window should use pale blue timing color instead of safe-current green")
	_expect(wake.color.b > wake.color.g, "Glassfin Swarm wake should stay bluer than green return-current language")
	_expect(tick_a.color.a <= 0.25 and window.color.a <= 0.19, "Glassfin Swarm spacing cue should stay readable without becoming a hard wall")
	_expect(return_current.color.g > window.color.g, "Glassfin Swarm safe-return current should stay greener than the spacing cue")
	_expect(window.color.b > resource_glimmer.color.b, "Glassfin Swarm spacing cue should stay distinct from yellow-green resource glimmers")
	_expect(window.color.r > pressure_shutter.color.r and window.color.g > pressure_shutter.color.g, "Glassfin Swarm spacing cue should stay brighter than pressure-lock language")
	_expect(return_gap.color.a < return_current.color.a, "Glassfin Swarm return gap should remain softer than the main return current")
	_expect(swarm.find_child("CollisionShape2D", true, false) == null, "Glassfin Swarm spacing cue should not add hidden collision")
	_expect(swarm.find_child("PressureBoundary", true, false) == null, "Glassfin Swarm spacing cue should not add pressure behavior")
	_expect(swarm.find_child("Predator", true, false) == null, "Glassfin Swarm spacing cue should not reuse predator behavior")
	scene_main.queue_free()

func _test_lantern_ray_timing_lane_is_visual_only() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var timing_lane := main.get_node("Creatures/LanternRayRoute/TimingLane") as Node2D
	var timing_upper := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneUpper") as Polygon2D
	var timing_lower := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneLower") as Polygon2D
	var timing_tick := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingTickA") as Polygon2D
	var route_lane := main.get_node("Creatures/LanternRayRoute/RouteLane") as Polygon2D
	var blackwater_pressure := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var dusk_low_visibility := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D

	_expect(timing_lane.find_child("CollisionShape2D", true, false) == null, "Lantern Ray timing lane should not add collision or contact punishment")
	_expect(timing_lane.get_node_or_null("InteractZone") == null, "Lantern Ray timing lane should not add an interaction hotspot")
	_expect(timing_lane.get_node_or_null("ResourcePickup") == null, "Lantern Ray timing lane should not add harvest or cargo behavior")
	_expect(timing_lane.get_node_or_null("Predator") == null, "Lantern Ray timing lane should not reuse predator behavior")
	_expect(timing_lane.get_node_or_null("PressureBoundary") == null, "Lantern Ray timing lane should not add a pressure gate")
	_expect(timing_upper.color.b >= timing_upper.color.r and timing_upper.color.r > timing_upper.color.g, "Lantern Ray timing lane should use pale timing color instead of safe-current green")
	_expect(timing_upper.color.g < route_lane.color.g, "Lantern Ray timing lane should stay distinct from the creature route-current lane")
	_expect(timing_upper.color.r > blackwater_pressure.color.r and timing_upper.color.g > blackwater_pressure.color.g, "Lantern Ray timing lane should be brighter than Blackwater pressure language")
	_expect(timing_upper.color.r > dusk_low_visibility.color.r and timing_upper.color.g > dusk_low_visibility.color.g, "Lantern Ray timing lane should be brighter than Dusk low-visibility pressure language")
	_expect(timing_upper.color.a <= 0.18 and timing_lower.color.a <= 0.14 and timing_tick.color.a <= 0.24, "Lantern Ray timing lane should remain readable without becoming a hard hazard wall")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.add_cargo("kelp_fiber")
	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades["pressure_seal_1"] = true
	main.progression_state.add_discovery("lantern_ray", "Lantern Ray", "Passive route creature.", "Watch the timing lane.")
	main.run_completed_scans.append("lantern_ray")
	main.current_predator_route_id = "test_route"
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()
	var bank_before: Dictionary = main.progression_state.banked_resources.duplicate(true)
	var upgrades_before: Dictionary = main.progression_state.purchased_upgrades.duplicate(true)
	var discoveries_before: Dictionary = main.progression_state.scan_discoveries.duplicate(true)
	var scans_before: Array[String] = main.run_completed_scans.duplicate()
	var route_before: String = main.current_predator_route_id
	var upper_alpha_before: float = timing_upper.color.a

	main.call("_update_lantern_ray_timing_lane", 0.9)
	_expect(not is_equal_approx(timing_upper.color.a, upper_alpha_before), "Lantern Ray timing lane should visibly pulse as a timing cue")
	_expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Lantern Ray timing lane should not secretly drain oxygen")
	_expect(main.dive_session.current_cargo == cargo_before, "Lantern Ray timing lane should not mutate carried cargo")
	_expect(main.progression_state.banked_resources == bank_before, "Lantern Ray timing lane should not mutate banked resources")
	_expect(main.progression_state.purchased_upgrades == upgrades_before, "Lantern Ray timing lane should not mutate upgrades")
	_expect(main.progression_state.scan_discoveries == discoveries_before, "Lantern Ray timing lane should not mutate durable discoveries")
	_expect(main.run_completed_scans == scans_before, "Lantern Ray timing lane should not mutate run scan evidence")
	_expect(main.current_predator_route_id == route_before, "Lantern Ray timing lane should not change seeded creature route state")
	main.queue_free()

func _test_scan_pulse_visual_helper() -> void:
	var idle := ScanPulseVisualScript.idle_modulate()
	var selected := ScanPulseVisualScript.selected_modulate()
	var pulse_a := ScanPulseVisualScript.tactical_highlight_modulate(0)
	var pulse_b := ScanPulseVisualScript.tactical_highlight_modulate(180)

	_expect(idle == Color.WHITE, "scan pulse idle color should be neutral")
	_expect(selected.r > idle.r and selected.g > idle.g, "selected scan pulse color should brighten the pickup")
	_expect(pulse_a != pulse_b, "tactical highlight should pulse instead of becoming a static marker")
	_expect(pulse_a.a == 1.0 and pulse_b.a == 1.0, "tactical highlight should stay a local modulate, not a hidden marker")

func _test_sprite_ready_scene_asset_slots() -> void:
	var main := MainScene.instantiate()
	var required_paths := [
		"ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/KelpFiber/Visuals/FallbackVisual/Visual",
		"ResourcePickups/KelpFiber/CollisionShape2D",
		"ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/ShellFragments/Visuals/FallbackVisual/Visual",
		"ResourcePickups/ShellFragments/CollisionShape2D",
		"ResourcePickups/GlowPlankton/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/GlowPlankton/Visuals/FallbackVisual/Visual",
		"ResourcePickups/HiddenGlowPlankton/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/DeepGlowPlankton/Visuals/SpriteAnchor/Sprite",
		"Creatures/LanternFry/SpriteAnchor/Sprite",
		"Creatures/LanternFry/FallbackVisual/Visual",
		"Creatures/LanternFry/FallbackVisual/Glow",
		"Creatures/LanternFry/ScanMarker",
		"Creatures/LanternFry/CollisionShape2D",
		"Creatures/LanternRayRoute/RouteLane",
		"Creatures/LanternRayRoute/TimingLane/TimingLaneUpper",
		"Creatures/LanternRayRoute/TimingLane/TimingLaneLower",
		"Creatures/LanternRayRoute/TimingLane/TimingTickA",
		"Creatures/LanternRayRoute/TimingLane/TimingTickB",
		"Creatures/LanternRayRoute/RayBody",
		"Creatures/LanternRayRoute/RayWingLeft",
		"Creatures/LanternRayRoute/EyeFleck",
		"Creatures/LanternRayRoute/ScanMarker",
		"Creatures/LanternRayRoute/CollisionShape2D",
		"Predators/GulperEel/SpriteAnchor/Sprite",
		"Predators/GulperEel/FallbackVisual/Body",
		"Predators/GulperEel/FallbackVisual/Eye",
		"Predators/GulperEel/PatrolHint",
		"Predators/GulperEel/ScanMarker",
		"Predators/GulperEel/CollisionShape2D",
		"ShellReefPocket/Visuals/SpriteAnchor/Sprite",
		"ShellReefPocket/Visuals/FallbackGeometry/ReefShelf",
		"ThermalVentPocket/Visuals/SpriteAnchor/Sprite",
		"ThermalVentPocket/Visuals/FallbackGeometry/WarmWash",
		"PressureLockedWreck/Visuals/SpriteAnchor/Sprite",
		"PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureShimmer",
		"PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLabel",
		"PressureLockedWreck/OuterScan/SpriteAnchor/Sprite",
		"PressureLockedWreck/OuterScan/FallbackVisual/ScanVisual",
		"PressureLockedWreck/OuterScan/ScanMarker",
		"PressureLockedWreck/OuterScan/CollisionShape2D",
		"PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite",
		"PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual",
		"PressureLockedWreck/WreckSignalCache/ScanMarker",
		"PressureLockedWreck/WreckSignalCache/EchoPulse",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/SpriteAnchor/Sprite",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim",
		"WreckEchoDescent/RouteWash",
		"WreckEchoDescent/RibA",
		"WreckEchoDescent/RibB",
		"WreckEchoDescent/ClueTrigger/ClueCore",
		"WreckEchoDescent/ClueTrigger/EchoRing",
		"WreckEchoDescent/ClueTrigger/CollisionShape2D",
		"RareSignalEmphasis/SoftPingWash",
		"RareSignalEmphasis/BrokenEchoArc",
		"DeepRewardLure/SpriteAnchor/Sprite",
		"DeepRewardLure/RewardCore",
		"ShallowMidwaterBackgroundStudy",
		"SurfaceBaseArt/SpriteAnchor/ResearchBoatSprite",
		"SurfaceBaseArt/MoonpoolGuide/MoonpoolWaterlineSprite",
		"SurfaceBaseArt/MoonpoolGuide/LaunchColumn",
		"SurfaceBaseArt/MoonpoolGuide/WaterlineFoam",
		"SurfaceBaseArt/FallbackGeometry/LabMoonpool",
		"Discoveries/ThermalVent/SpriteAnchor/Sprite",
		"Discoveries/ThermalVent/FallbackVisual/Visual",
		"Discoveries/ThermalVent/ScanMarker",
		"Discoveries/ShellReefShelf/SpriteAnchor/Sprite",
		"Discoveries/ShellReefShelf/FallbackVisual/Visual",
		"Discoveries/ShellReefShelf/ScanMarker",
	]

	for path in required_paths:
		_expect(main.get_node_or_null(path) != null, "main scene should keep sprite-ready slot or behavior node: %s" % path)

	var moonpool_sprite := main.get_node("SurfaceBaseArt/MoonpoolGuide/MoonpoolWaterlineSprite") as Sprite2D
	_expect(moonpool_sprite.texture != null, "Surface moonpool/waterline should use the first exported source asset sprite")
	var launch_column := main.get_node("SurfaceBaseArt/MoonpoolGuide/LaunchColumn") as Polygon2D
	var base_zone := main.get_node("BaseZone") as Area2D
	var base_core := main.get_node("BaseZone/BaseCore") as Polygon2D
	var dock_rim := main.get_node("BaseZone/DockRim") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var boat_sprite := main.get_node("SurfaceBaseArt/SpriteAnchor/ResearchBoatSprite") as Sprite2D
	var player_scene := PlayerScene.instantiate()
	root.add_child(player_scene)
	var diver_sprite := player_scene.get_node("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	player_scene.call("_set_swim_sheet_frame", 0)
	_expect(diver_sprite.region_rect.position.x == 0.0, "diver swim idle frame should use the first sprite-sheet cell")
	_expect(diver_sprite.offset.x < 0.0, "diver swim idle frame should apply a small registration offset")
	player_scene.call("_set_swim_sheet_frame", 5)
	_expect(diver_sprite.region_rect.position.x == 5.0 * 362.0, "diver swim final kick frame should use the sixth sprite-sheet cell")
	_expect(diver_sprite.offset.x > 35.0, "diver swim kick frame should compensate generated sheet forward/back drift")
	player_scene.call("_set_swim_sheet_frame", 0)
	player_scene.queue_free()
	_expect(base_zone.global_position.y > boat_sprite.global_position.y + 150.0, "base zone should sit below the boat hull, not inside the boat sprite")
	_expect(scene_player.global_position.y >= base_zone.global_position.y, "player should start in the marked moonpool dock below the boat")
	_expect(base_core.visible, "base dock core should be visible as an extraction marker")
	_expect(dock_rim.visible, "base dock rim should be visible as a loading-dock affordance")
	_expect(base_core.z_index < 0 and dock_rim.z_index < 0, "base dock marker should sit behind the sub, not on top of it")
	_expect(launch_column.color.a >= 0.16, "moonpool launch column should be visible enough to mark the dock route")
	var player_contract := PlayerScript.new()
	_expect(player_contract.world_bounds.position.y >= 240.0, "player top clamp should keep the sub below the boat hull")
	player_contract.free()

	var shallow_midwater_background := main.get_node("ShallowMidwaterBackgroundStudy") as Sprite2D
	_expect(shallow_midwater_background.texture != null, "Shallow/midwater background study should use its exported source asset")
	_expect(shallow_midwater_background.modulate.a <= 0.5, "Shallow/midwater background study should stay subdued behind gameplay cues")

	var glow_sprite := main.get_node("ResourcePickups/GlowPlankton/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var glow_fallback := main.get_node("ResourcePickups/GlowPlankton/Visuals/FallbackVisual") as Node2D
	_expect(glow_sprite.texture != null, "Glow Plankton should use the first exported source asset sprite")
	_expect(not glow_fallback.visible, "Glow Plankton polygon fallback should be hidden while the sprite asset is active")

	var kelp_sprite := main.get_node("ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var kelp_fallback := main.get_node("ResourcePickups/KelpFiber/Visuals/FallbackVisual") as Node2D
	_expect(kelp_sprite.texture != null, "Kelp Fiber should use the first exported source asset sprite")
	_expect(not kelp_fallback.visible, "Kelp Fiber polygon fallback should be hidden while the sprite asset is active")

	var shell_sprite := main.get_node("ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_fallback := main.get_node("ResourcePickups/ShellFragments/Visuals/FallbackVisual") as Node2D
	_expect(shell_sprite.texture != null, "Shell Fragments should use the first exported source asset sprite")
	_expect(not shell_fallback.visible, "Shell Fragments polygon fallback should be hidden while the sprite asset is active")

	var lantern_sprite := main.get_node("Creatures/LanternFry/SpriteAnchor/Sprite") as Sprite2D
	var lantern_body_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Visual") as Polygon2D
	var lantern_glow_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Glow") as Polygon2D
	_expect(lantern_sprite.texture != null, "Lantern Fry should use the first exported source asset sprite")
	_expect(not lantern_body_fallback.visible, "Lantern Fry body polygon should be hidden while the sprite asset is active")
	_expect(lantern_glow_fallback.visible, "Lantern Fry glow fallback should remain available for visual-only idle pulsing")

	var gulper_sprite := main.get_node("Predators/GulperEel/SpriteAnchor/Sprite") as Sprite2D
	var gulper_body_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Body") as Polygon2D
	var gulper_eye_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Eye") as Polygon2D
	_expect(gulper_sprite.texture != null, "Gulper Eel should use the first exported source asset sprite")
	_expect(gulper_body_overlay.visible, "Gulper Eel fallback body should remain available for state tint overlays")
	_expect(gulper_eye_overlay.visible, "Gulper Eel fallback eye should remain available for warning/chase state overlays")

	var thermal_vent_sprite := main.get_node("Discoveries/ThermalVent/SpriteAnchor/Sprite") as Sprite2D
	var thermal_vent_fallback := main.get_node("Discoveries/ThermalVent/FallbackVisual/Visual") as Polygon2D
	var thermal_vent_bubbles := main.get_node("Discoveries/ThermalVent/FallbackVisual/Bubbles") as Polygon2D
	_expect(thermal_vent_sprite.texture != null, "Thermal Vent should use the first exported source asset sprite")
	_expect(thermal_vent_fallback.visible, "Thermal Vent fallback geometry should remain available for optional route readability")
	_expect(thermal_vent_bubbles.visible, "Thermal Vent bubbles should remain available for condition/readability visuals")

	var shell_reef_pocket_sprite := main.get_node("ShellReefPocket/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_pocket_fallback := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefShelf") as Polygon2D
	_expect(shell_reef_pocket_sprite.texture != null, "Shell Reef pocket should use the first exported source landmark asset")
	_expect(shell_reef_pocket_fallback.visible, "Shell Reef pocket fallback geometry should remain available for route readability")

	var shell_reef_shelf_sprite := main.get_node("Discoveries/ShellReefShelf/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_shelf_fallback := main.get_node("Discoveries/ShellReefShelf/FallbackVisual/Visual") as Polygon2D
	_expect(shell_reef_shelf_sprite.texture != null, "Shell Reef Shelf scan target should use the first exported source asset sprite")
	_expect(shell_reef_shelf_fallback.visible, "Shell Reef Shelf fallback should remain available for scan clue readability")

	var wreck_cache_sprite := main.get_node("PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite") as Sprite2D
	var wreck_cache_fallback := main.get_node("PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual") as Polygon2D
	var wreck_cache_echo_pulse := main.get_node("PressureLockedWreck/WreckSignalCache/EchoPulse") as Sprite2D
	_expect(wreck_cache_sprite.texture != null, "Wreck Signal Cache should use the first exported source asset sprite")
	_expect(wreck_cache_fallback.visible, "Wreck Signal Cache fallback glow should remain available for scan/mystery readability")
	_expect(wreck_cache_echo_pulse.texture != null, "Wreck Signal Cache should have the scan/echo pulse sprite available for Echo Lens I")
	_expect(not wreck_cache_echo_pulse.visible, "Echo Lens I pulse should start hidden so it reads as temporary local feedback")

	var pressure_wreck_scan_sprite := main.get_node("PressureLockedWreck/OuterScan/SpriteAnchor/Sprite") as Sprite2D
	var pressure_wreck_scan_fallback := main.get_node("PressureLockedWreck/OuterScan/FallbackVisual/ScanVisual") as Polygon2D
	_expect(pressure_wreck_scan_sprite.texture != null, "Pressure-Locked Research Wreck outside scan should use the first exported source asset sprite")
	_expect(pressure_wreck_scan_fallback.visible, "Pressure-Locked Research Wreck outside scan fallback should remain available for pressure clue readability")

	var hollow_reef_sprite := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/SpriteAnchor/Sprite") as Sprite2D
	var hollow_reef_mouth_fallback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow") as Polygon2D
	var hollow_reef_rim_fallback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim") as Polygon2D
	_expect(hollow_reef_sprite.texture == null, "Hollow Reef cave source-art slot should not require imported texture metadata yet")
	_expect(hollow_reef_sprite.get_meta("source_art_path", "") == "res://assets/source/sprites/landmark_hollow_reef_cave_sprite_v1.svg", "Hollow Reef cave slot should document its editable source path")
	_expect(hollow_reef_sprite.get_meta("export_art_path", "") == "res://assets/exports/sprites/landmark_hollow_reef_cave_sprite_v1.svg", "Hollow Reef cave slot should document its runtime export path")
	_expect(hollow_reef_sprite.get_meta("provenance_path", "") == "res://assets/licenses/landmark_hollow_reef_cave_sprite_v1.txt", "Hollow Reef cave slot should document its provenance path")
	_expect(hollow_reef_sprite.modulate.a <= 0.55, "Hollow Reef cave sprite slot should be ready to support readability without overpowering fallback geometry")
	_expect(hollow_reef_mouth_fallback.visible and hollow_reef_mouth_fallback.color.a >= 0.65, "Hollow Reef cave mouth fallback should remain available and readable")
	_expect(hollow_reef_rim_fallback.visible, "Hollow Reef rim fallback should remain available for current route readability")

	var midwater_shelf := main.get_node("MidwaterShelf") as Polygon2D
	var midwater_wreck := main.get_node("MidwaterWreckSilhouette") as Polygon2D
	var deep_pressure_haze := main.get_node("DeepPressureHaze") as Polygon2D
	_expect(midwater_shelf.color.a <= 0.36, "lower-route shelf wash should stay behind core gameplay signals")
	_expect(midwater_wreck.color.a <= 0.24, "lower-route wreck silhouette should not compete with pressure/cache markers")
	_expect(deep_pressure_haze.color.a <= 0.06, "deep pressure haze should stay subtle behind route signals")

	var reef_landmark_wash := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/LandmarkWash") as Polygon2D
	var reef_shelf := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefShelf") as Polygon2D
	var reef_fan := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ShellFanA") as Polygon2D
	var reef_current := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefReturnCurrent") as Polygon2D
	_expect(reef_landmark_wash.color.a <= 0.14, "Shell Reef landmark wash should stay subdued in the lower-route stack")
	_expect(reef_shelf.color.a <= 0.38, "Shell Reef shelf fallback should support the sprite without becoming the loudest shape")
	_expect(reef_fan.color.a <= 0.5, "Shell Reef fan fallback should not overpower pressure/cache/reward reads")
	_expect(reef_current.color.a <= 0.18, "Shell Reef return current should remain a soft route cue")

	var pressure_shimmer := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureShimmer") as Polygon2D
	var pressure_gate_bar := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBarA") as Polygon2D
	var pressure_badge := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLockBadge") as Polygon2D
	_expect(pressure_shimmer.color.a <= 0.36, "pressure shimmer fill should be quieter than the lock badge")
	_expect(pressure_gate_bar.color.a <= 0.42, "pressure gate bars should not create a dominant lower-route wall")
	_expect(pressure_badge.color.a >= 0.7, "pressure lock badge should remain the readable blocked-route marker")

	var reward_core := main.get_node("DeepRewardLure/RewardCore") as Polygon2D
	var reward_bloom := main.get_node("DeepRewardLure/DistantBloom") as Polygon2D
	var reward_particles := main.get_node("DeepRewardLure/LureParticles") as Polygon2D
	var reward_sprite := main.get_node("DeepRewardLure/SpriteAnchor/Sprite") as Sprite2D
	_expect(reward_sprite.texture != null, "deep reward lure should use the selected exported source asset")
	_expect(reward_sprite.modulate.a >= 0.85, "deep reward lure sprite should carry the main reward read")
	_expect(reward_core.color.a <= 0.24, "deep reward fallback core should stay subordinate to the source asset")
	_expect(reward_bloom.color.a <= 0.08, "deep reward bloom should not wash over Shell Reef and predator signals")
	_expect(reward_particles.color.a <= 0.08, "deep reward particles should remain secondary to the reward sprite")

	var cache_visual := main.get_node("PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual") as Polygon2D
	var cache_marker := main.get_node("PressureLockedWreck/WreckSignalCache/ScanMarker") as Polygon2D
	var rare_signal_wash := main.get_node("RareSignalEmphasis/SoftPingWash") as Polygon2D
	_expect(cache_visual.color.a <= 0.34, "Wreck Signal Cache fallback should not overpower the cache sprite")
	_expect(cache_marker.color.a <= 0.18, "Wreck Signal Cache scan marker should stay compact until selected")
	_expect(rare_signal_wash.color.a <= 0.04, "Rare Signal condition wash should be atmospheric, not a route marker")

	var warning_ribs := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var warning_current := main.get_node("Predators/PredatorWarning/WarningCurrent") as Polygon2D
	var warning_marker := main.get_node("Predators/PredatorWarning/WarningMarker") as Polygon2D
	_expect(warning_ribs.color.a <= 0.12, "predator warning ribs should frame danger without filling the route")
	_expect(warning_current.color.a <= 0.08, "predator warning current should be a soft lane cue")
	_expect(warning_marker.color.a >= 0.65, "predator warning marker should remain the primary hazard read")
	_expect(gulper_body_overlay.color.a <= 0.46, "Gulper overlay body should tint the sprite without becoming a second opaque predator")
	_expect(gulper_eye_overlay.color.a >= 0.78, "Gulper overlay eye should keep the predator state readable")
	_expect(PredatorScript.BODY_OVERLAY_ALPHA <= 0.46, "runtime Gulper body overlays should stay translucent across predator states")
	_expect(PredatorScript.EYE_OVERLAY_ALPHA >= 0.78, "runtime Gulper eye overlays should stay readable across predator states")
	var camera := main.get_node("Player/Camera2D") as Camera2D
	_expect(camera.zoom.x <= 0.75 and camera.zoom.y <= 0.75, "starter diver camera should pull back for more exploration space")

	main.free()

	var player := PlayerScene.instantiate()
	var player_required_paths := [
		"VisualRoot/SubSpriteAnchor/SubSprite",
		"VisualRoot/SubSpriteAnchor/Body",
		"VisualRoot/SubSpriteAnchor/Viewport",
		"VisualRoot/NoseLight",
		"VisualRoot/BubbleTrail",
		"VisualRoot/ThrustFlare",
	]

	for path in player_required_paths:
		_expect(player.get_node_or_null(path) != null, "player scene should keep sprite-ready visual slot or fallback node: %s" % path)

	var player_sprite := player.get_node("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	var player_texture_path := player_sprite.texture.resource_path if player_sprite.texture != null else ""
	_expect(player_texture_path.ends_with("player_diver_swim_sheet_v1.png"), "starter player sprite should use the preferred animated diver sheet")
	_expect(player_sprite.region_enabled, "starter player sprite should read one swim-sheet frame at a time")
	_expect(player_sprite.region_rect.size == Vector2(362.0, 724.0), "starter player sprite frame size should match the six-frame sheet")
	_expect(player_sprite.scale.x <= 0.24 and player_sprite.scale.y <= 0.24, "starter diver sprite should stay small enough for exploration framing")
	var collision_shape := player.get_node("CollisionShape2D") as CollisionShape2D
	var capsule_shape := collision_shape.shape as CapsuleShape2D
	_expect(capsule_shape != null and capsule_shape.radius <= 10.0 and capsule_shape.height <= 30.0, "starter diver collision should be smaller than the old sub body")
	player.free()

func _test_east_shelf_spur_branch_scene_contract() -> void:
	var main := MainScene.instantiate()
	var branch_paths := [
		"EastShelfSpur",
		"EastShelfSpur/BranchMouthShadow",
		"EastShelfSpur/BranchRimFrame",
		"EastShelfSpur/BranchRouteOpening",
		"EastShelfSpur/ApproachCurrent",
		"EastShelfSpur/UpperShelfSilhouette",
		"EastShelfSpur/LowerShelfSilhouette",
		"EastShelfSpur/RouteGapCue",
		"EastShelfSpur/RouteRibA",
		"EastShelfSpur/RouteRibB",
		"EastShelfSpur/CurrentSurgeLane",
		"EastShelfSpur/CurrentSurgeRib",
		"EastShelfSpur/EastShelfArch",
		"EastShelfSpur/EastShelfArch/ArchSpan",
		"EastShelfSpur/EastShelfArch/LeftPillar",
		"EastShelfSpur/EastShelfArch/RightPillar",
		"EastShelfSpur/EastShelfArch/ReturnCurrentLeft",
		"EastShelfSpur/EastShelfArch/ReturnRib",
		"RouteChoiceBand",
		"RouteChoiceBand/DecisionRib",
		"RouteChoiceBand/SafeBankLane",
		"RouteChoiceBand/ResearchLane",
		"RouteChoiceBand/SafeBankLabel",
		"RouteChoiceBand/ResearchLabel",
		"EastShelfSpur/ShelfGlimmerOpportunity",
		"EastShelfSpur/ShelfGlimmerOpportunity/SignalWash",
		"EastShelfSpur/ShelfGlimmerOpportunity/GlimmerCore",
		"EastShelfSpur/ShelfGlimmerOpportunity/CurrentThread",
		"EastShelfSpur/TerminalPocketHint",
		"EastShelfSpur/PocketEntrance",
		"EastShelfSpur/PocketEntrance/MouthShadow",
		"EastShelfSpur/PocketEntrance/CaveBackWall",
		"EastShelfSpur/PocketEntrance/OuterRim",
		"EastShelfSpur/PocketEntrance/ForegroundShelfLip",
		"EastShelfSpur/PocketEntrance/LandmarkSpireA",
		"EastShelfSpur/PocketEntrance/LandmarkSpireB",
		"EastShelfSpur/PocketEntrance/InteriorGlowPool",
		"EastShelfSpur/PocketEntrance/SignalCore",
		"EastShelfSpur/PocketEntrance/SignalCore/CoreHalo",
		"EastShelfSpur/PocketEntrance/SignalCore/CoreGem",
		"EastShelfSpur/PocketEntrance/SignalCore/CoreSpark",
		"EastShelfSpur/PocketEntrance/ThresholdGlow",
		"EastShelfSpur/PocketEntrance/ExitCurrentCue",
		"EastShelfSpur/PocketEntrance/InteractZone",
		"EastShelfSpur/PocketEntrance/InteractZone/CollisionShape2D",
		"EastShelfSpur/SealedShelfHatch",
		"EastShelfSpur/SealedShelfHatch/HatchPlate",
		"EastShelfSpur/SealedShelfHatch/SealBars",
		"EastShelfSpur/SealedShelfHatch/EchoShimmer",
		"EastShelfSpur/SealedShelfHatch/LockBadge",
		"EastShelfSpur/SealedShelfHatch/LockLabel",
		"EastShelfSpur/DeepRoutePromise",
		"EastShelfSpur/DeepRoutePromise/PromiseMouth",
		"EastShelfSpur/DeepRoutePromise/PressureWash",
		"EastShelfSpur/DeepRoutePromise/SealLip",
		"EastShelfSpur/DeepRoutePromise/DepthGlint",
		"EastShelfSpur/DeepRoutePromise/PromiseLabel",
		"EastShelfSpur/ResonanceAlcove",
		"EastShelfSpur/ResonanceAlcove/AlcoveMouth",
		"EastShelfSpur/ResonanceAlcove/AlcoveRim",
		"EastShelfSpur/ResonanceAlcove/AlcoveGlow",
		"EastShelfSpur/ResonanceAlcove/ReturnCurrentCue",
		"EastShelfSpur/ResonanceAlcove/InteractZone",
		"EastShelfSpur/ResonanceAlcove/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector",
		"EastShelfSpur/ShelfDropConnector/ConnectorMouth",
		"EastShelfSpur/ShelfDropConnector/UpperDropShelf",
		"EastShelfSpur/ShelfDropConnector/LowerDropShelf",
		"EastShelfSpur/ShelfDropConnector/DownCurrentThread",
		"EastShelfSpur/ShelfDropConnector/DropArch",
		"EastShelfSpur/ShelfDropConnector/DropArch/ArchSpan",
		"EastShelfSpur/ShelfDropConnector/DropArch/LeftPillar",
		"EastShelfSpur/ShelfDropConnector/DropArch/RightPillar",
		"EastShelfSpur/ShelfDropConnector/DropArch/ReturnCurrentUpLeft",
		"EastShelfSpur/ShelfDropConnector/DropArch/ReturnRib",
		"EastShelfSpur/ShelfDropConnector/DropEchoOpportunity",
		"EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/SignalWash",
		"EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/EchoCore",
		"EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/InteractZone",
		"EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector/TurnbackPocketHint",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketRim",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketFloor",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimney",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimney/ChimneyColumn",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimney/ChimneyCrown",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ReverseDraftReturn",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity/SignalWash",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity/SignalCore",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ClosedLowerCrack",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/SiltVeinRibs",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LeftBranchHint",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/RightBranchHint",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkTurnbackLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/NookMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/LanternGlow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/SiltShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/ReturnCurrentCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/InteractZone",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/InteractZone",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillBackWater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillFloor",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TurnbackRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillEndSeal",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/TrenchMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/OpenWaterWindow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/UpperTrenchRim",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowerTrenchShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/ReturnCurrentUpLeft",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/FarTurnbackShadow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/CalmPocketWater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/GlassKelpFrondA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/GlassKelpFrondB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReturnCurrentToTrench",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingHalo",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ThresholdWater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefToothA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefToothB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnCurrentToTrench",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitReturnRibbon",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainToDusk",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DuskReturnFleck",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitBackWall",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneBackWater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperLaneShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LowerLaneShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/InteriorDirectionRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnCurrent",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfPocketWater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ChoiceCueRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/DropBackCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketCleft",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketHalo",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneTurnbackLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/EntranceThroat",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ChamberBackwater",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarWallSilhouette",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/TraversalClearBand",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/UpperChamberShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowerChamberShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ForegroundShelfEdge",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassRibSpan",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowCrownShelf",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/OpenWaterWindow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentRibA",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentRibB",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FutureChoiceShadow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/BoundaryWash",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRibbon",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRib",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/CueLabel",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseMouth",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PressureWash",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/SealLip",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseGlint",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseLabel",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone/CollisionShape2D",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/TurnbackLip",
	]
	for path in branch_paths:
		_expect(main.get_node_or_null(path) != null, "East Shelf Spur should keep first side-route branch scene node: %s" % path)

	var branch_mouth := main.get_node("EastShelfSpur/BranchMouthShadow") as Polygon2D
	var branch_rim := main.get_node("EastShelfSpur/BranchRimFrame") as Polygon2D
	var branch_opening := main.get_node("EastShelfSpur/BranchRouteOpening") as Polygon2D
	var route_choice_band := main.get_node("RouteChoiceBand") as Node2D
	var route_choice_rib := main.get_node("RouteChoiceBand/DecisionRib") as Polygon2D
	var safe_bank_lane := main.get_node("RouteChoiceBand/SafeBankLane") as Polygon2D
	var research_lane := main.get_node("RouteChoiceBand/ResearchLane") as Polygon2D
	var safe_bank_label := main.get_node("RouteChoiceBand/SafeBankLabel") as Label
	var research_label := main.get_node("RouteChoiceBand/ResearchLabel") as Label
	var approach_current := main.get_node("EastShelfSpur/ApproachCurrent") as Polygon2D
	var current_surge_lane := main.get_node("EastShelfSpur/CurrentSurgeLane") as Polygon2D
	var current_surge_rib := main.get_node("EastShelfSpur/CurrentSurgeRib") as Polygon2D
	var terminal_hint := main.get_node("EastShelfSpur/TerminalPocketHint") as Polygon2D
	var pocket_entrance := main.get_node("EastShelfSpur/PocketEntrance") as Node2D
	var mouth_shadow := main.get_node("EastShelfSpur/PocketEntrance/MouthShadow") as Polygon2D
	var cave_back_wall := main.get_node("EastShelfSpur/PocketEntrance/CaveBackWall") as Polygon2D
	var foreground_shelf_lip := main.get_node("EastShelfSpur/PocketEntrance/ForegroundShelfLip") as Polygon2D
	var landmark_spire_a := main.get_node("EastShelfSpur/PocketEntrance/LandmarkSpireA") as Polygon2D
	var landmark_spire_b := main.get_node("EastShelfSpur/PocketEntrance/LandmarkSpireB") as Polygon2D
	var interior_glow_pool := main.get_node("EastShelfSpur/PocketEntrance/InteriorGlowPool") as Polygon2D
	var signal_core_halo := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreHalo") as Polygon2D
	var signal_core_gem := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreGem") as Polygon2D
	var signal_core_spark := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreSpark") as Polygon2D
	var exit_current := main.get_node("EastShelfSpur/PocketEntrance/ExitCurrentCue") as Polygon2D
	var sealed_hatch := main.get_node("EastShelfSpur/SealedShelfHatch") as Node2D
	var hatch_lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	var deep_route_promise := main.get_node("EastShelfSpur/DeepRoutePromise") as Node2D
	var deep_route_mouth := main.get_node("EastShelfSpur/DeepRoutePromise/PromiseMouth") as Polygon2D
	var deep_route_wash := main.get_node("EastShelfSpur/DeepRoutePromise/PressureWash") as Polygon2D
	var deep_route_seal := main.get_node("EastShelfSpur/DeepRoutePromise/SealLip") as Polygon2D
	var deep_route_glint := main.get_node("EastShelfSpur/DeepRoutePromise/DepthGlint") as Polygon2D
	var deep_route_label := main.get_node("EastShelfSpur/DeepRoutePromise/PromiseLabel") as Label
	var resonance_alcove := main.get_node("EastShelfSpur/ResonanceAlcove") as Node2D
	var resonance_mouth := main.get_node("EastShelfSpur/ResonanceAlcove/AlcoveMouth") as Polygon2D
	var resonance_glow := main.get_node("EastShelfSpur/ResonanceAlcove/AlcoveGlow") as Polygon2D
	var resonance_return := main.get_node("EastShelfSpur/ResonanceAlcove/ReturnCurrentCue") as Polygon2D
	var connector_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/ConnectorMouth") as Polygon2D
	var connector_current := main.get_node("EastShelfSpur/ShelfDropConnector/DownCurrentThread") as Polygon2D
	var drop_arch := main.get_node("EastShelfSpur/ShelfDropConnector/DropArch") as Node2D
	var drop_arch_return := main.get_node("EastShelfSpur/ShelfDropConnector/DropArch/ReturnCurrentUpLeft") as Polygon2D
	var drop_echo := main.get_node("EastShelfSpur/ShelfDropConnector/DropEchoOpportunity") as Node2D
	var drop_echo_core := main.get_node("EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/EchoCore") as Polygon2D
	var connector_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/TurnbackPocketHint") as Polygon2D
	var blue_chimney_pocket := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket") as Node2D
	var blue_chimney_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketMouth") as Polygon2D
	var blue_chimney_rim := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketRim") as Polygon2D
	var blue_chimney_column := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimney/ChimneyColumn") as Polygon2D
	var reverse_draft_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ReverseDraftReturn") as Polygon2D
	var blue_chimney_signal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity") as Node2D
	var blue_chimney_signal_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity/SignalWash") as Polygon2D
	var blue_chimney_survey_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore") as Node2D
	var blue_chimney_survey_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyHalo") as Polygon2D
	var blue_chimney_survey_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem") as Polygon2D
	var blue_chimney_survey_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark") as Polygon2D
	var blue_chimney_crack := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ClosedLowerCrack") as Polygon2D
	var silt_vein_fork := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork") as Node2D
	var silt_fork_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkMouth") as Polygon2D
	var silt_left_hint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LeftBranchHint") as Polygon2D
	var silt_right_hint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/RightBranchHint") as Polygon2D
	var silt_turnback_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkTurnbackLip") as Polygon2D
	var lantern_silt_nook := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook") as Node2D
	var lantern_nook_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/NookMouth") as Polygon2D
	var lantern_glow := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/LanternGlow") as Polygon2D
	var lantern_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/ReturnCurrentCue") as Polygon2D
	var blackwater_crack := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack") as Node2D
	var blackwater_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth") as Polygon2D
	var blackwater_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash") as Polygon2D
	var blackwater_seal_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip") as Polygon2D
	var blackwater_gate_badge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge") as Polygon2D
	var blackwater_gate_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel") as Label
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var blackwater_sill_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillMouth") as Polygon2D
	var blackwater_sill_floor := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillFloor") as Polygon2D
	var blackwater_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue") as Polygon2D
	var blackwater_return_chain := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainCue") as Polygon2D
	var blackwater_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibA") as Polygon2D
	var blackwater_return_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibB") as Polygon2D
	var blackwater_pressure_shutter := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var blackwater_pressure_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA") as Polygon2D
	var blackwater_pressure_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibB") as Polygon2D
	var blackwater_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillEndSeal") as Polygon2D
	var blackwater_trace_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore") as Node2D
	var blackwater_trace_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo") as Polygon2D
	var blackwater_trace_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem") as Polygon2D
	var blackwater_trace_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark") as Polygon2D
	var blackwater_signal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity") as Node2D
	var blackwater_signal_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash") as Polygon2D
	var blackwater_signal_fleck := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck") as Polygon2D
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D
	var dusk_trench_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/TrenchMouth") as Polygon2D
	var dusk_open_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/OpenWaterWindow") as Polygon2D
	var dusk_lower_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowerTrenchShelf") as Polygon2D
	var dusk_return_current := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/ReturnCurrentUpLeft") as Polygon2D
	var low_visibility_cue := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue") as Node2D
	var low_visibility_veil := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D
	var low_visibility_band := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand") as Polygon2D
	var low_visibility_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA") as Polygon2D
	var glass_kelp_ledge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge") as Node2D
	var glass_kelp_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeMouth") as Polygon2D
	var glass_kelp_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/CalmPocketWater") as Polygon2D
	var glass_kelp_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeShelf") as Polygon2D
	var glass_kelp_frond_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/GlassKelpFrondA") as Polygon2D
	var glass_kelp_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReturnCurrentToTrench") as Polygon2D
	var glass_kelp_reading_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore") as Node2D
	var glass_kelp_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone") as Area2D
	var glass_kelp_reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard") as Polygon2D
	var glass_kelp_reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark") as Polygon2D
	var hollow_reef := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	var hollow_reef_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow") as Polygon2D
	var hollow_reef_rim := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim") as Polygon2D
	var hollow_reef_threshold := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ThresholdWater") as Polygon2D
	var hollow_reef_entrance := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceLip") as Polygon2D
	var hollow_reef_entrance_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceRibA") as Polygon2D
	var hollow_reef_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnCurrentToTrench") as Polygon2D
	var hollow_reef_exit_ribbon := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitReturnRibbon") as Polygon2D
	var hollow_reef_return_chain := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainToDusk") as Polygon2D
	var hollow_reef_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibA") as Polygon2D
	var hollow_reef_return_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibB") as Polygon2D
	var hollow_reef_return_fleck := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DuskReturnFleck") as Polygon2D
	var hollow_reef_exit_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitRib") as Polygon2D
	var hollow_reef_exit_back := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitBackWall") as Polygon2D
	var hollow_reef_interior_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane") as Node2D
	var hollow_lane_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneBackWater") as Polygon2D
	var hollow_lane_upper := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperLaneShelf") as Polygon2D
	var hollow_lane_lower := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LowerLaneShelf") as Polygon2D
	var hollow_lane_direction := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/InteriorDirectionRib") as Polygon2D
	var hollow_lane_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnCurrent") as Polygon2D
	var hollow_lane_return_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnRib") as Polygon2D
	var hollow_upper_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice") as Node2D
	var hollow_upper_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfPocketWater") as Polygon2D
	var hollow_upper_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfLip") as Polygon2D
	var hollow_upper_choice_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ChoiceCueRib") as Polygon2D
	var hollow_upper_drop_back := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/DropBackCue") as Polygon2D
	var hollow_resource_pocket := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket") as Node2D
	var hollow_resource_cleft := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketCleft") as Polygon2D
	var hollow_resource_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketHalo") as Polygon2D
	var hollow_resource_glimmer := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var hollow_lane_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneTurnbackLip") as Polygon2D
	var hollow_wide_chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var hollow_wide_entrance := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/EntranceThroat") as Polygon2D
	var hollow_wide_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ChamberBackwater") as Polygon2D
	var hollow_wide_far_wall := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarWallSilhouette") as Polygon2D
	var hollow_wide_clear_band := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/TraversalClearBand") as Polygon2D
	var hollow_wide_upper := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/UpperChamberShelf") as Polygon2D
	var hollow_wide_lower := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowerChamberShelf") as Polygon2D
	var hollow_wide_foreground := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ForegroundShelfEdge") as Polygon2D
	var hollow_wide_glass_rib_span := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassRibSpan") as Polygon2D
	var hollow_wide_low_crown_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowCrownShelf") as Polygon2D
	var hollow_wide_open_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/OpenWaterWindow") as Polygon2D
	var hollow_wide_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var hollow_wide_return_far := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib") as Polygon2D
	var hollow_wide_return_mid := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain") as Polygon2D
	var hollow_wide_return_entry := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain") as Polygon2D
	var hollow_wide_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentRibA") as Polygon2D
	var hollow_wide_future_choice := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FutureChoiceShadow") as Polygon2D
	var hollow_wide_far_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue") as Node2D
	var hollow_wide_far_boundary := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/BoundaryWash") as Polygon2D
	var hollow_wide_far_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRibbon") as Polygon2D
	var hollow_wide_far_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRib") as Polygon2D
	var hollow_wide_far_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/CueLabel") as Label
	var mirror_kelp_pass := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var mirror_kelp_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassMouth") as Polygon2D
	var mirror_kelp_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater") as Polygon2D
	var mirror_kelp_curtain_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA") as Polygon2D
	var mirror_kelp_curtain_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainB") as Polygon2D
	var mirror_kelp_floor := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassFloorShelf") as Polygon2D
	var mirror_kelp_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/EntryReturnRibbon") as Polygon2D
	var mirror_kelp_loop_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnCurrent") as Polygon2D
	var mirror_kelp_loop_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnRibA") as Polygon2D
	var mirror_kelp_loop_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnRibB") as Polygon2D
	var mirror_kelp_loop_silhouette := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ChamberLoopSilhouette") as Polygon2D
	var mirror_kelp_return_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReturnLabel") as Label
	var mirror_kelp_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassLabel") as Label
	var tideglass_sample := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample") as Node2D
	var tideglass_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo") as Polygon2D
	var tideglass_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D
	var tideglass_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark") as Polygon2D
	var tideglass_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone") as Area2D
	var hollow_deeper_promise := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise") as Node2D
	var hollow_deeper_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseMouth") as Polygon2D
	var hollow_deeper_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PressureWash") as Polygon2D
	var hollow_deeper_seal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/SealLip") as Polygon2D
	var hollow_deeper_glint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseGlint") as Polygon2D
	var hollow_deeper_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseLabel") as Label
	var hollow_reef_reading_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore") as Node2D
	var hollow_reef_reading_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo") as Polygon2D
	var hollow_reef_reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard") as Polygon2D
	var hollow_reef_reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark") as Polygon2D
	var hollow_reef_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone") as Area2D
	var hollow_reef_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/TurnbackLip") as Polygon2D
	var lantern_ray_route := main.get_node("Creatures/LanternRayRoute") as Area2D
	var lantern_ray_lane := main.get_node("Creatures/LanternRayRoute/RouteLane") as Polygon2D
	var lantern_ray_timing_lane := main.get_node("Creatures/LanternRayRoute/TimingLane") as Node2D
	var lantern_ray_timing_upper := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneUpper") as Polygon2D
	var lantern_ray_timing_lower := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneLower") as Polygon2D
	var lantern_ray_timing_tick := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingTickA") as Polygon2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var lantern_ray_wing := main.get_node("Creatures/LanternRayRoute/RayWingLeft") as Polygon2D
	var lantern_ray_eye := main.get_node("Creatures/LanternRayRoute/EyeFleck") as Polygon2D
	var lantern_ray_scan_marker := main.get_node("Creatures/LanternRayRoute/ScanMarker") as Polygon2D
	var lantern_ray_collision := main.get_node("Creatures/LanternRayRoute/CollisionShape2D") as CollisionShape2D
	var blue_chimney_glow_candidate := main.get_node("StarterResourceCandidates/GlowPlankton/BlueChimneyA") as SpawnPoint
	var hollow_reef_glow_candidate := main.get_node("StarterResourceCandidates/GlowPlankton/HollowReefA") as SpawnPoint
	var mirror_kelp_cargo_candidate := main.get_node("StarterResourceCandidates/KelpFiber/MirrorKelpA") as SpawnPoint
	var arch := main.get_node("EastShelfSpur/EastShelfArch") as Node2D
	var arch_return := main.get_node("EastShelfSpur/EastShelfArch/ReturnCurrentLeft") as Polygon2D
	var shelf_glimmer := main.get_node("EastShelfSpur/ShelfGlimmerOpportunity") as Node2D
	var shelf_glimmer_core := main.get_node("EastShelfSpur/ShelfGlimmerOpportunity/GlimmerCore") as Polygon2D
	_expect(branch_mouth.color.a >= 0.5, "East Shelf branch mouth should be dark enough to read as a route opening")
	_expect(branch_rim.color.a >= 0.3, "East Shelf branch rim should visibly frame the route entrance")
	_expect(branch_opening.color.a >= 0.18, "East Shelf branch opening should be more visible than a subtle current hint")
	_expect(route_choice_band.get_node_or_null("InteractZone") == null, "Route Choice Band should not add active interaction or objective UI")
	_expect(route_choice_rib.color.a <= 0.22, "Route Choice Band rib should be readable without becoming a blocking marker")
	_expect(safe_bank_lane.color.g > safe_bank_lane.color.r, "Safe banking lane should use a calmer green route language")
	_expect(research_lane.color.b >= research_lane.color.r, "Research lane should use cyan route language toward East Shelf")
	_expect(safe_bank_lane.polygon[1].x < safe_bank_lane.polygon[0].x, "Safe banking lane should point left/down toward Shell Reef")
	_expect(research_lane.polygon[1].x > research_lane.polygon[0].x, "Research lane should point right toward East Shelf")
	_expect(safe_bank_label.text == "SAFE BANK", "Safe banking label should be broad route language")
	_expect(research_label.text == "RESEARCH ROUTE", "Research label should be broad route language")
	_expect(not safe_bank_label.text.to_lower().contains("objective"), "Route labels should not become checklist language")
	_expect(not research_label.text.to_lower().contains("map"), "Route labels should not imply a minimap or exact locator")
	_expect(approach_current.polygon[1].x >= 1000.0, "East Shelf Spur should branch right of the existing main column while becoming visible earlier")
	_expect(terminal_hint.polygon[terminal_hint.polygon.size() - 1].x >= 1800.0, "East Shelf Spur should reach into the expanded camera space")
	_expect(approach_current.color.a <= 0.18, "East Shelf Spur current cue should stay readable without becoming a hard objective arrow")
	_expect(current_surge_lane.color.a <= 0.18, "East Shelf current-surge lane should read as timing guidance, not a damage wall")
	_expect(current_surge_rib.polygon.size() >= 4, "East Shelf current-surge rib should provide a readable timing tick")
	_expect(arch.position.x >= 1450.0, "East Shelf Arch should sit on the right-side branch before the pocket entrance")
	_expect(arch_return.polygon[1].x < arch_return.polygon[0].x, "East Shelf Arch return current should point left toward the base column")
	_expect(not shelf_glimmer.visible, "Shelf Glimmer opportunity should start hidden until its seeded condition is active")
	_expect(shelf_glimmer_core.color.a <= 0.4, "Shelf Glimmer should read as a subtle opportunity, not a guaranteed major reward")
	_expect(pocket_entrance.position.x >= 1880.0, "East Shelf pocket entrance should sit at the far end of the side route")
	_expect(mouth_shadow.color.a >= 0.6, "East Shelf pocket entrance should read as an opening, not another translucent current")
	_expect(cave_back_wall.color.a >= 0.68, "East Shelf pocket should have a readable cave back wall")
	_expect(foreground_shelf_lip.color.a >= 0.7, "East Shelf pocket should have a foreground shelf lip for destination depth")
	_expect(landmark_spire_a.color.a >= 0.4 and landmark_spire_b.color.a >= 0.3, "East Shelf pocket should include distinct landmark spires")
	_expect(interior_glow_pool.color.a >= 0.2, "East Shelf pocket should include a soft interior glow pool")
	_expect(signal_core_halo.color.a >= 0.3 and signal_core_gem.color.a >= 0.8, "East Shelf pocket should contain a clear visible payoff core")
	_expect(signal_core_spark.visible and signal_core_spark.color.a >= 0.9, "East Shelf pocket payoff should have a bright recoverable spark")
	_expect(exit_current.polygon[1].x < exit_current.polygon[0].x, "East Shelf pocket exit cue should point back left toward the main route")
	_expect(sealed_hatch.position.x >= pocket_entrance.position.x, "Sealed Shelf Hatch should sit at or beyond the pocket entrance as a future promise")
	_expect(hatch_lock_label.text == "ECHO LOCK", "Sealed Shelf Hatch should start as an Echo Lens locked promise")
	_expect(deep_route_promise.position.x > sealed_hatch.position.x, "Deep Route Promise should sit beyond the East Shelf destination")
	_expect(deep_route_promise.position.y > sealed_hatch.position.y, "Deep Route Promise should sit lower than the hatch to imply future depth")
	_expect(deep_route_mouth.color.a >= 0.62, "Deep Route Promise mouth should read as a visible sealed opening")
	_expect(deep_route_wash.color.a <= 0.18, "Deep Route Promise wash should stay atmospheric, not a damage field")
	_expect(deep_route_seal.color.a >= 0.28, "Deep Route Promise should have a readable seal lip")
	_expect(deep_route_glint.color.a >= 0.42, "Deep Route Promise should include a small curiosity glint")
	_expect(deep_route_label.text == "DEEP ROUTE SEALED", "Deep Route Promise label should communicate future route state without objective copy")
	_expect(deep_route_promise.get_node_or_null("InteractZone") == null, "Deep Route Promise should not add active interaction yet")
	_expect(deep_route_promise.get_node_or_null("Interior") == null, "Deep Route Promise should not add a cave interior system")
	_expect(resonance_alcove.position.x > sealed_hatch.position.x, "Resonance Alcove should sit just beyond the sealed hatch")
	_expect(resonance_alcove.position.y <= sealed_hatch.position.y + 80.0, "Resonance Alcove should stay near the hatch rather than becoming a new deep route")
	_expect(resonance_mouth.color.a <= 0.62, "Resonance Alcove mouth should read as a small pocket, not a full biome")
	_expect(resonance_glow.color.a <= 0.22, "Resonance Alcove glow should stay subtle until payoff behavior exists")
	_expect(resonance_return.polygon[1].x < resonance_return.polygon[0].x, "Resonance Alcove return cue should point back left toward East Shelf")
	_expect(resonance_alcove.get_node_or_null("Interior") == null, "Resonance Alcove scaffold should not add a full interior system")
	_expect(connector_mouth.polygon[0].x >= 1880.0, "Shelf Drop Connector should start beyond the East Shelf pocket area")
	_expect(connector_turnback.polygon[connector_turnback.polygon.size() - 1].y >= 2040.0, "Shelf Drop Connector should drop below East Shelf into the lower route space")
	_expect(connector_current.color.a <= 0.12, "Shelf Drop Connector current should stay subtle until route art and payoff exist")
	_expect(drop_arch.position.y >= 1860.0, "Drop Arch should sit inside the lower connector rather than the East Shelf approach")
	_expect(drop_arch_return.polygon[1].x < drop_arch_return.polygon[0].x, "Drop Arch return current should point up-left toward East Shelf and the base column")
	_expect(drop_arch_return.polygon[1].y < drop_arch_return.polygon[0].y, "Drop Arch return current should show upward return direction")
	_expect(drop_echo.position.y >= drop_arch.position.y, "Drop Echo should sit near the lower connector turnback point")
	_expect(drop_echo_core.color.a <= 0.4, "Drop Echo should read as a subtle research ping, not a guaranteed major reward")
	_expect(blue_chimney_pocket.position.x >= drop_arch.position.x, "Blue Chimney Pocket should extend slightly right after Drop Arch")
	_expect(blue_chimney_pocket.position.y > connector_turnback.polygon[connector_turnback.polygon.size() - 1].y, "Blue Chimney Pocket should sit just below the Shelf Drop turnback")
	_expect(blue_chimney_pocket.position.x <= 2180.0, "Blue Chimney Pocket scaffold should stay inside the current bounded route space")
	_expect(blue_chimney_pocket.position.y <= 2260.0, "Blue Chimney Pocket scaffold should stay small until larger route growth is planned")
	_expect(blue_chimney_mouth.color.a <= 0.62, "Blue Chimney Pocket mouth should read as a small pocket, not a full cave network")
	_expect(blue_chimney_rim.polygon.size() <= 14, "Blue Chimney Pocket rim should stay compact and authored")
	_expect(blue_chimney_column.color.b >= blue_chimney_column.color.r, "Blue Chimney landmark should read as a blue local memory anchor")
	_expect(reverse_draft_return.polygon[1].x < reverse_draft_return.polygon[0].x, "Blue Chimney reverse draft should point left toward Drop Arch")
	_expect(reverse_draft_return.polygon[1].y < reverse_draft_return.polygon[0].y, "Blue Chimney reverse draft should point upward toward the return route")
	_expect(reverse_draft_return.color.a <= 0.14, "Blue Chimney reverse draft should stay a soft route cue, not a map marker")
	_expect(not blue_chimney_signal.visible, "Blue Chimney signal opportunity should start hidden until its seeded condition is active")
	_expect(blue_chimney_signal_wash.color.a <= 0.1, "Blue Chimney signal wash should stay subtle, not a guaranteed reward marker")
	_expect(blue_chimney_survey_core.position.x > 0.0, "Blue Chimney survey core should sit inside the lower pocket as a concrete payoff")
	_expect(blue_chimney_survey_halo.color.a >= 0.28, "Blue Chimney survey core should have a readable halo in normal play")
	_expect(blue_chimney_survey_gem.color.a >= 0.7, "Blue Chimney survey core should have a visible recoverable gem")
	_expect(blue_chimney_survey_spark.visible and blue_chimney_survey_spark.color.a >= 0.8, "Blue Chimney survey core should have a bright recovery spark")
	_expect(blue_chimney_survey_core.get_node_or_null("InteractZone") == null, "Blue Chimney survey core should reuse the pocket interaction instead of adding a second hotspot")
	_expect(blue_chimney_crack.color.a >= 0.5, "Blue Chimney Pocket should include a visible closed lower turnback")
	_expect(blue_chimney_pocket.get_node_or_null("Interior") == null, "Blue Chimney Pocket scaffold should not add a full interior system")
	_expect(silt_vein_fork.position.y > blue_chimney_crack.polygon[blue_chimney_crack.polygon.size() - 1].y, "Silt Vein Fork should begin below the Blue Chimney lower crack")
	_expect(silt_vein_fork.position.y <= 190.0, "Silt Vein Fork scaffold should stay compact under Blue Chimney")
	_expect(silt_fork_mouth.color.a <= 0.42, "Silt Vein Fork mouth should stay subtle until branch content exists")
	_expect(silt_left_hint.polygon[2].x < silt_left_hint.polygon[0].x, "Silt Vein Fork left hint should show a readable left branch")
	_expect(silt_right_hint.polygon[2].x > silt_right_hint.polygon[0].x, "Silt Vein Fork right hint should show a readable right branch")
	_expect(silt_right_hint.color.a <= 0.24, "Silt Vein Fork right branch should read as deferred pressure-dark promise")
	_expect(silt_turnback_lip.color.a >= 0.45, "Silt Vein Fork should include a visible lower turnback lip")
	_expect(silt_vein_fork.get_node_or_null("InteractZone") == null, "Silt Vein Fork scaffold should not add payoff interaction yet")
	_expect(silt_vein_fork.get_node_or_null("Interior") == null, "Silt Vein Fork scaffold should not add a cave interior system")
	_expect(lantern_silt_nook.position.x < silt_vein_fork.position.x, "Lantern Silt Nook should sit on the left safe branch")
	_expect(lantern_silt_nook.position.y > 100.0, "Lantern Silt Nook should sit below the fork mouth, not above Blue Chimney")
	_expect(lantern_nook_mouth.color.a <= 0.5, "Lantern Silt Nook mouth should be readable but not a full cave entrance")
	_expect(lantern_glow.color.a <= 0.2, "Lantern Silt Nook glow should stay subtle until payoff exists")
	_expect(lantern_return.polygon[1].x > lantern_return.polygon[0].x, "Lantern Silt Nook return cue should point back toward the fork")
	_expect(lantern_return.polygon[1].y < lantern_return.polygon[0].y, "Lantern Silt Nook return cue should point upward toward the fork")
	_expect(lantern_silt_nook.get_node_or_null("InteractZone") != null, "Lantern Silt Nook should expose the first safe-branch sample interaction")
	_expect(lantern_silt_nook.get_node_or_null("Interior") == null, "Lantern Silt Nook scaffold should not add a multi-room cave")
	_expect(blackwater_crack.position.x > silt_vein_fork.position.x, "Blackwater Crack should sit on the right deferred branch")
	_expect(blackwater_crack.position.y > 120.0, "Blackwater Crack should sit below the fork mouth")
	_expect(blackwater_mouth.color.a >= 0.58, "Blackwater Crack mouth should read as closed deep water")
	_expect(blackwater_wash.color.a <= 0.22, "Blackwater Crack pressure-dark wash should stay atmospheric, not a damage field")
	_expect(blackwater_seal_lip.color.a <= 0.28, "Blackwater Crack seal lip should read as a quiet deferred promise")
	_expect(blackwater_gate_badge.color.a >= 0.48, "Blackwater Crack should visibly present a deliberate route gate")
	_expect(blackwater_gate_label.text == "RESONANCE SEAL", "Blackwater Crack should start with broad preparation gate copy")
	_expect(blackwater_crack.get_node_or_null("InteractZone") != null, "Blackwater Crack should expose a readback hotspot for its gate state")
	_expect(not blackwater_sill.visible, "Blackwater Sill should stay hidden until the scoped gate preparation is ready")
	_expect(blackwater_sill.position.x > blackwater_crack.position.x * 0.5, "Blackwater Sill should extend to the right of the crack as a short route step")
	_expect(blackwater_sill.position.y > 80.0, "Blackwater Sill should sit deeper than the crack mouth")
	_expect(blackwater_sill_mouth.color.a >= 0.6, "Blackwater Sill mouth should read as a deliberate short route when opened")
	_expect(blackwater_sill_floor.color.a >= 0.45, "Blackwater Sill should have a readable local floor silhouette")
	_expect(blackwater_return.polygon[1].x < blackwater_return.polygon[0].x, "Blackwater Sill return cue should point back left toward Silt Vein")
	_expect(blackwater_return.polygon[1].y < blackwater_return.polygon[0].y, "Blackwater Sill return cue should point upward toward Blue Chimney")
	_expect(blackwater_return_chain.polygon[1].x < blackwater_return_chain.polygon[0].x, "Blackwater return chain should point back toward Silt Vein")
	_expect(blackwater_return_chain.polygon[1].y < blackwater_return_chain.polygon[0].y, "Blackwater return chain should point upward toward Blue Chimney")
	_expect(blackwater_return_chain.color.g > blackwater_return_chain.color.r, "Blackwater return chain should use safe-current color language")
	_expect(blackwater_return_rib_a.polygon[1].x < blackwater_return_rib_a.polygon[0].x, "Blackwater first return rib should step left along the chain")
	_expect(blackwater_return_rib_b.polygon[1].y < blackwater_return_rib_b.polygon[0].y, "Blackwater second return rib should step upward along the chain")
	_expect(blackwater_sill.get_node_or_null("ReturnChainCue/InteractZone") == null, "Blackwater return chain should not add interaction or objective state")
	_expect(blackwater_pressure_shutter.color.b > blackwater_pressure_shutter.color.g, "Blackwater pressure cue should use dark violet pressure language, not safe-current green")
	_expect(blackwater_pressure_shutter.color.a >= 0.1 and blackwater_pressure_shutter.color.a <= 0.2, "Blackwater pressure shutter should stay subtle and non-combat")
	_expect(blackwater_pressure_rib_a.color.b > blackwater_pressure_rib_a.color.g, "Blackwater pressure ribs should stay visually distinct from safe return currents")
	_expect(blackwater_pressure_rib_b.color.b > blackwater_pressure_rib_b.color.g, "Blackwater pressure ribs should reinforce local route pressure")
	_expect(blackwater_pressure_shutter.polygon[0].y > blackwater_return_chain.polygon[0].y + 24.0, "Blackwater pressure cue should sit below the return chain instead of covering it")
	_expect(blackwater_sill.get_node_or_null("PressureBoundary") == null, "Blackwater pressure cue should not add a hidden pressure collision boundary")
	_expect(blackwater_turnback.color.a <= 0.3, "Blackwater Sill end should read as a turnback, not a full cave network")
	_expect(blackwater_trace_core.position.x > 0.0, "Blackwater Trace should sit inside the opened short sill route")
	_expect(blackwater_trace_core.position.x > blackwater_return_chain.polygon[0].x, "Blackwater Trace should sit to the right of the return-chain cue")
	_expect(blackwater_trace_core.position.y < blackwater_pressure_shutter.polygon[0].y, "Blackwater Trace should stay visually separate from the lower pressure cue")
	_expect(blackwater_trace_halo.color.a >= 0.28, "Blackwater Trace should have a readable halo in normal play")
	_expect(blackwater_trace_gem.color.a >= 0.7, "Blackwater Trace should have a visible recoverable core")
	_expect(blackwater_trace_spark.visible and blackwater_trace_spark.color.a >= 0.8, "Blackwater Trace should have a bright recovery spark")
	_expect(not blackwater_signal.visible, "Blackwater signal opportunity should start hidden until Rare Signal and route preparation are ready")
	_expect(blackwater_signal.position.y <= -70.0, "Blackwater signal wash should sit above the local route cues instead of covering them")
	_expect(blackwater_signal_wash.color.a <= 0.1, "Blackwater signal wash should stay atmospheric, not a guaranteed reward marker")
	_expect(blackwater_signal_fleck.color.a <= 0.36, "Blackwater signal fleck should stay subtle and optional")
	_expect(blackwater_signal.get_node_or_null("InteractZone") == null, "Blackwater signal nudge should not add a second interaction hotspot")
	_expect(dusk_trench.get_parent() == blackwater_sill, "Dusk Trench should inherit the existing Blackwater route gate")
	_expect(dusk_trench.position.x >= 200.0 and dusk_trench.position.y >= 100.0, "Dusk Trench should continue beyond the Blackwater Sill turnback")
	_expect(dusk_trench_mouth.color.a >= 0.6, "Dusk Trench mouth should read as a deliberate route continuation")
	_expect(dusk_open_water.color.a <= 0.5, "Dusk Trench should include negative open-water space instead of another dense cue pile")
	_expect(dusk_lower_shelf.color.a >= 0.5, "Dusk Trench should have a readable lower shelf silhouette")
	_expect(dusk_return_current.color.a >= 0.18 and dusk_return_current.color.a <= 0.24, "Dusk Trench return current should be stronger after visual evidence without becoming a route arrow")
	_expect(dusk_return_current.polygon[1].x < dusk_return_current.polygon[0].x, "Dusk Trench return current should point back left toward Blackwater")
	_expect(dusk_return_current.polygon[1].y < dusk_return_current.polygon[0].y, "Dusk Trench return current should point upward toward Silt and Blue")
	_expect(low_visibility_cue.get_parent() == dusk_trench, "Dusk Trench low-visibility cue should inherit the existing route gate")
	_expect(low_visibility_cue.scene_file_path.ends_with("DuskLowVisibilityCue.tscn"), "Dusk Trench low-visibility cue should be a reusable readability scene")
	_expect(low_visibility_cue.position.x > 120.0, "Dusk Trench low-visibility cue should sit deeper in the trench instead of covering the return current")
	_expect(low_visibility_veil.color.a >= 0.2 and low_visibility_veil.color.a <= 0.3, "Dusk Trench low-visibility veil should be visible but not a hard hazard wall")
	_expect(low_visibility_veil.color.b > low_visibility_veil.color.g, "Dusk Trench low-visibility cue should use blue-violet pressure language")
	_expect(low_visibility_veil.color.g < dusk_return_current.color.g, "Dusk Trench low-visibility cue should stay distinct from safe-current green")
	_expect(low_visibility_band.color.b > low_visibility_band.color.g, "Dusk Trench silt band should reinforce dark low-visibility language")
	_expect(low_visibility_rib.color.b > low_visibility_rib.color.r, "Dusk Trench silt rib should not read as predator warning red or resource yellow")
	_expect(low_visibility_cue.get_node_or_null("InteractZone") == null, "Dusk Trench low-visibility cue should not add an interaction hotspot")
	_expect(low_visibility_cue.get_node_or_null("PressureBoundary") == null, "Dusk Trench low-visibility cue should not add a hidden pressure or oxygen boundary")
	_expect(low_visibility_cue.find_child("CollisionShape2D", true, false) == null, "Dusk Trench low-visibility cue should not add collision or knockback")
	_expect(dusk_trench.get_node_or_null("InteractZone") == null, "Dusk Trench scaffold should not add an interaction hotspot yet")
	_expect(dusk_trench.get_node_or_null("Interior") == null, "Dusk Trench scaffold should not add a cave interior system")
	_expect(glass_kelp_ledge.get_parent() == dusk_trench, "Glass Kelp Ledge should branch from the Dusk Trench route")
	_expect(glass_kelp_ledge.position.x > 0.0 and glass_kelp_ledge.position.y > 0.0, "Glass Kelp Ledge should sit off the lower trench, not inside Blackwater")
	_expect(glass_kelp_mouth.color.g > glass_kelp_mouth.color.r, "Glass Kelp Ledge should use cooler calm-pocket color language")
	_expect(glass_kelp_mouth.color.a >= 0.6, "Glass Kelp Ledge mouth should read clearly in the staged Dusk evidence")
	_expect(glass_kelp_water.color.a <= 0.3, "Glass Kelp calm water should read as a pause pocket, not a pressure hazard")
	_expect(glass_kelp_shelf.color.a >= 0.55, "Glass Kelp Ledge should have a readable safe shelf silhouette")
	_expect(glass_kelp_frond_a.color.g > glass_kelp_frond_a.color.r, "Glass Kelp fronds should visually distinguish the pocket from Blackwater pressure")
	_expect(glass_kelp_return.color.a >= 0.18 and glass_kelp_return.color.a <= 0.24, "Glass Kelp return current should be readable without becoming a checklist marker")
	_expect(glass_kelp_return.polygon[1].x < glass_kelp_return.polygon[0].x, "Glass Kelp Ledge return current should point back left toward the trench")
	_expect(glass_kelp_return.polygon[1].y < glass_kelp_return.polygon[0].y, "Glass Kelp Ledge return current should point upward toward Blackwater and Silt Vein")
	_expect(glass_kelp_reading_core.position.distance_to(glass_kelp_interact.position) >= 64.0, "Glass Kelp payoff marker should be offset from the hotspot so the sub does not cover it")
	_expect(glass_kelp_reading_shard.color.a >= 0.85, "Glass Kelp reading shard should start visibly recoverable in normal-scale evidence")
	_expect(glass_kelp_reading_spark.visible, "Glass Kelp reading spark should start visible before recovery")
	_expect(glass_kelp_ledge.get_node_or_null("InteractZone") != null, "Glass Kelp Ledge should expose one payoff hotspot")
	_expect(glass_kelp_ledge.get_node_or_null("ResourcePickup") == null, "Glass Kelp Ledge should not add a resource pickup")
	_expect(glass_kelp_ledge.get_node_or_null("Predator") == null, "Glass Kelp Ledge should not add a predator encounter")
	_expect(glass_kelp_ledge.get_node_or_null("PressureBoundary") == null, "Glass Kelp Ledge should not add a hidden pressure or oxygen boundary")
	_expect(hollow_reef.get_parent() == dusk_trench, "Hollow Reef should branch from the Dusk Trench route")
	_expect(hollow_reef.position.x > glass_kelp_ledge.position.x, "Hollow Reef should sit farther along the trench than the calm Glass Kelp ledge")
	_expect(hollow_reef.position.y > glass_kelp_ledge.position.y, "Hollow Reef should sit lower as the first cave-like branch")
	_expect(hollow_reef_mouth.color.a >= 0.65, "Hollow Reef cave mouth should read as explorable dark space")
	_expect(hollow_reef_rim.color.g > hollow_reef_rim.color.r, "Hollow Reef rim should use cool reef/cave color language")
	_expect(hollow_reef_threshold.color.a <= 0.3, "Hollow Reef threshold water should be visible without becoming a hard objective marker")
	_expect(hollow_reef_entrance.color.g > hollow_reef_entrance.color.r and hollow_reef_entrance.color.b > hollow_reef_entrance.color.r, "Hollow Reef entrance lip should read as cool threshold language, not predator or resource color")
	_expect(hollow_reef_entrance.color.a <= 0.3, "Hollow Reef entrance lip should stay quieter than scan targets and pickups")
	_expect(hollow_reef_entrance_rib.color.g > hollow_reef_entrance_rib.color.r, "Hollow Reef entrance rib should stay in safe/cave readability language")
	_expect(hollow_reef_return.color.a >= 0.14 and hollow_reef_return.color.a <= 0.16, "Hollow Reef return current should be readable without becoming checklist guidance")
	_expect(hollow_reef_return.polygon[1].x < hollow_reef_return.polygon[0].x, "Hollow Reef return current should point left back toward Dusk Trench")
	_expect(hollow_reef_return.polygon[1].y < hollow_reef_return.polygon[0].y, "Hollow Reef return current should point upward toward Blackwater and Silt Vein")
	_expect(hollow_reef_exit_ribbon.color.g > hollow_reef_exit_ribbon.color.r, "Hollow Reef exit ribbon should use safe-return color language")
	_expect(hollow_reef_exit_ribbon.color.a <= hollow_reef_return.color.a, "Hollow Reef exit ribbon should support the return current without becoming a second objective arrow")
	_expect(hollow_reef_exit_ribbon.polygon[1].x < hollow_reef_exit_ribbon.polygon[0].x, "Hollow Reef exit ribbon should point back left toward the entrance")
	_expect(hollow_reef_return_chain.color.g > hollow_reef_return_chain.color.r and hollow_reef_return_chain.color.b > hollow_reef_return_chain.color.r, "Hollow Reef return chain should use safe-current color language")
	_expect(hollow_reef_return_chain.color.a >= 0.08 and hollow_reef_return_chain.color.a <= 0.1, "Hollow Reef return chain should stay readable without becoming a route graph")
	_expect(hollow_reef_return_chain.polygon[1].x < hollow_reef_return_chain.polygon[0].x, "Hollow Reef return chain should point left toward Dusk Trench")
	_expect(hollow_reef_return_chain.polygon[1].y < hollow_reef_return_chain.polygon[0].y, "Hollow Reef return chain should point upward toward Blackwater and Silt Vein")
	_expect(hollow_reef_return_rib_a.polygon[1].x < hollow_reef_return_rib_a.polygon[0].x, "Hollow Reef first return rib should step left along the chain")
	_expect(hollow_reef_return_rib_b.polygon[1].y < hollow_reef_return_rib_b.polygon[0].y, "Hollow Reef second return rib should step upward along the chain")
	_expect(hollow_reef_return_fleck.color.a <= 0.3, "Hollow Reef return fleck should be a small landmark cue, not a resource marker")
	_expect(hollow_reef_return_chain.color.g > blackwater_pressure_shutter.color.g, "Hollow Reef return chain should stay distinct from Blackwater pressure color language")
	_expect(hollow_reef_return_chain.get_node_or_null("InteractZone") == null, "Hollow Reef return chain should not add interaction or objective state")
	_expect(hollow_reef_return_chain.find_child("CollisionShape2D", true, false) == null, "Hollow Reef return chain should not add collision, movement, or hidden pressure behavior")
	_expect(hollow_reef_exit_rib.polygon[1].x < hollow_reef_exit_rib.polygon[0].x, "Hollow Reef exit rib should step left toward the exit route")
	_expect(hollow_reef_exit_back.color.a >= 0.45, "Hollow Reef exit back wall should make the current side-cave end readable")
	_expect(hollow_reef_interior_lane.position.x > hollow_reef_reading_core.position.x, "Hollow Reef interior lane should extend beyond the first cave reading payoff")
	_expect(hollow_reef_interior_lane.position.x < hollow_deeper_promise.position.x, "Hollow Reef interior lane should stay before the closed deeper promise")
	_expect(hollow_lane_water.color.a >= 0.45 and hollow_lane_water.color.a <= 0.55, "Hollow Reef interior lane should read as cave water without hiding route cues")
	_expect(hollow_lane_upper.color.a <= 0.32 and hollow_lane_lower.color.a <= 0.38, "Hollow Reef lane shelves should frame the path without becoming walls")
	_expect(hollow_lane_direction.color.g > hollow_lane_direction.color.r, "Hollow Reef interior direction rib should use safe/cave route color language")
	_expect(hollow_lane_return.color.a >= 0.08 and hollow_lane_return.color.a <= 0.1, "Hollow Reef lane return current should be readable but not objective-bright")
	_expect(hollow_lane_return.polygon[1].x < hollow_lane_return.polygon[0].x, "Hollow Reef lane return current should point left toward the cave mouth")
	_expect(hollow_lane_return.polygon[1].y < hollow_lane_return.polygon[0].y, "Hollow Reef lane return current should point up toward the exit route")
	_expect(hollow_lane_return_rib.polygon[1].x < hollow_lane_return_rib.polygon[0].x, "Hollow Reef lane return rib should step left along the return chain")
	_expect(hollow_upper_shelf.position.y < hollow_reef_interior_lane.position.y, "Hollow Reef upper shelf choice should sit above the main interior lane")
	_expect(hollow_upper_shelf.position.x > 0.0 and hollow_upper_shelf.position.x < hollow_lane_turnback.polygon[1].x, "Hollow Reef upper shelf choice should be a local option before the lane turnback")
	_expect(hollow_upper_water.color.b > hollow_upper_water.color.r, "Hollow Reef upper shelf water should use cool cave exploration color")
	_expect(hollow_upper_choice_rib.color.b > hollow_lane_return.color.b and hollow_upper_choice_rib.color.g < hollow_lane_return.color.g, "Hollow Reef upper shelf cue should be visually distinct from the green return lane")
	_expect(hollow_upper_choice_rib.color.a <= 0.22, "Hollow Reef upper shelf cue should stay exploratory instead of objective-bright")
	_expect(hollow_upper_lip.color.a <= 0.4, "Hollow Reef upper shelf lip should frame optional space without becoming a wall")
	_expect(hollow_upper_drop_back.color.a < hollow_lane_return.color.a, "Hollow Reef upper shelf drop-back cue should stay softer than the main return lane")
	_expect(hollow_upper_drop_back.polygon[1].y > hollow_upper_drop_back.polygon[0].y, "Hollow Reef upper shelf drop-back cue should point down toward the main lane")
	_expect(hollow_resource_pocket.position.x > 0.0 and hollow_resource_pocket.position.y > 0.0, "Hollow Reef sheltered resource pocket should sit inside the optional upper shelf")
	_expect(hollow_resource_cleft.color.a >= 0.45, "Hollow Reef sheltered pocket should read as a protected cleft")
	_expect(hollow_resource_halo.color.a <= 0.15, "Hollow Reef sheltered pocket halo should stay subtle enough not to crowd return cues")
	_expect(hollow_resource_glimmer.color.g >= hollow_resource_glimmer.color.r, "Hollow Reef sheltered pocket glimmer should use familiar glow resource language")
	_expect(hollow_resource_glimmer.color.a <= 0.36, "Hollow Reef sheltered pocket glimmer should suggest opportunity without guaranteeing a jackpot")
	_expect(hollow_resource_pocket.get_node_or_null("ResourcePickup") == null, "Hollow Reef sheltered pocket should use existing spawn candidates instead of adding a new pickup node")
	_expect(hollow_upper_shelf.get_node_or_null("InteractZone") == null, "Hollow Reef upper shelf should not add a new interaction hotspot")
	_expect(hollow_upper_shelf.get_node_or_null("ResourcePickup") == null, "Hollow Reef upper shelf should not add cargo or loot")
	_expect(hollow_upper_shelf.get_node_or_null("Predator") == null, "Hollow Reef upper shelf should not add combat pressure")
	_expect(hollow_upper_shelf.get_node_or_null("PressureBoundary") == null, "Hollow Reef upper shelf should not add hidden pressure behavior")
	_expect(hollow_upper_shelf.find_child("CollisionShape2D", true, false) == null, "Hollow Reef upper shelf should not block the safe return lane")
	_expect(hollow_lane_turnback.color.a <= 0.46, "Hollow Reef lane turnback lip should signal the current authored end without implying a full cave network")
	_expect(hollow_reef_interior_lane.get_node_or_null("InteractZone") == null, "Hollow Reef interior lane should not add a second interaction hotspot")
	_expect(hollow_reef_interior_lane.get_node_or_null("ResourcePickup") == null, "Hollow Reef interior lane should not add cargo or loot")
	_expect(hollow_reef_interior_lane.get_node_or_null("Predator") == null, "Hollow Reef interior lane should not add combat or monster pressure")
	_expect(hollow_reef_interior_lane.get_node_or_null("PressureBoundary") == null, "Hollow Reef interior lane should not add hidden pressure behavior")
	_expect(hollow_reef_interior_lane.find_child("CollisionShape2D", true, false) == null, "Hollow Reef interior lane should not add hidden collision")
	_expect(hollow_reef_interior_lane.get_script() == null, "Hollow Reef interior lane should remain authored scene presentation, not gameplay state")
	_expect(hollow_wide_chamber.position.x > hollow_reef_interior_lane.position.x + 180.0, "Wide Reef Chamber should sit beyond the short Hollow Reef interior lane")
	_expect(hollow_wide_chamber.position.y >= hollow_reef_interior_lane.position.y, "Wide Reef Chamber should continue the lower-route cave direction")
	_expect(hollow_wide_water.polygon[3].x - hollow_wide_water.polygon[0].x >= 680.0, "Wide Reef Chamber backwater should visibly support side-to-side movement")
	_expect(hollow_wide_water.polygon[6].y - hollow_wide_water.polygon[1].y >= 330.0, "Wide Reef Chamber should be more than a thin corridor")
	_expect(hollow_wide_entrance.polygon[0].x < 0.0 and hollow_wide_entrance.polygon[2].x > 0.0, "Wide Reef Chamber entrance should overlap back toward Hollow Reef")
	_expect(hollow_wide_far_wall.color.a <= 0.36, "Wide Reef Chamber far-wall silhouette should stay behind the player and route cues")
	_expect(hollow_wide_far_wall.color.b >= hollow_wide_far_wall.color.r, "Wide Reef Chamber far-wall silhouette should use cool cave color language")
	_expect(hollow_wide_clear_band.color.a <= 0.1, "Wide Reef Chamber traversal band should clarify negative space without becoming an objective marker")
	_expect(hollow_wide_clear_band.polygon[3].x - hollow_wide_clear_band.polygon[0].x >= 560.0, "Wide Reef Chamber traversal band should span the horizontal playable lane")
	_expect(hollow_wide_clear_band.polygon[5].y < hollow_wide_foreground.polygon[0].y, "Wide Reef Chamber clear lane should sit above the foreground edge")
	_expect(hollow_wide_open_water.color.a <= 0.16, "Wide Reef Chamber open water should read as negative traversable space, not a blocking field")
	_expect(hollow_wide_upper.color.a >= 0.3 and hollow_wide_upper.color.a <= 0.34 and hollow_wide_lower.color.a >= 0.34 and hollow_wide_lower.color.a <= 0.38, "Wide Reef Chamber should frame the playable gap without becoming the loudest shapes")
	_expect(hollow_wide_foreground.color.a <= 0.32, "Wide Reef Chamber foreground edge should not obscure the sub or chamber cues")
	_expect(hollow_wide_foreground.polygon[0].y > hollow_wide_clear_band.polygon[0].y, "Wide Reef Chamber foreground edge should stay below the main traversal band")
	_expect(hollow_wide_glass_rib_span.color.b > hollow_wide_glass_rib_span.color.r, "Glass Rib Span should use cool chamber landmark language")
	_expect(hollow_wide_glass_rib_span.color.a <= 0.26, "Glass Rib Span should remain passive and quieter than scan/resource targets")
	_expect(hollow_wide_glass_rib_span.polygon[1].y < hollow_wide_clear_band.polygon[1].y, "Glass Rib Span should sit above the traversal band as an upper chamber landmark")
	_expect(hollow_wide_low_crown_shelf.color.g > hollow_wide_low_crown_shelf.color.r, "Low Crown Shelf should use reef/cave landmark color rather than resource or predator color")
	_expect(hollow_wide_low_crown_shelf.color.a <= 0.32, "Low Crown Shelf should stay passive and not read as a pickup")
	_expect(hollow_wide_low_crown_shelf.polygon[0].y > hollow_wide_clear_band.polygon[0].y, "Low Crown Shelf should sit below the traversal band as a lower chamber landmark")
	_expect(hollow_wide_return.color.g > hollow_wide_return.color.r and hollow_wide_return_rib_a.color.g > hollow_wide_return_rib_a.color.r, "Wide Reef Chamber return cue should use the established safe-current language")
	_expect(hollow_wide_return.polygon[1].x < hollow_wide_return.polygon[0].x, "Wide Reef Chamber return cue should point back left toward Hollow Reef")
	_expect(hollow_wide_return_far.color.g > hollow_wide_return_far.color.r and hollow_wide_return_mid.color.g > hollow_wide_return_mid.color.r, "Wide Reef Chamber return chain should keep safe-current color language")
	_expect(hollow_wide_return.color.a <= 0.11 and hollow_wide_return_far.color.a <= 0.1 and hollow_wide_return_mid.color.a <= 0.09 and hollow_wide_return_entry.color.a <= 0.1, "Wide Reef Chamber return chain should stay broad and not objective-bright")
	_expect(hollow_wide_return_far.polygon[1].x < hollow_wide_return_far.polygon[0].x, "Wide Reef Chamber far return rib should point left from the far chamber")
	_expect(hollow_wide_return_mid.polygon[1].x < hollow_wide_return_mid.polygon[0].x, "Wide Reef Chamber mid return chain should point left through the chamber")
	_expect(hollow_wide_return_entry.polygon[1].x < hollow_wide_return_entry.polygon[0].x, "Wide Reef Chamber entry return chain should point left toward Hollow Reef")
	_expect(hollow_wide_return_mid.polygon[1].y < hollow_wide_foreground.polygon[0].y, "Wide Reef Chamber mid return chain should stay above the low foreground shelf")
	_expect(hollow_wide_future_choice.color.a <= 0.4, "Wide Reef Chamber future-choice shadow should stay a quiet staging cue")
	_expect(hollow_wide_far_turnback.position.x > hollow_wide_future_choice.polygon[4].x, "Wide Reef Chamber far turnback cue should sit beyond the current future-choice shadow")
	_expect(hollow_wide_far_boundary.color.b > hollow_wide_far_boundary.color.r, "Wide Reef Chamber far boundary should use cool future-route language")
	_expect(hollow_wide_far_boundary.color.a <= 0.2, "Wide Reef Chamber far boundary should stay atmospheric instead of becoming a hard wall")
	_expect(hollow_wide_far_return.color.g > hollow_wide_far_return.color.r, "Wide Reef Chamber far turnback should use established safe-current color")
	_expect(hollow_wide_far_return.polygon[1].x < hollow_wide_far_return.polygon[0].x, "Wide Reef Chamber far turnback ribbon should point left toward Hollow Reef")
	_expect(hollow_wide_far_rib.polygon[1].x < hollow_wide_far_rib.polygon[0].x, "Wide Reef Chamber far turnback rib should step left along the route chain")
	_expect(hollow_wide_far_label.text.contains("RETURN VIA HOLLOW"), "Wide Reef Chamber far turnback label should preserve broad copy for future review")
	_expect(not hollow_wide_far_label.visible, "Wide Reef Chamber far turnback label should stay hidden during normal play to avoid route-text pileup")
	_expect(hollow_wide_far_label.text.contains("LATER"), "Wide Reef Chamber far turnback label should frame the far edge as future content")
	_expect(not hollow_wide_far_label.text.to_lower().contains("pickup"), "Wide Reef Chamber far turnback label should not read as a collectable")
	_expect(not hollow_wide_far_label.text.to_lower().contains("locked"), "Wide Reef Chamber far turnback label should not read as an active gate")
	_expect_no_echo_lens_locator_language(hollow_wide_far_label.text, "Wide Reef Chamber far turnback label")
	_expect(hollow_wide_far_turnback.get_node_or_null("InteractZone") == null, "Wide Reef Chamber far turnback cue should not add an interaction hotspot")
	_expect(hollow_wide_far_turnback.get_node_or_null("ResourcePickup") == null, "Wide Reef Chamber far turnback cue should not add cargo or loot")
	_expect(hollow_wide_far_turnback.get_node_or_null("PressureBoundary") == null, "Wide Reef Chamber far turnback cue should not add hidden pressure behavior")
	_expect(hollow_wide_far_turnback.find_child("CollisionShape2D", true, false) == null, "Wide Reef Chamber far turnback cue should not add collision or invisible walls")
	_expect(hollow_wide_far_turnback.get_script() == null, "Wide Reef Chamber far turnback cue should remain visual-only")
	_expect(hollow_wide_chamber.get_node_or_null("InteractZone") == null, "Wide Reef Chamber should not add an interaction hotspot yet")
	_expect(hollow_wide_chamber.get_node_or_null("ResourcePickup") == null, "Wide Reef Chamber should not add cargo or loot yet")
	_expect(hollow_wide_chamber.get_node_or_null("Predator") == null, "Wide Reef Chamber should not add combat or monster pressure yet")
	_expect(hollow_wide_chamber.get_node_or_null("PressureBoundary") == null, "Wide Reef Chamber should not add pressure gating yet")
	_expect(hollow_wide_chamber.get_node_or_null("WreckSalvagePocketEntrance/InteractZone/CollisionShape2D") != null, "Wide Reef Chamber should only add collision for the nested salvage cache trigger")
	_expect(hollow_wide_chamber.get_node_or_null("RouteCollision") == null, "Wide Reef Chamber should not add route-blocking collision")
	_expect(hollow_wide_chamber.get_script() == null, "Wide Reef Chamber should remain authored scene presentation for this pass")
	_expect(hollow_wide_glass_rib_span.get_node_or_null("InteractZone") == null, "Glass Rib Span should not add an interaction hotspot")
	_expect(hollow_wide_low_crown_shelf.get_node_or_null("InteractZone") == null, "Low Crown Shelf should not add an interaction hotspot")
	_expect(mirror_kelp_pass.position.x > hollow_wide_far_turnback.position.x, "Mirror Kelp Pass should extend beyond the current wide-chamber far turnback")
	_expect(mirror_kelp_pass.position.y >= -12.0 and mirror_kelp_pass.position.y <= 80.0, "Mirror Kelp Pass should branch locally from the current chamber band")
	_expect(mirror_kelp_mouth.color.a >= 0.58, "Mirror Kelp Pass mouth should read as an intentional branch opening")
	_expect(mirror_kelp_water.color.b >= mirror_kelp_water.color.r, "Mirror Kelp Pass water should use cool reflective branch language")
	_expect(mirror_kelp_water.color.a <= 0.22, "Mirror Kelp Pass water should stay quieter than pickups and scan targets")
	_expect(mirror_kelp_curtain_a.color.g > mirror_kelp_curtain_a.color.r and mirror_kelp_curtain_b.color.b > mirror_kelp_curtain_b.color.r, "Mirror Kelp Pass curtains should establish reflective kelp identity")
	_expect(mirror_kelp_curtain_a.color.a <= 0.18 and mirror_kelp_curtain_b.color.a <= 0.16, "Mirror Kelp Pass curtains should not overpower the route")
	_expect(mirror_kelp_floor.color.a <= 0.34, "Mirror Kelp Pass floor shelf should frame the branch without becoming a wall")
	_expect(mirror_kelp_water.color.a < tideglass_core.color.a and mirror_kelp_curtain_a.color.a < tideglass_core.color.a, "Mirror Kelp placeholder scenery should stay quieter than the Tideglass payoff")
	_expect(mirror_kelp_return.color.g > mirror_kelp_return.color.r, "Mirror Kelp Pass entry return ribbon should use safe-current color language")
	_expect(mirror_kelp_return.polygon[1].x < mirror_kelp_return.polygon[0].x, "Mirror Kelp Pass entry return ribbon should point back left toward Wide Reef Chamber")
	_expect(mirror_kelp_loop_return.color.g > mirror_kelp_loop_return.color.r, "Mirror Kelp Pass loop return should use safe-current color language")
	_expect(mirror_kelp_loop_return.color.a >= 0.1 and mirror_kelp_loop_return.color.a <= 0.12, "Mirror Kelp Pass loop return should be readable without becoming objective-bright")
	_expect(mirror_kelp_loop_return.polygon[1].x < mirror_kelp_loop_return.polygon[0].x, "Mirror Kelp Pass loop return should point left from the branch interior")
	_expect(mirror_kelp_loop_return.polygon[2].x < mirror_kelp_loop_return.polygon[1].x, "Mirror Kelp Pass loop return should continue left through the branch")
	_expect(mirror_kelp_loop_rib_a.polygon[1].x < mirror_kelp_loop_rib_a.polygon[0].x, "Mirror Kelp Pass first return rib should step left along the loop")
	_expect(mirror_kelp_loop_rib_b.polygon[1].x < mirror_kelp_loop_rib_b.polygon[0].x, "Mirror Kelp Pass second return rib should step left toward the chamber")
	_expect(mirror_kelp_loop_silhouette.color.a <= 0.26, "Mirror Kelp Pass chamber-loop silhouette should remain background guidance")
	_expect(mirror_kelp_loop_silhouette.polygon[1].x < mirror_kelp_return.polygon[1].x, "Mirror Kelp Pass loop silhouette should connect visually back toward the chamber")
	_expect(mirror_kelp_return_label.text == "RETURN VIA WIDE REEF", "Mirror Kelp Pass return label should preserve broad place-based return copy")
	_expect(not mirror_kelp_return_label.visible, "Mirror Kelp Pass return label should stay hidden because base HUD already carries broad return guidance")
	_expect(not mirror_kelp_return_label.text.to_lower().contains("map"), "Mirror Kelp Pass return label should not imply a minimap")
	_expect(not mirror_kelp_return_label.text.to_lower().contains("objective"), "Mirror Kelp Pass return label should not imply checklist objectives")
	_expect_no_echo_lens_locator_language(mirror_kelp_return_label.text, "Mirror Kelp Pass return label")
	_expect(mirror_kelp_label.text == "MIRROR KELP", "Mirror Kelp Pass should expose a compact stable prototype place name")
	_expect(mirror_kelp_label.get_theme_font_size("font_size") <= 10, "Mirror Kelp place label should stay visually subordinate to playable content")
	_expect_no_echo_lens_locator_language(mirror_kelp_label.text, "Mirror Kelp Pass label")
	_expect(tideglass_sample.position.x > 70.0 and tideglass_sample.position.x < 180.0, "Tideglass Sample should sit inside Mirror Kelp Pass instead of on the chamber return path")
	_expect(tideglass_sample.position.y > -20.0 and tideglass_sample.position.y < 72.0, "Tideglass Sample should stay readable within the Mirror Kelp branch band")
	_expect(tideglass_halo.color.g >= tideglass_halo.color.r and tideglass_halo.color.b >= tideglass_halo.color.r, "Tideglass Sample should use cool knowledge-payoff color language")
	_expect(tideglass_halo.color.a <= 0.4, "Tideglass Sample halo should be readable without becoming objective-bright")
	_expect(tideglass_core.color.a >= 0.8, "Tideglass Sample should start visibly recoverable")
	_expect(tideglass_spark.visible and tideglass_spark.color.a >= 0.8, "Tideglass Sample should expose a small recovery spark")
	_expect(tideglass_interact.collision_layer == 0 and tideglass_interact.collision_mask == 1, "Tideglass Sample hotspot should detect the player without becoming route collision")
	_expect(mirror_kelp_pass.get_node_or_null("InteractZone") == null, "Mirror Kelp Pass should not add a pass-wide interaction hotspot")
	_expect(mirror_kelp_pass.get_node_or_null("ResourcePickup") == null, "Mirror Kelp Pass scaffold should not add cargo or loot yet")
	_expect(mirror_kelp_pass.get_node_or_null("Predator") == null, "Mirror Kelp Pass scaffold should not add combat pressure")
	_expect(mirror_kelp_pass.get_node_or_null("PressureBoundary") == null, "Mirror Kelp Pass scaffold should not add hidden pressure behavior")
	_expect(mirror_kelp_pass.get_node_or_null("MinimapMarker") == null, "Mirror Kelp Pass scaffold should not add minimap behavior")
	_expect(mirror_kelp_pass.find_child("CollisionShape2D", true, false) == tideglass_interact.get_node("CollisionShape2D"), "Mirror Kelp Pass should only add collision for the nested Tideglass trigger")
	_expect(mirror_kelp_pass.get_script() == null, "Mirror Kelp Pass should remain authored scene presentation for this issue")
	_expect(hollow_deeper_promise.position.x > hollow_reef_reading_core.position.x, "Hollow Reef deeper promise should sit beyond the current cave reading payoff")
	_expect(hollow_deeper_promise.position.y > hollow_reef_reading_core.position.y, "Hollow Reef deeper promise should imply lower future route growth")
	_expect(hollow_deeper_mouth.color.a >= 0.62, "Hollow Reef deeper promise mouth should read as an intentional closed opening")
	_expect(hollow_deeper_wash.color.a <= 0.18, "Hollow Reef deeper promise wash should stay atmospheric, not a damage field")
	_expect(hollow_deeper_seal.color.a >= 0.22 and hollow_deeper_seal.color.a < tideglass_core.color.a, "Hollow Reef deeper promise should have a readable but quiet seal lip")
	_expect(hollow_deeper_glint.color.a >= 0.28 and hollow_deeper_glint.color.a <= 0.34, "Hollow Reef deeper promise should include a small curiosity glint without becoming a payoff")
	_expect(hollow_deeper_label.text == "DEEP CLOSED", "Hollow Reef deeper promise should clearly say the route is closed with compact copy")
	_expect(hollow_deeper_label.get_theme_font_size("font_size") <= 9, "Hollow Reef deeper promise label should be smaller than current interaction copy")
	_expect(not hollow_deeper_label.text.to_lower().contains("objective"), "Hollow Reef deeper promise label should not become checklist copy")
	_expect(not hollow_deeper_label.text.to_lower().contains("map"), "Hollow Reef deeper promise label should not imply a minimap or exact locator")
	_expect(hollow_deeper_promise.get_node_or_null("InteractZone") == null, "Hollow Reef deeper promise should not add a readback hotspot yet")
	_expect(hollow_deeper_promise.get_node_or_null("Interior") == null, "Hollow Reef deeper promise should not open another cave network")
	_expect(hollow_deeper_promise.get_node_or_null("ResourcePickup") == null, "Hollow Reef deeper promise should not add cargo or loot")
	_expect(hollow_deeper_promise.get_node_or_null("PressureBoundary") == null, "Hollow Reef deeper promise should not add hidden pressure behavior")
	_expect(hollow_deeper_promise.find_child("CollisionShape2D", true, false) == null, "Hollow Reef deeper promise should not add collision or movement behavior")
	_expect(hollow_deeper_promise.get_script() == null, "Hollow Reef deeper promise should remain visual-only")
	_expect(hollow_reef_reading_core.position.distance_to(hollow_reef_interact.position) >= 64.0, "Hollow Reef cave reading marker should be offset from the hotspot so the sub does not cover it")
	_expect(hollow_reef_reading_halo.color.a >= 0.3, "Hollow Reef cave reading should have a visible halo before recovery")
	_expect(hollow_reef_reading_shard.color.a >= 0.8, "Hollow Reef cave reading should start visibly recoverable")
	_expect(hollow_reef_reading_spark.visible and hollow_reef_reading_spark.color.a >= 0.8, "Hollow Reef cave reading should have a bright recovery spark")
	_expect(hollow_reef_turnback.color.a >= 0.4, "Hollow Reef should keep the old mouth turnback lip readable beside the new interior lane")
	_expect(hollow_reef_interact.collision_layer == 0 and hollow_reef_interact.collision_mask == 1, "Hollow Reef reading hotspot should detect the player without becoming a blocking body")
	_expect(hollow_reef.get_node_or_null("Interior") == null, "Hollow Reef scaffold should not add a full cave interior system")
	_expect(hollow_reef.get_node_or_null("ResourcePickup") == null, "Hollow Reef scaffold should not add a resource pickup yet")
	_expect(hollow_reef.get_node_or_null("Predator") == null, "Hollow Reef scaffold should not add a predator encounter")
	_expect(hollow_reef.get_script() == null, "Hollow Reef readability cues should not own oxygen, cargo, or progression state")
	_expect(hollow_reef.get_node_or_null("PressureBoundary") == null, "Hollow Reef cave reading should not add hidden pressure behavior")
	_expect(lantern_ray_route.position.distance_to(dusk_trench.global_position) <= 240.0, "Lantern Ray Route should sit near Dusk Trench as lower-route creature presence")
	_expect(lantern_ray_route.position.y < dusk_trench.global_position.y, "Lantern Ray Route should drift above the main trench return lane")
	_expect(lantern_ray_lane.color.a <= 0.16, "Lantern Ray ambient lane should stay softer than predator warning lanes")
	_expect(lantern_ray_timing_upper.color.b >= lantern_ray_timing_upper.color.r and lantern_ray_timing_upper.color.r > lantern_ray_timing_upper.color.g, "Lantern Ray timing lane should read as pale timing guidance, not safe-current green")
	_expect(lantern_ray_timing_upper.color.a <= 0.18 and lantern_ray_timing_lower.color.a <= 0.14 and lantern_ray_timing_tick.color.a <= 0.24, "Lantern Ray timing lane should stay readable without becoming a hard wall")
	_expect(lantern_ray_timing_lane.find_child("CollisionShape2D", true, false) == null, "Lantern Ray timing lane should not add hidden collision")
	_expect(lantern_ray_timing_lane.get_node_or_null("PressureBoundary") == null, "Lantern Ray timing lane should not add hidden pressure behavior")
	_expect(lantern_ray_body.color.b > lantern_ray_body.color.r and lantern_ray_body.color.g > lantern_ray_body.color.r, "Lantern Ray should use cool creature color language instead of predator red or resource yellow")
	_expect(lantern_ray_wing.color.a <= 0.5, "Lantern Ray wing silhouette should read as ambient life without becoming a hard obstacle")
	_expect(lantern_ray_eye.color.a >= 0.65, "Lantern Ray should have a small distinct creature focal point")
	_expect(lantern_ray_route is Area2D, "Lantern Ray Route should be a passive scannable observation area")
	_expect(lantern_ray_route.collision_layer == 0 and lantern_ray_route.collision_mask == 0, "Lantern Ray scan area should not collide, damage, or block extraction")
	_expect(lantern_ray_scan_marker.color.a <= 0.2, "Lantern Ray scan marker should stay subtle while idle")
	_expect(lantern_ray_collision != null, "Lantern Ray should keep a scan-area shape for target readability")
	_expect(lantern_ray_route.get_node_or_null("InteractZone") == null, "Lantern Ray Route should not add an interaction hotspot")
	_expect(lantern_ray_route.get_node_or_null("ResourcePickup") == null, "Lantern Ray Route should not add harvest or cargo behavior")
	_expect(lantern_ray_route.get_node_or_null("Predator") == null, "Lantern Ray Route should not reuse predator behavior")
	_expect(blackwater_crack.get_node_or_null("Interior") == null, "Blackwater Crack should not add a cave interior system")
	_expect(blackwater_sill.get_node_or_null("Interior") == null, "Blackwater Sill should not add a cave interior system")
	_expect(blue_chimney_glow_candidate.target_id == "glow_plankton", "Blue Chimney optional material should use existing Glow Plankton")
	_expect(blue_chimney_glow_candidate.depth_band == "deep", "Blue Chimney material candidate should preserve deep resource identity")
	_expect(blue_chimney_glow_candidate.cluster_pattern == "deep_reward", "Blue Chimney material candidate should remain optional deep-reward route pressure")
	_expect(blue_chimney_glow_candidate.position.distance_to(blue_chimney_pocket.position) <= 96.0, "Blue Chimney material candidate should sit near the lower pocket after runtime v3 playable-water re-anchor")
	_expect(hollow_reef_glow_candidate.target_id == "glow_plankton", "Hollow Reef sheltered pocket should use existing Glow Plankton")
	_expect(hollow_reef_glow_candidate.depth_band == "deep", "Hollow Reef material candidate should preserve deep resource identity")
	_expect(hollow_reef_glow_candidate.cluster_pattern == "deep_reward", "Hollow Reef material candidate should stay optional in the deep-reward resource pool")
	_expect(hollow_reef_glow_candidate.position.distance_to(hollow_resource_pocket.global_position) <= 48.0, "Hollow Reef material candidate should sit inside the sheltered pocket")
	_expect(mirror_kelp_cargo_candidate.target_id == "kelp_fiber", "Mirror Kelp cargo split should use existing Kelp Fiber")
	_expect(mirror_kelp_cargo_candidate.depth_band == "deep", "Mirror Kelp cargo split should stay in the deep branch context")
	_expect(mirror_kelp_cargo_candidate.cluster_pattern == "deep_reward", "Mirror Kelp cargo split should remain optional deep-reward route pressure")
	_expect(mirror_kelp_cargo_candidate.global_position.distance_to(tideglass_sample.global_position) >= 90.0, "Mirror Kelp cargo and Tideglass knowledge should not stack on each other")
	_expect(mirror_kelp_cargo_candidate.global_position.y > tideglass_sample.global_position.y, "Mirror Kelp cargo should sit below the Tideglass payoff so the choice reads as two local commitments")
	_expect(main.get_node_or_null("ResourcePickups/BlueChimneyGlowPlankton") == null, "Blue Chimney candidate should not add an extra active resource pickup")
	_expect(main.get_node_or_null("ResourcePickups/HollowReefGlowPlankton") == null, "Hollow Reef candidate should not add an extra active resource pickup")
	_expect(main.get_node_or_null("ResourcePickups/MirrorKelpFiber") == null, "Mirror Kelp cargo split should not add an extra active resource pickup")

	main.free()

func _test_area_01_first_art_slice_scene_contract() -> void:
	var main := MainScene.instantiate()
	var slice_paths := [
		"Area01ArtSlice",
		"Area01ArtSlice/BackgroundFar",
		"Area01ArtSlice/BackgroundFar/FarLeftReefMass",
		"Area01ArtSlice/BackgroundFar/FarRightReefMass",
		"Area01ArtSlice/BackgroundFar/FarCenterDepthPocket",
		"Area01ArtSlice/OceanParallaxBackground",
		"Area01ArtSlice/OceanParallaxBackground/FarOpenWaterPocket",
		"Area01ArtSlice/OceanParallaxBackground/FarLeftReefWall",
		"Area01ArtSlice/OceanParallaxBackground/FarRightReefWall",
		"Area01ArtSlice/OceanParallaxBackground/MidLeftRidge",
		"Area01ArtSlice/OceanParallaxBackground/MidCenterBackPlate",
		"Area01ArtSlice/OceanParallaxBackground/MidRightRidge",
		"Area01ArtSlice/OceanParallaxBackground/DeepCenterSilhouette",
		"Area01ArtSlice/OceanLightingStack",
		"Area01ArtSlice/OceanLightingStack/SurfaceGlow",
		"Area01ArtSlice/OceanLightingStack/ShallowBlueWash",
		"Area01ArtSlice/OceanLightingStack/MidDepthCyanWash",
		"Area01ArtSlice/OceanLightingStack/DeepBlueHaze",
		"Area01ArtSlice/OceanLightingStack/CenterPlayLight",
		"Area01ArtSlice/OceanLightingStack/SunShaftBroad",
		"Area01ArtSlice/OceanLightingStack/CausticRibbonA",
		"Area01ArtSlice/OceanLightingStack/LeftEdgeVignette",
		"Area01ArtSlice/OceanLightingStack/RightEdgeVignette",
		"Area01ArtSlice/BackgroundMid",
		"Area01ArtSlice/BackgroundMid/LeftMidWallShadow",
		"Area01ArtSlice/BackgroundMid/RightMidWallShadow",
		"Area01ArtSlice/WaterLightShafts",
		"Area01ArtSlice/TerrainBackWalls",
		"Area01ArtSlice/TerrainBackWalls/ShallowLeftWall",
		"Area01ArtSlice/TerrainBackWalls/ShallowRightWall",
		"Area01ArtSlice/TerrainBackWalls/LeftSolidWall",
		"Area01ArtSlice/TerrainBackWalls/RightSolidWall",
		"Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass",
		"Area01ArtSlice/TerrainBackWalls/BlockoutLowerBasinFloor",
		"Area01ArtSlice/TerrainBackWalls/BlockoutWestCaveShelf",
		"Area01ArtSlice/TerrainBackWalls/BlockoutLeftChamberCeiling",
		"Area01ArtSlice/TerrainBackWalls/BlockoutRightChamberShelf",
		"Area01ArtSlice/TerrainBackWalls/BlockoutFarWestShelfMass",
		"Area01ArtSlice/TerrainBackWalls/BlockoutMidCrossingCeiling",
		"Area01ArtSlice/TerrainBackWalls/BlockoutDeepSpineFloor",
		"Area01ArtSlice/TerrainBackWalls/BlockoutFarRightPocketWall",
		"Area01ArtSlice/TerrainCollision",
		"Area01ArtSlice/TerrainCollision/ShallowLeftWallCollision",
		"Area01ArtSlice/TerrainCollision/ShallowRightWallCollision",
		"Area01ArtSlice/TerrainCollision/LeftWallCollision",
		"Area01ArtSlice/TerrainCollision/RightWallCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutEastReefCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutLowerBasinCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutWestCaveShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutLeftChamberCeilingCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutRightChamberShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutFarWestShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutMidCrossingCeilingCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutDeepSpineFloorCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutFarRightPocketWallCollision",
		"Area01ArtSlice/TerrainVisualEdges",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/ShallowLeftBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/ShallowRightBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftWallBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightWallBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftLedgeBlockingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightLedgeBlockingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLowerBasinLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutWestCaveShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLeftChamberCeilingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutRightChamberShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarWestShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutMidCrossingCeilingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutDeepSpineFloorLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarRightPocketWallLip",
		"Area01ArtSlice/TerrainVisualEdges/ShallowLeftLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/ShallowRightLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/LeftWallReefKit",
		"Area01ArtSlice/TerrainVisualEdges/RightWallReefKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeReefKit",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeReefKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/MainShelfMass",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/TopLitLip",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit/MainShelfMass",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit/TopLitLip",
		"Area01ArtSlice/TerrainVisualEdges/ShallowLeftPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/ShallowRightPlatformKit",
		"Area01ArtSlice/GameplayObjects",
		"Area01ArtSlice/GameplayObjects/CargoPocketGlow",
		"Area01ArtSlice/GameplayObjects/ScanFocusPocket",
		"Area01ArtSlice/GameplayObjects/LeftShallowResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightShelfResourcePocket",
		"Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightDeepResourcePocket",
		"Area01ArtSlice/GameplayObjects/LeftChamberResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightChamberResourcePocket",
		"Area01ArtSlice/ForegroundDecor",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/KelpFrondA",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/CoralFan",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/DimCrystalA",
		"Area01ArtSlice/ForegroundDecor/LeftCaveDressing",
		"Area01ArtSlice/ForegroundDecor/RightShelfDressing",
		"Area01ArtSlice/ForegroundDecor/RightDeepDressing",
		"Area01ArtSlice/ForegroundDecor/CentralDropDressing",
	]
	for path in slice_paths:
		_expect(main.get_node_or_null(path) != null, "Area 01 art slice should include %s" % path)

	var old_debug_shell := main.get_node("SafeShallowsExplorationShell") as Node2D
	_expect(not old_debug_shell.visible, "old Safe Shallows exploration shell should stay hidden behind the first real art slice")
	var left_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/LeftSolidWall") as Polygon2D
	var right_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/RightSolidWall") as Polygon2D
	var shallow_left_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/ShallowLeftWall") as Polygon2D
	var shallow_right_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/ShallowRightWall") as Polygon2D
	var shallow_left_collision := main.get_node("Area01ArtSlice/TerrainCollision/ShallowLeftWallCollision") as CollisionPolygon2D
	var shallow_right_collision := main.get_node("Area01ArtSlice/TerrainCollision/ShallowRightWallCollision") as CollisionPolygon2D
	var blockout_east_reef := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass") as Polygon2D
	var blockout_lower_basin := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutLowerBasinFloor") as Polygon2D
	var blockout_west_cave := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutWestCaveShelf") as Polygon2D
	var blockout_left_chamber := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutLeftChamberCeiling") as Polygon2D
	var blockout_right_chamber := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutRightChamberShelf") as Polygon2D
	var blockout_far_west := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutFarWestShelfMass") as Polygon2D
	var blockout_mid_crossing := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutMidCrossingCeiling") as Polygon2D
	var blockout_deep_spine := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutDeepSpineFloor") as Polygon2D
	var blockout_far_right := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutFarRightPocketWall") as Polygon2D
	var blockout_east_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutEastReefCollision") as CollisionPolygon2D
	var blockout_lower_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutLowerBasinCollision") as CollisionPolygon2D
	var blockout_west_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutWestCaveShelfCollision") as CollisionPolygon2D
	var blockout_left_chamber_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutLeftChamberCeilingCollision") as CollisionPolygon2D
	var blockout_right_chamber_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutRightChamberShelfCollision") as CollisionPolygon2D
	var blockout_far_west_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutFarWestShelfCollision") as CollisionPolygon2D
	var blockout_mid_crossing_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutMidCrossingCeilingCollision") as CollisionPolygon2D
	var blockout_deep_spine_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutDeepSpineFloorCollision") as CollisionPolygon2D
	var blockout_far_right_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutFarRightPocketWallCollision") as CollisionPolygon2D
	var far_center := main.get_node("Area01ArtSlice/BackgroundFar/FarCenterDepthPocket") as Polygon2D
	var far_open_water := main.get_node("Area01ArtSlice/OceanParallaxBackground/FarOpenWaterPocket") as Polygon2D
	var mid_center_plate := main.get_node("Area01ArtSlice/OceanParallaxBackground/MidCenterBackPlate") as Polygon2D
	var deep_center_silhouette := main.get_node("Area01ArtSlice/OceanParallaxBackground/DeepCenterSilhouette") as Polygon2D
	var surface_glow := main.get_node("Area01ArtSlice/OceanLightingStack/SurfaceGlow") as Polygon2D
	var deep_haze := main.get_node("Area01ArtSlice/OceanLightingStack/DeepBlueHaze") as Polygon2D
	var center_play_light := main.get_node("Area01ArtSlice/OceanLightingStack/CenterPlayLight") as Polygon2D
	var collision_read_boundaries := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries") as Node2D
	var left_wall_blocking_rim := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftWallBlockingRim") as Polygon2D
	var right_wall_blocking_rim := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightWallBlockingRim") as Polygon2D
	var left_ledge_blocking_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftLedgeBlockingLip") as Polygon2D
	var right_ledge_blocking_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightLedgeBlockingLip") as Polygon2D
	var blockout_east_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip") as Polygon2D
	var blockout_lower_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLowerBasinLip") as Polygon2D
	var blockout_west_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutWestCaveShelfLip") as Polygon2D
	var blockout_left_chamber_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLeftChamberCeilingLip") as Polygon2D
	var blockout_right_chamber_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutRightChamberShelfLip") as Polygon2D
	var blockout_far_west_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarWestShelfLip") as Polygon2D
	var blockout_mid_crossing_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutMidCrossingCeilingLip") as Polygon2D
	var blockout_deep_spine_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutDeepSpineFloorLip") as Polygon2D
	var blockout_far_right_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarRightPocketWallLip") as Polygon2D
	var left_platform_mass := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/MainShelfMass") as Polygon2D
	var left_platform_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/TopLitLip") as Polygon2D
	var dressing_crystal := main.get_node("Area01ArtSlice/ForegroundDecor/LeftShelfDressing/DimCrystalA") as Polygon2D
	var dressing_coral := main.get_node("Area01ArtSlice/ForegroundDecor/LeftShelfDressing/CoralFan") as Polygon2D
	var cargo_slot := main.get_node("Area01ArtSlice/GameplayObjects/CargoPocketGlow") as Polygon2D
	var background_study := main.get_node("ShallowMidwaterBackgroundStudy") as Sprite2D
	var route_choice_band := main.get_node("RouteChoiceBand") as Node2D
	_expect(left_wall.color.a >= 0.9, "primary art-slice walls should read as solid terrain instead of translucent route overlays")
	_expect(right_wall.color.a >= 0.9, "primary art-slice walls should read as solid terrain instead of translucent route overlays")
	_expect(not shallow_left_wall.visible and not shallow_right_wall.visible and shallow_left_collision.disabled and shallow_right_collision.disabled, "upper open water should not contain invisible shallow-wall blockers")
	_expect(blockout_east_reef.color.a >= 0.9 and blockout_lower_basin.color.a >= 0.9 and blockout_west_cave.color.a >= 0.9, "larger Area 01 blockout masses should read as solid reef terrain")
	_expect(not blockout_east_collision.disabled and not blockout_lower_collision.disabled and not blockout_west_collision.disabled, "larger Area 01 blockout collision should stay enabled only where matching terrain is visible")
	_expect(blockout_left_chamber.color.a >= 0.9 and blockout_right_chamber.color.a >= 0.9, "new Area 01 chamber masses should read as solid reef terrain")
	_expect(not blockout_left_chamber_collision.disabled and not blockout_right_chamber_collision.disabled, "new Area 01 chamber collision should stay enabled only where matching terrain is visible")
	_expect(blockout_far_west.color.a >= 0.9 and blockout_mid_crossing.color.a >= 0.9 and blockout_deep_spine.color.a >= 0.9 and blockout_far_right.color.a >= 0.9, "expanded multi-screen Area 01 masses should read as solid reef terrain")
	_expect(not blockout_far_west_collision.disabled and not blockout_mid_crossing_collision.disabled and not blockout_deep_spine_collision.disabled and not blockout_far_right_collision.disabled, "expanded Area 01 terrain collision should stay enabled only where matching terrain is visible")
	_expect(far_center.color.a < left_wall.color.a, "background pocket should sit behind solid terrain in opacity hierarchy")
	_expect(far_open_water.color.a < left_wall.color.a, "parallax open-water pockets should stay quieter than solid terrain")
	_expect(mid_center_plate.color.a > far_open_water.color.a, "mid parallax plates should be slightly stronger than far open-water pockets")
	_expect(deep_center_silhouette.color.a < left_wall.color.a, "deep parallax silhouettes should add depth without competing with walls")
	_expect(surface_glow.color.b > deep_haze.color.b, "ocean lighting stack should grade from brighter surface water into deeper blue haze")
	_expect(deep_haze.color.a > surface_glow.color.a, "deep haze should become more present than the surface glow at depth")
	_expect(center_play_light.color.a <= 0.2, "center play light should support focal readability without becoming a solid overlay")
	_expect(left_wall_blocking_rim.color.a >= 0.7 and right_wall_blocking_rim.color.a >= 0.7, "wall collision rims should be readable enough that solid terrain does not feel random")
	_expect(left_ledge_blocking_lip.color.a >= 0.6 and right_ledge_blocking_lip.color.a >= 0.6, "ledge collision lips should show where the player will bump")
	_expect(blockout_east_lip.color.a >= 0.6 and blockout_lower_lip.color.a >= 0.6 and blockout_west_lip.color.a >= 0.6, "larger blockout terrain should expose visible lips before the player collides")
	_expect(blockout_left_chamber_lip.color.a >= 0.6 and blockout_right_chamber_lip.color.a >= 0.6, "new Area 01 chamber terrain should expose visible lips before the player collides")
	_expect(blockout_far_west_lip.color.a >= 0.6 and blockout_mid_crossing_lip.color.a >= 0.6 and blockout_deep_spine_lip.color.a >= 0.6 and blockout_far_right_lip.color.a >= 0.6, "expanded multi-screen terrain should expose visible lips before the player collides")
	_expect(left_wall_blocking_rim.color.a < left_wall.color.a and right_wall_blocking_rim.color.a < right_wall.color.a, "collision rims should clarify terrain without replacing the solid mass")
	_expect(collision_read_boundaries.find_child("CollisionShape2D", true, false) == null, "collision-read boundary visuals should not add extra hidden collision")
	_expect(left_platform_mass.color.a >= 0.8, "platform kit shelf masses should read as solid reef rather than route overlays")
	_expect(left_platform_lip.color.a < left_platform_mass.color.a, "platform kit lip highlights should support terrain edges without becoming the solid mass")
	_expect(dressing_crystal.color.a < cargo_slot.color.a, "decorative crystals should stay quieter than cargo-object glows")
	_expect(dressing_coral.color.a < left_platform_mass.color.a, "decorative coral should enrich shelves without competing with terrain masses")
	_expect(cargo_slot.color.a < left_wall.color.a, "gameplay object slots should not look like solid terrain")
	_expect(background_study.modulate.a <= 0.24, "old broad background study should sit behind the first real art slice")
	_expect(not route_choice_band.visible, "route-choice review band should stay hidden by default so the first art slice reads as a place, not a diagram")
	main.free()

func _test_area_01_source_map_contract() -> void:
	var file := FileAccess.open("res://data/maps/area_01_runtime_geometry.generated.json", FileAccess.READ)
	_expect(file != null, "Area 01 generated runtime geometry JSON should exist")
	if file == null:
		return

	var parsed = JSON.parse_string(file.get_as_text())
	_expect(typeof(parsed) == TYPE_DICTIONARY, "Area 01 generated runtime geometry should parse as a JSON object")
	if typeof(parsed) != TYPE_DICTIONARY:
		return

	var source_map := parsed as Dictionary
	_expect(String(source_map.get("map_id", "")) == "area_01_runtime_geometry_generated", "Area 01 should use the generated runtime geometry revision")
	_expect(bool(source_map.get("generated", false)), "Area 01 runtime geometry should be generated")
	_expect(String(source_map.get("generated_from", "")) == "data/maps/area_01_source_grid_v1.json", "Area 01 generated runtime geometry should point back to the source grid")
	_expect(String(source_map.get("generated_by", "")) == "tools/build-area01-map.mjs", "Area 01 generated runtime geometry should name the deterministic converter")
	_expect(not String(source_map.get("source_sha256", "")).is_empty(), "Area 01 generated runtime geometry should preserve the source-grid hash")
	var required_keys := [
		"schema_version",
		"coordinate_space",
		"source_grid",
		"terrain_domain",
		"playable_water_components",
		"playable_water_regions",
		"solid_terrain",
		"scene_hooks",
		"review_points",
		"validation_contract",
	]
	for key in required_keys:
		_expect(source_map.has(key), "Area 01 generated runtime geometry should include %s" % key)

	var playable_water_regions: Array = source_map.get("playable_water_regions", [])
	var solid_terrain: Array = source_map.get("solid_terrain", [])
	var scene_hooks: Array = source_map.get("scene_hooks", [])
	var review_points: Array = source_map.get("review_points", [])
	var terrain_domain: Dictionary = source_map.get("terrain_domain", {})
	var validation_contract: Dictionary = source_map.get("validation_contract", {})
	_expect(bool(validation_contract.get("generated_geometry_must_not_be_hand_edited", false)), "Area 01 generated runtime geometry should reject hand-tuned terrain polygons")
	_expect(bool(validation_contract.get("screenshots_are_confirmation_only", false)), "Area 01 generated runtime geometry should keep screenshots as confirmation only")
	_expect((terrain_domain.get("polygon", []) as Array).size() >= 3, "Area 01 runtime source map should define one continuous terrain domain")
	_expect(playable_water_regions.size() >= 7, "Area 01 generated runtime geometry should define required playable-water regions")
	var playable_water_ids: Array[String] = []
	for water in playable_water_regions:
		if typeof(water) != TYPE_DICTIONARY:
			continue
		var water_entry := water as Dictionary
		playable_water_ids.append(String(water_entry.get("id", "")))
		_expect(water_entry.has("source_rect_cells"), "Area 01 playable water should preserve source-grid cells: %s" % String(water_entry.get("id", "")))
	for required_region_id in ["open_surface_water", "starter_kelp_hole", "shell_reef_route", "thermal_vent_pocket", "blue_chimney_route", "pressure_wreck_branch", "future_deep_exit"]:
		_expect(playable_water_ids.has(required_region_id), "Area 01 generated runtime geometry should cover %s" % required_region_id)
	_expect(solid_terrain.size() >= 20, "Area 01 runtime source map should define generated visible/colliding solid partitions")
	_expect(scene_hooks.size() >= 11, "Area 01 generated runtime geometry should define trigger/debug hooks")
	_expect(review_points.size() >= 7, "Area 01 generated runtime geometry should preserve review points")

	var hooks_by_id := {}
	for hook in scene_hooks:
		if typeof(hook) == TYPE_DICTIONARY:
			hooks_by_id[String((hook as Dictionary).get("id", ""))] = hook
	_expect(hooks_by_id.has("oxygen_surface"), "Area 01 source grid should define the full-width surface oxygen hook")
	_expect(hooks_by_id.has("ship_offload"), "Area 01 source grid should define the separate ship offload hook")
	for required_hook_id in ["player_start", "starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		_expect(hooks_by_id.has(required_hook_id), "Area 01 generated runtime geometry should include required hook %s" % required_hook_id)
	if hooks_by_id.has("oxygen_surface") and hooks_by_id.has("ship_offload"):
		var oxygen_hook := hooks_by_id["oxygen_surface"] as Dictionary
		var offload_hook := hooks_by_id["ship_offload"] as Dictionary
		_expect(String(oxygen_hook.get("type", "")) == "oxygen", "surface hook should be typed as oxygen")
		_expect(String(offload_hook.get("type", "")) == "offload", "ship hook should be typed as offload")
		_expect(String(oxygen_hook.get("id", "")) != String(offload_hook.get("id", "")), "oxygen refill and ship offload should remain separate hooks")

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 generated runtime geometry should build generated terrain: %s" % builder.last_error)

	var terrain_domain_runtime: Dictionary = terrain_domain.get("runtime_generation", {})
	var terrain_domain_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(terrain_domain_runtime.get("visible_polygon2d_name", "")))
	_expect(terrain_domain_node is Polygon2D, "Area 01 source map should build one continuous source-owned terrain domain")
	if terrain_domain_node is Polygon2D:
		var terrain_domain_polygon := terrain_domain_node as Polygon2D
		_expect(terrain_domain_polygon.visible, "Area 01 terrain domain should render as the continuous seafloor mass")
		_expect(terrain_domain_polygon.texture != null, "Area 01 terrain domain should share the generated terrain fill texture")
	var carved_water_count := 0
	for water in playable_water_regions:
		if typeof(water) != TYPE_DICTIONARY:
			_expect(false, "Area 01 playable water entries should be dictionaries")
			continue
		var water_entry := water as Dictionary
		var water_runtime: Dictionary = water_entry.get("runtime_generation", {})
		var water_cutout := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/RuntimeSourceWaterCutouts/%s" % String(water_runtime.get("visible_polygon2d_name", "")))
		var water_edge := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceWaterEdges/%s" % String(water_runtime.get("edge_line2d_name", "")))
		_expect(water_cutout is Polygon2D, "Area 01 playable water should build a cutout Polygon2D: %s" % String(water_entry.get("id", "")))
		_expect(water_edge is Line2D, "Area 01 playable water should build a hidden diagnostic edge Line2D: %s" % String(water_entry.get("id", "")))
		if bool(water_entry.get("carves_collision", false)):
			carved_water_count += 1
			_expect(water_cutout.visible, "Area 01 carving water cutout should visibly restore source-grid playable water over the terrain domain: %s" % String(water_entry.get("id", "")))
		else:
			_expect(water_cutout.visible, "Area 01 non-carving water cutout should remain source-visible for review consistency: %s" % String(water_entry.get("id", "")))
		if water_edge is Line2D:
			_expect(not water_edge.visible, "Area 01 water edge Line2D should stay hidden in normal play: %s" % String(water_entry.get("id", "")))
	_expect(carved_water_count >= 6, "Area 01 generated runtime geometry should carve cave/pocket water out of the continuous terrain domain")

	var generated_solid_partitions := 0
	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			_expect(false, "Area 01 solid terrain entries should be dictionaries")
			continue
		var terrain_entry := terrain as Dictionary
		var terrain_id := String(terrain_entry.get("id", "unknown"))
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		_expect(runtime_generation is Dictionary, "Area 01 solid terrain should include runtime generation metadata: %s" % terrain_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		_expect(String(runtime.get("visual_role", "")) == "generated_solid_partition", "Area 01 solid terrain should be generated visible/colliding partitions: %s" % terrain_id)
		generated_solid_partitions += 1
		var trim_segments: Variant = terrain_entry.get("trim_segments", [])
		if trim_segments is Array:
			for trim_value in trim_segments:
				_expect(trim_value is Dictionary, "Area 01 terrain trim segments should be dictionaries: %s" % terrain_id)
				if not trim_value is Dictionary:
					continue
				var trim := trim_value as Dictionary
				_expect(trim.has("id"), "Area 01 terrain trim segment should have an id: %s" % terrain_id)
				_expect(["top_lip", "underside", "deep_floor_lip", "vertical_wall", "diagonal_slope"].has(String(trim.get("type", ""))), "Area 01 terrain trim segment should have a semantic type: %s" % terrain_id)
				_expect(trim.get("start", []) is Array and trim.get("end", []) is Array, "Area 01 terrain trim segment should define explicit start/end points: %s" % terrain_id)
		var collision_node := main.get_node_or_null("Area01ArtSlice/RuntimeSourceCollision/%s" % String(runtime.get("collision_polygon2d_name", "")))
		var visible_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(runtime.get("visible_polygon2d_name", "")))
		var lip_node := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/%s" % String(runtime.get("rim_container_name", "")))
		_expect(visible_node is Polygon2D, "Area 01 source map visible terrain should exist as Polygon2D: %s" % terrain_id)
		_expect(collision_node is CollisionPolygon2D, "Area 01 source map collision should exist as CollisionPolygon2D: %s" % terrain_id)
		_expect(lip_node is Polygon2D, "Area 01 source map rim/lip should exist as Polygon2D: %s" % terrain_id)
		var expected_polygon := _points_from_source_map_json(terrain_entry.get("polygon", []))
		if visible_node is Polygon2D:
			_expect((visible_node as Polygon2D).visible, "Area 01 mapped visible terrain should stay visible: %s" % terrain_id)
			_expect(_packed_points_match((visible_node as Polygon2D).polygon, expected_polygon), "Area 01 visible terrain should match source-map polygon: %s" % terrain_id)
		if collision_node is CollisionPolygon2D:
			_expect(not (collision_node as CollisionPolygon2D).disabled, "Area 01 mapped blocker collision should stay enabled: %s" % terrain_id)
			_expect(_packed_points_match((collision_node as CollisionPolygon2D).polygon, expected_polygon), "Area 01 blocker collision should match source-map polygon: %s" % terrain_id)
		if lip_node is Polygon2D:
			_expect((lip_node as Polygon2D).visible, "Area 01 mapped rim/lip should stay visible: %s" % terrain_id)
			_expect(_packed_points_match((lip_node as Polygon2D).polygon, expected_polygon), "Area 01 rim/lip should match source-map polygon: %s" % terrain_id)
	_expect(generated_solid_partitions == solid_terrain.size(), "Area 01 solid terrain should all be generated visible/colliding partitions from playable water")

	for hook in scene_hooks:
		if typeof(hook) != TYPE_DICTIONARY:
			_expect(false, "Area 01 scene hook entries should be dictionaries")
			continue
		var hook_entry := hook as Dictionary
		var hook_runtime: Variant = hook_entry.get("runtime_generation", {})
		_expect(hook_runtime is Dictionary, "Area 01 scene hooks should include runtime generation metadata: %s" % String(hook_entry.get("id", "")))
		if not hook_runtime is Dictionary:
			continue
		var hook_runtime_dict := hook_runtime as Dictionary
		var area_node := main.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % String(hook_runtime_dict.get("area2d_name", ""))) as Area2D
		_expect(area_node != null, "Area 01 scene hook should create a generated Area2D: %s" % String(hook_entry.get("id", "")))
		if area_node != null:
			_expect(not area_node.monitoring and not area_node.monitorable, "Area 01 generated hooks should stay nonblocking/non-behavioral during validation: %s" % String(hook_entry.get("id", "")))
	main.free()

func _test_area_01_source_truth_validator() -> void:
	var validator := Area01SourceTruthValidatorScript.new()
	_expect(validator.load_source_map(), "Area 01 source truth validator should load the runtime source map: %s" % "\n".join(validator.errors))
	if validator.source_map.is_empty():
		return

	var data_errors: Array[String] = validator.validate_source_map_data()
	_expect(data_errors.is_empty(), "Area 01 source truth data validation should pass: %s" % "\n".join(data_errors))

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 runtime source map should build before source truth validation: %s" % builder.last_error)
	var runtime_errors: Array[String] = validator.validate_runtime_scene(main)
	_expect(runtime_errors.is_empty(), "Area 01 source truth runtime validation should pass: %s" % "\n".join(runtime_errors))
	main.free()

func _test_area_01_source_truth_validator_catches_drift() -> void:
	var validator := Area01SourceTruthValidatorScript.new()
	_expect(validator.load_source_map(), "Area 01 source truth validator should load before broken fixture")
	if validator.source_map.is_empty():
		return

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 runtime source map should build before broken fixture: %s" % builder.last_error)
	var collision_root := main.get_node("Area01ArtSlice/RuntimeSourceCollision") as StaticBody2D
	var rogue_collision := CollisionPolygon2D.new()
	rogue_collision.name = "UnmappedDriftCollision"
	rogue_collision.polygon = PackedVector2Array([
		Vector2(20.0, 20.0),
		Vector2(80.0, 20.0),
		Vector2(80.0, 80.0),
		Vector2(20.0, 80.0),
	])
	rogue_collision.disabled = false
	collision_root.add_child(rogue_collision)

	var errors: Array[String] = validator.validate_runtime_scene(main)
	var caught_unowned_collision := false
	for error in errors:
		if error.contains("UnmappedDriftCollision"):
			caught_unowned_collision = true
	_expect(caught_unowned_collision, "Area 01 source truth validator should catch enabled collision without source-map ownership")
	main.free()

func _test_area_01_visual_cue_contract_registry() -> void:
	var contracts: Dictionary = Area01VisualCueContractScript.contracts()
	for family_id in Area01VisualCueContractScript.required_family_ids():
		_expect(contracts.has(family_id), "Area 01 visual cue contract should register %s" % family_id)
		var contract := contracts.get(family_id, {}) as Dictionary
		for key in [
			"z_index_min",
			"z_index_max",
			"alpha_min",
			"alpha_max",
			"color_family",
			"label_policy",
			"brighter_than",
			"quieter_than",
		]:
			_expect(contract.has(key), "Area 01 cue family %s should define %s" % [family_id, key])
		_expect(float(contract.get("alpha_min", 0.0)) <= float(contract.get("alpha_max", -1.0)), "Area 01 cue family %s should have a valid alpha range" % family_id)

	var terrain_contract := contracts[Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN] as Dictionary
	var rim_contract := contracts[Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP] as Dictionary
	var pickup_contract := contracts[Area01VisualCueContractScript.FAMILY_RESOURCE_PICKUP] as Dictionary
	_expect(float(terrain_contract.get("alpha_min", 0.0)) > float(rim_contract.get("alpha_min", 1.0)), "solid terrain should be visually stronger than rim/lip support")
	_expect(float(pickup_contract.get("alpha_min", 0.0)) > float(rim_contract.get("alpha_min", 1.0)), "resource pickups should stay brighter than rim/lip support")

func _test_area_01_visual_cue_diagnostic_report() -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 runtime source map should build before visual cue diagnostics: %s" % builder.last_error)
	var report: Dictionary = Area01VisualCueContractScript.debug_report(main, Rect2(Vector2(-900.0, 0.0), Vector2(5500.0, 2600.0)))
	var families: Dictionary = report.get("families", {})
	_expect(int(families.get(Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, 0)) >= 13, "Area 01 cue report should count generated solid terrain nodes")
	_expect(int(families.get(Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, 0)) >= 13, "Area 01 cue report should count generated terrain rim/lip nodes")
	_expect(int(families.get(Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, 0)) >= 1, "Area 01 cue report should count tagged passive background support")

	var cue_parent := Node2D.new()
	main.add_child(cue_parent)
	for index in range(7):
		var bright_cue := Polygon2D.new()
		bright_cue.name = "BrightReturnCurrentFixture%d" % index
		bright_cue.polygon = PackedVector2Array([
			Vector2(0.0, 0.0),
			Vector2(12.0, 0.0),
			Vector2(12.0, 12.0),
			Vector2(0.0, 12.0),
		])
		bright_cue.position = Vector2(120.0 + float(index * 18), 120.0)
		bright_cue.color = Color(0.2, 1.0, 0.7, 0.8)
		Area01VisualCueContractScript.tag_node(bright_cue, Area01VisualCueContractScript.FAMILY_RETURN_CURRENT, "fixture_%d" % index)
		cue_parent.add_child(bright_cue)

	var warning_report: Dictionary = Area01VisualCueContractScript.debug_report(main, Rect2(Vector2(0.0, 0.0), Vector2(400.0, 300.0)))
	var warnings: Array = warning_report.get("warnings", [])
	var caught_bright_cluster := false
	for warning in warnings:
		if String(warning).contains(Area01VisualCueContractScript.FAMILY_RETURN_CURRENT):
			caught_bright_cluster = true
	_expect(caught_bright_cluster, "Area 01 cue report should flag too many bright return-current cues in one review region")
	main.free()

func _test_area_01_surface_oxygen_hook_runtime() -> void:
	var scene := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(scene), "Area 01 runtime source map should build before wiring surface oxygen: %s" % builder.last_error)
	scene.player = scene.get_node("Player") as CharacterBody2D
	scene.call("_wire_surface_oxygen_refill_zone")
	var oxygen_area := scene.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/SurfaceOxygenRefillZoneArea") as Area2D
	var offload_area := scene.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/ShipOffloadZoneArea") as Area2D
	_expect(oxygen_area != null, "live Area 01 scene should include the generated surface oxygen hook")
	_expect(offload_area != null, "live Area 01 scene should keep the generated ship offload hook separate")
	if oxygen_area == null or offload_area == null:
		scene.free()
		return

	var oxygen_collision := oxygen_area.get_node_or_null("SurfaceOxygenRefillZoneTrigger") as CollisionPolygon2D
	var offload_collision := offload_area.get_node_or_null("ShipOffloadZoneTrigger") as CollisionPolygon2D
	_expect(oxygen_area.monitoring, "surface oxygen hook should be promoted to active Area2D monitoring")
	_expect(not oxygen_area.monitorable, "surface oxygen hook should not become a blocking/monitorable target")
	_expect(oxygen_area.collision_mask == 1, "surface oxygen hook should monitor the player collision layer")
	_expect(oxygen_collision != null and not oxygen_collision.disabled, "surface oxygen trigger collision should be enabled for refill detection")
	_expect(not offload_area.monitoring, "generated ship offload hook should stay inert until ship offload behavior is implemented")
	_expect(offload_collision != null and offload_collision.disabled, "ship offload hook should not duplicate BaseZone banking")
	if oxygen_collision != null:
		var oxygen_bottom := -INF
		for point in oxygen_collision.polygon:
			oxygen_bottom = maxf(oxygen_bottom, point.y)
		_expect(oxygen_bottom >= 320.0, "surface oxygen trigger should reach the current diver surface clamp")

	scene.dive_session.start()
	scene.dive_session.oxygen = 5.0
	scene.dive_session.has_left_base = true
	scene.dive_session.current_cargo.clear()
	scene.dive_session.current_cargo.append("driftwood")
	scene.player.global_position = Vector2(1600.0, scene.call("_surface_oxygen_refill_floor_y") - 44.0)
	scene.player_in_base = false
	scene.call("_sync_surface_oxygen_refill_state_from_position")
	var banked_before: int = scene.progression_state.resource_count("driftwood")
	scene.call("_update_active_dive_oxygen", 1.0)
	_expect(scene.dive_session.oxygen > 5.0, "surface away from ship should refill oxygen")
	_expect(scene.dive_session.current_cargo == ["driftwood"], "surface away from ship should leave carried cargo in inventory")
	_expect(scene.progression_state.resource_count("driftwood") == banked_before, "surface away from ship should not bank resources")
	_expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "surface away from ship should keep the active dive running")

	var surface_oxygen: float = scene.dive_session.oxygen
	scene.player.global_position = Vector2(1600.0, scene.call("_surface_oxygen_refill_floor_y") + 180.0)
	scene.call("_sync_surface_oxygen_refill_state_from_position")
	scene.call("_update_active_dive_oxygen", 1.0)
	_expect(scene.dive_session.oxygen < surface_oxygen, "leaving the surface refill band should resume oxygen drain")
	scene.free()

func _test_area_01_source_map_debug_overlay() -> void:
	var overlay := Area01SourceMapOverlayScript.new()
	_expect(overlay.load_source_map(), "Area 01 source-map overlay should load the source map")
	var summary := overlay.source_map_summary()
	_expect(int(summary.get("solids", 0)) >= 13, "Area 01 source-map overlay should expose solid terrain count")
	_expect(int(summary.get("hooks", 0)) >= 11, "Area 01 source-map overlay should expose generated hook count")
	_expect(String(summary.get("map_id", "")) == "area_01_runtime_geometry_generated", "Area 01 source-map overlay should expose current generated map revision")
	overlay.capture_state = "area01-central-drop"
	overlay.camera_state = "pos 640,420 zoom 0.60"
	_expect(overlay.capture_state.contains("area01"), "Area 01 source-map overlay should carry capture state for screenshots")
	_expect(overlay.camera_state.contains("zoom"), "Area 01 source-map overlay should carry camera state for screenshots")

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 source-map overlay diagnostic should use built runtime scene: %s" % builder.last_error)
	var truth_errors: Array[String] = overlay.call("_runtime_truth_errors", main)
	_expect(truth_errors.is_empty(), "Area 01 source-map overlay diagnostic should see no runtime truth errors: %s" % "\n".join(truth_errors))
	main.free()

	overlay.set_debug_visible(true)
	_expect(overlay.visible, "Area 01 source-map overlay should become visible only through debug control")
	overlay.set_debug_visible(false)
	_expect(not overlay.visible, "Area 01 source-map overlay should hide through debug control")
	overlay.free()

func _test_area_01_visual_director() -> void:
	var host := Node2D.new()
	var director := Area01VisualDirectorScript.new()
	host.add_child(director)
	var overlay := director.sync_source_map_overlay(host, 96.0, false, true, "area01-central-drop", "pos 640,420 zoom 0.60")
	_expect(overlay != null, "Area 01 visual director should create the source-map overlay")
	_expect(overlay.scan_range == 96.0, "Area 01 visual director should own overlay scan range sync")
	_expect(overlay.capture_state == "area01-central-drop", "Area 01 visual director should own overlay capture-state sync")
	_expect(not overlay.visible, "Area 01 visual director should keep overlay hidden until debug is visible")

	director.sync_source_map_overlay(host, 120.0, true, true, "area01-west-chamber", "pos 800,420 zoom 0.60")
	_expect(director.source_map_overlay_visible(), "Area 01 visual director should expose overlay visibility")
	_expect(overlay.scan_range == 120.0, "Area 01 visual director should update existing overlay scan range")
	_expect(overlay.capture_state == "area01-west-chamber", "Area 01 visual director should update existing overlay capture state")

	var report := director.cue_debug_report(host)
	_expect(report.has("families"), "Area 01 visual director should expose cue-family diagnostics")
	host.free()

func _test_area_01_authoritative_wall_builder() -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 blockout builder should apply source-map wall authority: %s" % builder.last_error)
	if not builder.last_error.is_empty():
		main.free()
		return

	var source_map := _load_area01_source_map_for_tests()
	var terrain_domain: Dictionary = source_map.get("terrain_domain", {})
	var playable_water_regions: Array = source_map.get("playable_water_regions", [])
	var solid_terrain: Array = source_map.get("solid_terrain", [])
	var collisions: Array[CollisionPolygon2D] = []

	var terrain_domain_runtime: Dictionary = terrain_domain.get("runtime_generation", {})
	var expected_domain_polygon := _points_from_source_map_json(terrain_domain.get("polygon", []))
	var terrain_domain_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(terrain_domain_runtime.get("visible_polygon2d_name", ""))) as Polygon2D
	_expect(expected_domain_polygon.size() >= 3, "Area 01 terrain domain should define one continuous source-map polygon")
	_expect(terrain_domain_node != null and terrain_domain_node.visible, "Area 01 builder should render the continuous terrain-domain mass")
	if terrain_domain_node != null:
		_expect(_packed_points_match(terrain_domain_node.polygon, expected_domain_polygon), "Area 01 terrain-domain visual should exactly match the source-map terrain domain")
		_expect(terrain_domain_node.texture != null, "Area 01 terrain-domain visual should use the generated reef fill texture")

	var water_cutout_layer := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/RuntimeSourceWaterCutouts") as Node2D
	var water_edge_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceWaterEdges") as Node2D
	var player_rim_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourcePlayerRims") as Node2D
	var cave_wall_art_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceCaveWallSprites") as Node2D
	var carved_water_count := 0
	var art_slice := main.get_node("Area01ArtSlice") as CanvasItem
	var player_visual_root := main.get_node("Player/VisualRoot") as CanvasItem
	var player_visual_z := _effective_canvas_z(player_visual_root)
	_expect(player_visual_z >= 20, "player visual should render in an actor band above world art")
	_expect(art_slice.z_index >= 0, "Area 01 art slice should stay above opaque ocean backgrounds so cave walls remain visible")
	_expect(_effective_canvas_z(art_slice) < player_visual_z, "Area 01 art slice should stay below actors so generated terrain cannot cover the diver")
	if terrain_domain_node != null:
		_expect(_effective_canvas_z(terrain_domain_node) < player_visual_z, "Area 01 terrain domain should render behind the diver")
	_expect(water_cutout_layer != null, "Area 01 builder should create source-owned playable-water cutouts")
	_expect(water_edge_layer != null, "Area 01 builder should retain hidden playable-water diagnostic edge nodes")
	_expect(player_rim_layer != null, "Area 01 builder should retain the generated rim container for solid terrain")
	_expect(cave_wall_art_layer != null, "Area 01 builder should create generated cave-wall sprite art from playable-water source regions")
	if water_cutout_layer != null:
		_expect(_effective_canvas_z(water_cutout_layer) < player_visual_z, "Area 01 playable-water cutouts should render behind the diver")
	if water_edge_layer != null:
		_expect(_effective_canvas_z(water_edge_layer) < player_visual_z, "Area 01 hidden water edge diagnostics should stay behind the diver")
		_expect(water_edge_layer.find_child("*SpriteRimTrims", true, false) == null, "Area 01 should not scatter generated water-edge sprite trim chunks across cave silhouettes")
	if player_rim_layer != null:
		_expect(_effective_canvas_z(player_rim_layer) < player_visual_z, "Area 01 generated rim helpers should render behind the diver")
	if cave_wall_art_layer != null:
		_expect(_effective_canvas_z(cave_wall_art_layer) < player_visual_z, "Area 01 generated cave-wall sprites should render behind the diver")
		_expect(not _node_tree_contains_collision(cave_wall_art_layer), "Area 01 generated cave-wall sprites should not own collision")
		_expect(cave_wall_art_layer.find_children("*", "Line2D", true, false).is_empty(), "Area 01 generated cave-wall sprites should not add visible or hidden Line2D outlines")
		_expect(cave_wall_art_layer.find_children("*", "Polygon2D", true, false).is_empty(), "Area 01 generated cave-wall sprite layer should not add rectangular polygon debug boxes")
		var wall_sprites := cave_wall_art_layer.find_children("*", "Sprite2D", true, false)
		_expect(wall_sprites.size() >= 24, "Area 01 generated cave-wall sprite layer should add enough edge art to read primary cave corridors")
		for sprite_node in wall_sprites:
			var sprite := sprite_node as Sprite2D
			_expect(sprite != null and sprite.visible and sprite.texture != null, "Area 01 generated cave-wall art should use visible texture sprites")
			if sprite != null:
				_expect(absf(absf(sprite.scale.x) - absf(sprite.scale.y)) <= 0.001, "Area 01 generated cave-wall sprites should use uniform scale instead of stretched sprite fragments: %s" % sprite.name)
				_expect(absf(sprite.scale.x) <= 0.32 and absf(sprite.scale.y) <= 0.32, "Area 01 generated cave-wall sprites should stay trim-sized rather than becoming stretched wall strips: %s" % sprite.name)
	for water_value in playable_water_regions:
		if typeof(water_value) != TYPE_DICTIONARY:
			_expect(false, "Area 01 playable water entry should be a dictionary")
			continue
		var water_entry := water_value as Dictionary
		var water_id := String(water_entry.get("id", "unknown"))
		var runtime_generation: Variant = water_entry.get("runtime_generation", {})
		_expect(runtime_generation is Dictionary, "Area 01 playable water should define runtime generation metadata: %s" % water_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		var cutout: Polygon2D = null
		if water_cutout_layer != null:
			cutout = water_cutout_layer.get_node_or_null(String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		var edge: Line2D = null
		if water_edge_layer != null:
			edge = water_edge_layer.get_node_or_null(String(runtime.get("edge_line2d_name", ""))) as Line2D
		var player_rim_group: Node2D = null
		var player_rim_line: Line2D = null
		if player_rim_layer != null:
			player_rim_group = player_rim_layer.get_node_or_null("%sPlayerRimSprites" % String(runtime.get("edge_line2d_name", ""))) as Node2D
			player_rim_line = player_rim_layer.get_node_or_null("%sPlayerRim" % String(runtime.get("edge_line2d_name", ""))) as Line2D
		var cave_wall_art_group: Node2D = null
		if cave_wall_art_layer != null:
			cave_wall_art_group = cave_wall_art_layer.get_node_or_null("%sWallArt" % _pascal_case_id(water_id)) as Node2D
		if bool(water_entry.get("carves_collision", false)):
			carved_water_count += 1
			_expect(cutout != null and cutout.visible, "Area 01 carving playable water cutout should visibly carve the continuous terrain domain: %s" % water_id)
			_expect(player_rim_line == null, "Area 01 player-facing rim/lip should not be a Line2D debug outline: %s" % water_id)
			_expect(player_rim_group == null, "Area 01 carving playable water should not create separate stretched rim/lip sprite markers: %s" % water_id)
			if water_id == "open_surface_water":
				_expect(cave_wall_art_group == null, "Area 01 open surface should stay open water, not receive cave-wall sprite art")
			else:
				_expect(cave_wall_art_group != null, "Area 01 carving cave/pocket water should receive generated wall sprite art: %s" % water_id)
		else:
			_expect(cutout != null and cutout.visible, "Area 01 non-carving playable water cutout should remain source-visible: %s" % water_id)
			_expect(player_rim_group == null, "Area 01 non-carving playable water should not create a player-facing rim/lip sprite group: %s" % water_id)
		_expect(edge != null and not edge.visible, "Area 01 playable water diagnostic edge should stay hidden: %s" % water_id)
	_expect(carved_water_count >= 6, "Area 01 runtime map should carve traced cave/corridor water from the continuous terrain mass")

	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			_expect(false, "Area 01 authoritative wall entry should be a dictionary")
			continue
		var terrain_entry := terrain as Dictionary
		var terrain_id := String(terrain_entry.get("id", "unknown"))
		var expected_polygon := _points_from_source_map_json(terrain_entry.get("polygon", []))
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		_expect(runtime_generation is Dictionary, "Area 01 authoritative wall entry should define runtime generation metadata: %s" % terrain_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		_expect(String(runtime.get("visual_role", "")) == "generated_solid_partition", "Area 01 generated solid entry should be visible and colliding from one partition polygon: %s" % terrain_id)
		var visible := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		var collision := main.get_node_or_null("Area01ArtSlice/RuntimeSourceCollision/%s" % String(runtime.get("collision_polygon2d_name", ""))) as CollisionPolygon2D
		var lip := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/%s" % String(runtime.get("rim_container_name", ""))) as Polygon2D
		_expect(expected_polygon.size() >= 3, "Area 01 source-map wall should define an authoritative polygon: %s" % terrain_id)
		_expect(visible != null and visible.visible, "Area 01 generated solid partitions should render as visible terrain: %s" % terrain_id)
		_expect(collision != null and not collision.disabled, "Area 01 generated wall collision should be enabled: %s" % terrain_id)
		_expect(lip != null and lip.visible, "Area 01 generated solid partitions should render matching rim/lip reads: %s" % terrain_id)
		if visible != null:
			_expect(_packed_points_match(visible.polygon, expected_polygon), "Area 01 wall visual should exactly match source-map polygon: %s" % terrain_id)
		if collision != null:
			_expect(_packed_points_match(collision.polygon, expected_polygon), "Area 01 wall collision should exactly match source-map polygon: %s" % terrain_id)
			collisions.append(collision)
		if lip != null:
			_expect(_packed_points_match(lip.polygon, expected_polygon), "Area 01 wall rim/lip should exactly match source-map polygon: %s" % terrain_id)

	var legacy_collision_root := main.get_node("Area01ArtSlice/TerrainCollision") as StaticBody2D
	for child in legacy_collision_root.get_children():
		if child is CollisionPolygon2D:
			_expect((child as CollisionPolygon2D).disabled, "legacy Area 01 blockout collision should be disabled after runtime-v3 builder promotion: %s" % child.name)
	var legacy_terrain_root := main.get_node("Area01ArtSlice/TerrainBackWalls") as Node2D
	for child in legacy_terrain_root.get_children():
		if child is Polygon2D:
			_expect(not (child as Polygon2D).visible, "legacy Area 01 blockout terrain should be hidden behind runtime-v3 source terrain: %s" % child.name)

	for open_point in [
		Vector2(560.0, 620.0),
		Vector2(1660.0, 620.0),
		Vector2(1900.0, 1240.0),
		Vector2(2920.0, 620.0),
	]:
		_expect(not _point_inside_any_collision(open_point, collisions), "reported Area 01 open water should not contain a hidden generated blocker: %s" % open_point)

	var background_mid := main.get_node("Area01ArtSlice/BackgroundMid") as Node2D
	var foreground_decor := main.get_node("Area01ArtSlice/ForegroundDecor") as Node2D
	var platform_kit := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit") as Node2D
	var background_far := main.get_node("Area01ArtSlice/BackgroundFar") as CanvasItem
	var parallax_background := main.get_node("Area01ArtSlice/OceanParallaxBackground") as CanvasItem
	var lighting_stack := main.get_node("Area01ArtSlice/OceanLightingStack") as CanvasItem
	var water_light_shafts := main.get_node("Area01ArtSlice/WaterLightShafts") as CanvasItem
	var wall_dressing_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapWallDressing") as Node2D
	var tile_terrain_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapTileTerrain") as Node2D
	var terrain_accent_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapTerrainAccents") as Node2D
	_expect(not background_mid.visible, "Area 01 builder should hide old mid-background wall-like shapes during wall-map rescue")
	_expect(not foreground_decor.visible, "Area 01 builder should hide foreground dressing during wall-map rescue")
	_expect(not platform_kit.visible, "Area 01 builder should hide old decorative platform overlays during wall-map rescue")
	_expect(background_far.modulate.a <= 0.13, "Area 01 far background should be demoted below source-map terrain")
	_expect(parallax_background.modulate.a <= 0.17, "Area 01 parallax background should not compete with source-map terrain")
	_expect(lighting_stack.modulate.a <= 0.29, "Area 01 broad lighting stack should not read as blocking terrain")
	_expect(water_light_shafts.modulate.a <= 0.25, "Area 01 light shafts should stay secondary to collision-source terrain")
	_expect(wall_dressing_layer == null, "Area 01 builder should not keep the old shape-dressing layer")
	_expect(tile_terrain_layer == null, "Area 01 builder should not render rectangular atlas tiles over arbitrary wall polygons")
	if terrain_accent_layer != null:
		_expect(not _node_tree_contains_collision(terrain_accent_layer), "Area 01 terrain accents should not add collision ownership")
		_expect(terrain_accent_layer.find_child("VerticalWallMiddleTrim*", true, false) == null, "Area 01 terrain accents should not auto-place vertical wall trims without semantic source-map segments")
		_expect(terrain_accent_layer.find_child("DiagonalSlopeTrim*", true, false) == null, "Area 01 terrain accents should not auto-place slope trims without semantic source-map segments")
	var generated_terrain := main.get_node("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain") as Node2D
	var first_generated_wall: Polygon2D = null
	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			continue
		var terrain_entry := terrain as Dictionary
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		first_generated_wall = generated_terrain.get_node_or_null(String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		if first_generated_wall != null:
			break
	_expect(first_generated_wall != null, "Area 01 generated source-map terrain should include visible generated solid partitions")
	if first_generated_wall != null:
		_expect(first_generated_wall.color.a >= 0.9, "Area 01 generated source-map terrain should read as solid wall/floor, not translucent background dressing")
		_expect(first_generated_wall.texture != null, "Area 01 generated solid partitions should carry terrain fill texture instead of relying on a flat hidden domain")
		_expect(first_generated_wall.visible, "Area 01 generated solid partition should be player-facing terrain")
	main.free()

func _test_area_01_starter_resource_pocket_placement() -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	_expect(builder.build(main), "Area 01 starter resource placement test should use runtime source-map collision: %s" % builder.last_error)
	var source_map := _load_area01_source_map_for_tests()
	var hooks_by_id := {}
	for hook_value in source_map.get("scene_hooks", []):
		if typeof(hook_value) == TYPE_DICTIONARY:
			hooks_by_id[String((hook_value as Dictionary).get("id", ""))] = hook_value

	var collisions := _area01_enabled_collision_polygons(main)
	for hook_id in ["starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		_expect(hooks_by_id.has(hook_id), "Area 01 generated source map should include starter resource hook: %s" % hook_id)
		if not hooks_by_id.has(hook_id):
			continue
		var hook := hooks_by_id[hook_id] as Dictionary
		_expect(String(hook.get("type", "")) == "pickup", "starter resource hook should be typed as pickup: %s" % hook_id)
		_expect(not String(hook.get("resource", "")).is_empty(), "starter resource hook should name its resource family: %s" % hook_id)
		var runtime := hook.get("runtime_generation", {}) as Dictionary
		var area := main.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % String(runtime.get("area2d_name", ""))) as Area2D
		_expect(area != null, "starter resource hook should build a generated Area2D: %s" % hook_id)
		if area == null:
			continue
		var collision := area.get_node_or_null(String(runtime.get("collision_polygon2d_name", ""))) as CollisionPolygon2D
		_expect(collision != null and collision.disabled, "starter resource hook should stay inert/nonblocking until gameplay promotes it: %s" % hook_id)
		var points := _points_from_source_map_json(hook.get("points", []))
		_expect(points.size() >= 3, "starter resource hook should have generated polygon points: %s" % hook_id)
		if points.size() >= 3:
			var center := Vector2.ZERO
			for point in points:
				center += point
			center /= float(points.size())
			_expect(not _point_inside_any_collision(center, collisions), "starter resource hook should not sit inside generated Area 01 terrain collision: %s" % hook_id)
	main.free()

func _area01_enabled_collision_polygons(main: Node) -> Array[CollisionPolygon2D]:
	var collisions: Array[CollisionPolygon2D] = []
	var terrain_collision := main.get_node_or_null("Area01ArtSlice/TerrainCollision")
	if terrain_collision == null:
		return collisions

	for child in terrain_collision.get_children():
		if child is CollisionPolygon2D and not (child as CollisionPolygon2D).disabled:
			collisions.append(child as CollisionPolygon2D)

	var runtime_collision := main.get_node_or_null("Area01ArtSlice/RuntimeSourceCollision")
	if runtime_collision != null:
		for child in runtime_collision.get_children():
			if child is CollisionPolygon2D and not (child as CollisionPolygon2D).disabled:
				collisions.append(child as CollisionPolygon2D)

	return collisions

func _point_inside_any_collision(global_point: Vector2, collisions: Array[CollisionPolygon2D]) -> bool:
	for collision in collisions:
		if Geometry2D.is_point_in_polygon(collision.to_local(global_point), collision.polygon):
			return true

	return false

func _effective_canvas_z(node: Node) -> int:
	var effective_z := 0
	var current: Node = node
	var include_parent_z := true
	while current != null:
		if current is CanvasItem:
			var canvas_item := current as CanvasItem
			if include_parent_z:
				effective_z += canvas_item.z_index
				include_parent_z = canvas_item.z_as_relative
			else:
				break
		current = current.get_parent()
	return effective_z

func _node_tree_contains_collision(node: Node) -> bool:
	if node is CollisionPolygon2D or node is CollisionShape2D:
		return true

	for child in node.get_children():
		if _node_tree_contains_collision(child):
			return true

	return false

func _load_area01_source_map_for_tests() -> Dictionary:
	var file := FileAccess.open("res://data/maps/area_01_runtime_geometry.generated.json", FileAccess.READ)
	if file == null:
		return {}
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return {}
	return parsed as Dictionary

func _points_from_source_map_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points
	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))
	return points

func _packed_points_match(actual: PackedVector2Array, expected: PackedVector2Array) -> bool:
	if actual.size() != expected.size():
		return false
	for index in range(actual.size()):
		if actual[index].distance_to(expected[index]) > 0.01:
			return false
	return true

func _pascal_case_id(value: String) -> String:
	var result := ""
	for part in value.split("_", false):
		if part.is_empty():
			continue
		result += part.substr(0, 1).to_upper() + part.substr(1)
	return result

func _test_area_01_cave_mouth_affordances() -> void:
	var main := MainScene.instantiate()
	var root := main.get_node("Area01ArtSlice/GameplayObjects/CaveMouthAffordances") as Node2D
	var left_mouth := root.get_node("LeftCaveMouth") as Node2D
	var right_mouth := root.get_node("RightChamberMouth") as Node2D
	var future_seal := root.get_node("LowerBasinFutureSeal") as Node2D
	var left_shadow := left_mouth.get_node("MouthShadow") as Polygon2D
	var left_wash := left_mouth.get_node("EntryWaterWash") as Polygon2D
	var left_rim := left_mouth.get_node("UpperRim") as Polygon2D
	var right_shadow := right_mouth.get_node("MouthShadow") as Polygon2D
	var right_wash := right_mouth.get_node("EntryWaterWash") as Polygon2D
	var future_mouth := future_seal.get_node("SealMouth") as Polygon2D
	var future_veil := future_seal.get_node("PressureVeil") as Polygon2D
	var future_bars := future_seal.get_node("SealBars") as Polygon2D
	var future_glint := future_seal.get_node("FutureGlint") as Polygon2D
	_expect(root.find_child("CollisionShape2D", true, false) == null, "Area 01 cave-mouth affordances should not add hidden collision")
	_expect(root.find_child("CollisionPolygon2D", true, false) == null, "Area 01 cave-mouth affordances should not add player blockers")
	_expect(root.find_child("Label", true, false) == null, "Area 01 cave-mouth affordances should not rely on labels for comprehension")
	_expect(left_shadow.color.a >= 0.6 and right_shadow.color.a >= 0.55, "reachable cave mouths should use dark negative space so openings read apart from solid reef")
	_expect(left_wash.color.a <= 0.16 and right_wash.color.a <= 0.14, "reachable cave-mouth water washes should stay subtle instead of becoming route arrows")
	_expect(left_rim.color.a > left_wash.color.a, "reachable cave-mouth rims should frame the opening more clearly than the water wash")
	_expect(future_mouth.color.a < left_shadow.color.a, "future sealed mouth should be quieter than current reachable cave openings")
	_expect(future_veil.color.a < left_wash.color.a and future_bars.color.a < left_rim.color.a, "future route promise should stay lower priority than current cave affordances")
	_expect(future_glint.color.a < left_rim.color.a, "future glint should invite curiosity without reading as a collectible")
	main.free()

func _test_area_01_reusable_reef_visual_kit() -> void:
	var main := MainScene.instantiate()
	var wall_paths := [
		"Area01ArtSlice/TerrainVisualEdges/LeftWallReefKit/ReefRockStack",
		"Area01ArtSlice/TerrainVisualEdges/RightWallReefKit/ReefRockStack",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeReefKit/TopLipHighlight",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeReefKit/TopLipHighlight",
	]
	for path in wall_paths:
		var wall_piece := main.get_node(path) as Polygon2D
		_expect(wall_piece != null, "Area 01 shell wall and ledge should use the reusable reef visual kit: %s" % path)
		_expect(wall_piece.color.a <= 0.8, "reusable reef wall dressing should stay below pickup/scan brightness: %s" % path)

	var pocket_paths := [
		"Area01ArtSlice/GameplayObjects/LeftShallowResourcePocket/ReusablePocketArt/ResourceBed",
		"Area01ArtSlice/GameplayObjects/RightShelfResourcePocket/ReusablePocketArt/ResourceBed",
		"Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket/ReusablePocketArt/CargoReadGap",
		"Area01ArtSlice/GameplayObjects/RightDeepResourcePocket/ReusablePocketArt/CargoReadGap",
	]
	for path in pocket_paths:
		var pocket_piece := main.get_node(path) as Polygon2D
		_expect(pocket_piece != null, "Area 01 resource pockets should use the reusable pocket visual kit: %s" % path)
		_expect(pocket_piece.color.a <= 0.5, "resource pocket dressing should support cargo readability without becoming the reward: %s" % path)
	main.free()

func _test_landmark_region_identity_metadata() -> void:
	var main := MainScene.instantiate()
	var metadata_root := main.get_node("LandmarkMetadata")
	var expected_regions := {
		"SurfaceBase": "Surface Base",
		"ShellReef": "Shell Reef",
		"EastShelfArch": "East Shelf Spur",
		"DropArch": "Shelf Drop Connector",
		"BlueChimney": "Blue Chimney Pocket",
		"SiltVeinFork": "Silt Vein Fork",
		"DuskTrench": "Dusk Trench",
		"HollowReef": "Hollow Reef",
		"GlassRibSpan": "Wide Reef Chamber",
		"LowCrownShelf": "Wide Reef Chamber",
		"MirrorKelpPass": "Mirror Kelp Pass",
		"ThermalVentField": "Thermal Vent Field",
		"WreckShelf": "Wreck Shelf",
		"PressureLockedWreck": "Wreck Shelf",
		"GulperRoute": "Gulper Route",
	}

	for node_name in expected_regions.keys():
		var landmark := metadata_root.get_node(node_name)
		_expect(String(landmark.get("stable_region_name")) == expected_regions[node_name], "landmark should expose stable region name: %s" % node_name)
		_expect(not String(landmark.get("memory_goal")).is_empty(), "landmark should describe its player memory goal: %s" % node_name)
		_expect(not String(landmark.get("memory_goal")).to_lower().contains("coordinate"), "landmark should avoid exact-coordinate memory language: %s" % node_name)
		_expect(not String(landmark.get("memory_goal")).to_lower().contains("marker"), "landmark should avoid map-marker memory language: %s" % node_name)
		_expect(not String(landmark.get("memory_goal")).to_lower().contains("objective"), "landmark should avoid objective/checklist language: %s" % node_name)

	main.free()

func _test_predator_scan_target() -> void:
	var predator := PredatorScript.new()
	predator.discovery_id = "gulper_eel"
	predator.display_name = "Gulper Eel"
	predator.description = "Predator profile."
	predator.global_position = Vector2(12.0, 0.0)

	_expect(ScanTargetResolverScript.is_valid_target(predator), "visible predator with discovery id should be a scan target")
	_expect(ScanTargetResolverScript.target_id(predator) == "gulper_eel", "predator scan target should expose discovery id")
	_expect(ScanTargetResolverScript.display_name(predator) == "Gulper Eel", "predator scan target should expose display name")
	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, [predator])
	_expect(selected == predator, "scanner resolver should select the predator when it is in range")

	predator.visible = false
	_expect(not ScanTargetResolverScript.is_valid_target(predator), "hidden predator should not be a valid scan target")
	predator.free()

func _test_discovery_prerequisites() -> void:
	var progression := ProgressionStateScript.new()

	_expect(OxygenTankUpgrade.required_discovery.is_empty(), "Oxygen Tank I should not require a discovery")
	_expect(PressureSealUpgrade.required_discovery == "thermal_vent", "Pressure Seal I should require Thermal Vent")
	_expect(SignalLensUpgrade.required_discovery == "wreck_signal_cache", "Signal Lens I should require Wreck Signal Cache")
	_expect(EchoLensUpgrade.required_discovery == "wreck_signal_cache", "Echo Lens I should require Wreck Signal Cache")
	_expect(EchoLensUpgrade.required_upgrade == SignalLensUpgrade.id, "Echo Lens I should require Signal Lens I")
	_expect(EchoLensUpgrade.effect_id == "echo_lens_wreck_echo", "Echo Lens I should use the broad wreck echo effect id")
	_expect(int(EchoLensUpgrade.resource_cost.get("glow_plankton", 0)) == 3, "Echo Lens I should cost three glow plankton")
	_expect(int(EchoLensUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Echo Lens I should cost one kelp fiber")
	_expect(int(EchoLensUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Echo Lens I should cost two shell fragments")
	_expect(ResonanceKeyUpgrade.id == "resonance_key_1", "Resonance Key I should have a stable upgrade id")
	_expect(ResonanceKeyUpgrade.required_discovery == "east_shelf_route_research", "Resonance Key I should require recovered East Shelf or Drop Echo research context")
	_expect(ResonanceKeyUpgrade.required_upgrade == EchoLensUpgrade.id, "Resonance Key I should require Echo Lens I")
	_expect(ResonanceKeyUpgrade.effect_id == "resonance_key_1", "Resonance Key I should use a hatch-specific effect id")
	_expect(int(ResonanceKeyUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Resonance Key I should cost two glow plankton")
	_expect(int(ResonanceKeyUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Resonance Key I should cost one shell fragment")
	_expect(not ResonanceKeyUpgrade.resource_cost.has("kelp_fiber"), "Resonance Key I should avoid broad material spread for the first hatch key")
	_expect(ResonanceKeyUpgrade.description.contains("hatch-specific"), "Resonance Key I description should stay narrow")
	_expect(not ResonanceKeyUpgrade.description.to_lower().contains("all sealed"), "Resonance Key I should not imply a broad key family")
	_expect(CargoRackUpgrade.required_discovery.is_empty(), "Cargo Rack I should not require a discovery")
	_expect(CargoRackUpgrade.effect_id == "cargo_limit_4", "Cargo Rack I should use cargo limit effect")
	_expect(WaterFilterUpgrade.id == "water_filter_1", "Water Filter I should have a stable upgrade id")
	_expect(WaterFilterUpgrade.required_discovery.is_empty(), "Water Filter I should not require a discovery")
	_expect(WaterFilterUpgrade.required_upgrade.is_empty(), "Water Filter I should not require another upgrade")
	_expect(WaterFilterUpgrade.effect_id == "water_reserve_1", "Water Filter I should use the water reserve effect")
	_expect(int(WaterFilterUpgrade.resource_cost.get("driftwood", 0)) == 1, "Water Filter I should cost one driftwood")
	_expect(int(WaterFilterUpgrade.resource_cost.get("quartz_glass", 0)) == 1, "Water Filter I should cost one quartz glass")
	_expect(WaterFilterUpgrade.description.contains("starter salvage"), "Water Filter I should explain starter-material purpose")
	_expect(PredatorWarningUpgrade.required_discovery == "gulper_eel", "Predator Warning I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_discovery == "gulper_eel", "Decoy Pulse I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_upgrade == PredatorWarningUpgrade.id, "Decoy Pulse I should require Predator Warning I")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Decoy Pulse I should cost two glow plankton")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Decoy Pulse I should cost one kelp fiber")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Decoy Pulse I should cost one shell fragment")
	_expect(SalvageCutterUpgrade.id == "salvage_cutter_1", "Salvage Cutter I should have a stable upgrade id")
	_expect(SalvageCutterUpgrade.required_discovery == "salvage_data_cache", "Salvage Cutter I should require recovered salvage-cache evidence")
	_expect(SalvageCutterUpgrade.required_upgrade.is_empty(), "Salvage Cutter I should not create a broad prerequisite chain")
	_expect(SalvageCutterUpgrade.effect_id == "salvage_cutter_1", "Salvage Cutter I should use a narrow scoped effect id")
	_expect(int(SalvageCutterUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Salvage Cutter I should cost one existing kelp fiber")
	_expect(int(SalvageCutterUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Salvage Cutter I should cost two existing shell fragments")
	_expect(not SalvageCutterUpgrade.resource_cost.has("glow_plankton"), "Salvage Cutter I should avoid a broad material spread")
	_expect(SalvageCutterUpgrade.description.contains("Wide Reef"), "Salvage Cutter I should stay tied to Wide Reef")
	_expect(not SalvageCutterUpgrade.description.to_lower().contains("all sealed"), "Salvage Cutter I should not imply opening every sealed route")
	_expect(UpgradePurchaseScript.missing_discovery(progression, OxygenTankUpgrade) == "", "upgrade with no prerequisite should not be locked")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "thermal_vent", "Pressure Seal I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "wreck_signal_cache", "Signal Lens I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "wreck_signal_cache", "Echo Lens I discovery prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == SignalLensUpgrade.id, "Echo Lens I upgrade prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, ResonanceKeyUpgrade) == "east_shelf_route_research", "Resonance Key I route-research prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, ResonanceKeyUpgrade) == EchoLensUpgrade.id, "Resonance Key I Echo Lens prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, CargoRackUpgrade) == "", "Cargo Rack I prerequisite should be satisfied by default")
	_expect(UpgradePurchaseScript.missing_discovery(progression, WaterFilterUpgrade) == "", "Water Filter I prerequisite should be satisfied by default")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "gulper_eel", "Predator Warning I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == PredatorWarningUpgrade.id, "Decoy Pulse I upgrade prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SalvageCutterUpgrade) == "salvage_data_cache", "Salvage Cutter I prerequisite should start missing")
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "", "Pressure Seal I prerequisite should be satisfied by Thermal Vent discovery")
	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "", "Signal Lens I prerequisite should be satisfied by Wreck Signal Cache discovery")
	_expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "", "Echo Lens I discovery prerequisite should be satisfied by Wreck Signal Cache discovery")
	_expect(not UpgradePurchaseScript.purchase(progression, EchoLensUpgrade), "Echo Lens I should not purchase before Signal Lens I")
	progression.purchased_upgrades[SignalLensUpgrade.id] = true
	_expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == "", "Echo Lens I upgrade prerequisite should be satisfied by Signal Lens I")
	progression.purchased_upgrades[EchoLensUpgrade.id] = true
	_expect(UpgradePurchaseScript.missing_upgrade(progression, ResonanceKeyUpgrade) == "", "Resonance Key I upgrade prerequisite should be satisfied by Echo Lens I")
	_expect(UpgradePurchaseScript.missing_discovery(progression, ResonanceKeyUpgrade) == "east_shelf_route_research", "Resonance Key I should remain locked until route research is promoted by a later issue")
	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "", "Predator Warning I prerequisite should be satisfied by Gulper Eel discovery")
	_expect(UpgradePurchaseScript.missing_discovery(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I discovery prerequisite should be satisfied by Gulper Eel discovery")
	_expect(not UpgradePurchaseScript.purchase(progression, DecoyPulseUpgrade), "Decoy Pulse I should not purchase before Predator Warning I")
	progression.purchased_upgrades[PredatorWarningUpgrade.id] = true
	_expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I upgrade prerequisite should be satisfied by Predator Warning I")
	progression.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SalvageCutterUpgrade) == "", "Salvage Cutter I prerequisite should be satisfied by recovered cache evidence")

func _test_predator_warning_upgrade_metadata() -> void:
	_expect(PredatorWarningUpgrade.id == "predator_warning_1", "Predator Warning I should have a stable upgrade id")
	_expect(PredatorWarningUpgrade.effect_id == "predator_warning_range_1", "Predator Warning I should use the warning range effect")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Predator Warning I should cost one kelp fiber")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Predator Warning I should cost two shell fragments")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("glow_plankton", 0)) == 1, "Predator Warning I should cost one glow plankton")

	var predator := PredatorScript.new()
	predator.detect_radius = 100.0
	_expect(is_equal_approx(predator.warning_radius(), 145.0), "default predator warning radius should stay at the original lead distance")
	predator.set_warning_radius_multiplier(1.8)
	_expect(is_equal_approx(predator.warning_radius(), 180.0), "Predator Warning I should widen only the warning radius")
	_expect(is_equal_approx(predator.detect_radius, 100.0), "Predator Warning I should not change chase detection radius")
	predator.free()

func _test_predator_warning_effect_isolation() -> void:
	var main := MainScript.new()
	main.max_oxygen = 30.0
	main.oxygen_tank_1_max_oxygen = 40.0
	main.base_cargo_limit = 3
	main.cargo_rack_1_limit = 4
	main.dive_session.reset(30.0)
	main.dive_session.cargo_limit = main.base_cargo_limit
	main.progression_state.purchased_upgrades = {
		PredatorWarningUpgrade.id: true,
	}

	main._apply_upgrade_effect(PredatorWarningUpgrade.effect_id)

	_expect(main._current_max_oxygen() == 30.0, "Predator Warning I should not apply Oxygen Tank I max oxygen")
	_expect(main._current_cargo_limit() == 3, "Predator Warning I should not apply Cargo Rack I capacity")
	_expect(main.dive_session.cargo_limit == 3, "Predator Warning I should not mutate current dive cargo capacity")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Predator Warning I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Predator Warning I should not grant Signal Lens I")
	main.free()

func _test_decoy_pulse_effect_isolation() -> void:
	var main := MainScript.new()
	main.base_cargo_limit = 3
	main.dive_session.reset(30.0)
	main.dive_session.cargo_limit = main.base_cargo_limit
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.run_predator_contacts = 0
	main.progression_state.purchased_upgrades = {
		PredatorWarningUpgrade.id: true,
		DecoyPulseUpgrade.id: true,
	}

	main._apply_upgrade_effect(DecoyPulseUpgrade.effect_id)

	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Decoy Pulse I purchase should not change dive result state")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Decoy Pulse I purchase should not change carried cargo")
	_expect(main.dive_session.cargo_limit == 3, "Decoy Pulse I purchase should not change cargo capacity")
	_expect(main.run_predator_contacts == 0, "Decoy Pulse I purchase should not create predator contact")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Decoy Pulse I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Decoy Pulse I should not grant Signal Lens I")
	main.free()

func _test_echo_lens_effect_isolation() -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.purchased_upgrades = {
		SignalLensUpgrade.id: true,
		EchoLensUpgrade.id: true,
	}

	main._apply_upgrade_effect(EchoLensUpgrade.effect_id)

	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Echo Lens I purchase should not change dive result state")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Echo Lens I purchase should not change carried cargo")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Echo Lens I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(DecoyPulseUpgrade.id), "Echo Lens I should not grant Decoy Pulse I")
	main.free()

func _test_expedition_prep_goals() -> void:
	var upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]
	var progression := ProgressionStateScript.new()

	var goal := ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Oxygen Tank I"), "fresh prep goal should point at Oxygen Tank I")
	_expect(goal.contains("Kelp Fiber x2"), "fresh prep goal should list missing oxygen tank kelp")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal == "Goal: buy Oxygen Tank I in the upgrade bay after this dive.", "affordable prep goal should point to purchase")

	progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Thermal Vent"), "locked pressure seal goal should point at Thermal Vent")
	_expect(goal.contains("Pressure Seal I"), "locked pressure seal goal should name the upgrade")

	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("bank"), "unlocked pressure seal goal should point back to banking")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PressureSealUpgrade.id, PressureSealUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Wreck Signal Cache"), "locked signal lens goal should point at Wreck Signal Cache")

	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(SignalLensUpgrade.id, SignalLensUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Cargo Rack I"), "signal lens ownership should advance goal to Cargo Rack I")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(CargoRackUpgrade.id, CargoRackUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Gulper Eel"), "cargo rack ownership should advance goal to Predator Warning I scan prerequisite")

	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Predator Warning I"), "gulper observation should advance goal to Predator Warning I resources")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PredatorWarningUpgrade.id, PredatorWarningUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Decoy Pulse I"), "predator warning ownership should advance goal to Decoy Pulse I")
	_expect(goal.contains("Glow Plankton x2"), "decoy prep goal should show missing planned glow cost")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	progression.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Shell Reef"), "completed upgrade goals should preserve a safer bank route")
	_expect(goal.contains("Shelf Drop"), "completed upgrade goals should mention the lower connector broadly")
	_expect(goal.contains("Blue Chimney"), "completed upgrade goals should mention the lower-pocket payoff broadly")
	_expect(goal.contains("if oxygen allows"), "completed upgrade lower-pocket goal should remain optional")
	_expect(goal.contains("return safely"), "completed upgrade lower-pocket goal should preserve extraction pressure")
	_expect_no_echo_lens_locator_language(goal, "completed upgrade lower-pocket goal")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades, "rare_signal")
	_expect(goal.contains("East Shelf"), "Rare Signal should still give completed-upgrade players a reason to visit East Shelf")
	_expect(goal.contains("Blue Chimney"), "Rare Signal should sometimes point completed-upgrade players toward the lower pocket")
	_expect(goal.contains("if oxygen allows"), "Rare Signal route goal should remain optional rather than a checklist")
	_expect(goal.contains("return safely"), "Rare Signal route goal should preserve extraction pressure")
	_expect(not goal.contains("Blackwater"), "Rare Signal should not point at Blackwater before the scoped key is owned")

	var full_upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		EchoLensUpgrade,
		ResonanceKeyUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
		SalvageCutterUpgrade,
	]
	var salvage_goal_progression := ProgressionStateScript.new()
	for upgrade in full_upgrades:
		if upgrade.id != SalvageCutterUpgrade.id:
			salvage_goal_progression.purchased_upgrades[upgrade.id] = true
	goal = ExpeditionGoalFormatterScript.format_goal(salvage_goal_progression, full_upgrades)
	_expect(goal.contains("recover Salvage Data Cache"), "prepared players should get a salvage-cache recovery goal before Salvage Cutter I")
	_expect(goal.contains("Salvage Cutter I"), "salvage-cache recovery goal should name the new cutter upgrade")
	salvage_goal_progression.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	goal = ExpeditionGoalFormatterScript.format_goal(salvage_goal_progression, full_upgrades)
	_expect(goal.contains("bank"), "Salvage Cutter I should ask for existing resources after evidence is recovered")
	_expect(goal.contains("Shell Fragments"), "Salvage Cutter I resource goal should use existing Shell Fragments")

	var blackwater_ready_progression := ProgressionStateScript.new()
	for upgrade in full_upgrades:
		blackwater_ready_progression.purchased_upgrades[upgrade.id] = true
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "rare_signal")
	_expect(goal.contains("Blackwater"), "Rare Signal should nudge Blackwater once the scoped key path is ready")
	_expect(goal.contains("if oxygen allows"), "Blackwater Rare Signal goal should stay optional")
	_expect(goal.contains("return safely"), "Blackwater Rare Signal goal should preserve extraction pressure")
	_expect_no_echo_lens_locator_language(goal, "Blackwater Rare Signal goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades)
	_expect(goal.contains("Blackwater"), "prepared completed-upgrade goal should suggest the lower route outside Rare Signal")
	_expect(goal.contains("if oxygen allows"), "prepared completed-upgrade lower-route goal should stay optional")
	_expect(goal.contains("return safely"), "prepared completed-upgrade lower-route goal should preserve extraction pressure")
	_expect_no_echo_lens_locator_language(goal, "prepared completed-upgrade lower-route goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Blackwater")
	_expect(goal.contains("Blackwater"), "recent Blackwater memory should keep the ready nudge on the same broad route")
	_expect(goal.contains("Dusk"), "recent Blackwater memory should point the next dive toward Dusk")
	_expect_no_echo_lens_locator_language(goal, "recent Blackwater ready goal")
	var save_before_recent_goal: Dictionary = blackwater_ready_progression.to_save_data().duplicate(true)
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Dusk Trench")
	_expect(goal.contains("Dusk"), "recent Dusk memory should keep the ready nudge broad")
	_expect(goal.contains("Hollow Reef"), "recent Dusk memory should point toward the side-cave branch")
	_expect_no_echo_lens_locator_language(goal, "recent Dusk ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Hollow Reef")
	_expect(goal.contains("Hollow Reef"), "recent Hollow Reef memory should keep the ready nudge broad")
	_expect(goal.contains("wide chamber"), "recent Hollow Reef memory should point toward the wider chamber")
	_expect(goal.contains("if oxygen allows"), "recent Hollow Reef chamber goal should stay optional")
	_expect(goal.contains("return safely"), "recent Hollow Reef chamber goal should preserve extraction pressure")
	_expect_no_echo_lens_locator_language(goal, "recent Hollow Reef chamber goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Wide Reef Chamber")
	_expect(goal.contains("Wide Reef"), "recent Wide Reef Chamber memory should keep the ready nudge broad")
	_expect(goal.contains("Salvage Cutter I"), "recent Wide Reef Chamber memory should mention the owned narrow tool")
	_expect(goal.contains("if oxygen allows"), "recent Wide Reef Chamber ready goal should keep the return payoff optional")
	_expect(goal.contains("Hollow Reef"), "recent Wide Reef Chamber ready goal should preserve broad return-route language")
	_expect(not goal.to_lower().contains("buy"), "recent Wide Reef Chamber ready goal should not imply another cutter purchase")
	_expect(not goal.to_lower().contains("upgrade bay"), "recent Wide Reef Chamber ready goal should not create upgrade-bay promise copy")
	_expect(not goal.to_lower().contains("craft"), "recent Wide Reef Chamber ready goal should not introduce crafting")
	_expect_no_echo_lens_locator_language(goal, "recent Wide Reef Chamber ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Mirror Kelp Pass")
	_expect(goal.contains("Mirror Kelp"), "recent Mirror Kelp memory should keep the ready nudge on the new branch")
	_expect(goal.contains("deep-kelp seal"), "recent Mirror Kelp memory should point toward the branch promise")
	_expect(goal.contains("if oxygen allows"), "recent Mirror Kelp ready goal should stay optional")
	_expect(goal.contains("Wide Reef"), "recent Mirror Kelp ready goal should keep broad return-route language")
	_expect(not goal.to_lower().contains("checklist"), "recent Mirror Kelp ready goal should not imply a checklist")
	_expect(not goal.to_lower().contains("map"), "recent Mirror Kelp ready goal should not imply map UI")
	_expect_no_echo_lens_locator_language(goal, "recent Mirror Kelp ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Glass Rim")
	_expect(goal.contains("Glass Rim"), "recent Glass Rim memory should keep the ready nudge on the new payoff place")
	_expect(goal.contains("timing"), "recent Glass Rim ready goal should preserve the timing choice")
	_expect(goal.contains("cargo"), "recent Glass Rim ready goal should preserve the cargo alternative")
	_expect(goal.contains("sealed rim promise"), "recent Glass Rim ready goal should tease the broad future promise")
	_expect(goal.contains("if oxygen allows"), "recent Glass Rim ready goal should stay optional")
	_expect(goal.contains("Mirror/Wide/Hollow"), "recent Glass Rim ready goal should preserve broad return-route language")
	_expect(not goal.to_lower().contains("checklist"), "recent Glass Rim ready goal should not imply a checklist")
	_expect(not goal.to_lower().contains("map"), "recent Glass Rim ready goal should not imply map UI")
	_expect_no_echo_lens_locator_language(goal, "recent Glass Rim ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Outer Shelf")
	_expect(goal.contains("Outer Shelf"), "recent Outer Shelf memory should keep the ready nudge on Area 02")
	_expect(goal.contains("Glass Rim"), "recent Outer Shelf ready goal should tease the timing branch")
	_expect(goal.contains("Kelp Fiber cargo"), "recent Outer Shelf ready goal should preserve the cargo-vs-knowledge choice")
	_expect(goal.contains("if oxygen allows"), "recent Outer Shelf ready goal should keep the return payoff optional")
	_expect(goal.contains("Mirror/Wide/Hollow"), "recent Outer Shelf ready goal should preserve broad return-route language")
	_expect(not goal.to_lower().contains("checklist"), "recent Outer Shelf ready goal should not imply a checklist")
	_expect(not goal.to_lower().contains("map"), "recent Outer Shelf ready goal should not imply map UI")
	_expect_no_echo_lens_locator_language(goal, "recent Outer Shelf ready goal")
	var save_after_recent_goal: Dictionary = blackwater_ready_progression.to_save_data()
	_expect(save_after_recent_goal == save_before_recent_goal, "ready route suggestions should not mutate save data")
	_expect(not save_after_recent_goal.has("recent_route_memory"), "ready route suggestions should not add route memory to the save schema")
	_expect(not save_after_recent_goal.has("ready_goal"), "ready route suggestions should not add goal state to the save schema")
	_expect(not save_after_recent_goal.has("future_cutter"), "salvage cutter prep should not add obsolete tool state keys")

	var incomplete_progression := ProgressionStateScript.new()
	var incomplete_goal := ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "rare_signal")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Rare Signal route goal should not override upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Blackwater")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "recent route memory should not override incomplete upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Hollow Reef")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Hollow Reef chamber memory should not override incomplete upgrade progression goals")
	_expect(not incomplete_goal.contains("wide chamber"), "wide chamber ready goal should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Mirror Kelp Pass")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Mirror Kelp ready goal should not override incomplete upgrade progression goals")
	_expect(not incomplete_goal.contains("deep-kelp seal"), "Mirror Kelp route memory should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Glass Rim")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Glass Rim ready goal should not override incomplete upgrade progression goals")
	_expect(not incomplete_goal.contains("sealed rim promise"), "Glass Rim route memory should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Outer Shelf")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Outer Shelf ready goal should not override incomplete upgrade progression goals")
	_expect(not incomplete_goal.contains("Glass Rim"), "Outer Shelf route memory should wait until prep goals are complete")

func _test_result_progress_callouts() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	_expect(main._format_upgrade_progress_callout() == "Upgrade progress: Oxygen Tank I ready to buy.", "result progress should call out ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	_expect(main._format_upgrade_progress_callout().contains("scan Thermal Vent"), "result progress should call out missing scan prerequisites")

	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache"]
	_expect(main._format_scan_progress_callout("Scans kept") == "Scans kept: Thermal Vent, Wreck Signal Cache.", "result progress should name scans kept this dive")

	main.run_completed_scans.clear()
	_expect(main._format_scan_progress_callout("Discoveries recorded") == "Discoveries recorded: none this dive.", "result progress should stay explicit when no scans were recorded")
	main.free()

func _test_extraction_banking_result_copy() -> void:
	var main := MainScript.new()

	var cargo: Array[String] = ["kelp_fiber"]
	_expect(main._format_extraction_banking_line(1, cargo).contains("Upgrade/build materials banked: 1"), "cargo extraction should keep resource banking copy")
	_expect(main._format_extraction_banking_line(1, cargo).contains("Kelp Fiber x1"), "cargo extraction should keep resource counts")

	main.run_completed_scans = ["thermal_vent"]
	var scan_only := main._format_extraction_banking_line(0, [])
	_expect(scan_only.contains("Banked 0 resources"), "scan-only extraction should not imply phantom cargo")
	_expect(scan_only.contains("scan data came home"), "scan-only extraction should read as useful")

	main.run_completed_scans.clear()
	var empty_return := main._format_extraction_banking_line(0, [])
	_expect(empty_return.contains("No cargo or new scans"), "empty extraction should remain clearly low-value")
	main.free()

func _test_next_expedition_framing() -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 3

	var prompt := main._format_next_expedition_prompt()
	_expect(prompt.contains("Expedition 4"), "result prompt should point to the next expedition number")
	_expect(prompt.contains("Water Filter I"), "result prompt should point to the best known upgrade/material goal")
	_expect(prompt.contains("Shell Reef pockets"), "starter resource shortage should point back to a remembered place")
	_expect(prompt.contains("Driftwood/Quartz Glass"), "starter resource target should name the missing materials compactly")
	_expect(not prompt.to_lower().contains("restart"), "result prompt should avoid raw restart language")

	main.progression_state.banked_resources = {
		"driftwood": 1,
	}
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("Shell Reef pockets"), "partial starter progress should preserve the remembered-place target")
	_expect(prompt.contains("Quartz Glass") and not prompt.contains("Driftwood/Quartz Glass"), "partial starter progress should only name the remaining material")

	main.survival_state.food = 0
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("bank Food supply first") and prompt.contains("empty needs cut max oxygen"), "empty base needs should take priority in tomorrow planning")
	_expect(main._format_dawn_priority_line().contains("bank Food supply first"), "dawn priority should put empty base needs before upgrades")

	main.survival_state.food = 3
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("build Water Filter I in Upgrades"), "ready builds should take priority after critical base needs")
	_expect(main._format_dawn_priority_line().contains("build Water Filter I in Upgrades"), "dawn priority should name ready builds when critical needs are stable")

	main.progression_state.banked_resources.clear()
	main.survival_state.power = 1
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("bank Power supply soon"), "low base needs should produce a non-critical supply plan")
	_expect(main._format_dawn_priority_line().contains("bank Power supply soon"), "dawn priority should call out low base needs before route goals")
	main._refresh_carried_tomorrow_intention()
	main.survival_state.power = 3
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("bank Power supply soon"), "next expedition prompt should carry the confirmed night intention into tomorrow")
	_expect(main._format_dawn_priority_line().contains("bank Power supply soon"), "dawn priority should keep the carried night intention instead of recomputing immediately")
	main.carried_tomorrow_intention = ""

	main.survival_state.power = 3
	main.progression_state.banked_resources.clear()
	main.run_outer_shelf_survey_recovered = true
	prompt = main._format_next_expedition_prompt()
	_expect(prompt.contains("Glass Rim timing") and prompt.contains("Outer Shelf cargo"), "remembered place should produce a broad route plan when needs/builds are stable")
	_expect(main._format_dawn_priority_line().contains("Outer Shelf cargo"), "dawn priority should preserve broad remembered-route opportunities")

	main.progression_state.current_run_number = 4
	main.survival_state.current_day = 4
	var ready_status := main._format_expedition_ready_status()
	_expect(ready_status.contains("Day 4 ready"), "ready status should name the prepared survival day")
	_expect(ready_status.contains("ocean changed"), "ready status should describe the changed ocean")
	_expect(SurfaceResultPresenterScript.format_expedition_ready_status(false, "low_visibility", 4).contains("lower-trench"), "surface presenter should preserve low-visibility ready copy")
	_expect(SurfaceResultPresenterScript.format_expedition_day_title("Result: Extraction", false, 5, 5, 4) == "Emergency Week Day 4/5 Result: Extraction", "surface presenter should title completed result days from the completed day")
	_expect(SurfaceResultPresenterScript.format_completed_expedition_line("Failure", false, 5, 4) == "Emergency Week Day 4: Failure.", "surface presenter should preserve completed expedition result copy")
	_expect(SurfaceResultPresenterScript.format_night_report_block("Night cost paid.").begins_with("Night Report:"), "surface presenter should wrap night reports")
	_expect(SurfaceResultPresenterScript.format_daylight_closeout_line(true, 2).contains("after 2 ship offload"), "surface presenter should preserve late nightfall offload copy")
	_expect(main._format_expedition_day_title("Ready") == "Emergency Week Day 4/5 Ready", "ready title should show survival day number")
	_expect(main._format_expedition_day_title("Result: Extraction") == "Emergency Week Day 4/5 Result: Extraction", "result title should show completed survival day number")
	_expect(main._format_completed_expedition_line("Failure") == "Emergency Week Day 4: Failure.", "result summary should name the completed survival day")
	main.free()

func _test_region_memory_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_region_memory_callout().contains("Surface Base"), "region memory fallback should preserve safe return framing")

	main.run_collected_resources = ["shell_fragments"]
	_expect(main._format_region_memory_callout().contains("Shell Reef"), "shell cargo should remember Shell Reef")

	main.run_completed_scans = ["thermal_vent"]
	_expect(main._format_region_memory_callout().contains("Thermal Vent Field"), "thermal scan should remember Thermal Vent Field over shell cargo")

	main.run_completed_scans = ["pressure_wreck_signal"]
	_expect(main._format_region_memory_callout().contains("Wreck Shelf"), "pressure wreck scan should remember Wreck Shelf")

	main.run_completed_scans = ["lantern_ray"]
	var lantern_ray_memory := main._format_region_memory_callout()
	_expect(lantern_ray_memory.contains("Lantern Ray Route"), "Lantern Ray scan should remember the lower-route creature place")
	_expect(lantern_ray_memory.contains("timing lane"), "Lantern Ray memory should point to observation timing rather than combat")
	_expect(lantern_ray_memory.contains("Blackwater"), "Lantern Ray memory should preserve broad return-route language")
	_expect_no_monster_combat_language(lantern_ray_memory, "Lantern Ray remembered place")
	_expect(not lantern_ray_memory.to_lower().contains("field guide"), "Lantern Ray memory should not imply a field-guide UI")
	_expect(not lantern_ray_memory.to_lower().contains("checklist"), "Lantern Ray memory should not imply checklist UI")

	main.run_completed_scans.clear()
	main.run_predator_contacts = 1
	_expect(main._format_region_memory_callout().contains("Gulper Route"), "predator evidence should remember Gulper Route as the deepest contested place")
	_expect(not main._format_region_memory_callout().contains(","), "region memory callout should stay compact and not become a checklist")

	main.run_completed_scans = ["lantern_ray"]
	main.run_reached_dusk_trench = true
	var dusk_memory := main._format_region_memory_callout()
	_expect(dusk_memory.contains("Dusk Trench"), "Dusk reach evidence should remember the lower-trench place")
	_expect(not dusk_memory.contains("Lantern Ray Route"), "Dusk reach evidence should not be crowded out by Lantern Ray observation")
	_expect(dusk_memory.contains("up-left"), "Dusk reach memory should keep broad return language")
	_expect(dusk_memory.contains("Blackwater"), "Dusk reach memory should route back through the previous landmark")
	_expect(not dusk_memory.contains("coordinate"), "Dusk reach memory should avoid exact-coordinate language")
	_expect(not dusk_memory.contains("map"), "Dusk reach memory should avoid map language")
	_expect_no_echo_lens_locator_language(dusk_memory, "Dusk Trench remembered place")

	main.run_hollow_reef_reading_recovered = true
	var hollow_memory := main._format_region_memory_callout()
	_expect(hollow_memory.contains("Hollow Reef"), "Hollow Reef reading should own the remembered place over Dusk")
	_expect(not hollow_memory.contains("Lantern Ray Route"), "Hollow Reef memory should not be crowded out by creature observation")
	_expect(hollow_memory.contains("Blackwater"), "Hollow Reef memory should preserve broad return-chain language")
	_expect_no_echo_lens_locator_language(hollow_memory, "Hollow Reef remembered place")

	main.run_hollow_reef_reading_recovered = false
	main.run_reached_dusk_trench = false
	main.run_completed_scans = ["hollow_reef_skitter"]
	var hollow_observation_memory := main._format_region_memory_callout()
	_expect(hollow_observation_memory.contains("Hollow Reef"), "Hollow Reef Skitter scan should remember the side-cave place")
	_expect(hollow_observation_memory.contains("upper-shelf timing"), "Hollow Reef Skitter memory should say what was learned compactly")
	_expect(hollow_observation_memory.contains("Blackwater"), "Hollow Reef Skitter memory should preserve broad return-route language")
	_expect(not hollow_observation_memory.contains("Lantern Ray Route"), "Hollow Reef Skitter memory should not reuse Lantern Ray route language")
	_expect(not hollow_observation_memory.to_lower().contains("checklist"), "Hollow Reef Skitter memory should not imply checklist UI")
	_expect(not hollow_observation_memory.to_lower().contains("field guide"), "Hollow Reef Skitter memory should not imply field-guide UI")
	_expect_no_echo_lens_locator_language(hollow_observation_memory, "Hollow Reef Skitter remembered place")

	main.run_reached_dusk_trench = true
	var hollow_observation_over_dusk := main._format_region_memory_callout()
	_expect(hollow_observation_over_dusk.contains("Hollow Reef"), "Hollow Reef observation should take priority over generic Dusk reach memory")
	_expect(not hollow_observation_over_dusk.contains("Dusk Trench -"), "Hollow Reef observation should not collapse back to generic Dusk memory")
	main.run_reached_dusk_trench = false
	main.run_completed_scans = ["glassfin_swarm"]
	var glassfin_memory := main._format_region_memory_callout()
	_expect(glassfin_memory.contains("Glassfin Swarm"), "Glassfin Swarm scan should remember the creature-route place")
	_expect(glassfin_memory.contains("spacing window"), "Glassfin Swarm memory should say what was learned compactly")
	_expect(glassfin_memory.contains("Hollow Reef"), "Glassfin Swarm memory should preserve broad return-route language")
	_expect_no_monster_combat_language(glassfin_memory, "Glassfin Swarm remembered place")
	_expect(not glassfin_memory.to_lower().contains("field guide"), "Glassfin Swarm memory should not imply field-guide UI")
	_expect(not glassfin_memory.to_lower().contains("checklist"), "Glassfin Swarm memory should not imply checklist UI")
	main.run_reached_dusk_trench = true
	var dusk_over_glassfin := main._format_region_memory_callout()
	_expect(dusk_over_glassfin.contains("Dusk Trench"), "Dusk reach evidence should take priority over Glassfin observation")
	_expect(not dusk_over_glassfin.contains("Glassfin Swarm"), "Glassfin observation should not crowd out Dusk route evidence")
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = true
	var hollow_over_glassfin := main._format_region_memory_callout()
	_expect(hollow_over_glassfin.contains("Hollow Reef"), "Hollow Reef route evidence should take priority over Glassfin observation")
	_expect(not hollow_over_glassfin.contains("Glassfin Swarm"), "Glassfin observation should not crowd out Hollow Reef route evidence")
	main.run_tideglass_sample_recovered = true
	var mirror_kelp_memory := main._format_region_memory_callout()
	_expect(mirror_kelp_memory.contains("Mirror Kelp Pass"), "Mirror Kelp payoff should remember the branch place")
	_expect(mirror_kelp_memory.contains("Wide Reef"), "Mirror Kelp memory should preserve broad return-route language")
	_expect(mirror_kelp_memory.contains("Hollow Reef"), "Mirror Kelp memory should preserve the lower-route return chain")
	_expect(not mirror_kelp_memory.to_lower().contains("checklist"), "Mirror Kelp memory should not imply checklist UI")
	_expect(not mirror_kelp_memory.to_lower().contains("map"), "Mirror Kelp memory should not imply map UI")
	_expect_no_echo_lens_locator_language(mirror_kelp_memory, "Mirror Kelp remembered place")
	main.free()

func _test_discovery_memory_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_discovery_memory_callout() == "", "discovery memory should stay hidden when no first-time major discovery happened")

	main.run_completed_scans = ["shell_reef_shelf"]
	_expect(main._format_discovery_memory_callout().contains("Shell Reef Shelf"), "shell reef first scan should produce discovery memory")

	main.run_completed_scans = ["shell_reef_shelf", "thermal_vent"]
	_expect(main._format_discovery_memory_callout().contains("Thermal Vent"), "thermal first scan should take priority over shell reef")

	main.run_completed_scans = ["thermal_vent", "gulper_eel"]
	_expect(main._format_discovery_memory_callout().contains("Gulper Eel"), "gulper first scan should produce creature research memory")

	main.run_completed_scans = ["lantern_ray"]
	var lantern_ray_discovery_memory := main._format_discovery_memory_callout()
	_expect(lantern_ray_discovery_memory.contains("Lantern Ray"), "Lantern Ray first scan should produce creature observation memory")
	_expect(lantern_ray_discovery_memory.contains("without fighting"), "Lantern Ray discovery memory should frame observation as non-combat")
	_expect_no_monster_combat_language(lantern_ray_discovery_memory, "Lantern Ray discovery memory")
	_expect(not lantern_ray_discovery_memory.to_lower().contains("field guide"), "Lantern Ray discovery memory should not imply a field-guide UI")
	_expect(not lantern_ray_discovery_memory.to_lower().contains("checklist"), "Lantern Ray discovery memory should not imply checklist UI")

	main.run_completed_scans = ["glassfin_swarm"]
	var glassfin_discovery_memory := main._format_discovery_memory_callout()
	_expect(glassfin_discovery_memory.contains("Glassfin Swarm"), "Glassfin Swarm first scan should produce creature observation memory")
	_expect(glassfin_discovery_memory.contains("spacing"), "Glassfin Swarm discovery memory should name the spacing lesson")
	_expect(glassfin_discovery_memory.contains("without fighting"), "Glassfin Swarm discovery memory should frame observation as non-combat")
	_expect_no_monster_combat_language(glassfin_discovery_memory, "Glassfin Swarm discovery memory")
	_expect(not glassfin_discovery_memory.to_lower().contains("field guide"), "Glassfin Swarm discovery memory should not imply a field-guide UI")
	_expect(not glassfin_discovery_memory.to_lower().contains("checklist"), "Glassfin Swarm discovery memory should not imply checklist UI")

	main.run_completed_scans = ["pressure_wreck_signal", "wreck_signal_cache", "wreck_signal_cache"]
	var memory := main._format_discovery_memory_callout()
	_expect(memory.contains("Wreck Signal Cache"), "cache first scan should take priority over outside wreck signal")
	_expect(memory.find("Wreck Signal Cache") == memory.rfind("Wreck Signal Cache"), "discovery memory should not duplicate repeated ids")
	_expect(not memory.contains(","), "discovery memory should stay compact and not become a checklist")
	main.free()

func _test_route_memory_presenter() -> void:
	var empty_state := {
		"run_completed_scans": [],
		"run_collected_resources": [],
	}
	_expect(RouteMemoryPresenterScript.format_route_choice_callout(empty_state) == "", "route presenter should keep empty route choice quiet")
	_expect(RouteMemoryPresenterScript.format_recent_route_memory(empty_state) == "none", "route presenter should report no route memory for empty runs")
	_expect(RouteMemoryPresenterScript.format_region_memory_callout(empty_state).contains("Surface Base"), "route presenter should preserve surface-base fallback")
	_expect(RouteMemoryPresenterScript.format_discovery_memory_callout(empty_state) == "", "route presenter should keep discovery memory quiet without scans")

	var shell_state := {
		"run_completed_scans": [],
		"run_collected_resources": ["shell_fragments"],
	}
	_expect(RouteMemoryPresenterScript.format_route_choice_callout(shell_state).contains("Shell Reef"), "shell cargo should still produce the Shell Reef route callout")
	_expect(RouteMemoryPresenterScript.format_recent_route_memory(shell_state) == "Shell Reef", "shell cargo should still produce Shell Reef recent memory")

	var glass_rim_state := {
		"run_completed_scans": ["glass_ray_drifter"],
		"run_collected_resources": [],
	}
	_expect(RouteMemoryPresenterScript.format_route_choice_callout(glass_rim_state).contains("Glass Ray slackwater timing"), "Glass Ray observation should drive route-choice memory")
	_expect(RouteMemoryPresenterScript.format_region_memory_callout(glass_rim_state).contains("Outer Shelf"), "Glass Ray observation should remember Outer Shelf")
	_expect(RouteMemoryPresenterScript.format_discovery_memory_callout(glass_rim_state).contains("Glass Ray Drifter"), "Glass Ray observation should produce discovery memory")

	var blackwater_state := {
		"run_blackwater_trace_recovered": true,
		"run_blue_chimney_draft_reading_recovered": true,
		"run_completed_scans": ["thermal_vent"],
		"run_collected_resources": ["shell_fragments"],
	}
	_expect(RouteMemoryPresenterScript.format_route_choice_callout(blackwater_state).contains("Blackwater"), "Blackwater payoff should win route-choice priority")
	_expect(RouteMemoryPresenterScript.format_recent_route_memory(blackwater_state) == "Blackwater", "Blackwater payoff should win recent route memory")

func _test_route_choice_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_route_choice_callout() == "", "route choice callout should stay hidden without run evidence")

	main.run_collected_resources = ["shell_fragments"]
	_expect(main._format_route_choice_callout().contains("Shell Reef"), "shell cargo should produce a reef banking callout")

	main.run_collected_resources = []
	main.run_east_shelf_pocket_ping_recovered = true
	_expect(main._format_route_choice_callout().contains("East Shelf research push"), "East Shelf payoff should produce a research-push route callout")

	main.run_lower_connector_echo_recovered = true
	_expect(main._format_route_choice_callout().contains("Shelf Drop"), "Drop Echo payoff should produce a lower-route route callout")

	main.run_blue_chimney_draft_reading_recovered = true
	_expect(main._format_route_choice_callout().contains("Blue Chimney"), "Blue Chimney survey core should produce a lower-route route callout")

	main.run_east_shelf_pocket_ping_recovered = false
	main.run_lower_connector_echo_recovered = false
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_lantern_silt_sample_recovered = true
	_expect(main._format_route_choice_callout().contains("Silt Vein"), "Lantern Silt payoff should produce a lower-route route callout")

	main.run_lantern_silt_sample_recovered = false
	main.run_blackwater_trace_recovered = true
	main.run_predator_contacts = 1
	var blackwater_callout := main._format_route_choice_callout()
	_expect(blackwater_callout.contains("Blackwater"), "Blackwater Trace should produce the deepest-route route callout")
	_expect(not blackwater_callout.contains("predator route"), "Blackwater route evidence should not be crowded out by predator pressure")
	_expect(blackwater_callout.find("Route choice:") == blackwater_callout.rfind("Route choice:"), "Blackwater route memory should stay one compact route-choice line")
	_expect_no_echo_lens_locator_language(blackwater_callout, "Blackwater route choice")
	var empty_cargo: Array[String] = []
	var blackwater_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(not blackwater_summary.contains("Dusk Trench"), "Dusk result memory should stay hidden before reach evidence")

	main.run_reached_dusk_trench = true
	var dusk_callout := main._format_route_choice_callout()
	_expect(dusk_callout.contains("Dusk Trench"), "Dusk reach evidence should produce the deepest route-choice callout")
	_expect(not dusk_callout.contains("Blackwater"), "Dusk route choice should take priority over Blackwater route evidence")
	_expect(dusk_callout.find("Route choice:") == dusk_callout.rfind("Route choice:"), "Dusk route memory should stay one compact route-choice line")
	_expect_no_echo_lens_locator_language(dusk_callout, "Dusk route choice")
	var dusk_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(dusk_summary.contains("Remembered place: Dusk Trench"), "Dusk extraction summary should include supported remembered-place evidence")
	_expect(dusk_summary.contains("Route choice: lower-route research push reached Dusk Trench."), "Dusk extraction summary should include supported route-choice evidence")
	_expect(not dusk_summary.contains("map"), "Dusk extraction summary should avoid map language")

	main.run_hollow_reef_reading_recovered = true
	var hollow_callout := main._format_route_choice_callout()
	_expect(hollow_callout.contains("Hollow Reef"), "Hollow Reef reading should produce the deepest route-choice callout")
	_expect(not hollow_callout.contains("Dusk Trench"), "Hollow Reef route choice should take priority over Dusk reach evidence")
	_expect(not hollow_callout.contains("Blackwater"), "Hollow Reef route choice should take priority over Blackwater trace evidence")
	_expect_no_echo_lens_locator_language(hollow_callout, "Hollow Reef route choice")
	var hollow_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(hollow_summary.contains("Remembered place: Hollow Reef"), "Hollow Reef extraction summary should include the branch as remembered place")
	_expect(hollow_summary.contains("Route choice: lower-route research push reached Hollow Reef."), "Hollow Reef extraction summary should include the highest route-choice evidence")

	main.run_salvage_data_cache_recovered = true
	var save_before_wide_chamber_memory: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var wide_chamber_callout := main._format_route_choice_callout()
	_expect(wide_chamber_callout.contains("wide chamber"), "wide chamber salvage evidence should produce the most specific route-choice callout")
	_expect(wide_chamber_callout.contains("sealed pocket"), "wide chamber route choice should name the compact salvage lesson")
	_expect(not wide_chamber_callout.contains("Hollow Reef"), "wide chamber route choice should take priority over Hollow Reef reading evidence")
	_expect(not wide_chamber_callout.contains("Dusk Trench"), "wide chamber route choice should take priority over Dusk reach evidence")
	_expect_no_echo_lens_locator_language(wide_chamber_callout, "Wide Reef Chamber route choice")
	var wide_chamber_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(wide_chamber_summary.contains("Remembered place: Wide Reef Chamber"), "wide chamber extraction summary should remember the larger chamber when salvage evidence exists")
	_expect(wide_chamber_summary.contains("Route choice: wide chamber salvage cache marked a sealed pocket."), "wide chamber extraction summary should include one compact route-choice line")
	_expect(wide_chamber_summary.find("Route choice:") == wide_chamber_summary.rfind("Route choice:"), "wide chamber extraction summary should not duplicate route-choice lines")
	_expect(main.progression_state.to_save_data() == save_before_wide_chamber_memory, "wide chamber route memory formatting should not mutate durable progression")
	_expect(not main.progression_state.to_save_data().has("wide_reef_chamber_route"), "wide chamber route memory should not create durable route state")
	_expect(not main.progression_state.to_save_data().has("recent_route_memory"), "wide chamber route memory should not create durable recent-route state")
	main.run_tideglass_sample_recovered = true
	var tideglass_route_callout := main._format_route_choice_callout()
	_expect(tideglass_route_callout.contains("Mirror Kelp Pass"), "Tideglass payoff should produce Mirror Kelp route-choice memory")
	_expect(tideglass_route_callout.contains("deeper kelp seal"), "Tideglass route memory should name the compact branch promise")
	_expect(not tideglass_route_callout.contains("wide chamber"), "Mirror Kelp payoff should take priority over the upstream wide chamber route")
	_expect_no_echo_lens_locator_language(tideglass_route_callout, "Tideglass route choice")
	main.run_tideglass_sample_recovered = false
	main.run_completed_scans = ["mirrorfin_drift"]
	var mirrorfin_route_callout := main._format_route_choice_callout()
	_expect(mirrorfin_route_callout.contains("Mirror Kelp"), "Mirrorfin observation should produce Mirror Kelp route-choice memory")
	_expect(mirrorfin_route_callout.contains("reflection timing"), "Mirrorfin route memory should name the observation lesson")
	_expect(not mirrorfin_route_callout.contains("wide chamber"), "Mirrorfin route memory should take priority over the upstream wide chamber route")
	_expect(not mirrorfin_route_callout.to_lower().contains("checklist"), "Mirrorfin route memory should not imply checklist UI")
	_expect_no_echo_lens_locator_language(mirrorfin_route_callout, "Mirrorfin route choice")
	main.run_salvage_data_cache_recovered = false
	main.run_hollow_reef_reading_recovered = false
	main.run_reached_dusk_trench = false
	main.run_completed_scans = []

	main.run_completed_scans = ["hollow_reef_skitter"]
	var save_before_hollow_observation: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var hollow_observation_route_choice := main._format_route_choice_callout()
	_expect(hollow_observation_route_choice.contains("Hollow Reef"), "Hollow Reef Skitter scan should produce route-choice memory")
	_expect(hollow_observation_route_choice.contains("upper-shelf timing"), "Hollow Reef Skitter route-choice memory should name the compact lesson")
	_expect(not hollow_observation_route_choice.contains("Dusk Trench"), "Hollow Reef Skitter route choice should be more specific than generic Dusk reach")
	_expect(not hollow_observation_route_choice.to_lower().contains("checklist"), "Hollow Reef Skitter route choice should not imply checklist UI")
	_expect_no_echo_lens_locator_language(hollow_observation_route_choice, "Hollow Reef Skitter route choice")
	var hollow_observation_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(hollow_observation_summary.contains("Remembered place: Hollow Reef"), "Hollow Reef Skitter extraction summary should remember the side-cave place")
	_expect(hollow_observation_summary.contains("Route choice: observed Hollow Reef upper-shelf timing."), "Hollow Reef Skitter extraction summary should include one compact route-choice line")
	_expect(hollow_observation_summary.find("Route choice:") == hollow_observation_summary.rfind("Route choice:"), "Hollow Reef Skitter extraction summary should not duplicate route-choice lines")
	var save_after_hollow_observation: Dictionary = main.progression_state.to_save_data()
	_expect(save_after_hollow_observation == save_before_hollow_observation, "Hollow Reef route memory formatting should not mutate durable progression")
	_expect(not save_after_hollow_observation.has("hollow_reef_route"), "Hollow Reef route memory should not create durable route state")
	_expect(not save_after_hollow_observation.has("recent_route_memory"), "Hollow Reef route memory should not create durable recent-route state")
	_expect(not save_after_hollow_observation.has("route_graph"), "Hollow Reef route memory should not create route graph state")
	main.run_completed_scans = ["glassfin_swarm"]
	var save_before_glassfin_observation: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var glassfin_route_choice := main._format_route_choice_callout()
	_expect(glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin Swarm scan should produce route-choice memory")
	_expect(glassfin_route_choice.contains("spacing"), "Glassfin Swarm route-choice memory should name the compact lesson")
	_expect(glassfin_route_choice.contains("without fighting"), "Glassfin Swarm route-choice memory should reinforce observation-first creature direction")
	_expect(not glassfin_route_choice.to_lower().contains("checklist"), "Glassfin Swarm route choice should not imply checklist UI")
	_expect_no_monster_combat_language(glassfin_route_choice, "Glassfin Swarm route choice")
	var glassfin_summary := main._format_extraction_result_summary(0, empty_cargo)
	_expect(glassfin_summary.contains("Remembered place: Glassfin Swarm Route"), "Glassfin Swarm extraction summary should remember the creature-route place")
	_expect(glassfin_summary.contains("Route choice: observed Glassfin Swarm spacing without fighting."), "Glassfin Swarm extraction summary should include one compact route-choice line")
	_expect(glassfin_summary.contains("Discovery remembered: Glassfin Swarm"), "Glassfin Swarm extraction summary should include compact discovery memory")
	_expect(glassfin_summary.find("Route choice:") == glassfin_summary.rfind("Route choice:"), "Glassfin Swarm extraction summary should not duplicate route-choice lines")
	var save_after_glassfin_observation: Dictionary = main.progression_state.to_save_data()
	_expect(save_after_glassfin_observation == save_before_glassfin_observation, "Glassfin Swarm route memory formatting should not mutate durable progression")
	_expect(not save_after_glassfin_observation.has("glassfin_swarm_route"), "Glassfin Swarm route memory should not create durable route state")
	_expect(not save_after_glassfin_observation.has("monster_journal"), "Glassfin Swarm route memory should not create monster journal state")
	_expect(not save_after_glassfin_observation.has("creature_inventory"), "Glassfin Swarm route memory should not create creature inventory state")
	main.run_reached_dusk_trench = true
	var dusk_over_glassfin_route_choice := main._format_route_choice_callout()
	_expect(dusk_over_glassfin_route_choice.contains("Dusk Trench"), "Dusk reach evidence should win over Glassfin route-choice memory")
	_expect(not dusk_over_glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin route-choice memory should not crowd out Dusk route evidence")
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = true
	var hollow_over_glassfin_route_choice := main._format_route_choice_callout()
	_expect(hollow_over_glassfin_route_choice.contains("Hollow Reef"), "Hollow Reef route evidence should win over Glassfin route-choice memory")
	_expect(not hollow_over_glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin route-choice memory should not crowd out Hollow Reef route evidence")
	main.run_hollow_reef_reading_recovered = false
	main.run_completed_scans = []

	main.run_blackwater_trace_recovered = false
	main.run_predator_contacts = 0
	main.current_resource_cluster_pattern = "deep_reward"
	main.run_collected_resources = ["glow_plankton"]
	_expect(main._format_route_choice_callout().contains("deep glow"), "deep reward glow cargo should produce a deep push callout")

	main.run_completed_scans = ["wreck_signal_cache"]
	_expect(main._format_route_choice_callout().contains("pressure-wreck progress"), "wreck cache scan should produce a pressure progress callout")

	main.run_predator_contacts = 1
	_expect(main._format_route_choice_callout().contains("predator route"), "predator contact should take priority in the route callout")

	main.run_predator_contacts = 0
	main.run_completed_scans = ["lantern_ray"]
	var lantern_route_choice := main._format_route_choice_callout()
	_expect(lantern_route_choice.contains("Lantern Ray"), "Lantern Ray scan should produce a route observation callout when no deeper route wins")
	_expect_no_monster_combat_language(lantern_route_choice, "Lantern Ray route choice")

	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = []
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	_expect(main._format_route_choice_callout().contains("Pressure Seal I"), "thermal vent scan should produce a pressure seal route callout")

	main.run_collected_resources = ["glow_plankton"]
	_expect(main._format_route_choice_callout().contains("Thermal Vent clue"), "vent scan plus glow cargo should produce a vent route callout")

	var summary := main._format_run_summary("%s\nCompact result line." % main._format_route_choice_callout(), "extracted")
	_expect(summary.contains("Route choice:"), "player-facing result summary should include the route callout")
	_expect(summary.find("Route choice:") == summary.rfind("Route choice:"), "player-facing result summary should not duplicate route-choice lines")
	_expect(not summary.contains("Playtest data:"), "result summary should not include debug telemetry unless F3 is enabled")
	_expect(not summary.contains("Predator route:"), "predator route telemetry should stay hidden unless F3 is enabled")
	_expect(not summary.contains("thermal_bloom"), "condition id should stay hidden unless debug telemetry is enabled")

	main.show_debug_telemetry = true
	summary = main._format_run_summary(main._format_route_choice_callout(), "extracted")
	_expect(summary.contains("Playtest data:"), "debug telemetry should appear only when enabled")
	_expect(summary.contains("Condition: Thermal Bloom (thermal_bloom)"), "debug telemetry should include condition display and id")
	main.free()

func _test_gulper_research_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_gulper_research_callout() == "", "Gulper research should stay hidden without evidence")

	main.run_completed_scans = ["gulper_eel"]
	_expect(main._format_gulper_research_callout().contains("Gulper route timing observed"), "Gulper scan should produce a research callout")
	var summary := main._format_run_summary("%s%s" % [main._format_route_choice_callout(), main._format_gulper_research_callout()], "extracted")
	_expect(summary.contains("Research:"), "player-facing summary should include compact creature research when relevant")
	_expect(not summary.contains("Playtest data:"), "creature research should not expose debug telemetry")

	main.run_predator_contacts = 1
	_expect(main._format_gulper_research_callout().contains("warning lane"), "Gulper contact should take priority over scan research")

	main.decoy_pulse_used_this_run = true
	_expect(main._format_gulper_research_callout().contains("Decoy timing"), "Decoy evidence should take priority as a stronger research result")
	main.free()

func _test_research_result_presenter() -> void:
	var empty_state := {
		"run_completed_scans": [],
	}
	_expect(ResearchResultPresenterScript.format_gulper_research_callout(empty_state) == "", "empty research state should not create Gulper copy")
	_expect(ResearchResultPresenterScript.format_echo_lens_research_callout(empty_state) == "", "empty research state should not create Echo Lens copy")

	var gulper_scan_state := {
		"run_completed_scans": ["gulper_eel"],
	}
	_expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_scan_state).contains("Gulper route timing observed"), "Gulper scan should produce scan research copy")
	var gulper_contact_state := {
		"run_completed_scans": ["gulper_eel"],
		"run_predator_contacts": 1,
	}
	_expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_contact_state).contains("warning lane"), "Gulper contact should outrank scan research copy")
	var gulper_decoy_state := {
		"decoy_pulse_used_this_run": true,
		"run_completed_scans": ["gulper_eel"],
		"run_predator_contacts": 1,
	}
	_expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_decoy_state).contains("Decoy timing"), "Decoy evidence should outrank contact research copy")

	_expect(ResearchResultPresenterScript.format_blue_chimney_research_callout({"run_blue_chimney_draft_reading_recovered": true}).contains("Blue Chimney"), "Blue Chimney payoff should produce research copy")
	_expect(ResearchResultPresenterScript.format_salvage_manifest_research_callout({"run_salvage_manifest_recovered": true}).contains("Salvage Manifest"), "Salvage Manifest payoff should produce research copy")
	_expect(ResearchResultPresenterScript.format_sealed_shelf_hatch_readiness_callout({"has_echo_lens_upgrade": true}) == "", "sealed hatch lab note should stay hidden without route evidence")
	_expect(ResearchResultPresenterScript.format_sealed_shelf_hatch_readiness_callout({
		"has_echo_lens_upgrade": true,
		"run_lower_connector_echo_recovered": true,
	}).contains("Sealed Shelf Hatch"), "sealed hatch lab note should show with Echo Lens and route evidence")

func _test_monster_research_non_combat_guardrails() -> void:
	var main := MainScript.new()
	main.run_completed_scans = ["gulper_eel"]
	var scan_callout := main._format_gulper_research_callout()
	_expect_no_monster_combat_language(scan_callout, "Gulper scan research")

	main.run_predator_contacts = 1
	var contact_callout := main._format_gulper_research_callout()
	_expect(contact_callout.contains("warning lane"), "contact research should stay framed as route danger")
	_expect_no_monster_combat_language(contact_callout, "Gulper contact research")

	main.decoy_pulse_used_this_run = true
	var decoy_callout := main._format_gulper_research_callout()
	_expect(decoy_callout.contains("Decoy timing"), "Monster Research II candidate should stay framed as decoy timing")
	_expect_no_monster_combat_language(decoy_callout, "Decoy response research")

	var summary := main._format_run_summary(decoy_callout, "extracted")
	_expect_no_monster_combat_language(summary, "Monster research result summary")
	_expect(not summary.contains("field guide"), "Monster research result should not add field-guide UI language")
	_expect(not summary.contains("checklist"), "Monster research result should not add checklist UI language")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("monster_research"), "Monster Research II planning should not add durable monster research save state")
	_expect(not saved.has("creature_inventory"), "Monster Research II planning should not add creature inventory save state")
	main.free()

func _test_echo_lens_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_echo_lens_research_callout() == "", "Echo Lens result line should stay hidden until an echo fires")
	main.run_echo_lens_echo_fired = true
	var callout := main._format_echo_lens_research_callout()
	_expect(callout.contains("Echo Lens"), "Echo Lens result line should name the scanner upgrade")
	_expect(callout.contains("weak wreck echo below the shelf"), "Echo Lens result line should preserve the broad local echo memory")
	_expect_no_echo_lens_locator_language(callout, "Echo Lens result line")
	var summary := main._format_run_summary("%s%s" % [main._format_route_choice_callout(), callout], "extracted")
	_expect(summary.contains("Research:"), "Echo Lens result line should appear as compact research memory")
	_expect(not summary.contains("Playtest data:"), "Echo Lens result line should not expose debug telemetry")
	main.free()

func _test_wreck_echo_route_first_pass() -> void:
	var main := MainScript.new()
	_expect(not main._wreck_echo_route_available(), "Wreck Echo route should start unavailable")
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	_expect(not main._wreck_echo_route_available(), "Wreck Echo route should still need Echo Lens I")
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	_expect(main._wreck_echo_route_available(), "Wreck Echo route should require pressure and Echo Lens context")
	_expect(main._format_wreck_echo_research_callout() == "", "Wreck Echo result line should stay hidden before clue recovery")
	main.run_wreck_echo_clue_recovered = true
	var callout := main._format_wreck_echo_research_callout()
	_expect(callout.contains("Wreck Echo clue"), "Wreck Echo clue should produce compact research callout")
	_expect(callout.contains("deeper pressure signal below the shelf"), "Wreck Echo clue should stay broad/local")
	_expect_no_echo_lens_locator_language(callout, "Wreck Echo result line")
	var extraction_summary := main._format_extraction_result_summary(0, [])
	_expect(extraction_summary.contains("Wreck Echo clue carried"), "Wreck Echo extraction summary should include the clue readback")
	_expect(not extraction_summary.contains("%s"), "Wreck Echo extraction summary should not leak string placeholders")
	_expect(not extraction_summary.contains("%dm"), "Wreck Echo extraction summary should not leak depth placeholders")
	main._reset_run_telemetry()
	_expect(not main.run_wreck_echo_clue_recovered, "Wreck Echo clue should reset between expeditions")
	main.free()

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	var trigger: Area2D = main_scene.get_node("WreckEchoDescent/ClueTrigger")
	_expect(not trigger.monitoring, "Wreck Echo trigger should start inactive")
	main_scene.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	main_scene.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main_scene.call("_sync_wreck_echo_state")
	_expect(trigger.visible, "Wreck Echo trigger should appear when pressure and Echo Lens context are ready")
	_expect(trigger.monitoring, "Wreck Echo trigger should listen when available and unrecovered")
	main_scene.run_wreck_echo_clue_recovered = true
	main_scene.call("_sync_wreck_echo_state")
	_expect(not trigger.monitoring, "Wreck Echo trigger should disable after clue recovery")

	var presenter_trigger := Area2D.new()
	var presenter_wash := Polygon2D.new()
	var presenter_rib_a := Polygon2D.new()
	var presenter_rib_b := Polygon2D.new()
	var presenter_core := Polygon2D.new()
	var presenter_marker_outer := Polygon2D.new()
	var presenter_marker_inner := Polygon2D.new()
	var presenter_markers: Array[Polygon2D] = [presenter_marker_outer, presenter_marker_inner]
	RoutePresenterScript.sync_wreck_echo_state(presenter_trigger, presenter_wash, presenter_rib_a, presenter_rib_b, presenter_core, presenter_markers, true, false)
	_expect(presenter_trigger.visible and presenter_trigger.monitoring and presenter_trigger.monitorable, "route presenter should enable Wreck Echo trigger for available unrecovered route")
	_expect(presenter_core.visible and presenter_marker_outer.visible, "route presenter should show clue visuals for available route")
	RoutePresenterScript.sync_wreck_echo_state(presenter_trigger, presenter_wash, presenter_rib_a, presenter_rib_b, presenter_core, presenter_markers, true, true)
	_expect(not presenter_trigger.monitoring, "route presenter should disable recovered Wreck Echo trigger")
	_expect(presenter_marker_outer.color.a < presenter_marker_inner.color.a, "route presenter should keep recovered marker colors quiet but layered")
	presenter_trigger.free()
	presenter_wash.free()
	presenter_rib_a.free()
	presenter_rib_b.free()
	presenter_core.free()
	presenter_marker_outer.free()
	presenter_marker_inner.free()
	main_scene.queue_free()

func _test_east_shelf_pocket_result_callout() -> void:
	var main := MainScript.new()
	_expect(main._format_east_shelf_pocket_research_callout() == "", "East Shelf pocket result line should stay hidden before signal-core recovery")

	main.run_east_shelf_pocket_ping_recovered = true
	var callout := main._format_east_shelf_pocket_research_callout()
	_expect(callout.contains("East Shelf signal core"), "East Shelf signal core should produce compact research memory")
	_expect(callout.contains("sealed route below the arch"), "East Shelf pocket result line should stay broad and local")
	_expect(not callout.to_lower().contains("map"), "East Shelf pocket result line should not imply a map marker")
	_expect(not callout.to_lower().contains("quest"), "East Shelf pocket result line should not imply quest UI")
	_expect(not callout.to_lower().contains("checklist"), "East Shelf pocket result line should not imply checklist UI")

	var extraction_summary := main._format_extraction_result_summary(0, [])
	_expect(extraction_summary.contains("East Shelf signal core"), "East Shelf pocket extraction summary should include recovered signal-core memory")
	_expect(not extraction_summary.contains("%s"), "East Shelf pocket extraction summary should not leak string placeholders")
	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("east_shelf_pocket_signal_core"), "East Shelf signal core should not become durable save data")
	_expect(not saved.has("east_shelf_routes"), "East Shelf signal core should not create durable route state")
	main.free()

func _test_lower_connector_echo_opportunity() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_lower_connector_echo = true
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Drop Echo"), "Lower connector proximity should own the active dive prompt")
	_expect(prompt.contains("lower-route ping"), "Drop Echo prompt should explain the narrow research opportunity")

	var handled: bool = main.call("_try_lower_connector_echo_interaction")
	_expect(handled, "Drop Echo should handle interact while the player is nearby during a dive")
	_expect(main.run_lower_connector_echo_recovered, "Drop Echo interaction should record one run-scoped research ping")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Drop Echo interaction should preserve extraction pressure")

	var repeat_handled: bool = main.call("_try_lower_connector_echo_interaction")
	_expect(repeat_handled, "Drop Echo should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Drop Echo repeat interaction should not duplicate the payoff")

	main.player_near_lower_connector_echo = false
	var not_handled: bool = main.call("_try_lower_connector_echo_interaction")
	_expect(not not_handled, "Drop Echo should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_lower_connector_echo_research_callout")
	_expect(callout.contains("Drop Echo"), "Drop Echo should produce compact extraction research memory")
	_expect(callout.contains("Shelf Drop Connector"), "Drop Echo result memory should name the lower connector")
	_expect(not callout.to_lower().contains("map"), "Drop Echo result line should not imply map UI")
	_expect(not callout.to_lower().contains("quest"), "Drop Echo result line should not imply quest UI")
	_expect(not callout.to_lower().contains("checklist"), "Drop Echo result line should not imply checklist UI")

	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Drop Echo"), "Drop Echo extraction summary should include recovered lower-route memory")
	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("drop_echo"), "Drop Echo should not become durable save data")
	_expect(not saved.has("lower_connector_echo"), "Drop Echo should not create durable route state")

	main.call("_reset_run_telemetry")
	_expect(not main.run_lower_connector_echo_recovered, "Drop Echo research ping should reset between expeditions")
	main.free()

func _test_resonance_alcove_research_payoff() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_resonance_alcove = true
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Resonance Alcove"), "Resonance Alcove proximity should own the active dive prompt")
	_expect(prompt.contains("record hatch echo"), "Resonance Alcove prompt should explain the narrow research payoff")

	var locked_handled: bool = main.call("_try_resonance_alcove_interaction")
	_expect(locked_handled, "Resonance Alcove should handle interaction before key ownership")
	_expect(not main.run_resonance_alcove_research_recovered, "locked Resonance Alcove should not record research")
	if main.status_label != null:
		_expect(main.status_label.text.contains("behind the sealed hatch"), "locked Resonance Alcove should explain the hatch gate")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var cargo_before: Array[String] = main.dive_session.current_cargo.duplicate()
	var handled: bool = main.call("_try_resonance_alcove_interaction")
	_expect(handled, "Resonance Alcove should handle interact while nearby during a dive")
	_expect(main.run_resonance_alcove_research_recovered, "Resonance Alcove interaction should record one run-scoped research note")
	_expect(main.dive_session.current_cargo == cargo_before, "Resonance Alcove research should not add cargo")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Resonance Alcove payoff should preserve extraction pressure")

	var repeat_handled: bool = main.call("_try_resonance_alcove_interaction")
	_expect(repeat_handled, "Resonance Alcove should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Resonance Alcove repeat interaction should not duplicate the payoff")

	main.player_near_resonance_alcove = false
	var not_handled: bool = main.call("_try_resonance_alcove_interaction")
	_expect(not not_handled, "Resonance Alcove should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("resonance_alcove"), "Resonance Alcove note should not become durable save data")
	_expect(not saved.has("resonance_alcove_research"), "Resonance Alcove research should not create durable route state")

	var callout: String = main.call("_format_resonance_alcove_research_callout")
	_expect(callout.contains("Resonance Alcove"), "Resonance Alcove result memory should name the small pocket")
	_expect(callout.contains("small tuned pocket"), "Resonance Alcove result memory should stay broad and local")
	_expect_no_echo_lens_locator_language(callout, "Resonance Alcove result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Resonance Alcove"), "Resonance Alcove extraction summary should include recovered research memory")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_resonance_alcove_research_callout() == "", "Resonance Alcove result line should stay hidden before payoff recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Resonance Alcove"), "Resonance Alcove extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_blue_chimney_draft_interaction() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blue_chimney = true
	main.dive_session.oxygen = 26.0
	main.dive_session.current_cargo = ["shell_fragments"]
	var survey_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem") as Polygon2D
	var survey_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark") as Polygon2D
	main.call("_sync_blue_chimney_payoff_state")
	_expect(survey_gem.color.a >= 0.7, "Blue Chimney survey core should start visibly recoverable")
	_expect(survey_spark.visible, "Blue Chimney survey spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Blue Chimney"), "Blue Chimney proximity should own the active dive prompt")
	_expect(prompt.contains("recover survey core"), "Blue Chimney prompt should explain the concrete lower-route payoff")

	var handled: bool = main.call("_try_blue_chimney_interaction")
	_expect(handled, "Blue Chimney should handle interact while nearby during a dive")
	_expect(main.run_blue_chimney_draft_reading_recovered, "Blue Chimney interaction should record one run-scoped survey core")
	_expect(survey_gem.color.a <= 0.2, "Blue Chimney survey core should visibly dim after recovery")
	_expect(not survey_spark.visible, "Blue Chimney survey spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 26.0), "Blue Chimney survey core should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Blue Chimney survey core should not add or remove cargo")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Blue Chimney interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("survey core"), "Blue Chimney status should name the visible payoff")

	var repeat_handled: bool = main.call("_try_blue_chimney_interaction")
	_expect(repeat_handled, "Blue Chimney should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recovered"), "Blue Chimney repeat interaction should not duplicate the payoff")

	main.player_near_blue_chimney = false
	var not_handled: bool = main.call("_try_blue_chimney_interaction")
	_expect(not not_handled, "Blue Chimney should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_blue_chimney_research_callout")
	_expect(callout.contains("Blue Chimney"), "Blue Chimney result memory should name the lower pocket")
	_expect(callout.contains("survey core"), "Blue Chimney result memory should name the concrete payoff")
	_expect(callout.contains("Shelf Drop"), "Blue Chimney result memory should keep broad route context")
	_expect(callout.contains("deeper side-route"), "Blue Chimney result memory should hint at future route growth")
	_expect_no_echo_lens_locator_language(callout, "Blue Chimney result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Blue Chimney survey core"), "Blue Chimney extraction summary should include recovered survey core memory")
	_expect(not extraction_summary.contains("%s"), "Blue Chimney extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_blue_chimney_research_callout() == "", "Blue Chimney result line should stay hidden before draft recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Blue Chimney survey core"), "Blue Chimney extraction summary should stay hidden before survey core recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_blue_chimney_draft_reading_recovered, "Blue Chimney draft reading should reset between expeditions")
	_expect(survey_gem.color.a >= 0.7, "Blue Chimney survey core should become visible again on expedition reset")
	_expect(survey_spark.visible, "Blue Chimney survey spark should reset between expeditions")
	main.free()

func _test_lantern_silt_sample_interaction() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_lantern_silt_nook = true
	main.dive_session.oxygen = 24.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"glow_plankton": 2}
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Lantern Silt Nook"), "Lantern Silt Nook proximity should own the active dive prompt")
	_expect(prompt.contains("collect silt sample"), "Lantern Silt prompt should explain the narrow research action")

	var handled: bool = main.call("_try_lantern_silt_nook_interaction")
	_expect(handled, "Lantern Silt Nook should handle interact while nearby during a dive")
	_expect(main.run_lantern_silt_sample_recovered, "Lantern Silt interaction should record one run-scoped sample")
	_expect(is_equal_approx(main.dive_session.oxygen, 24.0), "Lantern Silt sample should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Lantern Silt sample should not add or remove cargo")
	_expect(main.progression_state.resource_count("glow_plankton") == 2, "Lantern Silt sample should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Lantern Silt interaction should preserve extraction pressure")

	var repeat_handled: bool = main.call("_try_lantern_silt_nook_interaction")
	_expect(repeat_handled, "Lantern Silt Nook should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already stored"), "Lantern Silt repeat interaction should not duplicate the payoff")

	main.player_near_lantern_silt_nook = false
	var not_handled: bool = main.call("_try_lantern_silt_nook_interaction")
	_expect(not not_handled, "Lantern Silt Nook should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("lantern_silt_sample"), "Lantern Silt sample should not become durable save data")
	_expect(not saved.has("lantern_silt"), "Lantern Silt sample should not create durable route state")
	_expect(not saved.has("silt_vein_fork"), "Silt Vein Fork should not create durable route state")

	var callout: String = main.call("_format_lantern_silt_sample_research_callout")
	_expect(callout.contains("Lantern Silt Sample"), "Lantern Silt result memory should name the sample")
	_expect(callout.contains("left branch"), "Lantern Silt result memory should explain the broad route choice")
	_expect(callout.contains("Silt Vein"), "Lantern Silt result memory should keep broad fork context")
	_expect_no_echo_lens_locator_language(callout, "Lantern Silt result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Lantern Silt Sample"), "Lantern Silt extraction summary should include recovered sample memory")
	_expect(not extraction_summary.contains("%s"), "Lantern Silt extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_lantern_silt_sample_research_callout() == "", "Lantern Silt result line should stay hidden before sample recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Lantern Silt Sample"), "Lantern Silt extraction summary should stay hidden before sample recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_lantern_silt_sample_recovered, "Lantern Silt sample should reset between expeditions")
	main.free()

func _test_blackwater_crack_gate_state() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blackwater_crack = true
	main.dive_session.oxygen = 19.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"glow_plankton": 2, "shell_fragments": 1}
	var gate_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel") as Label
	var gate_badge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge") as Polygon2D
	var closed_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard") as Polygon2D
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D

	main.call("_sync_blackwater_crack_gate_state")
	_expect(gate_label.text == "RESONANCE SEAL", "Blackwater Crack should start as a deliberate resonance-sealed route gate")
	_expect(not blackwater_sill.visible, "Blackwater Sill should be hidden before route preparation is ready")
	_expect(dusk_trench.visible, "Dusk Trench should rely on Blackwater Sill parent visibility rather than a separate gate flag")
	var sealed_status: String = main.call("_format_blackwater_gate_status")
	_expect(sealed_status.contains("Echo Lens"), "Blackwater sealed status should name existing scanner preparation")
	_expect(sealed_status.contains("Resonance Key I"), "Blackwater sealed status should name existing key preparation")
	_expect_no_echo_lens_locator_language(sealed_status, "Blackwater sealed status")

	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Blackwater Crack"), "Blackwater proximity should own the active dive prompt")
	_expect(prompt.contains("read Resonance seal"), "Blackwater prompt should explain the narrow gate readback")
	var handled: bool = main.call("_try_blackwater_crack_interaction")
	_expect(handled, "Blackwater Crack should handle interact while nearby during a dive")
	_expect(main.status_label.text.contains("Resonance Key I"), "Blackwater interaction should explain broad preparation")
	_expect(is_equal_approx(main.dive_session.oxygen, 19.0), "Blackwater gate readback should not spend oxygen")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Blackwater gate readback should not change cargo")
	_expect(main.progression_state.resource_count("glow_plankton") == 2, "Blackwater gate readback should not mutate banked resources")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.call("_sync_blackwater_crack_gate_state")
	_expect(gate_label.text == "KEY NEEDED", "Blackwater gate should ask for Resonance Key I after Echo Lens I is owned")
	var key_needed_status: String = main.call("_format_blackwater_gate_status")
	_expect(key_needed_status.contains("Resonance Key I"), "Blackwater key-needed status should stay tied to existing preparation")
	_expect(not key_needed_status.contains("Echo Lens and"), "Blackwater key-needed status should stop asking for Echo Lens after ownership")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	main.call("_sync_blackwater_crack_gate_state")
	_expect(gate_label.text == "KEY READY", "Blackwater gate should show ready after Resonance Key I ownership")
	_expect(gate_badge.color.g >= gate_badge.color.r, "Blackwater ready badge should visually differ from the sealed dark route")
	_expect(closed_shard.color.a <= 0.14, "Blackwater ready state should soften the closed shard without opening an interior yet")
	_expect(blackwater_sill.visible, "Blackwater Sill should become visible after Resonance Key I ownership")
	var ready_status: String = main.call("_format_blackwater_gate_status")
	_expect(ready_status.contains("trace sill"), "Blackwater ready status should name the short route sequence")
	_expect(ready_status.contains("Silt/Blue/Drop"), "Blackwater ready status should compactly name the broad return chain")
	_expect(ready_status.length() <= 52, "Blackwater ready status should fit the active HUD panel")
	_expect_no_echo_lens_locator_language(ready_status, "Blackwater ready status")
	var ready_prompt: String = main.call("_format_hud_prompt")
	_expect(ready_prompt.contains("record trace"), "Blackwater ready prompt should shift from gate readback to the route payoff")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("blackwater_crack"), "Blackwater gate should not add durable route state")
	_expect(not saved.has("blackwater_sill"), "Blackwater gate should not add durable sill state")
	_expect(not saved.has("blackwater_route_open"), "Blackwater gate should derive readiness from existing upgrade ownership")
	main.player_near_blackwater_crack = false
	var not_handled: bool = main.call("_try_blackwater_crack_interaction")
	_expect(not not_handled, "Blackwater Crack should not consume interact outside its proximity zone")
	main.free()

func _test_blackwater_trace_payoff() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blackwater_crack = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["glow_plankton"]
	main.progression_state.banked_resources = {"shell_fragments": 2}
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var trace_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem") as Polygon2D
	var trace_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark") as Polygon2D
	main.call("_sync_blackwater_crack_gate_state")
	_expect(trace_gem.color.a >= 0.7, "Blackwater Trace should start visibly recoverable when the route is open")
	_expect(trace_spark.visible, "Blackwater Trace spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Blackwater Sill"), "Blackwater open-route proximity should own the active dive prompt")
	_expect(prompt.contains("record trace"), "Blackwater prompt should explain the concrete knowledge payoff")

	var handled: bool = main.call("_try_blackwater_crack_interaction")
	_expect(handled, "Blackwater open route should handle interact while nearby during a dive")
	_expect(main.run_blackwater_trace_recovered, "Blackwater interaction should record one run-scoped trace")
	_expect(trace_gem.color.a <= 0.2, "Blackwater Trace should visibly dim after recovery")
	_expect(not trace_spark.visible, "Blackwater Trace spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Blackwater Trace should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["glow_plankton"], "Blackwater Trace should not add or remove cargo")
	_expect(main.progression_state.resource_count("shell_fragments") == 2, "Blackwater Trace should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Blackwater Trace interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("deep-route reading"), "Blackwater Trace status should name the knowledge payoff")
		_expect(main.status_label.text.contains("Silt Vein"), "Blackwater Trace status should remind the broad return chain")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Blackwater Trace status")

	var repeat_handled: bool = main.call("_try_blackwater_crack_interaction")
	_expect(repeat_handled, "Blackwater Trace should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Blackwater Trace repeat interaction should not duplicate the payoff")

	main.player_near_blackwater_crack = false
	var not_handled: bool = main.call("_try_blackwater_crack_interaction")
	_expect(not not_handled, "Blackwater Trace should not consume interact outside its proximity zone")

	var callout: String = main.call("_format_blackwater_trace_research_callout")
	_expect(callout.contains("Blackwater Trace"), "Blackwater Trace result memory should name the payoff")
	_expect(callout.contains("right branch"), "Blackwater Trace result memory should explain the route choice")
	_expect(callout.contains("deeper route"), "Blackwater Trace result memory should hint at future route growth")
	_expect(callout.contains("Silt Vein"), "Blackwater Trace result memory should name the first broad return landmark")
	_expect(callout.contains("Blue Chimney"), "Blackwater Trace result memory should name the mid return landmark")
	_expect(callout.contains("Drop Arch"), "Blackwater Trace result memory should name the upper lower-route landmark")
	_expect_no_echo_lens_locator_language(callout, "Blackwater Trace result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Blackwater Trace"), "Blackwater extraction summary should include recovered trace memory")
	_expect(not extraction_summary.contains("%s"), "Blackwater extraction summary should not leak string placeholders")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("blackwater_trace"), "Blackwater Trace should not become durable save data")
	_expect(not saved.has("blackwater_route"), "Blackwater Trace should not create durable route state")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_blackwater_trace_research_callout() == "", "Blackwater Trace result line should stay hidden before recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Blackwater Trace"), "Blackwater extraction summary should stay hidden before trace recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_blackwater_trace_recovered, "Blackwater Trace should reset between expeditions")
	_expect(trace_gem.color.a >= 0.7, "Blackwater Trace core should become visible again on expedition reset")
	_expect(trace_spark.visible, "Blackwater Trace spark should reset between expeditions")
	main.free()

func _test_glass_kelp_reading_payoff() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_glass_kelp_ledge = true
	main.dive_session.oxygen = 17.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"glow_plankton": 2}
	var reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard") as Polygon2D
	var reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark") as Polygon2D
	main.call("_sync_glass_kelp_reading_state")
	_expect(reading_shard.color.a >= 0.7, "Glass Kelp reading should start visibly recoverable")
	_expect(reading_spark.visible, "Glass Kelp reading spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Glass Kelp Ledge"), "Glass Kelp proximity should own the active dive prompt")
	_expect(prompt.contains("record kelp reading"), "Glass Kelp prompt should explain the concrete payoff")

	var handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	_expect(handled, "Glass Kelp Ledge should handle interact while nearby during a dive")
	_expect(main.run_glass_kelp_reading_recovered, "Glass Kelp interaction should record one run-scoped reading")
	_expect(main.run_reached_dusk_trench, "Glass Kelp interaction should count as reaching Dusk Trench for place memory")
	_expect(reading_shard.color.a <= 0.2, "Glass Kelp reading should visibly dim after recovery")
	_expect(not reading_spark.visible, "Glass Kelp reading spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 17.0), "Glass Kelp reading should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Kelp reading should not add or remove cargo")
	_expect(main.progression_state.resource_count("glow_plankton") == 2, "Glass Kelp reading should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Glass Kelp interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("Blackwater"), "Glass Kelp status should keep broad return language")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Glass Kelp status")

	var repeat_handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	_expect(repeat_handled, "Glass Kelp Ledge should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Glass Kelp repeat interaction should not duplicate the payoff")

	main.player_near_glass_kelp_ledge = false
	var not_handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	_expect(not not_handled, "Glass Kelp Ledge should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("glass_kelp_reading"), "Glass Kelp reading should not become durable save data")
	_expect(not saved.has("glass_kelp"), "Glass Kelp should not create durable route state")
	_expect(not saved.has("dusk_trench"), "Glass Kelp should not create durable Dusk Trench state")

	var callout: String = main.call("_format_glass_kelp_reading_callout")
	_expect(callout.contains("Glass Kelp"), "Glass Kelp result memory should name the payoff")
	_expect(callout.contains("Dusk Trench"), "Glass Kelp result memory should name the broad route context")
	_expect(callout.contains("safer ledge"), "Glass Kelp result memory should explain why the pocket mattered")
	_expect_no_echo_lens_locator_language(callout, "Glass Kelp result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Glass Kelp reading"), "Glass Kelp extraction summary should include recovered reading memory")
	_expect(not extraction_summary.contains("%s"), "Glass Kelp extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_glass_kelp_reading_callout() == "", "Glass Kelp result line should stay hidden before reading recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Glass Kelp reading"), "Glass Kelp extraction summary should stay hidden before reading recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_glass_kelp_reading_recovered, "Glass Kelp reading should reset between expeditions")
	_expect(reading_shard.color.a >= 0.7, "Glass Kelp reading should become visible again on expedition reset")
	_expect(reading_spark.visible, "Glass Kelp reading spark should reset between expeditions")
	main.free()

func _test_hollow_reef_cave_reading_payoff() -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_hollow_reef = true
	main.dive_session.oxygen = 16.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"kelp_fiber": 2}
	var reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard") as Polygon2D
	var reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark") as Polygon2D
	main.call("_sync_hollow_reef_reading_state")
	_expect(reading_shard.color.a >= 0.7, "Hollow Reef cave reading should start visibly recoverable")
	_expect(reading_spark.visible, "Hollow Reef cave reading spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("Hollow Reef"), "Hollow Reef proximity should own the active dive prompt")
	_expect(prompt.contains("E/Enter"), "Hollow Reef prompt should keep the compact interaction command")

	var handled: bool = main.call("_try_hollow_reef_interaction")
	_expect(handled, "Hollow Reef should handle interact while nearby during a dive")
	_expect(main.run_hollow_reef_reading_recovered, "Hollow Reef interaction should record one run-scoped reading")
	_expect(main.run_reached_dusk_trench, "Hollow Reef interaction should count as reaching Dusk Trench for place memory")
	_expect(reading_shard.color.a <= 0.2, "Hollow Reef cave reading should visibly dim after recovery")
	_expect(not reading_spark.visible, "Hollow Reef cave reading spark should disappear after recovery")
	_expect(is_equal_approx(main.dive_session.oxygen, 16.0), "Hollow Reef reading should not spend oxygen directly")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Hollow Reef reading should not add or remove cargo")
	_expect(main.progression_state.resource_count("kelp_fiber") == 2, "Hollow Reef reading should not mutate banked resources")
	if main.status_label != null:
		_expect(main.status_label.text.contains("Return safely"), "Hollow Reef interaction should preserve extraction pressure")
		_expect(main.status_label.text.contains("Dusk"), "Hollow Reef status should keep broad route language")
		_expect(main.status_label.text.contains("Blackwater"), "Hollow Reef status should keep broad return-chain language")
		_expect_no_echo_lens_locator_language(main.status_label.text, "Hollow Reef status")

	var repeat_handled: bool = main.call("_try_hollow_reef_interaction")
	_expect(repeat_handled, "Hollow Reef should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "Hollow Reef repeat interaction should not duplicate the payoff")

	main.player_near_hollow_reef = false
	var not_handled: bool = main.call("_try_hollow_reef_interaction")
	_expect(not not_handled, "Hollow Reef should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	_expect(not saved.has("hollow_reef_reading"), "Hollow Reef reading should not become durable save data")
	_expect(not saved.has("hollow_reef"), "Hollow Reef should not create durable route state")
	_expect(not saved.has("hollow_deeper_reef"), "Hollow Reef deeper promise should not become durable route state")
	_expect(not saved.has("deep_reef_closed"), "Hollow Reef closed promise should not create durable gate state yet")
	_expect(not saved.has("dusk_trench"), "Hollow Reef should not create durable Dusk Trench state")

	var callout: String = main.call("_format_hollow_reef_reading_callout")
	_expect(callout.contains("Hollow Reef"), "Hollow Reef result memory should name the branch")
	_expect(callout.contains("side-cave branch"), "Hollow Reef result memory should explain why the branch mattered")
	_expect(callout.contains("Dusk Trench"), "Hollow Reef result memory should name the broad route context")
	_expect_no_echo_lens_locator_language(callout, "Hollow Reef result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Hollow Reef cave reading"), "Hollow Reef extraction summary should include recovered reading memory")
	_expect(not extraction_summary.contains("%s"), "Hollow Reef extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	_expect(fresh_main._format_hollow_reef_reading_callout() == "", "Hollow Reef result line should stay hidden before reading recovery")
	var fresh_summary: String = fresh_main._format_extraction_result_summary(0, empty_cargo)
	_expect(not fresh_summary.contains("Hollow Reef cave reading"), "Hollow Reef extraction summary should stay hidden before reading recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	_expect(not main.run_hollow_reef_reading_recovered, "Hollow Reef reading should reset between expeditions")
	_expect(reading_shard.color.a >= 0.7, "Hollow Reef cave reading should become visible again on expedition reset")
	_expect(reading_spark.visible, "Hollow Reef cave reading spark should reset between expeditions")
	main.free()

func _test_upgrade_copy_presenter() -> void:
	var cost := {
		"driftwood": 2,
		"quartz_glass": 1,
	}
	var names := {
		"driftwood": "Driftwood",
		"quartz_glass": "Quartz Glass",
	}
	var owned := {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	_expect(UpgradeCopyPresenterScript.format_upgrade_cost({}, names) == "none", "empty upgrade costs should show none")
	_expect(UpgradeCopyPresenterScript.format_upgrade_cost(cost, names).contains("Driftwood x2"), "upgrade cost copy should use display names")
	_expect(UpgradeCopyPresenterScript.format_missing_resources(cost, owned, names).contains("Driftwood x1"), "missing resource block should include missing display names")
	_expect(not UpgradeCopyPresenterScript.format_missing_resources(cost, owned, names).contains("Quartz Glass"), "missing resource block should omit fully owned resources")
	_expect(UpgradeCopyPresenterScript.format_missing_resources_inline(cost, owned, names) == "Driftwood x1", "inline missing resources should stay comma-free for one item")
	_expect(UpgradeCopyPresenterScript.format_missing_resources_inline(cost, {"driftwood": 2, "quartz_glass": 1}, names) == "none", "inline missing resources should report none when complete")
	_expect(UpgradeCopyPresenterScript.format_material_need_list([]) == "materials", "empty material lists should keep fallback copy")
	_expect(UpgradeCopyPresenterScript.format_material_need_list(["Driftwood", "Quartz Glass"]) == "Driftwood/Quartz Glass", "two material lists should use slash copy")
	_expect(UpgradeCopyPresenterScript.format_need_list(["Food", "Water", "Power"]) == "Food/Water/Power", "three base needs should stay compact")
	_expect(UpgradeCopyPresenterScript.format_upgrade_effect_summary(EchoLensUpgrade.id, EchoLensUpgrade.owned_text).contains("not a locator"), "upgrade effect presenter should preserve Echo Lens role copy")
	_expect(UpgradeCopyPresenterScript.format_standard_upgrade_state("Effect: +10 max O2.", false, "", "", true, "E or Enter", "none").begins_with("State: Available now"), "standard upgrade state presenter should format available upgrades")
	_expect(UpgradeCopyPresenterScript.format_resonance_key_upgrade_state("Effect: opens East Shelf hatch only.", false, "", true, false, "E or Enter", "Glow Plankton x1").contains("Recover: East Shelf or Drop Echo"), "resonance upgrade presenter should preserve route-research copy")
	_expect(UpgradeCopyPresenterScript.format_salvage_cutter_upgrade_state("Effect: opens the sealed Wide Reef salvage pocket.", false, true, false, "E or Enter", "Shell Fragments x1").contains("Recover: Salvage Data Cache"), "salvage upgrade presenter should preserve cache evidence copy")
	_expect(UpgradeCopyPresenterScript.format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.") == "Banked 3 resource(s).\nNo upgrade ready yet.", "upgrade feedback presenter should compact deposit copy")
	_expect(UpgradeCopyPresenterScript.format_ready_upgrade_callout(["Oxygen Tank I"]) == "Ready upgrade: Oxygen Tank I.", "ready upgrade presenter should keep ready callout copy")

func _test_upgrade_bay_readability_states() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		EchoLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
	]

	var state := main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Missing resources"), "upgrade bay should label unaffordable upgrades")
	_expect(state.contains("Needs: Glow Plankton x1"), "upgrade bay should show missing resources inline")

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Available now"), "upgrade bay should label affordable upgrades")
	_expect(main._format_ready_upgrade_callout().contains("Oxygen Tank I"), "upgrade bay should call out newly ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	state = main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label owned upgrades")

	state = main._format_upgrade_state(WaterFilterUpgrade)
	_expect(state.begins_with("State: Missing resources"), "Water Filter I should show missing starter resources")
	_expect(state.contains("Driftwood x1"), "Water Filter I should name missing driftwood")
	_expect(state.contains("Quartz Glass x1"), "Water Filter I should name missing quartz glass")
	var missing_scene := MainScene.instantiate()
	root.add_child(missing_scene)
	missing_scene.dive_session.extract()
	missing_scene.surface_tab_index = missing_scene.SURFACE_TAB_UPGRADES
	missing_scene.selected_upgrade_index = 0
	missing_scene.call("_try_purchase_selected_upgrade")
	_expect(missing_scene.upgrade_menu_feedback.contains("Missing Driftwood x1, Quartz Glass x1"), "missing Water Filter feedback should name starter material shortage")
	_expect(missing_scene.upgrade_menu_feedback.contains("Next: bank it for Water Filter I."), "missing Water Filter feedback should turn shortage into a tomorrow plan")
	missing_scene.queue_free()
	var starter_goal := ExpeditionGoalFormatterScript.format_goal(main.progression_state, [WaterFilterUpgrade])
	_expect(starter_goal.contains("Driftwood x1") and starter_goal.contains("Quartz Glass x1"), "ready goal should display starter resource names for Water Filter I")
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	state = main._format_upgrade_state(WaterFilterUpgrade)
	_expect(state.begins_with("State: Available now"), "Water Filter I should become available after starter resources are banked")
	var water_before := main.survival_state.water
	_expect(UpgradePurchaseScript.purchase(main.progression_state, WaterFilterUpgrade), "Water Filter I should purchase through the normal upgrade pipeline")
	main.call("_apply_upgrade_effect", WaterFilterUpgrade.effect_id)
	_expect(main.survival_state.water == water_before + 1, "Water Filter I effect should add one water reserve")
	state = main._format_upgrade_state(WaterFilterUpgrade)
	_expect(state.begins_with("State: Owned"), "Water Filter I should show owned after purchase")

	state = main._format_upgrade_state(PressureSealUpgrade)
	_expect(state.begins_with("State: Locked by scan"), "upgrade bay should label scan-locked upgrades")
	_expect(state.contains("Scan: Thermal Vent"), "upgrade bay should name missing discoveries")

	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Locked by scan"), "upgrade bay should label Echo Lens I scan-locked before Wreck Signal Cache")
	_expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I state should distinguish it from Signal Lens I without locator language")

	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks scanner tuning.")
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label Echo Lens I as upgrade-locked before Signal Lens I")
	_expect(state.contains("Install: Signal Lens I"), "upgrade bay should name Signal Lens I as the Echo Lens prerequisite")
	_expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I locked-upgrade state should keep its compact role hint")

	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Missing resources"), "upgrade bay should label Echo Lens I missing resources after prerequisites are met")
	_expect(state.contains("Needs: Glow Plankton x1"), "Echo Lens I missing-resource state should show only remaining cost")
	_expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I missing-resource state should keep its compact role hint")

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Available now"), "upgrade bay should label Echo Lens I available after prerequisites and resources are ready")
	_expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I available state should keep its compact role hint")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label Echo Lens I owned after purchase")
	_expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I owned state should keep its compact role hint")

	state = main._format_upgrade_state(ResonanceKeyUpgrade)
	_expect(state.begins_with("State: Needs route research"), "Resonance Key I should ask for route research after Echo Lens I is owned")
	_expect(state.contains("Recover: East Shelf or Drop Echo"), "Resonance Key I should name the broad route-research requirement")
	_expect(state.contains("Effect: opens East Shelf hatch only."), "Resonance Key I should keep hatch-specific effect copy")
	_expect_no_echo_lens_locator_language(state, "Resonance Key I route-research state")

	main.progression_state.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(ResonanceKeyUpgrade)
	_expect(state.begins_with("State: Missing resources"), "Resonance Key I should show missing resources after prerequisites are met")
	_expect(state.contains("Needs: Glow Plankton x1"), "Resonance Key I should show only missing glow plankton")
	_expect_no_echo_lens_locator_language(state, "Resonance Key I missing-resource state")

	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(ResonanceKeyUpgrade)
	_expect(state.begins_with("State: Available now"), "Resonance Key I should become available after route context and resources")
	_expect_no_echo_lens_locator_language(state, "Resonance Key I available state")

	main.progression_state.purchase_upgrade(ResonanceKeyUpgrade.id, ResonanceKeyUpgrade.resource_cost)
	state = main._format_upgrade_state(ResonanceKeyUpgrade)
	_expect(state.begins_with("State: Owned"), "Resonance Key I should show owned state after purchase")
	_expect(state.contains("Effect: opens East Shelf hatch only."), "Resonance Key I owned state should stay hatch-specific")
	_expect_no_echo_lens_locator_language(state, "Resonance Key I owned state")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label upgrade-locked upgrades")
	_expect(state.contains("Install: Predator Warning I"), "upgrade bay should name missing upgrade prerequisites")

	main.progression_state.purchased_upgrades[PredatorWarningUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Available now"), "Decoy Pulse I should become available after discovery, prerequisite upgrade, and resources")

	main.progression_state.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label Decoy Pulse I owned after purchase")
	_expect(main._format_upgrade_effect_summary(EchoLensUpgrade).contains("not a locator"), "Echo Lens I compact effect summary should preserve no-locator wording")
	_expect(main._format_future_tool_upgrade_promise() == "", "future cutter promise should stay hidden before lower-route evidence")
	var feedback := main._format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.")
	_expect(feedback == "Banked 3 resource(s).\nNo upgrade ready yet.", "upgrade panel feedback should compact deposit copy")
	_expect_lines_within(feedback, 72, "compacted upgrade feedback")

	main.run_salvage_data_cache_recovered = true
	var cutter_promise := main._format_future_tool_upgrade_promise()
	_expect(cutter_promise == "", "future cutter promise should be removed now that Salvage Cutter I is a real upgrade entry")
	_expect_lines_within(cutter_promise, 72, "future cutter promise")
	_expect_no_echo_lens_locator_language(cutter_promise, "future cutter promise")

	var promised_feedback := main._format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.")
	_expect(promised_feedback.contains("Banked 3 resource(s)."), "future cutter promise should not replace normal upgrade feedback")
	_expect(not promised_feedback.contains("Planned: Salvage Cutter"), "upgrade feedback should not append obsolete planned cutter copy")
	_expect_lines_within(promised_feedback, 72, "future cutter promised feedback")
	var cutter_state := main._format_upgrade_state(SalvageCutterUpgrade)
	_expect(cutter_state.begins_with("State: Needs salvage data"), "Salvage Cutter I should be locked by recovered cache evidence before extraction")
	_expect(cutter_state.contains("Recover: Salvage Data Cache"), "Salvage Cutter I should name the broad evidence prerequisite")
	_expect(cutter_state.contains("Wide Reef salvage pocket"), "Salvage Cutter I should stay scoped to the sealed Wide Reef pocket")
	main.progression_state.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	main.progression_state.banked_resources = {
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	cutter_state = main._format_upgrade_state(SalvageCutterUpgrade)
	_expect(cutter_state.begins_with("State: Missing resources"), "Salvage Cutter I should show missing resources after evidence is recovered")
	_expect(cutter_state.contains("Shell Fragments x1"), "Salvage Cutter I should show only the remaining existing-resource cost")
	main.progression_state.banked_resources = {
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	cutter_state = main._format_upgrade_state(SalvageCutterUpgrade)
	_expect(cutter_state.begins_with("State: Available now"), "Salvage Cutter I should become available after evidence and existing resources")
	main.progression_state.purchase_upgrade(SalvageCutterUpgrade.id, SalvageCutterUpgrade.resource_cost)
	cutter_state = main._format_upgrade_state(SalvageCutterUpgrade)
	_expect(cutter_state.begins_with("State: Owned"), "Salvage Cutter I should show owned after normal upgrade purchase")
	main.run_salvage_data_cache_recovered = false
	main.recent_expedition_log = [{"route_memory": "Wide Reef Chamber"}]
	_expect(main._format_future_tool_upgrade_promise() == "", "recent Wide Reef Chamber memory should not revive obsolete future cutter promise copy")
	main.free()

func _test_result_and_upgrade_copy_length_guards() -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 4
	main.progression_state.current_run_seed = 32676
	main.current_resource_cluster_pattern = "deep_reward"
	main.current_predator_route_id = "lower_predator_gate"
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	main.run_collected_resources = ["glow_plankton", "shell_fragments", "kelp_fiber"]
	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache", "gulper_eel"]
	main.run_predator_contacts = 1
	main.run_echo_lens_echo_fired = true
	main.run_wreck_echo_clue_recovered = true
	main.decoy_pulse_used_this_run = true

	var compact_result := "\n".join([
		main._format_completed_expedition_line("Extraction"),
		main._format_extraction_banking_line(3, main.run_collected_resources),
		main._format_region_memory_callout(),
		main._format_discovery_memory_callout(),
		main._format_route_choice_callout(),
		main._format_gulper_research_callout(),
		main._format_echo_lens_research_callout(),
		main._format_wreck_echo_research_callout(),
		main._format_upgrade_progress_callout(),
		main._format_scan_progress_callout("Discoveries recorded"),
		main._format_next_expedition_prompt(),
	])
	_expect_lines_within(compact_result, 96, "player-facing result summary")
	_expect(not main._format_run_summary(compact_result, "Extraction").contains("Playtest data:"), "result copy length guard should keep debug telemetry gated")

	main.show_debug_telemetry = true
	_expect(main._format_run_summary(compact_result, "Extraction").contains("Playtest data:"), "debug telemetry should remain opt-in for long result checks")
	main.show_debug_telemetry = false

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal cache.", "Scanner curiosity.")
	var upgrade_states := [
		main._format_upgrade_state(OxygenTankUpgrade),
		main._format_upgrade_state(PressureSealUpgrade),
		main._format_upgrade_state(EchoLensUpgrade),
	]
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	upgrade_states.append(main._format_upgrade_state(EchoLensUpgrade))
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	upgrade_states.append(main._format_upgrade_state(EchoLensUpgrade))
	for index in range(upgrade_states.size()):
		_expect_lines_within(String(upgrade_states[index]), 88, "upgrade state %d" % index)

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	for label_path in [
		"HUD/RunPanel/RunSummary",
		"HUD/UpgradePanel/UpgradeMenuItem",
		"HUD/UpgradePanel/UpgradeMenuCost",
		"HUD/UpgradePanel/UpgradeMenuState",
		"HUD/UpgradePanel/UpgradeMenuFeedback",
	]:
		var label: Label = main_scene.get_node(label_path)
		_expect(label.autowrap_mode != TextServer.AUTOWRAP_OFF, "%s should keep wrapping enabled" % label_path)
	var run_panel: Panel = main_scene.get_node("HUD/RunPanel")
	var run_summary_label: Label = main_scene.get_node("HUD/RunPanel/RunSummary")
	main_scene.run_panel = run_panel
	main_scene.surface_tabs_label = main_scene.get_node("HUD/RunPanel/SurfaceTabs")
	main_scene.run_title_label = main_scene.get_node("HUD/RunPanel/RunTitle")
	main_scene.run_summary_label = run_summary_label
	main_scene.call("_apply_run_panel_layout", false)
	_expect(run_panel.offset_left == 44.0 and run_panel.offset_right == 850.0, "result surface panel should use the wide layout")
	_expect(run_panel.offset_bottom >= 672.0, "result surface panel should be tall enough to contain result copy")
	_expect(run_summary_label.offset_bottom <= run_panel.offset_bottom - run_panel.offset_top, "result summary label should stay inside the run panel")
	_expect(run_summary_label.clip_text, "result summary label should clip instead of drawing outside the panel")
	main_scene.call("_apply_run_panel_layout", true)
	_expect(run_panel.offset_left == 420.0 and run_panel.offset_bottom == 362.0, "upgrade surface tab should keep compact run panel above the upgrade details")
	var upgrade_panel: Panel = main_scene.get_node("HUD/UpgradePanel")
	var upgrade_feedback: Label = main_scene.get_node("HUD/UpgradePanel/UpgradeMenuFeedback")
	_expect(upgrade_panel.offset_bottom <= 704.0, "upgrade details panel should leave a visible bottom margin at 1280x720")
	_expect(upgrade_feedback.offset_bottom <= upgrade_panel.offset_bottom - upgrade_panel.offset_top - 14.0, "upgrade feedback label should stay inside the upgrade panel")
	_expect(upgrade_feedback.clip_text, "upgrade feedback should clip instead of drawing outside the panel")
	main_scene.queue_free()
	main.free()

func _test_recent_expedition_presenter() -> void:
	var empty_log := RecentExpeditionPresenterScript.format_recent_expedition_log([], false, {})
	_expect(empty_log == "Recent Expeditions\nNone yet.", "recent expedition presenter should keep empty-log copy exact")

	var entries: Array[Dictionary] = [{
		"run_number": 7,
		"result": "Extracted",
		"banked_cargo_count": 2,
		"route_memory": "Outer Shelf",
		"scans": ["thermal_vent", "unknown_scan"],
		"predator_contacts": 1,
		"best_depth": 88,
		"survival_memory": "banked Food supply",
		"seed": 1234,
		"pattern": "Cautious shallows",
	}]
	var scan_names := {
		"thermal_vent": "Thermal Vent",
	}
	var log_text := RecentExpeditionPresenterScript.format_recent_expedition_log(entries, false, scan_names)
	_expect(log_text.contains("#7 Extracted: banked 2, route Outer Shelf"), "recent expedition presenter should include run number, result, banked cargo, and route")
	_expect(log_text.contains("scans Thermal Vent/unknown_scan"), "recent expedition presenter should use provided scan names with id fallback")
	_expect(log_text.contains("next Glass Rim timing or cargo"), "recent expedition presenter should keep route tease copy")
	_expect(log_text.contains("survival banked Food supply"), "recent expedition presenter should append survival memory")
	_expect(not log_text.contains("seed 1234"), "recent expedition presenter should hide seed without debug telemetry")

	var debug_text := RecentExpeditionPresenterScript.format_recent_expedition_log(entries, true, scan_names)
	_expect(debug_text.contains("seed 1234, Cautious shallows"), "recent expedition presenter should expose debug telemetry when requested")
	_expect(RecentExpeditionPresenterScript.format_recent_route_tease("Glass Rim") == "timing, cargo, or return", "Glass Rim route tease should stay exact")
	_expect(RecentExpeditionPresenterScript.format_recent_route_tease("Shell Reef") == "", "non-tease routes should remain quiet")
	_expect(RecentExpeditionPresenterScript.format_scan_names_short([], scan_names) == "none", "empty scan lists should stay compact")
	_expect(RecentExpeditionPresenterScript.string_array_from("bad data").is_empty(), "non-array scan data should be ignored")

func _test_recent_expedition_log() -> void:
	var main := MainScript.new()
	main.current_resource_cluster_pattern = "cautious"
	_expect(main._latest_recent_route_memory() == "", "empty recent expedition log should not provide ready-route memory")

	for run_number in range(1, 5):
		main.progression_state.current_run_number = run_number
		main.progression_state.current_run_seed = 1000 + run_number
		main.progression_state.best_depth_reached = 10.0 * run_number
		main.run_completed_scans.clear()
		if run_number % 2 == 0:
			main.run_completed_scans.append("thermal_vent")
		main.run_predator_contacts = run_number - 1
		main._record_recent_expedition("Extracted", run_number)

	_expect(main.recent_expedition_log.size() == 3, "recent expedition log should keep only the latest three entries")
	var log_text := main._format_recent_expedition_log()
	_expect(not log_text.contains("#1"), "recent expedition log should drop the oldest entry")
	_expect(log_text.contains("#2 Extracted"), "recent expedition log should include the oldest retained entry")
	_expect(log_text.contains("route Gulper Route"), "recent expedition log should preserve one compact route memory")
	_expect(log_text.contains("scans Thermal Vent"), "recent expedition log should show readable scan names")
	_expect(log_text.contains("contacts 3"), "recent expedition log should show predator contacts")
	_expect(not log_text.contains("seed"), "recent expedition log should hide seed by default")
	_expect_lines_within(log_text, 120, "recent expedition log")

	main.show_debug_telemetry = true
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("seed 1004"), "recent expedition log should show seed only with debug telemetry")
	_expect(log_text.contains("Cautious shallows"), "recent expedition log should show pattern only with debug telemetry")
	main.show_debug_telemetry = false

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 8
	main.progression_state.current_run_seed = 2008
	main.progression_state.best_depth_reached = 280.0
	main.run_completed_scans = ["lantern_ray"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main._record_recent_expedition("Extracted", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#8 Extracted"), "recent expedition log should include Lantern Ray observation runs")
	_expect(log_text.contains("route Lantern Ray"), "Lantern Ray observation should produce compact recent route memory")
	_expect(log_text.contains("scans Lantern Ray"), "Lantern Ray scan should appear with readable scan names")
	_expect(not log_text.contains("seed"), "Lantern Ray recent log should hide raw seed without debug telemetry")
	_expect(not log_text.to_lower().contains("field guide"), "Lantern Ray recent log should not imply field-guide UI")
	_expect(not log_text.to_lower().contains("checklist"), "Lantern Ray recent log should not imply checklist UI")
	_expect_no_monster_combat_language(log_text, "Lantern Ray recent expedition log")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 82
	main.progression_state.current_run_seed = 2082
	main.progression_state.best_depth_reached = 336.0
	main.run_completed_scans = ["glassfin_swarm"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	var save_before_recent_glassfin: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#82 Extracted"), "recent expedition log should include Glassfin Swarm observation runs")
	_expect(log_text.contains("route Glassfin Swarm"), "Glassfin Swarm observation should produce compact recent route memory")
	_expect(log_text.contains("scans Glassfin Swarm"), "Glassfin Swarm scan should appear with readable scan name")
	_expect(not log_text.contains("seed"), "Glassfin Swarm recent log should hide raw seed without debug telemetry")
	_expect(not log_text.to_lower().contains("field guide"), "Glassfin Swarm recent log should not imply field-guide UI")
	_expect(not log_text.to_lower().contains("checklist"), "Glassfin Swarm recent log should not imply checklist UI")
	_expect_no_monster_combat_language(log_text, "Glassfin Swarm recent expedition log")
	_expect(main._latest_recent_route_memory() == "Glassfin Swarm", "latest route helper should expose Glassfin Swarm after a swarm observation")
	_expect(main.progression_state.to_save_data() == save_before_recent_glassfin, "Glassfin Swarm recent route memory should remain session-only")
	_expect(not main.progression_state.to_save_data().has("glassfin_swarm_route"), "recent Glassfin Swarm memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 81
	main.progression_state.current_run_seed = 2081
	main.progression_state.best_depth_reached = 260.0
	main.run_completed_scans = ["lantern_ray"]
	main.run_predator_contacts = 1
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	main._record_recent_expedition("Extracted", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("route Gulper Route"), "recent log should keep predator safety memory when no deeper route wins")
	_expect(not log_text.contains("route Lantern Ray"), "predator safety memory should win over passive creature observation after contact")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 9
	main.progression_state.current_run_seed = 2009
	main.progression_state.best_depth_reached = 208.0
	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main._record_recent_expedition("Failed", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#9 Failed"), "recent expedition log should include failed Blackwater attempts")
	_expect(log_text.contains("route Blackwater"), "recent expedition log should prioritize the deepest reached route")
	_expect(log_text.find("route Blackwater") == log_text.rfind("route Blackwater"), "recent expedition log should not duplicate Blackwater route memory")
	_expect(not log_text.contains("seed"), "Blackwater recent log should hide raw seed without debug telemetry")
	_expect_no_echo_lens_locator_language(log_text, "Blackwater recent expedition log")
	_expect(main._latest_recent_route_memory() == "Blackwater", "latest route helper should expose Blackwater for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 10
	main.progression_state.current_run_seed = 2010
	main.progression_state.best_depth_reached = 302.0
	main.run_completed_scans = ["thermal_vent", "lantern_ray", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main._record_recent_expedition("Extracted", 1)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#10 Extracted"), "recent expedition log should include Dusk route attempts")
	_expect(log_text.contains("route Dusk Trench"), "recent expedition log should prioritize Dusk reach evidence")
	_expect(not log_text.contains("route Blackwater"), "Dusk recent route memory should take priority over Blackwater")
	_expect(not log_text.contains("route Lantern Ray"), "Dusk recent route memory should take priority over Lantern Ray observation")
	_expect(not log_text.contains("route Glassfin Swarm"), "Dusk recent route memory should take priority over Glassfin observation")
	_expect(log_text.contains("scans Thermal Vent/Lantern Ray"), "Dusk recent log should still keep compact scan names when Lantern Ray was scanned")
	_expect(log_text.find("route Dusk Trench") == log_text.rfind("route Dusk Trench"), "recent expedition log should not duplicate Dusk route memory")
	_expect(not log_text.contains("seed"), "Dusk recent log should hide raw seed without debug telemetry")
	_expect_no_echo_lens_locator_language(log_text, "Dusk recent expedition log")
	_expect(main._latest_recent_route_memory() == "Dusk Trench", "latest route helper should expose Dusk for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 11
	main.progression_state.current_run_seed = 2011
	main.progression_state.best_depth_reached = 312.0
	main.run_completed_scans = ["thermal_vent", "lantern_ray", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main._record_recent_expedition("Extracted", 1)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#11 Extracted"), "recent expedition log should include Hollow Reef route attempts")
	_expect(log_text.contains("route Hollow Reef"), "recent expedition log should prioritize Hollow Reef over Dusk and Blackwater")
	_expect(not log_text.contains("route Dusk Trench"), "Hollow Reef recent route memory should take priority over Dusk")
	_expect(not log_text.contains("route Blackwater"), "Hollow Reef recent route memory should take priority over Blackwater")
	_expect(not log_text.contains("route Glassfin Swarm"), "Hollow Reef recent route memory should take priority over Glassfin observation")
	_expect(not log_text.contains("route Lantern Ray"), "Hollow Reef recent route memory should take priority over creature observation")
	_expect_no_echo_lens_locator_language(log_text, "Hollow Reef recent expedition log")
	_expect(main._latest_recent_route_memory() == "Hollow Reef", "latest route helper should expose Hollow Reef for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 13
	main.progression_state.current_run_seed = 2013
	main.progression_state.best_depth_reached = 340.0
	main.run_completed_scans = ["thermal_vent", "hollow_reef_skitter", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 1
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main.run_salvage_data_cache_recovered = true
	var save_before_recent_wide_chamber: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 1)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#13 Extracted"), "recent expedition log should include wide chamber salvage runs")
	_expect(log_text.contains("route Wide Reef Chamber"), "wide chamber salvage evidence should produce compact recent route memory")
	_expect(not log_text.contains("route Hollow Reef"), "wide chamber recent route memory should take priority over Hollow Reef when salvage evidence exists")
	_expect(not log_text.contains("route Dusk Trench"), "wide chamber recent route memory should take priority over Dusk when salvage evidence exists")
	_expect(not log_text.contains("route Blackwater"), "wide chamber recent route memory should take priority over Blackwater")
	_expect(not log_text.contains("route Glassfin Swarm"), "wide chamber recent route memory should take priority over passive Glassfin observation")
	_expect(not log_text.to_lower().contains("checklist"), "wide chamber recent log should not imply checklist UI")
	_expect(not log_text.to_lower().contains("field guide"), "wide chamber recent log should not imply field-guide UI")
	_expect_no_echo_lens_locator_language(log_text, "Wide Reef Chamber recent expedition log")
	_expect(main._latest_recent_route_memory() == "Wide Reef Chamber", "latest route helper should expose Wide Reef Chamber after salvage cache evidence")
	_expect(main.progression_state.to_save_data() == save_before_recent_wide_chamber, "wide chamber recent route memory should remain session-only")
	_expect(not main.progression_state.to_save_data().has("wide_reef_chamber_route"), "recent wide chamber memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 14
	main.progression_state.current_run_seed = 2014
	main.progression_state.best_depth_reached = 352.0
	main.run_completed_scans = ["mirrorfin_drift"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main.run_salvage_data_cache_recovered = true
	main.run_tideglass_sample_recovered = true
	var save_before_recent_mirror_kelp: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#14 Extracted"), "recent expedition log should include Mirror Kelp branch runs")
	_expect(log_text.contains("route Mirror Kelp Pass"), "Mirror Kelp evidence should produce compact recent route memory")
	_expect(log_text.contains("scans Mirrorfin Drift"), "Mirrorfin scan should appear with readable scan name")
	_expect(not log_text.contains("route Wide Reef Chamber"), "Mirror Kelp recent route memory should take priority over upstream wide chamber memory")
	_expect(not log_text.contains("route Hollow Reef"), "Mirror Kelp recent route memory should take priority over upstream Hollow Reef memory")
	_expect(not log_text.contains("seed"), "Mirror Kelp recent log should hide raw seed without debug telemetry")
	_expect(not log_text.to_lower().contains("checklist"), "Mirror Kelp recent log should not imply checklist UI")
	_expect(not log_text.to_lower().contains("field guide"), "Mirror Kelp recent log should not imply field-guide UI")
	_expect_no_echo_lens_locator_language(log_text, "Mirror Kelp recent expedition log")
	_expect(main._latest_recent_route_memory() == "Mirror Kelp Pass", "latest route helper should expose Mirror Kelp Pass after branch evidence")
	_expect(main.progression_state.to_save_data() == save_before_recent_mirror_kelp, "Mirror Kelp recent route memory should remain session-only")
	_expect(not main.progression_state.to_save_data().has("mirror_kelp_pass_route"), "recent Mirror Kelp memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.run_tideglass_sample_recovered = false
	main.progression_state.current_run_number = 12
	main.progression_state.current_run_seed = 2012
	main.progression_state.best_depth_reached = 316.0
	main.run_completed_scans = ["hollow_reef_skitter"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	main.run_salvage_data_cache_recovered = false
	var save_before_recent_hollow: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("#12 Extracted"), "recent expedition log should include Hollow Reef Skitter observation runs")
	_expect(log_text.contains("route Hollow Reef"), "Hollow Reef Skitter observation should produce compact Hollow Reef recent route memory")
	_expect(log_text.contains("scans Hollow Reef Skitter"), "Hollow Reef Skitter scan should appear with readable scan name")
	_expect(not log_text.contains("seed"), "Hollow Reef recent log should hide raw seed without debug telemetry")
	_expect(not log_text.to_lower().contains("checklist"), "Hollow Reef recent log should not imply checklist UI")
	_expect(not log_text.to_lower().contains("field guide"), "Hollow Reef recent log should not imply field-guide UI")
	_expect_no_echo_lens_locator_language(log_text, "Hollow Reef Skitter recent expedition log")
	_expect(main._latest_recent_route_memory() == "Hollow Reef", "latest route helper should expose Hollow Reef after a Skitter observation")
	_expect(main.progression_state.to_save_data() == save_before_recent_hollow, "Hollow Reef recent route memory should remain session-only")
	_expect(not main.progression_state.to_save_data().has("hollow_reef_route"), "recent Hollow Reef memory should not create durable route state")
	main.free()

func _test_recent_expedition_survival_memory() -> void:
	var banked := MainScript.new()
	banked.progression_state.current_run_number = 21
	banked.progression_state.best_depth_reached = 72.0
	banked.run_banked_survival_supplies = ["food_supply", "power_supply"]
	banked._record_recent_expedition("Extracted", 2)
	var log_text := banked._format_recent_expedition_log()
	_expect(log_text.contains("survival banked Food/Power supply"), "recent log should remember banked survival supplies compactly")
	_expect(not log_text.contains("seed"), "survival memory should not expose debug seed data")
	_expect_lines_within(log_text, 120, "recent expedition survival log")
	banked.free()

	var damaged := MainScript.new()
	damaged.progression_state.current_run_number = 22
	damaged.run_banked_survival_supplies = ["food_supply"]
	damaged.run_health_damage_events = 1
	damaged.dive_session.health = 82.0
	damaged.dive_session.max_health = 100.0
	damaged._record_recent_expedition("Extracted", 1)
	log_text = damaged._format_recent_expedition_log()
	_expect(log_text.contains("survival health 82/100; med used build"), "health damage should be the most important survival memory")
	_expect(not log_text.contains("survival banked Food"), "health memory should keep the line to one survival tradeoff")
	damaged.free()

	var late := MainScript.new()
	late.progression_state.current_run_number = 23
	late.daylight_nightfall_away_from_ship = true
	late.run_banked_survival_supplies = ["power_supply"]
	late._record_recent_expedition("Extracted", 1)
	log_text = late._format_recent_expedition_log()
	_expect(log_text.contains("survival late return cost Power -1"), "late return should be remembered as a survival tradeoff")
	_expect(not log_text.contains("survival banked Power"), "late return should keep one compact survival memory")
	late.free()

	var low_need := MainScript.new()
	low_need.progression_state.current_run_number = 24
	low_need.survival_state.food = 2
	low_need.survival_state.water = 1
	low_need.survival_state.power = 0
	low_need._record_recent_expedition("Extracted", 1)
	log_text = low_need._format_recent_expedition_log()
	_expect(log_text.contains("survival low Water/Power"), "recent log should remember low base needs when no sharper tradeoff exists")
	low_need.free()

	var target := MainScript.new()
	target.progression_state.current_run_number = 25
	target._record_recent_expedition("Extracted", 0)
	log_text = target._format_recent_expedition_log()
	_expect(log_text.contains("survival Water Filter needs Driftwood/Quartz Glass"), "no-cargo starter returns should remember the Water Filter material target")
	target.free()

	var retained := MainScript.new()
	for run_number in range(1, 5):
		retained.progression_state.current_run_number = run_number
		retained.progression_state.best_depth_reached = 20.0 * run_number
		retained.run_banked_survival_supplies.clear()
		if run_number == 4:
			retained.run_banked_survival_supplies = ["water_supply"]
		retained._record_recent_expedition("Extracted", run_number)

	log_text = retained._format_recent_expedition_log()
	_expect(retained.recent_expedition_log.size() == 3, "survival-memory recent log should keep only three entries")
	_expect(not log_text.contains("#1"), "survival-memory recent log retention should drop the oldest entry")
	_expect(log_text.contains("#4 Extracted"), "survival-memory recent log should retain the newest entry")
	_expect(log_text.contains("survival banked Water supply"), "retained newest entry should keep its survival memory")
	_expect(not log_text.contains("Playtest data"), "recent log survival memory should not expose debug telemetry")
	_expect_lines_within(log_text, 120, "recent expedition survival retention log")
	retained.free()

func _test_thermal_vent_scan_clue_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "thermal_vent"
	target.display_name = "Thermal Vent"
	target.description = "Warm current."

	var first_guidance := main._format_first_scan_guidance(target)
	_expect(first_guidance.contains("Warm current"), "thermal vent first scan should name the warm-current clue")
	_expect(first_guidance.contains("optional glow"), "thermal vent first scan should keep glow route optional")
	_expect(first_guidance.contains("Pressure Seal clue"), "thermal vent first scan should explain pressure-seal knowledge")
	_expect(main._format_repeat_scan_effect_text(target).contains("glow route optional"), "thermal vent repeat scan should stay concise and optional")
	target.free()
	main.free()

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	var hidden_glow: Area2D = main_scene.get_node("ResourcePickups/HiddenGlowPlankton")
	var vent_route_hint: Node2D = main_scene.get_node("VentRouteHint")
	main_scene.call("_reveal_thermal_vent_route")
	_expect(vent_route_hint.visible, "thermal vent scan should reveal the optional route hint")
	_expect(not hidden_glow.visible, "thermal vent scan should not create an extra active Glow Plankton pickup")
	_expect(not hidden_glow.monitoring, "thermal vent scan should not enable hidden Glow Plankton collision")
	main_scene.queue_free()

func _test_shell_reef_scan_clue_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "shell_reef_shelf"
	target.display_name = "Shell Reef Shelf"
	target.description = "Reef shelf."

	_expect(main._format_discovery_name("shell_reef_shelf") == "Shell Reef Shelf", "shell reef discovery should have a readable name")
	_expect(main._format_repeat_scan_effect_text(target).contains("Reef route clue refreshed"), "shell reef repeat scan should give compact feedback")
	_expect(main._format_first_scan_guidance(target).contains("midwater bank route"), "shell reef first scan should explain the route decision")
	_expect(main._format_scan_target_type(target) == "environment", "shell reef scan target should be environmental metadata")
	target.free()
	main.free()

func _test_wreck_signal_cache_repeat_scan_hint() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "wreck_signal_cache"
	target.display_name = "Wreck Signal Cache"
	target.description = "Cache ping."

	_expect(main._format_repeat_scan_effect_text(target).contains("Signal Lens I"), "cache repeat scan before Signal Lens I should refresh the current upgrade clue")
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	_expect(main._format_wreck_cache_repeat_hint().contains("Cache echo unresolved"), "cache repeat helper should name the unresolved echo")
	var repeat_hint := main._format_repeat_scan_effect_text(target)
	_expect(repeat_hint.contains("Echo Lens"), "cache repeat scan after Signal Lens I should hint at future echo-lens study")
	_expect(repeat_hint.contains("deeper wreck signals"), "cache repeat scan should imply unresolved wreck signals without exact coordinates")
	_expect(not repeat_hint.to_lower().contains("map"), "cache repeat scan should not introduce map UI language")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	repeat_hint = main._format_repeat_scan_effect_text(target)
	_expect(repeat_hint.contains("Echo Lens: weak wreck echo lingers below the shelf"), "Echo Lens I should turn the cache hint into a broad local wreck echo")
	_expect_no_echo_lens_locator_language(repeat_hint, "Echo Lens I repeat scan echo")
	_expect(main._format_signal_lens_pulse_text(target) == "", "Wreck Signal Cache repeat hint should not reuse resource pulse behavior")
	target.free()
	main.free()

func _test_pressure_lock_guidance_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "pressure_wreck_signal"
	target.display_name = "Pressure-Locked Research Wreck"
	target.description = "Pressure lock."

	var locked_guidance := main._format_first_scan_guidance(target)
	_expect(locked_guidance.contains("Locked"), "pressure lock guidance should first say the route is blocked")
	_expect(locked_guidance.contains("buy Pressure Seal I"), "pressure lock guidance should name the surface upgrade step")
	_expect(locked_guidance.contains("then return"), "pressure lock guidance should explain the return loop")

	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	var open_guidance := main._format_first_scan_guidance(target)
	_expect(open_guidance.contains("if oxygen allows"), "open pressure route guidance should invite entry only if oxygen allows")
	_expect(open_guidance.contains("scan cache"), "open pressure route guidance should name the cache payoff")
	target.free()
	main.free()

func _test_surface_summary_tabs() -> void:
	var main := MainScript.new()

	var ready_summary := main._format_ready_panel_summary()
	_expect(ready_summary.contains("E/Enter begins."), "ready panel should keep the start action visible")
	_expect(ready_summary.contains("Base needs: Food"), "ready panel should explain survival needs with readable names")
	_expect(ready_summary.contains("Tonight: Food -1, Water -1, Power -1."), "ready panel should explain nightly survival pressure")
	_expect(ready_summary.contains("base needs are stable"), "ready panel should explain why the shallow cache matters")
	_expect(ready_summary.contains("Day priority:"), "ready panel should name one main day priority")
	_expect(ready_summary.contains("Shell Reef pockets"), "ready panel priority should point to the current starter-resource target")
	_expect(not ready_summary.contains("Goal:"), "ready panel should not show a second generic goal line")
	_expect(not ready_summary.contains("Survival F"), "ready panel should not use cryptic survival abbreviations")
	_expect(not ready_summary.contains("F9"), "ready panel should hide prototype reset copy when debug telemetry is off")
	main.carried_tomorrow_intention = "bank Power supply soon to protect tomorrow's oxygen."
	var carried_ready_summary := main._format_ready_panel_summary()
	_expect(carried_ready_summary.contains("Day priority: bank Power supply soon"), "ready panel should carry the confirmed night intention into the next day")
	main.carried_tomorrow_intention = ""
	main.show_debug_telemetry = true
	_expect(main._format_ready_panel_summary().contains("F9 resets prototype save"), "ready panel may expose reset copy when debug telemetry is on")
	main.show_debug_telemetry = false

	_expect(not main._surface_tabs_enabled(), "surface tabs should be hidden before extraction")
	main.dive_session.extract()
	_expect(main._surface_tabs_enabled(), "surface tabs should be available after extraction")
	_expect(main._format_surface_tabs() == "[Result]  Upgrades  Log  Night", "surface tabs should mark the result view by default")
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	_expect(main._format_surface_tabs() == "Result  [Upgrades]  Log  Night", "surface tabs should mark the upgrade view")
	_expect(main._format_upgrade_menu_title(1, 7) == "Upgrade Bay (1/7) - Up/Down select", "upgrade bay title should keep selection controls visible")
	main.surface_tab_index = main.SURFACE_TAB_LOG
	_expect(main._format_surface_tabs() == "Result  Upgrades  [Log]  Night", "surface tabs should mark the log view")
	main.surface_tab_index = main.SURFACE_TAB_NIGHT
	_expect(main._format_surface_tabs() == "Result  Upgrades  Log  [Night]", "surface tabs should mark the night view")
	main.free()

func _test_keyboard_action_prompt_labels() -> void:
	var main := MainScript.new()
	_expect(main._action_label("interact") == "E/Enter", "interact prompt label should match the current keyboard binding")
	_expect(main._action_label("restart_dive") == "R", "restart prompt label should match the current keyboard binding")
	_expect(main._action_label("move_left_right") == "Left/Right", "tab cycling prompt label should match the current keyboard binding")
	_expect(main._action_label("move_up_down") == "Up/Down", "selection prompt label should match the current keyboard binding")
	_expect(main._action_label("scan") == "F", "scan prompt label should match the current keyboard binding")
	_expect(main._action_label("expedition_slate") == "Tab", "expedition slate prompt label should match the current keyboard binding")
	_expect(main._action_label("burst_thruster") == "Space", "burst prompt label should match the current keyboard binding")
	_expect(main._action_label("decoy_pulse") == "F", "decoy prompt label should match the current keyboard binding")
	_expect(main._action_label("future_action") == "future_action", "unknown prompt labels should fall back to their action id")
	_expect(InputMap.has_action("expedition_slate"), "expedition slate should have a semantic InputMap action")
	var slate_events := InputMap.action_get_events("expedition_slate")
	_expect(not slate_events.is_empty(), "expedition slate InputMap action should be bound")
	var slate_key := slate_events[0] as InputEventKey
	_expect(slate_key != null and slate_key.keycode == KEY_TAB, "expedition slate should be bound to Tab")
	main.free()

func _test_prompt_formatter_guard_coverage() -> void:
	var main := MainScript.new()
	var interact_label: String = main._action_label("interact")
	var interact_words := interact_label.replace("/", " or ")
	var restart_label: String = main._action_label("restart_dive")
	var horizontal_label: String = main._action_label("move_left_right")
	var vertical_label: String = main._action_label("move_up_down")
	var slate_label: String = main._action_label("expedition_slate")
	var burst_label: String = main._action_label("burst_thruster")
	var decoy_label: String = main._action_label("decoy_pulse")

	_expect(main._format_ready_panel_summary().contains("%s begins." % interact_label), "ready summary should derive its start label from the prompt helper")
	_expect(main._format_upgrade_menu_title(2, 7).contains("%s select" % vertical_label), "upgrade title should derive selection labels from the prompt helper")
	_expect(main._format_next_expedition_prompt().contains("press %s" % restart_label), "next expedition prompt should derive restart labels from the prompt helper")
	_expect(main._format_burst_thruster_prompt().begins_with("%s burst" % burst_label), "burst prompt should derive its label from the prompt helper")
	_expect(main._format_expedition_slate_text().contains("%s closes" % slate_label), "expedition slate should derive its close label from the prompt helper")
	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	_expect(main._format_decoy_pulse_prompt() == "%s: decoy ready" % decoy_label, "decoy prompt should derive its ready label from the prompt helper")
	main.dive_session.reset(main.max_oxygen)
	_expect(main._format_hud_prompt() == "Press %s to begin the dive" % interact_words, "ready HUD prompt should derive interact wording from the prompt helper")

	main.dive_session.extract()
	main.surface_tab_index = main.SURFACE_TAB_RESULT
	var result_prompt := main._format_hud_prompt()
	_expect(result_prompt.contains("press %s for upgrades" % interact_label), "result HUD prompt should derive upgrade-open labels from the prompt helper")
	_expect(result_prompt.contains("%s next expedition" % restart_label), "result HUD prompt should derive restart labels from the prompt helper")
	_expect(result_prompt.contains("%s surface view" % horizontal_label), "result HUD prompt should derive surface-tab labels from the prompt helper")

	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	var upgrade_prompt := main._format_hud_prompt()
	_expect(upgrade_prompt.contains("%s select" % vertical_label), "upgrade HUD prompt should derive selection labels from the prompt helper")
	_expect(upgrade_prompt.contains("%s purchase" % interact_label), "upgrade HUD prompt should derive purchase labels from the prompt helper")

	main.dive_session.fail()
	_expect(main._format_hud_prompt().contains("press %s for next expedition" % restart_label), "failure HUD prompt should derive restart labels from the prompt helper")
	main.free()

func _test_condition_presenter() -> void:
	_expect(ConditionPresenterScript.format_cluster_pattern("cautious") == "Cautious shallows", "condition presenter should name cautious resource routes")
	_expect(ConditionPresenterScript.format_cluster_pattern("deep_reward") == "Deep reward route", "condition presenter should name deep reward resource routes")
	_expect(ConditionPresenterScript.format_cluster_pattern("custom") == "custom", "condition presenter should preserve unknown cluster pattern ids")
	_expect(ConditionPresenterScript.format_condition_telemetry({}) == "none", "condition telemetry should report no active condition compactly")
	var condition := {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
	}
	_expect(ConditionPresenterScript.format_condition_telemetry(condition) == "Thermal Bloom (thermal_bloom)", "condition telemetry should preserve display name and id")
	_expect(ConditionPresenterScript.format_condition_briefing({}, false) == "Today: no unusual activity.", "empty condition briefing should preserve neutral copy")
	var fallback := ConditionPresenterScript.format_condition_briefing({
		"id": "new_current",
		"display_name": "New Current",
		"briefing": "A test briefing remains visible.",
	}, false)
	_expect(fallback.contains("Today: New Current."), "unknown condition briefing should still frame the display name")
	_expect(fallback.contains("A test briefing remains visible."), "unknown condition briefing should preserve authored briefing copy")
	_expect(ConditionPresenterScript.format_condition_briefing(condition, false).contains("Vent-warmed routes"), "condition presenter should own condition-specific briefing copy")

func _test_condition_briefing_copy() -> void:
	var main := MainScript.new()
	var condition := {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
		"tags": ["thermal", "scan"],
	}

	var briefing := ConditionPresenterScript.format_condition_briefing(condition, false)
	_expect(briefing.contains("Today: Thermal Bloom."), "condition briefing should frame the day condition as today's ocean change")
	_expect(briefing.contains("Vent-warmed routes may point toward extra glow."), "thermal briefing should name the implemented vent/glow route cue")
	_expect(not briefing.contains("thermal_bloom"), "condition briefing should not expose raw condition ids")
	_expect(not briefing.to_lower().contains("procedural"), "condition briefing should not imply unimplemented generation systems")

	condition = {
		"id": "kelp_bloom",
		"display_name": "Kelp Bloom",
		"briefing": "Shallow growth is unusually thick.",
		"tags": ["resource", "shallow"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	_expect(briefing.contains("Mirror Kelp"), "kelp briefing should point at the implemented Mirror Kelp route variation")
	_expect(briefing.contains("shimmer breaks"), "kelp briefing should tell players how to read the denser route")
	_expect(not briefing.contains("kelp_bloom"), "kelp briefing should not expose raw condition ids")

	condition = {
		"id": "predator_migration",
		"display_name": "Predator Migration",
		"briefing": "Deep patrols are shifting.",
		"tags": ["predator", "route"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	_expect(briefing.contains("Gulper route"), "predator briefing should point to the existing predator route")
	_expect(briefing.contains("warning cues"), "predator briefing should point to existing readable cues")

	condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	_expect(briefing.to_lower().contains("lower-trench"), "low-visibility briefing should nudge broad lower-trench route caution")
	_expect(briefing.contains("bank early"), "low-visibility briefing should keep the player-visible advice compact")
	_expect(not briefing.contains("Dusk Trench"), "low-visibility briefing should not reveal the exact trench location")
	_expect(not briefing.contains("Blackwater"), "low-visibility briefing should not reveal the gated route chain")
	_expect_no_echo_lens_locator_language(briefing, "low-visibility briefing")

	condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["scan", "rare"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	_expect(briefing.contains("East Shelf"), "rare signal briefing should point at the implemented side-route opportunity")
	_expect(briefing.contains("Blue Chimney"), "rare signal briefing should point at the lower-pocket opportunity")
	_expect(not briefing.contains("Blackwater"), "rare signal briefing should not point at Blackwater before Resonance Key I ownership")
	_expect(briefing.contains("if oxygen allows"), "rare signal briefing should keep route pings optional")
	_expect_no_echo_lens_locator_language(briefing, "rare signal briefing")
	_expect(main.call("_rare_signal_emphasis_visible_for_condition", "rare_signal"), "Rare Signal should enable the subtle signal emphasis")
	_expect(not main.call("_rare_signal_emphasis_visible_for_condition", "wreck_shift"), "Wreck Shift should not enable Rare Signal emphasis")
	_expect(not main.call("_rare_signal_emphasis_visible_for_condition", "thermal_bloom"), "Thermal Bloom should keep Rare Signal emphasis hidden")
	_expect(main.call("_shelf_glimmer_visible_for_condition", "rare_signal"), "Rare Signal should enable the Shelf Glimmer side-route opportunity")
	_expect(not main.call("_shelf_glimmer_visible_for_condition", "calm_current"), "Calm Current should not enable the Shelf Glimmer opportunity")
	_expect(main.call("_blue_chimney_signal_visible_for_condition", "rare_signal"), "Rare Signal should enable the Blue Chimney lower-pocket opportunity")
	_expect(not main.call("_blue_chimney_signal_visible_for_condition", "calm_current"), "Calm Current should not enable the Blue Chimney signal")
	_expect(not main.call("_blackwater_signal_visible_for_condition", "rare_signal"), "Rare Signal should not enable Blackwater signal before the scoped key path is ready")
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	briefing = ConditionPresenterScript.format_condition_briefing(condition, main.progression_state.has_upgrade(ResonanceKeyUpgrade.id))
	_expect(briefing.contains("Blackwater"), "rare signal briefing should nudge Blackwater once Resonance Key I is owned")
	_expect(briefing.contains("if oxygen allows"), "Blackwater rare signal briefing should remain optional")
	_expect_no_echo_lens_locator_language(briefing, "Blackwater rare signal briefing")
	_expect(main.call("_blackwater_signal_visible_for_condition", "rare_signal"), "Rare Signal should enable Blackwater signal when the route gate is ready")
	_expect(not main.call("_blackwater_signal_visible_for_condition", "calm_current"), "Calm Current should not enable Blackwater signal")
	var blackwater_scene := MainScene.instantiate()
	blackwater_scene.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	blackwater_scene.progression_state.banked_resources["glow_plankton"] = 2
	blackwater_scene.dive_session.reset(30.0)
	blackwater_scene.dive_session.start()
	blackwater_scene.dive_session.oxygen = 23.0
	blackwater_scene.dive_session.current_cargo = ["kelp_fiber"]
	blackwater_scene.dive_session.has_left_base = true
	blackwater_scene.player_in_base = false
	blackwater_scene.run_predator_contacts = 1
	blackwater_scene.call("_sync_blackwater_crack_gate_state")
	var blackwater_signal := blackwater_scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity") as Node2D
	blackwater_scene.call("_sync_blackwater_signal_opportunity", "rare_signal")
	_expect(blackwater_signal.visible, "Rare Signal should show a subtle Blackwater signal nudge when the route is ready")
	_expect(is_equal_approx(blackwater_scene.dive_session.oxygen, 23.0), "Blackwater condition nudge should not drain oxygen")
	_expect(blackwater_scene.dive_session.current_cargo == ["kelp_fiber"], "Blackwater condition nudge should not change carried cargo")
	_expect(blackwater_scene.dive_session.result == DiveSessionScript.Result.DIVING, "Blackwater condition nudge should not change dive state")
	_expect(blackwater_scene.dive_session.has_left_base, "Blackwater condition nudge should not reset extraction eligibility")
	_expect(not blackwater_scene.player_in_base, "Blackwater condition nudge should not move the player into base")
	_expect(blackwater_scene.run_predator_contacts == 1, "Blackwater condition nudge should not create predator contacts")
	_expect(blackwater_scene.progression_state.resource_count("glow_plankton") == 2, "Blackwater condition nudge should not mutate banked resources")
	_expect(blackwater_scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Blackwater condition nudge should not mutate key ownership")
	blackwater_scene.call("_sync_blackwater_signal_opportunity", "calm_current")
	_expect(not blackwater_signal.visible, "non-Rare-Signal conditions should hide the Blackwater signal nudge")
	blackwater_scene.free()
	var scene := MainScene.instantiate()
	var safe_bank_lane := scene.get_node("RouteChoiceBand/SafeBankLane") as Polygon2D
	var research_lane := scene.get_node("RouteChoiceBand/ResearchLane") as Polygon2D
	var decision_rib := scene.get_node("RouteChoiceBand/DecisionRib") as Polygon2D
	scene.call("_sync_route_choice_condition_nudge", "rare_signal")
	_expect(research_lane.color.a > 0.24, "Rare Signal should visibly nudge the research route lane")
	_expect(safe_bank_lane.color.a >= 0.14, "Rare Signal should keep the safe bank route visible")
	_expect(decision_rib.color.a <= 0.26, "Rare Signal route-choice rib should stay a soft suggestion")
	scene.call("_sync_route_choice_condition_nudge", "calm_current")
	_expect(research_lane.color.a <= 0.21, "non-Rare-Signal conditions should restore the neutral route choice lane")
	_expect(safe_bank_lane.color.a >= 0.17, "neutral route-choice visuals should preserve the safe bank lane")
	scene.free()
	main.free()

func _test_dusk_trench_low_visibility_condition_nudge() -> void:
	var scene := MainScene.instantiate()
	root.add_child(scene)
	var veil := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D
	var band := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand") as Polygon2D
	var rib_a := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA") as Polygon2D
	var return_current := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/ReturnCurrentUpLeft") as Polygon2D
	scene.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	scene.call("_sync_dusk_trench_condition_nudge", "calm_current")
	var neutral_veil_alpha := veil.color.a
	var neutral_band_alpha := band.color.a
	var neutral_rib_alpha := rib_a.color.a

	scene.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(4)
	scene.call("_sync_dusk_trench_condition_nudge", "low_visibility")
	_expect(scene._current_condition_id() == "low_visibility", "test seed should select Low Visibility")
	_expect(veil.color.a > neutral_veil_alpha, "Low Visibility should visibly strengthen Dusk Trench murk")
	_expect(band.color.a > neutral_band_alpha, "Low Visibility should strengthen the Dusk Trench silt band")
	_expect(rib_a.color.a > neutral_rib_alpha, "Low Visibility should strengthen Dusk Trench timing ribs")
	_expect(veil.color.b > veil.color.g, "Low Visibility Dusk nudge should keep blue-violet pressure language")
	_expect(return_current.color.g > veil.color.g, "Low Visibility Dusk nudge should preserve green return-current readability")
	var ready_status: String = scene.call("_format_expedition_ready_status")
	_expect(ready_status.contains("lower-trench"), "ready status should acknowledge the low-visibility trench nudge")
	_expect(not ready_status.contains("Dusk Trench"), "ready status should not reveal exact Dusk location")
	var saved: Dictionary = scene.progression_state.to_save_data()
	_expect(not saved.has("current_expedition_condition"), "Low Visibility should not save active condition state")
	_expect(not saved.has("low_visibility"), "Low Visibility should not add durable save state")
	_expect(not saved.has("dusk_trench_condition"), "Dusk condition nudge should not add durable route state")
	scene.queue_free()

func _test_wide_chamber_calm_current_condition_nudge() -> void:
	var scene := MainScene.instantiate()
	root.add_child(scene)
	var return_main := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var return_far := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib") as Polygon2D
	var return_mid := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain") as Polygon2D
	var return_entry := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain") as Polygon2D
	scene.dive_session.reset(30.0)
	scene.dive_session.start()
	scene.dive_session.oxygen = 19.0
	scene.dive_session.current_cargo = ["shell_fragments"]
	scene.dive_session.has_left_base = true
	scene.player_in_base = false
	scene.run_predator_contacts = 1
	scene.progression_state.banked_resources["glow_plankton"] = 2
	scene.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true

	scene.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	scene.call("_sync_wide_chamber_condition_nudge", "calm_current")
	var calm_main_alpha := return_main.color.a
	var calm_far_alpha := return_far.color.a
	var calm_mid_alpha := return_mid.color.a
	var calm_entry_alpha := return_entry.color.a
	_expect(calm_main_alpha >= 0.16 and calm_main_alpha <= 0.18, "Calm Current should subtly strengthen the Wide Reef Chamber main return current")
	_expect(calm_far_alpha >= 0.16 and calm_far_alpha <= 0.18, "Calm Current should strengthen the far chamber return rib without becoming objective-bright")
	_expect(calm_mid_alpha >= 0.13 and calm_mid_alpha <= 0.15, "Calm Current should strengthen the mid chamber return chain without adding clutter")
	_expect(calm_entry_alpha >= 0.15 and calm_entry_alpha <= 0.17, "Calm Current should strengthen the entry return chain without adding clutter")
	_expect(return_main.color.g > return_main.color.r and return_mid.color.g > return_mid.color.r, "Wide chamber condition nudge should preserve safe-current color language")

	scene.call("_sync_wide_chamber_condition_nudge", "rare_signal")
	_expect(return_main.color.a < calm_main_alpha, "non-Calm-Current conditions should restore neutral Wide Reef Chamber main return current")
	_expect(return_far.color.a < calm_far_alpha, "non-Calm-Current conditions should restore neutral far return rib")
	_expect(return_mid.color.a < calm_mid_alpha, "non-Calm-Current conditions should restore neutral mid return chain")
	_expect(return_entry.color.a < calm_entry_alpha, "non-Calm-Current conditions should restore neutral entry return chain")
	_expect(is_equal_approx(scene.dive_session.oxygen, 19.0), "Wide chamber condition nudge should not drain oxygen")
	_expect(scene.dive_session.current_cargo == ["shell_fragments"], "Wide chamber condition nudge should not change carried cargo")
	_expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "Wide chamber condition nudge should not change dive state")
	_expect(scene.dive_session.has_left_base, "Wide chamber condition nudge should not reset extraction eligibility")
	_expect(not scene.player_in_base, "Wide chamber condition nudge should not move the player into base")
	_expect(scene.run_predator_contacts == 1, "Wide chamber condition nudge should not create predator contacts")
	_expect(scene.progression_state.resource_count("glow_plankton") == 2, "Wide chamber condition nudge should not mutate banked resources")
	_expect(scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Wide chamber condition nudge should not mutate upgrade ownership")
	var saved: Dictionary = scene.progression_state.to_save_data()
	_expect(not saved.has("wide_chamber_condition"), "Wide chamber condition nudge should not add durable save state")
	_expect(not saved.has("calm_current"), "Calm Current chamber variation should not save active condition state")
	scene.queue_free()

func _test_mirror_kelp_kelp_bloom_condition_nudge() -> void:
	var scene := MainScene.instantiate()
	root.add_child(scene)
	var bloom_wash := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachWash") as Polygon2D
	var bloom_rib := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachRib") as Polygon2D
	var backwater := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater") as Polygon2D
	var curtain_a := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA") as Polygon2D
	var tideglass_zone := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone") as Area2D
	var mirrorfin := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorfinDrift") as Area2D

	scene.dive_session.reset(40.0)
	scene.dive_session.start()
	scene.dive_session.oxygen = 22.0
	scene.dive_session.current_cargo.append("shell_fragments")
	scene.dive_session.has_left_base = true
	scene.progression_state.banked_resources["kelp_fiber"] = 3
	scene.progression_state.purchased_upgrades[OxygenTankUpgrade.id] = true
	scene.current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	scene.call("_sync_mirror_kelp_condition_nudge", "rare_signal")
	var neutral_backwater_alpha := backwater.color.a
	var neutral_curtain_alpha := curtain_a.color.a
	_expect(not bloom_wash.visible, "non-Kelp-Bloom expeditions should hide the Mirror Kelp bloom approach wash")
	_expect(not bloom_rib.visible, "non-Kelp-Bloom expeditions should hide the Mirror Kelp bloom approach rib")

	scene.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(1)
	scene.call("_sync_mirror_kelp_condition_nudge", "kelp_bloom")
	_expect(scene._current_condition_id() == "kelp_bloom", "test seed should select Kelp Bloom deterministically")
	_expect(bloom_wash.visible, "Kelp Bloom should show the Mirror Kelp approach wash")
	_expect(bloom_rib.visible, "Kelp Bloom should show a readable Mirror Kelp approach rib")
	_expect(backwater.color.a > neutral_backwater_alpha, "Kelp Bloom should subtly thicken the Mirror Kelp backwater")
	_expect(curtain_a.color.a > neutral_curtain_alpha, "Kelp Bloom should subtly strengthen Mirror Kelp curtains")
	_expect(backwater.color.a <= 0.2 and curtain_a.color.a <= 0.25, "Kelp Bloom should stay readable without overpowering payoffs")
	_expect(bloom_wash.color.g > bloom_wash.color.r, "Mirror Kelp bloom nudge should keep kelp/current color language")
	var briefing := ConditionPresenterScript.format_condition_briefing(scene.current_expedition_condition, scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id))
	_expect(briefing.contains("Mirror Kelp"), "Kelp Bloom briefing should name the broad route feel")
	_expect(briefing.contains("shimmer"), "Kelp Bloom briefing should tell players how to read the variation")
	_expect(scene.call("_format_expedition_ready_status").contains("Mirror Kelp"), "ready status should acknowledge the Mirror Kelp approach variation")
	_expect(is_equal_approx(scene.dive_session.oxygen, 22.0), "Mirror Kelp condition nudge should not drain oxygen")
	_expect(scene.dive_session.current_cargo == ["shell_fragments"], "Mirror Kelp condition nudge should not change carried cargo")
	_expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "Mirror Kelp condition nudge should not change dive state")
	_expect(scene.dive_session.has_left_base, "Mirror Kelp condition nudge should not reset extraction eligibility")
	_expect(scene.progression_state.resource_count("kelp_fiber") == 3, "Mirror Kelp condition nudge should not mutate banked resources")
	_expect(scene.progression_state.has_upgrade(OxygenTankUpgrade.id), "Mirror Kelp condition nudge should not mutate upgrades")
	_expect(tideglass_zone.collision_mask == 1, "Mirror Kelp condition nudge should not change Tideglass interaction access")
	_expect(mirrorfin.collision_layer == 0 and mirrorfin.collision_mask == 0, "Mirror Kelp condition nudge should keep Mirrorfin non-combat")
	var saved: Dictionary = scene.progression_state.to_save_data()
	_expect(not saved.has("mirror_kelp_condition"), "Mirror Kelp condition nudge should not add durable route state")
	_expect(not saved.has("kelp_bloom"), "Kelp Bloom should not save active condition state")
	scene.queue_free()

func _test_daylight_timer_hud() -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 420.0
	main.daylight_elapsed_seconds = 0.0
	_expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "DAYLIGHT 07:00", "fresh daylight timer should show the full day budget")

	main.call("_set_daylight_progress_for_debug", 0.5)
	_expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "DAYLIGHT 03:30", "daylight debug progress should deterministically set remaining time")
	_expect(is_equal_approx(main.call("_daylight_remaining_ratio"), 0.5), "daylight remaining ratio should track the strategic day budget")

	main.call("_set_daylight_progress_for_debug", 1.0)
	_expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "NIGHTFALL", "depleted daylight should show nightfall instead of oxygen-style copy")
	main.free()

	var scene := MainScene.instantiate()
	root.add_child(scene)
	var cargo_panel: Panel = scene.get_node("HUD/CargoPanel")
	var daylight_panel: Panel = scene.get_node("HUD/DaylightPanel")
	var survival_panel: Panel = scene.get_node("HUD/SurvivalNeedsPanel")
	var daylight_label: Label = scene.get_node("HUD/DaylightLabel")
	var daylight_bar_back: ColorRect = scene.get_node("HUD/DaylightBarBack")
	var daylight_bar_fill: ColorRect = scene.get_node("HUD/DaylightBarFill")
	var oxygen_bar_back: ColorRect = scene.get_node("HUD/OxygenBarBack")

	_expect(not daylight_panel.visible, "raw scene should start with the daylight timer hidden")
	scene.dive_session.start()
	scene.player_in_base = false
	scene.call("_ensure_active_hud_references")
	scene.call("_apply_active_hud_layout")
	scene.call("_set_daylight_progress_for_debug", 0.25)
	scene.call("_update_daylight_timer_hud", true)
	_expect(daylight_panel.visible, "active diving should show the daylight timer")
	_expect(daylight_label.visible, "active diving should show daylight timer copy")
	_expect(daylight_label.text == "DAYLIGHT 05:15", "active daylight timer should show remaining day time")
	_expect(_control_rect(daylight_panel).size == Vector2(216.0, 48.0), "daylight timer should stay compact enough for top HUD space")
	_expect(daylight_panel.offset_left > cargo_panel.offset_right, "daylight timer should sit apart from the cargo strip")
	_expect(survival_panel.offset_left > daylight_panel.offset_right, "survival needs should sit apart from the daylight timer")
	_expect(not _controls_overlap(daylight_panel, cargo_panel), "daylight timer should not overlap cargo")
	_expect(not _controls_overlap(daylight_panel, survival_panel), "daylight timer should not overlap base needs")
	_expect(daylight_bar_back.color != oxygen_bar_back.color, "daylight bar should be visually distinct from oxygen")
	var morning_width := daylight_bar_fill.offset_right - daylight_bar_fill.offset_left

	scene.call("_set_daylight_progress_for_debug", 0.75)
	scene.call("_update_daylight_timer_hud", true)
	var evening_width := daylight_bar_fill.offset_right - daylight_bar_fill.offset_left
	_expect(evening_width < morning_width, "daylight fill should shrink as night approaches")
	_expect(daylight_label.text == "DAYLIGHT 01:45", "evening daylight staging should show less remaining time")

	scene.call("_advance_daylight_timer", scene.daylight_duration_seconds)
	_expect(scene.daylight_nightfall_announced, "daylight expiration should announce nightfall")
	_expect(scene.daylight_nightfall_away_from_ship, "timer expiration away from ship should mark the late-return consequence")
	_expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "timer expiration should keep the dive active until the player returns to ship")
	_expect(scene.status_label.text.contains("emergency return"), "timer expiration should tell the player to return immediately")
	scene.queue_free()

func _test_late_day_cargo_banking_warning() -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 100.0
	main.daylight_elapsed_seconds = 76.0
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.dive_session.current_cargo.append("driftwood")

	_expect(bool(main.call("_should_warn_late_day_cargo_banking")), "low daylight with cargo away from ship should warn before nightfall")
	var warning_prompt: String = main.call("_format_hud_prompt")
	var warning_objective: String = main.call("_format_active_objective_line")
	_expect(warning_prompt.contains("Bank at ship") and warning_prompt.contains("Power risk"), "late-day cargo prompt should name ship banking and Power risk")
	_expect(warning_objective.contains("Dusk") and warning_objective.contains("bank cargo"), "late-day cargo objective should stay compact and actionable")

	main.dive_session.current_cargo.clear()
	_expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "empty cargo should not show the late-day banking warning")
	main.dive_session.current_cargo.append("driftwood")
	main.player_in_base = true
	_expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "cargo already at ship should not show the late-day banking warning")
	main.player_in_base = false
	main.daylight_elapsed_seconds = 50.0
	_expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "early daylight should not show the late-day banking warning")
	main.daylight_elapsed_seconds = 100.0
	main.daylight_nightfall_announced = true
	main.daylight_nightfall_away_from_ship = true
	_expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "nightfall should use the existing overstay prompt instead of the pre-night warning")
	var nightfall_prompt: String = main.call("_format_hud_prompt")
	_expect(nightfall_prompt.contains("cargo at risk") and nightfall_prompt.contains("late Power -1"), "nightfall away-from-ship behavior should remain unchanged")
	main.free()

func _test_expedition_slate_context() -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 420.0
	main.daylight_elapsed_seconds = 210.0
	main.dive_session.reset(30.0, 100.0)
	main.dive_session.start()
	main.dive_session.oxygen = 12.0
	main.dive_session.health = 64.0
	main.dive_session.current_depth = 77.0
	main.dive_session.cargo_limit = 3
	main.dive_session.current_cargo = ["food_supply", "driftwood"]
	main.carried_tomorrow_intention = "bank Power supply soon to protect tomorrow's oxygen."

	var slate: String = main.call("_format_expedition_slate_text")
	_expect(slate.contains("DAYLIGHT 03:30") and slate.contains("50% daylight left"), "slate should show remaining daylight context")
	_expect(slate.contains("O2 12/30") and slate.contains("health 64/100"), "slate should show active pressure meters")
	_expect(slate.contains("Cargo: 2 / 3 carried") and slate.contains("Food") and slate.contains("Wood"), "slate should show carried cargo and capacity")
	_expect(slate.contains("Base needs: Food") and slate.contains("Tonight: Food -1, Water -1, Power -1."), "slate should show night needs before the player returns")
	_expect(slate.contains("Known build:"), "slate should expose known build or upgrade context")
	_expect(slate.contains("Day plan: bank Power supply soon"), "slate should carry the broad next-day intention without adding checklist progress")
	_expect(slate.contains("Route goal:"), "slate should preserve the current expedition goal")
	_expect(slate.contains("surface for O2") and slate.contains("ship banks cargo"), "slate should help decide whether to keep diving or bank cargo")
	_expect(slate.contains("Tab closes") and slate.contains("pressure is paused"), "slate should explain its active-dive pause rule")
	main.free()

func _test_expedition_slate_pressure_pause() -> void:
	var scene := MainScene.instantiate()
	root.add_child(scene)
	scene.dive_session.start()
	scene.dive_session.oxygen = 20.0
	scene.dive_session.health = 100.0
	scene.dive_session.current_cargo = ["shell_fragments"]
	scene.daylight_duration_seconds = 420.0
	scene.daylight_elapsed_seconds = 100.0
	scene.player_in_base = false
	scene.player_in_surface_oxygen_refill = false
	scene.call("_update_hud")

	scene.call("_toggle_expedition_slate")
	var slate_panel: Panel = scene.get_node("HUD/ExpeditionSlatePanel")
	var slate_body: Label = scene.get_node("HUD/ExpeditionSlatePanel/Body")
	_expect(scene.expedition_slate_open, "Tab slate toggle should open during active diving")
	_expect(slate_panel.visible, "open slate should show its HUD panel")
	_expect(_control_rect(slate_panel).size == Vector2(580.0, 386.0), "slate panel should stay bounded and not become a full-screen overlay")
	_expect(slate_body.text.contains("pressure is paused"), "slate body should state the pause rule")
	_expect(not scene.player.is_physics_processing(), "open slate should freeze player movement along with active pressure")

	var oxygen_before: float = scene.dive_session.oxygen
	var daylight_before: float = scene.daylight_elapsed_seconds
	scene.call("_process", 10.0)
	_expect(is_equal_approx(scene.dive_session.oxygen, oxygen_before), "open slate should pause oxygen drain")
	_expect(is_equal_approx(scene.daylight_elapsed_seconds, daylight_before), "open slate should pause daylight pressure")

	scene.call("_toggle_expedition_slate")
	_expect(not scene.expedition_slate_open, "second slate toggle should close it")
	_expect(not slate_panel.visible, "closed slate should leave the active HUD sparse")
	_expect(scene.player.is_physics_processing(), "closing slate should restore player movement processing")
	scene.queue_free()

func _test_hud_presenter() -> void:
	_expect(HudPresenterScript.format_oxygen_label(40.0, 40.0) == "OXYGEN: 40 / 40", "full oxygen label should keep exact active HUD copy")
	_expect(HudPresenterScript.format_oxygen_label(11.0, 40.0) == "OXYGEN: 11 / 40", "normal partial oxygen label should not add a warning suffix")
	_expect(HudPresenterScript.format_oxygen_label(10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	_expect(HudPresenterScript.format_oxygen_label(4.0, 40.0).contains("CRITICAL"), "oxygen label should carry critical state inline")
	_expect(HudPresenterScript.format_oxygen_label(0.0, 40.0).contains("CRITICAL"), "empty oxygen should stay critical")
	_expect(HudPresenterScript.format_oxygen_label(10.0, 0.0) == "OXYGEN: 10 / 0", "max-zero oxygen label should keep safe normal-state copy")

	_expect(HudPresenterScript.oxygen_state(40.0, 40.0) == "normal", "full oxygen state should be normal")
	_expect(HudPresenterScript.oxygen_state(11.0, 40.0) == "normal", "oxygen above low threshold should be normal")
	_expect(HudPresenterScript.oxygen_state(10.0, 40.0) == "low", "oxygen at low threshold should be low")
	_expect(HudPresenterScript.oxygen_state(4.0, 40.0) == "critical", "oxygen at critical threshold should be critical")
	_expect(HudPresenterScript.oxygen_state(10.0, 0.0) == "normal", "max-zero oxygen state should stay safe")

	_expect(HudPresenterScript.oxygen_warning_text("normal") == "", "normal oxygen should not show a warning")
	_expect(HudPresenterScript.oxygen_warning_text("low") == "O2 LOW\nPLAN RETURN", "low oxygen warning copy should stay exact")
	_expect(HudPresenterScript.oxygen_warning_text("critical") == "O2 CRITICAL\nRETURN TO BASE", "critical oxygen warning copy should stay exact")
	_expect(HudPresenterScript.oxygen_warning_text("empty") == "", "unknown oxygen states should not show warning copy")

	_expect(HudPresenterScript.oxygen_state_color("normal") == Color.WHITE, "normal oxygen color should stay white")
	_expect(HudPresenterScript.oxygen_state_color("low") == Color(1.0, 0.76, 0.22, 1.0), "low oxygen color should stay exact")
	_expect(HudPresenterScript.oxygen_state_color("critical") == Color(1.0, 0.18, 0.12, 1.0), "critical oxygen color should stay exact")

	_expect(HudPresenterScript.format_health_label(100.0, 100.0) == "HEALTH: 100 / 100", "full health label should keep exact active HUD copy")
	_expect(HudPresenterScript.format_health_label(30.0, 100.0).contains("LOW"), "health label should carry low state inline")
	_expect(HudPresenterScript.format_health_label(12.0, 100.0).contains("CRITICAL"), "health label should carry critical state inline")
	_expect(HudPresenterScript.health_state(100.0, 100.0) == "normal", "full health state should be normal")
	_expect(HudPresenterScript.health_state(30.0, 100.0) == "low", "health below low threshold should be low")
	_expect(HudPresenterScript.health_state(18.0, 100.0) == "critical", "health at critical threshold should be critical")
	_expect(HudPresenterScript.health_state(10.0, 0.0) == "normal", "max-zero health state should stay safe")
	_expect(HudPresenterScript.health_state_color("normal") == HudPresenterScript.HEALTH_NORMAL_COLOR, "normal health color should stay exact")
	_expect(HudPresenterScript.health_state_color("low") == HudPresenterScript.HEALTH_LOW_COLOR, "low health color should stay exact")
	_expect(HudPresenterScript.health_state_color("critical") == HudPresenterScript.HEALTH_CRITICAL_COLOR, "critical health color should stay exact")

	_expect(HudPresenterScript.format_daylight_label(420.0) == "DAYLIGHT 07:00", "full daylight label should stay exact")
	_expect(HudPresenterScript.format_daylight_label(210.0) == "DAYLIGHT 03:30", "partial daylight label should stay exact")
	_expect(HudPresenterScript.format_daylight_label(0.0) == "NIGHTFALL", "depleted daylight label should show nightfall")
	_expect(HudPresenterScript.daylight_bar_color(0.26) == HudPresenterScript.DAYLIGHT_NORMAL_COLOR, "daylight safe color should stay exact above dusk threshold")
	_expect(HudPresenterScript.daylight_bar_color(0.25) == HudPresenterScript.DAYLIGHT_DUSK_COLOR, "daylight dusk color should start at threshold")

	var short_status := "Scanned Shell Reef."
	_expect(HudPresenterScript.compact_dive_status("  %s  " % short_status) == short_status, "compact status should trim short copy")
	_expect(HudPresenterScript.compact_dive_status("Line one\nLine two") == "Line one Line two", "compact status should flatten newlines")
	var long_status := "Scanned a very long target description that would otherwise overrun the active dive HUD status row and collide with nearby panels."
	var compact_status := HudPresenterScript.compact_dive_status(long_status)
	_expect(compact_status.length() <= 72, "compact status should keep active HUD copy within the row")
	_expect(compact_status.ends_with("..."), "compact status should mark truncated copy")

func _test_tool_belt_presenter() -> void:
	_expect(ToolBeltPresenterScript.tool_slot_color("ready") == Color(0.018, 0.075, 0.095, 0.5), "ready tool slot color should stay exact")
	_expect(ToolBeltPresenterScript.tool_slot_color("locked").a <= 0.36, "locked tool slots should sit quieter than ready tools")
	_expect(ToolBeltPresenterScript.tool_slot_color("active").a >= 0.65, "active tool slots should still read as selected")
	_expect(ToolBeltPresenterScript.tool_key_color("cooldown") == Color(1.0, 0.82, 0.38, 0.92), "cooldown key color should stay exact")
	_expect(ToolBeltPresenterScript.tool_key_color("spent") == ToolBeltPresenterScript.tool_key_color("locked"), "spent and locked key colors should stay visually quiet")
	_expect(ToolBeltPresenterScript.tool_icon_color("scanner", "ready") == Color(0.1, 0.92, 1.0, 0.98), "scanner icon color should stay exact")
	_expect(ToolBeltPresenterScript.tool_icon_color("decoy", "spent") == Color(0.45, 0.56, 0.62, 0.72), "spent tool icons should use disabled icon color")
	_expect(ToolBeltPresenterScript.tool_icon_polygon("scanner").size() > 0, "scanner tool should keep an icon polygon")
	_expect(ToolBeltPresenterScript.tool_icon_polygon("burst").size() > 0, "burst tool should keep an icon polygon")
	_expect(ToolBeltPresenterScript.tool_icon_polygon("cutter").size() > 0, "cutter tool should keep an icon polygon")
	_expect(ToolBeltPresenterScript.tool_icon_polygon("decoy").size() > 0, "decoy tool should keep an icon polygon")
	_expect(ToolBeltPresenterScript.tool_icon_polygon("unknown").is_empty(), "unknown tools should not render an icon polygon")

func _test_compact_dive_hud_helpers() -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["glow_plankton", "kelp_fiber", "glow_plankton"]
	var inline_cargo: String = main.call("_format_cargo_counts_inline", cargo)
	_expect(inline_cargo == " - Glow x2, Kelp x1", "active cargo helper should keep carried resources on one line")

	var slot_states: Array = CargoSlotPresenterScript.cargo_slot_states(cargo, 3, 4)
	_expect(slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "hidden"], "cargo slots should hide excess capacity before Cargo Rack I")
	var upgraded_slot_states: Array = CargoSlotPresenterScript.cargo_slot_states(cargo, 4, 4)
	_expect(upgraded_slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "empty"], "cargo slots should reveal the fourth slot after capacity upgrade")
	_expect(CargoSlotPresenterScript.cargo_slot_color("empty").a > CargoSlotPresenterScript.cargo_slot_color("hidden").a, "empty cargo slots should read brighter than unavailable slots")
	_expect(CargoSlotPresenterScript.cargo_slot_color("hidden").a == 0.0, "hidden cargo slot color should stay transparent")
	_expect(CargoSlotPresenterScript.cargo_slot_color("empty").a <= 0.52, "empty cargo slots should stay translucent glass, not opaque blocks")
	_expect(CargoSlotPresenterScript.cargo_slot_color("glow_plankton").a <= 0.8, "filled cargo slots should use readable glass cards instead of solid color blocks")
	_expect(CargoSlotPresenterScript.cargo_slot_color("glow_plankton") == Color(0.38, 0.52, 0.12, 0.76), "representative cargo slot color should stay exact")
	_expect(CargoSlotPresenterScript.cargo_slot_color("locked").a <= 0.3, "locked cargo slots should be quieter than usable slots")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("kelp_fiber").size() > 0, "kelp cargo slots should have a mini-icon polygon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("shell_fragments").size() > 0, "shell cargo slots should have a mini-icon polygon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("glow_plankton").size() > 0, "glow cargo slots should have a mini-icon polygon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("scrap_metal").size() > 0, "scrap cargo slots should have a mini-icon polygon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("driftwood").size() > 0, "driftwood cargo slots should have a mini-icon polygon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("quartz_glass").size() > 0, "quartz glass cargo slots should have a mini-icon polygon")
	_expect(ResourcePresenterScript.short_resource_name("scrap_metal", false, "") == "Scrap", "scrap metal should have a compact HUD name")
	_expect(ResourcePresenterScript.short_resource_name("driftwood", false, "") == "Wood", "driftwood should have a compact HUD name")
	_expect(ResourcePresenterScript.short_resource_name("quartz_glass", false, "") == "Glass", "quartz glass should have a compact HUD name")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("empty").is_empty(), "empty cargo slots should not show a resource mini-icon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("unknown").is_empty(), "unknown cargo slots should not show a resource mini-icon")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_color("hidden").a == 0.0, "hidden cargo slot icon color should stay transparent")
	_expect(CargoSlotPresenterScript.cargo_slot_icon_color("kelp_fiber") == Color(0.78, 1.0, 0.74, 0.95), "representative cargo icon color should stay exact")
	_expect(ToolBeltPresenterScript.tool_slot_color("ready").a <= 0.52, "ready tool slots should stay translucent like reference HUD glass")
	_expect(ToolBeltPresenterScript.tool_slot_color("locked").a <= 0.36, "locked tool slots should sit quieter than ready tools")
	_expect(ToolBeltPresenterScript.tool_slot_color("active").a >= 0.65, "active tool slots should still read as selected")

	var compact_discoveries: String = main.call("_format_discoveries", true)
	_expect(compact_discoveries == "Discoveries: 0", "compact discovery helper should show only the count")

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var cargo_panel: Panel = main_scene.get_node("HUD/CargoPanel")
	var cargo_title: Label = main_scene.get_node("HUD/CargoPanel/CargoTitle")
	var cargo_slots_root: Node2D = main_scene.get_node("HUD/CargoSlots")
	var survival_panel: Panel = main_scene.get_node("HUD/SurvivalNeedsPanel")
	var warning_panel: Panel = main_scene.get_node("HUD/OxygenWarningPanel")
	var scan_card_panel: Panel = main_scene.get_node("HUD/ScanCardPanel")
	var tool_belt_panel: Panel = main_scene.get_node("HUD/ToolBeltPanel")
	var minimap_panel: Panel = main_scene.get_node("HUD/MinimapPanel")
	var oxygen_bar_fill: ColorRect = main_scene.get_node("HUD/OxygenBarFill")
	var health_bar_fill: ColorRect = main_scene.get_node("HUD/HealthBarFill")
	var depth_bar_fill: ColorRect = main_scene.get_node("HUD/DepthBarFill")
	var oxygen_label: Label = main_scene.get_node("HUD/Oxygen")
	var health_label: Label = main_scene.get_node("HUD/Health")
	var depth_label: Label = main_scene.get_node("HUD/Depth")
	var depth_rail_line: ColorRect = main_scene.get_node("HUD/DepthRailLine")
	var depth_rail_marker: Polygon2D = main_scene.get_node("HUD/DepthRailMarker")
	var discoveries_label: Label = main_scene.get_node("HUD/Discoveries")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var objective_title: Label = main_scene.get_node("HUD/DiveInfoPanel/ObjectiveTitle")
	var objective_line: Label = main_scene.get_node("HUD/DiveInfoPanel/ObjectiveLine")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var scan_card_meta_label: Label = main_scene.get_node("HUD/ScanCardMeta")
	var scan_card_prompt_label: Label = main_scene.get_node("HUD/ScanCardPrompt")
	var scan_reticle_root: Node2D = main_scene.get_node("HUD/ScanReticleRoot")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var status_label: Label = main_scene.get_node("HUD/Status")
	var cargo_label: Label = main_scene.get_node("HUD/Cargo")
	var food_label: Label = main_scene.get_node("HUD/FoodNeed")
	var water_label: Label = main_scene.get_node("HUD/WaterNeed")
	var power_label: Label = main_scene.get_node("HUD/PowerNeed")
	var food_icon: Polygon2D = main_scene.get_node("HUD/FoodNeedIcon")
	var water_icon: Polygon2D = main_scene.get_node("HUD/WaterNeedIcon")
	var power_icon: Polygon2D = main_scene.get_node("HUD/PowerNeedIcon")
	var cargo_slot_4: ColorRect = main_scene.get_node("HUD/CargoSlots/Slot4")
	var cargo_slot_nodes: Array[ColorRect] = [
		main_scene.get_node("HUD/CargoSlots/Slot1"),
		main_scene.get_node("HUD/CargoSlots/Slot2"),
		main_scene.get_node("HUD/CargoSlots/Slot3"),
		cargo_slot_4,
	]
	var cargo_slot_icon_nodes: Array[Polygon2D] = [
		main_scene.get_node("HUD/CargoSlots/Icon1"),
		main_scene.get_node("HUD/CargoSlots/Icon2"),
		main_scene.get_node("HUD/CargoSlots/Icon3"),
		main_scene.get_node("HUD/CargoSlots/Icon4"),
	]
	main_scene.cargo_slot_nodes = cargo_slot_nodes
	main_scene.cargo_slot_icon_nodes = cargo_slot_icon_nodes
	main_scene.dive_session.cargo_limit = 3
	main_scene.call("_apply_active_hud_layout")
	main_scene.call("_update_cargo_slots")
	var camera := main_scene.get_node("Player/Camera2D") as Camera2D
	var zoomed_out_reticle: Vector2 = main_scene.call(
		"_scan_reticle_fallback_screen_position",
		main_scene.player.global_position + Vector2(100.0, 0.0),
		Vector2(1280.0, 720.0)
	)
	_expect(zoomed_out_reticle.x < 740.0, "scan reticle should apply zoomed-out camera scale instead of drifting beyond the target")
	_expect(is_equal_approx(zoomed_out_reticle.x, 640.0 + 100.0 * camera.zoom.x), "scan reticle fallback should match Camera2D zoomed screen offset")
	var sticky_player := CharacterBody2D.new()
	root.add_child(sticky_player)
	var sticky_target := DummyScanTarget.new()
	sticky_target.discovery_id = "sticky_target"
	sticky_target.display_name = "Sticky Target"
	sticky_target.global_position = Vector2(142.0, 0.0)
	root.add_child(sticky_target)
	main.player = sticky_player
	main.scan_range = 120.0
	_expect(main.call("_scan_target_still_selectable", sticky_target), "scan target selection should keep the current target inside the sticky buffer")
	sticky_target.global_position = Vector2(154.0, 0.0)
	_expect(not main.call("_scan_target_still_selectable", sticky_target), "scan target selection should release a target beyond the sticky buffer")
	sticky_target.visible = false
	sticky_target.global_position = Vector2(80.0, 0.0)
	_expect(not main.call("_scan_target_still_selectable", sticky_target), "hidden scan targets should not stay selected")
	sticky_target.queue_free()
	sticky_player.queue_free()
	var hud_style := active_panel.get_theme_stylebox("panel") as StyleBoxFlat
	var warning_style := warning_panel.get_theme_stylebox("panel") as StyleBoxFlat
	_expect(hud_style.bg_color.a <= 0.62, "active HUD glass should stay translucent instead of opaque black")
	_expect(hud_style.border_color.a <= 0.38, "active HUD borders should stay subtle")
	_expect(hud_style.shadow_size <= 6, "active HUD shadow should stay tight and game-like")
	_expect(warning_style.bg_color.a >= 0.6, "oxygen warning should stay stronger than ordinary HUD glass")
	_expect(oxygen_label.get_theme_font_size("font_size") <= 15, "oxygen value should be compact rather than debug-sized")
	_expect(health_label.get_theme_font_size("font_size") <= 12, "health value should stay compact inside the active stats panel")
	_expect(depth_label.get_theme_font_size("font_size") <= 12, "depth value should use compact reference-style type")
	_expect(discoveries_label.get_theme_font_size("font_size") <= 12, "discoveries count should stay subordinate")
	_expect(objective_title.get_theme_font_size("font_size") <= 12, "objective title should be a compact HUD label")
	_expect(objective_line.get_theme_font_size("font_size") <= 12, "objective line should be compact enough for a small route card")
	_expect(status_label.get_theme_font_size("font_size") <= 13, "status text should be readable without oversized copy")
	_expect(_control_rect(active_panel).size.x <= 280.0, "active stats panel should keep a compact reference-style width")
	_expect(_control_rect(active_panel).size.y <= 160.0, "active stats panel should keep oxygen, health, and depth compact")
	_expect(_control_rect(cargo_panel).size.x <= 270.0, "cargo strip should be a compact top-center widget, not a wide banner")
	_expect(_control_rect(cargo_panel).size.y <= 50.0, "cargo strip should stay shallow and avoid wasting top-screen space")
	_expect(_control_rect(survival_panel).size.x <= 250.0, "survival needs panel should keep a compact reference-style width")
	_expect(_control_rect(survival_panel).size.x <= 232.0, "survival needs panel should tighten toward the right edge")
	_expect(_control_rect(dive_info_panel).size.x <= 300.0, "route objective card should stay compact")
	_expect(_control_rect(scan_card_panel).size.x <= 230.0, "scan card should be a compact contextual popup")
	_expect(_control_rect(scan_card_panel).size.y <= 92.0, "scan card should stay shallow and avoid permanent right-side clutter")
	_expect(_control_rect(tool_belt_panel).size.x <= 320.0, "tool belt should use compact icon cards instead of a wide placeholder tray")
	_expect(_control_rect(tool_belt_panel).size.y <= 58.0, "tool belt should stay close to the lower edge without tall glass")
	_expect(_control_rect(minimap_panel).size.x <= 192.0, "minimap should stay compact in the lower-right corner")
	_expect(cargo_title.offset_right <= _control_rect(cargo_panel).size.x, "cargo title should stay inside the compact cargo widget")
	_expect(cargo_slots_root.position.x + cargo_slot_4.offset_right <= cargo_panel.offset_right, "all cargo slots should fit inside the compact cargo strip when the fourth slot is unlocked")
	_expect(_control_rect(cargo_panel).encloses(_control_rect(cargo_label)), "active Cargo label should stay inside the top-center cargo strip")
	_expect(cargo_slot_4.offset_right <= 130.0, "cargo card row should stay tight enough to read as a compact strip")
	_expect(_control_rect(survival_panel).encloses(_control_rect(food_label)), "Food need should stay inside the top-right survival panel")
	_expect(_control_rect(survival_panel).encloses(_control_rect(water_label)), "Water need should stay inside the top-right survival panel")
	_expect(_control_rect(survival_panel).encloses(_control_rect(power_label)), "Power need should stay inside the top-right survival panel")
	_expect(food_icon.position.x >= survival_panel.offset_left, "Food icon should stay attached to the compact needs widget")
	_expect(water_icon.position.x >= survival_panel.offset_left, "Water icon should stay attached to the compact needs widget")
	_expect(power_icon.position.x >= survival_panel.offset_left, "Power icon should stay attached to the compact needs widget")
	_expect(discoveries_label.offset_top >= active_panel.offset_top, "active Discoveries label should stay inside the compact stats panel")
	_expect(discoveries_label.offset_bottom <= active_panel.offset_bottom, "active Discoveries label should not spill below the compact stats panel")
	_expect(_control_rect(active_panel).encloses(_control_rect(health_label)), "Health label should stay inside the compact stats panel")
	_expect(_control_rect(active_panel).encloses(_control_rect(health_bar_fill)), "Health bar should stay inside the compact stats panel")
	_expect(cargo_panel.offset_left > active_panel.offset_right, "cargo strip should be separated from the top-left instruments")
	_expect(survival_panel.offset_left > cargo_panel.offset_right, "survival panel should be separated from the cargo strip")
	_expect(oxygen_bar_fill.offset_right <= main_scene.get_node("HUD/OxygenBarBack").offset_right, "oxygen fill should stay inside the oxygen bar")
	_expect(health_bar_fill.offset_right <= main_scene.get_node("HUD/HealthBarBack").offset_right, "health fill should stay inside the health bar")
	_expect(depth_bar_fill.offset_right <= main_scene.get_node("HUD/DepthBarBack").offset_right, "depth fill should stay inside the depth bar")
	_expect(dive_info_panel.offset_top > active_panel.offset_bottom, "dive info panel should remain below compact stats content")
	_expect(_control_rect(scan_card_panel).encloses(_control_rect(scan_target_label)), "scan target should stay inside the dedicated scan card when visible")
	_expect(_control_rect(scan_card_panel).encloses(_control_rect(scan_card_meta_label)), "scan metadata should stay inside the dedicated scan card when visible")
	_expect(_control_rect(scan_card_panel).encloses(_control_rect(scan_card_prompt_label)), "scan prompt should stay inside the dedicated scan card when visible")
	var scan_reticle_top_left: Polygon2D = main_scene.get_node("HUD/ScanReticleRoot/TopLeft")
	_expect(scan_reticle_top_left.polygon[0].x >= -44.0 and scan_reticle_top_left.polygon[0].y >= -32.0, "scan reticle bracket should stay tight around the target instead of covering nearby sprites")
	_expect(tool_belt_panel.offset_top > dive_info_panel.offset_bottom, "tool belt should sit below active guidance and away from the play focus")
	_expect(minimap_panel.offset_left > tool_belt_panel.offset_right, "minimap should occupy the bottom-right reference zone away from the tool belt")
	_expect(depth_rail_line.offset_top > dive_info_panel.offset_bottom, "depth rail should start below the left objective card")
	_expect(depth_rail_marker.position.x >= depth_rail_line.offset_left, "depth rail marker should align to the depth rail")
	_expect(not scan_card_panel.visible, "scan card should hide when no target is selected")
	_expect(not scan_target_label.visible, "scan target label should hide when no target is selected")
	_expect(not scan_card_meta_label.visible, "scan metadata should hide when no target is selected")
	_expect(not scan_card_prompt_label.visible, "scan prompt should hide when no target is selected")
	_expect(not scan_reticle_root.visible, "scan reticle should hide when no target is selected")
	_expect(status_label.offset_bottom <= dive_info_panel.offset_bottom, "status text should stay inside the dive info panel")
	_expect(prompt_label.offset_bottom <= status_label.offset_top, "prompt and status should not overlap")
	_expect(not _controls_overlap(prompt_label, status_label), "active prompt and status rows should remain physically separated")
	_expect(prompt_label.autowrap_mode == TextServer.AUTOWRAP_OFF, "active prompt should clip within its reserved row instead of wrapping into status")
	_expect(status_label.autowrap_mode == TextServer.AUTOWRAP_OFF, "active status should clip within its reserved row instead of wrapping into nearby HUD text")
	_expect(not cargo_slot_4.visible, "fourth cargo slot should stay hidden before Cargo Rack I")
	main_scene.dive_session.cargo_limit = 4
	main_scene.call("_update_cargo_slots")
	_expect(cargo_slot_4.visible, "fourth cargo slot should appear after Cargo Rack I capacity is active")
	_expect(scan_target_label.text == "none nearby", "scan target label should use the scan-card none-nearby copy")
	_expect(not active_panel.visible, "surface-ready state should hide active stats clutter")
	_expect(not cargo_panel.visible, "surface-ready state should hide active cargo clutter")
	_expect(not survival_panel.visible, "surface-ready state should hide active base-needs clutter")
	_expect(not dive_info_panel.visible, "surface-ready state should hide dive guidance clutter")
	_expect(not scan_card_panel.visible, "surface-ready state should hide the contextual scan card")
	_expect(not tool_belt_panel.visible, "surface-ready state should hide the active tool belt")
	_expect(not minimap_panel.visible, "surface-ready state should hide the active minimap")

	main_scene.dive_session.start()
	main_scene.player_in_base = false
	main_scene.call("_update_hud")
	_expect(dive_info_panel.visible, "active diving should show one compact objective card")
	_expect(objective_title.text == "SURVIVAL ROUTE", "objective card title should frame the active goal as survival route work")
	_expect(objective_line.text.length() <= 46, "active objective line should stay shorter than paragraph-style HUD copy")
	_expect(not objective_line.text.contains("|"), "active objective line should not become another command strip")
	_expect(_control_rect(dive_info_panel).encloses(_control_rect(prompt_label)), "active prompt row should stay inside the objective card")
	_expect(_control_rect(dive_info_panel).encloses(_control_rect(status_label)), "active status row should stay inside the objective card")
	main_scene.dive_session.cargo_limit = 3
	main_scene.dive_session.current_cargo = ["food_supply", "water_supply", "driftwood"]
	main_scene.call("_update_hud")
	_expect(objective_line.text == "Cargo full: return to bank", "cargo-full state should replace generic objective copy with a compact return objective")
	main_scene.queue_free()

	var long_status := "Scanned Thermal Vent.\nWarm current marks optional glow; bank Pressure Seal clue. Return safely before oxygen runs out."
	var compact_status: String = HudPresenterScript.compact_dive_status(long_status)
	_expect(not compact_status.contains("\n"), "compact dive status should remove line breaks")
	_expect(compact_status.length() <= 72, "compact dive status should stay within the dive HUD limit")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	var combined_prompt := "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 72, "combined Burst and Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Space burst"), "combined active prompt should keep the Space command visible")
	_expect(combined_prompt.contains("F: decoy ready"), "combined active prompt should keep the Decoy command compact")
	_expect(not combined_prompt.contains("Playtest data:"), "combined active prompt should not expose debug telemetry")

	main.decoy_pulse_used_this_run = true
	combined_prompt = "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 68, "spent Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Decoy spent"), "spent Decoy active prompt should stay compact and explicit")

	_expect(HudPresenterScript.oxygen_state(30.0, 40.0) == "normal", "oxygen helper should treat safe oxygen as normal")
	_expect(HudPresenterScript.oxygen_state(10.0, 40.0) == "low", "oxygen helper should mark 25 percent oxygen as low")
	_expect(HudPresenterScript.oxygen_state(4.0, 40.0) == "critical", "oxygen helper should mark 10 percent oxygen as critical")
	_expect(HudPresenterScript.format_oxygen_label(10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	_expect(HudPresenterScript.format_oxygen_label(40.0, 40.0).begins_with("OXYGEN:"), "oxygen label should use instrument-style active HUD copy")
	_expect(HudPresenterScript.oxygen_warning_text("critical").contains("RETURN TO BASE"), "critical warning should emphasize the return route")
	_expect(HudPresenterScript.health_state(100.0, 100.0) == "normal", "health helper should treat full health as normal")
	_expect(HudPresenterScript.health_state(30.0, 100.0) == "low", "health helper should mark damaged health as low")
	_expect(HudPresenterScript.health_state(12.0, 100.0) == "critical", "health helper should mark near-failure health as critical")
	_expect(HudPresenterScript.format_health_label(30.0, 100.0).contains("LOW"), "health label should carry low state inline")
	main.free()

func _test_mobile_touch_controls_adapter() -> void:
	var main := MainScript.new()
	main.call("_ensure_mobile_touch_controls")
	_expect(main.get_node_or_null("MobileTouchControls") != null, "main scene should install a mobile touch input adapter")
	main.free()

	var controls := MobileTouchControlsScript.new() as CanvasLayer
	controls.call("_build_controls")
	if controls != null:
		var expected_default_visibility := OS.has_feature("mobile") or bool(controls.call("_web_touch_available"))
		_expect(bool(controls.call("should_show_touch_controls")) == expected_default_visibility, "touch controls should be visible on mobile/coarse-touch web and hidden on desktop")
		controls.set("force_visible", true)
		_expect(bool(controls.call("should_show_touch_controls")), "touch controls should support force-visible layout review")
		var root_node := controls.get_node_or_null("TouchControlsRoot") as Control
		var action_root := controls.get_node_or_null("TouchControlsRoot/ActionButtons") as Control
		var scan_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/ScanButton") as Button
		var use_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/InteractButton") as Button
		var burst_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/BurstThrusterButton") as Button
		var next_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/RestartDiveButton") as Button
		_expect(root_node != null, "touch controls should own one full-screen root Control")
		_expect(action_root != null, "touch controls should group action buttons separately from movement")
		_expect(scan_button != null and scan_button.custom_minimum_size.x >= 48.0, "touch Scan button should meet mobile target sizing")
		_expect(use_button != null and use_button.text == "USE", "touch Use button should map to interact")
		_expect(burst_button != null and burst_button.text == "BURST", "touch Burst button should map to burst_thruster")
		_expect(next_button != null and next_button.text == "NEXT", "touch Next button should map to restart_dive")
		_expect(controls.get_node_or_null("TouchControlsRoot/MovePad") != null, "touch controls should include a visible movement pad")
		_expect(controls.get_node_or_null("TouchControlsRoot/MoveKnob") != null, "touch controls should include a visible movement knob")
		var requested_actions: Array[StringName] = []
		controls.connect("action_requested", func(action: StringName) -> void:
			requested_actions.append(action)
		)
		var released_actions: Array[StringName] = []
		controls.connect("action_released", func(action: StringName) -> void:
			released_actions.append(action)
		)
		scan_button.emit_signal("button_down")
		use_button.emit_signal("button_down")
		_expect(requested_actions == [&"scan", &"interact"], "touch action buttons should emit direct semantic gameplay requests")
		scan_button.emit_signal("button_up")
		_expect(released_actions == [&"scan"], "touch Scan button should emit release so held scanning can cancel")
	controls.free()

func _control_rect(control: Control) -> Rect2:
	return Rect2(
		Vector2(control.offset_left, control.offset_top),
		Vector2(control.offset_right - control.offset_left, control.offset_bottom - control.offset_top)
	)

func _controls_overlap(first: Control, second: Control) -> bool:
	return _control_rect(first).intersects(_control_rect(second), true)

func _test_active_hud_final_polish_regression() -> void:
	var main := MainScript.new()
	_expect(not main.call("_active_hud_visible_for_result", DiveSessionScript.Result.READY), "ready state should hide active operational HUD rows")
	_expect(main.call("_surface_hud_visible_for_result", DiveSessionScript.Result.READY), "ready state should show a surface panel")
	_expect(main.call("_active_hud_visible_for_result", DiveSessionScript.Result.DIVING), "diving state should show active operational HUD rows")
	_expect(not main.call("_surface_hud_visible_for_result", DiveSessionScript.Result.DIVING), "diving state should hide surface panels")
	_expect(not main.call("_active_hud_visible_for_result", DiveSessionScript.Result.EXTRACTED), "extracted result should hide active operational HUD rows")
	_expect(main.call("_surface_hud_visible_for_result", DiveSessionScript.Result.EXTRACTED), "extracted result should show a surface panel")
	_expect(not main.call("_active_hud_visible_for_result", DiveSessionScript.Result.FAILED), "failure result should hide active operational HUD rows")
	_expect(main.call("_surface_hud_visible_for_result", DiveSessionScript.Result.FAILED), "failure result should show a surface panel")

	main.show_debug_telemetry = false
	var hidden_summary: String = main.call("_format_run_summary", "Compact result check.", "extracted")
	_expect(not hidden_summary.contains("Playtest data:"), "result summary should hide debug telemetry by default")
	_expect(not hidden_summary.contains("Seed:"), "result summary should hide raw seed by default")

	main.show_debug_telemetry = true
	var debug_summary: String = main.call("_format_run_summary", "Debug result check.", "extracted")
	_expect(debug_summary.contains("Playtest data:"), "result summary should expose debug telemetry only when enabled")
	_expect(debug_summary.contains("Seed:"), "debug telemetry should include raw seed only when enabled")
	main.free()

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)

	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var cargo_panel: Panel = main_scene.get_node("HUD/CargoPanel")
	var survival_panel: Panel = main_scene.get_node("HUD/SurvivalNeedsPanel")
	var scan_card_panel: Panel = main_scene.get_node("HUD/ScanCardPanel")
	var tool_belt_panel: Panel = main_scene.get_node("HUD/ToolBeltPanel")
	var minimap_panel: Panel = main_scene.get_node("HUD/MinimapPanel")
	var oxygen_label: Label = main_scene.get_node("HUD/Oxygen")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var run_panel: Panel = main_scene.get_node("HUD/RunPanel")

	_expect(not active_panel.visible, "raw scene should start with the active stats panel hidden")
	_expect(not cargo_panel.visible, "raw scene should start with the active cargo panel hidden")
	_expect(not survival_panel.visible, "raw scene should start with the active survival panel hidden")
	_expect(not scan_card_panel.visible, "raw scene should start with the contextual scan card hidden")
	_expect(not tool_belt_panel.visible, "raw scene should start with the active tool belt hidden")
	_expect(not minimap_panel.visible, "raw scene should start with the active minimap hidden")
	_expect(not dive_info_panel.visible, "raw scene should start with the dive info panel hidden")
	_expect(run_panel.visible, "raw scene should keep the surface panel visible")
	_expect(oxygen_label.text.begins_with("OXYGEN:"), "active dive should use instrument-style oxygen label")
	_expect(scan_target_label.text == "none nearby", "active dive should use scan-card none-nearby copy")
	_expect(prompt_label.text.length() <= 72, "active prompt should stay short after HUD final polish")

	main_scene.queue_free()

func _test_burst_thruster_movement_helper() -> void:
	var player := PlayerScript.new()
	player.burst(Vector2.DOWN, 700.0)
	_expect(player.velocity == Vector2.DOWN * 700.0, "burst should set velocity in the requested direction")

	player.burst(Vector2.ZERO, 500.0)
	_expect(player.velocity == Vector2.RIGHT * 500.0, "burst without input should use the last facing direction")
	player.free()

func _test_expanded_region_world_bounds() -> void:
	var player := PlayerScript.new()
	_expect(player.world_bounds.position.x <= 100.0, "expanded bounds should preserve the current main descent column")
	_expect(player.world_bounds.end.x >= 2000.0, "expanded bounds should allow roughly one extra screen of right-side exploration")
	_expect(player.world_bounds.position.y >= 240.0, "expanded bounds should keep the sub below the boat hull")
	_expect(player.world_bounds.end.y >= 2350.0, "expanded bounds should allow the first lower connector beyond East Shelf")
	_expect(player.world_bounds.end.x >= 2520.0, "expanded bounds should allow the short Blackwater Sill route")
	_expect(player.world_bounds.end.x >= 2980.0, "expanded bounds should allow the first Dusk Trench continuation beyond Blackwater")
	_expect(player.world_bounds.end.x >= 3180.0, "expanded bounds should allow the short Hollow Reef interior lane")
	_expect(player.world_bounds.end.x >= 3820.0, "expanded bounds should allow the first wider chamber beyond Hollow Reef")
	_expect(player.world_bounds.end.x >= 4300.0, "expanded bounds should allow the Mirror Kelp Pass branch beyond Wide Reef Chamber")
	_expect(player.world_bounds.end.x >= 5400.0, "expanded bounds should allow the first Outer Shelf route footprint")
	_expect(player.world_bounds.end.x <= 5450.0, "expanded bounds should include Area 02 without implying a full open ocean")
	_expect(player.world_bounds.end.y >= 2500.0, "expanded bounds should allow the first Silt Vein Fork scaffold below Blue Chimney")
	_expect(player.world_bounds.end.y >= 2700.0, "expanded bounds should allow the short Blackwater Sill route")
	_expect(player.world_bounds.end.y >= 3040.0, "expanded bounds should allow the first Dusk Trench continuation below Blackwater")
	_expect(player.world_bounds.end.y >= 3160.0, "expanded bounds should allow the first wider Hollow Reef chamber")
	_expect(player.world_bounds.end.y >= 3260.0, "expanded bounds should allow the Mirror Kelp Pass branch floor")
	_expect(player.world_bounds.end.y >= 3380.0, "expanded bounds should allow the first Outer Shelf low rim")
	_expect(player.world_bounds.end.y <= 3450.0, "expanded bounds should avoid implying a full lower biome")

	var clamped_high := player.clamp_position_to_world_bounds(Vector2(640.0, 0.0))
	_expect(clamped_high.y >= player.world_bounds.position.y, "world clamp should prevent surfacing through the boat sprite")

	var clamped_right := player.clamp_position_to_world_bounds(Vector2(5600.0, 900.0))
	_expect(is_equal_approx(clamped_right.x, player.world_bounds.end.x), "world clamp should stop at the expanded right edge")

	var clamped_blue_chimney := player.clamp_position_to_world_bounds(Vector2(2112.0, 2190.0))
	_expect(is_equal_approx(clamped_blue_chimney.x, 2112.0), "world clamp should keep Blue Chimney Pocket horizontally playable")
	_expect(is_equal_approx(clamped_blue_chimney.y, 2190.0), "world clamp should keep Blue Chimney Pocket vertically playable")

	var clamped_silt_vein_fork := player.clamp_position_to_world_bounds(Vector2(2160.0, 2490.0))
	_expect(is_equal_approx(clamped_silt_vein_fork.x, 2160.0), "world clamp should keep Silt Vein Fork horizontally playable")
	_expect(is_equal_approx(clamped_silt_vein_fork.y, 2490.0), "world clamp should keep Silt Vein Fork vertically playable")
	var clamped_blackwater_sill := player.clamp_position_to_world_bounds(Vector2(2440.0, 2660.0))
	_expect(is_equal_approx(clamped_blackwater_sill.x, 2440.0), "world clamp should keep the Blackwater Sill horizontally playable")
	_expect(is_equal_approx(clamped_blackwater_sill.y, 2660.0), "world clamp should keep the Blackwater Sill vertically playable")
	var clamped_dusk_trench := player.clamp_position_to_world_bounds(Vector2(2900.0, 3000.0))
	_expect(is_equal_approx(clamped_dusk_trench.x, 2900.0), "world clamp should keep the Dusk Trench horizontally playable")
	_expect(is_equal_approx(clamped_dusk_trench.y, 3000.0), "world clamp should keep the Dusk Trench vertically playable")
	var clamped_hollow_reef := player.clamp_position_to_world_bounds(Vector2(2940.0, 3040.0))
	_expect(is_equal_approx(clamped_hollow_reef.x, 2940.0), "world clamp should keep the Hollow Reef side-cave mouth horizontally playable")
	_expect(is_equal_approx(clamped_hollow_reef.y, 3040.0), "world clamp should keep the Hollow Reef side-cave turnback vertically playable")
	var clamped_hollow_reef_lane := player.clamp_position_to_world_bounds(Vector2(3180.0, 3056.0))
	_expect(is_equal_approx(clamped_hollow_reef_lane.x, 3180.0), "world clamp should keep the short Hollow Reef interior lane endpoint horizontally playable")
	_expect(is_equal_approx(clamped_hollow_reef_lane.y, 3056.0), "world clamp should keep the short Hollow Reef interior lane endpoint vertically playable")
	var clamped_wide_reef_chamber := player.clamp_position_to_world_bounds(Vector2(3800.0, 3136.0))
	_expect(is_equal_approx(clamped_wide_reef_chamber.x, 3800.0), "world clamp should keep the first wide Hollow Reef chamber horizontally playable")
	_expect(is_equal_approx(clamped_wide_reef_chamber.y, 3136.0), "world clamp should keep the first wide Hollow Reef chamber vertically playable")
	var clamped_mirror_kelp_pass := player.clamp_position_to_world_bounds(Vector2(4300.0, 3260.0))
	_expect(is_equal_approx(clamped_mirror_kelp_pass.x, 4300.0), "world clamp should keep Mirror Kelp Pass horizontally playable")
	_expect(is_equal_approx(clamped_mirror_kelp_pass.y, 3260.0), "world clamp should keep Mirror Kelp Pass vertically playable")
	var clamped_outer_shelf := player.clamp_position_to_world_bounds(Vector2(5240.0, 3380.0))
	_expect(is_equal_approx(clamped_outer_shelf.x, 5240.0), "world clamp should keep the first Outer Shelf footprint horizontally playable")
	_expect(is_equal_approx(clamped_outer_shelf.y, 3380.0), "world clamp should keep the first Outer Shelf footprint vertically playable")

	var clamped_left := player.clamp_position_to_world_bounds(Vector2(-80.0, 900.0))
	_expect(is_equal_approx(clamped_left.x, -80.0), "world clamp should keep the planned left-side Area 01 lane playable")
	player.free()

	var main_scene := MainScene.instantiate()
	var camera := main_scene.get_node("Player/Camera2D") as Camera2D
	_expect(camera.limit_right >= 6120, "camera limit should frame the first Outer Shelf footprint")
	_expect(camera.limit_bottom >= 3340, "camera limit should include the lower edge of Mirror Kelp Pass")
	_expect(camera.limit_right <= 6240, "camera limit should stay tight around the first Outer Shelf footprint")
	_expect(camera.limit_bottom <= 3380, "camera limit should avoid implying a full lower biome")
	var sky := main_scene.get_node("Sky") as ColorRect
	var ocean_shallows := main_scene.get_node("OceanShallows") as ColorRect
	var ocean_midwater := main_scene.get_node("OceanMidwater") as ColorRect
	var ocean_deep := main_scene.get_node("OceanDeep") as ColorRect
	var surface_line := main_scene.get_node("SurfaceLine") as ColorRect
	var deep_pressure_haze := main_scene.get_node("DeepPressureHaze") as Polygon2D
	_expect(sky.offset_right >= float(camera.limit_right), "sky backdrop should cover the expanded camera width")
	_expect(ocean_shallows.offset_right >= float(camera.limit_right), "shallow ocean backdrop should cover the expanded camera width")
	_expect(ocean_midwater.offset_right >= float(camera.limit_right), "midwater backdrop should cover the expanded camera width")
	_expect(ocean_deep.offset_right >= float(camera.limit_right), "deep ocean backdrop should cover the Dusk Trench camera width")
	_expect(ocean_deep.offset_bottom >= float(camera.limit_bottom), "deep ocean backdrop should cover the Dusk Trench camera bottom")
	_expect(surface_line.offset_right >= float(camera.limit_right), "surface line should extend across the playable camera width")
	var haze_right := -1.0
	var haze_bottom := -1.0
	for point in deep_pressure_haze.polygon:
		haze_right = maxf(haze_right, point.x)
		haze_bottom = maxf(haze_bottom, point.y)
	_expect(haze_right >= float(camera.limit_right), "deep pressure haze should cover the Dusk Trench camera width")
	_expect(haze_bottom >= float(camera.limit_bottom), "deep pressure haze should cover the Dusk Trench camera bottom")
	main_scene.free()

func _test_expanded_region_base_direction() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = main.start_position + Vector2(860.0, 640.0)
	var side_route_direction: String = main.call("_format_base_direction")
	_expect(side_route_direction.contains("up-left"), "base direction should point up-left from the expanded right-side route")

	scene_player.global_position = Vector2(2440.0, 2660.0)
	var blackwater_direction: String = main.call("_format_base_direction")
	_expect(blackwater_direction.contains("up-left"), "base direction should point up-left from the Blackwater Sill")
	_expect(blackwater_direction.contains("Silt/Blue"), "base direction should compactly name the Blackwater return landmark chain")
	_expect(not blackwater_direction.contains("Dusk"), "base direction should not name Dusk until the player reaches the new continuation")

	scene_player.global_position = Vector2(2900.0, 3000.0)
	var dusk_direction: String = main.call("_format_base_direction")
	_expect(dusk_direction.contains("up-left"), "base direction should point up-left from the Dusk Trench")
	_expect(dusk_direction.contains("Dusk/Blackwater"), "base direction should compactly name the Dusk return landmark chain")
	_expect(not dusk_direction.contains("Hollow"), "base direction should not name Hollow Reef before the player reaches the side-cave/wide chamber band")

	scene_player.global_position = Vector2(3700.0, 2964.0)
	var wide_chamber_direction: String = main.call("_format_base_direction")
	_expect(wide_chamber_direction.contains("up-left"), "base direction should point up-left from the wide chamber")
	_expect(wide_chamber_direction.contains("Hollow/Dusk/Blackwater"), "base direction should compactly name the wide chamber return route chain")
	_expect(not wide_chamber_direction.contains("Silt/Blue"), "wide chamber base direction should avoid crowding the HUD with the full lower-route chain")

	scene_player.global_position = Vector2(4300.0, 3260.0)
	var mirror_kelp_direction: String = main.call("_format_base_direction")
	_expect(mirror_kelp_direction.contains("up-left"), "base direction should point up-left from Mirror Kelp Pass")
	_expect(mirror_kelp_direction.contains("Hollow/Dusk/Blackwater"), "Mirror Kelp Pass base direction should reuse the broad chamber return route chain")
	_expect(not mirror_kelp_direction.contains("Silt/Blue"), "Mirror Kelp Pass base direction should avoid crowding the HUD with the full lower-route chain")

	scene_player.global_position = main.start_position + Vector2(0.0, 500.0)
	var vertical_direction: String = main.call("_format_base_direction")
	_expect(vertical_direction.begins_with("Base: up "), "base direction should preserve simple upward return copy in the main column")

	scene_player.global_position = main.start_position
	_expect(main.call("_format_base_direction") == "Base: here", "base direction should still read here at the surface base")
	main.queue_free()

func _test_no_minimap_orientation_guardrails() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player

	scene_player.global_position = main.start_position + Vector2(860.0, 640.0)
	var east_shelf_direction: String = main.call("_format_base_direction")
	_expect(east_shelf_direction.contains("up-left"), "East Shelf orientation should use broad return direction")
	_expect_no_echo_lens_locator_language(east_shelf_direction, "East Shelf base direction")

	scene_player.global_position = Vector2(2124.0, 2024.0)
	var shelf_drop_direction: String = main.call("_format_base_direction")
	_expect(shelf_drop_direction.contains("up-left"), "Shelf Drop orientation should use broad return direction")
	_expect_no_echo_lens_locator_language(shelf_drop_direction, "Shelf Drop base direction")

	scene_player.global_position = Vector2(2112.0, 2190.0)
	var blue_chimney_direction: String = main.call("_format_base_direction")
	_expect(blue_chimney_direction.contains("up-left"), "Blue Chimney orientation should use broad return direction")
	_expect_no_echo_lens_locator_language(blue_chimney_direction, "Blue Chimney base direction")

	scene_player.global_position = Vector2(2160.0, 2346.0)
	var silt_vein_direction: String = main.call("_format_base_direction")
	_expect(silt_vein_direction.contains("up-left"), "Silt Vein Fork orientation should use broad return direction")
	_expect_no_echo_lens_locator_language(silt_vein_direction, "Silt Vein Fork base direction")

	scene_player.global_position = Vector2(2440.0, 2660.0)
	var blackwater_sill_direction: String = main.call("_format_base_direction")
	_expect(blackwater_sill_direction.contains("up-left"), "Blackwater Sill orientation should use broad return direction")
	_expect(blackwater_sill_direction.contains("Silt/Blue"), "Blackwater Sill orientation should keep compact named return memory")
	_expect_no_echo_lens_locator_language(blackwater_sill_direction, "Blackwater Sill base direction")
	scene_player.global_position = Vector2(2900.0, 3000.0)
	var dusk_trench_direction: String = main.call("_format_base_direction")
	_expect(dusk_trench_direction.contains("up-left"), "Dusk Trench orientation should use broad return direction")
	_expect(dusk_trench_direction.contains("Dusk/Blackwater"), "Dusk Trench orientation should keep compact named return memory")
	_expect(not dusk_trench_direction.contains("Hollow"), "Dusk Trench orientation should not claim the player is inside Hollow Reef")
	_expect_no_echo_lens_locator_language(dusk_trench_direction, "Dusk Trench base direction")

	scene_player.global_position = Vector2(3700.0, 2964.0)
	var wide_chamber_direction: String = main.call("_format_base_direction")
	_expect(wide_chamber_direction.contains("up-left"), "Wide chamber orientation should use broad return direction")
	_expect(wide_chamber_direction.contains("Hollow/Dusk/Blackwater"), "Wide chamber orientation should keep a compact named return chain")
	_expect(not wide_chamber_direction.contains("Silt/Blue"), "Wide chamber orientation should stay short enough for the active HUD")
	_expect_no_echo_lens_locator_language(wide_chamber_direction, "Wide chamber base direction")

	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	var orientation_memory := "%s%s%s" % [
		main.call("_format_east_shelf_pocket_research_callout"),
		main.call("_format_lower_connector_echo_research_callout"),
		main.call("_format_sealed_shelf_hatch_readiness_callout"),
	]
	_expect(orientation_memory.contains("East Shelf"), "orientation memory should name the learned side route")
	_expect(orientation_memory.contains("Shelf Drop Connector"), "orientation memory should name the lower connector")
	_expect(orientation_memory.contains("Sealed Shelf Hatch"), "orientation memory should name the upgrade-locked promise")
	_expect_no_echo_lens_locator_language(orientation_memory, "larger side-view route result memory")

	var blue_chimney_landmark := main.get_node("LandmarkMetadata/BlueChimney")
	var blue_chimney_memory := "%s %s %s" % [
		String(blue_chimney_landmark.get("display_name")),
		String(blue_chimney_landmark.get("stable_region_name")),
		String(blue_chimney_landmark.get("memory_goal")),
	]
	_expect(blue_chimney_memory.contains("Blue Chimney"), "Blue Chimney metadata should provide broad place memory")
	_expect(blue_chimney_memory.contains("up-left"), "Blue Chimney metadata should preserve broad return orientation")
	_expect_no_echo_lens_locator_language(blue_chimney_memory, "Blue Chimney metadata")
	var silt_vein_landmark := main.get_node("LandmarkMetadata/SiltVeinFork")
	var silt_vein_memory := "%s %s %s" % [
		String(silt_vein_landmark.get("display_name")),
		String(silt_vein_landmark.get("stable_region_name")),
		String(silt_vein_landmark.get("memory_goal")),
	]
	_expect(silt_vein_memory.contains("Silt Vein Fork"), "Silt Vein Fork metadata should provide broad place memory")
	_expect(silt_vein_memory.contains("Blue Chimney"), "Silt Vein Fork metadata should anchor return memory to Blue Chimney")
	_expect(silt_vein_memory.contains("up-left"), "Silt Vein Fork metadata should preserve broad return orientation")
	_expect_no_echo_lens_locator_language(silt_vein_memory, "Silt Vein Fork metadata")
	var dusk_trench_landmark := main.get_node("LandmarkMetadata/DuskTrench")
	var dusk_trench_memory := "%s %s %s" % [
		String(dusk_trench_landmark.get("display_name")),
		String(dusk_trench_landmark.get("stable_region_name")),
		String(dusk_trench_landmark.get("memory_goal")),
	]
	_expect(dusk_trench_memory.contains("Dusk Trench"), "Dusk Trench metadata should provide broad place memory")
	_expect(dusk_trench_memory.contains("Blackwater"), "Dusk Trench metadata should anchor return memory to Blackwater")
	_expect(dusk_trench_memory.contains("up-left"), "Dusk Trench metadata should preserve broad return orientation")
	_expect(not dusk_trench_memory.to_lower().contains("coordinate"), "Dusk Trench metadata should avoid coordinate language")
	_expect(not dusk_trench_memory.to_lower().contains("map"), "Dusk Trench metadata should avoid map language")
	_expect_no_echo_lens_locator_language(dusk_trench_memory, "Dusk Trench metadata")
	main.queue_free()

func _test_expanded_region_reset_state_ownership() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	var run_before_restart: int = main.progression_state.current_run_number

	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.run_wreck_echo_clue_recovered = true
	main.run_resonance_alcove_research_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_glass_kelp_ledge = true
	main.player_near_tideglass_sample = true
	main.player_near_outer_shelf_survey = true
	main.player_near_rim_glass_reading = true
	main.player_near_salvage_manifest = true
	main.run_collected_resources.append("kelp_fiber")
	main.run_completed_scans.append("east_shelf_arch")
	main.run_predator_contacts = 1
	main.decoy_pulse_used_this_run = true
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = main.start_position + Vector2(1280.0, 980.0)
	scene_player.velocity = Vector2(123.0, 45.0)

	main.call("_restart_dive")

	_expect(main.progression_state.current_run_number == run_before_restart + 1, "restart should advance to the next expedition seed")
	_expect(scene_player.global_position == main.start_position, "restart should return the sub to the marked base start")
	_expect(scene_player.velocity == Vector2.ZERO, "restart should clear expanded-route movement velocity")
	_expect(main.player_in_base, "restart should restore extraction-zone ownership to the base")
	_expect(not main.dive_session.has_left_base, "restart should require leaving base before extraction can succeed again")
	_expect(not main.dive_session.can_extract(main.player_in_base), "restart should preserve extraction safety at the starting base")
	_expect(main.dive_session.cargo.is_empty(), "restart should clear carried cargo from the previous expedition")
	_expect(not main.run_wreck_echo_clue_recovered, "restart should clear run-scoped Wreck Echo clue state")
	_expect(not main.run_resonance_alcove_research_recovered, "restart should clear run-scoped Resonance Alcove research state")
	_expect(not main.run_blue_chimney_draft_reading_recovered, "restart should clear run-scoped Blue Chimney draft state")
	_expect(not main.run_lantern_silt_sample_recovered, "restart should clear run-scoped Lantern Silt sample state")
	_expect(not main.run_glass_kelp_reading_recovered, "restart should clear run-scoped Glass Kelp reading state")
	_expect(not main.run_tideglass_sample_recovered, "restart should clear run-scoped Tideglass Sample state")
	_expect(not main.run_outer_shelf_survey_recovered, "restart should clear run-scoped Outer Shelf survey state")
	_expect(not main.run_rim_glass_reading_recovered, "restart should clear run-scoped Glass Rim reading state")
	_expect(not main.player_near_resonance_alcove, "restart should clear Resonance Alcove proximity state")
	_expect(not main.player_near_blue_chimney, "restart should clear Blue Chimney proximity state")
	_expect(not main.player_near_lantern_silt_nook, "restart should clear Lantern Silt proximity state")
	_expect(not main.player_near_glass_kelp_ledge, "restart should clear Glass Kelp proximity state")
	_expect(not main.player_near_tideglass_sample, "restart should clear Tideglass Sample proximity state")
	_expect(not main.player_near_outer_shelf_survey, "restart should clear Outer Shelf proximity state")
	_expect(not main.player_near_rim_glass_reading, "restart should clear Glass Rim reading proximity state")
	_expect(main.run_collected_resources.is_empty(), "restart should clear run-scoped collected-resource telemetry")
	_expect(main.run_completed_scans.is_empty(), "restart should clear run-scoped scan telemetry")
	_expect(main.run_predator_contacts == 0, "restart should clear run-scoped predator contact telemetry")
	_expect(not main.decoy_pulse_used_this_run, "restart should clear run-scoped decoy pulse use")
	_expect(main.progression_state.resource_count("glow_plankton") == 2, "restart should preserve banked persistent resources")
	_expect(main.progression_state.has_upgrade(EchoLensUpgrade.id), "restart should preserve purchased persistent upgrades")

	var lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	_expect(lock_label.text == "ECHO PING", "restart should preserve persistent upgrade promise state after reset")
	main.queue_free()

func _test_lower_connector_reset_and_bounds_coverage() -> void:
	var player_bounds := PlayerScript.new()
	var clamped_lower_connector := player_bounds.clamp_position_to_world_bounds(Vector2(2124.0, 2450.0))
	_expect(is_equal_approx(clamped_lower_connector.x, 2124.0), "lower connector bounds should keep the staged route horizontally playable")
	_expect(is_equal_approx(clamped_lower_connector.y, 2450.0), "lower connector bounds should keep the Silt Vein Fork approach playable")
	_expect(player_bounds.world_bounds.end.y <= 3450.0, "expanded bounds should include Area 02 without becoming an open-world canvas")
	player_bounds.free()

	var main := MainScene.instantiate()
	root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = Vector2(2124.0, 2024.0)
	var lower_connector_direction: String = main.call("_format_base_direction")
	_expect(lower_connector_direction.contains("up-left"), "base direction should point up-left from the Shelf Drop Connector")

	var glass_kelp_ledge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge") as Node2D
	var low_visibility_cue := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue") as Node2D
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.run_predator_contacts = 1
	main.player_in_base = false
	scene_player.global_position = glass_kelp_ledge.global_position
	main.call("_update_depth")
	main.call("_update_hud")
	_expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Glass Kelp Ledge should not add a hidden oxygen tax")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Kelp Ledge should not mutate cargo")
	_expect(main.run_predator_contacts == 1, "Glass Kelp Ledge should not mutate predator pressure")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Glass Kelp Ledge should not change the dive result")
	_expect(main.dive_session.has_left_base, "Glass Kelp Ledge should not reset extraction eligibility")
	_expect(not main.player_in_base, "Glass Kelp Ledge should not move the player into the base")

	scene_player.global_position = low_visibility_cue.global_position
	main.call("_update_depth")
	main.call("_update_hud")
	_expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Dusk Trench low-visibility cue should not drain oxygen")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Dusk Trench low-visibility cue should not alter cargo")
	_expect(main.run_predator_contacts == 1, "Dusk Trench low-visibility cue should not mutate predator state")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Dusk Trench low-visibility cue should not damage or end the dive")
	_expect(main.dive_session.has_left_base, "Dusk Trench low-visibility cue should not reset extraction eligibility")
	_expect(not main.player_in_base, "Dusk Trench low-visibility cue should not move the player into the base")

	main.player_near_lower_connector_echo = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.run_lower_connector_echo_recovered = true
	main.run_resonance_alcove_research_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.blue_chimney_draft_timer = 1.7
	main.blackwater_pressure_timer = 1.9
	main.visual_smoke_route_stage = "lower_connector"
	main.call("_reset_run_telemetry")
	_expect(not main.run_lower_connector_echo_recovered, "run telemetry reset should clear Drop Echo research state")
	_expect(not main.run_resonance_alcove_research_recovered, "run telemetry reset should clear Resonance Alcove research state")
	_expect(not main.run_blue_chimney_draft_reading_recovered, "run telemetry reset should clear Blue Chimney draft research state")
	_expect(not main.run_lantern_silt_sample_recovered, "run telemetry reset should clear Lantern Silt sample state")
	_expect(not main.run_blackwater_trace_recovered, "run telemetry reset should clear Blackwater Trace state")
	_expect(not main.run_reached_dusk_trench, "run telemetry reset should clear Dusk Trench reach memory")
	_expect(not main.run_glass_kelp_reading_recovered, "run telemetry reset should clear Glass Kelp reading state")
	_expect(not main.run_tideglass_sample_recovered, "run telemetry reset should clear Tideglass Sample state")
	_expect(not main.run_outer_shelf_survey_recovered, "run telemetry reset should clear Outer Shelf survey state")
	_expect(not main.run_rim_glass_reading_recovered, "run telemetry reset should clear Glass Rim reading state")
	_expect(not main.run_salvage_manifest_recovered, "run telemetry reset should clear Salvage Manifest state")
	_expect(is_equal_approx(main.blue_chimney_draft_timer, 0.0), "run telemetry reset should clear Blue Chimney visual timing state")
	_expect(is_equal_approx(main.blackwater_pressure_timer, 0.0), "run telemetry reset should clear Blackwater pressure-cue timing state")
	_expect(main.visual_smoke_route_stage == "", "run telemetry reset should clear lower-connector visual route stage")

	main.player_near_lower_connector_echo = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_blackwater_crack = true
	main.player_near_tideglass_sample = true
	main.player_near_outer_shelf_survey = true
	main.player_near_rim_glass_reading = true
	main.player_near_salvage_manifest = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.call("_prepare_next_run")
	_expect(not main.player_near_lower_connector_echo, "new expeditions should clear Drop Echo proximity state")
	_expect(not main.player_near_resonance_alcove, "new expeditions should clear Resonance Alcove proximity state")
	_expect(not main.player_near_blue_chimney, "new expeditions should clear Blue Chimney proximity state")
	_expect(not main.player_near_lantern_silt_nook, "new expeditions should clear Lantern Silt proximity state")
	_expect(not main.player_near_blackwater_crack, "new expeditions should clear Blackwater Crack proximity state")
	_expect(not main.player_near_tideglass_sample, "new expeditions should clear Tideglass Sample proximity state")
	_expect(not main.player_near_outer_shelf_survey, "new expeditions should clear Outer Shelf proximity state")
	_expect(not main.player_near_rim_glass_reading, "new expeditions should clear Glass Rim reading proximity state")
	_expect(not main.player_near_salvage_manifest, "new expeditions should clear Salvage Manifest proximity state")
	_expect(not main.run_lower_connector_echo_recovered, "new expeditions should not carry Drop Echo research state")
	_expect(not main.run_resonance_alcove_research_recovered, "new expeditions should not carry Resonance Alcove research state")
	_expect(not main.run_blue_chimney_draft_reading_recovered, "new expeditions should not carry Blue Chimney draft research state")
	_expect(not main.run_lantern_silt_sample_recovered, "new expeditions should not carry Lantern Silt sample state")
	_expect(not main.run_blackwater_trace_recovered, "new expeditions should not carry Blackwater Trace state")
	_expect(not main.run_reached_dusk_trench, "new expeditions should not carry Dusk Trench reach memory")
	_expect(not main.run_glass_kelp_reading_recovered, "new expeditions should not carry Glass Kelp reading state")
	_expect(not main.run_tideglass_sample_recovered, "new expeditions should not carry Tideglass Sample state")
	_expect(not main.run_outer_shelf_survey_recovered, "new expeditions should not carry Outer Shelf survey state")
	_expect(not main.run_rim_glass_reading_recovered, "new expeditions should not carry Glass Rim reading state")
	_expect(not main.run_salvage_manifest_recovered, "new expeditions should not carry Salvage Manifest state")
	_expect(not main.progression_state.to_save_data().has("lower_connector_echo"), "Drop Echo should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("resonance_alcove_research"), "Resonance Alcove research should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("blue_chimney"), "Blue Chimney should not create durable route state")
	_expect(not main.progression_state.to_save_data().has("blue_chimney_signal"), "Blue Chimney signal should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("blue_chimney_draft"), "Blue Chimney draft should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("silt_vein"), "Silt Vein should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("silt_vein_fork"), "Silt Vein Fork should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("lantern_silt"), "Lantern Silt should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("lantern_silt_sample"), "Lantern Silt sample should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("blackwater_crack"), "Blackwater Crack should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("blackwater_trace"), "Blackwater Trace should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("dusk_trench_reached"), "Dusk Trench reach memory should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("glass_kelp_reading"), "Glass Kelp reading should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("tideglass_sample"), "Tideglass Sample should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("outer_shelf_survey"), "Outer Shelf survey should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("rim_glass_reading"), "Glass Rim reading should not be stored in durable progression")
	_expect(not main.progression_state.to_save_data().has("salvage_manifest"), "Salvage Manifest should not be stored in durable progression")
	main.queue_free()

func _test_east_shelf_pocket_prompt_interaction() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	main.dive_session.start()
	main.player_in_base = false
	main.player_near_east_shelf_pocket = true
	var signal_core_gem := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreGem") as Polygon2D
	var signal_core_spark := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreSpark") as Polygon2D
	main.call("_sync_east_shelf_pocket_payoff_state")
	_expect(signal_core_gem.color.a >= 0.8 and signal_core_spark.visible, "East Shelf signal core should start as an obvious visible payoff")
	var prompt: String = main.call("_format_hud_prompt")
	_expect(prompt.contains("East Shelf Pocket"), "East Shelf pocket proximity should own the active dive prompt")
	_expect(prompt.contains("recover signal core"), "East Shelf pocket prompt should name the visible payoff")

	var handled: bool = main.call("_try_east_shelf_pocket_interaction")
	_expect(handled, "East Shelf pocket should handle interact while the player is nearby during a dive")
	_expect(main.run_east_shelf_pocket_ping_recovered, "East Shelf pocket interaction should record one run-scoped research ping")
	_expect(signal_core_gem.color.a <= 0.2 and not signal_core_spark.visible, "East Shelf signal core should visibly dim after recovery")
	if main.status_label != null:
		_expect(main.status_label.text.contains("signal core recovered"), "East Shelf pocket interaction should acknowledge the visible payoff")

	var repeat_handled: bool = main.call("_try_east_shelf_pocket_interaction")
	_expect(repeat_handled, "East Shelf pocket should keep handling repeat interact while nearby")
	if main.status_label != null:
		_expect(main.status_label.text.contains("already recorded"), "East Shelf pocket repeat interaction should not duplicate the payoff")

	main.player_near_east_shelf_pocket = false
	var not_handled: bool = main.call("_try_east_shelf_pocket_interaction")
	_expect(not not_handled, "East Shelf pocket should not consume interact outside its proximity zone")

	main.call("_reset_run_telemetry")
	_expect(not main.run_east_shelf_pocket_ping_recovered, "East Shelf pocket research ping should reset between expeditions")
	_expect(signal_core_gem.color.a >= 0.8 and signal_core_spark.visible, "East Shelf signal core should be visible again after expedition reset")
	main.queue_free()

func _test_east_shelf_current_surge_visual_timing() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_east_shelf_current_surge_alpha", 0.0)
	var high_alpha: float = main.call("_east_shelf_current_surge_alpha", MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS * 0.25)
	var return_alpha: float = main.call("_east_shelf_current_surge_alpha", MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS * 0.5)

	_expect(high_alpha > low_alpha, "East Shelf current-surge alpha should pulse upward to suggest timing")
	_expect(is_equal_approx(low_alpha, return_alpha), "East Shelf current-surge pulse should repeat smoothly")
	_expect(low_alpha >= 0.08 and high_alpha <= 0.18, "East Shelf current-surge pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true

	main.call("_update_east_shelf_current_surge", 0.7)
	_expect(is_equal_approx(main.dive_session.oxygen, 24.0), "East Shelf current surge should not drain oxygen")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "East Shelf current surge should not change carried cargo")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "East Shelf current surge should not change dive result")
	_expect(main.dive_session.has_left_base, "East Shelf current surge should not reset extraction eligibility")
	_expect(not main.player_in_base, "East Shelf current surge should not move the player into the base")
	_expect(main.run_predator_contacts == 1, "East Shelf current surge should not create predator contacts")
	_expect(main.progression_state.has_upgrade(PressureSealUpgrade.id), "East Shelf current surge should not mutate pressure upgrade state")
	main.free()

func _test_blue_chimney_reverse_draft_visual_timing() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_blue_chimney_reverse_draft_alpha", 0.0)
	var high_alpha: float = main.call("_blue_chimney_reverse_draft_alpha", MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS * 0.25)
	var return_alpha: float = main.call("_blue_chimney_reverse_draft_alpha", MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS * 0.5)

	_expect(high_alpha > low_alpha, "Blue Chimney reverse draft alpha should pulse upward to suggest timing")
	_expect(is_equal_approx(low_alpha, return_alpha), "Blue Chimney reverse draft pulse should repeat smoothly")
	_expect(low_alpha >= 0.07 and high_alpha <= 0.14, "Blue Chimney reverse draft pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 22.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true

	main.call("_update_blue_chimney_reverse_draft", 0.7)
	_expect(is_equal_approx(main.dive_session.oxygen, 22.0), "Blue Chimney reverse draft should not drain oxygen")
	_expect(main.dive_session.current_cargo == ["shell_fragments"], "Blue Chimney reverse draft should not change carried cargo")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Blue Chimney reverse draft should not change dive result")
	_expect(main.dive_session.has_left_base, "Blue Chimney reverse draft should not reset extraction eligibility")
	_expect(not main.player_in_base, "Blue Chimney reverse draft should not move the player into the base")
	_expect(main.run_predator_contacts == 1, "Blue Chimney reverse draft should not create predator contacts")
	_expect(main.progression_state.resource_count("glow_plankton") == 2, "Blue Chimney reverse draft should not mutate banked resources")
	_expect(main.progression_state.has_upgrade(PressureSealUpgrade.id), "Blue Chimney reverse draft should not mutate pressure upgrade state")
	main.free()

func _test_blackwater_pressure_cue_visual_timing() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_blackwater_pressure_cue_alpha", 0.0)
	var high_alpha: float = main.call("_blackwater_pressure_cue_alpha", MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)
	var return_alpha: float = main.call("_blackwater_pressure_cue_alpha", MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.5)

	_expect(high_alpha > low_alpha, "Blackwater pressure cue alpha should pulse upward to suggest timing")
	_expect(is_equal_approx(low_alpha, return_alpha), "Blackwater pressure cue pulse should repeat smoothly")
	_expect(low_alpha >= 0.1 and high_alpha <= 0.2, "Blackwater pressure cue pulse should stay subtle and non-combat")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	scene_main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	scene_main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	scene_main.progression_state.banked_resources["glow_plankton"] = 2
	scene_main.dive_session.reset(30.0)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 21.0
	scene_main.dive_session.current_cargo = ["shell_fragments"]
	scene_main.dive_session.has_left_base = true
	scene_main.player_in_base = false
	scene_main.run_predator_contacts = 1
	scene_main.call("_sync_blackwater_crack_gate_state")
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var pressure_rib_a := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue") as Polygon2D

	scene_main.call("_update_blackwater_pressure_cue", MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)
	_expect(pressure_shutter.color.b > pressure_shutter.color.g, "Blackwater pressure cue should remain violet-blue after pulsing")
	_expect(pressure_rib_a.color.b > pressure_rib_a.color.g, "Blackwater pressure rib should remain distinct from safe current green")
	_expect(return_current.color.g > pressure_shutter.color.g, "Blackwater return current should stay visually distinct from pressure cue")
	_expect(is_equal_approx(scene_main.dive_session.oxygen, 21.0), "Blackwater pressure cue should not drain oxygen")
	_expect(scene_main.dive_session.current_cargo == ["shell_fragments"], "Blackwater pressure cue should not change carried cargo")
	_expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Blackwater pressure cue should not change dive result")
	_expect(scene_main.dive_session.has_left_base, "Blackwater pressure cue should not reset extraction eligibility")
	_expect(not scene_main.player_in_base, "Blackwater pressure cue should not move the player into the base")
	_expect(scene_main.run_predator_contacts == 1, "Blackwater pressure cue should not create predator contacts")
	_expect(scene_main.progression_state.resource_count("glow_plankton") == 2, "Blackwater pressure cue should not mutate banked resources")
	_expect(scene_main.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Blackwater pressure cue should not mutate Resonance Key ownership")
	_expect(scene_main.progression_state.has_upgrade(PressureSealUpgrade.id), "Blackwater pressure cue should not mutate Pressure Seal ownership")
	scene_main.queue_free()

func _test_hollow_reef_timing_current_visual_only() -> void:
	var main := MainScript.new()
	var low_alpha: float = main.call("_hollow_reef_timing_current_alpha", 0.0)
	var high_alpha: float = main.call("_hollow_reef_timing_current_alpha", MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.25)
	var return_alpha: float = main.call("_hollow_reef_timing_current_alpha", MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.5)

	_expect(high_alpha > low_alpha, "Hollow Reef timing current alpha should pulse upward to suggest wait/pass timing")
	_expect(is_equal_approx(low_alpha, return_alpha), "Hollow Reef timing current pulse should repeat smoothly")
	_expect(low_alpha >= 0.08 and high_alpha <= 0.16, "Hollow Reef timing current pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 20.0
	main.dive_session.current_cargo.append("glow_plankton")
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.banked_resources["shell_fragments"] = 2
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true

	main.call("_update_hollow_reef_timing_current", 0.7)
	_expect(is_equal_approx(main.dive_session.oxygen, 20.0), "Hollow Reef timing current should not drain oxygen")
	_expect(main.dive_session.current_cargo == ["glow_plankton"], "Hollow Reef timing current should not change carried cargo")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Hollow Reef timing current should not change dive result")
	_expect(main.dive_session.has_left_base, "Hollow Reef timing current should not reset extraction eligibility")
	_expect(not main.player_in_base, "Hollow Reef timing current should not move the player into the base")
	_expect(main.run_predator_contacts == 1, "Hollow Reef timing current should not create predator contacts")
	_expect(main.progression_state.resource_count("shell_fragments") == 2, "Hollow Reef timing current should not mutate banked resources")
	_expect(main.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Hollow Reef timing current should not mutate upgrade ownership")
	main.free()

	var scene_main := MainScene.instantiate()
	root.add_child(scene_main)
	scene_main.dive_session.reset(30.0)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 19.0
	scene_main.dive_session.current_cargo.append("kelp_fiber")
	scene_main.dive_session.has_left_base = true
	scene_main.player_in_base = false
	scene_main.run_predator_contacts = 1
	scene_main.progression_state.banked_resources["glow_plankton"] = 2

	var timing_cue := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue") as Node2D
	var upper := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonUpper") as Polygon2D
	var tick := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickA") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnCurrent") as Polygon2D
	var reading_halo := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo") as Polygon2D
	var pocket_glimmer := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var predator_warning := scene_main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D

	_expect(timing_cue.find_child("CollisionShape2D", true, false) == null, "Hollow Reef timing current should not add collision")
	_expect(timing_cue.find_child("InteractZone", true, false) == null, "Hollow Reef timing current should not add an interaction hotspot")
	_expect(timing_cue.find_child("ResourcePickup", true, false) == null, "Hollow Reef timing current should not add resource behavior")
	_expect(timing_cue.find_child("Predator", true, false) == null, "Hollow Reef timing current should not reuse predator behavior")
	_expect(timing_cue.find_child("PressureBoundary", true, false) == null, "Hollow Reef timing current should not add pressure behavior")
	scene_main.call("_update_hollow_reef_timing_current", MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.25)
	_expect(upper.color.b > upper.color.g and upper.color.r > upper.color.g, "Hollow Reef timing current should use pale timing color instead of safe-current green")
	_expect(return_current.color.g > upper.color.g, "Hollow Reef safe-return current should stay greener than the timing cue")
	_expect(upper.color.r > pressure_shutter.color.r and upper.color.g > pressure_shutter.color.g, "Hollow Reef timing current should stay brighter than pressure-lock language")
	_expect(predator_warning.color.r > upper.color.r, "Hollow Reef timing current should stay distinct from red predator warning language")
	_expect(pocket_glimmer.color.g > upper.color.g, "Hollow Reef timing current should not read like the green-yellow resource pocket glimmer")
	_expect(upper.color.a <= 0.16 and tick.color.a <= 0.21, "Hollow Reef timing current should remain subtle enough not to obscure cave content")
	_expect(reading_halo.color.a >= upper.color.a, "Hollow Reef reading payoff should remain as visible as the timing cue")
	_expect(is_equal_approx(scene_main.dive_session.oxygen, 19.0), "scene Hollow Reef timing current should not drain oxygen")
	_expect(scene_main.dive_session.current_cargo == ["kelp_fiber"], "scene Hollow Reef timing current should not mutate cargo")
	_expect(scene_main.run_predator_contacts == 1, "scene Hollow Reef timing current should not create predator contacts")
	_expect(scene_main.progression_state.resource_count("glow_plankton") == 2, "scene Hollow Reef timing current should not mutate resources")
	scene_main.queue_free()

func _test_sealed_shelf_hatch_promise_state() -> void:
	var main := MainScene.instantiate()
	root.add_child(main)
	var lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	var lock_badge := main.get_node("EastShelfSpur/SealedShelfHatch/LockBadge") as Polygon2D
	var seal_bars := main.get_node("EastShelfSpur/SealedShelfHatch/SealBars") as Polygon2D
	main.sealed_shelf_hatch_echo_shimmer = main.get_node("EastShelfSpur/SealedShelfHatch/EchoShimmer") as Polygon2D
	main.sealed_shelf_hatch_lock_badge = lock_badge
	main.sealed_shelf_hatch_lock_label = lock_label
	var locked_badge_color := lock_badge.color
	var locked_bars_alpha := seal_bars.color.a
	main.call("_sync_sealed_shelf_hatch_state")
	_expect(lock_label.text == "ECHO LOCK", "Sealed Shelf Hatch should advertise the missing Echo Lens upgrade before ownership")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.call("_sync_sealed_shelf_hatch_state")
	_expect(lock_label.text == "ECHO PING", "Sealed Shelf Hatch should change to a scanner-ready promise after Echo Lens I")
	_expect(lock_badge.color != locked_badge_color, "Sealed Shelf Hatch badge should visually react to Echo Lens I ownership")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["glow_plankton"]
	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.call("_sync_sealed_shelf_hatch_state")
	_expect(lock_label.text == "OPEN", "Sealed Shelf Hatch should visibly open after Resonance Key I")
	_expect(lock_badge.color != locked_badge_color, "open Sealed Shelf Hatch badge should stay visually distinct from the locked state")
	_expect(seal_bars.color.a < locked_bars_alpha, "open Sealed Shelf Hatch should soften the seal bars without adding an interior")
	_expect(main.get_node_or_null("EastShelfSpur/SealedShelfHatch/Interior") == null, "open hatch should not add a broad interior system")
	_expect(is_equal_approx(main.dive_session.oxygen, 18.0), "open hatch sync should not change oxygen")
	_expect(main.dive_session.current_cargo == ["glow_plankton"], "open hatch sync should not change carried cargo")
	_expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "open hatch sync should not change dive state")
	var saved_after_open: Dictionary = main.progression_state.to_save_data()
	_expect(not saved_after_open.has("quest"), "open hatch should not add durable quest state")
	_expect(not saved_after_open.has("map"), "open hatch should not add durable map state")
	_expect(not saved_after_open.has("objective"), "open hatch should not add durable objective state")
	_expect(not saved_after_open.has("sealed_shelf_hatch_open"), "open hatch should be derived from Resonance Key ownership, not separate hatch save state")
	main.queue_free()

	var copy_main := MainScript.new()
	_expect(copy_main._format_sealed_shelf_hatch_readiness_callout() == "", "sealed hatch readiness copy should stay hidden before Echo Lens I")
	copy_main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	_expect(copy_main._format_sealed_shelf_hatch_readiness_callout() == "", "sealed hatch readiness copy should need recovered route research")
	copy_main.run_east_shelf_pocket_ping_recovered = true
	var readiness_copy := copy_main._format_sealed_shelf_hatch_readiness_callout()
	_expect(readiness_copy.contains("Sealed Shelf Hatch"), "sealed hatch readiness copy should name the hatch promise")
	_expect(readiness_copy.contains("Resonance Key"), "sealed hatch readiness copy should point to the future key promise")
	_expect_no_echo_lens_locator_language(readiness_copy, "sealed hatch readiness copy")

	var empty_cargo: Array[String] = []
	var extraction_summary := copy_main._format_extraction_result_summary(0, empty_cargo)
	_expect(extraction_summary.contains("Resonance Key"), "sealed hatch readiness copy should appear in extraction result after relevant research")
	copy_main.free()

func _test_player_visual_facing_isolation() -> void:
	var player := PlayerScene.instantiate()
	root.add_child(player)
	var visual_root: Node2D = player.get_node("VisualRoot")

	player.call("_set_facing_sign", -1.0)
	_expect(player.scale == Vector2.ONE, "facing should not mirror the physics/player root")
	_expect(visual_root.scale.x == -1.0, "facing left should mirror only the visual root")
	player.set("_last_move_direction", Vector2.ZERO)
	_expect(player.get_burst_direction() == Vector2.LEFT, "burst fallback should use the tracked left-facing sign")

	player.call("_set_facing_sign", 1.0)
	_expect(player.scale == Vector2.ONE, "facing right should keep the physics/player root unmirrored")
	_expect(visual_root.scale.x == 1.0, "facing right should restore the visual root")
	player.set("_last_move_direction", Vector2.ZERO)
	_expect(player.get_burst_direction() == Vector2.RIGHT, "burst fallback should use the tracked right-facing sign")

	player.queue_free()

func _test_player_idle_and_thrust_visual_states() -> void:
	var player := PlayerScene.instantiate()
	root.add_child(player)
	var idle_bubble: Polygon2D = player.get_node("VisualRoot/IdleBubble")
	var thrust_flare: Polygon2D = player.get_node("VisualRoot/ThrustFlare")
	var bubble_trail: Polygon2D = player.get_node("VisualRoot/BubbleTrail")
	var focal_halo: Polygon2D = player.get_node("VisualRoot/FocalHalo")
	var nose_light: Polygon2D = player.get_node("VisualRoot/NoseLight")
	var swim_sprite: Sprite2D = player.get_node("VisualRoot/SubSpriteAnchor/SubSprite")

	player.call("_sync_movement_visuals", 0.1, false)
	_expect(player.scale == Vector2.ONE, "visual motion state should not modify the physics/player root")
	_expect(focal_halo.visible and focal_halo.z_index < 0, "idle state should keep a subtle player focal halo behind the diver")
	_expect(nose_light.visible and nose_light.z_index < 0, "idle state should keep the nose light behind interaction glows")
	var idle_nose_alpha := nose_light.color.a
	var idle_halo_alpha := focal_halo.color.a
	_expect(idle_nose_alpha <= 0.23, "idle nose light should stay subtle and not wash out cargo glows")
	_expect(idle_halo_alpha <= 0.13, "idle player halo should stay quieter than active interaction glows")
	_expect(idle_bubble.visible, "idle state should show the idle bubble treatment")
	_expect(not thrust_flare.visible, "idle state should hide the thrust flare")
	_expect(bubble_trail.color.a < 0.3, "idle state should keep the bubble trail subtle")
	_expect(swim_sprite.region_rect.position.x == 0.0, "idle state should return the diver sheet to the stable first frame")

	player.call("_set_facing_sign", -1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.scale == Vector2.ONE, "moving visual state should keep the physics/player root unmirrored")
	_expect(player.get_node("VisualRoot").scale.x == -1.0, "moving visual state should work while facing left")
	_expect(not idle_bubble.visible, "moving state should hide the idle bubble treatment")
	_expect(thrust_flare.visible, "moving state should show the thrust flare")
	_expect(nose_light.color.a > idle_nose_alpha, "moving state should strengthen the forward focal light")
	_expect(focal_halo.color.a >= idle_halo_alpha, "moving state should preserve the local focal halo")
	_expect(nose_light.polygon[2].x > 120.0, "nose light should project ahead of the diver rather than become a small marker")
	_expect(bubble_trail.color.a > 0.4, "moving state should strengthen the bubble trail")
	_expect(swim_sprite.region_rect.position.x > 0.0, "moving state should advance the diver swim-sheet frame")

	player.call("_set_facing_sign", 1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.get_node("VisualRoot").scale.x == 1.0, "moving visual state should work while facing right")
	_expect(thrust_flare.visible, "right-facing movement should keep thrust flare visible")
	_expect(swim_sprite.region_rect.size == Vector2(362.0, 724.0), "right-facing movement should preserve the swim-sheet frame size")

	player.queue_free()

func _test_predator_decoy_pulse_helper() -> void:
	var predator := PredatorScript.new()
	predator.global_position = Vector2(100.0, 0.0)
	predator.patrol_start = Vector2.ZERO
	predator.patrol_end = Vector2(200.0, 0.0)

	predator.trigger_decoy_from(Vector2.ZERO, 2.5, 260.0)
	_expect(predator.is_decoy_active(), "decoy pulse should mark predator as distracted")
	_expect(is_equal_approx(predator.decoy_time_remaining(), 2.5), "decoy pulse should preserve configured duration")
	_expect(predator.decoy_target().x > predator.global_position.x, "decoy target should pull predator away from player")
	_expect(predator.decoy_target().distance_to(predator.global_position) > 200.0, "decoy target should create a meaningful route-timing window")
	predator.free()

func _test_decoy_pulse_feedback_text() -> void:
	var main := MainScript.new()
	_expect(main._format_decoy_pulse_prompt() == "", "decoy prompt should stay hidden before Gulper Eel discovery")
	_expect(main._format_decoy_pulse_scan_feedback().contains("unavailable"), "decoy scan feedback should explain unavailable state")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	_expect(main._format_decoy_pulse_prompt().contains("locked"), "decoy prompt should show upgrade-locked state after discovery")

	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	_expect(main._format_decoy_pulse_prompt().contains("ready"), "decoy prompt should show ready state when owned and unused")
	main.decoy_pulse_activated_this_scan = true
	_expect(main._format_decoy_pulse_scan_feedback().contains("spent"), "decoy scan feedback should report use")
	_expect(main._format_decoy_pulse_scan_feedback().contains("3s"), "decoy scan feedback should report duration")

	main.decoy_pulse_activated_this_scan = false
	main.decoy_pulse_used_this_run = true
	_expect(main._format_decoy_pulse_prompt().contains("spent"), "decoy prompt should show spent state")
	_expect(main._format_decoy_pulse_scan_feedback().contains("already spent"), "decoy scan feedback should explain repeat denial")
	main.free()

func _make_spawn_point(spawn_id: String, category: String, target_id: String, depth_band: String, cluster_pattern: String, position: Vector2, preferred_condition_id := "") -> SpawnPoint:
	var point := SpawnPointScript.new()
	point.spawn_id = spawn_id
	point.category = category
	point.target_id = target_id
	point.depth_band = depth_band
	point.cluster_pattern = cluster_pattern
	point.preferred_condition_id = preferred_condition_id
	point.global_position = position
	return point

func _make_scan_target(discovery_id: String, display_name: String, position: Vector2) -> DummyScanTarget:
	var target := DummyScanTarget.new()
	target.discovery_id = discovery_id
	target.display_name = display_name
	target.description = "%s description" % display_name
	target.global_position = position
	return target

func _expect(condition: bool, message: String) -> void:
	if condition:
		_passes += 1
		return

	_failures.append(message)

func _expect_lines_within(text: String, max_length: int, context: String) -> void:
	for line in text.split("\n", false):
		_expect(line.length() <= max_length, "%s line should stay within %d characters: %s" % [context, max_length, line])

func _expect_no_echo_lens_locator_language(text: String, context: String) -> void:
	var lowered := text.to_lower()
	for blocked in [
		"coordinate",
		"coords",
		"map",
		"marker",
		"objective",
		"quest",
		"checklist",
		"field guide",
		"field-guide",
		"exact",
		"locator",
		"gps",
	]:
		_expect(not lowered.contains(blocked), "%s should not introduce %s language" % [context, blocked])

func _expect_no_monster_combat_language(text: String, context: String) -> void:
	var lowered := text.to_lower()
	for blocked in [
		"weapon",
		"harpoon",
		"damage",
		"stun",
		"kill",
		"killed",
		"loot",
		"harvest",
		"capture",
		"cage",
		"health",
		"bounty",
		"monster part",
		"victory",
	]:
		_expect(not lowered.contains(blocked), "%s should not introduce %s language" % [context, blocked])
