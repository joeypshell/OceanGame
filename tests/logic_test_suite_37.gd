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

func _test_mobile_touch_controls_adapter(runner) -> void:
	var main := MainScript.new()
	main.call("_ensure_mobile_touch_controls")
	runner._expect(main.get_node_or_null("MobileTouchControls") != null, "main scene should install a mobile touch input adapter")
	main.free()

	var controls := MobileTouchControlsScript.new() as CanvasLayer
	controls.call("_build_controls")
	if controls != null:
		var expected_default_visibility := OS.has_feature("mobile") or bool(controls.call("_web_touch_available"))
		runner._expect(bool(controls.call("should_show_touch_controls")) == expected_default_visibility, "touch controls should be visible on mobile/coarse-touch web and hidden on desktop")
		controls.set("force_visible", true)
		runner._expect(bool(controls.call("should_show_touch_controls")), "touch controls should support force-visible layout review")
		var root_node := controls.get_node_or_null("TouchControlsRoot") as Control
		var action_root := controls.get_node_or_null("TouchControlsRoot/ActionButtons") as Control
		var scan_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/ScanButton") as Button
		var use_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/InteractButton") as Button
		var burst_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/BurstThrusterButton") as Button
		var next_button := controls.get_node_or_null("TouchControlsRoot/ActionButtons/RestartDiveButton") as Button
		runner._expect(root_node != null, "touch controls should own one full-screen runner.root Control")
		runner._expect(action_root != null, "touch controls should group action buttons separately from movement")
		runner._expect(scan_button != null and scan_button.custom_minimum_size.x >= 48.0, "touch Scan button should meet mobile target sizing")
		runner._expect(use_button != null and use_button.text == "USE", "touch Use button should map to interact")
		runner._expect(burst_button != null and burst_button.text == "BURST", "touch Burst button should map to burst_thruster")
		runner._expect(next_button != null and next_button.text == "NEXT", "touch Next button should map to restart_dive")
		runner._expect(controls.get_node_or_null("TouchControlsRoot/MovePad") != null, "touch controls should include a visible movement pad")
		runner._expect(controls.get_node_or_null("TouchControlsRoot/MoveKnob") != null, "touch controls should include a visible movement knob")
		var requested_actions: Array[StringName] = []
		controls.connect("action_requested", func(action: StringName) -> void:
			requested_actions.append(action)
		)
		var released_actions: Array[StringName] = []
		controls.connect("action_released", func(action: StringName) -> void:
			released_actions.append(action)
		)
		scan_button.emit_signal("button_down")
		use_button.emit_signal("button_down")
		runner._expect(requested_actions == [&"scan", &"interact"], "touch action buttons should emit direct semantic gameplay requests")
		scan_button.emit_signal("button_up")
		runner._expect(released_actions == [&"scan"], "touch Scan button should emit release so held scanning can cancel")
	controls.free()

