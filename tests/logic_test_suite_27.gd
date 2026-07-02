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

func _test_blackwater_trace_payoff(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blackwater_crack = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["glow_plankton"]
	main.progression_state.banked_resources = {"shell_fragments": 2}
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var trace_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem") as Polygon2D
	var trace_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark") as Polygon2D
	main.call("_sync_blackwater_crack_gate_state")
	runner._expect(trace_gem.color.a >= 0.7, "Blackwater Trace should start visibly recoverable when the route is open")
	runner._expect(trace_spark.visible, "Blackwater Trace spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Blackwater Sill"), "Blackwater open-route proximity should own the active dive prompt")
	runner._expect(prompt.contains("record trace"), "Blackwater prompt should explain the concrete knowledge payoff")

	var handled: bool = main.call("_try_blackwater_crack_interaction")
	runner._expect(handled, "Blackwater open route should handle interact while nearby during a dive")
	runner._expect(main.run_blackwater_trace_recovered, "Blackwater interaction should record one run-scoped trace")
	runner._expect(trace_gem.color.a <= 0.2, "Blackwater Trace should visibly dim after recovery")
	runner._expect(not trace_spark.visible, "Blackwater Trace spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Blackwater Trace should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["glow_plankton"], "Blackwater Trace should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("shell_fragments") == 2, "Blackwater Trace should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Blackwater Trace interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("deep-route reading"), "Blackwater Trace status should name the knowledge payoff")
		runner._expect(main.status_label.text.contains("Silt Vein"), "Blackwater Trace status should remind the broad return chain")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Blackwater Trace status")

	var repeat_handled: bool = main.call("_try_blackwater_crack_interaction")
	runner._expect(repeat_handled, "Blackwater Trace should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Blackwater Trace repeat interaction should not duplicate the payoff")

	main.player_near_blackwater_crack = false
	var not_handled: bool = main.call("_try_blackwater_crack_interaction")
	runner._expect(not not_handled, "Blackwater Trace should not consume interact outside its proximity zone")

	var callout: String = ResearchResultCalloutServiceScript.format_blackwater_trace_research_callout(main)
	runner._expect(callout.contains("Blackwater Trace"), "Blackwater Trace result memory should name the payoff")
	runner._expect(callout.contains("right branch"), "Blackwater Trace result memory should explain the route choice")
	runner._expect(callout.contains("deeper route"), "Blackwater Trace result memory should hint at future route growth")
	runner._expect(callout.contains("Silt Vein"), "Blackwater Trace result memory should name the first broad return landmark")
	runner._expect(callout.contains("Blue Chimney"), "Blackwater Trace result memory should name the mid return landmark")
	runner._expect(callout.contains("Drop Arch"), "Blackwater Trace result memory should name the upper lower-route landmark")
	runner._expect_no_echo_lens_locator_language(callout, "Blackwater Trace result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Blackwater Trace"), "Blackwater extraction summary should include recovered trace memory")
	runner._expect(not extraction_summary.contains("%s"), "Blackwater extraction summary should not leak string placeholders")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("blackwater_trace"), "Blackwater Trace should not become durable save data")
	runner._expect(not saved.has("blackwater_route"), "Blackwater Trace should not create durable route state")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_blackwater_trace_research_callout(fresh_main) == "", "Blackwater Trace result line should stay hidden before recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Blackwater Trace"), "Blackwater extraction summary should stay hidden before trace recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_blackwater_trace_recovered, "Blackwater Trace should reset between expeditions")
	runner._expect(trace_gem.color.a >= 0.7, "Blackwater Trace core should become visible again on expedition reset")
	runner._expect(trace_spark.visible, "Blackwater Trace spark should reset between expeditions")
	main.free()

