class_name ShipOffloadVisualStagingService
extends RefCounted

const BASE_ZONE_PATH := "BaseZone"
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
	var review_base: Area2D = host.base_zone
	if review_base == null:
		review_base = host.get_node_or_null(BASE_ZONE_PATH) as Area2D
	if review_base == null:
		return

	host.player.global_position = review_base.global_position
	host.player.velocity = Vector2.ZERO
	host.player_in_base = true
	host.player_in_surface_oxygen_refill = true
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = maxf(1.0, host.dive_session.max_oxygen * 0.22)
	host.dive_session.current_cargo.clear()
	host.dive_session.current_cargo.append("driftwood")
	host.visual_smoke_route_stage = "ship_offload_complete"
	host._try_ship_offload()
	host.visual_smoke_route_stage = "ship_offload_complete"
	host._update_depth()
	host._update_hud()
