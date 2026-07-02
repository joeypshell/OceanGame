class_name HudReferenceService
extends RefCounted

static func ensure_active_hud_references(host) -> void:
	if host.active_stats_panel == null:
		host.active_stats_panel = host.get_node_or_null("HUD/ActiveStatsPanel") as Panel
	if host.cargo_panel == null:
		host.cargo_panel = host.get_node_or_null("HUD/CargoPanel") as Panel
	if host.daylight_panel == null:
		host.daylight_panel = host.get_node_or_null("HUD/DaylightPanel") as Panel
	if host.daylight_label == null:
		host.daylight_label = host.get_node_or_null("HUD/DaylightLabel") as Label
	if host.daylight_bar_back == null:
		host.daylight_bar_back = host.get_node_or_null("HUD/DaylightBarBack") as ColorRect
	if host.daylight_bar_fill == null:
		host.daylight_bar_fill = host.get_node_or_null("HUD/DaylightBarFill") as ColorRect
	if host.daylight_sun_icon == null:
		host.daylight_sun_icon = host.get_node_or_null("HUD/DaylightSunIcon") as Polygon2D
	if host.daylight_moon_icon == null:
		host.daylight_moon_icon = host.get_node_or_null("HUD/DaylightMoonIcon") as Polygon2D
	if host.survival_needs_panel == null:
		host.survival_needs_panel = host.get_node_or_null("HUD/SurvivalNeedsPanel") as Panel
	if host.dive_info_panel == null:
		host.dive_info_panel = host.get_node_or_null("HUD/DiveInfoPanel") as Panel
	if host.objective_title_label == null:
		host.objective_title_label = host.get_node_or_null("HUD/DiveInfoPanel/ObjectiveTitle") as Label
	if host.objective_line_label == null:
		host.objective_line_label = host.get_node_or_null("HUD/DiveInfoPanel/ObjectiveLine") as Label
	if host.scan_card_panel == null:
		host.scan_card_panel = host.get_node_or_null("HUD/ScanCardPanel") as Panel
	if host.scan_reticle_root == null:
		host.scan_reticle_root = host.get_node_or_null("HUD/ScanReticleRoot") as Node2D
	if host.tool_belt_panel == null:
		host.tool_belt_panel = host.get_node_or_null("HUD/ToolBeltPanel") as Panel
	if host.minimap_panel == null:
		host.minimap_panel = host.get_node_or_null("HUD/MinimapPanel") as Panel
	if host.oxygen_warning_panel == null:
		host.oxygen_warning_panel = host.get_node_or_null("HUD/OxygenWarningPanel") as Panel
	if host.oxygen_label == null:
		host.oxygen_label = host.get_node_or_null("HUD/Oxygen") as Label
	if host.oxygen_icon == null:
		host.oxygen_icon = host.get_node_or_null("HUD/OxygenIcon") as Polygon2D
	if host.oxygen_bar_back == null:
		host.oxygen_bar_back = host.get_node_or_null("HUD/OxygenBarBack") as ColorRect
	if host.oxygen_bar_fill == null:
		host.oxygen_bar_fill = host.get_node_or_null("HUD/OxygenBarFill") as ColorRect
	if host.health_icon == null:
		host.health_icon = host.get_node_or_null("HUD/HealthIcon") as Polygon2D
	if host.health_label == null:
		host.health_label = host.get_node_or_null("HUD/Health") as Label
	if host.health_bar_back == null:
		host.health_bar_back = host.get_node_or_null("HUD/HealthBarBack") as ColorRect
	if host.health_bar_fill == null:
		host.health_bar_fill = host.get_node_or_null("HUD/HealthBarFill") as ColorRect
	if host.depth_label == null:
		host.depth_label = host.get_node_or_null("HUD/Depth") as Label
	if host.depth_icon == null:
		host.depth_icon = host.get_node_or_null("HUD/DepthIcon") as Polygon2D
	if host.depth_bar_back == null:
		host.depth_bar_back = host.get_node_or_null("HUD/DepthBarBack") as ColorRect
	if host.depth_bar_fill == null:
		host.depth_bar_fill = host.get_node_or_null("HUD/DepthBarFill") as ColorRect
	if host.base_direction_label == null:
		host.base_direction_label = host.get_node_or_null("HUD/BaseDirection") as Label
	if host.cargo_label == null:
		host.cargo_label = host.get_node_or_null("HUD/Cargo") as Label
	if host.bank_label == null:
		host.bank_label = host.get_node_or_null("HUD/BankedResources") as Label
	if host.upgrade_label == null:
		host.upgrade_label = host.get_node_or_null("HUD/Upgrade") as Label
	if host.discoveries_label == null:
		host.discoveries_label = host.get_node_or_null("HUD/Discoveries") as Label
	if host.scan_target_label == null:
		host.scan_target_label = host.get_node_or_null("HUD/ScanTarget") as Label
	if host.scan_card_title_label == null:
		host.scan_card_title_label = host.get_node_or_null("HUD/ScanCardTitle") as Label
	if host.scan_card_meta_label == null:
		host.scan_card_meta_label = host.get_node_or_null("HUD/ScanCardMeta") as Label
	if host.scan_card_prompt_label == null:
		host.scan_card_prompt_label = host.get_node_or_null("HUD/ScanCardPrompt") as Label
	if host.prompt_label == null:
		host.prompt_label = host.get_node_or_null("HUD/ExtractionPrompt") as Label
	if host.status_label == null:
		host.status_label = host.get_node_or_null("HUD/Status") as Label
	if host.food_need_label == null:
		host.food_need_label = host.get_node_or_null("HUD/FoodNeed") as Label
	if host.water_need_label == null:
		host.water_need_label = host.get_node_or_null("HUD/WaterNeed") as Label
	if host.power_need_label == null:
		host.power_need_label = host.get_node_or_null("HUD/PowerNeed") as Label
	if host.food_need_icon == null:
		host.food_need_icon = host.get_node_or_null("HUD/FoodNeedIcon") as Polygon2D
	if host.water_need_icon == null:
		host.water_need_icon = host.get_node_or_null("HUD/WaterNeedIcon") as Polygon2D
	if host.power_need_icon == null:
		host.power_need_icon = host.get_node_or_null("HUD/PowerNeedIcon") as Polygon2D
	if host.food_need_bar_back == null:
		host.food_need_bar_back = host.get_node_or_null("HUD/FoodNeedBarBack") as ColorRect
	if host.water_need_bar_back == null:
		host.water_need_bar_back = host.get_node_or_null("HUD/WaterNeedBarBack") as ColorRect
	if host.power_need_bar_back == null:
		host.power_need_bar_back = host.get_node_or_null("HUD/PowerNeedBarBack") as ColorRect
	if host.food_need_bar_fill == null:
		host.food_need_bar_fill = host.get_node_or_null("HUD/FoodNeedBarFill") as ColorRect
	if host.water_need_bar_fill == null:
		host.water_need_bar_fill = host.get_node_or_null("HUD/WaterNeedBarFill") as ColorRect
	if host.power_need_bar_fill == null:
		host.power_need_bar_fill = host.get_node_or_null("HUD/PowerNeedBarFill") as ColorRect
	if host.depth_rail_line == null:
		host.depth_rail_line = host.get_node_or_null("HUD/DepthRailLine") as ColorRect
	if host.depth_rail_marker == null:
		host.depth_rail_marker = host.get_node_or_null("HUD/DepthRailMarker") as Polygon2D
	if host.depth_rail_labels.is_empty():
		var depth_labels: Array[Label] = [
			host.get_node_or_null("HUD/DepthRailLabel0") as Label,
			host.get_node_or_null("HUD/DepthRailLabel50") as Label,
			host.get_node_or_null("HUD/DepthRailLabel100") as Label,
		]
		host.depth_rail_labels = depth_labels
	if host.cargo_slots_root == null:
		host.cargo_slots_root = host.get_node_or_null("HUD/CargoSlots") as Node2D
	if host.cargo_slot_nodes.is_empty():
		var cargo_slots: Array[ColorRect] = [
			host.get_node_or_null("HUD/CargoSlots/Slot1") as ColorRect,
			host.get_node_or_null("HUD/CargoSlots/Slot2") as ColorRect,
			host.get_node_or_null("HUD/CargoSlots/Slot3") as ColorRect,
			host.get_node_or_null("HUD/CargoSlots/Slot4") as ColorRect,
		]
		host.cargo_slot_nodes = cargo_slots
	if host.cargo_slot_icon_nodes.is_empty():
		var cargo_icons: Array[Polygon2D] = [
			host.get_node_or_null("HUD/CargoSlots/Icon1") as Polygon2D,
			host.get_node_or_null("HUD/CargoSlots/Icon2") as Polygon2D,
			host.get_node_or_null("HUD/CargoSlots/Icon3") as Polygon2D,
			host.get_node_or_null("HUD/CargoSlots/Icon4") as Polygon2D,
		]
		host.cargo_slot_icon_nodes = cargo_icons
	if host.oxygen_warning_label == null:
		host.oxygen_warning_label = host.get_node_or_null("HUD/OxygenWarningPanel/OxygenWarning") as Label
	if host.oxygen_warning_icon == null:
		host.oxygen_warning_icon = host.get_node_or_null("HUD/OxygenWarningPanel/OxygenWarningIcon") as Polygon2D
	if host.tool_slot_nodes.is_empty():
		var tool_slots: Array[ColorRect] = [
			host.get_node_or_null("HUD/ToolBeltPanel/ToolSlot1") as ColorRect,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolSlot2") as ColorRect,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolSlot3") as ColorRect,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolSlot4") as ColorRect,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolSlot5") as ColorRect,
		]
		host.tool_slot_nodes = tool_slots
	if host.tool_icon_nodes.is_empty():
		var tool_icons: Array[Polygon2D] = [
			host.get_node_or_null("HUD/ToolBeltPanel/ToolIcon1") as Polygon2D,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolIcon2") as Polygon2D,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolIcon3") as Polygon2D,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolIcon4") as Polygon2D,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolIcon5") as Polygon2D,
		]
		host.tool_icon_nodes = tool_icons
	if host.tool_key_label_nodes.is_empty():
		var tool_keys: Array[Label] = [
			host.get_node_or_null("HUD/ToolBeltPanel/ToolKey1") as Label,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolKey2") as Label,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolKey3") as Label,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolKey4") as Label,
			host.get_node_or_null("HUD/ToolBeltPanel/ToolKey5") as Label,
		]
		host.tool_key_label_nodes = tool_keys
	if host.minimap_path == null:
		host.minimap_path = host.get_node_or_null("HUD/MinimapPanel/MinimapPath") as Line2D
	if host.minimap_player_marker == null:
		host.minimap_player_marker = host.get_node_or_null("HUD/MinimapPanel/MinimapPlayerMarker") as Polygon2D
	if host.recent_expedition_log_label == null:
		host.recent_expedition_log_label = host.get_node_or_null("HUD/RecentExpeditionLog") as Label
	if host.run_panel == null:
		host.run_panel = host.get_node_or_null("HUD/RunPanel") as Panel
	if host.surface_tabs_label == null:
		host.surface_tabs_label = host.get_node_or_null("HUD/RunPanel/SurfaceTabs") as Label
	if host.run_title_label == null:
		host.run_title_label = host.get_node_or_null("HUD/RunPanel/RunTitle") as Label
	if host.run_summary_label == null:
		host.run_summary_label = host.get_node_or_null("HUD/RunPanel/RunSummary") as Label
	if host.upgrade_panel == null:
		host.upgrade_panel = host.get_node_or_null("HUD/UpgradePanel") as Panel
	if host.upgrade_menu_title_label == null:
		host.upgrade_menu_title_label = host.get_node_or_null("HUD/UpgradePanel/UpgradeMenuTitle") as Label
	if host.upgrade_menu_item_label == null:
		host.upgrade_menu_item_label = host.get_node_or_null("HUD/UpgradePanel/UpgradeMenuItem") as Label
	if host.upgrade_menu_cost_label == null:
		host.upgrade_menu_cost_label = host.get_node_or_null("HUD/UpgradePanel/UpgradeMenuCost") as Label
	if host.upgrade_menu_state_label == null:
		host.upgrade_menu_state_label = host.get_node_or_null("HUD/UpgradePanel/UpgradeMenuState") as Label
	if host.upgrade_menu_feedback_label == null:
		host.upgrade_menu_feedback_label = host.get_node_or_null("HUD/UpgradePanel/UpgradeMenuFeedback") as Label
