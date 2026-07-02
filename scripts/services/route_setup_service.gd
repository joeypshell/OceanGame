class_name RouteSetupService
extends RefCounted

const ResourcePickupPresentationServiceScript := preload("res://scripts/ui/resource_pickup_presentation_service.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")

static func place_starter_resources_for_run(host) -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = host.progression_state.current_run_seed
	host.current_resource_cluster_pattern = resource_cluster_pattern_for_seed(
		host.progression_state.current_run_seed,
		host.RESOURCE_CLUSTER_PATTERNS
	)
	_ensure_route_refs(host)
	if host.deep_reward_lure != null:
		host.deep_reward_lure.visible = host.current_resource_cluster_pattern == "deep_reward"

	for pickup_name in host.STARTER_RESOURCE_PICKUP_NAMES:
		var pickup := host.get_node_or_null("ResourcePickups/%s" % pickup_name) as ResourcePickup
		if pickup == null:
			continue
		if pickup.definition == null:
			continue

		var candidates := spawn_positions_for_target(
			host,
			"resource",
			pickup.definition.id,
			host.current_resource_cluster_pattern
		)
		if candidates.is_empty():
			continue

		pickup.global_position = candidates[rng.randi_range(0, candidates.size() - 1)]

	ResourcePickupPresentationServiceScript.ensure_resource_role_visuals(host)
	place_predator_route_for_run(host, rng)
	place_lantern_ray_route_for_run(host, rng)

static func place_predator_route_for_run(host, rng: RandomNumberGenerator) -> void:
	var routes := spawn_routes_for_target(host, "creature", "gulper_eel", host.current_resource_cluster_pattern)
	if routes.is_empty():
		host.current_predator_route_id = "fixed"
		return

	var route_ids := routes.keys()
	route_ids.sort()
	host.current_predator_route_id = String(route_ids[rng.randi_range(0, route_ids.size() - 1)])
	var route: Dictionary = routes[host.current_predator_route_id]
	if not route.has("start") or not route.has("end"):
		push_warning("Predator route %s is missing start or end point." % host.current_predator_route_id)
		return

	if host.gulper_eel != null and host.gulper_eel.has_method("configure_patrol"):
		host.gulper_eel.configure_patrol(route["start"], route["end"])

	if host.predator_warning != null:
		host.predator_warning.global_position = route.get("warning", (route["start"] + route["end"]) * 0.5)

static func place_lantern_ray_route_for_run(host, rng: RandomNumberGenerator) -> void:
	var routes := spawn_routes_for_target(host, "creature", "lantern_ray", host.current_resource_cluster_pattern)
	if routes.is_empty():
		host.current_lantern_ray_route_id = "fixed"
		return

	var route_ids := routes.keys()
	route_ids.sort()
	host.current_lantern_ray_route_id = String(route_ids[rng.randi_range(0, route_ids.size() - 1)])
	var route: Dictionary = routes[host.current_lantern_ray_route_id]
	if not route.has("start") or not route.has("end"):
		push_warning("Lantern Ray route %s is missing start or end point." % host.current_lantern_ray_route_id)
		return

	var ray = host.lantern_ray_route
	if ray == null:
		ray = host.get_node_or_null("Creatures/LanternRayRoute")
		host.lantern_ray_route = ray
	if ray != null and ray.has_method("configure_patrol"):
		ray.configure_patrol(route["start"], route["end"])

static func resource_cluster_pattern_for_seed(seed: int, patterns: Array) -> String:
	return SpawnSelectionScript.cluster_pattern_for_seed(seed, patterns)

static func spawn_positions_for_target(host, category: String, target_id: String, cluster_pattern: String) -> Array[Vector2]:
	if host.starter_resource_candidates == null:
		return []
	return SpawnSelectionScript.positions_for_target(
		host.starter_resource_candidates,
		SpawnPointScript,
		category,
		target_id,
		cluster_pattern,
		host._current_condition_id()
	)

static func spawn_routes_for_target(host, category: String, target_id: String, cluster_pattern: String) -> Dictionary:
	if host.creature_route_candidates == null:
		return {}
	return SpawnSelectionScript.routes_for_target(
		host.creature_route_candidates,
		SpawnPointScript,
		category,
		target_id,
		cluster_pattern,
		host._current_condition_id()
	)

static func _ensure_route_refs(host) -> void:
	if host.starter_resource_candidates == null:
		host.starter_resource_candidates = host.get_node_or_null("StarterResourceCandidates") as Node2D
	if host.creature_route_candidates == null:
		host.creature_route_candidates = host.get_node_or_null("CreatureRouteCandidates") as Node2D
	if host.deep_reward_lure == null:
		host.deep_reward_lure = host.get_node_or_null("DeepRewardLure") as Node2D
	if host.predator_warning == null:
		host.predator_warning = host.get_node_or_null("Predators/PredatorWarning") as Node2D
	if host.gulper_eel == null:
		host.gulper_eel = host.get_node_or_null("Predators/GulperEel")
	if host.lantern_ray_route == null:
		host.lantern_ray_route = host.get_node_or_null("Creatures/LanternRayRoute")
