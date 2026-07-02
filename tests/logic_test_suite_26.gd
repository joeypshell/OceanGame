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

func _test_resonance_alcove_research_payoff(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_resonance_alcove = true
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Resonance Alcove"), "Resonance Alcove proximity should own the active dive prompt")
	runner._expect(prompt.contains("record hatch echo"), "Resonance Alcove prompt should explain the narrow research payoff")

	var locked_handled: bool = main.call("_try_resonance_alcove_interaction")
	runner._expect(locked_handled, "Resonance Alcove should handle interaction before key ownership")
	runner._expect(not main.run_resonance_alcove_research_recovered, "locked Resonance Alcove should not record research")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("behind the sealed hatch"), "locked Resonance Alcove should explain the hatch gate")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()
	var handled: bool = main.call("_try_resonance_alcove_interaction")
	runner._expect(handled, "Resonance Alcove should handle interact while nearby during a dive")
	runner._expect(main.run_resonance_alcove_research_recovered, "Resonance Alcove interaction should record one run-scoped research note")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Resonance Alcove research should not add cargo")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Resonance Alcove payoff should preserve extraction pressure")

	var repeat_handled: bool = main.call("_try_resonance_alcove_interaction")
	runner._expect(repeat_handled, "Resonance Alcove should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "Resonance Alcove repeat interaction should not duplicate the payoff")

	main.player_near_resonance_alcove = false
	var not_handled: bool = main.call("_try_resonance_alcove_interaction")
	runner._expect(not not_handled, "Resonance Alcove should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("resonance_alcove"), "Resonance Alcove note should not become durable save data")
	runner._expect(not saved.has("resonance_alcove_research"), "Resonance Alcove research should not create durable route state")

	var callout: String = ResearchResultCalloutServiceScript.format_resonance_alcove_research_callout(main)
	runner._expect(callout.contains("Resonance Alcove"), "Resonance Alcove result memory should name the small pocket")
	runner._expect(callout.contains("small tuned pocket"), "Resonance Alcove result memory should stay broad and local")
	runner._expect_no_echo_lens_locator_language(callout, "Resonance Alcove result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Resonance Alcove"), "Resonance Alcove extraction summary should include recovered research memory")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_resonance_alcove_research_callout(fresh_main) == "", "Resonance Alcove result line should stay hidden before payoff recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Resonance Alcove"), "Resonance Alcove extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()

func _test_blue_chimney_draft_interaction(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blue_chimney = true
	main.dive_session.oxygen = 26.0
	main.dive_session.current_cargo = ["shell_fragments"]
	var survey_gem := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem") as Polygon2D
	var survey_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_blue_chimney_payoff(main)
	runner._expect(survey_gem.color.a >= 0.7, "Blue Chimney survey core should start visibly recoverable")
	runner._expect(survey_spark.visible, "Blue Chimney survey spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Blue Chimney"), "Blue Chimney proximity should own the active dive prompt")
	runner._expect(prompt.contains("recover survey core"), "Blue Chimney prompt should explain the concrete lower-route payoff")

	var handled: bool = main.call("_try_blue_chimney_interaction")
	runner._expect(handled, "Blue Chimney should handle interact while nearby during a dive")
	runner._expect(main.run_blue_chimney_draft_reading_recovered, "Blue Chimney interaction should record one run-scoped survey core")
	runner._expect(survey_gem.color.a <= 0.2, "Blue Chimney survey core should visibly dim after recovery")
	runner._expect(not survey_spark.visible, "Blue Chimney survey spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 26.0), "Blue Chimney survey core should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Blue Chimney survey core should not add or remove cargo")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Blue Chimney interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("survey core"), "Blue Chimney status should name the visible payoff")

	var repeat_handled: bool = main.call("_try_blue_chimney_interaction")
	runner._expect(repeat_handled, "Blue Chimney should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recovered"), "Blue Chimney repeat interaction should not duplicate the payoff")

	main.player_near_blue_chimney = false
	var not_handled: bool = main.call("_try_blue_chimney_interaction")
	runner._expect(not not_handled, "Blue Chimney should not consume interact outside its proximity zone")

	var callout: String = ResearchResultCalloutServiceScript.format_blue_chimney_research_callout(main)
	runner._expect(callout.contains("Blue Chimney"), "Blue Chimney result memory should name the lower pocket")
	runner._expect(callout.contains("survey core"), "Blue Chimney result memory should name the concrete payoff")
	runner._expect(callout.contains("Shelf Drop"), "Blue Chimney result memory should keep broad route context")
	runner._expect(callout.contains("deeper side-route"), "Blue Chimney result memory should hint at future route growth")
	runner._expect_no_echo_lens_locator_language(callout, "Blue Chimney result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Blue Chimney survey core"), "Blue Chimney extraction summary should include recovered survey core memory")
	runner._expect(not extraction_summary.contains("%s"), "Blue Chimney extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_blue_chimney_research_callout(fresh_main) == "", "Blue Chimney result line should stay hidden before draft recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Blue Chimney survey core"), "Blue Chimney extraction summary should stay hidden before survey core recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_blue_chimney_draft_reading_recovered, "Blue Chimney draft reading should reset between expeditions")
	runner._expect(survey_gem.color.a >= 0.7, "Blue Chimney survey core should become visible again on expedition reset")
	runner._expect(survey_spark.visible, "Blue Chimney survey spark should reset between expeditions")
	main.free()

