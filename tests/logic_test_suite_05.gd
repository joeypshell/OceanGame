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

func _test_lantern_ray_route_variation(runner) -> void:
	var main := MainScene.instantiate()
	var candidates := main.get_node("CreatureRouteCandidates") as Node2D
	var lantern_ray := main.get_node("Creatures/LanternRayRoute") as Area2D
	main.creature_route_candidates = candidates
	main.lantern_ray_route = lantern_ray
	var source_map: Dictionary = runner._load_area01_source_map_for_tests()
	var source_grid_water_polygons := _source_grid_water_polygons(source_map, runner)

	for pattern in ["cautious", "deep_reward"]:
		var routes: Dictionary = SpawnSelectionScript.routes_for_target(candidates, SpawnPointScript, "creature", "lantern_ray", pattern)
		runner._expect(not routes.is_empty(), "Lantern Ray should have authored route candidates for %s runs" % pattern)
		for route_value in routes.values():
			var route: Dictionary = route_value
			var start: Vector2 = route["start"]
			var end: Vector2 = route["end"]
			runner._expect(_point_inside_any_polygon(start, source_grid_water_polygons), "Lantern Ray authored route start should sit inside source-grid playable water")
			runner._expect(_point_inside_any_polygon(end, source_grid_water_polygons), "Lantern Ray authored route end should sit inside source-grid playable water")
			runner._expect(end.x > start.x, "Lantern Ray authored route should read as a lateral glide through the generated route pocket")
			runner._expect(absf(end.y - start.y) <= 128.0, "Lantern Ray authored route should stay in one readable generated-water lane")

	main.current_resource_cluster_pattern = "cautious"
	main.current_expedition_condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
	}
	var low_visibility_routes: Dictionary = RouteSetupServiceScript.spawn_routes_for_target(main, "creature", "lantern_ray", "cautious")
	runner._expect(low_visibility_routes.size() == 1 and low_visibility_routes.has("lantern_ray_low_visibility_glide"), "Low Visibility should prefer the authored Lantern Ray high-safe route")
	var low_route: Dictionary = low_visibility_routes["lantern_ray_low_visibility_glide"]
	var low_rng := RandomNumberGenerator.new()
	low_rng.seed = 550
	RouteSetupServiceScript.place_lantern_ray_route_for_run(main, low_rng)
	runner._expect(main.current_lantern_ray_route_id == "lantern_ray_low_visibility_glide", "Lantern Ray route placement should use the condition-preferred route")
	runner._expect(lantern_ray.global_position == low_route["start"], "Lantern Ray should start at the selected authored route start")
	runner._expect(lantern_ray.get("move_start") == low_route["start"], "Lantern Ray move_start should follow the selected route")
	runner._expect(lantern_ray.get("move_end") == low_route["end"], "Lantern Ray move_end should follow the selected route")

	main.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
	}
	var first_rng := RandomNumberGenerator.new()
	first_rng.seed = 2026
	RouteSetupServiceScript.place_lantern_ray_route_for_run(main, first_rng)
	var first_route_id: String = main.current_lantern_ray_route_id
	var first_start: Vector2 = lantern_ray.global_position
	var second_rng := RandomNumberGenerator.new()
	second_rng.seed = 2026
	RouteSetupServiceScript.place_lantern_ray_route_for_run(main, second_rng)
	runner._expect(main.current_lantern_ray_route_id == first_route_id, "same seed and condition should select the same Lantern Ray route")
	runner._expect(lantern_ray.global_position == first_start, "same seed and condition should place the Lantern Ray at the same start")

	var telemetry: String = SurfaceRunSummaryServiceScript.format_run_telemetry(main, "Extracted")
	runner._expect(telemetry.contains("Lantern Ray route:"), "debug run telemetry should expose the runtime Lantern Ray route id")
	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved.has("current_lantern_ray_route_id"), "Lantern Ray route variation should not save active-run route state")
	runner._expect(not saved.has("lantern_ray_route"), "Lantern Ray route variation should not add durable route state")
	main.queue_free()

