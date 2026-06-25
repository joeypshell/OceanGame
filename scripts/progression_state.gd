class_name ProgressionState
extends RefCounted

var banked_resources: Dictionary = {}
var purchased_upgrades: Dictionary = {}
var scan_discoveries: Dictionary = {}
var best_depth_reached := 0.0

func bank_cargo(cargo: Array[String]) -> void:
	for resource_id in cargo:
		banked_resources[resource_id] = int(banked_resources.get(resource_id, 0)) + 1

func record_depth(depth: float) -> void:
	best_depth_reached = maxf(best_depth_reached, depth)

func has_upgrade(upgrade_id: String) -> bool:
	return bool(purchased_upgrades.get(upgrade_id, false))

func add_discovery(discovery_id: String) -> void:
	scan_discoveries[discovery_id] = true

func resource_count(resource_id: String) -> int:
	return int(banked_resources.get(resource_id, 0))
