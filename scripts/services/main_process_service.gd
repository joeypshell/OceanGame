class_name MainProcessService
extends RefCounted

const RouteTimingCueServiceScript := preload("res://scripts/ui/route_timing_cue_service.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")

static func process_frame(host, delta: float) -> void:
	host._consume_visual_smoke_command()
	host._update_depth()
	if host._expedition_pressure_paused():
		host._update_hud()
		return

	ScanRuntimeServiceScript.update_glow_plankton_highlight(host, delta)
	ScanRuntimeServiceScript.update_resource_scan_highlight(host, delta)
	ScanRuntimeServiceScript.update_echo_lens_pulse(host, delta)
	RouteTimingCueServiceScript.update_east_shelf_current_surge(host, delta)
	RouteTimingCueServiceScript.update_blue_chimney_reverse_draft(host, delta)
	RouteTimingCueServiceScript.update_blackwater_pressure_cue(host, delta)
	RouteTimingCueServiceScript.update_lantern_ray_timing_lane(host, delta)
	RouteTimingCueServiceScript.update_hollow_reef_timing_current(host, delta)
	RouteTimingCueServiceScript.update_glassfin_swarm_spacing_cue(host, delta)
	RouteTimingCueServiceScript.update_salvage_silt_timing_cue(host, delta)
	RouteTimingCueServiceScript.update_outer_shelf_slackwater_timing_cue(host, delta)
	ScanRuntimeServiceScript.update_lantern_fry_idle(host)
	ScanRuntimeServiceScript.update_burst_thruster_cooldown(host, delta)
	ScanRuntimeServiceScript.update_scan_charge(host, delta)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		ScanTargetFeedbackServiceScript.update_scan_target_feedback(host)
		return

	host._advance_daylight_timer(delta)
	host._update_active_dive_oxygen(delta)
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host._fail_dive()
	else:
		host._update_hud()
