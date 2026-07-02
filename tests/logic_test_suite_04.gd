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

func _test_save_load_behavior(runner) -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)

	var saved: Dictionary = progression.to_save_data()
	runner._expect(int(saved.get("save_version", -1)) == ProgressionStateScript.CURRENT_SAVE_VERSION, "save should include current save version")

	var loaded := ProgressionStateScript.new()
	loaded.load_save_data(saved)
	runner._expect(loaded.resource_count("kelp_fiber") == 3, "current save should reload banked resources")
	runner._expect(loaded.has_upgrade(OxygenTankUpgrade.id), "current save should reload purchased upgrades")
	runner._expect(loaded.has_discovery("thermal_vent"), "current save should reload scan discoveries")
	runner._expect(is_equal_approx(loaded.best_depth_reached, 144.5), "current save should reload best depth")

	var resonance_save_state := ProgressionStateScript.new()
	resonance_save_state.banked_resources = {"glow_plankton": 4, "shell_fragments": 2}
	resonance_save_state.purchased_upgrades = {
		EchoLensUpgrade.id: true,
		ResonanceKeyUpgrade.id: true,
	}
	resonance_save_state.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	var resonance_saved := resonance_save_state.to_save_data()
	var resonance_loaded := ProgressionStateScript.new()
	resonance_loaded.load_save_data(resonance_saved)
	runner._expect(resonance_loaded.has_upgrade(ResonanceKeyUpgrade.id), "current save should reload Resonance Key I purchase")
	runner._expect(resonance_loaded.has_upgrade(EchoLensUpgrade.id), "current save should preserve Resonance Key I prerequisite upgrade")
	runner._expect(resonance_loaded.has_discovery("east_shelf_route_research"), "current save should reload promoted route-research prerequisite")

	var legacy_save := saved.duplicate(true)
	legacy_save.erase("save_version")
	var legacy_loaded := ProgressionStateScript.new()
	legacy_loaded.load_save_data(legacy_save)
	runner._expect(legacy_loaded.loaded_save_version == ProgressionStateScript.LEGACY_SAVE_VERSION, "missing save version should load as legacy")
	runner._expect(legacy_loaded.has_discovery("thermal_vent"), "legacy save should reload known discovery fields")

	var future_save := saved.duplicate(true)
	future_save["save_version"] = 999
	var future_loaded := ProgressionStateScript.new()
	future_loaded.load_save_data(future_save)
	runner._expect(future_loaded.loaded_save_version == 999, "unknown future save version should be recorded")
	runner._expect(future_loaded.has_upgrade(OxygenTankUpgrade.id), "unknown future save should best-effort load known upgrade ids")

	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_hollow_reef_reading_recovered = true
	main.player_near_east_shelf_pocket = true
	main.player_near_lower_connector_echo = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_blackwater_crack = true
	main.player_near_hollow_reef = true
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	var main_saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(not main_saved.has("run_east_shelf_pocket_ping_recovered"), "progression save should not leak East Shelf run state")
	runner._expect(not main_saved.has("run_lower_connector_echo_recovered"), "progression save should not leak Drop Echo run state")
	runner._expect(not main_saved.has("run_blue_chimney_draft_reading_recovered"), "progression save should not leak Blue Chimney draft state")
	runner._expect(not main_saved.has("run_lantern_silt_sample_recovered"), "progression save should not leak Lantern Silt run state")
	runner._expect(not main_saved.has("run_blackwater_trace_recovered"), "progression save should not leak Blackwater Trace run state")
	runner._expect(not main_saved.has("run_hollow_reef_reading_recovered"), "progression save should not leak Hollow Reef run state")
	runner._expect(not main_saved.has("player_near_east_shelf_pocket"), "progression save should not leak East Shelf proximity state")
	runner._expect(not main_saved.has("player_near_lower_connector_echo"), "progression save should not leak Drop Echo proximity state")
	runner._expect(not main_saved.has("player_near_blue_chimney"), "progression save should not leak Blue Chimney proximity state")
	runner._expect(not main_saved.has("player_near_lantern_silt_nook"), "progression save should not leak Lantern Silt proximity state")
	runner._expect(not main_saved.has("player_near_blackwater_crack"), "progression save should not leak Blackwater proximity state")
	runner._expect(not main_saved.has("player_near_hollow_reef"), "progression save should not leak Hollow Reef proximity state")
	runner._expect(not main_saved.has("blue_chimney_draft"), "progression save should not add durable Blue Chimney draft data")
	runner._expect(not main_saved.has("silt_vein"), "progression save should not add durable Silt Vein route data")
	runner._expect(not main_saved.has("silt_vein_fork"), "progression save should not add durable Silt Vein Fork route data")
	runner._expect(not main_saved.has("lantern_silt"), "progression save should not add durable Lantern Silt route data")
	runner._expect(not main_saved.has("lantern_silt_sample"), "progression save should not add durable Lantern Silt sample data")
	runner._expect(not main_saved.has("blackwater_crack"), "progression save should not add durable Blackwater Crack route data")
	runner._expect(not main_saved.has("blackwater_trace"), "progression save should not add durable Blackwater Trace data")
	runner._expect(not main_saved.has("dusk_trench"), "progression save should not add durable Dusk Trench route data")
	runner._expect(not main_saved.has("dusk_trench_reached"), "progression save should not add durable Dusk Trench reach memory")
	runner._expect(not main_saved.has("glass_kelp_reading"), "progression save should not add durable Glass Kelp reading data")
	runner._expect(not main_saved.has("hollow_reef"), "progression save should not add durable Hollow Reef route data")
	runner._expect(not main_saved.has("hollow_reef_reading"), "progression save should not add durable Hollow Reef reading data")
	runner._expect(main_saved.get("purchased_upgrades", {}).has(ResonanceKeyUpgrade.id), "progression save should keep Resonance Key I as durable upgrade state only")
	main.queue_free()

