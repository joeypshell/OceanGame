extends Area2D

signal contacted(predator: Node)

@export var patrol_start := Vector2.ZERO
@export var patrol_end := Vector2.ZERO
@export var patrol_speed := 90.0
@export var chase_speed := 155.0
@export var detect_radius := 180.0
@export var warning_radius_multiplier := 1.45
@export var chase_duration := 2.0
@export var decoy_speed_multiplier := 0.9
@export var discovery_id: String
@export var display_name: String
@export var description: String
@export var gameplay_fact: String

@onready var patrol_hint: Polygon2D = $PatrolHint
@onready var scan_marker: Polygon2D = $ScanMarker

const MarkerPatterns := preload("res://scripts/readability_marker_patterns.gd")

var _target := Vector2.ZERO
var _chase_time := 0.0
var _decoy_target := Vector2.ZERO
var _decoy_time := 0.0
var is_scan_selected := false
var focus_bracket_a: Polygon2D = null
var focus_bracket_b: Polygon2D = null

func _ready() -> void:
	add_to_group("predators")
	add_to_group("scan_targets")
	body_entered.connect(_on_body_entered)
	_prepare_scan_marker()
	if patrol_start == Vector2.ZERO:
		patrol_start = global_position
	if patrol_end == Vector2.ZERO:
		patrol_end = global_position
	_target = patrol_end

func _physics_process(delta: float) -> void:
	var player := get_tree().get_first_node_in_group("player") as Node2D
	_update_warning_feedback(player)
	if _decoy_time > 0.0:
		_decoy_time = maxf(0.0, _decoy_time - delta)
		_chase_time = 0.0
		if patrol_hint != null:
			patrol_hint.modulate = Color(0.62, 1.0, 0.72, 0.72)
		global_position = global_position.move_toward(_decoy_target, chase_speed * decoy_speed_multiplier * delta)
		return

	if player != null and global_position.distance_to(player.global_position) <= detect_radius:
		_chase_time = chase_duration

	if _chase_time > 0.0 and player != null:
		_chase_time = maxf(0.0, _chase_time - delta)
		global_position = global_position.move_toward(player.global_position, chase_speed * delta)
		return

	global_position = global_position.move_toward(_target, patrol_speed * delta)
	if global_position.distance_to(_target) < 6.0:
		_target = patrol_start if _target == patrol_end else patrol_end

func configure_patrol(new_patrol_start: Vector2, new_patrol_end: Vector2) -> void:
	patrol_start = new_patrol_start
	patrol_end = new_patrol_end
	global_position = patrol_start
	_target = patrol_end
	_chase_time = 0.0
	_decoy_time = 0.0

func set_warning_radius_multiplier(multiplier: float) -> void:
	warning_radius_multiplier = maxf(1.0, multiplier)

func trigger_decoy_from(player_position: Vector2, duration: float, distance: float) -> void:
	var away_from_player := global_position - player_position
	if away_from_player == Vector2.ZERO:
		away_from_player = (patrol_end - patrol_start).normalized()
	if away_from_player == Vector2.ZERO:
		away_from_player = Vector2.RIGHT

	_decoy_target = global_position + away_from_player.normalized() * distance
	_decoy_time = maxf(0.0, duration)
	_chase_time = 0.0

func is_decoy_active() -> bool:
	return _decoy_time > 0.0

func decoy_time_remaining() -> float:
	return _decoy_time

func decoy_target() -> Vector2:
	return _decoy_target

func warning_radius() -> float:
	return detect_radius * warning_radius_multiplier

func set_scan_selected(selected: bool) -> void:
	is_scan_selected = selected
	modulate = Color(1.32, 1.18, 0.58, 1.0) if is_scan_selected else Color.WHITE
	_refresh_scan_marker()

func _prepare_scan_marker() -> void:
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

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		contacted.emit(self)

func _update_warning_feedback(player: Node2D) -> void:
	if patrol_hint == null:
		return

	if player == null:
		patrol_hint.modulate = Color.WHITE
		return

	var distance := global_position.distance_to(player.global_position)
	if distance <= detect_radius:
		var pulse := 0.75 + 0.25 * absf(sin(Time.get_ticks_msec() / 80.0))
		patrol_hint.modulate = Color(1.0, 0.15, 0.12, pulse)
	elif distance <= warning_radius():
		var warning_strength := 1.0 - ((distance - detect_radius) / (warning_radius() - detect_radius))
		patrol_hint.modulate = Color(1.0, 0.55, 0.18, 0.45 + 0.25 * warning_strength)
	else:
		patrol_hint.modulate = Color.WHITE
