class_name MainSceneController
extends "res://scripts/main_scene_context.gd"

func _ready() -> void:
	MainReadyServiceScript.ready(self)

func _ensure_mobile_touch_controls() -> void:
	SurfaceRuntimeServiceScript.ensure_mobile_touch_controls(self)

func _on_mobile_touch_action_requested(action: StringName) -> void:
	SurfaceRuntimeServiceScript.on_mobile_touch_action_requested(self, action)

func _on_mobile_touch_action_released(action: StringName) -> void:
	SurfaceRuntimeServiceScript.on_mobile_touch_action_released(self, action)

func _wire_surface_oxygen_refill_zone() -> void:
	SurfaceRuntimeServiceScript.wire_surface_oxygen_refill_zone(self)

func _process(delta: float) -> void:
	MainProcessServiceScript.process_frame(self, delta)

func _update_active_dive_oxygen(delta: float) -> void:
	SurfaceRuntimeServiceScript.update_active_dive_oxygen(self, delta)

func _apply_surface_oxygen_refill(delta: float) -> void:
	SurfaceRuntimeServiceScript.apply_surface_oxygen_refill(self, delta)

func _is_player_in_surface_oxygen_refill() -> bool:
	return SurfaceRuntimeServiceScript.is_player_in_surface_oxygen_refill(self)

func _surface_oxygen_refill_active() -> bool:
	return SurfaceRuntimeServiceScript.surface_oxygen_refill_active(self)

func _surface_oxygen_refill_floor_y() -> float:
	return SurfaceRuntimeServiceScript.surface_oxygen_refill_floor_y(self)

func _toggle_expedition_slate() -> void:
	ExpeditionSlateServiceScript.toggle_expedition_slate(self)

func _close_expedition_slate() -> void:
	ExpeditionSlateServiceScript.close_expedition_slate(self)

func _set_expedition_slate_open(is_open: bool) -> void:
	ExpeditionSlateServiceScript.set_expedition_slate_open(self, is_open)

func _has_recent_health_damage() -> bool:
	return dive_session.result == DiveSessionScript.Result.DIVING and run_health_damage_events > 0 and dive_session.health < dive_session.max_health

func _expedition_pressure_paused() -> bool:
	return ExpeditionSlateServiceScript.expedition_pressure_paused(self)

func _ensure_expedition_slate_nodes() -> void:
	ExpeditionSlateServiceScript.ensure_expedition_slate_nodes(self)

func _update_expedition_slate(is_diving: bool) -> void:
	ExpeditionSlateServiceScript.update_expedition_slate(self, is_diving)

func _sync_surface_oxygen_refill_state_from_position() -> void:
	SurfaceRuntimeServiceScript.sync_surface_oxygen_refill_state_from_position(self)

func _unhandled_input(_event: InputEvent) -> void:
	InputActionServiceScript.handle_unhandled_input(self, _event)

func _handle_interact_action() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.handle_interact_action(self)

func _try_ship_offload() -> bool:
	_ensure_active_hud_references()
	return DiveLifecycleServiceScript.try_ship_offload(self)

func _can_ship_offload() -> bool:
	return DiveLifecycleServiceScript.can_ship_offload(self)

func _try_extract() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.try_extract(self)

func _bank_extracted_cargo(extracted_cargo: Array[String]) -> Array[String]:
	return DiveLifecycleServiceScript.bank_extracted_cargo(self, extracted_cargo)

func _bank_extracted_survival_supplies(extracted_cargo: Array[String]) -> Array[String]:
	return SurvivalControllerServiceScript.bank_extracted_survival_supplies(self, extracted_cargo)

func _remember_banked_survival_supplies(supply_ids: Array[String]) -> void:
	SurvivalControllerServiceScript.remember_banked_survival_supplies(self, supply_ids)

func _resolve_night_after_result() -> void:
	SurvivalControllerServiceScript.resolve_night_after_result(self)

func _try_craft_night_power_patch() -> bool:
	return SurvivalControllerServiceScript.try_craft_night_power_patch(self)

func _append_night_report_line(line: String) -> void:
	SurvivalControllerServiceScript.append_night_report_line(self, line)

func _set_night_build_feedback(message: String) -> void:
	SurvivalControllerServiceScript.set_night_build_feedback(self, message)

func _nightfall_extra_power_cost() -> int:
	return SurvivalControllerServiceScript.nightfall_extra_power_cost(self)

