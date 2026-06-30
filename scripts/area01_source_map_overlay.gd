class_name Area01SourceMapOverlay
extends Node2D

const Area01SourceTruthValidatorScript := preload("res://scripts/area01_source_truth_validator.gd")
const Area01VisualCueContractScript := preload("res://scripts/area01_visual_cue_contract.gd")
const RUNTIME_SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_runtime_source_map_v3.json"
const LEGACY_SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const SOURCE_MAP_PATH := RUNTIME_SOURCE_MAP_PATH
const LANE_COLOR := Color(0.0, 0.9, 1.0, 0.12)
const LANE_EDGE_COLOR := Color(0.0, 0.95, 1.0, 0.72)
const COLLISION_COLOR := Color(1.0, 0.18, 0.08, 0.18)
const COLLISION_EDGE_COLOR := Color(1.0, 0.22, 0.12, 0.84)
const POCKET_COLOR := Color(0.25, 1.0, 0.52, 0.86)
const RESOURCE_COLOR := Color(0.2, 1.0, 0.85, 0.92)
const SCANNABLE_COLOR := Color(1.0, 0.76, 0.18, 0.92)
const SCAN_RADIUS_COLOR := Color(0.95, 0.95, 0.25, 0.42)
const HOOK_COLOR := Color(0.95, 0.74, 0.2, 0.16)
const HOOK_EDGE_COLOR := Color(0.95, 0.74, 0.2, 0.62)
const FUTURE_HOOK_COLOR := Color(0.9, 0.22, 0.38, 0.16)
const FUTURE_HOOK_EDGE_COLOR := Color(0.9, 0.22, 0.38, 0.62)
const LABEL_COLOR := Color(0.90, 1.0, 1.0, 0.88)
const LABEL_SHADOW_COLOR := Color(0.0, 0.04, 0.06, 0.92)
const SUMMARY_TEXT_COLOR := Color(0.88, 1.0, 1.0, 0.96)
const SUMMARY_BACK_COLOR := Color(0.0, 0.04, 0.07, 0.72)
const SUMMARY_WARN_COLOR := Color(1.0, 0.72, 0.24, 0.96)
const MAX_CUE_LABELS := 36

@export var scan_range := 120.0
@export var capture_state := "normal"
@export var camera_state := "camera unknown"

var source_map: Dictionary = {}
var load_error := ""
var loaded_source_map_path := ""

func _ready() -> void:
	name = "Area01SourceMapOverlay"
	z_index = 120
	visible = false
	load_source_map()

func _process(_delta: float) -> void:
	if visible:
		queue_redraw()

func set_debug_visible(enabled: bool) -> void:
	visible = enabled
	queue_redraw()

func load_source_map() -> bool:
	source_map = {}
	load_error = ""
	for path in [RUNTIME_SOURCE_MAP_PATH, LEGACY_SOURCE_MAP_PATH]:
		var file := FileAccess.open(path, FileAccess.READ)
		if file == null:
			continue

		var parsed = JSON.parse_string(file.get_as_text())
		if typeof(parsed) != TYPE_DICTIONARY:
			load_error = "source map parse failed: %s" % path
			return false

		source_map = parsed as Dictionary
		loaded_source_map_path = path
		queue_redraw()
		return true

	load_error = "missing source map"
	return false

func source_map_summary() -> Dictionary:
	var lanes := (source_map.get("playable_water_lanes", []) as Array).size()
	if lanes == 0:
		lanes = (source_map.get("playable_water_regions", []) as Array).size()
	if lanes == 0:
		lanes = (source_map.get("regions", []) as Array).size()
	var pockets := (source_map.get("resource_pockets", []) as Array).size()
	if pockets == 0:
		for hook in source_map.get("scene_hooks", []):
			if typeof(hook) == TYPE_DICTIONARY and String((hook as Dictionary).get("type", "")) == "pickup":
				pockets += 1
	return {
		"lanes": lanes,
		"solids": (source_map.get("solid_terrain", []) as Array).size(),
		"pockets": pockets,
		"hooks": (source_map.get("scene_hooks", []) as Array).size(),
		"rules": (source_map.get("validation_rules", []) as Array).size(),
		"map_id": String(source_map.get("map_id", "legacy_blockout_source_map")),
		"status": String(source_map.get("status", "legacy_fallback")),
	}

