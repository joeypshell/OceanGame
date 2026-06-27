extends Area2D

@export var discovery_id: String
@export var display_name: String
@export var description: String
@export var gameplay_fact: String
@export var move_start := Vector2.ZERO
@export var move_end := Vector2.ZERO
@export var move_speed := 0.0

const MarkerPatterns := preload("res://scripts/readability_marker_patterns.gd")

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

func configure_patrol(start: Vector2, end: Vector2) -> void:
	move_start = start
	move_end = end
	global_position = move_start
	_target = move_end

func set_scan_selected(selected: bool) -> void:
	is_scan_selected = selected
	modulate = Color(1.35, 1.25, 0.58, 1.0) if is_scan_selected else Color.WHITE
	_refresh_scan_marker()

func _prepare_scan_marker() -> void:
	scan_marker = get_node_or_null("ScanMarker") as Polygon2D
	if scan_marker == null:
		return

	scan_marker.polygon = MarkerPatterns.scan_marker_polygon()
	focus_bracket_a = MarkerPatterns.ensure_focus_bracket(self, "ScanFocusBracketA", MarkerPatterns.scan_focus_bracket_a_polygon())
	focus_bracket_b = MarkerPatterns.ensure_focus_bracket(self, "ScanFocusBracketB", MarkerPatterns.scan_focus_bracket_b_polygon())
	_refresh_scan_marker()

func _refresh_scan_marker() -> void:
	if scan_marker == null:
		return

	scan_marker.color = MarkerPatterns.scan_marker_color(is_scan_selected)
	if focus_bracket_a != null:
		focus_bracket_a.color = MarkerPatterns.scan_bracket_color(is_scan_selected)
	if focus_bracket_b != null:
		focus_bracket_b.color = MarkerPatterns.scan_bracket_color(is_scan_selected)
