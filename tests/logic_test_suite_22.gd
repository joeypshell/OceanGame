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

func _test_expedition_prep_goals(runner) -> void:
	var upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]
	var progression := ProgressionStateScript.new()

	var goal := ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("Oxygen Tank I"), "fresh prep goal should point at Oxygen Tank I")
	runner._expect(goal.contains("Kelp Fiber x2"), "fresh prep goal should list missing oxygen tank kelp")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal == "Goal: buy Oxygen Tank I in the upgrade bay after this dive.", "affordable prep goal should point to purchase")

	progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("scan Thermal Vent"), "locked pressure seal goal should point at Thermal Vent")
	runner._expect(goal.contains("Pressure Seal I"), "locked pressure seal goal should name the upgrade")

	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("bank"), "unlocked pressure seal goal should point back to banking")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PressureSealUpgrade.id, PressureSealUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("scan Wreck Signal Cache"), "locked signal lens goal should point at Wreck Signal Cache")

	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(SignalLensUpgrade.id, SignalLensUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("Cargo Rack I"), "signal lens ownership should advance goal to Cargo Rack I")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(CargoRackUpgrade.id, CargoRackUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("scan Gulper Eel"), "cargo rack ownership should advance goal to Predator Warning I scan prerequisite")

	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("Predator Warning I"), "gulper observation should advance goal to Predator Warning I resources")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PredatorWarningUpgrade.id, PredatorWarningUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("Decoy Pulse I"), "predator warning ownership should advance goal to Decoy Pulse I")
	runner._expect(goal.contains("Glow Plankton x2"), "decoy prep goal should show missing planned glow cost")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	progression.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	runner._expect(goal.contains("Shell Reef"), "completed upgrade goals should preserve a safer bank route")
	runner._expect(goal.contains("Shelf Drop"), "completed upgrade goals should mention the lower connector broadly")
	runner._expect(goal.contains("Blue Chimney"), "completed upgrade goals should mention the lower-pocket payoff broadly")
	runner._expect(goal.contains("if oxygen allows"), "completed upgrade lower-pocket goal should remain optional")
	runner._expect(goal.contains("return safely"), "completed upgrade lower-pocket goal should preserve extraction pressure")
	runner._expect_no_echo_lens_locator_language(goal, "completed upgrade lower-pocket goal")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades, "rare_signal")
	runner._expect(goal.contains("East Shelf"), "Rare Signal should still give completed-upgrade players a reason to visit East Shelf")
	runner._expect(goal.contains("Blue Chimney"), "Rare Signal should sometimes point completed-upgrade players toward the lower pocket")
	runner._expect(goal.contains("if oxygen allows"), "Rare Signal route goal should remain optional rather than a checklist")
	runner._expect(goal.contains("return safely"), "Rare Signal route goal should preserve extraction pressure")
	runner._expect(not goal.contains("Blackwater"), "Rare Signal should not point at Blackwater before the scoped key is owned")

	var full_upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		EchoLensUpgrade,
		ResonanceKeyUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
		SalvageCutterUpgrade,
	]
	var salvage_goal_progression := ProgressionStateScript.new()
	for upgrade in full_upgrades:
		if upgrade.id != SalvageCutterUpgrade.id:
			salvage_goal_progression.purchased_upgrades[upgrade.id] = true
	goal = ExpeditionGoalFormatterScript.format_goal(salvage_goal_progression, full_upgrades)
	runner._expect(goal.contains("recover Salvage Data Cache"), "prepared players should get a salvage-cache recovery goal before Salvage Cutter I")
	runner._expect(goal.contains("Salvage Cutter I"), "salvage-cache recovery goal should name the new cutter upgrade")
	salvage_goal_progression.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	goal = ExpeditionGoalFormatterScript.format_goal(salvage_goal_progression, full_upgrades)
	runner._expect(goal.contains("bank"), "Salvage Cutter I should ask for existing resources after evidence is recovered")
	runner._expect(goal.contains("Shell Fragments"), "Salvage Cutter I resource goal should use existing Shell Fragments")

	var blackwater_ready_progression := ProgressionStateScript.new()
	for upgrade in full_upgrades:
		blackwater_ready_progression.purchased_upgrades[upgrade.id] = true
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "rare_signal")
	runner._expect(goal.contains("Blackwater"), "Rare Signal should nudge Blackwater once the scoped key path is ready")
	runner._expect(goal.contains("if oxygen allows"), "Blackwater Rare Signal goal should stay optional")
	runner._expect(goal.contains("return safely"), "Blackwater Rare Signal goal should preserve extraction pressure")
	runner._expect_no_echo_lens_locator_language(goal, "Blackwater Rare Signal goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades)
	runner._expect(goal.contains("Blackwater"), "prepared completed-upgrade goal should suggest the lower route outside Rare Signal")
	runner._expect(goal.contains("if oxygen allows"), "prepared completed-upgrade lower-route goal should stay optional")
	runner._expect(goal.contains("return safely"), "prepared completed-upgrade lower-route goal should preserve extraction pressure")
	runner._expect_no_echo_lens_locator_language(goal, "prepared completed-upgrade lower-route goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Blackwater")
	runner._expect(goal.contains("Blackwater"), "recent Blackwater memory should keep the ready nudge on the same broad route")
	runner._expect(goal.contains("Dusk"), "recent Blackwater memory should point the next dive toward Dusk")
	runner._expect_no_echo_lens_locator_language(goal, "recent Blackwater ready goal")
	var save_before_recent_goal: Dictionary = blackwater_ready_progression.to_save_data().duplicate(true)
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Dusk Trench")
	runner._expect(goal.contains("Dusk"), "recent Dusk memory should keep the ready nudge broad")
	runner._expect(goal.contains("Hollow Reef"), "recent Dusk memory should point toward the side-cave branch")
	runner._expect_no_echo_lens_locator_language(goal, "recent Dusk ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Hollow Reef")
	runner._expect(goal.contains("Hollow Reef"), "recent Hollow Reef memory should keep the ready nudge broad")
	runner._expect(goal.contains("wide chamber"), "recent Hollow Reef memory should point toward the wider chamber")
	runner._expect(goal.contains("if oxygen allows"), "recent Hollow Reef chamber goal should stay optional")
	runner._expect(goal.contains("return safely"), "recent Hollow Reef chamber goal should preserve extraction pressure")
	runner._expect_no_echo_lens_locator_language(goal, "recent Hollow Reef chamber goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Wide Reef Chamber")
	runner._expect(goal.contains("Wide Reef"), "recent Wide Reef Chamber memory should keep the ready nudge broad")
	runner._expect(goal.contains("Salvage Cutter I"), "recent Wide Reef Chamber memory should mention the owned narrow tool")
	runner._expect(goal.contains("if oxygen allows"), "recent Wide Reef Chamber ready goal should keep the return payoff optional")
	runner._expect(goal.contains("Hollow Reef"), "recent Wide Reef Chamber ready goal should preserve broad return-route language")
	runner._expect(not goal.to_lower().contains("buy"), "recent Wide Reef Chamber ready goal should not imply another cutter purchase")
	runner._expect(not goal.to_lower().contains("upgrade bay"), "recent Wide Reef Chamber ready goal should not create upgrade-bay promise copy")
	runner._expect(not goal.to_lower().contains("craft"), "recent Wide Reef Chamber ready goal should not introduce crafting")
	runner._expect_no_echo_lens_locator_language(goal, "recent Wide Reef Chamber ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Mirror Kelp Pass")
	runner._expect(goal.contains("Mirror Kelp"), "recent Mirror Kelp memory should keep the ready nudge on the new branch")
	runner._expect(goal.contains("deep-kelp seal"), "recent Mirror Kelp memory should point toward the branch promise")
	runner._expect(goal.contains("if oxygen allows"), "recent Mirror Kelp ready goal should stay optional")
	runner._expect(goal.contains("Wide Reef"), "recent Mirror Kelp ready goal should keep broad return-route language")
	runner._expect(not goal.to_lower().contains("checklist"), "recent Mirror Kelp ready goal should not imply a checklist")
	runner._expect(not goal.to_lower().contains("map"), "recent Mirror Kelp ready goal should not imply map UI")
	runner._expect_no_echo_lens_locator_language(goal, "recent Mirror Kelp ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Glass Rim")
	runner._expect(goal.contains("Glass Rim"), "recent Glass Rim memory should keep the ready nudge on the new payoff place")
	runner._expect(goal.contains("timing"), "recent Glass Rim ready goal should preserve the timing choice")
	runner._expect(goal.contains("cargo"), "recent Glass Rim ready goal should preserve the cargo alternative")
	runner._expect(goal.contains("sealed rim promise"), "recent Glass Rim ready goal should tease the broad future promise")
	runner._expect(goal.contains("if oxygen allows"), "recent Glass Rim ready goal should stay optional")
	runner._expect(goal.contains("Mirror/Wide/Hollow"), "recent Glass Rim ready goal should preserve broad return-route language")
	runner._expect(not goal.to_lower().contains("checklist"), "recent Glass Rim ready goal should not imply a checklist")
	runner._expect(not goal.to_lower().contains("map"), "recent Glass Rim ready goal should not imply map UI")
	runner._expect_no_echo_lens_locator_language(goal, "recent Glass Rim ready goal")
	goal = ExpeditionGoalFormatterScript.format_goal(blackwater_ready_progression, full_upgrades, "", "Outer Shelf")
	runner._expect(goal.contains("Outer Shelf"), "recent Outer Shelf memory should keep the ready nudge on Area 02")
	runner._expect(goal.contains("Glass Rim"), "recent Outer Shelf ready goal should tease the timing branch")
	runner._expect(goal.contains("Kelp Fiber cargo"), "recent Outer Shelf ready goal should preserve the cargo-vs-knowledge choice")
	runner._expect(goal.contains("if oxygen allows"), "recent Outer Shelf ready goal should keep the return payoff optional")
	runner._expect(goal.contains("Mirror/Wide/Hollow"), "recent Outer Shelf ready goal should preserve broad return-route language")
	runner._expect(not goal.to_lower().contains("checklist"), "recent Outer Shelf ready goal should not imply a checklist")
	runner._expect(not goal.to_lower().contains("map"), "recent Outer Shelf ready goal should not imply map UI")
	runner._expect_no_echo_lens_locator_language(goal, "recent Outer Shelf ready goal")
	var save_after_recent_goal: Dictionary = blackwater_ready_progression.to_save_data()
	runner._expect(save_after_recent_goal == save_before_recent_goal, "ready route suggestions should not mutate save data")
	runner._expect(not save_after_recent_goal.has("recent_route_memory"), "ready route suggestions should not add route memory to the save schema")
	runner._expect(not save_after_recent_goal.has("ready_goal"), "ready route suggestions should not add goal state to the save schema")
	runner._expect(not save_after_recent_goal.has("future_cutter"), "salvage cutter prep should not add obsolete tool state keys")

	var incomplete_progression := ProgressionStateScript.new()
	var incomplete_goal := ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "rare_signal")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "Rare Signal route goal should not override upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Blackwater")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "recent route memory should not override incomplete upgrade progression goals")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Hollow Reef")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "Hollow Reef chamber memory should not override incomplete upgrade progression goals")
	runner._expect(not incomplete_goal.contains("wide chamber"), "wide chamber ready goal should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Mirror Kelp Pass")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "Mirror Kelp ready goal should not override incomplete upgrade progression goals")
	runner._expect(not incomplete_goal.contains("deep-kelp seal"), "Mirror Kelp route memory should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Glass Rim")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "Glass Rim ready goal should not override incomplete upgrade progression goals")
	runner._expect(not incomplete_goal.contains("sealed rim promise"), "Glass Rim route memory should wait until prep goals are complete")
	incomplete_goal = ExpeditionGoalFormatterScript.format_goal(incomplete_progression, upgrades, "", "Outer Shelf")
	runner._expect(incomplete_goal.contains("Oxygen Tank I"), "Outer Shelf ready goal should not override incomplete upgrade progression goals")
	runner._expect(not incomplete_goal.contains("Glass Rim"), "Outer Shelf route memory should wait until prep goals are complete")

