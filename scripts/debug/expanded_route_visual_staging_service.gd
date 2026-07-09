class_name ExpandedRouteVisualStagingService
extends RefCounted

const PLAYER_PATH := "Player"
const POCKET_ENTRANCE_PATH := "EastShelfSpur/PocketEntrance"

static func stage_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player == null:
		return

	var pocket_entrance := host.get_node_or_null(POCKET_ENTRANCE_PATH) as Node2D
	if pocket_entrance == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player = staged_player
	host.player.global_position = pocket_entrance.global_position + Vector2(-160.0, -150.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.visual_smoke_route_stage = "east_shelf_spur"
	host.status_label.text = "East Shelf Spur: follow the current toward the signal pocket."
	host._update_depth()
	host._update_hud()
