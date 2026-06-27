class_name ExpeditionGoalFormatter
extends RefCounted

const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const RESONANCE_KEY_UPGRADE_ID := "resonance_key_1"

static func format_goal(progression_state: ProgressionState, upgrade_definitions: Array[UpgradeDefinition], condition_id := "", recent_route_memory := "") -> String:
	for upgrade in upgrade_definitions:
		if progression_state.has_upgrade(upgrade.id):
			continue

		var missing_discovery := UpgradePurchaseScript.missing_discovery(progression_state, upgrade)
		if missing_discovery != "":
			return "Goal: scan %s, then bank %s for %s." % [
				_discovery_name(missing_discovery),
				_format_cost(upgrade.resource_cost),
				upgrade.display_name,
			]

		var missing_upgrade := UpgradePurchaseScript.missing_upgrade(progression_state, upgrade)
		if missing_upgrade != "":
			return "Goal: buy %s before %s." % [
				_upgrade_name(missing_upgrade, upgrade_definitions),
				upgrade.display_name,
			]

		var missing_resources := _format_missing_resources(progression_state, upgrade.resource_cost)
		if missing_resources == "none":
			return "Goal: buy %s in the upgrade bay after this dive." % upgrade.display_name

		return "Goal: bank %s for %s." % [
			missing_resources,
			upgrade.display_name,
		]

	var prepared_for_blackwater := progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID)
	if prepared_for_blackwater and recent_route_memory == "Hollow Reef":
		return "Goal: follow Hollow Reef toward the wide chamber if oxygen allows, then return safely."
	if prepared_for_blackwater and recent_route_memory == "Dusk Trench":
		return "Goal: follow Dusk toward Hollow Reef if oxygen allows, then return safely."
	if prepared_for_blackwater and recent_route_memory == "Blackwater":
		return "Goal: try Blackwater toward Dusk if oxygen allows, then return safely."
	if condition_id == "rare_signal" and progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID):
		return "Goal: check the Blackwater edge signal if oxygen allows, then return safely."
	if prepared_for_blackwater:
		return "Goal: try the Blackwater lower route if oxygen allows, then return safely."
	if condition_id == "rare_signal":
		return "Goal: check the East Shelf or Blue Chimney signal if oxygen allows, then return safely."

	return "Goal: bank Shell Reef, or try Shelf Drop and Blue Chimney if oxygen allows; return safely."

static func _format_missing_resources(progression_state: ProgressionState, cost: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		var missing := int(cost[resource_id]) - progression_state.resource_count(resource_id)
		if missing > 0:
			parts.append("%s x%d" % [_resource_name(resource_id), missing])

	return "none" if parts.is_empty() else ", ".join(parts)

static func _format_cost(cost: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		parts.append("%s x%d" % [_resource_name(resource_id), int(cost[resource_id])])

	return "resources" if parts.is_empty() else ", ".join(parts)

static func _resource_name(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp Fiber"
		"shell_fragments":
			return "Shell Fragments"
		"glow_plankton":
			return "Glow Plankton"
		_:
			return resource_id

static func _discovery_name(discovery_id: String) -> String:
	match discovery_id:
		"thermal_vent":
			return "Thermal Vent"
		"wreck_signal_cache":
			return "Wreck Signal Cache"
		"lantern_fry":
			return "Lantern Fry"
		"gulper_eel":
			return "Gulper Eel"
		_:
			return discovery_id

static func _upgrade_name(upgrade_id: String, upgrade_definitions: Array[UpgradeDefinition]) -> String:
	for upgrade in upgrade_definitions:
		if upgrade.id == upgrade_id:
			return upgrade.display_name

	match upgrade_id:
		"predator_warning_1":
			return "Predator Warning I"
		"decoy_pulse_1":
			return "Decoy Pulse I"
		_:
			return upgrade_id
