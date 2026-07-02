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

func _test_run_telemetry_reset_service(runner) -> void:
	var main := MainScript.new()
	main.run_collected_resources = ["shell_fragments"]
	main.run_collected_survival_supplies = ["food_supply"]
	main.run_banked_survival_supplies = ["power_supply"]
	main.run_completed_scans = ["thermal_vent"]
	main.run_predator_contacts = 2
	main.run_health_damage_events = 1
	main.last_health_damage_source = "thermal vent heat"
	main.last_health_damage_amount = 12.0
	main.run_failure_cause = "oxygen"
	main.run_echo_lens_echo_fired = true
	main.run_wreck_echo_clue_recovered = true
	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.run_resonance_alcove_research_recovered = true
	main.run_blue_chimney_draft_reading_recovered = true
	main.run_lantern_silt_sample_recovered = true
	main.run_blackwater_trace_recovered = true
	main.run_reached_dusk_trench = true
	main.run_glass_kelp_reading_recovered = true
	main.run_hollow_reef_reading_recovered = true
	main.run_salvage_manifest_recovered = true
	main.run_salvage_data_cache_recovered = true
	main.run_outer_shelf_survey_recovered = true
	main.run_rim_glass_reading_recovered = true
	main.run_tideglass_sample_recovered = true
	main.run_survival_supply_cache_recovered = true
	main.last_completed_survival_day = 4
	main.debug_wreck_echo_review_staged = true
	main.visual_smoke_route_stage = "wreck"
	main.current_lantern_ray_route_id = "high"
	main.echo_lens_pulse_timer = 3.0
	main.blue_chimney_draft_timer = 3.0
	main.blackwater_pressure_timer = 3.0
	main.lantern_ray_timing_timer = 3.0
	main.hollow_reef_timing_timer = 3.0
	main.glassfin_swarm_spacing_timer = 3.0
	main.salvage_silt_timing_timer = 3.0
	main.outer_shelf_slackwater_timer = 3.0

	RunTelemetryResetServiceScript.reset_run_telemetry(main)
	runner._expect(main.run_collected_resources.is_empty() and main.run_collected_survival_supplies.is_empty(), "run telemetry reset service should clear collected resource telemetry")
	runner._expect(main.run_banked_survival_supplies.is_empty() and main.run_completed_scans.is_empty(), "run telemetry reset service should clear banked supply and scan telemetry")
	runner._expect(main.run_predator_contacts == 0 and main.run_health_damage_events == 0, "run telemetry reset service should clear encounter counters")
	runner._expect(main.last_health_damage_source == "" and is_equal_approx(main.last_health_damage_amount, 0.0), "run telemetry reset service should clear last damage details")
	runner._expect(main.run_failure_cause == "none", "run telemetry reset service should restore default failure cause")
	runner._expect(not main.run_echo_lens_echo_fired and not main.run_wreck_echo_clue_recovered, "run telemetry reset service should clear Echo Lens and wreck clue flags")
	runner._expect(not main.run_blackwater_trace_recovered and not main.run_reached_dusk_trench, "run telemetry reset service should clear route memory flags")
	runner._expect(not main.run_salvage_data_cache_recovered and not main.run_tideglass_sample_recovered, "run telemetry reset service should clear late-region research flags")
	runner._expect(main.last_completed_survival_day == 0 and not main.debug_wreck_echo_review_staged, "run telemetry reset service should clear day/debug reset fields")
	runner._expect(main.visual_smoke_route_stage == "" and main.current_lantern_ray_route_id == "none", "run telemetry reset service should restore visual stage and Lantern Ray route defaults")
	runner._expect(is_equal_approx(main.echo_lens_pulse_timer, 0.0) and is_equal_approx(main.outer_shelf_slackwater_timer, 0.0), "run telemetry reset service should clear route timing timers")
	main.free()

