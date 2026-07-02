class_name Area01BlockoutBuilderTrimContext
extends Area01BlockoutBuilderBase

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
