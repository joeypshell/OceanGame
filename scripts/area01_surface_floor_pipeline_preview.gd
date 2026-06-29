@tool
extends Node2D

@export_file("*.json") var geometry_path := "res://docs/planning/maps/area_01_surface_floor_geometry_v1.json":
	get:
		return _geometry_path
	set(value):
		_geometry_path = value
		if is_inside_tree():
			rebuild_preview()

@export var show_scene_hooks := true:
	get:
		return _show_scene_hooks
	set(value):
		_show_scene_hooks = value
		if is_inside_tree():
			rebuild_preview()

@export var show_collision_shapes := true:
	get:
		return _show_collision_shapes
	set(value):
		_show_collision_shapes = value
		if is_inside_tree():
			rebuild_preview()

const GENERATED_META := &"area01_surface_floor_pipeline_generated"

var _geometry_path := "res://docs/planning/maps/area_01_surface_floor_geometry_v1.json"
var _show_scene_hooks := true
var _show_collision_shapes := true

const TERRAIN_COLOR := Color(0.02, 0.09, 0.12, 0.96)
const TERRAIN_EDGE_COLOR := Color(0.18, 0.84, 0.9, 0.68)
const WATER_COLOR := Color(0.04, 0.33, 0.45, 0.22)
const SURFACE_COLOR := Color(0.28, 0.85, 0.95, 0.2)
const HOOK_COLOR := Color(0.95, 0.74, 0.2, 0.25)
const FUTURE_COLOR := Color(0.9, 0.22, 0.38, 0.28)


func _ready() -> void:
	rebuild_preview()


func rebuild_preview() -> void:
	_clear_generated()
	var geometry := _load_geometry()
	if geometry.is_empty():
		return

	var background := Node2D.new()
	background.name = "ParallaxPreview"
	_mark_generated(background)
	add_child(background)

	var regions := Node2D.new()
	regions.name = "WaterRegionsPreview"
	_mark_generated(regions)
	add_child(regions)

	var terrain_visuals := Node2D.new()
	terrain_visuals.name = "TerrainVisuals"
	_mark_generated(terrain_visuals)
	add_child(terrain_visuals)

	var terrain_collision := Node2D.new()
	terrain_collision.name = "TerrainCollision"
	_mark_generated(terrain_collision)
	add_child(terrain_collision)

	var rims := Node2D.new()
	rims.name = "TerrainRims"
	_mark_generated(rims)
	add_child(rims)

	var hooks := Node2D.new()
	hooks.name = "SceneHooks"
	_mark_generated(hooks)
	add_child(hooks)

	_add_background(background)
	_add_regions(regions, geometry)
	_add_terrain(terrain_visuals, terrain_collision, rims, geometry)
	if _show_scene_hooks:
		_add_hooks(hooks, geometry)


func _load_geometry() -> Dictionary:
	if not FileAccess.file_exists(_geometry_path):
		push_warning("Area 01 surface-floor geometry JSON not found: %s" % _geometry_path)
		return {}

	var file := FileAccess.open(_geometry_path, FileAccess.READ)
	if file == null:
		push_warning("Unable to open geometry JSON: %s" % _geometry_path)
		return {}

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		push_warning("Geometry JSON did not parse as a Dictionary: %s" % _geometry_path)
		return {}
	return parsed


func _add_background(parent: Node2D) -> void:
	var surface := Polygon2D.new()
	surface.name = "OpenSurfaceWaterPreview"
	surface.polygon = PackedVector2Array([
		Vector2(-1000, -50),
		Vector2(4700, -50),
		Vector2(4700, 260),
		Vector2(-1000, 260),
	])
	surface.color = SURFACE_COLOR
	surface.z_index = -100
	parent.add_child(surface)

	var far := Polygon2D.new()
	far.name = "FarReefSilhouettePreview"
	far.polygon = PackedVector2Array([
		Vector2(-900, 1500),
		Vector2(200, 1260),
		Vector2(920, 1500),
		Vector2(1850, 1320),
		Vector2(2700, 1540),
		Vector2(3700, 1320),
		Vector2(4600, 1540),
		Vector2(4600, 2460),
		Vector2(-900, 2460),
	])
	far.color = Color(0.0, 0.06, 0.1, 0.32)
	far.z_index = -90
	parent.add_child(far)