func _test_save_service(runner) -> void:
	var save_path := "user://logic_test_save_service.json"
	SaveServiceScript.delete_progression_save(save_path)

	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)

	var survival := SurvivalStateScript.new()
	survival.current_day = 3
	survival.food = 2
	survival.water = 4
	survival.power = 1
	survival.chapter_complete = true

	runner._expect(SaveServiceScript.save_progression(save_path, progression, survival), "save service should write progression saves")

	var loaded_progression := ProgressionStateScript.new()
	var loaded_survival := SurvivalStateScript.new()
	runner._expect(SaveServiceScript.load_progression(save_path, loaded_progression, loaded_survival), "save service should load existing progression saves")
	runner._expect(loaded_progression.resource_count("kelp_fiber") == 3, "save service should reload banked resources")
	runner._expect(loaded_progression.has_upgrade(OxygenTankUpgrade.id), "save service should reload purchased upgrades")
	runner._expect(loaded_progression.has_discovery("thermal_vent"), "save service should reload scan discoveries")
	runner._expect(is_equal_approx(loaded_progression.best_depth_reached, 144.5), "save service should reload best depth")
	runner._expect(loaded_survival.current_day == 3, "save service should reload nested survival day")
	runner._expect(loaded_survival.food == 2 and loaded_survival.water == 4 and loaded_survival.power == 1, "save service should reload nested survival needs")
	runner._expect(loaded_survival.chapter_complete, "save service should reload nested survival chapter flags")

	runner._expect(SaveServiceScript.delete_progression_save(save_path), "save service should delete test save files")
	runner._expect(not SaveServiceScript.load_progression(save_path, loaded_progression, loaded_survival), "save service should report missing saves")

func _test_deterministic_seed_generation(runner) -> void:
	var first := ProgressionStateScript.new()
	var second := ProgressionStateScript.new()

	for index in range(5):
		first.advance_run()
		second.advance_run()
		runner._expect(first.current_run_number == index + 1, "run number should advance deterministically")
		runner._expect(first.current_run_seed == 1000 + first.current_run_number * 7919, "run seed should follow the documented formula")
		runner._expect(first.current_run_seed == second.current_run_seed, "two progression states should generate the same seed sequence")

