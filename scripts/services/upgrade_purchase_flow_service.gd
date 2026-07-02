class_name UpgradePurchaseFlowService
extends RefCounted

const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const SurfaceRunSummaryServiceScript := preload("res://scripts/ui/surface_run_summary_service.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")

static func try_purchase_selected_upgrade(host) -> void:
	if host.has_method("_ensure_active_hud_references"):
		host._ensure_active_hud_references()
	var upgrade = host._selected_upgrade_definition()
	if upgrade == null:
		return

	if host.progression_state.has_upgrade(upgrade.id):
		host.upgrade_menu_feedback = "%s is already installed." % upgrade.display_name
		host.status_label.text = host.upgrade_menu_feedback
		host._update_hud()
		return

	if UpgradePurchaseScript.missing_discovery(host.progression_state, upgrade) != "":
		if upgrade.id == host.SALVAGE_CUTTER_UPGRADE_ID:
			host.upgrade_menu_feedback = "Missing evidence: Salvage Data Cache. %s" % upgrade.locked_reason
			host.status_label.text = "%s needs recovered salvage data." % upgrade.display_name
			host._update_hud()
			return
		host.upgrade_menu_feedback = "Missing discovery: %s. %s" % [
			DiscoveryNamePresenterScript.display_name(host.progression_state, upgrade.required_discovery),
			upgrade.locked_reason
		]
		host.status_label.text = "%s is locked by missing scan data." % upgrade.display_name
		host._update_hud()
		return

	if UpgradePurchaseScript.missing_upgrade(host.progression_state, upgrade) != "":
		host.upgrade_menu_feedback = "Missing upgrade: %s. %s" % [
			UpgradeStateServiceScript.format_upgrade_display_name(host, upgrade.required_upgrade),
			upgrade.locked_reason
		]
		host.status_label.text = "%s is locked by an upgrade prerequisite." % upgrade.display_name
		host._update_hud()
		return

	if UpgradePurchaseScript.purchase(host.progression_state, upgrade):
		host._apply_upgrade_effect(upgrade.effect_id)
		host._refresh_carried_tomorrow_intention()
		host.upgrade_menu_feedback = "Purchased %s. Next: %s" % [
			upgrade.display_name,
			SurfaceRunSummaryServiceScript.format_current_tomorrow_intention(host),
		]
		SaveServiceScript.save_progression(host.PROGRESSION_SAVE_PATH, host.progression_state, host.survival_state)
		host.status_label.text = "Purchased %s." % upgrade.display_name
	else:
		var missing_resources := UpgradeStateServiceScript.format_missing_resources_inline(host, upgrade.resource_cost)
		host.upgrade_menu_feedback = "Missing %s. Next: bank it for %s." % [
			missing_resources,
			upgrade.display_name,
		]
		host.status_label.text = "%s needs more banked resources." % upgrade.display_name

	host._update_hud()
