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

func _test_next_expedition_framing(runner) -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 3

	var prompt := SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("Expedition 4"), "result prompt should point to the next expedition number")
	runner._expect(prompt.contains("Water Filter I"), "result prompt should point to the best known upgrade/material goal")
	runner._expect(prompt.contains("Shell Reef pockets"), "starter resource shortage should point back to a remembered place")
	runner._expect(prompt.contains("Driftwood/Quartz Glass"), "starter resource target should name the missing materials compactly")
	runner._expect(not prompt.to_lower().contains("restart"), "result prompt should avoid raw restart language")

	main.progression_state.banked_resources = {
		"driftwood": 1,
	}
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("Shell Reef pockets"), "partial starter progress should preserve the remembered-place target")
	runner._expect(prompt.contains("Quartz Glass") and not prompt.contains("Driftwood/Quartz Glass"), "partial starter progress should only name the remaining material")

	main.survival_state.food = 0
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("bank Food supply first") and prompt.contains("empty needs cut max oxygen"), "empty base needs should take priority in tomorrow planning")
	runner._expect(SurfaceRunSummaryServiceScript.format_dawn_priority_line(main).contains("bank Food supply first"), "dawn priority should put empty base needs before upgrades")

	main.survival_state.food = 3
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("build Water Filter I in Upgrades"), "ready builds should take priority after critical base needs")
	runner._expect(SurfaceRunSummaryServiceScript.format_dawn_priority_line(main).contains("build Water Filter I in Upgrades"), "dawn priority should name ready builds when critical needs are stable")

	main.progression_state.banked_resources.clear()
	main.survival_state.power = 1
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("bank Power supply soon"), "low base needs should produce a non-critical supply plan")
	runner._expect(SurfaceRunSummaryServiceScript.format_dawn_priority_line(main).contains("bank Power supply soon"), "dawn priority should call out low base needs before route goals")
	main._refresh_carried_tomorrow_intention()
	main.survival_state.power = 3
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("bank Power supply soon"), "next expedition prompt should carry the confirmed night intention into tomorrow")
	runner._expect(SurfaceRunSummaryServiceScript.format_dawn_priority_line(main).contains("bank Power supply soon"), "dawn priority should keep the carried night intention instead of recomputing immediately")
	main.carried_tomorrow_intention = ""

	main.survival_state.power = 3
	main.progression_state.banked_resources.clear()
	main.run_outer_shelf_survey_recovered = true
	prompt = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(prompt.contains("Glass Rim timing") and prompt.contains("Outer Shelf cargo"), "remembered place should produce a broad route plan when needs/builds are stable")
	runner._expect(SurfaceRunSummaryServiceScript.format_dawn_priority_line(main).contains("Outer Shelf cargo"), "dawn priority should preserve broad remembered-route opportunities")

	main.progression_state.current_run_number = 4
	main.survival_state.current_day = 4
	var ready_status := SurfaceRunSummaryServiceScript.format_expedition_ready_status(main)
	runner._expect(ready_status.contains("Day 4 ready"), "ready status should name the prepared survival day")
	runner._expect(ready_status.contains("ocean changed"), "ready status should describe the changed ocean")
	runner._expect(SurfaceResultPresenterScript.format_expedition_ready_status(false, "low_visibility", 4).contains("lower-trench"), "surface presenter should preserve low-visibility ready copy")
	runner._expect(SurfaceResultPresenterScript.format_expedition_day_title("Result: Extraction", false, 5, 5, 4) == "Emergency Week Day 4/5 Result: Extraction", "surface presenter should title completed result days from the completed day")
	runner._expect(SurfaceResultPresenterScript.format_completed_expedition_line("Failure", false, 5, 4) == "Emergency Week Day 4: Failure.", "surface presenter should preserve completed expedition result copy")
	runner._expect(SurfaceResultPresenterScript.format_night_report_block("Night cost paid.").begins_with("Night Report:"), "surface presenter should wrap night reports")
	runner._expect(SurfaceResultPresenterScript.format_daylight_closeout_line(true, 2).contains("after 2 ship offload"), "surface presenter should preserve late nightfall offload copy")
	runner._expect(SurfaceRunSummaryServiceScript.format_expedition_day_title(main, "Ready") == "Emergency Week Day 4/5 Ready", "ready title should show survival day number")
	runner._expect(SurfaceRunSummaryServiceScript.format_expedition_day_title(main, "Result: Extraction") == "Emergency Week Day 4/5 Result: Extraction", "result title should show completed survival day number")
	runner._expect(SurfaceRunSummaryServiceScript.format_completed_expedition_line(main, "Failure") == "Emergency Week Day 4: Failure.", "result summary should name the completed survival day")
	main.free()

