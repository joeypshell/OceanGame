class_name HudInstrumentBarService
extends RefCounted

static func update_bars(host) -> void:
	var oxygen_ratio := 0.0
	if host.dive_session.max_oxygen > 0.0:
		oxygen_ratio = clampf(host.dive_session.oxygen / host.dive_session.max_oxygen, 0.0, 1.0)
	host._set_bar_fill_width(host.oxygen_bar_fill, host.OXYGEN_BAR_FILL_RECT, oxygen_ratio)

	var health_ratio := 0.0
	if host.dive_session.max_health > 0.0:
		health_ratio = clampf(host.dive_session.health / host.dive_session.max_health, 0.0, 1.0)
	host._set_bar_fill_width(host.health_bar_fill, host.HEALTH_BAR_FILL_RECT, health_ratio)
	if host.health_bar_fill != null:
		var health_state := host.HudPresenterScript.health_state(host.dive_session.health, host.dive_session.max_health)
		host.health_bar_fill.color = host.HudPresenterScript.HEALTH_DAMAGED_COLOR if health_state == "normal" and host._has_recent_health_damage() else host.HudPresenterScript.health_state_color(health_state)

	var depth_ratio := clampf(host.dive_session.current_depth / 200.0, 0.0, 1.0)
	host._set_bar_fill_width(host.depth_bar_fill, host.DEPTH_BAR_FILL_RECT, depth_ratio)
