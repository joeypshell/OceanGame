class_name SpawnSelection
extends RefCounted

static func cluster_pattern_for_seed(seed: int, patterns: Array) -> String:
	if patterns.is_empty():
		return ""

	return String(patterns[seed % patterns.size()])

static func positions_for_target(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String, condition_id := "") -> Array[Vector2]:
	var points: Array[SpawnPoint] = []
	_collect_points(root, spawn_point_script, category, target_id, cluster_pattern, points)
	points = _condition_weighted_points(points, category, target_id, condition_id)

	var positions: Array[Vector2] = []
	for point in points:
		positions.append(point.global_position)
	return positions

static func routes_for_target(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String) -> Dictionary:
	var points: Array[SpawnPoint] = []
	_collect_points(root, spawn_point_script, category, target_id, cluster_pattern, points)
	var routes := {}
	for point in points:
		if point.route_id.is_empty():
			continue
		if not routes.has(point.route_id):
			routes[point.route_id] = {}
		routes[point.route_id][point.spawn_id] = point.global_position

	return routes

static func _collect_points(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String, points: Array[SpawnPoint]) -> void:
	for child in root.get_children():
		if _is_matching_spawn_point(child, spawn_point_script, category, target_id, cluster_pattern):
			points.append(child)
		_collect_points(child, spawn_point_script, category, target_id, cluster_pattern, points)

static func _condition_weighted_points(points: Array[SpawnPoint], category: String, target_id: String, condition_id: String) -> Array[SpawnPoint]:
	if condition_id != "thermal_bloom":
		return points
	if category != "resource" or target_id != "glow_plankton":
		return points

	var preferred: Array[SpawnPoint] = []
	for point in points:
		if point.preferred_condition_id == condition_id:
			preferred.append(point)

	return preferred if not preferred.is_empty() else points

static func _is_matching_spawn_point(node: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String) -> bool:
	if node.get_script() != spawn_point_script:
		return false
	if not node.matches(category, target_id):
		return false

	return node.cluster_pattern == "any" or node.cluster_pattern == cluster_pattern
