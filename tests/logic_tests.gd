extends SceneTree

const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const SUITE_COUNT := 40

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
	var suites := []
	for suite_index in range(1, SUITE_COUNT + 1):
		suites.append(load("res://tests/logic_test_suite_%02d.gd" % suite_index).new())
	_run("cargo limit", Callable(suites[0], "_test_cargo_limit").bind(self))
	_run("upgraded cargo limit", Callable(suites[0], "_test_upgraded_cargo_limit").bind(self))
	_run("extraction requirements", Callable(suites[0], "_test_extraction_requirements").bind(self))
	_run("oxygen failure", Callable(suites[0], "_test_oxygen_failure").bind(self))
	_run("health feedback presenter", Callable(suites[0], "_test_health_feedback_presenter").bind(self))
	_run("health damage and vent failure", Callable(suites[0], "_test_health_damage_and_vent_failure").bind(self))
	_run("health damage night resolution copy", Callable(suites[0], "_test_health_damage_night_resolution_copy").bind(self))
	_run("surface oxygen refill isolation", Callable(suites[0], "_test_surface_oxygen_refill_isolation").bind(self))
	_run("surface status presenter", Callable(suites[0], "_test_surface_status_presenter").bind(self))
	_run("ship offload repeat daylight sortie", Callable(suites[0], "_test_ship_offload_repeat_daylight_sortie").bind(self))
	_run("night phase end day and upgrade choice", Callable(suites[1], "_test_night_phase_end_day_and_upgrade_choice").bind(self))
	_run("night build presenter", Callable(suites[1], "_test_night_build_presenter").bind(self))
	_run("night power patch build choice", Callable(suites[1], "_test_night_power_patch_build_choice").bind(self))
	_run("nightfall away from ship late return consequence", Callable(suites[1], "_test_nightfall_away_from_ship_late_return_consequence").bind(self))
	_run("debug unlimited oxygen", Callable(suites[1], "_test_debug_unlimited_oxygen").bind(self))
	_run("survival night consumption", Callable(suites[1], "_test_survival_night_consumption").bind(self))
	_run("survival collapse and reset", Callable(suites[1], "_test_survival_collapse_and_reset").bind(self))
	_run("survival supply banking isolation", Callable(suites[1], "_test_survival_supply_banking_isolation").bind(self))
	_run("survival supply cache presenter", Callable(suites[1], "_test_survival_supply_cache_presenter").bind(self))
	_run("survival supply cache state service", Callable(suites[1], "_test_survival_supply_cache_state_service").bind(self))
	_run("survival needs panel service", Callable(suites[2], "_test_survival_needs_panel_service").bind(self))
	_run("survival supply cache target copy", Callable(suites[2], "_test_survival_supply_cache_target_copy").bind(self))
	_run("starter survival resource families", Callable(suites[2], "_test_starter_survival_resource_families").bind(self))
	_run("resource taxonomy offload copy", Callable(suites[2], "_test_resource_taxonomy_offload_copy").bind(self))
	_run("survival oxygen penalty", Callable(suites[2], "_test_survival_oxygen_penalty").bind(self))
	_run("upgrade affordability", Callable(suites[2], "_test_upgrade_affordability").bind(self))
	_run("progression reset", Callable(suites[2], "_test_progression_reset").bind(self))
	_run("save/load behavior", Callable(suites[3], "_test_save_load_behavior").bind(self))
	_run("save service", Callable(suites[3], "_test_save_service").bind(self))
	_run("deterministic seed generation", Callable(suites[3], "_test_deterministic_seed_generation").bind(self))
	_run("expedition condition selection", Callable(suites[3], "_test_expedition_condition_selection").bind(self))
	_run("spawn-point matching", Callable(suites[3], "_test_spawn_point_matching").bind(self))
	_run("spawn selection", Callable(suites[3], "_test_spawn_selection").bind(self))
	_run("condition-weighted spawn selection", Callable(suites[3], "_test_condition_weighted_spawn_selection").bind(self))
	_run("Lantern Ray route variation", Callable(suites[4], "_test_lantern_ray_route_variation").bind(self))
	_run("debug review seed and condition helpers", Callable(suites[4], "_test_debug_review_helpers").bind(self))
	_run("debug Wreck Echo visual staging", Callable(suites[4], "_test_debug_wreck_echo_visual_staging").bind(self))
	_run("debug Wide Reef salvage staging guardrails", Callable(suites[4], "_test_debug_wide_reef_salvage_staging_guardrails").bind(self))
	_run("debug Mirror Kelp evidence staging", Callable(suites[4], "_test_debug_mirror_kelp_evidence_staging").bind(self))
	_run("debug Outer Shelf evidence staging", Callable(suites[4], "_test_debug_outer_shelf_evidence_staging").bind(self))
	_run("debug Open Hatch visual staging service", Callable(suites[4], "_test_open_hatch_visual_staging_service").bind(self))
	_run("debug Ship Offload visual staging service", Callable(suites[4], "_test_ship_offload_visual_staging_service").bind(self))
	_run("debug Surface Oxygen visual staging service", Callable(suites[4], "_test_surface_oxygen_visual_staging_service").bind(self))
	_run("debug Daylight Cargo visual staging service", Callable(suites[5], "_test_daylight_cargo_visual_staging_service").bind(self))
	_run("debug Health Damage visual staging service", Callable(suites[5], "_test_health_damage_visual_staging_service").bind(self))
	_run("debug Health Damage extraction visual staging service", Callable(suites[5], "_test_health_damage_extraction_visual_staging_service").bind(self))
	_run("debug Expanded Route visual staging service", Callable(suites[5], "_test_expanded_route_visual_staging_service").bind(self))
	_run("debug Silt Vein visual staging service", Callable(suites[5], "_test_silt_vein_visual_staging_service").bind(self))
	_run("debug Dusk Trench payoff visual staging service", Callable(suites[5], "_test_dusk_trench_payoff_visual_staging_service").bind(self))
	_run("debug Hollow Reef payoff visual staging service", Callable(suites[5], "_test_hollow_reef_payoff_visual_staging_service").bind(self))
	_run("scanner target resolver", Callable(suites[5], "_test_scanner_target_resolver").bind(self))
	_run("scan hold timing helper", Callable(suites[5], "_test_scan_hold_timing_helper").bind(self))
	_run("compact scan marker", Callable(suites[5], "_test_compact_scan_marker").bind(self))
	_run("Lantern Ray scan behavior", Callable(suites[5], "_test_lantern_ray_scan_behavior").bind(self))
	_run("Hollow Reef passive creature scan behavior", Callable(suites[6], "_test_hollow_reef_passive_creature_scan_behavior").bind(self))
	_run("Glassfin Swarm scan behavior", Callable(suites[6], "_test_glassfin_swarm_scan_behavior").bind(self))
	_run("Mirrorfin route-read behavior", Callable(suites[6], "_test_mirrorfin_route_read_behavior").bind(self))
	_run("Mirror Kelp deep promise", Callable(suites[7], "_test_mirror_kelp_deep_promise").bind(self))
	_run("Outer Shelf route footprint", Callable(suites[7], "_test_outer_shelf_route_footprint").bind(self))
	_run("Outer Shelf Glass Rim branch", Callable(suites[7], "_test_outer_shelf_glass_rim_branch").bind(self))
	_run("Outer Shelf slackwater timing cue visual only", Callable(suites[7], "_test_outer_shelf_slackwater_timing_cue_visual_only").bind(self))
	_run("Outer Shelf cargo knowledge payoff choice", Callable(suites[8], "_test_outer_shelf_cargo_knowledge_payoff_choice").bind(self))
	_run("Glass Rim reading payoff choice", Callable(suites[8], "_test_glass_rim_reading_payoff_choice").bind(self))
	_run("Glass Ray Drifter passive route read", Callable(suites[8], "_test_glass_ray_drifter_passive_route_read").bind(self))
	_run("wide chamber salvage pocket entrance", Callable(suites[9], "_test_wide_chamber_salvage_pocket_entrance").bind(self))
	_run("salvage data cache interaction", Callable(suites[9], "_test_salvage_data_cache_interaction").bind(self))
	_run("Salvage Manifest interaction", Callable(suites[10], "_test_salvage_manifest_interaction").bind(self))
	_run("Salvage pocket silt timing cue visual only", Callable(suites[10], "_test_salvage_pocket_silt_timing_cue_visual_only").bind(self))
	_run("Tideglass Sample interaction", Callable(suites[10], "_test_tideglass_sample_interaction").bind(self))
	_run("Glassfin Swarm spacing cue visual only", Callable(suites[10], "_test_glassfin_swarm_spacing_cue_visual_only").bind(self))
	_run("Lantern Ray timing lane is visual only", Callable(suites[10], "_test_lantern_ray_timing_lane_is_visual_only").bind(self))
	_run("scan pulse visual helper", Callable(suites[11], "_test_scan_pulse_visual_helper").bind(self))
	_run("sprite-ready scene asset slots", Callable(suites[11], "_test_sprite_ready_scene_asset_slots").bind(self))
	_run("Area 01 first art slice scene contract", Callable(suites[16], "_test_area_01_first_art_slice_scene_contract").bind(self))
	_run("Area 01 source map contract", Callable(suites[17], "_test_area_01_source_map_contract").bind(self))
	_run("Area 01 source truth validator", Callable(suites[17], "_test_area_01_source_truth_validator").bind(self))
	_run("Area 01 source truth validator catches drift", Callable(suites[17], "_test_area_01_source_truth_validator_catches_drift").bind(self))
	_run("Area 01 visual cue contract registry", Callable(suites[17], "_test_area_01_visual_cue_contract_registry").bind(self))
	_run("Area 01 visual cue diagnostic report", Callable(suites[17], "_test_area_01_visual_cue_diagnostic_report").bind(self))
	_run("Area 01 visual director", Callable(suites[18], "_test_area_01_visual_director").bind(self))
	_run("Area 01 surface oxygen hook runtime", Callable(suites[18], "_test_area_01_surface_oxygen_hook_runtime").bind(self))
	_run("Area 01 authoritative wall builder", Callable(suites[19], "_test_area_01_authoritative_wall_builder").bind(self))
	_run("Area 01 source map debug overlay", Callable(suites[18], "_test_area_01_source_map_debug_overlay").bind(self))
	_run("Area 01 starter resource pocket placement", Callable(suites[19], "_test_area_01_starter_resource_pocket_placement").bind(self))
	_run("Area 01 cave mouth affordances", Callable(suites[19], "_test_area_01_cave_mouth_affordances").bind(self))
	_run("Area 01 reusable reef visual kit", Callable(suites[20], "_test_area_01_reusable_reef_visual_kit").bind(self))
	_run("east shelf spur branch scene contract paths", Callable(suites[12], "_test_east_shelf_spur_branch_scene_contract_paths").bind(self))
	_run("east shelf spur branch scene contract part 1", Callable(suites[13], "_test_east_shelf_spur_branch_scene_contract_part_1").bind(self))
	_run("east shelf spur branch scene contract part 2", Callable(suites[13], "_test_east_shelf_spur_branch_scene_contract_part_2").bind(self))
	_run("east shelf spur branch scene contract part 3", Callable(suites[13], "_test_east_shelf_spur_branch_scene_contract_part_3").bind(self))
	_run("east shelf spur branch scene contract part 4", Callable(suites[14], "_test_east_shelf_spur_branch_scene_contract_part_4").bind(self))
	_run("east shelf spur branch scene contract part 5", Callable(suites[14], "_test_east_shelf_spur_branch_scene_contract_part_5").bind(self))
	_run("east shelf spur branch scene contract part 6", Callable(suites[14], "_test_east_shelf_spur_branch_scene_contract_part_6").bind(self))
	_run("east shelf spur branch scene contract part 7", Callable(suites[15], "_test_east_shelf_spur_branch_scene_contract_part_7").bind(self))
	_run("east shelf spur branch scene contract part 8", Callable(suites[15], "_test_east_shelf_spur_branch_scene_contract_part_8").bind(self))
	_run("east shelf spur branch scene contract part 9", Callable(suites[15], "_test_east_shelf_spur_branch_scene_contract_part_9").bind(self))
	_run("landmark region identity metadata", Callable(suites[20], "_test_landmark_region_identity_metadata").bind(self))
	_run("predator scan target", Callable(suites[20], "_test_predator_scan_target").bind(self))
	_run("discovery prerequisites", Callable(suites[20], "_test_discovery_prerequisites").bind(self))
	_run("predator warning upgrade metadata", Callable(suites[20], "_test_predator_warning_upgrade_metadata").bind(self))
	_run("predator warning effect isolation", Callable(suites[20], "_test_predator_warning_effect_isolation").bind(self))
	_run("decoy pulse effect isolation", Callable(suites[20], "_test_decoy_pulse_effect_isolation").bind(self))
	_run("echo lens effect isolation", Callable(suites[20], "_test_echo_lens_effect_isolation").bind(self))
	_run("expedition prep goals", Callable(suites[21], "_test_expedition_prep_goals").bind(self))
	_run("result progress callouts", Callable(suites[21], "_test_result_progress_callouts").bind(self))
	_run("extraction banking result copy", Callable(suites[21], "_test_extraction_banking_result_copy").bind(self))
	_run("next expedition framing", Callable(suites[22], "_test_next_expedition_framing").bind(self))
	_run("region memory result callout", Callable(suites[22], "_test_region_memory_result_callout").bind(self))
	_run("discovery memory result callout", Callable(suites[22], "_test_discovery_memory_result_callout").bind(self))
	_run("route memory presenter", Callable(suites[22], "_test_route_memory_presenter").bind(self))
	_run("run memory state service", Callable(suites[22], "_test_run_memory_state_service").bind(self))
	_run("run telemetry reset service", Callable(suites[23], "_test_run_telemetry_reset_service").bind(self))
	_run("route choice result callout", Callable(suites[23], "_test_route_choice_result_callout").bind(self))
	_run("gulper research result callout", Callable(suites[23], "_test_gulper_research_result_callout").bind(self))
	_run("research result presenter", Callable(suites[23], "_test_research_result_presenter").bind(self))
	_run("monster research non-combat guardrails", Callable(suites[24], "_test_monster_research_non_combat_guardrails").bind(self))
	_run("echo lens result callout", Callable(suites[24], "_test_echo_lens_result_callout").bind(self))
	_run("wreck echo route first pass", Callable(suites[24], "_test_wreck_echo_route_first_pass").bind(self))
	_run("East Shelf pocket result callout", Callable(suites[24], "_test_east_shelf_pocket_result_callout").bind(self))
	_run("lower connector echo opportunity", Callable(suites[24], "_test_lower_connector_echo_opportunity").bind(self))
	_run("Resonance Alcove research payoff", Callable(suites[25], "_test_resonance_alcove_research_payoff").bind(self))
	_run("Blue Chimney draft interaction", Callable(suites[25], "_test_blue_chimney_draft_interaction").bind(self))
	_run("Lantern Silt Sample interaction", Callable(suites[25], "_test_lantern_silt_sample_interaction").bind(self))
	_run("Blackwater gate presenter", Callable(suites[25], "_test_blackwater_gate_presenter").bind(self))
	_run("Blackwater Crack gate state", Callable(suites[25], "_test_blackwater_crack_gate_state").bind(self))
	_run("Blackwater Trace payoff", Callable(suites[26], "_test_blackwater_trace_payoff").bind(self))
	_run("Glass Kelp reading payoff", Callable(suites[26], "_test_glass_kelp_reading_payoff").bind(self))
	_run("Hollow Reef cave reading payoff", Callable(suites[26], "_test_hollow_reef_cave_reading_payoff").bind(self))
	_run("upgrade copy presenter", Callable(suites[26], "_test_upgrade_copy_presenter").bind(self))
	_run("upgrade bay readability states", Callable(suites[27], "_test_upgrade_bay_readability_states").bind(self))
	_run("result and upgrade copy length guards", Callable(suites[27], "_test_result_and_upgrade_copy_length_guards").bind(self))
	_run("recent expedition log service", Callable(suites[27], "_test_recent_expedition_log_service").bind(self))
	_run("recent expedition presenter", Callable(suites[28], "_test_recent_expedition_presenter").bind(self))
	_run("recent expedition log", Callable(suites[28], "_test_recent_expedition_log").bind(self))
	_run("recent expedition survival memory", Callable(suites[29], "_test_recent_expedition_survival_memory").bind(self))
	_run("thermal vent scan clue text", Callable(suites[29], "_test_thermal_vent_scan_clue_text").bind(self))
	_run("shell reef scan clue text", Callable(suites[29], "_test_shell_reef_scan_clue_text").bind(self))
	_run("wreck signal cache repeat scan hint", Callable(suites[29], "_test_wreck_signal_cache_repeat_scan_hint").bind(self))
	_run("pressure lock guidance text", Callable(suites[29], "_test_pressure_lock_guidance_text").bind(self))
	_run("surface summary tabs", Callable(suites[29], "_test_surface_summary_tabs").bind(self))
	_run("keyboard action prompt labels", Callable(suites[29], "_test_keyboard_action_prompt_labels").bind(self))
	_run("HUD prompt presenter", Callable(suites[29], "_test_hud_prompt_presenter").bind(self))
	_run("prompt formatter guard coverage", Callable(suites[30], "_test_prompt_formatter_guard_coverage").bind(self))
	_run("condition presenter", Callable(suites[30], "_test_condition_presenter").bind(self))
	_run("condition briefing copy", Callable(suites[30], "_test_condition_briefing_copy").bind(self))
	_run("Dusk Trench low-visibility condition nudge", Callable(suites[30], "_test_dusk_trench_low_visibility_condition_nudge").bind(self))
	_run("Wide Reef Chamber calm-current condition nudge", Callable(suites[30], "_test_wide_chamber_calm_current_condition_nudge").bind(self))
	_run("Mirror Kelp kelp-bloom condition nudge", Callable(suites[31], "_test_mirror_kelp_kelp_bloom_condition_nudge").bind(self))
	_run("daylight timer HUD", Callable(suites[31], "_test_daylight_timer_hud").bind(self))
	_run("late-day cargo banking warning", Callable(suites[31], "_test_late_day_cargo_banking_warning").bind(self))
	_run("expedition slate presenter", Callable(suites[31], "_test_expedition_slate_presenter").bind(self))
	_run("expedition slate node service", Callable(suites[31], "_test_expedition_slate_node_service").bind(self))
	_run("expedition slate context", Callable(suites[31], "_test_expedition_slate_context").bind(self))
	_run("expedition slate pressure pause", Callable(suites[31], "_test_expedition_slate_pressure_pause").bind(self))
	_run("HUD presenter", Callable(suites[32], "_test_hud_presenter").bind(self))
	_run("daylight timer HUD service", Callable(suites[32], "_test_daylight_timer_hud_service").bind(self))
	_run("HUD instrument bar service", Callable(suites[32], "_test_hud_instrument_bar_service").bind(self))
	_run("scan effect text service", Callable(suites[32], "_test_scan_effect_text_service").bind(self))
	_run("oxygen feedback service", Callable(suites[32], "_test_oxygen_feedback_service").bind(self))
	_run("health feedback service", Callable(suites[32], "_test_health_feedback_service").bind(self))
	_run("scan target card service", Callable(suites[32], "_test_scan_target_card_service").bind(self))
	_run("scan target feedback service", Callable(suites[32], "_test_scan_target_feedback_service").bind(self))
	_run("surface run summary service", Callable(suites[32], "_test_surface_run_summary_service").bind(self))
	_run("run panel layout service", Callable(suites[33], "_test_run_panel_layout_service").bind(self))
	_run("run panel service", Callable(suites[33], "_test_run_panel_service").bind(self))
	_run("upgrade menu service", Callable(suites[33], "_test_upgrade_menu_service").bind(self))
	_run("upgrade state service", Callable(suites[33], "_test_upgrade_state_service").bind(self))
	_run("resource summary service", Callable(suites[33], "_test_resource_summary_service").bind(self))
	_run("depth rail service", Callable(suites[33], "_test_depth_rail_service").bind(self))
	_run("minimap service", Callable(suites[33], "_test_minimap_service").bind(self))
	_run("tool belt presenter", Callable(suites[34], "_test_tool_belt_presenter").bind(self))
	_run("tool belt service", Callable(suites[33], "_test_tool_belt_service").bind(self))
	_run("condition visual sync service", Callable(suites[33], "_test_condition_visual_sync_service").bind(self))
	_run("discovery reveal sync service", Callable(suites[34], "_test_discovery_reveal_sync_service").bind(self))
	_run("route gate sync service", Callable(suites[33], "_test_route_gate_sync_service").bind(self))
	_run("route payoff sync service", Callable(suites[34], "_test_route_payoff_sync_service").bind(self))
	_run("compact dive hud helpers", Callable(suites[35], "_test_compact_dive_hud_helpers").bind(self))
	_run("visual smoke bridge", Callable(suites[35], "_test_visual_smoke_bridge").bind(self))
	_run("Area 01 visual staging service", Callable(suites[35], "_test_area01_visual_staging_service").bind(self))
	_run("mobile touch controls adapter", Callable(suites[36], "_test_mobile_touch_controls_adapter").bind(self))
	_run("active HUD final polish regression", Callable(suites[36], "_test_active_hud_final_polish_regression").bind(self))
	_run("expanded region world bounds", Callable(suites[36], "_test_expanded_region_world_bounds").bind(self))
	_run("expanded region base direction", Callable(suites[36], "_test_expanded_region_base_direction").bind(self))
	_run("no-minimap orientation guardrails", Callable(suites[37], "_test_no_minimap_orientation_guardrails").bind(self))
	_run("expanded region reset state ownership", Callable(suites[37], "_test_expanded_region_reset_state_ownership").bind(self))
	_run("lower connector reset and bounds coverage", Callable(suites[38], "_test_lower_connector_reset_and_bounds_coverage").bind(self))
	_run("East Shelf pocket prompt interaction", Callable(suites[38], "_test_east_shelf_pocket_prompt_interaction").bind(self))
	_run("East Shelf current surge visual timing", Callable(suites[38], "_test_east_shelf_current_surge_visual_timing").bind(self))
	_run("Blue Chimney reverse draft visual timing", Callable(suites[38], "_test_blue_chimney_reverse_draft_visual_timing").bind(self))
	_run("Blackwater pressure cue visual timing", Callable(suites[38], "_test_blackwater_pressure_cue_visual_timing").bind(self))
	_run("Hollow Reef timing current visual only", Callable(suites[39], "_test_hollow_reef_timing_current_visual_only").bind(self))
	_run("sealed shelf hatch promise state", Callable(suites[39], "_test_sealed_shelf_hatch_promise_state").bind(self))
	_run("burst thruster movement helper", Callable(suites[36], "_test_burst_thruster_movement_helper").bind(self))
	_run("burst thruster action service", Callable(suites[36], "_test_burst_thruster_action_service").bind(self))
	_run("player visual facing isolation", Callable(suites[39], "_test_player_visual_facing_isolation").bind(self))
	_run("player idle and thrust visual states", Callable(suites[39], "_test_player_idle_and_thrust_visual_states").bind(self))
	_run("predator decoy pulse helper", Callable(suites[39], "_test_predator_decoy_pulse_helper").bind(self))
	_run("decoy pulse feedback text", Callable(suites[39], "_test_decoy_pulse_feedback_text").bind(self))

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




func _control_rect(control: Control) -> Rect2:
	return Rect2(
		Vector2(control.offset_left, control.offset_top),
		Vector2(control.offset_right - control.offset_left, control.offset_bottom - control.offset_top)
	)




func _controls_overlap(first: Control, second: Control) -> bool:
	return _control_rect(first).intersects(_control_rect(second), true)




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
