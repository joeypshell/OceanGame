class_name ExpeditionSlatePresenter
extends RefCounted

const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const RecentExpeditionLogServiceScript := preload("res://scripts/ui/recent_expedition_log_service.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")

static func format_slate_text_for_host(host) -> String:
	return format_slate_text(slate_state(host))

static func slate_state(host) -> Dictionary:
	var cargo_names: Array[String] = []
	for item_id in host.dive_session.current_cargo:
		cargo_names.append(ResourceSummaryServiceScript.short_resource_name(item_id, host.survival_state))
	return {
		"base_needs_line": host.survival_state.status_line(),
		"cargo_limit": host.dive_session.cargo_limit,
		"cargo_names": cargo_names,
		"current_depth": roundi(host.dive_session.current_depth),
		"day_plan": host._format_current_tomorrow_intention(),
		"daylight_label": HudPresenterScript.format_daylight_label(host._daylight_remaining_seconds()),
		"daylight_percent_left": roundi(host._daylight_remaining_ratio() * 100.0),
		"health": ceili(host.dive_session.health),
		"known_build_line": host._format_night_build_choice_line(),
		"max_health": ceili(host.dive_session.max_health),
		"max_oxygen": ceili(host.dive_session.max_oxygen),
		"oxygen": ceili(host.dive_session.oxygen),
		"route_goal": ExpeditionGoalFormatterScript.format_goal(host.progression_state, host.upgrade_definitions, host._current_condition_id(), RecentExpeditionLogServiceScript.latest_recent_route_memory(host.recent_expedition_log)),
		"slate_label": host._action_label("expedition_slate"),
	}

static func format_slate_text(state: Dictionary) -> String:
	var route_goal := String(state.get("route_goal", ""))
	var route_goal_prefix := "Goal: "
	if route_goal.begins_with(route_goal_prefix):
		route_goal = route_goal.substr(route_goal_prefix.length())

	var lines: Array[String] = [
		"%s (%d%% daylight left)" % [String(state.get("daylight_label", "")), int(state.get("daylight_percent_left", 0))],
		"Pressure: O2 %d/%d, health %d/%d, depth %dm." % [
			int(state.get("oxygen", 0)),
			int(state.get("max_oxygen", 0)),
			int(state.get("health", 0)),
			int(state.get("max_health", 0)),
			int(state.get("current_depth", 0)),
		],
		format_cargo_line(state.get("cargo_names", []), int(state.get("cargo_limit", 0))),
		"Base needs: %s" % String(state.get("base_needs_line", "")),
		"Tonight: Food -1, Water -1, Power -1.",
		String(state.get("known_build_line", "")).replace("Build choice:", "Known build:"),
		"Day plan: %s" % String(state.get("day_plan", "")),
		"Route goal: %s" % route_goal,
		"Decision: surface for O2, ship banks cargo, return before nightfall.",
		"%s closes. Active pressure is paused while open." % String(state.get("slate_label", "")),
	]
	return "\n".join(lines)

static func format_cargo_line(cargo_names: Array, cargo_limit: int) -> String:
	var cargo_count := cargo_names.size()
	if cargo_count <= 0:
		return "Cargo: empty (%d slots open)." % cargo_limit

	var parts: Array[String] = []
	for cargo_name in cargo_names:
		parts.append(String(cargo_name))
	return "Cargo: %d / %d carried - %s." % [
		cargo_count,
		cargo_limit,
		", ".join(parts),
	]
