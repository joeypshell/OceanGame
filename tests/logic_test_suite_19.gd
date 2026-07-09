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

func _test_area_01_surface_oxygen_hook_runtime(runner) -> void:
	var scene := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(scene), "Area 01 runtime source map should build before wiring surface oxygen: %s" % builder.last_error)
	scene.player = scene.get_node("Player") as CharacterBody2D
	scene.call("_wire_surface_oxygen_refill_zone")
	var oxygen_area := scene.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/SurfaceOxygenRefillZoneArea") as Area2D
	var offload_area := scene.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/ShipOffloadZoneArea") as Area2D
	runner._expect(oxygen_area != null, "live Area 01 scene should include the generated surface oxygen hook")
	runner._expect(offload_area != null, "live Area 01 scene should keep the generated ship offload hook separate")
	if oxygen_area == null or offload_area == null:
		scene.free()
		return

	var oxygen_collision := oxygen_area.get_node_or_null("SurfaceOxygenRefillZoneTrigger") as CollisionPolygon2D
	var offload_collision := offload_area.get_node_or_null("ShipOffloadZoneTrigger") as CollisionPolygon2D
	runner._expect(oxygen_area.monitoring, "surface oxygen hook should be promoted to active Area2D monitoring")
	runner._expect(not oxygen_area.monitorable, "surface oxygen hook should not become a blocking/monitorable target")
	runner._expect(oxygen_area.collision_mask == 1, "surface oxygen hook should monitor the player collision layer")
	runner._expect(oxygen_collision != null and not oxygen_collision.disabled, "surface oxygen trigger collision should be enabled for refill detection")
	runner._expect(not offload_area.monitoring, "generated ship offload hook should stay inert until ship offload behavior is implemented")
	runner._expect(offload_collision != null and offload_collision.disabled, "ship offload hook should not duplicate BaseZone banking")
	if oxygen_collision != null:
		var oxygen_bottom := -INF
		for point in oxygen_collision.polygon:
			oxygen_bottom = maxf(oxygen_bottom, point.y)
		runner._expect(oxygen_bottom >= 320.0, "surface oxygen trigger should reach the current diver surface clamp")

	scene.dive_session.start()
	scene.dive_session.oxygen = 5.0
	scene.dive_session.has_left_base = true
	scene.dive_session.current_cargo.clear()
	scene.dive_session.current_cargo.append("driftwood")
	scene.player.global_position = Vector2(1600.0, scene.call("_surface_oxygen_refill_floor_y") - 44.0)
	scene.player_in_base = false
	scene.call("_sync_surface_oxygen_refill_state_from_position")
	var banked_before: int = scene.progression_state.resource_count("driftwood")
	scene.call("_update_active_dive_oxygen", 1.0)
	runner._expect(scene.dive_session.oxygen > 5.0, "surface away from ship should refill oxygen")
	runner._expect(scene.dive_session.current_cargo == ["driftwood"], "surface away from ship should leave carried cargo in inventory")
	runner._expect(scene.progression_state.resource_count("driftwood") == banked_before, "surface away from ship should not bank resources")
	runner._expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "surface away from ship should keep the active dive running")

	var surface_oxygen: float = scene.dive_session.oxygen
	scene.player.global_position = Vector2(1600.0, scene.call("_surface_oxygen_refill_floor_y") + 180.0)
	scene.call("_sync_surface_oxygen_refill_state_from_position")
	scene.call("_update_active_dive_oxygen", 1.0)
	runner._expect(scene.dive_session.oxygen < surface_oxygen, "leaving the surface refill band should resume oxygen drain")
	scene.free()

func _test_area_01_source_map_debug_overlay(runner) -> void:
	var overlay := Area01SourceMapOverlayScript.new()
	runner._expect(overlay.load_source_map(), "Area 01 source-map overlay should load the source map")
	var summary := overlay.source_map_summary()
	runner._expect(int(summary.get("solids", 0)) >= 13, "Area 01 source-map overlay should expose solid terrain count")
	runner._expect(int(summary.get("hooks", 0)) >= 11, "Area 01 source-map overlay should expose generated hook count")
	runner._expect(String(summary.get("map_id", "")) == "area_01_runtime_geometry_generated", "Area 01 source-map overlay should expose current generated map revision")
	runner._expect(String(summary.get("status", "")) == "generated_current", "Area 01 source-map overlay should report generated source-map authority")
	overlay.capture_state = "area01-central-drop"
	overlay.camera_state = "pos 640,420 zoom 0.60"
	runner._expect(overlay.capture_state.contains("area01"), "Area 01 source-map overlay should carry capture state for screenshots")
	runner._expect(overlay.camera_state.contains("zoom"), "Area 01 source-map overlay should carry camera state for screenshots")

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 source-map overlay diagnostic should use built runtime scene: %s" % builder.last_error)
	var truth_errors: Array[String] = overlay.call("_runtime_truth_errors", main)
	runner._expect(truth_errors.is_empty(), "Area 01 source-map overlay diagnostic should see no runtime truth errors: %s" % "\n".join(truth_errors))
	main.free()

	overlay.set_debug_visible(true)
	runner._expect(overlay.visible, "Area 01 source-map overlay should become visible only through debug control")
	overlay.set_debug_visible(false)
	runner._expect(not overlay.visible, "Area 01 source-map overlay should hide through debug control")
	overlay.free()

func _test_area_01_visual_director(runner) -> void:
	var host := Node2D.new()
	var director := Area01VisualDirectorScript.new()
	host.add_child(director)
	var overlay := director.sync_source_map_overlay(host, 96.0, false, true, "area01-central-drop", "pos 640,420 zoom 0.60")
	runner._expect(overlay != null, "Area 01 visual director should create the source-map overlay")
	runner._expect(overlay.scan_range == 96.0, "Area 01 visual director should own overlay scan range sync")
	runner._expect(overlay.capture_state == "area01-central-drop", "Area 01 visual director should own overlay capture-state sync")
	runner._expect(not overlay.visible, "Area 01 visual director should keep overlay hidden until debug is visible")

	director.sync_source_map_overlay(host, 120.0, true, true, "area01-west-chamber", "pos 800,420 zoom 0.60")
	runner._expect(director.source_map_overlay_visible(), "Area 01 visual director should expose overlay visibility")
	runner._expect(overlay.scan_range == 120.0, "Area 01 visual director should update existing overlay scan range")
	runner._expect(overlay.capture_state == "area01-west-chamber", "Area 01 visual director should update existing overlay capture state")

	var report := director.cue_debug_report(host)
	runner._expect(report.has("families"), "Area 01 visual director should expose cue-family diagnostics")
	host.free()
