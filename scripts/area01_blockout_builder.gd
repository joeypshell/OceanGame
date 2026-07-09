class_name Area01BlockoutBuilder
extends Area01BlockoutBuilderDomainContext

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
	for path in [RUNTIME_SOURCE_MAP_PATH, RUNTIME_SOURCE_MAP_V3_PATH, LEGACY_SOURCE_MAP_PATH]:
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
		if art_slice is CanvasItem:
			(art_slice as CanvasItem).z_index = AREA01_ART_SLICE_Z_INDEX
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

	_create_generated_source_visuals(terrain_layer, rim_layer, source_map)

	for terrain in source_map.get("solid_terrain", []):
		if typeof(terrain) != TYPE_DICTIONARY:
			last_error = "generated solid terrain entry is not a dictionary"
			return false
		if not _create_generated_solid(terrain_layer, collision_root, rim_layer, terrain as Dictionary):
			return false
		if not _is_generated_solid_partition(terrain as Dictionary):
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
	visible.uv = _texture_uv_for_points(points, Rect2())
	visible.texture = REEF_WALL_FILL_TEXTURE
	visible.visible = true
	visible.color = SOLID_COLOR
	Area01VisualCueContractScript.tag_node(visible, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, terrain_id)
	terrain_layer.add_child(visible)

	var collision := CollisionPolygon2D.new()
	collision.name = collision_name
	collision.polygon = points
	collision.disabled = not bool(terrain.get("blocks_player", true))
	Area01VisualCueContractScript.tag_node(collision, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, terrain_id)
	collision_root.add_child(collision)

	var rim := Polygon2D.new()
	rim.name = rim_name
	rim.polygon = points
	rim.visible = true
	rim.color = LIP_COLOR
	Area01VisualCueContractScript.tag_node(rim, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, terrain_id)
	rim_layer.add_child(rim)
	return true

func _create_generated_source_visuals(terrain_layer: Node2D, rim_layer: Node2D, source_map: Dictionary) -> void:
	var terrain_domain: Variant = source_map.get("terrain_domain", {})
	if terrain_domain is Dictionary:
		_create_terrain_domain_visual(terrain_layer, terrain_domain as Dictionary)

	var water_cutout_layer := Node2D.new()
	water_cutout_layer.name = GENERATED_WATER_CUTOUT_LAYER_NAME
	water_cutout_layer.z_index = 5
	Area01VisualCueContractScript.tag_node(water_cutout_layer, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, GENERATED_WATER_CUTOUT_LAYER_NAME)
	terrain_layer.add_child(water_cutout_layer)

	var water_edge_layer := Node2D.new()
	water_edge_layer.name = GENERATED_WATER_EDGE_LAYER_NAME
	water_edge_layer.z_index = 5
	rim_layer.add_child(water_edge_layer)

	var player_rim_layer := Node2D.new()
	player_rim_layer.name = GENERATED_PLAYER_RIM_LAYER_NAME
	player_rim_layer.z_index = 5
	rim_layer.add_child(player_rim_layer)

	var cave_wall_art_layer := Node2D.new()
	cave_wall_art_layer.name = GENERATED_CAVE_WALL_ART_LAYER_NAME
	cave_wall_art_layer.z_index = 6
	Area01VisualCueContractScript.tag_node(cave_wall_art_layer, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, GENERATED_CAVE_WALL_ART_LAYER_NAME)
	rim_layer.add_child(cave_wall_art_layer)

	var exact_water_visuals_enabled := _create_source_grid_water_cutouts(water_cutout_layer, source_map)
	if exact_water_visuals_enabled:
		_add_source_grid_water_edge_art(cave_wall_art_layer, source_map)

	for water_value in source_map.get("playable_water_regions", []):
		if not water_value is Dictionary:
			continue
		_create_playable_water_visual(water_cutout_layer, water_edge_layer, player_rim_layer, cave_wall_art_layer, water_value as Dictionary, exact_water_visuals_enabled)

