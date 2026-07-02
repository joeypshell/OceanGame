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

func _test_no_minimap_orientation_guardrails(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player

	scene_player.global_position = main.start_position + Vector2(860.0, 640.0)
	var east_shelf_direction: String = main.call("_format_base_direction")
	runner._expect(east_shelf_direction.contains("up-left"), "East Shelf orientation should use broad return direction")
	runner._expect_no_echo_lens_locator_language(east_shelf_direction, "East Shelf base direction")

	scene_player.global_position = Vector2(2124.0, 2024.0)
	var shelf_drop_direction: String = main.call("_format_base_direction")
	runner._expect(shelf_drop_direction.contains("up-left"), "Shelf Drop orientation should use broad return direction")
	runner._expect_no_echo_lens_locator_language(shelf_drop_direction, "Shelf Drop base direction")

	scene_player.global_position = Vector2(2112.0, 2190.0)
	var blue_chimney_direction: String = main.call("_format_base_direction")
	runner._expect(blue_chimney_direction.contains("up-left"), "Blue Chimney orientation should use broad return direction")
	runner._expect_no_echo_lens_locator_language(blue_chimney_direction, "Blue Chimney base direction")

	scene_player.global_position = Vector2(2160.0, 2346.0)
	var silt_vein_direction: String = main.call("_format_base_direction")
	runner._expect(silt_vein_direction.contains("up-left"), "Silt Vein Fork orientation should use broad return direction")
	runner._expect_no_echo_lens_locator_language(silt_vein_direction, "Silt Vein Fork base direction")

	scene_player.global_position = Vector2(2440.0, 2660.0)
	var blackwater_sill_direction: String = main.call("_format_base_direction")
	runner._expect(blackwater_sill_direction.contains("up-left"), "Blackwater Sill orientation should use broad return direction")
	runner._expect(blackwater_sill_direction.contains("Silt/Blue"), "Blackwater Sill orientation should keep compact named return memory")
	runner._expect_no_echo_lens_locator_language(blackwater_sill_direction, "Blackwater Sill base direction")
	scene_player.global_position = Vector2(2900.0, 3000.0)
	var dusk_trench_direction: String = main.call("_format_base_direction")
	runner._expect(dusk_trench_direction.contains("up-left"), "Dusk Trench orientation should use broad return direction")
	runner._expect(dusk_trench_direction.contains("Dusk/Blackwater"), "Dusk Trench orientation should keep compact named return memory")
	runner._expect(not dusk_trench_direction.contains("Hollow"), "Dusk Trench orientation should not claim the player is inside Hollow Reef")
	runner._expect_no_echo_lens_locator_language(dusk_trench_direction, "Dusk Trench base direction")

	scene_player.global_position = Vector2(3700.0, 2964.0)
	var wide_chamber_direction: String = main.call("_format_base_direction")
	runner._expect(wide_chamber_direction.contains("up-left"), "Wide chamber orientation should use broad return direction")
	runner._expect(wide_chamber_direction.contains("Hollow/Dusk/Blackwater"), "Wide chamber orientation should keep a compact named return chain")
	runner._expect(not wide_chamber_direction.contains("Silt/Blue"), "Wide chamber orientation should stay short enough for the active HUD")
	runner._expect_no_echo_lens_locator_language(wide_chamber_direction, "Wide chamber base direction")

	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	var orientation_memory := "%s%s%s" % [
		ResearchResultCalloutServiceScript.format_east_shelf_pocket_research_callout(main),
		ResearchResultCalloutServiceScript.format_lower_connector_echo_research_callout(main),
		ResearchResultCalloutServiceScript.format_sealed_shelf_hatch_readiness_callout(main),
	]
	runner._expect(orientation_memory.contains("East Shelf"), "orientation memory should name the learned side route")
	runner._expect(orientation_memory.contains("Shelf Drop Connector"), "orientation memory should name the lower connector")
	runner._expect(orientation_memory.contains("Sealed Shelf Hatch"), "orientation memory should name the upgrade-locked promise")
	runner._expect_no_echo_lens_locator_language(orientation_memory, "larger side-view route result memory")

	var blue_chimney_landmark := main.get_node("LandmarkMetadata/BlueChimney")
	var blue_chimney_memory := "%s %s %s" % [
		String(blue_chimney_landmark.get("display_name")),
		String(blue_chimney_landmark.get("stable_region_name")),
		String(blue_chimney_landmark.get("memory_goal")),
	]
	runner._expect(blue_chimney_memory.contains("Blue Chimney"), "Blue Chimney metadata should provide broad place memory")
	runner._expect(blue_chimney_memory.contains("up-left"), "Blue Chimney metadata should preserve broad return orientation")
	runner._expect_no_echo_lens_locator_language(blue_chimney_memory, "Blue Chimney metadata")
	var silt_vein_landmark := main.get_node("LandmarkMetadata/SiltVeinFork")
	var silt_vein_memory := "%s %s %s" % [
		String(silt_vein_landmark.get("display_name")),
		String(silt_vein_landmark.get("stable_region_name")),
		String(silt_vein_landmark.get("memory_goal")),
	]
	runner._expect(silt_vein_memory.contains("Silt Vein Fork"), "Silt Vein Fork metadata should provide broad place memory")
	runner._expect(silt_vein_memory.contains("Blue Chimney"), "Silt Vein Fork metadata should anchor return memory to Blue Chimney")
	runner._expect(silt_vein_memory.contains("up-left"), "Silt Vein Fork metadata should preserve broad return orientation")
	runner._expect_no_echo_lens_locator_language(silt_vein_memory, "Silt Vein Fork metadata")
	var dusk_trench_landmark := main.get_node("LandmarkMetadata/DuskTrench")
	var dusk_trench_memory := "%s %s %s" % [
		String(dusk_trench_landmark.get("display_name")),
		String(dusk_trench_landmark.get("stable_region_name")),
		String(dusk_trench_landmark.get("memory_goal")),
	]
	runner._expect(dusk_trench_memory.contains("Dusk Trench"), "Dusk Trench metadata should provide broad place memory")
	runner._expect(dusk_trench_memory.contains("Blackwater"), "Dusk Trench metadata should anchor return memory to Blackwater")
	runner._expect(dusk_trench_memory.contains("up-left"), "Dusk Trench metadata should preserve broad return orientation")
	runner._expect(not dusk_trench_memory.to_lower().contains("coordinate"), "Dusk Trench metadata should avoid coordinate language")
	runner._expect(not dusk_trench_memory.to_lower().contains("map"), "Dusk Trench metadata should avoid map language")
	runner._expect_no_echo_lens_locator_language(dusk_trench_memory, "Dusk Trench metadata")
	main.queue_free()

func _test_expanded_region_reset_state_ownership(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	var run_before_restart: int = main.progression_state.current_run_number

	main.progression_state.banked_resources["glow_plankton"] = 2
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.run_wreck_echo_clue_recovered = true
	main.run_resonance_alcove_research_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_glass_kelp_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.player_near_resonance_alcove = true
	main.player_near_blue_chimney = true
	main.player_near_lantern_silt_nook = true
	main.player_near_glass_kelp_ledge = true
	main.player_near_tideglass_sample = true
	main.player_near_outer_shelf_survey = true
	main.player_near_rim_glass_reading = true
	main.player_near_salvage_manifest = true
	main.run_collected_resources.append("kelp_fiber")
	main.run_completed_scans.append("east_shelf_arch")
	main.run_predator_contacts = 1
	main.decoy_pulse_used_this_run = true
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = main.start_position + Vector2(1280.0, 980.0)
	scene_player.velocity = Vector2(123.0, 45.0)

	main.call("_restart_dive")

	runner._expect(main.progression_state.current_run_number == run_before_restart + 1, "restart should advance to the next expedition seed")
	runner._expect(scene_player.global_position == main.start_position, "restart should return the sub to the marked base start")
	runner._expect(scene_player.velocity == Vector2.ZERO, "restart should clear expanded-route movement velocity")
	runner._expect(main.player_in_base, "restart should restore extraction-zone ownership to the base")
	runner._expect(not main.dive_session.has_left_base, "restart should require leaving base before extraction can succeed again")
	runner._expect(not main.dive_session.can_extract(main.player_in_base), "restart should preserve extraction safety at the starting base")
	runner._expect(main.dive_session.cargo.is_empty(), "restart should clear carried cargo from the previous expedition")
	runner._expect(not main.run_wreck_echo_clue_recovered, "restart should clear run-scoped Wreck Echo clue state")
	runner._expect(not main.run_resonance_alcove_research_recovered, "restart should clear run-scoped Resonance Alcove research state")
	runner._expect(not main.run_blue_chimney_draft_reading_recovered, "restart should clear run-scoped Blue Chimney draft state")
	runner._expect(not main.run_lantern_silt_sample_recovered, "restart should clear run-scoped Lantern Silt sample state")
	runner._expect(not main.run_glass_kelp_reading_recovered, "restart should clear run-scoped Glass Kelp reading state")
	runner._expect(not main.run_tideglass_sample_recovered, "restart should clear run-scoped Tideglass Sample state")
	runner._expect(not main.run_outer_shelf_survey_recovered, "restart should clear run-scoped Outer Shelf survey state")
	runner._expect(not main.run_rim_glass_reading_recovered, "restart should clear run-scoped Glass Rim reading state")
	runner._expect(not main.player_near_resonance_alcove, "restart should clear Resonance Alcove proximity state")
	runner._expect(not main.player_near_blue_chimney, "restart should clear Blue Chimney proximity state")
	runner._expect(not main.player_near_lantern_silt_nook, "restart should clear Lantern Silt proximity state")
	runner._expect(not main.player_near_glass_kelp_ledge, "restart should clear Glass Kelp proximity state")
	runner._expect(not main.player_near_tideglass_sample, "restart should clear Tideglass Sample proximity state")
	runner._expect(not main.player_near_outer_shelf_survey, "restart should clear Outer Shelf proximity state")
	runner._expect(not main.player_near_rim_glass_reading, "restart should clear Glass Rim reading proximity state")
	runner._expect(main.run_collected_resources.is_empty(), "restart should clear run-scoped collected-resource telemetry")
	runner._expect(main.run_completed_scans.is_empty(), "restart should clear run-scoped scan telemetry")
	runner._expect(main.run_predator_contacts == 0, "restart should clear run-scoped predator contact telemetry")
	runner._expect(not main.decoy_pulse_used_this_run, "restart should clear run-scoped decoy pulse use")
	runner._expect(main.progression_state.resource_count("glow_plankton") == 2, "restart should preserve banked persistent resources")
	runner._expect(main.progression_state.has_upgrade(EchoLensUpgrade.id), "restart should preserve purchased persistent upgrades")

	var lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	runner._expect(lock_label.text == "ECHO PING", "restart should preserve persistent upgrade promise state after reset")
	main.queue_free()