func _test_route_choice_result_callout(runner) -> void:
	var main := MainScript.new()

	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main) == "", "route choice callout should stay hidden without run evidence")

	main.run_collected_resources = ["shell_fragments"]
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Shell Reef"), "shell cargo should produce a reef banking callout")

	main.run_collected_resources = []
	main.run_east_shelf_pocket_ping_recovered = true
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("East Shelf research push"), "East Shelf payoff should produce a research-push route callout")

	main.run_lower_connector_echo_recovered = true
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Shelf Drop"), "Drop Echo payoff should produce a lower-route route callout")

	main.run_blue_chimney_draft_reading_recovered = true
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Blue Chimney"), "Blue Chimney survey core should produce a lower-route route callout")

	main.run_east_shelf_pocket_ping_recovered = false
	main.run_lower_connector_echo_recovered = false
	main.run_blue_chimney_draft_reading_recovered = false
	main.run_lantern_silt_sample_recovered = true
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Silt Vein"), "Lantern Silt payoff should produce a lower-route route callout")

	main.run_lantern_silt_sample_recovered = false
	main.run_blackwater_trace_recovered = true
	main.run_predator_contacts = 1
	var blackwater_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(blackwater_callout.contains("Blackwater"), "Blackwater Trace should produce the deepest-route route callout")
	runner._expect(not blackwater_callout.contains("predator route"), "Blackwater route evidence should not be crowded out by predator pressure")
	runner._expect(blackwater_callout.find("Route choice:") == blackwater_callout.rfind("Route choice:"), "Blackwater route memory should stay one compact route-choice line")
	runner._expect_no_echo_lens_locator_language(blackwater_callout, "Blackwater route choice")
	var empty_cargo: Array[String] = []
	var blackwater_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(not blackwater_summary.contains("Dusk Trench"), "Dusk result memory should stay hidden before reach evidence")

	main.run_reached_dusk_trench = true
	var dusk_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(dusk_callout.contains("Dusk Trench"), "Dusk reach evidence should produce the deepest route-choice callout")
	runner._expect(not dusk_callout.contains("Blackwater"), "Dusk route choice should take priority over Blackwater route evidence")
	runner._expect(dusk_callout.find("Route choice:") == dusk_callout.rfind("Route choice:"), "Dusk route memory should stay one compact route-choice line")
	runner._expect_no_echo_lens_locator_language(dusk_callout, "Dusk route choice")
	var dusk_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(dusk_summary.contains("Remembered place: Dusk Trench"), "Dusk extraction summary should include supported remembered-place evidence")
	runner._expect(dusk_summary.contains("Route choice: lower-route research push reached Dusk Trench."), "Dusk extraction summary should include supported route-choice evidence")
	runner._expect(not dusk_summary.contains("map"), "Dusk extraction summary should avoid map language")

	main.run_hollow_reef_reading_recovered = true
	var hollow_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(hollow_callout.contains("Hollow Reef"), "Hollow Reef reading should produce the deepest route-choice callout")
	runner._expect(not hollow_callout.contains("Dusk Trench"), "Hollow Reef route choice should take priority over Dusk reach evidence")
	runner._expect(not hollow_callout.contains("Blackwater"), "Hollow Reef route choice should take priority over Blackwater trace evidence")
	runner._expect_no_echo_lens_locator_language(hollow_callout, "Hollow Reef route choice")
	var hollow_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(hollow_summary.contains("Remembered place: Hollow Reef"), "Hollow Reef extraction summary should include the branch as remembered place")
	runner._expect(hollow_summary.contains("Route choice: lower-route research push reached Hollow Reef."), "Hollow Reef extraction summary should include the highest route-choice evidence")

	main.run_salvage_data_cache_recovered = true
	var save_before_wide_chamber_memory: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var wide_chamber_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(wide_chamber_callout.contains("wide chamber"), "wide chamber salvage evidence should produce the most specific route-choice callout")
	runner._expect(wide_chamber_callout.contains("sealed pocket"), "wide chamber route choice should name the compact salvage lesson")
	runner._expect(not wide_chamber_callout.contains("Hollow Reef"), "wide chamber route choice should take priority over Hollow Reef reading evidence")
	runner._expect(not wide_chamber_callout.contains("Dusk Trench"), "wide chamber route choice should take priority over Dusk reach evidence")
	runner._expect_no_echo_lens_locator_language(wide_chamber_callout, "Wide Reef Chamber route choice")
	var wide_chamber_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(wide_chamber_summary.contains("Remembered place: Wide Reef Chamber"), "wide chamber extraction summary should remember the larger chamber when salvage evidence exists")
	runner._expect(wide_chamber_summary.contains("Route choice: wide chamber salvage cache marked a sealed pocket."), "wide chamber extraction summary should include one compact route-choice line")
	runner._expect(wide_chamber_summary.find("Route choice:") == wide_chamber_summary.rfind("Route choice:"), "wide chamber extraction summary should not duplicate route-choice lines")
	runner._expect(main.progression_state.to_save_data() == save_before_wide_chamber_memory, "wide chamber route memory formatting should not mutate durable progression")
	runner._expect(not main.progression_state.to_save_data().has("wide_reef_chamber_route"), "wide chamber route memory should not create durable route state")
	runner._expect(not main.progression_state.to_save_data().has("recent_route_memory"), "wide chamber route memory should not create durable recent-route state")
	main.run_tideglass_sample_recovered = true
	var tideglass_route_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(tideglass_route_callout.contains("Mirror Kelp Pass"), "Tideglass payoff should produce Mirror Kelp route-choice memory")
	runner._expect(tideglass_route_callout.contains("deeper kelp seal"), "Tideglass route memory should name the compact branch promise")
	runner._expect(not tideglass_route_callout.contains("wide chamber"), "Mirror Kelp payoff should take priority over the upstream wide chamber route")
	runner._expect_no_echo_lens_locator_language(tideglass_route_callout, "Tideglass route choice")
	main.run_tideglass_sample_recovered = false
	main.run_completed_scans = ["mirrorfin_drift"]
	var mirrorfin_route_callout := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(mirrorfin_route_callout.contains("Mirror Kelp"), "Mirrorfin observation should produce Mirror Kelp route-choice memory")
	runner._expect(mirrorfin_route_callout.contains("reflection timing"), "Mirrorfin route memory should name the observation lesson")
	runner._expect(not mirrorfin_route_callout.contains("wide chamber"), "Mirrorfin route memory should take priority over the upstream wide chamber route")
	runner._expect(not mirrorfin_route_callout.to_lower().contains("checklist"), "Mirrorfin route memory should not imply checklist UI")
	runner._expect_no_echo_lens_locator_language(mirrorfin_route_callout, "Mirrorfin route choice")
	main.run_salvage_data_cache_recovered = false
	main.run_hollow_reef_reading_recovered = false
	main.run_reached_dusk_trench = false
	main.run_completed_scans = []

	main.run_completed_scans = ["hollow_reef_skitter"]
	var save_before_hollow_observation: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var hollow_observation_route_choice := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(hollow_observation_route_choice.contains("Hollow Reef"), "Hollow Reef Skitter scan should produce route-choice memory")
	runner._expect(hollow_observation_route_choice.contains("upper-shelf timing"), "Hollow Reef Skitter route-choice memory should name the compact lesson")
	runner._expect(not hollow_observation_route_choice.contains("Dusk Trench"), "Hollow Reef Skitter route choice should be more specific than generic Dusk reach")
	runner._expect(not hollow_observation_route_choice.to_lower().contains("checklist"), "Hollow Reef Skitter route choice should not imply checklist UI")
	runner._expect_no_echo_lens_locator_language(hollow_observation_route_choice, "Hollow Reef Skitter route choice")
	var hollow_observation_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(hollow_observation_summary.contains("Remembered place: Hollow Reef"), "Hollow Reef Skitter extraction summary should remember the side-cave place")
	runner._expect(hollow_observation_summary.contains("Route choice: observed Hollow Reef upper-shelf timing."), "Hollow Reef Skitter extraction summary should include one compact route-choice line")
	runner._expect(hollow_observation_summary.find("Route choice:") == hollow_observation_summary.rfind("Route choice:"), "Hollow Reef Skitter extraction summary should not duplicate route-choice lines")
	var save_after_hollow_observation: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_after_hollow_observation == save_before_hollow_observation, "Hollow Reef route memory formatting should not mutate durable progression")
	runner._expect(not save_after_hollow_observation.has("hollow_reef_route"), "Hollow Reef route memory should not create durable route state")
	runner._expect(not save_after_hollow_observation.has("recent_route_memory"), "Hollow Reef route memory should not create durable recent-route state")
	runner._expect(not save_after_hollow_observation.has("route_graph"), "Hollow Reef route memory should not create route graph state")
	main.run_completed_scans = ["glassfin_swarm"]
	var save_before_glassfin_observation: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var glassfin_route_choice := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin Swarm scan should produce route-choice memory")
	runner._expect(glassfin_route_choice.contains("spacing"), "Glassfin Swarm route-choice memory should name the compact lesson")
	runner._expect(glassfin_route_choice.contains("without fighting"), "Glassfin Swarm route-choice memory should reinforce observation-first creature direction")
	runner._expect(not glassfin_route_choice.to_lower().contains("checklist"), "Glassfin Swarm route choice should not imply checklist UI")
	runner._expect_no_monster_combat_language(glassfin_route_choice, "Glassfin Swarm route choice")
	var glassfin_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(glassfin_summary.contains("Remembered place: Glassfin Swarm Route"), "Glassfin Swarm extraction summary should remember the creature-route place")
	runner._expect(glassfin_summary.contains("Route choice: observed Glassfin Swarm spacing without fighting."), "Glassfin Swarm extraction summary should include one compact route-choice line")
	runner._expect(glassfin_summary.contains("Discovery remembered: Glassfin Swarm"), "Glassfin Swarm extraction summary should include compact discovery memory")
	runner._expect(glassfin_summary.find("Route choice:") == glassfin_summary.rfind("Route choice:"), "Glassfin Swarm extraction summary should not duplicate route-choice lines")
	var save_after_glassfin_observation: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_after_glassfin_observation == save_before_glassfin_observation, "Glassfin Swarm route memory formatting should not mutate durable progression")
	runner._expect(not save_after_glassfin_observation.has("glassfin_swarm_route"), "Glassfin Swarm route memory should not create durable route state")
	runner._expect(not save_after_glassfin_observation.has("monster_journal"), "Glassfin Swarm route memory should not create monster journal state")
	runner._expect(not save_after_glassfin_observation.has("creature_inventory"), "Glassfin Swarm route memory should not create creature inventory state")
	main.run_reached_dusk_trench = true
	var dusk_over_glassfin_route_choice := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(dusk_over_glassfin_route_choice.contains("Dusk Trench"), "Dusk reach evidence should win over Glassfin route-choice memory")
	runner._expect(not dusk_over_glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin route-choice memory should not crowd out Dusk route evidence")
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = true
	var hollow_over_glassfin_route_choice := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(hollow_over_glassfin_route_choice.contains("Hollow Reef"), "Hollow Reef route evidence should win over Glassfin route-choice memory")
	runner._expect(not hollow_over_glassfin_route_choice.contains("Glassfin Swarm"), "Glassfin route-choice memory should not crowd out Hollow Reef route evidence")
	main.run_hollow_reef_reading_recovered = false
	main.run_completed_scans = []

	main.run_blackwater_trace_recovered = false
	main.run_predator_contacts = 0
	main.current_resource_cluster_pattern = "deep_reward"
	main.run_collected_resources = ["glow_plankton"]
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("deep glow"), "deep reward glow cargo should produce a deep push callout")

	main.run_completed_scans = ["wreck_signal_cache"]
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("pressure-wreck progress"), "wreck cache scan should produce a pressure progress callout")

	main.run_predator_contacts = 1
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("predator route"), "predator contact should take priority in the route callout")

	main.run_predator_contacts = 0
	main.run_completed_scans = ["lantern_ray"]
	var lantern_route_choice := SurfaceRunSummaryServiceScript.format_route_choice_callout(main)
	runner._expect(lantern_route_choice.contains("Lantern Ray"), "Lantern Ray scan should produce a route observation callout when no deeper route wins")
	runner._expect_no_monster_combat_language(lantern_route_choice, "Lantern Ray route choice")

	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = []
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Pressure Seal I"), "thermal vent scan should produce a pressure seal route callout")

	main.run_collected_resources = ["glow_plankton"]
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Thermal Vent clue"), "vent scan plus glow cargo should produce a vent route callout")

	var summary := SurfaceRunSummaryServiceScript.format_run_summary(main, "%s\nCompact result line." % SurfaceRunSummaryServiceScript.format_route_choice_callout(main), "extracted")
	runner._expect(summary.contains("Route choice:"), "player-facing result summary should include the route callout")
	runner._expect(summary.find("Route choice:") == summary.rfind("Route choice:"), "player-facing result summary should not duplicate route-choice lines")
	runner._expect(not summary.contains("Playtest data:"), "result summary should not include debug telemetry unless F3 is enabled")
	runner._expect(not summary.contains("Predator route:"), "predator route telemetry should stay hidden unless F3 is enabled")
	runner._expect(not summary.contains("thermal_bloom"), "condition id should stay hidden unless debug telemetry is enabled")

	main.show_debug_telemetry = true
	summary = SurfaceRunSummaryServiceScript.format_run_summary(main, SurfaceRunSummaryServiceScript.format_route_choice_callout(main), "extracted")
	runner._expect(summary.contains("Playtest data:"), "debug telemetry should appear only when enabled")
	runner._expect(summary.contains("Condition: Thermal Bloom (thermal_bloom)"), "debug telemetry should include condition display and id")
	main.free()

