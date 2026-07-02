class_name SurfaceOxygenVisualStagingService
extends RefCounted

const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")

const PLAYER_PATH := "Player"

static func stage_visual_review(host) -> void:
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player == null:
		return

	host.player = staged_player
	host.player.global_position = Vector2(1600.0, host._surface_oxygen_refill_floor_y() - 44.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.player_in_surface_oxygen_refill = true
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = maxf(1.0, host.dive_session.max_oxygen * 0.18)
	host.dive_session.current_cargo.clear()
	host.dive_session.current_cargo.append("driftwood")
	host.visual_smoke_route_stage = "surface_oxygen_refill"
	host.status_label.text = SurfaceStatusPresenterScript.surface_oxygen_status_for_host(host)
	host._update_depth()
	host._update_hud()
