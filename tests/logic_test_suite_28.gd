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

func _test_upgrade_bay_readability_states(runner) -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		EchoLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
	]

	var state := UpgradeStateServiceScript.format_upgrade_state(main, OxygenTankUpgrade)
	runner._expect(state.begins_with("State: Missing resources"), "upgrade bay should label unaffordable upgrades")
	runner._expect(state.contains("Needs: Glow Plankton x1"), "upgrade bay should show missing resources inline")

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, OxygenTankUpgrade)
	runner._expect(state.begins_with("State: Available now"), "upgrade bay should label affordable upgrades")
	runner._expect(UpgradeStateServiceScript.format_ready_upgrade_callout(main).contains("Oxygen Tank I"), "upgrade bay should call out newly ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	state = UpgradeStateServiceScript.format_upgrade_state(main, OxygenTankUpgrade)
	runner._expect(state.begins_with("State: Owned"), "upgrade bay should label owned upgrades")

	state = UpgradeStateServiceScript.format_upgrade_state(main, WaterFilterUpgrade)
	runner._expect(state.begins_with("State: Missing resources"), "Water Filter I should show missing starter resources")
	runner._expect(state.contains("Driftwood x1"), "Water Filter I should name missing driftwood")
	runner._expect(state.contains("Quartz Glass x1"), "Water Filter I should name missing quartz glass")
	var missing_scene := MainScene.instantiate()
	runner.root.add_child(missing_scene)
	missing_scene.dive_session.extract()
	missing_scene.surface_tab_index = missing_scene.SURFACE_TAB_UPGRADES
	missing_scene.selected_upgrade_index = 0
	missing_scene.call("_try_purchase_selected_upgrade")
	runner._expect(missing_scene.upgrade_menu_feedback.contains("Missing Driftwood x1, Quartz Glass x1"), "missing Water Filter feedback should name starter material shortage")
	runner._expect(missing_scene.upgrade_menu_feedback.contains("Next: bank it for Water Filter I."), "missing Water Filter feedback should turn shortage into a tomorrow plan")
	missing_scene.queue_free()
	var starter_goal := ExpeditionGoalFormatterScript.format_goal(main.progression_state, [WaterFilterUpgrade])
	runner._expect(starter_goal.contains("Driftwood x1") and starter_goal.contains("Quartz Glass x1"), "ready goal should display starter resource names for Water Filter I")
	main.progression_state.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, WaterFilterUpgrade)
	runner._expect(state.begins_with("State: Available now"), "Water Filter I should become available after starter resources are banked")
	var water_before := main.survival_state.water
	runner._expect(UpgradePurchaseScript.purchase(main.progression_state, WaterFilterUpgrade), "Water Filter I should purchase through the normal upgrade pipeline")
	main.call("_apply_upgrade_effect", WaterFilterUpgrade.effect_id)
	runner._expect(main.survival_state.water == water_before + 1, "Water Filter I effect should add one water reserve")
	state = UpgradeStateServiceScript.format_upgrade_state(main, WaterFilterUpgrade)
	runner._expect(state.begins_with("State: Owned"), "Water Filter I should show owned after purchase")

	state = UpgradeStateServiceScript.format_upgrade_state(main, PressureSealUpgrade)
	runner._expect(state.begins_with("State: Locked by scan"), "upgrade bay should label scan-locked upgrades")
	runner._expect(state.contains("Scan: Thermal Vent"), "upgrade bay should name missing discoveries")

	state = UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade)
	runner._expect(state.begins_with("State: Locked by scan"), "upgrade bay should label Echo Lens I scan-locked before Wreck Signal Cache")
	runner._expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I state should distinguish it from Signal Lens I without locator language")

	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks scanner tuning.")
	state = UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade)
	runner._expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label Echo Lens I as upgrade-locked before Signal Lens I")
	runner._expect(state.contains("Install: Signal Lens I"), "upgrade bay should name Signal Lens I as the Echo Lens prerequisite")
	runner._expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I locked-upgrade state should keep its compact role hint")

	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade)
	runner._expect(state.begins_with("State: Missing resources"), "upgrade bay should label Echo Lens I missing resources after prerequisites are met")
	runner._expect(state.contains("Needs: Glow Plankton x1"), "Echo Lens I missing-resource state should show only remaining cost")
	runner._expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I missing-resource state should keep its compact role hint")

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade)
	runner._expect(state.begins_with("State: Available now"), "upgrade bay should label Echo Lens I available after prerequisites and resources are ready")
	runner._expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I available state should keep its compact role hint")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	state = UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade)
	runner._expect(state.begins_with("State: Owned"), "upgrade bay should label Echo Lens I owned after purchase")
	runner._expect(state.contains("Role: broad wreck echoes, not a locator."), "Echo Lens I owned state should keep its compact role hint")

	state = UpgradeStateServiceScript.format_upgrade_state(main, ResonanceKeyUpgrade)
	runner._expect(state.begins_with("State: Needs route research"), "Resonance Key I should ask for route research after Echo Lens I is owned")
	runner._expect(state.contains("Recover: East Shelf or Drop Echo"), "Resonance Key I should name the broad route-research requirement")
	runner._expect(state.contains("Effect: opens East Shelf hatch only."), "Resonance Key I should keep hatch-specific effect copy")
	runner._expect_no_echo_lens_locator_language(state, "Resonance Key I route-research state")

	main.progression_state.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"shell_fragments": 1,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, ResonanceKeyUpgrade)
	runner._expect(state.begins_with("State: Missing resources"), "Resonance Key I should show missing resources after prerequisites are met")
	runner._expect(state.contains("Needs: Glow Plankton x1"), "Resonance Key I should show only missing glow plankton")
	runner._expect_no_echo_lens_locator_language(state, "Resonance Key I missing-resource state")

	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"shell_fragments": 1,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, ResonanceKeyUpgrade)
	runner._expect(state.begins_with("State: Available now"), "Resonance Key I should become available after route context and resources")
	runner._expect_no_echo_lens_locator_language(state, "Resonance Key I available state")

	main.progression_state.purchase_upgrade(ResonanceKeyUpgrade.id, ResonanceKeyUpgrade.resource_cost)
	state = UpgradeStateServiceScript.format_upgrade_state(main, ResonanceKeyUpgrade)
	runner._expect(state.begins_with("State: Owned"), "Resonance Key I should show owned state after purchase")
	runner._expect(state.contains("Effect: opens East Shelf hatch only."), "Resonance Key I owned state should stay hatch-specific")
	runner._expect_no_echo_lens_locator_language(state, "Resonance Key I owned state")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	state = UpgradeStateServiceScript.format_upgrade_state(main, DecoyPulseUpgrade)
	runner._expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label upgrade-locked upgrades")
	runner._expect(state.contains("Install: Predator Warning I"), "upgrade bay should name missing upgrade prerequisites")

	main.progression_state.purchased_upgrades[PredatorWarningUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	state = UpgradeStateServiceScript.format_upgrade_state(main, DecoyPulseUpgrade)
	runner._expect(state.begins_with("State: Available now"), "Decoy Pulse I should become available after discovery, prerequisite upgrade, and resources")

	main.progression_state.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	state = UpgradeStateServiceScript.format_upgrade_state(main, DecoyPulseUpgrade)
	runner._expect(state.begins_with("State: Owned"), "upgrade bay should label Decoy Pulse I owned after purchase")
	runner._expect(UpgradeStateServiceScript.format_upgrade_effect_summary(EchoLensUpgrade).contains("not a locator"), "Echo Lens I compact effect summary should preserve no-locator wording")
	var feedback := UpgradeStateServiceScript.format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.")
	runner._expect(feedback == "Banked 3 resource(s).\nNo upgrade ready yet.", "upgrade panel feedback should compact deposit copy")
	runner._expect_lines_within(feedback, 72, "compacted upgrade feedback")

	main.run_salvage_data_cache_recovered = true
	var promised_feedback := UpgradeStateServiceScript.format_upgrade_panel_feedback("Deposited 3 resource(s) into the bank.\nNo upgrade ready yet; check missing requirements below.")
	runner._expect(promised_feedback.contains("Banked 3 resource(s)."), "future cutter promise should not replace normal upgrade feedback")
	runner._expect(not promised_feedback.contains("Planned: Salvage Cutter"), "upgrade feedback should not append obsolete planned cutter copy")
	runner._expect_lines_within(promised_feedback, 72, "future cutter promised feedback")
	var cutter_state := UpgradeStateServiceScript.format_upgrade_state(main, SalvageCutterUpgrade)
	runner._expect(cutter_state.begins_with("State: Needs salvage data"), "Salvage Cutter I should be locked by recovered cache evidence before extraction")
	runner._expect(cutter_state.contains("Recover: Salvage Data Cache"), "Salvage Cutter I should name the broad evidence prerequisite")
	runner._expect(cutter_state.contains("Wide Reef salvage pocket"), "Salvage Cutter I should stay scoped to the sealed Wide Reef pocket")
	main.progression_state.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	main.progression_state.banked_resources = {
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	cutter_state = UpgradeStateServiceScript.format_upgrade_state(main, SalvageCutterUpgrade)
	runner._expect(cutter_state.begins_with("State: Missing resources"), "Salvage Cutter I should show missing resources after evidence is recovered")
	runner._expect(cutter_state.contains("Shell Fragments x1"), "Salvage Cutter I should show only the remaining existing-resource cost")
	main.progression_state.banked_resources = {
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	cutter_state = UpgradeStateServiceScript.format_upgrade_state(main, SalvageCutterUpgrade)
	runner._expect(cutter_state.begins_with("State: Available now"), "Salvage Cutter I should become available after evidence and existing resources")
	main.progression_state.purchase_upgrade(SalvageCutterUpgrade.id, SalvageCutterUpgrade.resource_cost)
	cutter_state = UpgradeStateServiceScript.format_upgrade_state(main, SalvageCutterUpgrade)
	runner._expect(cutter_state.begins_with("State: Owned"), "Salvage Cutter I should show owned after normal upgrade purchase")
	main.run_salvage_data_cache_recovered = false
	main.recent_expedition_log = [{"route_memory": "Wide Reef Chamber"}]
	main.free()

func _test_result_and_upgrade_copy_length_guards(runner) -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 4
	main.progression_state.current_run_seed = 32676
	main.current_resource_cluster_pattern = "deep_reward"
	main.current_predator_route_id = "lower_predator_gate"
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	main.run_collected_resources = ["glow_plankton", "shell_fragments", "kelp_fiber"]
	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache", "gulper_eel"]
	main.run_predator_contacts = 1
	main.run_echo_lens_echo_fired = true
	main.run_wreck_echo_clue_recovered = true
	main.decoy_pulse_used_this_run = true

	var compact_result := "\n".join([
		SurfaceRunSummaryServiceScript.format_completed_expedition_line(main, "Extraction"),
		SurfaceRunSummaryServiceScript.format_extraction_banking_line(3, main.run_collected_resources, main.survival_state, main.RESOURCE_CATEGORY_LABELS, not main.run_completed_scans.is_empty()),
		SurfaceRunSummaryServiceScript.format_region_memory_callout(main),
		SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main),
		SurfaceRunSummaryServiceScript.format_route_choice_callout(main),
		ResearchResultCalloutServiceScript.format_gulper_research_callout(main),
		ResearchResultCalloutServiceScript.format_echo_lens_research_callout(main),
		ResearchResultCalloutServiceScript.format_wreck_echo_research_callout(main),
		UpgradeStateServiceScript.format_upgrade_progress_callout(main),
		SurfaceRunSummaryServiceScript.format_scan_progress_callout(main.progression_state, main.run_completed_scans, "Discoveries recorded"),
		SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main),
	])
	runner._expect_lines_within(compact_result, 96, "player-facing result summary")
	runner._expect(not SurfaceRunSummaryServiceScript.format_run_summary(main, compact_result, "Extraction").contains("Playtest data:"), "result copy length guard should keep debug telemetry gated")

	main.show_debug_telemetry = true
	runner._expect(SurfaceRunSummaryServiceScript.format_run_summary(main, compact_result, "Extraction").contains("Playtest data:"), "debug telemetry should remain opt-in for long result checks")
	main.show_debug_telemetry = false

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal cache.", "Scanner curiosity.")
	var upgrade_states := [
		UpgradeStateServiceScript.format_upgrade_state(main, OxygenTankUpgrade),
		UpgradeStateServiceScript.format_upgrade_state(main, PressureSealUpgrade),
		UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade),
	]
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	upgrade_states.append(UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade))
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	upgrade_states.append(UpgradeStateServiceScript.format_upgrade_state(main, EchoLensUpgrade))
	for index in range(upgrade_states.size()):
		runner._expect_lines_within(String(upgrade_states[index]), 88, "upgrade state %d" % index)

	var main_scene := MainScene.instantiate()
	runner.root.add_child(main_scene)
	for label_path in [
		"HUD/RunPanel/RunSummary",
		"HUD/UpgradePanel/UpgradeMenuItem",
		"HUD/UpgradePanel/UpgradeMenuCost",
		"HUD/UpgradePanel/UpgradeMenuState",
		"HUD/UpgradePanel/UpgradeMenuFeedback",
	]:
		var label: Label = main_scene.get_node(label_path)
		runner._expect(label.autowrap_mode != TextServer.AUTOWRAP_OFF, "%s should keep wrapping enabled" % label_path)
	var run_panel: Panel = main_scene.get_node("HUD/RunPanel")
	var run_summary_label: Label = main_scene.get_node("HUD/RunPanel/RunSummary")
	main_scene.run_panel = run_panel
	main_scene.surface_tabs_label = main_scene.get_node("HUD/RunPanel/SurfaceTabs")
	main_scene.run_title_label = main_scene.get_node("HUD/RunPanel/RunTitle")
	main_scene.run_summary_label = run_summary_label
	main_scene.call("_apply_run_panel_layout", false)
	runner._expect(run_panel.offset_left == 44.0 and run_panel.offset_right == 850.0, "result surface panel should use the wide layout")
	runner._expect(run_panel.offset_bottom >= 672.0, "result surface panel should be tall enough to contain result copy")
	runner._expect(run_summary_label.offset_bottom <= run_panel.offset_bottom - run_panel.offset_top, "result summary label should stay inside the run panel")
	runner._expect(run_summary_label.clip_text, "result summary label should clip instead of drawing outside the panel")
	main_scene.call("_apply_run_panel_layout", true)
	runner._expect(run_panel.offset_left == 420.0 and run_panel.offset_bottom == 362.0, "upgrade surface tab should keep compact run panel above the upgrade details")
	var upgrade_panel: Panel = main_scene.get_node("HUD/UpgradePanel")
	var upgrade_feedback: Label = main_scene.get_node("HUD/UpgradePanel/UpgradeMenuFeedback")
	runner._expect(upgrade_panel.offset_bottom <= 704.0, "upgrade details panel should leave a visible bottom margin at 1280x720")
	runner._expect(upgrade_feedback.offset_bottom <= upgrade_panel.offset_bottom - upgrade_panel.offset_top - 14.0, "upgrade feedback label should stay inside the upgrade panel")
	runner._expect(upgrade_feedback.clip_text, "upgrade feedback should clip instead of drawing outside the panel")
	main_scene.queue_free()
	main.free()

