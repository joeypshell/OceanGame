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

func _test_night_phase_end_day_and_upgrade_choice(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.player_in_base = true
	main.dive_session.has_left_base = true
	main.daylight_nightfall_announced = true
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("quartz_glass")
	main.dive_session.current_cargo.append("food_supply")
	main.dive_session.current_cargo.append("power_supply")
	main.daylight_ship_offload_count = 1
	var starting_day: int = main.survival_state.current_day

	main.call("_try_extract")

	runner._expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "returning to ship after nightfall should end the day")
	runner._expect(main.surface_tab_index == main.SURFACE_TAB_NIGHT, "successful end-of-day extraction should open the Night tab")
	runner._expect(main.last_completed_survival_day == starting_day, "night phase should remember the completed survival day")
	runner._expect(main.survival_state.current_day == starting_day + 1, "night resolution should prepare tomorrow")
	runner._expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED, "banked food/fish should pay tonight's food cost")
	runner._expect(main.survival_state.power == SurvivalStateScript.STARTING_NEED, "banked power should pay tonight's power cost")
	runner._expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED - 1, "missing water should show as a clear night consequence")
	var night_summary: String = SurfaceRunSummaryServiceScript.format_night_phase_summary(main)
	runner._expect(night_summary.contains("Night Report"), "Night tab should show the night report")
	runner._expect(night_summary.contains("Daylight closeout") and night_summary.contains("1 ship offload"), "Night tab should preserve the repeated-sortie day context")
	runner._expect(night_summary.contains("Power -1"), "Night tab should name power resolution")
	runner._expect(night_summary.contains("Base needs: Food"), "Night tab should show current base needs")
	runner._expect(night_summary.contains("Build choice: Water Filter I ready"), "Night tab should point to a compact build choice")
	runner._expect(night_summary.contains("build Water Filter I in Upgrades"), "Night tab should turn ready builds into a tomorrow plan")

	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	main.selected_upgrade_index = 0
	main.call("_try_purchase_selected_upgrade")

	runner._expect(main.progression_state.has_upgrade(WaterFilterUpgrade.id), "night upgrade choice should purchase Water Filter I")
	runner._expect(main.progression_state.resource_count("driftwood") == 0, "night upgrade should spend driftwood")
	runner._expect(main.progression_state.resource_count("quartz_glass") == 0, "night upgrade should spend quartz glass")
	runner._expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED, "Water Filter I should restore one water reserve during night")
	runner._expect(main.upgrade_menu_feedback.contains("Purchased Water Filter I"), "night purchase feedback should confirm the build choice")
	runner._expect(main.upgrade_menu_feedback.contains("Next:"), "night purchase feedback should include a concrete next-day plan")
	var post_purchase_prompt: String = SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main)
	runner._expect(not post_purchase_prompt.contains("build Water Filter I"), "tomorrow plan should move past Water Filter I after it is built")
	runner._expect(post_purchase_prompt.contains("Oxygen Tank I"), "tomorrow plan after Water Filter I should point back to the starter research upgrade path")

	main.call("_restart_dive")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "restart after night should prepare the next day")
	runner._expect(main.survival_state.current_day == starting_day + 1, "restart after night should keep tomorrow's day number")
	main.queue_free()

func _test_night_build_presenter(runner) -> void:
	var missing_choice := NightBuildPresenterScript.format_choice_line(
		false,
		false,
		true,
		false,
		"",
		"Upgrade progress: Oxygen Tank I needs Kelp Fiber x2",
		"Scrap Metal x1",
		"E/Enter",
		1
	)
	runner._expect(missing_choice.contains("Power Patch needs Scrap Metal x1"), "night build presenter should name missing Power Patch materials")
	runner._expect(missing_choice.contains("Oxygen Tank I needs Kelp Fiber x2"), "night build presenter should preserve compact upgrade progress")
	var ready_choice := NightBuildPresenterScript.format_choice_line(false, false, true, true, "", "", "Scrap Metal x1", "E/Enter", 1)
	runner._expect(ready_choice.contains("Power Patch ready"), "night build presenter should expose available Power Patch craft")
	runner._expect(ready_choice.contains("E or Enter craft"), "night build presenter should use readable craft action labels")
	runner._expect(NightBuildPresenterScript.format_choice_line(false, true, true, false, "", "", "Scrap Metal x1", "E/Enter", 1).contains("Power Patch installed"), "night build presenter should show installed craft state")
	runner._expect(NightBuildPresenterScript.format_choice_line(true, false, true, true, "", "", "Scrap Metal x1", "E/Enter", 1).contains("Night med used build time"), "night build presenter should prioritize health recovery build lockout")
	runner._expect(NightBuildPresenterScript.format_choice_line(false, false, true, false, "Water Filter I", "", "Scrap Metal x1", "E/Enter", 1).contains("Water Filter I ready"), "night build presenter should expose ready upgrades when Power Patch is not ready")
	runner._expect(NightBuildPresenterScript.format_prompt(true, false, true, true, "E/Enter", "R", "Left/Right").contains("review night med"), "night build prompt should expose the health recovery review")
	runner._expect(NightBuildPresenterScript.format_prompt(false, false, true, true, "E/Enter", "R", "Left/Right").contains("craft Power Patch"), "night build prompt should expose available craft action")
	runner._expect(NightBuildPresenterScript.format_prompt(false, false, true, false, "E/Enter", "R", "Left/Right").contains("check Power Patch"), "night build prompt should expose missing craft review")

