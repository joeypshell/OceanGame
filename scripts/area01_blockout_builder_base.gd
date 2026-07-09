class_name Area01BlockoutBuilderBase
extends RefCounted

const Area01VisualCueContractScript := preload("res://scripts/area01_visual_cue_contract.gd")
const GENERATED_RUNTIME_GEOMETRY_PATH := "res://data/maps/area_01_runtime_geometry.generated.json"
const RUNTIME_SOURCE_MAP_PATH := GENERATED_RUNTIME_GEOMETRY_PATH
const RUNTIME_SOURCE_MAP_V3_PATH := "res://docs/planning/maps/area_01_runtime_source_map_v3.json"
const LEGACY_SOURCE_MAP_PATH := "res://docs/planning/maps/area_01_blockout_source_map_v1.json"
const SOURCE_MAP_PATH := RUNTIME_SOURCE_MAP_PATH
const REEF_WALL_FILL_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_fill_texture_v2.png")
const WALL_CORNER_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_corner_cap_v1.svg")
const WALL_CRACK_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_crack_decal_v1.svg")
const WALL_KELP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_kelp_decal_v1.svg")
const WALL_CORAL_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_wall_coral_decal_v1.svg")
const TOP_LIP_LEFT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-2.png")
const TOP_LIP_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-3.png")
const TOP_LIP_RIGHT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-4.png")
const CEILING_LEFT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-5.png")
const CEILING_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-6.png")
const CEILING_RIGHT_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-7.png")
const VERTICAL_TOP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-9.png")
const VERTICAL_MIDDLE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-10.png")
const VERTICAL_BOTTOM_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-11.png")
const DIAGONAL_SLOPE_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-12.png")
const DEEP_FLOOR_LIP_TEXTURE := preload("res://assets/exports/sprites/environment/area01_reef_seafloor_terrain_kit_v4_frames/area01_terrain_kit_v4-16.png")
const SOLID_COLOR := Area01VisualCueContractScript.SOLID_TERRAIN_COLOR
const LIP_COLOR := Area01VisualCueContractScript.TERRAIN_RIM_COLOR
const TOP_EDGE_COLOR := Color(0.66, 0.94, 0.82, 0.10)
const SIDE_EDGE_COLOR := Color(0.06, 0.18, 0.20, 0.08)
const UNDER_EDGE_COLOR := Color(0.0, 0.012, 0.02, 0.18)
const INTERNAL_PLANE_COLOR := Color(0.03, 0.10, 0.11, 0.10)
const STRATA_LIGHT_COLOR := Color(0.18, 0.36, 0.32, 0.08)
const STRATA_DARK_COLOR := Color(0.0, 0.018, 0.024, 0.16)
const TERRAIN_DOMAIN_COLOR := Color(0.28, 0.52, 0.50, 0.92)
const WALL_DRESSING_LAYER_NAME := "SourceMapWallDressing"
const TERRAIN_ACCENT_LAYER_NAME := "SourceMapTerrainAccents"
const GENERATED_TERRAIN_LAYER_NAME := "RuntimeSourceTerrain"
const GENERATED_COLLISION_BODY_NAME := "RuntimeSourceCollision"
const GENERATED_RIM_LAYER_NAME := "RuntimeSourceRims"
const GENERATED_HOOK_LAYER_NAME := "RuntimeSourceHooks"
const GENERATED_WATER_CUTOUT_LAYER_NAME := "RuntimeSourceWaterCutouts"
const GENERATED_WATER_SKIN_LAYER_NAME := "RuntimeSourceMergedWaterSkins"
const GENERATED_WATER_EDGE_LAYER_NAME := "RuntimeSourceWaterEdges"
const GENERATED_PLAYER_RIM_LAYER_NAME := "RuntimeSourcePlayerRims"
const GENERATED_CAVE_WALL_ART_LAYER_NAME := "RuntimeSourceCaveWallSprites"
const GENERATED_DOMAIN_ACCENT_LAYER_NAME := "RuntimeSourceTerrainDomainAccents"
const AREA01_ART_SLICE_Z_INDEX := 0
const REEF_TEXTURE_UV_SCALE := 0.84
const FAR_BACKGROUND_AUTHORITY_ALPHA := 0.045
const PARALLAX_BACKGROUND_AUTHORITY_ALPHA := 0.055
const LIGHTING_STACK_AUTHORITY_ALPHA := 0.075
const WATER_SHAFT_AUTHORITY_ALPHA := 0.055
const TRIM_BASE_SCALE := 0.22
const TRIM_REPEAT_SPACING := 240.0
const TRIM_EDGE_ALPHA := 0.44
const TOP_TRIM_BLEND_COLOR := Color(0.48, 0.72, 0.64, 0.05)
const UNDER_TRIM_BLEND_COLOR := Color(0.0, 0.025, 0.035, 0.20)
const SIDE_TRIM_BLEND_COLOR := Color(0.02, 0.11, 0.12, 0.14)
const DEEP_TRIM_BLEND_COLOR := Color(0.0, 0.018, 0.026, 0.24)
const TOP_FACE_BEVEL_COLOR := Color(0.46, 0.78, 0.66, 0.04)
const TOP_EDGE_GLOW_COLOR := Color(0.78, 0.98, 0.90, 0.05)
const OVERHANG_OCCLUSION_COLOR := Color(0.0, 0.012, 0.018, 0.30)
const SIDE_OCCLUSION_COLOR := Color(0.0, 0.03, 0.035, 0.22)
const WATER_CUTOUT_COLOR := Color(0.015, 0.15, 0.23, 0.82)
const MERGED_WATER_SKIN_COLOR := Color(0.015, 0.15, 0.23, 0.10)
const MERGED_WATER_SKIN_INNER_COLOR := Color(0.09, 0.28, 0.34, 0.020)
const MERGED_WATER_SKIN_VERTEX_COUNT := 16
const MERGED_WATER_SKIN_EDGE_MARGIN := 32.0
const OPEN_SURFACE_WATER_CUTOUT_COLOR := Color(0.05, 0.32, 0.46, 0.0)
const WATER_AMBIENCE_REEF_COLOR := Color(0.03, 0.18, 0.20, 0.10)
const WATER_AMBIENCE_SILT_COLOR := Color(0.24, 0.58, 0.56, 0.035)
const WATER_AMBIENCE_CURRENT_COLOR := Color(0.38, 0.82, 0.82, 0.014)
const WATER_AMBIENCE_VEIL_COLOR := Color(0.16, 0.42, 0.48, 0.018)
const WATER_AMBIENCE_MOTE_COLOR := Color(0.54, 0.95, 0.92, 0.15)
const WATER_AMBIENCE_CORRIDOR_SHADOW_COLOR := Color(0.0, 0.024, 0.034, 0.028)
const WATER_AMBIENCE_CORRIDOR_GLOW_COLOR := Color(0.22, 0.62, 0.66, 0.008)
const WATER_AMBIENCE_MIN_WIDTH := 192.0
const WATER_AMBIENCE_MIN_HEIGHT := 128.0
const WATER_AMBIENCE_MIN_Y := 512.0
const WATER_AMBIENCE_CORRIDOR_MIN_LONG_AXIS := 448.0
const WATER_AMBIENCE_CORRIDOR_MAX_SHORT_AXIS := 180.0
const WATER_AMBIENCE_CORRIDOR_MIN_DECORATED_SHORT_AXIS := 96.0
const WATER_EDGE_COLOR := Color(0.70, 0.98, 0.90, 0.0)
const FUTURE_WATER_EDGE_COLOR := Color(0.90, 0.22, 0.38, 0.0)
const PLAYER_RIM_MARKER_SCALE := 0.115
const PLAYER_RIM_MARKER_ALPHA := 0.18
const FUTURE_PLAYER_RIM_MARKER_ALPHA := 0.22
const PLAYER_RIM_MARKER_SPACING := 300.0
const PLAYER_RIM_MARKERS_PER_EDGE := 4
const GENERATED_CAVE_WALL_ART_SCALE := 0.28
const GENERATED_CAVE_WALL_ART_SPACING := 190.0
const GENERATED_CAVE_WALL_ART_ALPHA := 0.46
const GENERATED_FUTURE_CAVE_WALL_ART_ALPHA := 0.30
const GENERATED_CAVE_WALL_ART_MAX_REPEATS := 10
const SOURCE_GRID_WATER_EDGE_ART_SCALE := 0.13
const SOURCE_GRID_WATER_EDGE_ART_SPACING := 360.0
const SOURCE_GRID_WATER_EDGE_ART_ALPHA := 0.14
const SOURCE_GRID_WATER_EDGE_ART_MIN_LENGTH := 96.0
const SOURCE_GRID_WATER_EDGE_ART_MAX_SPRITES := 56
const SOURCE_GRID_WATER_EDGE_BAND_MIN_LENGTH := 96.0
const SOURCE_GRID_WATER_EDGE_BAND_WIDTH := 9.0
const SOURCE_GRID_WATER_EDGE_CEILING_SHADOW_COLOR := Color(0.0, 0.014, 0.024, 0.026)
const SOURCE_GRID_WATER_EDGE_FLOOR_GLOW_COLOR := Color(0.34, 0.72, 0.64, 0.012)
const SOURCE_GRID_WATER_EDGE_SIDE_OCCLUSION_COLOR := Color(0.0, 0.035, 0.045, 0.032)
const SOURCE_GRID_WATER_EDGE_DEFAULT_BAND_COLOR := Color(0.04, 0.18, 0.18, 0.020)
const SOURCE_GRID_WATER_CORNER_CAP_SCALE := 0.13
const SOURCE_GRID_WATER_CORNER_CAP_ALPHA := 0.11
const SOURCE_GRID_WATER_CORNER_CAP_OFFSET := 8.0
const SOURCE_GRID_WATER_CORNER_CAP_STRIDE := 2
const SOURCE_GRID_WATER_CORNER_CAP_MAX_COUNT := 48
const SOURCE_GRID_WATER_BREAKUP_SCALE := 0.13
const SOURCE_GRID_WATER_BREAKUP_ALPHA := 0.12
const SOURCE_GRID_WATER_BREAKUP_STRIDE := 6
const SOURCE_GRID_WATER_BREAKUP_MAX_SPRITES := 16
const HOOK_PICKUP_COLOR := Color(0.16, 1.0, 0.82, 0.88)
const HOOK_SCAN_COLOR := Color(0.20, 0.86, 1.0, 0.82)
const HOOK_GATE_COLOR := Color(0.92, 0.24, 0.32, 0.62)
const HOOK_RETURN_COLOR := Color(0.20, 0.95, 0.68, 0.48)
const HOOK_HAZARD_COLOR := Color(0.96, 0.68, 0.18, 0.62)
const LEGACY_ROUTE_VISUAL_ROOTS := [
	"SafeShallowsExplorationShell",
	"EastShelfSpur",
	"ShellReefPocket",
	"ThermalVentPocket",
	"WreckEchoDescent",
]