func _test_lantern_silt_sample_interaction(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_lantern_silt_nook = true
	main.dive_session.oxygen = 24.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.banked_resources = {"glow_plankton": 2}
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Lantern Silt Nook"), "Lantern Silt Nook proximity should own the active dive prompt")
	runner._expect(prompt.contains("collect silt sample"), "Lantern Silt prompt should explain the narrow research action")

	var handled: bool = main.call("_try_lantern_silt_nook_interaction")
	runner._expect(handled, "Lantern Silt Nook should handle interact while nearby during a dive")
	runner._expect(main.run_lantern_silt_sample_recovered, "Lantern Silt interaction should record one run-scoped sample")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 24.0), "Lantern Silt sample should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Lantern Silt sample should not add or remove cargo")
	runner._expect(main.progression_state.resource_count("glow_plankton") == 2, "Lantern Silt sample should not mutate banked resources")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "Lantern Silt interaction should preserve extraction pressure")

	var repeat_handled: bool = main.call("_try_lantern_silt_nook_interaction")
	runner._expect(repeat_handled, "Lantern Silt Nook should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already stored"), "Lantern Silt repeat interaction should not duplicate the payoff")

	main.player_near_lantern_silt_nook = false
	var not_handled: bool = main.call("_try_lantern_silt_nook_interaction")
	runner._expect(not not_handled, "Lantern Silt Nook should not consume interact outside its proximity zone")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("lantern_silt_sample"), "Lantern Silt sample should not become durable save data")
	runner._expect(not saved.has("lantern_silt"), "Lantern Silt sample should not create durable route state")
	runner._expect(not saved.has("silt_vein_fork"), "Silt Vein Fork should not create durable route state")

	var callout: String = ResearchResultCalloutServiceScript.format_lantern_silt_sample_research_callout(main)
	runner._expect(callout.contains("Lantern Silt Sample"), "Lantern Silt result memory should name the sample")
	runner._expect(callout.contains("left branch"), "Lantern Silt result memory should explain the broad route choice")
	runner._expect(callout.contains("Silt Vein"), "Lantern Silt result memory should keep broad fork context")
	runner._expect_no_echo_lens_locator_language(callout, "Lantern Silt result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Lantern Silt Sample"), "Lantern Silt extraction summary should include recovered sample memory")
	runner._expect(not extraction_summary.contains("%s"), "Lantern Silt extraction summary should not leak string placeholders")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_lantern_silt_sample_research_callout(fresh_main) == "", "Lantern Silt result line should stay hidden before sample recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Lantern Silt Sample"), "Lantern Silt extraction summary should stay hidden before sample recovery")
	fresh_main.free()

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_lantern_silt_sample_recovered, "Lantern Silt sample should reset between expeditions")
	main.free()

func _test_blackwater_gate_presenter(runner) -> void:
	runner._expect(
		BlackwaterGatePresenterScript.format_gate_status(false, false).contains("Echo Lens study"),
		"sealed Blackwater status should explain missing scanner preparation"
	)
	runner._expect(
		BlackwaterGatePresenterScript.format_gate_status(false, true).contains("Resonance Key I preparation needed"),
		"sealed Blackwater status should preserve key preparation copy after Echo Lens"
	)
	runner._expect(
		BlackwaterGatePresenterScript.format_gate_status(true, true) == "Blackwater: trace sill. Return Silt/Blue/Drop.",
		"open Blackwater status should keep compact return-route copy"
	)
	runner._expect(
		BlackwaterGatePresenterScript.format_prompt(false, false, "E/Enter").contains("read Resonance seal"),
		"sealed Blackwater prompt should explain the gate readback"
	)
	runner._expect(
		BlackwaterGatePresenterScript.format_prompt(true, false, "E/Enter").contains("E/Enter record trace"),
		"open Blackwater prompt should expose the trace interaction"
	)
	runner._expect(
		BlackwaterGatePresenterScript.format_prompt(true, true, "E/Enter").contains("trace recorded"),
		"recorded Blackwater prompt should preserve return guidance"
	)

