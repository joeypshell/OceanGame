class_name MirrorKelpVisualStagingService
extends RefCounted

const MIRROR_KELP_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass"

static func stage_visual_review(host, recovered := false, observed := false) -> void:
	if not OS.has_feature("web") and not host.show_debug_telemetry:
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var mirror_kelp := host.get_node_or_null(MIRROR_KELP_PATH) as Node2D
	if mirror_kelp == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player = staged_player
	host.player.global_position = mirror_kelp.global_position + Vector2(118.0, 22.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.player_near_blackwater_crack = false
	host.player_near_glass_kelp_ledge = false
	host.player_near_hollow_reef = false
	host.player_near_salvage_manifest = false
	host.player_near_salvage_data_cache = false
	host.player_near_tideglass_sample = false
	host.run_reached_dusk_trench = true
	host.run_salvage_manifest_recovered = false
	host.run_salvage_data_cache_recovered = false
	host.run_tideglass_sample_recovered = false
	while host.run_completed_scans.has("mirrorfin_drift"):
		host.run_completed_scans.erase("mirrorfin_drift")
	host._sync_salvage_manifest_state()
	host._sync_salvage_data_cache_state()
	host._sync_tideglass_sample_state()
	host.visual_smoke_route_stage = "mirror_kelp_pass"
	if host.status_label != null:
		host.status_label.text = "Debug review: Mirror Kelp Pass staged."

	if recovered:
		var sample_zone := host.get_node_or_null("%s/TideglassSample/InteractZone" % MIRROR_KELP_PATH) as Area2D
		if sample_zone != null:
			host.player.global_position = sample_zone.global_position
			host.player_near_tideglass_sample = true
			host.run_tideglass_sample_recovered = true
			host.run_reached_dusk_trench = true
			host._sync_tideglass_sample_state()
			host.visual_smoke_route_stage = "mirror_kelp_tideglass"
			if host.status_label != null:
				host.status_label.text = "Debug review: Mirror Kelp Tideglass payoff staged."
	elif observed:
		var mirrorfin := host.get_node_or_null("%s/MirrorfinDrift" % MIRROR_KELP_PATH) as Node2D
		if mirrorfin != null:
			host.player.global_position = mirrorfin.global_position + Vector2(-42.0, 0.0)
		host.run_completed_scans.append("mirrorfin_drift")
		host.visual_smoke_route_stage = "mirror_kelp_mirrorfin"
		if host.status_label != null:
			host.status_label.text = "Debug review: Mirror Kelp Mirrorfin observation staged."

	host.dive_session.current_depth = maxf(0.0, (host.player.global_position.y - host.surface_y) / host.pixels_per_meter)
	if host.is_inside_tree() and host.active_stats_panel != null:
		host._update_hud()
