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

func _test_mirror_kelp_kelp_bloom_condition_nudge(runner) -> void:
	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	var bloom_wash := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachWash") as Polygon2D
	var bloom_rib := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachRib") as Polygon2D
	var backwater := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater") as Polygon2D
	var curtain_a := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA") as Polygon2D
	var tideglass_zone := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone") as Area2D
	var mirrorfin := scene.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorfinDrift") as Area2D

	scene.dive_session.reset(40.0)
	scene.dive_session.start()
	scene.dive_session.oxygen = 22.0
	scene.dive_session.current_cargo.append("shell_fragments")
	scene.dive_session.has_left_base = true
	scene.progression_state.banked_resources["kelp_fiber"] = 3
	scene.progression_state.purchased_upgrades[OxygenTankUpgrade.id] = true
	scene.current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	scene.call("_sync_mirror_kelp_condition_nudge", "rare_signal")
	var neutral_backwater_alpha := backwater.color.a
	var neutral_curtain_alpha := curtain_a.color.a
	runner._expect(not bloom_wash.visible, "non-Kelp-Bloom expeditions should hide the Mirror Kelp bloom approach wash")
	runner._expect(not bloom_rib.visible, "non-Kelp-Bloom expeditions should hide the Mirror Kelp bloom approach rib")

	scene.current_expedition_condition = ExpeditionConditionScript.condition_for_seed(1)
	scene.call("_sync_mirror_kelp_condition_nudge", "kelp_bloom")
	runner._expect(scene._current_condition_id() == "kelp_bloom", "test seed should select Kelp Bloom deterministically")
	runner._expect(bloom_wash.visible, "Kelp Bloom should show the Mirror Kelp approach wash")
	runner._expect(bloom_rib.visible, "Kelp Bloom should show a readable Mirror Kelp approach rib")
	runner._expect(backwater.color.a > neutral_backwater_alpha, "Kelp Bloom should subtly thicken the Mirror Kelp backwater")
	runner._expect(curtain_a.color.a > neutral_curtain_alpha, "Kelp Bloom should subtly strengthen Mirror Kelp curtains")
	runner._expect(backwater.color.a <= 0.2 and curtain_a.color.a <= 0.25, "Kelp Bloom should stay readable without overpowering payoffs")
	runner._expect(bloom_wash.color.g > bloom_wash.color.r, "Mirror Kelp bloom nudge should keep kelp/current color language")
	var briefing := ConditionPresenterScript.format_condition_briefing(scene.current_expedition_condition, scene.progression_state.has_upgrade(ResonanceKeyUpgrade.id))
	runner._expect(briefing.contains("Mirror Kelp"), "Kelp Bloom briefing should name the broad route feel")
	runner._expect(briefing.contains("shimmer"), "Kelp Bloom briefing should tell players how to read the variation")
	runner._expect(scene.call("_format_expedition_ready_status").contains("Mirror Kelp"), "ready status should acknowledge the Mirror Kelp approach variation")
	runner._expect(is_equal_approx(scene.dive_session.oxygen, 22.0), "Mirror Kelp condition nudge should not drain oxygen")
	runner._expect(scene.dive_session.current_cargo == ["shell_fragments"], "Mirror Kelp condition nudge should not change carried cargo")
	runner._expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "Mirror Kelp condition nudge should not change dive state")
	runner._expect(scene.dive_session.has_left_base, "Mirror Kelp condition nudge should not reset extraction eligibility")
	runner._expect(scene.progression_state.resource_count("kelp_fiber") == 3, "Mirror Kelp condition nudge should not mutate banked resources")
	runner._expect(scene.progression_state.has_upgrade(OxygenTankUpgrade.id), "Mirror Kelp condition nudge should not mutate upgrades")
	runner._expect(tideglass_zone.collision_mask == 1, "Mirror Kelp condition nudge should not change Tideglass interaction access")
	runner._expect(mirrorfin.collision_layer == 0 and mirrorfin.collision_mask == 0, "Mirror Kelp condition nudge should keep Mirrorfin non-combat")
	var saved: Dictionary = scene.progression_state.to_save_data()
	runner._expect(not saved.has("mirror_kelp_condition"), "Mirror Kelp condition nudge should not add durable route state")
	runner._expect(not saved.has("kelp_bloom"), "Kelp Bloom should not save active condition state")
	scene.queue_free()

