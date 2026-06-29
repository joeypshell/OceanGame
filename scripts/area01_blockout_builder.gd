class_name Area01BlockoutBuilder
extends RefCounted

const RUNTIME_SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_runtime_source_map_v2.json"
const LEGACY_SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const SOURCE_MAP_PATH := RUNTIME_SOURCE_MAP_PATH
const REEF_WALL_FILL_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_fill_texture_v2.png")
const WALL_CORNER_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_corner_cap_v1.svg")
const WALL_CRACK_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_crack_decal_v1.svg")
const WALL_KELP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_kelp_decal_v1.svg")
const WALL_CORAL_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_coral_decal_v1.svg")
const TOP_LIP_LEFT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-2.png")
const TOP_LIP_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-3.png")
const TOP_LIP_RIGHT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-4.png")
const CEILING_LEFT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-5.png")
const CEILING_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-6.png")
const CEILING_RIGHT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-7.png")
const VERTICAL_TOP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-9.png")
const VERTICAL_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-10.png")
const VERTICAL_BOTTOM_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-11.png")
const DIAGONAL_SLOPE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-12.png")
const DEEP_FLOOR_LIP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-16.png")
const SOLID_COLOR := Color(0.42, 0.72, 0.68, 1.0)
const LIP_COLOR := Color(0.46, 0.82, 0.76, 0.04)
const TOP_EDGE_COLOR := Color(0.66, 0.94, 0.82, 0.10)
const SIDE_EDGE_COLOR := Color(0.06, 0.18, 0.20, 0.08)
const UNDER_EDGE_COLOR := Color(0.0, 0.012, 0.02, 0.18)
const INTERNAL_PLANE_COLOR := Color(0.03, 0.10, 0.11, 0.10)
const STRATA_LIGHT_COLOR := Color(0.18, 0.36, 0.32, 0.08)
const STRATA_DARK_COLOR := Color(0.0, 0.018, 0.024, 0.16)
const WALL_DRESSING_LAYER_NAME := "SourceMapWallDressing"
const TERRAIN_ACCENT_LAYER_NAME := "SourceMapTerrainAccents"
const GENERATED_TERRAIN_LAYER_NAME := "RuntimeSourceTerrain"
const GENERATED_COLLISION_BODY_NAME := "RuntimeSourceCollision"
const GENERATED_RIM_LAYER_NAME := "RuntimeSourceRims"
const GENERATED_HOOK_LAYER_NAME := "RuntimeSourceHooks"
const REEF_TEXTURE_UV_SCALE := 0.84
const FAR_BACKGROUND_AUTHORITY_ALPHA := 0.06
const PARALLAX_BACKGROUND_AUTHORITY_ALPHA := 0.08
const LIGHTING_STACK_AUTHORITY_ALPHA := 0.14
const WATER_SHAFT_AUTHORITY_ALPHA := 0.10
const TRIM_BASE_SCALE := 0.22
const TRIM_REPEAT_SPACING := 240.0
const TRIM_EDGE_ALPHA := 0.44
const TOP_TRIM_BLEND_COLOR := Color(0.48, 0.72, 0.64, 0.05)
const UNDER_TRIM_BLEND_COLOR := Color(0.0, 0.025, 0.035, 0.20)
const SIDE_TRIM_BLEND_COLOR := Color(0.02, 0.11, 0.12, 0.14)
const DEEP_TRIM_BLEND_COLOR := Color(0.0, 0.018, 0.026, 0.24)
const TOP_FACE_BEVEL_COLOR := Color(0.46, 0.78, 0.66, 0.04)
const TOP_EDGE_GLOW_COLOR := Color(0.78, 0.98, 0.90, 0.05)
const OVERHANG_OCCLUSION_COLOR := Color(0.0, 0.012, 0.018, 0.30)
const SIDE_OCCLUSION_COLOR := Color(0.0, 0.03, 0.035, 0.22)
const LEGACY_ROUTE_VISUAL_ROOTS := [
	"SafeShallowsExplorationShell",
	"EastShelfSpur",
	"ShellReefPocket",
	"ThermalVentPocket",
	"WreckEchoDescent",
]