func _should_report_health_recovery_after_result() -> bool:
	return SurvivalControllerServiceScript.should_report_health_recovery_after_result(self)

func _should_resolve_health_recovery_after_result() -> bool:
	return SurvivalControllerServiceScript.should_resolve_health_recovery_after_result(self)

func _fail_dive() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.fail_dive(self)

func _start_dive() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.start_dive(self)

func _restart_dive() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.restart_dive(self)

func _reset_local_prototype_save() -> void:
	_ensure_active_hud_references()
	DiveLifecycleServiceScript.reset_local_prototype_save(self)

func _prepare_next_run() -> void:
	RunPreparationServiceScript.prepare_next_run(self)

func _try_survival_supply_cache_interaction() -> bool:
	return RouteInteractionServiceScript.try_survival_supply_cache_interaction(self)

func _try_east_shelf_pocket_interaction() -> bool:
	return RouteInteractionServiceScript.try_east_shelf_pocket_interaction(self)

func _try_lower_connector_echo_interaction() -> bool:
	return RouteInteractionServiceScript.try_lower_connector_echo_interaction(self)

func _try_resonance_alcove_interaction() -> bool:
	return RouteInteractionServiceScript.try_resonance_alcove_interaction(self)

func _try_blue_chimney_interaction() -> bool:
	return RouteInteractionServiceScript.try_blue_chimney_interaction(self)

func _try_blackwater_crack_interaction() -> bool:
	return RouteInteractionServiceScript.try_blackwater_crack_interaction(self)

func _try_glass_kelp_ledge_interaction() -> bool:
	return RouteInteractionServiceScript.try_glass_kelp_ledge_interaction(self)

func _try_hollow_reef_interaction() -> bool:
	return RouteInteractionServiceScript.try_hollow_reef_interaction(self)

func _try_lantern_silt_nook_interaction() -> bool:
	return RouteInteractionServiceScript.try_lantern_silt_nook_interaction(self)

func _try_salvage_data_cache_interaction() -> bool:
	return RouteInteractionServiceScript.try_salvage_data_cache_interaction(self)

func _try_salvage_manifest_interaction() -> bool:
	return RouteInteractionServiceScript.try_salvage_manifest_interaction(self)

func _try_outer_shelf_survey_interaction() -> bool:
	return RouteInteractionServiceScript.try_outer_shelf_survey_interaction(self)

func _try_rim_glass_reading_interaction() -> bool:
	return RouteInteractionServiceScript.try_rim_glass_reading_interaction(self)

func _try_tideglass_sample_interaction() -> bool:
	return RouteInteractionServiceScript.try_tideglass_sample_interaction(self)

func _update_depth() -> void:
	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	progression_state.record_depth(dive_session.current_depth)
	if player.global_position.x >= DUSK_TRENCH_MEMORY_MIN_X and player.global_position.y >= DUSK_TRENCH_MEMORY_MIN_Y:
		run_reached_dusk_trench = true

func _select_upgrade(direction: int) -> void:
	_ensure_active_hud_references()
	if upgrade_definitions.is_empty():
		return

	selected_upgrade_index = posmod(selected_upgrade_index + direction, upgrade_definitions.size())
	upgrade_menu_feedback = ""
	_update_hud()

func _cycle_surface_tab(direction: int) -> void:
	_ensure_active_hud_references()
	surface_tab_index = posmod(surface_tab_index + direction, SURFACE_TAB_NAMES.size())
	status_label.text = "Surface view: %s." % SURFACE_TAB_NAMES[surface_tab_index].to_lower()
	_update_hud()

func _toggle_debug_telemetry() -> void:
	DebugRuntimeServiceScript.toggle_debug_telemetry(self)

func _toggle_area01_source_map_overlay() -> void:
	DebugRuntimeServiceScript.toggle_area01_source_map_overlay(self)

func _sync_debug_oxygen_mode() -> void:
	DebugRuntimeServiceScript.sync_debug_oxygen_mode(self)

func _ensure_area01_source_map_overlay() -> void:
	DebugRuntimeServiceScript.ensure_area01_source_map_overlay(self)

func _ensure_area01_visual_director() -> Area01VisualDirector:
	if area01_visual_director != null and is_instance_valid(area01_visual_director):
		return area01_visual_director

	area01_visual_director = Area01VisualDirectorScript.new()
	add_child(area01_visual_director)
	return area01_visual_director

