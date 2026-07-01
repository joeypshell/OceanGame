class_name RunMemoryStateService
extends RefCounted

static func route_memory_state(host) -> Dictionary:
	return {
		"current_resource_cluster_pattern": host.current_resource_cluster_pattern,
		"run_blackwater_trace_recovered": host.run_blackwater_trace_recovered,
		"run_blue_chimney_draft_reading_recovered": host.run_blue_chimney_draft_reading_recovered,
		"run_collected_resources": host.run_collected_resources,
		"run_completed_scans": host.run_completed_scans,
		"run_east_shelf_pocket_ping_recovered": host.run_east_shelf_pocket_ping_recovered,
		"run_hollow_reef_reading_recovered": host.run_hollow_reef_reading_recovered,
		"run_lantern_silt_sample_recovered": host.run_lantern_silt_sample_recovered,
		"run_lower_connector_echo_recovered": host.run_lower_connector_echo_recovered,
		"run_outer_shelf_survey_recovered": host.run_outer_shelf_survey_recovered,
		"run_predator_contacts": host.run_predator_contacts,
		"run_reached_dusk_trench": host.run_reached_dusk_trench,
		"run_rim_glass_reading_recovered": host.run_rim_glass_reading_recovered,
		"run_salvage_data_cache_recovered": host.run_salvage_data_cache_recovered,
		"run_salvage_manifest_recovered": host.run_salvage_manifest_recovered,
		"run_tideglass_sample_recovered": host.run_tideglass_sample_recovered,
	}

static func research_result_state(host) -> Dictionary:
	var state := route_memory_state(host)
	state.merge({
		"decoy_pulse_used_this_run": host.decoy_pulse_used_this_run,
		"has_echo_lens_upgrade": host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID),
		"run_echo_lens_echo_fired": host.run_echo_lens_echo_fired,
		"run_glass_kelp_reading_recovered": host.run_glass_kelp_reading_recovered,
		"run_resonance_alcove_research_recovered": host.run_resonance_alcove_research_recovered,
		"run_wreck_echo_clue_recovered": host.run_wreck_echo_clue_recovered,
	})
	return state