func _is_generated_solid_partition(terrain: Dictionary) -> bool:
	var runtime_generation: Variant = terrain.get("runtime_generation", {})
	if not runtime_generation is Dictionary:
		return false
	var runtime := runtime_generation as Dictionary
	var visual_role := String(runtime.get("visual_role", ""))
	return visual_role == "generated_solid_partition"

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
		Area01VisualCueContractScript.tag_node(area, _cue_family_for_hook_type(String(hook_data.get("type", ""))), hook_id)
		hook_parent.add_child(area)

		var collision := CollisionPolygon2D.new()
		collision.name = collision_name
		collision.polygon = points
		collision.disabled = true
		area.add_child(collision)

		var visual := _hook_visual_for_type(String(hook_data.get("type", "")), _polygon_bounds(points).get_center())
		if visual != null:
			Area01VisualCueContractScript.tag_node(visual, _cue_family_for_hook_type(String(hook_data.get("type", ""))), hook_id)
			area.add_child(visual)

func _generated_hook_layer(scene_root: Node) -> Node2D:
	var art_slice := scene_root.get_node_or_null("Area01ArtSlice") as Node2D
	if art_slice == null:
		return null

	var layer := Node2D.new()
	layer.name = GENERATED_HOOK_LAYER_NAME
	layer.z_index = 6
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
	Area01VisualCueContractScript.tag_node(visible, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, terrain_id)
	collision.polygon = points
	collision.disabled = false
	Area01VisualCueContractScript.tag_node(collision, Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, terrain_id)
	lip.polygon = points
	lip.visible = true
	lip.color = LIP_COLOR
	Area01VisualCueContractScript.tag_node(lip, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, terrain_id)
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
	Area01VisualCueContractScript.tag_node(group, Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, terrain_id)
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
		Area01VisualCueContractScript.tag_node(node, Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, path)

func _cue_family_for_hook_type(hook_type: String) -> String:
	match hook_type:
		"oxygen", "offload":
			return Area01VisualCueContractScript.FAMILY_ACTIVE_PROMPT_STATUS
		"return_current":
			return Area01VisualCueContractScript.FAMILY_RETURN_CURRENT
		"hazard":
			return Area01VisualCueContractScript.FAMILY_TIMING_HAZARD_SUPPORT
		"pickup":
			return Area01VisualCueContractScript.FAMILY_RESOURCE_PICKUP
		"scan":
			return Area01VisualCueContractScript.FAMILY_KNOWLEDGE_PAYOFF
		"gate":
			return Area01VisualCueContractScript.FAMILY_LOCKED_PROMISE
		"cave_entrance":
			return Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP
		_:
			return Area01VisualCueContractScript.FAMILY_DEBUG_SOURCE_MAP_OVERLAY

func _hook_visual_for_type(hook_type: String, center: Vector2) -> Polygon2D:
	var visual := Polygon2D.new()
	visual.name = "%sVisualCue" % _pascal_case_id(hook_type)
	visual.position = center

	match hook_type:
		"pickup":
			visual.color = HOOK_PICKUP_COLOR
			visual.polygon = _regular_marker_polygon(10.0, 6)
		"scan":
			visual.color = HOOK_SCAN_COLOR
			visual.polygon = PackedVector2Array([
				Vector2(0.0, -13.0),
				Vector2(12.0, 0.0),
				Vector2(0.0, 13.0),
				Vector2(-12.0, 0.0),
			])
		"gate":
			visual.color = HOOK_GATE_COLOR
			visual.polygon = PackedVector2Array([
				Vector2(-18.0, -7.0),
				Vector2(18.0, -7.0),
				Vector2(18.0, 7.0),
				Vector2(-18.0, 7.0),
			])
		"return_current":
			visual.color = HOOK_RETURN_COLOR
			visual.polygon = PackedVector2Array([
				Vector2(-18.0, -4.0),
				Vector2(2.0, -4.0),
				Vector2(2.0, -12.0),
				Vector2(18.0, 0.0),
				Vector2(2.0, 12.0),
				Vector2(2.0, 4.0),
				Vector2(-18.0, 4.0),
			])
		"hazard":
			visual.color = HOOK_HAZARD_COLOR
			visual.polygon = PackedVector2Array([
				Vector2(0.0, -16.0),
				Vector2(5.0, -5.0),
				Vector2(16.0, 0.0),
				Vector2(5.0, 5.0),
				Vector2(0.0, 16.0),
				Vector2(-5.0, 5.0),
				Vector2(-16.0, 0.0),
				Vector2(-5.0, -5.0),
			])
		_:
			return null

	visual.visible = true
	return visual
