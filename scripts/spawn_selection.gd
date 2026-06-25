class_name SpawnSelection
extends RefCounted

static func cluster_pattern_for_seed(seed: int, patterns: Array) -> String:
	if patterns.is_empty():
		return ""

	return String(patterns[seed % patterns.size()])

static func positions_for_target(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	_collect_positions(root, spawn_point_script, category, target_id, cluster_pattern, positions)
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

static func _collect_positions(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String, positions: Array[Vector2]) -> void:
	for child in root.get_children():
		if _is_matching_spawn_point(child, spawn_point_script, category, target_id, cluster_pattern):
			positions.append(child.global_position)
		_collect_positions(child, spawn_point_script, category, target_id, cluster_pattern, positions)

static func _collect_points(root: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String, points: Array[SpawnPoint]) -> void:
	for child in root.get_children():
		if _is_matching_spawn_point(child, spawn_point_script, category, target_id, cluster_pattern):
			points.append(child)
		_collect_points(child, spawn_point_script, category, target_id, cluster_pattern, points)

static func _is_matching_spawn_point(node: Node, spawn_point_script: Script, category: String, target_id: String, cluster_pattern: String) -> bool:
	if node.get_script() != spawn_point_script:
		return false
	if not node.matches(category, target_id):
		return false

	return node.cluster_pattern == "any" or node.cluster_pattern == cluster_pattern