func _test_region_memory_result_callout(runner) -> void:
	var main := MainScript.new()

	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Surface Base"), "region memory fallback should preserve safe return framing")

	main.run_collected_resources = ["shell_fragments"]
	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Shell Reef"), "shell cargo should remember Shell Reef")

	main.run_completed_scans = ["thermal_vent"]
	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Thermal Vent Field"), "thermal scan should remember Thermal Vent Field over shell cargo")

	main.run_completed_scans = ["pressure_wreck_signal"]
	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Wreck Shelf"), "pressure wreck scan should remember Wreck Shelf")

	main.run_completed_scans = ["lantern_ray"]
	var lantern_ray_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(lantern_ray_memory.contains("Lantern Ray Route"), "Lantern Ray scan should remember the lower-route creature place")
	runner._expect(lantern_ray_memory.contains("timing lane"), "Lantern Ray memory should point to observation timing rather than combat")
	runner._expect(lantern_ray_memory.contains("Blackwater"), "Lantern Ray memory should preserve broad return-route language")
	runner._expect_no_monster_combat_language(lantern_ray_memory, "Lantern Ray remembered place")
	runner._expect(not lantern_ray_memory.to_lower().contains("field guide"), "Lantern Ray memory should not imply a field-guide UI")
	runner._expect(not lantern_ray_memory.to_lower().contains("checklist"), "Lantern Ray memory should not imply checklist UI")

	main.run_completed_scans.clear()
	main.run_predator_contacts = 1
	runner._expect(SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains("Gulper Route"), "predator evidence should remember Gulper Route as the deepest contested place")
	runner._expect(not SurfaceRunSummaryServiceScript.format_region_memory_callout(main).contains(","), "region memory callout should stay compact and not become a checklist")

	main.run_completed_scans = ["lantern_ray"]
	main.run_reached_dusk_trench = true
	var dusk_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(dusk_memory.contains("Dusk Trench"), "Dusk reach evidence should remember the lower-trench place")
	runner._expect(not dusk_memory.contains("Lantern Ray Route"), "Dusk reach evidence should not be crowded out by Lantern Ray observation")
	runner._expect(dusk_memory.contains("up-left"), "Dusk reach memory should keep broad return language")
	runner._expect(dusk_memory.contains("Blackwater"), "Dusk reach memory should route back through the previous landmark")
	runner._expect(not dusk_memory.contains("coordinate"), "Dusk reach memory should avoid exact-coordinate language")
	runner._expect(not dusk_memory.contains("map"), "Dusk reach memory should avoid map language")
	runner._expect_no_echo_lens_locator_language(dusk_memory, "Dusk Trench remembered place")

	main.run_hollow_reef_reading_recovered = true
	var hollow_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(hollow_memory.contains("Hollow Reef"), "Hollow Reef reading should own the remembered place over Dusk")
	runner._expect(not hollow_memory.contains("Lantern Ray Route"), "Hollow Reef memory should not be crowded out by creature observation")
	runner._expect(hollow_memory.contains("Blackwater"), "Hollow Reef memory should preserve broad return-chain language")
	runner._expect_no_echo_lens_locator_language(hollow_memory, "Hollow Reef remembered place")

	main.run_hollow_reef_reading_recovered = false
	main.run_reached_dusk_trench = false
	main.run_completed_scans = ["hollow_reef_skitter"]
	var hollow_observation_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(hollow_observation_memory.contains("Hollow Reef"), "Hollow Reef Skitter scan should remember the side-cave place")
	runner._expect(hollow_observation_memory.contains("upper-shelf timing"), "Hollow Reef Skitter memory should say what was learned compactly")
	runner._expect(hollow_observation_memory.contains("Blackwater"), "Hollow Reef Skitter memory should preserve broad return-route language")
	runner._expect(not hollow_observation_memory.contains("Lantern Ray Route"), "Hollow Reef Skitter memory should not reuse Lantern Ray route language")
	runner._expect(not hollow_observation_memory.to_lower().contains("checklist"), "Hollow Reef Skitter memory should not imply checklist UI")
	runner._expect(not hollow_observation_memory.to_lower().contains("field guide"), "Hollow Reef Skitter memory should not imply field-guide UI")
	runner._expect_no_echo_lens_locator_language(hollow_observation_memory, "Hollow Reef Skitter remembered place")

	main.run_reached_dusk_trench = true
	var hollow_observation_over_dusk := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(hollow_observation_over_dusk.contains("Hollow Reef"), "Hollow Reef observation should take priority over generic Dusk reach memory")
	runner._expect(not hollow_observation_over_dusk.contains("Dusk Trench -"), "Hollow Reef observation should not collapse back to generic Dusk memory")
	main.run_reached_dusk_trench = false
	main.run_completed_scans = ["glassfin_swarm"]
	var glassfin_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(glassfin_memory.contains("Glassfin Swarm"), "Glassfin Swarm scan should remember the creature-route place")
	runner._expect(glassfin_memory.contains("spacing window"), "Glassfin Swarm memory should say what was learned compactly")
	runner._expect(glassfin_memory.contains("Hollow Reef"), "Glassfin Swarm memory should preserve broad return-route language")
	runner._expect_no_monster_combat_language(glassfin_memory, "Glassfin Swarm remembered place")
	runner._expect(not glassfin_memory.to_lower().contains("field guide"), "Glassfin Swarm memory should not imply field-guide UI")
	runner._expect(not glassfin_memory.to_lower().contains("checklist"), "Glassfin Swarm memory should not imply checklist UI")
	main.run_reached_dusk_trench = true
	var dusk_over_glassfin := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(dusk_over_glassfin.contains("Dusk Trench"), "Dusk reach evidence should take priority over Glassfin observation")
	runner._expect(not dusk_over_glassfin.contains("Glassfin Swarm"), "Glassfin observation should not crowd out Dusk route evidence")
	main.run_reached_dusk_trench = false
	main.run_hollow_reef_reading_recovered = true
	var hollow_over_glassfin := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(hollow_over_glassfin.contains("Hollow Reef"), "Hollow Reef route evidence should take priority over Glassfin observation")
	runner._expect(not hollow_over_glassfin.contains("Glassfin Swarm"), "Glassfin observation should not crowd out Hollow Reef route evidence")
	main.run_tideglass_sample_recovered = true
	var mirror_kelp_memory := SurfaceRunSummaryServiceScript.format_region_memory_callout(main)
	runner._expect(mirror_kelp_memory.contains("Mirror Kelp Pass"), "Mirror Kelp payoff should remember the branch place")
	runner._expect(mirror_kelp_memory.contains("Wide Reef"), "Mirror Kelp memory should preserve broad return-route language")
	runner._expect(mirror_kelp_memory.contains("Hollow Reef"), "Mirror Kelp memory should preserve the lower-route return chain")
	runner._expect(not mirror_kelp_memory.to_lower().contains("checklist"), "Mirror Kelp memory should not imply checklist UI")
	runner._expect(not mirror_kelp_memory.to_lower().contains("map"), "Mirror Kelp memory should not imply map UI")
	runner._expect_no_echo_lens_locator_language(mirror_kelp_memory, "Mirror Kelp remembered place")
	main.free()

