class_name BlackwaterVisualStagingService
extends RefCounted

const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const RouteTimingCueServiceScript := preload("res://scripts/ui/route_timing_cue_service.gd")

const BLACKWATER_SILL_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill"

static func stage_route_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var sill := host.get_node_or_null(BLACKWATER_SILL_PATH) as Node2D
	if sill == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.RESONANCE_KEY_UPGRADE_ID] = true
	host.current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	host._sync_sealed_shelf_hatch_state()
	host._sync_blackwater_crack_gate_state()
	host._sync_condition_visuals()
	RouteTimingCueServiceScript.update_blackwater_pressure_cue(host, host.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	host.player = staged_player
	host.player.global_position = sill.global_position + Vector2(-20.0, -20.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_blackwater_crack = true
	host.visual_smoke_route_stage = "blackwater_route"
	host.status_label.text = BlackwaterGatePresenterScript.format_gate_status(
		host._blackwater_crack_gate_open(),
		host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID)
	)
	host._update_depth()
	host._update_hud()