func _test_gulper_research_result_callout(runner) -> void:
	var main := MainScript.new()

	runner._expect(ResearchResultCalloutServiceScript.format_gulper_research_callout(main) == "", "Gulper research should stay hidden without evidence")

	main.run_completed_scans = ["gulper_eel"]
	runner._expect(ResearchResultCalloutServiceScript.format_gulper_research_callout(main).contains("Gulper route timing observed"), "Gulper scan should produce a research callout")
	var summary := SurfaceRunSummaryServiceScript.format_run_summary(main, "%s%s" % [SurfaceRunSummaryServiceScript.format_route_choice_callout(main), ResearchResultCalloutServiceScript.format_gulper_research_callout(main)], "extracted")
	runner._expect(summary.contains("Research:"), "player-facing summary should include compact creature research when relevant")
	runner._expect(not summary.contains("Playtest data:"), "creature research should not expose debug telemetry")

	main.run_predator_contacts = 1
	runner._expect(ResearchResultCalloutServiceScript.format_gulper_research_callout(main).contains("warning lane"), "Gulper contact should take priority over scan research")

	main.decoy_pulse_used_this_run = true
	runner._expect(ResearchResultCalloutServiceScript.format_gulper_research_callout(main).contains("Decoy timing"), "Decoy evidence should take priority as a stronger research result")
	main.free()

