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

func _test_outer_shelf_cargo_knowledge_payoff_choice(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_outer_shelf_survey = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"kelp_fiber": 1}
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var survey := outer_shelf.get_node("OuterShelfSurveyCore") as Node2D
	var survey_core := survey.get_node("SurveyCore") as Polygon2D
	var survey_spark := survey.get_node("SurveySpark") as Polygon2D
	var kelp_candidate := main.get_node("StarterResourceCandidates/KelpFiber/OuterShelfA") as SpawnPoint
	RoutePayoffSyncServiceScript.sync_outer_shelf_survey_payoff(main)
	runner._expect(survey_core.color.a >= 0.8, "Outer Shelf survey core should start visibly recoverable")
	runner._expect(survey_spark.visible, "Outer Shelf survey spark should start visible before recovery")
	runner._expect(kelp_candidate.target_id == "kelp_fiber", "Outer Shelf cargo choice should use existing Kelp Fiber")
	runner._expect(kelp_candidate.depth_band == "deep", "Outer Shelf cargo choice should stay in the deep branch context")
	runner._expect(kelp_candidate.cluster_pattern == "deep_reward", "Outer Shelf cargo choice should remain optional deep-reward pressure")
	runner._expect(kelp_candidate.global_position.distance_to(survey.global_position) >= 90.0, "Outer Shelf cargo and survey should not stack on each other")
	runner._expect(kelp_candidate.global_position.y > survey.global_position.y, "Outer Shelf cargo should sit below the survey so it reads as a separate commitment")
	runner._expect(main.get_node_or_null("ResourcePickups/OuterShelfKelpFiber") == null, "Outer Shelf cargo choice should reuse existing pickup placement instead of adding an extra active pickup")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Outer Shelf survey"), "Outer Shelf proximity should own the active dive prompt")
	runner._expect(prompt.contains("E/Enter"), "Outer Shelf prompt should keep the compact interaction command")

	var handled: bool = main.call("_try_outer_shelf_survey_interaction")
	runner._expect(handled, "Outer Shelf should handle interact while nearby during a dive")
	runner._expect(main.run_outer_shelf_survey_recovered, "Outer Shelf interaction should record one run-scoped survey")
	runner._expect(main.run_reached_dusk_trench, "Outer Shelf interaction should count as a deep-route reach for broad place memory")
	runner._expect(survey_core.color.a <= 0.2, "Outer Shelf survey should visibly dim after recovery")
	runner._expect(not survey_spark.visible, "Outer Shelf survey spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Outer Shelf survey should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Outer Shelf survey should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("kelp_fiber") == 1, "Outer Shelf survey should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("return through Mirror/Wide/Hollow"), "Outer Shelf status should keep broad return language")
		runner._expect(main.status_label.text.contains("Kelp Fiber"), "Outer Shelf status should name the nearby cargo alternative")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Outer Shelf status")

	var repeat_handled: bool = main.call("_try_outer_shelf_survey_interaction")
	runner._expect(repeat_handled, "Outer Shelf should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Outer Shelf repeat interaction should not duplicate the payoff")

	main.player_near_outer_shelf_survey = false
	var not_handled: bool = main.call("_try_outer_shelf_survey_interaction")
	runner._expect(not not_handled, "Outer Shelf should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("outer_shelf_survey"), "Outer Shelf survey should not become durable save data")
	runner._expect(not saved.has("outer_shelf_route"), "Outer Shelf should not create durable route state")
	runner._expect(not saved.has("glass_rim_cut"), "Glass Rim Cut should not create durable route state")

	var callout: String = ResearchResultCalloutServiceScript.format_outer_shelf_survey_research_callout(main)
	runner._expect(callout.contains("Outer Shelf"), "Outer Shelf result memory should name the area")
	runner._expect(callout.contains("Glass Rim Cut"), "Outer Shelf result memory should explain why the survey mattered")
	runner._expect(callout.contains("Kelp Fiber cargo"), "Outer Shelf result memory should preserve the cargo-vs-knowledge choice")
	runner._expect_no_echo_lens_locator_language(callout, "Outer Shelf result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Remembered place: Outer Shelf"), "Outer Shelf extraction summary should remember the newest area")
	runner._expect(extraction_summary.contains("Outer Shelf survey"), "Outer Shelf extraction summary should include recovered survey memory")
	runner._expect(extraction_summary.contains("try Glass Rim timing or bank the Outer Shelf cargo"), "Outer Shelf extraction summary should invite one next-run hypothesis")
	runner._expect(not extraction_summary.to_lower().contains("checklist"), "Outer Shelf extraction summary should not imply checklist UI")
	runner._expect(not extraction_summary.to_lower().contains("map"), "Outer Shelf extraction summary should not imply map UI")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Outer Shelf", "recent route helper should expose Outer Shelf after survey evidence")
	runner._expect(not extraction_summary.contains("%s"), "Outer Shelf extraction summary should not leak string placeholders")
	main.progression_state.current_run_number = 8
	main.progression_state.current_run_seed = 1008
	main.call("_record_recent_expedition", "Extracted", 0)
	var recent_log: String = main.call("_format_recent_expedition_log")
	runner._expect(recent_log.contains("route Outer Shelf"), "Outer Shelf recent log should name the remembered place")
	runner._expect(recent_log.contains("next Glass Rim timing or cargo"), "Outer Shelf recent log should tease a compact next dive")
	runner._expect(not recent_log.to_lower().contains("checklist"), "Outer Shelf recent log should not imply checklist UI")
	runner._expect(not recent_log.to_lower().contains("map"), "Outer Shelf recent log should not imply map UI")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_outer_shelf_survey_research_callout(fresh_main) == "", "Outer Shelf result line should stay hidden before survey recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Outer Shelf survey"), "Outer Shelf extraction summary should stay hidden before survey recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_outer_shelf_survey_recovered, "Outer Shelf survey should reset between expeditions")
	runner._expect(survey_core.color.a >= 0.8, "Outer Shelf survey should become visible again on expedition reset")
	runner._expect(survey_spark.visible, "Outer Shelf survey spark should reset between expeditions")
	main.free()

