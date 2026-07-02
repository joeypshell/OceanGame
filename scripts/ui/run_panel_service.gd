class_name RunPanelService
extends RefCounted

const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const SurfaceRunSummaryServiceScript := preload("res://scripts/ui/surface_run_summary_service.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func update_run_panel(host) -> void:
	var use_compact_panel: bool = (
		host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED
		and host.surface_tab_index == host.SURFACE_TAB_UPGRADES
	)
	host._apply_run_panel_layout(use_compact_panel)
	host.surface_tabs_label.visible = UpgradeStateServiceScript.surface_tabs_enabled(host)
	host.surface_tabs_label.text = UpgradeStateServiceScript.format_surface_tabs(host) if host.surface_tabs_label.visible else ""
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.run_panel.visible = true
		host.run_title_label.text = SurfaceRunSummaryServiceScript.format_expedition_day_title(host, "Ready")
		host.run_summary_label.text = SurfaceRunSummaryServiceScript.format_run_summary(host, host._format_ready_panel_summary(), "ready")
	elif host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED:
		host.run_panel.visible = true
		if host.surface_tab_index == host.SURFACE_TAB_NIGHT:
			host.run_title_label.text = SurfaceRunSummaryServiceScript.format_expedition_day_title(host, "Night")
			host.run_summary_label.text = SurfaceRunSummaryServiceScript.format_run_summary(host, SurfaceRunSummaryServiceScript.format_night_phase_summary(host), "night")
		elif host.surface_tab_index == host.SURFACE_TAB_UPGRADES:
			host.run_title_label.text = "Surface Upgrade Bay"
			host.run_summary_label.text = SurfaceRunSummaryServiceScript.format_run_summary(host, "Banked:%s\n%s choose; %s buys.\n%s" % [
				ResourceSummaryServiceScript.format_banked_resources(host.progression_state.banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
				host._action_label("move_up_down"),
				host._action_label("interact"),
				host._format_next_expedition_prompt(),
			], "extracted")
		elif host.surface_tab_index == host.SURFACE_TAB_LOG:
			host.run_title_label.text = "Recent Expeditions"
			host.run_summary_label.text = host._format_recent_expedition_log()
		else:
			host.run_title_label.text = SurfaceRunSummaryServiceScript.format_expedition_day_title(host, "Result: Extraction")
			host.run_summary_label.text = SurfaceRunSummaryServiceScript.format_run_summary(host, host.last_result_summary, "extracted")
	elif host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host.run_panel.visible = true
		if host.surface_tab_index == host.SURFACE_TAB_LOG:
			host.run_title_label.text = "Recent Expeditions"
			host.run_summary_label.text = host._format_recent_expedition_log()
		else:
			host.run_title_label.text = SurfaceRunSummaryServiceScript.format_expedition_day_title(host, "Result: Failure")
			host.run_summary_label.text = SurfaceRunSummaryServiceScript.format_run_summary(host, host.last_result_summary, "failed")
	else:
		host.run_panel.visible = false
