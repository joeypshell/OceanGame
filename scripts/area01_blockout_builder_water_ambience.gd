extends Area01BlockoutBuilderBase

func add_merged_source_grid_water_skins(water_cutout_layer: Node2D, source_map: Dictionary, source_grid_polygons: Array[PackedVector2Array]) -> void:
	if source_grid_polygons.is_empty():
		return

	var merged_polygons := _player_facing_water_skin_polygons(source_map, source_grid_polygons)
	var group := Node2D.new()
	group.name = GENERATED_WATER_SKIN_LAYER_NAME
	group.z_index = 0
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, GENERATED_WATER_SKIN_LAYER_NAME)
	water_cutout_layer.add_child(group)

	for index in range(merged_polygons.size()):
		var polygon := merged_polygons[index]
		if polygon.size() < 3:
			continue
		var skin := Polygon2D.new()
		skin.name = "MergedWaterSkin%d" % (index + 1)
		skin.polygon = polygon
		skin.visible = true
		skin.color = MERGED_WATER_SKIN_COLOR
		Area01VisualCueContractScript.tag_node(skin, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, GENERATED_WATER_SKIN_LAYER_NAME)
		group.add_child(skin)
		_add_merged_source_grid_water_inner_read(group, polygon, index)

func _player_facing_water_skin_polygons(source_map: Dictionary, source_grid_polygons: Array[PackedVector2Array]) -> Array[PackedVector2Array]:
	var region_skins: Array[PackedVector2Array] = []
	var playable_regions: Variant = source_map.get("playable_water_regions", [])
	if playable_regions is Array:
		for region_value in playable_regions:
			if not region_value is Dictionary:
				continue
			var region := region_value as Dictionary
			var water_kind := String(region.get("kind", ""))
			var water_id := String(region.get("id", ""))
			if water_kind == "surface" or water_kind == "open_surface" or water_kind == "locked_promise" or water_id == "open_surface_water":
				continue
			var points := _points_from_json(region.get("polygon", []))
			if points.size() >= 3:
				region_skins.append(_softened_water_skin_polygon(points, region_skins.size()))
	if not region_skins.is_empty():
		return region_skins

	var fallback_skins: Array[PackedVector2Array] = []
	for index in range(mini(source_grid_polygons.size(), 16)):
		fallback_skins.append(_softened_water_skin_polygon(source_grid_polygons[index], index))
	return fallback_skins

func _softened_water_skin_polygon(points: PackedVector2Array, index: int) -> PackedVector2Array:
	var bounds := _polygon_bounds(points)
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0:
		return points

	var inset_x := clampf(bounds.size.x * 0.16, 72.0, 260.0)
	var inset_y := clampf(bounds.size.y * 0.18, 48.0, 190.0)
	return _organic_water_blob_polygon(bounds, index, inset_x, inset_y, MERGED_WATER_SKIN_VERTEX_COUNT)

func _add_merged_source_grid_water_inner_read(group: Node2D, polygon: PackedVector2Array, index: int) -> void:
	var bounds := _polygon_bounds(polygon)
	if bounds.size.x < 160.0 or bounds.size.y < 96.0:
		return

	var inset_x := clampf(bounds.size.x * 0.12, 18.0, 80.0)
	var inset_y := clampf(bounds.size.y * 0.14, 16.0, 84.0)
	if bounds.size.x - inset_x * 2.0 <= 24.0 or bounds.size.y - inset_y * 2.0 <= 24.0:
		return

	var checksum := _source_grid_water_edge_checksum("merged_water_skin_%d" % index)
	var inner := Polygon2D.new()
	inner.name = "MergedWaterInteriorRead%d" % (index + 1)
	inner.color = MERGED_WATER_SKIN_INNER_COLOR
	inner.polygon = _organic_water_blob_polygon(bounds, checksum, inset_x, inset_y, 10)
	Area01VisualCueContractScript.tag_node(inner, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, GENERATED_WATER_SKIN_LAYER_NAME)
	group.add_child(inner)

