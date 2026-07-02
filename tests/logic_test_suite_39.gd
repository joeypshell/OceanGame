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

func _test_lower_connector_reset_and_bounds_coverage(runner) -> void:
	var player_bounds := PlayerScript.new()
	var clamped_lower_connector := player_bounds.clamp_position_to_world_bounds(Vector2(2124.0, 2450.0))
	runner._expect(is_equal_approx(clamped_lower_connector.x, 2124.0), "lower connector bounds should keep the staged route horizontally playable")
	runner._expect(is_equal_approx(clamped_lower_connector.y, 2450.0), "lower connector bounds should keep the Silt Vein Fork approach playable")
	runner._expect(player_bounds.world_bounds.end.y <= 3450.0, "expanded bounds should include Area 02 without becoming an open-world canvas")
	player_bounds.free()

	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = Vector2(2124.0, 2024.0)
	var lower_connector_direction: String = main.call("_format_base_direction")
	runner._expect(lower_connector_direction.contains("up-left"), "base direction should point up-left from the Shelf Drop Connector")

	var glass_kelp_ledge := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge") as Node2D
	var low_visibility_cue := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue") as Node2D
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.run_predator_contacts = 1
	main.player_in_base = false
	scene_player.global_position = glass_kelp_ledge.global_position
	main.call("_update_depth")
	main.call("_update_hud")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Glass Kelp Ledge should not add a hidden oxygen tax")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Glass Kelp Ledge should not mutate cargo")
	runner._expect(main.run_predator_contacts == 1, "Glass Kelp Ledge should not mutate predator pressure")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Glass Kelp Ledge should not change the dive result")
	runner._expect(main.dive_session.has_left_base, "Glass Kelp Ledge should not reset extraction eligibility")
	runner._expect(not main.player_in_base, "Glass Kelp Ledge should not move the player into the base")

	scene_player.global_position = low_visibility_cue.global_position
	main.call("_update_depth")
	main.call("_update_hud")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 18.0), "Dusk Trench low-visibility cue should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Dusk Trench low-visibility cue should not alter cargo")
	runner._expect(main.run_predator_contacts == 1, "Dusk Trench low-visibility cue should not mutate predator state")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Dusk Trench low-visibility cue should not damage or end the dive")
	runner._expect(main.dive_session.has_left_base, "Dusk Trench low-visibility cue should not reset extraction eligibility")
	runner._expect(not main.player_in_base, "Dusk Trench low-visibility cue should not move the player into the base")

	main.player_near_lower_connector_echo = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.run_lower_connector_echo_recovered = true
	main.run_resonance_alcove_research_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.blue_chimney_draft_timer = 1.7
	main.blackwater_pressure_timer = 1.9
	main.visual_smoke_route_stage = "lower_connector"
	main.call("_reset_run_telemetry")
	runner._expect(not main.run_lower_connector_echo_recovered, "run telemetry reset should clear Drop Echo research state")
	runner._expect(not main.run_resonance_alcove_research_recovered, "run telemetry reset should clear Resonance Alcove research state")
	runner._expect(not main.run_blue_chimney_draft_reading_recovered, "run telemetry reset should clear Blue Chimney draft research state")
	runner._expect(not main.run_lantern_silt_sample_recovered, "run telemetry reset should clear Lantern Silt sample state")
	runner._expect(not main.run_blackwater_trace_recovered, "run telemetry reset should clear Blackwater Trace state")
	runner._expect(not main.run_reached_dusk_trench, "run telemetry reset should clear Dusk Trench reach memory")
	runner._expect(not main.run_glass_kelp_reading_recovered, "run telemetry reset should clear Glass Kelp reading state")
	runner._expect(not main.run_tideglass_sample_recovered, "run telemetry reset should clear Tideglass Sample state")
	runner._expect(not main.run_outer_shelf_survey_recovered, "run telemetry reset should clear Outer Shelf survey state")
	runner._expect(not main.run_rim_glass_reading_recovered, "run telemetry reset should clear Glass Rim reading state")
	runner._expect(not main.run_salvage_manifest_recovered, "run telemetry reset should clear Salvage Manifest state")
	runner._expect(is_equal_approx(main.blue_chimney_draft_timer, 0.0), "run telemetry reset should clear Blue Chimney visual timing state")
	runner._expect(is_equal_approx(main.blackwater_pressure_timer, 0.0), "run telemetry reset should clear Blackwater pressure-cue timing state")
	runner._expect(main.visual_smoke_route_stage == "", "run telemetry reset should clear lower-connector visual route stage")

	main.player_near_lower_connector_echo = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_blackwater_crack = true
	main.player_near_tideglass_sample = true
	main.player_near_outer_shelf_survey = true
	main.player_near_rim_glass_reading = true
	main.player_near_salvage_manifest = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.call("_prepare_next_run")
	runner._expect(not main.player_near_lower_connector_echo, "new expeditions should clear Drop Echo proximity state")
	runner._expect(not main.player_near_resonance_alcove, "new expeditions should clear Resonance Alcove proximity state")
	runner._expect(not main.player_near_blue_chimney, "new expeditions should clear Blue Chimney proximity state")
	runner._expect(not main.player_near_lantern_silt_nook, "new expeditions should clear Lantern Silt proximity state")
	runner._expect(not main.player_near_blackwater_crack, "new expeditions should clear Blackwater Crack proximity state")
	runner._expect(not main.player_near_tideglass_sample, "new expeditions should clear Tideglass Sample proximity state")
	runner._expect(not main.player_near_outer_shelf_survey, "new expeditions should clear Outer Shelf proximity state")
	runner._expect(not main.player_near_rim_glass_reading, "new expeditions should clear Glass Rim reading proximity state")
	runner._expect(not main.player_near_salvage_manifest, "new expeditions should clear Salvage Manifest proximity state")
	runner._expect(not main.run_lower_connector_echo_recovered, "new expeditions should not carry Drop Echo research state")
	runner._expect(not main.run_resonance_alcove_research_recovered, "new expeditions should not carry Resonance Alcove research state")
	runner._expect(not main.run_blue_chimney_draft_reading_recovered, "new expeditions should not carry Blue Chimney draft research state")
	runner._expect(not main.run_lantern_silt_sample_recovered, "new expeditions should not carry Lantern Silt sample state")
	runner._expect(not main.run_blackwater_trace_recovered, "new expeditions should not carry Blackwater Trace state")
	runner._expect(not main.run_reached_dusk_trench, "new expeditions should not carry Dusk Trench reach memory")
	runner._expect(not main.run_glass_kelp_reading_recovered, "new expeditions should not carry Glass Kelp reading state")
	runner._expect(not main.run_tideglass_sample_recovered, "new expeditions should not carry Tideglass Sample state")
	runner._expect(not main.run_outer_shelf_survey_recovered, "new expeditions should not carry Outer Shelf survey state")
	runner._expect(not main.run_rim_glass_reading_recovered, "new expeditions should not carry Glass Rim reading state")
	runner._expect(not main.run_salvage_manifest_recovered, "new expeditions should not carry Salvage Manifest state")
	runner._expect(not main.progression_state.to_save_data().has("lower_connector_echo"), "Drop Echo should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("resonance_alcove_research"), "Resonance Alcove research should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("blue_chimney"), "Blue Chimney should not create durable route state")
	runner._expect(not main.progression_state.to_save_data().has("blue_chimney_signal"), "Blue Chimney signal should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("blue_chimney_draft"), "Blue Chimney draft should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("silt_vein"), "Silt Vein should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("silt_vein_fork"), "Silt Vein Fork should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("lantern_silt"), "Lantern Silt should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("lantern_silt_sample"), "Lantern Silt sample should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("blackwater_crack"), "Blackwater Crack should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("blackwater_trace"), "Blackwater Trace should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("dusk_trench_reached"), "Dusk Trench reach memory should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("glass_kelp_reading"), "Glass Kelp reading should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("tideglass_sample"), "Tideglass Sample should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("outer_shelf_survey"), "Outer Shelf survey should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("rim_glass_reading"), "Glass Rim reading should not be stored in durable progression")
	runner._expect(not main.progression_state.to_save_data().has("salvage_manifest"), "Salvage Manifest should not be stored in durable progression")
	main.queue_free()

