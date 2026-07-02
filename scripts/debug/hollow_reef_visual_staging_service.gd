class_name HollowReefVisualStagingService
extends RefCounted

const RouteTimingCueServiceScript := preload("res://scripts/ui/route_timing_cue_service.gd")

const HOLLOW_REEF_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave"
const HOLLOW_REEF_INTERACT_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone"

static func stage_route_visual_review(host) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var hollow_reef := host.get_node_or_null(HOLLOW_REEF_PATH) as Node2D
	if hollow_reef == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.RESONANCE_KEY_UPGRADE_ID] = true
	host.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	host._sync_sealed_shelf_hatch_state()
	host._sync_blackwater_crack_gate_state()
	host._sync_condition_visuals()
	RouteTimingCueServiceScript.update_blackwater_pressure_cue(host, host.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	host.player = staged_player
	host.player.global_position = hollow_reef.global_position + Vector2(-132.0, -28.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_blackwater_crack = false
	host.player_near_glass_kelp_ledge = false
	host.player_near_hollow_reef = false
	host.run_reached_dusk_trench = true
	host.run_glass_kelp_reading_recovered = false
	host.run_hollow_reef_reading_recovered = false
	host._sync_glass_kelp_reading_state()
	host._sync_hollow_reef_reading_state()
	host.visual_smoke_route_stage = "hollow_reef_route"
	host.status_label.text = "Debug review: Hollow Reef entrance staged."
	host._update_depth()
	host._update_hud()

static func stage_payoff_visual_review(host, recovered := false) -> void:
	stage_route_visual_review(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var hollow_interact := host.get_node_or_null(HOLLOW_REEF_INTERACT_PATH) as Area2D
	if hollow_interact == null:
		return

	host.player.global_position = hollow_interact.global_position
	host.player.velocity = Vector2.ZERO
	host.player_near_hollow_reef = true
	host.run_reached_dusk_trench = true
	if recovered:
		host._try_hollow_reef_interaction()
		host.visual_smoke_route_stage = "hollow_reef_return"
	else:
		host.run_hollow_reef_reading_recovered = false
		host._sync_hollow_reef_reading_state()
		host.visual_smoke_route_stage = "hollow_reef_payoff"
		host.status_label.text = "Debug review: Hollow Reef payoff staged."
	host._update_depth()
	host._update_hud()