func _test_expedition_condition_selection(runner) -> void:
	var first := ExpeditionConditionScript.condition_for_seed(8919)
	var first_again := ExpeditionConditionScript.condition_for_seed(8919)
	runner._expect(first.get("id", "") == first_again.get("id", ""), "same seed should select the same expedition condition")
	runner._expect(not String(first.get("display_name", "")).is_empty(), "condition should include a display name")
	runner._expect(not String(first.get("briefing", "")).is_empty(), "condition should include a briefing line")
	runner._expect(first.get("tags", []) is Array, "condition should include tag metadata")
	var low_visibility := ExpeditionConditionScript.condition_for_seed(4)
	runner._expect(low_visibility.get("id", "") == "low_visibility", "Low Visibility should remain deterministically selectable by seed")
	runner._expect(low_visibility.get("tags", []).has("visibility"), "Low Visibility should keep visibility tag metadata for route presentation")

	var ids := {}
	for seed in [8919, 16838, 24757, 32676, 40595]:
		ids[ExpeditionConditionScript.id_for_seed(seed)] = true

	runner._expect(ids.size() >= 2, "small seed set should produce at least two expedition conditions")
	runner._expect(ExpeditionConditionScript.id_for_seed(8919) == String(first.get("id", "")), "id_for_seed should match condition_for_seed")

func _test_spawn_point_matching(runner) -> void:
	var point := SpawnPointScript.new()
	point.category = "resource"
	point.target_id = "kelp_fiber"
	point.depth_band = "shallow"
	point.cluster_pattern = "cautious"

	runner._expect(point.matches("resource", "kelp_fiber"), "spawn point should match category and target id")
	runner._expect(not point.matches("creature", "kelp_fiber"), "spawn point should reject different categories")
	runner._expect(not point.matches("resource", "glow_plankton"), "spawn point should reject different target ids")
	runner._expect(point.depth_band == "shallow", "spawn point should preserve authored depth band")
	runner._expect(point.cluster_pattern == "cautious", "spawn point should preserve authored cluster pattern")
	point.free()

func _test_spawn_selection(runner) -> void:
	var root := Node2D.new()
	var shallow: SpawnPoint = runner._make_spawn_point("a", "resource", "kelp_fiber", "shallow", "any", Vector2(10.0, 20.0))
	var cautious: SpawnPoint = runner._make_spawn_point("b", "resource", "kelp_fiber", "shallow", "cautious", Vector2(30.0, 40.0))
	var deep_reward: SpawnPoint = runner._make_spawn_point("c", "resource", "kelp_fiber", "shallow", "deep_reward", Vector2(50.0, 60.0))
	root.add_child(shallow)
	root.add_child(cautious)
	root.add_child(deep_reward)

	var positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "kelp_fiber", "cautious")
	runner._expect(positions.size() == 2, "spawn selection should include any and matching cluster points")
	runner._expect(positions.has(Vector2(10.0, 20.0)), "spawn selection should include any-cluster point")
	runner._expect(positions.has(Vector2(30.0, 40.0)), "spawn selection should include matching cautious point")
	runner._expect(not positions.has(Vector2(50.0, 60.0)), "spawn selection should exclude nonmatching cluster point")
	runner._expect(SpawnSelectionScript.cluster_pattern_for_seed(1, ["cautious", "deep_reward"]) == "deep_reward", "spawn selection should map seeds to cluster patterns deterministically")
	var shell_reef: SpawnPoint = runner._make_spawn_point("reef", "resource", "shell_fragments", "midwater", "any", Vector2(70.0, 80.0))
	root.add_child(shell_reef)
	var shell_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward")
	runner._expect(shell_positions.size() == 1, "shell reef spawn selection should include one authored shell candidate without adding extra pickups")
	runner._expect(shell_positions.has(Vector2(70.0, 80.0)), "shell reef spawn selection should include any-pattern reef candidate")
	runner._expect(shell_reef.depth_band == "midwater", "shell reef spawn point should preserve midwater depth identity")

	var vent_glow: SpawnPoint = runner._make_spawn_point("vent", "resource", "glow_plankton", "deep", "deep_reward", Vector2(90.0, 100.0))
	root.add_child(vent_glow)
	var blue_chimney_glow: SpawnPoint = runner._make_spawn_point("blue_chimney", "resource", "glow_plankton", "deep", "deep_reward", Vector2(110.0, 130.0))
	root.add_child(blue_chimney_glow)
	var vent_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	runner._expect(vent_positions.size() == 2, "lower-route glow candidates should be selectable authored points without adding extra pickups")
	runner._expect(vent_positions.has(Vector2(90.0, 100.0)), "thermal vent pocket should expose inspectable glow placement")
	runner._expect(vent_positions.has(Vector2(110.0, 130.0)), "Blue Chimney should expose an optional existing-glow placement")
	runner._expect(vent_glow.depth_band == "deep", "thermal vent glow candidates should preserve deep resource identity")
	runner._expect(blue_chimney_glow.depth_band == "deep", "Blue Chimney glow candidate should preserve deep resource identity")
	root.free()