func _test_discovery_memory_result_callout(runner) -> void:
	var main := MainScript.new()

	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main) == "", "discovery memory should stay hidden when no first-time major discovery happened")

	main.run_completed_scans = ["shell_reef_shelf"]
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("Shell Reef Shelf"), "shell reef first scan should produce discovery memory")

	main.run_completed_scans = ["shell_reef_shelf", "thermal_vent"]
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("Thermal Vent"), "thermal first scan should take priority over shell reef")

	main.run_completed_scans = ["thermal_vent", "gulper_eel"]
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("Gulper Eel"), "gulper first scan should produce creature research memory")

	main.run_completed_scans = ["lantern_ray"]
	var lantern_ray_discovery_memory := SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main)
	runner._expect(lantern_ray_discovery_memory.contains("Lantern Ray"), "Lantern Ray first scan should produce creature observation memory")
	runner._expect(lantern_ray_discovery_memory.contains("without fighting"), "Lantern Ray discovery memory should frame observation as non-combat")
	runner._expect_no_monster_combat_language(lantern_ray_discovery_memory, "Lantern Ray discovery memory")
	runner._expect(not lantern_ray_discovery_memory.to_lower().contains("field guide"), "Lantern Ray discovery memory should not imply a field-guide UI")
	runner._expect(not lantern_ray_discovery_memory.to_lower().contains("checklist"), "Lantern Ray discovery memory should not imply checklist UI")

	main.run_completed_scans = ["glassfin_swarm"]
	var glassfin_discovery_memory := SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main)
	runner._expect(glassfin_discovery_memory.contains("Glassfin Swarm"), "Glassfin Swarm first scan should produce creature observation memory")
	runner._expect(glassfin_discovery_memory.contains("spacing"), "Glassfin Swarm discovery memory should name the spacing lesson")
	runner._expect(glassfin_discovery_memory.contains("without fighting"), "Glassfin Swarm discovery memory should frame observation as non-combat")
	runner._expect_no_monster_combat_language(glassfin_discovery_memory, "Glassfin Swarm discovery memory")
	runner._expect(not glassfin_discovery_memory.to_lower().contains("field guide"), "Glassfin Swarm discovery memory should not imply a field-guide UI")
	runner._expect(not glassfin_discovery_memory.to_lower().contains("checklist"), "Glassfin Swarm discovery memory should not imply checklist UI")

	main.run_completed_scans = ["pressure_wreck_signal", "wreck_signal_cache", "wreck_signal_cache"]
	var memory := SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main)
	runner._expect(memory.contains("Wreck Signal Cache"), "cache first scan should take priority over outside wreck signal")
	runner._expect(memory.find("Wreck Signal Cache") == memory.rfind("Wreck Signal Cache"), "discovery memory should not duplicate repeated ids")
	runner._expect(not memory.contains(","), "discovery memory should stay compact and not become a checklist")
	main.free()

