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
