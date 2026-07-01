class_name ExpeditionSlatePresenter
extends RefCounted

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