var last_error := ""
var loaded_source_map_path := ""

func _texture_uv_for_points(points: PackedVector2Array, bounds: Rect2) -> PackedVector2Array:
	var uvs := PackedVector2Array()
	for point in points:
		uvs.append((point - bounds.position) * REEF_TEXTURE_UV_SCALE)
	return uvs

func _offset_polygon(points: PackedVector2Array, offset: Vector2) -> PackedVector2Array:
	var shifted := PackedVector2Array()
	for point in points:
		shifted.append(point + offset)
	return shifted

func _wall_sprite(sprite_name: String, texture: Texture2D, position: Vector2, scale: Vector2, alpha: float) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.name = sprite_name
	sprite.texture = texture
	sprite.position = position
	sprite.scale = scale
	sprite.modulate = Color(1.0, 1.0, 1.0, alpha)
	return sprite

func _pascal_case_id(value: String) -> String:
	var result := ""
	for part in value.split("_", false):
		if part.is_empty():
			continue
		result += part.substr(0, 1).to_upper() + part.substr(1)
	return result

func _points_from_json(value: Variant) -> PackedVector2Array:
	var points := PackedVector2Array()
	if not value is Array:
		return points

	for item in value:
		if item is Array and item.size() >= 2:
			points.append(Vector2(float(item[0]), float(item[1])))

	return points

func _point_from_json(value: Variant) -> Vector2:
	if value is Array and value.size() >= 2:
		return Vector2(float(value[0]), float(value[1]))
	return Vector2.ZERO

func _closed_points(points: PackedVector2Array) -> PackedVector2Array:
	var closed := PackedVector2Array(points)
	if not closed.is_empty():
		closed.append(closed[0])
	return closed

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

func _regular_marker_polygon(radius: float, sides: int) -> PackedVector2Array:
	var points := PackedVector2Array()
	if sides < 3:
		return points
	for index in range(sides):
		var angle := TAU * float(index) / float(sides) - PI * 0.5
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	return points

func _source_grid_water_edge_checksum(edge_id: String) -> int:
	var checksum := 0
	for index in range(edge_id.length()):
		checksum += edge_id.unicode_at(index) * (index + 1)
	return checksum
