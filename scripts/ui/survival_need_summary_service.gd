class_name SurvivalNeedSummaryService
extends RefCounted

const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const UpgradeCopyPresenterScript := preload("res://scripts/ui/upgrade_copy_presenter.gd")

static func format_starter_resource_target(progression_state, survival_state, water_filter_upgrade_id: String, water_filter_resource_cost: Dictionary) -> String:
	if progression_state.has_upgrade(water_filter_upgrade_id):
		return ""

	var missing_materials: Array[String] = []
	for resource_key in water_filter_resource_cost.keys():
		var resource_id := String(resource_key)
		var missing: int = int(water_filter_resource_cost[resource_key]) - progression_state.resource_count(resource_id)
		if missing > 0:
			missing_materials.append(ResourceSummaryServiceScript.display_name_for_resource(resource_id, survival_state))

	if missing_materials.is_empty():
		return ""

	return "Shell Reef pockets: %s for Water Filter I." % format_material_need_list(missing_materials)

static func base_need_names_at_or_below(survival_state, threshold: int) -> Array[String]:
	var needs: Array[String] = []
	if survival_state.food <= threshold:
		needs.append("Food")
	if survival_state.water <= threshold:
		needs.append("Water")
	if survival_state.power <= threshold:
		needs.append("Power")
	return needs

static func format_material_need_list(materials: Array[String]) -> String:
	return UpgradeCopyPresenterScript.format_material_need_list(materials)

static func format_need_list(needs: Array[String]) -> String:
	return UpgradeCopyPresenterScript.format_need_list(needs)
