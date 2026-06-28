class_name Area01SourceMapOverlay
extends Node2D

const SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const LANE_COLOR := Color(0.0, 0.9, 1.0, 0.12)
const LANE_EDGE_COLOR := Color(0.0, 0.95, 1.0, 0.72)
const COLLISION_COLOR := Color(1.0, 0.18, 0.08, 0.18)
const COLLISION_EDGE_COLOR := Color(1.0, 0.22, 0.12, 0.84)
const POCKET_COLOR := Color(0.25, 1.0, 0.52, 0.86)
const RESOURCE_COLOR := Color(0.2, 1.0, 0.85, 0.92)
const SCANNABLE_COLOR := Color(1.0, 0.76, 0.18, 0.92)
const SCAN_RADIUS_COLOR := Color(0.95, 0.95, 0.25, 0.42)

@export var scan_range := 120.0

var source_map: Dictionary = {}
var load_error := ""

func _ready() -> void:
	name = "Area01SourceMapOverlay"
	z_index = 120
	visible = false
	load_source_map()

func _process(_delta: float) -> void:
	if visible:
		queue_redraw()

func set_debug_visible(enabled: bool) -> void:
	visible = enabled
	queue_redraw()

func load_source_map() -> bool:
	source_map = {}
	load_error = ""
	var file := FileAccess.open(SOURCE_MAP_PATH, FileAccess.READ)
	if file == null:
		load_error = "missing source map"
		return false

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		load_error = "source map parse failed"
		return false

	source_map = parsed as Dictionary
	queue_redraw()
	return true

func source_map_summary() -> Dictionary:
	return {
		"lanes": (source_map.get("playable_water_lanes", []) as Array).size(),
		"solids": (source_map.get("solid_terrain", []) as Array).size(),
		"pockets": (source_map.get("resource_pockets", []) as Array).size(),
		"rules": (source_map.get("validation_rules", []) as Array).size(),
	}

func _draw() -> void:
	if source_map.is_empty():
		return

	_draw_playable_lanes()
	_draw_mapped_collision()
	_draw_resource_pockets()
	_draw_runtime_scan_radius()
	_draw_runtime_targets()

func _draw_playable_lanes() -> void:
	var lanes: Array = source_map.get("playable_water_lanes", [])
	for lane in lanes:
		if typeof(lane) != TYPE_DICTIONARY:
			continue
		var points := _points_from_json((lane as Dictionary).get("approx_polygon", []))
		if points.size() < 3:
			continue
		draw_colored_polygon(points, LANE_COLOR)
		draw_polyline(_closed_points(points), LANE_EDGE_COLOR, 2.0)

func _draw_mapped_collision() -> void:
	var solids: Array = source_map.get("solid_terrain", [])
	for solid in solids:
		if typeof(solid) != TYPE_DICTIONARY:
			continue
		var path := String((solid as Dictionary).get("collision_path", ""))
		var collision := get_node_or_null("../%s" % path) as CollisionPolygon2D
		if collision == null or collision.disabled:
			continue
		var points := PackedVector2Array()
		for point in collision.polygon:
			points.append(to_local(collision.to_global(point)))
		if points.size() < 3:
			continue
		draw_colored_polygon(points, COLLISION_COLOR)
		draw_polyline(_closed_points(points), COLLISION_EDGE_COLOR, 2.5)

func _draw_resource_pockets() -> void:
	var pockets: Array = source_map.get("resource_pockets", [])
	for pocket in pockets:
		if typeof(pocket) != TYPE_DICTIONARY:
			continue
		var path := String((pocket as Dictionary).get("scene_path", ""))
		var node := get_node_or_null("../%s" % path) as Node2D
		if node == null:
			continue
		var position := to_local(node.global_position)
		_draw_cross(position, POCKET_COLOR, 18.0, 2.0)
		draw_arc(position, 28.0, 0.0, TAU, 32, POCKET_COLOR, 2.0)

func _draw_runtime_scan_radius() -> void:
	var player := get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var position := to_local(player.global_position)
	draw_arc(position, scan_range, 0.0, TAU, 48, SCAN_RADIUS_COLOR, 2.0)

func _draw_runtime_targets() -> void:
	for resource in get_tree().get_nodes_in_group("resource_pickups"):
		if resource is Node2D and resource.visible:
			_draw_square(to_local((resource as Node2D).global_position), RESOURCE_COLOR, 9.0)

	for target in get_tree().get_nodes_in_group("scannables"):
		if target is Node2D and target.visible:
			_draw_diamond(to_local((target as Node2D).global_position), SCANNABLE_COLOR, 11.0)

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points

	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))

	return points

func _closed_points(points: PackedVector2Array) -> PackedVector2Array:
	var closed := PackedVector2Array(points)
	if not closed.is_empty():
		closed.append(closed[0])
	return closed

func _draw_cross(position: Vector2, color: Color, radius: float, width: float) -> void:
	draw_line(position + Vector2(-radius, 0.0), position + Vector2(radius, 0.0), color, width)
	draw_line(position + Vector2(0.0, -radius), position + Vector2(0.0, radius), color, width)

func _draw_square(position: Vector2, color: Color, half_size: float) -> void:
	draw_rect(Rect2(position - Vector2(half_size, half_size), Vector2(half_size * 2.0, half_size * 2.0)), color, false, 2.0)

func _draw_diamond(position: Vector2, color: Color, radius: float) -> void:
	var points := PackedVector2Array([
		position + Vector2(0.0, -radius),
		position + Vector2(radius, 0.0),
		position + Vector2(0.0, radius),
		position + Vector2(-radius, 0.0),
	])
	draw_polyline(_closed_points(points), color, 2.0)