func _test_debug_review_helpers(runner) -> void:
	var main := MainScript.new()
	var next_condition := main._debug_next_condition_from_id("calm_current")
	runner._expect(next_condition.get("id", "") == "kelp_bloom", "debug condition helper should cycle from the current condition")

	var first_condition := main._debug_next_condition_from_id("unknown_condition")
	runner._expect(first_condition.get("id", "") == "calm_current", "debug condition helper should fall back to the first condition")
	runner._expect(main._debug_seed_for_delta(8919, 1) == 8920, "debug seed helper should increment review seed")
	runner._expect(main._debug_seed_for_delta(1, -10) == 1, "debug seed helper should keep review seed positive")
	LowerConnectorVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.visual_smoke_route_stage == "", "Lower Connector visual staging service should stay inert outside web visual smoke")
	BlueChimneyVisualStagingServiceScript.stage_pocket_visual_review(main)
	runner._expect(main.visual_smoke_route_stage == "", "Blue Chimney visual staging service should stay inert outside web visual smoke")
	BlackwaterVisualStagingServiceScript.stage_route_visual_review(main)
	runner._expect(main.visual_smoke_route_stage == "", "Blackwater visual staging service should stay inert outside web visual smoke")
	DuskTrenchVisualStagingServiceScript.stage_route_visual_review(main)
	runner._expect(main.visual_smoke_route_stage == "", "Dusk Trench visual staging service should stay inert outside web visual smoke")
	HollowReefVisualStagingServiceScript.stage_route_visual_review(main)
	runner._expect(main.visual_smoke_route_stage == "", "Hollow Reef visual staging service should stay inert outside web visual smoke")
	var area01_stages := [
		"surface_entry",
		"left_shelf_cave",
		"right_shelf_pocket",
		"central_drop",
		"west_chamber",
		"right_chamber",
		"deep_spine",
		"future_exit",
	]
	for stage in area01_stages:
		var status := Area01VisualStagingServiceScript.player_status_for_stage(stage)
		var lower_status := status.to_lower()
		runner._expect(not lower_status.contains("debug"), "Area 01 staged status should not expose debug copy: %s" % stage)
		runner._expect(not lower_status.contains("review"), "Area 01 staged status should not expose review copy: %s" % stage)
		runner._expect(not lower_status.contains("staged"), "Area 01 staged status should not expose capture harness copy: %s" % stage)
	main.free()

func _test_debug_wreck_echo_visual_staging(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)

	main.show_debug_telemetry = false
	WideReefVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef Chamber web staging should be inaccessible outside the web debug bridge")
	runner._expect(main.visual_smoke_route_stage == "", "Wide Reef Chamber web staging should not set route state outside web visual smoke")

	WreckEchoVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wreck Echo visual staging should be ignored while debug telemetry is hidden")

	main.show_debug_telemetry = true
	WreckEchoVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Wreck Echo visual staging should start or keep a dive active")
	runner._expect(main.debug_wreck_echo_review_staged, "Wreck Echo visual staging should remember the active route view state")
	runner._expect(main._wreck_echo_route_available(), "Wreck Echo visual staging should prepare the route prerequisites")
	runner._expect(not main.run_wreck_echo_clue_recovered, "first Wreck Echo visual staging press should not auto-complete the clue")

	WreckEchoVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "second Wreck Echo visual staging press should produce the result view")
	runner._expect(main.last_result_summary.contains("Wreck Echo clue carried"), "staged Wreck Echo result should include the compact clue readback")
	main.queue_free()

