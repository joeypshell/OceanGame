extends Node2D

enum DiveState { DIVING, EXTRACTED, FAILED }

@export var max_oxygen := 30.0
@export var oxygen_drain_per_second := 1.0
@export var start_position := Vector2(640.0, 190.0)

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt

var dive_state := DiveState.DIVING
var player_in_base := true
var oxygen := max_oxygen

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	oxygen = max_oxygen
	_update_hud()

func _process(delta: float) -> void:
	if dive_state != DiveState.DIVING:
		return

	oxygen = maxf(0.0, oxygen - oxygen_drain_per_second * delta)
	if oxygen <= 0.0:
		_fail_dive()
	else:
		_update_hud()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E or event.keycode == KEY_ENTER:
			_try_extract()
		elif event.keycode == KEY_R:
			_restart_dive()

func _try_extract() -> void:
	if dive_state != DiveState.DIVING or not player_in_base:
		return

	dive_state = DiveState.EXTRACTED
	status_label.text = "Dive complete: extracted safely with %d oxygen." % ceili(oxygen)
	_update_hud()

func _fail_dive() -> void:
	dive_state = DiveState.FAILED
	status_label.text = "Dive failed: oxygen depleted. Cargo lost."
	_update_hud()

func _restart_dive() -> void:
	dive_state = DiveState.DIVING
	oxygen = max_oxygen
	player.global_position = start_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	status_label.text = "Dive status: active"
	_update_hud()

func _on_base_zone_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_base = true
		_update_hud()

func _on_base_zone_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_base = false
		_update_hud()

func _update_hud() -> void:
	oxygen_label.text = "Oxygen: %d / %d" % [ceili(oxygen), ceili(max_oxygen)]

	if dive_state == DiveState.EXTRACTED:
		prompt_label.text = "Extraction complete - press R to restart"
	elif dive_state == DiveState.FAILED:
		prompt_label.text = "Run failed - press R to restart"
	elif player_in_base:
		prompt_label.text = "Safe base: press E or Enter to extract"
	else:
		prompt_label.text = "Explore, then return to the safe base"
