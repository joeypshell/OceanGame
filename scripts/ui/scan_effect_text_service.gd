class_name ScanEffectTextService
extends RefCounted

const ResourcePresenterScript := preload("res://scripts/ui/resource_presenter.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func scan_target_gameplay_fact(host, target: Node) -> String:
	if target is ResourcePickup:
		return "Depth: %s. Role: %s. %s" % [
			format_depth_band((target as ResourcePickup).definition.depth_band),
			resource_role_summary(host, (target as ResourcePickup).definition.id),
			resource_upgrade_need(host, (target as ResourcePickup).definition.id)
		]

	return String(target.get("gameplay_fact"))

static func repeat_scan_effect_text(host, target: Node) -> String:
	return ScanFeedbackPresenterScript.format_repeat_scan_effect_text(
		ScanTargetResolverScript.target_id(target),
		target is ResourcePickup,
		(target as ResourcePickup).definition.display_name if target is ResourcePickup else "",
		wreck_cache_repeat_hint(host),
		UpgradeStateServiceScript.format_decoy_pulse_scan_feedback(host)
	)

static func wreck_cache_repeat_hint(host) -> String:
	return ScanFeedbackPresenterScript.format_wreck_cache_repeat_hint(
		host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID),
		host.progression_state.has_upgrade(host.SIGNAL_LENS_UPGRADE_ID)
	)

static func signal_lens_pulse_text(host, target: Node, match_target: ResourcePickup = null) -> String:
	return ScanFeedbackPresenterScript.format_signal_lens_pulse_text(
		host.progression_state.has_upgrade(host.SIGNAL_LENS_UPGRADE_ID),
		target is ResourcePickup,
		match_target != null,
		direction_to(host, match_target.global_position) if match_target != null else "",
		(target as ResourcePickup).definition.display_name if target is ResourcePickup else ""
	)

static func direction_to(host, target_position: Vector2) -> String:
	return ScanFeedbackPresenterScript.format_direction_to(host.player.global_position, target_position)

static func first_scan_guidance(host, target: Node) -> String:
	return ScanFeedbackPresenterScript.format_first_scan_guidance(
		ScanTargetResolverScript.target_id(target),
		target is ResourcePickup,
		resource_collection_guidance(host, (target as ResourcePickup).definition.id) if target is ResourcePickup else "",
		host.dive_session.current_cargo.size(),
		host.dive_session.cargo_limit,
		host.progression_state.has_upgrade(host.PRESSURE_SEAL_UPGRADE_ID)
	)

static func resource_upgrade_need(host, resource_id: String) -> String:
	var needed: int = maxi(0, int(host._oxygen_tank_cost().get(resource_id, 0)) - host.progression_state.resource_count(resource_id))
	return ResourcePresenterScript.format_resource_upgrade_need(
		host.survival_state.is_supply_id(resource_id),
		host.progression_state.has_upgrade(host.OXYGEN_TANK_UPGRADE_ID),
		needed
	)

static func resource_role_summary(host, resource_id: String) -> String:
	return ResourcePresenterScript.resource_role_summary(
		resource_id,
		host.survival_state.is_supply_id(resource_id),
		ResourceSummaryServiceScript.resource_category_label(resource_id, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		ResourcePresenterScript.supply_banking_role(resource_id)
	)

static func resource_collection_guidance(host, resource_id: String) -> String:
	return ResourcePresenterScript.resource_collection_guidance(
		host.survival_state.is_supply_id(resource_id),
		ResourceSummaryServiceScript.resource_category_label(resource_id, host.survival_state, host.RESOURCE_CATEGORY_LABELS),
		ResourcePresenterScript.supply_banking_role(resource_id)
	)

static func format_depth_band(depth_band: String) -> String:
	return ResourcePresenterScript.format_depth_band(depth_band)