func _test_glass_kelp_reading_payoff(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_glass_kelp_ledge = true
	main.dive_session.oxygen = 17.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"glow_plankton": 2}
	var reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard") as Polygon2D
	var reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_glass_kelp_reading_payoff(main)
	runner._expect(reading_shard.color.a >= 0.7, "Glass Kelp reading should start visibly recoverable")
	runner._expect(reading_spark.visible, "Glass Kelp reading spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Glass Kelp Ledge"), "Glass Kelp proximity should own the active dive prompt")
	runner._expect(prompt.contains("record kelp reading"), "Glass Kelp prompt should explain the concrete payoff")

	var handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	runner._expect(handled, "Glass Kelp Ledge should handle interact while nearby during a dive")
	runner._expect(main.run_glass_kelp_reading_recovered, "Glass Kelp interaction should record one run-scoped reading")
	runner._expect(main.run_reached_dusk_trench, "Glass Kelp interaction should count as reaching Dusk Trench for place memory")
	runner._expect(reading_shard.color.a <= 0.2, "Glass Kelp reading should visibly dim after recovery")
	runner._expect(not reading_spark.visible, "Glass Kelp reading spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 17.0), "Glass Kelp reading should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Kelp reading should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("glow_plankton") == 2, "Glass Kelp reading should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Glass Kelp interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("Blackwater"), "Glass Kelp status should keep broad return language")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Glass Kelp status")

	var repeat_handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	runner._expect(repeat_handled, "Glass Kelp Ledge should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Glass Kelp repeat interaction should not duplicate the payoff")

	main.player_near_glass_kelp_ledge = false
	var not_handled: bool = main.call("_try_glass_kelp_ledge_interaction")
	runner._expect(not not_handled, "Glass Kelp Ledge should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("glass_kelp_reading"), "Glass Kelp reading should not become durable save data")
	runner._expect(not saved.has("glass_kelp"), "Glass Kelp should not create durable route state")
	runner._expect(not saved.has("dusk_trench"), "Glass Kelp should not create durable Dusk Trench state")

	var callout: String = ResearchResultCalloutServiceScript.format_glass_kelp_reading_callout(main)
	runner._expect(callout.contains("Glass Kelp"), "Glass Kelp result memory should name the payoff")
	runner._expect(callout.contains("Dusk Trench"), "Glass Kelp result memory should name the broad route context")
	runner._expect(callout.contains("safer ledge"), "Glass Kelp result memory should explain why the pocket mattered")
	runner._expect_no_echo_lens_locator_language(callout, "Glass Kelp result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Glass Kelp reading"), "Glass Kelp extraction summary should include recovered reading memory")
	runner._expect(not extraction_summary.contains("%s"), "Glass Kelp extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_glass_kelp_reading_callout(fresh_main) == "", "Glass Kelp result line should stay hidden before reading recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Glass Kelp reading"), "Glass Kelp extraction summary should stay hidden before reading recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_glass_kelp_reading_recovered, "Glass Kelp reading should reset between expeditions")
	runner._expect(reading_shard.color.a >= 0.7, "Glass Kelp reading should become visible again on expedition reset")
	runner._expect(reading_spark.visible, "Glass Kelp reading spark should reset between expeditions")
	main.free()

