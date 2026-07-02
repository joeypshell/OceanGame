class_name RouteInteractionService
extends RefCounted

const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const RoutePayoffSyncServiceScript := preload("res://scripts/ui/route_payoff_sync_service.gd")
const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")
const SurvivalSupplyCachePresenterScript := preload("res://scripts/ui/survival_supply_cache_presenter.gd")

static func try_survival_supply_cache_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_survival_supply_cache:
		return false

	if host.run_survival_supply_cache_recovered:
		if host.status_label != null:
			host.status_label.text = "Emergency cache already recovered this expedition."
		if host.is_inside_tree():
			host._update_hud()
		return true

	var supply_id: String = host.survival_state.most_needed_supply_id()
	if not host.dive_session.add_cargo(supply_id):
		host.status_label.text = SurvivalSupplyCachePresenterScript.format_full_status(
			host.survival_state.needs_are_stable(),
			host.survival_state.short_name_for_supply(host.survival_state.most_needed_supply_id())
		)
		host._update_hud()
		return true

	host.run_survival_supply_cache_recovered = true
	host.run_collected_survival_supplies.append(supply_id)
	host._sync_survival_supply_cache_state()
	host.status_label.text = SurvivalSupplyCachePresenterScript.format_recovered_status(
		host.survival_state.display_name_for_supply(supply_id),
		host.survival_state.short_name_for_supply(supply_id)
	)
	host._update_hud()
	return true

static func try_east_shelf_pocket_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_east_shelf_pocket:
		return false

	if host.run_east_shelf_pocket_ping_recovered:
		return _handled_repeat(host, "East Shelf signal core already recovered for this expedition.")

	host.run_east_shelf_pocket_ping_recovered = true
	RoutePayoffSyncServiceScript.sync_east_shelf_pocket_payoff(host)
	if host.status_label != null:
		if host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID):
			host.status_label.text = "East Shelf signal core recovered. Echo Lens reads the seal; return to plan a key."
		else:
			host.status_label.text = "East Shelf signal core recovered. Return safely to keep the route note."
	return _handled_updated(host)

static func try_lower_connector_echo_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_lower_connector_echo:
		return false

	if host.run_lower_connector_echo_recovered:
		return _handled_repeat(host, "Drop Echo already recorded for this expedition.")

	host.run_lower_connector_echo_recovered = true
	if host.status_label != null:
		if host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID):
			host.status_label.text = "Drop Echo recorded. Return safely; lab can compare hatch resonance."
		else:
			host.status_label.text = "Drop Echo recorded. Return safely to keep the lower-route note."
	return _handled_updated(host)

static func try_resonance_alcove_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_resonance_alcove:
		return false

	if not host.progression_state.has_upgrade(host.RESONANCE_KEY_UPGRADE_ID):
		return _handled_repeat(host, "Resonance Alcove is behind the sealed hatch.")

	if host.run_resonance_alcove_research_recovered:
		return _handled_repeat(host, "Resonance Alcove echo already recorded this expedition.")

	host.run_resonance_alcove_research_recovered = true
	if host.status_label != null:
		host.status_label.text = "Resonance Alcove echo recorded. Return safely to keep the research."
	return _handled_updated(host)

static func try_blue_chimney_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_blue_chimney:
		return false

	if host.run_blue_chimney_draft_reading_recovered:
		return _handled_repeat(host, "Blue Chimney survey core already recovered this expedition.")

	host.run_blue_chimney_draft_reading_recovered = true
	RoutePayoffSyncServiceScript.sync_blue_chimney_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Blue Chimney survey core recovered. Return safely to keep the lower-route reading."
	return _handled_updated(host)

static func try_blackwater_crack_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_blackwater_crack:
		return false

	if host._blackwater_crack_gate_open():
		if host.run_blackwater_trace_recovered:
			return _handled_repeat(host, "Blackwater trace already recorded this expedition.")

		host.run_blackwater_trace_recovered = true
		RoutePayoffSyncServiceScript.sync_blackwater_trace_payoff(host)
		if host.status_label != null:
			host.status_label.text = "Blackwater trace recorded. Return safely via Silt Vein, Blue Chimney, and Drop Arch to keep the deep-route reading."
		return _handled_updated(host)

	if host.status_label != null:
		host.status_label.text = BlackwaterGatePresenterScript.format_gate_status(
			host._blackwater_crack_gate_open(),
			host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID)
		)
	return _handled_updated(host)

