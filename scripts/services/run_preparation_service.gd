class_name RunPreparationService
extends RefCounted

const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const RouteSetupServiceScript := preload("res://scripts/services/route_setup_service.gd")

static func prepare_next_run(host) -> void:
	host.progression_state.advance_run()
	host.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(host.progression_state.current_run_seed)
	host.dive_session.reset(host._current_max_oxygen(), host.max_health)
	host.dive_session.cargo_limit = host._current_cargo_limit()
	host.daylight_elapsed_seconds = 0.0
	host.daylight_nightfall_announced = false
	host.daylight_nightfall_away_from_ship = false
	host.daylight_ship_offload_count = 0
	host.night_build_completed_this_surface = false
	host.night_health_recovery_used_build_time = false
	host.player_in_surface_oxygen_refill = false
	host.player_near_survival_supply_cache = false
	host.player_near_east_shelf_pocket = false
	host.player_near_lower_connector_echo = false
	host.player_near_resonance_alcove = false
	host.player_near_blue_chimney = false
	host.player_near_lantern_silt_nook = false
	host.player_near_blackwater_crack = false
	host.player_near_glass_kelp_ledge = false
	host.player_near_hollow_reef = false
	host.player_near_salvage_manifest = false
	host.player_near_salvage_data_cache = false
	host.player_near_outer_shelf_survey = false
	host.player_near_rim_glass_reading = false
	host.player_near_tideglass_sample = false
	host._reset_run_telemetry()
	host.burst_thruster_cooldown_remaining = 0.0
	host.decoy_pulse_used_this_run = false
	RouteSetupServiceScript.place_starter_resources_for_run(host)
	host._sync_condition_visuals()
	host._sync_wreck_echo_state()
	host._sync_sealed_shelf_hatch_state()
	host._sync_salvage_pocket_open_state()
	host._sync_survival_supply_cache_state()