func _organic_water_blob_polygon(bounds: Rect2, seed: int, inset_x: float, inset_y: float, point_count: int) -> PackedVector2Array:
	var margin := MERGED_WATER_SKIN_EDGE_MARGIN
	var center := bounds.get_center()
	center += Vector2(
		float(seed % 3 - 1) * minf(bounds.size.x * 0.025, 34.0),
		float((seed / 3) % 3 - 1) * minf(bounds.size.y * 0.025, 28.0)
	)
	var radius_x := maxf(bounds.size.x * 0.5 - inset_x, 28.0)
	var radius_y := maxf(bounds.size.y * 0.5 - inset_y, 22.0)
	var polygon := PackedVector2Array()
	for point_index in range(maxi(point_count, 8)):
		var angle := (PI * 2.0) * float(point_index) / float(maxi(point_count, 8))
		var wobble_x := 0.90 + sin(angle * 3.0 + float(seed) * 0.17) * 0.055 + cos(angle * 5.0 + float(seed) * 0.07) * 0.030
		var wobble_y := 0.90 + cos(angle * 2.0 + float(seed) * 0.13) * 0.060 + sin(angle * 4.0 + float(seed) * 0.09) * 0.025
		var point := center + Vector2(cos(angle) * radius_x * wobble_x, sin(angle) * radius_y * wobble_y)
		point.x = clampf(point.x, bounds.position.x + margin, bounds.end.x - margin)
		point.y = clampf(point.y, bounds.position.y + margin, bounds.end.y - margin)
		polygon.append(point)
	return polygon

func add_source_grid_water_ambience(water_cutout_layer: Node2D, cutout_id: String, points: PackedVector2Array) -> void:
	var bounds := _polygon_bounds(points)
	var is_corridor := _is_water_ambience_corridor(bounds)
	if is_corridor and minf(bounds.size.x, bounds.size.y) < WATER_AMBIENCE_CORRIDOR_MIN_DECORATED_SHORT_AXIS:
		return
	if not is_corridor and (bounds.size.x < WATER_AMBIENCE_MIN_WIDTH or bounds.size.y < WATER_AMBIENCE_MIN_HEIGHT):
		return
	if bounds.position.y < WATER_AMBIENCE_MIN_Y:
		return

	var checksum := _source_grid_water_edge_checksum(cutout_id)
	var group := Node2D.new()
	group.name = "%sWaterAmbience" % _pascal_case_id(cutout_id)
	group.z_index = 1
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, cutout_id)
	water_cutout_layer.add_child(group)

	if bounds.size.y >= 240.0:
		_add_water_ambience_depth_veil(group, bounds, checksum, cutout_id)
	_add_water_ambience_silt(group, bounds, checksum, cutout_id)
	if bounds.size.x >= 420.0:
		_add_water_ambience_current_ribbon(group, bounds, checksum, cutout_id)
	if is_corridor:
		_add_water_ambience_corridor_breakup(group, bounds, checksum, cutout_id)
	_add_water_ambience_motes(group, bounds, checksum, cutout_id)

func _is_water_ambience_corridor(bounds: Rect2) -> bool:
	var long_axis := maxf(bounds.size.x, bounds.size.y)
	var short_axis := minf(bounds.size.x, bounds.size.y)
	return long_axis >= WATER_AMBIENCE_CORRIDOR_MIN_LONG_AXIS and short_axis <= WATER_AMBIENCE_CORRIDOR_MAX_SHORT_AXIS

