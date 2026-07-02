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

func _test_mirror_kelp_deep_promise(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var promise := mirror_kelp.get_node("DeepKelpSealPromise") as Node2D
	var seal_mouth := promise.get_node("SealMouth") as Polygon2D
	var pressure_veil := promise.get_node("PressureVeil") as Polygon2D
	var kelp_bars := promise.get_node("KelpSealBars") as Polygon2D
	var future_glint := promise.get_node("FutureGlint") as Polygon2D
	var promise_label := promise.get_node("PromiseLabel") as Label
	var tideglass := mirror_kelp.get_node("TideglassSample") as Node2D
	var tideglass_core := mirror_kelp.get_node("TideglassSample/SampleCore") as Polygon2D
	var mirrorfin := mirror_kelp.get_node("MirrorfinDrift") as Area2D
	var return_label := mirror_kelp.get_node("ReturnLabel") as Label
	var landmark := main.get_node("LandmarkMetadata/MirrorKelpPass")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()

	runner._expect(promise.get_parent() == mirror_kelp, "deep kelp promise should be authored inside Mirror Kelp Pass")
	runner._expect(promise.position.x > tideglass.position.x, "deep kelp promise should sit beyond the Tideglass payoff")
	runner._expect(promise.position.x > mirrorfin.position.x, "deep kelp promise should sit beyond the Mirrorfin route-read lane")
	runner._expect(promise.position.y > tideglass.position.y, "deep kelp promise should point toward deeper branch growth")
	runner._expect(return_label.text.contains("WIDE REEF"), "Mirror Kelp return label should stay readable beside the future promise")
	runner._expect(seal_mouth.color.a >= 0.6, "deep kelp promise should read as a closed route mouth")
	runner._expect(pressure_veil.color.b > pressure_veil.color.r and pressure_veil.color.a <= 0.2, "deep kelp pressure veil should stay subtle and cool")
	runner._expect(kelp_bars.color.g > kelp_bars.color.r and kelp_bars.color.a <= 0.28, "deep kelp seal bars should use quiet route language instead of resource glow")
	runner._expect(future_glint.color.a <= 0.32 and future_glint.color.a < tideglass_core.color.a, "deep kelp promise glint should stay a future hint, not a collectible")
	runner._expect(tideglass_core.color.b >= tideglass_core.color.r and tideglass_core.color.a >= 0.8, "Tideglass should stay brighter than sealed-route promise language")
	runner._expect(promise_label.text == "KELP SEALED", "deep kelp promise label should be compact and honest")
	runner._expect(not promise_label.text.to_lower().contains("objective"), "deep kelp promise should not imply objective checklist language")
	runner._expect(not promise_label.text.to_lower().contains("map"), "deep kelp promise should not imply exact locator UI")
	runner._expect(not promise_label.text.to_lower().contains("open"), "deep kelp promise should not imply current access")
	runner._expect(promise.get_node_or_null("InteractZone") == null, "deep kelp promise should not add interaction yet")
	runner._expect(promise.find_child("CollisionShape2D", true, false) == null, "deep kelp promise should not add collision")
	runner._expect(promise.find_child("ResourcePickup", true, false) == null, "deep kelp promise should not add a pickup")
	runner._expect(promise.find_child("LootTable", true, false) == null, "deep kelp promise should not add loot tables")
	runner._expect(promise.find_child("HarvestArea", true, false) == null, "deep kelp promise should not add harvesting")
	runner._expect(promise.find_child("HealthBar", true, false) == null, "deep kelp promise should not add combat UI")
	runner._expect(promise.get_script() == null, "deep kelp promise should stay visual/readback only")
	var landmark_memory := "%s %s %s" % [
		String(landmark.get("display_name")),
		String(landmark.get("memory_goal")),
		String(landmark.get("persistent_facts")),
	]
	runner._expect(landmark_memory.contains("Mirror Kelp Pass"), "deep kelp promise should point back to the remembered Mirror Kelp place")
	runner._expect(landmark_memory.contains("closed deep-kelp route promise"), "Mirror Kelp metadata should record the promise as future route memory")
	runner._expect(not landmark_memory.to_lower().contains("coordinates"), "Mirror Kelp metadata should avoid exact locator framing")
	runner._expect(main.get_node_or_null("ResourcePickups/DeepKelp") == null, "deep kelp promise should not create a resource pickup")
	runner._expect(main.progression_state.to_save_data() == save_before, "deep kelp promise should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "deep kelp promise should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "deep kelp promise should not mutate cargo")
	main.queue_free()

func _test_outer_shelf_route_footprint(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var mirror_kelp := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	var outer_shelf := mirror_kelp.get_node("OuterShelfReach") as Node2D
	var deep_backwater := outer_shelf.get_node("DeepBackwater") as Polygon2D
	var playable_lane := outer_shelf.get_node("PlayableWaterLane") as Polygon2D
	var mid_plate := outer_shelf.get_node("MidShelfBackPlate") as Polygon2D
	var upper_rim := outer_shelf.get_node("UpperRimSilhouette") as Polygon2D
	var lower_rim := outer_shelf.get_node("LowerRimSilhouette") as Polygon2D
	var glass_rim := outer_shelf.get_node("GlassRimLandmark") as Polygon2D
	var glass_steps := outer_shelf.get_node("GlassRimShelfSteps") as Polygon2D
	var low_shelf := outer_shelf.get_node("LowShelfLandmark") as Polygon2D
	var survey_perch := outer_shelf.get_node("SurveyPerchShadow") as Polygon2D
	var foreground_shelf := outer_shelf.get_node("OuterShelfForegroundShelf") as Polygon2D
	var return_wash := outer_shelf.get_node("ReturnWashToMirror") as Polygon2D
	var survey_core := outer_shelf.get_node("OuterShelfSurveyCore") as Node2D
	var survey_visual := survey_core.get_node("SurveyCore") as Polygon2D
	var outer_label := outer_shelf.get_node("OuterShelfLabel") as Label
	var glass_label := outer_shelf.get_node("GlassRimLabel") as Label
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()

	var min_x := INF
	var max_x := -INF
	for point in deep_backwater.polygon:
		min_x = minf(min_x, point.x)
		max_x = maxf(max_x, point.x)

	runner._expect(outer_shelf.get_parent() == mirror_kelp, "Outer Shelf should extend from the current Mirror Kelp edge")
	runner._expect(outer_shelf.position.x > 280.0, "Outer Shelf should sit beyond existing Mirror Kelp payoffs")
	runner._expect(max_x - min_x >= 1200.0, "Outer Shelf footprint should be wide enough for later branch and decision work")
	runner._expect(playable_lane.color.a <= 0.2, "Outer Shelf playable water should stay readable without becoming a bright pickup")
	runner._expect(deep_backwater.color.a > playable_lane.color.a, "Outer Shelf background should frame the route with darker mass")
	runner._expect(mid_plate.color.a > playable_lane.color.a and mid_plate.color.a < deep_backwater.color.a, "Outer Shelf mid plate should separate route mass from playable water")
	runner._expect(upper_rim.color.a >= 0.45 and lower_rim.color.a >= 0.45, "Outer Shelf terrain rims should be distinguishable from playable water")
	runner._expect(glass_rim.color.a <= 0.24 and low_shelf.color.a <= 0.32, "Outer Shelf landmarks should not compete with future payoffs")
	runner._expect(glass_steps.color.a > glass_rim.color.a and glass_steps.color.a < survey_visual.color.a, "Outer Shelf Glass Rim steps should frame the route without competing with the survey")
	runner._expect(survey_perch.color.a < survey_visual.color.a and survey_perch.polygon.size() >= 5, "Outer Shelf survey perch should anchor the payoff as terrain, not cargo")
	runner._expect(foreground_shelf.color.a >= 0.42 and foreground_shelf.color.a < upper_rim.color.a, "Outer Shelf foreground shelf should read as terrain while staying behind active rewards")
	runner._expect(return_wash.color.g > return_wash.color.r and return_wash.color.a <= 0.12, "Outer Shelf return wash should use quiet safe-current language")
	runner._expect(outer_label.text == "OUTER SHELF", "Outer Shelf should have one compact region label")
	runner._expect(glass_label.text == "GLASS RIM", "Outer Shelf should have one compact local landmark label")
	runner._expect(not outer_label.text.to_lower().contains("objective"), "Outer Shelf label should not become checklist copy")
	runner._expect(not glass_label.text.to_lower().contains("map"), "Glass Rim label should not imply exact map UI")
	runner._expect(survey_core.get_node_or_null("InteractZone/CollisionShape2D") != null, "Outer Shelf should own exactly one nested survey interaction")
	runner._expect(outer_shelf.get_node_or_null("InteractZone") == null, "Outer Shelf footprint should not add a route-wide interaction hotspot")
	runner._expect(outer_shelf.find_child("CollisionShape2D", true, false) == survey_core.get_node("InteractZone/CollisionShape2D"), "Outer Shelf footprint should only add collision for the survey trigger")
	runner._expect(outer_shelf.find_child("ResourcePickup", true, false) == null, "Outer Shelf footprint should not add pickups yet")
	runner._expect(outer_shelf.find_child("LootTable", true, false) == null, "Outer Shelf footprint should not add loot tables")
	runner._expect(outer_shelf.find_child("HealthBar", true, false) == null, "Outer Shelf footprint should not add combat UI")
	runner._expect(main.progression_state.to_save_data() == save_before, "Outer Shelf footprint should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Outer Shelf footprint should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Outer Shelf footprint should not mutate cargo")

	var player_bounds := PlayerScript.new()
	var outer_center := outer_shelf.global_position + Vector2(940.0, 120.0)
	var clamped_outer := player_bounds.clamp_position_to_world_bounds(outer_center)
	runner._expect(clamped_outer == outer_center, "player bounds should include the first Outer Shelf footprint")
	player_bounds.free()

	var scene_player := main.get_node("Player") as CharacterBody2D
	main.player = scene_player
	scene_player.global_position = outer_center
	var outer_direction: String = main.call("_format_base_direction")
	runner._expect(outer_direction.contains("up-left"), "Outer Shelf base direction should use broad return orientation")
	runner._expect(outer_direction.contains("Mirror/Wide/Hollow"), "Outer Shelf base direction should keep compact named return memory")
	runner._expect_no_echo_lens_locator_language(outer_direction, "Outer Shelf base direction")
	main.queue_free()

func _test_outer_shelf_glass_rim_branch(runner) -> void:
	var main := MainScene.instantiate()
	runner.root.add_child(main)
	var outer_shelf := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach") as Node2D
	var branch := outer_shelf.get_node("GlassRimCutBranch") as Node2D
	var mouth_shadow := branch.get_node("BranchMouthShadow") as Polygon2D
	var water_pocket := branch.get_node("BranchWaterPocket") as Polygon2D
	var upper_rim := branch.get_node("UpperCutRim") as Polygon2D
	var lower_rim := branch.get_node("LowerCutRim") as Polygon2D
	var return_wash := branch.get_node("BranchReturnWash") as Polygon2D
	var branch_label := branch.get_node("BranchLabel") as Label
	var rim_promise := outer_shelf.get_node("RimSealPromise") as Node2D
	var rim_promise_mouth := rim_promise.get_node("SealMouth") as Polygon2D
	var rim_promise_veil := rim_promise.get_node("SealVeil") as Polygon2D
	var rim_promise_bars := rim_promise.get_node("RimSealBars") as Polygon2D
	var rim_promise_glint := rim_promise.get_node("FutureGlint") as Polygon2D
	var rim_promise_label := rim_promise.get_node("PromiseLabel") as Label
	var survey_core := outer_shelf.get_node("OuterShelfSurveyCore/SurveyCore") as Polygon2D
	var outer_metadata := main.get_node("LandmarkMetadata/OuterShelf")
	var branch_metadata := main.get_node("LandmarkMetadata/GlassRimCut")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()

	runner._expect(branch.get_parent() == outer_shelf, "Glass Rim Cut should be authored inside the Outer Shelf footprint")
	runner._expect(branch.position.x > 700.0, "Glass Rim Cut should sit deeper inside Area 02 instead of at the entrance")
	runner._expect(branch.position.y < 0.0, "Glass Rim Cut should read as a high branch off the main water lane")
	runner._expect(branch_label.text == "GLASS RIM CUT", "Glass Rim Cut should have compact place-label copy")
	runner._expect(not branch_label.text.to_lower().contains("objective"), "Glass Rim Cut label should not read like a checklist")
	runner._expect(not branch_label.text.to_lower().contains("map"), "Glass Rim Cut label should not imply exact map UI")
	runner._expect(mouth_shadow.color.a >= 0.5, "Glass Rim Cut branch mouth should read as a deliberate side opening")
	runner._expect(water_pocket.color.a <= 0.18, "Glass Rim Cut water should stay readable without becoming a reward marker")
	runner._expect(upper_rim.color.a <= 0.24 and lower_rim.color.a <= 0.34, "Glass Rim Cut rims should frame the branch without overpowering the sub")
	runner._expect(return_wash.color.g > return_wash.color.r and return_wash.color.a <= 0.1, "Glass Rim Cut return wash should use quiet safe-current language")
	runner._expect(branch.find_child("InteractZone", true, false) == null, "Glass Rim Cut branch should not add interactions yet")
	runner._expect(branch.find_child("CollisionShape2D", true, false) == null, "Glass Rim Cut branch should not add collision yet")
	runner._expect(branch.find_child("ResourcePickup", true, false) == null, "Glass Rim Cut branch should not add pickups yet")
	runner._expect(branch.find_child("ScannerObjective", true, false) == null, "Glass Rim Cut branch should not add objective-like scanner UI")
	runner._expect(branch.find_child("LootTable", true, false) == null, "Glass Rim Cut branch should not add loot tables")
	runner._expect(branch.find_child("HealthBar", true, false) == null, "Glass Rim Cut branch should not add combat UI")
	runner._expect(rim_promise.position.x > branch.position.x, "Rim Seal Promise should sit beyond the visible Glass Rim Cut landmark")
	runner._expect(rim_promise_label.text == "RIM SEAL NEEDED", "Rim Seal Promise should name the missing capability compactly")
	runner._expect(not rim_promise_label.text.to_lower().contains("objective"), "Rim Seal Promise should not read like a checklist objective")
	runner._expect(not rim_promise_label.text.to_lower().contains("map"), "Rim Seal Promise should not imply exact map UI")
	runner._expect(rim_promise_mouth.color.a >= 0.5, "Rim Seal Promise should read as a blocked future route mouth")
	runner._expect(rim_promise_veil.color.a <= 0.14, "Rim Seal Promise veil should stay quieter than active goals")
	runner._expect(rim_promise_bars.color.a <= 0.24, "Rim Seal Promise bars should stay quieter than recoverable payoffs")
	runner._expect(rim_promise_glint.color.a <= 0.28, "Rim Seal Promise glint should be curiosity, not a reward marker")
	runner._expect(rim_promise_bars.color.a < survey_core.color.a, "Rim Seal Promise should be quieter than the active Outer Shelf survey payoff")
	runner._expect(rim_promise.get_node_or_null("InteractZone") == null, "Rim Seal Promise should not add an active interaction")
	runner._expect(rim_promise.find_child("CollisionShape2D", true, false) == null, "Rim Seal Promise should not add collision")
	runner._expect(rim_promise.find_child("ResourcePickup", true, false) == null, "Rim Seal Promise should not create cargo")
	runner._expect(rim_promise.find_child("UpgradeDefinition", true, false) == null, "Rim Seal Promise should not create a purchasable upgrade entry")
	var outer_memory := "%s %s %s" % [
		String(outer_metadata.get("display_name")),
		String(outer_metadata.get("memory_goal")),
		String(outer_metadata.get("persistent_facts")),
	]
	var branch_memory := "%s %s %s" % [
		String(branch_metadata.get("display_name")),
		String(branch_metadata.get("memory_goal")),
		String(branch_metadata.get("persistent_facts")),
	]
	runner._expect(outer_memory.contains("Outer Shelf"), "Outer Shelf metadata should support future result memory")
	runner._expect(outer_memory.contains("Mirror Kelp"), "Outer Shelf metadata should preserve broad return orientation")
	runner._expect(branch_memory.contains("Glass Rim Cut"), "Glass Rim Cut metadata should support future result memory")
	runner._expect(branch_memory.contains("up-left") or branch_memory.contains("back left"), "Glass Rim Cut metadata should preserve broad return orientation")
	runner._expect_no_echo_lens_locator_language(outer_memory, "Outer Shelf metadata")
	runner._expect_no_echo_lens_locator_language(branch_memory, "Glass Rim Cut metadata")
	runner._expect(main.progression_state.to_save_data() == save_before, "Glass Rim Cut branch should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "Glass Rim Cut branch should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "Glass Rim Cut branch should not mutate cargo")
	main.queue_free()

func _test_outer_shelf_slackwater_timing_cue_visual_only(runner) -> void:
	var low_alpha: float = RouteTimingCuePresenterScript.outer_shelf_slackwater_alpha(0.0, MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var high_alpha: float = RouteTimingCuePresenterScript.outer_shelf_slackwater_alpha(MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25, MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var repeat_alpha: float = RouteTimingCuePresenterScript.outer_shelf_slackwater_alpha(MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.5, MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var open_state: String = RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_state(
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25,
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
		MainScript.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
		MainScript.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
	)
	var surge_state: String = RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_state(
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.75,
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
		MainScript.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
		MainScript.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
	)
	var open_prompt: String = RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_prompt_for_timer(
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25,
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
		MainScript.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
		MainScript.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
	)
	var surge_prompt: String = RouteTimingCuePresenterScript.outer_shelf_slackwater_decision_prompt_for_timer(
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.75,
		MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS,
		MainScript.OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD,
		MainScript.OUTER_SHELF_SLACKWATER_EASING_THRESHOLD
	)
	runner._expect(high_alpha > low_alpha, "Outer Shelf slackwater timing cue alpha should pulse upward to suggest a crossing window")
	runner._expect(is_equal_approx(low_alpha, repeat_alpha), "Outer Shelf slackwater timing cue should repeat smoothly")
	runner._expect(open_state == "open", "Outer Shelf slackwater timing should expose a readable open-crossing state")
	runner._expect(surge_state == "surging", "Outer Shelf slackwater timing should expose a readable turn-back state")
	runner._expect(open_prompt.contains("cross now") and open_prompt.contains("bank cargo"), "Outer Shelf open timing prompt should present a local push-or-bank decision")
	runner._expect(surge_prompt.contains("turn back") and surge_prompt.contains("oxygen"), "Outer Shelf surge timing prompt should frame the cost of waiting")
	runner._expect(not open_prompt.to_lower().contains("map") and not open_prompt.to_lower().contains("objective"), "Outer Shelf timing prompt should not imply map or checklist UI")

	var scene_main := MainScene.instantiate()
	runner.root.add_child(scene_main)
	var branch := scene_main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch") as Node2D
	var wake := branch.get_node("SlackwaterTimingWake") as Polygon2D
	var window := branch.get_node("SlackwaterWindow") as Polygon2D
	var tick := branch.get_node("SlackwaterTickA") as Polygon2D
	var return_wash := branch.get_node("BranchReturnWash") as Polygon2D
	var branch_mouth := branch.get_node("BranchMouthShadow") as Polygon2D
	scene_main.dive_session.reset(24.0)
	scene_main.dive_session.start()
	scene_main.dive_session.has_left_base = true
	scene_main.dive_session.current_cargo.append("kelp_fiber")
	var save_before: Dictionary = scene_main.progression_state.to_save_data().duplicate(true)

	RouteTimingCueServiceScript.update_outer_shelf_slackwater_timing_cue(scene_main, MainScript.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	runner._expect(window.color.b > window.color.g and window.color.r > return_wash.color.r, "Outer Shelf slackwater timing should use pale violet timing language instead of safe-current green")
	runner._expect(return_wash.color.g > window.color.g, "Glass Rim return wash should stay visually distinct from the timing window")
	runner._expect(wake.color.a <= 0.15 and window.color.a <= 0.2 and tick.color.a <= 0.23, "Outer Shelf slackwater timing cue should stay subtle and non-blocking")
	runner._expect(window.color.a > wake.color.a, "Outer Shelf slackwater window should become the clearest local crossing read")
	runner._expect(window.color.a < branch_mouth.color.a, "Outer Shelf slackwater timing cue should not overpower the branch mouth")
	runner._expect(is_equal_approx(scene_main.dive_session.oxygen, 24.0), "Outer Shelf slackwater timing cue should not drain oxygen")
	runner._expect(scene_main.dive_session.current_cargo == ["kelp_fiber"], "Outer Shelf slackwater timing cue should not mutate cargo")
	runner._expect(scene_main.dive_session.result == DiveSessionScript.Result.DIVING, "Outer Shelf slackwater timing cue should not change dive result")
	runner._expect(scene_main.progression_state.to_save_data() == save_before, "Outer Shelf slackwater timing cue should not mutate durable progression")
	runner._expect(branch.find_child("PressureBoundary", true, false) == null, "Outer Shelf slackwater timing cue should not add hidden pressure behavior")
	runner._expect(branch.find_child("Predator", true, false) == null, "Outer Shelf slackwater timing cue should not add combat pressure")
	runner._expect(branch.find_child("ResourcePickup", true, false) == null, "Outer Shelf slackwater timing cue should not create cargo")
	scene_main.queue_free()
