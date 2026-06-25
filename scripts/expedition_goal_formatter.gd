class_name ExpeditionGoalFormatter
extends RefCounted

const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")

static func format_goal(progression_state: ProgressionState, upgrade_definitions: Array[UpgradeDefinition]) -> String:
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

		var missing_resources := _format_missing_resources(progression_state, upgrade.resource_cost)
		if missing_resources == "none":
			return "Goal: buy %s in the upgrade bay after this dive." % upgrade.display_name

		return "Goal: bank %s for %s." % [
			missing_resources,
			upgrade.display_name,
		]

	return "Goal: choose a route, fill cargo, and return safely."

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
		_:
			return discovery_id
