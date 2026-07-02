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

func _test_recent_expedition_survival_memory(runner) -> void:
	var banked := MainScript.new()
	banked.progression_state.current_run_number = 21
	banked.progression_state.best_depth_reached = 72.0
	banked.run_banked_survival_supplies = ["food_supply", "power_supply"]
	banked._record_recent_expedition("Extracted", 2)
	var log_text := RecentExpeditionLogServiceScript.format_recent_expedition_log(banked)
	runner._expect(log_text.contains("survival banked Food/Power supply"), "recent log should remember banked survival supplies compactly")
	runner._expect(not log_text.contains("seed"), "survival memory should not expose debug seed data")
	runner._expect_lines_within(log_text, 120, "recent expedition survival log")
	banked.free()

	var damaged := MainScript.new()
	damaged.progression_state.current_run_number = 22
	damaged.run_banked_survival_supplies = ["food_supply"]
	damaged.run_health_damage_events = 1
	damaged.dive_session.health = 82.0
	damaged.dive_session.max_health = 100.0
	damaged._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(damaged)
	runner._expect(log_text.contains("survival health 82/100; med used build"), "health damage should be the most important survival memory")
	runner._expect(not log_text.contains("survival banked Food"), "health memory should keep the line to one survival tradeoff")
	damaged.free()

	var late := MainScript.new()
	late.progression_state.current_run_number = 23
	late.daylight_nightfall_away_from_ship = true
	late.run_banked_survival_supplies = ["power_supply"]
	late._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(late)
	runner._expect(log_text.contains("survival late return cost Power -1"), "late return should be remembered as a survival tradeoff")
	runner._expect(not log_text.contains("survival banked Power"), "late return should keep one compact survival memory")
	late.free()

	var low_need := MainScript.new()
	low_need.progression_state.current_run_number = 24
	low_need.survival_state.food = 2
	low_need.survival_state.water = 1
	low_need.survival_state.power = 0
	low_need._record_recent_expedition("Extracted", 1)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(low_need)
	runner._expect(log_text.contains("survival low Water/Power"), "recent log should remember low base needs when no sharper tradeoff exists")
	low_need.free()

	var target := MainScript.new()
	target.progression_state.current_run_number = 25
	target._record_recent_expedition("Extracted", 0)
	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(target)
	runner._expect(log_text.contains("survival Water Filter needs Driftwood/Quartz Glass"), "no-cargo starter returns should remember the Water Filter material target")
	target.free()

	var retained := MainScript.new()
	for run_number in range(1, 5):
		retained.progression_state.current_run_number = run_number
		retained.progression_state.best_depth_reached = 20.0 * run_number
		retained.run_banked_survival_supplies.clear()
		if run_number == 4:
			retained.run_banked_survival_supplies = ["water_supply"]
		retained._record_recent_expedition("Extracted", run_number)

	log_text = RecentExpeditionLogServiceScript.format_recent_expedition_log(retained)
	runner._expect(retained.recent_expedition_log.size() == 3, "survival-memory recent log should keep only three entries")
	runner._expect(not log_text.contains("#1"), "survival-memory recent log retention should drop the oldest entry")
	runner._expect(log_text.contains("#4 Extracted"), "survival-memory recent log should retain the newest entry")
	runner._expect(log_text.contains("survival banked Water supply"), "retained newest entry should keep its survival memory")
	runner._expect(not log_text.contains("Playtest data"), "recent log survival memory should not expose debug telemetry")
	runner._expect_lines_within(log_text, 120, "recent expedition survival retention log")
	retained.free()

