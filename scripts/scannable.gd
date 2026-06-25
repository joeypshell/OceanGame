extends Area2D

@export var discovery_id: String
@export var display_name: String
@export var description: String
@export var gameplay_fact: String
@export var move_start := Vector2.ZERO
@export var move_end := Vector2.ZERO
@export var move_speed := 0.0

var _target := Vector2.ZERO

func _ready() -> void:
	add_to_group("scannables")
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
