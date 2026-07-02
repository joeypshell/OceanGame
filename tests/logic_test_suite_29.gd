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

func _test_recent_expedition_presenter(runner) -> void:
	var empty_log := RecentExpeditionPresenterScript.format_recent_expedition_log([], false, {})
	runner._expect(empty_log == "Recent Expeditions\nNone yet.", "recent expedition presenter should keep empty-log copy exact")

	var entries: Array[Dictionary] = [{
		"run_number": 7,
		"result": "Extracted",
		"banked_cargo_count": 2,
		"route_memory": "Outer Shelf",
		"scans": ["thermal_vent", "unknown_scan"],
		"predator_contacts": 1,
		"best_depth": 88,
		"survival_memory": "banked Food supply",
		"seed": 1234,
		"pattern": "Cautious shallows",
	}]
	var scan_names := {
		"thermal_vent": "Thermal Vent",
	}
	var log_text := RecentExpeditionPresenterScript.format_recent_expedition_log(entries, false, scan_names)
	runner._expect(log_text.contains("#7 Extracted: banked 2, route Outer Shelf"), "recent expedition presenter should include run number, result, banked cargo, and route")
	runner._expect(log_text.contains("scans Thermal Vent/unknown_scan"), "recent expedition presenter should use provided scan names with id fallback")
	runner._expect(log_text.contains("next Glass Rim timing or cargo"), "recent expedition presenter should keep route tease copy")
	runner._expect(log_text.contains("survival banked Food supply"), "recent expedition presenter should append survival memory")
	runner._expect(not log_text.contains("seed 1234"), "recent expedition presenter should hide seed without debug telemetry")

	var debug_text := RecentExpeditionPresenterScript.format_recent_expedition_log(entries, true, scan_names)
	runner._expect(debug_text.contains("seed 1234, Cautious shallows"), "recent expedition presenter should expose debug telemetry when requested")
	runner._expect(RecentExpeditionPresenterScript.format_recent_route_tease("Glass Rim") == "timing, cargo, or return", "Glass Rim route tease should stay exact")
	runner._expect(RecentExpeditionPresenterScript.format_recent_route_tease("Shell Reef") == "", "non-tease routes should remain quiet")
	runner._expect(RecentExpeditionPresenterScript.format_scan_names_short([], scan_names) == "none", "empty scan lists should stay compact")
	runner._expect(RecentExpeditionPresenterScript.string_array_from("bad data").is_empty(), "non-array scan data should be ignored")

