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

func _test_east_shelf_spur_branch_scene_contract_part_4(runner) -> void:
	var main := MainScene.instantiate()
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D
	var dusk_lower_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowerTrenchShelf") as Polygon2D
	var dusk_return_current := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/ReturnCurrentUpLeft") as Polygon2D
	var low_visibility_cue := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue") as Node2D
	var low_visibility_veil := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D
	var low_visibility_band := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand") as Polygon2D
	var low_visibility_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA") as Polygon2D
	var glass_kelp_ledge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge") as Node2D
	var glass_kelp_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeMouth") as Polygon2D
	var glass_kelp_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/CalmPocketWater") as Polygon2D
	var glass_kelp_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/LedgeShelf") as Polygon2D
	var glass_kelp_frond_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/GlassKelpFrondA") as Polygon2D
	var glass_kelp_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReturnCurrentToTrench") as Polygon2D
	var glass_kelp_reading_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore") as Node2D
	var glass_kelp_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone") as Area2D
	var glass_kelp_reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard") as Polygon2D
	var glass_kelp_reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark") as Polygon2D
	var hollow_reef := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	var hollow_reef_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow") as Polygon2D
	var hollow_reef_rim := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim") as Polygon2D
	var hollow_reef_threshold := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ThresholdWater") as Polygon2D
	var hollow_reef_entrance := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceLip") as Polygon2D
	var hollow_reef_entrance_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/EntranceRibA") as Polygon2D
	var hollow_reef_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnCurrentToTrench") as Polygon2D

	runner._expect(dusk_lower_shelf.color.a >= 0.5, "Dusk Trench should have a readable lower shelf silhouette")
	runner._expect(dusk_return_current.color.a >= 0.18 and dusk_return_current.color.a <= 0.24, "Dusk Trench return current should be stronger after visual evidence without becoming a route arrow")
	runner._expect(dusk_return_current.polygon[1].x < dusk_return_current.polygon[0].x, "Dusk Trench return current should point back left toward Blackwater")
	runner._expect(dusk_return_current.polygon[1].y < dusk_return_current.polygon[0].y, "Dusk Trench return current should point upward toward Silt and Blue")
	runner._expect(low_visibility_cue.get_parent() == dusk_trench, "Dusk Trench low-visibility cue should inherit the existing route gate")
	runner._expect(low_visibility_cue.scene_file_path.ends_with("DuskLowVisibilityCue.tscn"), "Dusk Trench low-visibility cue should be a reusable readability scene")
	runner._expect(low_visibility_cue.position.x > 120.0, "Dusk Trench low-visibility cue should sit deeper in the trench instead of covering the return current")
	runner._expect(low_visibility_veil.color.a >= 0.2 and low_visibility_veil.color.a <= 0.3, "Dusk Trench low-visibility veil should be visible but not a hard hazard wall")
	runner._expect(low_visibility_veil.color.b > low_visibility_veil.color.g, "Dusk Trench low-visibility cue should use blue-violet pressure language")
	runner._expect(low_visibility_veil.color.g < dusk_return_current.color.g, "Dusk Trench low-visibility cue should stay distinct from safe-current green")
	runner._expect(low_visibility_band.color.b > low_visibility_band.color.g, "Dusk Trench silt band should reinforce dark low-visibility language")
	runner._expect(low_visibility_rib.color.b > low_visibility_rib.color.r, "Dusk Trench silt rib should not read as predator warning red or resource yellow")
	runner._expect(low_visibility_cue.get_node_or_null("InteractZone") == null, "Dusk Trench low-visibility cue should not add an interaction hotspot")
	runner._expect(low_visibility_cue.get_node_or_null("PressureBoundary") == null, "Dusk Trench low-visibility cue should not add a hidden pressure or oxygen boundary")
	runner._expect(low_visibility_cue.find_child("CollisionShape2D", true, false) == null, "Dusk Trench low-visibility cue should not add collision or knockback")
	runner._expect(dusk_trench.get_node_or_null("InteractZone") == null, "Dusk Trench scaffold should not add an interaction hotspot yet")
	runner._expect(dusk_trench.get_node_or_null("Interior") == null, "Dusk Trench scaffold should not add a cave interior system")
	runner._expect(glass_kelp_ledge.get_parent() == dusk_trench, "Glass Kelp Ledge should branch from the Dusk Trench route")
	runner._expect(glass_kelp_ledge.position.x > 0.0 and glass_kelp_ledge.position.y > 0.0, "Glass Kelp Ledge should sit off the lower trench, not inside Blackwater")
	runner._expect(glass_kelp_mouth.color.g > glass_kelp_mouth.color.r, "Glass Kelp Ledge should use cooler calm-pocket color language")
	runner._expect(glass_kelp_mouth.color.a >= 0.6, "Glass Kelp Ledge mouth should read clearly in the staged Dusk evidence")
	runner._expect(glass_kelp_water.color.a <= 0.3, "Glass Kelp calm water should read as a pause pocket, not a pressure hazard")
	runner._expect(glass_kelp_shelf.color.a >= 0.55, "Glass Kelp Ledge should have a readable safe shelf silhouette")
	runner._expect(glass_kelp_frond_a.color.g > glass_kelp_frond_a.color.r, "Glass Kelp fronds should visually distinguish the pocket from Blackwater pressure")
	runner._expect(glass_kelp_return.color.a >= 0.18 and glass_kelp_return.color.a <= 0.24, "Glass Kelp return current should be readable without becoming a checklist marker")
	runner._expect(glass_kelp_return.polygon[1].x < glass_kelp_return.polygon[0].x, "Glass Kelp Ledge return current should point back left toward the trench")
	runner._expect(glass_kelp_return.polygon[1].y < glass_kelp_return.polygon[0].y, "Glass Kelp Ledge return current should point upward toward Blackwater and Silt Vein")
	runner._expect(glass_kelp_reading_core.position.distance_to(glass_kelp_interact.position) >= 64.0, "Glass Kelp payoff marker should be offset from the hotspot so the sub does not cover it")
	runner._expect(glass_kelp_reading_shard.color.a >= 0.85, "Glass Kelp reading shard should start visibly recoverable in normal-scale evidence")
	runner._expect(glass_kelp_reading_spark.visible, "Glass Kelp reading spark should start visible before recovery")
	runner._expect(glass_kelp_ledge.get_node_or_null("InteractZone") != null, "Glass Kelp Ledge should expose one payoff hotspot")
	runner._expect(glass_kelp_ledge.get_node_or_null("ResourcePickup") == null, "Glass Kelp Ledge should not add a resource pickup")
	runner._expect(glass_kelp_ledge.get_node_or_null("Predator") == null, "Glass Kelp Ledge should not add a predator encounter")
	runner._expect(glass_kelp_ledge.get_node_or_null("PressureBoundary") == null, "Glass Kelp Ledge should not add a hidden pressure or oxygen boundary")
	runner._expect(hollow_reef.get_parent() == dusk_trench, "Hollow Reef should branch from the Dusk Trench route")
	runner._expect(hollow_reef.position.x > glass_kelp_ledge.position.x, "Hollow Reef should sit farther along the trench than the calm Glass Kelp ledge")
	runner._expect(hollow_reef.position.y > glass_kelp_ledge.position.y, "Hollow Reef should sit lower as the first cave-like branch")
	runner._expect(hollow_reef_mouth.color.a >= 0.65, "Hollow Reef cave mouth should read as explorable dark space")
	runner._expect(hollow_reef_rim.color.g > hollow_reef_rim.color.r, "Hollow Reef rim should use cool reef/cave color language")
	runner._expect(hollow_reef_threshold.color.a <= 0.3, "Hollow Reef threshold water should be visible without becoming a hard objective marker")
	runner._expect(hollow_reef_entrance.color.g > hollow_reef_entrance.color.r and hollow_reef_entrance.color.b > hollow_reef_entrance.color.r, "Hollow Reef entrance lip should read as cool threshold language, not predator or resource color")
	runner._expect(hollow_reef_entrance.color.a <= 0.3, "Hollow Reef entrance lip should stay quieter than scan targets and pickups")
	runner._expect(hollow_reef_entrance_rib.color.g > hollow_reef_entrance_rib.color.r, "Hollow Reef entrance rib should stay in safe/cave readability language")
	runner._expect(hollow_reef_return.color.a >= 0.14 and hollow_reef_return.color.a <= 0.16, "Hollow Reef return current should be readable without becoming checklist guidance")
	runner._expect(hollow_reef_return.polygon[1].x < hollow_reef_return.polygon[0].x, "Hollow Reef return current should point left back toward Dusk Trench")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_5(runner) -> void:
	var main := MainScene.instantiate()
	var blackwater_pressure_shutter := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var hollow_reef_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnCurrentToTrench") as Polygon2D
	var hollow_reef_exit_ribbon := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitReturnRibbon") as Polygon2D
	var hollow_reef_return_chain := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainToDusk") as Polygon2D
	var hollow_reef_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibA") as Polygon2D
	var hollow_reef_return_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReturnChainRibB") as Polygon2D
	var hollow_reef_return_fleck := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DuskReturnFleck") as Polygon2D
	var hollow_reef_exit_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitRib") as Polygon2D
	var hollow_reef_exit_back := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ExitBackWall") as Polygon2D
	var hollow_reef_interior_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane") as Node2D
	var hollow_lane_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneBackWater") as Polygon2D
	var hollow_lane_upper := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperLaneShelf") as Polygon2D
	var hollow_lane_lower := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LowerLaneShelf") as Polygon2D
	var hollow_lane_direction := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/InteriorDirectionRib") as Polygon2D
	var hollow_lane_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnCurrent") as Polygon2D
	var hollow_lane_return_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnRib") as Polygon2D
	var hollow_upper_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice") as Node2D
	var hollow_upper_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfPocketWater") as Polygon2D
	var hollow_upper_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelfLip") as Polygon2D
	var hollow_upper_choice_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ChoiceCueRib") as Polygon2D
	var hollow_upper_drop_back := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/DropBackCue") as Polygon2D
	var hollow_resource_pocket := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket") as Node2D
	var hollow_resource_cleft := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketCleft") as Polygon2D
	var hollow_resource_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketHalo") as Polygon2D
	var hollow_resource_glimmer := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var hollow_lane_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneTurnbackLip") as Polygon2D
	var hollow_deeper_promise := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise") as Node2D
	var hollow_reef_reading_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore") as Node2D

	runner._expect(hollow_reef_return.polygon[1].y < hollow_reef_return.polygon[0].y, "Hollow Reef return current should point upward toward Blackwater and Silt Vein")
	runner._expect(hollow_reef_exit_ribbon.color.g > hollow_reef_exit_ribbon.color.r, "Hollow Reef exit ribbon should use safe-return color language")
	runner._expect(hollow_reef_exit_ribbon.color.a <= hollow_reef_return.color.a, "Hollow Reef exit ribbon should support the return current without becoming a second objective arrow")
	runner._expect(hollow_reef_exit_ribbon.polygon[1].x < hollow_reef_exit_ribbon.polygon[0].x, "Hollow Reef exit ribbon should point back left toward the entrance")
	runner._expect(hollow_reef_return_chain.color.g > hollow_reef_return_chain.color.r and hollow_reef_return_chain.color.b > hollow_reef_return_chain.color.r, "Hollow Reef return chain should use safe-current color language")
	runner._expect(hollow_reef_return_chain.color.a >= 0.08 and hollow_reef_return_chain.color.a <= 0.1, "Hollow Reef return chain should stay readable without becoming a route graph")
	runner._expect(hollow_reef_return_chain.polygon[1].x < hollow_reef_return_chain.polygon[0].x, "Hollow Reef return chain should point left toward Dusk Trench")
	runner._expect(hollow_reef_return_chain.polygon[1].y < hollow_reef_return_chain.polygon[0].y, "Hollow Reef return chain should point upward toward Blackwater and Silt Vein")
	runner._expect(hollow_reef_return_rib_a.polygon[1].x < hollow_reef_return_rib_a.polygon[0].x, "Hollow Reef first return rib should step left along the chain")
	runner._expect(hollow_reef_return_rib_b.polygon[1].y < hollow_reef_return_rib_b.polygon[0].y, "Hollow Reef second return rib should step upward along the chain")
	runner._expect(hollow_reef_return_fleck.color.a <= 0.3, "Hollow Reef return fleck should be a small landmark cue, not a resource marker")
	runner._expect(hollow_reef_return_chain.color.g > blackwater_pressure_shutter.color.g, "Hollow Reef return chain should stay distinct from Blackwater pressure color language")
	runner._expect(hollow_reef_return_chain.get_node_or_null("InteractZone") == null, "Hollow Reef return chain should not add interaction or objective state")
	runner._expect(hollow_reef_return_chain.find_child("CollisionShape2D", true, false) == null, "Hollow Reef return chain should not add collision, movement, or hidden pressure behavior")
	runner._expect(hollow_reef_exit_rib.polygon[1].x < hollow_reef_exit_rib.polygon[0].x, "Hollow Reef exit rib should step left toward the exit route")
	runner._expect(hollow_reef_exit_back.color.a >= 0.45, "Hollow Reef exit back wall should make the current side-cave end readable")
	runner._expect(hollow_reef_interior_lane.position.x > hollow_reef_reading_core.position.x, "Hollow Reef interior lane should extend beyond the first cave reading payoff")
	runner._expect(hollow_reef_interior_lane.position.x < hollow_deeper_promise.position.x, "Hollow Reef interior lane should stay before the closed deeper promise")
	runner._expect(hollow_lane_water.color.a >= 0.45 and hollow_lane_water.color.a <= 0.55, "Hollow Reef interior lane should read as cave water without hiding route cues")
	runner._expect(hollow_lane_upper.color.a <= 0.32 and hollow_lane_lower.color.a <= 0.38, "Hollow Reef lane shelves should frame the path without becoming walls")
	runner._expect(hollow_lane_direction.color.g > hollow_lane_direction.color.r, "Hollow Reef interior direction rib should use safe/cave route color language")
	runner._expect(hollow_lane_return.color.a >= 0.08 and hollow_lane_return.color.a <= 0.1, "Hollow Reef lane return current should be readable but not objective-bright")
	runner._expect(hollow_lane_return.polygon[1].x < hollow_lane_return.polygon[0].x, "Hollow Reef lane return current should point left toward the cave mouth")
	runner._expect(hollow_lane_return.polygon[1].y < hollow_lane_return.polygon[0].y, "Hollow Reef lane return current should point up toward the exit route")
	runner._expect(hollow_lane_return_rib.polygon[1].x < hollow_lane_return_rib.polygon[0].x, "Hollow Reef lane return rib should step left along the return chain")
	runner._expect(hollow_upper_shelf.position.y < hollow_reef_interior_lane.position.y, "Hollow Reef upper shelf choice should sit above the main interior lane")
	runner._expect(hollow_upper_shelf.position.x > 0.0 and hollow_upper_shelf.position.x < hollow_lane_turnback.polygon[1].x, "Hollow Reef upper shelf choice should be a local option before the lane turnback")
	runner._expect(hollow_upper_water.color.b > hollow_upper_water.color.r, "Hollow Reef upper shelf water should use cool cave exploration color")
	runner._expect(hollow_upper_choice_rib.color.b > hollow_lane_return.color.b and hollow_upper_choice_rib.color.g < hollow_lane_return.color.g, "Hollow Reef upper shelf cue should be visually distinct from the green return lane")
	runner._expect(hollow_upper_choice_rib.color.a <= 0.22, "Hollow Reef upper shelf cue should stay exploratory instead of objective-bright")
	runner._expect(hollow_upper_lip.color.a <= 0.4, "Hollow Reef upper shelf lip should frame optional space without becoming a wall")
	runner._expect(hollow_upper_drop_back.color.a < hollow_lane_return.color.a, "Hollow Reef upper shelf drop-back cue should stay softer than the main return lane")
	runner._expect(hollow_upper_drop_back.polygon[1].y > hollow_upper_drop_back.polygon[0].y, "Hollow Reef upper shelf drop-back cue should point down toward the main lane")
	runner._expect(hollow_resource_pocket.position.x > 0.0 and hollow_resource_pocket.position.y > 0.0, "Hollow Reef sheltered resource pocket should sit inside the optional upper shelf")
	runner._expect(hollow_resource_cleft.color.a >= 0.45, "Hollow Reef sheltered pocket should read as a protected cleft")
	runner._expect(hollow_resource_halo.color.a <= 0.15, "Hollow Reef sheltered pocket halo should stay subtle enough not to crowd return cues")
	runner._expect(hollow_resource_glimmer.color.g >= hollow_resource_glimmer.color.r, "Hollow Reef sheltered pocket glimmer should use familiar glow resource language")
	runner._expect(hollow_resource_glimmer.color.a <= 0.36, "Hollow Reef sheltered pocket glimmer should suggest opportunity without guaranteeing a jackpot")
	runner._expect(hollow_resource_pocket.get_node_or_null("ResourcePickup") == null, "Hollow Reef sheltered pocket should use existing spawn candidates instead of adding a new pickup node")
	runner._expect(hollow_upper_shelf.get_node_or_null("InteractZone") == null, "Hollow Reef upper shelf should not add a new interaction hotspot")
	runner._expect(hollow_upper_shelf.get_node_or_null("ResourcePickup") == null, "Hollow Reef upper shelf should not add cargo or loot")
	runner._expect(hollow_upper_shelf.get_node_or_null("Predator") == null, "Hollow Reef upper shelf should not add combat pressure")
	runner._expect(hollow_upper_shelf.get_node_or_null("PressureBoundary") == null, "Hollow Reef upper shelf should not add hidden pressure behavior")
	runner._expect(hollow_upper_shelf.find_child("CollisionShape2D", true, false) == null, "Hollow Reef upper shelf should not block the safe return lane")
	runner._expect(hollow_lane_turnback.color.a <= 0.46, "Hollow Reef lane turnback lip should signal the current authored end without implying a full cave network")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_6(runner) -> void:
	var main := MainScene.instantiate()
	var hollow_reef_interior_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane") as Node2D
	var hollow_wide_chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var hollow_wide_entrance := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/EntranceThroat") as Polygon2D
	var hollow_wide_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ChamberBackwater") as Polygon2D
	var hollow_wide_far_wall := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarWallSilhouette") as Polygon2D
	var hollow_wide_clear_band := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/TraversalClearBand") as Polygon2D
	var hollow_wide_upper := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/UpperChamberShelf") as Polygon2D
	var hollow_wide_lower := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowerChamberShelf") as Polygon2D
	var hollow_wide_foreground := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ForegroundShelfEdge") as Polygon2D
	var hollow_wide_glass_rib_span := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassRibSpan") as Polygon2D
	var hollow_wide_low_crown_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowCrownShelf") as Polygon2D
	var hollow_wide_open_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/OpenWaterWindow") as Polygon2D
	var hollow_wide_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var hollow_wide_return_far := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib") as Polygon2D
	var hollow_wide_return_mid := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain") as Polygon2D
	var hollow_wide_return_entry := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain") as Polygon2D
	var hollow_wide_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentRibA") as Polygon2D
	var hollow_wide_future_choice := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FutureChoiceShadow") as Polygon2D
	var hollow_wide_far_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue") as Node2D
	var hollow_wide_far_boundary := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/BoundaryWash") as Polygon2D
	var hollow_wide_far_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRibbon") as Polygon2D
	var hollow_wide_far_rib := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/ReturnRib") as Polygon2D
	var hollow_wide_far_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/CueLabel") as Label

	runner._expect(hollow_reef_interior_lane.get_node_or_null("InteractZone") == null, "Hollow Reef interior lane should not add a second interaction hotspot")
	runner._expect(hollow_reef_interior_lane.get_node_or_null("ResourcePickup") == null, "Hollow Reef interior lane should not add cargo or loot")
	runner._expect(hollow_reef_interior_lane.get_node_or_null("Predator") == null, "Hollow Reef interior lane should not add combat or monster pressure")
	runner._expect(hollow_reef_interior_lane.get_node_or_null("PressureBoundary") == null, "Hollow Reef interior lane should not add hidden pressure behavior")
	runner._expect(hollow_reef_interior_lane.find_child("CollisionShape2D", true, false) == null, "Hollow Reef interior lane should not add hidden collision")
	runner._expect(hollow_reef_interior_lane.get_script() == null, "Hollow Reef interior lane should remain authored scene presentation, not gameplay state")
	runner._expect(hollow_wide_chamber.position.x > hollow_reef_interior_lane.position.x + 180.0, "Wide Reef Chamber should sit beyond the short Hollow Reef interior lane")
	runner._expect(hollow_wide_chamber.position.y >= hollow_reef_interior_lane.position.y, "Wide Reef Chamber should continue the lower-route cave direction")
	runner._expect(hollow_wide_water.polygon[3].x - hollow_wide_water.polygon[0].x >= 680.0, "Wide Reef Chamber backwater should visibly support side-to-side movement")
	runner._expect(hollow_wide_water.polygon[6].y - hollow_wide_water.polygon[1].y >= 330.0, "Wide Reef Chamber should be more than a thin corridor")
	runner._expect(hollow_wide_entrance.polygon[0].x < 0.0 and hollow_wide_entrance.polygon[2].x > 0.0, "Wide Reef Chamber entrance should overlap back toward Hollow Reef")
	runner._expect(hollow_wide_far_wall.color.a <= 0.36, "Wide Reef Chamber far-wall silhouette should stay behind the player and route cues")
	runner._expect(hollow_wide_far_wall.color.b >= hollow_wide_far_wall.color.r, "Wide Reef Chamber far-wall silhouette should use cool cave color language")
	runner._expect(hollow_wide_clear_band.color.a <= 0.1, "Wide Reef Chamber traversal band should clarify negative space without becoming an objective marker")
	runner._expect(hollow_wide_clear_band.polygon[3].x - hollow_wide_clear_band.polygon[0].x >= 560.0, "Wide Reef Chamber traversal band should span the horizontal playable lane")
	runner._expect(hollow_wide_clear_band.polygon[5].y < hollow_wide_foreground.polygon[0].y, "Wide Reef Chamber clear lane should sit above the foreground edge")
	runner._expect(hollow_wide_open_water.color.a <= 0.16, "Wide Reef Chamber open water should read as negative traversable space, not a blocking field")
	runner._expect(hollow_wide_upper.color.a >= 0.3 and hollow_wide_upper.color.a <= 0.34 and hollow_wide_lower.color.a >= 0.34 and hollow_wide_lower.color.a <= 0.38, "Wide Reef Chamber should frame the playable gap without becoming the loudest shapes")
	runner._expect(hollow_wide_foreground.color.a <= 0.32, "Wide Reef Chamber foreground edge should not obscure the sub or chamber cues")
	runner._expect(hollow_wide_foreground.polygon[0].y > hollow_wide_clear_band.polygon[0].y, "Wide Reef Chamber foreground edge should stay below the main traversal band")
	runner._expect(hollow_wide_glass_rib_span.color.b > hollow_wide_glass_rib_span.color.r, "Glass Rib Span should use cool chamber landmark language")
	runner._expect(hollow_wide_glass_rib_span.color.a <= 0.26, "Glass Rib Span should remain passive and quieter than scan/resource targets")
	runner._expect(hollow_wide_glass_rib_span.polygon[1].y < hollow_wide_clear_band.polygon[1].y, "Glass Rib Span should sit above the traversal band as an upper chamber landmark")
	runner._expect(hollow_wide_low_crown_shelf.color.g > hollow_wide_low_crown_shelf.color.r, "Low Crown Shelf should use reef/cave landmark color rather than resource or predator color")
	runner._expect(hollow_wide_low_crown_shelf.color.a <= 0.32, "Low Crown Shelf should stay passive and not read as a pickup")
	runner._expect(hollow_wide_low_crown_shelf.polygon[0].y > hollow_wide_clear_band.polygon[0].y, "Low Crown Shelf should sit below the traversal band as a lower chamber landmark")
	runner._expect(hollow_wide_return.color.g > hollow_wide_return.color.r and hollow_wide_return_rib_a.color.g > hollow_wide_return_rib_a.color.r, "Wide Reef Chamber return cue should use the established safe-current language")
	runner._expect(hollow_wide_return.polygon[1].x < hollow_wide_return.polygon[0].x, "Wide Reef Chamber return cue should point back left toward Hollow Reef")
	runner._expect(hollow_wide_return_far.color.g > hollow_wide_return_far.color.r and hollow_wide_return_mid.color.g > hollow_wide_return_mid.color.r, "Wide Reef Chamber return chain should keep safe-current color language")
	runner._expect(hollow_wide_return.color.a <= 0.11 and hollow_wide_return_far.color.a <= 0.1 and hollow_wide_return_mid.color.a <= 0.09 and hollow_wide_return_entry.color.a <= 0.1, "Wide Reef Chamber return chain should stay broad and not objective-bright")
	runner._expect(hollow_wide_return_far.polygon[1].x < hollow_wide_return_far.polygon[0].x, "Wide Reef Chamber far return rib should point left from the far chamber")
	runner._expect(hollow_wide_return_mid.polygon[1].x < hollow_wide_return_mid.polygon[0].x, "Wide Reef Chamber mid return chain should point left through the chamber")
	runner._expect(hollow_wide_return_entry.polygon[1].x < hollow_wide_return_entry.polygon[0].x, "Wide Reef Chamber entry return chain should point left toward Hollow Reef")
	runner._expect(hollow_wide_return_mid.polygon[1].y < hollow_wide_foreground.polygon[0].y, "Wide Reef Chamber mid return chain should stay above the low foreground shelf")
	runner._expect(hollow_wide_future_choice.color.a <= 0.4, "Wide Reef Chamber future-choice shadow should stay a quiet staging cue")
	runner._expect(hollow_wide_far_turnback.position.x > hollow_wide_future_choice.polygon[4].x, "Wide Reef Chamber far turnback cue should sit beyond the current future-choice shadow")
	runner._expect(hollow_wide_far_boundary.color.b > hollow_wide_far_boundary.color.r, "Wide Reef Chamber far boundary should use cool future-route language")
	runner._expect(hollow_wide_far_boundary.color.a <= 0.2, "Wide Reef Chamber far boundary should stay atmospheric instead of becoming a hard wall")
	runner._expect(hollow_wide_far_return.color.g > hollow_wide_far_return.color.r, "Wide Reef Chamber far turnback should use established safe-current color")
	runner._expect(hollow_wide_far_return.polygon[1].x < hollow_wide_far_return.polygon[0].x, "Wide Reef Chamber far turnback ribbon should point left toward Hollow Reef")
	runner._expect(hollow_wide_far_rib.polygon[1].x < hollow_wide_far_rib.polygon[0].x, "Wide Reef Chamber far turnback rib should step left along the route chain")
	runner._expect(hollow_wide_far_label.text.contains("RETURN VIA HOLLOW"), "Wide Reef Chamber far turnback label should preserve broad copy for future review")
	runner._expect(not hollow_wide_far_label.visible, "Wide Reef Chamber far turnback label should stay hidden during normal play to avoid route-text pileup")
	runner._expect(hollow_wide_far_label.text.contains("LATER"), "Wide Reef Chamber far turnback label should frame the far edge as future content")
	runner._expect(not hollow_wide_far_label.text.to_lower().contains("pickup"), "Wide Reef Chamber far turnback label should not read as a collectable")

	main.free()
