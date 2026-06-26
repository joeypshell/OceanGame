extends Area2D

@export var discovery_id: String
@export var display_name: String
@export var description: String
@export var gameplay_fact: String
@export var move_start := Vector2.ZERO
@export var move_end := Vector2.ZERO
@export var move_speed := 0.0

const SCAN_MARKER_IDLE_COLOR := Color(0.95, 1.0, 0.7, 0.24)
const SCAN_MARKER_SELECTED_COLOR := Color(1.0, 1.0, 0.55, 0.54)
const SCAN_BRACKET_IDLE_COLOR := Color(0.9, 1.0, 1.0, 0.0)
const SCAN_BRACKET_SELECTED_COLOR := Color(0.9, 1.0, 1.0, 0.34)

var _target := Vector2.ZERO
var is_scan_selected := false
var scan_marker: Polygon2D = null
var focus_bracket_a: Polygon2D = null
var focus_bracket_b: Polygon2D = null

func _ready() -> void:
	add_to_group("scannables")
	add_to_group("scan_targets")
	_prepare_scan_marker()
	if move_speed > 0.0:
		if move_start == Vector2.ZERO:
			move_start = global_position
		if move_end == Vector2.ZERO:
			move_end = global_position
		_target = move_end

func _physics_process(delta: float) -> void:
	if move_speed <= 0.0:
		return

	global_position = global_position.move_toward(_target, move_speed * delta)
	if global_position.distance_to(_target) < 4.0:
		_target = move_start if _target == move_end else move_end

func set_scan_selected(selected: bool) -> void:
	is_scan_selected = selected
	modulate = Color(1.35, 1.25, 0.58, 1.0) if is_scan_selected else Color.WHITE
	_refresh_scan_marker()

func _prepare_scan_marker() -> void:
	scan_marker = get_node_or_null("ScanMarker") as Polygon2D
	if scan_marker == null:
		return

	scan_marker.polygon = _scan_marker_polygon()
	focus_bracket_a = _ensure_focus_bracket("ScanFocusBracketA", _focus_bracket_a_polygon())
	focus_bracket_b = _ensure_focus_bracket("ScanFocusBracketB", _focus_bracket_b_polygon())
	_refresh_scan_marker()

func _scan_marker_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(0, -36),
		Vector2(28, -18),
		Vector2(36, 0),
		Vector2(28, 18),
		Vector2(0, 36),
		Vector2(-28, 18),
		Vector2(-36, 0),
		Vector2(-28, -18),
	])

func _focus_bracket_a_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(-48, -42),
		Vector2(-24, -42),
		Vector2(-24, -34),
		Vector2(-40, -34),
		Vector2(-40, -18),
		Vector2(-48, -18),
	])

func _focus_bracket_b_polygon() -> PackedVector2Array:
	return PackedVector2Array([
		Vector2(48, 42),
		Vector2(24, 42),
		Vector2(24, 34),
		Vector2(40, 34),
		Vector2(40, 18),
		Vector2(48, 18),
	])

func _ensure_focus_bracket(node_name: String, polygon: PackedVector2Array) -> Polygon2D:
	var bracket := get_node_or_null(node_name) as Polygon2D
	if bracket == null:
		bracket = Polygon2D.new()
		bracket.name = node_name
		add_child(bracket)

	bracket.polygon = polygon
	return bracket

func _refresh_scan_marker() -> void:
	if scan_marker == null:
		return

	scan_marker.color = SCAN_MARKER_SELECTED_COLOR if is_scan_selected else SCAN_MARKER_IDLE_COLOR
	if focus_bracket_a != null:
		focus_bracket_a.color = SCAN_BRACKET_SELECTED_COLOR if is_scan_selected else SCAN_BRACKET_IDLE_COLOR
	if focus_bracket_b != null:
		focus_bracket_b.color = SCAN_BRACKET_SELECTED_COLOR if is_scan_selected else SCAN_BRACKET_IDLE_COLOR
