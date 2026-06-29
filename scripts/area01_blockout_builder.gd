class_name Area01BlockoutBuilder
extends RefCounted

const SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const SOLID_COLOR := Color(0.008, 0.035, 0.042, 1.0)
const LIP_COLOR := Color(0.35, 0.62, 0.58, 0.08)
const WALL_DRESSING_LAYER_NAME := "SourceMapWallDressing"
const WALL_DRESSING_STEP := 440.0
const WALL_DRESSING_MAX_TILES := 8

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
		_apply_wall_dressing(scene_root, terrain as Dictionary)

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
		var old_dressing := visual_edges.get_node_or_null(WALL_DRESSING_LAYER_NAME)
		if old_dressing != null:
			visual_edges.remove_child(old_dressing)
			old_dressing.free()

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

func _apply_wall_dressing(scene_root: Node, terrain: Dictionary) -> void:
	var terrain_id := String(terrain.get("id", "unknown"))
	var points := _points_from_json(terrain.get("polygon", []))
	if points.size() < 3:
		return

	var dressing_layer := _wall_dressing_layer(scene_root)
	if dressing_layer == null:
		return

	var bounds := _polygon_bounds(points)
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0:
		return

	var tile_count := clampi(int(ceil(maxf(bounds.size.x, bounds.size.y) / WALL_DRESSING_STEP)), 1, WALL_DRESSING_MAX_TILES)
	for index in range(tile_count):
		var t := 0.5
		if tile_count > 1:
			t = float(index) / float(tile_count - 1)

		var tile := _create_wall_dressing_tile(index)
		tile.name = "%sWallDressing%02d" % [_pascal_case_id(terrain_id), index + 1]
		tile.position = _wall_dressing_position(bounds, t)
		tile.scale = _wall_dressing_scale(bounds, index)
		tile.rotation_degrees = _wall_dressing_rotation(bounds, index)
		tile.z_index = 3
		dressing_layer.add_child(tile)

func _wall_dressing_layer(scene_root: Node) -> Node2D:
	var parent := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges") as Node2D
	if parent == null:
		return null

	var existing := parent.get_node_or_null(WALL_DRESSING_LAYER_NAME) as Node2D
	if existing != null:
		return existing

	var layer := Node2D.new()
	layer.name = WALL_DRESSING_LAYER_NAME
	layer.z_index = 3
	parent.add_child(layer)
	return layer

func _wall_dressing_position(bounds: Rect2, t: float) -> Vector2:
	if bounds.size.x >= bounds.size.y:
		var inset_x := minf(160.0, bounds.size.x * 0.18)
		return Vector2(lerpf(bounds.position.x + inset_x, bounds.end.x - inset_x, t), bounds.position.y + bounds.size.y * 0.45)

	var inset_y := minf(140.0, bounds.size.y * 0.18)
	return Vector2(bounds.position.x + bounds.size.x * 0.52, lerpf(bounds.position.y + inset_y, bounds.end.y - inset_y, t))

func _wall_dressing_scale(bounds: Rect2, index: int) -> Vector2:
	var horizontal := bounds.size.x >= bounds.size.y
	var base_scale := Vector2(0.85, 0.46) if horizontal else Vector2(0.58, 0.62)
	var pulse := 1.0 + (0.08 if index % 2 == 0 else -0.05)
	return base_scale * pulse

func _wall_dressing_rotation(bounds: Rect2, index: int) -> float:
	if bounds.size.x >= bounds.size.y:
		return -3.0 if index % 2 == 0 else 2.0
	return 86.0 if index % 2 == 0 else 94.0

func _create_wall_dressing_tile(index: int) -> Node2D:
	var tile := Node2D.new()

	var dark_face := Polygon2D.new()
	dark_face.name = "DarkReefFace"
	dark_face.color = Color(0.01, 0.045, 0.052, 0.52)
	dark_face.polygon = PackedVector2Array([
		Vector2(-150.0, -28.0),
		Vector2(-72.0, -50.0),
		Vector2(74.0, -42.0),
		Vector2(148.0, -8.0),
		Vector2(108.0, 42.0),
		Vector2(-118.0, 38.0),
	])
	tile.add_child(dark_face)

	var lip := Polygon2D.new()
	lip.name = "ReadableReefLip"
	lip.color = Color(0.36, 0.65, 0.56, 0.34)
	lip.polygon = PackedVector2Array([
		Vector2(-132.0, -28.0),
		Vector2(-56.0, -44.0),
		Vector2(74.0, -34.0),
		Vector2(132.0, -8.0),
		Vector2(98.0, 6.0),
		Vector2(18.0, -16.0),
		Vector2(-66.0, -14.0),
		Vector2(-122.0, -4.0),
	])
	tile.add_child(lip)

	var under_shadow := Polygon2D.new()
	under_shadow.name = "UndersideShadow"
	under_shadow.color = Color(0.0, 0.01, 0.018, 0.42)
	under_shadow.polygon = PackedVector2Array([
		Vector2(-108.0, 12.0),
		Vector2(-22.0, -2.0),
		Vector2(90.0, 8.0),
		Vector2(116.0, 28.0),
		Vector2(44.0, 38.0),
		Vector2(-96.0, 34.0),
	])
	tile.add_child(under_shadow)

	var algae := Polygon2D.new()
	algae.name = "SmallAlgaeAccent"
	algae.color = Color(0.22, 0.56, 0.26, 0.26)
	algae.polygon = _algae_polygon(index)
	tile.add_child(algae)

	return tile

func _algae_polygon(index: int) -> PackedVector2Array:
	if index % 2 == 0:
		return PackedVector2Array([
			Vector2(-44.0, -22.0),
			Vector2(-36.0, -54.0),
			Vector2(-26.0, -18.0),
			Vector2(-12.0, -42.0),
			Vector2(-8.0, -8.0),
			Vector2(-48.0, -6.0),
		])

	return PackedVector2Array([
		Vector2(48.0, -18.0),
		Vector2(58.0, -46.0),
		Vector2(68.0, -14.0),
		Vector2(82.0, -36.0),
		Vector2(88.0, -4.0),
		Vector2(46.0, 0.0),
	])

func _pascal_case_id(value: String) -> String:
	var result := ""
	for part in value.split("_", false):
		if part.is_empty():
			continue
		result += part.substr(0, 1).to_upper() + part.substr(1)
	return result

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points

	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))

	return points

func _polygon_bounds(points: PackedVector2Array) -> Rect2:
	if points.is_empty():
		return Rect2()

	var min_x := points[0].x
	var max_x := points[0].x
	var min_y := points[0].y
	var max_y := points[0].y
	for point in points:
		min_x = minf(min_x, point.x)
		max_x = maxf(max_x, point.x)
		min_y = minf(min_y, point.y)
		max_y = maxf(max_y, point.y)

	return Rect2(Vector2(min_x, min_y), Vector2(max_x - min_x, max_y - min_y))
