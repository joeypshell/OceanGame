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

func _test_prompt_formatter_guard_coverage(runner) -> void:
	var main := MainScript.new()
	var interact_label: String = main._action_label("interact")
	var interact_words := interact_label.replace("/", " or ")
	var restart_label: String = main._action_label("restart_dive")
	var horizontal_label: String = main._action_label("move_left_right")
	var vertical_label: String = main._action_label("move_up_down")
	var slate_label: String = main._action_label("expedition_slate")
	var burst_label: String = main._action_label("burst_thruster")
	var decoy_label: String = main._action_label("decoy_pulse")

	runner._expect(SurfaceRunSummaryServiceScript.format_ready_panel_summary(main).contains("%s begins." % interact_label), "ready summary should derive its start label from the prompt helper")
	runner._expect(UpgradeStateServiceScript.format_upgrade_menu_title(2, 7, main._action_label("move_up_down")).contains("%s select" % vertical_label), "upgrade title should derive selection labels from the prompt helper")
	runner._expect(SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main).contains("press %s" % restart_label), "next expedition prompt should derive restart labels from the prompt helper")
	runner._expect(UpgradeStateServiceScript.format_burst_thruster_prompt(main).begins_with("%s burst" % burst_label), "burst prompt should derive its label from the prompt helper")
	runner._expect(ExpeditionSlatePresenterScript.format_slate_text_for_host(main).contains("%s closes" % slate_label), "expedition slate should derive its close label from the prompt helper")
	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main) == "%s: decoy ready" % decoy_label, "decoy prompt should derive its ready label from the prompt helper")
	main.dive_session.reset(main.max_oxygen)
	runner._expect(main._format_hud_prompt() == "Press %s to begin the dive" % interact_words, "ready HUD prompt should derive interact wording from the prompt helper")

	main.dive_session.extract()
	main.surface_tab_index = main.SURFACE_TAB_RESULT
	var result_prompt := main._format_hud_prompt()
	runner._expect(result_prompt.contains("press %s for upgrades" % interact_label), "result HUD prompt should derive upgrade-open labels from the prompt helper")
	runner._expect(result_prompt.contains("%s next expedition" % restart_label), "result HUD prompt should derive restart labels from the prompt helper")
	runner._expect(result_prompt.contains("%s surface view" % horizontal_label), "result HUD prompt should derive surface-tab labels from the prompt helper")

	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	var upgrade_prompt := main._format_hud_prompt()
	runner._expect(upgrade_prompt.contains("%s select" % vertical_label), "upgrade HUD prompt should derive selection labels from the prompt helper")
	runner._expect(upgrade_prompt.contains("%s purchase" % interact_label), "upgrade HUD prompt should derive purchase labels from the prompt helper")

	main.dive_session.fail()
	runner._expect(main._format_hud_prompt().contains("press %s for next expedition" % restart_label), "failure HUD prompt should derive restart labels from the prompt helper")
	main.free()

func _test_condition_presenter(runner) -> void:
	runner._expect(ConditionPresenterScript.format_cluster_pattern("cautious") == "Cautious shallows", "condition presenter should name cautious resource routes")
	runner._expect(ConditionPresenterScript.format_cluster_pattern("deep_reward") == "Deep reward route", "condition presenter should name deep reward resource routes")
	runner._expect(ConditionPresenterScript.format_cluster_pattern("custom") == "custom", "condition presenter should preserve unknown cluster pattern ids")
	runner._expect(ConditionPresenterScript.format_condition_telemetry({}) == "none", "condition telemetry should report no active condition compactly")
	var condition := {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
	}
	runner._expect(ConditionPresenterScript.format_condition_telemetry(condition) == "Thermal Bloom (thermal_bloom)", "condition telemetry should preserve display name and id")
	runner._expect(ConditionPresenterScript.format_condition_briefing({}, false) == "Today: no unusual activity.", "empty condition briefing should preserve neutral copy")
	var fallback := ConditionPresenterScript.format_condition_briefing({
		"id": "new_current",
		"display_name": "New Current",
		"briefing": "A test briefing remains visible.",
	}, false)
	runner._expect(fallback.contains("Today: New Current."), "unknown condition briefing should still frame the display name")
	runner._expect(fallback.contains("A test briefing remains visible."), "unknown condition briefing should preserve authored briefing copy")
	runner._expect(ConditionPresenterScript.format_condition_briefing(condition, false).contains("Vent-warmed routes"), "condition presenter should own condition-specific briefing copy")

