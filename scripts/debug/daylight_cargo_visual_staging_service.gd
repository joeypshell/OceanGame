class_name DaylightCargoVisualStagingService
extends RefCounted

const PLAYER_PATH := "Player"

static func stage_visual_review(host) -> void:
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	if host.dive_session.current_cargo.is_empty():
		host.dive_session.current_cargo.append("driftwood")
	host._set_daylight_progress_for_debug(1.0 - host.LATE_DAY_CARGO_WARNING_RATIO)

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player != null:
		host.player = staged_player
		host.player.global_position = host.start_position + Vector2(520.0, 460.0)
		host.player.velocity = Vector2.ZERO

	host.player_in_base = false
	host.player_in_surface_oxygen_refill = false
	host.dive_session.has_left_base = true
	host.status_label.text = "Dusk cargo: bank before night."
	host.visual_smoke_route_stage = "daylight_cargo_warning"
	host._update_depth()
	host._update_hud()