func _test_blackwater_crack_gate_state(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_blackwater_crack = true
	main.dive_session.oxygen = 19.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.progression_state.banked_resources = {"glow_plankton": 2, "shell_fragments": 1}
	var gate_label := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel") as Label
	var gate_badge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge") as Polygon2D
	var closed_shard := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard") as Polygon2D
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var dusk_trench := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D

	main.call("_sync_blackwater_crack_gate_state")
	runner._expect(gate_label.text == "RESONANCE SEAL", "Blackwater Crack should start as a deliberate resonance-sealed route gate")
	runner._expect(not blackwater_sill.visible, "Blackwater Sill should be hidden before route preparation is ready")
	runner._expect(dusk_trench.visible, "Dusk Trench should rely on Blackwater Sill parent visibility rather than a separate gate flag")
	var sealed_status := BlackwaterGatePresenterScript.format_gate_status(
		main.progression_state.has_upgrade(main.RESONANCE_KEY_UPGRADE_ID),
		main.progression_state.has_upgrade(main.ECHO_LENS_UPGRADE_ID)
	)
	runner._expect(sealed_status.contains("Echo Lens"), "Blackwater sealed status should name existing scanner preparation")
	runner._expect(sealed_status.contains("Resonance Key I"), "Blackwater sealed status should name existing key preparation")
	runner._expect_no_echo_lens_locator_language(sealed_status, "Blackwater sealed status")

	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Blackwater Crack"), "Blackwater proximity should own the active dive prompt")
	runner._expect(prompt.contains("read Resonance seal"), "Blackwater prompt should explain the narrow gate readback")
	var handled: bool = main.call("_try_blackwater_crack_interaction")
	runner._expect(handled, "Blackwater Crack should handle interact while nearby during a dive")
	runner._expect(main.status_label.text.contains("Resonance Key I"), "Blackwater interaction should explain broad preparation")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 19.0), "Blackwater gate readback should not spend oxygen")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Blackwater gate readback should not change cargo")
	runner._expect(main.progression_state.resource_count("glow_plankton") == 2, "Blackwater gate readback should not mutate banked resources")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.call("_sync_blackwater_crack_gate_state")
	runner._expect(gate_label.text == "KEY NEEDED", "Blackwater gate should ask for Resonance Key I after Echo Lens I is owned")
	var key_needed_status: String = main.call("_format_blackwater_gate_status")
	runner._expect(key_needed_status.contains("Resonance Key I"), "Blackwater key-needed status should stay tied to existing preparation")
	runner._expect(not key_needed_status.contains("Echo Lens and"), "Blackwater key-needed status should stop asking for Echo Lens after ownership")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	main.call("_sync_blackwater_crack_gate_state")
	runner._expect(gate_label.text == "KEY READY", "Blackwater gate should show ready after Resonance Key I ownership")
	runner._expect(gate_badge.color.g >= gate_badge.color.r, "Blackwater ready badge should visually differ from the sealed dark route")
	runner._expect(closed_shard.color.a <= 0.14, "Blackwater ready state should soften the closed shard without opening an interior yet")
	runner._expect(blackwater_sill.visible, "Blackwater Sill should become visible after Resonance Key I ownership")
	var ready_status: String = main.call("_format_blackwater_gate_status")
	runner._expect(ready_status.contains("trace sill"), "Blackwater ready status should name the short route sequence")
	runner._expect(ready_status.contains("Silt/Blue/Drop"), "Blackwater ready status should compactly name the broad return chain")
	runner._expect(ready_status.length() <= 52, "Blackwater ready status should fit the active HUD panel")
	runner._expect_no_echo_lens_locator_language(ready_status, "Blackwater ready status")
	var ready_prompt: String = main.call("_format_hud_prompt")
	runner._expect(ready_prompt.contains("record trace"), "Blackwater ready prompt should shift from gate readback to the route payoff")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("blackwater_crack"), "Blackwater gate should not add durable route state")
	runner._expect(not saved.has("blackwater_sill"), "Blackwater gate should not add durable sill state")
	runner._expect(not saved.has("blackwater_route_open"), "Blackwater gate should derive readiness from existing upgrade ownership")
	main.player_near_blackwater_crack = false
	var not_handled: bool = main.call("_try_blackwater_crack_interaction")
	runner._expect(not not_handled, "Blackwater Crack should not consume interact outside its proximity zone")
	main.free()