func _test_research_result_presenter(runner) -> void:
	var empty_state := {
		"run_completed_scans": [],
	}
	runner._expect(ResearchResultPresenterScript.format_gulper_research_callout(empty_state) == "", "empty research state should not create Gulper copy")
	runner._expect(ResearchResultPresenterScript.format_echo_lens_research_callout(empty_state) == "", "empty research state should not create Echo Lens copy")

	var gulper_scan_state := {
		"run_completed_scans": ["gulper_eel"],
	}
	runner._expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_scan_state).contains("Gulper route timing observed"), "Gulper scan should produce scan research copy")
	var gulper_contact_state := {
		"run_completed_scans": ["gulper_eel"],
		"run_predator_contacts": 1,
	}
	runner._expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_contact_state).contains("warning lane"), "Gulper contact should outrank scan research copy")
	var gulper_decoy_state := {
		"decoy_pulse_used_this_run": true,
		"run_completed_scans": ["gulper_eel"],
		"run_predator_contacts": 1,
	}
	runner._expect(ResearchResultPresenterScript.format_gulper_research_callout(gulper_decoy_state).contains("Decoy timing"), "Decoy evidence should outrank contact research copy")

	runner._expect(ResearchResultPresenterScript.format_blue_chimney_research_callout({"run_blue_chimney_draft_reading_recovered": true}).contains("Blue Chimney"), "Blue Chimney payoff should produce research copy")
	runner._expect(ResearchResultPresenterScript.format_salvage_manifest_research_callout({"run_salvage_manifest_recovered": true}).contains("Salvage Manifest"), "Salvage Manifest payoff should produce research copy")
	runner._expect(ResearchResultPresenterScript.format_sealed_shelf_hatch_readiness_callout({"has_echo_lens_upgrade": true}) == "", "sealed hatch lab note should stay hidden without route evidence")
	runner._expect(ResearchResultPresenterScript.format_sealed_shelf_hatch_readiness_callout({
		"has_echo_lens_upgrade": true,
		"run_lower_connector_echo_recovered": true,
	}).contains("Sealed Shelf Hatch"), "sealed hatch lab note should show with Echo Lens and route evidence")