func _test_thermal_vent_scan_clue_text(runner) -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "thermal_vent"
	target.display_name = "Thermal Vent"
	target.description = "Warm current."

	var first_guidance := ScanEffectTextServiceScript.first_scan_guidance(main, target)
	runner._expect(first_guidance.contains("Warm current"), "thermal vent first scan should name the warm-current clue")
	runner._expect(first_guidance.contains("optional glow"), "thermal vent first scan should keep glow route optional")
	runner._expect(first_guidance.contains("Pressure Seal clue"), "thermal vent first scan should explain pressure-seal knowledge")
	runner._expect(ScanEffectTextServiceScript.repeat_scan_effect_text(main, target).contains("glow route optional"), "thermal vent repeat scan should stay concise and optional")
	target.free()
	main.free()

	var main_scene := MainScene.instantiate()
	runner.root.add_child(main_scene)
	var hidden_glow: Area2D = main_scene.get_node("ResourcePickups/HiddenGlowPlankton")
	var vent_route_hint: Node2D = main_scene.get_node("VentRouteHint")
	main_scene.call("_reveal_thermal_vent_route")
	runner._expect(vent_route_hint.visible, "thermal vent scan should reveal the optional route hint")
	runner._expect(not hidden_glow.visible, "thermal vent scan should not create an extra active Glow Plankton pickup")
	runner._expect(not hidden_glow.monitoring, "thermal vent scan should not enable hidden Glow Plankton collision")
	main_scene.queue_free()

func _test_shell_reef_scan_clue_text(runner) -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "shell_reef_shelf"
	target.display_name = "Shell Reef Shelf"
	target.description = "Reef shelf."

	runner._expect(DiscoveryNamePresenterScript.display_name(main.progression_state, "shell_reef_shelf") == "Shell Reef Shelf", "shell reef discovery should have a readable name")
	runner._expect(DiscoveryNamePresenterScript.display_name(main.progression_state, "") == "none", "discovery name presenter should preserve empty discovery copy")
	runner._expect(DiscoveryNamePresenterScript.format_discoveries(main.progression_state) == "Discoveries: 0\n???", "empty discovery summary should keep the unknown placeholder")
	main.progression_state.add_discovery("custom_signal", "Custom Signal", "Signal.", "Memory.")
	runner._expect(DiscoveryNamePresenterScript.display_name(main.progression_state, "custom_signal") == "Custom Signal", "discovery name presenter should prefer durable discovery display names")
	runner._expect(DiscoveryNamePresenterScript.format_discoveries(main.progression_state).contains("Custom Signal - Memory."), "discovery summary should list discovered gameplay facts")
	runner._expect(ScanEffectTextServiceScript.repeat_scan_effect_text(main, target).contains("Reef route clue refreshed"), "shell reef repeat scan should give compact feedback")
	runner._expect(ScanEffectTextServiceScript.first_scan_guidance(main, target).contains("midwater bank route"), "shell reef first scan should explain the route decision")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, target) == "environment", "shell reef scan target should be environmental metadata")
	target.free()
	main.free()

func _test_wreck_signal_cache_repeat_scan_hint(runner) -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "wreck_signal_cache"
	target.display_name = "Wreck Signal Cache"
	target.description = "Cache ping."

	runner._expect(ScanEffectTextServiceScript.repeat_scan_effect_text(main, target).contains("Signal Lens I"), "cache repeat scan before Signal Lens I should refresh the current upgrade clue")
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	runner._expect(ScanEffectTextServiceScript.wreck_cache_repeat_hint(main).contains("Cache echo unresolved"), "cache repeat helper should name the unresolved echo")
	var repeat_hint := ScanEffectTextServiceScript.repeat_scan_effect_text(main, target)
	runner._expect(repeat_hint.contains("Echo Lens"), "cache repeat scan after Signal Lens I should hint at future echo-lens study")
	runner._expect(repeat_hint.contains("deeper wreck signals"), "cache repeat scan should imply unresolved wreck signals without exact coordinates")
	runner._expect(not repeat_hint.to_lower().contains("map"), "cache repeat scan should not introduce map UI language")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	repeat_hint = ScanEffectTextServiceScript.repeat_scan_effect_text(main, target)
	runner._expect(repeat_hint.contains("Echo Lens: weak wreck echo lingers below the shelf"), "Echo Lens I should turn the cache hint into a broad local wreck echo")
	runner._expect_no_echo_lens_locator_language(repeat_hint, "Echo Lens I repeat scan echo")
	runner._expect(ScanEffectTextServiceScript.signal_lens_pulse_text(main, target) == "", "Wreck Signal Cache repeat hint should not reuse resource pulse behavior")
	target.free()
	main.free()

