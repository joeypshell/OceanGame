class_name DaylightRuntimeService
extends RefCounted

static func advance_daylight_timer(host, delta: float) -> void:
	if host.daylight_duration_seconds <= 0.0 or host.daylight_nightfall_announced:
		return

	host.daylight_elapsed_seconds = minf(host.daylight_duration_seconds, host.daylight_elapsed_seconds + maxf(delta, 0.0))
	if host.daylight_elapsed_seconds >= host.daylight_duration_seconds:
		handle_daylight_expired(host)

static func handle_daylight_expired(host) -> void:
	host.daylight_nightfall_announced = true
	host.daylight_elapsed_seconds = maxf(host.daylight_elapsed_seconds, host.daylight_duration_seconds)
	host.daylight_nightfall_away_from_ship = not host.player_in_base
	if host.status_label != null:
		if host.daylight_nightfall_away_from_ship:
			host.status_label.text = "Nightfall: emergency return. Cargo stays at risk; ship spends extra Power."
		else:
			host.status_label.text = "Nightfall reached: start night at ship."

static func set_daylight_progress_for_debug(host, progress_ratio: float) -> void:
	var clamped_progress := clampf(progress_ratio, 0.0, 1.0)
	host.daylight_elapsed_seconds = maxf(0.0, host.daylight_duration_seconds) * clamped_progress
	host.daylight_nightfall_announced = clamped_progress >= 1.0
	host.daylight_nightfall_away_from_ship = false

static func daylight_remaining_seconds(host) -> float:
	return maxf(0.0, host.daylight_duration_seconds - host.daylight_elapsed_seconds)

static func daylight_remaining_ratio(host) -> float:
	if host.daylight_duration_seconds <= 0.0:
		return 0.0

	return clampf(daylight_remaining_seconds(host) / host.daylight_duration_seconds, 0.0, 1.0)

static func should_warn_late_day_cargo_banking(host) -> bool:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return false
	if host.daylight_nightfall_announced:
		return false
	if host.player_in_base:
		return false
	if host.dive_session.current_cargo.is_empty():
		return false

	return daylight_remaining_ratio(host) <= host.LATE_DAY_CARGO_WARNING_RATIO

static func visual_late_day_cargo_warning_visible(host) -> bool:
	var prompt_text: String = host.prompt_label.text if host.prompt_label != null else ""
	var objective_text: String = host.objective_line_label.text if host.objective_line_label != null else ""
	return prompt_text.contains("Power risk") or objective_text.contains("Dusk: bank cargo soon")
