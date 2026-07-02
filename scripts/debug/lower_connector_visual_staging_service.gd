class_name LowerConnectorVisualStagingService
extends RefCounted

const TURNBACK_HINT_PATH := "EastShelfSpur/ShelfDropConnector/TurnbackPocketHint"

static func stage_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var turnback_hint := host.get_node_or_null(TURNBACK_HINT_PATH) as Polygon2D
	if turnback_hint == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player = staged_player
	var hint_center := Vector2.ZERO
	for point in turnback_hint.polygon:
		hint_center += point
	hint_center /= max(1, turnback_hint.polygon.size())
	host.player.global_position = turnback_hint.global_position + hint_center + Vector2(-120.0, -90.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.visual_smoke_route_stage = "lower_connector"
	host.status_label.text = "Debug review: Shelf Drop Connector staged."
	host._update_depth()
	host._update_hud()