func _test_pressure_lock_guidance_text(runner) -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "pressure_wreck_signal"
	target.display_name = "Pressure-Locked Research Wreck"
	target.description = "Pressure lock."

	var locked_guidance := ScanEffectTextServiceScript.first_scan_guidance(main, target)
	runner._expect(locked_guidance.contains("Locked"), "pressure lock guidance should first say the route is blocked")
	runner._expect(locked_guidance.contains("buy Pressure Seal I"), "pressure lock guidance should name the surface upgrade step")
	runner._expect(locked_guidance.contains("then return"), "pressure lock guidance should explain the return loop")

	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	var open_guidance := ScanEffectTextServiceScript.first_scan_guidance(main, target)
	runner._expect(open_guidance.contains("if oxygen allows"), "open pressure route guidance should invite entry only if oxygen allows")
	runner._expect(open_guidance.contains("scan cache"), "open pressure route guidance should name the cache payoff")
	target.free()
	main.free()

func _test_surface_summary_tabs(runner) -> void:
	var main := MainScript.new()

	var ready_summary := SurfaceRunSummaryServiceScript.format_ready_panel_summary(main)
	runner._expect(ready_summary.contains("E/Enter begins."), "ready panel should keep the start action visible")
	runner._expect(ready_summary.contains("Base needs: Food"), "ready panel should explain survival needs with readable names")
	runner._expect(ready_summary.contains("Tonight: Food -1, Water -1, Power -1."), "ready panel should explain nightly survival pressure")
	runner._expect(ready_summary.contains("base needs are stable"), "ready panel should explain why the shallow cache matters")
	runner._expect(ready_summary.contains("Day priority:"), "ready panel should name one main day priority")
	runner._expect(ready_summary.contains("Shell Reef pockets"), "ready panel priority should point to the current starter-resource target")
	runner._expect(not ready_summary.contains("Goal:"), "ready panel should not show a second generic goal line")
	runner._expect(not ready_summary.contains("Survival F"), "ready panel should not use cryptic survival abbreviations")
	runner._expect(not ready_summary.contains("F9"), "ready panel should hide prototype reset copy when debug telemetry is off")
	main.carried_tomorrow_intention = "bank Power supply soon to protect tomorrow's oxygen."
	var carried_ready_summary := SurfaceRunSummaryServiceScript.format_ready_panel_summary(main)
	runner._expect(carried_ready_summary.contains("Day priority: bank Power supply soon"), "ready panel should carry the confirmed night intention into the next day")
	main.carried_tomorrow_intention = ""
	main.show_debug_telemetry = true
	runner._expect(SurfaceRunSummaryServiceScript.format_ready_panel_summary(main).contains("F9 resets prototype save"), "ready panel may expose reset copy when debug telemetry is on")
	main.show_debug_telemetry = false

	runner._expect(not UpgradeStateServiceScript.surface_tabs_enabled(main), "surface tabs should be hidden before extraction")
	main.dive_session.extract()
	runner._expect(UpgradeStateServiceScript.surface_tabs_enabled(main), "surface tabs should be available after extraction")
	runner._expect(UpgradeStateServiceScript.format_surface_tabs(main) == "[Result]  Upgrades  Log  Night", "surface tabs should mark the result view by default")
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	runner._expect(UpgradeStateServiceScript.format_surface_tabs(main) == "Result  [Upgrades]  Log  Night", "surface tabs should mark the upgrade view")
	runner._expect(UpgradeStateServiceScript.format_upgrade_menu_title(1, 7, main._action_label("move_up_down")) == "Upgrade Bay (1/7) - Up/Down select", "upgrade bay title should keep selection controls visible")
	main.surface_tab_index = main.SURFACE_TAB_LOG
	runner._expect(UpgradeStateServiceScript.format_surface_tabs(main) == "Result  Upgrades  [Log]  Night", "surface tabs should mark the log view")
	main.surface_tab_index = main.SURFACE_TAB_NIGHT
	runner._expect(UpgradeStateServiceScript.format_surface_tabs(main) == "Result  Upgrades  Log  [Night]", "surface tabs should mark the night view")
	main.free()

