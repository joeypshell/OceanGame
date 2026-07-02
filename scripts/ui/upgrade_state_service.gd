class_name UpgradeStateService
extends RefCounted

const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const UpgradeCopyPresenterScript := preload("res://scripts/ui/upgrade_copy_presenter.gd")

static func format_upgrade_status(host) -> String:
	var owned_count := 0
	for upgrade in host.upgrade_definitions:
		if host.progression_state.has_upgrade(upgrade.id):
			owned_count += 1

	return "Upgrades: %d / %d installed" % [owned_count, host.upgrade_definitions.size()]

static func format_burst_thruster_prompt(host) -> String:
	if host.burst_thruster_cooldown_remaining > 0.0:
		return "Burst: %ds cooldown" % ceili(host.burst_thruster_cooldown_remaining)

	return "%s burst -%d" % [host._action_label("burst_thruster"), ceili(host.burst_thruster_oxygen_cost)]

static func format_decoy_pulse_prompt(host) -> String:
	if host.progression_state.has_upgrade(host.DECOY_PULSE_UPGRADE_ID):
		return "Decoy spent" if host.decoy_pulse_used_this_run else "%s: decoy ready" % host._action_label("decoy_pulse")
	if host.progression_state.has_discovery("gulper_eel"):
		return "Decoy locked"

	return ""

static func format_decoy_pulse_scan_feedback(host) -> String:
	if not host.progression_state.has_upgrade(host.DECOY_PULSE_UPGRADE_ID):
		return "Predator route warning refreshed. Decoy Pulse unavailable."
	if host.decoy_pulse_activated_this_scan:
		return "Decoy Pulse spent: predator distracted for %ds." % ceili(host.decoy_pulse_duration_seconds)
	if host.decoy_pulse_used_this_run:
		return "Predator route warning refreshed. Decoy Pulse already spent this expedition."

	return "Predator route warning refreshed. Decoy Pulse ready on re-scan."

static func format_surface_tabs(host) -> String:
	var parts: Array[String] = []
	for index in range(host.SURFACE_TAB_NAMES.size()):
		var tab_name: String = host.SURFACE_TAB_NAMES[index]
		if index == host.surface_tab_index:
			parts.append("[%s]" % tab_name)
		else:
			parts.append(tab_name)

	return "  ".join(parts)

static func format_upgrade_cost(host, cost: Dictionary) -> String:
	return UpgradeCopyPresenterScript.format_upgrade_cost(cost, ResourceSummaryServiceScript.resource_names_for_cost(cost, host.survival_state))

static func format_missing_resources(host, cost: Dictionary) -> String:
	return UpgradeCopyPresenterScript.format_missing_resources(cost, resource_counts_for_cost(host, cost), ResourceSummaryServiceScript.resource_names_for_cost(cost, host.survival_state))

static func resource_counts_for_cost(host, cost: Dictionary) -> Dictionary:
	var counts_by_id := {}
	for resource_id in cost.keys():
		counts_by_id[resource_id] = host.progression_state.resource_count(resource_id)
	return counts_by_id

static func format_upgrade_state(host, upgrade) -> String:
	var effect_summary := format_upgrade_effect_summary(upgrade)
	if upgrade.id == host.RESONANCE_KEY_UPGRADE_ID:
		var resonance_missing_upgrade: String = host._upgrade_missing_upgrade(host.RESONANCE_KEY_UPGRADE)
		return UpgradeCopyPresenterScript.format_resonance_key_upgrade_state(
			effect_summary,
			host.progression_state.has_upgrade(upgrade.id),
			format_upgrade_display_name(host, resonance_missing_upgrade) if resonance_missing_upgrade != "" else "",
			host._upgrade_missing_discovery(host.RESONANCE_KEY_UPGRADE) != "",
			host.progression_state.can_afford(host.RESONANCE_KEY_UPGRADE.resource_cost),
			host._action_label("interact").replace("/", " or "),
			format_missing_resources_inline(host, host.RESONANCE_KEY_UPGRADE.resource_cost)
		)
	if upgrade.id == host.SALVAGE_CUTTER_UPGRADE_ID:
		return UpgradeCopyPresenterScript.format_salvage_cutter_upgrade_state(
			effect_summary,
			host.progression_state.has_upgrade(upgrade.id),
			host._upgrade_missing_discovery(host.SALVAGE_CUTTER_UPGRADE) != "",
			host.progression_state.can_afford(host.SALVAGE_CUTTER_UPGRADE.resource_cost),
			host._action_label("interact").replace("/", " or "),
			format_missing_resources_inline(host, host.SALVAGE_CUTTER_UPGRADE.resource_cost)
		)

	var missing_discovery: String = host._upgrade_missing_discovery(upgrade)
	var missing_upgrade: String = host._upgrade_missing_upgrade(upgrade)
	return UpgradeCopyPresenterScript.format_standard_upgrade_state(
		effect_summary,
		host.progression_state.has_upgrade(upgrade.id),
		DiscoveryNamePresenterScript.display_name(host.progression_state, missing_discovery) if missing_discovery != "" else "",
		format_upgrade_display_name(host, missing_upgrade) if missing_upgrade != "" else "",
		host.progression_state.can_afford(upgrade.resource_cost),
		host._action_label("interact").replace("/", " or "),
		format_missing_resources_inline(host, upgrade.resource_cost)
	)