func _test_daylight_timer_hud(runner) -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 420.0
	main.daylight_elapsed_seconds = 0.0
	runner._expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "DAYLIGHT 07:00", "fresh daylight timer should show the full day budget")

	main.call("_set_daylight_progress_for_debug", 0.5)
	runner._expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "DAYLIGHT 03:30", "daylight debug progress should deterministically set remaining time")
	runner._expect(is_equal_approx(main.call("_daylight_remaining_ratio"), 0.5), "daylight remaining ratio should track the strategic day budget")

	main.call("_set_daylight_progress_for_debug", 1.0)
	runner._expect(HudPresenterScript.format_daylight_label(main.call("_daylight_remaining_seconds")) == "NIGHTFALL", "depleted daylight should show nightfall instead of oxygen-style copy")
	main.free()

	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	var cargo_panel: Panel = scene.get_node("HUD/CargoPanel")
	var daylight_panel: Panel = scene.get_node("HUD/DaylightPanel")
	var survival_panel: Panel = scene.get_node("HUD/SurvivalNeedsPanel")
	var daylight_label: Label = scene.get_node("HUD/DaylightLabel")
	var daylight_bar_back: ColorRect = scene.get_node("HUD/DaylightBarBack")
	var daylight_bar_fill: ColorRect = scene.get_node("HUD/DaylightBarFill")
	var oxygen_bar_back: ColorRect = scene.get_node("HUD/OxygenBarBack")

	runner._expect(not daylight_panel.visible, "raw scene should start with the daylight timer hidden")
	scene.dive_session.start()
	scene.player_in_base = false
	scene.call("_ensure_active_hud_references")
	scene.call("_apply_active_hud_layout")
	scene.call("_set_daylight_progress_for_debug", 0.25)
	scene.call("_update_daylight_timer_hud", true)
	runner._expect(daylight_panel.visible, "active diving should show the daylight timer")
	runner._expect(daylight_label.visible, "active diving should show daylight timer copy")
	runner._expect(daylight_label.text == "DAYLIGHT 05:15", "active daylight timer should show remaining day time")
	runner._expect(runner._control_rect(daylight_panel).size == Vector2(216.0, 48.0), "daylight timer should stay compact enough for top HUD space")
	runner._expect(daylight_panel.offset_left > cargo_panel.offset_right, "daylight timer should sit apart from the cargo strip")
	runner._expect(survival_panel.offset_left > daylight_panel.offset_right, "survival needs should sit apart from the daylight timer")
	runner._expect(not runner._controls_overlap(daylight_panel, cargo_panel), "daylight timer should not overlap cargo")
	runner._expect(not runner._controls_overlap(daylight_panel, survival_panel), "daylight timer should not overlap base needs")
	runner._expect(daylight_bar_back.color != oxygen_bar_back.color, "daylight bar should be visually distinct from oxygen")
	var morning_width := daylight_bar_fill.offset_right - daylight_bar_fill.offset_left

	scene.call("_set_daylight_progress_for_debug", 0.75)
	scene.call("_update_daylight_timer_hud", true)
	var evening_width := daylight_bar_fill.offset_right - daylight_bar_fill.offset_left
	runner._expect(evening_width < morning_width, "daylight fill should shrink as night approaches")
	runner._expect(daylight_label.text == "DAYLIGHT 01:45", "evening daylight staging should show less remaining time")

	scene.call("_advance_daylight_timer", scene.daylight_duration_seconds)
	runner._expect(scene.daylight_nightfall_announced, "daylight expiration should announce nightfall")
	runner._expect(scene.daylight_nightfall_away_from_ship, "timer expiration away from ship should mark the late-return consequence")
	runner._expect(scene.dive_session.result == DiveSessionScript.Result.DIVING, "timer expiration should keep the dive active until the player returns to ship")
	runner._expect(scene.status_label.text.contains("emergency return"), "timer expiration should tell the player to return immediately")
	scene.queue_free()

