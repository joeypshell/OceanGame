class_name HealthFeedbackService
extends RefCounted

const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")

static func update_feedback(host) -> void:
	if host.health_label == null:
		return

	host.health_label.modulate = Color.WHITE
	host.health_label.scale = Vector2.ONE
	if host.health_icon != null:
		host.health_icon.modulate = Color.WHITE
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or host.dive_session.max_health <= 0.0:
		return

	var health_state := HudPresenterScript.health_state(host.dive_session.health, host.dive_session.max_health)
	var health_color := HudPresenterScript.health_state_color(health_state)
	if health_state == "critical":
		var pulse := 1.0 + 0.07 * absf(sin(Time.get_ticks_msec() / 110.0))
		host.health_label.modulate = health_color
		host.health_label.scale = Vector2(pulse, pulse)
		if host.health_icon != null:
			host.health_icon.modulate = health_color
	elif health_state == "low":
		host.health_label.modulate = health_color
		if host.health_icon != null:
			host.health_icon.modulate = health_color
	elif host._has_recent_health_damage():
		host.health_label.modulate = HudPresenterScript.HEALTH_DAMAGED_COLOR
		if host.health_icon != null:
			host.health_icon.modulate = HudPresenterScript.HEALTH_DAMAGED_COLOR
