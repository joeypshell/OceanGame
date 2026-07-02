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

func _test_hollow_reef_passive_creature_scan_behavior(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var skitter := main.get_node("Creatures/HollowReefSkitter") as Area2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var hollow_reef := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var skitter_body := main.get_node("Creatures/HollowReefSkitter/SkitterBody") as Polygon2D
	main.player = scene_player
	skitter.call("_ready")
	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = skitter.global_position

	runner._expect(skitter.is_in_group("scan_targets"), "Hollow Reef Skitter should register as a scan target once the scene is ready")
	var scan_candidates: Array[Node] = [skitter]
	runner._expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == skitter, "scanner target selection should find Hollow Reef Skitter reliably at close range")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, skitter) == "creature", "Hollow Reef Skitter scan target should read as a creature")
	runner._expect(ScanTargetResolverScript.target_id(skitter) == "hollow_reef_skitter", "Hollow Reef Skitter should expose a stable discovery id")
	runner._expect(skitter.global_position.distance_to(hollow_reef.global_position) < 520.0, "Hollow Reef Skitter should live inside the Hollow Reef side-cave neighborhood")
	runner._expect(skitter_body.color.g > skitter_body.color.r and skitter_body.color.b > skitter_body.color.r, "Hollow Reef Skitter should use cool passive reef colors instead of red warning language")
	runner._expect(skitter_body.polygon[3].x < lantern_ray_body.polygon[3].x, "Hollow Reef Skitter should read smaller and distinct from the broad Lantern Ray")
	runner._expect(skitter.collision_layer == 0 and skitter.collision_mask == 0, "Hollow Reef Skitter should not create contact collision")
	runner._expect(skitter.find_child("HarvestArea", true, false) == null, "Hollow Reef Skitter should not add harvesting behavior")
	runner._expect(skitter.find_child("HealthBar", true, false) == null, "Hollow Reef Skitter should not add combat health UI")
	runner._expect(skitter.find_child("Predator", true, false) == null, "Hollow Reef Skitter should not reuse predator behavior")

	var save_before_scan: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = ScanTargetResolverScript.target_id(skitter)
	var display_name: String = ScanTargetResolverScript.display_name(skitter)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(skitter),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(main, skitter)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, skitter) + ScanEffectTextServiceScript.first_scan_guidance(main, skitter)
	])
	var first_scan_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, skitter)
	runner._expect(main.progression_state.has_discovery("hollow_reef_skitter"), "first Hollow Reef Skitter scan should record a normal durable discovery")
	runner._expect(main.run_completed_scans == ["hollow_reef_skitter"], "first Hollow Reef Skitter scan should count as current-run scan evidence")
	runner._expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Hollow Reef Skitter scan should use the normal scan oxygen cost")
	runner._expect(first_scan_status.contains("Scanned Hollow Reef Skitter"), "first Hollow Reef Skitter scan status should name the creature")
	runner._expect(first_scan_guidance.contains("Observe the upper shelf timing"), "first Hollow Reef Skitter scan guidance should teach a compact behavior clue")
	runner._expect_no_monster_combat_language(first_scan_status, "Hollow Reef Skitter first scan status")
	runner._expect(not first_scan_status.to_lower().contains("field guide"), "Hollow Reef Skitter first scan should not imply field-guide UI")
	runner._expect(not first_scan_status.to_lower().contains("checklist"), "Hollow Reef Skitter first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, skitter) + ScanEffectTextServiceScript.signal_lens_pulse_text(main, skitter)
	])
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Hollow Reef Skitter scan should stay free like existing known scans")
	runner._expect(main.run_completed_scans == ["hollow_reef_skitter"], "repeat Hollow Reef Skitter scan should not duplicate current-run scan evidence")
	runner._expect(repeat_scan_status.contains("Hollow Reef Skitter known"), "repeat Hollow Reef Skitter scan should use compact known-target copy")
	runner._expect(repeat_scan_status.contains("observation refreshed"), "repeat Hollow Reef Skitter scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved.get("scan_discoveries", {}).has("hollow_reef_skitter"), "Hollow Reef Skitter discovery should persist through normal scan discovery storage")
	runner._expect(saved.get("banked_resources", {}) == save_before_scan.get("banked_resources", {}), "Hollow Reef Skitter scan should not mutate resources")
	runner._expect(saved.get("purchased_upgrades", {}) == save_before_scan.get("purchased_upgrades", {}), "Hollow Reef Skitter scan should not mutate upgrades")
	runner._expect(is_equal_approx(float(saved.get("best_depth_reached", 0.0)), float(save_before_scan.get("best_depth_reached", 0.0))), "Hollow Reef Skitter scan should not mutate best-depth state")
	runner._expect(not saved.has("hollow_reef_skitter_objective"), "Hollow Reef Skitter scan should not create durable objective-chain state")
	runner._expect(not saved.has("monster_parts"), "Hollow Reef Skitter scan should not add monster-part economy state")
	runner._expect(not saved.has("creature_inventory"), "Hollow Reef Skitter scan should not add creature inventory state")
	main.queue_free()

func _test_glassfin_swarm_scan_behavior(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var swarm := chamber.get_node("GlassfinSwarm") as Area2D
	var lane := swarm.get_node("SwarmRouteLane") as Polygon2D
	var body_a_outline := swarm.get_node("SwarmBodyAOutline") as Polygon2D
	var body_b_outline := swarm.get_node("SwarmBodyBOutline") as Polygon2D
	var body_c_outline := swarm.get_node("SwarmBodyCOutline") as Polygon2D
	var body_a := swarm.get_node("SwarmBodyA") as Polygon2D
	var body_b := swarm.get_node("SwarmBodyB") as Polygon2D
	var spacing_wake := swarm.get_node("SpacingWake") as Polygon2D
	var return_gap := swarm.get_node("ReturnGapCue") as Polygon2D
	var scan_marker := swarm.get_node("ScanMarker") as Polygon2D
	var return_current := chamber.get_node("ReturnCurrentBackToHollow") as Polygon2D
	var lantern_ray_body := main.get_node("Creatures/LanternRayRoute/RayBody") as Polygon2D
	var predator_warning := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var resource_glimmer := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()
	main.player = scene_player
	swarm.call("_ready")

	runner._expect(swarm.get_parent() == chamber, "Glassfin Swarm should be authored inside the wide chamber route space")
	runner._expect(swarm.position.x > 200.0 and swarm.position.x < 480.0, "Glassfin Swarm should sit in the chamber's mid/far open-water lane")
	runner._expect(swarm.position.y < return_current.polygon[0].y, "Glassfin Swarm should leave the lower return-current route readable")
	runner._expect(lane.color.b > lane.color.g and lane.color.g > lane.color.r, "Glassfin Swarm lane should use glassy blue timing language")
	runner._expect(body_a.color.b > body_a.color.g and body_a.color.g > body_a.color.r, "Glassfin Swarm body should avoid red predator and yellow resource language")
	runner._expect(body_a.color.a >= 0.78 and body_b.color.a >= 0.74, "Glassfin Swarm bodies should stay visible at normal play scale instead of becoming label-only targets")
	runner._expect(body_a_outline.color.a >= 0.68 and body_b_outline.color.a >= 0.68 and body_c_outline.color.a >= 0.64, "Glassfin Swarm should keep dark body outlines so the pale fish separate from chamber water")
	runner._expect(body_a_outline.color.b < body_a.color.b and body_a_outline.color.g < body_a.color.g, "Glassfin Swarm outline should frame the fish without reading as another bright timing cue")
	runner._expect(body_a.color.b > lantern_ray_body.color.b and body_a.color.r > lantern_ray_body.color.r, "Glassfin Swarm should read brighter and more glasslike than Lantern Ray")
	runner._expect(body_b.color.b > resource_glimmer.color.b, "Glassfin Swarm should stay distinct from yellow-green resource glimmers")
	runner._expect(body_a.color.r < predator_warning.color.r, "Glassfin Swarm should not reuse predator-warning red")
	runner._expect(return_gap.color.g > body_a.color.g and return_gap.color.a < return_current.color.a, "Glassfin Swarm return gap should remain softer than the main safe-return current")
	runner._expect(spacing_wake.color.a <= 0.18, "Glassfin Swarm spacing wake should be a subtle observation cue")
	runner._expect(swarm.is_in_group("scan_targets"), "Glassfin Swarm should register as a scan target once the scene is ready")
	runner._expect(scan_marker.color.a < 0.3, "Glassfin Swarm scan marker should stay subtle while idle")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, swarm) == "creature", "Glassfin Swarm scan target should read as a creature")
	runner._expect(ScanTargetResolverScript.target_id(swarm) == "glassfin_swarm", "Glassfin Swarm should expose a stable discovery id")
	runner._expect(swarm.find_child("CollisionShape2D", true, false) == null, "Glassfin Swarm should not add collision or physically block return")
	runner._expect(swarm.find_child("ResourcePickup", true, false) == null, "Glassfin Swarm should not add resource pickup behavior")
	runner._expect(swarm.find_child("HarvestArea", true, false) == null, "Glassfin Swarm should not add harvesting behavior")
	runner._expect(swarm.find_child("HealthBar", true, false) == null, "Glassfin Swarm should not add combat health UI")
	runner._expect(swarm.find_child("Predator", true, false) == null, "Glassfin Swarm should not reuse predator behavior")
	runner._expect(main.progression_state.to_save_data() == save_before, "Glassfin Swarm passive obstacle should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Glassfin Swarm passive obstacle should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Glassfin Swarm passive obstacle should not mutate cargo")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = swarm.global_position
	var scan_candidates: Array[Node] = [swarm]
	runner._expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == swarm, "scanner target selection should find Glassfin Swarm reliably at close range")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = ScanTargetResolverScript.target_id(swarm)
	var display_name: String = ScanTargetResolverScript.display_name(swarm)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(swarm),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(main, swarm)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, swarm) + ScanEffectTextServiceScript.first_scan_guidance(main, swarm)
	])
	var first_scan_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, swarm)
	runner._expect(main.progression_state.has_discovery("glassfin_swarm"), "first Glassfin Swarm scan should record a normal durable discovery")
	runner._expect(main.run_completed_scans == ["glassfin_swarm"], "first Glassfin Swarm scan should count as current-run scan evidence")
	runner._expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Glassfin Swarm scan should use the normal scan oxygen cost")
	runner._expect(first_scan_status.contains("Scanned Glassfin Swarm"), "first Glassfin Swarm scan status should name the creature")
	runner._expect(first_scan_guidance.contains("spacing lane"), "first Glassfin Swarm scan guidance should teach spacing")
	runner._expect(first_scan_guidance.contains("pass around"), "first Glassfin Swarm scan guidance should teach avoidance instead of fighting")
	runner._expect_no_monster_combat_language(first_scan_status, "Glassfin Swarm first scan status")
	runner._expect(not first_scan_status.to_lower().contains("field guide"), "Glassfin Swarm first scan should not imply field-guide UI")
	runner._expect(not first_scan_status.to_lower().contains("checklist"), "Glassfin Swarm first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, swarm) + ScanEffectTextServiceScript.signal_lens_pulse_text(main, swarm)
	])
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Glassfin Swarm scan should stay free like existing known scans")
	runner._expect(main.run_completed_scans == ["glassfin_swarm"], "repeat Glassfin Swarm scan should not duplicate current-run scan evidence")
	runner._expect(repeat_scan_status.contains("Glassfin Swarm known"), "repeat Glassfin Swarm scan should use compact known-target copy")
	runner._expect(repeat_scan_status.contains("observation refreshed"), "repeat Glassfin Swarm scan should refresh behavior text compactly")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved.get("scan_discoveries", {}).has("glassfin_swarm"), "Glassfin Swarm discovery should persist through normal scan discovery storage")
	runner._expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Glassfin Swarm scan should not mutate resources")
	runner._expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Glassfin Swarm scan should not mutate upgrades")
	runner._expect(is_equal_approx(float(saved.get("best_depth_reached", 0.0)), float(save_before.get("best_depth_reached", 0.0))), "Glassfin Swarm scan should not mutate best-depth state")
	runner._expect(not saved.has("glassfin_swarm_objective"), "Glassfin Swarm scan should not create durable objective-chain state")
	runner._expect(not saved.has("monster_parts"), "Glassfin Swarm scan should not add monster-part economy state")
	runner._expect(not saved.has("creature_inventory"), "Glassfin Swarm scan should not add creature inventory state")
	main.queue_free()

