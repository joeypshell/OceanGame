extends CharacterBody2D

@export var max_speed := 320.0
@export var acceleration := 900.0
@export var drag := 650.0
@export var world_bounds := Rect2(Vector2(96.0, 120.0), Vector2(1088.0, 2080.0))

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
	global_position = global_position.clamp(world_bounds.position, world_bounds.end)

	if absf(velocity.x) > 1.0:
		scale.x = signf(velocity.x)
