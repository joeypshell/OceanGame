class_name ResourcePickup
extends Area2D

signal collected(pickup: ResourcePickup)

@export var definition: ResourceDefinition

var is_collected := false
var is_scan_selected := false
var is_tactical_highlighted := false

func _ready() -> void:
	add_to_group("resource_pickups")
	add_to_group("scan_targets")
	body_entered.connect(_on_body_entered)

func collect() -> void:
	is_collected = true
	visible = false
	monitoring = false
	_refresh_scan_modulate()

func reset_pickup() -> void:
	is_collected = false
	visible = true
	monitoring = true
	_refresh_scan_modulate()

func set_scan_selected(selected: bool) -> void:
	is_scan_selected = selected
	_refresh_scan_modulate()

func set_tactical_highlight(highlighted: bool) -> void:
	is_tactical_highlighted = highlighted
	_refresh_scan_modulate()

func _refresh_scan_modulate() -> void:
	if is_scan_selected:
		modulate = Color(1.35, 1.25, 0.58, 1.0)
	elif is_tactical_highlighted:
		modulate = Color(0.75, 1.45, 0.85, 1.0)
	else:
		modulate = Color.WHITE

func _on_body_entered(body: Node2D) -> void:
	if is_collected or definition == null or not body is CharacterBody2D:
		return

	collected.emit(self)