var last_error := ""
var loaded_source_map_path := ""

func build(scene_root: Node) -> bool:
	last_error = ""
	var source_map := _load_source_map()
	if source_map.is_empty():
		return false

	_prepare_area01_for_authority(scene_root)
	if _uses_generated_runtime_schema(source_map):
		if not _build_generated_runtime(scene_root, source_map):
			return false
		return true

	for terrain in source_map.get("solid_terrain", []):
		if typeof(terrain) != TYPE_DICTIONARY:
			last_error = "solid terrain entry is not a dictionary"
			return false
		if not _apply_solid_terrain(scene_root, terrain as Dictionary):
			return false
		_apply_terrain_accents(scene_root, terrain as Dictionary)

	return true

func _load_source_map() -> Dictionary:
	for path in [RUNTIME_SOURCE_MAP_PATH, LEGACY_SOURCE_MAP_PATH]:
		var file := FileAccess.open(path, FileAccess.READ)
		if file == null:
			continue

		var parsed = JSON.parse_string(file.get_as_text())
		if typeof(parsed) != TYPE_DICTIONARY:
			last_error = "Area 01 source map parse failed: %s" % path
			return {}

		loaded_source_map_path = path
		return parsed as Dictionary

	last_error = "missing Area 01 source map"
	return {}

func _uses_generated_runtime_schema(source_map: Dictionary) -> bool:
	for terrain in source_map.get("solid_terrain", []):
		if typeof(terrain) == TYPE_DICTIONARY and (terrain as Dictionary).has("runtime_generation"):
			return true
	return false

func _prepare_area01_for_authority(scene_root: Node) -> void:
	_hide_legacy_route_visual_roots(scene_root)
	for path in [
		"Area01ArtSlice/BackgroundMid",
		"Area01ArtSlice/ForegroundDecor",
	]:
		var node := scene_root.get_node_or_null(path) as CanvasItem
		if node != null:
			node.visible = false

	_set_canvas_item_alpha(scene_root, "Area01ArtSlice/BackgroundFar", FAR_BACKGROUND_AUTHORITY_ALPHA)
	_set_canvas_item_alpha(scene_root, "Area01ArtSlice/OceanParallaxBackground", PARALLAX_BACKGROUND_AUTHORITY_ALPHA)
	_set_canvas_item_alpha(scene_root, "Area01ArtSlice/OceanLightingStack", LIGHTING_STACK_AUTHORITY_ALPHA)
	_set_canvas_item_alpha(scene_root, "Area01ArtSlice/WaterLightShafts", WATER_SHAFT_AUTHORITY_ALPHA)

	var terrain_back := scene_root.get_node_or_null("Area01ArtSlice/TerrainBackWalls")
	if terrain_back != null:
		if terrain_back is CanvasItem:
			(terrain_back as CanvasItem).z_index = 3
		_remove_child_if_present(terrain_back, GENERATED_TERRAIN_LAYER_NAME)
		for child in terrain_back.get_children():
			if child is Polygon2D:
				(child as Polygon2D).visible = false

	var art_slice := scene_root.get_node_or_null("Area01ArtSlice")
	if art_slice != null:
		_remove_child_if_present(art_slice, GENERATED_COLLISION_BODY_NAME)
		_remove_child_if_present(art_slice, GENERATED_HOOK_LAYER_NAME)

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
		_remove_child_if_present(visual_edges, WALL_DRESSING_LAYER_NAME)
		_remove_child_if_present(visual_edges, TERRAIN_ACCENT_LAYER_NAME)

	var collision_boundaries := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries")
	if collision_boundaries != null:
		if collision_boundaries is CanvasItem:
			(collision_boundaries as CanvasItem).z_index = 4
		_remove_child_if_present(collision_boundaries, GENERATED_RIM_LAYER_NAME)
		for child in collision_boundaries.get_children():
			if child is Polygon2D:
				(child as Polygon2D).visible = false

