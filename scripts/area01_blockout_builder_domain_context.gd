class_name Area01BlockoutBuilderDomainContext
extends Area01BlockoutBuilderWaterContext

func _create_terrain_domain_visual(terrain_layer: Node2D, terrain_domain: Dictionary) -> void:
	var points := _points_from_json(terrain_domain.get("polygon", []))
	if points.size() < 3:
		return
	var runtime_generation: Variant = terrain_domain.get("runtime_generation", {})
	var runtime: Dictionary = runtime_generation as Dictionary if runtime_generation is Dictionary else {}
	var domain_id := String(terrain_domain.get("id", "terrain_domain"))
	var visible_name := String(runtime.get("visible_polygon2d_name", "ContinuousUnderseaTerrainDomain"))
	var visible := Polygon2D.new()
	visible.name = visible_name
	visible.polygon = points
	visible.uv = _texture_uv_for_points(points, Rect2())
	visible.texture = REEF_WALL_FILL_TEXTURE
	visible.visible = true
	visible.color = TERRAIN_DOMAIN_COLOR
	Area01VisualCueContractScript.tag_node(visible, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, domain_id)
	terrain_layer.add_child(visible)

func _add_generated_domain_accents(terrain_layer: Node2D, terrain_domain: Dictionary) -> void:
	var points := _points_from_json(terrain_domain.get("polygon", []))
	if points.size() < 3:
		return

	var bounds := _polygon_bounds(points)
	if bounds.size.x <= 0.0 or bounds.size.y <= 0.0:
		return

	var domain_id := String(terrain_domain.get("id", "terrain_domain"))
	var layer := Node2D.new()
	layer.name = GENERATED_DOMAIN_ACCENT_LAYER_NAME
	layer.z_index = 2
	Area01VisualCueContractScript.tag_node(layer, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, domain_id)
	terrain_layer.add_child(layer)

	var upper_shadow := Polygon2D.new()
	upper_shadow.name = "ContinuousUpperReefShadow"
	upper_shadow.color = Color(0.0, 0.03, 0.035, 0.18)
	upper_shadow.polygon = PackedVector2Array([
		Vector2(bounds.position.x, bounds.position.y),
		Vector2(bounds.end.x, bounds.position.y),
		Vector2(bounds.end.x, bounds.position.y + clampf(bounds.size.y * 0.10, 96.0, 190.0)),
		Vector2(bounds.position.x, bounds.position.y + clampf(bounds.size.y * 0.15, 128.0, 260.0)),
	])
	layer.add_child(upper_shadow)

	var lower_shadow := Polygon2D.new()
	lower_shadow.name = "ContinuousLowerDepthMass"
	lower_shadow.color = Color(0.0, 0.012, 0.018, 0.20)
	lower_shadow.polygon = PackedVector2Array([
		Vector2(bounds.position.x, bounds.position.y + bounds.size.y * 0.62),
		Vector2(bounds.end.x, bounds.position.y + bounds.size.y * 0.58),
		Vector2(bounds.end.x, bounds.end.y),
		Vector2(bounds.position.x, bounds.end.y),
	])
	layer.add_child(lower_shadow)

	_add_strata_band(layer, "GeneratedUpperReefStrata", bounds, 0.18, 0.08, STRATA_LIGHT_COLOR.lightened(0.12), -24.0)
	_add_strata_band(layer, "GeneratedMidReefStrata", bounds, 0.43, 0.10, STRATA_DARK_COLOR, 18.0)
	_add_strata_band(layer, "GeneratedLowerReefStrata", bounds, 0.73, 0.08, STRATA_LIGHT_COLOR.darkened(0.4), -14.0)
	_add_generated_domain_decals(layer, bounds)

func _add_generated_domain_decals(layer: Node2D, bounds: Rect2) -> void:
	var decal_specs := [
		{"name": "GeneratedDomainKelpDecal", "texture": WALL_KELP_TEXTURE, "position": bounds.position + Vector2(bounds.size.x * 0.18, bounds.size.y * 0.28), "scale": Vector2(0.30, 0.30), "alpha": 0.22},
		{"name": "GeneratedDomainCrackDecal", "texture": WALL_CRACK_TEXTURE, "position": bounds.position + Vector2(bounds.size.x * 0.38, bounds.size.y * 0.52), "scale": Vector2(0.34, 0.34), "alpha": 0.20},
		{"name": "GeneratedDomainCoralDecal", "texture": WALL_CORAL_TEXTURE, "position": bounds.position + Vector2(bounds.size.x * 0.68, bounds.size.y * 0.37), "scale": Vector2(0.30, 0.30), "alpha": 0.22},
		{"name": "GeneratedDomainCornerCapDecal", "texture": WALL_CORNER_TEXTURE, "position": bounds.position + Vector2(bounds.size.x * 0.82, bounds.size.y * 0.72), "scale": Vector2(0.28, 0.28), "alpha": 0.18},
	]
	for spec in decal_specs:
		var sprite := _wall_sprite(
			String(spec["name"]),
			spec["texture"] as Texture2D,
			spec["position"] as Vector2,
			spec["scale"] as Vector2,
			float(spec["alpha"])
		)
		Area01VisualCueContractScript.tag_node(sprite, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, String(spec["name"]))
		layer.add_child(sprite)
