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

func _test_daylight_cargo_visual_staging_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen)
	if main.status_label == null:
		main.status_label = Label.new()
		main.add_child(main.status_label)

	DaylightCargoVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Daylight Cargo staging should start or keep the daylight dive active")
	runner._expect(main.visual_smoke_route_stage == "daylight_cargo_warning", "Daylight Cargo staging should expose the deterministic warning stage")
	runner._expect(main.dive_session.current_cargo == ["driftwood"], "Daylight Cargo staging should seed one carried resource when cargo is empty")
	runner._expect(main.dive_session.has_left_base, "Daylight Cargo staging should mark the sortie as active")
	runner._expect(not main.player_in_base, "Daylight Cargo staging should keep the player away from the ship")
	runner._expect(is_equal_approx(main._daylight_remaining_ratio(), main.LATE_DAY_CARGO_WARNING_RATIO), "Daylight Cargo staging should preserve the late-day warning threshold")
	runner._expect(main._should_warn_late_day_cargo_banking(), "Daylight Cargo staging should trigger the existing cargo-banking warning helper")
	runner._expect(main.status_label.text == "Dusk cargo: bank before night.", "Daylight Cargo staging should preserve status copy")
	main.queue_free()

func _test_health_damage_visual_staging_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen, main.max_health)
	if main.status_label == null:
		main.status_label = Label.new()
		main.add_child(main.status_label)

	HealthDamageVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Health Damage staging should start or keep the daylight dive active")
	runner._expect(main.visual_smoke_route_stage == "thermal_vent_health_damage", "Health Damage staging should expose the deterministic review stage")
	runner._expect(main.run_health_damage_events == 1, "Health Damage staging should route through the normal damage telemetry")
	runner._expect(main.last_health_damage_source == "thermal vent heat", "Health Damage staging should preserve the thermal vent source")
	runner._expect(is_equal_approx(main.dive_session.health, main.dive_session.max_health - main.thermal_vent_health_damage), "Health Damage staging should apply configured thermal vent health loss")
	runner._expect(is_equal_approx(main.dive_session.oxygen, main.dive_session.max_oxygen), "Health Damage staging should keep oxygen full for the review capture")
	runner._expect(main.dive_session.unlimited_oxygen, "Health Damage staging should preserve unlimited oxygen review mode")
	runner._expect(not main.player_in_base, "Health Damage staging should move the player away from the ship")
	runner._expect(main.dive_session.has_left_base, "Health Damage staging should mark the sortie as active")
	main.queue_free()

func _test_health_damage_extraction_visual_staging_service(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.reset(main.max_oxygen, main.max_health)
	if main.status_label == null:
		main.status_label = Label.new()
		main.add_child(main.status_label)

	HealthDamageVisualStagingServiceScript.stage_extraction_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.EXTRACTED, "Health Damage extraction staging should extract through the normal result path")
	runner._expect(main.visual_smoke_route_stage == "health_damage_extracted", "Health Damage extraction staging should expose the deterministic result stage")
	runner._expect(main.run_health_damage_events == 1, "Health Damage extraction staging should include the staged damage event")
	runner._expect(main.last_result_summary.contains("no surface heal"), "Health Damage extraction staging should preserve health recovery result copy")
	runner._expect(main.last_night_report.contains("Health:"), "Health Damage extraction staging should resolve the night health report")
	runner._expect(main.player_in_base, "Health Damage extraction staging should place the player at the ship before extracting")
	main.queue_free()

func _test_expanded_route_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.visual_smoke_route_stage = ""

	ExpandedRouteVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Expanded Route staging should stay inert outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "Expanded Route staging should not set route state outside web visual smoke")
	runner._expect(main.dive_session.current_cargo.is_empty(), "Expanded Route staging should not mutate cargo outside web visual smoke")
	main.free()

func _test_silt_vein_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.visual_smoke_route_stage = ""

	SiltVeinVisualStagingServiceScript.stage_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Silt Vein staging should stay inert outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "Silt Vein staging should not set route state outside web visual smoke")
	runner._expect(not main.dive_session.has_left_base, "Silt Vein staging should not mark route progress outside web visual smoke")
	main.free()

