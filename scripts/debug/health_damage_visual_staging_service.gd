class_name HealthDamageVisualStagingService
extends RefCounted

const PLAYER_PATH := "Player"
const THERMAL_VENT_PATH := "Discoveries/ThermalVent"

static func stage_visual_review(host) -> void:
	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	if staged_player == null:
		return

	var vent: Area2D = host.thermal_vent_hazard
	if vent == null:
		vent = host.get_node_or_null(THERMAL_VENT_PATH) as Area2D
	if vent == null:
		return

	host.player = staged_player
	host.player.global_position = vent.global_position + Vector2(96.0, -48.0)
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.player_in_surface_oxygen_refill = false
	host.dive_session.has_left_base = true
	host.dive_session.unlimited_oxygen = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.dive_session.health = host.dive_session.max_health
	host.visual_smoke_route_stage = "thermal_vent_health_damage"
	host._apply_health_damage(host.thermal_vent_health_damage, "thermal vent heat")
	host.visual_smoke_route_stage = "thermal_vent_health_damage"
	host._update_depth()
	host._update_hud()
