class_name HudPromptStateService
extends RefCounted

const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")
const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")

static func build_state(host) -> Dictionary:
	return {
		"action_labels": host._prompt_action_labels(),
		"all_upgrades_owned": host._all_upgrades_owned(),
		"blackwater_prompt": BlackwaterGatePresenterScript.format_prompt(
			host._blackwater_crack_gate_open(),
			host.run_blackwater_trace_recovered,
			host._action_label("interact")
		),
		"burst_thruster_prompt": UpgradeStateServiceScript.format_burst_thruster_prompt(host),
		"can_ship_offload": host._can_ship_offload(),
		"cargo_count": host.dive_session.current_cargo.size(),
		"cargo_limit": host.dive_session.cargo_limit,
		"daylight_nightfall_announced": host.daylight_nightfall_announced,
		"daylight_nightfall_away_from_ship": host.daylight_nightfall_away_from_ship,
		"decoy_pulse_prompt": UpgradeStateServiceScript.format_decoy_pulse_prompt(host),
		"has_left_base": host.dive_session.has_left_base,
		"has_recent_health_damage": host._has_recent_health_damage(),
		"has_salvage_cutter": host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID),
		"health": host.dive_session.health,
		"max_health": host.dive_session.max_health,
		"max_oxygen": host.dive_session.max_oxygen,
		"night_build_prompt": host._format_night_build_prompt(),
		"outer_shelf_recovered_prompt": RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_prompt_for_timer(
			host.outer_shelf_slackwater_timer,
			host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
			host.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
			host.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
		),
		"oxygen": host.dive_session.oxygen,
		"player_in_base": host.player_in_base,
		"player_in_surface_oxygen_refill": host._is_player_in_surface_oxygen_refill(),
		"player_near_blackwater_crack": host.player_near_blackwater_crack,
		"player_near_blue_chimney": host.player_near_blue_chimney,
		"player_near_east_shelf_pocket": host.player_near_east_shelf_pocket,
		"player_near_glass_kelp_ledge": host.player_near_glass_kelp_ledge,
		"player_near_hollow_reef": host.player_near_hollow_reef,
		"player_near_lantern_silt_nook": host.player_near_lantern_silt_nook,
		"player_near_lower_connector_echo": host.player_near_lower_connector_echo,
		"player_near_outer_shelf_survey": host.player_near_outer_shelf_survey,
		"player_near_resonance_alcove": host.player_near_resonance_alcove,
		"player_near_rim_glass_reading": host.player_near_rim_glass_reading,
		"player_near_salvage_data_cache": host.player_near_salvage_data_cache,
		"player_near_salvage_manifest": host.player_near_salvage_manifest,
		"player_near_survival_supply_cache": host.player_near_survival_supply_cache,
		"player_near_tideglass_sample": host.player_near_tideglass_sample,
		"result": host._dive_result_prompt_state(),
		"run_glass_kelp_reading_recovered": host.run_glass_kelp_reading_recovered,
		"run_hollow_reef_reading_recovered": host.run_hollow_reef_reading_recovered,
		"run_outer_shelf_survey_recovered": host.run_outer_shelf_survey_recovered,
		"run_rim_glass_reading_recovered": host.run_rim_glass_reading_recovered,
		"run_salvage_data_cache_recovered": host.run_salvage_data_cache_recovered,
		"run_salvage_manifest_recovered": host.run_salvage_manifest_recovered,
		"run_survival_supply_cache_recovered": host.run_survival_supply_cache_recovered,
		"run_tideglass_sample_recovered": host.run_tideglass_sample_recovered,
		"should_warn_late_day_cargo_banking": host._should_warn_late_day_cargo_banking(),
		"surface_tab": host._surface_tab_prompt_state(),
		"survival_supply_cache_prompt": host.SurvivalSupplyCachePresenterScript.format_prompt(
			host.survival_state.needs_are_stable(),
			host.survival_state.short_name_for_supply(host.survival_state.most_needed_supply_id()),
			host._action_label("interact")
		),
	}
