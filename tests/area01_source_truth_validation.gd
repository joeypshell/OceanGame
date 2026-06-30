extends SceneTree

const MainScene := preload("res://scenes/Main.tscn")
const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")
const Area01SourceTruthValidatorScript := preload("res://scripts/area01_source_truth_validator.gd")

func _initialize() -> void:
	var validator := Area01SourceTruthValidatorScript.new()
	if not validator.load_source_map():
		_fail(validator.errors)
		return

	var scene := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	if not builder.build(scene):
		scene.free()
		_fail(["Area01BlockoutBuilder failed: %s" % builder.last_error])
		return

	var errors: Array[String] = validator.validate_runtime_scene(scene)
	scene.free()
	if not errors.is_empty():
		_fail(errors)
		return

	print("PASS Area 01 source truth validation")
	quit(0)

func _fail(errors: Array[String]) -> void:
	push_error("Area 01 source truth validation failed")
	for error in errors:
		push_error("- %s" % error)
	quit(1)
