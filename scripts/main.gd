extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")

@export var max_oxygen := 30.0
@export var oxygen_drain_per_second := 1.0
@export var collect_oxygen_cost := 1.0
@export var start_position := Vector2(640.0, 190.0)
@export var surface_y := 120.0
@export var pixels_per_meter := 10.0

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var depth_label: Label = $HUD/Depth
@onready var base_direction_label: Label = $HUD/BaseDirection
@onready var cargo_label: Label = $HUD/Cargo
@onready var bank_label: Label = $HUD/BankedResources
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt

var dive_session := DiveSessionScript.new()
var progression_state := ProgressionStateScript.new()
var player_in_base := true

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.collected.connect(_on_resource_pickup_collected)
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
	progression_state.bank_cargo(dive_session.current_cargo)
	dive_session.clear_cargo()
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
	_reset_resource_pickups()
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

func _on_resource_pickup_collected(pickup: Node) -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	if not dive_session.add_cargo(pickup.definition.id):
		status_label.text = "Cargo full: return to bank resources."
		_update_hud()
		return

	pickup.collect()
	dive_session.drain_oxygen(collect_oxygen_cost)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		status_label.text = "Collected %s." % pickup.definition.display_name
		_update_hud()

func _reset_resource_pickups() -> void:
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.reset_pickup()

func _update_hud() -> void:
	oxygen_label.text = "Oxygen: %d / %d" % [ceili(dive_session.oxygen), ceili(dive_session.max_oxygen)]
	depth_label.text = "Depth: %dm | Best: %dm" % [
		roundi(dive_session.current_depth),
		roundi(progression_state.best_depth_reached)
	]
	base_direction_label.text = _format_base_direction()
	cargo_label.text = "Cargo: %d / %d%s" % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit,
		_format_resource_counts(dive_session.current_cargo)
	]
	bank_label.text = "Banked:%s" % _format_banked_resources()

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

func _format_resource_counts(resource_ids: Array[String]) -> String:
	if resource_ids.is_empty():
		return ""

	var counts := {}
	for resource_id in resource_ids:
		counts[resource_id] = int(counts.get(resource_id, 0)) + 1

	var parts: Array[String] = []
	for resource_id in counts.keys():
		parts.append(" %s x%d" % [_display_name_for_resource(resource_id), int(counts[resource_id])])

	return "\n" + "\n".join(parts)

func _format_banked_resources() -> String:
	if progression_state.banked_resources.is_empty():
		return " none"

	var parts: Array[String] = []
	for resource_id in progression_state.banked_resources.keys():
		parts.append(" %s x%d" % [
			_display_name_for_resource(resource_id),
			progression_state.resource_count(resource_id)
		])

	return "\n" + "\n".join(parts)

func _display_name_for_resource(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp Fiber"
		"shell_fragments":
			return "Shell Fragments"
		"glow_plankton":
			return "Glow Plankton"
		_:
			return resource_id

func _format_base_direction() -> String:
	var vertical_delta := player.global_position.y - start_position.y
	if absf(vertical_delta) < 48.0:
		return "Base: here"

	if vertical_delta > 0.0:
		return "Base: up %.0fm" % (vertical_delta / pixels_per_meter)

	return "Base: below %.0fm" % (absf(vertical_delta) / pixels_per_meter)
