class_name InputActionService
extends RefCounted

const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")
const WreckEchoVisualStagingServiceScript := preload("res://scripts/debug/wreck_echo_visual_staging_service.gd")

static func handle_unhandled_input(host, event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F3:
		host._toggle_debug_telemetry()
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F4:
		host._cycle_debug_condition()
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F5:
		host._cycle_debug_seed()
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F6:
		WreckEchoVisualStagingServiceScript.stage_visual_review(host)
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F7:
		host._stage_debug_oxygen_visual_review(0.20, "low")
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F8:
		host._stage_debug_oxygen_visual_review(0.08, "critical")
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F9:
		host._reset_local_prototype_save()
	elif event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_F10:
		host._toggle_area01_source_map_overlay()
	elif Input.is_action_just_pressed("expedition_slate"):
		host._toggle_expedition_slate()
	elif host.expedition_slate_open:
		return
	elif Input.is_action_just_pressed("interact"):
		host._handle_interact_action()
	elif Input.is_action_just_pressed("move_left") and UpgradeStateServiceScript.surface_tabs_enabled(host):
		host._cycle_surface_tab(-1)
	elif Input.is_action_just_pressed("move_right") and UpgradeStateServiceScript.surface_tabs_enabled(host):
		host._cycle_surface_tab(1)
	elif Input.is_action_just_pressed("move_up") and host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED and host.surface_tab_index == host.SURFACE_TAB_UPGRADES:
		host._select_upgrade(-1)
	elif Input.is_action_just_pressed("move_down") and host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED and host.surface_tab_index == host.SURFACE_TAB_UPGRADES:
		host._select_upgrade(1)
	elif Input.is_action_just_pressed("restart_dive"):
		host._restart_dive()
	elif Input.is_action_just_pressed("burst_thruster"):
		host._try_burst_thruster()
	elif Input.is_action_just_pressed("scan"):
		ScanRuntimeServiceScript.begin_scan_charge(host)
	elif Input.is_action_just_released("scan"):
		ScanRuntimeServiceScript.cancel_scan_charge(host, "Scan canceled.")
