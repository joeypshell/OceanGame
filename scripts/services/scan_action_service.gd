class_name ScanActionService
extends RefCounted

const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")
const ScanEffectTextServiceScript := preload("res://scripts/ui/scan_effect_text_service.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")

static func try_scan(host, requested_target: Node = null) -> void:
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var target: Node = requested_target if requested_target != null else ScanRuntimeServiceScript.nearest_scan_target(host)
	if target != null and not ScanTargetFeedbackServiceScript.scan_target_still_selectable(host, target):
		target = null
	if target == null:
		host.status_label.text = "No scan target nearby."
		host._update_hud()
		return

	var discovery_id := ScanTargetResolverScript.target_id(target)
	var display_name := ScanTargetResolverScript.display_name(target)
	if host.progression_state.has_discovery(discovery_id):
		ScanRuntimeServiceScript.activate_scan_effect(host, target)
		if discovery_id == "wreck_signal_cache" and host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID):
			host.run_echo_lens_echo_fired = true
			ScanRuntimeServiceScript.trigger_echo_lens_pulse(host)
		host.status_label.text = HudPresenterScript.compact_dive_status("%s known.%s" % [
			display_name,
			ScanEffectTextServiceScript.repeat_scan_effect_text(host, target) + ScanEffectTextServiceScript.signal_lens_pulse_text(host, target, ScanRuntimeServiceScript.nearest_matching_visible_resource(host, target) if target is ResourcePickup else null)
		])
		host._update_hud()
		return

	host.dive_session.drain_oxygen(host.scan_oxygen_cost)
	host.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(target),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(host, target)
	)
	host.run_completed_scans.append(discovery_id)
	ScanRuntimeServiceScript.activate_scan_effect(host, target)

	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host._fail_dive()
	else:
		SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
		host.status_label.text = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
			display_name,
			ScanEffectTextServiceScript.repeat_scan_effect_text(host, target) + ScanEffectTextServiceScript.first_scan_guidance(host, target)
		])
		host._update_hud()
