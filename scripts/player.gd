extends CharacterBody2D

@export var max_speed := 320.0
@export var acceleration := 900.0
@export var drag := 650.0
@export var world_bounds := Rect2(Vector2(96.0, 245.0), Vector2(2904.0, 2815.0))

var _movement_disrupt_timer := 0.0
var _last_move_direction := Vector2.RIGHT
var _facing_sign := 1.0
var _visual_motion_time := 0.0

@onready var _visual_root: Node2D = get_node_or_null("VisualRoot")
@onready var _bubble_trail: Polygon2D = get_node_or_null("VisualRoot/BubbleTrail")
@onready var _idle_bubble: Polygon2D = get_node_or_null("VisualRoot/IdleBubble")
@onready var _thrust_flare: Polygon2D = get_node_or_null("VisualRoot/ThrustFlare")

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if _movement_disrupt_timer > 0.0:
		_movement_disrupt_timer = maxf(0.0, _movement_disrupt_timer - delta)
		move_and_slide()
		global_position = clamp_position_to_world_bounds(global_position)
		_sync_movement_visuals(delta, velocity.length() > 8.0)
		return

	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector != Vector2.ZERO:
		_last_move_direction = input_vector.normalized()
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
	global_position = clamp_position_to_world_bounds(global_position)

	if absf(velocity.x) > 1.0:
		_set_facing_sign(signf(velocity.x))

	_sync_movement_visuals(delta, velocity.length() > 8.0)

func apply_knockback(direction: Vector2, force: float, disruption_seconds: float) -> void:
	velocity = direction.normalized() * force
	_movement_disrupt_timer = disruption_seconds

func burst(direction: Vector2, force: float) -> void:
	var burst_direction := direction.normalized() if direction != Vector2.ZERO else get_burst_direction()
	velocity = burst_direction * force

func clamp_position_to_world_bounds(position: Vector2) -> Vector2:
	return position.clamp(world_bounds.position, world_bounds.end)

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

func _sync_movement_visuals(delta: float, is_moving: bool) -> void:
	_visual_motion_time += delta
	var pulse := 0.5 + 0.5 * sin(_visual_motion_time * 8.0)

	if _bubble_trail == null:
		_bubble_trail = get_node_or_null("VisualRoot/BubbleTrail")
	if _bubble_trail != null:
		_bubble_trail.visible = true
		_bubble_trail.scale = Vector2.ONE * (1.0 + (0.16 if is_moving else 0.04) * pulse)
		_bubble_trail.color = Color(0.72, 0.96, 1.0, 0.48 if is_moving else 0.22)

	if _idle_bubble == null:
		_idle_bubble = get_node_or_null("VisualRoot/IdleBubble")
	if _idle_bubble != null:
		_idle_bubble.visible = not is_moving
		_idle_bubble.scale = Vector2.ONE * (0.88 + 0.08 * pulse)
		_idle_bubble.color = Color(0.72, 0.96, 1.0, 0.18 + 0.08 * pulse)

	if _thrust_flare == null:
		_thrust_flare = get_node_or_null("VisualRoot/ThrustFlare")
	if _thrust_flare != null:
		_thrust_flare.visible = is_moving
		_thrust_flare.scale = Vector2(1.0 + 0.22 * pulse, 0.82 + 0.12 * pulse)
		_thrust_flare.color = Color(0.42, 1.0, 0.92, 0.38 + 0.2 * pulse)
