class_name DuskTrenchVisualStagingService
extends RefCounted

const RouteTimingCueServiceScript := preload("res://scripts/ui/route_timing_cue_service.gd")
const RoutePayoffSyncServiceScript := preload("res://scripts/ui/route_payoff_sync_service.gd")

const DUSK_TRENCH_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench"
const GLASS_KELP_INTERACT_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone"

static func stage_route_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var dusk_trench := host.get_node_or_null(DUSK_TRENCH_PATH) as Node2D
	if dusk_trench == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.RESONANCE_KEY_UPGRADE_ID] = true
	host.current_expedition_condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	}
	host._sync_sealed_shelf_hatch_state()
	host._sync_blackwater_crack_gate_state()
	host._sync_condition_visuals()
	RouteTimingCueServiceScript.update_blackwater_pressure_cue(host, host.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	host.player = staged_player
	host.player.global_position = dusk_trench.global_position + Vector2(92.0, 32.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_blackwater_crack = false
	host.player_near_glass_kelp_ledge = false
	host.run_reached_dusk_trench = true
	host.run_glass_kelp_reading_recovered = false
	RoutePayoffSyncServiceScript.sync_glass_kelp_reading_payoff(host)
	host.visual_smoke_route_stage = "dusk_trench_route"
	host.status_label.text = "Debug review: Dusk Trench route staged."
	host._update_depth()
	host._update_hud()

static func stage_payoff_visual_review(host, recovered := false) -> void:
	stage_route_visual_review(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var ledge_interact := host.get_node_or_null(GLASS_KELP_INTERACT_PATH) as Area2D
	if ledge_interact == null:
		return

	host.player.global_position = ledge_interact.global_position
	host.player.velocity = Vector2.ZERO
	host.player_near_glass_kelp_ledge = true
	host.run_reached_dusk_trench = true
	if recovered:
		host._try_glass_kelp_ledge_interaction()
		host.visual_smoke_route_stage = "dusk_trench_payoff_recovered"
		host.status_label.text = "Debug review: Dusk Trench payoff recovered."
	else:
		host.run_glass_kelp_reading_recovered = false
		RoutePayoffSyncServiceScript.sync_glass_kelp_reading_payoff(host)
		host.visual_smoke_route_stage = "dusk_trench_payoff"
		host.status_label.text = "Debug review: Dusk Trench payoff staged."
	host._update_depth()
	host._update_hud()