func _test_late_day_cargo_banking_warning(runner) -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 100.0
	main.daylight_elapsed_seconds = 76.0
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.dive_session.current_cargo.append("driftwood")

	runner._expect(bool(main.call("_should_warn_late_day_cargo_banking")), "low daylight with cargo away from ship should warn before nightfall")
	var warning_prompt: String = main.call("_format_hud_prompt")
	var warning_objective: String = main.call("_format_active_objective_line")
	runner._expect(warning_prompt.contains("Bank at ship") and warning_prompt.contains("Power risk"), "late-day cargo prompt should name ship banking and Power risk")
	runner._expect(warning_objective.contains("Dusk") and warning_objective.contains("bank cargo"), "late-day cargo objective should stay compact and actionable")

	main.dive_session.current_cargo.clear()
	runner._expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "empty cargo should not show the late-day banking warning")
	main.dive_session.current_cargo.append("driftwood")
	main.player_in_base = true
	runner._expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "cargo already at ship should not show the late-day banking warning")
	main.player_in_base = false
	main.daylight_elapsed_seconds = 50.0
	runner._expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "early daylight should not show the late-day banking warning")
	main.daylight_elapsed_seconds = 100.0
	main.daylight_nightfall_announced = true
	main.daylight_nightfall_away_from_ship = true
	runner._expect(not bool(main.call("_should_warn_late_day_cargo_banking")), "nightfall should use the existing overstay prompt instead of the pre-night warning")
	var nightfall_prompt: String = main.call("_format_hud_prompt")
	runner._expect(nightfall_prompt.contains("cargo at risk") and nightfall_prompt.contains("late Power -1"), "nightfall away-from-ship behavior should remain unchanged")
	main.free()

func _test_expedition_slate_presenter(runner) -> void:
	runner._expect(ExpeditionSlatePresenterScript.format_cargo_line([], 3) == "Cargo: empty (3 slots open).", "slate presenter should format empty cargo capacity")
	runner._expect(ExpeditionSlatePresenterScript.format_cargo_line(["Food", "Wood"], 3) == "Cargo: 2 / 3 carried - Food, Wood.", "slate presenter should format carried cargo names in order")
	var slate := ExpeditionSlatePresenterScript.format_slate_text({
		"base_needs_line": "Food 4/5 | Water 3/5 | Power 2/5",
		"cargo_limit": 3,
		"cargo_names": ["Food", "Wood"],
		"current_depth": 77,
		"day_plan": "bank Power supply soon",
		"daylight_label": "DAYLIGHT 03:30",
		"daylight_percent_left": 50,
		"health": 64,
		"known_build_line": "Build choice: Power Patch needs Scrap Metal x1.",
		"max_health": 100,
		"max_oxygen": 30,
		"oxygen": 12,
		"route_goal": "Goal: Scan target or collect cargo",
		"slate_label": "Tab",
	})
	runner._expect(slate.contains("DAYLIGHT 03:30") and slate.contains("50% daylight left"), "slate presenter should show remaining daylight context")
	runner._expect(slate.contains("Pressure: O2 12/30, health 64/100, depth 77m."), "slate presenter should show active pressure meters")
	runner._expect(slate.contains("Known build: Power Patch needs Scrap Metal x1."), "slate presenter should convert build choice into known build context")
	runner._expect(slate.contains("Route goal: Scan target or collect cargo"), "slate presenter should remove the route goal prefix once")
	runner._expect(slate.contains("Tab closes") and slate.contains("pressure is paused"), "slate presenter should preserve the pause rule")

func _test_expedition_slate_node_service(runner) -> void:
	var main := MainScript.new()
	var hud := CanvasLayer.new()
	hud.name = "HUD"
	main.add_child(hud)

	ExpeditionSlateNodeServiceScript.ensure_nodes(main)
	runner._expect(main.expedition_slate_panel != null and main.expedition_slate_panel.name == "ExpeditionSlatePanel", "expedition slate node service should create the slate panel")
	runner._expect(main.expedition_slate_title_label != null and main.expedition_slate_title_label.text == "EXPEDITION SLATE", "expedition slate node service should preserve slate title copy")
	runner._expect(main.expedition_slate_body_label != null and main.expedition_slate_body_label.clip_text, "expedition slate node service should create a clipped body label")
	runner._expect(main.expedition_slate_panel.get_parent() == hud, "expedition slate node service should attach the slate panel under HUD")
	var panel_count := hud.get_child_count()
	ExpeditionSlateNodeServiceScript.ensure_nodes(main)
	runner._expect(hud.get_child_count() == panel_count, "expedition slate node service should not duplicate nodes once created")
	main.free()

