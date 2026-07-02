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

func _test_compact_dive_hud_helpers(runner) -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["glow_plankton", "kelp_fiber", "glow_plankton"]
	var inline_cargo: String = ResourceSummaryServiceScript.format_cargo_counts_inline(cargo, main.survival_state)
	runner._expect(inline_cargo == " - Glow x2, Kelp x1", "active cargo helper should keep carried resources on one line")

	var slot_states: Array = CargoSlotPresenterScript.cargo_slot_states(cargo, 3, 4)
	runner._expect(slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "hidden"], "cargo slots should hide excess capacity before Cargo Rack I")
	var upgraded_slot_states: Array = CargoSlotPresenterScript.cargo_slot_states(cargo, 4, 4)
	runner._expect(upgraded_slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "empty"], "cargo slots should reveal the fourth slot after capacity upgrade")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("empty").a > CargoSlotPresenterScript.cargo_slot_color("hidden").a, "empty cargo slots should read brighter than unavailable slots")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("hidden").a == 0.0, "hidden cargo slot color should stay transparent")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("empty").a <= 0.52, "empty cargo slots should stay translucent glass, not opaque blocks")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("glow_plankton").a <= 0.8, "filled cargo slots should use readable glass cards instead of solid color blocks")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("glow_plankton") == Color(0.38, 0.52, 0.12, 0.76), "representative cargo slot color should stay exact")
	runner._expect(CargoSlotPresenterScript.cargo_slot_color("locked").a <= 0.3, "locked cargo slots should be quieter than usable slots")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("kelp_fiber").size() > 0, "kelp cargo slots should have a mini-icon polygon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("shell_fragments").size() > 0, "shell cargo slots should have a mini-icon polygon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("glow_plankton").size() > 0, "glow cargo slots should have a mini-icon polygon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("scrap_metal").size() > 0, "scrap cargo slots should have a mini-icon polygon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("driftwood").size() > 0, "driftwood cargo slots should have a mini-icon polygon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("quartz_glass").size() > 0, "quartz glass cargo slots should have a mini-icon polygon")
	runner._expect(ResourcePresenterScript.short_resource_name("scrap_metal", false, "") == "Scrap", "scrap metal should have a compact HUD name")
	runner._expect(ResourcePresenterScript.short_resource_name("driftwood", false, "") == "Wood", "driftwood should have a compact HUD name")
	runner._expect(ResourcePresenterScript.short_resource_name("quartz_glass", false, "") == "Glass", "quartz glass should have a compact HUD name")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("empty").is_empty(), "empty cargo slots should not show a resource mini-icon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_polygon("unknown").is_empty(), "unknown cargo slots should not show a resource mini-icon")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_color("hidden").a == 0.0, "hidden cargo slot icon color should stay transparent")
	runner._expect(CargoSlotPresenterScript.cargo_slot_icon_color("kelp_fiber") == Color(0.78, 1.0, 0.74, 0.95), "representative cargo icon color should stay exact")
	runner._expect(ToolBeltPresenterScript.tool_slot_color("ready").a <= 0.52, "ready tool slots should stay translucent like reference HUD glass")
	runner._expect(ToolBeltPresenterScript.tool_slot_color("locked").a <= 0.36, "locked tool slots should sit quieter than ready tools")
	runner._expect(ToolBeltPresenterScript.tool_slot_color("active").a >= 0.65, "active tool slots should still read as selected")

	var compact_discoveries: String = DiscoveryNamePresenterScript.format_discoveries(main.progression_state, true)
	runner._expect(compact_discoveries == "Discoveries: 0", "compact discovery helper should show only the count")

	var main_scene := MainScene.instantiate()
	runner.root.add_child(main_scene)
	main_scene.active_stats_panel = null
	main_scene.cargo_slots_root = null
	HudReferenceServiceScript.ensure_active_hud_references(main_scene)
	runner._expect(main_scene.active_stats_panel != null, "HUD reference service should cache the active stats panel")
	runner._expect(main_scene.cargo_slots_root != null, "HUD reference service should cache the cargo slots runner.root")
	HudLayoutServiceScript.apply_active_hud_layout(main_scene)
	runner._expect(runner._control_rect(main_scene.active_stats_panel) == main_scene.ACTIVE_STATS_RECT, "HUD layout service should apply the active stats panel rect")
	HudVisibilityServiceScript.apply_active_hud_visibility(main_scene, true, false, false)
	runner._expect(main_scene.active_stats_panel.visible, "HUD visibility service should show active stats while diving")
	runner._expect(not main_scene.scan_card_panel.visible, "HUD visibility service should hide the scan card without a scan target")
	var canvas_parent := Node2D.new()
	var canvas_child := Node2D.new()
	canvas_parent.z_index = 4
	canvas_child.z_index = 3
	canvas_parent.add_child(canvas_child)
	runner._expect(HudVisibilityServiceScript.effective_canvas_z(canvas_child) == 7, "HUD visibility service should include relative parent canvas z")
	canvas_child.z_as_relative = false
	runner._expect(HudVisibilityServiceScript.effective_canvas_z(canvas_child) == 3, "HUD visibility service should stop at non-relative canvas z")
	canvas_parent.free()
	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var cargo_panel: Panel = main_scene.get_node("HUD/CargoPanel")
	var cargo_title: Label = main_scene.get_node("HUD/CargoPanel/CargoTitle")
	var cargo_slots_root: Node2D = main_scene.get_node("HUD/CargoSlots")
	var survival_panel: Panel = main_scene.get_node("HUD/SurvivalNeedsPanel")
	var warning_panel: Panel = main_scene.get_node("HUD/OxygenWarningPanel")
	var scan_card_panel: Panel = main_scene.get_node("HUD/ScanCardPanel")
	var tool_belt_panel: Panel = main_scene.get_node("HUD/ToolBeltPanel")
	var minimap_panel: Panel = main_scene.get_node("HUD/MinimapPanel")
	var oxygen_bar_fill: ColorRect = main_scene.get_node("HUD/OxygenBarFill")
	var health_bar_fill: ColorRect = main_scene.get_node("HUD/HealthBarFill")
	var depth_bar_fill: ColorRect = main_scene.get_node("HUD/DepthBarFill")
	var oxygen_label: Label = main_scene.get_node("HUD/Oxygen")
	var health_label: Label = main_scene.get_node("HUD/Health")
	var depth_label: Label = main_scene.get_node("HUD/Depth")
	var depth_rail_line: ColorRect = main_scene.get_node("HUD/DepthRailLine")
	var depth_rail_marker: Polygon2D = main_scene.get_node("HUD/DepthRailMarker")
	var discoveries_label: Label = main_scene.get_node("HUD/Discoveries")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var objective_title: Label = main_scene.get_node("HUD/DiveInfoPanel/ObjectiveTitle")
	var objective_line: Label = main_scene.get_node("HUD/DiveInfoPanel/ObjectiveLine")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var scan_card_meta_label: Label = main_scene.get_node("HUD/ScanCardMeta")
	var scan_card_prompt_label: Label = main_scene.get_node("HUD/ScanCardPrompt")
	var scan_reticle_root: Node2D = main_scene.get_node("HUD/ScanReticleRoot")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var status_label: Label = main_scene.get_node("HUD/Status")
	var cargo_label: Label = main_scene.get_node("HUD/Cargo")
	var food_label: Label = main_scene.get_node("HUD/FoodNeed")
	var water_label: Label = main_scene.get_node("HUD/WaterNeed")
	var power_label: Label = main_scene.get_node("HUD/PowerNeed")
	var food_icon: Polygon2D = main_scene.get_node("HUD/FoodNeedIcon")
	var water_icon: Polygon2D = main_scene.get_node("HUD/WaterNeedIcon")
	var power_icon: Polygon2D = main_scene.get_node("HUD/PowerNeedIcon")
	var cargo_slot_4: ColorRect = main_scene.get_node("HUD/CargoSlots/Slot4")
	var cargo_slot_nodes: Array[ColorRect] = [
		main_scene.get_node("HUD/CargoSlots/Slot1"),
		main_scene.get_node("HUD/CargoSlots/Slot2"),
		main_scene.get_node("HUD/CargoSlots/Slot3"),
		cargo_slot_4,
	]
	var cargo_slot_icon_nodes: Array[Polygon2D] = [
		main_scene.get_node("HUD/CargoSlots/Icon1"),
		main_scene.get_node("HUD/CargoSlots/Icon2"),
		main_scene.get_node("HUD/CargoSlots/Icon3"),
		main_scene.get_node("HUD/CargoSlots/Icon4"),
	]
	main_scene.cargo_slot_nodes = cargo_slot_nodes
	main_scene.cargo_slot_icon_nodes = cargo_slot_icon_nodes
	main_scene.dive_session.cargo_limit = 3
	main_scene.call("_apply_active_hud_layout")
	main_scene.call("_update_cargo_slots")
	var camera := main_scene.get_node("Player/Camera2D") as Camera2D
	var zoomed_out_reticle: Vector2 = ScanTargetFeedbackServiceScript.scan_reticle_fallback_screen_position(
		main_scene,
		main_scene.player.global_position + Vector2(100.0, 0.0),
		Vector2(1280.0, 720.0)
	)
	runner._expect(zoomed_out_reticle.x < 740.0, "scan reticle should apply zoomed-out camera scale instead of drifting beyond the target")
	runner._expect(is_equal_approx(zoomed_out_reticle.x, 640.0 + 100.0 * camera.zoom.x), "scan reticle fallback should match Camera2D zoomed screen offset")
	var sticky_player := CharacterBody2D.new()
	runner.root.add_child(sticky_player)
	var sticky_target := DummyScanTarget.new()
	sticky_target.discovery_id = "sticky_target"
	sticky_target.display_name = "Sticky Target"
	sticky_target.global_position = Vector2(142.0, 0.0)
	runner.root.add_child(sticky_target)
	main.player = sticky_player
	main.scan_range = 120.0
	runner._expect(ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, sticky_target), "scan target selection should keep the current target inside the sticky buffer")
	sticky_target.global_position = Vector2(154.0, 0.0)
	runner._expect(not ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, sticky_target), "scan target selection should release a target beyond the sticky buffer")
	sticky_target.visible = false
	sticky_target.global_position = Vector2(80.0, 0.0)
	runner._expect(not ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, sticky_target), "hidden scan targets should not stay selected")
	sticky_target.queue_free()
	sticky_player.queue_free()
	var hud_style := active_panel.get_theme_stylebox("panel") as StyleBoxFlat
	var warning_style := warning_panel.get_theme_stylebox("panel") as StyleBoxFlat
	runner._expect(hud_style.bg_color.a <= 0.62, "active HUD glass should stay translucent instead of opaque black")
	runner._expect(hud_style.border_color.a <= 0.38, "active HUD borders should stay subtle")
	runner._expect(hud_style.shadow_size <= 6, "active HUD shadow should stay tight and game-like")
	runner._expect(warning_style.bg_color.a >= 0.6, "oxygen warning should stay stronger than ordinary HUD glass")
	runner._expect(oxygen_label.get_theme_font_size("font_size") <= 15, "oxygen value should be compact rather than debug-sized")
	runner._expect(health_label.get_theme_font_size("font_size") <= 12, "health value should stay compact inside the active stats panel")
	runner._expect(depth_label.get_theme_font_size("font_size") <= 12, "depth value should use compact reference-style type")
	runner._expect(discoveries_label.get_theme_font_size("font_size") <= 12, "discoveries count should stay subordinate")
	runner._expect(objective_title.get_theme_font_size("font_size") <= 12, "objective title should be a compact HUD label")
	runner._expect(objective_line.get_theme_font_size("font_size") <= 12, "objective line should be compact enough for a small route card")
	runner._expect(status_label.get_theme_font_size("font_size") <= 13, "status text should be readable without oversized copy")
	runner._expect(runner._control_rect(active_panel).size.x <= 280.0, "active stats panel should keep a compact reference-style width")
	runner._expect(runner._control_rect(active_panel).size.y <= 160.0, "active stats panel should keep oxygen, health, and depth compact")
	runner._expect(runner._control_rect(cargo_panel).size.x <= 270.0, "cargo strip should be a compact top-center widget, not a wide banner")
	runner._expect(runner._control_rect(cargo_panel).size.y <= 50.0, "cargo strip should stay shallow and avoid wasting top-screen space")
	runner._expect(runner._control_rect(survival_panel).size.x <= 250.0, "survival needs panel should keep a compact reference-style width")
	runner._expect(runner._control_rect(survival_panel).size.x <= 232.0, "survival needs panel should tighten toward the right edge")
	runner._expect(runner._control_rect(dive_info_panel).size.x <= 300.0, "route objective card should stay compact")
	runner._expect(runner._control_rect(scan_card_panel).size.x <= 230.0, "scan card should be a compact contextual popup")
	runner._expect(runner._control_rect(scan_card_panel).size.y <= 92.0, "scan card should stay shallow and avoid permanent right-side clutter")
	runner._expect(runner._control_rect(tool_belt_panel).size.x <= 320.0, "tool belt should use compact icon cards instead of a wide placeholder tray")
	runner._expect(runner._control_rect(tool_belt_panel).size.y <= 58.0, "tool belt should stay close to the lower edge without tall glass")
	runner._expect(runner._control_rect(minimap_panel).size.x <= 192.0, "minimap should stay compact in the lower-right corner")
	runner._expect(cargo_title.offset_right <= runner._control_rect(cargo_panel).size.x, "cargo title should stay inside the compact cargo widget")
	runner._expect(cargo_slots_root.position.x + cargo_slot_4.offset_right <= cargo_panel.offset_right, "all cargo slots should fit inside the compact cargo strip when the fourth slot is unlocked")
	runner._expect(runner._control_rect(cargo_panel).encloses(runner._control_rect(cargo_label)), "active Cargo label should stay inside the top-center cargo strip")
	runner._expect(cargo_slot_4.offset_right <= 130.0, "cargo card row should stay tight enough to read as a compact strip")
	runner._expect(runner._control_rect(survival_panel).encloses(runner._control_rect(food_label)), "Food need should stay inside the top-right survival panel")
	runner._expect(runner._control_rect(survival_panel).encloses(runner._control_rect(water_label)), "Water need should stay inside the top-right survival panel")
	runner._expect(runner._control_rect(survival_panel).encloses(runner._control_rect(power_label)), "Power need should stay inside the top-right survival panel")
	runner._expect(food_icon.position.x >= survival_panel.offset_left, "Food icon should stay attached to the compact needs widget")
	runner._expect(water_icon.position.x >= survival_panel.offset_left, "Water icon should stay attached to the compact needs widget")
	runner._expect(power_icon.position.x >= survival_panel.offset_left, "Power icon should stay attached to the compact needs widget")
	runner._expect(discoveries_label.offset_top >= active_panel.offset_top, "active Discoveries label should stay inside the compact stats panel")
	runner._expect(discoveries_label.offset_bottom <= active_panel.offset_bottom, "active Discoveries label should not spill below the compact stats panel")
	runner._expect(runner._control_rect(active_panel).encloses(runner._control_rect(health_label)), "Health label should stay inside the compact stats panel")
	runner._expect(runner._control_rect(active_panel).encloses(runner._control_rect(health_bar_fill)), "Health bar should stay inside the compact stats panel")
	runner._expect(cargo_panel.offset_left > active_panel.offset_right, "cargo strip should be separated from the top-left instruments")
	runner._expect(survival_panel.offset_left > cargo_panel.offset_right, "survival panel should be separated from the cargo strip")
	runner._expect(oxygen_bar_fill.offset_right <= main_scene.get_node("HUD/OxygenBarBack").offset_right, "oxygen fill should stay inside the oxygen bar")
	runner._expect(health_bar_fill.offset_right <= main_scene.get_node("HUD/HealthBarBack").offset_right, "health fill should stay inside the health bar")
	runner._expect(depth_bar_fill.offset_right <= main_scene.get_node("HUD/DepthBarBack").offset_right, "depth fill should stay inside the depth bar")
	runner._expect(dive_info_panel.offset_top > active_panel.offset_bottom, "dive info panel should remain below compact stats content")
	runner._expect(runner._control_rect(scan_card_panel).encloses(runner._control_rect(scan_target_label)), "scan target should stay inside the dedicated scan card when visible")
	runner._expect(runner._control_rect(scan_card_panel).encloses(runner._control_rect(scan_card_meta_label)), "scan metadata should stay inside the dedicated scan card when visible")
	runner._expect(runner._control_rect(scan_card_panel).encloses(runner._control_rect(scan_card_prompt_label)), "scan prompt should stay inside the dedicated scan card when visible")
	var scan_reticle_top_left: Polygon2D = main_scene.get_node("HUD/ScanReticleRoot/TopLeft")
	runner._expect(scan_reticle_top_left.polygon[0].x >= -44.0 and scan_reticle_top_left.polygon[0].y >= -32.0, "scan reticle bracket should stay tight around the target instead of covering nearby sprites")
	runner._expect(tool_belt_panel.offset_top > dive_info_panel.offset_bottom, "tool belt should sit below active guidance and away from the play focus")
	runner._expect(minimap_panel.offset_left > tool_belt_panel.offset_right, "minimap should occupy the bottom-right reference zone away from the tool belt")
	runner._expect(depth_rail_line.offset_top > dive_info_panel.offset_bottom, "depth rail should start below the left objective card")
	runner._expect(depth_rail_marker.position.x >= depth_rail_line.offset_left, "depth rail marker should align to the depth rail")
	runner._expect(not scan_card_panel.visible, "scan card should hide when no target is selected")
	runner._expect(not scan_target_label.visible, "scan target label should hide when no target is selected")
	runner._expect(not scan_card_meta_label.visible, "scan metadata should hide when no target is selected")
	runner._expect(not scan_card_prompt_label.visible, "scan prompt should hide when no target is selected")
	runner._expect(not scan_reticle_root.visible, "scan reticle should hide when no target is selected")
	runner._expect(status_label.offset_bottom <= dive_info_panel.offset_bottom, "status text should stay inside the dive info panel")
	runner._expect(prompt_label.offset_bottom <= status_label.offset_top, "prompt and status should not overlap")
	runner._expect(not runner._controls_overlap(prompt_label, status_label), "active prompt and status rows should remain physically separated")
	runner._expect(prompt_label.autowrap_mode == TextServer.AUTOWRAP_OFF, "active prompt should clip within its reserved row instead of wrapping into status")
	runner._expect(status_label.autowrap_mode == TextServer.AUTOWRAP_OFF, "active status should clip within its reserved row instead of wrapping into nearby HUD text")
	runner._expect(not cargo_slot_4.visible, "fourth cargo slot should stay hidden before Cargo Rack I")
	main_scene.dive_session.cargo_limit = 4
	main_scene.call("_update_cargo_slots")
	runner._expect(cargo_slot_4.visible, "fourth cargo slot should appear after Cargo Rack I capacity is active")
	runner._expect(scan_target_label.text == "none nearby", "scan target label should use the scan-card none-nearby copy")
	runner._expect(not active_panel.visible, "surface-ready state should hide active stats clutter")
	runner._expect(not cargo_panel.visible, "surface-ready state should hide active cargo clutter")
	runner._expect(not survival_panel.visible, "surface-ready state should hide active base-needs clutter")
	runner._expect(not dive_info_panel.visible, "surface-ready state should hide dive guidance clutter")
	runner._expect(not scan_card_panel.visible, "surface-ready state should hide the contextual scan card")
	runner._expect(not tool_belt_panel.visible, "surface-ready state should hide the active tool belt")
	runner._expect(not minimap_panel.visible, "surface-ready state should hide the active minimap")

	main_scene.dive_session.start()
	main_scene.player_in_base = false
	main_scene.call("_update_hud")
	runner._expect(dive_info_panel.visible, "active diving should show one compact objective card")
	runner._expect(objective_title.text == "SURVIVAL ROUTE", "objective card title should frame the active goal as survival route work")
	runner._expect(objective_line.text.length() <= 46, "active objective line should stay shorter than paragraph-style HUD copy")
	runner._expect(not objective_line.text.contains("|"), "active objective line should not become another command strip")
	runner._expect(runner._control_rect(dive_info_panel).encloses(runner._control_rect(prompt_label)), "active prompt row should stay inside the objective card")
	runner._expect(runner._control_rect(dive_info_panel).encloses(runner._control_rect(status_label)), "active status row should stay inside the objective card")
	main_scene.dive_session.cargo_limit = 3
	main_scene.dive_session.current_cargo = ["food_supply", "water_supply", "driftwood"]
	main_scene.call("_update_hud")
	runner._expect(objective_line.text == "Cargo full: return to bank", "cargo-full state should replace generic objective copy with a compact return objective")
	main_scene.queue_free()

	var long_status := "Scanned Thermal Vent.\nWarm current marks optional glow; bank Pressure Seal clue. Return safely before oxygen runs out."
	var compact_status: String = HudPresenterScript.compact_dive_status(long_status)
	runner._expect(not compact_status.contains("\n"), "compact dive status should remove line breaks")
	runner._expect(compact_status.length() <= 72, "compact dive status should stay within the dive HUD limit")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	var combined_prompt := "Explore, then return to base | %s | %s" % [
		UpgradeStateServiceScript.format_burst_thruster_prompt(main),
		UpgradeStateServiceScript.format_decoy_pulse_prompt(main),
	]
	runner._expect(combined_prompt.length() <= 72, "combined Burst and Decoy active prompt should stay compact")
	runner._expect(combined_prompt.contains("Space burst"), "combined active prompt should keep the Space command visible")
	runner._expect(combined_prompt.contains("F: decoy ready"), "combined active prompt should keep the Decoy command compact")
	runner._expect(not combined_prompt.contains("Playtest data:"), "combined active prompt should not expose debug telemetry")

	main.decoy_pulse_used_this_run = true
	combined_prompt = "Explore, then return to base | %s | %s" % [
		UpgradeStateServiceScript.format_burst_thruster_prompt(main),
		UpgradeStateServiceScript.format_decoy_pulse_prompt(main),
	]
	runner._expect(combined_prompt.length() <= 68, "spent Decoy active prompt should stay compact")
	runner._expect(combined_prompt.contains("Decoy spent"), "spent Decoy active prompt should stay compact and explicit")

	runner._expect(HudPresenterScript.oxygen_state(30.0, 40.0) == "normal", "oxygen helper should treat safe oxygen as normal")
	runner._expect(HudPresenterScript.oxygen_state(10.0, 40.0) == "low", "oxygen helper should mark 25 percent oxygen as low")
	runner._expect(HudPresenterScript.oxygen_state(4.0, 40.0) == "critical", "oxygen helper should mark 10 percent oxygen as critical")
	runner._expect(HudPresenterScript.format_oxygen_label(10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	runner._expect(HudPresenterScript.format_oxygen_label(40.0, 40.0).begins_with("OXYGEN:"), "oxygen label should use instrument-style active HUD copy")
	runner._expect(HudPresenterScript.oxygen_warning_text("critical").contains("RETURN TO BASE"), "critical warning should emphasize the return route")
	runner._expect(HudPresenterScript.health_state(100.0, 100.0) == "normal", "health helper should treat full health as normal")
	runner._expect(HudPresenterScript.health_state(30.0, 100.0) == "low", "health helper should mark damaged health as low")
	runner._expect(HudPresenterScript.health_state(12.0, 100.0) == "critical", "health helper should mark near-failure health as critical")
	runner._expect(HudPresenterScript.format_health_label(30.0, 100.0).contains("LOW"), "health label should carry low state inline")
	main.free()

func _test_visual_smoke_bridge(runner) -> void:
	var visible_state := {
		"available": true,
		"player_visible": true,
		"visual_root_visible": true,
		"sprite_visible": true,
		"sprite_has_texture": true,
		"sprite_alpha": 0.5,
	}
	runner._expect(VisualSmokeBridgeScript.player_rendered(visible_state), "visual smoke bridge should report a visible textured player as rendered")

	var transparent_state := visible_state.duplicate()
	transparent_state["sprite_alpha"] = 0.25
	runner._expect(not VisualSmokeBridgeScript.player_rendered(transparent_state), "visual smoke bridge should require a player sprite alpha above the visibility threshold")

	var missing_texture_state := visible_state.duplicate()
	missing_texture_state["sprite_has_texture"] = false
	runner._expect(not VisualSmokeBridgeScript.player_rendered(missing_texture_state), "visual smoke bridge should not report an untextured player as rendered")

	runner._expect(not VisualSmokeBridgeScript.player_rendered({}), "visual smoke bridge should treat an unavailable player state as not rendered")

func _test_area01_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	var fallback := Vector2(123.0, 456.0)
	runner._expect(Area01VisualStagingServiceScript.generated_hook_visual_center(main, "MissingHook", fallback) == fallback, "Area 01 visual staging should use fallback hook positions when generated hook nodes are absent")

	main.visual_smoke_route_stage = ""
	Area01VisualStagingServiceScript.stage_shell_visual_review(main, "central_drop")
	runner._expect(main.visual_smoke_route_stage == "", "Area 01 visual staging should stay inert outside exported web visual-smoke runs")
	main.free()
