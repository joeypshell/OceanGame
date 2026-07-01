class_name OuterShelfVisualStagingService
extends RefCounted

const BLACKWATER_SILL_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill"
const OUTER_SHELF_SURVEY_ZONE_PATH := "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/InteractZone"

static func stage_visual_review(host) -> void:
	if not OS.has_feature("web") and not host.show_debug_telemetry:
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var survey_zone := host.get_node_or_null(OUTER_SHELF_SURVEY_ZONE_PATH) as Area2D
	if survey_zone == null:
		return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var blackwater_sill := host.get_node_or_null(BLACKWATER_SILL_PATH) as Node2D
	if blackwater_sill != null:
		blackwater_sill.visible = true
	host.player = staged_player
	host.player.global_position = survey_zone.global_position + Vector2(-92.0, -36.0)
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
	host.player_near_outer_shelf_survey = true
	host.run_reached_dusk_trench = true
	host.run_glass_kelp_reading_recovered = false
	host.run_hollow_reef_reading_recovered = true
	host.run_salvage_manifest_recovered = false
	host.run_salvage_data_cache_recovered = false
	host.run_tideglass_sample_recovered = false
	host.run_outer_shelf_survey_recovered = false
	while host.run_completed_scans.has("mirrorfin_drift"):
		host.run_completed_scans.erase("mirrorfin_drift")
	host._sync_salvage_manifest_state()
	host._sync_salvage_data_cache_state()
	host._sync_tideglass_sample_state()
	host._sync_outer_shelf_survey_state()
	host._update_outer_shelf_slackwater_timing_cue(host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	host.visual_smoke_route_stage = "outer_shelf_survey"
	if host.status_label != null:
		host.status_label.text = "Debug review: Outer Shelf survey and Glass Rim route staged."

	host.dive_session.current_depth = maxf(0.0, (host.player.global_position.y - host.surface_y) / host.pixels_per_meter)
	if host.is_inside_tree() and host.active_stats_panel != null:
		host._update_hud()
