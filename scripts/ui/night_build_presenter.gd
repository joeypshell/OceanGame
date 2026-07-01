class_name NightBuildPresenter
extends RefCounted

static func format_prompt(
	night_health_recovery_used_build_time: bool,
	night_build_completed_this_surface: bool,
	chapter_active: bool,
	can_afford_power_patch: bool,
	interact_label: String,
	restart_label: String,
	surface_label: String
) -> String:
	var action := "review"
	if night_health_recovery_used_build_time:
		action = "review night med"
	elif not night_build_completed_this_surface and chapter_active:
		action = "craft Power Patch" if can_afford_power_patch else "check Power Patch"
	return "Night build: %s %s, %s next expedition | %s surface view" % [
		interact_label,
		action,
		restart_label,
		surface_label,
	]

static func format_choice_line(
	night_health_recovery_used_build_time: bool,
	night_build_completed_this_surface: bool,
	chapter_active: bool,
	can_afford_power_patch: bool,
	ready_upgrade_name: String,
	upgrade_progress_callout: String,
	missing_power_patch_resources: String,
	interact_label: String,
	power_patch_power_gain: int
) -> String:
	if night_health_recovery_used_build_time:
		return "Build choice: Night med used build time. Tomorrow health full; Power Patch waits."
	if night_build_completed_this_surface:
		return "Build choice: Power Patch installed. Power +%d carries into tomorrow." % power_patch_power_gain
	if chapter_active and can_afford_power_patch:
		return "Build choice: Power Patch ready (%s craft; Scrap Metal x1 -> Power +%d tomorrow)." % [
			interact_label.replace("/", " or "),
			power_patch_power_gain,
		]
	if not ready_upgrade_name.is_empty():
		return "Build choice: %s ready in Upgrades." % ready_upgrade_name

	var progress := upgrade_progress_callout
	var prefix := "Upgrade progress: "
	if progress.begins_with(prefix):
		progress = progress.substr(prefix.length())
	if chapter_active:
		return "Build choice: Power Patch needs %s; %s" % [
			missing_power_patch_resources,
			progress,
		]
	return "Build choice: %s" % progress
