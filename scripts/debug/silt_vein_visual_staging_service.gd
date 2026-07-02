class_name SiltVeinVisualStagingService
extends RefCounted

const PLAYER_PATH := "Player"
const SILT_VEIN_FORK_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork"

static func stage_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player == null:
		return

	var fork := host.get_node_or_null(SILT_VEIN_FORK_PATH) as Node2D
	if fork == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player = staged_player
	host.player.global_position = fork.global_position + Vector2(-16.0, 32.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.visual_smoke_route_stage = "silt_vein_fork"
	host.status_label.text = "Debug review: Silt Vein Fork staged."
	host._update_depth()
	host._update_hud()
