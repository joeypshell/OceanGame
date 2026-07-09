extends RefCounted

const MainScene := preload("res://scenes/Main.tscn")
const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")

func _test_area_01_starter_resource_pocket_placement(runner) -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 starter resource placement test should use runtime source-map collision: %s" % builder.last_error)
	var source_map: Dictionary = runner._load_area01_source_map_for_tests()
	var source_grid_water_polygons := _source_grid_water_polygons(source_map, runner)
	var source_grid_domain := _source_grid_domain_bounds(source_map, runner)
	var hooks_by_id := {}
	for hook_value in source_map.get("scene_hooks", []):
		if typeof(hook_value) == TYPE_DICTIONARY:
			hooks_by_id[String((hook_value as Dictionary).get("id", ""))] = hook_value

	var collisions: Array[CollisionPolygon2D] = runner._area01_enabled_collision_polygons(main)
	for hook_id in ["starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		runner._expect(hooks_by_id.has(hook_id), "Area 01 generated source map should include starter resource hook: %s" % hook_id)
		if not hooks_by_id.has(hook_id):
			continue
		var hook := hooks_by_id[hook_id] as Dictionary
		runner._expect(String(hook.get("type", "")) == "pickup", "starter resource hook should be typed as pickup: %s" % hook_id)
		runner._expect(not String(hook.get("resource", "")).is_empty(), "starter resource hook should name its resource family: %s" % hook_id)
		var runtime := hook.get("runtime_generation", {}) as Dictionary
		var area := main.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % String(runtime.get("area2d_name", ""))) as Area2D
		runner._expect(area != null, "starter resource hook should build a generated Area2D: %s" % hook_id)
		if area == null:
			continue
		var collision := area.get_node_or_null(String(runtime.get("collision_polygon2d_name", ""))) as CollisionPolygon2D
		runner._expect(collision != null and collision.disabled, "starter resource hook should stay inert/nonblocking until gameplay promotes it: %s" % hook_id)
		var points: PackedVector2Array = runner._points_from_source_map_json(hook.get("points", []))
		runner._expect(points.size() >= 3, "starter resource hook should have generated polygon points: %s" % hook_id)
		if points.size() >= 3:
			var center := Vector2.ZERO
			for point in points:
				center += point
			center /= float(points.size())
			runner._expect(not runner._point_inside_any_collision(center, collisions), "starter resource hook should not sit inside generated Area 01 terrain collision: %s" % hook_id)
	main.free()

	main = MainScene.instantiate()
	builder = Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 authored placement test should use runtime source-map collision: %s" % builder.last_error)
	collisions = runner._area01_enabled_collision_polygons(main)
	var starter_resource_candidates := main.get_node("StarterResourceCandidates") as Node2D
	for marker_node in starter_resource_candidates.find_children("*", "Marker2D", true, false):
		var marker := marker_node as Marker2D
		if marker == null:
			continue
		_expect_area01_runtime_water_point(runner, marker.global_position, source_grid_domain, source_grid_water_polygons, collisions, "starter resource candidate %s" % _local_node_path(marker))

	var resource_pickups := main.get_node("ResourcePickups") as Node2D
	for pickup_node in resource_pickups.get_children():
		var pickup := pickup_node as Node2D
		if pickup == null or not pickup.visible:
			continue
		_expect_area01_runtime_water_point(runner, pickup.global_position, source_grid_domain, source_grid_water_polygons, collisions, "visible resource pickup %s" % _local_node_path(pickup))

	var lantern_fry := main.get_node("Creatures/LanternFry") as Node2D
	runner._expect(runner._effective_canvas_z(lantern_fry) >= 17, "Lantern Fry should render above generated cave-wall decoration")
	for point in [
		lantern_fry.global_position,
		lantern_fry.get("move_start") as Vector2,
		lantern_fry.get("move_end") as Vector2,
	]:
		_expect_area01_runtime_water_point(runner, point, source_grid_domain, source_grid_water_polygons, collisions, "Lantern Fry patrol point %s" % point)

	var creature_route_candidates := main.get_node("CreatureRouteCandidates") as Node2D
	for marker_node in creature_route_candidates.find_children("*", "Marker2D", true, false):
		var marker := marker_node as Marker2D
		if marker == null:
			continue
		if String(marker.get("target_id")) != "lantern_ray":
			continue
		_expect_area01_runtime_water_point(runner, marker.global_position, source_grid_domain, source_grid_water_polygons, collisions, "Lantern Ray route candidate %s" % _local_node_path(marker))
	main.free()

