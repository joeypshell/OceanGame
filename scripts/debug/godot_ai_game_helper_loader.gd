extends Node

const GAME_HELPER_PATH := "res://addons/godot_ai/runtime/game_helper.gd"


func _ready() -> void:
	# Exported and standalone headless builds have no editor debugger to serve.
	if not EngineDebugger.is_active():
		return
	if not ResourceLoader.exists(GAME_HELPER_PATH):
		push_warning("Godot AI runtime helper is unavailable; editor capture tools are disabled.")
		return
	var helper_script := load(GAME_HELPER_PATH) as Script
	if helper_script == null:
		push_warning("Godot AI runtime helper could not be loaded; editor capture tools are disabled.")
		return
	var helper := helper_script.new() as Node
	if helper == null:
		push_warning("Godot AI runtime helper is not a Node; editor capture tools are disabled.")
		return
	add_child(helper)
