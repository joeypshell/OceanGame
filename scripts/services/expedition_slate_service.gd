class_name ExpeditionSlateService
extends RefCounted

const ExpeditionSlateNodeServiceScript := preload("res://scripts/ui/expedition_slate_node_service.gd")
const ExpeditionSlatePresenterScript := preload("res://scripts/ui/expedition_slate_presenter.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")

static func toggle_expedition_slate(host) -> void:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	set_expedition_slate_open(host, not host.expedition_slate_open)

static func close_expedition_slate(host) -> void:
	set_expedition_slate_open(host, false)

static func set_expedition_slate_open(host, is_open: bool) -> void:
	if is_open and host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return
	if host.expedition_slate_open == is_open:
		return

	host.expedition_slate_open = is_open
	if host.player != null:
		host.player.velocity = Vector2.ZERO
		host.player.set_physics_process(not is_open)
	if is_open:
		ScanRuntimeServiceScript.cancel_scan_charge(host, "Expedition slate open: pressure paused.")
		if host.status_label != null:
			host.status_label.text = "Expedition slate open: pressure paused."
	else:
		if host.status_label != null and host.dive_session.result == host.DiveSessionScript.Result.DIVING:
			host.status_label.text = "Expedition slate closed."

	if host.is_inside_tree():
		host._update_hud()
	update_expedition_slate(host, host.dive_session.result == host.DiveSessionScript.Result.DIVING)

static func expedition_pressure_paused(host) -> bool:
	return host.expedition_slate_open and host.dive_session.result == host.DiveSessionScript.Result.DIVING

static func ensure_expedition_slate_nodes(host) -> void:
	ExpeditionSlateNodeServiceScript.ensure_nodes(host)

static func update_expedition_slate(host, is_diving: bool) -> void:
	ensure_expedition_slate_nodes(host)
	if host.expedition_slate_panel == null:
		return

	var should_show: bool = is_diving and host.expedition_slate_open
	host.expedition_slate_panel.visible = should_show
	host._set_control_rect(host.expedition_slate_panel, host.EXPEDITION_SLATE_RECT)
	host._set_control_rect(host.expedition_slate_title_label, host.EXPEDITION_SLATE_TITLE_RECT)
	host._set_control_rect(host.expedition_slate_body_label, host.EXPEDITION_SLATE_BODY_RECT)
	if host.expedition_slate_body_label != null:
		host.expedition_slate_body_label.text = ExpeditionSlatePresenterScript.format_slate_text_for_host(host)
