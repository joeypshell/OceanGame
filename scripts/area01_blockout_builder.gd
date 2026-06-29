class_name Area01BlockoutBuilder
extends RefCounted

const SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const SOLID_COLOR := Color(0.008, 0.035, 0.042, 1.0)
const LIP_COLOR := Color(0.35, 0.62, 0.58, 0.08)

var last_error := ""

func build(scene_root: Node) -> bool:
	last_error = ""
	var source_map := _load_source_map()
	if source_map.is_empty():
		return false

	_prepare_area01_for_authority(scene_root)
	for terrain in source_map.get("solid_terrain", []):
		if typeof(terrain) != TYPE_DICTIONARY:
			last_error = "solid terrain entry is not a dictionary"
			return false
		if not _apply_solid_terrain(scene_root, terrain as Dictionary):
			return false

	return true

func _load_source_map() -> Dictionary:
	var file := FileAccess.open(SOURCE_MAP_PATH, FileAccess.READ)
	if file == null:
		last_error = "missing Area 01 source map"
		return {}

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		last_error = "Area 01 source map parse failed"
		return {}

	return parsed as Dictionary

func _prepare_area01_for_authority(scene_root: Node) -> void:
	for path in [
		"Area01ArtSlice/BackgroundMid",
		"Area01ArtSlice/ForegroundDecor",
	]:
		var node := scene_root.get_node_or_null(path) as CanvasItem
		if node != null:
			node.visible = false

	var parallax := scene_root.get_node_or_null("Area01ArtSlice/OceanParallaxBackground") as CanvasItem
	if parallax != null:
		parallax.modulate.a = 0.32

	var terrain_back := scene_root.get_node_or_null("Area01ArtSlice/TerrainBackWalls")
	if terrain_back != null:
		if terrain_back is CanvasItem:
			(terrain_back as CanvasItem).z_index = 3
		for child in terrain_back.get_children():
			if child is Polygon2D:
				(child as Polygon2D).visible = false

	var terrain_collision := scene_root.get_node_or_null("Area01ArtSlice/TerrainCollision")
	if terrain_collision != null:
		for child in terrain_collision.get_children():
			if child is CollisionPolygon2D:
				(child as CollisionPolygon2D).disabled = true

	var visual_edges := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges")
	if visual_edges != null:
		for child in visual_edges.get_children():
			if child.name != "CollisionReadBoundaries" and child is CanvasItem:
				(child as CanvasItem).visible = false

	var collision_boundaries := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries")
	if collision_boundaries != null:
		if collision_boundaries is CanvasItem:
			(collision_boundaries as CanvasItem).z_index = 4
		for child in collision_boundaries.get_children():
			if child is Polygon2D:
				(child as Polygon2D).visible = false

func _apply_solid_terrain(scene_root: Node, terrain: Dictionary) -> bool:
	var terrain_id := String(terrain.get("id", "unknown"))
	var points := _points_from_json(terrain.get("polygon", []))
	if points.size() < 3:
		last_error = "solid terrain entry lacks polygon: %s" % terrain_id
		return false

	var visible := scene_root.get_node_or_null(String(terrain.get("visible_path", ""))) as Polygon2D
	var collision := scene_root.get_node_or_null(String(terrain.get("collision_path", ""))) as CollisionPolygon2D
	var lip := scene_root.get_node_or_null(String(terrain.get("lip_path", ""))) as Polygon2D
	if visible == null or collision == null or lip == null:
		last_error = "solid terrain entry lacks mapped scene nodes: %s" % terrain_id
		return false

	visible.polygon = points
	visible.visible = true
	visible.color = SOLID_COLOR
	collision.polygon = points
	collision.disabled = false
	lip.polygon = points
	lip.visible = true
	lip.color = LIP_COLOR
	return true

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points

	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))

	return points
