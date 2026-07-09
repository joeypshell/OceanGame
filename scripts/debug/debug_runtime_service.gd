class_name DebugRuntimeService
extends RefCounted

const BlueChimneyVisualStagingServiceScript := preload("res://scripts/debug/blue_chimney_visual_staging_service.gd")
const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const ExpandedRouteVisualStagingServiceScript := preload("res://scripts/debug/expanded_route_visual_staging_service.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const RouteSetupServiceScript := preload("res://scripts/services/route_setup_service.gd")

static func toggle_debug_telemetry(host) -> void:
	host.show_debug_telemetry = not host.show_debug_telemetry
	host._sync_debug_oxygen_mode()
	host._sync_area01_source_map_overlay()
	host.status_label.text = "Debug telemetry: %s%s." % [
		"shown" if host.show_debug_telemetry else "hidden",
		" | unlimited oxygen" if host.show_debug_telemetry else "",
	]
	host._update_hud()

static func toggle_area01_source_map_overlay(host) -> void:
	host.show_area01_source_map_overlay = not host.show_area01_source_map_overlay
	if host.show_area01_source_map_overlay:
		host.show_debug_telemetry = true
	host._sync_debug_oxygen_mode()
	host._ensure_area01_source_map_overlay()
	host._sync_area01_source_map_overlay()
	host.status_label.text = "Area 01 source map overlay: %s." % ("shown" if host.show_area01_source_map_overlay else "hidden")
	host._update_hud()

static func sync_debug_oxygen_mode(host) -> void:
	host.dive_session.unlimited_oxygen = host.show_debug_telemetry

static func ensure_area01_source_map_overlay(host) -> void:
	host.area01_source_map_overlay = host._ensure_area01_visual_director().ensure_source_map_overlay(host)

static func sync_area01_source_map_overlay(host) -> void:
	host.area01_source_map_overlay = host._ensure_area01_visual_director().sync_source_map_overlay(
		host,
		host.scan_range,
		host.show_debug_telemetry,
		host.show_area01_source_map_overlay,
		area01_overlay_capture_state(host),
		area01_overlay_camera_state(host)
	)

static func area01_overlay_capture_state(host) -> String:
	if not host.visual_smoke_route_stage.is_empty():
		return host.visual_smoke_route_stage
	return "day %d %s" % [host.survival_state.current_day, host.DiveSessionScript.Result.keys()[host.dive_session.result].to_lower()]

static func area01_overlay_camera_state(host) -> String:
	if host.player == null:
		return "player camera unavailable"
	var camera := host.player.get_node_or_null("Camera2D") as Camera2D
	if camera == null:
		return "camera unavailable"
	return "pos %.0f,%.0f zoom %.2f" % [camera.global_position.x, camera.global_position.y, camera.zoom.x]

static func cycle_debug_condition(host) -> void:
	if not host.show_debug_telemetry:
		return

	host.current_expedition_condition = debug_next_condition_from_id(host, host._current_condition_id())
	RouteSetupServiceScript.place_starter_resources_for_run(host)
	host._sync_condition_visuals()
	host._update_hud()
	host.status_label.text = "Debug condition: %s." % ConditionPresenterScript.format_condition_telemetry(host.current_expedition_condition)

static func cycle_debug_seed(host) -> void:
	if not host.show_debug_telemetry:
		return

	host.progression_state.current_run_seed = debug_seed_for_delta(host.progression_state.current_run_seed, 1)
	host.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(host.progression_state.current_run_seed)
	host._reset_resource_pickups()
	RouteSetupServiceScript.place_starter_resources_for_run(host)
	host._sync_condition_visuals()
	host._sync_discovery_reveals()
	host._update_hud()
	host.status_label.text = "Debug seed: %d | %s | %s." % [
		host.progression_state.current_run_seed,
		ConditionPresenterScript.format_cluster_pattern(host.current_resource_cluster_pattern),
		ConditionPresenterScript.format_condition_telemetry(host.current_expedition_condition),
	]

static func stage_debug_oxygen_visual_review(host, target_ratio: float, label: String) -> void:
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or host.dive_session.max_oxygen <= 0.0:
		return

	host.dive_session.oxygen = maxf(1.0, host.dive_session.max_oxygen * target_ratio)
	host.status_label.text = HudPresenterScript.oxygen_warning_text(HudPresenterScript.oxygen_state(host.dive_session.oxygen, host.dive_session.max_oxygen))
	host._update_hud()

static func stage_debug_daylight_visual_review(host, progress_ratio: float, label: String) -> void:
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host._set_daylight_progress_for_debug(progress_ratio)
	host.status_label.text = "Daylight %s: plan the next ship return." % label
	host._update_hud()

static func stage_debug_east_shelf_pocket_visual_review(host) -> void:
	ExpandedRouteVisualStagingServiceScript.stage_visual_review(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player_near_east_shelf_pocket = true
	host._try_east_shelf_pocket_interaction()
	host.visual_smoke_route_stage = "east_shelf_pocket"
	host._update_hud()

static func stage_debug_blue_chimney_payoff_visual_review(host) -> void:
	BlueChimneyVisualStagingServiceScript.stage_pocket_visual_review(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player_near_blue_chimney = true
	host._try_blue_chimney_interaction()
	host.visual_smoke_route_stage = "blue_chimney_payoff"
	host.status_label.text = "Debug review: Blue Chimney draft payoff staged."
	host._update_hud()

static func debug_next_condition_from_id(host, current_id: String) -> Dictionary:
	var conditions := ExpeditionConditionScript.all_conditions()
	if conditions.is_empty():
		return {}

	for index in range(conditions.size()):
		if String(conditions[index].get("id", "")) == current_id:
			return conditions[(index + 1) % conditions.size()].duplicate(true)

	return conditions[0].duplicate(true)

static func debug_seed_for_delta(seed: int, delta: int) -> int:
	return maxi(1, seed + delta)
