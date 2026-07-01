class_name HudVisibilityService
extends RefCounted

static func apply_active_hud_visibility(host, is_diving: bool, has_surface_panel: bool, has_scan_target: bool) -> void:
	_set_visible(host.hint_label, false)
	_set_visible(host.bounds_hint_label, false)
	_set_visible(host.active_stats_panel, is_diving)
	_set_visible(host.cargo_panel, is_diving)
	_set_visible(host.daylight_panel, is_diving)
	_set_visible(host.survival_needs_panel, is_diving)
	_set_visible(host.scan_card_panel, has_scan_target)
	_set_visible(host.tool_belt_panel, is_diving)
	_set_visible(host.minimap_panel, is_diving)
	_set_visible(host.oxygen_icon, is_diving)
	_set_visible(host.health_icon, is_diving)
	_set_visible(host.depth_icon, is_diving)
	_set_visible(host.oxygen_label, is_diving)
	_set_visible(host.oxygen_bar_back, is_diving)
	_set_visible(host.oxygen_bar_fill, is_diving)
	_set_visible(host.health_label, is_diving)
	_set_visible(host.health_bar_back, is_diving)
	_set_visible(host.health_bar_fill, is_diving)
	_set_visible(host.depth_label, is_diving)
	_set_visible(host.depth_bar_back, is_diving)
	_set_visible(host.depth_bar_fill, is_diving)
	_set_visible(host.base_direction_label, is_diving)
	_set_visible(host.cargo_label, is_diving)
	_set_visible(host.cargo_slots_root, is_diving)
	_set_visible(host.bank_label, false)
	_set_visible(host.upgrade_label, false)
	_set_visible(host.recent_expedition_log_label, false)
	_set_visible(host.discoveries_label, not has_surface_panel)
	_set_visible(host.dive_info_panel, is_diving)
	_set_visible(host.scan_target_label, has_scan_target)
	_set_visible(host.scan_card_title_label, has_scan_target)
	_set_visible(host.scan_card_meta_label, has_scan_target)
	_set_visible(host.scan_card_prompt_label, has_scan_target)
	_set_visible(host.status_label, is_diving)
	_set_visible(host.prompt_label, is_diving)

static func _set_visible(item: CanvasItem, is_visible: bool) -> void:
	if item == null:
		return
	item.visible = is_visible
