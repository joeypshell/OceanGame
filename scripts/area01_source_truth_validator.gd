class_name Area01SourceTruthValidator
extends RefCounted

const SOURCE_MAP_PATH := "res://data/maps/area_01_runtime_geometry.generated.json"
const TERRAIN_LAYER_PATH := "Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain"
const COLLISION_ROOT_PATH := "Area01ArtSlice/RuntimeSourceCollision"
const LEGACY_COLLISION_ROOT_PATH := "Area01ArtSlice/TerrainCollision"
const RIM_LAYER_PATH := "Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims"
const HOOK_LAYER_PATH := "Area01ArtSlice/RuntimeSourceHooks"
const META_SOURCE_ID := &"area01_visual_cue_source_id"

var errors: Array[String] = []
var source_map: Dictionary = {}

func load_source_map(path: String = SOURCE_MAP_PATH) -> bool:
	errors.clear()
	source_map = {}
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		_add_error("source map file is missing: %s" % path)
		return false

	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		_add_error("source map file does not parse as a JSON object: %s" % path)
		return false

	source_map = parsed as Dictionary
	return true

func validate_source_map_data(map: Dictionary = source_map) -> Array[String]:
	errors.clear()
	_validate_source_map_data(map)
	return errors.duplicate()

func validate_runtime_scene(scene_root: Node, map: Dictionary = source_map) -> Array[String]:
	errors.clear()
	_validate_source_map_data(map)
	if errors.is_empty():
		_validate_runtime_scene(scene_root, map)
	return errors.duplicate()

