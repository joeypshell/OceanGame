class_name RecentExpeditionLogService
extends RefCounted

const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const RecentExpeditionPresenterScript := preload("res://scripts/ui/recent_expedition_presenter.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")

static func format_scan_ids(scan_ids: Array[String]) -> String:
	if scan_ids.is_empty():
		return "none"

	var parts: Array[String] = []
	for scan_id in scan_ids:
		parts.append(scan_id)

	return ", ".join(parts)

static func record_recent_expedition(host, result_name: String, banked_cargo_count: int) -> void:
	host.recent_expedition_log.append({
		"run_number": host.progression_state.current_run_number,
		"result": result_name,
		"banked_cargo_count": banked_cargo_count,
		"scans": host.run_completed_scans.duplicate(),
		"route_memory": host._format_recent_route_memory(),
		"survival_memory": format_recent_survival_memory(host, result_name, banked_cargo_count),
		"predator_contacts": host.run_predator_contacts,
		"best_depth": roundi(host.progression_state.best_depth_reached),
		"seed": host.progression_state.current_run_seed,
		"pattern": ConditionPresenterScript.format_cluster_pattern(host.current_resource_cluster_pattern),
	})

	while host.recent_expedition_log.size() > 3:
		host.recent_expedition_log.pop_front()

static func format_recent_expedition_log(host) -> String:
	return RecentExpeditionPresenterScript.format_recent_expedition_log(
		host.recent_expedition_log,
		host.show_debug_telemetry,
		recent_expedition_scan_names_by_id(host)
	)

static func format_recent_survival_memory(host, result_name: String, banked_cargo_count: int) -> String:
	if host.run_health_damage_events > 0 and host.dive_session.health < host.dive_session.max_health:
		return "health %d/%d; med used build" % [
			ceili(host.dive_session.health),
			ceili(host.dive_session.max_health),
		]
	if host.daylight_nightfall_away_from_ship:
		return "late return cost Power -1"
	if not host.run_banked_survival_supplies.is_empty():
		return "banked %s supply" % ResourceSummaryServiceScript.format_supply_names_inline(host.run_banked_survival_supplies, host.survival_state)

	var low_needs: Array[String] = host._base_need_names_at_or_below(1)
	if not low_needs.is_empty():
		return "low %s" % host._format_need_list(low_needs)

	if result_name == "Extracted" and banked_cargo_count == 0:
		var starter_target: String = host._format_starter_resource_target()
		if not starter_target.is_empty():
			var prefix := "Shell Reef pockets: "
			var suffix := " for Water Filter I."
			if starter_target.begins_with(prefix):
				starter_target = starter_target.substr(prefix.length())
			if starter_target.ends_with(suffix):
				starter_target = starter_target.substr(0, starter_target.length() - suffix.length())
			return "Water Filter needs %s" % starter_target

	return ""

static func recent_expedition_scan_names_by_id(host) -> Dictionary:
	var names_by_id := {}
	for entry in host.recent_expedition_log:
		for scan_id in RecentExpeditionPresenterScript.string_array_from(entry.get("scans", [])):
			names_by_id[scan_id] = DiscoveryNamePresenterScript.display_name(host.progression_state, scan_id)

	return names_by_id
