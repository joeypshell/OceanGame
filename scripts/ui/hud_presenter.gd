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
