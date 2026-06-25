extends Node2D

enum DiveState { DIVING, EXTRACTED }

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt

var dive_state := DiveState.DIVING
var player_in_base := true

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	_update_hud()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E or event.keycode == KEY_ENTER:
			_try_extract()

func _try_extract() -> void:
	if dive_state != DiveState.DIVING or not player_in_base:
		return

	dive_state = DiveState.EXTRACTED
	status_label.text = "Dive complete: extracted safely."
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
	if dive_state == DiveState.EXTRACTED:
		prompt_label.text = "Extraction complete"
	elif player_in_base:
		prompt_label.text = "Safe base: press E or Enter to extract"
	else:
		prompt_label.text = "Explore, then return to the safe base"
