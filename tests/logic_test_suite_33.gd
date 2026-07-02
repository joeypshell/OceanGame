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

func _test_hud_presenter(runner) -> void:
	runner._expect(HudPresenterScript.format_oxygen_label(40.0, 40.0) == "OXYGEN: 40 / 40", "full oxygen label should keep exact active HUD copy")
	runner._expect(HudPresenterScript.format_oxygen_label(11.0, 40.0) == "OXYGEN: 11 / 40", "normal partial oxygen label should not add a warning suffix")
	runner._expect(HudPresenterScript.format_oxygen_label(10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	runner._expect(HudPresenterScript.format_oxygen_label(4.0, 40.0).contains("CRITICAL"), "oxygen label should carry critical state inline")
	runner._expect(HudPresenterScript.format_oxygen_label(0.0, 40.0).contains("CRITICAL"), "empty oxygen should stay critical")
	runner._expect(HudPresenterScript.format_oxygen_label(10.0, 0.0) == "OXYGEN: 10 / 0", "max-zero oxygen label should keep safe normal-state copy")

	runner._expect(HudPresenterScript.oxygen_state(40.0, 40.0) == "normal", "full oxygen state should be normal")
	runner._expect(HudPresenterScript.oxygen_state(11.0, 40.0) == "normal", "oxygen above low threshold should be normal")
	runner._expect(HudPresenterScript.oxygen_state(10.0, 40.0) == "low", "oxygen at low threshold should be low")
	runner._expect(HudPresenterScript.oxygen_state(4.0, 40.0) == "critical", "oxygen at critical threshold should be critical")
	runner._expect(HudPresenterScript.oxygen_state(10.0, 0.0) == "normal", "max-zero oxygen state should stay safe")

	runner._expect(HudPresenterScript.oxygen_warning_text("normal") == "", "normal oxygen should not show a warning")
	runner._expect(HudPresenterScript.oxygen_warning_text("low") == "O2 LOW\nPLAN RETURN", "low oxygen warning copy should stay exact")
	runner._expect(HudPresenterScript.oxygen_warning_text("critical") == "O2 CRITICAL\nRETURN TO BASE", "critical oxygen warning copy should stay exact")
	runner._expect(HudPresenterScript.oxygen_warning_text("empty") == "", "unknown oxygen states should not show warning copy")

	runner._expect(HudPresenterScript.oxygen_state_color("normal") == Color.WHITE, "normal oxygen color should stay white")
	runner._expect(HudPresenterScript.oxygen_state_color("low") == Color(1.0, 0.76, 0.22, 1.0), "low oxygen color should stay exact")
	runner._expect(HudPresenterScript.oxygen_state_color("critical") == Color(1.0, 0.18, 0.12, 1.0), "critical oxygen color should stay exact")

	runner._expect(HudPresenterScript.format_health_label(100.0, 100.0) == "HEALTH: 100 / 100", "full health label should keep exact active HUD copy")
	runner._expect(HudPresenterScript.format_health_label(30.0, 100.0).contains("LOW"), "health label should carry low state inline")
	runner._expect(HudPresenterScript.format_health_label(12.0, 100.0).contains("CRITICAL"), "health label should carry critical state inline")
	runner._expect(HudPresenterScript.health_state(100.0, 100.0) == "normal", "full health state should be normal")
	runner._expect(HudPresenterScript.health_state(30.0, 100.0) == "low", "health below low threshold should be low")
	runner._expect(HudPresenterScript.health_state(18.0, 100.0) == "critical", "health at critical threshold should be critical")
	runner._expect(HudPresenterScript.health_state(10.0, 0.0) == "normal", "max-zero health state should stay safe")
	runner._expect(HudPresenterScript.health_state_color("normal") == HudPresenterScript.HEALTH_NORMAL_COLOR, "normal health color should stay exact")
	runner._expect(HudPresenterScript.health_state_color("low") == HudPresenterScript.HEALTH_LOW_COLOR, "low health color should stay exact")
	runner._expect(HudPresenterScript.health_state_color("critical") == HudPresenterScript.HEALTH_CRITICAL_COLOR, "critical health color should stay exact")

	runner._expect(HudPresenterScript.format_daylight_label(420.0) == "DAYLIGHT 07:00", "full daylight label should stay exact")
	runner._expect(HudPresenterScript.format_daylight_label(210.0) == "DAYLIGHT 03:30", "partial daylight label should stay exact")
	runner._expect(HudPresenterScript.format_daylight_label(0.0) == "NIGHTFALL", "depleted daylight label should show nightfall")
	runner._expect(HudPresenterScript.daylight_bar_color(0.26) == HudPresenterScript.DAYLIGHT_NORMAL_COLOR, "daylight safe color should stay exact above dusk threshold")
	runner._expect(HudPresenterScript.daylight_bar_color(0.25) == HudPresenterScript.DAYLIGHT_DUSK_COLOR, "daylight dusk color should start at threshold")

	var short_status := "Scanned Shell Reef."
	runner._expect(HudPresenterScript.compact_dive_status("  %s  " % short_status) == short_status, "compact status should trim short copy")
	runner._expect(HudPresenterScript.compact_dive_status("Line one\nLine two") == "Line one Line two", "compact status should flatten newlines")
	var long_status := "Scanned a very long target description that would otherwise overrun the active dive HUD status row and collide with nearby panels."
	var compact_status := HudPresenterScript.compact_dive_status(long_status)
	runner._expect(compact_status.length() <= 72, "compact status should keep active HUD copy within the row")
	runner._expect(compact_status.ends_with("..."), "compact status should mark truncated copy")
	runner._expect(HudPresenterScript.format_active_objective_line({"cargo_count": 3, "cargo_limit": 3}, 46) == "Cargo full: return to bank", "active objective presenter should prioritize full cargo")
	runner._expect(HudPresenterScript.format_active_objective_line({"player_in_base": true, "has_left_base": true, "can_ship_offload": true, "cargo_count": 1, "cargo_limit": 3}, 46) == "At ship: offload, O2 full", "active objective presenter should show ship offload when available")
	runner._expect(HudPresenterScript.format_active_objective_line({"player_in_surface_oxygen_refill": true, "has_recent_health_damage": true, "cargo_count": 0, "cargo_limit": 3}, 46) == "Surface: O2 only; health stays", "active objective presenter should not imply surface healing")
	runner._expect(HudPresenterScript.format_active_objective_line({"survival_need_low": true, "cargo_count": 0, "cargo_limit": 3}, 46) == "Prioritize food, water, power", "active objective presenter should surface low base needs")
	runner._expect(HudPresenterScript.format_active_objective_line({"has_scan_target": true, "cargo_count": 0, "cargo_limit": 3}, 46) == "Scan target or collect cargo", "active objective presenter should fall back to scan target guidance")
	runner._expect(HudPresenterScript.format_base_direction(Vector2.ZERO, Vector2.ZERO, 40.0) == "Base: here", "base direction presenter should show nearby base copy")
	runner._expect(HudPresenterScript.format_base_direction(Vector2(400.0, 400.0), Vector2.ZERO, 40.0).begins_with("Base: up-left"), "base direction presenter should name broad return direction")
	runner._expect(HudPresenterScript.format_base_direction(Vector2(4300.0, 2700.0), Vector2.ZERO, 40.0).contains("via Mirror/Wide/Hollow"), "base direction presenter should preserve far-route hint copy")

func _test_hud_instrument_bar_service(runner) -> void:
	var main := MainScript.new()
	main.oxygen_bar_fill = ColorRect.new()
	main.health_bar_fill = ColorRect.new()
	main.depth_bar_fill = ColorRect.new()
	main.dive_session.reset(40.0, 100.0)
	main.dive_session.start()
	main.dive_session.oxygen = 20.0
	main.dive_session.health = 82.0
	main.dive_session.current_depth = 100.0
	main.run_health_damage_events = 1

	HudInstrumentBarServiceScript.update_bars(main)
	var oxygen_width := main.oxygen_bar_fill.offset_right - main.oxygen_bar_fill.offset_left
	var health_width := main.health_bar_fill.offset_right - main.health_bar_fill.offset_left
	var depth_width := main.depth_bar_fill.offset_right - main.depth_bar_fill.offset_left
	runner._expect(is_equal_approx(oxygen_width, main.OXYGEN_BAR_FILL_RECT.size.x * 0.5), "instrument bars should scale oxygen fill by oxygen ratio")
	runner._expect(is_equal_approx(health_width, main.HEALTH_BAR_FILL_RECT.size.x * 0.82), "instrument bars should scale health fill by health ratio")
	runner._expect(is_equal_approx(depth_width, main.DEPTH_BAR_FILL_RECT.size.x * 0.5), "instrument bars should scale depth fill by display depth ratio")
	runner._expect(main.health_bar_fill.color == HudPresenterScript.HEALTH_DAMAGED_COLOR, "instrument bars should preserve recent-damage health color")
	main.free()

func _test_daylight_timer_hud_service(runner) -> void:
	var main := MainScript.new()
	main.daylight_panel = Panel.new()
	main.daylight_label = Label.new()
	main.daylight_bar_back = ColorRect.new()
	main.daylight_bar_fill = ColorRect.new()
	main.daylight_sun_icon = Polygon2D.new()
	main.daylight_moon_icon = Polygon2D.new()
	main.daylight_duration_seconds = 420.0
	main.daylight_elapsed_seconds = 210.0

	DaylightTimerHudServiceScript.update_timer(main, true)
	var fill_width := main.daylight_bar_fill.offset_right - main.daylight_bar_fill.offset_left
	runner._expect(main.daylight_panel.visible and main.daylight_label.visible and main.daylight_bar_fill.visible, "visible daylight timer should show the timer nodes")
	runner._expect(main.daylight_label.text == "DAYLIGHT 03:30", "daylight timer service should preserve remaining time copy")
	runner._expect(main.daylight_label.modulate == HudPresenterScript.daylight_bar_color(0.5), "daylight timer service should tint label from daylight color state")
	runner._expect(main.daylight_bar_fill.color == HudPresenterScript.daylight_bar_color(0.5), "daylight timer service should tint fill from daylight color state")
	runner._expect(is_equal_approx(fill_width, main.DAYLIGHT_BAR_FILL_RECT.size.x * 0.5), "daylight timer service should scale fill by remaining ratio")
	runner._expect(is_equal_approx(main.daylight_sun_icon.color.a, 0.32 + 0.5 * 0.62), "daylight sun icon opacity should track remaining day")
	runner._expect(is_equal_approx(main.daylight_moon_icon.color.a, 0.34 + 0.5 * 0.58), "daylight moon icon opacity should track remaining night")

	DaylightTimerHudServiceScript.update_timer(main, false)
	runner._expect(not main.daylight_panel.visible and not main.daylight_label.visible and not main.daylight_bar_fill.visible, "hidden daylight timer should hide the timer nodes")
	main.free()

func _test_scan_effect_text_service(runner) -> void:
	var main := MainScript.new()
	var player := CharacterBody2D.new()
	main.player = player
	player.global_position = Vector2.ZERO

	var vent = runner._make_scan_target("thermal_vent", "Thermal Vent", Vector2.ZERO)
	runner._expect(ScanEffectTextServiceScript.first_scan_guidance(main, vent).contains("Pressure Seal clue"), "scan effect text service should preserve thermal vent first-scan guidance")
	runner._expect(ScanEffectTextServiceScript.repeat_scan_effect_text(main, vent).contains("glow route optional"), "scan effect text service should preserve thermal vent repeat guidance")

	var wreck_cache = runner._make_scan_target("wreck_signal_cache", "Wreck Signal Cache", Vector2.ZERO)
	runner._expect(ScanEffectTextServiceScript.wreck_cache_repeat_hint(main).contains("Signal Lens I"), "scan effect text service should preserve pre-upgrade wreck cache hint")
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	runner._expect(ScanEffectTextServiceScript.repeat_scan_effect_text(main, wreck_cache).contains("deeper wreck signals"), "scan effect text service should preserve Signal Lens wreck-cache copy")
	runner._expect(ScanEffectTextServiceScript.signal_lens_pulse_text(main, wreck_cache) == "", "scan effect text service should not show resource pulse copy for wreck cache")

	var pressure_lock = runner._make_scan_target("pressure_wreck_signal", "Pressure-Locked Research Wreck", Vector2.ZERO)
	runner._expect(ScanEffectTextServiceScript.first_scan_guidance(main, pressure_lock).contains("Locked: buy Pressure Seal I"), "scan effect text service should preserve pressure-lock upgrade guidance")
	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	runner._expect(ScanEffectTextServiceScript.first_scan_guidance(main, pressure_lock).contains("scan cache"), "scan effect text service should preserve pressure-open cache guidance")
	runner._expect(ScanEffectTextServiceScript.direction_to(main, Vector2(96.0, 96.0)) == "deeper-right", "scan effect text service should preserve direction copy")

	vent.free()
	wreck_cache.free()
	pressure_lock.free()
	player.free()
	main.free()

func _test_oxygen_feedback_service(runner) -> void:
	var main := MainScript.new()
	main.oxygen_warning_panel = Panel.new()
	main.oxygen_warning_label = Label.new()
	main.oxygen_label = Label.new()
	main.base_direction_label = Label.new()
	main.dive_session.reset(40.0, 100.0)

	OxygenFeedbackServiceScript.update_feedback(main)
	runner._expect(not main.oxygen_warning_panel.visible, "oxygen feedback should stay hidden outside an active dive")
	runner._expect(main.oxygen_label.modulate == Color.WHITE and main.base_direction_label.modulate == Color.WHITE, "oxygen feedback should reset active HUD colors")

	main.dive_session.start()
	main.dive_session.oxygen = 10.0
	OxygenFeedbackServiceScript.update_feedback(main)
	runner._expect(main.oxygen_warning_panel.visible, "low oxygen should show warning panel")
	runner._expect(main.oxygen_warning_label.text == "O2 LOW\nPLAN RETURN", "low oxygen warning copy should stay exact")
	runner._expect(main.oxygen_label.modulate == HudPresenterScript.oxygen_state_color("low"), "low oxygen should tint oxygen label")
	runner._expect(main.base_direction_label.modulate == Color(1.0, 0.86, 0.36, 1.0), "low oxygen should tint base direction amber")
	runner._expect(main.oxygen_label.scale == Vector2.ONE, "low oxygen should not pulse scale")

	main.dive_session.oxygen = 4.0
	OxygenFeedbackServiceScript.update_feedback(main)
	runner._expect(main.oxygen_warning_label.text == "O2 CRITICAL\nRETURN TO BASE", "critical oxygen warning copy should stay exact")
	runner._expect(main.oxygen_label.modulate == HudPresenterScript.oxygen_state_color("critical"), "critical oxygen should tint oxygen label")
	runner._expect(main.base_direction_label.modulate == Color(1.0, 0.22, 0.14, 1.0), "critical oxygen should tint base direction red")
	runner._expect(main.oxygen_label.scale.x >= 1.0 and main.oxygen_label.scale.x <= 1.08, "critical oxygen pulse should stay within current scale range")
	main.free()

func _test_health_feedback_service(runner) -> void:
	var main := MainScript.new()
	main.health_label = Label.new()
	main.health_icon = Polygon2D.new()
	main.dive_session.reset(40.0, 100.0)

	HealthFeedbackServiceScript.update_feedback(main)
	runner._expect(main.health_label.modulate == Color.WHITE and main.health_icon.modulate == Color.WHITE, "health feedback should reset inactive HUD color")
	runner._expect(main.health_label.scale == Vector2.ONE, "health feedback should reset inactive HUD scale")

	main.dive_session.start()
	main.dive_session.health = 30.0
	HealthFeedbackServiceScript.update_feedback(main)
	runner._expect(main.health_label.modulate == HudPresenterScript.health_state_color("low"), "low health should tint health label")
	runner._expect(main.health_icon.modulate == HudPresenterScript.health_state_color("low"), "low health should tint health icon")
	runner._expect(main.health_label.scale == Vector2.ONE, "low health should not pulse scale")

	main.dive_session.health = 12.0
	HealthFeedbackServiceScript.update_feedback(main)
	runner._expect(main.health_label.modulate == HudPresenterScript.health_state_color("critical"), "critical health should tint health label")
	runner._expect(main.health_icon.modulate == HudPresenterScript.health_state_color("critical"), "critical health should tint health icon")
	runner._expect(main.health_label.scale.x >= 1.0 and main.health_label.scale.x <= 1.07, "critical health pulse should stay within current scale range")

	main.dive_session.health = 82.0
	main.run_health_damage_events = 1
	HealthFeedbackServiceScript.update_feedback(main)
	runner._expect(main.health_label.modulate == HudPresenterScript.HEALTH_DAMAGED_COLOR, "recent damage should tint normal health label")
	runner._expect(main.health_icon.modulate == HudPresenterScript.HEALTH_DAMAGED_COLOR, "recent damage should tint normal health icon")
	main.free()

func _test_scan_target_card_service(runner) -> void:
	var main := MainScript.new()
	main.scan_card_title_label = Label.new()
	main.scan_target_label = Label.new()
	main.scan_card_meta_label = Label.new()
	main.scan_card_prompt_label = Label.new()

	ScanTargetCardServiceScript.update_card(main, null)
	runner._expect(main.scan_card_title_label.text == "SCAN TARGET", "scan target card title should stay exact")
	runner._expect(main.scan_target_label.text == "none nearby", "scan target card should preserve no-target copy")
	runner._expect(main.scan_card_meta_label.text == "No readable signal", "scan target card should preserve no-signal copy")
	runner._expect(main.scan_card_prompt_label.text.contains("near a target"), "scan target card should preserve no-target prompt")

	var target = runner._make_scan_target("thermal_vent", "Thermal Vent", Vector2.ZERO)
	ScanTargetCardServiceScript.update_card(main, target)
	runner._expect(main.scan_target_label.text == "Thermal Vent", "scan target card should show target display name")
	runner._expect(main.scan_card_meta_label.text == "NEW | ENVIRONMENT", "scan target card should preserve target metadata copy")
	runner._expect(main.scan_card_prompt_label.text == "HOLD F TO SCAN", "scan target card should preserve scan prompt copy")
	target.free()
	main.free()

func _test_scan_target_feedback_service(runner) -> void:
	var main := MainScript.new()
	var player := CharacterBody2D.new()
	main.player = player
	player.global_position = Vector2(100.0, 100.0)
	main.scan_range = 120.0

	var target = runner._make_scan_target("thermal_vent", "Thermal Vent", Vector2(150.0, 100.0))
	main.current_scan_target = target
	runner._expect(ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, target), "scan target feedback service should keep the current target inside the sticky buffer")
	runner._expect(ScanTargetFeedbackServiceScript.scan_target_candidate(main) == target, "scan target feedback service should preserve the current sticky target")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, target) == "environment", "scan target feedback service should preserve target type copy")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_discovery_state(main, target) == "new", "scan target feedback service should preserve undiscovered state copy")

	main.progression_state.add_discovery("thermal_vent", "Thermal Vent", "Vent.", "Route clue.")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_discovery_state(main, target) == "known", "scan target feedback service should preserve discovered state copy")

	target.global_position = Vector2(249.0, 100.0)
	runner._expect(not ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, target), "scan target feedback service should release a target beyond the sticky buffer")
	target.visible = false
	target.global_position = Vector2(120.0, 100.0)
	runner._expect(not ScanTargetFeedbackServiceScript.scan_target_still_selectable(main, target), "scan target feedback service should reject hidden scan targets")

	var fallback := ScanTargetFeedbackServiceScript.scan_reticle_fallback_screen_position(main, Vector2(112.0, 84.0), Vector2(1280.0, 720.0))
	runner._expect(fallback == Vector2(652.0, 344.0), "scan reticle fallback should preserve camera-relative positioning without camera zoom")

	target.free()
	player.free()
	main.free()