func _sync_area01_source_map_overlay() -> void:
	DebugRuntimeServiceScript.sync_area01_source_map_overlay(self)

func _area01_overlay_capture_state() -> String:
	return DebugRuntimeServiceScript.area01_overlay_capture_state(self)

func _area01_overlay_camera_state() -> String:
	return DebugRuntimeServiceScript.area01_overlay_camera_state(self)

func _cycle_debug_condition() -> void:
	DebugRuntimeServiceScript.cycle_debug_condition(self)

func _cycle_debug_seed() -> void:
	DebugRuntimeServiceScript.cycle_debug_seed(self)

func _stage_debug_oxygen_visual_review(target_ratio: float, label: String) -> void:
	DebugRuntimeServiceScript.stage_debug_oxygen_visual_review(self, target_ratio, label)

func _stage_debug_daylight_visual_review(progress_ratio: float, label: String) -> void:
	DebugRuntimeServiceScript.stage_debug_daylight_visual_review(self, progress_ratio, label)

func _stage_debug_east_shelf_pocket_visual_review() -> void:
	DebugRuntimeServiceScript.stage_debug_east_shelf_pocket_visual_review(self)

func _stage_debug_blue_chimney_payoff_visual_review() -> void:
	DebugRuntimeServiceScript.stage_debug_blue_chimney_payoff_visual_review(self)

func _consume_visual_smoke_command() -> void:
	VisualSmokeBridgeScript.consume_command(self)

func _debug_next_condition_from_id(current_id: String) -> Dictionary:
	return DebugRuntimeServiceScript.debug_next_condition_from_id(self, current_id)

func _debug_seed_for_delta(seed: int, delta: int) -> int:
	return DebugRuntimeServiceScript.debug_seed_for_delta(seed, delta)

func _action_label(action_id: String) -> String:
	return String(KEYBOARD_ACTION_LABELS.get(action_id, action_id))

func _format_hud_prompt() -> String:
	return HudPromptPresenterScript.format_prompt(_hud_prompt_state())

func _hud_prompt_state() -> Dictionary:
	return HudPromptStateServiceScript.build_state(self)

func _prompt_action_labels() -> Dictionary:
	return {
		"interact": _action_label("interact"),
		"move_left_right": _action_label("move_left_right"),
		"move_up_down": _action_label("move_up_down"),
		"restart_dive": _action_label("restart_dive"),
	}

func _dive_result_prompt_state() -> String:
	match dive_session.result:
		DiveSessionScript.Result.READY:
			return "ready"
		DiveSessionScript.Result.EXTRACTED:
			return "extracted"
		DiveSessionScript.Result.FAILED:
			return "failed"
		_:
			return "diving"

func _surface_tab_prompt_state() -> String:
	if surface_tab_index == SURFACE_TAB_NIGHT:
		return "night"
	if surface_tab_index == SURFACE_TAB_UPGRADES:
		return "upgrades"
	return "result"

func _format_night_build_prompt() -> String:
	return NightBuildPresenterScript.format_prompt(
		night_health_recovery_used_build_time,
		night_build_completed_this_surface,
		not survival_state.chapter_failed and not survival_state.chapter_complete,
		progression_state.can_afford(NIGHT_POWER_PATCH_COST),
		_action_label("interact"),
		_action_label("restart_dive"),
		_action_label("move_left_right")
	)

func _try_purchase_selected_upgrade() -> void:
	_ensure_active_hud_references()
	UpgradePurchaseFlowServiceScript.try_purchase_selected_upgrade(self)

func _try_burst_thruster() -> void:
	DiveToolActionServiceScript.try_burst_thruster(self)

func _apply_upgrade_effect(effect_id: String) -> void:
	UpgradeEffectServiceScript.apply_upgrade_effect(self, effect_id)

func _try_scan(requested_target: Node = null) -> void:
	ScanActionServiceScript.try_scan(self, requested_target)

func _reset_resource_pickups() -> void:
	if not is_inside_tree():
		return
	var tree := get_tree()
	for pickup in tree.get_nodes_in_group("resource_pickups"):
		pickup.reset_pickup()
	_sync_discovery_reveals()

func _sync_condition_visuals() -> void:
	var condition_id := _current_condition_id()
	ConditionVisualSyncServiceScript.sync_condition_visuals(self, condition_id, _blackwater_signal_visible_for_condition(condition_id))