func _validate_source_map_data(map: Dictionary) -> void:
	if map.is_empty():
		_add_error("source map is empty")
		return

	_expect(String(map.get("map_id", "")) == "area_01_runtime_geometry_generated", "source map must be the generated Area 01 runtime geometry")
	_expect(bool(map.get("generated", false)), "source map must be generated, not hand-authored runtime terrain")
	_expect(String(map.get("generated_from", "")) == "data/maps/area_01_source_grid_v1.json", "source map must name the source-grid authority")
	_expect(String(map.get("generated_by", "")) == "tools/build-area01-map.mjs", "source map must name the deterministic converter")
	_expect(not String(map.get("source_sha256", "")).is_empty(), "source map must preserve a source-grid hash")
	var source_grid := _dict_value(map, "source_grid", "source map")
	_expect(String(source_grid.get("map_id", "")) == "area_01", "source map must preserve source-grid map_id")
	_expect(int(source_grid.get("width", 0)) > 0 and int(source_grid.get("height", 0)) > 0, "source map must preserve source-grid dimensions")
	var validation_contract := _dict_value(map, "validation_contract", "source map")
	_expect(bool(validation_contract.get("generated_geometry_must_not_be_hand_edited", false)), "source map must forbid hand-editing generated geometry")
	_expect(bool(validation_contract.get("screenshots_are_confirmation_only", false)), "source map must keep screenshots as confirmation only")
	var terrain_domain := _dict_value(map, "terrain_domain", "source map")
	_expect(_points_from_json(terrain_domain.get("polygon", [])).size() >= 3, "source map terrain_domain must define one continuous domain polygon")
	var domain_runtime := _dict_value(terrain_domain, "runtime_generation", "terrain_domain")
	_expect(String(domain_runtime.get("visual_role", "")) == "terrain_domain_reference", "terrain_domain must remain the source-derived continuous terrain domain reference")
	_expect(not String(domain_runtime.get("visible_polygon2d_name", "")).is_empty(), "terrain_domain must name its generated domain Polygon2D")
	var playable_water_regions := _array_value(map, "playable_water_regions")
	var terrain_entries := _array_value(map, "solid_terrain")
	var scene_hooks := _array_value(map, "scene_hooks")
	var review_points := _array_value(map, "review_points")
	var water_ids := _ids_from_entries(playable_water_regions, "playable water")
	var hook_ids := _ids_from_entries(scene_hooks, "scene hook")
	var terrain_ids := _ids_from_entries(terrain_entries, "solid terrain")

	var required_regions := [
		"open_surface_water",
		"starter_kelp_hole",
		"shell_reef_route",
		"thermal_vent_pocket",
		"blue_chimney_route",
		"pressure_wreck_branch",
		"future_deep_exit",
	]
	for required_region_id in required_regions:
		_expect(water_ids.has(required_region_id), "generated runtime map must include required region %s" % required_region_id)

	var hook_types := {}
	var carving_water_count := 0
	for water_value in playable_water_regions:
		if not water_value is Dictionary:
			_add_error("playable water entry is not a dictionary")
			continue
		var water := water_value as Dictionary
		var water_id := String(water.get("id", "unknown"))
		_expect(_points_from_json(water.get("polygon", [])).size() >= 3, "playable water %s must define a source polygon" % water_id)
		_expect(water.has("source_rect_cells"), "playable water %s must preserve source-grid cells" % water_id)
		_expect(not String(water.get("source_component_id", "")).is_empty(), "playable water %s must preserve connected-water component metadata" % water_id)
		var runtime_water := _dict_value(water, "runtime_generation", "playable water %s" % water_id)
		_expect(String(runtime_water.get("visual_role", "")).contains("water"), "playable water %s must own a water-reference visual role" % water_id)
		_expect(not String(runtime_water.get("visible_polygon2d_name", "")).is_empty(), "playable water %s must name generated cutout polygon" % water_id)
		_expect(not String(runtime_water.get("edge_line2d_name", "")).is_empty(), "playable water %s must name generated diagnostic edge line" % water_id)
		if bool(water.get("carves_collision", false)):
			carving_water_count += 1

	for terrain_value in terrain_entries:
		if not terrain_value is Dictionary:
			_add_error("solid terrain entry is not a dictionary")
			continue

		var terrain := terrain_value as Dictionary
		var terrain_id := String(terrain.get("id", "unknown"))
		var points := _points_from_json(terrain.get("polygon", []))
		_expect(points.size() >= 3, "solid terrain %s must define one source polygon" % terrain_id)
		var runtime := _dict_value(terrain, "runtime_generation", "solid terrain %s" % terrain_id)
		var visual_role := String(runtime.get("visual_role", "solid_terrain"))
		_expect(visual_role == "generated_solid_partition", "solid terrain %s must be a generated visible/colliding terrain partition" % terrain_id)
		var generation_source := _dict_value(terrain, "generation_source", "solid terrain %s" % terrain_id)
		_expect(String(generation_source.get("algorithm", "")).contains("source_grid"), "solid terrain %s must declare source-grid generation source" % terrain_id)
		_expect(String(generation_source.get("source", "")) == "data/maps/area_01_source_grid_v1.json", "solid terrain %s must declare the source-grid path" % terrain_id)
		_expect(not String(runtime.get("visible_polygon2d_name", "")).is_empty(), "solid terrain %s must name generated visible terrain" % terrain_id)
		_expect(not String(runtime.get("rim_container_name", "")).is_empty(), "solid terrain %s must name generated rim/lip" % terrain_id)
		_expect(not String(runtime.get("collision_polygon2d_name", "")).is_empty(), "solid terrain %s must name generated collision" % terrain_id)
		_expect(String(runtime.get("collision_points_source", "")) == "this polygon", "solid terrain %s collision must use this source polygon" % terrain_id)
		_expect(String(runtime.get("visual_points_source", "")) == "this polygon", "solid terrain %s visible terrain must use this source polygon" % terrain_id)
		_expect(String(runtime.get("rim_points_source", "")) == "this polygon", "solid terrain %s rim/lip must use this source polygon" % terrain_id)
		_expect(not bool(runtime.get("sprites_define_collision", true)), "solid terrain %s sprites must not define collision" % terrain_id)

	for hook_value in scene_hooks:
		if not hook_value is Dictionary:
			_add_error("scene hook entry is not a dictionary")
			continue

		var hook := hook_value as Dictionary
		var hook_id := String(hook.get("id", "unknown"))
		var hook_type := String(hook.get("type", ""))
		hook_types[hook_type] = true
		_expect(not hook_type.is_empty(), "scene hook %s must declare a type" % hook_id)
		_expect(hook.has("source_cells"), "scene hook %s must preserve source-grid cells" % hook_id)
		_expect(_points_from_json(hook.get("points", [])).size() >= 3, "scene hook %s must define polygon points" % hook_id)
		var runtime := _dict_value(hook, "runtime_generation", "scene hook %s" % hook_id)
		_expect(not String(runtime.get("area2d_name", "")).is_empty(), "scene hook %s must name a generated Area2D" % hook_id)
		_expect(not String(runtime.get("collision_polygon2d_name", "")).is_empty(), "scene hook %s must name a generated trigger polygon" % hook_id)
		_expect(String(runtime.get("points_source", "")) == "this hook points", "scene hook %s trigger must use this hook polygon" % hook_id)
		_expect(not bool(runtime.get("blocks_player", true)), "scene hook %s must not own blocking terrain collision" % hook_id)

	for required_type in ["oxygen", "offload", "player_start", "pickup", "scan", "gate", "return_current"]:
		_expect(hook_types.has(required_type), "source map must include %s scene hook ownership" % required_type)

	for required_hook_id in ["oxygen_surface", "ship_offload", "player_start", "starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		_expect(hook_ids.has(required_hook_id), "generated runtime map must include required hook %s" % required_hook_id)

	for point_value in review_points:
		if not point_value is Dictionary:
			_add_error("review point entry is not a dictionary")
			continue
		var point := point_value as Dictionary
		_expect(not String(point.get("id", "")).is_empty(), "review point must have an id")
		_expect(point.get("world_position", []) is Array, "review point %s must preserve a world position" % String(point.get("id", "")))

	_expect(terrain_ids.size() == terrain_entries.size(), "solid terrain IDs must be stable and unique")
	_expect(water_ids.size() == playable_water_regions.size(), "playable water IDs must be stable and unique")
	_expect(carving_water_count >= 6, "source map must define carved playable water regions and cave mouths")
	_expect(hook_ids.size() == scene_hooks.size(), "scene hook IDs must be stable and unique")
	_expect(review_points.size() >= 7, "source map must preserve review points for source/runtime/diff confirmation")

func _validate_runtime_scene(scene_root: Node, map: Dictionary) -> void:
	var terrain_entries := _array_value(map, "solid_terrain")
	var scene_hooks := _array_value(map, "scene_hooks")
	var expected_visible := {}
	var expected_collision := {}
	var expected_rims := {}

	_validate_generated_source_visuals(scene_root, map, expected_visible)

	for terrain_value in terrain_entries:
		if not terrain_value is Dictionary:
			continue

		var terrain := terrain_value as Dictionary
		var terrain_id := String(terrain.get("id", "unknown"))
		var points := _points_from_json(terrain.get("polygon", []))
		var runtime := terrain.get("runtime_generation", {}) as Dictionary
		var visible_name := String(runtime.get("visible_polygon2d_name", ""))
		var collision_name := String(runtime.get("collision_polygon2d_name", ""))
		var rim_name := String(runtime.get("rim_container_name", ""))
		expected_visible[visible_name] = terrain_id
		expected_rims[rim_name] = terrain_id
		expected_collision[collision_name] = terrain_id

		var visible := scene_root.get_node_or_null("%s/%s" % [TERRAIN_LAYER_PATH, visible_name]) as Polygon2D
		var collision := scene_root.get_node_or_null("%s/%s" % [COLLISION_ROOT_PATH, collision_name]) as CollisionPolygon2D
		var rim := scene_root.get_node_or_null("%s/%s" % [RIM_LAYER_PATH, rim_name]) as Polygon2D
		_expect(visible != null, "terrain %s missing generated visible Polygon2D %s" % [terrain_id, visible_name])
		_expect(rim != null, "terrain %s missing generated rim/lip Polygon2D %s" % [terrain_id, rim_name])
		_expect(collision != null, "terrain %s missing generated CollisionPolygon2D %s" % [terrain_id, collision_name])
		if visible != null:
			_expect(visible.visible, "terrain %s generated visible polygon must be visible" % terrain_id)
			_expect(_same_points(visible.polygon, points), "terrain %s visible polygon drifted from source map" % terrain_id)
		if collision != null:
			var blocks_player := bool(terrain.get("blocks_player", true))
			_expect(collision.disabled == (not blocks_player), "terrain %s collision enabled state does not match source map blocking rule" % terrain_id)
			if blocks_player:
				_expect(not collision.disabled, "terrain %s blocking collision must be enabled" % terrain_id)
			_expect(_same_points(collision.polygon, points), "terrain %s collision polygon drifted from source map" % terrain_id)
		if rim != null:
			_expect(rim.visible, "terrain %s generated rim/lip must be visible" % terrain_id)
			_expect(_same_points(rim.polygon, points), "terrain %s rim/lip polygon drifted from source map" % terrain_id)

	_validate_no_unowned_enabled_collisions(scene_root, expected_collision)
	_validate_no_unowned_visible_polygons(scene_root, TERRAIN_LAYER_PATH, expected_visible, "visible terrain")
	_validate_no_unowned_visible_polygons(scene_root, RIM_LAYER_PATH, expected_rims, "rim/lip")
	_validate_runtime_hooks(scene_root, scene_hooks)

func _validate_generated_source_visuals(scene_root: Node, map: Dictionary, expected_visible: Dictionary) -> void:
	var terrain_domain := map.get("terrain_domain", {}) as Dictionary
	var domain_runtime := terrain_domain.get("runtime_generation", {}) as Dictionary
	var domain_name := String(domain_runtime.get("visible_polygon2d_name", ""))
	var source_grid_cutouts := _array_value(map, "source_grid_water_cutouts")
	var exact_source_grid_cutouts_own_water := not source_grid_cutouts.is_empty()
	if not domain_name.is_empty():
		var domain_visual := scene_root.get_node_or_null("%s/%s" % [TERRAIN_LAYER_PATH, domain_name]) as Polygon2D
		expected_visible[domain_name] = String(terrain_domain.get("id", "terrain_domain"))
		_expect(domain_visual != null, "terrain_domain missing generated continuous terrain Polygon2D %s" % domain_name)
		if domain_visual != null:
			_expect(not domain_visual.visible, "terrain_domain must stay a hidden reference guide so uncut texture cannot fill playable water")
			_expect(_same_points(domain_visual.polygon, _points_from_json(terrain_domain.get("polygon", []))), "terrain_domain polygon drifted from source map")

	for water_value in _array_value(map, "playable_water_regions"):
		if not water_value is Dictionary:
			continue
		var water := water_value as Dictionary
		var water_id := String(water.get("id", "unknown"))
		var runtime := water.get("runtime_generation", {}) as Dictionary
		var cutout_name := String(runtime.get("visible_polygon2d_name", ""))
		var edge_name := String(runtime.get("edge_line2d_name", ""))
		if not cutout_name.is_empty():
			var cutout := scene_root.get_node_or_null("%s/RuntimeSourceWaterCutouts/%s" % [TERRAIN_LAYER_PATH, cutout_name]) as Polygon2D
			expected_visible[cutout_name] = water_id
			_expect(cutout != null, "playable water %s missing generated cutout Polygon2D %s" % [water_id, cutout_name])
			if cutout != null:
				_expect(cutout.visible or exact_source_grid_cutouts_own_water, "playable water %s cutout must render the source-driven cave water aperture" % water_id)
				_expect(_same_points(cutout.polygon, _points_from_json(water.get("polygon", []))), "playable water %s cutout polygon drifted from source map" % water_id)
		if not edge_name.is_empty():
			var edge := scene_root.get_node_or_null("%s/RuntimeSourceWaterEdges/%s" % [RIM_LAYER_PATH, edge_name]) as Line2D
			_expect(edge != null, "playable water %s missing generated diagnostic edge Line2D %s" % [water_id, edge_name])
			if edge != null:
				_expect(not edge.visible, "playable water %s diagnostic edge Line2D must stay hidden in player-facing runtime" % water_id)

func _validate_no_unowned_enabled_collisions(scene_root: Node, expected_collision: Dictionary) -> void:
	for root_path in [LEGACY_COLLISION_ROOT_PATH, COLLISION_ROOT_PATH]:
		var root := scene_root.get_node_or_null(root_path)
		if root == null:
			continue
		for collision in _find_children_of_type(root, "CollisionPolygon2D"):
			var collision_polygon := collision as CollisionPolygon2D
			if collision_polygon.disabled:
				continue
			_expect(expected_collision.has(collision_polygon.name), "enabled Area 01 collision is not owned by the source map: %s/%s" % [root_path, collision_polygon.name])

func _validate_no_unowned_visible_polygons(scene_root: Node, root_path: String, expected_names: Dictionary, label: String) -> void:
	var root := scene_root.get_node_or_null(root_path)
	if root == null:
		_add_error("missing generated %s root: %s" % [label, root_path])
		return
	for polygon in _find_children_of_type(root, "Polygon2D"):
		var polygon_node := polygon as Polygon2D
		if polygon_node.visible:
			_expect(expected_names.has(polygon_node.name) or _has_source_ownership(polygon_node), "visible Area 01 %s lacks source-map ownership: %s/%s" % [label, root_path, polygon_node.name])

func _validate_runtime_hooks(scene_root: Node, scene_hooks: Array) -> void:
	var expected_hooks := {}
	for hook_value in scene_hooks:
		if not hook_value is Dictionary:
			continue
		var hook := hook_value as Dictionary
		var hook_id := String(hook.get("id", "unknown"))
		var runtime := hook.get("runtime_generation", {}) as Dictionary
		var area_name := String(runtime.get("area2d_name", ""))
		var collision_name := String(runtime.get("collision_polygon2d_name", ""))
		expected_hooks[area_name] = hook_id

		var area := scene_root.get_node_or_null("%s/%s" % [HOOK_LAYER_PATH, area_name]) as Area2D
		_expect(area != null, "scene hook %s missing generated Area2D %s" % [hook_id, area_name])
		if area == null:
			continue
		_expect(String(area.get_meta(&"area01_hook_id", "")) == hook_id, "scene hook %s Area2D must preserve source-map id metadata" % hook_id)
		_expect(String(area.get_meta(&"area01_hook_type", "")) == String(hook.get("type", "")), "scene hook %s Area2D must preserve type metadata" % hook_id)
		var collision := area.get_node_or_null(collision_name) as CollisionPolygon2D
		_expect(collision != null, "scene hook %s missing trigger CollisionPolygon2D %s" % [hook_id, collision_name])
		if collision != null:
			_expect(collision.disabled, "scene hook %s must stay inert until a gameplay system explicitly promotes it" % hook_id)
			_expect(_same_points(collision.polygon, _points_from_json(hook.get("points", []))), "scene hook %s trigger polygon drifted from source map" % hook_id)

	var hook_root := scene_root.get_node_or_null(HOOK_LAYER_PATH)
	if hook_root == null:
		_add_error("missing generated hook root: %s" % HOOK_LAYER_PATH)
		return
	for child in hook_root.get_children():
		if child is Area2D:
			_expect(expected_hooks.has(child.name), "generated Area 01 hook lacks source-map ownership: %s/%s" % [HOOK_LAYER_PATH, child.name])

func _has_source_ownership(node: Node) -> bool:
	var cursor: Node = node
	while cursor != null:
		if cursor.has_meta(META_SOURCE_ID) and not String(cursor.get_meta(META_SOURCE_ID)).is_empty():
			return true
		cursor = cursor.get_parent()
	return false

func _ids_from_entries(entries: Array, label: String) -> Dictionary:
	var ids := {}
	for entry_value in entries:
		if not entry_value is Dictionary:
			_add_error("%s entry is not a dictionary" % label)
			continue
		var id := String((entry_value as Dictionary).get("id", ""))
		if id.is_empty():
			_add_error("%s entry is missing an id" % label)
		elif ids.has(id):
			_add_error("duplicate %s id: %s" % [label, id])
		else:
			ids[id] = true
	return ids

func _array_value(map: Dictionary, key: String) -> Array:
	var value: Variant = map.get(key, [])
	if value is Array:
		return value as Array
	_add_error("source map %s must be an array" % key)
	return []

func _dict_value(map: Dictionary, key: String, label: String) -> Dictionary:
	var value: Variant = map.get(key, {})
	if value is Dictionary:
		return value as Dictionary
	_add_error("%s %s must be a dictionary" % [label, key])
	return {}

func _find_children_of_type(root: Node, type_name: String) -> Array[Node]:
	var matches: Array[Node] = []
	for child in root.get_children():
		if child.is_class(type_name):
			matches.append(child)
		matches.append_array(_find_children_of_type(child, type_name))
	return matches

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points
	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))
	return points

func _same_points(actual: PackedVector2Array, expected: PackedVector2Array) -> bool:
	if actual.size() != expected.size():
		return false
	for index in range(actual.size()):
		if actual[index].distance_to(expected[index]) > 0.01:
			return false
	return true

func _expect(condition: bool, message: String) -> void:
	if not condition:
		_add_error(message)

func _add_error(message: String) -> void:
	errors.append(message)
