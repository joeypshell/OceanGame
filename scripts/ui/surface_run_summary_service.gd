class_name SurfaceRunSummaryService
extends RefCounted

const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const InventorySummaryPresenterScript := preload("res://scripts/ui/inventory_summary_presenter.gd")
const NightBuildPresenterScript := preload("res://scripts/ui/night_build_presenter.gd")
const RecentExpeditionLogServiceScript := preload("res://scripts/ui/recent_expedition_log_service.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const RouteMemoryPresenterScript := preload("res://scripts/ui/route_memory_presenter.gd")
const RunMemoryStateServiceScript := preload("res://scripts/ui/run_memory_state_service.gd")
const SurfaceResultPresenterScript := preload("res://scripts/ui/surface_result_presenter.gd")
const SurvivalNeedSummaryServiceScript := preload("res://scripts/ui/survival_need_summary_service.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func format_run_telemetry(host, result_name: String) -> String:
	return "\n\nPlaytest data:\nResult: %s\nSeed: %d\nPattern: %s\nCondition: %s\nPredator route: %s\nLantern Ray route: %s\nCargo collected:%s%s\nScans: %s\nPredator contacts: %d\nHealth damage events: %d\nOxygen at result: %d / %d\nHealth at result: %d / %d\nFailure cause: %s" % [
		result_name,
		host.progression_state.current_run_seed,
		ConditionPresenterScript.format_cluster_pattern(host.current_resource_cluster_pattern),
		ConditionPresenterScript.format_condition_telemetry(host.current_expedition_condition),
		host.current_predator_route_id,
		host.current_lantern_ray_route_id,
		ResourceSummaryServiceScript.format_resource_counts(host.run_collected_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		ResourceSummaryServiceScript.format_survival_supply_counts(host.run_collected_survival_supplies, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		RecentExpeditionLogServiceScript.format_scan_ids(host.run_completed_scans),
		host.run_predator_contacts,
		host.run_health_damage_events,
		ceili(host.dive_session.oxygen),
		ceili(host.dive_session.max_oxygen),
		ceili(host.dive_session.health),
		ceili(host.dive_session.max_health),
		host.run_failure_cause
	]

static func format_run_summary(host, player_summary: String, result_name: String) -> String:
	if not host.show_debug_telemetry:
		return player_summary

	return "%s\n%s" % [player_summary, format_run_telemetry(host, result_name)]

static func format_next_expedition_prompt(host) -> String:
	if host.survival_state.chapter_failed:
		return "Next: press %s to restart Emergency Week." % host._action_label("restart_dive")
	if host.survival_state.chapter_complete:
		return "Next: press %s for a stabilized expedition." % host._action_label("restart_dive")

	return "Next: press %s for Expedition %d; %s" % [
		host._action_label("restart_dive"),
		host.progression_state.current_run_number + 1,
		format_current_tomorrow_intention(host),
	]

static func format_tomorrow_plan(host) -> String:
	var empty_needs := base_need_names_at_or_below(host, 0)
	if not empty_needs.is_empty():
		return "bank %s supply first; empty needs cut max oxygen." % format_need_list(empty_needs)

	var ready_upgrade = host._first_ready_upgrade_definition()
	if ready_upgrade != null:
		return "build %s in Upgrades before diving." % ready_upgrade.display_name

	var low_needs := base_need_names_at_or_below(host, 1)
	if not low_needs.is_empty():
		return "bank %s supply soon to protect tomorrow's oxygen." % format_need_list(low_needs)

	if host.run_rim_glass_reading_recovered:
		return "use the Glass Rim reading to choose timing, cargo, or return."
	if host.run_outer_shelf_survey_recovered:
		return "try Glass Rim timing or bank the Outer Shelf cargo."

	var starter_resource_target: String = format_starter_resource_target(host)
	if not starter_resource_target.is_empty():
		return starter_resource_target

	var broad_goal: String = ExpeditionGoalFormatterScript.format_goal(host.progression_state, host.upgrade_definitions, host._current_condition_id(), RecentExpeditionLogServiceScript.latest_recent_route_memory(host.recent_expedition_log))
	var goal_prefix := "Goal: "
	if broad_goal.begins_with(goal_prefix):
		broad_goal = broad_goal.substr(goal_prefix.length())
	if broad_goal.is_empty():
		return "the ocean shifts again."

	return broad_goal

static func format_current_tomorrow_intention(host) -> String:
	var carried: String = host.carried_tomorrow_intention.strip_edges()
	if not carried.is_empty():
		return carried

	return format_tomorrow_plan(host)

static func format_dawn_priority_line(host) -> String:
	return "Day priority: %s" % format_current_tomorrow_intention(host)

static func format_starter_resource_target(host) -> String:
	return SurvivalNeedSummaryServiceScript.format_starter_resource_target(host.progression_state, host.survival_state, host.WATER_FILTER_UPGRADE_ID, host.WATER_FILTER_UPGRADE.resource_cost)

static func format_material_need_list(materials: Array[String]) -> String:
	return SurvivalNeedSummaryServiceScript.format_material_need_list(materials)

static func base_need_names_at_or_below(host, threshold: int) -> Array[String]:
	return SurvivalNeedSummaryServiceScript.base_need_names_at_or_below(host.survival_state, threshold)

static func format_need_list(needs: Array[String]) -> String:
	return SurvivalNeedSummaryServiceScript.format_need_list(needs)

static func format_expedition_ready_status(host) -> String:
	return SurfaceResultPresenterScript.format_expedition_ready_status(
		host.survival_state.chapter_complete,
		host._current_condition_id(),
		host.survival_state.current_day
	)

static func format_expedition_day_title(host, suffix: String) -> String:
	return SurfaceResultPresenterScript.format_expedition_day_title(
		suffix,
		host.survival_state.chapter_complete,
		host.survival_state.current_day,
		host.survival_state.max_days,
		host.last_completed_survival_day
	)

static func format_completed_expedition_line(host, result_name: String) -> String:
	return SurfaceResultPresenterScript.format_completed_expedition_line(
		result_name,
		host.survival_state.chapter_complete,
		host.survival_state.current_day,
		host.last_completed_survival_day
	)

static func format_extraction_result_summary(host, extracted_count: int, banked_resources: Array[String], banked_survival_supplies: Array[String] = []) -> String:
	return "%s\n%s\n%s\n%s%s\n%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n%s\n%s\nBest depth: %dm.\n%s%s" % [
		format_completed_expedition_line(host, "Extraction"),
		format_extraction_banking_line(banked_resources.size(), banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS, not host.run_completed_scans.is_empty()),
		ResourceSummaryServiceScript.format_survival_banking_line(banked_survival_supplies, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		format_region_memory_callout(host),
		format_discovery_memory_callout(host),
		format_route_choice_callout(host),
		host._format_gulper_research_callout(),
		host._format_echo_lens_research_callout(),
		host._format_wreck_echo_research_callout(),
		host._format_east_shelf_pocket_research_callout(),
		host._format_lower_connector_echo_research_callout(),
		host._format_resonance_alcove_research_callout(),
		host._format_blue_chimney_research_callout(),
		host._format_lantern_silt_sample_research_callout(),
		host._format_blackwater_trace_research_callout(),
		host._format_glass_kelp_reading_callout(),
		host._format_hollow_reef_reading_callout(),
		host._format_salvage_data_cache_research_callout(),
		host._format_salvage_manifest_research_callout(),
		host._format_tideglass_sample_research_callout(),
		host._format_rim_glass_reading_callout(),
		host._format_outer_shelf_survey_research_callout(),
		host._format_sealed_shelf_hatch_readiness_callout(),
		UpgradeStateServiceScript.format_upgrade_progress_callout(host),
		format_scan_progress_callout(host.progression_state, host.run_completed_scans, "Discoveries recorded"),
		roundi(host.progression_state.best_depth_reached),
		format_night_report_block(host),
		format_next_expedition_prompt(host)
	]

static func format_region_memory_callout(host) -> String:
	return RouteMemoryPresenterScript.format_region_memory_callout(RunMemoryStateServiceScript.route_memory_state(host))

static func format_discovery_memory_callout(host) -> String:
	return RouteMemoryPresenterScript.format_discovery_memory_callout(RunMemoryStateServiceScript.route_memory_state(host))

static func format_route_choice_callout(host) -> String:
	return RouteMemoryPresenterScript.format_route_choice_callout(RunMemoryStateServiceScript.route_memory_state(host))

static func format_scan_progress_callout(progression_state, run_completed_scans: Array[String], prefix: String) -> String:
	if run_completed_scans.is_empty():
		return "%s: none this dive." % prefix

	var parts: Array[String] = []
	for discovery_id in run_completed_scans:
		parts.append(DiscoveryNamePresenterScript.display_name(progression_state, discovery_id))

	return "%s: %s." % [prefix, ", ".join(parts)]

static func format_extraction_banking_line(
	extracted_count: int,
	extracted_cargo: Array[String],
	survival_state,
	category_labels: Dictionary,
	has_completed_scans: bool
) -> String:
	return InventorySummaryPresenterScript.format_extraction_banking_line(
		extracted_count,
		ResourceSummaryServiceScript.format_resource_counts(extracted_cargo, survival_state, category_labels),
		has_completed_scans
	)

static func format_night_report_block(host) -> String:
	return SurfaceResultPresenterScript.format_night_report_block(host.last_night_report)

static func format_night_phase_summary(host) -> String:
	var lines: Array[String] = [
		format_completed_expedition_line(host, "Night"),
	]
	var report: String = format_night_report_block(host).strip_edges()
	if not report.is_empty():
		lines.append(report)
	lines.append(format_daylight_closeout_line(host))
	lines.append(host.survival_state.status_line())
	lines.append("Banked materials:%s" % ResourceSummaryServiceScript.format_banked_resources(host.progression_state.banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS))
	lines.append(format_night_build_choice_line(host))
	lines.append(format_next_expedition_prompt(host))
	return "\n".join(lines)

static func format_daylight_closeout_line(host) -> String:
	return SurfaceResultPresenterScript.format_daylight_closeout_line(
		host.daylight_nightfall_away_from_ship,
		host.daylight_ship_offload_count
	)

static func format_night_build_choice_line(host) -> String:
	var ready_upgrade = host._first_ready_upgrade_definition()
	return NightBuildPresenterScript.format_choice_line(
		host.night_health_recovery_used_build_time,
		host.night_build_completed_this_surface,
		not host.survival_state.chapter_failed and not host.survival_state.chapter_complete,
		host.progression_state.can_afford(host.NIGHT_POWER_PATCH_COST),
		ready_upgrade.display_name if ready_upgrade != null else "",
		UpgradeStateServiceScript.format_upgrade_progress_callout(host),
		UpgradeStateServiceScript.format_missing_resources_inline(host, host.NIGHT_POWER_PATCH_COST),
		host._action_label("interact"),
		host.NIGHT_POWER_PATCH_POWER_GAIN
	)