func _blackwater_signal_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal" and _blackwater_crack_gate_open()

func _sync_blackwater_signal_opportunity(condition_id: String) -> void:
	DiscoveryRevealSyncServiceScript.sync_blackwater_signal_opportunity(self, _blackwater_signal_visible_for_condition(condition_id))

func _current_condition_id() -> String:
	return String(current_expedition_condition.get("id", ""))

func _sync_discovery_reveals() -> void:
	MainControllerStateServiceScript.sync_discovery_reveals(self)

func _reveal_thermal_vent_route() -> void:
	DiscoveryRevealSyncServiceScript.reveal_thermal_vent_route(self)

func _set_hidden_glow_plankton_active(active: bool) -> void:
	DiscoveryRevealSyncServiceScript.set_hidden_glow_plankton_active(self, active)

func _reveal_pressure_wreck_signal() -> void:
	DiscoveryRevealSyncServiceScript.reveal_pressure_wreck_signal(self)

func _sync_pressure_lock_state() -> void:
	RouteGateSyncServiceScript.sync_pressure_lock(self)

func _sync_sealed_shelf_hatch_state() -> void:
	RouteGateSyncServiceScript.sync_sealed_shelf_hatch(self)

func _blackwater_crack_gate_open() -> bool:
	return progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID)

func _sync_salvage_pocket_open_state() -> void:
	RouteGateSyncServiceScript.sync_salvage_pocket_open(self)
	RoutePayoffSyncServiceScript.sync_salvage_manifest_payoff(self)

func _sync_blackwater_crack_gate_state() -> void:
	RouteGateSyncServiceScript.sync_blackwater_crack_gate(self)
	RoutePayoffSyncServiceScript.sync_blackwater_trace_payoff(self)
	_sync_blackwater_signal_opportunity(_current_condition_id())

func _wreck_echo_route_available() -> bool:
	return progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID) and progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID)

func _sync_wreck_echo_state() -> void:
	RouteGateSyncServiceScript.sync_wreck_echo(self)

func _sync_predator_warning_upgrade_state() -> void:
	var multiplier := predator_warning_1_multiplier if progression_state.has_upgrade(PREDATOR_WARNING_UPGRADE_ID) else 1.45
	if gulper_eel != null and gulper_eel.has_method("set_warning_radius_multiplier"):
		gulper_eel.set_warning_radius_multiplier(multiplier)

func _update_hud() -> void:
	HudUpdateServiceScript.update_hud(self)

func _apply_active_hud_layout() -> void:
	_ensure_active_hud_references()
	HudLayoutServiceScript.apply_active_hud_layout(self)

func _ensure_active_hud_references() -> void:
	if player == null:
		player = get_node_or_null("Player") as CharacterBody2D
	if base_zone == null:
		base_zone = get_node_or_null("BaseZone") as Area2D
	HudReferenceServiceScript.ensure_active_hud_references(self)
	if status_label == null:
		status_label = Label.new()

func _format_recent_expedition_log() -> String:
	return RecentExpeditionLogServiceScript.format_recent_expedition_log(self)

func _format_blackwater_gate_status() -> String:
	return BlackwaterGatePresenterScript.format_gate_status(
		_blackwater_crack_gate_open(),
		progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID)
	)

func _format_night_build_choice_line() -> String:
	return SurfaceRunSummaryServiceScript.format_night_build_choice_line(self)

func _format_run_summary(player_summary: String, result_name: String) -> String:
	return SurfaceRunSummaryServiceScript.format_run_summary(self, player_summary, result_name)

func _format_expedition_ready_status() -> String:
	return SurfaceRunSummaryServiceScript.format_expedition_ready_status(self)

func _rare_signal_emphasis_visible_for_condition(condition_id: String) -> bool:
	return ConditionVisualSyncServiceScript.rare_signal_emphasis_visible_for_condition(condition_id)

func _shelf_glimmer_visible_for_condition(condition_id: String) -> bool:
	return ConditionVisualSyncServiceScript.shelf_glimmer_visible_for_condition(condition_id)

func _blue_chimney_signal_visible_for_condition(condition_id: String) -> bool:
	return ConditionVisualSyncServiceScript.blue_chimney_signal_visible_for_condition(condition_id)

func _sync_dusk_trench_condition_nudge(condition_id: String) -> void:
	ConditionVisualSyncServiceScript.sync_dusk_trench_condition_nudge(self, condition_id)