func _test_mirrorfin_route_read_behavior(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var mirrorfin := mirror_kelp.get_node("MirrorfinDrift") as Area2D
	var reflection_lane := mirrorfin.get_node("ReflectionLane") as Polygon2D
	var body := mirrorfin.get_node("MirrorfinBody") as Polygon2D
	var safe_break := mirrorfin.get_node("SafeBreakCue") as Polygon2D
	var scan_marker := mirrorfin.get_node("ScanMarker") as Polygon2D
	var tideglass_core := mirror_kelp.get_node("TideglassSample/SampleCore") as Polygon2D
	var predator_warning := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()
	main.player = scene_player
	mirrorfin.call("_ready")

	runner._expect(mirrorfin.get_parent() == mirror_kelp, "Mirrorfin should be authored inside Mirror Kelp Pass")
	runner._expect(mirrorfin.is_in_group("scan_targets"), "Mirrorfin should register as a scan target once the scene is ready")
	runner._expect(ScanTargetFeedbackServiceScript.format_scan_target_type(main, mirrorfin) == "creature", "Mirrorfin scan target should read as a creature")
	runner._expect(ScanTargetResolverScript.target_id(mirrorfin) == "mirrorfin_drift", "Mirrorfin should expose a stable discovery id")
	runner._expect(mirrorfin.collision_layer == 0 and mirrorfin.collision_mask == 0, "Mirrorfin should not collide, damage, or block the route")
	runner._expect(reflection_lane.color.b > reflection_lane.color.r and reflection_lane.color.a <= 0.16, "Mirrorfin reflection lane should use subtle cool timing language")
	runner._expect(body.color.b > body.color.r and body.color.g > body.color.r, "Mirrorfin body should avoid predator-warning red")
	runner._expect(body.color.b >= tideglass_core.color.b, "Mirrorfin should share branch reflection language without looking like cargo")
	runner._expect(body.color.r < predator_warning.color.r, "Mirrorfin should stay visually distinct from predator warnings")
	runner._expect(safe_break.color.g > safe_break.color.r and safe_break.color.a < 0.18, "Mirrorfin safe-break cue should be a subtle route read")
	runner._expect(scan_marker.color.a < 0.3, "Mirrorfin scan marker should stay subtle while idle")
	runner._expect(mirrorfin.find_child("CollisionShape2D", true, false) == null, "Mirrorfin should not add collision geometry")
	runner._expect(mirrorfin.find_child("HarvestArea", true, false) == null, "Mirrorfin should not add harvesting behavior")
	runner._expect(mirrorfin.find_child("HealthBar", true, false) == null, "Mirrorfin should not add combat health UI")
	runner._expect(mirrorfin.find_child("Predator", true, false) == null, "Mirrorfin should not reuse predator behavior")
	runner._expect(main.progression_state.to_save_data() == save_before, "Mirrorfin passive route read should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Mirrorfin passive route read should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Mirrorfin passive route read should not mutate cargo")

	var start_position := mirrorfin.global_position
	var end_position: Vector2 = mirrorfin.get("move_end")
	mirrorfin.call("_physics_process", 1.0)
	runner._expect(mirrorfin.global_position != start_position, "Mirrorfin should drift instead of reading as static scenery")
	runner._expect(mirrorfin.global_position.distance_to(end_position) < start_position.distance_to(end_position), "Mirrorfin drift should move toward the reflection break")

	main.dive_session.reset(main.max_oxygen)
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_in_base = false
	scene_player.global_position = mirrorfin.global_position
	var scan_candidates: Array[Node] = [mirrorfin]
	runner._expect(ScanTargetResolverScript.nearest(scene_player.global_position, main.scan_range, scan_candidates) == mirrorfin, "scanner target selection should find Mirrorfin reliably at close range")

	var starting_oxygen: float = main.dive_session.oxygen
	var discovery_id: String = ScanTargetResolverScript.target_id(mirrorfin)
	var display_name: String = ScanTargetResolverScript.display_name(mirrorfin)
	main.dive_session.drain_oxygen(main.scan_oxygen_cost)
	main.progression_state.add_discovery(
		discovery_id,
		display_name,
		ScanTargetResolverScript.description(mirrorfin),
		ScanEffectTextServiceScript.scan_target_gameplay_fact(main, mirrorfin)
	)
	main.run_completed_scans.append(discovery_id)
	var first_scan_status: String = HudPresenterScript.compact_dive_status("Scanned %s.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, mirrorfin) + ScanEffectTextServiceScript.first_scan_guidance(main, mirrorfin)
	])
	var first_scan_guidance: String = ScanEffectTextServiceScript.first_scan_guidance(main, mirrorfin)
	runner._expect(main.progression_state.has_discovery("mirrorfin_drift"), "first Mirrorfin scan should record a normal durable discovery")
	runner._expect(main.run_completed_scans == ["mirrorfin_drift"], "first Mirrorfin scan should count as current-run scan evidence")
	runner._expect(is_equal_approx(main.dive_session.oxygen, starting_oxygen - main.scan_oxygen_cost), "first Mirrorfin scan should use the normal scan oxygen cost")
	runner._expect(first_scan_status.contains("Scanned Mirrorfin Drift"), "first Mirrorfin scan status should name the creature")
	runner._expect(first_scan_guidance.contains("reflection break"), "first Mirrorfin scan guidance should teach the route read")
	runner._expect(first_scan_guidance.contains("after the shimmer"), "first Mirrorfin scan guidance should teach timing instead of fighting")
	runner._expect_no_monster_combat_language(first_scan_status, "Mirrorfin first scan status")
	runner._expect(not first_scan_status.to_lower().contains("field guide"), "Mirrorfin first scan should not imply field-guide UI")
	runner._expect(not first_scan_status.to_lower().contains("checklist"), "Mirrorfin first scan should not imply checklist UI")

	var oxygen_after_first: float = main.dive_session.oxygen
	var repeat_scan_status: String = HudPresenterScript.compact_dive_status("%s known.%s" % [
		display_name,
		ScanEffectTextServiceScript.repeat_scan_effect_text(main, mirrorfin) + ScanEffectTextServiceScript.signal_lens_pulse_text(main, mirrorfin)
	])
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_after_first), "repeat Mirrorfin scan should stay free like existing known scans")
	runner._expect(main.run_completed_scans == ["mirrorfin_drift"], "repeat Mirrorfin scan should not duplicate current-run scan evidence")
	runner._expect(repeat_scan_status.contains("Mirrorfin Drift known"), "repeat Mirrorfin scan should use compact known-target copy")
	runner._expect(repeat_scan_status.contains("observation refreshed"), "repeat Mirrorfin scan should refresh behavior text compactly")
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("Mirrorfin Drift"), "Mirrorfin first scan should produce compact discovery memory")
	runner._expect(SurfaceRunSummaryServiceScript.format_discovery_memory_callout(main).contains("without fighting"), "Mirrorfin discovery memory should frame observation as non-combat")
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Mirror Kelp"), "Mirrorfin scan should now support compact Mirror Kelp route memory")
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("reflection timing"), "Mirrorfin route memory should explain what the observation taught")
	main.run_reached_dusk_trench = true
	runner._expect(SurfaceRunSummaryServiceScript.format_route_choice_callout(main).contains("Mirror Kelp"), "Mirrorfin branch evidence should stay more specific than upstream route reach memory")

	var saved: Dictionary = main.progression_state.to_save_data()
	runner._expect(saved.get("scan_discoveries", {}).has("mirrorfin_drift"), "Mirrorfin discovery should persist through normal scan discovery storage")
	runner._expect(saved.get("banked_resources", {}) == save_before.get("banked_resources", {}), "Mirrorfin scan should not mutate resources")
	runner._expect(saved.get("purchased_upgrades", {}) == save_before.get("purchased_upgrades", {}), "Mirrorfin scan should not mutate upgrades")
	runner._expect(not saved.has("mirrorfin_objective"), "Mirrorfin scan should not create durable objective-chain state")
	runner._expect(not saved.has("monster_parts"), "Mirrorfin scan should not add monster-part economy state")
	runner._expect(not saved.has("creature_inventory"), "Mirrorfin scan should not add creature inventory state")
	main.queue_free()
