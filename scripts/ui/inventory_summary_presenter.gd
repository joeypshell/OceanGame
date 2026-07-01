class_name InventorySummaryPresenter
extends RefCounted

static func format_item_counts(item_ids: Array[String], category_labels_by_id: Dictionary, display_names_by_id: Dictionary) -> String:
	if item_ids.is_empty():
		return ""

	var counts := {}
	for item_id in item_ids:
		counts[item_id] = int(counts.get(item_id, 0)) + 1

	var parts: Array[String] = []
	for item_id in counts.keys():
		parts.append(" %s: %s x%d" % [
			String(category_labels_by_id.get(item_id, "Resource")),
			String(display_names_by_id.get(item_id, item_id)),
			int(counts[item_id]),
		])

	return "\n" + "\n".join(parts)

static func format_survival_banking_line(banked_survival_supplies: Array[String], formatted_supply_counts: String) -> String:
	if banked_survival_supplies.is_empty():
		return "Survival needs banked: none."

	return "Survival needs banked:%s" % formatted_supply_counts

static func format_cargo_counts_inline(resource_ids: Array[String], short_names_by_id: Dictionary) -> String:
	if resource_ids.is_empty():
		return ""

	var counts := {}
	for resource_id in resource_ids:
		counts[resource_id] = int(counts.get(resource_id, 0)) + 1

	var parts: Array[String] = []
	for resource_id in counts.keys():
		parts.append("%s x%d" % [String(short_names_by_id.get(resource_id, resource_id)), int(counts[resource_id])])

	return " - " + ", ".join(parts)

static func format_banked_resources(banked_resources: Dictionary, category_labels_by_id: Dictionary, display_names_by_id: Dictionary) -> String:
	if banked_resources.is_empty():
		return " none"

	var parts: Array[String] = []
	for resource_id in banked_resources.keys():
		parts.append(" %s: %s x%d" % [
			String(category_labels_by_id.get(resource_id, "Resource")),
			String(display_names_by_id.get(resource_id, resource_id)),
			int(banked_resources.get(resource_id, 0)),
		])

	return "\n" + "\n".join(parts)

static func format_extraction_banking_line(extracted_count: int, formatted_resource_counts: String, has_completed_scans: bool) -> String:
	if extracted_count > 0:
		return "Upgrade/build materials banked: %d.%s" % [
			extracted_count,
			formatted_resource_counts,
		]
	if has_completed_scans:
		return "Banked 0 resources. Useful dive: scan data came home."

	return "Banked 0 resources. No cargo or new scans came home."

static func format_supply_names_inline(supply_ids: Array[String], short_names_by_id: Dictionary) -> String:
	if supply_ids.is_empty():
		return "supply"

	var names: Array[String] = []
	for supply_id in supply_ids:
		var name := String(short_names_by_id.get(supply_id, supply_id))
		if not names.has(name):
			names.append(name)
	if names.size() == 1:
		return names[0]
	if names.size() == 2:
		return "%s/%s" % [names[0], names[1]]
	return "%s/%s/%s" % [names[0], names[1], names[2]]
