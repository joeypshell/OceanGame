class_name SurfaceResultPresenter
extends RefCounted

static func format_expedition_ready_status(chapter_complete: bool, condition_id: String, current_day: int) -> String:
	if chapter_complete:
		return "Base stabilized: continue expeditions without nightly collapse."
	if condition_id == "low_visibility":
		return "Day %d ready: lower-trench visibility is poor today." % current_day
	if condition_id == "kelp_bloom":
		return "Day %d ready: Mirror Kelp approaches are thicker today." % current_day

	return "Day %d ready: the ocean changed overnight." % current_day

static func format_expedition_day_title(
	suffix: String,
	chapter_complete: bool,
	current_day: int,
	max_days: int,
	last_completed_survival_day: int
) -> String:
	if chapter_complete:
		return "Base Stabilized %s" % suffix
	var display_day := last_completed_survival_day if (suffix.begins_with("Result") or suffix == "Night") and last_completed_survival_day > 0 else current_day
	return "Emergency Week Day %d/%d %s" % [
		display_day,
		max_days,
		suffix,
	]

static func format_completed_expedition_line(
	result_name: String,
	chapter_complete: bool,
	current_day: int,
	last_completed_survival_day: int
) -> String:
	if chapter_complete:
		return "Base Stabilized: %s." % result_name
	var display_day := last_completed_survival_day if last_completed_survival_day > 0 else current_day
	return "Emergency Week Day %d: %s." % [
		display_day,
		result_name,
	]

static func format_night_report_block(last_night_report: String) -> String:
	if last_night_report.is_empty():
		return ""

	return "Night Report:\n%s\n" % last_night_report

static func format_daylight_closeout_line(nightfall_away_from_ship: bool, ship_offload_count: int) -> String:
	if nightfall_away_from_ship:
		if ship_offload_count > 0:
			return "Daylight closeout: nightfall caught the diver away from ship after %d ship offload(s); final return banked cargo and cost extra Power." % ship_offload_count
		return "Daylight closeout: nightfall caught the diver away from ship; final return banked cargo and cost extra Power."

	if ship_offload_count > 0:
		return "Daylight closeout: %d ship offload(s) banked cargo before night; final return resolved base needs." % ship_offload_count

	return "Daylight closeout: no ship offload before night; final return resolved base needs."
