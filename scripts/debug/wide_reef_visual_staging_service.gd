class_name WideReefVisualStagingService
extends RefCounted

const WIDE_REEF_CHAMBER_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber"

static func stage_visual_review(host, cutter_owned := false) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var chamber := host.get_node_or_null(WIDE_REEF_CHAMBER_PATH) as Node2D
	if chamber == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.progression_state.purchased_upgrades[host.ECHO_LENS_UPGRADE_ID] = true
	host.progression_state.purchased_upgrades[host.RESONANCE_KEY_UPGRADE_ID] = true
	if cutter_owned:
		host.progression_state.purchased_upgrades[host.SALVAGE_CUTTER_UPGRADE_ID] = true
	host.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	host._sync_sealed_shelf_hatch_state()
	host._sync_blackwater_crack_gate_state()
	host._sync_salvage_pocket_open_state()
	host._sync_condition_visuals()
	host._update_blackwater_pressure_cue(host.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	host.player = staged_player
	host.player.global_position = chamber.global_position + (Vector2(456.0, -88.0) if cutter_owned else Vector2(112.0, -18.0))
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_blackwater_crack = false
	host.player_near_glass_kelp_ledge = false
	host.player_near_hollow_reef = false
	host.player_near_salvage_manifest = false
	host.player_near_salvage_data_cache = false
	host.run_reached_dusk_trench = true
	host.run_glass_kelp_reading_recovered = false
	host.run_hollow_reef_reading_recovered = true
	host.run_salvage_manifest_recovered = false
	host.run_salvage_data_cache_recovered = false
	host._sync_glass_kelp_reading_state()
	host._sync_hollow_reef_reading_state()
	host._sync_salvage_manifest_state()
	host._sync_salvage_data_cache_state()
	host.visual_smoke_route_stage = "wide_reef_salvage_open" if cutter_owned else "wide_reef_chamber"
	host.status_label.text = "Debug review: Wide Reef salvage pocket opened." if cutter_owned else "Debug review: Wide Reef Chamber staged."
	host._update_depth()
	host._update_hud()
