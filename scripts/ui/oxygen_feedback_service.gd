class_name OxygenFeedbackService
extends RefCounted

const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")

static func update_feedback(host) -> void:
	host.oxygen_warning_panel.visible = false
	host.oxygen_label.modulate = Color.WHITE
	host.base_direction_label.modulate = Color.WHITE
	host.oxygen_label.scale = Vector2.ONE
	host.base_direction_label.scale = Vector2.ONE

	if host.dive_session.result != host.DiveSessionScript.Result.DIVING or host.dive_session.max_oxygen <= 0.0:
		return

	var oxygen_state := HudPresenterScript.oxygen_state(host.dive_session.oxygen, host.dive_session.max_oxygen)
	var oxygen_color := HudPresenterScript.oxygen_state_color(oxygen_state)
	if oxygen_state == "critical":
		var pulse := 1.0 + 0.08 * absf(sin(Time.get_ticks_msec() / 90.0))
		host.oxygen_warning_panel.visible = true
		host.oxygen_warning_label.text = HudPresenterScript.oxygen_warning_text(oxygen_state)
		host.oxygen_warning_label.modulate = oxygen_color
		host.oxygen_label.modulate = oxygen_color
		host.base_direction_label.modulate = Color(1.0, 0.22, 0.14, 1.0)
		host.oxygen_label.scale = Vector2(pulse, pulse)
		host.base_direction_label.scale = Vector2(pulse, pulse)
	elif oxygen_state == "low":
		host.oxygen_warning_panel.visible = true
		host.oxygen_warning_label.text = HudPresenterScript.oxygen_warning_text(oxygen_state)
		host.oxygen_warning_label.modulate = oxygen_color
		host.oxygen_label.modulate = oxygen_color
		host.base_direction_label.modulate = Color(1.0, 0.86, 0.36, 1.0)
