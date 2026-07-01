class_name ResourceSummaryService
extends RefCounted

const InventorySummaryPresenterScript := preload("res://scripts/ui/inventory_summary_presenter.gd")
const ResourcePresenterScript := preload("res://scripts/ui/resource_presenter.gd")

static func short_resource_name(resource_id: String, survival_state) -> String:
	return ResourcePresenterScript.short_resource_name(
		resource_id,
		survival_state.is_supply_id(resource_id),
		survival_state.short_name_for_supply(resource_id)
	)

static func resource_category_label(resource_id: String, survival_state, resource_category_labels: Dictionary) -> String:
	return ResourcePresenterScript.resource_category_label(
		resource_id,
		survival_state.is_supply_id(resource_id),
		survival_state.category_name_for_supply(resource_id),
		resource_category_labels
	)

static func display_name_for_resource(resource_id: String, survival_state) -> String:
	return ResourcePresenterScript.display_name_for_resource(
		resource_id,
		survival_state.is_supply_id(resource_id),
		survival_state.display_name_for_supply(resource_id)
	)

static func category_labels_for_ids(resource_ids: Array[String], survival_state, resource_category_labels: Dictionary) -> Dictionary:
	var labels := {}
	for resource_id in resource_ids:
		labels[resource_id] = resource_category_label(resource_id, survival_state, resource_category_labels)
	return labels

static func display_names_for_ids(resource_ids: Array[String], survival_state) -> Dictionary:
	var names := {}
	for resource_id in resource_ids:
		names[resource_id] = display_name_for_resource(resource_id, survival_state)
	return names

static func short_names_for_ids(resource_ids: Array[String], survival_state) -> Dictionary:
	var names := {}
	for resource_id in resource_ids:
		names[resource_id] = short_resource_name(resource_id, survival_state)
	return names

static func format_resource_counts(resource_ids: Array[String], survival_state, resource_category_labels: Dictionary) -> String:
	return InventorySummaryPresenterScript.format_item_counts(
		resource_ids,
		category_labels_for_ids(resource_ids, survival_state, resource_category_labels),
		display_names_for_ids(resource_ids, survival_state)
	)

static func format_survival_supply_counts(supply_ids: Array[String], survival_state, resource_category_labels: Dictionary) -> String:
	return InventorySummaryPresenterScript.format_item_counts(
		supply_ids,
		category_labels_for_ids(supply_ids, survival_state, resource_category_labels),
		display_names_for_ids(supply_ids, survival_state)
	)

static func format_survival_banking_line(banked_survival_supplies: Array[String], survival_state, resource_category_labels: Dictionary) -> String:
	return InventorySummaryPresenterScript.format_survival_banking_line(
		banked_survival_supplies,
		format_survival_supply_counts(banked_survival_supplies, survival_state, resource_category_labels)
	)

static func format_cargo_counts_inline(resource_ids: Array[String], survival_state) -> String:
	return InventorySummaryPresenterScript.format_cargo_counts_inline(
		resource_ids,
		short_names_for_ids(resource_ids, survival_state)
	)

static func format_banked_resources(banked_resources: Dictionary, survival_state, resource_category_labels: Dictionary) -> String:
	var resource_ids: Array[String] = []
	for resource_id in banked_resources.keys():
		resource_ids.append(String(resource_id))
	return InventorySummaryPresenterScript.format_banked_resources(
		banked_resources,
		category_labels_for_ids(resource_ids, survival_state, resource_category_labels),
		display_names_for_ids(resource_ids, survival_state)
	)

static func resource_names_for_cost(cost: Dictionary, survival_state) -> Dictionary:
	var names_by_id := {}
	for resource_id in cost.keys():
		names_by_id[resource_id] = display_name_for_resource(resource_id, survival_state)
	return names_by_id

static func format_supply_names_inline(supply_ids: Array[String], survival_state) -> String:
	return InventorySummaryPresenterScript.format_supply_names_inline(
		supply_ids,
		short_names_for_ids(supply_ids, survival_state)
	)
