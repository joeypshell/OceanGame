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

func _test_east_shelf_spur_branch_scene_contract_part_1(runner) -> void:
	var main := MainScene.instantiate()
	var branch_mouth := main.get_node("EastShelfSpur/BranchMouthShadow") as Polygon2D
	var branch_rim := main.get_node("EastShelfSpur/BranchRimFrame") as Polygon2D
	var branch_opening := main.get_node("EastShelfSpur/BranchRouteOpening") as Polygon2D
	var route_choice_band := main.get_node("RouteChoiceBand") as Node2D
	var route_choice_rib := main.get_node("RouteChoiceBand/DecisionRib") as Polygon2D
	var safe_bank_lane := main.get_node("RouteChoiceBand/SafeBankLane") as Polygon2D
	var research_lane := main.get_node("RouteChoiceBand/ResearchLane") as Polygon2D
	var safe_bank_label := main.get_node("RouteChoiceBand/SafeBankLabel") as Label
	var research_label := main.get_node("RouteChoiceBand/ResearchLabel") as Label
	var approach_current := main.get_node("EastShelfSpur/ApproachCurrent") as Polygon2D
	var current_surge_lane := main.get_node("EastShelfSpur/CurrentSurgeLane") as Polygon2D
	var current_surge_rib := main.get_node("EastShelfSpur/CurrentSurgeRib") as Polygon2D
	var terminal_hint := main.get_node("EastShelfSpur/TerminalPocketHint") as Polygon2D
	var pocket_entrance := main.get_node("EastShelfSpur/PocketEntrance") as Node2D
	var mouth_shadow := main.get_node("EastShelfSpur/PocketEntrance/MouthShadow") as Polygon2D
	var cave_back_wall := main.get_node("EastShelfSpur/PocketEntrance/CaveBackWall") as Polygon2D
	var foreground_shelf_lip := main.get_node("EastShelfSpur/PocketEntrance/ForegroundShelfLip") as Polygon2D
	var landmark_spire_a := main.get_node("EastShelfSpur/PocketEntrance/LandmarkSpireA") as Polygon2D
	var landmark_spire_b := main.get_node("EastShelfSpur/PocketEntrance/LandmarkSpireB") as Polygon2D
	var interior_glow_pool := main.get_node("EastShelfSpur/PocketEntrance/InteriorGlowPool") as Polygon2D
	var signal_core_halo := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreHalo") as Polygon2D
	var signal_core_gem := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreGem") as Polygon2D
	var signal_core_spark := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreSpark") as Polygon2D
	var exit_current := main.get_node("EastShelfSpur/PocketEntrance/ExitCurrentCue") as Polygon2D
	var sealed_hatch := main.get_node("EastShelfSpur/SealedShelfHatch") as Node2D
	var hatch_lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	var deep_route_promise := main.get_node("EastShelfSpur/DeepRoutePromise") as Node2D
	var deep_route_mouth := main.get_node("EastShelfSpur/DeepRoutePromise/PromiseMouth") as Polygon2D
	var deep_route_wash := main.get_node("EastShelfSpur/DeepRoutePromise/PressureWash") as Polygon2D
	var deep_route_seal := main.get_node("EastShelfSpur/DeepRoutePromise/SealLip") as Polygon2D
	var deep_route_glint := main.get_node("EastShelfSpur/DeepRoutePromise/DepthGlint") as Polygon2D
	var deep_route_label := main.get_node("EastShelfSpur/DeepRoutePromise/PromiseLabel") as Label
	var resonance_alcove := main.get_node("EastShelfSpur/ResonanceAlcove") as Node2D
	var resonance_mouth := main.get_node("EastShelfSpur/ResonanceAlcove/AlcoveMouth") as Polygon2D
	var arch := main.get_node("EastShelfSpur/EastShelfArch") as Node2D
	var arch_return := main.get_node("EastShelfSpur/EastShelfArch/ReturnCurrentLeft") as Polygon2D
	var shelf_glimmer := main.get_node("EastShelfSpur/ShelfGlimmerOpportunity") as Node2D
	var shelf_glimmer_core := main.get_node("EastShelfSpur/ShelfGlimmerOpportunity/GlimmerCore") as Polygon2D

	runner._expect(branch_mouth.color.a >= 0.5, "East Shelf branch mouth should be dark enough to read as a route opening")
	runner._expect(branch_rim.color.a >= 0.3, "East Shelf branch rim should visibly frame the route entrance")
	runner._expect(branch_opening.color.a >= 0.18, "East Shelf branch opening should be more visible than a subtle current hint")
	runner._expect(route_choice_band.get_node_or_null("InteractZone") == null, "Route Choice Band should not add active interaction or objective UI")
	runner._expect(route_choice_rib.color.a <= 0.22, "Route Choice Band rib should be readable without becoming a blocking marker")
	runner._expect(safe_bank_lane.color.g > safe_bank_lane.color.r, "Safe banking lane should use a calmer green route language")
	runner._expect(research_lane.color.b >= research_lane.color.r, "Research lane should use cyan route language toward East Shelf")
	runner._expect(safe_bank_lane.polygon[1].x < safe_bank_lane.polygon[0].x, "Safe banking lane should point left/down toward Shell Reef")
	runner._expect(research_lane.polygon[1].x > research_lane.polygon[0].x, "Research lane should point right toward East Shelf")
	runner._expect(safe_bank_label.text == "SAFE BANK", "Safe banking label should be broad route language")
	runner._expect(research_label.text == "RESEARCH ROUTE", "Research label should be broad route language")
	runner._expect(not safe_bank_label.text.to_lower().contains("objective"), "Route labels should not become checklist language")
	runner._expect(not research_label.text.to_lower().contains("map"), "Route labels should not imply a minimap or exact locator")
	runner._expect(approach_current.polygon[1].x >= 1000.0, "East Shelf Spur should branch right of the existing main column while becoming visible earlier")
	runner._expect(terminal_hint.polygon[terminal_hint.polygon.size() - 1].x >= 1800.0, "East Shelf Spur should reach into the expanded camera space")
	runner._expect(approach_current.color.a <= 0.18, "East Shelf Spur current cue should stay readable without becoming a hard objective arrow")
	runner._expect(current_surge_lane.color.a <= 0.18, "East Shelf current-surge lane should read as timing guidance, not a damage wall")
	runner._expect(current_surge_rib.polygon.size() >= 4, "East Shelf current-surge rib should provide a readable timing tick")
	runner._expect(arch.position.x >= 1450.0, "East Shelf Arch should sit on the right-side branch before the pocket entrance")
	runner._expect(arch_return.polygon[1].x < arch_return.polygon[0].x, "East Shelf Arch return current should point left toward the base column")
	runner._expect(not shelf_glimmer.visible, "Shelf Glimmer opportunity should start hidden until its seeded condition is active")
	runner._expect(shelf_glimmer_core.color.a <= 0.4, "Shelf Glimmer should read as a subtle opportunity, not a guaranteed major reward")
	runner._expect(pocket_entrance.position.x >= 1880.0, "East Shelf pocket entrance should sit at the far end of the side route")
	runner._expect(mouth_shadow.color.a >= 0.6, "East Shelf pocket entrance should read as an opening, not another translucent current")
	runner._expect(cave_back_wall.color.a >= 0.68, "East Shelf pocket should have a readable cave back wall")
	runner._expect(foreground_shelf_lip.color.a >= 0.7, "East Shelf pocket should have a foreground shelf lip for destination depth")
	runner._expect(landmark_spire_a.color.a >= 0.4 and landmark_spire_b.color.a >= 0.3, "East Shelf pocket should include distinct landmark spires")
	runner._expect(interior_glow_pool.color.a >= 0.2, "East Shelf pocket should include a soft interior glow pool")
	runner._expect(signal_core_halo.color.a >= 0.3 and signal_core_gem.color.a >= 0.8, "East Shelf pocket should contain a clear visible payoff core")
	runner._expect(signal_core_spark.visible and signal_core_spark.color.a >= 0.9, "East Shelf pocket payoff should have a bright recoverable spark")
	runner._expect(exit_current.polygon[1].x < exit_current.polygon[0].x, "East Shelf pocket exit cue should point back left toward the main route")
	runner._expect(sealed_hatch.position.x >= pocket_entrance.position.x, "Sealed Shelf Hatch should sit at or beyond the pocket entrance as a future promise")
	runner._expect(hatch_lock_label.text == "ECHO LOCK", "Sealed Shelf Hatch should start as an Echo Lens locked promise")
	runner._expect(deep_route_promise.position.x > sealed_hatch.position.x, "Deep Route Promise should sit beyond the East Shelf destination")
	runner._expect(deep_route_promise.position.y > sealed_hatch.position.y, "Deep Route Promise should sit lower than the hatch to imply future depth")
	runner._expect(deep_route_mouth.color.a >= 0.62, "Deep Route Promise mouth should read as a visible sealed opening")
	runner._expect(deep_route_wash.color.a <= 0.18, "Deep Route Promise wash should stay atmospheric, not a damage field")
	runner._expect(deep_route_seal.color.a >= 0.28, "Deep Route Promise should have a readable seal lip")
	runner._expect(deep_route_glint.color.a >= 0.42, "Deep Route Promise should include a small curiosity glint")
	runner._expect(deep_route_label.text == "DEEP ROUTE SEALED", "Deep Route Promise label should communicate future route state without objective copy")
	runner._expect(deep_route_promise.get_node_or_null("InteractZone") == null, "Deep Route Promise should not add active interaction yet")
	runner._expect(deep_route_promise.get_node_or_null("Interior") == null, "Deep Route Promise should not add a cave interior system")
	runner._expect(resonance_alcove.position.x > sealed_hatch.position.x, "Resonance Alcove should sit just beyond the sealed hatch")
	runner._expect(resonance_alcove.position.y <= sealed_hatch.position.y + 80.0, "Resonance Alcove should stay near the hatch rather than becoming a new deep route")
	runner._expect(resonance_mouth.color.a <= 0.62, "Resonance Alcove mouth should read as a small pocket, not a full biome")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_2(runner) -> void:
	var main := MainScene.instantiate()
	var resonance_alcove := main.get_node("EastShelfSpur/ResonanceAlcove") as Node2D
	var resonance_glow := main.get_node("EastShelfSpur/ResonanceAlcove/AlcoveGlow") as Polygon2D
	var resonance_return := main.get_node("EastShelfSpur/ResonanceAlcove/ReturnCurrentCue") as Polygon2D
	var connector_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/ConnectorMouth") as Polygon2D
	var connector_current := main.get_node("EastShelfSpur/ShelfDropConnector/DownCurrentThread") as Polygon2D
	var drop_arch := main.get_node("EastShelfSpur/ShelfDropConnector/DropArch") as Node2D
	var drop_arch_return := main.get_node("EastShelfSpur/ShelfDropConnector/DropArch/ReturnCurrentUpLeft") as Polygon2D
	var drop_echo := main.get_node("EastShelfSpur/ShelfDropConnector/DropEchoOpportunity") as Node2D
	var drop_echo_core := main.get_node("EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/EchoCore") as Polygon2D
	var connector_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/TurnbackPocketHint") as Polygon2D
	var blue_chimney_pocket := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket") as Node2D
	var blue_chimney_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketMouth") as Polygon2D
	var blue_chimney_rim := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/PocketRim") as Polygon2D
	var blue_chimney_column := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimney/ChimneyColumn") as Polygon2D
	var reverse_draft_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ReverseDraftReturn") as Polygon2D
	var blue_chimney_signal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity") as Node2D
	var blue_chimney_signal_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity/SignalWash") as Polygon2D
	var blue_chimney_survey_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore") as Node2D
	var blue_chimney_survey_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyHalo") as Polygon2D
	var blue_chimney_survey_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem") as Polygon2D
	var blue_chimney_survey_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark") as Polygon2D
	var blue_chimney_crack := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ClosedLowerCrack") as Polygon2D
	var silt_vein_fork := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork") as Node2D
	var silt_fork_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkMouth") as Polygon2D
	var silt_left_hint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LeftBranchHint") as Polygon2D
	var silt_right_hint := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/RightBranchHint") as Polygon2D
	var silt_turnback_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/ForkTurnbackLip") as Polygon2D
	var lantern_silt_nook := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook") as Node2D
	var lantern_nook_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/NookMouth") as Polygon2D
	var lantern_glow := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/LanternGlow") as Polygon2D
	var lantern_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/ReturnCurrentCue") as Polygon2D

	runner._expect(resonance_glow.color.a <= 0.22, "Resonance Alcove glow should stay subtle until payoff behavior exists")
	runner._expect(resonance_return.polygon[1].x < resonance_return.polygon[0].x, "Resonance Alcove return cue should point back left toward East Shelf")
	runner._expect(resonance_alcove.get_node_or_null("Interior") == null, "Resonance Alcove scaffold should not add a full interior system")
	runner._expect(connector_mouth.polygon[0].x >= 1880.0, "Shelf Drop Connector should start beyond the East Shelf pocket area")
	runner._expect(connector_turnback.polygon[connector_turnback.polygon.size() - 1].y >= 2040.0, "Shelf Drop Connector should drop below East Shelf into the lower route space")
	runner._expect(connector_current.color.a <= 0.12, "Shelf Drop Connector current should stay subtle until route art and payoff exist")
	runner._expect(drop_arch.position.y >= 1860.0, "Drop Arch should sit inside the lower connector rather than the East Shelf approach")
	runner._expect(drop_arch_return.polygon[1].x < drop_arch_return.polygon[0].x, "Drop Arch return current should point up-left toward East Shelf and the base column")
	runner._expect(drop_arch_return.polygon[1].y < drop_arch_return.polygon[0].y, "Drop Arch return current should show upward return direction")
	runner._expect(drop_echo.position.y >= drop_arch.position.y, "Drop Echo should sit near the lower connector turnback point")
	runner._expect(drop_echo_core.color.a <= 0.4, "Drop Echo should read as a subtle research ping, not a guaranteed major reward")
	runner._expect(blue_chimney_pocket.position.x >= drop_arch.position.x, "Blue Chimney Pocket should extend slightly right after Drop Arch")
	runner._expect(blue_chimney_pocket.position.y > connector_turnback.polygon[connector_turnback.polygon.size() - 1].y, "Blue Chimney Pocket should sit just below the Shelf Drop turnback")
	runner._expect(blue_chimney_pocket.position.x <= 2180.0, "Blue Chimney Pocket scaffold should stay inside the current bounded route space")
	runner._expect(blue_chimney_pocket.position.y <= 2260.0, "Blue Chimney Pocket scaffold should stay small until larger route growth is planned")
	runner._expect(blue_chimney_mouth.color.a <= 0.62, "Blue Chimney Pocket mouth should read as a small pocket, not a full cave network")
	runner._expect(blue_chimney_rim.polygon.size() <= 14, "Blue Chimney Pocket rim should stay compact and authored")
	runner._expect(blue_chimney_column.color.b >= blue_chimney_column.color.r, "Blue Chimney landmark should read as a blue local memory anchor")
	runner._expect(reverse_draft_return.polygon[1].x < reverse_draft_return.polygon[0].x, "Blue Chimney reverse draft should point left toward Drop Arch")
	runner._expect(reverse_draft_return.polygon[1].y < reverse_draft_return.polygon[0].y, "Blue Chimney reverse draft should point upward toward the return route")
	runner._expect(reverse_draft_return.color.a <= 0.14, "Blue Chimney reverse draft should stay a soft route cue, not a map marker")
	runner._expect(not blue_chimney_signal.visible, "Blue Chimney signal opportunity should start hidden until its seeded condition is active")
	runner._expect(blue_chimney_signal_wash.color.a <= 0.1, "Blue Chimney signal wash should stay subtle, not a guaranteed reward marker")
	runner._expect(blue_chimney_survey_core.position.x > 0.0, "Blue Chimney survey core should sit inside the lower pocket as a concrete payoff")
	runner._expect(blue_chimney_survey_halo.color.a >= 0.28, "Blue Chimney survey core should have a readable halo in normal play")
	runner._expect(blue_chimney_survey_gem.color.a >= 0.7, "Blue Chimney survey core should have a visible recoverable gem")
	runner._expect(blue_chimney_survey_spark.visible and blue_chimney_survey_spark.color.a >= 0.8, "Blue Chimney survey core should have a bright recovery spark")
	runner._expect(blue_chimney_survey_core.get_node_or_null("InteractZone") == null, "Blue Chimney survey core should reuse the pocket interaction instead of adding a second hotspot")
	runner._expect(blue_chimney_crack.color.a >= 0.5, "Blue Chimney Pocket should include a visible closed lower turnback")
	runner._expect(blue_chimney_pocket.get_node_or_null("Interior") == null, "Blue Chimney Pocket scaffold should not add a full interior system")
	runner._expect(silt_vein_fork.position.y > blue_chimney_crack.polygon[blue_chimney_crack.polygon.size() - 1].y, "Silt Vein Fork should begin below the Blue Chimney lower crack")
	runner._expect(silt_vein_fork.position.y <= 190.0, "Silt Vein Fork scaffold should stay compact under Blue Chimney")
	runner._expect(silt_fork_mouth.color.a <= 0.42, "Silt Vein Fork mouth should stay subtle until branch content exists")
	runner._expect(silt_left_hint.polygon[2].x < silt_left_hint.polygon[0].x, "Silt Vein Fork left hint should show a readable left branch")
	runner._expect(silt_right_hint.polygon[2].x > silt_right_hint.polygon[0].x, "Silt Vein Fork right hint should show a readable right branch")
	runner._expect(silt_right_hint.color.a <= 0.24, "Silt Vein Fork right branch should read as deferred pressure-dark promise")
	runner._expect(silt_turnback_lip.color.a >= 0.45, "Silt Vein Fork should include a visible lower turnback lip")
	runner._expect(silt_vein_fork.get_node_or_null("InteractZone") == null, "Silt Vein Fork scaffold should not add payoff interaction yet")
	runner._expect(silt_vein_fork.get_node_or_null("Interior") == null, "Silt Vein Fork scaffold should not add a cave interior system")
	runner._expect(lantern_silt_nook.position.x < silt_vein_fork.position.x, "Lantern Silt Nook should sit on the left safe branch")
	runner._expect(lantern_silt_nook.position.y > 100.0, "Lantern Silt Nook should sit below the fork mouth, not above Blue Chimney")
	runner._expect(lantern_nook_mouth.color.a <= 0.5, "Lantern Silt Nook mouth should be readable but not a full cave entrance")
	runner._expect(lantern_glow.color.a <= 0.2, "Lantern Silt Nook glow should stay subtle until payoff exists")
	runner._expect(lantern_return.polygon[1].x > lantern_return.polygon[0].x, "Lantern Silt Nook return cue should point back toward the fork")
	runner._expect(lantern_return.polygon[1].y < lantern_return.polygon[0].y, "Lantern Silt Nook return cue should point upward toward the fork")

	main.free()

