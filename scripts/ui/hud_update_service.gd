class_name HudUpdateService
extends RefCounted

const DepthRailServiceScript := preload("res://scripts/ui/depth_rail_service.gd")
const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const HealthFeedbackServiceScript := preload("res://scripts/ui/health_feedback_service.gd")
const HudInstrumentBarServiceScript := preload("res://scripts/ui/hud_instrument_bar_service.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const HudVisibilityServiceScript := preload("res://scripts/ui/hud_visibility_service.gd")
const MinimapServiceScript := preload("res://scripts/ui/minimap_service.gd")
const OxygenFeedbackServiceScript := preload("res://scripts/ui/oxygen_feedback_service.gd")
const RecentExpeditionLogServiceScript := preload("res://scripts/ui/recent_expedition_log_service.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const RunPanelServiceScript := preload("res://scripts/ui/run_panel_service.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")
const SurvivalNeedsPanelServiceScript := preload("res://scripts/ui/survival_needs_panel_service.gd")
const ToolBeltServiceScript := preload("res://scripts/ui/tool_belt_service.gd")
const UpgradeMenuServiceScript := preload("res://scripts/ui/upgrade_menu_service.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func update_hud(host) -> void:
	if host.get_node_or_null("HUD") == null:
		return
	host._ensure_active_hud_references()
	if not _has_required_hud_refs(host):
		return
	ScanTargetFeedbackServiceScript.update_scan_target_feedback(host)
	RunPanelServiceScript.update_run_panel(host)
	UpgradeMenuServiceScript.update_menu(host)
	host._apply_active_hud_layout()
	var is_diving := HudVisibilityServiceScript.active_hud_visible_for_result(host.dive_session.result)
	var has_surface_panel := HudVisibilityServiceScript.surface_hud_visible_for_result(host.dive_session.result)
	var has_scan_target := is_diving and host.current_scan_target != null
	HudVisibilityServiceScript.apply_active_hud_visibility(host, is_diving, has_surface_panel, has_scan_target)
	host._update_daylight_timer_hud(is_diving)
	host.oxygen_label.text = HudPresenterScript.format_oxygen_label(host.dive_session.oxygen, host.dive_session.max_oxygen)
	host.health_label.text = HudPresenterScript.format_health_label(host.dive_session.health, host.dive_session.max_health)
	host.depth_label.text = "Depth: %dm | Best: %dm" % [
		roundi(host.dive_session.current_depth),
		roundi(host.progression_state.best_depth_reached)
	]
	host.base_direction_label.text = host._format_base_direction()
	OxygenFeedbackServiceScript.update_feedback(host)
	HealthFeedbackServiceScript.update_feedback(host)
	host.cargo_label.text = "%d / %d" % [
		host.dive_session.current_cargo.size(),
		host.dive_session.cargo_limit
	]
	host._update_cargo_slots()
	HudInstrumentBarServiceScript.update_bars(host)
	SurvivalNeedsPanelServiceScript.update_panel(host, is_diving)
	DepthRailServiceScript.update_rail(host, is_diving)
	MinimapServiceScript.update_minimap(host, is_diving)
	host.bank_label.text = "Banked:%s" % ResourceSummaryServiceScript.format_banked_resources(host.progression_state.banked_resources, host.survival_state, host.RESOURCE_CATEGORY_LABELS)
	host.upgrade_label.text = UpgradeStateServiceScript.format_upgrade_status(host)
	host.discoveries_label.text = DiscoveryNamePresenterScript.format_discoveries(host.progression_state, true)
	host.recent_expedition_log_label.text = RecentExpeditionLogServiceScript.format_recent_expedition_log(host)
	host.status_label.text = HudPresenterScript.compact_dive_status(host.status_label.text) if is_diving else host.status_label.text
	if is_diving:
		host.objective_title_label.text = "SURVIVAL ROUTE"
		host.objective_line_label.text = host._format_active_objective_line()

	host.prompt_label.text = HudPresenterScript.compact_dive_status(host._format_hud_prompt()) if is_diving else host._format_hud_prompt()
	ToolBeltServiceScript.update_tool_belt(host, is_diving)
	host._update_expedition_slate(is_diving)

	host._publish_visual_smoke_state()

static func _has_required_hud_refs(host) -> bool:
	return (
		host.scan_reticle_root != null
		and host.run_panel != null
		and host.upgrade_panel != null
		and host.oxygen_label != null
		and host.health_label != null
		and host.depth_label != null
		and host.base_direction_label != null
		and host.cargo_label != null
		and host.bank_label != null
		and host.upgrade_label != null
		and host.discoveries_label != null
		and host.recent_expedition_log_label != null
		and host.status_label != null
		and host.prompt_label != null
	)