func _test_active_hud_final_polish_regression(runner) -> void:
	var main := MainScript.new()
	runner._expect(not HudVisibilityServiceScript.active_hud_visible_for_result(DiveSessionScript.Result.READY), "ready state should hide active operational HUD rows")
	runner._expect(HudVisibilityServiceScript.surface_hud_visible_for_result(DiveSessionScript.Result.READY), "ready state should show a surface panel")
	runner._expect(HudVisibilityServiceScript.active_hud_visible_for_result(DiveSessionScript.Result.DIVING), "diving state should show active operational HUD rows")
	runner._expect(not HudVisibilityServiceScript.surface_hud_visible_for_result(DiveSessionScript.Result.DIVING), "diving state should hide surface panels")
	runner._expect(not HudVisibilityServiceScript.active_hud_visible_for_result(DiveSessionScript.Result.EXTRACTED), "extracted result should hide active operational HUD rows")
	runner._expect(HudVisibilityServiceScript.surface_hud_visible_for_result(DiveSessionScript.Result.EXTRACTED), "extracted result should show a surface panel")
	runner._expect(not HudVisibilityServiceScript.active_hud_visible_for_result(DiveSessionScript.Result.FAILED), "failure result should hide active operational HUD rows")
	runner._expect(HudVisibilityServiceScript.surface_hud_visible_for_result(DiveSessionScript.Result.FAILED), "failure result should show a surface panel")

	main.show_debug_telemetry = false
	var hidden_summary: String = main.call("_format_run_summary", "Compact result check.", "extracted")
	runner._expect(not hidden_summary.contains("Playtest data:"), "result summary should hide debug telemetry by default")
	runner._expect(not hidden_summary.contains("Seed:"), "result summary should hide raw seed by default")

	main.show_debug_telemetry = true
	var debug_summary: String = main.call("_format_run_summary", "Debug result check.", "extracted")
	runner._expect(debug_summary.contains("Playtest data:"), "result summary should expose debug telemetry only when enabled")
	runner._expect(debug_summary.contains("Seed:"), "debug telemetry should include raw seed only when enabled")
	main.free()

	var main_scene := MainScene.instantiate()
	runner.root.add_child(main_scene)

	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var cargo_panel: Panel = main_scene.get_node("HUD/CargoPanel")
	var survival_panel: Panel = main_scene.get_node("HUD/SurvivalNeedsPanel")
	var scan_card_panel: Panel = main_scene.get_node("HUD/ScanCardPanel")
	var tool_belt_panel: Panel = main_scene.get_node("HUD/ToolBeltPanel")
	var minimap_panel: Panel = main_scene.get_node("HUD/MinimapPanel")
	var oxygen_label: Label = main_scene.get_node("HUD/Oxygen")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var run_panel: Panel = main_scene.get_node("HUD/RunPanel")

	runner._expect(not active_panel.visible, "raw scene should start with the active stats panel hidden")
	runner._expect(not cargo_panel.visible, "raw scene should start with the active cargo panel hidden")
	runner._expect(not survival_panel.visible, "raw scene should start with the active survival panel hidden")
	runner._expect(not scan_card_panel.visible, "raw scene should start with the contextual scan card hidden")
	runner._expect(not tool_belt_panel.visible, "raw scene should start with the active tool belt hidden")
	runner._expect(not minimap_panel.visible, "raw scene should start with the active minimap hidden")
	runner._expect(not dive_info_panel.visible, "raw scene should start with the dive info panel hidden")
	runner._expect(run_panel.visible, "raw scene should keep the surface panel visible")
	runner._expect(oxygen_label.text.begins_with("OXYGEN:"), "active dive should use instrument-style oxygen label")
	runner._expect(scan_target_label.text == "none nearby", "active dive should use scan-card none-nearby copy")
	runner._expect(prompt_label.text.length() <= 72, "active prompt should stay short after HUD final polish")

	main_scene.queue_free()

func _test_burst_thruster_movement_helper(runner) -> void:
	var player := PlayerScript.new()
	player.burst(Vector2.DOWN, 700.0)
	runner._expect(player.velocity == Vector2.DOWN * 700.0, "burst should set velocity in the requested direction")

	player.burst(Vector2.ZERO, 500.0)
	runner._expect(player.velocity == Vector2.RIGHT * 500.0, "burst without input should use the last facing direction")
	player.free()

func _test_burst_thruster_action_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.dive_session.oxygen = 20.0

	DiveToolActionServiceScript.try_burst_thruster(main)

	runner._expect(main.player.velocity.length() > 0.0, "burst service should push the player")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 20.0 - main.burst_thruster_oxygen_cost), "burst service should drain the configured oxygen cost")
	runner._expect(is_equal_approx(main.burst_thruster_cooldown_remaining, main.burst_thruster_cooldown_seconds), "burst service should start the cooldown")
	runner._expect(main.status_label.text.contains("Burst Thruster"), "burst service should publish concise status feedback")

	var oxygen_after_burst: float = main.dive_session.oxygen
	DiveToolActionServiceScript.try_burst_thruster(main)
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_burst), "burst service should not drain oxygen while cooling down")
	runner._expect(main.status_label.text.contains("cooling down"), "burst service should report cooldown lockout")
	main.queue_free()

