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

func _test_survival_needs_panel_service(runner) -> void:
	var main := MainScript.new()
	main.food_need_label = Label.new()
	main.water_need_label = Label.new()
	main.power_need_label = Label.new()
	main.food_need_icon = Polygon2D.new()
	main.water_need_icon = Polygon2D.new()
	main.power_need_icon = Polygon2D.new()
	main.food_need_bar_back = ColorRect.new()
	main.food_need_bar_fill = ColorRect.new()
	main.water_need_bar_back = ColorRect.new()
	main.water_need_bar_fill = ColorRect.new()
	main.power_need_bar_back = ColorRect.new()
	main.power_need_bar_fill = ColorRect.new()
	main.survival_state.food = 5
	main.survival_state.water = 2
	main.survival_state.power = 4

	SurvivalNeedsPanelServiceScript.update_panel(main, true)
	runner._expect(main.food_need_label.visible and main.water_need_label.visible and main.power_need_label.visible, "visible survival panel should show all need labels")
	runner._expect(main.food_need_icon.visible and main.water_need_icon.visible and main.power_need_icon.visible, "visible survival panel should show all need icons")
	runner._expect(main.food_need_label.text == "FOOD 5 / 5", "survival panel should preserve food label copy")
	runner._expect(main.water_need_label.text == "WATER 2 / 5", "survival panel should preserve water label copy")
	runner._expect(main.power_need_label.text == "POWER 4 / 5", "survival panel should preserve power label copy")
	var water_width := main.water_need_bar_fill.offset_right - main.water_need_bar_fill.offset_left
	runner._expect(is_equal_approx(water_width, main.SURVIVAL_NEED_BAR_BACK_RECTS["water"].size.x * 0.4), "survival panel should scale water fill by need ratio")

	SurvivalNeedsPanelServiceScript.update_panel(main, false)
	runner._expect(not main.food_need_label.visible and not main.water_need_label.visible and not main.power_need_label.visible, "hidden survival panel should hide all need labels")
	runner._expect(not main.food_need_bar_back.visible and not main.water_need_bar_fill.visible and not main.power_need_bar_fill.visible, "hidden survival panel should hide all need bars")
	main.free()

func _test_survival_supply_cache_target_copy(runner) -> void:
	var stable_status := SurvivalSupplyCachePresenterScript.format_status_text(true, "Power")
	var stable_prompt := SurvivalSupplyCachePresenterScript.format_prompt(true, "Power", "E/Enter")
	runner._expect(stable_status.contains("base stable"), "stable cache status should say the cache is backup")
	runner._expect(stable_prompt.contains("backup supply"), "stable cache prompt should avoid naming a false weak need")

	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.survival_state.food = 3
	main.survival_state.water = 2
	main.survival_state.power = 1
	main.player_near_survival_supply_cache = true

	var prompt: String = main.call("_format_hud_prompt")
	var status := SurvivalSupplyCachePresenterScript.format_status_text(false, main.survival_state.short_name_for_supply(main.survival_state.most_needed_supply_id()))
	runner._expect(prompt.contains("Power"), "cache prompt should name the currently weakest survival need before pickup")
	runner._expect(status.contains("Power is lowest"), "cache status should name the currently weakest survival need before pickup")

	RouteProximityServiceScript.on_survival_supply_cache_body_entered(main.player, main)
	runner._expect(main.status_label.text.contains("Power is lowest"), "cache entry status should name the weakest need")

	var full_cargo: Array[String] = ["kelp_fiber", "shell_fragments", "driftwood"]
	main.dive_session.current_cargo = full_cargo
	var handled_full := bool(main.call("_try_survival_supply_cache_interaction"))
	runner._expect(handled_full, "full cargo cache interaction should be handled with feedback")
	runner._expect(main.status_label.text.contains("Cargo full") and main.status_label.text.contains("Power"), "full cargo cache status should stay short and name the blocked target")
	runner._expect(not main.run_survival_supply_cache_recovered, "full cargo should not mark the cache recovered")

	main.dive_session.current_cargo.clear()
	var handled_pickup := bool(main.call("_try_survival_supply_cache_interaction"))
	runner._expect(handled_pickup, "cache interaction should recover a supply when cargo has room")
	runner._expect(main.dive_session.current_cargo.size() == 1 and main.dive_session.current_cargo[0] == "power_supply", "cache pickup should add the weakest survival supply")
	runner._expect(main.status_label.text.contains("Power Cell") and main.status_label.text.contains("Power") and main.status_label.text.contains("Ship banks"), "recovered cache status should name the supply role and ship banking")
	runner._expect(String(main.call("_format_hud_prompt")).contains("recovered"), "recovered cache prompt should stay compact")
	main.queue_free()

