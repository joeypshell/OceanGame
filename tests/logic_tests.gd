extends SceneTree

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
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
const ScannableScript := preload("res://scripts/scannable.gd")
const PredatorScript := preload("res://scripts/predator.gd")
const OxygenTankUpgrade := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PressureSealUpgrade := preload("res://resources/upgrades/pressure_seal_1.tres")
const SignalLensUpgrade := preload("res://resources/upgrades/signal_lens_1.tres")
const EchoLensUpgrade := preload("res://resources/upgrades/echo_lens_1.tres")
const ResonanceKeyUpgrade := preload("res://resources/upgrades/resonance_key_1.tres")
const CargoRackUpgrade := preload("res://resources/upgrades/cargo_rack_1.tres")
const PredatorWarningUpgrade := preload("res://resources/upgrades/predator_warning_1.tres")
const DecoyPulseUpgrade := preload("res://resources/upgrades/decoy_pulse_1.tres")

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
	_run("upgrade affordability", _test_upgrade_affordability)
	_run("progression reset", _test_progression_reset)
	_run("save/load behavior", _test_save_load_behavior)
	_run("deterministic seed generation", _test_deterministic_seed_generation)
	_run("expedition condition selection", _test_expedition_condition_selection)
	_run("spawn-point matching", _test_spawn_point_matching)
	_run("spawn selection", _test_spawn_selection)
	_run("condition-weighted spawn selection", _test_condition_weighted_spawn_selection)
	_run("Lantern Ray route variation", _test_lantern_ray_route_variation)
	_run("debug review seed and condition helpers", _test_debug_review_helpers)
	_run("debug Wreck Echo visual staging", _test_debug_wreck_echo_visual_staging)
	_run("scanner target resolver", _test_scanner_target_resolver)
	_run("compact scan marker", _test_compact_scan_marker)
	_run("Lantern Ray scan behavior", _test_lantern_ray_scan_behavior)
	_run("Hollow Reef passive creature scan behavior", _test_hollow_reef_passive_creature_scan_behavior)
	_run("Glassfin Swarm scan behavior", _test_glassfin_swarm_scan_behavior)
	_run("Glassfin Swarm spacing cue visual only", _test_glassfin_swarm_spacing_cue_visual_only)
	_run("Lantern Ray timing lane is visual only", _test_lantern_ray_timing_lane_is_visual_only)
	_run("scan pulse visual helper", _test_scan_pulse_visual_helper)
	_run("sprite-ready scene asset slots", _test_sprite_ready_scene_asset_slots)
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
	_run("route choice result callout", _test_route_choice_result_callout)
	_run("gulper research result callout", _test_gulper_research_result_callout)
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
	_run("upgrade bay readability states", _test_upgrade_bay_readability_states)
	_run("result and upgrade copy length guards", _test_result_and_upgrade_copy_length_guards)
	_run("recent expedition log", _test_recent_expedition_log)
	_run("thermal vent scan clue text", _test_thermal_vent_scan_clue_text)
	_run("shell reef scan clue text", _test_shell_reef_scan_clue_text)
	_run("wreck signal cache repeat scan hint", _test_wreck_signal_cache_repeat_scan_hint)
	_run("pressure lock guidance text", _test_pressure_lock_guidance_text)
	_run("surface summary tabs", _test_surface_summary_tabs)
	_run("keyboard action prompt labels", _test_keyboard_action_prompt_labels)
	_run("prompt formatter guard coverage", _test_prompt_formatter_guard_coverage)
	_run("condition briefing copy", _test_condition_briefing_copy)
	_run("Dusk Trench low-visibility condition nudge", _test_dusk_trench_low_visibility_condition_nudge)
	_run("Wide Reef Chamber calm-current condition nudge", _test_wide_chamber_calm_current_condition_nudge)
	_run("compact dive hud helpers", _test_compact_dive_hud_helpers)
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
	var first_scan_status: String = main.call("_compact_dive_status", "Scanned %s.%s" % [
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
	var repeat_scan_status: String = main.call("_compact_dive_status", "%s known.%s" % [
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
	var first_scan_status: String = main.call("_compact_dive_status", "Scanned %s.%s" % [
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
	var repeat_scan_status: String = main.call("_compact_dive_status", "%s known.%s" % [
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
	var first_scan_status: String = main.call("_compact_dive_status", "Scanned %s.%s" % [
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
	var repeat_scan_status: String = main.call("_compact_dive_status", "%s known.%s" % [
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
	_expect(hollow_reef_return.color.a >= 0.18 and hollow_reef_return.color.a <= 0.24, "Hollow Reef return current should be readable without becoming checklist guidance")
	_expect(hollow_reef_return.polygon[1].x < hollow_reef_return.polygon[0].x, "Hollow Reef return current should point left back toward Dusk Trench")
	_expect(hollow_reef_return.polygon[1].y < hollow_reef_return.polygon[0].y, "Hollow Reef return current should point upward toward Blackwater and Silt Vein")
	_expect(hollow_reef_exit_ribbon.color.g > hollow_reef_exit_ribbon.color.r, "Hollow Reef exit ribbon should use safe-return color language")
	_expect(hollow_reef_exit_ribbon.color.a <= hollow_reef_return.color.a, "Hollow Reef exit ribbon should support the return current without becoming a second objective arrow")
	_expect(hollow_reef_exit_ribbon.polygon[1].x < hollow_reef_exit_ribbon.polygon[0].x, "Hollow Reef exit ribbon should point back left toward the entrance")
	_expect(hollow_reef_return_chain.color.g > hollow_reef_return_chain.color.r and hollow_reef_return_chain.color.b > hollow_reef_return_chain.color.r, "Hollow Reef return chain should use safe-current color language")
	_expect(hollow_reef_return_chain.color.a >= 0.18 and hollow_reef_return_chain.color.a <= 0.22, "Hollow Reef return chain should stay readable without becoming a route graph")
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
	_expect(hollow_lane_upper.color.a <= 0.45 and hollow_lane_lower.color.a <= 0.52, "Hollow Reef lane shelves should frame the path without becoming walls")
	_expect(hollow_lane_direction.color.g > hollow_lane_direction.color.r, "Hollow Reef interior direction rib should use safe/cave route color language")
	_expect(hollow_lane_return.color.a >= 0.18 and hollow_lane_return.color.a <= 0.2, "Hollow Reef lane return current should be readable but not objective-bright")
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
	_expect(hollow_wide_upper.color.a >= 0.4 and hollow_wide_lower.color.a >= 0.5, "Wide Reef Chamber should frame the top and bottom shelves around the playable gap")
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
	_expect(hollow_wide_return_far.color.a <= 0.2 and hollow_wide_return_mid.color.a <= 0.16 and hollow_wide_return_entry.color.a <= 0.18, "Wide Reef Chamber return chain should stay broad and not objective-bright")
	_expect(hollow_wide_return_far.polygon[1].x < hollow_wide_return_far.polygon[0].x, "Wide Reef Chamber far return rib should point left from the far chamber")
	_expect(hollow_wide_return_mid.polygon[1].x < hollow_wide_return_mid.polygon[0].x, "Wide Reef Chamber mid return chain should point left through the chamber")
	_expect(hollow_wide_return_entry.polygon[1].x < hollow_wide_return_entry.polygon[0].x, "Wide Reef Chamber entry return chain should point left toward Hollow Reef")
	_expect(hollow_wide_return_mid.polygon[1].y < hollow_wide_foreground.polygon[0].y, "Wide Reef Chamber mid return chain should stay above the low foreground shelf")
	_expect(hollow_wide_future_choice.color.a <= 0.4, "Wide Reef Chamber future-choice shadow should stay a quiet staging cue")
	_expect(hollow_wide_chamber.get_node_or_null("InteractZone") == null, "Wide Reef Chamber should not add an interaction hotspot yet")
	_expect(hollow_wide_chamber.get_node_or_null("ResourcePickup") == null, "Wide Reef Chamber should not add cargo or loot yet")
	_expect(hollow_wide_chamber.get_node_or_null("Predator") == null, "Wide Reef Chamber should not add combat or monster pressure yet")
	_expect(hollow_wide_chamber.get_node_or_null("PressureBoundary") == null, "Wide Reef Chamber should not add pressure gating yet")
	_expect(hollow_wide_chamber.find_child("CollisionShape2D", true, false) == null, "Wide Reef Chamber should remain movement-readable visual staging")
	_expect(hollow_wide_chamber.get_script() == null, "Wide Reef Chamber should remain authored scene presentation for this pass")
	_expect(hollow_wide_glass_rib_span.get_node_or_null("InteractZone") == null, "Glass Rib Span should not add an interaction hotspot")
	_expect(hollow_wide_low_crown_shelf.get_node_or_null("InteractZone") == null, "Low Crown Shelf should not add an interaction hotspot")
	_expect(hollow_deeper_promise.position.x > hollow_reef_reading_core.position.x, "Hollow Reef deeper promise should sit beyond the current cave reading payoff")
	_expect(hollow_deeper_promise.position.y > hollow_reef_reading_core.position.y, "Hollow Reef deeper promise should imply lower future route growth")
	_expect(hollow_deeper_mouth.color.a >= 0.62, "Hollow Reef deeper promise mouth should read as an intentional closed opening")
	_expect(hollow_deeper_wash.color.a <= 0.18, "Hollow Reef deeper promise wash should stay atmospheric, not a damage field")
	_expect(hollow_deeper_seal.color.a >= 0.28, "Hollow Reef deeper promise should have a readable seal lip")
	_expect(hollow_deeper_glint.color.a >= 0.4, "Hollow Reef deeper promise should include a small curiosity glint")
	_expect(hollow_deeper_label.text == "DEEP REEF CLOSED", "Hollow Reef deeper promise should clearly say the route is closed")
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
	_expect(blue_chimney_glow_candidate.position.distance_to(blue_chimney_pocket.position) <= 72.0, "Blue Chimney material candidate should sit near the lower pocket")
	_expect(hollow_reef_glow_candidate.target_id == "glow_plankton", "Hollow Reef sheltered pocket should use existing Glow Plankton")
	_expect(hollow_reef_glow_candidate.depth_band == "deep", "Hollow Reef material candidate should preserve deep resource identity")
	_expect(hollow_reef_glow_candidate.cluster_pattern == "deep_reward", "Hollow Reef material candidate should stay optional in the deep-reward resource pool")
	_expect(hollow_reef_glow_candidate.position.distance_to(hollow_resource_pocket.global_position) <= 48.0, "Hollow Reef material candidate should sit inside the sheltered pocket")
	_expect(main.get_node_or_null("ResourcePickups/BlueChimneyGlowPlankton") == null, "Blue Chimney candidate should not add an extra active resource pickup")
	_expect(main.get_node_or_null("ResourcePickups/HollowReefGlowPlankton") == null, "Hollow Reef candidate should not add an extra active resource pickup")

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
	_expect(PredatorWarningUpgrade.required_discovery == "gulper_eel", "Predator Warning I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_discovery == "gulper_eel", "Decoy Pulse I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_upgrade == PredatorWarningUpgrade.id, "Decoy Pulse I should require Predator Warning I")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Decoy Pulse I should cost two glow plankton")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Decoy Pulse I should cost one kelp fiber")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Decoy Pulse I should cost one shell fragment")
	_expect(UpgradePurchaseScript.missing_discovery(progression, OxygenTankUpgrade) == "", "upgrade with no prerequisite should not be locked")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "thermal_vent", "Pressure Seal I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "wreck_signal_cache", "Signal Lens I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "wreck_signal_cache", "Echo Lens I discovery prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == SignalLensUpgrade.id, "Echo Lens I upgrade prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, ResonanceKeyUpgrade) == "east_shelf_route_research", "Resonance Key I route-research prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, ResonanceKeyUpgrade) == EchoLensUpgrade.id, "Resonance Key I Echo Lens prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, CargoRackUpgrade) == "", "Cargo Rack I prerequisite should be satisfied by default")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "gulper_eel", "Predator Warning I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == PredatorWarningUpgrade.id, "Decoy Pulse I upgrade prerequisite should start missing")
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
	]
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
	var save_after_recent_goal: Dictionary = blackwater_ready_progression.to_save_data()
	_expect(save_after_recent_goal == save_before_recent_goal, "ready route suggestions should not mutate save data")
	_expect(not save_after_recent_goal.has("recent_route_memory"), "ready route suggestions should not add route memory to the save schema")
	_expect(not save_after_recent_goal.has("ready_goal"), "ready route suggestions should not add goal state to the save schema")

	var incomplete_progression := ProgressionStateScript.new()
	var incomplete_goal := ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "rare_signal")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Rare Signal route goal should not override upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Blackwater")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "recent route memory should not override incomplete upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Hollow Reef")
	_expect(incomplete_goal.contains("Oxygen Tank I"), "Hollow Reef chamber memory should not override incomplete upgrade progression goals")
	_expect(not incomplete_goal.contains("wide chamber"), "wide chamber ready goal should wait until prep goals are complete")

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
	_expect(main._format_extraction_banking_line(1, cargo).contains("Banked 1 resource"), "cargo extraction should keep resource banking copy")
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
	_expect(prompt.contains("ocean shifts again"), "result prompt should frame restart as a changed ocean")
	_expect(not prompt.to_lower().contains("restart"), "result prompt should avoid raw restart language")

	main.progression_state.current_run_number = 4
	var ready_status := main._format_expedition_ready_status()
	_expect(ready_status.contains("Expedition 4 ready"), "ready status should name the prepared expedition")
	_expect(ready_status.contains("ocean changed"), "ready status should describe the changed ocean")
	_expect(main._format_expedition_day_title("Ready") == "Expedition Day 4 Ready", "ready title should show expedition day number")
	_expect(main._format_expedition_day_title("Result: Extraction") == "Expedition Day 4 Result: Extraction", "result title should show completed expedition day number")
	_expect(main._format_completed_expedition_line("Failure") == "Expedition Day 4: Failure.", "result summary should name the completed expedition day")
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
	main.run_hollow_reef_reading_recovered = false
	main.run_reached_dusk_trench = false

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
	_expect(prompt.contains("record cave reading"), "Hollow Reef prompt should explain the concrete payoff")

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
	var feedback := main._format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.")
	_expect(feedback == "Banked 3 resource(s).\nNo upgrade ready yet.", "upgrade panel feedback should compact deposit copy")
	_expect_lines_within(feedback, 72, "compacted upgrade feedback")
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
	_expect(not ready_summary.contains("F9"), "ready panel should hide prototype reset copy when debug telemetry is off")
	main.show_debug_telemetry = true
	_expect(main._format_ready_panel_summary().contains("F9 resets prototype save"), "ready panel may expose reset copy when debug telemetry is on")
	main.show_debug_telemetry = false

	_expect(not main._surface_tabs_enabled(), "surface tabs should be hidden before extraction")
	main.dive_session.extract()
	_expect(main._surface_tabs_enabled(), "surface tabs should be available after extraction")
	_expect(main._format_surface_tabs() == "[Result]  Upgrades  Log", "surface tabs should mark the result view by default")
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	_expect(main._format_surface_tabs() == "Result  [Upgrades]  Log", "surface tabs should mark the upgrade view")
	_expect(main._format_upgrade_menu_title(1, 7) == "Upgrade Bay (1/7) - Up/Down select", "upgrade bay title should keep selection controls visible")
	main.surface_tab_index = main.SURFACE_TAB_LOG
	_expect(main._format_surface_tabs() == "Result  Upgrades  [Log]", "surface tabs should mark the log view")
	main.free()

func _test_keyboard_action_prompt_labels() -> void:
	var main := MainScript.new()
	_expect(main._action_label("interact") == "E/Enter", "interact prompt label should match the current keyboard binding")
	_expect(main._action_label("restart_dive") == "R", "restart prompt label should match the current keyboard binding")
	_expect(main._action_label("move_left_right") == "Left/Right", "tab cycling prompt label should match the current keyboard binding")
	_expect(main._action_label("move_up_down") == "Up/Down", "selection prompt label should match the current keyboard binding")
	_expect(main._action_label("burst_thruster") == "Space", "burst prompt label should match the current keyboard binding")
	_expect(main._action_label("decoy_pulse") == "F", "decoy prompt label should match the current keyboard binding")
	_expect(main._action_label("future_action") == "future_action", "unknown prompt labels should fall back to their action id")
	main.free()

func _test_prompt_formatter_guard_coverage() -> void:
	var main := MainScript.new()
	var interact_label: String = main._action_label("interact")
	var interact_words := interact_label.replace("/", " or ")
	var restart_label: String = main._action_label("restart_dive")
	var horizontal_label: String = main._action_label("move_left_right")
	var vertical_label: String = main._action_label("move_up_down")
	var burst_label: String = main._action_label("burst_thruster")
	var decoy_label: String = main._action_label("decoy_pulse")

	_expect(main._format_ready_panel_summary().contains("%s begins." % interact_label), "ready summary should derive its start label from the prompt helper")
	_expect(main._format_upgrade_menu_title(2, 7).contains("%s select" % vertical_label), "upgrade title should derive selection labels from the prompt helper")
	_expect(main._format_next_expedition_prompt().contains("press %s" % restart_label), "next expedition prompt should derive restart labels from the prompt helper")
	_expect(main._format_burst_thruster_prompt().begins_with("%s: burst" % burst_label), "burst prompt should derive its label from the prompt helper")
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

func _test_condition_briefing_copy() -> void:
	var main := MainScript.new()
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
		"tags": ["thermal", "scan"],
	}

	var briefing := main._format_condition_briefing()
	_expect(briefing.contains("Today: Thermal Bloom."), "condition briefing should frame the day condition as today's ocean change")
	_expect(briefing.contains("Vent-warmed routes may point toward extra glow."), "thermal briefing should name the implemented vent/glow route cue")
	_expect(not briefing.contains("thermal_bloom"), "condition briefing should not expose raw condition ids")
	_expect(not briefing.to_lower().contains("procedural"), "condition briefing should not imply unimplemented generation systems")

	main.current_expedition_condition = {
		"id": "predator_migration",
		"display_name": "Predator Migration",
		"briefing": "Deep patrols are shifting.",
		"tags": ["predator", "route"],
	}
	briefing = main._format_condition_briefing()
	_expect(briefing.contains("Gulper route"), "predator briefing should point to the existing predator route")
	_expect(briefing.contains("warning cues"), "predator briefing should point to existing readable cues")

	main.current_expedition_condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	}
	briefing = main._format_condition_briefing()
	_expect(briefing.to_lower().contains("lower-trench"), "low-visibility briefing should nudge broad lower-trench route caution")
	_expect(briefing.contains("bank early"), "low-visibility briefing should keep the player-visible advice compact")
	_expect(not briefing.contains("Dusk Trench"), "low-visibility briefing should not reveal the exact trench location")
	_expect(not briefing.contains("Blackwater"), "low-visibility briefing should not reveal the gated route chain")
	_expect_no_echo_lens_locator_language(briefing, "low-visibility briefing")

	main.current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["scan", "rare"],
	}
	briefing = main._format_condition_briefing()
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
	briefing = main._format_condition_briefing()
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
	_expect(calm_main_alpha > 0.2, "Calm Current should subtly strengthen the Wide Reef Chamber main return current")
	_expect(calm_far_alpha > 0.2, "Calm Current should strengthen the far chamber return rib")
	_expect(calm_mid_alpha > 0.16, "Calm Current should strengthen the mid chamber return chain")
	_expect(calm_entry_alpha > 0.18, "Calm Current should strengthen the entry return chain")
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

func _test_compact_dive_hud_helpers() -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["glow_plankton", "kelp_fiber", "glow_plankton"]
	var inline_cargo: String = main.call("_format_cargo_counts_inline", cargo)
	_expect(inline_cargo == " - Glow x2, Kelp x1", "active cargo helper should keep carried resources on one line")

	var slot_states: Array = main.call("_cargo_slot_states", cargo, 3, 4)
	_expect(slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "hidden"], "cargo slots should hide excess capacity before Cargo Rack I")
	var upgraded_slot_states: Array = main.call("_cargo_slot_states", cargo, 4, 4)
	_expect(upgraded_slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "empty"], "cargo slots should reveal the fourth slot after capacity upgrade")
	_expect(main.call("_cargo_slot_color", "empty").a > main.call("_cargo_slot_color", "hidden").a, "empty cargo slots should read brighter than unavailable slots")
	_expect(main.call("_cargo_slot_color", "hidden").a == 0.0, "hidden cargo slot color should stay transparent")
	_expect(main.call("_cargo_slot_icon_polygon", "kelp_fiber").size() > 0, "kelp cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "shell_fragments").size() > 0, "shell cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "glow_plankton").size() > 0, "glow cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "empty").is_empty(), "empty cargo slots should not show a resource mini-icon")
	_expect(main.call("_cargo_slot_icon_color", "hidden").a == 0.0, "hidden cargo slot icon color should stay transparent")

	var compact_discoveries: String = main.call("_format_discoveries", true)
	_expect(compact_discoveries == "Discoveries: 0", "compact discovery helper should show only the count")

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var discoveries_label: Label = main_scene.get_node("HUD/Discoveries")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var status_label: Label = main_scene.get_node("HUD/Status")
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
	main_scene.call("_update_cargo_slots")
	_expect(discoveries_label.offset_top >= active_panel.offset_top, "active Discoveries label should stay inside the compact stats panel")
	_expect(discoveries_label.offset_bottom <= active_panel.offset_bottom, "active Discoveries label should not spill below the compact stats panel")
	_expect(dive_info_panel.offset_top > active_panel.offset_bottom, "dive info panel should remain below compact stats content")
	_expect(scan_target_label.offset_top >= dive_info_panel.offset_top, "scan target should stay inside the dive info panel")
	_expect(status_label.offset_bottom <= dive_info_panel.offset_bottom, "status text should stay inside the dive info panel")
	_expect(prompt_label.offset_bottom <= status_label.offset_top, "prompt and status should not overlap")
	_expect(not cargo_slot_4.visible, "fourth cargo slot should stay hidden before Cargo Rack I")
	main_scene.dive_session.cargo_limit = 4
	main_scene.call("_update_cargo_slots")
	_expect(cargo_slot_4.visible, "fourth cargo slot should appear after Cargo Rack I capacity is active")
	_expect(scan_target_label.text.begins_with("Scan:"), "scan target label should use compact active HUD copy")
	_expect(not active_panel.visible, "surface-ready state should hide active stats clutter")
	_expect(not dive_info_panel.visible, "surface-ready state should hide dive guidance clutter")
	main_scene.queue_free()

	var long_status := "Scanned Thermal Vent.\nWarm current marks optional glow; bank Pressure Seal clue. Return safely before oxygen runs out."
	var compact_status: String = main.call("_compact_dive_status", long_status)
	_expect(not compact_status.contains("\n"), "compact dive status should remove line breaks")
	_expect(compact_status.length() <= 76, "compact dive status should stay within the dive HUD limit")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	var combined_prompt := "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 72, "combined Burst and Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Space: burst"), "combined active prompt should keep the Space command visible")
	_expect(combined_prompt.contains("F: decoy ready"), "combined active prompt should keep the Decoy command compact")
	_expect(not combined_prompt.contains("Playtest data:"), "combined active prompt should not expose debug telemetry")

	main.decoy_pulse_used_this_run = true
	combined_prompt = "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 68, "spent Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Decoy spent"), "spent Decoy active prompt should stay compact and explicit")

	_expect(main.call("_oxygen_state", 30.0, 40.0) == "normal", "oxygen helper should treat safe oxygen as normal")
	_expect(main.call("_oxygen_state", 10.0, 40.0) == "low", "oxygen helper should mark 25 percent oxygen as low")
	_expect(main.call("_oxygen_state", 4.0, 40.0) == "critical", "oxygen helper should mark 10 percent oxygen as critical")
	_expect(main.call("_format_oxygen_label", 10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	_expect(main.call("_format_oxygen_label", 40.0, 40.0).begins_with("O2:"), "oxygen label should use compact active HUD copy")
	_expect(main.call("_oxygen_warning_text", "critical").contains("RETURN TO BASE"), "critical warning should emphasize the return route")
	main.free()

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
	var oxygen_label: Label = main_scene.get_node("HUD/Oxygen")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var run_panel: Panel = main_scene.get_node("HUD/RunPanel")

	_expect(not active_panel.visible, "raw scene should start with the active stats panel hidden")
	_expect(not dive_info_panel.visible, "raw scene should start with the dive info panel hidden")
	_expect(run_panel.visible, "raw scene should keep the surface panel visible")
	_expect(oxygen_label.text.begins_with("O2:"), "active dive should use compact oxygen label")
	_expect(scan_target_label.text.begins_with("Scan:"), "active dive should use compact scan label")
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
	_expect(player.world_bounds.end.x <= 3860.0, "expanded bounds should stay tight around the first wider Hollow Reef chamber")
	_expect(player.world_bounds.end.y >= 2500.0, "expanded bounds should allow the first Silt Vein Fork scaffold below Blue Chimney")
	_expect(player.world_bounds.end.y >= 2700.0, "expanded bounds should allow the short Blackwater Sill route")
	_expect(player.world_bounds.end.y >= 3040.0, "expanded bounds should allow the first Dusk Trench continuation below Blackwater")
	_expect(player.world_bounds.end.y >= 3160.0, "expanded bounds should allow the first wider Hollow Reef chamber")
	_expect(player.world_bounds.end.y <= 3220.0, "expanded bounds should avoid implying a full lower biome")

	var clamped_high := player.clamp_position_to_world_bounds(Vector2(640.0, 0.0))
	_expect(clamped_high.y >= player.world_bounds.position.y, "world clamp should prevent surfacing through the boat sprite")

	var clamped_right := player.clamp_position_to_world_bounds(Vector2(3900.0, 900.0))
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

	var clamped_left := player.clamp_position_to_world_bounds(Vector2(-80.0, 900.0))
	_expect(is_equal_approx(clamped_left.x, player.world_bounds.position.x), "world clamp should preserve the left edge of the main column")
	player.free()

	var main_scene := MainScene.instantiate()
	var camera := main_scene.get_node("Player/Camera2D") as Camera2D
	_expect(camera.limit_right >= 3900, "camera limit should include the first wider Hollow Reef chamber")
	_expect(camera.limit_bottom >= 3260, "camera limit should include the lower edge of the first wider Hollow Reef chamber")
	_expect(camera.limit_right <= 3940, "camera limit should stay tight around the first wider Hollow Reef chamber")
	_expect(camera.limit_bottom <= 3300, "camera limit should avoid implying a full lower biome")
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
	_expect(dusk_direction.contains("Blackwater/Silt/Blue"), "base direction should compactly name the Dusk return landmark chain")

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
	_expect(dusk_trench_direction.contains("Blackwater/Silt/Blue"), "Dusk Trench orientation should keep compact named return memory")
	_expect_no_echo_lens_locator_language(dusk_trench_direction, "Dusk Trench base direction")

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
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_glass_kelp_ledge = true
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
	_expect(not main.player_near_resonance_alcove, "restart should clear Resonance Alcove proximity state")
	_expect(not main.player_near_blue_chimney, "restart should clear Blue Chimney proximity state")
	_expect(not main.player_near_lantern_silt_nook, "restart should clear Lantern Silt proximity state")
	_expect(not main.player_near_glass_kelp_ledge, "restart should clear Glass Kelp proximity state")
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
	_expect(player_bounds.world_bounds.end.y <= 3220.0, "lower connector bounds should stay tight around the first Hollow Reef wide-chamber pass")
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
	_expect(is_equal_approx(main.blue_chimney_draft_timer, 0.0), "run telemetry reset should clear Blue Chimney visual timing state")
	_expect(is_equal_approx(main.blackwater_pressure_timer, 0.0), "run telemetry reset should clear Blackwater pressure-cue timing state")
	_expect(main.visual_smoke_route_stage == "", "run telemetry reset should clear lower-connector visual route stage")

	main.player_near_lower_connector_echo = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_blackwater_crack = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.call("_prepare_next_run")
	_expect(not main.player_near_lower_connector_echo, "new expeditions should clear Drop Echo proximity state")
	_expect(not main.player_near_resonance_alcove, "new expeditions should clear Resonance Alcove proximity state")
	_expect(not main.player_near_blue_chimney, "new expeditions should clear Blue Chimney proximity state")
	_expect(not main.player_near_lantern_silt_nook, "new expeditions should clear Lantern Silt proximity state")
	_expect(not main.player_near_blackwater_crack, "new expeditions should clear Blackwater Crack proximity state")
	_expect(not main.run_lower_connector_echo_recovered, "new expeditions should not carry Drop Echo research state")
	_expect(not main.run_resonance_alcove_research_recovered, "new expeditions should not carry Resonance Alcove research state")
	_expect(not main.run_blue_chimney_draft_reading_recovered, "new expeditions should not carry Blue Chimney draft research state")
	_expect(not main.run_lantern_silt_sample_recovered, "new expeditions should not carry Lantern Silt sample state")
	_expect(not main.run_blackwater_trace_recovered, "new expeditions should not carry Blackwater Trace state")
	_expect(not main.run_reached_dusk_trench, "new expeditions should not carry Dusk Trench reach memory")
	_expect(not main.run_glass_kelp_reading_recovered, "new expeditions should not carry Glass Kelp reading state")
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

	player.call("_sync_movement_visuals", 0.1, false)
	_expect(player.scale == Vector2.ONE, "visual motion state should not modify the physics/player root")
	_expect(idle_bubble.visible, "idle state should show the idle bubble treatment")
	_expect(not thrust_flare.visible, "idle state should hide the thrust flare")
	_expect(bubble_trail.color.a < 0.3, "idle state should keep the bubble trail subtle")

	player.call("_set_facing_sign", -1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.scale == Vector2.ONE, "moving visual state should keep the physics/player root unmirrored")
	_expect(player.get_node("VisualRoot").scale.x == -1.0, "moving visual state should work while facing left")
	_expect(not idle_bubble.visible, "moving state should hide the idle bubble treatment")
	_expect(thrust_flare.visible, "moving state should show the thrust flare")
	_expect(bubble_trail.color.a > 0.4, "moving state should strengthen the bubble trail")

	player.call("_set_facing_sign", 1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.get_node("VisualRoot").scale.x == 1.0, "moving visual state should work while facing right")
	_expect(thrust_flare.visible, "right-facing movement should keep thrust flare visible")

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