func _test_expanded_region_world_bounds(runner) -> void:
	var player := PlayerScript.new()
	runner._expect(player.world_bounds.position.x <= 100.0, "expanded bounds should preserve the current main descent column")
	runner._expect(player.world_bounds.end.x >= 2000.0, "expanded bounds should allow roughly one extra screen of right-side exploration")
	runner._expect(player.world_bounds.position.y >= 240.0, "expanded bounds should keep the sub below the boat hull")
	runner._expect(player.world_bounds.end.y >= 2350.0, "expanded bounds should allow the first lower connector beyond East Shelf")
	runner._expect(player.world_bounds.end.x >= 2520.0, "expanded bounds should allow the short Blackwater Sill route")
	runner._expect(player.world_bounds.end.x >= 2980.0, "expanded bounds should allow the first Dusk Trench continuation beyond Blackwater")
	runner._expect(player.world_bounds.end.x >= 3180.0, "expanded bounds should allow the short Hollow Reef interior lane")
	runner._expect(player.world_bounds.end.x >= 3820.0, "expanded bounds should allow the first wider chamber beyond Hollow Reef")
	runner._expect(player.world_bounds.end.x >= 4300.0, "expanded bounds should allow the Mirror Kelp Pass branch beyond Wide Reef Chamber")
	runner._expect(player.world_bounds.end.x >= 5400.0, "expanded bounds should allow the first Outer Shelf route footprint")
	runner._expect(player.world_bounds.end.x <= 5450.0, "expanded bounds should include Area 02 without implying a full open ocean")
	runner._expect(player.world_bounds.end.y >= 2500.0, "expanded bounds should allow the first Silt Vein Fork scaffold below Blue Chimney")
	runner._expect(player.world_bounds.end.y >= 2700.0, "expanded bounds should allow the short Blackwater Sill route")
	runner._expect(player.world_bounds.end.y >= 3040.0, "expanded bounds should allow the first Dusk Trench continuation below Blackwater")
	runner._expect(player.world_bounds.end.y >= 3160.0, "expanded bounds should allow the first wider Hollow Reef chamber")
	runner._expect(player.world_bounds.end.y >= 3260.0, "expanded bounds should allow the Mirror Kelp Pass branch floor")
	runner._expect(player.world_bounds.end.y >= 3380.0, "expanded bounds should allow the first Outer Shelf low rim")
	runner._expect(player.world_bounds.end.y <= 3450.0, "expanded bounds should avoid implying a full lower biome")

	var clamped_high := player.clamp_position_to_world_bounds(Vector2(640.0, 0.0))
	runner._expect(clamped_high.y >= player.world_bounds.position.y, "world clamp should prevent surfacing through the boat sprite")

	var clamped_right := player.clamp_position_to_world_bounds(Vector2(5600.0, 900.0))
	runner._expect(is_equal_approx(clamped_right.x, player.world_bounds.end.x), "world clamp should stop at the expanded right edge")

	var clamped_blue_chimney := player.clamp_position_to_world_bounds(Vector2(2112.0, 2190.0))
	runner._expect(is_equal_approx(clamped_blue_chimney.x, 2112.0), "world clamp should keep Blue Chimney Pocket horizontally playable")
	runner._expect(is_equal_approx(clamped_blue_chimney.y, 2190.0), "world clamp should keep Blue Chimney Pocket vertically playable")

	var clamped_silt_vein_fork := player.clamp_position_to_world_bounds(Vector2(2160.0, 2490.0))
	runner._expect(is_equal_approx(clamped_silt_vein_fork.x, 2160.0), "world clamp should keep Silt Vein Fork horizontally playable")
	runner._expect(is_equal_approx(clamped_silt_vein_fork.y, 2490.0), "world clamp should keep Silt Vein Fork vertically playable")
	var clamped_blackwater_sill := player.clamp_position_to_world_bounds(Vector2(2440.0, 2660.0))
	runner._expect(is_equal_approx(clamped_blackwater_sill.x, 2440.0), "world clamp should keep the Blackwater Sill horizontally playable")
	runner._expect(is_equal_approx(clamped_blackwater_sill.y, 2660.0), "world clamp should keep the Blackwater Sill vertically playable")
	var clamped_dusk_trench := player.clamp_position_to_world_bounds(Vector2(2900.0, 3000.0))
	runner._expect(is_equal_approx(clamped_dusk_trench.x, 2900.0), "world clamp should keep the Dusk Trench horizontally playable")
	runner._expect(is_equal_approx(clamped_dusk_trench.y, 3000.0), "world clamp should keep the Dusk Trench vertically playable")
	var clamped_hollow_reef := player.clamp_position_to_world_bounds(Vector2(2940.0, 3040.0))
	runner._expect(is_equal_approx(clamped_hollow_reef.x, 2940.0), "world clamp should keep the Hollow Reef side-cave mouth horizontally playable")
	runner._expect(is_equal_approx(clamped_hollow_reef.y, 3040.0), "world clamp should keep the Hollow Reef side-cave turnback vertically playable")
	var clamped_hollow_reef_lane := player.clamp_position_to_world_bounds(Vector2(3180.0, 3056.0))
	runner._expect(is_equal_approx(clamped_hollow_reef_lane.x, 3180.0), "world clamp should keep the short Hollow Reef interior lane endpoint horizontally playable")
	runner._expect(is_equal_approx(clamped_hollow_reef_lane.y, 3056.0), "world clamp should keep the short Hollow Reef interior lane endpoint vertically playable")
	var clamped_wide_reef_chamber := player.clamp_position_to_world_bounds(Vector2(3800.0, 3136.0))
	runner._expect(is_equal_approx(clamped_wide_reef_chamber.x, 3800.0), "world clamp should keep the first wide Hollow Reef chamber horizontally playable")
	runner._expect(is_equal_approx(clamped_wide_reef_chamber.y, 3136.0), "world clamp should keep the first wide Hollow Reef chamber vertically playable")
	var clamped_mirror_kelp_pass := player.clamp_position_to_world_bounds(Vector2(4300.0, 3260.0))
	runner._expect(is_equal_approx(clamped_mirror_kelp_pass.x, 4300.0), "world clamp should keep Mirror Kelp Pass horizontally playable")
	runner._expect(is_equal_approx(clamped_mirror_kelp_pass.y, 3260.0), "world clamp should keep Mirror Kelp Pass vertically playable")
	var clamped_outer_shelf := player.clamp_position_to_world_bounds(Vector2(5240.0, 3380.0))
	runner._expect(is_equal_approx(clamped_outer_shelf.x, 5240.0), "world clamp should keep the first Outer Shelf footprint horizontally playable")
	runner._expect(is_equal_approx(clamped_outer_shelf.y, 3380.0), "world clamp should keep the first Outer Shelf footprint vertically playable")

	var clamped_left := player.clamp_position_to_world_bounds(Vector2(-80.0, 900.0))
	runner._expect(is_equal_approx(clamped_left.x, -80.0), "world clamp should keep the planned left-side Area 01 lane playable")
	player.free()

	var main_scene := MainScene.instantiate()
	var camera := main_scene.get_node("Player/Camera2D") as Camera2D
	runner._expect(camera.limit_right >= 6120, "camera limit should frame the first Outer Shelf footprint")
	runner._expect(camera.limit_bottom >= 3340, "camera limit should include the lower edge of Mirror Kelp Pass")
	runner._expect(camera.limit_right <= 6240, "camera limit should stay tight around the first Outer Shelf footprint")
	runner._expect(camera.limit_bottom <= 3380, "camera limit should avoid implying a full lower biome")
	var sky := main_scene.get_node("Sky") as ColorRect
	var ocean_shallows := main_scene.get_node("OceanShallows") as ColorRect
	var ocean_midwater := main_scene.get_node("OceanMidwater") as ColorRect
	var ocean_deep := main_scene.get_node("OceanDeep") as ColorRect
	var surface_line := main_scene.get_node("SurfaceLine") as ColorRect
	var deep_pressure_haze := main_scene.get_node("DeepPressureHaze") as Polygon2D
	runner._expect(sky.offset_right >= float(camera.limit_right), "sky backdrop should cover the expanded camera width")
	runner._expect(ocean_shallows.offset_right >= float(camera.limit_right), "shallow ocean backdrop should cover the expanded camera width")
	runner._expect(ocean_midwater.offset_right >= float(camera.limit_right), "midwater backdrop should cover the expanded camera width")
	runner._expect(ocean_deep.offset_right >= float(camera.limit_right), "deep ocean backdrop should cover the Dusk Trench camera width")
	runner._expect(ocean_deep.offset_bottom >= float(camera.limit_bottom), "deep ocean backdrop should cover the Dusk Trench camera bottom")
	runner._expect(surface_line.offset_right >= float(camera.limit_right), "surface line should extend across the playable camera width")
	var haze_right := -1.0
	var haze_bottom := -1.0
	for point in deep_pressure_haze.polygon:
		haze_right = maxf(haze_right, point.x)
		haze_bottom = maxf(haze_bottom, point.y)
	runner._expect(haze_right >= float(camera.limit_right), "deep pressure haze should cover the Dusk Trench camera width")
	runner._expect(haze_bottom >= float(camera.limit_bottom), "deep pressure haze should cover the Dusk Trench camera bottom")
	main_scene.free()

