class_name ScanFeedbackPresenter
extends RefCounted

const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")

static func format_scan_charge_target_status(target: Node, scan_charge_elapsed: float, scan_hold_seconds: float) -> String:
	return format_scan_charge_status(
		ScanTargetResolverScript.display_name(target),
		scan_charge_ratio(scan_charge_elapsed, scan_hold_seconds)
	)

static func format_scan_charge_status(display_name: String, charge_ratio: float) -> String:
	var percent := int(roundf(clampf(charge_ratio, 0.0, 1.0) * 100.0))
	return "Scanning %s: %d%%" % [display_name, percent]

static func scan_charge_ratio(scan_charge_elapsed: float, scan_hold_seconds: float) -> float:
	if scan_hold_seconds <= 0.0:
		return 1.0
	return clampf(scan_charge_elapsed / scan_hold_seconds, 0.0, 1.0)

static func format_repeat_scan_effect_text(
	target_id: String,
	is_resource: bool,
	resource_display_name: String,
	wreck_cache_repeat_hint: String,
	decoy_pulse_scan_feedback: String
) -> String:
	if is_resource:
		return " Matching %s deposits highlighted." % resource_display_name
	match target_id:
		"lantern_fry":
			return " Nearby Glow Plankton pulsed again."
		"lantern_ray":
			return " Lantern Ray route observation refreshed."
		"hollow_reef_skitter":
			return " Hollow Reef Skitter observation refreshed."
		"glassfin_swarm":
			return " Glassfin Swarm spacing observation refreshed."
		"mirrorfin_drift":
			return " Mirrorfin reflection observation refreshed."
		"glass_ray_drifter":
			return " Glass Ray slackwater observation refreshed."
		"thermal_vent":
			return " Warm clue refreshed; glow route optional."
		"shell_reef_shelf":
			return " Reef route clue refreshed."
		"wreck_signal_cache":
			return wreck_cache_repeat_hint
		"gulper_eel":
			return " %s" % decoy_pulse_scan_feedback
	return ""

static func format_wreck_cache_repeat_hint(has_echo_lens: bool, has_signal_lens: bool) -> String:
	if has_echo_lens:
		return " Echo Lens: weak wreck echo lingers below the shelf."
	if has_signal_lens:
		return " Cache echo unresolved: future Echo Lens study may read deeper wreck signals."

	return " Cache clue refreshed for Signal Lens I."

static func format_signal_lens_pulse_text(
	has_signal_lens: bool,
	is_resource: bool,
	has_match: bool,
	direction_to_match: String,
	resource_display_name: String
) -> String:
	if not has_signal_lens or not is_resource:
		return ""
	if not has_match:
		return " Signal Lens quiet: no matching visible deposits."

	return " Signal Lens pulse leans %s toward another %s." % [
		direction_to_match,
		resource_display_name,
	]

static func format_direction_to(origin_position: Vector2, target_position: Vector2) -> String:
	var delta := target_position - origin_position
	var horizontal := ""
	if absf(delta.x) > 48.0:
		horizontal = "right" if delta.x > 0.0 else "left"

	var vertical := ""
	if absf(delta.y) > 48.0:
		vertical = "deeper" if delta.y > 0.0 else "up"

	if not horizontal.is_empty() and not vertical.is_empty():
		return "%s-%s" % [vertical, horizontal]
	elif not vertical.is_empty():
		return vertical
	elif not horizontal.is_empty():
		return horizontal

	return "nearby"

static func format_first_scan_guidance(
	target_id: String,
	is_resource: bool,
	role_guidance: String,
	cargo_count: int,
	cargo_limit: int,
	has_pressure_seal: bool
) -> String:
	if is_resource:
		if cargo_count >= cargo_limit:
			return " Cargo full: return to ship to bank before collecting more."
		elif cargo_count == cargo_limit - 1:
			return " Last slot: %s Return to ship if this is the right cargo." % role_guidance
		return " %s Return to ship to bank it." % role_guidance

	match target_id:
		"lantern_fry":
			return " Follow the plankton pulse if oxygen allows, then return to base."
		"lantern_ray":
			return " Observe its calm pass, then return through Blackwater."
		"hollow_reef_skitter":
			return " Observe the upper shelf timing, then return through Hollow Reef."
		"glassfin_swarm":
			return " Observe the spacing lane, pass around the swarm, then return through Hollow Reef."
		"mirrorfin_drift":
			return " Observe the reflection break, pass after the shimmer, then return through Wide Reef."
		"glass_ray_drifter":
			return " Observe its turn, cross on slackwater if oxygen allows, or bank cargo."
		"thermal_vent":
			return " Warm current marks optional glow; bank Pressure Seal clue."
		"shell_reef_shelf":
			return " Reef marks a safer midwater bank route."
		"pressure_wreck_signal":
			if has_pressure_seal:
				return " Pressure Seal active: enter and scan cache if oxygen allows."
			return " Locked: buy Pressure Seal I, then return."
		"wreck_signal_cache":
			return " Bank cache clue for future scanner upgrades."
		"gulper_eel":
			return " Time warning current, or return with cargo."
		_:
			return " Use the clue if it helps, then return to base before oxygen runs out."

static func format_scan_target_discovery_state(is_known: bool) -> String:
	return "known" if is_known else "new"

static func format_scan_target_type(target_id: String, is_resource: bool) -> String:
	if is_resource:
		return "resource"
	match target_id:
		"lantern_fry", "lantern_ray", "hollow_reef_skitter", "glassfin_swarm", "mirrorfin_drift", "gulper_eel":
			return "creature"
		"thermal_vent", "shell_reef_shelf":
			return "environment"
		"pressure_wreck_signal", "wreck_signal_cache":
			return "wreck signal"
		_:
			return "clue"
