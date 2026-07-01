class_name HealthFeedbackPresenter
extends RefCounted

static func format_damage_source_short(source: String) -> String:
	var lowered := source.to_lower()
	if lowered.contains("thermal vent"):
		return "Thermal vent"
	if source.strip_edges().is_empty():
		return "Damage"

	return source.capitalize()

static func format_damage_status(source: String, amount: float) -> String:
	return "%s: -%d health. O2 unchanged." % [
		format_damage_source_short(source),
		ceili(amount),
	]

static func format_recovery_line(current_health: float, max_health: float) -> String:
	return "Health: %d/%d returned; no surface heal; night med used build time, tomorrow health full." % [
		ceili(current_health),
		ceili(max_health),
	]

static func format_failure_cause_for_player(failure_cause: String) -> String:
	if failure_cause.contains("health depleted"):
		return "health depleted"
	if failure_cause.contains("thermal vent"):
		return "thermal vent damage"
	if failure_cause.contains("predator"):
		return "oxygen depleted after predator contact"

	return "oxygen depleted"