func _test_night_power_patch_build_choice(runner) -> void:
	var main := MainScript.new()
	main.dive_session.start()
	main.dive_session.extract()
	main.surface_tab_index = main.SURFACE_TAB_NIGHT
	main.survival_state.power = 1

	var missing_choice := SurfaceRunSummaryServiceScript.format_night_build_choice_line(main)
	runner._expect(missing_choice.contains("Power Patch needs Scrap Metal x1"), "Night tab should name the tiny craft cost when missing")
	runner._expect(main._format_night_build_prompt().contains("check Power Patch"), "Night prompt should expose the build action even before materials are ready")

	main.progression_state.banked_resources = {
		"scrap_metal": 1,
	}
	var ready_choice := SurfaceRunSummaryServiceScript.format_night_build_choice_line(main)
	runner._expect(ready_choice.contains("Power Patch ready"), "Night tab should expose an available craft when scrap is banked")
	runner._expect(ready_choice.contains("Power +1 tomorrow"), "Night tab should describe the next-day payoff")
	runner._expect(main._format_night_build_prompt().contains("craft Power Patch"), "Night prompt should make the available craft actionable")

	runner._expect(bool(main.call("_try_craft_night_power_patch")), "Night craft should succeed when scrap is banked")
	runner._expect(main.progression_state.resource_count("scrap_metal") == 0, "Night craft should spend banked scrap")
	runner._expect(main.survival_state.power == 2, "Night craft should add a visible Power reserve for tomorrow")
	runner._expect(main.night_build_completed_this_surface, "Night craft should be one-per-night")
	runner._expect(main.last_night_report.contains("Power Patch spent Scrap Metal x1"), "Night report should record the build result")
	runner._expect(SurfaceRunSummaryServiceScript.format_night_build_choice_line(main).contains("Power Patch installed"), "Night tab should show the completed build instead of another available action")

	runner._expect(not bool(main.call("_try_craft_night_power_patch")), "Night craft should not repeat after the one-night build is complete")
	runner._expect(main.survival_state.power == 2, "Rejected repeat night craft should not add more Power")
	main.free()

func _test_nightfall_away_from_ship_late_return_consequence(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.player_in_base = false
	main.dive_session.has_left_base = true
	main.dive_session.oxygen = 12.0
	main.dive_session.health = 72.0
	main.daylight_elapsed_seconds = main.daylight_duration_seconds
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("food_supply")
	main.dive_session.current_cargo.append("power_supply")

	main.call("_advance_daylight_timer", 1.0)

	runner._expect(main.daylight_nightfall_announced, "nightfall away from ship should announce the day ending")
	runner._expect(main.daylight_nightfall_away_from_ship, "nightfall away from ship should mark the late-return consequence")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "nightfall away from ship should keep the dive active until final ship return")
	runner._expect(main.dive_session.current_cargo.size() == 3, "nightfall away from ship should keep cargo carried and at risk")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 12.0), "nightfall away from ship should not change oxygen directly")
	runner._expect(is_equal_approx(main.dive_session.health, 72.0), "nightfall away from ship should not change health directly")
	var overstay_prompt: String = main.call("_format_hud_prompt")
	runner._expect(overstay_prompt.contains("return to ship") and overstay_prompt.contains("cargo at risk") and overstay_prompt.contains("late Power -1"), "overstay prompt should explain return, cargo risk, and power consequence")

	main.player_in_base = true
	runner._expect(not bool(main.call("_try_ship_offload")), "nightfall away from ship should disable daylight cargo offload")

	var extracted_cargo: Array[String] = []
	for item_id in main.dive_session.current_cargo:
		extracted_cargo.append(item_id)
	main.dive_session.extract()
	main.call("_bank_extracted_cargo", extracted_cargo)
	main.call("_bank_extracted_survival_supplies", extracted_cargo)
	main.last_completed_survival_day = main.survival_state.current_day
	main.call("_resolve_night_after_result")
	main.dive_session.clear_cargo()
	main.surface_tab_index = main.SURFACE_TAB_NIGHT

	runner._expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "late return to ship should resolve the day")
	runner._expect(main.dive_session.current_cargo.is_empty(), "late final return should clear carried cargo after banking")
	runner._expect(main.progression_state.resource_count("driftwood") == 1, "late final return should still bank carried material cargo")
	runner._expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED, "late final return should bank food before paying night food")
	runner._expect(main.survival_state.power == SurvivalStateScript.STARTING_NEED - 1, "late final return should bank power then pay normal night power plus late power")
	runner._expect(main.survival_state.water == SurvivalStateScript.STARTING_NEED - 1, "late final return should still pay normal night water")
	runner._expect(main.last_night_report.contains("Late return cost: Power -1"), "Night tab should name the late return power cost")
	var closeout_line: String = SurfaceRunSummaryServiceScript.format_daylight_closeout_line(main)
	runner._expect(closeout_line.contains("nightfall caught the diver away from ship") and closeout_line.contains("cost extra Power"), "Night tab closeout should preserve the late-return context")
	var ship_prompt: String = main.call("_format_hud_prompt")
	runner._expect(ship_prompt.contains("Night build") and not ship_prompt.contains("return to ship"), "after late return extraction, HUD should leave active overstay prompts")
	main.queue_free()