func _test_keyboard_action_prompt_labels(runner) -> void:
	var main := MainScript.new()
	runner._expect(main._action_label("interact") == "E/Enter", "interact prompt label should match the current keyboard binding")
	runner._expect(main._action_label("restart_dive") == "R", "restart prompt label should match the current keyboard binding")
	runner._expect(main._action_label("move_left_right") == "Left/Right", "tab cycling prompt label should match the current keyboard binding")
	runner._expect(main._action_label("move_up_down") == "Up/Down", "selection prompt label should match the current keyboard binding")
	runner._expect(main._action_label("scan") == "F", "scan prompt label should match the current keyboard binding")
	runner._expect(main._action_label("expedition_slate") == "Tab", "expedition slate prompt label should match the current keyboard binding")
	runner._expect(main._action_label("burst_thruster") == "Space", "burst prompt label should match the current keyboard binding")
	runner._expect(main._action_label("decoy_pulse") == "F", "decoy prompt label should match the current keyboard binding")
	runner._expect(main._action_label("future_action") == "future_action", "unknown prompt labels should fall back to their action id")
	runner._expect(InputMap.has_action("expedition_slate"), "expedition slate should have a semantic InputMap action")
	var slate_events := InputMap.action_get_events("expedition_slate")
	runner._expect(not slate_events.is_empty(), "expedition slate InputMap action should be bound")
	var slate_key := slate_events[0] as InputEventKey
	runner._expect(slate_key != null and slate_key.keycode == KEY_TAB, "expedition slate should be bound to Tab")
	main.free()

func _test_hud_prompt_presenter(runner) -> void:
	var labels := {
		"interact": "E/Enter",
		"move_left_right": "Left/Right",
		"move_up_down": "Up/Down",
		"restart_dive": "R",
	}
	var prompt := HudPromptPresenterScript.format_prompt({
		"action_labels": labels,
		"result": "ready",
	})
	runner._expect(prompt == "Press E or Enter to begin the dive", "HUD prompt presenter should format ready interact copy")

	prompt = HudPromptPresenterScript.format_prompt({
		"action_labels": labels,
		"result": "extracted",
		"surface_tab": "upgrades",
	})
	runner._expect(prompt.contains("Upgrade bay: Up/Down select, E/Enter purchase"), "HUD prompt presenter should format upgrade tab controls")

	prompt = HudPromptPresenterScript.format_prompt({
		"action_labels": labels,
		"burst_thruster_prompt": "Space burst",
		"decoy_pulse_prompt": "F: decoy ready",
		"player_near_survival_supply_cache": true,
		"result": "diving",
		"survival_supply_cache_prompt": "Emergency cache: E/Enter recover Power",
	})
	runner._expect(prompt.begins_with("Emergency cache: E/Enter recover Power"), "HUD prompt presenter should prefer nearby interactable prompts")
	runner._expect(prompt.ends_with("Space burst | F: decoy ready"), "HUD prompt presenter should append active dive tool prompts")

	prompt = HudPromptPresenterScript.format_prompt({
		"action_labels": labels,
		"burst_thruster_prompt": "Space burst",
		"can_ship_offload": true,
		"cargo_count": 2,
		"cargo_limit": 3,
		"has_left_base": true,
		"player_in_base": true,
		"result": "diving",
	})
	runner._expect(prompt.contains("At ship: E/Enter offload cargo 2/3, O2 full"), "HUD prompt presenter should format ship offload prompts")

	prompt = HudPromptPresenterScript.format_prompt({
		"action_labels": labels,
		"burst_thruster_prompt": "Space burst",
		"has_recent_health_damage": true,
		"health": 82.0,
		"max_health": 100.0,
		"player_in_surface_oxygen_refill": true,
		"result": "diving",
	})
	runner._expect(prompt.contains("O2 only; health 82/100; ship banks"), "HUD prompt presenter should keep surface refill copy honest after health damage")

	var main := MainScript.new()
	main.dive_session.current_cargo = ["food_supply", "driftwood"]
	main.dive_session.cargo_limit = 3
	var state := HudPromptStateServiceScript.build_state(main)
	runner._expect(state.get("cargo_count", 0) == 2, "HUD prompt state service should preserve carried cargo count")
	runner._expect(state.get("cargo_limit", 0) == 3, "HUD prompt state service should preserve cargo capacity")
	runner._expect(Dictionary(state.get("action_labels", {})).get("interact", "") == "E/Enter", "HUD prompt state service should include action labels")
	main.free()
