class_name Area01SourceTruthValidator
extends RefCounted

const SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_runtime_source_map_v2.json"
const TERRAIN_LAYER_PATH := "Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain"
const COLLISION_ROOT_PATH := "Area01ArtSlice/RuntimeSourceCollision"
const LEGACY_COLLISION_ROOT_PATH := "Area01ArtSlice/TerrainCollision"
const RIM_LAYER_PATH := "Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims"
const HOOK_LAYER_PATH := "Area01ArtSlice/RuntimeSourceHooks"

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

	_expect(String(map.get("map_id", "")) == "area_01_runtime_source_map_v2", "source map must be the active runtime v2 map")
	var terrain_entries := _array_value(map, "solid_terrain")
	var scene_hooks := _array_value(map, "scene_hooks")
	var cave_mouths := _array_value(map, "cave_mouths")
	var regions := _array_value(map, "regions")
	var region_ids := _ids_from_entries(regions, "region")
	var hook_ids := _ids_from_entries(scene_hooks, "scene hook")
	var terrain_ids := _ids_from_entries(terrain_entries, "solid terrain")

	var hook_types := {}
	for terrain_value in terrain_entries:
		if not terrain_value is Dictionary:
			_add_error("solid terrain entry is not a dictionary")
			continue

		var terrain := terrain_value as Dictionary
		var terrain_id := String(terrain.get("id", "unknown"))
		var points := _points_from_json(terrain.get("polygon", []))
		_expect(points.size() >= 3, "solid terrain %s must define one source polygon" % terrain_id)
		var runtime := _dict_value(terrain, "runtime_generation", "solid terrain %s" % terrain_id)
		_expect(not String(runtime.get("visible_polygon2d_name", "")).is_empty(), "solid terrain %s must name generated visible terrain" % terrain_id)
		_expect(not String(runtime.get("collision_polygon2d_name", "")).is_empty(), "solid terrain %s must name generated collision" % terrain_id)
		_expect(not String(runtime.get("rim_container_name", "")).is_empty(), "solid terrain %s must name generated rim/lip" % terrain_id)
		_expect(String(runtime.get("collision_points_source", "")) == "this polygon", "solid terrain %s collision must use this source polygon" % terrain_id)
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
		_expect(region_ids.has(String(hook.get("region_id", ""))), "scene hook %s must reference a known region" % hook_id)
		_expect(_points_from_json(hook.get("points", [])).size() >= 3, "scene hook %s must define polygon points" % hook_id)
		var runtime := _dict_value(hook, "runtime_generation", "scene hook %s" % hook_id)
		_expect(not String(runtime.get("area2d_name", "")).is_empty(), "scene hook %s must name a generated Area2D" % hook_id)
		_expect(not String(runtime.get("collision_polygon2d_name", "")).is_empty(), "scene hook %s must name a generated trigger polygon" % hook_id)
		_expect(String(runtime.get("points_source", "")) == "this hook points", "scene hook %s trigger must use this hook polygon" % hook_id)
		_expect(not bool(runtime.get("blocks_player", true)), "scene hook %s must not own blocking terrain collision" % hook_id)

	for required_type in ["oxygen", "offload", "cave_entrance", "pickup", "scan", "gate", "return_current", "hazard"]:
		_expect(hook_types.has(required_type), "source map must include %s scene hook ownership" % required_type)

	for cave_value in cave_mouths:
		if not cave_value is Dictionary:
			_add_error("cave mouth entry is not a dictionary")
			continue
		var cave := cave_value as Dictionary
		var cave_id := String(cave.get("id", "unknown"))
		_expect(hook_ids.has(String(cave.get("scene_hook", ""))), "cave mouth %s must reference a known scene hook" % cave_id)
		_expect(region_ids.has(String(cave.get("from_region", ""))), "cave mouth %s must reference a known from_region" % cave_id)
		_expect(region_ids.has(String(cave.get("to_region", ""))), "cave mouth %s must reference a known to_region" % cave_id)
		_expect(_points_from_json(cave.get("entrance_polygon", [])).size() >= 3, "cave mouth %s must define an entrance polygon" % cave_id)

	_expect(terrain_ids.size() == terrain_entries.size(), "solid terrain IDs must be stable and unique")
	_expect(hook_ids.size() == scene_hooks.size(), "scene hook IDs must be stable and unique")

func _validate_runtime_scene(scene_root: Node, map: Dictionary) -> void:
	var terrain_entries := _array_value(map, "solid_terrain")
	var scene_hooks := _array_value(map, "scene_hooks")
	var expected_visible := {}
	var expected_collision := {}
	var expected_rims := {}

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
		expected_collision[collision_name] = terrain_id
		expected_rims[rim_name] = terrain_id

		var visible := scene_root.get_node_or_null("%s/%s" % [TERRAIN_LAYER_PATH, visible_name]) as Polygon2D
		var collision := scene_root.get_node_or_null("%s/%s" % [COLLISION_ROOT_PATH, collision_name]) as CollisionPolygon2D
		var rim := scene_root.get_node_or_null("%s/%s" % [RIM_LAYER_PATH, rim_name]) as Polygon2D
		_expect(visible != null, "terrain %s missing generated visible Polygon2D %s" % [terrain_id, visible_name])
		_expect(collision != null, "terrain %s missing generated CollisionPolygon2D %s" % [terrain_id, collision_name])
		_expect(rim != null, "terrain %s missing generated rim/lip Polygon2D %s" % [terrain_id, rim_name])
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
			_expect(expected_names.has(polygon_node.name), "visible Area 01 %s lacks source-map ownership: %s/%s" % [label, root_path, polygon_node.name])

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