func _test_surface_run_summary_service(runner) -> void:
	var main := MainScript.new()
	main.show_debug_telemetry = false
	runner._expect(SurfaceRunSummaryServiceScript.format_run_summary(main, "Short summary", "Extracted") == "Short summary", "non-debug run summary should preserve player summary only")
	main.show_debug_telemetry = true
	runner._expect(SurfaceRunSummaryServiceScript.format_run_summary(main, "Short summary", "Extracted").contains("Playtest data:"), "debug run summary should append telemetry")

	main.survival_state.food = 0
	main.survival_state.water = 1
	main.survival_state.power = 3
	var empty_needs := SurfaceRunSummaryServiceScript.base_need_names_at_or_below(main, 0)
	runner._expect(empty_needs == ["Food"], "empty need list should include only needs at or below threshold")
	runner._expect(SurvivalNeedSummaryServiceScript.base_need_names_at_or_below(main.survival_state, 1) == ["Food", "Water"], "survival need summary service should include all needs at or below threshold")
	runner._expect(SurvivalNeedSummaryServiceScript.format_need_list(["Food", "Water"]) == "Food/Water", "survival need summary service should preserve compact need list copy")
	runner._expect(SurfaceRunSummaryServiceScript.format_tomorrow_plan(main).contains("bank Food supply first"), "tomorrow plan should prioritize empty survival needs")

	main.survival_state.food = 3
	main.survival_state.water = 3
	main.survival_state.power = 3
	main.progression_state.banked_resources["driftwood"] = 1
	var starter_target := SurfaceRunSummaryServiceScript.format_starter_resource_target(main)
	runner._expect(starter_target.contains("Quartz Glass"), "starter resource target should preserve missing Water Filter material copy")
	runner._expect(SurvivalNeedSummaryServiceScript.format_starter_resource_target(main.progression_state, main.survival_state, main.WATER_FILTER_UPGRADE_ID, main.WATER_FILTER_UPGRADE.resource_cost) == starter_target, "survival need summary service should preserve starter resource target copy")
	runner._expect(SurfaceRunSummaryServiceScript.format_next_expedition_prompt(main).begins_with("Next: press R for Expedition"), "next expedition prompt should preserve restart action copy")
	main.free()
