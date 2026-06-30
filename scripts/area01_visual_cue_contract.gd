class_name Area01VisualCueContract
extends RefCounted

const META_FAMILY := &"area01_visual_cue_family"
const META_SOURCE_ID := &"area01_visual_cue_source_id"

const FAMILY_SOLID_TERRAIN := "solid_terrain"
const FAMILY_TERRAIN_RIM_LIP := "terrain_rim_lip"
const FAMILY_PASSIVE_BACKGROUND := "passive_background_atmosphere"
const FAMILY_RETURN_CURRENT := "return_current_cue"
const FAMILY_TIMING_HAZARD_SUPPORT := "timing_hazard_support_cue"
const FAMILY_RESOURCE_PICKUP := "resource_pickup"
const FAMILY_KNOWLEDGE_PAYOFF := "knowledge_payoff"
const FAMILY_LOCKED_PROMISE := "locked_future_route_promise"
const FAMILY_ACTIVE_PROMPT_STATUS := "active_prompt_status_label"
const FAMILY_DEBUG_SOURCE_MAP_OVERLAY := "debug_source_map_overlay"
const FAMILY_UNKNOWN := "unregistered"

const SOLID_TERRAIN_COLOR := Color(0.42, 0.72, 0.68, 1.0)
const TERRAIN_RIM_COLOR := Color(0.46, 0.82, 0.76, 0.04)
const PASSIVE_BACKGROUND_COLOR := Color(0.04, 0.18, 0.26, 0.10)
const RETURN_CURRENT_COLOR := Color(0.20, 0.95, 0.68, 0.22)
const TIMING_SUPPORT_COLOR := Color(0.95, 0.74, 0.20, 0.20)
const RESOURCE_PICKUP_COLOR := Color(0.20, 1.0, 0.85, 0.92)
const KNOWLEDGE_PAYOFF_COLOR := Color(0.95, 0.78, 0.22, 0.86)
const LOCKED_PROMISE_COLOR := Color(0.90, 0.22, 0.38, 0.20)
const DEBUG_OVERLAY_COLOR := Color(0.0, 0.95, 1.0, 0.72)

static func contracts() -> Dictionary:
	return {
		FAMILY_SOLID_TERRAIN: _contract(3, 5, Vector2(0.85, 1.0), "cool reef teal fill", "none", ["passive background", "return current", "timing support"], ["resource pickups", "knowledge payoffs", "active prompts"], 99.0, 999),
		FAMILY_TERRAIN_RIM_LIP: _contract(4, 6, Vector2(0.03, 0.65), "cool cyan/teal edge read", "none unless locked/open state needs a compact badge", ["passive background"], ["solid terrain", "resource pickups", "knowledge payoffs"], 0.50, 18),
		FAMILY_PASSIVE_BACKGROUND: _contract(-20, 2, Vector2(0.02, 0.24), "deep blue/cyan atmosphere", "none", [], ["terrain", "pickups", "knowledge", "prompts"], 0.24, 999),
		FAMILY_RETURN_CURRENT: _contract(2, 7, Vector2(0.08, 0.32), "green/cyan directional current", "broad return text only when needed", ["passive background"], ["pickups", "knowledge", "active prompts"], 0.34, 6),
		FAMILY_TIMING_HAZARD_SUPPORT: _contract(2, 8, Vector2(0.08, 0.42), "warm amber/violet hazard or timing read", "compact local state, no exact route labels", ["passive background", "return current when it is the current decision"], ["pickups", "knowledge", "active prompts"], 0.44, 6),
		FAMILY_RESOURCE_PICKUP: _contract(5, 12, Vector2(0.70, 1.0), "bright cargo silhouette color", "no label unless prompt/status owns it", ["terrain rim", "return current", "timing support"], ["active prompts"], 0.90, 10),
		FAMILY_KNOWLEDGE_PAYOFF: _contract(5, 12, Vector2(0.55, 0.95), "cyan or amber compact core", "prompt/status confirms state", ["terrain rim", "return current", "timing support"], ["active prompts"], 0.82, 8),
		FAMILY_LOCKED_PROMISE: _contract(4, 10, Vector2(0.08, 0.38), "dark mouth with quiet seal/glint", "short locked/open badge only", ["passive background"], ["current pickups", "current knowledge", "active prompts"], 0.40, 5),
		FAMILY_ACTIVE_PROMPT_STATUS: _contract(20, 130, Vector2(0.80, 1.0), "HUD white/cyan/warning color", "short active command/status text", ["all world cues"], [], 0.95, 999),
		FAMILY_DEBUG_SOURCE_MAP_OVERLAY: _contract(100, 140, Vector2(0.12, 0.90), "developer cyan/orange overlay", "debug only", ["normal play cues while debug is visible"], [], 0.90, 999),
	}

static func required_family_ids() -> Array[String]:
	return [
		FAMILY_SOLID_TERRAIN,
		FAMILY_TERRAIN_RIM_LIP,
		FAMILY_PASSIVE_BACKGROUND,
		FAMILY_RETURN_CURRENT,
		FAMILY_TIMING_HAZARD_SUPPORT,
		FAMILY_RESOURCE_PICKUP,
		FAMILY_KNOWLEDGE_PAYOFF,
		FAMILY_LOCKED_PROMISE,
		FAMILY_ACTIVE_PROMPT_STATUS,
		FAMILY_DEBUG_SOURCE_MAP_OVERLAY,
	]

