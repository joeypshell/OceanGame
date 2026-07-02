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

func _test_salvage_manifest_interaction(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_manifest = true
	main.dive_session.oxygen = 19.0
	main.dive_session.current_cargo.append("shell_fragments")
	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	main.call("_sync_salvage_pocket_open_state")
	var manifest_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestHalo") as Polygon2D
	var manifest_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestCore") as Polygon2D
	var manifest_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestSpark") as Polygon2D
	var opened_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	runner._expect(opened_lane.visible, "owned Salvage Cutter I should make the manifest lane visible")
	runner._expect(manifest_core.color.a >= 0.7, "Salvage Manifest should start visibly recoverable")
	runner._expect(manifest_spark.visible, "Salvage Manifest spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Salvage manifest"), "Salvage Manifest proximity should own the active dive prompt")
	runner._expect(prompt.contains("E/Enter"), "Salvage Manifest prompt should keep the compact interaction command")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_salvage_manifest_interaction")
	runner._expect(handled, "Salvage Manifest should handle interact while nearby during a dive with the cutter")
	runner._expect(main.run_salvage_manifest_recovered, "Salvage Manifest interaction should record one run-scoped manifest")
	runner._expect(main.run_reached_dusk_trench, "Salvage Manifest recovery should count as meaningful lower-route reach evidence")
	runner._expect(manifest_halo.color.a <= 0.09, "Salvage Manifest halo should visibly dim after recovery")
	runner._expect(manifest_core.color.a <= 0.2, "Salvage Manifest core should visibly dim after recovery")
	runner._expect(not manifest_spark.visible, "Salvage Manifest spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 19.0), "Salvage Manifest should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Salvage Manifest should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_after == save_before, "Salvage Manifest should not mutate durable progression")
	runner._expect(not save_after.has("salvage_manifest"), "Salvage Manifest should not create durable manifest state")
	runner._expect(not save_after.has("salvage_inventory"), "Salvage Manifest should not create salvage inventory state")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Salvage Manifest interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("shell fragments"), "Salvage Manifest status should frame the nearby cargo-vs-knowledge choice")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Salvage Manifest status")

	var repeat_handled: bool = main.call("_try_salvage_manifest_interaction")
	runner._expect(repeat_handled, "Salvage Manifest should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recovered"), "Salvage Manifest repeat interaction should not duplicate the payoff")

	main.player_near_salvage_manifest = false
	var not_handled: bool = main.call("_try_salvage_manifest_interaction")
	runner._expect(not not_handled, "Salvage Manifest should not consume interact outside its proximity zone")

	var callout: String = ResearchResultCalloutServiceScript.format_salvage_manifest_research_callout(main)
	runner._expect(callout.contains("Salvage Manifest"), "Salvage Manifest result memory should name the recovered payoff")
	runner._expect(callout.contains("cut-open wreck pocket"), "Salvage Manifest result memory should name the opened-pocket context")
	runner._expect(callout.contains("shell cargo is optional"), "Salvage Manifest result memory should preserve the cargo-vs-knowledge decision")
	runner._expect(not callout.to_lower().contains("craft"), "Salvage Manifest result memory should not introduce crafting")
	runner._expect(not callout.to_lower().contains("loot table"), "Salvage Manifest result memory should avoid loot-system language")
	runner._expect_no_echo_lens_locator_language(callout, "Salvage Manifest result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Salvage Manifest"), "Salvage Manifest extraction summary should include recovered manifest memory")
	runner._expect(extraction_summary.contains("Salvage Pocket"), "Salvage Manifest extraction summary should remember the opened pocket place")
	runner._expect(not extraction_summary.to_lower().contains("inventory"), "Salvage Manifest extraction summary should avoid inventory language")
	var save_before_recent: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main.progression_state.current_run_number = 21
	main.progression_state.current_run_seed = 3021
	main._record_recent_expedition("Extracted", 1)
	var log_text: String = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#21 Extracted"), "recent expedition log should include Salvage Manifest runs")
	runner._expect(log_text.contains("route Salvage Pocket"), "Salvage Manifest should produce compact salvage-pocket route memory")
	runner._expect(not log_text.contains("route Wide Reef Chamber"), "Salvage Pocket memory should take priority over upstream wide chamber memory")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Salvage Pocket", "latest route helper should expose Salvage Pocket after manifest evidence")
	runner._expect(main.progression_state.to_save_data() == save_before_recent, "Salvage Pocket recent route memory should remain session-only")
	runner._expect(not main.progression_state.to_save_data().has("salvage_pocket_route"), "recent Salvage Pocket memory should not create durable route state")
	main.call("_reset_run_telemetry")
	runner._expect(not main.run_salvage_manifest_recovered, "Salvage Manifest should reset between expeditions")
	runner._expect(manifest_core.color.a >= 0.7, "Salvage Manifest should become visible again after expedition reset")
	runner._expect(manifest_spark.visible, "Salvage Manifest spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_salvage_manifest_research_callout(fresh_main) == "", "Salvage Manifest result line should stay hidden before payoff recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Salvage Manifest"), "Salvage Manifest extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_salvage_pocket_silt_timing_cue_visual_only(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.salvage_silt_timing_alpha(0.0, MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.salvage_silt_timing_alpha(MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.25, MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	var repeat_alpha: float = RouteTimingCuePresenterScript.salvage_silt_timing_alpha(MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.5, MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	runner._expect(high_alpha > low_alpha, "Salvage silt timing cue alpha should pulse upward to suggest a safe read window")
	runner._expect(is_equal_approx(low_alpha, repeat_alpha), "Salvage silt timing cue pulse should repeat smoothly")
	main.free()

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	scene_main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	scene_main.call("_sync_salvage_pocket_open_state")
	var opened_lane := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	var wake := opened_lane.get_node("SiltTimingWake") as Polygon2D
	var window := opened_lane.get_node("SiltTimingWindow") as Polygon2D
	var tick := opened_lane.get_node("SiltTimingTickA") as Polygon2D
	var manifest_core := opened_lane.get_node("SalvageManifest/ManifestCore") as Polygon2D
	var return_cue := opened_lane.get_node("ReturnCurrentCue") as Polygon2D
	scene_main.dive_session.reset(26.0)
	scene_main.dive_session.start()
	scene_main.dive_session.current_cargo.append("shell_fragments")
	var save_before: Dictionary = scene_main.progression_state.to_save_data().duplicate(true)

	RouteTimingCueServiceScript.update_salvage_silt_timing_cue(scene_main, MainScript.SALVAGE_SILT_TIMING_PERIOD_SECONDS * 0.25)
	runner._expect(opened_lane.visible, "Salvage silt timing cue should live in the opened pocket lane")
	runner._expect(window.color.b > window.color.g and window.color.b > window.color.r, "Salvage silt timing window should use pale silt timing color instead of safe-current green")
	runner._expect(return_cue.color.g > window.color.g, "Salvage safe-return cue should stay visually distinct from the timing window")
	runner._expect(wake.color.a <= 0.15 and window.color.a <= 0.17 and tick.color.a <= 0.23, "Salvage silt timing cue should stay subtle and non-blocking")
	runner._expect(window.color.a < manifest_core.color.a, "Salvage silt timing cue should not read as the main salvage payoff")
	runner._expect(is_equal_approx(scene_main.dive_session.oxygen, 26.0), "Salvage silt timing cue should not drain oxygen")
	runner._expect(scene_main.dive_session.current_cargo == ["shell_fragments"], "Salvage silt timing cue should not mutate cargo")
	runner._expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Salvage silt timing cue should not change dive result")
	runner._expect(scene_main.progression_state.to_save_data() == save_before, "Salvage silt timing cue should not mutate durable progression")
	runner._expect(opened_lane.find_child("PressureBoundary", true, false) == null, "Salvage silt timing cue should not add hidden pressure behavior")
	runner._expect(opened_lane.find_child("Predator", true, false) == null, "Salvage silt timing cue should not add combat pressure")
	scene_main.queue_free()

func _test_tideglass_sample_interaction(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_tideglass_sample = true
	main.dive_session.oxygen = 21.0
	main.dive_session.current_cargo.append("shell_fragments")
	var sample_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo") as Polygon2D
	var sample_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D
	var sample_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_tideglass_sample_payoff(main)
	runner._expect(sample_core.color.a >= 0.7, "Tideglass Sample should start visibly recoverable")
	runner._expect(sample_spark.visible, "Tideglass Sample spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Tideglass"), "Tideglass proximity should own the active dive prompt")
	runner._expect(prompt.contains("Tideglass"), "Tideglass prompt should name the concrete knowledge payoff")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_tideglass_sample_interaction")
	runner._expect(handled, "Tideglass Sample should handle interact while nearby during a dive")
	runner._expect(main.run_tideglass_sample_recovered, "Tideglass Sample interaction should record one run-scoped sample")
	runner._expect(main.run_reached_dusk_trench, "Tideglass Sample recovery should count as meaningful lower-route reach evidence")
	runner._expect(sample_halo.color.a <= 0.08, "Tideglass Sample halo should visibly dim after recovery")
	runner._expect(sample_core.color.a <= 0.2, "Tideglass Sample core should visibly dim after recovery")
	runner._expect(not sample_spark.visible, "Tideglass Sample spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 21.0), "Tideglass Sample should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Tideglass Sample should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_after == save_before, "Tideglass Sample should not mutate durable progression")
	runner._expect(not save_after.has("tideglass_sample"), "Tideglass Sample should not create durable sample state")
	runner._expect(not save_after.has("mirror_kelp_pass"), "Mirror Kelp Pass payoff should not create durable route state")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Tideglass Sample interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("Wide Reef"), "Tideglass status should keep broad return language")
		runner._expect(main.status_label.text.contains("Mirror Kelp"), "Tideglass status should name the branch payoff")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Tideglass status")

	var repeat_handled: bool = main.call("_try_tideglass_sample_interaction")
	runner._expect(repeat_handled, "Tideglass Sample should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Tideglass repeat interaction should not duplicate the payoff")

	main.player_near_tideglass_sample = false
	var not_handled: bool = main.call("_try_tideglass_sample_interaction")
	runner._expect(not not_handled, "Tideglass Sample should not consume interact outside its proximity zone")

	var callout: String = ResearchResultCalloutServiceScript.format_tideglass_sample_research_callout(main)
	runner._expect(callout.contains("Tideglass Sample"), "Tideglass result memory should name the recovered sample")
	runner._expect(callout.contains("Mirror Kelp"), "Tideglass result memory should name the branch context")
	runner._expect(callout.contains("return-current"), "Tideglass result memory should explain why the sample mattered")
	runner._expect_no_echo_lens_locator_language(callout, "Tideglass result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Tideglass Sample"), "Tideglass extraction summary should include recovered sample memory")
	runner._expect(extraction_summary.contains("Mirror Kelp"), "Tideglass extraction summary should keep the branch payoff readable")
	runner._expect(not extraction_summary.to_lower().contains("inventory"), "Tideglass extraction summary should avoid inventory language")
	main.call("_reset_run_telemetry")
	runner._expect(not main.run_tideglass_sample_recovered, "Tideglass Sample should reset between expeditions")
	runner._expect(sample_core.color.a >= 0.7, "Tideglass Sample should become visible again after expedition reset")
	runner._expect(sample_spark.visible, "Tideglass Sample spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_tideglass_sample_research_callout(fresh_main) == "", "Tideglass result line should stay hidden before payoff recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Tideglass Sample"), "Tideglass extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_glassfin_swarm_spacing_cue_visual_only(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.glassfin_swarm_spacing_alpha(0.0, MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.glassfin_swarm_spacing_alpha(MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.25, MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)
	var repeat_alpha: float = RouteTimingCuePresenterScript.glassfin_swarm_spacing_alpha(MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.5, MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)

	runner._expect(high_alpha > low_alpha, "Glassfin Swarm spacing cue alpha should pulse upward to suggest a pass window")
	runner._expect(is_equal_approx(low_alpha, repeat_alpha), "Glassfin Swarm spacing cue pulse should repeat smoothly")

	main.dive_session.reset(24.0)
	main.dive_session.start()
	main.dive_session.current_cargo.append("glow_plankton")
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	RouteTimingCueServiceScript.update_glassfin_swarm_spacing_cue(main, 0.8)
	runner._expect(is_equal_approx(main.dive_session.oxygen, 24.0), "Glassfin Swarm spacing cue should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == ["glow_plankton"], "Glassfin Swarm spacing cue should not change carried cargo")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Glassfin Swarm spacing cue should not change dive result")
	runner._expect(main.progression_state.to_save_data() == save_before, "Glassfin Swarm spacing cue should not mutate progression")
	main.free()

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	var swarm := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm") as Area2D
	var window := swarm.get_node("SpacingWindowPulse") as Polygon2D
	var wake := swarm.get_node("SpacingWake") as Polygon2D
	var tick_a := swarm.get_node("SpacingTickA") as Polygon2D
	var return_gap := swarm.get_node("ReturnGapCue") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var resource_glimmer := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D

	RouteTimingCueServiceScript.update_glassfin_swarm_spacing_cue(scene_main, MainScript.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS * 0.25)
	runner._expect(window.color.b > window.color.g and window.color.b > window.color.r, "Glassfin Swarm spacing window should use pale blue timing color instead of safe-current green")
	runner._expect(wake.color.b > wake.color.g, "Glassfin Swarm wake should stay bluer than green return-current language")
	runner._expect(tick_a.color.a <= 0.25 and window.color.a <= 0.19, "Glassfin Swarm spacing cue should stay readable without becoming a hard wall")
	runner._expect(return_current.color.g > window.color.g, "Glassfin Swarm safe-return current should stay greener than the spacing cue")
	runner._expect(window.color.b > resource_glimmer.color.b, "Glassfin Swarm spacing cue should stay distinct from yellow-green resource glimmers")
	runner._expect(window.color.r > pressure_shutter.color.r and window.color.g > pressure_shutter.color.g, "Glassfin Swarm spacing cue should stay brighter than pressure-lock language")
	runner._expect(return_gap.color.a < return_current.color.a, "Glassfin Swarm return gap should remain softer than the main return current")
	runner._expect(swarm.find_child("CollisionShape2D", true, false) == null, "Glassfin Swarm spacing cue should not add hidden collision")
	runner._expect(swarm.find_child("PressureBoundary", true, false) == null, "Glassfin Swarm spacing cue should not add pressure behavior")
	runner._expect(swarm.find_child("Predator", true, false) == null, "Glassfin Swarm spacing cue should not reuse predator behavior")
	scene_main.queue_free()

func _test_lantern_ray_timing_lane_is_visual_only(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var timing_lane := main.get_node("Creatures/LanternRayRoute/TimingLane") as Node2D
	var timing_upper := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneUpper") as Polygon2D
	var timing_lower := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingLaneLower") as Polygon2D
	var timing_tick := main.get_node("Creatures/LanternRayRoute/TimingLane/TimingTickA") as Polygon2D
	var route_lane := main.get_node("Creatures/LanternRayRoute/RouteLane") as Polygon2D
	var blackwater_pressure := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var dusk_low_visibility := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D

	runner._expect(timing_lane.find_child("CollisionShape2D", true, false) == null, "Lantern Ray timing lane should not add collision or contact punishment")
	runner._expect(timing_lane.get_node_or_null("InteractZone") == null, "Lantern Ray timing lane should not add an interaction hotspot")
	runner._expect(timing_lane.get_node_or_null("ResourcePickup") == null, "Lantern Ray timing lane should not add harvest or cargo behavior")
	runner._expect(timing_lane.get_node_or_null("Predator") == null, "Lantern Ray timing lane should not reuse predator behavior")
	runner._expect(timing_lane.get_node_or_null("PressureBoundary") == null, "Lantern Ray timing lane should not add a pressure gate")
	runner._expect(timing_upper.color.b >= timing_upper.color.r and timing_upper.color.r > timing_upper.color.g, "Lantern Ray timing lane should use pale timing color instead of safe-current green")
	runner._expect(timing_upper.color.g < route_lane.color.g, "Lantern Ray timing lane should stay distinct from the creature route-current lane")
	runner._expect(timing_upper.color.r > blackwater_pressure.color.r and timing_upper.color.g > blackwater_pressure.color.g, "Lantern Ray timing lane should be brighter than Blackwater pressure language")
	runner._expect(timing_upper.color.r > dusk_low_visibility.color.r and timing_upper.color.g > dusk_low_visibility.color.g, "Lantern Ray timing lane should be brighter than Dusk low-visibility pressure language")
	runner._expect(timing_upper.color.a <= 0.18 and timing_lower.color.a <= 0.14 and timing_tick.color.a <= 0.24, "Lantern Ray timing lane should remain readable without becoming a hard hazard wall")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.add_cargo("kelp_fiber")
	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades["pressure_seal_1"] = true
	main.progression_state.add_discovery("lantern_ray", "Lantern Ray", "Passive route creature.", "Watch the timing lane.")
	main.run_completed_scans.append("lantern_ray")
	main.current_predator_route_id = "test_route"
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()
	var bank_before: Dictionary = main.progression_state.banked_resources.duplicate(true)
	var upgrades_before: Dictionary = main.progression_state.purchased_upgrades.duplicate(true)
	var discoveries_before: Dictionary = main.progression_state.scan_discoveries.duplicate(true)
	var scans_before: Array[String] = main.run_completed_scans.duplicate()
	var route_before: String = main.current_predator_route_id
	var upper_alpha_before: float = timing_upper.color.a

	RouteTimingCueServiceScript.update_lantern_ray_timing_lane(main, 0.9)
	runner._expect(not is_equal_approx(timing_upper.color.a, upper_alpha_before), "Lantern Ray timing lane should visibly pulse as a timing cue")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Lantern Ray timing lane should not secretly drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Lantern Ray timing lane should not mutate carried cargo")
	runner._expect(main.progression_state.banked_resources == bank_before, "Lantern Ray timing lane should not mutate banked resources")
	runner._expect(main.progression_state.purchased_upgrades == upgrades_before, "Lantern Ray timing lane should not mutate upgrades")
	runner._expect(main.progression_state.scan_discoveries == discoveries_before, "Lantern Ray timing lane should not mutate durable discoveries")
	runner._expect(main.run_completed_scans == scans_before, "Lantern Ray timing lane should not mutate run scan evidence")
	runner._expect(main.current_predator_route_id == route_before, "Lantern Ray timing lane should not change seeded creature route state")
	main.queue_free()