func _draw() -> void:
	if source_map.is_empty():
		return

	_draw_playable_lanes()
	_draw_mapped_collision()
	_draw_resource_pockets()
	_draw_scene_hooks()
	_draw_runtime_scan_radius()
	_draw_runtime_targets()
	_draw_cue_family_labels()
	_draw_diagnostic_summary()

func _draw_playable_lanes() -> void:
	var lanes: Array = source_map.get("playable_water_lanes", [])
	if lanes.is_empty():
		lanes = source_map.get("playable_water_regions", [])
	for lane in lanes:
		if typeof(lane) != TYPE_DICTIONARY:
			continue
		var lane_data := lane as Dictionary
		var points := _points_from_json(lane_data.get("approx_polygon", lane_data.get("polygon", [])))
		if points.size() < 3:
			continue
		draw_colored_polygon(points, LANE_COLOR)
		var edge_color := FUTURE_HOOK_EDGE_COLOR if String(lane_data.get("status", "")) == "future_locked" else LANE_EDGE_COLOR
		draw_polyline(_closed_points(points), edge_color, 2.0)

func _draw_mapped_collision() -> void:
	var solids: Array = source_map.get("solid_terrain", [])
	for solid in solids:
		if typeof(solid) != TYPE_DICTIONARY:
			continue
		var collision := _collision_for_solid(solid as Dictionary)
		if collision == null or collision.disabled:
			continue
		var points := PackedVector2Array()
		for point in collision.polygon:
			points.append(to_local(collision.to_global(point)))
		if points.size() < 3:
			continue
		draw_colored_polygon(points, COLLISION_COLOR)
		draw_polyline(_closed_points(points), COLLISION_EDGE_COLOR, 2.5)

func _draw_resource_pockets() -> void:
	var pockets: Array = source_map.get("resource_pockets", [])
	for pocket in pockets:
		if typeof(pocket) != TYPE_DICTIONARY:
			continue
		var path := String((pocket as Dictionary).get("scene_path", ""))
		var node := get_node_or_null("../%s" % path) as Node2D
		if node == null:
			continue
		var position := to_local(node.global_position)
		_draw_cross(position, POCKET_COLOR, 18.0, 2.0)
		draw_arc(position, 28.0, 0.0, TAU, 32, POCKET_COLOR, 2.0)

func _draw_scene_hooks() -> void:
	var hooks: Array = source_map.get("scene_hooks", [])
	for hook in hooks:
		if typeof(hook) != TYPE_DICTIONARY:
			continue
		var hook_data := hook as Dictionary
		var points := _points_from_json(hook_data.get("points", []))
		if points.size() < 3:
			continue
		var is_future := String(hook_data.get("status", "")) == "future_locked"
		draw_colored_polygon(points, FUTURE_HOOK_COLOR if is_future else HOOK_COLOR)
		draw_polyline(_closed_points(points), FUTURE_HOOK_EDGE_COLOR if is_future else HOOK_EDGE_COLOR, 1.5)

func _collision_for_solid(solid: Dictionary) -> CollisionPolygon2D:
	var path := String(solid.get("collision_path", ""))
	if not path.is_empty():
		return get_node_or_null("../%s" % path) as CollisionPolygon2D

	var runtime_generation: Variant = solid.get("runtime_generation", {})
	if not runtime_generation is Dictionary:
		return null
	var runtime := runtime_generation as Dictionary
	var collision_name := String(runtime.get("collision_polygon2d_name", ""))
	if collision_name.is_empty():
		return null
	return get_node_or_null("../Area01ArtSlice/RuntimeSourceCollision/%s" % collision_name) as CollisionPolygon2D

func _draw_runtime_scan_radius() -> void:
	var player := get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var position := to_local(player.global_position)
	draw_arc(position, scan_range, 0.0, TAU, 48, SCAN_RADIUS_COLOR, 2.0)