func _add_water_ambience_silt(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var stripe_count := clampi(int(floor(bounds.size.y / 280.0)) + 1, 1, 3)
	for index in range(stripe_count):
		var fraction := (float(index) + 1.0) / (float(stripe_count) + 1.0)
		var y := bounds.position.y + bounds.size.y * fraction
		var slant := (float((checksum + index) % 5) - 2.0) * 10.0
		var inset := bounds.size.x * (0.16 + float((checksum + index) % 3) * 0.035)
		var thickness := clampf(bounds.size.y * 0.035, 8.0, 22.0)
		var ribbon := Polygon2D.new()
		ribbon.name = "SuspendedSiltRibbon%d" % (index + 1)
		ribbon.color = WATER_AMBIENCE_SILT_COLOR
		ribbon.polygon = PackedVector2Array([
			Vector2(bounds.position.x + inset, y),
			Vector2(bounds.end.x - inset * 0.75, y + slant),
			Vector2(bounds.end.x - inset * 0.85, y + slant + thickness),
			Vector2(bounds.position.x + inset * 1.18, y + thickness),
		])
		Area01VisualCueContractScript.tag_node(ribbon, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(ribbon)

func _add_water_ambience_depth_veil(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var veil_count := clampi(int(floor(bounds.size.x / 520.0)) + 1, 1, 3)
	for index in range(veil_count):
		var fraction := (float(index) + 1.0) / (float(veil_count) + 1.0)
		var x := bounds.position.x + bounds.size.x * fraction + float((checksum + index) % 5 - 2) * 18.0
		var width := clampf(bounds.size.x * (0.10 + float((checksum + index) % 3) * 0.025), 42.0, 150.0)
		var inset_y := bounds.size.y * 0.08
		var lean := float((checksum + index * 3) % 7 - 3) * 8.0
		var veil := Polygon2D.new()
		veil.name = "DepthVeil%d" % (index + 1)
		veil.color = WATER_AMBIENCE_VEIL_COLOR
		veil.polygon = PackedVector2Array([
			Vector2(x - width * 0.50, bounds.position.y + inset_y),
			Vector2(x + width * 0.42, bounds.position.y + inset_y * 0.45),
			Vector2(x + width * 0.18 + lean, bounds.end.y - inset_y),
			Vector2(x - width * 0.70 + lean, bounds.end.y - inset_y * 0.35),
		])
		Area01VisualCueContractScript.tag_node(veil, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(veil)

func _add_water_ambience_corridor_breakup(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var corridor_group := Node2D.new()
	corridor_group.name = "CorridorBreakup"
	corridor_group.z_index = 1
	Area01VisualCueContractScript.tag_node(corridor_group, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
	group.add_child(corridor_group)

	if bounds.size.x >= bounds.size.y:
		_add_horizontal_corridor_breakup(corridor_group, bounds, checksum, source_id)
	else:
		_add_vertical_corridor_breakup(corridor_group, bounds, checksum, source_id)

func _add_horizontal_corridor_breakup(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var shadow_count := clampi(int(floor(bounds.size.x / 460.0)) + 1, 2, 5)
	var shadow_height := clampf(bounds.size.y * 0.62, 14.0, 54.0)
	for index in range(shadow_count):
		var fraction := (float(index) + 0.72) / (float(shadow_count) + 0.65)
		var x := bounds.position.x + bounds.size.x * fraction + float((checksum + index) % 5 - 2) * 18.0
		var width := clampf(bounds.size.x * 0.12, 72.0, 180.0)
		var lower_y := bounds.end.y - bounds.size.y * (0.08 + float((checksum + index) % 3) * 0.025)
		var shadow := Polygon2D.new()
		shadow.name = "HorizontalCorridorShadow%d" % (index + 1)
		shadow.color = WATER_AMBIENCE_CORRIDOR_SHADOW_COLOR
		shadow.polygon = PackedVector2Array([
			Vector2(x - width * 0.55, lower_y + 3.0),
			Vector2(x - width * 0.18, lower_y - shadow_height),
			Vector2(x + width * 0.42, lower_y - shadow_height * 0.52),
			Vector2(x + width * 0.60, lower_y + 2.0),
		])
		Area01VisualCueContractScript.tag_node(shadow, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(shadow)

	var eddy_count := clampi(int(floor(bounds.size.x / 620.0)) + 1, 2, 4)
	for index in range(eddy_count):
		var fraction := (float(index) + 0.76) / (float(eddy_count) + 0.58)
		var x := bounds.position.x + bounds.size.x * fraction + float((checksum + index * 2) % 7 - 3) * 14.0
		var y := bounds.position.y + bounds.size.y * (0.42 + float((checksum + index) % 5 - 2) * 0.026)
		var width := clampf(bounds.size.x * 0.09, 64.0, 150.0)
		var height := clampf(bounds.size.y * 0.14, 8.0, 18.0)
		var eddy := Polygon2D.new()
		eddy.name = "HorizontalCorridorDepthEddy%d" % (index + 1)
		eddy.color = WATER_AMBIENCE_CORRIDOR_GLOW_COLOR
		eddy.polygon = PackedVector2Array([
			Vector2(x - width * 0.52, y + height * 0.18),
			Vector2(x - width * 0.12, y - height * 0.62),
			Vector2(x + width * 0.38, y - height * 0.46),
			Vector2(x + width * 0.56, y + height * 0.10),
			Vector2(x + width * 0.10, y + height * 0.60),
			Vector2(x - width * 0.42, y + height * 0.48),
		])
		Area01VisualCueContractScript.tag_node(eddy, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(eddy)

func _add_vertical_corridor_breakup(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var shadow_count := clampi(int(floor(bounds.size.y / 520.0)) + 1, 2, 5)
	var shadow_width := clampf(bounds.size.x * 0.72, 18.0, 62.0)
	for index in range(shadow_count):
		var fraction := (float(index) + 0.64) / (float(shadow_count) + 0.58)
		var y := bounds.position.y + bounds.size.y * fraction + float((checksum + index) % 7 - 3) * 16.0
		var x := bounds.position.x + bounds.size.x * (0.18 + float((checksum + index) % 3) * 0.16)
		var height := clampf(bounds.size.y * 0.11, 84.0, 210.0)
		var shadow := Polygon2D.new()
		shadow.name = "VerticalCorridorShadow%d" % (index + 1)
		shadow.color = WATER_AMBIENCE_CORRIDOR_SHADOW_COLOR
		shadow.polygon = PackedVector2Array([
			Vector2(x, y - height * 0.55),
			Vector2(x + shadow_width, y - height * 0.34),
			Vector2(x + shadow_width * 0.62, y + height * 0.50),
			Vector2(x - shadow_width * 0.20, y + height * 0.34),
		])
		Area01VisualCueContractScript.tag_node(shadow, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(shadow)

	var eddy_count := clampi(int(floor(bounds.size.y / 680.0)) + 1, 2, 4)
	for index in range(eddy_count):
		var fraction := (float(index) + 0.72) / (float(eddy_count) + 0.52)
		var x := bounds.position.x + bounds.size.x * (0.44 + float((checksum + index) % 5 - 2) * 0.032)
		var y := bounds.position.y + bounds.size.y * fraction + float((checksum + index * 3) % 7 - 3) * 15.0
		var width := clampf(bounds.size.x * 0.18, 8.0, 18.0)
		var height := clampf(bounds.size.y * 0.08, 70.0, 160.0)
		var eddy := Polygon2D.new()
		eddy.name = "VerticalCorridorDepthEddy%d" % (index + 1)
		eddy.color = WATER_AMBIENCE_CORRIDOR_GLOW_COLOR
		eddy.polygon = PackedVector2Array([
			Vector2(x - width * 0.28, y - height * 0.48),
			Vector2(x + width * 0.62, y - height * 0.30),
			Vector2(x + width * 0.48, y + height * 0.16),
			Vector2(x + width * 0.02, y + height * 0.52),
			Vector2(x - width * 0.58, y + height * 0.24),
			Vector2(x - width * 0.44, y - height * 0.20),
		])
		Area01VisualCueContractScript.tag_node(eddy, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(eddy)

func _add_water_ambience_current_ribbon(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var eddy_count := clampi(int(floor(bounds.size.x / 780.0)) + 1, 1, 4)
	for index in range(eddy_count):
		var fraction := (float(index) + 0.66) / (float(eddy_count) + 0.44)
		var x := bounds.position.x + bounds.size.x * fraction + float((checksum + index * 5) % 9 - 4) * 16.0
		var y := bounds.position.y + bounds.size.y * (0.34 + float((checksum + index) % 4) * 0.07)
		var width := clampf(bounds.size.x * 0.10, 90.0, 190.0)
		var thickness := clampf(bounds.size.y * 0.025, 6.0, 15.0)
		var eddy := Polygon2D.new()
		eddy.name = "SoftCurrentEddy%d" % (index + 1)
		eddy.color = WATER_AMBIENCE_CURRENT_COLOR
		eddy.polygon = PackedVector2Array([
			Vector2(x - width * 0.52, y + thickness * 0.38),
			Vector2(x - width * 0.12, y - thickness * 0.70),
			Vector2(x + width * 0.36, y - thickness * 0.56),
			Vector2(x + width * 0.56, y + thickness * 0.18),
			Vector2(x + width * 0.08, y + thickness * 0.70),
			Vector2(x - width * 0.44, y + thickness * 0.52),
		])
		Area01VisualCueContractScript.tag_node(eddy, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(eddy)

func _add_water_ambience_motes(group: Node2D, bounds: Rect2, checksum: int, source_id: String) -> void:
	var mote_count := clampi(int(floor(bounds.size.x * bounds.size.y / 180000.0)), 2, 8)
	for index in range(mote_count):
		var x_fraction := 0.18 + fmod(float(checksum * 7 + index * 23), 64.0) / 100.0
		var y_fraction := 0.20 + fmod(float(checksum * 11 + index * 31), 60.0) / 100.0
		var radius := 2.6 + float((checksum + index) % 4) * 0.85
		var mote := Polygon2D.new()
		mote.name = "SuspendedMote%d" % (index + 1)
		mote.color = WATER_AMBIENCE_MOTE_COLOR
		mote.position = Vector2(
			bounds.position.x + bounds.size.x * clampf(x_fraction, 0.12, 0.88),
			bounds.position.y + bounds.size.y * clampf(y_fraction, 0.14, 0.86)
		)
		mote.polygon = _regular_marker_polygon(radius, 8)
		Area01VisualCueContractScript.tag_node(mote, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, source_id)
		group.add_child(mote)
