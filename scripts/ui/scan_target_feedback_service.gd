class_name ScanTargetFeedbackService
extends RefCounted

const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetCardServiceScript := preload("res://scripts/ui/scan_target_card_service.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")

static func update_scan_target_feedback(host) -> void:
	var next_target: Node = scan_target_candidate(host) if host.dive_session.result == host.DiveSessionScript.Result.DIVING else null
	if host.current_scan_target != next_target:
		if host.current_scan_target != null and host.current_scan_target.has_method("set_scan_selected"):
			host.current_scan_target.set_scan_selected(false)
		host.current_scan_target = next_target
		if host.current_scan_target != null and host.current_scan_target.has_method("set_scan_selected"):
			host.current_scan_target.set_scan_selected(true)

	ScanTargetCardServiceScript.update_card(host, host.current_scan_target)
	if host.current_scan_target == null:
		host.scan_reticle_root.visible = false
	else:
		update_scan_reticle_position(host, host.current_scan_target)

static func scan_target_candidate(host) -> Node:
	if scan_target_still_selectable(host, host.current_scan_target):
		return host.current_scan_target

	return host._nearest_scan_target()

static func scan_target_still_selectable(host, target: Node) -> bool:
	if target == null or host.player == null or not is_instance_valid(target):
		return false
	if not (target is Node2D):
		return false
	if not ScanTargetResolverScript.is_valid_target(target):
		return false

	return host.player.global_position.distance_to((target as Node2D).global_position) <= host.scan_range + host.SCAN_TARGET_STICKY_RANGE_BUFFER

static func update_scan_reticle_position(host, target: Node) -> void:
	if target == null or not (target is Node2D):
		host.scan_reticle_root.visible = false
		return

	var viewport_size: Vector2 = host.get_viewport_rect().size
	var screen_position: Vector2 = scan_reticle_screen_position(host, (target as Node2D).global_position)

	host.scan_reticle_root.visible = true
	host.scan_reticle_root.position = Vector2(
		clampf(screen_position.x, host.SCAN_RETICLE_SCREEN_MARGIN, viewport_size.x - host.SCAN_RETICLE_SCREEN_MARGIN),
		clampf(screen_position.y, host.SCAN_RETICLE_SCREEN_MARGIN, viewport_size.y - host.SCAN_RETICLE_SCREEN_MARGIN)
	)

static func scan_reticle_screen_position(host, world_position: Vector2) -> Vector2:
	var viewport_size: Vector2 = host.get_viewport_rect().size
	var canvas_transform: Transform2D = host.get_viewport().get_canvas_transform()
	if not canvas_transform.is_equal_approx(Transform2D.IDENTITY):
		return canvas_transform * world_position

	return scan_reticle_fallback_screen_position(host, world_position, viewport_size)

static func scan_reticle_fallback_screen_position(host, world_position: Vector2, viewport_size: Vector2) -> Vector2:
	var screen_position := viewport_size * 0.5
	if host.player == null:
		return screen_position

	var zoom := Vector2.ONE
	var camera := host.player.get_node_or_null("Camera2D") as Camera2D
	if camera != null:
		zoom = camera.zoom
	var world_delta: Vector2 = world_position - host.player.global_position
	return screen_position + Vector2(world_delta.x * maxf(zoom.x, 0.001), world_delta.y * maxf(zoom.y, 0.001))

static func format_scan_target_discovery_state(host, target: Node) -> String:
	return ScanFeedbackPresenterScript.format_scan_target_discovery_state(
		host.progression_state.has_discovery(ScanTargetResolverScript.target_id(target))
	)

static func format_scan_target_type(host, target: Node) -> String:
	return ScanFeedbackPresenterScript.format_scan_target_type(
		ScanTargetResolverScript.target_id(target),
		target is ResourcePickup
	)