func _test_debug_wide_reef_salvage_staging_guardrails(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	WideReefVisualStagingServiceScript.stage_visual_review(main, true)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef salvage staging should be inaccessible outside web/debug review")
	runner._expect(main.visual_smoke_route_stage == "", "hidden Wide Reef salvage staging should not set visual route state")
	runner._expect(main.progression_state.to_save_data() == save_before, "hidden Wide Reef salvage staging should not mutate durable progression")

	main.show_debug_telemetry = true
	WideReefVisualStagingServiceScript.stage_visual_review(main, true)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Wide Reef salvage staging should remain web-only even when debug telemetry is visible headlessly")
	runner._expect(main.visual_smoke_route_stage == "", "headless Wide Reef salvage staging should not set visual route state")
	runner._expect(main.progression_state.to_save_data() == save_before, "headless Wide Reef salvage staging should not mutate durable progression")

	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	main.call("_sync_salvage_pocket_open_state")
	var opened_lane := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D
	var lock_bars := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/LockBars") as Polygon2D
	var manifest_core := opened_lane.get_node("SalvageManifest/ManifestCore") as Polygon2D
	runner._expect(opened_lane.visible, "owned Salvage Cutter I should reveal the opened pocket lane")
	runner._expect(not lock_bars.visible, "owned Salvage Cutter I should remove sealed lock bars")
	runner._expect(manifest_core.color.a >= 0.7, "owned Salvage Cutter I should leave the manifest visibly recoverable")
	runner._expect(not main.run_salvage_manifest_recovered, "opened pocket should not auto-complete the manifest payoff")
	runner._expect(not main.run_salvage_data_cache_recovered, "opened pocket should not auto-complete the earlier cache payoff")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) != "Salvage Pocket", "opened pocket alone should not claim Salvage Pocket route memory")
	var staged_save: Dictionary = main.progression_state.to_save_data()
	runner._expect(not staged_save.has("salvage_pocket_route"), "opened pocket should not create durable salvage route state")
	runner._expect(not staged_save.has("salvage_manifest"), "opened pocket should not create durable manifest state")
	runner._expect(not staged_save.has("salvage_inventory"), "opened pocket should not create salvage inventory state")

	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_manifest = true
	var handled: bool = main.call("_try_salvage_manifest_interaction")
	runner._expect(handled, "staged Wide Reef salvage payoff should remain interactable through the normal manifest path")
	runner._expect(main.run_salvage_manifest_recovered, "staged manifest interaction should set only run-scoped payoff evidence")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Salvage Pocket", "manifest payoff should upgrade the current run memory to Salvage Pocket")
	var empty_cargo: Array[String] = []
	var summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(summary.contains("Salvage Manifest"), "staged manifest payoff should support extraction result memory")
	main.progression_state.current_run_number = 42
	main.progression_state.current_run_seed = 9042
	main.call("_record_recent_expedition", "Extracted", 0)
	var log_text: String = main.call("_format_recent_expedition_log")
	runner._expect(log_text.contains("route Salvage Pocket"), "staged manifest payoff should support compact recent-route memory")
	var payoff_save: Dictionary = main.progression_state.to_save_data()
	runner._expect(not payoff_save.has("salvage_pocket_route"), "Salvage Pocket route memory should remain session-only after payoff")
	runner._expect(not payoff_save.has("salvage_inventory"), "Salvage Manifest payoff should not create durable salvage inventory")

	main.call("_reset_run_telemetry")
	runner._expect(not main.run_salvage_manifest_recovered, "Salvage Manifest payoff should reset between expeditions")
	runner._expect(opened_lane.visible, "owned cutter should keep the opened lane visible after run reset")
	runner._expect(manifest_core.color.a >= 0.7, "Salvage Manifest should become recoverable again after run reset")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) != "Salvage Pocket", "run reset should clear active Salvage Pocket route memory")
	main.queue_free()

