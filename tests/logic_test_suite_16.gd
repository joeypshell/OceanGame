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

func _test_east_shelf_spur_branch_scene_contract_part_7(runner) -> void:
	var main := MainScene.instantiate()
	var hollow_wide_chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var hollow_wide_glass_rib_span := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassRibSpan") as Polygon2D
	var hollow_wide_low_crown_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/LowCrownShelf") as Polygon2D
	var hollow_wide_far_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue") as Node2D
	var hollow_wide_far_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/FarTurnbackCue/CueLabel") as Label
	var mirror_kelp_pass := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var mirror_kelp_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassMouth") as Polygon2D
	var mirror_kelp_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater") as Polygon2D
	var mirror_kelp_curtain_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA") as Polygon2D
	var mirror_kelp_curtain_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainB") as Polygon2D
	var mirror_kelp_floor := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassFloorShelf") as Polygon2D
	var mirror_kelp_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/EntryReturnRibbon") as Polygon2D
	var mirror_kelp_loop_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnCurrent") as Polygon2D
	var mirror_kelp_loop_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnRibA") as Polygon2D
	var mirror_kelp_loop_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/LoopReturnRibB") as Polygon2D
	var mirror_kelp_loop_silhouette := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ChamberLoopSilhouette") as Polygon2D
	var mirror_kelp_return_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReturnLabel") as Label
	var mirror_kelp_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/PassLabel") as Label
	var tideglass_sample := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample") as Node2D
	var tideglass_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D

	runner._expect(not hollow_wide_far_label.text.to_lower().contains("locked"), "Wide Reef Chamber far turnback label should not read as an active gate")
	runner._expect_no_echo_lens_locator_language(hollow_wide_far_label.text, "Wide Reef Chamber far turnback label")
	runner._expect(hollow_wide_far_turnback.get_node_or_null("InteractZone") == null, "Wide Reef Chamber far turnback cue should not add an interaction hotspot")
	runner._expect(hollow_wide_far_turnback.get_node_or_null("ResourcePickup") == null, "Wide Reef Chamber far turnback cue should not add cargo or loot")
	runner._expect(hollow_wide_far_turnback.get_node_or_null("PressureBoundary") == null, "Wide Reef Chamber far turnback cue should not add hidden pressure behavior")
	runner._expect(hollow_wide_far_turnback.find_child("CollisionShape2D", true, false) == null, "Wide Reef Chamber far turnback cue should not add collision or invisible walls")
	runner._expect(hollow_wide_far_turnback.get_script() == null, "Wide Reef Chamber far turnback cue should remain visual-only")
	runner._expect(hollow_wide_chamber.get_node_or_null("InteractZone") == null, "Wide Reef Chamber should not add an interaction hotspot yet")
	runner._expect(hollow_wide_chamber.get_node_or_null("ResourcePickup") == null, "Wide Reef Chamber should not add cargo or loot yet")
	runner._expect(hollow_wide_chamber.get_node_or_null("Predator") == null, "Wide Reef Chamber should not add combat or monster pressure yet")
	runner._expect(hollow_wide_chamber.get_node_or_null("PressureBoundary") == null, "Wide Reef Chamber should not add pressure gating yet")
	runner._expect(hollow_wide_chamber.get_node_or_null("WreckSalvagePocketEntrance/InteractZone/CollisionShape2D") != null, "Wide Reef Chamber should only add collision for the nested salvage cache trigger")
	runner._expect(hollow_wide_chamber.get_node_or_null("RouteCollision") == null, "Wide Reef Chamber should not add route-blocking collision")
	runner._expect(hollow_wide_chamber.get_script() == null, "Wide Reef Chamber should remain authored scene presentation for this pass")
	runner._expect(hollow_wide_glass_rib_span.get_node_or_null("InteractZone") == null, "Glass Rib Span should not add an interaction hotspot")
	runner._expect(hollow_wide_low_crown_shelf.get_node_or_null("InteractZone") == null, "Low Crown Shelf should not add an interaction hotspot")
	runner._expect(mirror_kelp_pass.position.x > hollow_wide_far_turnback.position.x, "Mirror Kelp Pass should extend beyond the current wide-chamber far turnback")
	runner._expect(mirror_kelp_pass.position.y >= -12.0 and mirror_kelp_pass.position.y <= 80.0, "Mirror Kelp Pass should branch locally from the current chamber band")
	runner._expect(mirror_kelp_mouth.color.a >= 0.58, "Mirror Kelp Pass mouth should read as an intentional branch opening")
	runner._expect(mirror_kelp_water.color.b >= mirror_kelp_water.color.r, "Mirror Kelp Pass water should use cool reflective branch language")
	runner._expect(mirror_kelp_water.color.a <= 0.22, "Mirror Kelp Pass water should stay quieter than pickups and scan targets")
	runner._expect(mirror_kelp_curtain_a.color.g > mirror_kelp_curtain_a.color.r and mirror_kelp_curtain_b.color.b > mirror_kelp_curtain_b.color.r, "Mirror Kelp Pass curtains should establish reflective kelp identity")
	runner._expect(mirror_kelp_curtain_a.color.a <= 0.18 and mirror_kelp_curtain_b.color.a <= 0.16, "Mirror Kelp Pass curtains should not overpower the route")
	runner._expect(mirror_kelp_floor.color.a <= 0.34, "Mirror Kelp Pass floor shelf should frame the branch without becoming a wall")
	runner._expect(mirror_kelp_water.color.a < tideglass_core.color.a and mirror_kelp_curtain_a.color.a < tideglass_core.color.a, "Mirror Kelp placeholder scenery should stay quieter than the Tideglass payoff")
	runner._expect(mirror_kelp_return.color.g > mirror_kelp_return.color.r, "Mirror Kelp Pass entry return ribbon should use safe-current color language")
	runner._expect(mirror_kelp_return.polygon[1].x < mirror_kelp_return.polygon[0].x, "Mirror Kelp Pass entry return ribbon should point back left toward Wide Reef Chamber")
	runner._expect(mirror_kelp_loop_return.color.g > mirror_kelp_loop_return.color.r, "Mirror Kelp Pass loop return should use safe-current color language")
	runner._expect(mirror_kelp_loop_return.color.a >= 0.1 and mirror_kelp_loop_return.color.a <= 0.12, "Mirror Kelp Pass loop return should be readable without becoming objective-bright")
	runner._expect(mirror_kelp_loop_return.polygon[1].x < mirror_kelp_loop_return.polygon[0].x, "Mirror Kelp Pass loop return should point left from the branch interior")
	runner._expect(mirror_kelp_loop_return.polygon[2].x < mirror_kelp_loop_return.polygon[1].x, "Mirror Kelp Pass loop return should continue left through the branch")
	runner._expect(mirror_kelp_loop_rib_a.polygon[1].x < mirror_kelp_loop_rib_a.polygon[0].x, "Mirror Kelp Pass first return rib should step left along the loop")
	runner._expect(mirror_kelp_loop_rib_b.polygon[1].x < mirror_kelp_loop_rib_b.polygon[0].x, "Mirror Kelp Pass second return rib should step left toward the chamber")
	runner._expect(mirror_kelp_loop_silhouette.color.a <= 0.26, "Mirror Kelp Pass chamber-loop silhouette should remain background guidance")
	runner._expect(mirror_kelp_loop_silhouette.polygon[1].x < mirror_kelp_return.polygon[1].x, "Mirror Kelp Pass loop silhouette should connect visually back toward the chamber")
	runner._expect(mirror_kelp_return_label.text == "RETURN VIA WIDE REEF", "Mirror Kelp Pass return label should preserve broad place-based return copy")
	runner._expect(not mirror_kelp_return_label.visible, "Mirror Kelp Pass return label should stay hidden because base HUD already carries broad return guidance")
	runner._expect(not mirror_kelp_return_label.text.to_lower().contains("map"), "Mirror Kelp Pass return label should not imply a minimap")
	runner._expect(not mirror_kelp_return_label.text.to_lower().contains("objective"), "Mirror Kelp Pass return label should not imply checklist objectives")
	runner._expect_no_echo_lens_locator_language(mirror_kelp_return_label.text, "Mirror Kelp Pass return label")
	runner._expect(mirror_kelp_label.text == "MIRROR KELP", "Mirror Kelp Pass should expose a compact stable prototype place name")
	runner._expect(mirror_kelp_label.get_theme_font_size("font_size") <= 10, "Mirror Kelp place label should stay visually subordinate to playable content")
	runner._expect_no_echo_lens_locator_language(mirror_kelp_label.text, "Mirror Kelp Pass label")
	runner._expect(tideglass_sample.position.x > 70.0 and tideglass_sample.position.x < 180.0, "Tideglass Sample should sit inside Mirror Kelp Pass instead of on the chamber return path")
	runner._expect(tideglass_sample.position.y > -20.0 and tideglass_sample.position.y < 72.0, "Tideglass Sample should stay readable within the Mirror Kelp branch band")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_8(runner) -> void:
	var main := MainScene.instantiate()
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D
	var hollow_reef := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	var mirror_kelp_pass := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var tideglass_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo") as Polygon2D
	var tideglass_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D
	var tideglass_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark") as Polygon2D
	var tideglass_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone") as Area2D
	var hollow_deeper_promise := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise") as Node2D
	var hollow_deeper_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseMouth") as Polygon2D
	var hollow_deeper_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PressureWash") as Polygon2D
	var hollow_deeper_seal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/SealLip") as Polygon2D
	var hollow_deeper_glint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseGlint") as Polygon2D
	var hollow_deeper_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/DeeperReefPromise/PromiseLabel") as Label
	var hollow_reef_reading_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore") as Node2D
	var hollow_reef_reading_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo") as Polygon2D
	var hollow_reef_reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard") as Polygon2D
	var hollow_reef_reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark") as Polygon2D
	var hollow_reef_interact := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone") as Area2D
	var hollow_reef_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/TurnbackLip") as Polygon2D
	var lantern_ray_route := main.get_node("Creatures/LanternRayRoute") as Area2D
	var lantern_ray_lane := main.get_node("Creatures/LanternRayRoute/RouteLane") as Polygon2D
	var lantern_ray_timing_lane := main.get_node("Creatures/LanternRayRoute/TimingLane") as Node2D
	var lantern_ray_timing_upper := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneUpper") as Polygon2D
	var lantern_ray_timing_lower := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneLower") as Polygon2D
	var lantern_ray_timing_tick := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingTickA") as Polygon2D

	runner._expect(tideglass_halo.color.g >= tideglass_halo.color.r and tideglass_halo.color.b >= tideglass_halo.color.r, "Tideglass Sample should use cool knowledge-payoff color language")
	runner._expect(tideglass_halo.color.a <= 0.4, "Tideglass Sample halo should be readable without becoming objective-bright")
	runner._expect(tideglass_core.color.a >= 0.8, "Tideglass Sample should start visibly recoverable")
	runner._expect(tideglass_spark.visible and tideglass_spark.color.a >= 0.8, "Tideglass Sample should expose a small recovery spark")
	runner._expect(tideglass_interact.collision_layer == 0 and tideglass_interact.collision_mask == 1, "Tideglass Sample hotspot should detect the player without becoming route collision")
	runner._expect(mirror_kelp_pass.get_node_or_null("InteractZone") == null, "Mirror Kelp Pass should not add a pass-wide interaction hotspot")
	runner._expect(mirror_kelp_pass.get_node_or_null("ResourcePickup") == null, "Mirror Kelp Pass scaffold should not add cargo or loot yet")
	runner._expect(mirror_kelp_pass.get_node_or_null("Predator") == null, "Mirror Kelp Pass scaffold should not add combat pressure")
	runner._expect(mirror_kelp_pass.get_node_or_null("PressureBoundary") == null, "Mirror Kelp Pass scaffold should not add hidden pressure behavior")
	runner._expect(mirror_kelp_pass.get_node_or_null("MinimapMarker") == null, "Mirror Kelp Pass scaffold should not add minimap behavior")
	runner._expect(mirror_kelp_pass.find_child("CollisionShape2D", true, false) == tideglass_interact.get_node("CollisionShape2D"), "Mirror Kelp Pass should only add collision for the nested Tideglass trigger")
	runner._expect(mirror_kelp_pass.get_script() == null, "Mirror Kelp Pass should remain authored scene presentation for this issue")
	runner._expect(hollow_deeper_promise.position.x > hollow_reef_reading_core.position.x, "Hollow Reef deeper promise should sit beyond the current cave reading payoff")
	runner._expect(hollow_deeper_promise.position.y > hollow_reef_reading_core.position.y, "Hollow Reef deeper promise should imply lower future route growth")
	runner._expect(hollow_deeper_mouth.color.a >= 0.62, "Hollow Reef deeper promise mouth should read as an intentional closed opening")
	runner._expect(hollow_deeper_wash.color.a <= 0.18, "Hollow Reef deeper promise wash should stay atmospheric, not a damage field")
	runner._expect(hollow_deeper_seal.color.a >= 0.22 and hollow_deeper_seal.color.a < tideglass_core.color.a, "Hollow Reef deeper promise should have a readable but quiet seal lip")
	runner._expect(hollow_deeper_glint.color.a >= 0.28 and hollow_deeper_glint.color.a <= 0.34, "Hollow Reef deeper promise should include a small curiosity glint without becoming a payoff")
	runner._expect(hollow_deeper_label.text == "DEEP CLOSED", "Hollow Reef deeper promise should clearly say the route is closed with compact copy")
	runner._expect(hollow_deeper_label.get_theme_font_size("font_size") <= 9, "Hollow Reef deeper promise label should be smaller than current interaction copy")
	runner._expect(not hollow_deeper_label.text.to_lower().contains("objective"), "Hollow Reef deeper promise label should not become checklist copy")
	runner._expect(not hollow_deeper_label.text.to_lower().contains("map"), "Hollow Reef deeper promise label should not imply a minimap or exact locator")
	runner._expect(hollow_deeper_promise.get_node_or_null("InteractZone") == null, "Hollow Reef deeper promise should not add a readback hotspot yet")
	runner._expect(hollow_deeper_promise.get_node_or_null("Interior") == null, "Hollow Reef deeper promise should not open another cave network")
	runner._expect(hollow_deeper_promise.get_node_or_null("ResourcePickup") == null, "Hollow Reef deeper promise should not add cargo or loot")
	runner._expect(hollow_deeper_promise.get_node_or_null("PressureBoundary") == null, "Hollow Reef deeper promise should not add hidden pressure behavior")
	runner._expect(hollow_deeper_promise.find_child("CollisionShape2D", true, false) == null, "Hollow Reef deeper promise should not add collision or movement behavior")
	runner._expect(hollow_deeper_promise.get_script() == null, "Hollow Reef deeper promise should remain visual-only")
	runner._expect(hollow_reef_reading_core.position.distance_to(hollow_reef_interact.position) >= 64.0, "Hollow Reef cave reading marker should be offset from the hotspot so the sub does not cover it")
	runner._expect(hollow_reef_reading_halo.color.a >= 0.3, "Hollow Reef cave reading should have a visible halo before recovery")
	runner._expect(hollow_reef_reading_shard.color.a >= 0.8, "Hollow Reef cave reading should start visibly recoverable")
	runner._expect(hollow_reef_reading_spark.visible and hollow_reef_reading_spark.color.a >= 0.8, "Hollow Reef cave reading should have a bright recovery spark")
	runner._expect(hollow_reef_turnback.color.a >= 0.4, "Hollow Reef should keep the old mouth turnback lip readable beside the new interior lane")
	runner._expect(hollow_reef_interact.collision_layer == 0 and hollow_reef_interact.collision_mask == 1, "Hollow Reef reading hotspot should detect the player without becoming a blocking body")
	runner._expect(hollow_reef.get_node_or_null("Interior") == null, "Hollow Reef scaffold should not add a full cave interior system")
	runner._expect(hollow_reef.get_node_or_null("ResourcePickup") == null, "Hollow Reef scaffold should not add a resource pickup yet")
	runner._expect(hollow_reef.get_node_or_null("Predator") == null, "Hollow Reef scaffold should not add a predator encounter")
	runner._expect(hollow_reef.get_script() == null, "Hollow Reef readability cues should not own oxygen, cargo, or progression state")
	runner._expect(hollow_reef.get_node_or_null("PressureBoundary") == null, "Hollow Reef cave reading should not add hidden pressure behavior")
	runner._expect(lantern_ray_route.position.distance_to(dusk_trench.global_position) <= 240.0, "Lantern Ray Route should sit near Dusk Trench as lower-route creature presence")
	runner._expect(lantern_ray_route.position.y < dusk_trench.global_position.y, "Lantern Ray Route should drift above the main trench return lane")
	runner._expect(lantern_ray_lane.color.a <= 0.16, "Lantern Ray ambient lane should stay softer than predator warning lanes")
	runner._expect(lantern_ray_timing_upper.color.b >= lantern_ray_timing_upper.color.r and lantern_ray_timing_upper.color.r > lantern_ray_timing_upper.color.g, "Lantern Ray timing lane should read as pale timing guidance, not safe-current green")
	runner._expect(lantern_ray_timing_upper.color.a <= 0.18 and lantern_ray_timing_lower.color.a <= 0.14 and lantern_ray_timing_tick.color.a <= 0.24, "Lantern Ray timing lane should stay readable without becoming a hard wall")
	runner._expect(lantern_ray_timing_lane.find_child("CollisionShape2D", true, false) == null, "Lantern Ray timing lane should not add hidden collision")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_9(runner) -> void:
	var main := MainScene.instantiate()
	var blackwater_crack := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack") as Node2D
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var hollow_resource_pocket := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket") as Node2D
	var tideglass_sample := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample") as Node2D
	var lantern_ray_route := main.get_node("Creatures/LanternRayRoute") as Area2D
	var lantern_ray_timing_lane := main.get_node("Creatures/LanternRayRoute/TimingLane") as Node2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var lantern_ray_wing := main.get_node("Creatures/LanternRayRoute/RayWingLeft") as Polygon2D
	var lantern_ray_eye := main.get_node("Creatures/LanternRayRoute/EyeFleck") as Polygon2D
	var lantern_ray_scan_marker := main.get_node("Creatures/LanternRayRoute/ScanMarker") as Polygon2D
	var lantern_ray_collision := main.get_node("Creatures/LanternRayRoute/CollisionShape2D") as CollisionShape2D
	var blue_chimney_glow_candidate := main.get_node("StarterResourceCandidates/GlowPlankton/BlueChimneyA") as SpawnPoint
	var blue_chimney_return_current_position := _source_hook_world_position(runner._load_area01_source_map_for_tests(), "blue_chimney_return_current")
	var hollow_reef_glow_candidate := main.get_node("StarterResourceCandidates/GlowPlankton/HollowReefA") as SpawnPoint
	var mirror_kelp_cargo_candidate := main.get_node("StarterResourceCandidates/KelpFiber/MirrorKelpA") as SpawnPoint

	runner._expect(lantern_ray_timing_lane.get_node_or_null("PressureBoundary") == null, "Lantern Ray timing lane should not add hidden pressure behavior")
	runner._expect(lantern_ray_body.color.b > lantern_ray_body.color.r and lantern_ray_body.color.g > lantern_ray_body.color.r, "Lantern Ray should use cool creature color language instead of predator red or resource yellow")
	runner._expect(lantern_ray_wing.color.a <= 0.5, "Lantern Ray wing silhouette should read as ambient life without becoming a hard obstacle")
	runner._expect(lantern_ray_eye.color.a >= 0.65, "Lantern Ray should have a small distinct creature focal point")
	runner._expect(lantern_ray_route is Area2D, "Lantern Ray Route should be a passive scannable observation area")
	runner._expect(lantern_ray_route.collision_layer == 0 and lantern_ray_route.collision_mask == 0, "Lantern Ray scan area should not collide, damage, or block extraction")
	runner._expect(lantern_ray_scan_marker.color.a <= 0.2, "Lantern Ray scan marker should stay subtle while idle")
	runner._expect(lantern_ray_collision != null, "Lantern Ray should keep a scan-area shape for target readability")
	runner._expect(lantern_ray_route.get_node_or_null("InteractZone") == null, "Lantern Ray Route should not add an interaction hotspot")
	runner._expect(lantern_ray_route.get_node_or_null("ResourcePickup") == null, "Lantern Ray Route should not add harvest or cargo behavior")
	runner._expect(lantern_ray_route.get_node_or_null("Predator") == null, "Lantern Ray Route should not reuse predator behavior")
	runner._expect(blackwater_crack.get_node_or_null("Interior") == null, "Blackwater Crack should not add a cave interior system")
	runner._expect(blackwater_sill.get_node_or_null("Interior") == null, "Blackwater Sill should not add a cave interior system")
	runner._expect(blue_chimney_glow_candidate.target_id == "glow_plankton", "Blue Chimney optional material should use existing Glow Plankton")
	runner._expect(blue_chimney_glow_candidate.depth_band == "deep", "Blue Chimney material candidate should preserve deep resource identity")
	runner._expect(blue_chimney_glow_candidate.cluster_pattern == "deep_reward", "Blue Chimney material candidate should remain optional deep-reward route pressure")
	runner._expect(blue_chimney_return_current_position != Vector2.INF, "Blue Chimney material candidate should have a generated source-grid return-current anchor")
	if blue_chimney_return_current_position != Vector2.INF:
		runner._expect(blue_chimney_glow_candidate.position.distance_to(blue_chimney_return_current_position) <= 48.0, "Blue Chimney material candidate should sit near the generated lower-pocket return current after source-grid re-anchor")
	runner._expect(hollow_reef_glow_candidate.target_id == "glow_plankton", "Hollow Reef sheltered pocket should use existing Glow Plankton")
	runner._expect(hollow_reef_glow_candidate.depth_band == "deep", "Hollow Reef material candidate should preserve deep resource identity")
	runner._expect(hollow_reef_glow_candidate.cluster_pattern == "deep_reward", "Hollow Reef material candidate should stay optional in the deep-reward resource pool")
	runner._expect(hollow_reef_glow_candidate.position.distance_to(hollow_resource_pocket.global_position) <= 48.0, "Hollow Reef material candidate should sit inside the sheltered pocket")
	runner._expect(mirror_kelp_cargo_candidate.target_id == "kelp_fiber", "Mirror Kelp cargo split should use existing Kelp Fiber")
	runner._expect(mirror_kelp_cargo_candidate.depth_band == "deep", "Mirror Kelp cargo split should stay in the deep branch context")
	runner._expect(mirror_kelp_cargo_candidate.cluster_pattern == "deep_reward", "Mirror Kelp cargo split should remain optional deep-reward route pressure")
	runner._expect(mirror_kelp_cargo_candidate.global_position.distance_to(tideglass_sample.global_position) >= 90.0, "Mirror Kelp cargo and Tideglass knowledge should not stack on each other")
	runner._expect(mirror_kelp_cargo_candidate.global_position.y > tideglass_sample.global_position.y, "Mirror Kelp cargo should sit below the Tideglass payoff so the choice reads as two local commitments")
	runner._expect(main.get_node_or_null("ResourcePickups/BlueChimneyGlowPlankton") == null, "Blue Chimney candidate should not add an extra active resource pickup")
	runner._expect(main.get_node_or_null("ResourcePickups/HollowReefGlowPlankton") == null, "Hollow Reef candidate should not add an extra active resource pickup")
	runner._expect(main.get_node_or_null("ResourcePickups/MirrorKelpFiber") == null, "Mirror Kelp cargo split should not add an extra active resource pickup")

	main.free()

func _source_hook_world_position(source_map: Dictionary, hook_id: String) -> Vector2:
	for hook_value in source_map.get("scene_hooks", []):
		if typeof(hook_value) != TYPE_DICTIONARY:
			continue
		var hook := hook_value as Dictionary
		if String(hook.get("id", "")) != hook_id:
			continue
		var value: Variant = hook.get("world_position", [])
		if value is Array and value.size() >= 2:
			return Vector2(float(value[0]), float(value[1]))
	return Vector2.INF
