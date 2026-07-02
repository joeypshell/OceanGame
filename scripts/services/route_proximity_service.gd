class_name RouteProximityService
extends RefCounted

const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")
const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")
const SurvivalSupplyCachePresenterScript := preload("res://scripts/ui/survival_supply_cache_presenter.gd")

static func on_survival_supply_cache_body_entered(body: Node2D, host) -> void:
	var entered_body := body
	_ensure_hud_refs(host)
	if entered_body != null and entered_body != host.player:
		return
	host.player_near_survival_supply_cache = true
	if host.status_label != null:
		host.status_label.text = SurvivalSupplyCachePresenterScript.format_status_text(
			host.survival_state.needs_are_stable(),
			host.survival_state.short_name_for_supply(host.survival_state.most_needed_supply_id())
		)
	_update_if_inside_tree(host)
	if host.status_label != null:
		host.status_label.text = SurvivalSupplyCachePresenterScript.format_status_text(
			host.survival_state.needs_are_stable(),
			host.survival_state.short_name_for_supply(host.survival_state.most_needed_supply_id())
		)

static func on_survival_supply_cache_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_survival_supply_cache", false)

static func on_base_zone_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body == host.player:
		host.player_in_base = true
		host._update_hud()

static func on_base_zone_body_exited(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body == host.player:
		host.player_in_base = false
		host.dive_session.has_left_base = true
		host._update_hud()

static func on_surface_oxygen_refill_zone_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player:
		return
	host.player_in_surface_oxygen_refill = true
	if host.dive_session.result == host.DiveSessionScript.Result.DIVING and host.status_label != null:
		host.status_label.text = SurfaceStatusPresenterScript.surface_oxygen_status_for_host(host)
	_update_if_inside_tree(host)

static func on_surface_oxygen_refill_zone_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_in_surface_oxygen_refill", false)

static func on_east_shelf_pocket_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_east_shelf_pocket", "East Shelf Pocket: recover the signal core.")

static func on_east_shelf_pocket_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_east_shelf_pocket", false)

static func on_lower_connector_echo_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_lower_connector_echo", "Drop Echo: inspect the lower connector signal.")

static func on_lower_connector_echo_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_lower_connector_echo", false)

static func on_resonance_alcove_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_resonance_alcove", "Resonance Alcove: inspect the tuned hatch echo.")

static func on_resonance_alcove_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_resonance_alcove", false)

static func on_blue_chimney_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_blue_chimney", "Blue Chimney: inspect the reverse draft.")

static func on_blue_chimney_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_blue_chimney", false)

static func on_lantern_silt_nook_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_lantern_silt_nook", "Lantern Silt Nook: collect a silt sample.")

static func on_lantern_silt_nook_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_lantern_silt_nook", false)

static func on_blackwater_crack_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player:
		return
	host.player_near_blackwater_crack = true
	if host.status_label != null:
		host.status_label.text = BlackwaterGatePresenterScript.format_gate_status(
			host._blackwater_crack_gate_open(),
			host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID)
		)
	_update_if_inside_tree(host)

static func on_blackwater_crack_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_blackwater_crack", false)

static func on_glass_kelp_ledge_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_glass_kelp_ledge", "Glass Kelp: read kelp.")

static func on_glass_kelp_ledge_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_glass_kelp_ledge", false)

static func on_hollow_reef_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_hollow_reef", "Hollow Reef: read cave.")

static func on_hollow_reef_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_hollow_reef", false)

static func on_salvage_manifest_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player:
		return
	host.player_near_salvage_manifest = true
	if host.status_label != null and host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID):
		host.status_label.text = "Salvage: recover manifest."
	_update_if_inside_tree(host)

static func on_salvage_manifest_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_salvage_manifest", false)

static func on_salvage_data_cache_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_salvage_data_cache", "Salvage: recover data cache.")

static func on_salvage_data_cache_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_salvage_data_cache", false)

static func on_tideglass_sample_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_tideglass_sample", "Mirror Kelp: recover Tideglass.")

static func on_tideglass_sample_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_tideglass_sample", false)

static func on_outer_shelf_survey_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player:
		return
	host.player_near_outer_shelf_survey = true
	if host.status_label != null:
		host.status_label.text = RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_text_for_timer(
			host.outer_shelf_slackwater_timer,
			host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
			host.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
			host.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
		)
	_update_if_inside_tree(host)

static func on_outer_shelf_survey_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_outer_shelf_survey", false)

static func on_rim_glass_reading_body_entered(body: Node2D, host) -> void:
	_enter_with_status(body, host, "player_near_rim_glass_reading", "Glass Rim: recover slackwater reading.")

static func on_rim_glass_reading_body_exited(body: Node2D, host) -> void:
	_set_player_near_flag(body, host, "player_near_rim_glass_reading", false)

static func _enter_with_status(body: Node2D, host, flag_name: String, status_text: String) -> void:
	_ensure_hud_refs(host)
	if body != host.player:
		return
	host.set(flag_name, true)
	if host.status_label != null:
		host.status_label.text = status_text
	_update_if_inside_tree(host)

static func _set_player_near_flag(body: Node2D, host, flag_name: String, value: bool) -> void:
	if body != host.player:
		return
	host.set(flag_name, value)
	_update_if_inside_tree(host)

static func _update_if_inside_tree(host) -> void:
	if host.is_inside_tree():
		host._update_hud()

static func _ensure_hud_refs(host) -> void:
	if host.has_method("_ensure_active_hud_references"):
		host._ensure_active_hud_references()