func _test_debug_mirror_kelp_evidence_staging(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	MirrorKelpVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Mirror Kelp staging should be ignored while debug telemetry is hidden outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "hidden Mirror Kelp staging should not set visual route state")
	runner._expect(main.progression_state.to_save_data() == save_before, "hidden Mirror Kelp staging should not mutate durable progression")

	main.show_debug_telemetry = true
	MirrorKelpVisualStagingServiceScript.stage_visual_review(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Mirror Kelp staging should start or keep a dive active")
	runner._expect(main.visual_smoke_route_stage == "mirror_kelp_pass", "Mirror Kelp route staging should expose a deterministic route stage")
	runner._expect(main.player.global_position.distance_to(mirror_kelp.global_position) < 180.0, "Mirror Kelp staging should place the player near the branch")
	runner._expect(main.dive_session.has_left_base, "Mirror Kelp staging should make extraction eligibility match an active route attempt")
	runner._expect(not main.run_tideglass_sample_recovered, "plain Mirror Kelp staging should not auto-complete the payoff")
	runner._expect(not main.run_completed_scans.has("mirrorfin_drift"), "plain Mirror Kelp staging should not auto-add Mirrorfin evidence")
	runner._expect(main.progression_state.to_save_data() == save_before, "plain Mirror Kelp staging should not mutate durable progression")

	MirrorKelpVisualStagingServiceScript.stage_visual_review(main, true)
	runner._expect(main.visual_smoke_route_stage == "mirror_kelp_tideglass", "Tideglass staging should expose a deterministic payoff stage")
	runner._expect(main.run_tideglass_sample_recovered, "Tideglass staging should set only the run-scoped payoff evidence")
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Mirror Kelp Pass"), "Tideglass staging should support Mirror Kelp result memory")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Mirror Kelp Pass", "Tideglass staging should support recent route memory")
	runner._expect(main.progression_state.to_save_data() == save_before, "Tideglass staging should not mutate durable progression")

	MirrorKelpVisualStagingServiceScript.stage_visual_review(main, false, true)
	runner._expect(main.visual_smoke_route_stage == "mirror_kelp_mirrorfin", "Mirrorfin staging should expose a deterministic observation stage")
	runner._expect(not main.run_tideglass_sample_recovered, "Mirrorfin staging should reset Tideglass payoff state for deterministic captures")
	runner._expect(main.run_completed_scans.has("mirrorfin_drift"), "Mirrorfin staging should set only current-run observation evidence")
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("reflection timing"), "Mirrorfin staging should support observation result memory")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(RunMemoryStateServiceScript.route_memory_state(main)) == "Mirror Kelp Pass", "Mirrorfin staging should support recent route memory")
	runner._expect(main.progression_state.to_save_data() == save_before, "Mirrorfin staging should not mutate durable progression")
	runner._expect(not main.progression_state.to_save_data().has("mirror_kelp_pass_route"), "Mirror Kelp staging should not add durable route state")
	main.queue_free()

func _test_debug_outer_shelf_evidence_staging(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	main.show_debug_telemetry = false
	OuterShelfVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Outer Shelf staging should be ignored while debug telemetry is hidden outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "hidden Outer Shelf staging should not set visual route state")
	runner._expect(main.progression_state.to_save_data() == save_before, "hidden Outer Shelf staging should not mutate durable progression")

	main.show_debug_telemetry = true
	OuterShelfVisualStagingServiceScript.stage_visual_review(main)
	var blackwater_sill := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var survey_zone := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/InteractZone") as Area2D
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Outer Shelf staging should start or keep a dive active")
	runner._expect(main.visual_smoke_route_stage == "outer_shelf_survey", "Outer Shelf staging should expose a deterministic route stage")
	runner._expect(blackwater_sill.visible, "Outer Shelf staging should reveal the hidden route ancestor for visual review only")
	runner._expect(main.player.global_position.distance_to(survey_zone.global_position) < 120.0, "Outer Shelf staging should place the player near the survey payoff")
	runner._expect(main.dive_session.has_left_base, "Outer Shelf staging should make extraction eligibility match an active route attempt")
	runner._expect(main.player_near_outer_shelf_survey, "Outer Shelf staging should expose the survey prompt for readability review")
	runner._expect(not main.run_outer_shelf_survey_recovered, "Outer Shelf staging should not auto-complete the survey payoff")
	runner._expect(not main.run_tideglass_sample_recovered, "Outer Shelf staging should not inherit Mirror Kelp payoff state")
	runner._expect(not main.run_salvage_manifest_recovered, "Outer Shelf staging should not inherit salvage payoff state")
	runner._expect(not main.run_completed_scans.has("mirrorfin_drift"), "Outer Shelf staging should not auto-add Mirrorfin evidence")
	runner._expect(main.progression_state.to_save_data() == save_before, "Outer Shelf staging should not mutate durable progression")
	runner._expect(not main.progression_state.to_save_data().has("outer_shelf_survey"), "Outer Shelf staging should not add durable survey state")
	main.queue_free()