func _test_debug_unlimited_oxygen(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(10.0)
	session.start()
	session.add_cargo("kelp_fiber")
	session.unlimited_oxygen = true

	session.drain_oxygen(12.0)

	runner._expect(session.oxygen == 10.0, "debug unlimited oxygen should keep oxygen unchanged")
	runner._expect(session.result == DiveSessionScript.Result.DIVING, "debug unlimited oxygen should not fail the dive")
	runner._expect(session.current_cargo == ["kelp_fiber"], "debug unlimited oxygen should preserve carried cargo")

	var main := MainScript.new()
	main.dive_session.reset(10.0)
	main.dive_session.start()
	main.show_debug_telemetry = false
	main.call("_sync_debug_oxygen_mode")
	runner._expect(not main.dive_session.unlimited_oxygen, "hidden debug telemetry should keep normal oxygen rules")
	main.show_debug_telemetry = true
	main.call("_sync_debug_oxygen_mode")
	runner._expect(main.dive_session.unlimited_oxygen, "shown debug telemetry should enable unlimited oxygen for exploration")
	main.free()

func _test_survival_night_consumption(runner) -> void:
	var survival := SurvivalStateScript.new()
	var cache_copy := SurvivalStateScript.new()

	var day_one_report := survival.resolve_night()

	runner._expect(survival.current_day == 2, "survival night should advance from day one to day two")
	runner._expect(survival.food == 2, "survival night should consume one food")
	runner._expect(survival.water == 2, "survival night should consume one water")
	runner._expect(survival.power == 2, "survival night should consume one power")
	runner._expect(day_one_report[0].contains("Night cost paid"), "survival report should explain night consumption")
	runner._expect(day_one_report[0].contains("Food -1") and day_one_report[0].contains("Water -1") and day_one_report[0].contains("Power -1"), "survival report should name each consumed need")
	runner._expect(survival.status_line().contains("Base needs: Food 2, Water 2, Power 2"), "survival status should use readable Food/Water/Power names")
	runner._expect(not survival.status_line().contains("F2 W2 P2"), "survival status should not use cryptic need abbreviations")
	runner._expect(survival.nightly_pressure_line().contains("Tonight"), "ready copy helper should explain nightly pressure")
	runner._expect(survival.supply_cache_hint_line().contains("cargo space"), "ready copy helper should explain the supply-cache cargo tradeoff")
	runner._expect(cache_copy.supply_cache_hint_line().contains("base needs are stable"), "ready copy helper should explain when the supply cache is backup")
	cache_copy.power = 1
	runner._expect(cache_copy.supply_cache_hint_line().contains("Power") and cache_copy.supply_cache_hint_line().contains("lowest need"), "ready copy helper should name the weakest need the cache targets")

	var late_return := SurvivalStateScript.new()
	var late_report := late_return.resolve_night(1)
	runner._expect(late_return.food == 2 and late_return.water == 2 and late_return.power == 1, "late return night should add one deterministic power cost without changing food or water")
	runner._expect("\n".join(late_report).contains("Power -2"), "late return night report should include total power cost")
	runner._expect("\n".join(late_report).contains("Late return cost"), "late return night report should explain the extra power cost")

	survival.resolve_night()
	var warning_report := survival.resolve_night()
	runner._expect(survival.current_day == 4, "survival should keep advancing while needs are at zero")
	runner._expect(survival.oxygen_penalty() == 12.0, "zero food, water, and power should create a staged oxygen penalty")
	runner._expect("\n".join(warning_report).contains("Tomorrow oxygen penalty"), "zero-need night should warn about reduced oxygen")
	runner._expect("\n".join(warning_report).contains("-12 max oxygen"), "zero-need night should quantify the next-day oxygen penalty")

func _test_survival_collapse_and_reset(runner) -> void:
	var survival := SurvivalStateScript.new()
	survival.food = 0
	survival.water = 0
	survival.power = 0

	var collapse_report := survival.resolve_night()

	runner._expect(survival.chapter_failed, "survival should collapse when a need falls below zero")
	runner._expect("\n".join(collapse_report).contains("Collapse"), "collapse report should name the chapter failure")
	survival.reset_chapter()
	runner._expect(not survival.chapter_failed, "survival reset should clear chapter failure")
	runner._expect(survival.current_day == 1, "survival reset should return to day one")
	runner._expect(survival.food == 3 and survival.water == 3 and survival.power == 3, "survival reset should restore starting supplies")

func _test_survival_supply_banking_isolation(runner) -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["kelp_fiber", "food_supply", "power_supply"]

	var resources: Array[String] = main.call("_bank_extracted_cargo", cargo)
	var supplies: Array[String] = SurvivalControllerServiceScript.bank_extracted_survival_supplies(main, cargo)

	runner._expect(resources == ["kelp_fiber"], "survival supplies should not bank as upgrade resources")
	runner._expect(supplies == ["food_supply", "power_supply"], "survival supply banking should return only supply cargo")
	runner._expect(main.progression_state.resource_count("kelp_fiber") == 1, "resource cargo should still bank normally")
	runner._expect(main.progression_state.resource_count("food_supply") == 0, "food supply should not appear in resource bank")
	runner._expect(main.survival_state.food == 4, "food supply should increase survival food")
	runner._expect(main.survival_state.power == 4, "power supply should increase survival power")
	runner._expect(main.survival_state.water == 3, "unbanked water should remain unchanged")

func _test_survival_supply_cache_presenter(runner) -> void:
	runner._expect(SurvivalSupplyCachePresenterScript.format_status_text(true, "Power").contains("base stable"), "stable cache status should say the cache is backup")
	runner._expect(SurvivalSupplyCachePresenterScript.format_status_text(false, "Power").contains("Power is lowest"), "cache status should name the currently weakest survival need")
	runner._expect(SurvivalSupplyCachePresenterScript.format_prompt(true, "Power", "E/Enter").contains("backup supply"), "stable cache prompt should avoid naming a false weak need")
	runner._expect(SurvivalSupplyCachePresenterScript.format_prompt(false, "Power", "E/Enter").contains("recover Power"), "cache prompt should name the currently weakest survival need")
	runner._expect(SurvivalSupplyCachePresenterScript.format_full_status(true, "Power") == "Cargo full: backup cache needs a slot.", "stable full-cache status should preserve backup copy")
	runner._expect(SurvivalSupplyCachePresenterScript.format_full_status(false, "Power") == "Cargo full: Power cache needs a slot.", "full-cache status should name the blocked target")
	runner._expect(SurvivalSupplyCachePresenterScript.format_recovered_status("Power Cell", "Power").contains("Power Cell") and SurvivalSupplyCachePresenterScript.format_recovered_status("Power Cell", "Power").contains("Ship banks"), "recovered cache status should name the supply role and ship banking")

func _test_survival_supply_cache_state_service(runner) -> void:
	var main := MainScript.new()
	main.survival_supply_cache_halo = Polygon2D.new()
	main.survival_supply_cache_core = Polygon2D.new()
	main.survival_supply_cache_label = Label.new()

	SurvivalSupplyCacheStateServiceScript.sync_state(main)
	runner._expect(main.survival_supply_cache_halo.color == Color(0.72, 0.95, 1.0, 0.22), "available supply cache halo should keep readable color")
	runner._expect(main.survival_supply_cache_core.color == Color(0.96, 0.78, 0.38, 0.72), "available supply cache core should keep readable color")
	runner._expect(main.survival_supply_cache_label.text == "SUPPLY CACHE", "available supply cache label should stay exact")

	main.run_survival_supply_cache_recovered = true
	SurvivalSupplyCacheStateServiceScript.sync_state(main)
	runner._expect(main.survival_supply_cache_halo.color == Color(0.72, 0.95, 1.0, 0.08), "recovered supply cache halo should dim")
	runner._expect(main.survival_supply_cache_core.color == Color(0.96, 0.78, 0.38, 0.18), "recovered supply cache core should dim")
	runner._expect(main.survival_supply_cache_label.text == "SUPPLY TAKEN", "recovered supply cache label should stay exact")
	main.free()
