class_name HudLayoutService
extends RefCounted

static func apply_active_hud_layout(host) -> void:
	_set_control_rect(host.active_stats_panel, host.ACTIVE_STATS_RECT)
	_set_control_rect(host.cargo_panel, host.CARGO_PANEL_RECT)
	_set_control_rect(host.daylight_panel, host.DAYLIGHT_PANEL_RECT)
	_set_control_rect(host.survival_needs_panel, host.SURVIVAL_NEEDS_PANEL_RECT)
	_set_control_rect(host.dive_info_panel, host.DIVE_INFO_RECT)
	_set_control_rect(host.objective_title_label, host.DIVE_INFO_LABEL_RECTS["title"])
	_set_control_rect(host.objective_line_label, host.DIVE_INFO_LABEL_RECTS["objective"])
	_set_control_rect(host.scan_card_panel, host.SCAN_CARD_RECT)
	_set_control_rect(host.tool_belt_panel, host.TOOL_BELT_PANEL_RECT)
	_set_control_rect(host.minimap_panel, host.MINIMAP_PANEL_RECT)
	_set_control_rect(host.oxygen_warning_panel, host.OXYGEN_WARNING_RECT)
	_set_control_rect(host.oxygen_label, host.ACTIVE_HUD_LABEL_RECTS["oxygen"])
	_set_control_rect(host.oxygen_bar_back, host.OXYGEN_BAR_BACK_RECT)
	_set_control_rect(host.oxygen_bar_fill, host.OXYGEN_BAR_FILL_RECT)
	_set_control_rect(host.health_label, host.ACTIVE_HUD_LABEL_RECTS["health"])
	_set_control_rect(host.health_bar_back, host.HEALTH_BAR_BACK_RECT)
	_set_control_rect(host.health_bar_fill, host.HEALTH_BAR_FILL_RECT)
	_set_control_rect(host.depth_label, host.ACTIVE_HUD_LABEL_RECTS["depth"])
	_set_control_rect(host.depth_bar_back, host.DEPTH_BAR_BACK_RECT)
	_set_control_rect(host.depth_bar_fill, host.DEPTH_BAR_FILL_RECT)
	_set_control_rect(host.base_direction_label, host.ACTIVE_HUD_LABEL_RECTS["base"])
	_set_control_rect(host.cargo_label, host.ACTIVE_HUD_LABEL_RECTS["cargo"])
	_set_control_rect(host.daylight_label, host.DAYLIGHT_LABEL_RECT)
	_set_control_rect(host.daylight_bar_back, host.DAYLIGHT_BAR_BACK_RECT)
	_set_control_rect(host.daylight_bar_fill, host.DAYLIGHT_BAR_FILL_RECT)
	_set_control_rect(host.discoveries_label, host.ACTIVE_HUD_LABEL_RECTS["discoveries"])
	_set_control_rect(host.scan_target_label, host.ACTIVE_HUD_LABEL_RECTS["scan"])
	_set_control_rect(host.scan_card_title_label, host.SCAN_CARD_LABEL_RECTS["title"])
	_set_control_rect(host.scan_card_meta_label, host.SCAN_CARD_LABEL_RECTS["meta"])
	_set_control_rect(host.scan_card_prompt_label, host.SCAN_CARD_LABEL_RECTS["prompt"])
	_set_control_rect(host.prompt_label, host.ACTIVE_HUD_LABEL_RECTS["prompt"])
	_set_control_rect(host.status_label, host.ACTIVE_HUD_LABEL_RECTS["status"])
	_set_control_rect(host.food_need_label, host.SURVIVAL_NEED_LABEL_RECTS["food"])
	_set_control_rect(host.water_need_label, host.SURVIVAL_NEED_LABEL_RECTS["water"])
	_set_control_rect(host.power_need_label, host.SURVIVAL_NEED_LABEL_RECTS["power"])
	_set_control_rect(host.food_need_bar_back, host.SURVIVAL_NEED_BAR_BACK_RECTS["food"])
	_set_control_rect(host.water_need_bar_back, host.SURVIVAL_NEED_BAR_BACK_RECTS["water"])
	_set_control_rect(host.power_need_bar_back, host.SURVIVAL_NEED_BAR_BACK_RECTS["power"])
	_set_control_rect(host.food_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["food"])
	_set_control_rect(host.water_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["water"])
	_set_control_rect(host.power_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["power"])
	if host.food_need_icon != null:
		host.food_need_icon.position = host.SURVIVAL_NEED_ICON_POSITIONS["food"]
	if host.water_need_icon != null:
		host.water_need_icon.position = host.SURVIVAL_NEED_ICON_POSITIONS["water"]
	if host.power_need_icon != null:
		host.power_need_icon.position = host.SURVIVAL_NEED_ICON_POSITIONS["power"]
	if host.oxygen_icon != null:
		host.oxygen_icon.position = host.OXYGEN_ICON_POSITION
	if host.health_icon != null:
		host.health_icon.position = host.HEALTH_ICON_POSITION
	if host.depth_icon != null:
		host.depth_icon.position = host.DEPTH_ICON_POSITION
	_set_control_rect(host.depth_rail_line, host.DEPTH_RAIL_LINE_RECT)
	if host.depth_rail_labels.size() >= 3:
		_set_control_rect(host.depth_rail_labels[0], host.DEPTH_RAIL_LABEL_RECTS["0"])
		_set_control_rect(host.depth_rail_labels[1], host.DEPTH_RAIL_LABEL_RECTS["50"])
		_set_control_rect(host.depth_rail_labels[2], host.DEPTH_RAIL_LABEL_RECTS["100"])
	if host.cargo_slots_root != null:
		host.cargo_slots_root.position = host.CARGO_SLOT_ACTIVE_POSITION
	if host.daylight_sun_icon != null:
		host.daylight_sun_icon.position = host.DAYLIGHT_SUN_ICON_POSITION
	if host.daylight_moon_icon != null:
		host.daylight_moon_icon.position = host.DAYLIGHT_MOON_ICON_POSITION

	var bounded_labels: Array[Label] = [
		host.oxygen_label,
		host.health_label,
		host.depth_label,
		host.base_direction_label,
		host.cargo_label,
		host.daylight_label,
		host.discoveries_label,
		host.scan_target_label,
		host.scan_card_title_label,
		host.scan_card_meta_label,
		host.scan_card_prompt_label,
		host.objective_title_label,
		host.objective_line_label,
		host.prompt_label,
		host.status_label,
		host.food_need_label,
		host.water_need_label,
		host.power_need_label,
	]
	for label in host.depth_rail_labels:
		bounded_labels.append(label)
	for label in bounded_labels:
		if label != null:
			label.autowrap_mode = TextServer.AUTOWRAP_OFF
			label.clip_text = true

static func _set_control_rect(control: Control, rect: Rect2) -> void:
	if control == null:
		return
	control.position = rect.position
	control.size = rect.size