func _test_route_memory_presenter(runner) -> void:
	var empty_state := {
		"run_completed_scans": [],
		"run_collected_resources": [],
	}
	runner._expect(RouteMemoryPresenterScript.format_route_choice_callout(empty_state) == "", "route presenter should keep empty route choice quiet")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(empty_state) == "none", "route presenter should report no route memory for empty runs")
	runner._expect(RouteMemoryPresenterScript.format_region_memory_callout(empty_state).contains("Surface Base"), "route presenter should preserve surface-base fallback")
	runner._expect(RouteMemoryPresenterScript.format_discovery_memory_callout(empty_state) == "", "route presenter should keep discovery memory quiet without scans")

	var shell_state := {
		"run_completed_scans": [],
		"run_collected_resources": ["shell_fragments"],
	}
	runner._expect(RouteMemoryPresenterScript.format_route_choice_callout(shell_state).contains("Shell Reef"), "shell cargo should still produce the Shell Reef route callout")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(shell_state) == "Shell Reef", "shell cargo should still produce Shell Reef recent memory")

	var glass_rim_state := {
		"run_completed_scans": ["glass_ray_drifter"],
		"run_collected_resources": [],
	}
	runner._expect(RouteMemoryPresenterScript.format_route_choice_callout(glass_rim_state).contains("Glass Ray slackwater timing"), "Glass Ray observation should drive route-choice memory")
	runner._expect(RouteMemoryPresenterScript.format_region_memory_callout(glass_rim_state).contains("Outer Shelf"), "Glass Ray observation should remember Outer Shelf")
	runner._expect(RouteMemoryPresenterScript.format_discovery_memory_callout(glass_rim_state).contains("Glass Ray Drifter"), "Glass Ray observation should produce discovery memory")

	var blackwater_state := {
		"run_blackwater_trace_recovered": true,
		"run_blue_chimney_draft_reading_recovered": true,
		"run_completed_scans": ["thermal_vent"],
		"run_collected_resources": ["shell_fragments"],
	}
	runner._expect(RouteMemoryPresenterScript.format_route_choice_callout(blackwater_state).contains("Blackwater"), "Blackwater payoff should win route-choice priority")
	runner._expect(RouteMemoryPresenterScript.format_recent_route_memory(blackwater_state) == "Blackwater", "Blackwater payoff should win recent route memory")

func _test_run_memory_state_service(runner) -> void:
	var main := MainScript.new()
	main.current_resource_cluster_pattern = "cautious"
	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = ["shell_fragments"]
	main.run_blackwater_trace_recovered = true
	main.run_predator_contacts = 2
	main.run_reached_dusk_trench = true

	var route_state := RunMemoryStateServiceScript.route_memory_state(main)
	runner._expect(route_state.get("current_resource_cluster_pattern") == "cautious", "run memory state service should preserve resource cluster pattern")
	runner._expect(route_state.get("run_completed_scans") == ["thermal_vent"], "run memory state service should preserve scan ids")
	runner._expect(route_state.get("run_collected_resources") == ["shell_fragments"], "run memory state service should preserve collected resources")
	runner._expect(route_state.get("run_blackwater_trace_recovered") == true, "run memory state service should preserve route research flags")
	runner._expect(route_state.get("run_predator_contacts") == 2, "run memory state service should preserve predator contact count")
	runner._expect(route_state.get("run_reached_dusk_trench") == true, "run memory state service should preserve region reach flags")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.decoy_pulse_used_this_run = true
	main.run_echo_lens_echo_fired = true
	main.run_wreck_echo_clue_recovered = true
	main.run_glass_kelp_reading_recovered = true
	var research_state := RunMemoryStateServiceScript.research_result_state(main)
	runner._expect(research_state.get("has_echo_lens_upgrade") == true, "run memory state service should preserve Echo Lens ownership state")
	runner._expect(research_state.get("decoy_pulse_used_this_run") == true, "run memory state service should preserve decoy pulse usage")
	runner._expect(research_state.get("run_echo_lens_echo_fired") == true, "run memory state service should preserve Echo Lens echo state")
	runner._expect(research_state.get("run_wreck_echo_clue_recovered") == true, "run memory state service should preserve wreck echo clue state")
	runner._expect(research_state.get("run_glass_kelp_reading_recovered") == true, "run memory state service should preserve glass kelp reading state")
	main.free()
