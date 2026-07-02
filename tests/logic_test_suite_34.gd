extends RefCounted

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SurvivalStateScript := preload("res://scripts/survival_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const DiveCapacityServiceScript := preload("res://scripts/services/dive_capacity_service.gd")
const DiveToolActionServiceScript := preload("res://scripts/services/dive_tool_action_service.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const PlayerScript := preload("res://scripts/player.gd")
const PlayerScene := preload("res://scenes/Player.tscn")
const MainScene := preload("res://scenes/Main.tscn")
const ReadabilityMarkerPatternsScript := preload("res://scripts/readability_marker_patterns.gd")
const ScanPulseVisualScript := preload("res://scripts/scan_pulse_visual.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const MainScript := preload("res://scripts/main.gd")
const Area01SourceMapOverlayScript := preload("res://scripts/area01_source_map_overlay.gd")
const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")
const Area01SourceTruthValidatorScript := preload("res://scripts/area01_source_truth_validator.gd")
const Area01VisualCueContractScript := preload("res://scripts/area01_visual_cue_contract.gd")
const Area01VisualDirectorScript := preload("res://scripts/area01_visual_director.gd")
const Area01VisualStagingServiceScript := preload("res://scripts/debug/area01_visual_staging_service.gd")
const BlackwaterVisualStagingServiceScript := preload("res://scripts/debug/blackwater_visual_staging_service.gd")
const BlueChimneyVisualStagingServiceScript := preload("res://scripts/debug/blue_chimney_visual_staging_service.gd")
const MobileTouchControlsScript := preload("res://scripts/mobile_touch_controls.gd")
const RunTelemetryResetServiceScript := preload("res://scripts/services/run_telemetry_reset_service.gd")
const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const DaylightCargoVisualStagingServiceScript := preload("res://scripts/debug/daylight_cargo_visual_staging_service.gd")
const DaylightTimerHudServiceScript := preload("res://scripts/ui/daylight_timer_hud_service.gd")
const DepthRailServiceScript := preload("res://scripts/ui/depth_rail_service.gd")
const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const DuskTrenchVisualStagingServiceScript := preload("res://scripts/debug/dusk_trench_visual_staging_service.gd")
const ExpeditionSlateNodeServiceScript := preload("res://scripts/ui/expedition_slate_node_service.gd")
const ExpeditionSlatePresenterScript := preload("res://scripts/ui/expedition_slate_presenter.gd")
const ExpandedRouteVisualStagingServiceScript := preload("res://scripts/debug/expanded_route_visual_staging_service.gd")
const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const HealthFeedbackServiceScript := preload("res://scripts/ui/health_feedback_service.gd")
const HealthDamageVisualStagingServiceScript := preload("res://scripts/debug/health_damage_visual_staging_service.gd")
const HollowReefVisualStagingServiceScript := preload("res://scripts/debug/hollow_reef_visual_staging_service.gd")
const HudPromptPresenterScript := preload("res://scripts/ui/hud_prompt_presenter.gd")
const HudPromptStateServiceScript := preload("res://scripts/ui/hud_prompt_state_service.gd")
const HudInstrumentBarServiceScript := preload("res://scripts/ui/hud_instrument_bar_service.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const HudLayoutServiceScript := preload("res://scripts/ui/hud_layout_service.gd")
const HudReferenceServiceScript := preload("res://scripts/ui/hud_reference_service.gd")
const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")
const CargoSlotPresenterScript := preload("res://scripts/ui/cargo_slot_presenter.gd")
const HudVisibilityServiceScript := preload("res://scripts/ui/hud_visibility_service.gd")
const InventorySummaryPresenterScript := preload("res://scripts/ui/inventory_summary_presenter.gd")
const LowerConnectorVisualStagingServiceScript := preload("res://scripts/debug/lower_connector_visual_staging_service.gd")
const MirrorKelpVisualStagingServiceScript := preload("res://scripts/debug/mirror_kelp_visual_staging_service.gd")
const MinimapServiceScript := preload("res://scripts/ui/minimap_service.gd")
const NightBuildPresenterScript := preload("res://scripts/ui/night_build_presenter.gd")
const OpenHatchVisualStagingServiceScript := preload("res://scripts/debug/open_hatch_visual_staging_service.gd")
const OuterShelfVisualStagingServiceScript := preload("res://scripts/debug/outer_shelf_visual_staging_service.gd")
const OxygenFeedbackServiceScript := preload("res://scripts/ui/oxygen_feedback_service.gd")
const ResourcePresenterScript := preload("res://scripts/ui/resource_presenter.gd")
const ResourcePickupPresentationServiceScript := preload("res://scripts/ui/resource_pickup_presentation_service.gd")
const ResourceRoleVisualPresenterScript := preload("res://scripts/ui/resource_role_visual_presenter.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const RecentExpeditionLogServiceScript := preload("res://scripts/ui/recent_expedition_log_service.gd")
const RecentExpeditionPresenterScript := preload("res://scripts/ui/recent_expedition_presenter.gd")
const ScanEffectTextServiceScript := preload("res://scripts/ui/scan_effect_text_service.gd")
const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetCardServiceScript := preload("res://scripts/ui/scan_target_card_service.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")
const SurfaceResultPresenterScript := preload("res://scripts/ui/surface_result_presenter.gd")
const SurfaceRunSummaryServiceScript := preload("res://scripts/ui/surface_run_summary_service.gd")
const SurvivalNeedSummaryServiceScript := preload("res://scripts/ui/survival_need_summary_service.gd")
const SurvivalSupplyCachePresenterScript := preload("res://scripts/ui/survival_supply_cache_presenter.gd")
const SurvivalSupplyCacheStateServiceScript := preload("res://scripts/ui/survival_supply_cache_state_service.gd")
const SurvivalNeedsPanelServiceScript := preload("res://scripts/ui/survival_needs_panel_service.gd")
const ToolBeltPresenterScript := preload("res://scripts/ui/tool_belt_presenter.gd")
const ToolBeltServiceScript := preload("res://scripts/ui/tool_belt_service.gd")
const RouteMemoryPresenterScript := preload("res://scripts/ui/route_memory_presenter.gd")
const RoutePresenterScript := preload("res://scripts/ui/route_presenter.gd")
const RouteProximityServiceScript := preload("res://scripts/services/route_proximity_service.gd")
const RouteSetupServiceScript := preload("res://scripts/services/route_setup_service.gd")
const SceneEventServiceScript := preload("res://scripts/services/scene_event_service.gd")
const SurvivalControllerServiceScript := preload("res://scripts/services/survival_controller_service.gd")
const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")
const RouteTimingCueServiceScript := preload("res://scripts/ui/route_timing_cue_service.gd")
const RunMemoryStateServiceScript := preload("res://scripts/ui/run_memory_state_service.gd")
const ResearchResultPresenterScript := preload("res://scripts/ui/research_result_presenter.gd")
const ResearchResultCalloutServiceScript := preload("res://scripts/ui/research_result_callout_service.gd")
const ConditionVisualSyncServiceScript := preload("res://scripts/ui/condition_visual_sync_service.gd")
const DiscoveryRevealSyncServiceScript := preload("res://scripts/ui/discovery_reveal_sync_service.gd")
const RouteGateSyncServiceScript := preload("res://scripts/ui/route_gate_sync_service.gd")
const RoutePayoffSyncServiceScript := preload("res://scripts/ui/route_payoff_sync_service.gd")
const RunPanelLayoutServiceScript := preload("res://scripts/ui/run_panel_layout_service.gd")
const RunPanelServiceScript := preload("res://scripts/ui/run_panel_service.gd")
const UpgradeCopyPresenterScript := preload("res://scripts/ui/upgrade_copy_presenter.gd")
const UpgradeMenuServiceScript := preload("res://scripts/ui/upgrade_menu_service.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const VisualSmokeBridgeScript := preload("res://scripts/debug/visual_smoke_bridge.gd")
const ShipOffloadVisualStagingServiceScript := preload("res://scripts/debug/ship_offload_visual_staging_service.gd")
const SiltVeinVisualStagingServiceScript := preload("res://scripts/debug/silt_vein_visual_staging_service.gd")
const SurfaceOxygenVisualStagingServiceScript := preload("res://scripts/debug/surface_oxygen_visual_staging_service.gd")
const WideReefVisualStagingServiceScript := preload("res://scripts/debug/wide_reef_visual_staging_service.gd")
const WreckEchoVisualStagingServiceScript := preload("res://scripts/debug/wreck_echo_visual_staging_service.gd")
const ScannableScript := preload("res://scripts/scannable.gd")
const PredatorScript := preload("res://scripts/predator.gd")
const OxygenTankUpgrade := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PressureSealUpgrade := preload("res://resources/upgrades/pressure_seal_1.tres")
const SignalLensUpgrade := preload("res://resources/upgrades/signal_lens_1.tres")
const EchoLensUpgrade := preload("res://resources/upgrades/echo_lens_1.tres")
const ResonanceKeyUpgrade := preload("res://resources/upgrades/resonance_key_1.tres")
const CargoRackUpgrade := preload("res://resources/upgrades/cargo_rack_1.tres")
const WaterFilterUpgrade := preload("res://resources/upgrades/water_filter_1.tres")
const PredatorWarningUpgrade := preload("res://resources/upgrades/predator_warning_1.tres")
const DecoyPulseUpgrade := preload("res://resources/upgrades/decoy_pulse_1.tres")
const SalvageCutterUpgrade := preload("res://resources/upgrades/salvage_cutter_1.tres")
const StarterResourceDefinitions := [
	preload("res://resources/driftwood.tres"),
	preload("res://resources/food_supply.tres"),
	preload("res://resources/glow_plankton.tres"),
	preload("res://resources/kelp_fiber.tres"),
	preload("res://resources/power_supply.tres"),
	preload("res://resources/quartz_glass.tres"),
	preload("res://resources/scrap_metal.tres"),
	preload("res://resources/shell_fragments.tres"),
	preload("res://resources/water_supply.tres"),
]

class DummyScanTarget:
	extends Node2D

	var discovery_id := ""
	var display_name := ""
	var description := ""

	func set_scan_selected(_selected: bool) -> void:
		pass

func _test_run_panel_layout_service(runner) -> void:
	var main := MainScript.new()
	main.run_panel = Panel.new()
	main.surface_tabs_label = Label.new()
	main.run_title_label = Label.new()
	main.run_summary_label = Label.new()

	RunPanelLayoutServiceScript.apply_layout(main, false)
	runner._expect(runner._control_rect(main.run_panel) == main.RUN_PANEL_TALL_RECT, "run panel layout service should preserve tall surface panel rect")
	runner._expect(main.run_summary_label.offset_bottom == main.RUN_SUMMARY_TALL_BOTTOM, "run panel layout service should preserve tall summary bottom")
	runner._expect(main.run_title_label.offset_right == main.RUN_PANEL_CONTENT_RIGHT_TALL, "run panel layout service should preserve tall content right edge")

	RunPanelLayoutServiceScript.apply_layout(main, true)
	runner._expect(runner._control_rect(main.run_panel) == main.RUN_PANEL_COMPACT_RECT, "run panel layout service should preserve compact upgrade panel rect")
	runner._expect(main.run_summary_label.offset_bottom == main.RUN_SUMMARY_COMPACT_BOTTOM, "run panel layout service should preserve compact summary bottom")
	runner._expect(main.surface_tabs_label.offset_right == main.RUN_PANEL_CONTENT_RIGHT_COMPACT, "run panel layout service should preserve compact content right edge")
	main.free()

func _test_run_panel_service(runner) -> void:
	var main := MainScript.new()
	main.run_panel = Panel.new()
	main.surface_tabs_label = Label.new()
	main.run_title_label = Label.new()
	main.run_summary_label = Label.new()
	main.dive_session.result = DiveSessionScript.Result.READY

	RunPanelServiceScript.update_run_panel(main)
	runner._expect(main.run_panel.visible, "run panel service should show the panel in ready state")
	runner._expect(main.run_title_label.text.contains("Ready"), "run panel service should preserve ready title copy")
	runner._expect(main.run_summary_label.text.contains("Start with"), "run panel service should preserve ready summary copy")

	main.dive_session.result = DiveSessionScript.Result.EXTRACTED
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	RunPanelServiceScript.update_run_panel(main)
	runner._expect(main.run_title_label.text == "Surface Upgrade Bay", "run panel service should preserve upgrade tab title")
	runner._expect(main.run_summary_label.text.contains("Banked:"), "run panel service should preserve upgrade tab banked summary")
	runner._expect(runner._control_rect(main.run_panel) == main.RUN_PANEL_COMPACT_RECT, "run panel service should request compact layout for upgrade tab")

	main.surface_tab_index = main.SURFACE_TAB_LOG
	RunPanelServiceScript.update_run_panel(main)
	runner._expect(main.run_title_label.text == "Recent Expeditions", "run panel service should preserve recent log title")
	runner._expect(main.run_summary_label.text.contains("Recent Expeditions"), "run panel service should show recent expedition log copy")

	main.dive_session.result = DiveSessionScript.Result.DIVING
	RunPanelServiceScript.update_run_panel(main)
	runner._expect(not main.run_panel.visible, "run panel service should hide the surface panel while diving")
	main.free()

func _test_upgrade_menu_service(runner) -> void:
	var main := MainScript.new()
	main.upgrade_panel = Panel.new()
	main.upgrade_menu_title_label = Label.new()
	main.upgrade_menu_item_label = Label.new()
	main.upgrade_menu_cost_label = Label.new()
	main.upgrade_menu_state_label = Label.new()
	main.upgrade_menu_feedback_label = Label.new()

	UpgradeMenuServiceScript.update_menu(main)
	runner._expect(not main.upgrade_panel.visible, "upgrade menu service should hide panel outside extracted upgrade tab")

	main.dive_session.result = DiveSessionScript.Result.EXTRACTED
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	main.upgrade_definitions = []
	main.upgrade_menu_feedback = "No work queued"
	UpgradeMenuServiceScript.update_menu(main)
	runner._expect(main.upgrade_panel.visible, "upgrade menu service should show panel on upgrade tab")
	runner._expect(main.upgrade_menu_title_label.text == "Upgrade Bay", "upgrade menu service should preserve empty title")
	runner._expect(main.upgrade_menu_item_label.text == "No upgrades configured", "upgrade menu service should preserve empty item copy")
	runner._expect(main.upgrade_menu_feedback_label.text == "No work queued", "upgrade menu service should preserve empty feedback copy")

	var upgrade := UpgradeDefinition.new()
	upgrade.id = "test_upgrade"
	upgrade.display_name = "Test Upgrade"
	upgrade.description = "Test description"
	upgrade.resource_cost = {"driftwood": 1}
	main.upgrade_definitions = [upgrade]
	main.selected_upgrade_index = 0
	UpgradeMenuServiceScript.update_menu(main)
	runner._expect(main.upgrade_menu_title_label.text.begins_with("Upgrade Bay (1/1)"), "upgrade menu service should preserve selected title copy")
	runner._expect(main.upgrade_menu_item_label.text == "Test Upgrade\nTest description", "upgrade menu service should preserve upgrade item copy")
	runner._expect(main.upgrade_menu_cost_label.text == "Cost: Driftwood x1", "upgrade menu service should preserve cost copy")
	main.free()

func _test_upgrade_state_service(runner) -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [OxygenTankUpgrade, WaterFilterUpgrade]
	main.surface_tab_index = MainScript.SURFACE_TAB_UPGRADES

	runner._expect(UpgradeStateServiceScript.format_upgrade_status(main) == "Upgrades: 0 / 2 installed", "upgrade status should preserve owned/total copy")
	runner._expect(UpgradeStateServiceScript.format_surface_tabs(main) == "Result  [Upgrades]  Log  Night", "surface tab copy should preserve selected tab brackets")
	runner._expect(UpgradeStateServiceScript.format_burst_thruster_prompt(main).begins_with("Space burst -"), "burst prompt should preserve action-label copy")
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main) == "", "undiscovered Decoy Pulse prompt should stay hidden")

	var counts := UpgradeStateServiceScript.resource_counts_for_cost(main, {"kelp_fiber": 2, "shell_fragments": 1})
	runner._expect(int(counts.get("kelp_fiber", -1)) == 0, "upgrade resource count should use banked resource totals")
	main.progression_state.banked_resources["kelp_fiber"] = 2
	main.progression_state.banked_resources["shell_fragments"] = 1
	main.progression_state.banked_resources["glow_plankton"] = 1
	counts = UpgradeStateServiceScript.resource_counts_for_cost(main, {"kelp_fiber": 2, "shell_fragments": 1})
	runner._expect(int(counts.get("kelp_fiber", -1)) == 2, "upgrade resource count should reflect banked resources")

	var ready_callout := UpgradeStateServiceScript.format_ready_upgrade_callout(main)
	runner._expect(ready_callout.contains("Oxygen Tank I"), "ready upgrade callout should include affordable upgrades")
	runner._expect(UpgradeStateServiceScript.format_upgrade_prerequisite_action("salvage_data_cache") == "recover", "salvage cache prerequisite should preserve recover verb")
	runner._expect(UpgradeStateServiceScript.format_upgrade_prerequisite_action("thermal_vent") == "scan", "scan prerequisites should preserve scan verb")
	main.free()

func _test_resource_summary_service(runner) -> void:
	var main := MainScript.new()
	var resources: Array[String] = ["scrap_metal", "scrap_metal", "food_supply"]
	runner._expect(ResourceSummaryServiceScript.short_resource_name("kelp_fiber", main.survival_state) == "Kelp", "resource summary service should preserve compact material names")
	runner._expect(ResourceSummaryServiceScript.short_resource_name("food_supply", main.survival_state) == "Food", "resource summary service should preserve compact supply names")
	runner._expect(ResourceSummaryServiceScript.resource_category_label("food_supply", main.survival_state, main.RESOURCE_CATEGORY_LABELS) == "Food/Fish", "resource summary service should use survival category labels")
	runner._expect(ResourceSummaryServiceScript.display_name_for_resource("scrap_metal", main.survival_state) == "Scrap Metal", "resource summary service should preserve material display names")
	runner._expect(ResourceSummaryServiceScript.format_resource_counts(resources, main.survival_state, main.RESOURCE_CATEGORY_LABELS).contains("Scrap Metal x2"), "resource summary service should format counted resource summaries")
	runner._expect(ResourceSummaryServiceScript.format_cargo_counts_inline(["glow_plankton", "kelp_fiber", "glow_plankton"], main.survival_state) == " - Glow x2, Kelp x1", "resource summary service should preserve inline cargo copy")
	runner._expect(ResourceSummaryServiceScript.resource_names_for_cost({"driftwood": 1}, main.survival_state)["driftwood"] == "Driftwood", "resource summary service should build cost display names")
	main.free()

func _test_depth_rail_service(runner) -> void:
	var main := MainScript.new()
	main.depth_rail_line = ColorRect.new()
	main.depth_rail_marker = Polygon2D.new()
	main.depth_rail_labels = [Label.new(), Label.new(), Label.new()]
	main.dive_session.current_depth = main.DEPTH_RAIL_MAX_DISPLAY_DEPTH * 0.5

	DepthRailServiceScript.update_rail(main, true)
	runner._expect(main.depth_rail_line.visible and main.depth_rail_marker.visible, "visible depth rail should show line and marker")
	runner._expect(main.depth_rail_labels[0].text == "0m" and main.depth_rail_labels[1].text == "50m" and main.depth_rail_labels[2].text == "100m", "depth rail labels should preserve compact copy")
	runner._expect(is_equal_approx(main.depth_rail_marker.position.y, main.DEPTH_RAIL_LINE_RECT.position.y + main.DEPTH_RAIL_LINE_RECT.size.y * 0.5), "depth rail marker should track current depth ratio")

	DepthRailServiceScript.update_rail(main, false)
	runner._expect(not main.depth_rail_line.visible and not main.depth_rail_marker.visible, "hidden depth rail should hide line and marker")
	runner._expect(not main.depth_rail_labels[0].visible and not main.depth_rail_labels[1].visible and not main.depth_rail_labels[2].visible, "hidden depth rail should hide labels")
	main.free()

func _test_minimap_service(runner) -> void:
	var main := MainScript.new()
	main.minimap_path = Line2D.new()
	main.minimap_player_marker = Polygon2D.new()
	main.player = PlayerScene.instantiate()
	main.player.set("world_bounds", Rect2(Vector2.ZERO, Vector2(200.0, 200.0)))
	main.player.global_position = Vector2(200.0, 0.0)
	main.dive_session.current_depth = main.DEPTH_RAIL_MAX_DISPLAY_DEPTH * 0.5

	MinimapServiceScript.update_minimap(main, true)
	runner._expect(main.minimap_path.visible and main.minimap_player_marker.visible, "visible minimap should show path and player marker")
	runner._expect(is_equal_approx(main.minimap_player_marker.position.x, 94.0 + 39.0), "minimap marker should track player horizontal world ratio")
	runner._expect(is_equal_approx(main.minimap_player_marker.position.y, 34.0 + 38.0), "minimap marker should track current depth ratio")

	MinimapServiceScript.update_minimap(main, false)
	runner._expect(not main.minimap_path.visible and not main.minimap_player_marker.visible, "hidden minimap should hide path and player marker")
	main.player.free()
	main.free()

func _test_tool_belt_service(runner) -> void:
	runner._expect(ToolBeltServiceScript.tool_belt_state("scanner", true, 0.0, 30.0, 6.0, false, false, false) == "active", "scanner should be active when a scan target is selected")
	runner._expect(ToolBeltServiceScript.tool_belt_state("scanner", false, 0.0, 30.0, 6.0, false, false, false) == "ready", "scanner should be ready without a scan target")
	runner._expect(ToolBeltServiceScript.tool_belt_state("burst", false, 1.0, 30.0, 6.0, false, false, false) == "cooldown", "burst tool should show cooldown before oxygen readiness")
	runner._expect(ToolBeltServiceScript.tool_belt_state("burst", false, 0.0, 30.0, 6.0, false, false, false) == "ready", "burst tool should be ready when oxygen is above cost")
	runner._expect(ToolBeltServiceScript.tool_belt_state("burst", false, 0.0, 6.0, 6.0, false, false, false) == "disabled", "burst tool should require oxygen above cost")
	runner._expect(ToolBeltServiceScript.tool_belt_state("cutter", false, 0.0, 30.0, 6.0, true, false, false) == "ready", "cutter should be ready after Salvage Cutter")
	runner._expect(ToolBeltServiceScript.tool_belt_state("decoy", false, 0.0, 30.0, 6.0, false, true, true) == "spent", "decoy should show spent after use")
	runner._expect(ToolBeltServiceScript.tool_belt_state("reserve", false, 0.0, 30.0, 6.0, false, false, false) == "locked", "reserve tool slot should stay locked")

	var main := MainScript.new()
	main.tool_slot_nodes = [ColorRect.new(), ColorRect.new(), ColorRect.new(), ColorRect.new(), ColorRect.new()]
	main.tool_icon_nodes = [Polygon2D.new(), Polygon2D.new(), Polygon2D.new(), Polygon2D.new(), Polygon2D.new()]
	main.tool_key_label_nodes = [Label.new(), Label.new(), Label.new(), Label.new(), Label.new()]
	main.dive_session.reset(40.0, 100.0)
	main.dive_session.start()

	ToolBeltServiceScript.update_tool_belt(main, true)
	runner._expect(main.tool_slot_nodes[0].visible and main.tool_icon_nodes[0].visible and main.tool_key_label_nodes[0].visible, "visible tool belt should show scanner slot nodes")
	runner._expect(main.tool_key_label_nodes[0].text == "F" and main.tool_key_label_nodes[1].text == "Space", "tool belt service should preserve key labels")
	runner._expect(main.tool_slot_nodes[0].color == ToolBeltPresenterScript.tool_slot_color("ready"), "tool belt service should preserve scanner ready slot color")
	runner._expect(main.tool_icon_nodes[0].polygon.size() > 0, "tool belt service should preserve scanner icon polygon")

	ToolBeltServiceScript.update_tool_belt(main, false)
	runner._expect(not main.tool_slot_nodes[0].visible and not main.tool_icon_nodes[0].visible and not main.tool_key_label_nodes[0].visible, "hidden tool belt should hide scanner slot nodes")
	main.free()

func _test_route_gate_sync_service(runner) -> void:
	var main := MainScript.new()
	main.salvage_hatch_panel = Polygon2D.new()
	main.salvage_lock_bars = Polygon2D.new()
	main.salvage_glint = Polygon2D.new()
	main.salvage_tool_label = Label.new()
	main.salvage_promise_label = Label.new()
	main.salvage_opened_pocket_lane = Node2D.new()

	RouteGateSyncServiceScript.sync_salvage_pocket_open(main)
	runner._expect(not main.salvage_opened_pocket_lane.visible, "locked salvage pocket should keep opened lane hidden")
	runner._expect(main.salvage_lock_bars.visible, "locked salvage pocket should keep lock bars visible")
	runner._expect(main.salvage_tool_label.text == "CUTTER NEEDED", "locked salvage pocket should keep cutter-needed label")

	main.progression_state.add_upgrade(main.SALVAGE_CUTTER_UPGRADE_ID)
	RouteGateSyncServiceScript.sync_salvage_pocket_open(main)
	runner._expect(main.salvage_opened_pocket_lane.visible, "cutter-owned salvage pocket should reveal opened lane")
	runner._expect(not main.salvage_lock_bars.visible, "cutter-owned salvage pocket should hide lock bars")
	runner._expect(main.salvage_promise_label.text == "OPEN", "cutter-owned salvage pocket should preserve open label")
	main.free()

func _test_condition_visual_sync_service(runner) -> void:
	var main := MainScript.new()
	main.rare_signal_emphasis = Node2D.new()
	main.shelf_glimmer_opportunity = Node2D.new()
	main.blue_chimney_signal_opportunity = Node2D.new()
	main.route_choice_decision_rib = Polygon2D.new()
	main.route_choice_safe_bank_lane = Polygon2D.new()
	main.route_choice_research_lane = Polygon2D.new()
	main.dusk_low_visibility_veil = Polygon2D.new()
	main.dusk_low_visibility_band = Polygon2D.new()
	main.dusk_low_visibility_rib_a = Polygon2D.new()
	main.dusk_low_visibility_rib_b = Polygon2D.new()
	main.wide_chamber_return_main = Polygon2D.new()
	main.wide_chamber_return_far = Polygon2D.new()
	main.wide_chamber_return_mid = Polygon2D.new()
	main.wide_chamber_return_entry = Polygon2D.new()
	main.mirror_kelp_reflective_backwater = Polygon2D.new()
	main.mirror_kelp_curtain_a = Polygon2D.new()
	main.mirror_kelp_curtain_b = Polygon2D.new()
	main.mirror_kelp_curtain_c = Polygon2D.new()
	main.mirror_kelp_bloom_approach_wash = Polygon2D.new()
	main.mirror_kelp_bloom_approach_rib = Polygon2D.new()

	ConditionVisualSyncServiceScript.sync_condition_visuals(main, "rare_signal", false)
	runner._expect(main.rare_signal_emphasis.visible, "Rare Signal should show the subtle signal emphasis")
	runner._expect(main.shelf_glimmer_opportunity.visible, "Rare Signal should show the shelf glimmer opportunity")
	runner._expect(main.blue_chimney_signal_opportunity.visible, "Rare Signal should show the Blue Chimney signal opportunity")
	runner._expect(main.route_choice_research_lane.color == Color(0.52, 0.96, 1.0, 0.28), "Rare Signal research lane color should stay exact")

	ConditionVisualSyncServiceScript.sync_dusk_trench_condition_nudge(main, "low_visibility")
	runner._expect(main.dusk_low_visibility_veil.color == Color(0.035, 0.055, 0.15, 0.32), "low-visibility Dusk veil color should stay exact")

	ConditionVisualSyncServiceScript.sync_wide_chamber_condition_nudge(main, "calm_current")
	runner._expect(main.wide_chamber_return_main.color == Color(0.66, 1.0, 0.88, 0.17), "calm-current Wide Reef return color should stay exact")

	ConditionVisualSyncServiceScript.sync_mirror_kelp_condition_nudge(main, "kelp_bloom")
	runner._expect(main.mirror_kelp_bloom_approach_wash.visible, "Kelp Bloom should show the Mirror Kelp approach wash")
	runner._expect(main.mirror_kelp_reflective_backwater.color == Color(0.08, 0.36, 0.42, 0.18), "Kelp Bloom backwater color should stay exact")

	ConditionVisualSyncServiceScript.sync_condition_visuals(main, "calm_current", false)
	runner._expect(not main.rare_signal_emphasis.visible, "non-Rare-Signal conditions should hide the signal emphasis")
	runner._expect(not main.shelf_glimmer_opportunity.visible, "non-Rare-Signal conditions should hide shelf glimmer")
	runner._expect(not main.blue_chimney_signal_opportunity.visible, "non-Rare-Signal conditions should hide Blue Chimney signal")

	main.rare_signal_emphasis.free()
	main.shelf_glimmer_opportunity.free()
	main.blue_chimney_signal_opportunity.free()
	main.route_choice_decision_rib.free()
	main.route_choice_safe_bank_lane.free()
	main.route_choice_research_lane.free()
	main.dusk_low_visibility_veil.free()
	main.dusk_low_visibility_band.free()
	main.dusk_low_visibility_rib_a.free()
	main.dusk_low_visibility_rib_b.free()
	main.wide_chamber_return_main.free()
	main.wide_chamber_return_far.free()
	main.wide_chamber_return_mid.free()
	main.wide_chamber_return_entry.free()
	main.mirror_kelp_reflective_backwater.free()
	main.mirror_kelp_curtain_a.free()
	main.mirror_kelp_curtain_b.free()
	main.mirror_kelp_curtain_c.free()
	main.mirror_kelp_bloom_approach_wash.free()
	main.mirror_kelp_bloom_approach_rib.free()
	main.free()