func _hide_legacy_route_visual_roots(scene_root: Node) -> void:
	for path in LEGACY_ROUTE_VISUAL_ROOTS:
		var node := scene_root.get_node_or_null(path) as CanvasItem
		if node != null:
			node.visible = false

func _build_generated_runtime(scene_root: Node, source_map: Dictionary) -> bool:
	var terrain_layer := _generated_terrain_layer(scene_root)
	var collision_root := _generated_collision_root(scene_root)
	var rim_layer := _generated_rim_layer(scene_root)
	if terrain_layer == null or collision_root == null or rim_layer == null:
		last_error = "Area 01 generated runtime containers could not be created"
		return false

	for terrain in source_map.get("solid_terrain", []):
		if typeof(terrain) != TYPE_DICTIONARY:
			last_error = "generated solid terrain entry is not a dictionary"
			return false
		if not _create_generated_solid(terrain_layer, collision_root, rim_layer, terrain as Dictionary):
			return false
		_apply_terrain_accents(scene_root, terrain as Dictionary)

	_create_generated_hooks(scene_root, source_map)
	return true

func _generated_terrain_layer(scene_root: Node) -> Node2D:
	var parent := scene_root.get_node_or_null("Area01ArtSlice/TerrainBackWalls") as Node2D
	if parent == null:
		return null

	var layer := Node2D.new()
	layer.name = GENERATED_TERRAIN_LAYER_NAME
	layer.z_index = 3
	parent.add_child(layer)
	return layer

func _generated_collision_root(scene_root: Node) -> StaticBody2D:
	var art_slice := scene_root.get_node_or_null("Area01ArtSlice") as Node2D
	if art_slice == null:
		return null

	var legacy_collision := scene_root.get_node_or_null("Area01ArtSlice/TerrainCollision") as StaticBody2D
	var root := StaticBody2D.new()
	root.name = GENERATED_COLLISION_BODY_NAME
	if legacy_collision != null:
		root.collision_layer = legacy_collision.collision_layer
		root.collision_mask = legacy_collision.collision_mask
	art_slice.add_child(root)
	return root

func _generated_rim_layer(scene_root: Node) -> Node2D:
	var parent := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries") as Node2D
	if parent == null:
		return null

	var layer := Node2D.new()
	layer.name = GENERATED_RIM_LAYER_NAME
	layer.z_index = 4
	parent.add_child(layer)
	return layer

func _create_generated_solid(terrain_layer: Node2D, collision_root: StaticBody2D, rim_layer: Node2D, terrain: Dictionary) -> bool:
	var terrain_id := String(terrain.get("id", "unknown"))
	var points := _points_from_json(terrain.get("polygon", []))
	if points.size() < 3:
		last_error = "generated solid terrain entry lacks polygon: %s" % terrain_id
		return false

	var runtime_generation: Variant = terrain.get("runtime_generation", {})
	var runtime: Dictionary = runtime_generation as Dictionary if runtime_generation is Dictionary else {}
	var visible_name := String(runtime.get("visible_polygon2d_name", "%sTerrain" % _pascal_case_id(terrain_id)))
	var collision_name := String(runtime.get("collision_polygon2d_name", "%sCollision" % _pascal_case_id(terrain_id)))
	var rim_name := String(runtime.get("rim_container_name", "%sRims" % _pascal_case_id(terrain_id)))

	var visible := Polygon2D.new()
	visible.name = visible_name
	visible.polygon = points
	visible.uv = _texture_uv_for_points(points, _polygon_bounds(points))
	visible.texture = REEF_WALL_FILL_TEXTURE
	visible.visible = true
	visible.color = SOLID_COLOR
	terrain_layer.add_child(visible)

	var collision := CollisionPolygon2D.new()
	collision.name = collision_name
	collision.polygon = points
	collision.disabled = not bool(terrain.get("blocks_player", true))
	collision_root.add_child(collision)

	var rim := Polygon2D.new()
	rim.name = rim_name
	rim.polygon = points
	rim.visible = true
	rim.color = LIP_COLOR
	rim_layer.add_child(rim)
	return true

