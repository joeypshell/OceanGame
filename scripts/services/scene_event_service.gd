class_name SceneEventService
extends RefCounted

const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const HealthFeedbackServiceScript := preload("res://scripts/ui/health_feedback_service.gd")
const HudInstrumentBarServiceScript := preload("res://scripts/ui/hud_instrument_bar_service.gd")
const ResourcePickupPresentationServiceScript := preload("res://scripts/ui/resource_pickup_presentation_service.gd")
const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")

static func apply_health_damage(host, amount: float, source: String) -> void:
	_ensure_hud_refs(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return
	if amount <= 0.0:
		return

	var health_before: float = host.dive_session.health
	host.dive_session.damage_health(amount)
	if host.dive_session.health >= health_before:
		return

	host.run_health_damage_events += 1
	host.last_health_damage_source = source
	host.last_health_damage_amount = health_before - host.dive_session.health
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host.run_failure_cause = "health depleted by %s" % source
		if host.is_inside_tree():
			host._fail_dive()
		return

	if host.status_label != null:
		host.status_label.text = HealthFeedbackPresenterScript.format_damage_status(source, host.last_health_damage_amount)
	HealthFeedbackServiceScript.update_feedback(host)
	if host.health_bar_fill != null:
		HudInstrumentBarServiceScript.update_bars(host)
	if host.is_inside_tree():
		host._update_hud()

static func on_wreck_echo_clue_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player or host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return
	if not host._wreck_echo_route_available():
		return
	if host.run_wreck_echo_clue_recovered:
		return

	host.run_wreck_echo_clue_recovered = true
	host.status_label.text = "Wreck Echo clue recovered: return to base to keep the research."
	host._sync_wreck_echo_state()
	host._update_hud()

static func on_resource_pickup_collected(pickup: Node, host) -> void:
	_ensure_hud_refs(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	if not host.dive_session.add_cargo(pickup.definition.id):
		host.status_label.text = SurfaceStatusPresenterScript.cargo_full_status_for_host(host)
		host._update_hud()
		return

	pickup.collect()
	host.run_collected_resources.append(pickup.definition.id)
	host.dive_session.drain_oxygen(host.collect_oxygen_cost)
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host.run_failure_cause = "oxygen depleted after collecting %s" % pickup.definition.display_name
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host._fail_dive()
	else:
		host.status_label.text = "Collected %s. %s" % [
			pickup.definition.display_name,
			ResourcePickupPresentationServiceScript.resource_pickup_feedback(host, pickup.definition.id),
		]
		host._update_hud()

static func on_predator_contacted(predator: Node, host) -> void:
	_ensure_hud_refs(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var knockback_direction: Vector2 = host.player.global_position - predator.global_position
	if knockback_direction == Vector2.ZERO:
		knockback_direction = Vector2.UP

	host.player.apply_knockback(knockback_direction, 520.0, 0.55)
	host.run_predator_contacts += 1
	host.dive_session.drain_oxygen(host.predator_contact_oxygen_cost)
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host.run_failure_cause = "oxygen depleted after predator contact"
	if host.dive_session.result == host.DiveSessionScript.Result.FAILED:
		host._fail_dive()
	else:
		host.status_label.text = "Predator strike: oxygen lost, controls disrupted."
		host._update_hud()

static func on_thermal_vent_hazard_body_entered(body: Node2D, host) -> void:
	if body != host.player:
		return

	apply_health_damage(host, host.thermal_vent_health_damage, "thermal vent heat")

static func on_pressure_boundary_body_entered(body: Node2D, host) -> void:
	_ensure_hud_refs(host)
	if body != host.player or host.progression_state.has_upgrade(host.PRESSURE_SEAL_UPGRADE_ID):
		return

	host.player.global_position.x = minf(host.player.global_position.x, host.pressure_boundary.global_position.x - 86.0)
	host.player.velocity = Vector2(-120.0, -60.0)
	host.status_label.text = "Pressure route locked: buy Pressure Seal I at the surface, then return."
	host._update_hud()

static func _ensure_hud_refs(host) -> void:
	if host.has_method("_ensure_active_hud_references"):
		host._ensure_active_hud_references()
