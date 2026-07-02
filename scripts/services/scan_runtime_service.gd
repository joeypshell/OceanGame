class_name ScanRuntimeService
extends RefCounted

const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")

static func begin_scan_charge(host) -> void:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var target := ScanTargetFeedbackServiceScript.scan_target_candidate(host)
	if target == null:
		host.status_label.text = "No scan target nearby."
		host._update_hud()
		return

	host.scan_charge_target = target
	host.scan_charge_elapsed = 0.0
	host.scan_hold_active = true
	host.status_label.text = ScanFeedbackPresenterScript.format_scan_charge_target_status(target, host.scan_charge_elapsed, host.scan_hold_seconds)
	host._update_hud()

static func cancel_scan_charge(host, message := "") -> void:
	if host.scan_charge_target == null and not host.scan_hold_active:
		return
	host.scan_charge_target = null
	host.scan_charge_elapsed = 0.0
	host.scan_hold_active = false
	if not message.is_empty() and host.dive_session.result == host.DiveSessionScript.Result.DIVING:
		host.status_label.text = message
		host._update_hud()

static func update_scan_charge(host, delta: float) -> void:
	if host.scan_charge_target == null:
		return
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		cancel_scan_charge(host)
		return
	if not host.scan_hold_active:
		cancel_scan_charge(host, "Scan canceled.")
		return
	if not ScanTargetFeedbackServiceScript.scan_target_still_selectable(host, host.scan_charge_target):
		cancel_scan_charge(host, "Scan lost: target out of range.")
		return

	host.scan_charge_elapsed = minf(host.scan_hold_seconds, host.scan_charge_elapsed + delta)
	if host.scan_charge_elapsed >= host.scan_hold_seconds:
		var completed_target: Node = host.scan_charge_target
		host.scan_charge_target = null
		host.scan_charge_elapsed = 0.0
		host.scan_hold_active = false
		host._try_scan(completed_target)
	else:
		host.status_label.text = ScanFeedbackPresenterScript.format_scan_charge_target_status(host.scan_charge_target, host.scan_charge_elapsed, host.scan_hold_seconds)
		host._update_hud()

static func nearest_scan_target(host) -> Node:
	if not host.is_inside_tree():
		return null
	var candidates: Array[Node] = []
	for target in host.get_tree().get_nodes_in_group("scan_targets"):
		candidates.append(target)

	return ScanTargetResolverScript.nearest(host.player.global_position, host.scan_range, candidates)

static func activate_scan_effect(host, target: Node) -> void:
	host.decoy_pulse_activated_this_scan = false
	if target is ResourcePickup:
		host.resource_scan_highlight_id = target.definition.id
		host.resource_scan_highlight_timer = 8.0
	elif ScanTargetResolverScript.target_id(target) == "lantern_fry":
		host.glow_plankton_highlight_timer = 8.0
	elif ScanTargetResolverScript.target_id(target) == "thermal_vent":
		host._reveal_thermal_vent_route()
	elif ScanTargetResolverScript.target_id(target) == "pressure_wreck_signal":
		host._reveal_pressure_wreck_signal()
	elif ScanTargetResolverScript.target_id(target) == "gulper_eel":
		try_trigger_decoy_pulse(host)

static func trigger_echo_lens_pulse(host) -> void:
	host.echo_lens_pulse_timer = host.ECHO_LENS_PULSE_DURATION
	host.echo_lens_pulse.visible = true
	host.echo_lens_pulse.scale = Vector2(1.4, 1.4)
	host.echo_lens_pulse.modulate = Color(1.0, 1.0, 1.0, 0.9)

static func update_echo_lens_pulse(host, delta: float) -> void:
	if host.echo_lens_pulse_timer <= 0.0:
		host.echo_lens_pulse.visible = false
		return

	host.echo_lens_pulse_timer = maxf(host.echo_lens_pulse_timer - delta, 0.0)
	var age_ratio: float = 1.0 - (host.echo_lens_pulse_timer / host.ECHO_LENS_PULSE_DURATION)
	var pulse_scale: float = lerpf(1.4, 2.2, age_ratio)
	host.echo_lens_pulse.scale = Vector2(pulse_scale, pulse_scale)
	host.echo_lens_pulse.modulate = Color(1.0, 1.0, 1.0, lerpf(0.9, 0.0, age_ratio))
	if host.echo_lens_pulse_timer <= 0.0:
		host.echo_lens_pulse.visible = false