func _test_recent_expedition_log(runner) -> void:
	var main := MainScript.new()
	main.current_resource_cluster_pattern = "cautious"
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "", "empty recent expedition log should not provide ready-route memory")

	for run_number in range(1, 5):
		main.progression_state.current_run_number = run_number
		main.progression_state.current_run_seed = 1000 + run_number
		main.progression_state.best_depth_reached = 10.0 * run_number
		main.run_completed_scans.clear()
		if run_number % 2 == 0:
			main.run_completed_scans.append("thermal_vent")
		main.run_predator_contacts = run_number - 1
		main._record_recent_expedition("Extracted", run_number)

	runner._expect(main.recent_expedition_log.size() == 3, "recent expedition log should keep only the latest three entries")
	var log_text := RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(not log_text.contains("#1"), "recent expedition log should drop the oldest entry")
	runner._expect(log_text.contains("#2 Extracted"), "recent expedition log should include the oldest retained entry")
	runner._expect(log_text.contains("route Gulper Route"), "recent expedition log should preserve one compact route memory")
	runner._expect(log_text.contains("scans Thermal Vent"), "recent expedition log should show readable scan names")
	runner._expect(log_text.contains("contacts 3"), "recent expedition log should show predator contacts")
	runner._expect(not log_text.contains("seed"), "recent expedition log should hide seed by default")
	runner._expect_lines_within(log_text, 120, "recent expedition log")

	main.show_debug_telemetry = true
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("seed 1004"), "recent expedition log should show seed only with debug telemetry")
	runner._expect(log_text.contains("Cautious shallows"), "recent expedition log should show pattern only with debug telemetry")
	main.show_debug_telemetry = false

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 8
	main.progression_state.current_run_seed = 2008
	main.progression_state.best_depth_reached = 280.0
	main.run_completed_scans = ["lantern_ray"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#8 Extracted"), "recent expedition log should include Lantern Ray observation runs")
	runner._expect(log_text.contains("route Lantern Ray"), "Lantern Ray observation should produce compact recent route memory")
	runner._expect(log_text.contains("scans Lantern Ray"), "Lantern Ray scan should appear with readable scan names")
	runner._expect(not log_text.contains("seed"), "Lantern Ray recent log should hide raw seed without debug telemetry")
	runner._expect(not log_text.to_lower().contains("field guide"), "Lantern Ray recent log should not imply field-guide UI")
	runner._expect(not log_text.to_lower().contains("checklist"), "Lantern Ray recent log should not imply checklist UI")
	runner._expect_no_monster_combat_language(log_text, "Lantern Ray recent expedition log")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 82
	main.progression_state.current_run_seed = 2082
	main.progression_state.best_depth_reached = 336.0
	main.run_completed_scans = ["glassfin_swarm"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	var save_before_recent_glassfin: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#82 Extracted"), "recent expedition log should include Glassfin Swarm observation runs")
	runner._expect(log_text.contains("route Glassfin Swarm"), "Glassfin Swarm observation should produce compact recent route memory")
	runner._expect(log_text.contains("scans Glassfin Swarm"), "Glassfin Swarm scan should appear with readable scan name")
	runner._expect(not log_text.contains("seed"), "Glassfin Swarm recent log should hide raw seed without debug telemetry")
	runner._expect(not log_text.to_lower().contains("field guide"), "Glassfin Swarm recent log should not imply field-guide UI")
	runner._expect(not log_text.to_lower().contains("checklist"), "Glassfin Swarm recent log should not imply checklist UI")
	runner._expect_no_monster_combat_language(log_text, "Glassfin Swarm recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Glassfin Swarm", "latest route helper should expose Glassfin Swarm after a swarm observation")
	runner._expect(main.progression_state.to_save_data() == save_before_recent_glassfin, "Glassfin Swarm recent route memory should remain session-only")
	runner._expect(not main.progression_state.to_save_data().has("glassfin_swarm_route"), "recent Glassfin Swarm memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 81
	main.progression_state.current_run_seed = 2081
	main.progression_state.best_depth_reached = 260.0
	main.run_completed_scans = ["lantern_ray"]
	main.run_predator_contacts = 1
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	main._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("route Gulper Route"), "recent log should keep predator safety memory when no deeper route wins")
	runner._expect(not log_text.contains("route Lantern Ray"), "predator safety memory should win over passive creature observation after contact")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 9
	main.progression_state.current_run_seed = 2009
	main.progression_state.best_depth_reached = 208.0
	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main._record_recent_expedition("Failed", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#9 Failed"), "recent expedition log should include failed Blackwater attempts")
	runner._expect(log_text.contains("route Blackwater"), "recent expedition log should prioritize the deepest reached route")
	runner._expect(log_text.find("route Blackwater") == log_text.rfind("route Blackwater"), "recent expedition log should not duplicate Blackwater route memory")
	runner._expect(not log_text.contains("seed"), "Blackwater recent log should hide raw seed without debug telemetry")
	runner._expect_no_echo_lens_locator_language(log_text, "Blackwater recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Blackwater", "latest route helper should expose Blackwater for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 10
	main.progression_state.current_run_seed = 2010
	main.progression_state.best_depth_reached = 302.0
	main.run_completed_scans = ["thermal_vent", "lantern_ray", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#10 Extracted"), "recent expedition log should include Dusk route attempts")
	runner._expect(log_text.contains("route Dusk Trench"), "recent expedition log should prioritize Dusk reach evidence")
	runner._expect(not log_text.contains("route Blackwater"), "Dusk recent route memory should take priority over Blackwater")
	runner._expect(not log_text.contains("route Lantern Ray"), "Dusk recent route memory should take priority over Lantern Ray observation")
	runner._expect(not log_text.contains("route Glassfin Swarm"), "Dusk recent route memory should take priority over Glassfin observation")
	runner._expect(log_text.contains("scans Thermal Vent/Lantern Ray"), "Dusk recent log should still keep compact scan names when Lantern Ray was scanned")
	runner._expect(log_text.find("route Dusk Trench") == log_text.rfind("route Dusk Trench"), "recent expedition log should not duplicate Dusk route memory")
	runner._expect(not log_text.contains("seed"), "Dusk recent log should hide raw seed without debug telemetry")
	runner._expect_no_echo_lens_locator_language(log_text, "Dusk recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Dusk Trench", "latest route helper should expose Dusk for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 11
	main.progression_state.current_run_seed = 2011
	main.progression_state.best_depth_reached = 312.0
	main.run_completed_scans = ["thermal_vent", "lantern_ray", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 2
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#11 Extracted"), "recent expedition log should include Hollow Reef route attempts")
	runner._expect(log_text.contains("route Hollow Reef"), "recent expedition log should prioritize Hollow Reef over Dusk and Blackwater")
	runner._expect(not log_text.contains("route Dusk Trench"), "Hollow Reef recent route memory should take priority over Dusk")
	runner._expect(not log_text.contains("route Blackwater"), "Hollow Reef recent route memory should take priority over Blackwater")
	runner._expect(not log_text.contains("route Glassfin Swarm"), "Hollow Reef recent route memory should take priority over Glassfin observation")
	runner._expect(not log_text.contains("route Lantern Ray"), "Hollow Reef recent route memory should take priority over creature observation")
	runner._expect_no_echo_lens_locator_language(log_text, "Hollow Reef recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Hollow Reef", "latest route helper should expose Hollow Reef for the next ready panel")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 13
	main.progression_state.current_run_seed = 2013
	main.progression_state.best_depth_reached = 340.0
	main.run_completed_scans = ["thermal_vent", "hollow_reef_skitter", "glassfin_swarm"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_predator_contacts = 1
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main.run_salvage_data_cache_recovered = true
	var save_before_recent_wide_chamber: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#13 Extracted"), "recent expedition log should include wide chamber salvage runs")
	runner._expect(log_text.contains("route Wide Reef Chamber"), "wide chamber salvage evidence should produce compact recent route memory")
	runner._expect(not log_text.contains("route Hollow Reef"), "wide chamber recent route memory should take priority over Hollow Reef when salvage evidence exists")
	runner._expect(not log_text.contains("route Dusk Trench"), "wide chamber recent route memory should take priority over Dusk when salvage evidence exists")
	runner._expect(not log_text.contains("route Blackwater"), "wide chamber recent route memory should take priority over Blackwater")
	runner._expect(not log_text.contains("route Glassfin Swarm"), "wide chamber recent route memory should take priority over passive Glassfin observation")
	runner._expect(not log_text.to_lower().contains("checklist"), "wide chamber recent log should not imply checklist UI")
	runner._expect(not log_text.to_lower().contains("field guide"), "wide chamber recent log should not imply field-guide UI")
	runner._expect_no_echo_lens_locator_language(log_text, "Wide Reef Chamber recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Wide Reef Chamber", "latest route helper should expose Wide Reef Chamber after salvage cache evidence")
	runner._expect(main.progression_state.to_save_data() == save_before_recent_wide_chamber, "wide chamber recent route memory should remain session-only")
	runner._expect(not main.progression_state.to_save_data().has("wide_reef_chamber_route"), "recent wide chamber memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.progression_state.current_run_number = 14
	main.progression_state.current_run_seed = 2014
	main.progression_state.best_depth_reached = 352.0
	main.run_completed_scans = ["mirrorfin_drift"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_hollow_reef_reading_recovered = true
	main.run_salvage_data_cache_recovered = true
	main.run_tideglass_sample_recovered = true
	var save_before_recent_mirror_kelp: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#14 Extracted"), "recent expedition log should include Mirror Kelp branch runs")
	runner._expect(log_text.contains("route Mirror Kelp Pass"), "Mirror Kelp evidence should produce compact recent route memory")
	runner._expect(log_text.contains("scans Mirrorfin Drift"), "Mirrorfin scan should appear with readable scan name")
	runner._expect(not log_text.contains("route Wide Reef Chamber"), "Mirror Kelp recent route memory should take priority over upstream wide chamber memory")
	runner._expect(not log_text.contains("route Hollow Reef"), "Mirror Kelp recent route memory should take priority over upstream Hollow Reef memory")
	runner._expect(not log_text.contains("seed"), "Mirror Kelp recent log should hide raw seed without debug telemetry")
	runner._expect(not log_text.to_lower().contains("checklist"), "Mirror Kelp recent log should not imply checklist UI")
	runner._expect(not log_text.to_lower().contains("field guide"), "Mirror Kelp recent log should not imply field-guide UI")
	runner._expect_no_echo_lens_locator_language(log_text, "Mirror Kelp recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Mirror Kelp Pass", "latest route helper should expose Mirror Kelp Pass after branch evidence")
	runner._expect(main.progression_state.to_save_data() == save_before_recent_mirror_kelp, "Mirror Kelp recent route memory should remain session-only")
	runner._expect(not main.progression_state.to_save_data().has("mirror_kelp_pass_route"), "recent Mirror Kelp memory should not create durable route state")

	main.recent_expedition_log.clear()
	main.run_tideglass_sample_recovered = false
	main.progression_state.current_run_number = 12
	main.progression_state.current_run_seed = 2012
	main.progression_state.best_depth_reached = 316.0
	main.run_completed_scans = ["hollow_reef_skitter"]
	main.run_collected_resources = []
	main.run_predator_contacts = 0
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_blackwater_trace_recovered = false
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = false
	main.run_salvage_data_cache_recovered = false
	var save_before_recent_hollow: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(main)
	runner._expect(log_text.contains("#12 Extracted"), "recent expedition log should include Hollow Reef Skitter observation runs")
	runner._expect(log_text.contains("route Hollow Reef"), "Hollow Reef Skitter observation should produce compact Hollow Reef recent route memory")
	runner._expect(log_text.contains("scans Hollow Reef Skitter"), "Hollow Reef Skitter scan should appear with readable scan name")
	runner._expect(not log_text.contains("seed"), "Hollow Reef recent log should hide raw seed without debug telemetry")
	runner._expect(not log_text.to_lower().contains("checklist"), "Hollow Reef recent log should not imply checklist UI")
	runner._expect(not log_text.to_lower().contains("field guide"), "Hollow Reef recent log should not imply field-guide UI")
	runner._expect_no_echo_lens_locator_language(log_text, "Hollow Reef Skitter recent expedition log")
	runner._expect(RecentExpeditionLogServiceScript.latest_recent_route_memory(main.recent_expedition_log) == "Hollow Reef", "latest route helper should expose Hollow Reef after a Skitter observation")
	runner._expect(main.progression_state.to_save_data() == save_before_recent_hollow, "Hollow Reef recent route memory should remain session-only")
	runner._expect(not main.progression_state.to_save_data().has("hollow_reef_route"), "recent Hollow Reef memory should not create durable route state")
	main.free()