static func tag_node(node: Node, family: String, source_id: String = "") -> void:
	node.set_meta(META_FAMILY, family)
	if not source_id.is_empty():
		node.set_meta(META_SOURCE_ID, source_id)

static func family_for_node(node: Node) -> String:
	var cursor: Node = node
	while cursor != null:
		if cursor.has_meta(META_FAMILY):
			return String(cursor.get_meta(META_FAMILY))
		cursor = cursor.get_parent()
	return FAMILY_UNKNOWN

static func debug_report(root: Node, camera_region: Rect2 = Rect2()) -> Dictionary:
	var family_counts := {}
	var bright_counts := {}
	var warnings: Array[String] = []
	var total_visible := 0

	for node in _collect_canvas_items(root):
		var item := node as CanvasItem
		if not _is_effectively_visible(item):
			continue
		if camera_region.has_area() and not _node_overlaps_region(item, camera_region):
			continue

		total_visible += 1
		var family := family_for_node(item)
		family_counts[family] = int(family_counts.get(family, 0)) + 1
		var alpha := _effective_alpha(item)
		var contract := contracts().get(family, {}) as Dictionary
		var bright_threshold := float(contract.get("suspicious_alpha_min", 0.80))
		if alpha >= bright_threshold:
			bright_counts[family] = int(bright_counts.get(family, 0)) + 1

	for family in bright_counts.keys():
		var contract := contracts().get(family, {}) as Dictionary
		var budget := int(contract.get("max_bright_nodes_per_camera_region", 999))
		var count := int(bright_counts[family])
		if count > budget:
			warnings.append("%s has %d bright visible nodes in the review region; budget is %d" % [family, count, budget])

	return {
		"total_visible": total_visible,
		"families": family_counts,
		"bright_counts": bright_counts,
		"warnings": warnings,
	}

static func _contract(z_min: int, z_max: int, alpha_range: Vector2, color_family: String, label_policy: String, brighter_than: Array, quieter_than: Array, suspicious_alpha_min: float, max_bright_nodes: int) -> Dictionary:
	return {
		"z_index_min": z_min,
		"z_index_max": z_max,
		"alpha_min": alpha_range.x,
		"alpha_max": alpha_range.y,
		"color_family": color_family,
		"label_policy": label_policy,
		"brighter_than": brighter_than,
		"quieter_than": quieter_than,
		"suspicious_alpha_min": suspicious_alpha_min,
		"max_bright_nodes_per_camera_region": max_bright_nodes,
	}

static func _collect_canvas_items(root: Node) -> Array[CanvasItem]:
	var items: Array[CanvasItem] = []
	if root is CanvasItem:
		items.append(root as CanvasItem)
	for child in root.get_children():
		items.append_array(_collect_canvas_items(child))
	return items

static func _is_effectively_visible(item: CanvasItem) -> bool:
	var cursor: Node = item
	while cursor != null:
		if cursor is CanvasItem and not (cursor as CanvasItem).visible:
			return false
		cursor = cursor.get_parent()
	return true

static func _node_overlaps_region(item: CanvasItem, region: Rect2) -> bool:
	if family_for_node(item) == FAMILY_DEBUG_SOURCE_MAP_OVERLAY:
		return true
	if item is Polygon2D:
		return region.intersects(_global_polygon_bounds(item as Polygon2D))
	if item is Line2D:
		return region.intersects(_global_line_bounds(item as Line2D))
	if item is Sprite2D:
		return region.has_point((item as Sprite2D).global_position)
	if item is Node2D:
		return region.has_point((item as Node2D).global_position)
	return true

static func _global_polygon_bounds(polygon: Polygon2D) -> Rect2:
	var points := polygon.polygon
	if points.is_empty():
		return Rect2((polygon as Node2D).global_position, Vector2.ONE)

	var first := (polygon as Node2D).to_global(points[0])
	var min_x := first.x
	var max_x := first.x
	var min_y := first.y
	var max_y := first.y
	for point in points:
		var global_point := (polygon as Node2D).to_global(point)
		min_x = minf(min_x, global_point.x)
		max_x = maxf(max_x, global_point.x)
		min_y = minf(min_y, global_point.y)
		max_y = maxf(max_y, global_point.y)
	return Rect2(Vector2(min_x, min_y), Vector2(max_x - min_x, max_y - min_y))

static func _global_line_bounds(line: Line2D) -> Rect2:
	var points := line.points
	if points.is_empty():
		return Rect2((line as Node2D).global_position, Vector2.ONE)

	var first := (line as Node2D).to_global(points[0])
	var min_x := first.x
	var max_x := first.x
	var min_y := first.y
	var max_y := first.y
	for point in points:
		var global_point := (line as Node2D).to_global(point)
		min_x = minf(min_x, global_point.x)
		max_x = maxf(max_x, global_point.x)
		min_y = minf(min_y, global_point.y)
		max_y = maxf(max_y, global_point.y)
	var padding := maxf(line.width * 0.5, 1.0)
	return Rect2(Vector2(min_x - padding, min_y - padding), Vector2(max_x - min_x + padding * 2.0, max_y - min_y + padding * 2.0))

static func _effective_alpha(item: CanvasItem) -> float:
	var alpha := item.modulate.a
	if item is Polygon2D:
		alpha *= (item as Polygon2D).color.a
	elif item is Line2D:
		alpha *= (item as Line2D).default_color.a
	elif item is Sprite2D:
		alpha *= (item as Sprite2D).modulate.a
	return alpha
