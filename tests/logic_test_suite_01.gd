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

func _test_cargo_limit(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	runner._expect(session.add_cargo("kelp_fiber"), "first cargo slot should accept an item")
	runner._expect(session.add_cargo("shell_fragments"), "second cargo slot should accept an item")
	runner._expect(session.add_cargo("glow_plankton"), "third cargo slot should accept an item")
	runner._expect(not session.add_cargo("extra_resource"), "cargo should reject items beyond the limit")
	runner._expect(session.current_cargo.size() == session.cargo_limit, "cargo should stay at the configured limit")

func _test_upgraded_cargo_limit(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.cargo_limit = 4
	session.start()

	runner._expect(session.add_cargo("kelp_fiber"), "upgraded first cargo slot should accept an item")
	runner._expect(session.add_cargo("shell_fragments"), "upgraded second cargo slot should accept an item")
	runner._expect(session.add_cargo("glow_plankton"), "upgraded third cargo slot should accept an item")
	runner._expect(session.add_cargo("kelp_fiber"), "upgraded fourth cargo slot should accept an item")
	runner._expect(not session.add_cargo("extra_resource"), "upgraded cargo should reject items beyond four slots")
	session.fail()
	runner._expect(session.current_cargo.is_empty(), "oxygen failure should still discard upgraded cargo")

func _test_extraction_requirements(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	runner._expect(not session.can_extract(true), "player should not extract before leaving base")
	session.has_left_base = true
	runner._expect(not session.can_extract(false), "player should not extract away from base")
	runner._expect(session.can_extract(true), "player should extract only after leaving and returning to base")
	session.extract()
	runner._expect(session.result == DiveSessionScript.Result.EXTRACTED, "extract should set extracted result")

func _test_oxygen_failure(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(10.0)
	session.start()
	session.add_cargo("kelp_fiber")

	session.drain_oxygen(12.0)

	runner._expect(session.oxygen == 0.0, "oxygen should clamp to zero")
	runner._expect(session.result == DiveSessionScript.Result.FAILED, "oxygen depletion should fail the dive")
	runner._expect(session.current_cargo.is_empty(), "oxygen failure should discard current cargo")

func _test_health_feedback_presenter(runner) -> void:
	runner._expect(HealthFeedbackPresenterScript.format_damage_source_short("thermal vent heat") == "Thermal vent", "thermal vent damage source should be compact")
	runner._expect(HealthFeedbackPresenterScript.format_damage_source_short("") == "Damage", "empty damage source should fall back safely")
	runner._expect(HealthFeedbackPresenterScript.format_damage_status("thermal vent heat", 18.0).contains("-18 health"), "thermal vent damage copy should name the health loss amount")
	runner._expect(HealthFeedbackPresenterScript.format_damage_status("thermal vent heat", 18.0).contains("O2 unchanged"), "thermal vent damage copy should stay distinct from oxygen loss")
	runner._expect(HealthFeedbackPresenterScript.format_recovery_line(82.0, 100.0).contains("Health: 82/100 returned"), "night health recovery copy should report return health")
	runner._expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("health depleted by thermal vent") == "health depleted", "health failure copy should stay distinct from oxygen failure copy")
	runner._expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("predator warning ignored") == "oxygen depleted after predator contact", "predator failure copy should preserve oxygen framing")
	runner._expect(HealthFeedbackPresenterScript.format_failure_cause_for_player("none") == "oxygen depleted", "unknown failure causes should preserve oxygen fallback")

func _test_health_damage_and_vent_failure(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0, 100.0)
	session.start()
	session.oxygen = 18.0
	session.add_cargo("driftwood")

	session.damage_health(22.0)

	runner._expect(is_equal_approx(session.health, 78.0), "health damage should reduce health")
	runner._expect(is_equal_approx(session.oxygen, 18.0), "health damage should not spend oxygen")
	runner._expect(session.current_cargo == ["driftwood"], "nonfatal health damage should preserve carried cargo")
	runner._expect(session.result == DiveSessionScript.Result.DIVING, "nonfatal health damage should keep the dive active")

	session.refill_oxygen(20.0)
	runner._expect(is_equal_approx(session.oxygen, session.max_oxygen), "oxygen refill should still refill oxygen")
	runner._expect(is_equal_approx(session.health, 78.0), "oxygen refill should not heal health")

	session.damage_health(100.0)
	runner._expect(session.result == DiveSessionScript.Result.FAILED, "health reaching zero should fail the dive")
	runner._expect(session.current_cargo.is_empty(), "health failure should discard carried cargo")

	var main := MainScript.new()
	main.dive_session.reset(30.0, 100.0)
	main.dive_session.start()
	main.dive_session.oxygen = 24.0
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.dive_session.current_cargo.append("driftwood")
	main.thermal_vent_health_damage = 18.0
	SceneEventServiceScript.apply_health_damage(main, main.thermal_vent_health_damage, "thermal vent heat")
	runner._expect(is_equal_approx(main.dive_session.health, 82.0), "thermal vent damage should reduce health by the configured amount")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 24.0), "thermal vent damage should leave oxygen unchanged")
	runner._expect(main.run_health_damage_events == 1, "thermal vent damage should count as health damage telemetry")
	runner._expect(main.last_health_damage_source == "thermal vent heat", "thermal vent damage should record a distinct source")
	runner._expect(is_equal_approx(main.last_health_damage_amount, 18.0), "thermal vent damage should record the health loss amount")
	runner._expect(main.call("_format_active_objective_line").contains("Health hit"), "recent health damage should take over the generic active objective")
	runner._expect(main.call("_format_hud_prompt").contains("Surface O2 only"), "recent health damage prompt should say surfacing is oxygen-only")
	main.player_in_surface_oxygen_refill = true
	runner._expect(main.call("_format_active_objective_line").contains("O2 only"), "surface objective after damage should not imply healing")
	main.dive_session.current_cargo.append("food_supply")
	SceneEventServiceScript.apply_health_damage(main, 200.0, "thermal vent heat")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.FAILED, "fatal thermal vent damage should fail the dive")
	runner._expect(main.run_failure_cause.contains("health depleted"), "fatal thermal vent damage should record health as the failure cause")
	main.free()

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 19.0
	scene_main.dive_session.health = scene_main.dive_session.max_health
	SceneEventServiceScript.on_thermal_vent_hazard_body_entered(scene_main.player, scene_main)
	runner._expect(is_equal_approx(scene_main.dive_session.health, scene_main.dive_session.max_health - scene_main.thermal_vent_health_damage), "scene thermal vent collision should damage health")
	runner._expect(is_equal_approx(scene_main.dive_session.oxygen, 19.0), "scene thermal vent collision should not drain oxygen")
	runner._expect(scene_main.status_label.text.contains("-18 health"), "scene thermal vent feedback should show the health loss amount")
	runner._expect(scene_main.status_label.text.contains("O2 unchanged"), "scene thermal vent feedback should be distinct from oxygen warning copy")
	var health_bar_fill := scene_main.get_node("HUD/HealthBarFill") as ColorRect
	runner._expect(is_equal_approx(health_bar_fill.color.r, HudPresenterScript.HEALTH_DAMAGED_COLOR.r) and is_equal_approx(health_bar_fill.color.g, HudPresenterScript.HEALTH_DAMAGED_COLOR.g), "recent health damage should tint the health bar separately from oxygen")
	scene_main.queue_free()

