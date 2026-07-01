extends RefCounted

class_name HudPresenter

const LOW_OXYGEN_RATIO := 0.25
const CRITICAL_OXYGEN_RATIO := 0.10
const DIVE_STATUS_MAX_CHARS := 72

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


static func compact_dive_status(text: String) -> String:
	var cleaned := text.replace("\n", " ").strip_edges()
	while cleaned.find("  ") != -1:
		cleaned = cleaned.replace("  ", " ")

	if cleaned.length() <= DIVE_STATUS_MAX_CHARS:
		return cleaned

	return cleaned.substr(0, DIVE_STATUS_MAX_CHARS - 3).strip_edges() + "..."