func _draw_runtime_targets() -> void:
	for resource in get_tree().get_nodes_in_group("resource_pickups"):
		if resource is Node2D and resource.visible:
			_draw_square(to_local((resource as Node2D).global_position), RESOURCE_COLOR, 9.0)

	for target in get_tree().get_nodes_in_group("scannables"):
		if target is Node2D and target.visible:
			_draw_diamond(to_local((target as Node2D).global_position), SCANNABLE_COLOR, 11.0)

func _draw_cue_family_labels() -> void:
	var parent := get_parent()
	if parent == null:
		return
	var font := ThemeDB.fallback_font
	var label_count := 0
	for node in _tagged_canvas_items(parent):
		if label_count >= MAX_CUE_LABELS:
			break
		if not _is_effectively_visible(node):
			continue
		var family := Area01VisualCueContractScript.family_for_node(node)
		if family == Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND:
			continue
		var position := _cue_label_position(node)
		var source_id := String(node.get_meta(Area01VisualCueContractScript.META_SOURCE_ID, node.name))
		var label := "%s | %s" % [_short_family_name(family), source_id]
		draw_string(font, position + Vector2(1.0, 1.0), label, HORIZONTAL_ALIGNMENT_LEFT, -1.0, 11, LABEL_SHADOW_COLOR)
		draw_string(font, position, label, HORIZONTAL_ALIGNMENT_LEFT, -1.0, 11, LABEL_COLOR)
		label_count += 1

func _draw_diagnostic_summary() -> void:
	var parent := get_parent()
	if parent == null:
		return
	var report: Dictionary = Area01VisualCueContractScript.debug_report(parent, _current_camera_region())
	var families: Dictionary = report.get("families", {})
	var warnings: Array = report.get("warnings", [])
	var validator_errors := _runtime_truth_errors(parent)
	var collision_drift_count := _count_matching_errors(validator_errors, "enabled Area 01 collision")
	var missing_metadata_count := int(families.get(Area01VisualCueContractScript.FAMILY_UNKNOWN, 0))
	var summary := source_map_summary()
	var lines: Array[String] = [
		"AREA 01 READABILITY DEBUG",
		"map: %s" % String(summary.get("map_id", "unknown")),
		"status: %s" % String(summary.get("status", "unknown")),
		"capture: %s" % capture_state,
		"camera: %s" % camera_state,
		"families: %s" % _format_family_counts(families),
		"unread collisions: %d" % collision_drift_count,
		"untagged visible cues: %d" % missing_metadata_count,
	]
	for warning in warnings.slice(0, 2):
		lines.append("warn: %s" % String(warning))
	if validator_errors.size() > 0 and collision_drift_count == 0:
		lines.append("truth warnings: %d" % validator_errors.size())

	var font := ThemeDB.fallback_font
	var top_left := get_canvas_transform().affine_inverse() * Vector2(18.0, 146.0)
	var line_height := 14.0
	var panel_size := Vector2(430.0, float(lines.size()) * line_height + 16.0)
	draw_rect(Rect2(top_left - Vector2(8.0, 14.0), panel_size), SUMMARY_BACK_COLOR, true)
	for index in range(lines.size()):
		var color := SUMMARY_WARN_COLOR if lines[index].begins_with("warn:") or lines[index].begins_with("truth warnings:") else SUMMARY_TEXT_COLOR
		draw_string(font, top_left + Vector2(0.0, float(index) * line_height), lines[index], HORIZONTAL_ALIGNMENT_LEFT, -1.0, 12, color)

func _runtime_truth_errors(parent: Node) -> Array[String]:
	var validator := Area01SourceTruthValidatorScript.new()
	if not validator.load_source_map():
		return validator.errors
	return validator.validate_runtime_scene(parent)

func _count_matching_errors(error_list: Array[String], pattern: String) -> int:
	var count := 0
	for error in error_list:
		if error.contains(pattern):
			count += 1
	return count

