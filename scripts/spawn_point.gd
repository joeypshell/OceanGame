class_name SpawnPoint
extends Marker2D

@export var spawn_id: String
@export_enum("resource", "hazard", "creature", "discovery", "resource_cluster") var category := "resource"
@export var target_id: String
@export_enum("shallow", "midwater", "deep") var depth_band := "shallow"
@export_enum("any", "cautious", "deep_reward") var cluster_pattern := "any"
@export var preferred_condition_id: String
@export var route_id: String

func _ready() -> void:
	add_to_group("spawn_points")

func matches(requested_category: String, requested_target_id: String) -> bool:
	return category == requested_category and target_id == requested_target_id
