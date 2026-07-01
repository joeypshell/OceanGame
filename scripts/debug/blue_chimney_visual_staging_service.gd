class_name BlueChimneyVisualStagingService
extends RefCounted

const BLUE_CHIMNEY_POCKET_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket"

static func stage_pocket_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var pocket := host.get_node_or_null(BLUE_CHIMNEY_POCKET_PATH) as Node2D
	if pocket == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	host._sync_condition_visuals()

	host.player = staged_player
	host.player.global_position = pocket.global_position + Vector2(-34.0, -24.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.visual_smoke_route_stage = "blue_chimney_pocket"
	host.status_label.text = "Debug review: Blue Chimney Pocket staged."
	host._update_depth()
	host._update_hud()
