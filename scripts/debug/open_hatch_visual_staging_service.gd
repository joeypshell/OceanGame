class_name OpenHatchVisualStagingService
extends RefCounted

const RESONANCE_ALCOVE_PATH := "EastShelfSpur/ResonanceAlcove"
const PLAYER_PATH := "Player"

static func stage_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player == null:
		return

	var alcove := host.get_node_or_null(RESONANCE_ALCOVE_PATH) as Node2D
	if alcove == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.RESONANCE_KEY_UPGRADE_ID] = true
	host._sync_sealed_shelf_hatch_state()

	host.player = staged_player
	host.player.global_position = alcove.global_position + Vector2(-120.0, -40.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_resonance_alcove = true
	host._try_resonance_alcove_interaction()
	host.visual_smoke_route_stage = "open_hatch_resonance_alcove"
	host.status_label.text = "Debug review: open hatch and Resonance Alcove staged."
	host._update_depth()
	host._update_hud()
