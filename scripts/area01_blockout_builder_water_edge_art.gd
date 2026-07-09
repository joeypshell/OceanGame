extends Area01BlockoutBuilderTrimContext

func add_source_grid_water_edge_art(cave_wall_art_layer: Node2D, source_map: Dictionary) -> void:
	var edges: Variant = source_map.get("source_grid_water_edges", [])
	if not edges is Array:
		return
	var edge_entries := edges as Array
	if edge_entries.is_empty():
		return

	_add_source_grid_water_edge_bands(cave_wall_art_layer, edge_entries)
	_add_source_grid_water_corner_caps(cave_wall_art_layer, edge_entries)
	_add_source_grid_water_breakup_sprites(cave_wall_art_layer, edge_entries)

	var group := Node2D.new()
	group.name = "SourceGridWaterBoundaryWallArt"
	group.z_index = 1
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, group.name)
	cave_wall_art_layer.add_child(group)

	for edge_value in edge_entries:
		if group.get_child_count() >= SOURCE_GRID_WATER_EDGE_ART_MAX_SPRITES:
			break
		if not edge_value is Dictionary:
			continue
		var edge_data := edge_value as Dictionary
		var points := _points_from_json(edge_data.get("points", []))
		if points.size() < 2:
			continue
		if points[0].distance_to(points[1]) < SOURCE_GRID_WATER_EDGE_ART_MIN_LENGTH:
			continue
		var edge_id := String(edge_data.get("id", "source_grid_water_edge"))
		var trim_type := String(edge_data.get("trim_type", ""))
		var solid_side := String(edge_data.get("solid_side", ""))
		var offset := _source_grid_water_edge_trim_offset(solid_side)
		add_generated_cave_wall_edge_trim(
			group,
			"SourceGrid%s" % _pascal_case_id(edge_id),
			trim_type,
			points[0],
			points[1],
			offset,
			SOURCE_GRID_WATER_EDGE_ART_SPACING,
			SOURCE_GRID_WATER_EDGE_ART_SCALE,
			SOURCE_GRID_WATER_EDGE_ART_ALPHA,
			edge_id
		)

func _add_source_grid_water_edge_bands(cave_wall_art_layer: Node2D, edge_entries: Array) -> void:
	var group := Node2D.new()
	group.name = "SourceGridWaterBoundarySoftBands"
	group.z_index = 0
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, group.name)
	cave_wall_art_layer.add_child(group)

	for edge_value in edge_entries:
		if not edge_value is Dictionary:
			continue
		var edge_data := edge_value as Dictionary
		var points := _points_from_json(edge_data.get("points", []))
		if points.size() < 2:
			continue
		if points[0].distance_to(points[1]) < SOURCE_GRID_WATER_EDGE_BAND_MIN_LENGTH:
			continue
		var solid_side := String(edge_data.get("solid_side", ""))
		var offset := _source_grid_water_edge_band_offset(solid_side)
		if offset == Vector2.ZERO:
			continue
		var edge_id := String(edge_data.get("id", "source_grid_water_edge"))
		var trim_type := String(edge_data.get("trim_type", ""))
		var band_polygon := PackedVector2Array()
		band_polygon.append(points[0])
		band_polygon.append(points[1])
		band_polygon.append(points[1] + offset)
		band_polygon.append(points[0] + offset)

		var band := Polygon2D.new()
		band.name = "SourceGrid%sSoftBand" % _pascal_case_id(edge_id)
		band.polygon = band_polygon
		band.color = _source_grid_water_edge_band_color(solid_side, trim_type)
		band.visible = true
		Area01VisualCueContractScript.tag_node(band, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, edge_id)
		group.add_child(band)

