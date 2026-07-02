class_name HealthDamageVisualStagingService
extends RefCounted

const SceneEventServiceScript := preload("res://scripts/services/scene_event_service.gd")

const PLAYER_PATH := "Player"
const BASE_ZONE_PATH := "BaseZone"
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
	SceneEventServiceScript.apply_health_damage(host, host.thermal_vent_health_damage, "thermal vent heat")
	host.visual_smoke_route_stage = "thermal_vent_health_damage"
	host._update_depth()
	host._update_hud()

static func stage_extraction_visual_review(host) -> void:
	if host.run_health_damage_events == 0 or host.dive_session.health >= host.dive_session.max_health:
		stage_visual_review(host)
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	var staged_player: CharacterBody2D = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null(PLAYER_PATH) as CharacterBody2D
	var review_base: Area2D = host.base_zone
	if review_base == null:
		review_base = host.get_node_or_null(BASE_ZONE_PATH) as Area2D
	if staged_player == null or review_base == null:
		return

	host.player = staged_player
	host.player.global_position = review_base.global_position
	host.player.velocity = Vector2.ZERO
	host.player_in_base = true
	host.player_in_surface_oxygen_refill = true
	host.dive_session.has_left_base = true
	host._try_extract()
	host.visual_smoke_route_stage = "health_damage_extracted"
	host._update_hud()