func _test_condition_briefing_copy(runner) -> void:
	var main := MainScript.new()
	var condition := {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
		"tags": ["thermal", "scan"],
	}

	var briefing := ConditionPresenterScript.format_condition_briefing(condition, false)
	runner._expect(briefing.contains("Today: Thermal Bloom."), "condition briefing should frame the day condition as today's ocean change")
	runner._expect(briefing.contains("Vent-warmed routes may point toward extra glow."), "thermal briefing should name the implemented vent/glow route cue")
	runner._expect(not briefing.contains("thermal_bloom"), "condition briefing should not expose raw condition ids")
	runner._expect(not briefing.to_lower().contains("procedural"), "condition briefing should not imply unimplemented generation systems")

	condition = {
		"id": "kelp_bloom",
		"display_name": "Kelp Bloom",
		"briefing": "Shallow growth is unusually thick.",
		"tags": ["resource", "shallow"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	runner._expect(briefing.contains("Mirror Kelp"), "kelp briefing should point at the implemented Mirror Kelp route variation")
	runner._expect(briefing.contains("shimmer breaks"), "kelp briefing should tell players how to read the denser route")
	runner._expect(not briefing.contains("kelp_bloom"), "kelp briefing should not expose raw condition ids")

	condition = {
		"id": "predator_migration",
		"display_name": "Predator Migration",
		"briefing": "Deep patrols are shifting.",
		"tags": ["predator", "route"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	runner._expect(briefing.contains("Gulper route"), "predator briefing should point to the existing predator route")
	runner._expect(briefing.contains("warning cues"), "predator briefing should point to existing readable cues")

	condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	runner._expect(briefing.to_lower().contains("lower-trench"), "low-visibility briefing should nudge broad lower-trench route caution")
	runner._expect(briefing.contains("bank early"), "low-visibility briefing should keep the player-visible advice compact")
	runner._expect(not briefing.contains("Dusk Trench"), "low-visibility briefing should not reveal the exact trench location")
	runner._expect(not briefing.contains("Blackwater"), "low-visibility briefing should not reveal the gated route chain")
	runner._expect_no_echo_lens_locator_language(briefing, "low-visibility briefing")

	condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["scan", "rare"],
	}
	briefing = ConditionPresenterScript.format_condition_briefing(condition, false)
	runner._expect(briefing.contains("East Shelf"), "rare signal briefing should point at the implemented side-route opportunity")
	runner._expect(briefing.contains("Blue Chimney"), "rare signal briefing should point at the lower-pocket opportunity")
	runner._expect(not briefing.contains("Blackwater"), "rare signal briefing should not point at Blackwater before Resonance Key I ownership")
	runner._expect(briefing.contains("if oxygen allows"), "rare signal briefing should keep route pings optional")
	runner._expect_no_echo_lens_locator_language(briefing, "rare signal briefing")
	runner._expect(main.call("_rare_signal_emphasis_visible_for_condition", "rare_signal"), "Rare Signal should enable the subtle signal emphasis")
	runner._expect(not main.call("_rare_signal_emphasis_visible_for_condition", "wreck_shift"), "Wreck Shift should not enable Rare Signal emphasis")
	runner._expect(not main.call("_rare_signal_emphasis_visible_for_condition", "thermal_bloom"), "Thermal Bloom should keep Rare Signal emphasis hidden")
	runner._expect(main.call("_shelf_glimmer_visible_for_condition", "rare_signal"), "Rare Signal should enable the Shelf Glimmer side-route opportunity")
	runner._expect(not main.call("_shelf_glimmer_visible_for_condition", "calm_current"), "Calm Current should not enable the Shelf Glimmer opportunity")
	runner._expect(main.call("_blue_chimney_signal_visible_for_condition", "rare_signal"), "Rare Signal should enable the Blue Chimney lower-pocket opportunity")
	runner._expect(not main.call("_blue_chimney_signal_visible_for_condition", "calm_current"), "Calm Current should not enable the Blue Chimney signal")
	runner._expect(not main.call("_blackwater_signal_visible_for_condition", "rare_signal"), "Rare Signal should not enable Blackwater signal before the scoped key path is ready")
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	briefing = ConditionPresenterScript.format_condition_briefing(condition, main.progression_state.has_upgrade(ResonanceKeyUpgrade.id))
	runner._expect(briefing.contains("Blackwater"), "rare signal briefing should nudge Blackwater once Resonance Key I is owned")
	runner._expect(briefing.contains("if oxygen allows"), "Blackwater rare signal briefing should remain optional")
	runner._expect_no_echo_lens_locator_language(briefing, "Blackwater rare signal briefing")
	runner._expect(main.call("_blackwater_signal_visible_for_condition", "rare_signal"), "Rare Signal should enable Blackwater signal when the route gate is ready")
	runner._expect(not main.call("_blackwater_signal_visible_for_condition", "calm_current"), "Calm Current should not enable Blackwater signal")
	var blackwater_scene := MainScene.instantiate()
	blackwater_scene.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	blackwater_scene.progression_state.banked_resources["glow_plankton"] = 2
	blackwater_scene.dive_session.reset(30.0)
	blackwater_scene.dive_session.start()
	blackwater_scene.dive_session.oxygen = 23.0
	blackwater_scene.dive_session.current_cargo = ["kelp_fiber"]
	blackwater_scene.dive_session.has_left_base = true
	blackwater_scene.player_in_base = false
	blackwater_scene.run_predator_contacts = 1
	blackwater_scene.call("_sync_blackwater_crack_gate_state")
	var blackwater_signal := blackwater_scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity") as Node2D
	blackwater_scene.call("_sync_blackwater_signal_opportunity", "rare_signal")
	runner._expect(blackwater_signal.visible, "Rare Signal should show a subtle Blackwater signal nudge when the route is ready")
	runner._expect(is_equal_approx(blackwater_scene.dive_session.oxygen, 23.0), "Blackwater condition nudge should not drain oxygen")
	runner._expect(blackwater_scene.dive_session.current_cargo == ["kelp_fiber"], "Blackwater condition nudge should not change carried cargo")
	runner._expect(blackwater_scene.dive_session.result == DiveSessionScript.Result.DIVING, "Blackwater condition nudge should not change dive state")
	runner._expect(blackwater_scene.dive_session.has_left_base, "Blackwater condition nudge should not reset extraction eligibility")
	runner._expect(not blackwater_scene.player_in_base, "Blackwater condition nudge should not move the player into base")
	runner._expect(blackwater_scene.run_predator_contacts == 1, "Blackwater condition nudge should not create predator contacts")
	runner._expect(blackwater_scene.progression_state.resource_count("glow_plankton") == 2, "Blackwater condition nudge should not mutate banked resources")
	runner._expect(blackwater_scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Blackwater condition nudge should not mutate key ownership")
	blackwater_scene.call("_sync_blackwater_signal_opportunity", "calm_current")
	runner._expect(not blackwater_signal.visible, "non-Rare-Signal conditions should hide the Blackwater signal nudge")
	blackwater_scene.free()
	var scene := MainScene.instantiate()
	var safe_bank_lane := scene.get_node("RouteChoiceBand/SafeBankLane") as Polygon2D
	var research_lane := scene.get_node("RouteChoiceBand/ResearchLane") as Polygon2D
	var decision_rib := scene.get_node("RouteChoiceBand/DecisionRib") as Polygon2D
	scene.call("_sync_route_choice_condition_nudge", "rare_signal")
	runner._expect(research_lane.color.a > 0.24, "Rare Signal should visibly nudge the research route lane")
	runner._expect(safe_bank_lane.color.a >= 0.14, "Rare Signal should keep the safe bank route visible")
	runner._expect(decision_rib.color.a <= 0.26, "Rare Signal route-choice rib should stay a soft suggestion")
	scene.call("_sync_route_choice_condition_nudge", "calm_current")
	runner._expect(research_lane.color.a <= 0.21, "non-Rare-Signal conditions should restore the neutral route choice lane")
	runner._expect(safe_bank_lane.color.a >= 0.17, "neutral route-choice visuals should preserve the safe bank lane")
	scene.free()
	main.free()

func _test_dusk_trench_low_visibility_condition_nudge(runner) -> void:
	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	var veil := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D
	var band := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand") as Polygon2D
	var rib_a := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA") as Polygon2D
	var return_current := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/ReturnCurrentUpLeft") as Polygon2D
	scene.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	scene.call("_sync_dusk_trench_condition_nudge", "calm_current")
	var neutral_veil_alpha := veil.color.a
	var neutral_band_alpha := band.color.a
	var neutral_rib_alpha := rib_a.color.a

	scene.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(4)
	scene.call("_sync_dusk_trench_condition_nudge", "low_visibility")
	runner._expect(scene._current_condition_id() == "low_visibility", "test seed should select Low Visibility")
	runner._expect(veil.color.a > neutral_veil_alpha, "Low Visibility should visibly strengthen Dusk Trench murk")
	runner._expect(band.color.a > neutral_band_alpha, "Low Visibility should strengthen the Dusk Trench silt band")
	runner._expect(rib_a.color.a > neutral_rib_alpha, "Low Visibility should strengthen Dusk Trench timing ribs")
	runner._expect(veil.color.b > veil.color.g, "Low Visibility Dusk nudge should keep blue-violet pressure language")
	runner._expect(return_current.color.g > veil.color.g, "Low Visibility Dusk nudge should preserve green return-current readability")
	var ready_status: String = scene.call("_format_expedition_ready_status")
	runner._expect(ready_status.contains("lower-trench"), "ready status should acknowledge the low-visibility trench nudge")
	runner._expect(not ready_status.contains("Dusk Trench"), "ready status should not reveal exact Dusk location")
	var saved: Dictionary = scene.progression_state.to_save_data()
	runner._expect(not saved.has("current_expedition_condition"), "Low Visibility should not save active condition state")
	runner._expect(not saved.has("low_visibility"), "Low Visibility should not add durable save state")
	runner._expect(not saved.has("dusk_trench_condition"), "Dusk condition nudge should not add durable route state")
	scene.queue_free()

func _test_wide_chamber_calm_current_condition_nudge(runner) -> void:
	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	var return_main := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var return_far := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib") as Polygon2D
	var return_mid := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain") as Polygon2D
	var return_entry := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain") as Polygon2D
	scene.dive_session.reset(30.0)
	scene.dive_session.start()
	scene.dive_session.oxygen = 19.0
	scene.dive_session.current_cargo = ["shell_fragments"]
	scene.dive_session.has_left_base = true
	scene.player_in_base = false
	scene.run_predator_contacts = 1
	scene.progression_state.banked_resources["glow_plankton"] = 2
	scene.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true

	scene.current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	scene.call("_sync_wide_chamber_condition_nudge", "calm_current")
	var calm_main_alpha := return_main.color.a
	var calm_far_alpha := return_far.color.a
	var calm_mid_alpha := return_mid.color.a
	var calm_entry_alpha := return_entry.color.a
	runner._expect(calm_main_alpha >= 0.16 and calm_main_alpha <= 0.18, "Calm Current should subtly strengthen the Wide Reef Chamber main return current")
	runner._expect(calm_far_alpha >= 0.16 and calm_far_alpha <= 0.18, "Calm Current should strengthen the far chamber return rib without becoming objective-bright")
	runner._expect(calm_mid_alpha >= 0.13 and calm_mid_alpha <= 0.15, "Calm Current should strengthen the mid chamber return chain without adding clutter")
	runner._expect(calm_entry_alpha >= 0.15 and calm_entry_alpha <= 0.17, "Calm Current should strengthen the entry return chain without adding clutter")
	runner._expect(return_main.color.g > return_main.color.r and return_mid.color.g > return_mid.color.r, "Wide chamber condition nudge should preserve safe-current color language")

	scene.call("_sync_wide_chamber_condition_nudge", "rare_signal")
	runner._expect(return_main.color.a < calm_main_alpha, "non-Calm-Current conditions should restore neutral Wide Reef Chamber main return current")
	runner._expect(return_far.color.a < calm_far_alpha, "non-Calm-Current conditions should restore neutral far return rib")
	runner._expect(return_mid.color.a < calm_mid_alpha, "non-Calm-Current conditions should restore neutral mid return chain")
	runner._expect(return_entry.color.a < calm_entry_alpha, "non-Calm-Current conditions should restore neutral entry return chain")
	runner._expect(is_equal_approx(scene.dive_session.oxygen, 19.0), "Wide chamber condition nudge should not drain oxygen")
	runner._expect(scene.dive_session.current_cargo == ["shell_fragments"], "Wide chamber condition nudge should not change carried cargo")
	runner._expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "Wide chamber condition nudge should not change dive state")
	runner._expect(scene.dive_session.has_left_base, "Wide chamber condition nudge should not reset extraction eligibility")
	runner._expect(not scene.player_in_base, "Wide chamber condition nudge should not move the player into base")
	runner._expect(scene.run_predator_contacts == 1, "Wide chamber condition nudge should not create predator contacts")
	runner._expect(scene.progression_state.resource_count("glow_plankton") == 2, "Wide chamber condition nudge should not mutate banked resources")
	runner._expect(scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Wide chamber condition nudge should not mutate upgrade ownership")
	var saved: Dictionary = scene.progression_state.to_save_data()
	runner._expect(not saved.has("wide_chamber_condition"), "Wide chamber condition nudge should not add durable save state")
	runner._expect(not saved.has("calm_current"), "Calm Current chamber variation should not save active condition state")
	scene.queue_free()
