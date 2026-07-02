class_name MainControllerStateService
extends RefCounted

const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const HudVisibilityServiceScript := preload("res://scripts/ui/hud_visibility_service.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")

static func sync_discovery_reveals(host) -> void:
	host._set_hidden_glow_plankton_active(false)
	if host.progression_state.has_discovery("thermal_vent"):
		host._reveal_thermal_vent_route()
	else:
		host.vent_route_hint.visible = false
	if host.progression_state.has_discovery("pressure_wreck_signal"):
		host._reveal_pressure_wreck_signal()
	else:
		host.wreck_signal_hint.visible = false
	host._sync_pressure_lock_state()
	host._sync_predator_warning_upgrade_state()
	host._sync_wreck_echo_state()
	host._sync_sealed_shelf_hatch_state()
	host._sync_blackwater_crack_gate_state()
	RoutePayoffSyncService.sync_east_shelf_pocket_payoff(host)
	RoutePayoffSyncService.sync_blue_chimney_payoff(host)
	RoutePayoffSyncService.sync_outer_shelf_survey_payoff(host)

static func set_control_rect(control: Control, rect: Rect2) -> void:
	if control == null:
		return

	control.offset_left = rect.position.x
	control.offset_top = rect.position.y
	control.offset_right = rect.position.x + rect.size.x
	control.offset_bottom = rect.position.y + rect.size.y

static func update_cargo_slots(host) -> void:
	var states := CargoSlotPresenter.cargo_slot_states(host.dive_session.current_cargo, host.dive_session.cargo_limit, host.cargo_slot_nodes.size())
	for index in range(host.cargo_slot_nodes.size()):
		var slot_visible := states[index] != "hidden"
		host.cargo_slot_nodes[index].color = CargoSlotPresenter.cargo_slot_color(states[index])
		host.cargo_slot_nodes[index].visible = slot_visible
		host.cargo_slot_icon_nodes[index].polygon = CargoSlotPresenter.cargo_slot_icon_polygon(states[index])
		host.cargo_slot_icon_nodes[index].color = CargoSlotPresenter.cargo_slot_icon_color(states[index])
		host.cargo_slot_icon_nodes[index].visible = slot_visible and host.cargo_slot_icon_nodes[index].polygon.size() > 0
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		HudVisibilityServiceScript.apply_active_hud_visibility(host, false, true, false)

static func record_salvage_data_cache_discovery_if_extracted(host) -> void:
	if not host.run_salvage_data_cache_recovered:
		return
	if host.progression_state.has_discovery("salvage_data_cache"):
		return

	host.progression_state.add_discovery(
		"salvage_data_cache",
		"Salvage Data Cache",
		"Recovered Wide Reef cutter prep data.",
		"Unlocks Salvage Cutter I for the sealed Wide Reef salvage pocket."
	)

static func selected_upgrade_definition(host) -> UpgradeDefinition:
	if host.upgrade_definitions.is_empty():
		return null

	host.selected_upgrade_index = clampi(host.selected_upgrade_index, 0, host.upgrade_definitions.size() - 1)
	return host.upgrade_definitions[host.selected_upgrade_index]

static func all_upgrades_owned(host) -> bool:
	for upgrade in host.upgrade_definitions:
		if not host.progression_state.has_upgrade(upgrade.id):
			return false

	return true

static func reset_run_telemetry(host) -> void:
	RunTelemetryResetService.reset_run_telemetry(host)
	if host.echo_lens_pulse != null:
		host.echo_lens_pulse.visible = false
	RoutePayoffSyncService.sync_east_shelf_pocket_payoff(host)
	RoutePayoffSyncService.sync_blue_chimney_payoff(host)
	RoutePayoffSyncService.sync_blackwater_trace_payoff(host)
	RoutePayoffSyncService.sync_glass_kelp_reading_payoff(host)
	RoutePayoffSyncService.sync_hollow_reef_reading_payoff(host)
	RoutePayoffSyncService.sync_salvage_manifest_payoff(host)
	RoutePayoffSyncService.sync_salvage_data_cache_payoff(host)
	RoutePayoffSyncService.sync_outer_shelf_survey_payoff(host)
	RoutePayoffSyncService.sync_rim_glass_reading_payoff(host)
	RoutePayoffSyncService.sync_tideglass_sample_payoff(host)
	host._sync_survival_supply_cache_state()

static func first_ready_upgrade_definition(host) -> UpgradeDefinition:
	for upgrade in host.upgrade_definitions:
		if host.progression_state.has_upgrade(upgrade.id):
			continue
		if UpgradePurchaseScript.missing_discovery(host.progression_state, upgrade) != "":
			continue
		if UpgradePurchaseScript.missing_upgrade(host.progression_state, upgrade) != "":
			continue
		if host.progression_state.can_afford(upgrade.resource_cost):
			return upgrade
	return null

static func format_active_objective_line(host) -> String:
	return HudPresenterScript.format_active_objective_line({
		"can_ship_offload": host._can_ship_offload(),
		"cargo_count": host.dive_session.current_cargo.size(),
		"cargo_limit": host.dive_session.cargo_limit,
		"daylight_nightfall_announced": host.daylight_nightfall_announced,
		"daylight_nightfall_away_from_ship": host.daylight_nightfall_away_from_ship,
		"has_left_base": host.dive_session.has_left_base,
		"has_recent_health_damage": host._has_recent_health_damage(),
		"has_scan_target": host.current_scan_target != null,
		"player_in_base": host.player_in_base,
		"player_in_surface_oxygen_refill": host._is_player_in_surface_oxygen_refill(),
		"should_warn_late_day_cargo_banking": host._should_warn_late_day_cargo_banking(),
		"survival_need_low": host.survival_state.food <= 1 or host.survival_state.water <= 1 or host.survival_state.power <= 1,
	}, host.ACTIVE_OBJECTIVE_MAX_CHARS)

static func format_base_direction(host) -> String:
	var direction_player: CharacterBody2D = host.player
	if direction_player == null:
		direction_player = host.get_node_or_null("Player") as CharacterBody2D
	if direction_player == null:
		return "Base: here"

	return HudPresenterScript.format_base_direction(direction_player.global_position, host.start_position, host.pixels_per_meter)
