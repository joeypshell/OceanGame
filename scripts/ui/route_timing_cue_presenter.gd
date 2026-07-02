class_name RouteTimingCuePresenter
extends RefCounted


static func east_shelf_current_surge_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.08, 0.045)


static func blue_chimney_reverse_draft_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.07, 0.035)


static func blackwater_pressure_cue_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.1, 0.04)


static func lantern_ray_timing_lane_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.09, 0.035)


static func hollow_reef_timing_current_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.08, 0.035)


static func glassfin_swarm_spacing_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.08, 0.04)


static func salvage_silt_timing_alpha(timer_seconds: float, period_seconds: float) -> float:
	return _sine_alpha(timer_seconds, period_seconds, 0.07, 0.035)


static func outer_shelf_slackwater_alpha(timer_seconds: float, period_seconds: float) -> float:
	return 0.065 + outer_shelf_slackwater_window_ratio(timer_seconds, period_seconds) * 0.08


static func outer_shelf_slackwater_window_ratio(timer_seconds: float, period_seconds: float) -> float:
	var phase := sin((timer_seconds / period_seconds) * TAU)
	return (phase + 1.0) * 0.5


static func outer_shelf_slackwater_decision_state(
	timer_seconds: float,
	period_seconds: float,
	open_threshold: float,
	easing_threshold: float
) -> String:
	var window_ratio := outer_shelf_slackwater_window_ratio(timer_seconds, period_seconds)
	if window_ratio >= open_threshold:
		return "open"
	if window_ratio >= easing_threshold:
		return "easing"
	return "surging"


static func outer_shelf_slackwater_decision_prompt_for_timer(
	timer_seconds: float,
	period_seconds: float,
	open_threshold: float,
	easing_threshold: float
) -> String:
	return outer_shelf_slackwater_decision_prompt(
		outer_shelf_slackwater_decision_state(timer_seconds, period_seconds, open_threshold, easing_threshold)
	)


static func outer_shelf_slackwater_decision_prompt(state: String) -> String:
	match state:
		"open":
			return "Glass Rim slackwater: cross now or bank cargo"
		"easing":
			return "Glass Rim current easing: wait, cross, or turn back"
		_:
			return "Glass Rim surge: turn back or spend oxygen waiting"


static func outer_shelf_slackwater_decision_text_for_timer(
	timer_seconds: float,
	period_seconds: float,
	open_threshold: float,
	easing_threshold: float
) -> String:
	return outer_shelf_slackwater_decision_text(
		outer_shelf_slackwater_decision_state(timer_seconds, period_seconds, open_threshold, easing_threshold)
	)


static func outer_shelf_slackwater_decision_text(state: String) -> String:
	match state:
		"open":
			return "Glass Rim open: cross now or bank cargo."
		"easing":
			return "Glass Rim easing: wait, cross, or turn back."
		_:
			return "Glass Rim surge: turn back or wait."


static func _sine_alpha(timer_seconds: float, period_seconds: float, base_alpha: float, amplitude: float) -> float:
	var phase := sin((timer_seconds / period_seconds) * TAU)
	return base_alpha + (phase + 1.0) * amplitude