func _test_condition_weighted_spawn_selection(runner) -> void:
	var root := Node2D.new()
	var glow_a: SpawnPoint = runner._make_spawn_point("glow_a", "resource", "glow_plankton", "deep", "deep_reward", Vector2(10.0, 100.0))
	var glow_b: SpawnPoint = runner._make_spawn_point("glow_b", "resource", "glow_plankton", "deep", "deep_reward", Vector2(20.0, 100.0))
	var vent_glow: SpawnPoint = runner._make_spawn_point("vent_glow", "resource", "glow_plankton", "deep", "deep_reward", Vector2(30.0, 100.0), "thermal_bloom")
	var shell: SpawnPoint = runner._make_spawn_point("shell", "resource", "shell_fragments", "midwater", "deep_reward", Vector2(40.0, 100.0), "thermal_bloom")
	root.add_child(glow_a)
	root.add_child(glow_b)
	root.add_child(vent_glow)
	root.add_child(shell)

	var unweighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	var calm_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "calm_current")
	var thermal_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var thermal_weighted_repeat := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var shell_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward", "thermal_bloom")

	runner._expect(unweighted.size() == 3, "unweighted glow selection should keep every authored matching candidate")
	runner._expect(calm_weighted == unweighted, "unaffected conditions should preserve glow selection behavior")
	runner._expect(thermal_weighted == thermal_weighted_repeat, "thermal bloom weighting should be deterministic for the same inputs")
	runner._expect(thermal_weighted.size() == 1, "thermal bloom weighting should not add active glow candidates")
	runner._expect(thermal_weighted.has(Vector2(30.0, 100.0)), "thermal bloom should prefer the authored vent glow candidate")
	runner._expect(vent_glow.depth_band == "deep", "condition-preferred glow should preserve deep depth-band identity")
	runner._expect(shell_weighted.size() == 1, "thermal bloom should not broaden non-glow resource selection")
	runner._expect(shell_weighted.has(Vector2(40.0, 100.0)), "thermal bloom should leave non-glow target positions intact")

	var default_route_start: SpawnPoint = runner._make_spawn_point("start", "creature", "lantern_ray", "deep", "cautious", Vector2(100.0, 200.0))
	default_route_start.route_id = "default_glide"
	var default_route_end: SpawnPoint = runner._make_spawn_point("end", "creature", "lantern_ray", "deep", "cautious", Vector2(180.0, 220.0))
	default_route_end.route_id = "default_glide"
	var low_visibility_start: SpawnPoint = runner._make_spawn_point("start", "creature", "lantern_ray", "deep", "cautious", Vector2(120.0, 180.0), "low_visibility")
	low_visibility_start.route_id = "low_visibility_glide"
	var low_visibility_end: SpawnPoint = runner._make_spawn_point("end", "creature", "lantern_ray", "deep", "cautious", Vector2(190.0, 190.0), "low_visibility")
	low_visibility_end.route_id = "low_visibility_glide"
	root.add_child(default_route_start)
	root.add_child(default_route_end)
	root.add_child(low_visibility_start)
	root.add_child(low_visibility_end)
	var calm_routes := SpawnSelectionScript.routes_for_target(root, SpawnPointScript, "creature", "lantern_ray", "cautious", "calm_current")
	var low_visibility_routes := SpawnSelectionScript.routes_for_target(root, SpawnPointScript, "creature", "lantern_ray", "cautious", "low_visibility")
	runner._expect(calm_routes.size() == 2, "nonmatching conditions should keep every authored Lantern Ray route candidate")
	runner._expect(low_visibility_routes.size() == 1 and low_visibility_routes.has("low_visibility_glide"), "matching conditions should prefer authored Lantern Ray route variants")
	root.free()
