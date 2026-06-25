class_name UpgradePurchase
extends RefCounted

static func missing_discovery(progression_state: ProgressionState, upgrade: UpgradeDefinition) -> String:
	if upgrade.required_discovery.is_empty():
		return ""

	return "" if progression_state.has_discovery(upgrade.required_discovery) else upgrade.required_discovery

static func purchase(progression_state: ProgressionState, upgrade: UpgradeDefinition) -> bool:
	if progression_state.has_upgrade(upgrade.id):
		return false
	if missing_discovery(progression_state, upgrade) != "":
		return false

	return progression_state.purchase_upgrade(upgrade.id, upgrade.resource_cost)
