extends RefCounted

class_name HudPresenter

const LOW_OXYGEN_RATIO := 0.25
const CRITICAL_OXYGEN_RATIO := 0.10
const DIVE_STATUS_MAX_CHARS := 72
const HEALTH_LOW_RATIO := 0.35
const HEALTH_CRITICAL_RATIO := 0.18
const HEALTH_NORMAL_COLOR := Color(0.42, 1.0, 0.5, 0.94)
const HEALTH_DAMAGED_COLOR := Color(1.0, 0.5, 0.26, 0.96)
const HEALTH_LOW_COLOR := Color(1.0, 0.72, 0.22, 0.96)
const HEALTH_CRITICAL_COLOR := Color(1.0, 0.18, 0.16, 0.98)
const DAYLIGHT_DUSK_RATIO := 0.25
const DAYLIGHT_NORMAL_COLOR := Color(1.0, 0.78, 0.18, 0.96)
const DAYLIGHT_DUSK_COLOR := Color(0.82, 0.42, 1.0, 0.94)

static func oxygen_state(current_oxygen: float, maximum_oxygen: float) -> String:
	if maximum_oxygen <= 0.0:
		return "normal"

	var oxygen_ratio := current_oxygen / maximum_oxygen
	if oxygen_ratio <= CRITICAL_OXYGEN_RATIO:
		return "critical"
	if oxygen_ratio <= LOW_OXYGEN_RATIO:
		return "low"

	return "normal"


static func format_oxygen_label(current_oxygen: float, maximum_oxygen: float) -> String:
	var state := oxygen_state(current_oxygen, maximum_oxygen)
	var suffix := ""
	if state == "critical":
		suffix = "  CRITICAL"
	elif state == "low":
		suffix = "  LOW"

	return "OXYGEN: %d / %d%s" % [ceili(current_oxygen), ceili(maximum_oxygen), suffix]


static func oxygen_warning_text(state: String) -> String:
	if state == "critical":
		return "O2 CRITICAL\nRETURN TO BASE"
	if state == "low":
		return "O2 LOW\nPLAN RETURN"

	return ""


static func oxygen_state_color(state: String) -> Color:
	if state == "critical":
		return Color(1.0, 0.18, 0.12, 1.0)
	if state == "low":
		return Color(1.0, 0.76, 0.22, 1.0)

	return Color.WHITE


static func health_state(current_health: float, maximum_health: float) -> String:
	if maximum_health <= 0.0:
		return "normal"

	var health_ratio := current_health / maximum_health
	if health_ratio <= HEALTH_CRITICAL_RATIO:
		return "critical"
	if health_ratio <= HEALTH_LOW_RATIO:
		return "low"

	return "normal"


static func format_health_label(current_health: float, maximum_health: float) -> String:
	var state := health_state(current_health, maximum_health)
	var suffix := ""
	if state == "critical":
		suffix = "  CRITICAL"
	elif state == "low":
		suffix = "  LOW"

	return "HEALTH: %d / %d%s" % [ceili(current_health), ceili(maximum_health), suffix]


static func health_state_color(state: String) -> Color:
	if state == "critical":
		return HEALTH_CRITICAL_COLOR
	if state == "low":
		return HEALTH_LOW_COLOR

	return HEALTH_NORMAL_COLOR


static func format_daylight_label(remaining_seconds: float) -> String:
	if remaining_seconds <= 0.0:
		return "NIGHTFALL"

	var rounded_remaining := ceili(remaining_seconds)
	var minutes := int(rounded_remaining / 60)
	var seconds := rounded_remaining % 60
	return "DAYLIGHT %02d:%02d" % [minutes, seconds]


static func daylight_bar_color(remaining_ratio: float) -> Color:
	if remaining_ratio <= DAYLIGHT_DUSK_RATIO:
		return DAYLIGHT_DUSK_COLOR

	return DAYLIGHT_NORMAL_COLOR


static func compact_dive_status(text: String) -> String:
	var cleaned := text.replace("\n", " ").strip_edges()
	while cleaned.find("  ") != -1:
		cleaned = cleaned.replace("  ", " ")

	if cleaned.length() <= DIVE_STATUS_MAX_CHARS:
		return cleaned

	return cleaned.substr(0, DIVE_STATUS_MAX_CHARS - 3).strip_edges() + "..."


static func format_active_objective_line(state: Dictionary, max_chars: int) -> String:
	var objective := "Find supplies, scan, return"
	if int(state.get("cargo_count", 0)) >= int(state.get("cargo_limit", 0)):
		objective = "Cargo full: return to bank"
	elif bool(state.get("player_in_base", false)) and bool(state.get("has_left_base", false)):
		if bool(state.get("can_ship_offload", false)):
			objective = "At ship: offload, O2 full"
		elif bool(state.get("daylight_nightfall_announced", false)):
			objective = "At ship: start night, Power -1" if bool(state.get("daylight_nightfall_away_from_ship", false)) else "At ship: start night"
		else:
			objective = "At ship: dive again"
	elif bool(state.get("daylight_nightfall_announced", false)):
		objective = "Nightfall: return to ship"
	elif bool(state.get("should_warn_late_day_cargo_banking", false)):
		objective = "Dusk: bank cargo soon"
	elif bool(state.get("player_in_base", false)):
		objective = "Leave moonpool, gather supplies"
	elif bool(state.get("player_in_surface_oxygen_refill", false)):
		objective = "Surface: O2 only; health stays" if bool(state.get("has_recent_health_damage", false)) else "Surface: refill O2; ship banks"
	elif bool(state.get("has_recent_health_damage", false)):
		objective = "Health hit: surface won't heal"
	elif bool(state.get("survival_need_low", false)):
		objective = "Prioritize food, water, power"
	elif int(state.get("cargo_count", 0)) > 0:
		objective = "Cargo %d/%d: ship or push deeper" % [
			int(state.get("cargo_count", 0)),
			int(state.get("cargo_limit", 0)),
		]
	elif bool(state.get("has_scan_target", false)):
		objective = "Scan target or collect cargo"

	if objective.length() <= max_chars:
		return objective

	return objective.substr(0, max_chars - 3).strip_edges() + "..."


static func format_base_direction(player_position: Vector2, base_position: Vector2, pixels_per_meter: float) -> String:
	var delta := player_position - base_position
	if delta.length() < 48.0:
		return "Base: here"

	var directions := PackedStringArray()
	if delta.y > 48.0:
		directions.append("up")
	elif delta.y < -48.0:
		directions.append("below")

	if delta.x > 96.0:
		directions.append("left")
	elif delta.x < -96.0:
		directions.append("right")

	var direction_text := "-".join(directions)
	if direction_text.is_empty():
		direction_text = "nearby"

	var route_hint := ""
	if delta.x > 4000.0 and delta.y > 2500.0:
		route_hint = " via Mirror/Wide/Hollow"
	elif delta.x > 3000.0 and delta.y > 2500.0:
		route_hint = " via Hollow/Dusk/Blackwater"
	elif delta.x > 2200.0 and delta.y > 2400.0:
		route_hint = " via Dusk/Blackwater"
	elif delta.x > 2100.0 and delta.y > 2400.0:
		route_hint = " via Blackwater/Silt/Blue"
	elif delta.x > 1500.0 and delta.y > 2100.0:
		route_hint = " via Silt/Blue"

	return "Base: %s %.0fm%s" % [direction_text, delta.length() / pixels_per_meter, route_hint]