static func try_glass_kelp_ledge_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_glass_kelp_ledge:
		return false

	if host.run_glass_kelp_reading_recovered:
		return _handled_repeat(host, "Glass Kelp reading already recorded this expedition.")

	host.run_glass_kelp_reading_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_glass_kelp_reading_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Glass Kelp reading recorded. Return safely through Blackwater and Silt Vein to keep the ledge note."
	return _handled_updated(host)

static func try_hollow_reef_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_hollow_reef:
		return false

	if host.run_hollow_reef_reading_recovered:
		return _handled_repeat(host, "Hollow Reef cave reading already recorded this expedition.")

	host.run_hollow_reef_reading_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_hollow_reef_reading_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Hollow Reef cave reading recorded. Return safely through Dusk and Blackwater to keep the branch note."
	return _handled_updated(host)

static func try_lantern_silt_nook_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_lantern_silt_nook:
		return false

	if host.run_lantern_silt_sample_recovered:
		return _handled_repeat(host, "Lantern silt sample already stored this expedition.")

	host.run_lantern_silt_sample_recovered = true
	if host.status_label != null:
		host.status_label.text = "Lantern silt sample stored. Return safely to keep the fork reading."
	return _handled_updated(host)

static func try_salvage_data_cache_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_salvage_data_cache:
		return false

	if host.run_salvage_data_cache_recovered:
		return _handled_repeat(host, "Salvage data cache already recovered this expedition.")

	host.run_salvage_data_cache_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_salvage_data_cache_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Salvage data cache recovered for Salvage Cutter I prep. Return safely through Hollow Reef to keep the wreck note."
	return _handled_updated(host)

static func try_salvage_manifest_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_salvage_manifest:
		return false
	if not host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID):
		return false

	if host.run_salvage_manifest_recovered:
		return _handled_repeat(host, "Salvage manifest already recovered this expedition.")

	host.run_salvage_manifest_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_salvage_manifest_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Salvage manifest recovered. Return safely or risk cargo space on nearby shell fragments."
	return _handled_updated(host)

static func try_outer_shelf_survey_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_outer_shelf_survey:
		return false

	if host.run_outer_shelf_survey_recovered:
		return _handled_repeat(host, "Outer Shelf survey already recorded this expedition.")

	host.run_outer_shelf_survey_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_outer_shelf_survey_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Outer Shelf survey recorded. Choose nearby Kelp Fiber, return through Mirror/Wide/Hollow, or read the Glass Rim current: %s" % RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_text_for_timer(
			host.outer_shelf_slackwater_timer,
			host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
			host.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
			host.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
		)
	return _handled_updated(host)

static func try_rim_glass_reading_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_rim_glass_reading:
		return false

	if host.run_rim_glass_reading_recovered:
		return _handled_repeat(host, "Glass Rim reading already recovered this expedition.")

	host.run_rim_glass_reading_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_rim_glass_reading_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Glass Rim reading recovered. Bank it now, or risk nearby Kelp Fiber if oxygen allows."
	return _handled_updated(host)

static func try_tideglass_sample_interaction(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or not host.player_near_tideglass_sample:
		return false

	if host.run_tideglass_sample_recovered:
		return _handled_repeat(host, "Tideglass Sample already recorded this expedition.")

	host.run_tideglass_sample_recovered = true
	host.run_reached_dusk_trench = true
	RoutePayoffSyncServiceScript.sync_tideglass_sample_payoff(host)
	if host.status_label != null:
		host.status_label.text = "Tideglass Sample recovered. Return safely through Wide Reef and Hollow Reef to keep the Mirror Kelp reading."
	return _handled_updated(host)

static func _handled_repeat(host, message: String) -> bool:
	if host.status_label != null:
		host.status_label.text = message
	return _handled_updated(host)

static func _handled_updated(host) -> bool:
	if host.is_inside_tree():
		host._update_hud()
	return true
