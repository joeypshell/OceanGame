class_name DiveLifecycleService
extends RefCounted

const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const ResearchResultCalloutServiceScript := preload("res://scripts/ui/research_result_callout_service.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const SurvivalControllerServiceScript := preload("res://scripts/services/survival_controller_service.gd")
const SurfaceRunSummaryServiceScript := preload("res://scripts/ui/surface_run_summary_service.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func handle_interact_action(host) -> void:
	_ensure_hud_refs(host)
	if host.expedition_slate_open:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		start_dive(host)
	elif host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED:
		if host.surface_tab_index == host.SURFACE_TAB_NIGHT:
			try_craft_night_power_patch(host)
		elif host.surface_tab_index == host.SURFACE_TAB_UPGRADES:
			host._try_purchase_selected_upgrade()
		else:
			host.surface_tab_index = host.SURFACE_TAB_UPGRADES
			host.status_label.text = "Surface view: upgrades."
			host._update_hud()
	else:
		if not host._try_survival_supply_cache_interaction() and not host._try_outer_shelf_survey_interaction() and not host._try_rim_glass_reading_interaction() and not host._try_tideglass_sample_interaction() and not host._try_salvage_manifest_interaction() and not host._try_salvage_data_cache_interaction() and not host._try_resonance_alcove_interaction() and not host._try_hollow_reef_interaction() and not host._try_glass_kelp_ledge_interaction() and not host._try_blackwater_crack_interaction() and not host._try_lantern_silt_nook_interaction() and not host._try_blue_chimney_interaction() and not host._try_lower_connector_echo_interaction() and not host._try_east_shelf_pocket_interaction():
			if not try_ship_offload(host):
				try_extract(host)

static func try_ship_offload(host) -> bool:
	_ensure_hud_refs(host)
	if not can_ship_offload(host):
		return false

	var offloaded_cargo: Array[String] = _cargo_ids_from(host.dive_session.current_cargo)
	var offloaded_count: int = offloaded_cargo.size()
	var banked_resources := bank_extracted_cargo(host, offloaded_cargo)
	var banked_survival_supplies := bank_extracted_survival_supplies(host, offloaded_cargo)
	remember_banked_survival_supplies(host, banked_survival_supplies)
	host.dive_session.clear_cargo()
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.daylight_ship_offload_count += 1
	host.upgrade_menu_feedback = "Ship offload banked %d cargo item(s).%s%s\nOxygen full. Daylight continues; dive again when ready." % [
		offloaded_count,
		ResourceSummaryServiceScript.format_resource_counts(banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		ResourceSummaryServiceScript.format_survival_supply_counts(banked_survival_supplies, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
	]
	if host.status_label != null:
		host.status_label.text = "Ship banked cargo; O2 full. Dive again."
	SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	if host.is_inside_tree():
		host._update_hud()
	return true

static func can_ship_offload(host) -> bool:
	return host.dive_session.result == host.DiveSessionScript.Result.DIVING and host.player_in_base and host.dive_session.has_left_base and not host.daylight_nightfall_announced and not host.dive_session.current_cargo.is_empty()

static func try_extract(host) -> void:
	_ensure_hud_refs(host)
	if not host.dive_session.can_extract(host.player_in_base):
		return

	host._close_expedition_slate()
	var extracted_cargo: Array[String] = _cargo_ids_from(host.dive_session.current_cargo)
	var extracted_count: int = extracted_cargo.size()
	host.dive_session.extract()
	var banked_resources := bank_extracted_cargo(host, extracted_cargo)
	var banked_survival_supplies := bank_extracted_survival_supplies(host, extracted_cargo)
	remember_banked_survival_supplies(host, banked_survival_supplies)
	host._record_salvage_data_cache_discovery_if_extracted()
	host.last_completed_survival_day = host.survival_state.current_day
	resolve_night_after_result(host)
	host.dive_session.clear_cargo()
	host.surface_tab_index = host.SURFACE_TAB_NIGHT
	host.last_result_summary = SurfaceRunSummaryServiceScript.format_extraction_result_summary(host, extracted_count, banked_resources, banked_survival_supplies)
	host.upgrade_menu_feedback = "Deposited %d cargo item(s).%s%s\n%s" % [
		extracted_count,
		ResourceSummaryServiceScript.format_resource_counts(banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		ResourceSummaryServiceScript.format_survival_supply_counts(banked_survival_supplies, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		UpgradeStateServiceScript.format_ready_upgrade_callout(host),
	]
	host._record_recent_expedition("Extracted", extracted_count)
	SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	host.status_label.text = "Night phase: food, water, and power resolved."
	host._update_hud()

static func bank_extracted_cargo(host, extracted_cargo: Array[String]) -> Array[String]:
	var banked_resources: Array[String] = []
	for item_id in extracted_cargo:
		if not host.survival_state.is_supply_id(item_id):
			banked_resources.append(item_id)
	host.progression_state.bank_cargo(banked_resources)
	return banked_resources

static func bank_extracted_survival_supplies(host, extracted_cargo: Array[String]) -> Array[String]:
	return SurvivalControllerServiceScript.bank_extracted_survival_supplies(host, extracted_cargo)

static func remember_banked_survival_supplies(host, supply_ids: Array[String]) -> void:
	SurvivalControllerServiceScript.remember_banked_survival_supplies(host, supply_ids)

static func resolve_night_after_result(host) -> void:
	SurvivalControllerServiceScript.resolve_night_after_result(host)

static func try_craft_night_power_patch(host) -> bool:
	return SurvivalControllerServiceScript.try_craft_night_power_patch(host)

static func append_night_report_line(host, line: String) -> void:
	SurvivalControllerServiceScript.append_night_report_line(host, line)

static func set_night_build_feedback(host, message: String) -> void:
	SurvivalControllerServiceScript.set_night_build_feedback(host, message)

static func nightfall_extra_power_cost(host) -> int:
	return SurvivalControllerServiceScript.nightfall_extra_power_cost(host)

static func should_report_health_recovery_after_result(host) -> bool:
	return SurvivalControllerServiceScript.should_report_health_recovery_after_result(host)

static func should_resolve_health_recovery_after_result(host) -> bool:
	return SurvivalControllerServiceScript.should_resolve_health_recovery_after_result(host)

static func fail_dive(host) -> void:
	_ensure_hud_refs(host)
	host._close_expedition_slate()
	if host.run_failure_cause == "none":
		host.run_failure_cause = "oxygen depleted"
	host.surface_tab_index = host.SURFACE_TAB_RESULT
	host.upgrade_menu_feedback = ""
	host._record_recent_expedition("Failed", 0)
	host.last_completed_survival_day = host.survival_state.current_day
	resolve_night_after_result(host)
	host.last_result_summary = "%s\nCause: %s.\nCargo lost. Banked resources, upgrades, scans, and best depth kept.\n%s%s\n%s%s%s\n%s\nBest depth: %dm.\n%s%s" % [
		SurfaceRunSummaryServiceScript.format_completed_expedition_line(host, "Failure"),
		HealthFeedbackPresenterScript.format_failure_cause_for_player(host.run_failure_cause),
		SurfaceRunSummaryServiceScript.format_region_memory_callout(host),
		SurfaceRunSummaryServiceScript.format_discovery_memory_callout(host),
		SurfaceRunSummaryServiceScript.format_route_choice_callout(host),
		ResearchResultCalloutServiceScript.format_gulper_research_callout(host),
		ResearchResultCalloutServiceScript.format_echo_lens_research_callout(host),
		SurfaceRunSummaryServiceScript.format_scan_progress_callout(host.progression_state, host.run_completed_scans, "Scans kept"),
		roundi(host.progression_state.best_depth_reached),
		SurfaceRunSummaryServiceScript.format_night_report_block(host),
		SurfaceRunSummaryServiceScript.format_next_expedition_prompt(host),
	]
	SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	host.status_label.text = "Dive failed: %s. Cargo lost." % HealthFeedbackPresenterScript.format_failure_cause_for_player(host.run_failure_cause)
	host._update_hud()

static func start_dive(host) -> void:
	_ensure_hud_refs(host)
	host._close_expedition_slate()
	if host.carried_tomorrow_intention.strip_edges().is_empty():
		host._refresh_carried_tomorrow_intention()
	host.dive_session.start()
	host.surface_tab_index = host.SURFACE_TAB_RESULT
	host.upgrade_menu_feedback = ""
	host._sync_surface_oxygen_refill_state_from_position()
	host.status_label.text = "Dive status: active"
	host._update_hud()

static func restart_dive(host) -> void:
	_ensure_hud_refs(host)
	_ensure_player_ref(host)
	host._close_expedition_slate()
	if host.survival_state.chapter_failed:
		host.survival_state.reset_chapter()
		host.carried_tomorrow_intention = ""
	host._prepare_next_run()
	if host.carried_tomorrow_intention.strip_edges().is_empty():
		host._refresh_carried_tomorrow_intention()
	if host.player != null:
		host.player.global_position = host.start_position
		host.player.velocity = Vector2.ZERO
	host.player_in_base = true
	host._sync_surface_oxygen_refill_state_from_position()
	host.last_result_summary = ""
	host.last_night_report = ""
	host.last_completed_survival_day = 0
	host.upgrade_menu_feedback = ""
	host.night_build_completed_this_surface = false
	host.night_health_recovery_used_build_time = false
	host.surface_tab_index = host.SURFACE_TAB_RESULT
	host._reset_resource_pickups()
	host.status_label.text = SurfaceRunSummaryServiceScript.format_expedition_ready_status(host)
	host._update_hud()

static func reset_local_prototype_save(host) -> void:
	_ensure_hud_refs(host)
	_ensure_player_ref(host)
	host._close_expedition_slate()
	host.progression_state.reset()
	host.survival_state.reset_chapter()
	SaveServiceScript.delete_progression_save(host.PROGRESSION_SAVE_PATH)
	host._prepare_next_run()
	if host.player != null:
		host.player.global_position = host.start_position
		host.player.velocity = Vector2.ZERO
	host.player_in_base = true
	host._sync_surface_oxygen_refill_state_from_position()
	host.last_result_summary = ""
	host.last_night_report = ""
	host.last_completed_survival_day = 0
	host.upgrade_menu_feedback = ""
	host.carried_tomorrow_intention = ""
	host.night_build_completed_this_surface = false
	host.night_health_recovery_used_build_time = false
	host.surface_tab_index = host.SURFACE_TAB_RESULT
	host.selected_upgrade_index = 0
	host._reset_resource_pickups()
	host._sync_discovery_reveals()
	SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	host.status_label.text = "Prototype save reset. Expedition 1 ready."
	host._update_hud()

static func _ensure_hud_refs(host) -> void:
	if host.has_method("_ensure_active_hud_references"):
		host._ensure_active_hud_references()

static func _ensure_player_ref(host) -> void:
	if host.player == null:
		host.player = host.get_node_or_null("Player") as CharacterBody2D

static func _cargo_ids_from(value: Array) -> Array[String]:
	var cargo_ids: Array[String] = []
	for item_id in value:
		cargo_ids.append(String(item_id))
	return cargo_ids