func _test_expanded_region_base_direction(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = main.start_position + Vector2(860.0, 640.0)
	var side_route_direction: String = main.call("_format_base_direction")
	runner._expect(side_route_direction.contains("up-left"), "base direction should point up-left from the expanded right-side route")

	scene_player.global_position = Vector2(2440.0, 2660.0)
	var blackwater_direction: String = main.call("_format_base_direction")
	runner._expect(blackwater_direction.contains("up-left"), "base direction should point up-left from the Blackwater Sill")
	runner._expect(blackwater_direction.contains("Silt/Blue"), "base direction should compactly name the Blackwater return landmark chain")
	runner._expect(not blackwater_direction.contains("Dusk"), "base direction should not name Dusk until the player reaches the new continuation")

	scene_player.global_position = Vector2(2900.0, 3000.0)
	var dusk_direction: String = main.call("_format_base_direction")
	runner._expect(dusk_direction.contains("up-left"), "base direction should point up-left from the Dusk Trench")
	runner._expect(dusk_direction.contains("Dusk/Blackwater"), "base direction should compactly name the Dusk return landmark chain")
	runner._expect(not dusk_direction.contains("Hollow"), "base direction should not name Hollow Reef before the player reaches the side-cave/wide chamber band")

	scene_player.global_position = Vector2(3700.0, 2964.0)
	var wide_chamber_direction: String = main.call("_format_base_direction")
	runner._expect(wide_chamber_direction.contains("up-left"), "base direction should point up-left from the wide chamber")
	runner._expect(wide_chamber_direction.contains("Hollow/Dusk/Blackwater"), "base direction should compactly name the wide chamber return route chain")
	runner._expect(not wide_chamber_direction.contains("Silt/Blue"), "wide chamber base direction should avoid crowding the HUD with the full lower-route chain")

	scene_player.global_position = Vector2(4300.0, 3260.0)
	var mirror_kelp_direction: String = main.call("_format_base_direction")
	runner._expect(mirror_kelp_direction.contains("up-left"), "base direction should point up-left from Mirror Kelp Pass")
	runner._expect(mirror_kelp_direction.contains("Hollow/Dusk/Blackwater"), "Mirror Kelp Pass base direction should reuse the broad chamber return route chain")
	runner._expect(not mirror_kelp_direction.contains("Silt/Blue"), "Mirror Kelp Pass base direction should avoid crowding the HUD with the full lower-route chain")

	scene_player.global_position = main.start_position + Vector2(0.0, 500.0)
	var vertical_direction: String = main.call("_format_base_direction")
	runner._expect(vertical_direction.begins_with("Base: up "), "base direction should preserve simple upward return copy in the main column")

	scene_player.global_position = main.start_position
	runner._expect(main.call("_format_base_direction") == "Base: here", "base direction should still read here at the surface base")
	main.queue_free()
