class_name SurvivalNeedsPanelService
extends RefCounted

static func update_panel(host, is_visible: bool) -> void:
	var need_labels: Array[Label] = [host.food_need_label, host.water_need_label, host.power_need_label]
	var need_icons: Array[Polygon2D] = [host.food_need_icon, host.water_need_icon, host.power_need_icon]
	var need_bars: Array[ColorRect] = [
		host.food_need_bar_back,
		host.food_need_bar_fill,
		host.water_need_bar_back,
		host.water_need_bar_fill,
		host.power_need_bar_back,
		host.power_need_bar_fill,
	]
	for label in need_labels:
		label.visible = is_visible
	for icon in need_icons:
		icon.visible = is_visible
	for bar in need_bars:
		bar.visible = is_visible

	if not is_visible:
		return

	host.food_need_label.text = "FOOD %d / %d" % [host.survival_state.food, int(host.SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	host.water_need_label.text = "WATER %d / %d" % [host.survival_state.water, int(host.SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	host.power_need_label.text = "POWER %d / %d" % [host.survival_state.power, int(host.SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	host._set_bar_fill_width(host.food_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["food"], clampf(float(host.survival_state.food) / host.SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))
	host._set_bar_fill_width(host.water_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["water"], clampf(float(host.survival_state.water) / host.SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))
	host._set_bar_fill_width(host.power_need_bar_fill, host.SURVIVAL_NEED_BAR_BACK_RECTS["power"], clampf(float(host.survival_state.power) / host.SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))