func _add_source_grid_water_corner_caps(cave_wall_art_layer: Node2D, edge_entries: Array) -> void:
	var endpoints := {}
	for edge_value in edge_entries:
		if not edge_value is Dictionary:
			continue
		var edge_data := edge_value as Dictionary
		var points := _points_from_json(edge_data.get("points", []))
		if points.size() < 2:
			continue
		_register_source_grid_water_corner_endpoint(endpoints, points[0], edge_data)
		_register_source_grid_water_corner_endpoint(endpoints, points[1], edge_data)

	var group := Node2D.new()
	group.name = "SourceGridWaterBoundaryCornerCaps"
	group.z_index = 2
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, group.name)
	cave_wall_art_layer.add_child(group)

	var endpoint_keys := endpoints.keys()
	endpoint_keys.sort()
	var cap_count := 0
	for key in endpoint_keys:
		if cap_count >= SOURCE_GRID_WATER_CORNER_CAP_MAX_COUNT:
			break
		if _source_grid_water_edge_checksum(String(key)) % SOURCE_GRID_WATER_CORNER_CAP_STRIDE != 0:
			continue
		var entry := endpoints[key] as Dictionary
		var adjacent_edges := entry.get("edges", []) as Array
		if adjacent_edges.size() < 2:
			continue
		if _source_grid_water_corner_side_count(adjacent_edges) < 2:
			continue
		var point := entry.get("point", Vector2.ZERO) as Vector2
		var offset := _source_grid_water_corner_cap_offset(adjacent_edges)
		if offset == Vector2.ZERO:
			continue
		var cap := _wall_sprite(
			"SourceGridCorner%sCap" % _source_grid_corner_key_suffix(String(key)),
			WALL_CORNER_TEXTURE,
			point + offset,
			Vector2(SOURCE_GRID_WATER_CORNER_CAP_SCALE, SOURCE_GRID_WATER_CORNER_CAP_SCALE),
			SOURCE_GRID_WATER_CORNER_CAP_ALPHA
		)
		cap.rotation = offset.angle() + PI * 0.25
		Area01VisualCueContractScript.tag_node(cap, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, "source_grid_water_corner")
		group.add_child(cap)
		cap_count += 1

func _add_source_grid_water_breakup_sprites(cave_wall_art_layer: Node2D, edge_entries: Array) -> void:
	var group := Node2D.new()
	group.name = "SourceGridWaterBoundaryBreakupSprites"
	group.z_index = 3
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, group.name)
	cave_wall_art_layer.add_child(group)

	var breakup_count := 0
	for edge_value in edge_entries:
		if breakup_count >= SOURCE_GRID_WATER_BREAKUP_MAX_SPRITES:
			break
		if not edge_value is Dictionary:
			continue
		var edge_data := edge_value as Dictionary
		var points := _points_from_json(edge_data.get("points", []))
		if points.size() < 2:
			continue
		var edge_id := String(edge_data.get("id", "source_grid_water_edge"))
		var trim_type := String(edge_data.get("trim_type", ""))
		var solid_side := String(edge_data.get("solid_side", ""))
		if not _source_grid_water_edge_gets_breakup(edge_id, trim_type):
			continue
		var offset := _source_grid_water_edge_trim_offset(solid_side)
		if offset == Vector2.ZERO:
			continue
		var edge := points[1] - points[0]
		if edge.length() < SOURCE_GRID_WATER_EDGE_ART_MIN_LENGTH:
			continue
		var checksum := _source_grid_water_edge_checksum(edge_id)
		var fraction := 0.34 + float(checksum % 3) * 0.16
		var scale := SOURCE_GRID_WATER_BREAKUP_SCALE * (0.9 + float(checksum % 4) * 0.04)
		var sprite := _wall_sprite(
			"SourceGrid%sBreakup" % _pascal_case_id(edge_id),
			_source_grid_water_breakup_texture(checksum, trim_type),
			points[0].lerp(points[1], fraction) + offset * 0.55,
			Vector2(scale, scale),
			SOURCE_GRID_WATER_BREAKUP_ALPHA
		)
		sprite.rotation = edge.angle()
		if trim_type == "vertical_wall":
			sprite.rotation += PI * 0.5
		sprite.rotation += (float(checksum % 5) - 2.0) * 0.08
		Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, edge_id)
		group.add_child(sprite)
		breakup_count += 1

func _register_source_grid_water_corner_endpoint(endpoints: Dictionary, point: Vector2, edge_data: Dictionary) -> void:
	var key := _source_grid_corner_key(point)
	var entry: Dictionary = endpoints.get(key, {"point": point, "edges": []})
	var adjacent_edges := entry.get("edges", []) as Array
	adjacent_edges.append(edge_data)
	entry["edges"] = adjacent_edges
	endpoints[key] = entry

func _source_grid_corner_key(point: Vector2) -> String:
	return "%d,%d" % [roundi(point.x), roundi(point.y)]

func _source_grid_corner_key_suffix(key: String) -> String:
	return key.replace(",", "_")

func _source_grid_water_corner_side_count(adjacent_edges: Array) -> int:
	var sides := {}
	for edge_value in adjacent_edges:
		if not edge_value is Dictionary:
			continue
		var side := String((edge_value as Dictionary).get("solid_side", ""))
		if not side.is_empty():
			sides[side] = true
	return sides.size()

func _source_grid_water_corner_cap_offset(adjacent_edges: Array) -> Vector2:
	var offset := Vector2.ZERO
	var count := 0
	for edge_value in adjacent_edges:
		if not edge_value is Dictionary:
			continue
		var side := String((edge_value as Dictionary).get("solid_side", ""))
		var side_offset := _source_grid_water_edge_trim_offset(side)
		if side_offset == Vector2.ZERO:
			continue
		offset += side_offset.normalized()
		count += 1
	if count <= 0 or offset.length() <= 0.0:
		return Vector2.ZERO
	return offset.normalized() * SOURCE_GRID_WATER_CORNER_CAP_OFFSET