func _test_starter_survival_resource_families(runner) -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["scrap_metal", "driftwood", "quartz_glass", "food_supply", "water_supply", "power_supply"]
	var resources: Array[String] = main.call("_bank_extracted_cargo", cargo)
	var supplies: Array[String] = SurvivalControllerServiceScript.bank_extracted_survival_supplies(main, cargo)

	runner._expect(resources == ["scrap_metal", "driftwood", "quartz_glass"], "starter crafting materials should bank as upgrade resources")
	runner._expect(supplies == ["food_supply", "water_supply", "power_supply"], "starter food, water, and power should bank as survival supplies")
	runner._expect(main.progression_state.resource_count("scrap_metal") == 1, "scrap metal should appear in the resource bank")
	runner._expect(main.progression_state.resource_count("driftwood") == 1, "driftwood should appear in the resource bank")
	runner._expect(main.progression_state.resource_count("quartz_glass") == 1, "quartz glass should appear in the resource bank")
	runner._expect(main.survival_state.food == 4, "food pickup should increase survival food")
	runner._expect(main.survival_state.water == 4, "water pickup should increase survival water")
	runner._expect(main.survival_state.power == 4, "power pickup should increase survival power")
	runner._expect(ResourceSummaryServiceScript.format_resource_counts(resources, main.survival_state, main.RESOURCE_CATEGORY_LABELS).contains("Building: Scrap Metal"), "resource result copy should name building materials")
	runner._expect(ResourceSummaryServiceScript.format_survival_supply_counts(supplies, main.survival_state, main.RESOURCE_CATEGORY_LABELS).contains("Food/Fish: Food/Fish Supply"), "survival result copy should name the food/fish role")
	runner._expect(ResourceSummaryServiceScript.format_survival_supply_counts(supplies, main.survival_state, main.RESOURCE_CATEGORY_LABELS).contains("Power: Power Cell"), "survival result copy should name the power role")
	var summary_names := {
		"scrap_metal": "Scrap Metal",
		"food_supply": "Food/Fish Supply",
	}
	var summary_categories := {
		"scrap_metal": "Building",
		"food_supply": "Food/Fish",
	}
	runner._expect(InventorySummaryPresenterScript.format_item_counts(["scrap_metal", "scrap_metal"], summary_categories, summary_names).contains("Scrap Metal x2"), "inventory summary presenter should count repeated resources")
	runner._expect(InventorySummaryPresenterScript.format_cargo_counts_inline(["scrap_metal", "food_supply"], {"scrap_metal": "Scrap", "food_supply": "Food"}) == " - Scrap x1, Food x1", "inventory summary presenter should keep compact cargo copy")
	runner._expect(InventorySummaryPresenterScript.format_extraction_banking_line(0, "", true).contains("scan data"), "inventory summary presenter should preserve scan-only extraction copy")
	runner._expect(InventorySummaryPresenterScript.format_supply_names_inline(["food_supply", "power_supply"], {"food_supply": "Food", "power_supply": "Power"}) == "Food/Power", "inventory summary presenter should compact supply names")
	runner._expect(ResourcePresenterScript.resource_role_summary("food_supply", true, "Food/Fish", "fill tonight's Food reserve").contains("Food/Fish survival supply"), "food pickup role should read as survival supply")
	runner._expect(ResourcePresenterScript.resource_role_summary("power_supply", true, "Power", "fill tonight's Power reserve").contains("Power survival supply"), "power pickup role should read as survival supply")
	runner._expect(ResourcePresenterScript.resource_role_summary("scrap_metal", false, "Building", "").contains("Building material"), "scrap pickup role should read as building material")
	runner._expect(ResourcePresenterScript.resource_role_summary("kelp_fiber", false, "Research", "").contains("Research material"), "kelp pickup role should read as research material")
	runner._expect(ResourcePresenterScript.resource_collection_guidance(false, "Building", "").contains("repairs/upgrades"), "building resource guidance should stay exact enough for route copy")
	runner._expect(ResourcePresenterScript.resource_pickup_feedback("food_supply", 1, 3, true, "Food/Fish").contains("Food/Fish reserve"), "supply pickup feedback should keep base-need reserve copy")
	runner._expect(ResourcePresenterScript.resource_visual_role_family(false, "Building") == "building", "building resources should keep building role family")
	runner._expect(ResourcePresenterScript.resource_role_accent_color("food_supply") == Color(1.0, 0.32, 0.08, 0.95), "food supply role accent should stay exact")
	var role_host := Node2D.new()
	ResourceRoleVisualPresenterScript.ensure_resource_role_visual(role_host, "food_supply", "supply", ResourcePresenterScript.resource_role_accent_color("food_supply"))
	var direct_role_read := role_host.get_node_or_null("RoleRead") as Node2D
	runner._expect(direct_role_read != null and direct_role_read.get_child_count() >= 3, "resource role visual presenter should build readable marker geometry")
	runner._expect(String(direct_role_read.get_meta("role_family", "")) == "supply", "resource role visual presenter should preserve role family metadata")
	runner._expect(ResourcePickupPresentationServiceScript.resource_pickup_feedback(main, "food_supply").contains("Food/Fish reserve"), "resource pickup presentation service should preserve supply pickup feedback")
	role_host.free()
	for definition in StarterResourceDefinitions:
		runner._expect(not definition.resource_category.is_empty(), "%s should declare a resource category" % definition.id)

	var scene := MainScene.instantiate()
	runner.root.add_child(scene)
	ResourcePickupPresentationServiceScript.ensure_resource_role_visuals(scene)
	var expected_pickups := {
		"KelpFiber": {"id": "kelp_fiber", "family": "research"},
		"ShellFragments": {"id": "shell_fragments", "family": "research"},
		"GlowPlankton": {"id": "glow_plankton", "family": "research"},
		"ScrapMetal": {"id": "scrap_metal", "family": "building"},
		"Driftwood": {"id": "driftwood", "family": "building"},
		"QuartzGlass": {"id": "quartz_glass", "family": "building"},
		"FoodSupply": {"id": "food_supply", "family": "supply"},
		"WaterSupply": {"id": "water_supply", "family": "supply"},
		"PowerSupply": {"id": "power_supply", "family": "supply"},
	}
	for pickup_name in expected_pickups.keys():
		var expected := expected_pickups[pickup_name] as Dictionary
		var pickup := scene.get_node("ResourcePickups/%s" % pickup_name) as ResourcePickup
		var candidate := scene.get_node_or_null("StarterResourceCandidates/%s/A" % pickup_name)
		var role_read := pickup.get_node_or_null("RoleRead") as Node2D
		runner._expect(pickup.definition.id == String(expected.get("id", "")), "%s should use the expected resource definition" % pickup_name)
		runner._expect(candidate != null, "%s should have at least one authored spawn candidate" % pickup_name)
		runner._expect(role_read != null and role_read.visible, "%s should show a pre-pickup role read marker" % pickup_name)
		if role_read != null:
			runner._expect(String(role_read.get_meta("role_family", "")) == String(expected.get("family", "")), "%s role marker should declare the expected cargo family" % pickup_name)
			runner._expect(role_read.get_child_count() >= 3, "%s role marker should have enough visible shapes to read at play scale" % pickup_name)
	var food_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, scene.get_node("ResourcePickups/FoodSupply"))
	var power_fact: String = ScanEffectTextServiceScript.scan_target_gameplay_fact(main, scene.get_node("ResourcePickups/PowerSupply"))
	var scrap_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, scene.get_node("ResourcePickups/ScrapMetal"))
	var kelp_fact: String = ScanEffectTextServiceScript.scan_target_gameplay_fact(main, scene.get_node("ResourcePickups/KelpFiber"))
	runner._expect(food_guidance.contains("Food reserve") and food_guidance.contains("Return to ship"), "food scan guidance should explain the tonight/base decision")
	runner._expect(power_fact.contains("Power survival supply") and power_fact.contains("base needs for tonight"), "power scan fact should explain the survival role")
	runner._expect(scrap_guidance.contains("building material") and scrap_guidance.contains("repairs/upgrades"), "scrap scan guidance should explain the building role")
	runner._expect(kelp_fact.contains("Research material") and kelp_fact.contains("Oxygen Tank I"), "kelp scan fact should explain the research/upgrade role")
	scene.queue_free()

