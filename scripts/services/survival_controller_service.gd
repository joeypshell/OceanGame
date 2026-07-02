class_name SurvivalControllerService
extends RefCounted

const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")
const SurvivalStateScript := preload("res://scripts/survival_state.gd")

static func bank_extracted_survival_supplies(host, extracted_cargo: Array[String]) -> Array[String]:
	var banked_supplies: Array[String] = []
	for item_id in extracted_cargo:
		if host.survival_state.bank_supply(item_id):
			banked_supplies.append(item_id)
	return banked_supplies

static func remember_banked_survival_supplies(host, supply_ids: Array[String]) -> void:
	for supply_id in supply_ids:
		host.run_banked_survival_supplies.append(supply_id)

static func resolve_night_after_result(host) -> void:
	host.night_health_recovery_used_build_time = false
	var night_lines: Array[String] = host.survival_state.resolve_night(nightfall_extra_power_cost(host))
	if should_resolve_health_recovery_after_result(host):
		host.night_health_recovery_used_build_time = true
		night_lines.append(HealthFeedbackPresenterScript.format_recovery_line(host.dive_session.health, host.dive_session.max_health))
	host.last_night_report = "\n".join(night_lines)
	host._refresh_carried_tomorrow_intention()

static func try_craft_night_power_patch(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.EXTRACTED or host.surface_tab_index != host.SURFACE_TAB_NIGHT:
		return false
	if host.survival_state.chapter_failed:
		set_night_build_feedback(host, "Night build unavailable: Emergency Week collapsed.")
		return false
	if host.survival_state.chapter_complete:
		set_night_build_feedback(host, "Night build unnecessary: base already stabilized.")
		return false
	if host.night_health_recovery_used_build_time:
		set_night_build_feedback(host, "Night med already used build time; Power Patch waits until tomorrow.")
		return false
	if host.night_build_completed_this_surface:
		set_night_build_feedback(host, "Power Patch already installed for tomorrow.")
		return false
	if not host.progression_state.spend_resources(host.NIGHT_POWER_PATCH_COST):
		set_night_build_feedback(host, "Power Patch needs %s." % UpgradeStateServiceScript.format_missing_resources_inline(host, host.NIGHT_POWER_PATCH_COST))
		return false

	for index in range(host.NIGHT_POWER_PATCH_POWER_GAIN):
		host.survival_state.bank_supply(SurvivalStateScript.SUPPLY_POWER)
	host.night_build_completed_this_surface = true
	var result_line := "Night build: Power Patch spent Scrap Metal x1. Power +%d for tomorrow." % host.NIGHT_POWER_PATCH_POWER_GAIN
	append_night_report_line(host, result_line)
	host._refresh_carried_tomorrow_intention()
	set_night_build_feedback(host, result_line)
	SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
	return true

static func append_night_report_line(host, line: String) -> void:
	if host.last_night_report.is_empty():
		host.last_night_report = line
	else:
		host.last_night_report = "%s\n%s" % [host.last_night_report, line]

static func set_night_build_feedback(host, message: String) -> void:
	host.upgrade_menu_feedback = message
	if host.status_label != null:
		host.status_label.text = message
	if host.is_inside_tree():
		host._update_hud()

static func nightfall_extra_power_cost(host) -> int:
	if host.daylight_nightfall_away_from_ship:
		return 1

	return 0

static func should_report_health_recovery_after_result(host) -> bool:
	return host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED and host.run_health_damage_events > 0 and host.dive_session.health < host.dive_session.max_health

static func should_resolve_health_recovery_after_result(host) -> bool:
	return should_report_health_recovery_after_result(host) and not host.survival_state.chapter_failed