func _test_east_shelf_pocket_prompt_interaction(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.player_in_base = false
	main.player_near_east_shelf_pocket = true
	var signal_core_gem := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreGem") as Polygon2D
	var signal_core_spark := main.get_node("EastShelfSpur/PocketEntrance/SignalCore/CoreSpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_east_shelf_pocket_payoff(main)
	runner._expect(signal_core_gem.color.a >= 0.8 and signal_core_spark.visible, "East Shelf signal core should start as an obvious visible payoff")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("East Shelf Pocket"), "East Shelf pocket proximity should own the active dive prompt")
	runner._expect(prompt.contains("recover signal core"), "East Shelf pocket prompt should name the visible payoff")

	var handled: bool = main.call("_try_east_shelf_pocket_interaction")
	runner._expect(handled, "East Shelf pocket should handle interact while the player is nearby during a dive")
	runner._expect(main.run_east_shelf_pocket_ping_recovered, "East Shelf pocket interaction should record one run-scoped research ping")
	runner._expect(signal_core_gem.color.a <= 0.2 and not signal_core_spark.visible, "East Shelf signal core should visibly dim after recovery")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("signal core recovered"), "East Shelf pocket interaction should acknowledge the visible payoff")

	var repeat_handled: bool = main.call("_try_east_shelf_pocket_interaction")
	runner._expect(repeat_handled, "East Shelf pocket should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recorded"), "East Shelf pocket repeat interaction should not duplicate the payoff")

	main.player_near_east_shelf_pocket = false
	var not_handled: bool = main.call("_try_east_shelf_pocket_interaction")
	runner._expect(not not_handled, "East Shelf pocket should not consume interact outside its proximity zone")

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_east_shelf_pocket_ping_recovered, "East Shelf pocket research ping should reset between expeditions")
	runner._expect(signal_core_gem.color.a >= 0.8 and signal_core_spark.visible, "East Shelf signal core should be visible again after expedition reset")
	main.queue_free()