func _test_health_damage_night_resolution_copy(runner) -> void:
	var damaged := MainScene.instantiate()
	runner.root.add_child(damaged)
	damaged.dive_session.start()
	damaged.dive_session.oxygen = damaged.dive_session.max_oxygen
	damaged.dive_session.has_left_base = true
	damaged.player_in_base = false
	damaged.progression_state.banked_resources = {
		"scrap_metal": 1,
	}
	SceneEventServiceScript.apply_health_damage(damaged, damaged.thermal_vent_health_damage, "thermal vent heat")
	damaged.player_in_base = true
	damaged.call("_try_extract")

	runner._expect(damaged.dive_session.result == DiveSessionScript.Result.EXTRACTED, "damaged return should still extract successfully")
	runner._expect(damaged.last_night_report.contains("Health: 82/100 returned"), "night report should record the damaged return health value")
	runner._expect(damaged.last_night_report.contains("no surface heal"), "night report should state that surfacing did not heal health")
	runner._expect(damaged.last_night_report.contains("night med used build time") and damaged.last_night_report.contains("tomorrow health full"), "night report should name the health recovery cost and payoff")
	runner._expect(damaged.last_result_summary.contains("no surface heal"), "result summary should carry the health resolution line through the night report")
	runner._expect(damaged.run_summary_label.text.contains("no surface heal"), "default Night tab should show the health resolution line")
	runner._expect(damaged.night_health_recovery_used_build_time, "damaged extraction should reserve the one-night build window for medical recovery")
	runner._expect(damaged.call("_format_night_build_choice_line").contains("Night med used build time"), "Night tab should show that medical recovery consumed the build choice")
	runner._expect(damaged.call("_format_night_build_prompt").contains("review night med"), "Night prompt should point at the medical recovery tradeoff")
	runner._expect(not bool(damaged.call("_try_craft_night_power_patch")), "Power Patch craft should wait when night medical recovery used the build window")
	runner._expect(damaged.progression_state.resource_count("scrap_metal") == 1, "blocked Power Patch should not spend banked scrap")
	runner._expect(not damaged.last_night_report.contains("Power Patch spent"), "blocked Power Patch should not append a false build result")
	runner._expect(is_equal_approx(damaged.dive_session.health, 82.0), "extraction should not instantly heal health before the next expedition reset")
	damaged.call("_restart_dive")
	runner._expect(is_equal_approx(damaged.dive_session.health, damaged.dive_session.max_health), "next expedition should start after the night medical recovery")
	runner._expect(not damaged.night_health_recovery_used_build_time, "new expedition should clear the medical build reservation")
	damaged.queue_free()

	var clean := MainScene.instantiate()
	runner.root.add_child(clean)
	clean.dive_session.start()
	clean.dive_session.has_left_base = true
	clean.player_in_base = true
	clean.call("_try_extract")

	runner._expect(not clean.last_night_report.contains("no surface heal"), "undamaged extraction should omit health resolution copy")
	runner._expect(not clean.last_result_summary.contains("no surface heal"), "undamaged result summary should omit health resolution copy")
	clean.queue_free()

