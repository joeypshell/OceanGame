extends Area2D

signal contacted(predator: Node)

@export var patrol_start := Vector2.ZERO
@export var patrol_end := Vector2.ZERO
@export var patrol_speed := 90.0
@export var chase_speed := 155.0
@export var detect_radius := 180.0
@export var chase_duration := 2.0

@onready var patrol_hint: Polygon2D = $PatrolHint

var _target := Vector2.ZERO
var _chase_time := 0.0

func _ready() -> void:
	add_to_group("predators")
	body_entered.connect(_on_body_entered)
	if patrol_start == Vector2.ZERO:
		patrol_start = global_position
	if patrol_end == Vector2.ZERO:
		patrol_end = global_position
	_target = patrol_end

func _physics_process(delta: float) -> void:
	var player := get_tree().get_first_node_in_group("player") as Node2D
	_update_warning_feedback(player)
	if player != null and global_position.distance_to(player.global_position) <= detect_radius:
		_chase_time = chase_duration

	if _chase_time > 0.0 and player != null:
		_chase_time = maxf(0.0, _chase_time - delta)
		global_position = global_position.move_toward(player.global_position, chase_speed * delta)
		return

	global_position = global_position.move_toward(_target, patrol_speed * delta)
	if global_position.distance_to(_target) < 6.0:
		_target = patrol_start if _target == patrol_end else patrol_end

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		contacted.emit(self)

func _update_warning_feedback(player: Node2D) -> void:
	if patrol_hint == null:
		return

	if player == null:
		patrol_hint.modulate = Color.WHITE
		return

	var warning_radius := detect_radius * 1.45
	var distance := global_position.distance_to(player.global_position)
	if distance <= detect_radius:
		var pulse := 0.75 + 0.25 * absf(sin(Time.get_ticks_msec() / 80.0))
		patrol_hint.modulate = Color(1.0, 0.15, 0.12, pulse)
	elif distance <= warning_radius:
		var warning_strength := 1.0 - ((distance - detect_radius) / (warning_radius - detect_radius))
		patrol_hint.modulate = Color(1.0, 0.55, 0.18, 0.45 + 0.25 * warning_strength)
	else:
		patrol_hint.modulate = Color.WHITE