func _test_east_shelf_current_surge_visual_timing(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.east_shelf_current_surge_alpha(0.0, MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.east_shelf_current_surge_alpha(MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS * 0.25, MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS)
	var return_alpha: float = RouteTimingCuePresenterScript.east_shelf_current_surge_alpha(MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS * 0.5, MainScript.EAST_SHELF_SURGE_PERIOD_SECONDS)

	runner._expect(high_alpha > low_alpha, "East Shelf current-surge alpha should pulse upward to suggest timing")
	runner._expect(is_equal_approx(low_alpha, return_alpha), "East Shelf current-surge pulse should repeat smoothly")
	runner._expect(low_alpha >= 0.08 and high_alpha <= 0.18, "East Shelf current-surge pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true

	RouteTimingCueServiceScript.update_east_shelf_current_surge(main, 0.7)
	runner._expect(is_equal_approx(main.dive_session.oxygen, 24.0), "East Shelf current surge should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "East Shelf current surge should not change carried cargo")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "East Shelf current surge should not change dive result")
	runner._expect(main.dive_session.has_left_base, "East Shelf current surge should not reset extraction eligibility")
	runner._expect(not main.player_in_base, "East Shelf current surge should not move the player into the base")
	runner._expect(main.run_predator_contacts == 1, "East Shelf current surge should not create predator contacts")
	runner._expect(main.progression_state.has_upgrade(PressureSealUpgrade.id), "East Shelf current surge should not mutate pressure upgrade state")
	main.free()

func _test_blue_chimney_reverse_draft_visual_timing(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.blue_chimney_reverse_draft_alpha(0.0, MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.blue_chimney_reverse_draft_alpha(MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS * 0.25, MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)
	var return_alpha: float = RouteTimingCuePresenterScript.blue_chimney_reverse_draft_alpha(MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS * 0.5, MainScript.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)

	runner._expect(high_alpha > low_alpha, "Blue Chimney reverse draft alpha should pulse upward to suggest timing")
	runner._expect(is_equal_approx(low_alpha, return_alpha), "Blue Chimney reverse draft pulse should repeat smoothly")
	runner._expect(low_alpha >= 0.07 and high_alpha <= 0.14, "Blue Chimney reverse draft pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 22.0
	main.dive_session.current_cargo = ["shell_fragments"]
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true

	RouteTimingCueServiceScript.update_blue_chimney_reverse_draft(main, 0.7)
	runner._expect(is_equal_approx(main.dive_session.oxygen, 22.0), "Blue Chimney reverse draft should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == ["shell_fragments"], "Blue Chimney reverse draft should not change carried cargo")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Blue Chimney reverse draft should not change dive result")
	runner._expect(main.dive_session.has_left_base, "Blue Chimney reverse draft should not reset extraction eligibility")
	runner._expect(not main.player_in_base, "Blue Chimney reverse draft should not move the player into the base")
	runner._expect(main.run_predator_contacts == 1, "Blue Chimney reverse draft should not create predator contacts")
	runner._expect(main.progression_state.resource_count("glow_plankton") == 2, "Blue Chimney reverse draft should not mutate banked resources")
	runner._expect(main.progression_state.has_upgrade(PressureSealUpgrade.id), "Blue Chimney reverse draft should not mutate pressure upgrade state")
	main.free()

func _test_blackwater_pressure_cue_visual_timing(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.blackwater_pressure_cue_alpha(0.0, MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.blackwater_pressure_cue_alpha(MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25, MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS)
	var return_alpha: float = RouteTimingCuePresenterScript.blackwater_pressure_cue_alpha(MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.5, MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS)

	runner._expect(high_alpha > low_alpha, "Blackwater pressure cue alpha should pulse upward to suggest timing")
	runner._expect(is_equal_approx(low_alpha, return_alpha), "Blackwater pressure cue pulse should repeat smoothly")
	runner._expect(low_alpha >= 0.1 and high_alpha <= 0.2, "Blackwater pressure cue pulse should stay subtle and non-combat")
	main.free()

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	scene_main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	scene_main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	scene_main.progression_state.banked_resources["glow_plankton"] = 2
	scene_main.dive_session.reset(30.0)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 21.0
	scene_main.dive_session.current_cargo = ["shell_fragments"]
	scene_main.dive_session.has_left_base = true
	scene_main.player_in_base = false
	scene_main.run_predator_contacts = 1
	scene_main.call("_sync_blackwater_crack_gate_state")
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D
	var pressure_rib_a := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue") as Polygon2D

	RouteTimingCueServiceScript.update_blackwater_pressure_cue(scene_main, MainScript.BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)
	runner._expect(pressure_shutter.color.b > pressure_shutter.color.g, "Blackwater pressure cue should remain violet-blue after pulsing")
	runner._expect(pressure_rib_a.color.b > pressure_rib_a.color.g, "Blackwater pressure rib should remain distinct from safe current green")
	runner._expect(return_current.color.g > pressure_shutter.color.g, "Blackwater return current should stay visually distinct from pressure cue")
	runner._expect(is_equal_approx(scene_main.dive_session.oxygen, 21.0), "Blackwater pressure cue should not drain oxygen")
	runner._expect(scene_main.dive_session.current_cargo == ["shell_fragments"], "Blackwater pressure cue should not change carried cargo")
	runner._expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Blackwater pressure cue should not change dive result")
	runner._expect(scene_main.dive_session.has_left_base, "Blackwater pressure cue should not reset extraction eligibility")
	runner._expect(not scene_main.player_in_base, "Blackwater pressure cue should not move the player into the base")
	runner._expect(scene_main.run_predator_contacts == 1, "Blackwater pressure cue should not create predator contacts")
	runner._expect(scene_main.progression_state.resource_count("glow_plankton") == 2, "Blackwater pressure cue should not mutate banked resources")
	runner._expect(scene_main.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Blackwater pressure cue should not mutate Resonance Key ownership")
	runner._expect(scene_main.progression_state.has_upgrade(PressureSealUpgrade.id), "Blackwater pressure cue should not mutate Pressure Seal ownership")
	scene_main.queue_free()
