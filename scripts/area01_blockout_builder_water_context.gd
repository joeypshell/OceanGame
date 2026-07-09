class_name Area01BlockoutBuilderWaterContext
extends Area01BlockoutBuilderTrimContext

const WaterAmbienceBuilderScript := preload("res://scripts/area01_blockout_builder_water_ambience.gd")
const WaterEdgeArtBuilderScript := preload("res://scripts/area01_blockout_builder_water_edge_art.gd")

var _water_ambience_builder := WaterAmbienceBuilderScript.new()
var _water_edge_art_builder := WaterEdgeArtBuilderScript.new()

func _create_source_grid_water_cutouts(water_cutout_layer: Node2D, source_map: Dictionary) -> bool:
	var cutouts: Variant = source_map.get("source_grid_water_cutouts", [])
	if not cutouts is Array:
		return false
	var cutout_entries := cutouts as Array
	if cutout_entries.is_empty():
		return false

	var source_grid_polygons: Array[PackedVector2Array] = []
	for cutout_value in cutout_entries:
		if not cutout_value is Dictionary:
			continue
		var cutout_data := cutout_value as Dictionary
		var points := _points_from_json(cutout_data.get("polygon", []))
		if points.size() < 3:
			continue
		source_grid_polygons.append(points)
		var runtime_generation: Variant = cutout_data.get("runtime_generation", {})
		var runtime: Dictionary = runtime_generation as Dictionary if runtime_generation is Dictionary else {}
		var cutout_id := String(cutout_data.get("id", "source_grid_water_cutout"))
		var visible := Polygon2D.new()
		visible.name = String(runtime.get("visible_polygon2d_name", "%sWaterCutout" % _pascal_case_id(cutout_id)))
		visible.polygon = points
		visible.visible = false
		visible.color = WATER_CUTOUT_COLOR
		Area01VisualCueContractScript.tag_node(visible, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, cutout_id)
		water_cutout_layer.add_child(visible)
		_water_ambience_builder.add_source_grid_water_ambience(water_cutout_layer, cutout_id, points)

	_water_ambience_builder.add_merged_source_grid_water_skins(water_cutout_layer, source_map, source_grid_polygons)
	return true

func _add_source_grid_water_edge_art(cave_wall_art_layer: Node2D, source_map: Dictionary) -> void:
	_water_edge_art_builder.add_source_grid_water_edge_art(cave_wall_art_layer, source_map)

func _create_playable_water_visual(water_cutout_layer: Node2D, water_edge_layer: Node2D, player_rim_layer: Node2D, cave_wall_art_layer: Node2D, water: Dictionary, exact_water_visuals_enabled: bool) -> void:
	var points := _points_from_json(water.get("polygon", []))
	if points.size() < 3:
		return
	var water_kind := String(water.get("kind", ""))
	var carves_collision := bool(water.get("carves_collision", false))
	var runtime_generation: Variant = water.get("runtime_generation", {})
	var runtime: Dictionary = runtime_generation as Dictionary if runtime_generation is Dictionary else {}
	var water_id := String(water.get("id", "playable_water"))
	var visible_name := String(runtime.get("visible_polygon2d_name", "%sWaterCutout" % _pascal_case_id(water_id)))
	var edge_name := String(runtime.get("edge_line2d_name", "%sWaterEdge" % _pascal_case_id(water_id)))

	var cutout := Polygon2D.new()
	cutout.name = visible_name
	cutout.polygon = points
	cutout.visible = not exact_water_visuals_enabled
	cutout.color = OPEN_SURFACE_WATER_CUTOUT_COLOR if water_id == "open_surface_water" or water_kind == "surface" or water_kind == "open_surface" else WATER_CUTOUT_COLOR
	Area01VisualCueContractScript.tag_node(cutout, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, water_id)
	water_cutout_layer.add_child(cutout)

	var edge := Line2D.new()
	edge.name = edge_name
	edge.points = _closed_points(points)
	edge.width = 0.0
	edge.default_color = FUTURE_WATER_EDGE_COLOR if String(water.get("status", "")) == "future_locked" else WATER_EDGE_COLOR
	edge.visible = false
	Area01VisualCueContractScript.tag_node(edge, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, water_id)
	water_edge_layer.add_child(edge)

	if carves_collision and bool(runtime.get("player_facing_rim_markers", false)):
		_add_playable_water_rim_markers(player_rim_layer, "%sPlayerRimSprites" % edge_name, water_id, points, String(water.get("status", "")))
	if carves_collision and not exact_water_visuals_enabled:
		_add_generated_cave_wall_art(cave_wall_art_layer, water_id, water_kind, points, String(water.get("status", "")))

