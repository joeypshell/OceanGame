class_name ResourcePickupPresentationService
extends RefCounted

const ResourcePresenterScript := preload("res://scripts/ui/resource_presenter.gd")
const ResourceRoleVisualPresenterScript := preload("res://scripts/ui/resource_role_visual_presenter.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")

static func resource_pickup_feedback(host, resource_id: String) -> String:
	return ResourcePresenterScript.resource_pickup_feedback(
		resource_id,
		host.dive_session.current_cargo.size(),
		host.dive_session.cargo_limit,
		host.survival_state.is_supply_id(resource_id),
		ResourceSummaryServiceScript.resource_category_label(resource_id, host.survival_state, host.RESOURCE_CATEGORY_LABELS)
	)

static func ensure_resource_role_visuals(host) -> void:
	var pickup_root := host.get_node_or_null("ResourcePickups")
	if pickup_root == null:
		return
	for pickup_node in pickup_root.get_children():
		var pickup := pickup_node as ResourcePickup
		if pickup == null or pickup.definition == null:
			continue
		ensure_resource_role_visual(host, pickup)

static func ensure_resource_role_visual(host, pickup: ResourcePickup) -> void:
	ResourceRoleVisualPresenterScript.ensure_resource_role_visual(
		pickup,
		pickup.definition.id,
		resource_visual_role_family(host, pickup.definition.id),
		resource_role_accent_color(pickup.definition.id)
	)

static func resource_visual_role_family(host, resource_id: String) -> String:
	return ResourcePresenterScript.resource_visual_role_family(
		host.survival_state.is_supply_id(resource_id),
		ResourceSummaryServiceScript.resource_category_label(resource_id, host.survival_state, host.RESOURCE_CATEGORY_LABELS)
	)

static func resource_role_accent_color(resource_id: String) -> Color:
	return ResourcePresenterScript.resource_role_accent_color(resource_id)