func _create_generated_hooks(scene_root: Node, source_map: Dictionary) -> void:
	var hook_parent := _generated_hook_layer(scene_root)
	if hook_parent == null:
		return

	for hook in source_map.get("scene_hooks", []):
		if typeof(hook) != TYPE_DICTIONARY:
			continue
		var hook_data := hook as Dictionary
		var points := _points_from_json(hook_data.get("points", []))
		if points.size() < 3:
			continue
		var runtime_generation: Variant = hook_data.get("runtime_generation", {})
		var runtime: Dictionary = runtime_generation as Dictionary if runtime_generation is Dictionary else {}
		var hook_id := String(hook_data.get("id", "hook"))
		var area_name := String(runtime.get("area2d_name", "%sArea" % _pascal_case_id(hook_id)))
		var collision_name := String(runtime.get("collision_polygon2d_name", "%sTrigger" % _pascal_case_id(hook_id)))

		var area := Area2D.new()
		area.name = area_name
		area.monitoring = false
		area.monitorable = false
		area.collision_layer = 0
		area.collision_mask = 0
		area.set_meta(&"area01_hook_id", hook_id)
		area.set_meta(&"area01_hook_type", String(hook_data.get("type", "")))
		hook_parent.add_child(area)

		var collision := CollisionPolygon2D.new()
		collision.name = collision_name
		collision.polygon = points
		collision.disabled = true
		area.add_child(collision)

func _generated_hook_layer(scene_root: Node) -> Node2D:
	var art_slice := scene_root.get_node_or_null("Area01ArtSlice") as Node2D
	if art_slice == null:
		return null

	var layer := Node2D.new()
	layer.name = GENERATED_HOOK_LAYER_NAME
	art_slice.add_child(layer)
	return layer

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
	visible.uv = _texture_uv_for_points(points, _polygon_bounds(points))
	visible.texture = REEF_WALL_FILL_TEXTURE
	visible.visible = true
	visible.color = SOLID_COLOR
	collision.polygon = points
	collision.disabled = false
	lip.polygon = points
	lip.visible = true
	lip.color = LIP_COLOR
	return true

func _apply_terrain_accents(scene_root: Node, terrain: Dictionary) -> void:
	var terrain_id := String(terrain.get("id", "unknown"))
	var points := _points_from_json(terrain.get("polygon", []))
	if points.size() < 3:
		return

	var accent_layer := _terrain_accent_layer(scene_root)
	if accent_layer == null:
		return

	var bounds := _polygon_bounds(points)
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0:
		return

	var group := Node2D.new()
	group.name = "%sTerrainAccents" % _pascal_case_id(terrain_id)
	group.z_index = 4
	accent_layer.add_child(group)

	_add_continuous_wall_planes(group, points, bounds)
	_add_edge_bands(group, points, bounds)
	_add_authored_trim_segments(group, terrain)
	_add_sparse_wall_decals(group, terrain_id, bounds)

func _terrain_accent_layer(scene_root: Node) -> Node2D:
	var parent := scene_root.get_node_or_null("Area01ArtSlice/TerrainVisualEdges") as Node2D
	if parent == null:
		return null

	var existing := parent.get_node_or_null(TERRAIN_ACCENT_LAYER_NAME) as Node2D
	if existing != null:
		return existing

	var layer := Node2D.new()
	layer.name = TERRAIN_ACCENT_LAYER_NAME
	layer.z_index = 4
	parent.add_child(layer)
	return layer

func _remove_child_if_present(parent: Node, child_name: String) -> void:
	var child := parent.get_node_or_null(child_name)
	if child != null:
		parent.remove_child(child)
		child.free()

func _set_canvas_item_alpha(scene_root: Node, path: String, alpha: float) -> void:
	var node := scene_root.get_node_or_null(path) as CanvasItem
	if node != null:
		node.modulate.a = alpha

