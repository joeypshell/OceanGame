class_name ConditionPresenter
extends RefCounted

static func format_cluster_pattern(pattern: String) -> String:
	match pattern:
		"cautious":
			return "Cautious shallows"
		"deep_reward":
			return "Deep reward route"
		_:
			return pattern

static func format_condition_telemetry(condition: Dictionary) -> String:
	if condition.is_empty():
		return "none"

	return "%s (%s)" % [
		String(condition.get("display_name", "Unknown")),
		String(condition.get("id", "unknown")),
	]

static func format_condition_briefing(condition: Dictionary, has_resonance_key: bool) -> String:
	if condition.is_empty():
		return "Today: no unusual activity."

	var condition_id := String(condition.get("id", "unknown"))
	var display_name := String(condition.get("display_name", "Unknown"))
	match condition_id:
		"calm_current":
			return "Today: %s.\nReturn currents are clearer near base." % display_name
		"thermal_bloom":
			return "Today: %s.\nVent-warmed routes may point toward extra glow." % display_name
		"kelp_bloom":
			return "Today: %s.\nMirror Kelp approaches are denser; read the shimmer breaks." % display_name
		"predator_migration":
			return "Today: %s.\nExpect the Gulper route to feel active; watch warning cues." % display_name
		"low_visibility":
			return "Today: %s.\nLower-trench routes are murkier; bank early if unsure." % display_name
		"rare_signal":
			if has_resonance_key:
				return "Today: %s.\nEast Shelf, Blue Chimney, or Blackwater pings are worth checking if oxygen allows." % display_name
			return "Today: %s.\nEast Shelf or Blue Chimney pings are worth checking if oxygen allows." % display_name
		"wreck_shift":
			return "Today: %s.\nThe pressure wreck route is the notable landmark today." % display_name

	return "Today: %s.\n%s" % [
		display_name,
		String(condition.get("briefing", "")),
	]
