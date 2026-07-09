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

func _test_area_01_first_art_slice_scene_contract(runner) -> void:
	var main := MainScene.instantiate()
	var slice_paths := [
		"Area01ArtSlice",
		"Area01ArtSlice/BackgroundFar",
		"Area01ArtSlice/BackgroundFar/FarLeftReefMass",
		"Area01ArtSlice/BackgroundFar/FarRightReefMass",
		"Area01ArtSlice/BackgroundFar/FarCenterDepthPocket",
		"Area01ArtSlice/OceanParallaxBackground",
		"Area01ArtSlice/OceanParallaxBackground/FarOpenWaterPocket",
		"Area01ArtSlice/OceanParallaxBackground/FarLeftReefWall",
		"Area01ArtSlice/OceanParallaxBackground/FarRightReefWall",
		"Area01ArtSlice/OceanParallaxBackground/MidLeftRidge",
		"Area01ArtSlice/OceanParallaxBackground/MidCenterBackPlate",
		"Area01ArtSlice/OceanParallaxBackground/MidRightRidge",
		"Area01ArtSlice/OceanParallaxBackground/DeepCenterSilhouette",
		"Area01ArtSlice/OceanLightingStack",
		"Area01ArtSlice/OceanLightingStack/SurfaceGlow",
		"Area01ArtSlice/OceanLightingStack/ShallowBlueWash",
		"Area01ArtSlice/OceanLightingStack/MidDepthCyanWash",
		"Area01ArtSlice/OceanLightingStack/DeepBlueHaze",
		"Area01ArtSlice/OceanLightingStack/CenterPlayLight",
		"Area01ArtSlice/OceanLightingStack/SunShaftBroad",
		"Area01ArtSlice/OceanLightingStack/CausticRibbonA",
		"Area01ArtSlice/OceanLightingStack/LeftEdgeVignette",
		"Area01ArtSlice/OceanLightingStack/RightEdgeVignette",
		"Area01ArtSlice/BackgroundMid",
		"Area01ArtSlice/BackgroundMid/LeftMidWallShadow",
		"Area01ArtSlice/BackgroundMid/RightMidWallShadow",
		"Area01ArtSlice/WaterLightShafts",
		"Area01ArtSlice/TerrainBackWalls",
		"Area01ArtSlice/TerrainBackWalls/ShallowLeftWall",
		"Area01ArtSlice/TerrainBackWalls/ShallowRightWall",
		"Area01ArtSlice/TerrainBackWalls/LeftSolidWall",
		"Area01ArtSlice/TerrainBackWalls/RightSolidWall",
		"Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass",
		"Area01ArtSlice/TerrainBackWalls/BlockoutLowerBasinFloor",
		"Area01ArtSlice/TerrainBackWalls/BlockoutWestCaveShelf",
		"Area01ArtSlice/TerrainBackWalls/BlockoutLeftChamberCeiling",
		"Area01ArtSlice/TerrainBackWalls/BlockoutRightChamberShelf",
		"Area01ArtSlice/TerrainBackWalls/BlockoutFarWestShelfMass",
		"Area01ArtSlice/TerrainBackWalls/BlockoutMidCrossingCeiling",
		"Area01ArtSlice/TerrainBackWalls/BlockoutDeepSpineFloor",
		"Area01ArtSlice/TerrainBackWalls/BlockoutFarRightPocketWall",
		"Area01ArtSlice/TerrainCollision",
		"Area01ArtSlice/TerrainCollision/ShallowLeftWallCollision",
		"Area01ArtSlice/TerrainCollision/ShallowRightWallCollision",
		"Area01ArtSlice/TerrainCollision/LeftWallCollision",
		"Area01ArtSlice/TerrainCollision/RightWallCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutEastReefCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutLowerBasinCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutWestCaveShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutLeftChamberCeilingCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutRightChamberShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutFarWestShelfCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutMidCrossingCeilingCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutDeepSpineFloorCollision",
		"Area01ArtSlice/TerrainCollision/BlockoutFarRightPocketWallCollision",
		"Area01ArtSlice/TerrainVisualEdges",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/ShallowLeftBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/ShallowRightBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftWallBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightWallBlockingRim",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftLedgeBlockingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightLedgeBlockingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLowerBasinLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutWestCaveShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLeftChamberCeilingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutRightChamberShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarWestShelfLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutMidCrossingCeilingLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutDeepSpineFloorLip",
		"Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarRightPocketWallLip",
		"Area01ArtSlice/TerrainVisualEdges/ShallowLeftLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/ShallowRightLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeLitEdge",
		"Area01ArtSlice/TerrainVisualEdges/LeftWallReefKit",
		"Area01ArtSlice/TerrainVisualEdges/RightWallReefKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeReefKit",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeReefKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/MainShelfMass",
		"Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/TopLitLip",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit/MainShelfMass",
		"Area01ArtSlice/TerrainVisualEdges/RightShelfPlatformKit/TopLitLip",
		"Area01ArtSlice/TerrainVisualEdges/ShallowLeftPlatformKit",
		"Area01ArtSlice/TerrainVisualEdges/ShallowRightPlatformKit",
		"Area01ArtSlice/GameplayObjects",
		"Area01ArtSlice/GameplayObjects/CargoPocketGlow",
		"Area01ArtSlice/GameplayObjects/ScanFocusPocket",
		"Area01ArtSlice/GameplayObjects/LeftShallowResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightShelfResourcePocket",
		"Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightDeepResourcePocket",
		"Area01ArtSlice/GameplayObjects/LeftChamberResourcePocket",
		"Area01ArtSlice/GameplayObjects/RightChamberResourcePocket",
		"Area01ArtSlice/ForegroundDecor",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/KelpFrondA",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/CoralFan",
		"Area01ArtSlice/ForegroundDecor/LeftShelfDressing/DimCrystalA",
		"Area01ArtSlice/ForegroundDecor/LeftCaveDressing",
		"Area01ArtSlice/ForegroundDecor/RightShelfDressing",
		"Area01ArtSlice/ForegroundDecor/RightDeepDressing",
		"Area01ArtSlice/ForegroundDecor/CentralDropDressing",
	]
	for path in slice_paths:
		runner._expect(main.get_node_or_null(path) != null, "Area 01 art slice should include %s" % path)

	var old_debug_shell := main.get_node("SafeShallowsExplorationShell") as Node2D
	runner._expect(not old_debug_shell.visible, "old Safe Shallows exploration shell should stay hidden behind the first real art slice")
	var left_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/LeftSolidWall") as Polygon2D
	var right_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/RightSolidWall") as Polygon2D
	var shallow_left_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/ShallowLeftWall") as Polygon2D
	var shallow_right_wall := main.get_node("Area01ArtSlice/TerrainBackWalls/ShallowRightWall") as Polygon2D
	var shallow_left_collision := main.get_node("Area01ArtSlice/TerrainCollision/ShallowLeftWallCollision") as CollisionPolygon2D
	var shallow_right_collision := main.get_node("Area01ArtSlice/TerrainCollision/ShallowRightWallCollision") as CollisionPolygon2D
	var blockout_east_reef := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass") as Polygon2D
	var blockout_lower_basin := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutLowerBasinFloor") as Polygon2D
	var blockout_west_cave := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutWestCaveShelf") as Polygon2D
	var blockout_left_chamber := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutLeftChamberCeiling") as Polygon2D
	var blockout_right_chamber := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutRightChamberShelf") as Polygon2D
	var blockout_far_west := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutFarWestShelfMass") as Polygon2D
	var blockout_mid_crossing := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutMidCrossingCeiling") as Polygon2D
	var blockout_deep_spine := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutDeepSpineFloor") as Polygon2D
	var blockout_far_right := main.get_node("Area01ArtSlice/TerrainBackWalls/BlockoutFarRightPocketWall") as Polygon2D
	var blockout_east_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutEastReefCollision") as CollisionPolygon2D
	var blockout_lower_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutLowerBasinCollision") as CollisionPolygon2D
	var blockout_west_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutWestCaveShelfCollision") as CollisionPolygon2D
	var blockout_left_chamber_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutLeftChamberCeilingCollision") as CollisionPolygon2D
	var blockout_right_chamber_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutRightChamberShelfCollision") as CollisionPolygon2D
	var blockout_far_west_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutFarWestShelfCollision") as CollisionPolygon2D
	var blockout_mid_crossing_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutMidCrossingCeilingCollision") as CollisionPolygon2D
	var blockout_deep_spine_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutDeepSpineFloorCollision") as CollisionPolygon2D
	var blockout_far_right_collision := main.get_node("Area01ArtSlice/TerrainCollision/BlockoutFarRightPocketWallCollision") as CollisionPolygon2D
	var far_center := main.get_node("Area01ArtSlice/BackgroundFar/FarCenterDepthPocket") as Polygon2D
	var far_open_water := main.get_node("Area01ArtSlice/OceanParallaxBackground/FarOpenWaterPocket") as Polygon2D
	var mid_center_plate := main.get_node("Area01ArtSlice/OceanParallaxBackground/MidCenterBackPlate") as Polygon2D
	var deep_center_silhouette := main.get_node("Area01ArtSlice/OceanParallaxBackground/DeepCenterSilhouette") as Polygon2D
	var surface_glow := main.get_node("Area01ArtSlice/OceanLightingStack/SurfaceGlow") as Polygon2D
	var deep_haze := main.get_node("Area01ArtSlice/OceanLightingStack/DeepBlueHaze") as Polygon2D
	var center_play_light := main.get_node("Area01ArtSlice/OceanLightingStack/CenterPlayLight") as Polygon2D
	var collision_read_boundaries := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries") as Node2D
	var left_wall_blocking_rim := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftWallBlockingRim") as Polygon2D
	var right_wall_blocking_rim := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightWallBlockingRim") as Polygon2D
	var left_ledge_blocking_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/LeftLedgeBlockingLip") as Polygon2D
	var right_ledge_blocking_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RightLedgeBlockingLip") as Polygon2D
	var blockout_east_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip") as Polygon2D
	var blockout_lower_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLowerBasinLip") as Polygon2D
	var blockout_west_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutWestCaveShelfLip") as Polygon2D
	var blockout_left_chamber_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutLeftChamberCeilingLip") as Polygon2D
	var blockout_right_chamber_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutRightChamberShelfLip") as Polygon2D
	var blockout_far_west_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarWestShelfLip") as Polygon2D
	var blockout_mid_crossing_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutMidCrossingCeilingLip") as Polygon2D
	var blockout_deep_spine_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutDeepSpineFloorLip") as Polygon2D
	var blockout_far_right_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutFarRightPocketWallLip") as Polygon2D
	var left_platform_mass := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/MainShelfMass") as Polygon2D
	var left_platform_lip := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit/TopLitLip") as Polygon2D
	var dressing_crystal := main.get_node("Area01ArtSlice/ForegroundDecor/LeftShelfDressing/DimCrystalA") as Polygon2D
	var dressing_coral := main.get_node("Area01ArtSlice/ForegroundDecor/LeftShelfDressing/CoralFan") as Polygon2D
	var cargo_slot := main.get_node("Area01ArtSlice/GameplayObjects/CargoPocketGlow") as Polygon2D
	var background_study := main.get_node("ShallowMidwaterBackgroundStudy") as Sprite2D
	var route_choice_band := main.get_node("RouteChoiceBand") as Node2D
	runner._expect(left_wall.color.a >= 0.9, "primary art-slice walls should read as solid terrain instead of translucent route overlays")
	runner._expect(right_wall.color.a >= 0.9, "primary art-slice walls should read as solid terrain instead of translucent route overlays")
	runner._expect(not shallow_left_wall.visible and not shallow_right_wall.visible and shallow_left_collision.disabled and shallow_right_collision.disabled, "upper open water should not contain invisible shallow-wall blockers")
	runner._expect(blockout_east_reef.color.a >= 0.9 and blockout_lower_basin.color.a >= 0.9 and blockout_west_cave.color.a >= 0.9, "larger Area 01 blockout masses should read as solid reef terrain")
	runner._expect(not blockout_east_collision.disabled and not blockout_lower_collision.disabled and not blockout_west_collision.disabled, "larger Area 01 blockout collision should stay enabled only where matching terrain is visible")
	runner._expect(blockout_left_chamber.color.a >= 0.9 and blockout_right_chamber.color.a >= 0.9, "new Area 01 chamber masses should read as solid reef terrain")
	runner._expect(not blockout_left_chamber_collision.disabled and not blockout_right_chamber_collision.disabled, "new Area 01 chamber collision should stay enabled only where matching terrain is visible")
	runner._expect(blockout_far_west.color.a >= 0.9 and blockout_mid_crossing.color.a >= 0.9 and blockout_deep_spine.color.a >= 0.9 and blockout_far_right.color.a >= 0.9, "expanded multi-screen Area 01 masses should read as solid reef terrain")
	runner._expect(not blockout_far_west_collision.disabled and not blockout_mid_crossing_collision.disabled and not blockout_deep_spine_collision.disabled and not blockout_far_right_collision.disabled, "expanded Area 01 terrain collision should stay enabled only where matching terrain is visible")
	runner._expect(far_center.color.a < left_wall.color.a, "background pocket should sit behind solid terrain in opacity hierarchy")
	runner._expect(far_open_water.color.a < left_wall.color.a, "parallax open-water pockets should stay quieter than solid terrain")
	runner._expect(mid_center_plate.color.a > far_open_water.color.a, "mid parallax plates should be slightly stronger than far open-water pockets")
	runner._expect(deep_center_silhouette.color.a < left_wall.color.a, "deep parallax silhouettes should add depth without competing with walls")
	runner._expect(surface_glow.color.b > deep_haze.color.b, "ocean lighting stack should grade from brighter surface water into deeper blue haze")
	runner._expect(deep_haze.color.a > surface_glow.color.a, "deep haze should become more present than the surface glow at depth")
	runner._expect(center_play_light.color.a <= 0.2, "center play light should support focal readability without becoming a solid overlay")
	runner._expect(left_wall_blocking_rim.color.a >= 0.7 and right_wall_blocking_rim.color.a >= 0.7, "wall collision rims should be readable enough that solid terrain does not feel random")
	runner._expect(left_ledge_blocking_lip.color.a >= 0.6 and right_ledge_blocking_lip.color.a >= 0.6, "ledge collision lips should show where the player will bump")
	runner._expect(blockout_east_lip.color.a >= 0.6 and blockout_lower_lip.color.a >= 0.6 and blockout_west_lip.color.a >= 0.6, "larger blockout terrain should expose visible lips before the player collides")
	runner._expect(blockout_left_chamber_lip.color.a >= 0.6 and blockout_right_chamber_lip.color.a >= 0.6, "new Area 01 chamber terrain should expose visible lips before the player collides")
	runner._expect(blockout_far_west_lip.color.a >= 0.6 and blockout_mid_crossing_lip.color.a >= 0.6 and blockout_deep_spine_lip.color.a >= 0.6 and blockout_far_right_lip.color.a >= 0.6, "expanded multi-screen terrain should expose visible lips before the player collides")
	runner._expect(left_wall_blocking_rim.color.a < left_wall.color.a and right_wall_blocking_rim.color.a < right_wall.color.a, "collision rims should clarify terrain without replacing the solid mass")
	runner._expect(collision_read_boundaries.find_child("CollisionShape2D", true, false) == null, "collision-read boundary visuals should not add extra hidden collision")
	runner._expect(left_platform_mass.color.a >= 0.8, "platform kit shelf masses should read as solid reef rather than route overlays")
	runner._expect(left_platform_lip.color.a < left_platform_mass.color.a, "platform kit lip highlights should support terrain edges without becoming the solid mass")
	runner._expect(dressing_crystal.color.a < cargo_slot.color.a, "decorative crystals should stay quieter than cargo-object glows")
	runner._expect(dressing_coral.color.a < left_platform_mass.color.a, "decorative coral should enrich shelves without competing with terrain masses")
	runner._expect(cargo_slot.color.a < left_wall.color.a, "gameplay object slots should not look like solid terrain")
	runner._expect(not background_study.visible, "old broad background study should not paint rocky texture across normal-play water")
	runner._expect(background_study.modulate.a <= 0.06, "old broad background study should stay very faint if temporarily enabled for review")
	runner._expect(not route_choice_band.visible, "route-choice review band should stay hidden by default so the first art slice reads as a place, not a diagram")
	main.free()