static func try_trigger_decoy_pulse(host) -> bool:
	if not host.progression_state.has_upgrade(host.DECOY_PULSE_UPGRADE_ID):
		return false
	if host.decoy_pulse_used_this_run:
		return false
	if host.gulper_eel == null or not host.gulper_eel.has_method("trigger_decoy_from"):
		return false

	host.gulper_eel.trigger_decoy_from(host.player.global_position, host.decoy_pulse_duration_seconds, host.decoy_pulse_pull_distance)
	host.decoy_pulse_used_this_run = true
	host.decoy_pulse_activated_this_scan = true
	host.status_label.text = "Decoy Pulse: Gulper Eel distracted briefly."
	return true

static func nearest_matching_visible_resource(host, source: ResourcePickup) -> ResourcePickup:
	if not host.is_inside_tree():
		return null
	var nearest: ResourcePickup = null
	var nearest_distance := INF
	for pickup in host.get_tree().get_nodes_in_group("resource_pickups"):
		if pickup == source or not pickup is ResourcePickup:
			continue
		if pickup.definition == null or source.definition == null:
			continue
		if pickup.definition.id != source.definition.id:
			continue
		if pickup.is_collected or not pickup.visible:
			continue

		var distance := source.global_position.distance_to(pickup.global_position)
		if distance < nearest_distance:
			nearest = pickup
			nearest_distance = distance

	return nearest

static func update_glow_plankton_highlight(host, delta: float) -> void:
	if host.glow_plankton_highlight_timer <= 0.0:
		host.glow_plankton_visual.scale = Vector2.ONE
		host.glow_plankton_visual.modulate = Color.WHITE
		return

	host.glow_plankton_highlight_timer = maxf(0.0, host.glow_plankton_highlight_timer - delta)
	var pulse := 1.0 + 0.24 * absf(sin(Time.get_ticks_msec() / 120.0))
	host.glow_plankton_visual.scale = Vector2(pulse, pulse)
	host.glow_plankton_visual.modulate = Color(1.2, 1.2, 0.7, 1.0)

static func update_resource_scan_highlight(host, delta: float) -> void:
	if host.resource_scan_highlight_timer > 0.0:
		host.resource_scan_highlight_timer = maxf(0.0, host.resource_scan_highlight_timer - delta)
	elif not host.resource_scan_highlight_id.is_empty():
		host.resource_scan_highlight_id = ""

	if not host.is_inside_tree():
		return
	for pickup in host.get_tree().get_nodes_in_group("resource_pickups"):
		if pickup is ResourcePickup:
			var highlighted: bool = (
				host.resource_scan_highlight_timer > 0.0
				and pickup.definition != null
				and pickup.definition.id == host.resource_scan_highlight_id
				and not pickup.is_collected
				and pickup.visible
			)
			pickup.set_tactical_highlight(highlighted)

static func update_lantern_fry_idle(host) -> void:
	var pulse := 0.5 + 0.5 * sin(Time.get_ticks_msec() / 360.0)
	var bob := sin(Time.get_ticks_msec() / 520.0) * 3.0
	var visual_scale := 1.0 + pulse * 0.08
	host.lantern_fry_sprite_anchor.position.y = bob
	host.lantern_fry_sprite_anchor.scale = Vector2(visual_scale, visual_scale)
	host.lantern_fry_visual_root.position.y = bob
	host.lantern_fry_visual_root.scale = Vector2(visual_scale, visual_scale)
	host.lantern_fry_glow.color = Color(0.7, 1.0, 0.35, 0.18 + pulse * 0.18)

static func update_burst_thruster_cooldown(host, delta: float) -> void:
	if host.burst_thruster_cooldown_remaining <= 0.0:
		return

	host.burst_thruster_cooldown_remaining = maxf(0.0, host.burst_thruster_cooldown_remaining - delta)
