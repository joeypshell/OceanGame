extends RefCounted

class_name UpgradeCopyPresenter

static func format_upgrade_cost(cost: Dictionary, resource_names_by_id: Dictionary) -> String:
	if cost.is_empty():
		return "none"

	var parts: Array[String] = []
	for resource_id in cost.keys():
		parts.append("%s x%d" % [String(resource_names_by_id.get(resource_id, resource_id)), int(cost[resource_id])])

	return ", ".join(parts)


static func format_missing_resources(cost: Dictionary, owned_counts_by_id: Dictionary, resource_names_by_id: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		var missing: int = int(cost[resource_id]) - int(owned_counts_by_id.get(resource_id, 0))
		if missing > 0:
			parts.append(" %s x%d" % [String(resource_names_by_id.get(resource_id, resource_id)), missing])

	return " none" if parts.is_empty() else "\n" + "\n".join(parts)


static func format_missing_resources_inline(cost: Dictionary, owned_counts_by_id: Dictionary, resource_names_by_id: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		var missing: int = int(cost[resource_id]) - int(owned_counts_by_id.get(resource_id, 0))
		if missing > 0:
			parts.append("%s x%d" % [String(resource_names_by_id.get(resource_id, resource_id)), missing])

	return "none" if parts.is_empty() else ", ".join(parts)


static func format_material_need_list(materials: Array[String]) -> String:
	if materials.is_empty():
		return "materials"
	if materials.size() == 1:
		return materials[0]
	if materials.size() == 2:
		return "%s/%s" % [materials[0], materials[1]]
	return ", ".join(materials)


static func format_need_list(needs: Array[String]) -> String:
	if needs.is_empty():
		return "base"
	if needs.size() == 1:
		return needs[0]
	if needs.size() == 2:
		return "%s/%s" % [needs[0], needs[1]]
	return "%s/%s/%s" % [needs[0], needs[1], needs[2]]


static func format_standard_upgrade_state(
	effect_summary: String,
	is_owned: bool,
	missing_discovery_name: String,
	missing_upgrade_name: String,
	can_afford: bool,
	interact_label: String,
	missing_resources_inline: String
) -> String:
	if is_owned:
		return "State: Owned\n%s" % effect_summary
	if missing_discovery_name != "":
		return "State: Locked by scan\nScan: %s\n%s" % [
			missing_discovery_name,
			effect_summary,
		]
	if missing_upgrade_name != "":
		return "State: Locked by upgrade\nInstall: %s\n%s" % [
			missing_upgrade_name,
			effect_summary,
		]
	if can_afford:
		return "State: Available now\n%s: buy\n%s" % [
			interact_label,
			effect_summary,
		]
	return "State: Missing resources\nNeeds: %s\n%s" % [
		missing_resources_inline,
		effect_summary,
	]


static func format_resonance_key_upgrade_state(
	effect_summary: String,
	is_owned: bool,
	missing_upgrade_name: String,
	has_missing_discovery: bool,
	can_afford: bool,
	interact_label: String,
	missing_resources_inline: String
) -> String:
	if is_owned:
		return "State: Owned\n%s" % effect_summary
	if missing_upgrade_name != "":
		return "State: Locked by upgrade\nInstall: %s\n%s" % [
			missing_upgrade_name,
			effect_summary,
		]
	if has_missing_discovery:
		return "State: Needs route research\nRecover: East Shelf or Drop Echo\n%s" % effect_summary
	if can_afford:
		return "State: Available now\n%s: buy\n%s" % [
			interact_label,
			effect_summary,
		]
	return "State: Missing resources\nNeeds: %s\n%s" % [
		missing_resources_inline,
		effect_summary,
	]


static func format_salvage_cutter_upgrade_state(
	effect_summary: String,
	is_owned: bool,
	has_missing_discovery: bool,
	can_afford: bool,
	interact_label: String,
	missing_resources_inline: String
) -> String:
	if is_owned:
		return "State: Owned\n%s" % effect_summary
	if has_missing_discovery:
		return "State: Needs salvage data\nRecover: Salvage Data Cache\n%s" % effect_summary
	if can_afford:
		return "State: Available now\n%s: buy\n%s" % [
			interact_label,
			effect_summary,
		]
	return "State: Missing resources\nNeeds: %s\n%s" % [
		missing_resources_inline,
		effect_summary,
	]


static func format_upgrade_effect_summary(upgrade_id: String, owned_text: String) -> String:
	match upgrade_id:
		"oxygen_tank_1":
			return "Effect: +10 max O2."
		"pressure_seal_1":
			return "Effect: opens first pressure route."
		"signal_lens_1":
			return "Effect: material scan pulse."
		"echo_lens_1":
			return "Role: broad wreck echoes, not a locator."
		"resonance_key_1":
			return "Effect: opens East Shelf hatch only."
		"cargo_rack_1":
			return "Effect: +1 cargo slot."
		"water_filter_1":
			return "Effect: +1 Water reserve now."
		"predator_warning_1":
			return "Effect: earlier predator warning."
		"decoy_pulse_1":
			return "Effect: one decoy window per expedition."
		"salvage_cutter_1":
			return "Effect: opens the sealed Wide Reef salvage pocket."
	return "Effect: %s" % owned_text


static func format_upgrade_panel_feedback(feedback: String) -> String:
	if feedback.is_empty():
		return ""

	var compact := feedback
	compact = compact.replace("Deposited", "Banked")
	compact = compact.replace("resource(s) into the bank.", "resource(s).")
	compact = compact.replace("No upgrade ready yet; check missing requirements below.", "No upgrade ready yet.")
	compact = compact.replace("Ready upgrade:", "Ready:")
	compact = compact.replace("Purchased ", "Bought ")
	compact = compact.replace("\nBanked:", " | Banked:")

	var max_chars := 112
	if compact.length() > max_chars:
		compact = "%s..." % compact.substr(0, max_chars - 3)

	return compact


static func format_ready_upgrade_callout(ready_upgrade_names: Array[String]) -> String:
	if ready_upgrade_names.is_empty():
		return "No upgrade ready yet; check missing requirements below."
	return "Ready upgrade: %s." % ", ".join(ready_upgrade_names)
