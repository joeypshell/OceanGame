extends CharacterBody2D

@export var max_speed := 320.0
@export var acceleration := 900.0
@export var drag := 650.0
@export var world_bounds := Rect2(Vector2(96.0, 120.0), Vector2(1088.0, 2080.0))

var _movement_disrupt_timer := 0.0
var _last_move_direction := Vector2.RIGHT
var _facing_sign := 1.0

@onready var _visual_root: Node2D = get_node_or_null("VisualRoot")

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if _movement_disrupt_timer > 0.0:
		_movement_disrupt_timer = maxf(0.0, _movement_disrupt_timer - delta)
		move_and_slide()
		global_position = global_position.clamp(world_bounds.position, world_bounds.end)
		return

	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector != Vector2.ZERO:
		_last_move_direction = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
	global_position = global_position.clamp(world_bounds.position, world_bounds.end)

	if absf(velocity.x) > 1.0:
		_set_facing_sign(signf(velocity.x))

func apply_knockback(direction: Vector2, force: float, disruption_seconds: float) -> void:
	velocity = direction.normalized() * force
	_movement_disrupt_timer = disruption_seconds

func burst(direction: Vector2, force: float) -> void:
	var burst_direction := direction.normalized() if direction != Vector2.ZERO else get_burst_direction()
	velocity = burst_direction * force

func get_burst_direction() -> Vector2:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector != Vector2.ZERO:
		return input_vector.normalized()

	if _last_move_direction != Vector2.ZERO:
		return _last_move_direction.normalized()

	return Vector2(_facing_sign, 0.0)

func _set_facing_sign(next_sign: float) -> void:
	if next_sign == 0.0:
		return

	_facing_sign = signf(next_sign)
	if _visual_root == null:
		_visual_root = get_node_or_null("VisualRoot")
	if _visual_root != null:
		_visual_root.scale.x = _facing_sign
