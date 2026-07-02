class_name RunTelemetryResetService
extends RefCounted

static func reset_run_telemetry(host) -> void:
	host.run_collected_resources.clear()
	host.run_collected_survival_supplies.clear()
	host.run_banked_survival_supplies.clear()
	host.run_completed_scans.clear()
	host.run_predator_contacts = 0
	host.run_health_damage_events = 0
	host.last_health_damage_source = ""
	host.last_health_damage_amount = 0.0
	host.run_failure_cause = "none"
	host.run_echo_lens_echo_fired = false
	host.run_wreck_echo_clue_recovered = false
	host.run_east_shelf_pocket_ping_recovered = false
	host.run_lower_connector_echo_recovered = false
	host.run_resonance_alcove_research_recovered = false
	host.run_blue_chimney_draft_reading_recovered = false
	host.run_lantern_silt_sample_recovered = false
	host.run_blackwater_trace_recovered = false
	host.run_reached_dusk_trench = false
	host.run_glass_kelp_reading_recovered = false
	host.run_hollow_reef_reading_recovered = false
	host.run_salvage_manifest_recovered = false
	host.run_salvage_data_cache_recovered = false
	host.run_outer_shelf_survey_recovered = false
	host.run_rim_glass_reading_recovered = false
	host.run_tideglass_sample_recovered = false
	host.run_survival_supply_cache_recovered = false
	host.last_completed_survival_day = 0
	host.debug_wreck_echo_review_staged = false
	host.visual_smoke_route_stage = ""
	host.current_lantern_ray_route_id = "none"
	host.echo_lens_pulse_timer = 0.0
	host.blue_chimney_draft_timer = 0.0
	host.blackwater_pressure_timer = 0.0
	host.lantern_ray_timing_timer = 0.0
	host.hollow_reef_timing_timer = 0.0
	host.glassfin_swarm_spacing_timer = 0.0
	host.salvage_silt_timing_timer = 0.0
	host.outer_shelf_slackwater_timer = 0.0
