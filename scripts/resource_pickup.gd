class_name ResourcePickup
extends Area2D

signal collected(pickup: ResourcePickup)

@export var definition: ResourceDefinition

var is_collected := false

func _ready() -> void:
	add_to_group("resource_pickups")
	body_entered.connect(_on_body_entered)

func collect() -> void:
	is_collected = true
	visible = false
	monitoring = false

func reset_pickup() -> void:
	is_collected = false
	visible = true
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if is_collected or definition == null or not body is CharacterBody2D:
		return

	collected.emit(self)