func _test_open_hatch_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.visual_smoke_route_stage = ""
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	OpenHatchVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Open Hatch staging service should stay inert outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "Open Hatch staging service should not set route state outside web visual smoke")
	runner._expect(main.progression_state.to_save_data() == save_before, "Open Hatch staging service should not mutate durable progression outside web visual smoke")

	main.show_debug_telemetry = true
	OpenHatchVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Open Hatch staging wrapper should keep the non-web guard")
	runner._expect(main.visual_smoke_route_stage == "", "Open Hatch staging wrapper should not set route state outside web visual smoke")
	runner._expect(main.progression_state.to_save_data() == save_before, "Open Hatch staging wrapper should not mutate durable progression outside web visual smoke")
	main.free()

func _test_ship_offload_visual_staging_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	main.dive_session.oxygen = 7.0

	ShipOffloadVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Ship Offload staging should keep the daylight dive active")
	runner._expect(main.visual_smoke_route_stage == "ship_offload_complete", "Ship Offload staging should expose the deterministic review stage")
	runner._expect(main.dive_session.current_cargo.is_empty(), "Ship Offload staging should run the normal cargo offload path")
	runner._expect(main.progression_state.resource_count("driftwood") == 1, "Ship Offload staging should bank staged driftwood through progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, main.dive_session.max_oxygen), "Ship Offload staging should refill oxygen through the ship offload path")
	runner._expect(main.player_in_base, "Ship Offload staging should leave the player at the ship")
	runner._expect(main.dive_session.has_left_base, "Ship Offload staging should preserve repeat-sortie eligibility")
	main.queue_free()

func _test_surface_oxygen_visual_staging_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)

	SurfaceOxygenVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Surface Oxygen staging should start or keep the daylight dive active")
	runner._expect(main.visual_smoke_route_stage == "surface_oxygen_refill", "Surface Oxygen staging should expose the deterministic review stage")
	runner._expect(main.player_in_surface_oxygen_refill, "Surface Oxygen staging should place the player in the refill area")
	runner._expect(not main.player_in_base, "Surface Oxygen staging should stay distinct from ship offload staging")
	runner._expect(main.dive_session.current_cargo == ["driftwood"], "Surface Oxygen staging should seed one carried resource for the visual review")
	runner._expect(is_equal_approx(main.dive_session.oxygen, maxf(1.0, main.dive_session.max_oxygen * 0.18)), "Surface Oxygen staging should preserve the low oxygen review value")
	runner._expect(main.status_label.text == "Surface O2 refilling; ship still banks cargo.", "Surface Oxygen staging should preserve the refill status copy")
	main.queue_free()

func _source_grid_water_polygons(source_map: Dictionary, runner) -> Array[PackedVector2Array]:
	var water_polygons: Array[PackedVector2Array] = []
	for cutout_value in source_map.get("source_grid_water_cutouts", []):
		if typeof(cutout_value) != TYPE_DICTIONARY:
			continue
		var cutout := cutout_value as Dictionary
		var points: PackedVector2Array = runner._points_from_source_map_json(cutout.get("polygon", []))
		if points.size() >= 3:
			water_polygons.append(points)
	return water_polygons

func _point_inside_any_polygon(point: Vector2, polygons: Array[PackedVector2Array]) -> bool:
	for polygon in polygons:
		if Geometry2D.is_point_in_polygon(point, polygon):
			return true
	return false