func _add_generated_cave_wall_art(cave_wall_art_layer: Node2D, water_id: String, water_kind: String, points: PackedVector2Array, status: String) -> void:
	if points.size() < 3:
		return
	if water_id == "open_surface_water" or water_kind == "surface" or water_kind == "open_surface":
		return

	var group := Node2D.new()
	group.name = "%sWallArt" % _pascal_case_id(water_id)
	group.z_index = 1
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, water_id)
	cave_wall_art_layer.add_child(group)

	var bounds := _polygon_bounds(points)
	var center := bounds.get_center()
	var alpha := GENERATED_FUTURE_CAVE_WALL_ART_ALPHA if status == "future_locked" else GENERATED_CAVE_WALL_ART_ALPHA
	for index in range(points.size()):
		var start := points[index]
		var finish := points[(index + 1) % points.size()]
		var edge := finish - start
		if edge.length() < GENERATED_CAVE_WALL_ART_SPACING * 0.55:
			continue

		var midpoint := (start + finish) * 0.5
		var trim_type := _generated_cave_wall_trim_type(edge, midpoint, center)
		var offset := _generated_cave_wall_trim_offset(midpoint, center)
		_add_generated_cave_wall_edge_trim(
			group,
			"Generated%sEdge%d" % [_pascal_case_id(trim_type), index + 1],
			trim_type,
			start,
			finish,
			offset,
			GENERATED_CAVE_WALL_ART_SPACING,
			GENERATED_CAVE_WALL_ART_SCALE,
			alpha,
			water_id
		)

func _generated_cave_wall_trim_type(edge: Vector2, midpoint: Vector2, water_center: Vector2) -> String:
	if absf(edge.x) >= absf(edge.y) * 1.35:
		if midpoint.y <= water_center.y:
			return "underside"
		return "deep_floor_lip" if midpoint.y >= 1400.0 else "top_lip"
	if absf(edge.y) >= absf(edge.x) * 1.35:
		return "vertical_wall"
	return "diagonal_slope"

func _generated_cave_wall_trim_offset(midpoint: Vector2, water_center: Vector2) -> Vector2:
	var direction := midpoint - water_center
	if direction.length() <= 0.0:
		return Vector2.ZERO
	return direction.normalized() * 14.0

func _add_generated_cave_wall_edge_trim(group: Node2D, sprite_name: String, trim_type: String, start: Vector2, finish: Vector2, offset: Vector2, spacing: float, scale: float, alpha: float, source_id: String) -> void:
	_water_edge_art_builder.add_generated_cave_wall_edge_trim(group, sprite_name, trim_type, start, finish, offset, spacing, scale, alpha, source_id)

func _add_playable_water_rim_markers(player_rim_layer: Node2D, group_name: String, water_id: String, points: PackedVector2Array, status: String) -> void:
	if points.size() < 3:
		return

	var group := Node2D.new()
	group.name = group_name
	group.z_index = 5
	player_rim_layer.add_child(group)

	var bounds := _polygon_bounds(points)
	var center := bounds.get_center()
	var alpha := FUTURE_PLAYER_RIM_MARKER_ALPHA if status == "future_locked" else PLAYER_RIM_MARKER_ALPHA
	for index in range(points.size()):
		var start := points[index]
		var finish := points[(index + 1) % points.size()]
		var edge := finish - start
		var length := edge.length()
		if length < PLAYER_RIM_MARKER_SPACING * 0.55:
			continue

		var texture := _water_rim_marker_texture(edge, (start + finish) * 0.5, center)
		if texture == null:
			continue

		var count := clampi(int(floor(length / PLAYER_RIM_MARKER_SPACING)), 1, PLAYER_RIM_MARKERS_PER_EDGE)
		var offset := _water_rim_marker_offset((start + finish) * 0.5, center)
		for marker_index in range(count):
			var fraction := float(marker_index + 1) / float(count + 1)
			var sprite := _wall_sprite(
				"WaterRimMarker%d_%d" % [index + 1, marker_index + 1],
				texture,
				start.lerp(finish, fraction) + offset,
				Vector2(PLAYER_RIM_MARKER_SCALE, PLAYER_RIM_MARKER_SCALE),
				alpha
			)
			sprite.rotation = _water_rim_marker_rotation(edge)
			Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, water_id)
			group.add_child(sprite)

func _water_rim_marker_texture(edge: Vector2, midpoint: Vector2, water_center: Vector2) -> Texture2D:
	if absf(edge.x) >= absf(edge.y) * 1.35:
		return CEILING_MIDDLE_TEXTURE if midpoint.y < water_center.y else DEEP_FLOOR_LIP_TEXTURE
	if absf(edge.y) >= absf(edge.x) * 1.35:
		return VERTICAL_MIDDLE_TEXTURE
	return DIAGONAL_SLOPE_TEXTURE

func _water_rim_marker_offset(midpoint: Vector2, water_center: Vector2) -> Vector2:
	var direction := midpoint - water_center
	if direction.length() <= 0.0:
		return Vector2.ZERO
	return direction.normalized() * 10.0

func _water_rim_marker_rotation(edge: Vector2) -> float:
	if absf(edge.x) >= absf(edge.y) * 1.35:
		return 0.0 if edge.x >= 0.0 else PI
	if absf(edge.y) >= absf(edge.x) * 1.35:
		return 0.0
	return 0.0 if edge.x >= 0.0 else PI
