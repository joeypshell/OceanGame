class_name ProgressionState
extends RefCounted

var banked_resources: Dictionary = {}
var purchased_upgrades: Dictionary = {}
var scan_discoveries: Dictionary = {}
var best_depth_reached := 0.0
var current_run_number := 0
var current_run_seed := 0

func advance_run() -> void:
	current_run_number += 1
	current_run_seed = 1000 + current_run_number * 7919

func bank_cargo(cargo: Array[String]) -> void:
	for resource_id in cargo:
		banked_resources[resource_id] = int(banked_resources.get(resource_id, 0)) + 1

func record_depth(depth: float) -> void:
	best_depth_reached = maxf(best_depth_reached, depth)

func has_upgrade(upgrade_id: String) -> bool:
	return bool(purchased_upgrades.get(upgrade_id, false))

func can_afford(cost: Dictionary) -> bool:
	for resource_id in cost.keys():
		if resource_count(resource_id) < int(cost[resource_id]):
			return false

	return true

func purchase_upgrade(upgrade_id: String, cost: Dictionary) -> bool:
	if has_upgrade(upgrade_id) or not can_afford(cost):
		return false

	for resource_id in cost.keys():
		banked_resources[resource_id] = resource_count(resource_id) - int(cost[resource_id])

	purchased_upgrades[upgrade_id] = true
	return true

func add_discovery(discovery_id: String, display_name: String, description: String, gameplay_fact: String) -> void:
	scan_discoveries[discovery_id] = {
		"display_name": display_name,
		"description": description,
		"gameplay_fact": gameplay_fact,
	}

func has_discovery(discovery_id: String) -> bool:
	return scan_discoveries.has(discovery_id)

func resource_count(resource_id: String) -> int:
	return int(banked_resources.get(resource_id, 0))