func _add_regions(parent: Node2D, geometry: Dictionary) -> void:
	for region in geometry.get("regions", []):
		if not region.has("approx_polygon"):
			continue
		var poly := Polygon2D.new()
		poly.name = "%s_Region" % String(region.get("id", "unnamed"))
		poly.polygon = _points_to_polygon(region["approx_polygon"])
		poly.color = WATER_COLOR if region.get("kind", "") != "open_surface" else SURFACE_COLOR
		poly.z_index = -40
		parent.add_child(poly)


func _add_terrain(visual_parent: Node2D, collision_parent: Node2D, rim_parent: Node2D, geometry: Dictionary) -> void:
	for solid in geometry.get("solid_terrain", []):
		var solid_id := String(solid.get("id", "solid"))
		var polygon := _points_to_polygon(solid.get("polygon", []))
		if polygon.size() < 3:
			continue

		var visual := Polygon2D.new()
		visual.name = "%s_Visual" % solid_id
		visual.polygon = polygon
		visual.color = TERRAIN_COLOR
		visual.z_index = 0
		visual_parent.add_child(visual)

		var rim := Line2D.new()
		rim.name = "%s_Rim" % solid_id
		rim.points = _closed_line_points(polygon)
		rim.width = 8.0
		rim.default_color = TERRAIN_EDGE_COLOR
		rim.z_index = 5
		rim_parent.add_child(rim)

		var body := StaticBody2D.new()
		body.name = "%s_Body" % solid_id
		body.collision_layer = 4
		body.collision_mask = 0
		collision_parent.add_child(body)

		var collision := CollisionPolygon2D.new()
		collision.name = "%s_CollisionPolygon" % solid_id
		collision.polygon = polygon
		body.add_child(collision)

		if _show_collision_shapes:
			var collision_line := Line2D.new()
			collision_line.name = "%s_CollisionDebug" % solid_id
			collision_line.points = _closed_line_points(polygon)
			collision_line.width = 2.0
			collision_line.default_color = Color(1.0, 0.86, 0.18, 0.7)
			collision_line.z_index = 20
			rim_parent.add_child(collision_line)


func _add_hooks(parent: Node2D, geometry: Dictionary) -> void:
	for hook in geometry.get("scene_hooks", []):
		var points: Array = hook.get("points", [])
		var polygon := _points_to_polygon(points)
		if polygon.size() < 3:
			continue

		var area := Area2D.new()
		area.name = "%s_Area2D" % String(hook.get("id", "hook"))
		area.monitoring = false
		area.monitorable = false
		area.collision_layer = 0
		area.collision_mask = 0
		parent.add_child(area)

		var collision := CollisionPolygon2D.new()
		collision.name = "HookPolygon"
		collision.polygon = polygon
		area.add_child(collision)

		var visual := Polygon2D.new()
		visual.name = "%s_HookPreview" % String(hook.get("id", "hook"))
		visual.polygon = polygon
		visual.color = FUTURE_COLOR if hook.get("status", "") == "future_locked" else HOOK_COLOR
		visual.z_index = 30
		parent.add_child(visual)


func _points_to_polygon(points: Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	for point in points:
		if point is Array and point.size() >= 2:
			result.append(Vector2(float(point[0]), float(point[1])))
	return result


func _closed_line_points(polygon: PackedVector2Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	for point in polygon:
		result.append(point)
	if polygon.size() > 0:
		result.append(polygon[0])
	return result


func _clear_generated() -> void:
	for child in get_children():
		if child.get_meta(GENERATED_META, false):
			remove_child(child)
			child.queue_free()


func _mark_generated(node: Node) -> void:
	node.set_meta(GENERATED_META, true)