func _texture_uv_for_points(points: PackedVector2Array, bounds: Rect2) -> PackedVector2Array:
	var uvs := PackedVector2Array()
	for point in points:
		uvs.append((point - bounds.position) * REEF_TEXTURE_UV_SCALE)
	return uvs

func _add_continuous_wall_planes(group: Node2D, points: PackedVector2Array, bounds: Rect2) -> void:
	if points.size() < 3:
		return

	var center := bounds.get_center()
	var inner_plane := Polygon2D.new()
	inner_plane.name = "ContinuousInsetPlane"
	inner_plane.color = INTERNAL_PLANE_COLOR
	inner_plane.polygon = _inset_polygon(points, center, 0.08)
	group.add_child(inner_plane)

	var shadow_plane := Polygon2D.new()
	shadow_plane.name = "ContinuousDepthShadowPlane"
	shadow_plane.color = Color(0.0, 0.01, 0.018, 0.18)
	shadow_plane.polygon = _offset_polygon(_inset_polygon(points, center, 0.16), Vector2(0.0, clampf(bounds.size.y * 0.04, 8.0, 22.0)))
	group.add_child(shadow_plane)

	if bounds.size.x > 260.0:
		_add_strata_band(group, "UpperRockStrataBand", bounds, 0.2, 0.12, STRATA_LIGHT_COLOR, -18.0)
		_add_strata_band(group, "MidShadowStrataBand", bounds, 0.48, 0.16, STRATA_DARK_COLOR, 26.0)
		_add_strata_band(group, "LowerRockStrataBand", bounds, 0.72, 0.12, STRATA_LIGHT_COLOR.darkened(0.35), -12.0)

func _inset_polygon(points: PackedVector2Array, center: Vector2, fraction: float) -> PackedVector2Array:
	var inset := PackedVector2Array()
	for point in points:
		inset.append(point.lerp(center, fraction))
	return inset

func _offset_polygon(points: PackedVector2Array, offset: Vector2) -> PackedVector2Array:
	var shifted := PackedVector2Array()
	for point in points:
		shifted.append(point + offset)
	return shifted

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
	return clampf(minf(bounds.size.x, bounds.size.y) * 0.12, 10.0, 24.0)

func _add_authored_trim_segments(group: Node2D, terrain: Dictionary) -> void:
	var segments: Variant = terrain.get("trim_segments", [])
	if not segments is Array:
		return

	for segment_value in segments:
		if not segment_value is Dictionary:
			continue

		var segment := segment_value as Dictionary
		var trim_type := String(segment.get("type", ""))
		if _trim_texture_sequence_for_type(trim_type).is_empty():
			continue

		var start := _point_from_json(segment.get("start", []))
		var finish := _point_from_json(segment.get("end", []))
		if start == finish:
			continue

		var offset := _point_from_json(segment.get("offset", [0, 0]))
		var spacing := float(segment.get("repeat_spacing", TRIM_REPEAT_SPACING))
		var scale := float(segment.get("scale", TRIM_BASE_SCALE))
		var alpha := float(segment.get("alpha", _trim_alpha_for_type(trim_type)))
		_add_trim_blend(group, trim_type, start, finish, offset)
		_add_role_aware_edge_trim(
			group,
			"Semantic%sTrim" % _pascal_case_id(trim_type),
			trim_type,
			start,
			finish,
			offset,
			spacing,
			scale,
			clampf(alpha * 0.72, 0.14, 0.42)
		)