func _test_recent_expedition_log_service(runner) -> void:
	var main := MainScript.new()
	runner._expect(RecentExpeditionLogServiceScript.format_scan_ids([]) == "none", "empty scan-id list should format as none")
	runner._expect(RecentExpeditionLogServiceScript.format_scan_ids(["thermal_vent", "shell_reef_shelf"]) == "thermal_vent, shell_reef_shelf", "scan-id list should preserve comma-separated ids")

	main.progression_state.current_run_number = 5
	main.progression_state.current_run_seed = 101
	main.progression_state.best_depth_reached = 42.0
	main.run_completed_scans = ["thermal_vent"]
	main.run_banked_survival_supplies = ["food_supply"]
	RecentExpeditionLogServiceScript.record_recent_expedition(main, "Extracted", 1)
	runner._expect(main.recent_expedition_log.size() == 1, "recent expedition service should append one entry")
	runner._expect(String(main.recent_expedition_log[0].get("survival_memory", "")).contains("Food"), "recent expedition service should preserve survival supply memory")

	for run_number in range(6, 10):
		main.progression_state.current_run_number = run_number
		RecentExpeditionLogServiceScript.record_recent_expedition(main, "Extracted", 0)
	runner._expect(main.recent_expedition_log.size() == 3, "recent expedition service should keep only three entries")
	runner._expect(int(main.recent_expedition_log[0].get("run_number", -1)) == 7, "recent expedition service should drop oldest entries first")
	main.free()
