class_name UpgradeMenuService
extends RefCounted

static func update_menu(host) -> void:
	host.upgrade_panel.visible = host.dive_session.result == host.DiveSessionScript.Result.EXTRACTED and host.surface_tab_index == host.SURFACE_TAB_UPGRADES
	if not host.upgrade_panel.visible:
		return

	var upgrade: UpgradeDefinition = host._selected_upgrade_definition()
	if upgrade == null:
		host.upgrade_menu_title_label.text = "Upgrade Bay"
		host.upgrade_menu_item_label.text = "No upgrades configured"
		host.upgrade_menu_cost_label.text = ""
		host.upgrade_menu_state_label.text = ""
		host.upgrade_menu_feedback_label.text = host.upgrade_menu_feedback
		return

	host.upgrade_menu_title_label.text = host._format_upgrade_menu_title(
		host.selected_upgrade_index + 1,
		host.upgrade_definitions.size()
	)
	host.upgrade_menu_item_label.text = "%s\n%s" % [upgrade.display_name, upgrade.description]
	host.upgrade_menu_cost_label.text = "Cost: %s" % host._format_upgrade_cost(upgrade.resource_cost)
	host.upgrade_menu_state_label.text = host._format_upgrade_state(upgrade)
	host.upgrade_menu_feedback_label.text = host._format_upgrade_panel_feedback(host.upgrade_menu_feedback)
