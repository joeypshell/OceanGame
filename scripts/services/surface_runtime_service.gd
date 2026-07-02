class_name SurfaceRuntimeService
extends RefCounted

const RouteProximityServiceScript := preload("res://scripts/services/route_proximity_service.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")
const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")

static func ensure_mobile_touch_controls(host) -> void:
	if host.mobile_touch_controls != null:
		return
	host.mobile_touch_controls = host.MobileTouchControlsScript.new()
	host.mobile_touch_controls.name = "MobileTouchControls"
	host.mobile_touch_controls.connect("action_requested", Callable(host, "_on_mobile_touch_action_requested"))
	host.mobile_touch_controls.connect("action_released", Callable(host, "_on_mobile_touch_action_released"))
	host.add_child(host.mobile_touch_controls)

static func on_mobile_touch_action_requested(host, action: StringName) -> void:
	match action:
		&"interact":
			host._handle_interact_action()
		&"restart_dive":
			host._restart_dive()
		&"burst_thruster":
			host._try_burst_thruster()
		&"scan":
			ScanRuntimeServiceScript.begin_scan_charge(host)

static func on_mobile_touch_action_released(host, action: StringName) -> void:
	if action == &"scan":
		ScanRuntimeServiceScript.cancel_scan_charge(host, "Scan canceled.")

static func wire_surface_oxygen_refill_zone(host) -> void:
	host.surface_oxygen_refill_zone = host.get_node_or_null(host.SURFACE_OXYGEN_REFILL_HOOK_PATH) as Area2D
	if host.surface_oxygen_refill_zone == null:
		return

	host.surface_oxygen_refill_zone.monitoring = true
	host.surface_oxygen_refill_zone.monitorable = false
	host.surface_oxygen_refill_zone.collision_layer = 0
	host.surface_oxygen_refill_zone.collision_mask = host.PLAYER_COLLISION_MASK
	host.surface_oxygen_refill_zone.set_meta(&"area01_hook_status", "active_oxygen_refill")
	for child in host.surface_oxygen_refill_zone.get_children():
		if child is CollisionPolygon2D:
			(child as CollisionPolygon2D).disabled = false
		elif child is CollisionShape2D:
			(child as CollisionShape2D).disabled = false

	var entered_callback := Callable(RouteProximityServiceScript, "on_surface_oxygen_refill_zone_body_entered").bind(host)
	var exited_callback := Callable(RouteProximityServiceScript, "on_surface_oxygen_refill_zone_body_exited").bind(host)
	if not host.surface_oxygen_refill_zone.body_entered.is_connected(entered_callback):
		host.surface_oxygen_refill_zone.body_entered.connect(entered_callback)
	if not host.surface_oxygen_refill_zone.body_exited.is_connected(exited_callback):
		host.surface_oxygen_refill_zone.body_exited.connect(exited_callback)

static func update_active_dive_oxygen(host, delta: float) -> void:
	if is_player_in_surface_oxygen_refill(host):
		apply_surface_oxygen_refill(host, delta)
		return

	host.dive_session.drain_oxygen(host.oxygen_drain_per_second * delta)

static func apply_surface_oxygen_refill(host, delta: float) -> void:
	var oxygen_before: float = host.dive_session.oxygen
	host.dive_session.refill_oxygen(host.surface_oxygen_refill_per_second * delta)
	if host.daylight_nightfall_announced or host.status_label == null:
		return
	if host.dive_session.oxygen > oxygen_before + 0.01:
		host.status_label.text = SurfaceStatusPresenterScript.surface_oxygen_status_for_host(host)

static func is_player_in_surface_oxygen_refill(host) -> bool:
	if host.player == null:
		return host.player_in_surface_oxygen_refill

	var refill_floor_y := surface_oxygen_refill_floor_y(host)
	if host.player.global_position.y > refill_floor_y + 24.0:
		return false

	return host.player_in_surface_oxygen_refill or host.player.global_position.y <= refill_floor_y

static func surface_oxygen_refill_active(host) -> bool:
	return host.dive_session.result == host.DiveSessionScript.Result.DIVING and is_player_in_surface_oxygen_refill(host)

static func surface_oxygen_refill_floor_y(host) -> float:
	return host.surface_y + host.surface_oxygen_refill_depth

static func sync_surface_oxygen_refill_state_from_position(host) -> void:
	if host.player == null:
		return

	host.player_in_surface_oxygen_refill = host.player.global_position.y <= surface_oxygen_refill_floor_y(host)