func _test_result_progress_callouts(runner) -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	runner._expect(UpgradeStateServiceScript.format_upgrade_progress_callout(main) == "Upgrade progress: Oxygen Tank I ready to buy.", "result progress should call out ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	runner._expect(UpgradeStateServiceScript.format_upgrade_progress_callout(main).contains("scan Thermal Vent"), "result progress should call out missing scan prerequisites")

	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache"]
	runner._expect(SurfaceRunSummaryServiceScript.format_scan_progress_callout(main.progression_state, main.run_completed_scans, "Scans kept") == "Scans kept: Thermal Vent, Wreck Signal Cache.", "result progress should name scans kept this dive")

	main.run_completed_scans.clear()
	runner._expect(SurfaceRunSummaryServiceScript.format_scan_progress_callout(main.progression_state, main.run_completed_scans, "Discoveries recorded") == "Discoveries recorded: none this dive.", "result progress should stay explicit when no scans were recorded")
	main.free()

func _test_extraction_banking_result_copy(runner) -> void:
	var main := MainScript.new()

	var cargo: Array[String] = ["kelp_fiber"]
	runner._expect(SurfaceRunSummaryServiceScript.format_extraction_banking_line(1, cargo, main.survival_state, main.RESOURCE_CATEGORY_LABELS, false).contains("Upgrade/build materials banked: 1"), "cargo extraction should keep resource banking copy")
	runner._expect(SurfaceRunSummaryServiceScript.format_extraction_banking_line(1, cargo, main.survival_state, main.RESOURCE_CATEGORY_LABELS, false).contains("Kelp Fiber x1"), "cargo extraction should keep resource counts")

	main.run_completed_scans = ["thermal_vent"]
	var scan_only := SurfaceRunSummaryServiceScript.format_extraction_banking_line(0, [], main.survival_state, main.RESOURCE_CATEGORY_LABELS, not main.run_completed_scans.is_empty())
	runner._expect(scan_only.contains("Banked 0 resources"), "scan-only extraction should not imply phantom cargo")
	runner._expect(scan_only.contains("scan data came home"), "scan-only extraction should read as useful")

	main.run_completed_scans.clear()
	var empty_return := SurfaceRunSummaryServiceScript.format_extraction_banking_line(0, [], main.survival_state, main.RESOURCE_CATEGORY_LABELS, not main.run_completed_scans.is_empty())
	runner._expect(empty_return.contains("No cargo or new scans"), "empty extraction should remain clearly low-value")
	main.free()