func _test_surface_oxygen_refill_isolation(runner) -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()
	session.oxygen = 8.0
	session.has_left_base = true
	session.current_cargo.append("driftwood")

	session.refill_oxygen(7.0)

	runner._expect(is_equal_approx(session.oxygen, 15.0), "surface refill should increase oxygen without requiring extraction")
	runner._expect(session.result == DiveSessionScript.Result.DIVING, "surface refill should keep the dive active")
	runner._expect(session.current_cargo == ["driftwood"], "surface refill should preserve carried cargo")
	runner._expect(not session.can_extract(false), "surface refill away from the ship should not become extraction eligible")
	session.refill_oxygen(100.0)
	runner._expect(is_equal_approx(session.oxygen, session.max_oxygen), "surface refill should clamp at max oxygen")

	var main := MainScript.new()
	main.surface_oxygen_refill_per_second = 6.0
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 9.0
	main.dive_session.has_left_base = true
	main.dive_session.current_cargo.append("driftwood")
	main.player_in_base = false
	main.player_in_surface_oxygen_refill = true
	main.call("_update_active_dive_oxygen", 1.0)
	runner._expect(is_equal_approx(main.dive_session.oxygen, 15.0), "active dive oxygen tick should refill at open surface")
	runner._expect(main.dive_session.current_cargo == ["driftwood"], "active surface refill should not clear carried cargo")
	runner._expect(main.progression_state.banked_resources.is_empty(), "active surface refill should not bank resources")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "active surface refill should not resolve the dive")
	runner._expect(SurfaceStatusPresenterScript.surface_oxygen_status_text(false, main.dive_session.oxygen, main.dive_session.max_oxygen, "E/Enter") == "Surface O2 refilling; ship still banks cargo.", "surface status should distinguish oxygen refill from ship banking")
	var surface_prompt: String = main.call("_format_hud_prompt")
	runner._expect(surface_prompt.contains("O2 refill") and surface_prompt.contains("Cargo 1/3") and surface_prompt.contains("Ship banks"), "surface prompt should separate oxygen refill from cargo banking and show carried capacity")
	main.player_in_base = true
	var ship_prompt: String = main.call("_format_hud_prompt")
	runner._expect(ship_prompt.contains("At ship") and ship_prompt.contains("offload cargo 1/3") and ship_prompt.contains("O2 full"), "ship prompt should remain the cargo banking/offload prompt with capacity")
	main.free()