static func format_upgrade_effect_summary(upgrade) -> String:
	return UpgradeCopyPresenterScript.format_upgrade_effect_summary(upgrade.id, upgrade.owned_text)

static func format_upgrade_panel_feedback(feedback: String) -> String:
	return UpgradeCopyPresenterScript.format_upgrade_panel_feedback(feedback)

static func format_ready_upgrade_callout(host) -> String:
	var ready: Array[String] = []
	for upgrade in host.upgrade_definitions:
		if host.progression_state.has_upgrade(upgrade.id):
			continue
		if host._upgrade_missing_discovery(upgrade) != "":
			continue
		if host._upgrade_missing_upgrade(upgrade) != "":
			continue
		if host.progression_state.can_afford(upgrade.resource_cost):
			ready.append(upgrade.display_name)

	return UpgradeCopyPresenterScript.format_ready_upgrade_callout(ready)

static func format_upgrade_progress_callout(host) -> String:
	for upgrade in host.upgrade_definitions:
		if host.progression_state.has_upgrade(upgrade.id):
			continue

		var missing_discovery: String = host._upgrade_missing_discovery(upgrade)
		if missing_discovery != "":
			return "Upgrade progress: %s %s to unlock %s." % [
				format_upgrade_prerequisite_action(missing_discovery),
				DiscoveryNamePresenterScript.display_name(host.progression_state, missing_discovery),
				upgrade.display_name,
			]

		var missing_upgrade: String = host._upgrade_missing_upgrade(upgrade)
		if missing_upgrade != "":
			return "Upgrade progress: buy %s before %s." % [
				format_upgrade_display_name(host, missing_upgrade),
				upgrade.display_name,
			]

		var missing_resources := format_missing_resources_inline(host, upgrade.resource_cost)
		if missing_resources == "none":
			return "Upgrade progress: %s ready to buy." % upgrade.display_name

		return "Upgrade progress: %s still needs %s." % [
			upgrade.display_name,
			missing_resources,
		]

	return "Upgrade progress: all current upgrades installed."

static func format_missing_resources_inline(host, cost: Dictionary) -> String:
	return UpgradeCopyPresenterScript.format_missing_resources_inline(cost, resource_counts_for_cost(host, cost), ResourceSummaryServiceScript.resource_names_for_cost(cost, host.survival_state))

static func format_upgrade_display_name(host, upgrade_id: String) -> String:
	for upgrade in host.upgrade_definitions:
		if upgrade.id == upgrade_id:
			return upgrade.display_name

	match upgrade_id:
		host.PREDATOR_WARNING_UPGRADE_ID:
			return "Predator Warning I"
		host.DECOY_PULSE_UPGRADE_ID:
			return "Decoy Pulse I"
		host.RESONANCE_KEY_UPGRADE_ID:
			return "Resonance Key I"
		host.WATER_FILTER_UPGRADE_ID:
			return "Water Filter I"
		host.SALVAGE_CUTTER_UPGRADE_ID:
			return "Salvage Cutter I"
		_:
			return upgrade_id

static func format_upgrade_prerequisite_action(discovery_id: String) -> String:
	if discovery_id == "salvage_data_cache":
		return "recover"

	return "scan"
