extends RefCounted

class_name RecentExpeditionPresenter

static func format_recent_expedition_log(entries: Array[Dictionary], show_debug_telemetry: bool, scan_names_by_id: Dictionary = {}) -> String:
	if entries.is_empty():
		return "Recent Expeditions\nNone yet."

	var lines: Array[String] = ["Recent Expeditions"]
	for entry in entries:
		var route_memory := String(entry.get("route_memory", "none"))
		var line := "#%d %s: banked %d, route %s, scans %s, contacts %d, best %dm" % [
			int(entry.get("run_number", 0)),
			String(entry.get("result", "Unknown")),
			int(entry.get("banked_cargo_count", 0)),
			route_memory,
			format_scan_names_short(string_array_from(entry.get("scans", [])), scan_names_by_id),
			int(entry.get("predator_contacts", 0)),
			int(entry.get("best_depth", 0)),
		]
		var route_tease := format_recent_route_tease(route_memory)
		if not route_tease.is_empty():
			line += ", next %s" % route_tease
		var survival_memory := String(entry.get("survival_memory", ""))
		if not survival_memory.is_empty():
			line += ", survival %s" % survival_memory
		if show_debug_telemetry:
			line += " | seed %d, %s" % [
				int(entry.get("seed", 0)),
				String(entry.get("pattern", "unknown")),
			]
		lines.append(line)

	return "\n".join(lines)


static func format_recent_route_tease(route_memory: String) -> String:
	match route_memory:
		"Glass Rim":
			return "timing, cargo, or return"
		"Outer Shelf":
			return "Glass Rim timing or cargo"
		_:
			return ""


static func format_scan_names_short(scan_ids: Array[String], scan_names_by_id: Dictionary = {}) -> String:
	if scan_ids.is_empty():
		return "none"

	var parts: Array[String] = []
	for scan_id in scan_ids:
		parts.append(String(scan_names_by_id.get(scan_id, scan_id)))

	return "/".join(parts)


static func string_array_from(value: Variant) -> Array[String]:
	var result: Array[String] = []
	if not value is Array:
		return result

	for item in value:
		result.append(String(item))

	return result
