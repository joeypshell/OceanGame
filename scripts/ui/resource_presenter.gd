class_name ResourcePresenter
extends RefCounted

static func format_resource_upgrade_need(is_supply: bool, has_oxygen_tank: bool, needed_for_oxygen_tank: int) -> String:
	if is_supply:
		return "Banks into base needs for tonight, not the upgrade-material bank."
	if has_oxygen_tank:
		return "Oxygen Tank I is installed; future upgrades may still use it."
	if needed_for_oxygen_tank > 0:
		return "Need %d more for Oxygen Tank I." % needed_for_oxygen_tank

	return "Enough banked for this Oxygen Tank I material."

static func resource_role_summary(resource_id: String, is_supply: bool, category_label: String, supply_banking_role: String) -> String:
	if is_supply:
		return "%s survival supply; %s" % [
			category_label,
			supply_banking_role,
		]
	if category_label == "Building":
		return "Building material; banks for repairs, crafting, and starter upgrades."
	if category_label == "Research":
		return "Research material; banks for oxygen, scanner, and pressure upgrades."
	return "%s material; banks for upgrades." % category_label

static func resource_collection_guidance(is_supply: bool, category_label: String, supply_banking_role: String) -> String:
	if is_supply:
		return "Collect to %s." % supply_banking_role
	if category_label == "Building":
		return "Collect as building material for repairs/upgrades."
	if category_label == "Research":
		return "Collect as research material for oxygen/scanner upgrades."
	return "Collect as %s material." % category_label.to_lower()

static func resource_pickup_feedback(
	resource_id: String,
	current_cargo_count: int,
	cargo_limit: int,
	is_supply: bool,
	category_label: String
) -> String:
	if is_supply:
		return "Cargo %d/%d; ship banks %s reserve" % [
			current_cargo_count,
			cargo_limit,
			category_label,
		]
	if category_label == "Building":
		return "Cargo %d/%d; ship banks building mats" % [
			current_cargo_count,
			cargo_limit,
		]
	if category_label == "Research":
		return "Cargo %d/%d; ship banks research mats" % [
			current_cargo_count,
			cargo_limit,
		]
	return "Cargo %d/%d; ship banks %s mats" % [
		current_cargo_count,
		cargo_limit,
		category_label.to_lower(),
	]

static func resource_visual_role_family(is_supply: bool, category_label: String) -> String:
	if is_supply:
		return "supply"
	if category_label == "Building":
		return "building"
	return "research"

static func resource_role_accent_color(resource_id: String) -> Color:
	match resource_id:
		"food_supply":
			return Color(1.0, 0.32, 0.08, 0.95)
		"water_supply":
			return Color(0.22, 0.90, 1.0, 0.95)
		"power_supply":
			return Color(1.0, 0.90, 0.16, 0.95)
		"driftwood":
			return Color(0.82, 0.54, 0.26, 0.95)
		"scrap_metal":
			return Color(0.78, 0.86, 0.90, 0.95)
		"quartz_glass":
			return Color(0.55, 0.92, 1.0, 0.95)
		"kelp_fiber":
			return Color(0.34, 1.0, 0.45, 0.95)
		"shell_fragments":
			return Color(1.0, 0.78, 0.58, 0.95)
		"glow_plankton":
			return Color(0.62, 0.50, 1.0, 0.95)
		_:
			return Color(0.92, 1.0, 1.0, 0.95)

static func supply_banking_role(resource_id: String) -> String:
	match resource_id:
		"food_supply":
			return "fill tonight's Food reserve"
		"water_supply":
			return "fill tonight's Water reserve"
		"power_supply":
			return "fill tonight's Power reserve"
		_:
			return "fill a base need"

static func format_depth_band(depth_band: String) -> String:
	match depth_band:
		"shallow":
			return "Shallow"
		"midwater":
			return "Midwater"
		"deep":
			return "Deep"
		_:
			return depth_band

static func short_resource_name(resource_id: String, is_supply: bool, supply_short_name: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp"
		"shell_fragments":
			return "Shell"
		"glow_plankton":
			return "Glow"
		"scrap_metal":
			return "Scrap"
		"driftwood":
			return "Wood"
		"quartz_glass":
			return "Glass"
		_:
			if is_supply:
				return supply_short_name
			return resource_id

static func resource_category_label(resource_id: String, is_supply: bool, supply_category_name: String, resource_category_labels: Dictionary) -> String:
	if is_supply:
		return supply_category_name
	return String(resource_category_labels.get(resource_id, "Resource"))

static func display_name_for_resource(resource_id: String, is_supply: bool, supply_display_name: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp Fiber"
		"shell_fragments":
			return "Shell Fragments"
		"glow_plankton":
			return "Glow Plankton"
		"scrap_metal":
			return "Scrap Metal"
		"driftwood":
			return "Driftwood"
		"quartz_glass":
			return "Quartz Glass"
		_:
			if is_supply:
				return supply_display_name
			return resource_id