func _test_east_shelf_spur_branch_scene_contract_part_3(runner) -> void:
	var main := MainScene.instantiate()
	var silt_vein_fork := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork") as Node2D
	var lantern_silt_nook := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook") as Node2D
	var blackwater_crack := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack") as Node2D
	var blackwater_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth") as Polygon2D
	var blackwater_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash") as Polygon2D
	var blackwater_seal_lip := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip") as Polygon2D
	var blackwater_gate_badge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge") as Polygon2D
	var blackwater_gate_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel") as Label
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var blackwater_sill_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillMouth") as Polygon2D
	var blackwater_sill_floor := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillFloor") as Polygon2D
	var blackwater_return := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue") as Polygon2D
	var blackwater_return_chain := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainCue") as Polygon2D
	var blackwater_return_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibA") as Polygon2D
	var blackwater_return_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnChainRibB") as Polygon2D
	var blackwater_pressure_shutter := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var blackwater_pressure_rib_a := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA") as Polygon2D
	var blackwater_pressure_rib_b := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibB") as Polygon2D
	var blackwater_turnback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/SillEndSeal") as Polygon2D
	var blackwater_trace_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore") as Node2D
	var blackwater_trace_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo") as Polygon2D
	var blackwater_trace_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem") as Polygon2D
	var blackwater_trace_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark") as Polygon2D
	var blackwater_signal := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity") as Node2D
	var blackwater_signal_wash := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash") as Polygon2D
	var blackwater_signal_fleck := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck") as Polygon2D
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D
	var dusk_trench_mouth := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/TrenchMouth") as Polygon2D
	var dusk_open_water := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/OpenWaterWindow") as Polygon2D

	runner._expect(lantern_silt_nook.get_node_or_null("InteractZone") != null, "Lantern Silt Nook should expose the first safe-branch sample interaction")
	runner._expect(lantern_silt_nook.get_node_or_null("Interior") == null, "Lantern Silt Nook scaffold should not add a multi-room cave")
	runner._expect(blackwater_crack.position.x > silt_vein_fork.position.x, "Blackwater Crack should sit on the right deferred branch")
	runner._expect(blackwater_crack.position.y > 120.0, "Blackwater Crack should sit below the fork mouth")
	runner._expect(blackwater_mouth.color.a >= 0.58, "Blackwater Crack mouth should read as closed deep water")
	runner._expect(blackwater_wash.color.a <= 0.22, "Blackwater Crack pressure-dark wash should stay atmospheric, not a damage field")
	runner._expect(blackwater_seal_lip.color.a <= 0.28, "Blackwater Crack seal lip should read as a quiet deferred promise")
	runner._expect(blackwater_gate_badge.color.a >= 0.48, "Blackwater Crack should visibly present a deliberate route gate")
	runner._expect(blackwater_gate_label.text == "RESONANCE SEAL", "Blackwater Crack should start with broad preparation gate copy")
	runner._expect(blackwater_crack.get_node_or_null("InteractZone") != null, "Blackwater Crack should expose a readback hotspot for its gate state")
	runner._expect(not blackwater_sill.visible, "Blackwater Sill should stay hidden until the scoped gate preparation is ready")
	runner._expect(blackwater_sill.position.x > blackwater_crack.position.x * 0.5, "Blackwater Sill should extend to the right of the crack as a short route step")
	runner._expect(blackwater_sill.position.y > 80.0, "Blackwater Sill should sit deeper than the crack mouth")
	runner._expect(blackwater_sill_mouth.color.a >= 0.6, "Blackwater Sill mouth should read as a deliberate short route when opened")
	runner._expect(blackwater_sill_floor.color.a >= 0.45, "Blackwater Sill should have a readable local floor silhouette")
	runner._expect(blackwater_return.polygon[1].x < blackwater_return.polygon[0].x, "Blackwater Sill return cue should point back left toward Silt Vein")
	runner._expect(blackwater_return.polygon[1].y < blackwater_return.polygon[0].y, "Blackwater Sill return cue should point upward toward Blue Chimney")
	runner._expect(blackwater_return_chain.polygon[1].x < blackwater_return_chain.polygon[0].x, "Blackwater return chain should point back toward Silt Vein")
	runner._expect(blackwater_return_chain.polygon[1].y < blackwater_return_chain.polygon[0].y, "Blackwater return chain should point upward toward Blue Chimney")
	runner._expect(blackwater_return_chain.color.g > blackwater_return_chain.color.r, "Blackwater return chain should use safe-current color language")
	runner._expect(blackwater_return_rib_a.polygon[1].x < blackwater_return_rib_a.polygon[0].x, "Blackwater first return rib should step left along the chain")
	runner._expect(blackwater_return_rib_b.polygon[1].y < blackwater_return_rib_b.polygon[0].y, "Blackwater second return rib should step upward along the chain")
	runner._expect(blackwater_sill.get_node_or_null("ReturnChainCue/InteractZone") == null, "Blackwater return chain should not add interaction or objective state")
	runner._expect(blackwater_pressure_shutter.color.b > blackwater_pressure_shutter.color.g, "Blackwater pressure cue should use dark violet pressure language, not safe-current green")
	runner._expect(blackwater_pressure_shutter.color.a >= 0.1 and blackwater_pressure_shutter.color.a <= 0.2, "Blackwater pressure shutter should stay subtle and non-combat")
	runner._expect(blackwater_pressure_rib_a.color.b > blackwater_pressure_rib_a.color.g, "Blackwater pressure ribs should stay visually distinct from safe return currents")
	runner._expect(blackwater_pressure_rib_b.color.b > blackwater_pressure_rib_b.color.g, "Blackwater pressure ribs should reinforce local route pressure")
	runner._expect(blackwater_pressure_shutter.polygon[0].y > blackwater_return_chain.polygon[0].y + 24.0, "Blackwater pressure cue should sit below the return chain instead of covering it")
	runner._expect(blackwater_sill.get_node_or_null("PressureBoundary") == null, "Blackwater pressure cue should not add a hidden pressure collision boundary")
	runner._expect(blackwater_turnback.color.a <= 0.3, "Blackwater Sill end should read as a turnback, not a full cave network")
	runner._expect(blackwater_trace_core.position.x > 0.0, "Blackwater Trace should sit inside the opened short sill route")
	runner._expect(blackwater_trace_core.position.x > blackwater_return_chain.polygon[0].x, "Blackwater Trace should sit to the right of the return-chain cue")
	runner._expect(blackwater_trace_core.position.y < blackwater_pressure_shutter.polygon[0].y, "Blackwater Trace should stay visually separate from the lower pressure cue")
	runner._expect(blackwater_trace_halo.color.a >= 0.28, "Blackwater Trace should have a readable halo in normal play")
	runner._expect(blackwater_trace_gem.color.a >= 0.7, "Blackwater Trace should have a visible recoverable core")
	runner._expect(blackwater_trace_spark.visible and blackwater_trace_spark.color.a >= 0.8, "Blackwater Trace should have a bright recovery spark")
	runner._expect(not blackwater_signal.visible, "Blackwater signal opportunity should start hidden until Rare Signal and route preparation are ready")
	runner._expect(blackwater_signal.position.y <= -70.0, "Blackwater signal wash should sit above the local route cues instead of covering them")
	runner._expect(blackwater_signal_wash.color.a <= 0.1, "Blackwater signal wash should stay atmospheric, not a guaranteed reward marker")
	runner._expect(blackwater_signal_fleck.color.a <= 0.36, "Blackwater signal fleck should stay subtle and optional")
	runner._expect(blackwater_signal.get_node_or_null("InteractZone") == null, "Blackwater signal nudge should not add a second interaction hotspot")
	runner._expect(dusk_trench.get_parent() == blackwater_sill, "Dusk Trench should inherit the existing Blackwater route gate")
	runner._expect(dusk_trench.position.x >= 200.0 and dusk_trench.position.y >= 100.0, "Dusk Trench should continue beyond the Blackwater Sill turnback")
	runner._expect(dusk_trench_mouth.color.a >= 0.6, "Dusk Trench mouth should read as a deliberate route continuation")
	runner._expect(dusk_open_water.color.a <= 0.5, "Dusk Trench should include negative open-water space instead of another dense cue pile")

	main.free()
