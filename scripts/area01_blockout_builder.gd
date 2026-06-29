class_name Area01BlockoutBuilder
extends RefCounted

const SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const WALL_CORNER_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_corner_cap_v1.svg")
const WALL_CRACK_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_crack_decal_v1.svg")
const WALL_KELP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_kelp_decal_v1.svg")
const WALL_CORAL_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_coral_decal_v1.svg")
const SOLID_COLOR := Color(0.018, 0.084, 0.09, 0.96)
const LIP_COLOR := Color(0.35, 0.68, 0.62, 0.12)
const TOP_EDGE_COLOR := Color(0.54, 0.78, 0.68, 0.46)
const SIDE_EDGE_COLOR := Color(0.17, 0.42, 0.44, 0.28)
const UNDER_EDGE_COLOR := Color(0.0, 0.012, 0.02, 0.36)
const INTERNAL_PLANE_COLOR := Color(0.08, 0.22, 0.22, 0.18)
const STRATA_LIGHT_COLOR := Color(0.22, 0.42, 0.38, 0.2)
const STRATA_DARK_COLOR := Color(0.0, 0.02, 0.026, 0.24)
const WALL_DRESSING_LAYER_NAME := "SourceMapWallDressing"

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

	var group := Node2D.new()
	group.name = "%sWallDressing" % _pascal_case_id(terrain_id)
	group.z_index = 3
	dressing_layer.add_child(group)

	_add_continuous_wall_planes(group, bounds)
	_add_edge_bands(group, points, bounds)
	_add_sparse_wall_decals(group, terrain_id, bounds)

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

func _add_continuous_wall_planes(group: Node2D, bounds: Rect2) -> void:
	if bounds.size.x > 260.0:
		_add_strata_band(group, "UpperRockStrataBand", bounds, 0.2, 0.12, STRATA_LIGHT_COLOR, -18.0)
		_add_strata_band(group, "MidShadowStrataBand", bounds, 0.48, 0.16, STRATA_DARK_COLOR, 26.0)
		_add_strata_band(group, "LowerRockStrataBand", bounds, 0.72, 0.12, STRATA_LIGHT_COLOR.darkened(0.35), -12.0)

	var top_plane_height := clampf(bounds.size.y * 0.38, 24.0, 90.0)
	var top_plane := Polygon2D.new()
	top_plane.name = "ContinuousTopPlane"
	top_plane.color = INTERNAL_PLANE_COLOR
	top_plane.polygon = PackedVector2Array([
		bounds.position + Vector2(20.0, 12.0),
		Vector2(bounds.end.x - 24.0, bounds.position.y + 6.0),
		Vector2(bounds.end.x - 70.0, bounds.position.y + top_plane_height),
		Vector2(bounds.position.x + 62.0, bounds.position.y + top_plane_height + 10.0),
	])
	group.add_child(top_plane)

	var under_plane := Polygon2D.new()
	under_plane.name = "ContinuousUndersidePlane"
	under_plane.color = Color(0.0, 0.01, 0.018, 0.22)
	under_plane.polygon = PackedVector2Array([
		Vector2(bounds.position.x + 28.0, bounds.end.y - top_plane_height * 0.7),
		Vector2(bounds.end.x - 58.0, bounds.end.y - top_plane_height * 0.55),
		bounds.end - Vector2(28.0, 16.0),
		Vector2(bounds.position.x + 56.0, bounds.end.y - 12.0),
	])
	group.add_child(under_plane)

func _add_strata_band(group: Node2D, node_name: String, bounds: Rect2, y_fraction: float, height_fraction: float, color: Color, slant: float) -> void:
	var inset := clampf(bounds.size.x * 0.08, 34.0, 130.0)
	var band_height := clampf(bounds.size.y * height_fraction, 18.0, 64.0)
	var y := bounds.position.y + bounds.size.y * y_fraction
	var band := Polygon2D.new()
	band.name = node_name
	band.color = color
	band.polygon = PackedVector2Array([
		Vector2(bounds.position.x + inset, y),
		Vector2(bounds.end.x - inset * 0.75, y + slant),
		Vector2(bounds.end.x - inset * 1.35, y + band_height + slant * 0.45),
		Vector2(bounds.position.x + inset * 1.4, y + band_height),
	])
	group.add_child(band)

func _add_edge_bands(group: Node2D, points: PackedVector2Array, bounds: Rect2) -> void:
	var center := bounds.get_center()
	for index in range(points.size()):
		var start := points[index]
		var finish := points[(index + 1) % points.size()]
		var edge := finish - start
		if edge.length() < 70.0:
			continue

		var midpoint := (start + finish) * 0.5
		if absf(edge.x) >= absf(edge.y):
			if midpoint.y <= center.y:
				_add_edge_band(group, "ReadableTopEdgeBand", start, finish, Vector2(0.0, _edge_band_width(bounds)), TOP_EDGE_COLOR)
			else:
				_add_edge_band(group, "UndersideShadowBand", start, finish, Vector2(0.0, -_edge_band_width(bounds) * 0.85), UNDER_EDGE_COLOR)
		elif absf(edge.y) > absf(edge.x) * 1.25:
			var side_dir := 1.0 if midpoint.x < center.x else -1.0
			_add_edge_band(group, "SideWallBand", start, finish, Vector2(side_dir * _edge_band_width(bounds) * 0.8, 0.0), SIDE_EDGE_COLOR)

func _add_edge_band(group: Node2D, node_name: String, start: Vector2, finish: Vector2, offset: Vector2, color: Color) -> void:
	var band := Polygon2D.new()
	band.name = node_name
	band.color = color
	band.polygon = PackedVector2Array([start, finish, finish + offset, start + offset])
	group.add_child(band)

func _edge_band_width(bounds: Rect2) -> float:
	return clampf(minf(bounds.size.x, bounds.size.y) * 0.2, 18.0, 44.0)

func _add_sparse_wall_decals(group: Node2D, terrain_id: String, bounds: Rect2) -> void:
	if bounds.size.x < 180.0 or bounds.size.y < 90.0:
		return

	var checksum := 0
	for index in range(terrain_id.length()):
		checksum += terrain_id.unicode_at(index)

	var decal_position := bounds.position + Vector2(bounds.size.x * 0.34, bounds.size.y * 0.42)
	var decal_scale := Vector2(0.34, 0.34)
	match checksum % 4:
		0:
			group.add_child(_wall_sprite("SparseCrackDecalSprite", WALL_CRACK_TEXTURE, decal_position, decal_scale, 0.42))
		1:
			group.add_child(_wall_sprite("SparseKelpDecalSprite", WALL_KELP_TEXTURE, decal_position + Vector2(-18.0, -18.0), Vector2(0.28, 0.28), 0.42))
		2:
			group.add_child(_wall_sprite("SparseCoralDecalSprite", WALL_CORAL_TEXTURE, decal_position + Vector2(22.0, 8.0), Vector2(0.32, 0.32), 0.4))
		_:
			group.add_child(_wall_sprite("SparseCornerCapSprite", WALL_CORNER_TEXTURE, bounds.position + bounds.size * 0.72, Vector2(0.3, 0.3), 0.34))

func _wall_sprite(sprite_name: String, texture: Texture2D, position: Vector2, scale: Vector2, alpha: float) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.name = sprite_name
	sprite.texture = texture
	sprite.position = position
	sprite.scale = scale
	sprite.modulate = Color(1.0, 1.0, 1.0, alpha)
	return sprite

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