func _sync_wide_chamber_condition_nudge(condition_id: String) -> void:
	ConditionVisualSyncServiceScript.sync_wide_chamber_condition_nudge(self, condition_id)

func _sync_mirror_kelp_condition_nudge(condition_id: String) -> void:
	ConditionVisualSyncServiceScript.sync_mirror_kelp_condition_nudge(self, condition_id)

func _sync_route_choice_condition_nudge(condition_id: String) -> void:
	ConditionVisualSyncServiceScript.sync_route_choice_condition_nudge(self, condition_id)

func _advance_daylight_timer(delta: float) -> void:
	DaylightRuntimeServiceScript.advance_daylight_timer(self, delta)

func _handle_daylight_expired() -> void:
	DaylightRuntimeServiceScript.handle_daylight_expired(self)

func _set_daylight_progress_for_debug(progress_ratio: float) -> void:
	DaylightRuntimeServiceScript.set_daylight_progress_for_debug(self, progress_ratio)

func _daylight_remaining_seconds() -> float:
	return DaylightRuntimeServiceScript.daylight_remaining_seconds(self)

func _daylight_remaining_ratio() -> float:
	return DaylightRuntimeServiceScript.daylight_remaining_ratio(self)

func _should_warn_late_day_cargo_banking() -> bool:
	return DaylightRuntimeServiceScript.should_warn_late_day_cargo_banking(self)

func _visual_late_day_cargo_warning_visible() -> bool:
	return DaylightRuntimeServiceScript.visual_late_day_cargo_warning_visible(self)

func _update_daylight_timer_hud(is_visible: bool) -> void:
	DaylightTimerHudServiceScript.update_timer(self, is_visible)

func _set_bar_fill_width(fill: ColorRect, base_rect: Rect2, ratio: float) -> void:
	_set_control_rect(fill, base_rect)
	fill.offset_right = fill.offset_left + base_rect.size.x * clampf(ratio, 0.0, 1.0)

func _set_control_rect(control: Control, rect: Rect2) -> void:
	MainControllerStateServiceScript.set_control_rect(control, rect)

func _publish_visual_smoke_state() -> void:
	VisualSmokeBridgeScript.publish_state(self)

func _apply_run_panel_layout(use_compact_panel: bool) -> void:
	RunPanelLayoutServiceScript.apply_layout(self, use_compact_panel)

func _update_cargo_slots() -> void:
	MainControllerStateServiceScript.update_cargo_slots(self)

func _sync_survival_supply_cache_state() -> void:
	SurvivalSupplyCacheStateServiceScript.sync_state(self)

func _record_salvage_data_cache_discovery_if_extracted() -> void:
	MainControllerStateServiceScript.record_salvage_data_cache_discovery_if_extracted(self)

func _selected_upgrade_definition() -> UpgradeDefinition:
	return MainControllerStateServiceScript.selected_upgrade_definition(self)

func _all_upgrades_owned() -> bool:
	return MainControllerStateServiceScript.all_upgrades_owned(self)

func _oxygen_tank_cost() -> Dictionary:
	return OXYGEN_TANK_UPGRADE.resource_cost

func _reset_run_telemetry() -> void:
	MainControllerStateServiceScript.reset_run_telemetry(self)

func _refresh_carried_tomorrow_intention() -> void:
	carried_tomorrow_intention = SurfaceRunSummaryServiceScript.format_tomorrow_plan(self)

func _first_ready_upgrade_definition() -> UpgradeDefinition:
	return MainControllerStateServiceScript.first_ready_upgrade_definition(self)

func _record_recent_expedition(result_name: String, banked_cargo_count: int) -> void:
	RecentExpeditionLogServiceScript.record_recent_expedition(self, result_name, banked_cargo_count)

func _format_active_objective_line() -> String:
	return MainControllerStateServiceScript.format_active_objective_line(self)

func _current_max_oxygen() -> float:
	return DiveCapacityServiceScript.current_max_oxygen(max_oxygen, progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID), oxygen_tank_1_max_oxygen, survival_state.oxygen_penalty())

func _current_cargo_limit() -> int:
	return DiveCapacityServiceScript.current_cargo_limit(base_cargo_limit, progression_state.has_upgrade(CARGO_RACK_UPGRADE_ID), cargo_rack_1_limit)

func _format_base_direction() -> String:
	return MainControllerStateServiceScript.format_base_direction(self)
