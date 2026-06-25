extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")

@export var max_oxygen := 30.0
@export var oxygen_drain_per_second := 1.0
@export var start_position := Vector2(640.0, 190.0)
@export var surface_y := 120.0
@export var pixels_per_meter := 10.0

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt

var dive_session := DiveSessionScript.new()
var progression_state := ProgressionStateScript.new()
var player_in_base := true

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	dive_session.reset(max_oxygen)
	_update_hud()

func _process(delta: float) -> void:
	_update_depth()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	dive_session.drain_oxygen(oxygen_drain_per_second * delta)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		_update_hud()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		_try_extract()
	elif Input.is_action_just_pressed("restart_dive"):
		_restart_dive()

func _try_extract() -> void:
	if not dive_session.can_extract(player_in_base):
		return

	dive_session.extract()
	status_label.text = "Dive complete: extracted safely with %d oxygen." % ceili(dive_session.oxygen)
	_update_hud()

func _fail_dive() -> void:
	status_label.text = "Dive failed: oxygen depleted. Cargo lost."
	_update_hud()

func _restart_dive() -> void:
	dive_session.reset(max_oxygen)
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
		dive_session.has_left_base = true
		_update_hud()

func _update_depth() -> void:
	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	progression_state.record_depth(dive_session.current_depth)

func _update_hud() -> void:
	oxygen_label.text = "Oxygen: %d / %d" % [ceili(dive_session.oxygen), ceili(dive_session.max_oxygen)]

	if dive_session.result == DiveSessionScript.Result.EXTRACTED:
		prompt_label.text = "Extraction complete - press R to restart"
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		prompt_label.text = "Run failed - press R to restart"
	elif player_in_base:
		if dive_session.has_left_base:
			prompt_label.text = "Safe base: press E or Enter to extract"
		else:
			prompt_label.text = "Leave the moonpool, then return to extract"
	else:
		prompt_label.text = "Explore, then return to the safe base"