func _test_hollow_reef_cave_reading_payoff(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_hollow_reef = true
	main.dive_session.oxygen = 16.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"kelp_fiber": 2}
	var reading_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard") as Polygon2D
	var reading_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_hollow_reef_reading_payoff(main)
	runner._expect(reading_shard.color.a >= 0.7, "Hollow Reef cave reading should start visibly recoverable")
	runner._expect(reading_spark.visible, "Hollow Reef cave reading spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Hollow Reef"), "Hollow Reef proximity should own the active dive prompt")
	runner._expect(prompt.contains("E/Enter"), "Hollow Reef prompt should keep the compact interaction command")

	var handled: bool = main.call("_try_hollow_reef_interaction")
	runner._expect(handled, "Hollow Reef should handle interact while nearby during a dive")
	runner._expect(main.run_hollow_reef_reading_recovered, "Hollow Reef interaction should record one run-scoped reading")
	runner._expect(main.run_reached_dusk_trench, "Hollow Reef interaction should count as reaching Dusk Trench for place memory")
	runner._expect(reading_shard.color.a <= 0.2, "Hollow Reef cave reading should visibly dim after recovery")
	runner._expect(not reading_spark.visible, "Hollow Reef cave reading spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 16.0), "Hollow Reef reading should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Hollow Reef reading should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("kelp_fiber") == 2, "Hollow Reef reading should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Hollow Reef interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("Dusk"), "Hollow Reef status should keep broad route language")
		runner._expect(main.status_label.text.contains("Blackwater"), "Hollow Reef status should keep broad return-chain language")
		runner._expect_no_echo_lens_locator_language(main.status_label.text, "Hollow Reef status")

	var repeat_handled: bool = main.call("_try_hollow_reef_interaction")
	runner._expect(repeat_handled, "Hollow Reef should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Hollow Reef repeat interaction should not duplicate the payoff")

	main.player_near_hollow_reef = false
	var not_handled: bool = main.call("_try_hollow_reef_interaction")
	runner._expect(not not_handled, "Hollow Reef should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("hollow_reef_reading"), "Hollow Reef reading should not become durable save data")
	runner._expect(not saved.has("hollow_reef"), "Hollow Reef should not create durable route state")
	runner._expect(not saved.has("hollow_deeper_reef"), "Hollow Reef deeper promise should not become durable route state")
	runner._expect(not saved.has("deep_reef_closed"), "Hollow Reef closed promise should not create durable gate state yet")
	runner._expect(not saved.has("dusk_trench"), "Hollow Reef should not create durable Dusk Trench state")

	var callout: String = ResearchResultCalloutServiceScript.format_hollow_reef_reading_callout(main)
	runner._expect(callout.contains("Hollow Reef"), "Hollow Reef result memory should name the branch")
	runner._expect(callout.contains("side-cave branch"), "Hollow Reef result memory should explain why the branch mattered")
	runner._expect(callout.contains("Dusk Trench"), "Hollow Reef result memory should name the broad route context")
	runner._expect_no_echo_lens_locator_language(callout, "Hollow Reef result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Hollow Reef cave reading"), "Hollow Reef extraction summary should include recovered reading memory")
	runner._expect(not extraction_summary.contains("%s"), "Hollow Reef extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_hollow_reef_reading_callout(fresh_main) == "", "Hollow Reef result line should stay hidden before reading recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Hollow Reef cave reading"), "Hollow Reef extraction summary should stay hidden before reading recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_hollow_reef_reading_recovered, "Hollow Reef reading should reset between expeditions")
	runner._expect(reading_shard.color.a >= 0.7, "Hollow Reef cave reading should become visible again on expedition reset")
	runner._expect(reading_spark.visible, "Hollow Reef cave reading spark should reset between expeditions")
	main.free()

func _test_upgrade_copy_presenter(runner) -> void:
	var cost := {
		"driftwood": 2,
		"quartz_glass": 1,
	}
	var names := {
		"driftwood": "Driftwood",
		"quartz_glass": "Quartz Glass",
	}
	var owned := {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	runner._expect(UpgradeCopyPresenterScript.format_upgrade_cost({}, names) == "none", "empty upgrade costs should show none")
	runner._expect(UpgradeCopyPresenterScript.format_upgrade_cost(cost, names).contains("Driftwood x2"), "upgrade cost copy should use display names")
	runner._expect(UpgradeCopyPresenterScript.format_missing_resources(cost, owned, names).contains("Driftwood x1"), "missing resource block should include missing display names")
	runner._expect(not UpgradeCopyPresenterScript.format_missing_resources(cost, owned, names).contains("Quartz Glass"), "missing resource block should omit fully owned resources")
	runner._expect(UpgradeCopyPresenterScript.format_missing_resources_inline(cost, owned, names) == "Driftwood x1", "inline missing resources should stay comma-free for one item")
	runner._expect(UpgradeCopyPresenterScript.format_missing_resources_inline(cost, {"driftwood": 2, "quartz_glass": 1}, names) == "none", "inline missing resources should report none when complete")
	runner._expect(UpgradeCopyPresenterScript.format_material_need_list([]) == "materials", "empty material lists should keep fallback copy")
	runner._expect(UpgradeCopyPresenterScript.format_material_need_list(["Driftwood", "Quartz Glass"]) == "Driftwood/Quartz Glass", "two material lists should use slash copy")
	runner._expect(UpgradeCopyPresenterScript.format_need_list(["Food", "Water", "Power"]) == "Food/Water/Power", "three base needs should stay compact")
	runner._expect(UpgradeCopyPresenterScript.format_upgrade_effect_summary(EchoLensUpgrade.id, EchoLensUpgrade.owned_text).contains("not a locator"), "upgrade effect presenter should preserve Echo Lens role copy")
	runner._expect(UpgradeCopyPresenterScript.format_standard_upgrade_state("Effect: +10 max O2.", false, "", "", true, "E or Enter", "none").begins_with("State: Available now"), "standard upgrade state presenter should format available upgrades")
	runner._expect(UpgradeCopyPresenterScript.format_resonance_key_upgrade_state("Effect: opens East Shelf hatch only.", false, "", true, false, "E or Enter", "Glow Plankton x1").contains("Recover: East Shelf or Drop Echo"), "resonance upgrade presenter should preserve route-research copy")
	runner._expect(UpgradeCopyPresenterScript.format_salvage_cutter_upgrade_state("Effect: opens the sealed Wide Reef salvage pocket.", false, true, false, "E or Enter", "Shell Fragments x1").contains("Recover: Salvage Data Cache"), "salvage upgrade presenter should preserve cache evidence copy")
	runner._expect(UpgradeCopyPresenterScript.format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.") == "Banked 3 resource(s).\nNo upgrade ready yet.", "upgrade feedback presenter should compact deposit copy")
	runner._expect(UpgradeCopyPresenterScript.format_ready_upgrade_callout(["Oxygen Tank I"]) == "Ready upgrade: Oxygen Tank I.", "ready upgrade presenter should keep ready callout copy")
