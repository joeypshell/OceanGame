class_name DaylightTimerHudService
extends RefCounted

const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")

static func update_timer(host, is_visible: bool) -> void:
	if host.daylight_panel != null:
		host.daylight_panel.visible = is_visible
	var daylight_nodes: Array[CanvasItem] = [
		host.daylight_label,
		host.daylight_bar_back,
		host.daylight_bar_fill,
		host.daylight_sun_icon,
		host.daylight_moon_icon,
	]
	for node in daylight_nodes:
		if node != null:
			node.visible = is_visible

	if not is_visible:
		return

	var remaining_ratio: float = host._daylight_remaining_ratio()
	if host.daylight_label != null:
		host.daylight_label.text = HudPresenterScript.format_daylight_label(host._daylight_remaining_seconds())
		host.daylight_label.modulate = HudPresenterScript.daylight_bar_color(remaining_ratio)
	if host.daylight_bar_fill != null:
		host.daylight_bar_fill.color = HudPresenterScript.daylight_bar_color(remaining_ratio)
		host._set_bar_fill_width(host.daylight_bar_fill, host.DAYLIGHT_BAR_FILL_RECT, remaining_ratio)
	if host.daylight_sun_icon != null:
		host.daylight_sun_icon.color = Color(1.0, 0.82, 0.22, 0.32 + remaining_ratio * 0.62)
	if host.daylight_moon_icon != null:
		host.daylight_moon_icon.color = Color(0.72, 0.78, 1.0, 0.34 + (1.0 - remaining_ratio) * 0.58)
