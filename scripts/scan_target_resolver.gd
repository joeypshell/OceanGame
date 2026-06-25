class_name ScanTargetResolver
extends RefCounted

static func nearest(player_position: Vector2, scan_range: float, targets: Array[Node]) -> Node:
	var candidates: Array[Node] = []
	for target in targets:
		if not is_valid_target(target):
			continue
		if player_position.distance_to(target.global_position) <= scan_range:
			candidates.append(target)

	candidates.sort_custom(func(a: Node, b: Node) -> bool:
		var distance_a := player_position.distance_to(a.global_position)
		var distance_b := player_position.distance_to(b.global_position)
		if not is_equal_approx(distance_a, distance_b):
			return distance_a < distance_b
		return target_id(a) < target_id(b)
	)

	return null if candidates.is_empty() else candidates[0]

static func is_valid_target(target: Node) -> bool:
	if target is ResourcePickup:
		return not target.is_collected and target.visible and target.definition != null

	return target.has_method("set_scan_selected") and not String(target.get("discovery_id")).is_empty()

static func target_id(target: Node) -> String:
	if target is ResourcePickup:
		return "resource_%s" % target.definition.id

	return String(target.get("discovery_id"))

static func display_name(target: Node) -> String:
	if target is ResourcePickup:
		return target.definition.display_name

	return String(target.get("display_name"))

static func description(target: Node) -> String:
	if target is ResourcePickup:
		return target.definition.scan_description

	return String(target.get("description"))