func _test_glass_rim_reading_payoff_choice(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_rim_glass_reading = true
	main.dive_session.oxygen = 16.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"shell_fragments": 1}
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var branch := outer_shelf.get_node("GlassRimCutBranch") as Node2D
	var promise := outer_shelf.get_node("RimSealPromise") as Node2D
	var reading := outer_shelf.get_node("RimGlassReading") as Node2D
	var halo := reading.get_node("ReadingHalo") as Polygon2D
	var core := reading.get_node("ReadingCore") as Polygon2D
	var spark := reading.get_node("ReadingSpark") as Polygon2D
	var interact_zone := reading.get_node("InteractZone") as Area2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	RoutePayoffSyncServiceScript.sync_rim_glass_reading_payoff(main)
	runner._expect(reading.position.x > branch.position.x, "Glass Rim reading should sit beyond the timing branch")
	runner._expect(reading.position.x < promise.position.x, "Glass Rim reading should sit before the sealed future promise")
	runner._expect(interact_zone.collision_layer == 0, "Glass Rim reading interaction should not become route collision")
	runner._expect(halo.color.a <= 0.24 and core.color.a >= 0.8, "Glass Rim reading should read as a visible knowledge payoff")
	runner._expect(spark.visible, "Glass Rim reading spark should start visible before recovery")
	runner._expect(reading.find_child("ResourcePickup", true, false) == null, "Glass Rim reading should not be cargo")
	runner._expect(reading.find_child("LootTable", true, false) == null, "Glass Rim reading should not add loot tables")
	runner._expect(reading.find_child("HealthBar", true, false) == null, "Glass Rim reading should not add combat UI")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Glass Rim reading"), "Glass Rim reading proximity should own the active prompt")
	runner._expect(prompt.contains("E/Enter"), "Glass Rim reading prompt should expose the normal interact command")

	var handled: bool = main.call("_try_rim_glass_reading_interaction")
	runner._expect(handled, "Glass Rim reading should handle interact while nearby during a dive")
	runner._expect(main.run_rim_glass_reading_recovered, "Glass Rim interaction should record one run-scoped reading")
	runner._expect(main.run_reached_dusk_trench, "Glass Rim reading should count as a deeper route reach for broad place memory")
	runner._expect(core.color.a <= 0.2, "Glass Rim reading core should visibly dim after recovery")
	runner._expect(not spark.visible, "Glass Rim reading spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 16.0), "Glass Rim reading should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Rim reading should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("shell_fragments") == 1, "Glass Rim reading should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Bank it now"), "Glass Rim status should name the safe return option")
		runner._expect(main.status_label.text.contains("Kelp Fiber"), "Glass Rim status should preserve the nearby cargo alternative")
		runner._expect(main.status_label.text.contains("oxygen"), "Glass Rim status should frame the oxygen risk")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Glass Rim reading status")

	var repeat_handled: bool = main.call("_try_rim_glass_reading_interaction")
	runner._expect(repeat_handled, "Glass Rim should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recovered"), "Glass Rim repeat interaction should not duplicate the payoff")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved == save_before, "Glass Rim reading should not mutate durable progression")
	runner._expect(not saved.has("rim_glass_reading"), "Glass Rim reading should not create durable reading state")
	runner._expect(not saved.has("glass_rim_route"), "Glass Rim reading should not create durable route state")
	runner._expect(not saved.has("route_graph"), "Glass Rim reading should not create route graph state")
	var callout: String = ResearchResultCalloutServiceScript.format_rim_glass_reading_callout(main)
	runner._expect(callout.contains("Glass Rim reading"), "Glass Rim research line should name the new payoff")
	runner._expect(callout.contains("cargo remains optional"), "Glass Rim research line should preserve the cargo-vs-knowledge decision")
	runner._expect_no_echo_lens_locator_language(callout, "Glass Rim research line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Remembered place: Glass Rim"), "Glass Rim extraction summary should remember the specific payoff place")
	runner._expect(extraction_summary.contains("Route choice: recovered Glass Rim reading"), "Glass Rim extraction summary should distinguish this payoff from the survey")
	runner._expect(extraction_summary.contains("Research: Glass Rim reading"), "Glass Rim extraction summary should include the new research payoff")
	runner._expect(extraction_summary.contains("timing, cargo, or return"), "Glass Rim extraction summary should tease the next decision loop")
	runner._expect(not extraction_summary.to_lower().contains("checklist"), "Glass Rim extraction summary should not imply checklist UI")
	runner._expect(not extraction_summary.to_lower().contains("map"), "Glass Rim extraction summary should not imply map UI")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Glass Rim", "recent route helper should prefer Glass Rim after the new payoff")
	main.progression_state.current_run_number = 9
	main.progression_state.current_run_seed = 1009
	main.call("_record_recent_expedition", "Extracted", 0)
	var recent_log: String = main.call("_format_recent_expedition_log")
	runner._expect(recent_log.contains("route Glass Rim"), "Glass Rim recent log should name the new payoff place")
	runner._expect(recent_log.contains("next timing, cargo, or return"), "Glass Rim recent log should tease the compact next dive")

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_rim_glass_reading_recovered, "Glass Rim reading should reset between expeditions")
	runner._expect(core.color.a >= 0.8, "Glass Rim reading should become visible again on expedition reset")
	runner._expect(spark.visible, "Glass Rim reading spark should reset between expeditions")
	main.free()