func _add_trim_blend(group: Node2D, trim_type: String, start: Vector2, finish: Vector2, offset: Vector2) -> void:
	var edge := finish - start
	if edge.length() <= 0.0:
		return

	var base_start := start + offset
	var base_finish := finish + offset
	match trim_type:
		"top_lip":
			_add_tapered_trim_blend_band(group, "SemanticTopLipBroadLitFace", base_start, base_finish, Vector2(0.0, 24.0), TOP_FACE_BEVEL_COLOR)
			_add_trim_blend_band(group, "SemanticTopLipEdgeGlow", base_start + Vector2(0.0, -2.0), base_finish + Vector2(0.0, -2.0), Vector2(0.0, 6.0), TOP_EDGE_GLOW_COLOR)
			_add_trim_blend_band(group, "SemanticTopLipBlend", base_start, base_finish, Vector2(0.0, 18.0), TOP_TRIM_BLEND_COLOR)
			_add_trim_blend_band(group, "SemanticTopLipShadowBlend", base_start + Vector2(0.0, 16.0), base_finish + Vector2(0.0, 16.0), Vector2(0.0, 12.0), UNDER_TRIM_BLEND_COLOR.lightened(0.05))
		"underside":
			_add_trim_blend_band(group, "SemanticOverhangOcclusionBlend", base_start + Vector2(0.0, -28.0), base_finish + Vector2(0.0, -28.0), Vector2(0.0, 58.0), OVERHANG_OCCLUSION_COLOR)
			_add_trim_blend_band(group, "SemanticUndersideBlend", base_start + Vector2(0.0, -18.0), base_finish + Vector2(0.0, -18.0), Vector2(0.0, 34.0), UNDER_TRIM_BLEND_COLOR)
		"deep_floor_lip":
			_add_trim_blend_band(group, "SemanticDeepFloorLipBlend", base_start + Vector2(0.0, -16.0), base_finish + Vector2(0.0, -16.0), Vector2(0.0, 38.0), DEEP_TRIM_BLEND_COLOR)
		"vertical_wall":
			var side_sign := 1.0 if offset.x >= 0.0 else -1.0
			_add_trim_blend_band(group, "SemanticVerticalWallOcclusionBlend", base_start, base_finish, Vector2(42.0 * side_sign, 0.0), SIDE_OCCLUSION_COLOR)
			_add_trim_blend_band(group, "SemanticVerticalWallBlend", base_start, base_finish, Vector2(28.0 * side_sign, 0.0), SIDE_TRIM_BLEND_COLOR)
		"diagonal_slope":
			var normal := Vector2(-edge.y, edge.x).normalized() * 26.0
			_add_trim_blend_band(group, "SemanticDiagonalSlopeBlend", base_start, base_finish, normal, SIDE_TRIM_BLEND_COLOR.lightened(0.08))

func _add_trim_blend_band(group: Node2D, node_name: String, start: Vector2, finish: Vector2, thickness: Vector2, color: Color) -> void:
	var band := Polygon2D.new()
	band.name = node_name
	band.color = color
	band.polygon = PackedVector2Array([start, finish, finish + thickness, start + thickness])
	group.add_child(band)

func _add_tapered_trim_blend_band(group: Node2D, node_name: String, start: Vector2, finish: Vector2, thickness: Vector2, color: Color) -> void:
	var edge := finish - start
	if edge.length() <= 0.0:
		return

	var direction := edge.normalized()
	var inset := minf(42.0, edge.length() * 0.12)
	var band := Polygon2D.new()
	band.name = node_name
	band.color = color
	band.polygon = PackedVector2Array([
		start,
		finish,
		finish + thickness - direction * inset,
		start + thickness + direction * inset,
	])
	group.add_child(band)

func _add_repeated_edge_trim(group: Node2D, sprite_name: String, texture: Texture2D, start: Vector2, finish: Vector2, offset: Vector2, spacing: float, scale: float, alpha: float) -> void:
	var edge := finish - start
	var length := edge.length()
	if length <= 0.0:
		return

	var count := clampi(int(floor(length / spacing)), 1, 4)
	var angle := edge.angle()
	for index in range(count):
		var fraction := float(index + 1) / float(count + 1)
		_add_rotated_trim_sprite(group, "%s%d" % [sprite_name, index + 1], texture, start.lerp(finish, fraction) + offset, scale, alpha, angle)