func _format_family_counts(families: Dictionary) -> String:
	var parts: Array[String] = []
	for family in [
		Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN,
		Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP,
		Area01VisualCueContractScript.FAMILY_RESOURCE_PICKUP,
		Area01VisualCueContractScript.FAMILY_KNOWLEDGE_PAYOFF,
		Area01VisualCueContractScript.FAMILY_LOCKED_PROMISE,
		Area01VisualCueContractScript.FAMILY_UNKNOWN,
	]:
		var count := int(families.get(family, 0))
		if count > 0:
			parts.append("%s %d" % [_short_family_name(family), count])
	return ", ".join(parts)

func _short_family_name(family: String) -> String:
	match family:
		Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN:
			return "terrain"
		Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP:
			return "rim"
		Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND:
			return "backdrop"
		Area01VisualCueContractScript.FAMILY_RETURN_CURRENT:
			return "return"
		Area01VisualCueContractScript.FAMILY_TIMING_HAZARD_SUPPORT:
			return "timing"
		Area01VisualCueContractScript.FAMILY_RESOURCE_PICKUP:
			return "pickup"
		Area01VisualCueContractScript.FAMILY_KNOWLEDGE_PAYOFF:
			return "knowledge"
		Area01VisualCueContractScript.FAMILY_LOCKED_PROMISE:
			return "locked"
		Area01VisualCueContractScript.FAMILY_ACTIVE_PROMPT_STATUS:
			return "prompt"
		Area01VisualCueContractScript.FAMILY_DEBUG_SOURCE_MAP_OVERLAY:
			return "debug"
		_:
			return "untagged"

func _tagged_canvas_items(root: Node) -> Array[CanvasItem]:
	var items: Array[CanvasItem] = []
	if root is CanvasItem and root.has_meta(Area01VisualCueContractScript.META_FAMILY):
		items.append(root as CanvasItem)
	for child in root.get_children():
		items.append_array(_tagged_canvas_items(child))
	return items

func _is_effectively_visible(item: CanvasItem) -> bool:
	var cursor: Node = item
	while cursor != null:
		if cursor is CanvasItem and not (cursor as CanvasItem).visible:
			return false
		cursor = cursor.get_parent()
	return true

func _cue_label_position(item: CanvasItem) -> Vector2:
	if item is Polygon2D:
		return to_local(_polygon_center(item as Polygon2D))
	if item is Node2D:
		return to_local((item as Node2D).global_position)
	return Vector2.ZERO

func _polygon_center(polygon: Polygon2D) -> Vector2:
	var points := polygon.polygon
	if points.is_empty():
		return (polygon as Node2D).global_position
	var total := Vector2.ZERO
	for point in points:
		total += (polygon as Node2D).to_global(point)
	return total / float(points.size())

func _current_camera_region() -> Rect2:
	var visible_rect := get_viewport_rect()
	var top_left := get_canvas_transform().affine_inverse() * visible_rect.position
	var bottom_right := get_canvas_transform().affine_inverse() * visible_rect.end
	return Rect2(top_left, bottom_right - top_left).abs()

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points

	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))

	return points

func _closed_points(points: PackedVector2Array) -> PackedVector2Array:
	var closed := PackedVector2Array(points)
	if not closed.is_empty():
		closed.append(closed[0])
	return closed

func _draw_cross(position: Vector2, color: Color, radius: float, width: float) -> void:
	draw_line(position + Vector2(-radius, 0.0), position + Vector2(radius, 0.0), color, width)
	draw_line(position + Vector2(0.0, -radius), position + Vector2(0.0, radius), color, width)

func _draw_square(position: Vector2, color: Color, half_size: float) -> void:
	draw_rect(Rect2(position - Vector2(half_size, half_size), Vector2(half_size * 2.0, half_size * 2.0)), color, false, 2.0)

func _draw_diamond(position: Vector2, color: Color, radius: float) -> void:
	var points := PackedVector2Array([
		position + Vector2(0.0, -radius),
		position + Vector2(radius, 0.0),
		position + Vector2(0.0, radius),
		position + Vector2(-radius, 0.0),
	])
	draw_polyline(_closed_points(points), color, 2.0)