func _test_dusk_trench_payoff_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.visual_smoke_route_stage = ""

	DuskTrenchVisualStagingServiceScript.stage_payoff_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Dusk Trench payoff staging should stay inert outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "Dusk Trench payoff staging should not set route state outside web visual smoke")
	runner._expect(not main.run_reached_dusk_trench, "Dusk Trench payoff staging should not set route memory outside web visual smoke")
	main.free()

func _test_hollow_reef_payoff_visual_staging_service(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.visual_smoke_route_stage = ""

	HollowReefVisualStagingServiceScript.stage_payoff_visual_review(main)
	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Hollow Reef payoff staging should stay inert outside web visual smoke")
	runner._expect(main.visual_smoke_route_stage == "", "Hollow Reef payoff staging should not set route state outside web visual smoke")
	runner._expect(not main.run_hollow_reef_reading_recovered, "Hollow Reef payoff staging should not recover reading state outside web visual smoke")
	main.free()

func _test_scanner_target_resolver(runner) -> void:
	var farther_a = runner._make_scan_target("alpha", "Alpha", Vector2(10.0, 0.0))
	var farther_b = runner._make_scan_target("beta", "Beta", Vector2(10.0, 0.0))
	var nearest = runner._make_scan_target("gamma", "Gamma", Vector2(3.0, 0.0))
	var targets: Array[Node] = [farther_b, nearest, farther_a]

	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	runner._expect(selected == nearest, "scanner resolver should choose the nearest target")
	runner._expect(ScanTargetResolverScript.target_id(selected) == "gamma", "scanner resolver should expose target discovery id")
	runner._expect(ScanTargetResolverScript.display_name(selected) == "Gamma", "scanner resolver should expose target display name")

	targets = [farther_b, farther_a]
	selected = ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	runner._expect(selected == farther_a, "scanner resolver should break equal-distance ties by id")
	runner._expect(ScanTargetResolverScript.nearest(Vector2.ZERO, 2.0, targets) == null, "scanner resolver should ignore targets outside range")
	farther_a.free()
	farther_b.free()
	nearest.free()

func _test_scan_hold_timing_helper(runner) -> void:
	var main := MainScript.new()
	var target = runner._make_scan_target("thermal_vent", "Thermal Vent", Vector2.ZERO)
	main.scan_hold_seconds = 1.0
	main.scan_charge_elapsed = 0.35

	runner._expect(is_equal_approx(ScanFeedbackPresenterScript.scan_charge_ratio(main.scan_charge_elapsed, main.scan_hold_seconds), 0.35), "scan hold ratio should report partial progress")
	var scan_charge_status := ScanFeedbackPresenterScript.format_scan_charge_target_status(target, main.scan_charge_elapsed, main.scan_hold_seconds)
	runner._expect(scan_charge_status.contains("Thermal Vent: 35%"), "scan hold status should show target name and progress")
	runner._expect(ScanFeedbackPresenterScript.format_scan_charge_status("Thermal Vent", 0.35) == "Scanning Thermal Vent: 35%", "scan feedback presenter should format charge status")
	runner._expect(ScanFeedbackPresenterScript.format_wreck_cache_repeat_hint(true, true).contains("Echo Lens"), "scan feedback presenter should prioritize Echo Lens cache hints")
	runner._expect(ScanFeedbackPresenterScript.format_signal_lens_pulse_text(true, true, false, "", "Kelp Fiber").contains("quiet"), "scan feedback presenter should preserve quiet Signal Lens copy")
	runner._expect(ScanFeedbackPresenterScript.format_direction_to(Vector2.ZERO, Vector2(96.0, 96.0)) == "deeper-right", "scan feedback presenter should format directional hints")
	runner._expect(ScanFeedbackPresenterScript.format_first_scan_guidance("pressure_wreck_signal", false, "", 0, 3, false).contains("Locked: buy Pressure Seal I"), "scan feedback presenter should preserve pressure-locked guidance")
	runner._expect(ScanFeedbackPresenterScript.format_scan_target_type("lantern_ray", false) == "creature", "scan feedback presenter should classify creature scan targets")
	main.scan_charge_elapsed = 1.5
	runner._expect(is_equal_approx(ScanFeedbackPresenterScript.scan_charge_ratio(main.scan_charge_elapsed, main.scan_hold_seconds), 1.0), "scan hold ratio should clamp completed progress")
	main.scan_hold_seconds = 0.0
	runner._expect(is_equal_approx(ScanFeedbackPresenterScript.scan_charge_ratio(main.scan_charge_elapsed, main.scan_hold_seconds), 1.0), "scan hold ratio should treat zero-duration scans as complete")

	target.free()
	main.free()

func _test_compact_scan_marker(runner) -> void:
	var scannable := ScannableScript.new()
	var marker := Polygon2D.new()
	marker.name = "ScanMarker"
	scannable.add_child(marker)
	scannable._ready()

	runner._expect(marker.polygon.size() == 8, "compact scan marker should use the standard diamond polygon")
	runner._expect(marker.polygon == ReadabilityMarkerPatternsScript.scan_marker_polygon(), "compact scan marker should use shared marker pattern data")
	runner._expect(marker.color.a < 0.3, "compact scan marker should be subtle while idle")
	runner._expect(scannable.get_node_or_null("ScanFocusBracketA") != null, "compact scan marker should create first focus bracket")
	runner._expect(scannable.get_node_or_null("ScanFocusBracketB") != null, "compact scan marker should create second focus bracket")

	scannable.set_scan_selected(true)
	runner._expect(marker.color.a > 0.5, "selected compact scan marker should brighten")
	scannable.free()

func _test_lantern_ray_scan_behavior(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var lantern_ray := main.get_node("Creatures/LanternRayRoute") as Area2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	lantern_ray.call("_ready")
	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = lantern_ray.global_position

	runner._expect(lantern_ray.is_in_group("scan_targets"), "Lantern Ray should register as a scan target once the scene is ready")
	var scan_candidates: Array[Node] = [lantern_ray]
	runner._expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == lantern_ray, "scanner target selection should find Lantern Ray reliably at close range")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, lantern_ray) == "creature", "Lantern Ray scan target should read as a creature")
	runner._expect(ScanTargetResolverScript.target_id(lantern_ray) == "lantern_ray", "Lantern Ray should expose a stable discovery id")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = ScanTargetResolverScript.target_id(lantern_ray)
	var display_name: String = ScanTargetResolverScript.display_name(lantern_ray)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(lantern_ray),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(main, lantern_ray)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, lantern_ray) + ScanEffectTextServiceScript.first_scan_guidance(main, lantern_ray)
	])
	var first_scan_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, lantern_ray)
	runner._expect(main.progression_state.has_discovery("lantern_ray"), "first Lantern Ray scan should record a durable discovery")
	runner._expect(main.run_completed_scans == ["lantern_ray"], "first Lantern Ray scan should count as current-run scan evidence")
	runner._expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Lantern Ray scan should use the normal scan oxygen cost")
	runner._expect(first_scan_status.contains("Scanned Lantern Ray"), "first Lantern Ray scan status should name the creature")
	runner._expect(first_scan_guidance.contains("Observe its calm pass"), "first Lantern Ray scan guidance should stay route-observation focused")

	var no_cargo: Array[String] = []
	var summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, no_cargo)
	runner._expect(summary.contains("Lantern Ray"), "Lantern Ray scan should appear in scan/discovery result copy")
	runner._expect_no_monster_combat_language(summary, "Lantern Ray scan result copy")
	runner._expect(not summary.to_lower().contains("field guide"), "Lantern Ray scan result should not imply field-guide UI")
	runner._expect(not summary.to_lower().contains("checklist"), "Lantern Ray scan result should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, lantern_ray) + ScanEffectTextServiceScript.signal_lens_pulse_text(main, lantern_ray)
	])
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Lantern Ray scan should stay free like existing known scans")
	runner._expect(main.run_completed_scans == ["lantern_ray"], "repeat Lantern Ray scan should not duplicate current-run scan evidence")
	runner._expect(repeat_scan_status.contains("Lantern Ray known"), "repeat Lantern Ray scan should use compact known-target copy")
	runner._expect(repeat_scan_status.contains("observation refreshed"), "repeat Lantern Ray scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved.get("scan_discoveries", {}).has("lantern_ray"), "Lantern Ray discovery should persist through normal scan discovery storage")
	runner._expect(not saved.has("lantern_ray_objective"), "Lantern Ray scan should not create durable objective-chain state")
	runner._expect(not saved.has("monster_parts"), "Lantern Ray scan should not add monster-part economy state")
	runner._expect(not saved.has("creature_inventory"), "Lantern Ray scan should not add creature inventory state")
	main.queue_free()