func _test_expedition_slate_context(runner) -> void:
	var main := MainScript.new()
	main.daylight_duration_seconds = 420.0
	main.daylight_elapsed_seconds = 210.0
	main.dive_session.reset(30.0, 100.0)
	main.dive_session.start()
	main.dive_session.oxygen = 12.0
	main.dive_session.health = 64.0
	main.dive_session.current_depth = 77.0
	main.dive_session.cargo_limit = 3
	main.dive_session.current_cargo = ["food_supply", "driftwood"]
	main.carried_tomorrow_intention = "bank Power supply soon to protect tomorrow's oxygen."

	var slate: String = ExpeditionSlatePresenterScript.format_slate_text_for_host(main)
	runner._expect(slate.contains("DAYLIGHT 03:30") and slate.contains("50% daylight left"), "slate should show remaining daylight context")
	runner._expect(slate.contains("O2 12/30") and slate.contains("health 64/100"), "slate should show active pressure meters")
	runner._expect(slate.contains("Cargo: 2 / 3 carried") and slate.contains("Food") and slate.contains("Wood"), "slate should show carried cargo and capacity")
	runner._expect(slate.contains("Base needs: Food") and slate.contains("Tonight: Food -1, Water -1, Power -1."), "slate should show night needs before the player returns")
	runner._expect(slate.contains("Known build:"), "slate should expose known build or upgrade context")
	runner._expect(slate.contains("Day plan: bank Power supply soon"), "slate should carry the broad next-day intention without adding checklist progress")
	runner._expect(slate.contains("Route goal:"), "slate should preserve the current expedition goal")
	runner._expect(slate.contains("surface for O2") and slate.contains("ship banks cargo"), "slate should help decide whether to keep diving or bank cargo")
	runner._expect(slate.contains("Tab closes") and slate.contains("pressure is paused"), "slate should explain its active-dive pause rule")
	main.free()

func _test_expedition_slate_pressure_pause(runner) -> void:
	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	scene.dive_session.start()
	scene.dive_session.oxygen = 20.0
	scene.dive_session.health = 100.0
	scene.dive_session.current_cargo = ["shell_fragments"]
	scene.daylight_duration_seconds = 420.0
	scene.daylight_elapsed_seconds = 100.0
	scene.player_in_base = false
	scene.player_in_surface_oxygen_refill = false
	scene.call("_update_hud")

	scene.call("_toggle_expedition_slate")
	var slate_panel: Panel = scene.get_node("HUD/ExpeditionSlatePanel")
	var slate_body: Label = scene.get_node("HUD/ExpeditionSlatePanel/Body")
	runner._expect(scene.expedition_slate_open, "Tab slate toggle should open during active diving")
	runner._expect(slate_panel.visible, "open slate should show its HUD panel")
	runner._expect(runner._control_rect(slate_panel).size == Vector2(580.0, 386.0), "slate panel should stay bounded and not become a full-screen overlay")
	runner._expect(slate_body.text.contains("pressure is paused"), "slate body should state the pause rule")
	runner._expect(not scene.player.is_physics_processing(), "open slate should freeze player movement along with active pressure")

	var oxygen_before: float = scene.dive_session.oxygen
	var daylight_before: float = scene.daylight_elapsed_seconds
	scene.call("_process", 10.0)
	runner._expect(is_equal_approx(scene.dive_session.oxygen, oxygen_before), "open slate should pause oxygen drain")
	runner._expect(is_equal_approx(scene.daylight_elapsed_seconds, daylight_before), "open slate should pause daylight pressure")

	scene.call("_toggle_expedition_slate")
	runner._expect(not scene.expedition_slate_open, "second slate toggle should close it")
	runner._expect(not slate_panel.visible, "closed slate should leave the active HUD sparse")
	runner._expect(scene.player.is_physics_processing(), "closing slate should restore player movement processing")
	scene.queue_free()