func _add_role_aware_edge_trim(group: Node2D, sprite_name: String, trim_type: String, start: Vector2, finish: Vector2, offset: Vector2, spacing: float, scale: float, alpha: float) -> void:
	var edge := finish - start
	var length := edge.length()
	if length <= 0.0:
		return

	var textures := _trim_texture_sequence_for_type(trim_type)
	if textures.is_empty():
		return

	if textures.size() < 3:
		_add_repeated_edge_trim(group, sprite_name, textures[0] as Texture2D, start, finish, offset, spacing, scale, alpha)
		return

	var start_texture := textures[0] as Texture2D
	var middle_texture := textures[1] as Texture2D
	var end_texture := textures[2] as Texture2D
	if _trim_segment_is_reversed(trim_type, start, finish):
		var swap_texture := start_texture
		start_texture = end_texture
		end_texture = swap_texture

	var angle := edge.angle()
	var direction := edge.normalized()
	var cap_inset := minf(spacing * 0.28, length * 0.18)
	_add_rotated_trim_sprite(group, "%sStartCap" % sprite_name, start_texture, start + offset + direction * cap_inset, scale, alpha, angle)

	if length > spacing * 1.25:
		var repeat_count := clampi(int(floor((length - cap_inset * 2.0) / spacing)), 1, 3)
		for index in range(repeat_count):
			var fraction := float(index + 1) / float(repeat_count + 1)
			_add_rotated_trim_sprite(group, "%sMiddle%d" % [sprite_name, index + 1], middle_texture, start.lerp(finish, fraction) + offset, scale, alpha, angle)

	_add_rotated_trim_sprite(group, "%sEndCap" % sprite_name, end_texture, finish + offset - direction * cap_inset, scale, alpha, angle)

func _add_rotated_trim_sprite(group: Node2D, sprite_name: String, texture: Texture2D, position: Vector2, scale_value: float, alpha: float, angle: float) -> void:
	var sprite := _wall_sprite(sprite_name, texture, position, Vector2(scale_value, scale_value), alpha)
	sprite.rotation = angle
	group.add_child(sprite)

func _trim_texture_sequence_for_type(trim_type: String) -> Array:
	match trim_type:
		"top_lip":
			return [TOP_LIP_LEFT_TEXTURE, TOP_LIP_MIDDLE_TEXTURE, TOP_LIP_RIGHT_TEXTURE]
		"underside":
			return [CEILING_LEFT_TEXTURE, CEILING_MIDDLE_TEXTURE, CEILING_RIGHT_TEXTURE]
		"vertical_wall":
			return [VERTICAL_TOP_TEXTURE, VERTICAL_MIDDLE_TEXTURE, VERTICAL_BOTTOM_TEXTURE]
		"deep_floor_lip":
			return [DEEP_FLOOR_LIP_TEXTURE]
		"diagonal_slope":
			return [DIAGONAL_SLOPE_TEXTURE]
		_:
			return []

func _trim_segment_is_reversed(trim_type: String, start: Vector2, finish: Vector2) -> bool:
	match trim_type:
		"top_lip", "underside", "deep_floor_lip":
			return start.x > finish.x
		"vertical_wall":
			return start.y > finish.y
		_:
			return false

func _trim_texture_for_type(trim_type: String) -> Texture2D:
	match trim_type:
		"top_lip":
			return TOP_LIP_MIDDLE_TEXTURE
		"underside":
			return CEILING_MIDDLE_TEXTURE
		"deep_floor_lip":
			return DEEP_FLOOR_LIP_TEXTURE
		"vertical_wall":
			return VERTICAL_MIDDLE_TEXTURE
		"diagonal_slope":
			return DIAGONAL_SLOPE_TEXTURE
		_:
			return null

func _trim_alpha_for_type(trim_type: String) -> float:
	match trim_type:
		"top_lip":
			return 0.58
		"underside":
			return 0.38
		"deep_floor_lip":
			return 0.34
		"vertical_wall", "diagonal_slope":
			return 0.30
		_:
			return TRIM_EDGE_ALPHA

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

func _point_from_json(value: Variant) -> Vector2:
	if value is Array and value.size() >= 2:
		return Vector2(float(value[0]), float(value[1]))
	return Vector2.ZERO

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