func _test_glass_ray_drifter_passive_route_read(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var ray := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRayDrifter") as Area2D
	var wake := ray.get_node("RouteWake") as Polygon2D
	var body := ray.get_node("RayBody") as Polygon2D
	var scan_marker := ray.get_node("ScanMarker") as Polygon2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()

	runner._expect(ray.get("discovery_id") == "glass_ray_drifter", "Glass Ray should expose a stable scan id")
	runner._expect(ray.get("display_name") == "Glass Ray Drifter", "Glass Ray should expose a compact display name")
	var description: String = String(ray.get("description"))
	var gameplay_fact: String = String(ray.get("gameplay_fact"))
	runner._expect(description.contains("Glass Rim Cut"), "Glass Ray description should anchor to the remembered branch")
	runner._expect(gameplay_fact.contains("Glass Rim slackwater window"), "Glass Ray gameplay fact should teach the timing read")
	runner._expect(gameplay_fact.contains("wait"), "Glass Ray gameplay fact should encourage observation over forcing the route")
	runner._expect(gameplay_fact.contains("cross after the turn"), "Glass Ray gameplay fact should explain the local traversal timing")
	runner._expect(gameplay_fact.contains("bank cargo"), "Glass Ray gameplay fact should preserve the push-or-return choice")
	runner._expect(not gameplay_fact.to_lower().contains("coordinate") and not gameplay_fact.to_lower().contains("checklist"), "Glass Ray gameplay fact should not read like exact locator or checklist copy")
	runner._expect_no_monster_combat_language(description, "Glass Ray description")
	runner._expect_no_monster_combat_language(gameplay_fact, "Glass Ray gameplay fact")
	runner._expect(wake.color.a <= 0.14 and wake.color.b > wake.color.r, "Glass Ray route wake should stay subtle and not read as a reward")
	runner._expect(body.color.a <= 0.55, "Glass Ray should read as a passive translucent creature")
	runner._expect(scan_marker.color.a < 0.3, "Glass Ray scan marker should stay quiet while idle")
	runner._expect(Vector2(ray.get("move_start")).x < Vector2(ray.get("move_end")).x, "Glass Ray should drift across the Glass Rim route read instead of bobbing in place")
	runner._expect(Vector2(ray.get("move_start")).distance_to(Vector2(ray.get("move_end"))) >= 200.0, "Glass Ray drift should be long enough to imply a timing loop")
	runner._expect(ray.find_child("HealthBar", true, false) == null, "Glass Ray should not add combat health UI")
	runner._expect(ray.find_child("LootTable", true, false) == null, "Glass Ray should not add loot tables")
	runner._expect(ray.find_child("HarvestArea", true, false) == null, "Glass Ray should not add harvesting")
	runner._expect(ray.find_child("CaptureArea", true, false) == null, "Glass Ray should not add capture behavior")
	runner._expect(ray.find_child("Predator", true, false) == null, "Glass Ray should not use predator behavior")
	runner._expect(ray.get_node_or_null("ResourcePickup") == null, "Glass Ray should not be a resource pickup")

	var start_position := ray.global_position
	ray.call("_physics_process", 1.0)
	runner._expect(ray.global_position != start_position, "Glass Ray should drift instead of reading as static scenery")

	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = ray.global_position
	var scan_candidates: Array[Node] = [ray]
	runner._expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == ray, "scanner target selection should find Glass Ray reliably at close range")
	runner._expect(ScanEffectTextServiceScript.scan_target_gameplay_fact(main, ray).contains("slackwater"), "scanner read should expose the route-timing lesson")
	runner._expect(main.progression_state.to_save_data() == save_before, "unscanned Glass Ray should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "unscanned Glass Ray should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "unscanned Glass Ray should not mutate cargo")

	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = ScanTargetResolverScript.target_id(ray)
	var display_name: String = ScanTargetResolverScript.display_name(ray)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(ray),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(main, ray)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, ray) + ScanEffectTextServiceScript.first_scan_guidance(main, ray)
	])
	var first_scan_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, ray)
	runner._expect(main.progression_state.has_discovery("glass_ray_drifter"), "first Glass Ray scan should record a normal durable discovery")
	runner._expect(main.run_completed_scans == ["glass_ray_drifter"], "first Glass Ray scan should count as current-run observation evidence")
	runner._expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Glass Ray scan should use the normal scan oxygen cost")
	runner._expect(first_scan_status.contains("Scanned Glass Ray Drifter"), "first Glass Ray scan status should name the creature")
	runner._expect(first_scan_status.contains("slackwater observation refreshed"), "first Glass Ray scan status should refresh the route lesson")
	runner._expect(first_scan_guidance.contains("cross on slackwater"), "first Glass Ray scan guidance should teach the Glass Rim timing decision")
	runner._expect(first_scan_guidance.contains("bank cargo"), "first Glass Ray scan guidance should preserve the return option")
	runner._expect_no_monster_combat_language(first_scan_status, "Glass Ray first scan status")
	runner._expect(not first_scan_status.to_lower().contains("field guide"), "Glass Ray scan should not imply field-guide UI")
	runner._expect(not first_scan_status.to_lower().contains("checklist"), "Glass Ray scan should not imply checklist UI")
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("Glass Ray Drifter"), "Glass Ray scan should produce compact discovery memory")
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("without fighting"), "Glass Ray discovery memory should frame observation as non-combat")
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Glass Ray slackwater timing"), "Glass Ray scan should produce a compact Glass Rim route-choice memory")
	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Outer Shelf"), "Glass Ray scan should remember the broad Outer Shelf place")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Outer Shelf", "Glass Ray scan should support current-run Outer Shelf route memory")
	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved.get("scan_discoveries", {}).has("glass_ray_drifter"), "Glass Ray discovery should persist through normal scan discovery storage")
	runner._expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Glass Ray scan should not mutate resources")
	runner._expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Glass Ray scan should not mutate upgrades")
	runner._expect(not saved.has("glass_ray_objective"), "Glass Ray scan should not create durable objective-chain state")
	runner._expect(not saved.has("monster_parts"), "Glass Ray scan should not add monster-part economy state")
	runner._expect(not saved.has("creature_inventory"), "Glass Ray scan should not add creature inventory state")
	main.queue_free()
