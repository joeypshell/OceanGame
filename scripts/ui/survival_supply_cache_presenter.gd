class_name SurvivalSupplyCachePresenter
extends RefCounted

static func format_status_text(needs_are_stable: bool, needed_supply_short_name: String) -> String:
	if needs_are_stable:
		return "Emergency cache: base stable backup; uses cargo."
	return "Emergency cache: %s is lowest; uses cargo." % needed_supply_short_name

static func format_prompt(needs_are_stable: bool, needed_supply_short_name: String, interact_label: String) -> String:
	if needs_are_stable:
		return "Emergency cache: %s backup supply" % interact_label
	return "Emergency cache: %s recover %s" % [
		interact_label,
		needed_supply_short_name,
	]

static func format_full_status(needs_are_stable: bool, needed_supply_short_name: String) -> String:
	if needs_are_stable:
		return "Cargo full: backup cache needs a slot."
	return "Cargo full: %s cache needs a slot." % needed_supply_short_name

static func format_recovered_status(supply_display_name: String, supply_short_name: String) -> String:
	return "Recovered %s for %s. Ship banks it tonight." % [
		supply_display_name,
		supply_short_name,
	]