func _test_resource_taxonomy_offload_copy(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	main.dive_session.start()
	main.player_in_base = true
	main.dive_session.has_left_base = true
	var mixed_cargo: Array[String] = ["food_supply", "power_supply", "scrap_metal", "kelp_fiber"]
	main.dive_session.current_cargo = mixed_cargo

	var offloaded := bool(main.call("_try_ship_offload"))

	runner._expect(offloaded, "ship offload should accept mixed taxonomy cargo")
	runner._expect(main.survival_state.food == 4, "food/fish offload should bank survival food")
	runner._expect(main.survival_state.power == 4, "power offload should bank survival power")
	runner._expect(main.progression_state.resource_count("scrap_metal") == 1, "building offload should bank scrap")
	runner._expect(main.progression_state.resource_count("kelp_fiber") == 1, "research offload should bank kelp fiber")
	runner._expect(main.upgrade_menu_feedback.contains("Food/Fish: Food/Fish Supply"), "offload copy should label food/fish survival value")
	runner._expect(main.upgrade_menu_feedback.contains("Power: Power Cell"), "offload copy should label power survival value")
	runner._expect(main.upgrade_menu_feedback.contains("Building: Scrap Metal"), "offload copy should label building value")
	runner._expect(main.upgrade_menu_feedback.contains("Research: Kelp Fiber"), "offload copy should label research value")
	runner._expect(main.status_label.text == "Ship banked cargo; O2 full. Dive again.", "active offload status should stay compact while detailed taxonomy remains in feedback")
	main.queue_free()

	var pickup_scene := MainScene.instantiate()
	runner.root.add_child(pickup_scene)
	pickup_scene.dive_session.start()
	var power_pickup := pickup_scene.get_node("ResourcePickups/PowerSupply") as ResourcePickup
	SceneEventServiceScript.on_resource_pickup_collected(power_pickup, pickup_scene)
	runner._expect(pickup_scene.status_label.text.contains("Power Cell") and pickup_scene.status_label.text.contains("Cargo 1/3") and pickup_scene.status_label.text.contains("Power reserve"), "power pickup feedback should name capacity and night-survival role")
	pickup_scene.queue_free()

func _test_survival_oxygen_penalty(runner) -> void:
	runner._expect(DiveCapacityServiceScript.current_max_oxygen(30.0, false, 40.0, 4.0) == 26.0, "dive capacity service should apply survival oxygen penalty to base oxygen")
	runner._expect(DiveCapacityServiceScript.current_max_oxygen(30.0, true, 40.0, 4.0) == 36.0, "dive capacity service should apply survival oxygen penalty after Oxygen Tank")
	runner._expect(DiveCapacityServiceScript.current_max_oxygen(14.0, false, 40.0, 8.0) == 12.0, "dive capacity service should preserve the oxygen floor")
	runner._expect(DiveCapacityServiceScript.current_cargo_limit(3, false, 4) == 3, "dive capacity service should preserve base cargo capacity")
	runner._expect(DiveCapacityServiceScript.current_cargo_limit(3, true, 4) == 4, "dive capacity service should apply Cargo Rack capacity")

	var main := MainScript.new()
	main.survival_state.food = 0

	runner._expect(main._current_max_oxygen() == 26.0, "one empty survival need should reduce next expedition oxygen")
	main.progression_state.purchased_upgrades[OxygenTankUpgrade.id] = true
	runner._expect(main._current_max_oxygen() == 36.0, "survival oxygen penalty should apply after oxygen upgrade max is calculated")

func _test_upgrade_affordability(runner) -> void:
	var progression := ProgressionStateScript.new()

	runner._expect(not progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should not be affordable without resources")
	progression.banked_resources = {
		"kelp_fiber": 2,
		"shell_fragments": 1,
		"glow_plankton": 1,
	}

	runner._expect(progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should become affordable with exact resources")
	runner._expect(progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "affordable upgrade should purchase")
	runner._expect(progression.has_upgrade(OxygenTankUpgrade.id), "purchased upgrade id should be recorded")
	runner._expect(progression.resource_count("kelp_fiber") == 0, "purchase should spend kelp fiber")
	runner._expect(progression.resource_count("shell_fragments") == 0, "purchase should spend shell fragments")
	runner._expect(progression.resource_count("glow_plankton") == 0, "purchase should spend glow plankton")
	runner._expect(not progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "owned upgrade should not purchase again")

	var resonance_progression := ProgressionStateScript.new()
	resonance_progression.banked_resources = {
		"glow_plankton": 2,
		"shell_fragments": 1,
	}
	runner._expect(resonance_progression.can_afford(ResonanceKeyUpgrade.resource_cost), "Resonance Key I should use currently bankable materials")
	runner._expect(UpgradePurchaseScript.missing_upgrade(resonance_progression, ResonanceKeyUpgrade) == EchoLensUpgrade.id, "Resonance Key I purchase should require Echo Lens I first")
	runner._expect(not UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should not purchase before prerequisites")
	resonance_progression.purchased_upgrades[EchoLensUpgrade.id] = true
	resonance_progression.add_discovery("east_shelf_route_research", "East Shelf route research", "Route evidence.", "Plans a hatch key.")
	runner._expect(UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should purchase after route context, Echo Lens I, and resources")
	runner._expect(resonance_progression.has_upgrade(ResonanceKeyUpgrade.id), "Resonance Key I purchase should record the upgrade id")
	runner._expect(resonance_progression.resource_count("glow_plankton") == 0, "Resonance Key I purchase should spend glow plankton")
	runner._expect(resonance_progression.resource_count("shell_fragments") == 0, "Resonance Key I purchase should spend shell fragments")
	runner._expect(not UpgradePurchaseScript.purchase(resonance_progression, ResonanceKeyUpgrade), "Resonance Key I should not purchase twice")

	var starter_progression := ProgressionStateScript.new()
	runner._expect(not starter_progression.can_afford(WaterFilterUpgrade.resource_cost), "Water Filter I should not be affordable without starter resources")
	starter_progression.banked_resources = {
		"driftwood": 1,
		"quartz_glass": 1,
	}
	runner._expect(starter_progression.can_afford(WaterFilterUpgrade.resource_cost), "Water Filter I should become affordable with starter resources")
	runner._expect(UpgradePurchaseScript.purchase(starter_progression, WaterFilterUpgrade), "Water Filter I should purchase without scan prerequisites")
	runner._expect(starter_progression.has_upgrade(WaterFilterUpgrade.id), "Water Filter I purchase should record ownership")
	runner._expect(starter_progression.resource_count("driftwood") == 0, "Water Filter I should spend driftwood")
	runner._expect(starter_progression.resource_count("quartz_glass") == 0, "Water Filter I should spend quartz glass")
	runner._expect(not UpgradePurchaseScript.purchase(starter_progression, WaterFilterUpgrade), "Water Filter I should not purchase twice")

func _test_progression_reset(runner) -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)
	progression.advance_run()

	progression.reset()

	runner._expect(progression.banked_resources.is_empty(), "reset should clear banked resources")
	runner._expect(progression.purchased_upgrades.is_empty(), "reset should clear purchased upgrades")
	runner._expect(progression.scan_discoveries.is_empty(), "reset should clear scan discoveries")
	runner._expect(is_equal_approx(progression.best_depth_reached, 0.0), "reset should clear best depth")
	runner._expect(progression.current_run_number == 0, "reset should return run counter to pre-expedition state")
	runner._expect(progression.current_run_seed == 0, "reset should clear current seed")

	progression.advance_run()
	runner._expect(progression.current_run_number == 1, "first run after reset should be expedition 1")
	runner._expect(progression.current_run_seed == 8919, "first seed after reset should match expedition 1")
