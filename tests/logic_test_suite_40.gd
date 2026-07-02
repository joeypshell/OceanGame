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

func _test_hollow_reef_timing_current_visual_only(runner) -> void:
	var main := MainScript.new()
	var low_alpha: float = RouteTimingCuePresenterScript.hollow_reef_timing_current_alpha(0.0, MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.hollow_reef_timing_current_alpha(MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.25, MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS)
	var return_alpha: float = RouteTimingCuePresenterScript.hollow_reef_timing_current_alpha(MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.5, MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS)

	runner._expect(high_alpha > low_alpha, "Hollow Reef timing current alpha should pulse upward to suggest wait/pass timing")
	runner._expect(is_equal_approx(low_alpha, return_alpha), "Hollow Reef timing current pulse should repeat smoothly")
	runner._expect(low_alpha >= 0.08 and high_alpha <= 0.16, "Hollow Reef timing current pulse should stay subtle and non-combat")

	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 20.0
	main.dive_session.current_cargo.append("glow_plankton")
	main.dive_session.has_left_base = true
	main.player_in_base = false
	main.run_predator_contacts = 1
	main.progression_state.banked_resources["shell_fragments"] = 2
	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true

	RouteTimingCueServiceScript.update_hollow_reef_timing_current(main, 0.7)
	runner._expect(is_equal_approx(main.dive_session.oxygen, 20.0), "Hollow Reef timing current should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == ["glow_plankton"], "Hollow Reef timing current should not change carried cargo")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "Hollow Reef timing current should not change dive result")
	runner._expect(main.dive_session.has_left_base, "Hollow Reef timing current should not reset extraction eligibility")
	runner._expect(not main.player_in_base, "Hollow Reef timing current should not move the player into the base")
	runner._expect(main.run_predator_contacts == 1, "Hollow Reef timing current should not create predator contacts")
	runner._expect(main.progression_state.resource_count("shell_fragments") == 2, "Hollow Reef timing current should not mutate banked resources")
	runner._expect(main.progression_state.has_upgrade(ResonanceKeyUpgrade.id), "Hollow Reef timing current should not mutate upgrade ownership")
	main.free()

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	scene_main.dive_session.reset(30.0)
	scene_main.dive_session.start()
	scene_main.dive_session.oxygen = 19.0
	scene_main.dive_session.current_cargo.append("kelp_fiber")
	scene_main.dive_session.has_left_base = true
	scene_main.player_in_base = false
	scene_main.run_predator_contacts = 1
	scene_main.progression_state.banked_resources["glow_plankton"] = 2

	var timing_cue := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue") as Node2D
	var upper := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonUpper") as Polygon2D
	var tick := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickA") as Polygon2D
	var return_current := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/LaneReturnCurrent") as Polygon2D
	var reading_halo := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo") as Polygon2D
	var pocket_glimmer := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/UpperShelfChoice/ShelteredResourcePocket/PocketGlimmer") as Polygon2D
	var predator_warning := scene_main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var pressure_shutter := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter") as Polygon2D

	runner._expect(timing_cue.find_child("CollisionShape2D", true, false) == null, "Hollow Reef timing current should not add collision")
	runner._expect(timing_cue.find_child("InteractZone", true, false) == null, "Hollow Reef timing current should not add an interaction hotspot")
	runner._expect(timing_cue.find_child("ResourcePickup", true, false) == null, "Hollow Reef timing current should not add resource behavior")
	runner._expect(timing_cue.find_child("Predator", true, false) == null, "Hollow Reef timing current should not reuse predator behavior")
	runner._expect(timing_cue.find_child("PressureBoundary", true, false) == null, "Hollow Reef timing current should not add pressure behavior")
	RouteTimingCueServiceScript.update_hollow_reef_timing_current(scene_main, MainScript.HOLLOW_REEF_TIMING_PERIOD_SECONDS * 0.25)
	runner._expect(upper.color.b > upper.color.g and upper.color.r > upper.color.g, "Hollow Reef timing current should use pale timing color instead of safe-current green")
	runner._expect(return_current.color.g > upper.color.g, "Hollow Reef safe-return current should stay greener than the timing cue")
	runner._expect(upper.color.r > pressure_shutter.color.r and upper.color.g > pressure_shutter.color.g, "Hollow Reef timing current should stay brighter than pressure-lock language")
	runner._expect(predator_warning.color.r > upper.color.r, "Hollow Reef timing current should stay distinct from red predator warning language")
	runner._expect(pocket_glimmer.color.g > upper.color.g, "Hollow Reef timing current should not read like the green-yellow resource pocket glimmer")
	runner._expect(upper.color.a <= 0.16 and tick.color.a <= 0.21, "Hollow Reef timing current should remain subtle enough not to obscure cave content")
	runner._expect(reading_halo.color.a >= upper.color.a, "Hollow Reef reading payoff should remain as visible as the timing cue")
	runner._expect(is_equal_approx(scene_main.dive_session.oxygen, 19.0), "scene Hollow Reef timing current should not drain oxygen")
	runner._expect(scene_main.dive_session.current_cargo == ["kelp_fiber"], "scene Hollow Reef timing current should not mutate cargo")
	runner._expect(scene_main.run_predator_contacts == 1, "scene Hollow Reef timing current should not create predator contacts")
	runner._expect(scene_main.progression_state.resource_count("glow_plankton") == 2, "scene Hollow Reef timing current should not mutate resources")
	scene_main.queue_free()

func _test_sealed_shelf_hatch_promise_state(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var lock_label := main.get_node("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	var lock_badge := main.get_node("EastShelfSpur/SealedShelfHatch/LockBadge") as Polygon2D
	var seal_bars := main.get_node("EastShelfSpur/SealedShelfHatch/SealBars") as Polygon2D
	main.sealed_shelf_hatch_echo_shimmer = main.get_node("EastShelfSpur/SealedShelfHatch/EchoShimmer") as Polygon2D
	main.sealed_shelf_hatch_lock_badge = lock_badge
	main.sealed_shelf_hatch_lock_label = lock_label
	var locked_badge_color := lock_badge.color
	var locked_bars_alpha := seal_bars.color.a
	main.call("_sync_sealed_shelf_hatch_state")
	runner._expect(lock_label.text == "ECHO LOCK", "Sealed Shelf Hatch should advertise the missing Echo Lens upgrade before ownership")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	main.call("_sync_sealed_shelf_hatch_state")
	runner._expect(lock_label.text == "ECHO PING", "Sealed Shelf Hatch should change to a scanner-ready promise after Echo Lens I")
	runner._expect(lock_badge.color != locked_badge_color, "Sealed Shelf Hatch badge should visually react to Echo Lens I ownership")

	main.progression_state.purchased_upgrades[ResonanceKeyUpgrade.id] = true
	main.dive_session.reset(30.0)
	main.dive_session.start()
	main.dive_session.oxygen = 18.0
	main.dive_session.current_cargo = ["glow_plankton"]
	main.run_east_shelf_pocket_ping_recovered = true
	main.run_lower_connector_echo_recovered = true
	main.call("_sync_sealed_shelf_hatch_state")
	runner._expect(lock_label.text == "OPEN", "Sealed Shelf Hatch should visibly open after Resonance Key I")
	runner._expect(lock_badge.color != locked_badge_color, "open Sealed Shelf Hatch badge should stay visually distinct from the locked state")
	runner._expect(seal_bars.color.a < locked_bars_alpha, "open Sealed Shelf Hatch should soften the seal bars without adding an interior")
	runner._expect(main.get_node_or_null("EastShelfSpur/SealedShelfHatch/Interior") == null, "open hatch should not add a broad interior system")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 18.0), "open hatch sync should not change oxygen")
	runner._expect(main.dive_session.current_cargo == ["glow_plankton"], "open hatch sync should not change carried cargo")
	runner._expect(main.dive_session.result == DiveSessionScript.Result.DIVING, "open hatch sync should not change dive state")
	var saved_after_open: Dictionary = main.progression_state.to_save_data()
	runner._expect(not saved_after_open.has("quest"), "open hatch should not add durable quest state")
	runner._expect(not saved_after_open.has("map"), "open hatch should not add durable map state")
	runner._expect(not saved_after_open.has("objective"), "open hatch should not add durable objective state")
	runner._expect(not saved_after_open.has("sealed_shelf_hatch_open"), "open hatch should be derived from Resonance Key ownership, not separate hatch save state")
	main.queue_free()

	var copy_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_sealed_shelf_hatch_readiness_callout(copy_main) == "", "sealed hatch readiness copy should stay hidden before Echo Lens I")
	copy_main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	runner._expect(ResearchResultCalloutServiceScript.format_sealed_shelf_hatch_readiness_callout(copy_main) == "", "sealed hatch readiness copy should need recovered route research")
	copy_main.run_east_shelf_pocket_ping_recovered = true
	var readiness_copy := ResearchResultCalloutServiceScript.format_sealed_shelf_hatch_readiness_callout(copy_main)
	runner._expect(readiness_copy.contains("Sealed Shelf Hatch"), "sealed hatch readiness copy should name the hatch promise")
	runner._expect(readiness_copy.contains("Resonance Key"), "sealed hatch readiness copy should point to the future key promise")
	runner._expect_no_echo_lens_locator_language(readiness_copy, "sealed hatch readiness copy")

	var empty_cargo: Array[String] = []
	var extraction_summary := SurfaceRunSummaryServiceScript.format_extraction_result_summary(copy_main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Resonance Key"), "sealed hatch readiness copy should appear in extraction result after relevant research")
	copy_main.free()

func _test_player_visual_facing_isolation(runner) -> void:
	var player := PlayerScene.instantiate()
	runner.root.add_child(player)
	var visual_root: Node2D = player.get_node("VisualRoot")

	player.call("_set_facing_sign", -1.0)
	runner._expect(player.scale == Vector2.ONE, "facing should not mirror the physics/player runner.root")
	runner._expect(visual_root.scale.x == -1.0, "facing left should mirror only the visual runner.root")
	player.set("_last_move_direction", Vector2.ZERO)
	runner._expect(player.get_burst_direction() == Vector2.LEFT, "burst fallback should use the tracked left-facing sign")

	player.call("_set_facing_sign", 1.0)
	runner._expect(player.scale == Vector2.ONE, "facing right should keep the physics/player runner.root unmirrored")
	runner._expect(visual_root.scale.x == 1.0, "facing right should restore the visual runner.root")
	player.set("_last_move_direction", Vector2.ZERO)
	runner._expect(player.get_burst_direction() == Vector2.RIGHT, "burst fallback should use the tracked right-facing sign")

	player.queue_free()

func _test_player_idle_and_thrust_visual_states(runner) -> void:
	var player := PlayerScene.instantiate()
	runner.root.add_child(player)
	var idle_bubble: Polygon2D = player.get_node("VisualRoot/IdleBubble")
	var thrust_flare: Polygon2D = player.get_node("VisualRoot/ThrustFlare")
	var bubble_trail: Polygon2D = player.get_node("VisualRoot/BubbleTrail")
	var focal_halo: Polygon2D = player.get_node("VisualRoot/FocalHalo")
	var nose_light: Polygon2D = player.get_node("VisualRoot/NoseLight")
	var swim_sprite: Sprite2D = player.get_node("VisualRoot/SubSpriteAnchor/SubSprite")

	player.call("_sync_movement_visuals", 0.1, false)
	runner._expect(player.scale == Vector2.ONE, "visual motion state should not modify the physics/player runner.root")
	runner._expect(focal_halo.visible and focal_halo.z_index < 0, "idle state should keep a subtle player focal halo behind the diver")
	runner._expect(nose_light.visible and nose_light.z_index < 0, "idle state should keep the nose light behind interaction glows")
	var idle_nose_alpha := nose_light.color.a
	var idle_halo_alpha := focal_halo.color.a
	runner._expect(idle_nose_alpha <= 0.23, "idle nose light should stay subtle and not wash out cargo glows")
	runner._expect(idle_halo_alpha <= 0.13, "idle player halo should stay quieter than active interaction glows")
	runner._expect(idle_bubble.visible, "idle state should show the idle bubble treatment")
	runner._expect(not thrust_flare.visible, "idle state should hide the thrust flare")
	runner._expect(bubble_trail.color.a < 0.3, "idle state should keep the bubble trail subtle")
	runner._expect(swim_sprite.region_rect.position.x == 0.0, "idle state should return the diver sheet to the stable first frame")

	player.call("_set_facing_sign", -1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	runner._expect(player.scale == Vector2.ONE, "moving visual state should keep the physics/player runner.root unmirrored")
	runner._expect(player.get_node("VisualRoot").scale.x == -1.0, "moving visual state should work while facing left")
	runner._expect(not idle_bubble.visible, "moving state should hide the idle bubble treatment")
	runner._expect(thrust_flare.visible, "moving state should show the thrust flare")
	runner._expect(nose_light.color.a > idle_nose_alpha, "moving state should strengthen the forward focal light")
	runner._expect(focal_halo.color.a >= idle_halo_alpha, "moving state should preserve the local focal halo")
	runner._expect(nose_light.polygon[2].x > 120.0, "nose light should project ahead of the diver rather than become a small marker")
	runner._expect(bubble_trail.color.a > 0.4, "moving state should strengthen the bubble trail")
	runner._expect(swim_sprite.region_rect.position.x > 0.0, "moving state should advance the diver swim-sheet frame")

	player.call("_set_facing_sign", 1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	runner._expect(player.get_node("VisualRoot").scale.x == 1.0, "moving visual state should work while facing right")
	runner._expect(thrust_flare.visible, "right-facing movement should keep thrust flare visible")
	runner._expect(swim_sprite.region_rect.size == Vector2(362.0, 724.0), "right-facing movement should preserve the swim-sheet frame size")

	player.queue_free()

func _test_predator_decoy_pulse_helper(runner) -> void:
	var predator := PredatorScript.new()
	predator.global_position = Vector2(100.0, 0.0)
	predator.patrol_start = Vector2.ZERO
	predator.patrol_end = Vector2(200.0, 0.0)

	predator.trigger_decoy_from(Vector2.ZERO, 2.5, 260.0)
	runner._expect(predator.is_decoy_active(), "decoy pulse should mark predator as distracted")
	runner._expect(is_equal_approx(predator.decoy_time_remaining(), 2.5), "decoy pulse should preserve configured duration")
	runner._expect(predator.decoy_target().x > predator.global_position.x, "decoy target should pull predator away from player")
	runner._expect(predator.decoy_target().distance_to(predator.global_position) > 200.0, "decoy target should create a meaningful route-timing window")
	predator.free()

func _test_decoy_pulse_feedback_text(runner) -> void:
	var main := MainScript.new()
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main) == "", "decoy prompt should stay hidden before Gulper Eel discovery")
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_scan_feedback(main).contains("unavailable"), "decoy scan feedback should explain unavailable state")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main).contains("locked"), "decoy prompt should show upgrade-locked state after discovery")

	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main).contains("ready"), "decoy prompt should show ready state when owned and unused")
	main.decoy_pulse_activated_this_scan = true
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_scan_feedback(main).contains("spent"), "decoy scan feedback should report use")
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_scan_feedback(main).contains("3s"), "decoy scan feedback should report duration")

	main.decoy_pulse_activated_this_scan = false
	main.decoy_pulse_used_this_run = true
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_prompt(main).contains("spent"), "decoy prompt should show spent state")
	runner._expect(UpgradeStateServiceScript.format_decoy_pulse_scan_feedback(main).contains("already spent"), "decoy scan feedback should explain repeat denial")
	main.free()