func _test_area_01_cave_mouth_affordances(runner) -> void:
	var main := MainScene.instantiate()
	var root := main.get_node("Area01ArtSlice/GameplayObjects/CaveMouthAffordances") as Node2D
	var left_mouth := root.get_node("LeftCaveMouth") as Node2D
	var right_mouth := root.get_node("RightChamberMouth") as Node2D
	var future_seal := root.get_node("LowerBasinFutureSeal") as Node2D
	var left_shadow := left_mouth.get_node("MouthShadow") as Polygon2D
	var left_wash := left_mouth.get_node("EntryWaterWash") as Polygon2D
	var left_rim := left_mouth.get_node("UpperRim") as Polygon2D
	var right_shadow := right_mouth.get_node("MouthShadow") as Polygon2D
	var right_wash := right_mouth.get_node("EntryWaterWash") as Polygon2D
	var future_mouth := future_seal.get_node("SealMouth") as Polygon2D
	var future_veil := future_seal.get_node("PressureVeil") as Polygon2D
	var future_bars := future_seal.get_node("SealBars") as Polygon2D
	var future_glint := future_seal.get_node("FutureGlint") as Polygon2D
	runner._expect(root.find_child("CollisionShape2D", true, false) == null, "Area 01 cave-mouth affordances should not add hidden collision")
	runner._expect(root.find_child("CollisionPolygon2D", true, false) == null, "Area 01 cave-mouth affordances should not add player blockers")
	runner._expect(root.find_child("Label", true, false) == null, "Area 01 cave-mouth affordances should not rely on labels for comprehension")
	runner._expect(left_shadow.color.a >= 0.6 and right_shadow.color.a >= 0.55, "reachable cave mouths should use dark negative space so openings read apart from solid reef")
	runner._expect(left_wash.color.a <= 0.16 and right_wash.color.a <= 0.14, "reachable cave-mouth water washes should stay subtle instead of becoming route arrows")
	runner._expect(left_rim.color.a > left_wash.color.a, "reachable cave-mouth rims should frame the opening more clearly than the water wash")
	runner._expect(future_mouth.color.a < left_shadow.color.a, "future sealed mouth should be quieter than current reachable cave openings")
	runner._expect(future_veil.color.a < left_wash.color.a and future_bars.color.a < left_rim.color.a, "future route promise should stay lower priority than current cave affordances")
	runner._expect(future_glint.color.a < left_rim.color.a, "future glint should invite curiosity without reading as a collectible")
	main.free()

func _source_grid_water_polygons(source_map: Dictionary, runner) -> Array[PackedVector2Array]:
	var water_polygons: Array[PackedVector2Array] = []
	for cutout_value in source_map.get("source_grid_water_cutouts", []):
		if typeof(cutout_value) != TYPE_DICTIONARY:
			continue
		var cutout := cutout_value as Dictionary
		var points: PackedVector2Array = runner._points_from_source_map_json(cutout.get("polygon", []))
		if points.size() >= 3:
			water_polygons.append(points)
	return water_polygons

func _source_grid_domain_bounds(source_map: Dictionary, runner) -> Rect2:
	var terrain_domain := source_map.get("terrain_domain", {}) as Dictionary
	return _polygon_bounds(runner._points_from_source_map_json(terrain_domain.get("polygon", [])))

func _expect_area01_runtime_water_point(
	runner,
	point: Vector2,
	source_grid_domain: Rect2,
	source_grid_water_polygons: Array[PackedVector2Array],
	collisions: Array[CollisionPolygon2D],
	context: String
) -> void:
	if not source_grid_domain.has_point(point):
		return
	runner._expect(_point_inside_any_polygon(point, source_grid_water_polygons), "%s should sit inside source-grid playable water" % context)
	runner._expect(not runner._point_inside_any_collision(point, collisions), "%s should not sit inside generated Area 01 terrain collision" % context)

func _point_inside_any_polygon(point: Vector2, polygons: Array[PackedVector2Array]) -> bool:
	for polygon in polygons:
		if Geometry2D.is_point_in_polygon(point, polygon):
			return true
	return false

func _local_node_path(node: Node) -> String:
	var parts := PackedStringArray()
	var current: Node = node
	while current != null:
		parts.insert(0, String(current.name))
		current = current.get_parent()
	return "/".join(parts)

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