func _test_surface_status_presenter(runner) -> void:
	runner._expect(
		SurfaceStatusPresenterScript.surface_oxygen_status_text(true, 12.0, 30.0, "E/Enter") == "Ship moonpool: O2 full; E/Enter banks cargo.",
		"ship moonpool surface status should preserve offload action copy"
	)
	runner._expect(
		SurfaceStatusPresenterScript.surface_oxygen_status_text(false, 30.0, 30.0, "E/Enter") == "Surface O2 full; ship still banks cargo.",
		"full surface oxygen status should separate oxygen from ship banking"
	)
	runner._expect(
		SurfaceStatusPresenterScript.surface_oxygen_status_text(false, 12.0, 30.0, "E/Enter") == "Surface O2 refilling; ship still banks cargo.",
		"refilling surface oxygen status should preserve ship banking reminder"
	)
	runner._expect(
		SurfaceStatusPresenterScript.cargo_full_status_text(3, 3) == "Cargo full 3/3: return to ship.",
		"cargo full status should preserve capacity copy"
	)

func _test_ship_offload_repeat_daylight_sortie(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 6.0
	main.dive_session.health = 64.0
	main.dive_session.has_left_base = true
	main.dive_session.current_cargo.append("driftwood")
	main.dive_session.current_cargo.append("food_supply")
	main.player_in_base = true
	main.daylight_elapsed_seconds = 123.0
	main.daylight_nightfall_announced = false
	var starting_day: int = main.survival_state.current_day
	var starting_water := main.survival_state.water
	var starting_power := main.survival_state.power

	runner._expect(bool(main.call("_try_ship_offload")), "ship offload should accept carried cargo during active daylight")

	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "ship offload should keep the same daylight dive active")
	runner._expect(main.dive_session.current_cargo.is_empty(), "ship offload should clear carried inventory")
	runner._expect(is_equal_approx(main.dive_session.oxygen, main.dive_session.max_oxygen), "ship offload should leave oxygen ready for the next sortie")
	runner._expect(is_equal_approx(main.dive_session.health, 64.0), "ship offload should not heal health")
	runner._expect(main.progression_state.resource_count("driftwood") == 1, "ship offload should bank resource cargo")
	runner._expect(main.survival_state.food == SurvivalStateScript.STARTING_NEED + 1, "ship offload should bank survival supplies without waiting for night")
	runner._expect(main.survival_state.water == starting_water and main.survival_state.power == starting_power, "ship offload should only change supplied survival needs")
	runner._expect(main.survival_state.current_day == starting_day, "ship offload should not resolve the night or advance the survival day")
	runner._expect(is_equal_approx(main.daylight_elapsed_seconds, 123.0), "ship offload should preserve the current daylight timer")
	runner._expect(main.daylight_ship_offload_count == 1, "ship offload should count repeated daylight sorties")
	runner._expect(main.last_completed_survival_day == 0, "ship offload should not mark the day as completed")
	runner._expect(main.status_label.text == "Ship banked cargo; O2 full. Dive again.", "ship offload status should be concise enough for the active HUD row")
	var clear_prompt: String = main.call("_format_hud_prompt")
	runner._expect(clear_prompt.contains("cargo banked") and clear_prompt.contains("O2 full") and clear_prompt.contains("dive again"), "ship prompt should invite another sortie after offload")
	runner._expect(main.upgrade_menu_feedback.contains("Ship offload banked 2 cargo item") and main.upgrade_menu_feedback.contains("Oxygen full"), "ship offload feedback should explain cargo banking, oxygen refill, and continued daylight")

	main.dive_session.current_cargo.append("driftwood")
	main.daylight_nightfall_announced = true
	runner._expect(not bool(main.call("_try_ship_offload")), "nightfall should stop daylight offload and leave night-start handling separate")
	runner._expect(main.dive_session.current_cargo == ["driftwood"], "rejected nightfall offload should leave carried cargo untouched")
	main.free()