func _source_grid_water_edge_gets_breakup(edge_id: String, trim_type: String) -> bool:
	if trim_type.is_empty():
		return false
	return _source_grid_water_edge_checksum(edge_id) % SOURCE_GRID_WATER_BREAKUP_STRIDE == 0

func _source_grid_water_breakup_texture(checksum: int, trim_type: String) -> Texture2D:
	if trim_type == "vertical_wall":
		return WALL_KELP_TEXTURE if checksum % 2 == 0 else WALL_CRACK_TEXTURE
	match checksum % 3:
		0:
			return WALL_CRACK_TEXTURE
		1:
			return WALL_CORAL_TEXTURE
		_:
			return WALL_KELP_TEXTURE

func _source_grid_water_edge_band_offset(solid_side: String) -> Vector2:
	match solid_side:
		"top":
			return Vector2(0.0, SOURCE_GRID_WATER_EDGE_BAND_WIDTH)
		"bottom":
			return Vector2(0.0, -SOURCE_GRID_WATER_EDGE_BAND_WIDTH)
		"left":
			return Vector2(SOURCE_GRID_WATER_EDGE_BAND_WIDTH, 0.0)
		"right":
			return Vector2(-SOURCE_GRID_WATER_EDGE_BAND_WIDTH, 0.0)
		_:
			return Vector2.ZERO

func _source_grid_water_edge_band_color(solid_side: String, trim_type: String) -> Color:
	if solid_side == "top" or trim_type == "underside":
		return SOURCE_GRID_WATER_EDGE_CEILING_SHADOW_COLOR
	if solid_side == "bottom" or trim_type == "top_lip" or trim_type == "deep_floor_lip":
		return SOURCE_GRID_WATER_EDGE_FLOOR_GLOW_COLOR
	if solid_side == "left" or solid_side == "right" or trim_type == "vertical_wall":
		return SOURCE_GRID_WATER_EDGE_SIDE_OCCLUSION_COLOR
	return SOURCE_GRID_WATER_EDGE_DEFAULT_BAND_COLOR

func _source_grid_water_edge_trim_offset(solid_side: String) -> Vector2:
	match solid_side:
		"top":
			return Vector2(0.0, -14.0)
		"bottom":
			return Vector2(0.0, 14.0)
		"left":
			return Vector2(-14.0, 0.0)
		"right":
			return Vector2(14.0, 0.0)
		_:
			return Vector2.ZERO


func add_generated_cave_wall_edge_trim(group: Node2D, sprite_name: String, trim_type: String, start: Vector2, finish: Vector2, offset: Vector2, spacing: float, scale: float, alpha: float, source_id: String) -> void:
	var edge := finish - start
	var length := edge.length()
	if length <= 0.0:
		return

	var textures := _trim_texture_sequence_for_type(trim_type)
	if textures.is_empty():
		return

	if textures.size() < 3:
		var texture := textures[0] as Texture2D
		var count := clampi(int(floor(length / spacing)), 1, GENERATED_CAVE_WALL_ART_MAX_REPEATS)
		var angle := edge.angle()
		for index in range(count):
			var fraction := float(index + 1) / float(count + 1)
			var sprite := _wall_sprite("%sRepeat%d" % [sprite_name, index + 1], texture, start.lerp(finish, fraction) + offset, Vector2(scale, scale), alpha)
			sprite.rotation = angle
			Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, source_id)
			group.add_child(sprite)
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
	for entry in [
		{"name": "%sStartCap" % sprite_name, "texture": start_texture, "position": start + offset + direction * cap_inset},
		{"name": "%sEndCap" % sprite_name, "texture": end_texture, "position": finish + offset - direction * cap_inset},
	]:
		var sprite := _wall_sprite(String(entry["name"]), entry["texture"] as Texture2D, entry["position"] as Vector2, Vector2(scale, scale), alpha)
		sprite.rotation = angle
		Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, source_id)
		group.add_child(sprite)
	if length <= spacing * 1.25:
		return

	var repeat_count := clampi(int(floor((length - cap_inset * 2.0) / spacing)), 1, GENERATED_CAVE_WALL_ART_MAX_REPEATS)
	for index in range(repeat_count):
		var fraction := float(index + 1) / float(repeat_count + 1)
		var sprite := _wall_sprite("%sMiddle%d" % [sprite_name, index + 1], middle_texture, start.lerp(finish, fraction) + offset, Vector2(scale, scale), alpha)
		sprite.rotation = angle
		Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, source_id)
		group.add_child(sprite)
