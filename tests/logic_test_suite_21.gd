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

func _test_area_01_reusable_reef_visual_kit(runner) -> void:
	var main := MainScene.instantiate()
	var wall_paths := [
		"Area01ArtSlice/TerrainVisualEdges/LeftWallReefKit/ReefRockStack",
		"Area01ArtSlice/TerrainVisualEdges/RightWallReefKit/ReefRockStack",
		"Area01ArtSlice/TerrainVisualEdges/LeftLedgeReefKit/TopLipHighlight",
		"Area01ArtSlice/TerrainVisualEdges/RightLedgeReefKit/TopLipHighlight",
	]
	for path in wall_paths:
		var wall_piece := main.get_node(path) as Polygon2D
		runner._expect(wall_piece != null, "Area 01 shell wall and ledge should use the reusable reef visual kit: %s" % path)
		runner._expect(wall_piece.color.a <= 0.8, "reusable reef wall dressing should stay below pickup/scan brightness: %s" % path)

	var pocket_paths := [
		"Area01ArtSlice/GameplayObjects/LeftShallowResourcePocket/ReusablePocketArt/ResourceBed",
		"Area01ArtSlice/GameplayObjects/RightShelfResourcePocket/ReusablePocketArt/ResourceBed",
		"Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket/ReusablePocketArt/CargoReadGap",
		"Area01ArtSlice/GameplayObjects/RightDeepResourcePocket/ReusablePocketArt/CargoReadGap",
	]
	for path in pocket_paths:
		var pocket_piece := main.get_node(path) as Polygon2D
		runner._expect(pocket_piece != null, "Area 01 resource pockets should use the reusable pocket visual kit: %s" % path)
		runner._expect(pocket_piece.color.a <= 0.5, "resource pocket dressing should support cargo readability without becoming the reward: %s" % path)
	main.free()

func _test_landmark_region_identity_metadata(runner) -> void:
	var main := MainScene.instantiate()
	var metadata_root := main.get_node("LandmarkMetadata")
	var expected_regions := {
		"SurfaceBase": "Surface Base",
		"ShellReef": "Shell Reef",
		"EastShelfArch": "East Shelf Spur",
		"DropArch": "Shelf Drop Connector",
		"BlueChimney": "Blue Chimney Pocket",
		"SiltVeinFork": "Silt Vein Fork",
		"DuskTrench": "Dusk Trench",
		"HollowReef": "Hollow Reef",
		"GlassRibSpan": "Wide Reef Chamber",
		"LowCrownShelf": "Wide Reef Chamber",
		"MirrorKelpPass": "Mirror Kelp Pass",
		"ThermalVentField": "Thermal Vent Field",
		"WreckShelf": "Wreck Shelf",
		"PressureLockedWreck": "Wreck Shelf",
		"GulperRoute": "Gulper Route",
	}

	for node_name in expected_regions.keys():
		var landmark := metadata_root.get_node(node_name)
		runner._expect(String(landmark.get("stable_region_name")) == expected_regions[node_name], "landmark should expose stable region name: %s" % node_name)
		runner._expect(not String(landmark.get("memory_goal")).is_empty(), "landmark should describe its player memory goal: %s" % node_name)
		runner._expect(not String(landmark.get("memory_goal")).to_lower().contains("coordinate"), "landmark should avoid exact-coordinate memory language: %s" % node_name)
		runner._expect(not String(landmark.get("memory_goal")).to_lower().contains("marker"), "landmark should avoid map-marker memory language: %s" % node_name)
		runner._expect(not String(landmark.get("memory_goal")).to_lower().contains("objective"), "landmark should avoid objective/checklist language: %s" % node_name)

	main.free()

func _test_predator_scan_target(runner) -> void:
	var predator := PredatorScript.new()
	predator.discovery_id = "gulper_eel"
	predator.display_name = "Gulper Eel"
	predator.description = "Predator profile."
	predator.global_position = Vector2(12.0, 0.0)

	runner._expect(ScanTargetResolverScript.is_valid_target(predator), "visible predator with discovery id should be a scan target")
	runner._expect(ScanTargetResolverScript.target_id(predator) == "gulper_eel", "predator scan target should expose discovery id")
	runner._expect(ScanTargetResolverScript.display_name(predator) == "Gulper Eel", "predator scan target should expose display name")
	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, [predator])
	runner._expect(selected == predator, "scanner resolver should select the predator when it is in range")

	predator.visible = false
	runner._expect(not ScanTargetResolverScript.is_valid_target(predator), "hidden predator should not be a valid scan target")
	predator.free()

func _test_discovery_prerequisites(runner) -> void:
	var progression := ProgressionStateScript.new()

	runner._expect(OxygenTankUpgrade.required_discovery.is_empty(), "Oxygen Tank I should not require a discovery")
	runner._expect(PressureSealUpgrade.required_discovery == "thermal_vent", "Pressure Seal I should require Thermal Vent")
	runner._expect(SignalLensUpgrade.required_discovery == "wreck_signal_cache", "Signal Lens I should require Wreck Signal Cache")
	runner._expect(EchoLensUpgrade.required_discovery == "wreck_signal_cache", "Echo Lens I should require Wreck Signal Cache")
	runner._expect(EchoLensUpgrade.required_upgrade == SignalLensUpgrade.id, "Echo Lens I should require Signal Lens I")
	runner._expect(EchoLensUpgrade.effect_id == "echo_lens_wreck_echo", "Echo Lens I should use the broad wreck echo effect id")
	runner._expect(int(EchoLensUpgrade.resource_cost.get("glow_plankton", 0)) == 3, "Echo Lens I should cost three glow plankton")
	runner._expect(int(EchoLensUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Echo Lens I should cost one kelp fiber")
	runner._expect(int(EchoLensUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Echo Lens I should cost two shell fragments")
	runner._expect(ResonanceKeyUpgrade.id == "resonance_key_1", "Resonance Key I should have a stable upgrade id")
	runner._expect(ResonanceKeyUpgrade.required_discovery == "east_shelf_route_research", "Resonance Key I should require recovered East Shelf or Drop Echo research context")
	runner._expect(ResonanceKeyUpgrade.required_upgrade == EchoLensUpgrade.id, "Resonance Key I should require Echo Lens I")
	runner._expect(ResonanceKeyUpgrade.effect_id == "resonance_key_1", "Resonance Key I should use a hatch-specific effect id")
	runner._expect(int(ResonanceKeyUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Resonance Key I should cost two glow plankton")
	runner._expect(int(ResonanceKeyUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Resonance Key I should cost one shell fragment")
	runner._expect(not ResonanceKeyUpgrade.resource_cost.has("kelp_fiber"), "Resonance Key I should avoid broad material spread for the first hatch key")
	runner._expect(ResonanceKeyUpgrade.description.contains("hatch-specific"), "Resonance Key I description should stay narrow")
	runner._expect(not ResonanceKeyUpgrade.description.to_lower().contains("all sealed"), "Resonance Key I should not imply a broad key family")
	runner._expect(CargoRackUpgrade.required_discovery.is_empty(), "Cargo Rack I should not require a discovery")
	runner._expect(CargoRackUpgrade.effect_id == "cargo_limit_4", "Cargo Rack I should use cargo limit effect")
	runner._expect(WaterFilterUpgrade.id == "water_filter_1", "Water Filter I should have a stable upgrade id")
	runner._expect(WaterFilterUpgrade.required_discovery.is_empty(), "Water Filter I should not require a discovery")
	runner._expect(WaterFilterUpgrade.required_upgrade.is_empty(), "Water Filter I should not require another upgrade")
	runner._expect(WaterFilterUpgrade.effect_id == "water_reserve_1", "Water Filter I should use the water reserve effect")
	runner._expect(int(WaterFilterUpgrade.resource_cost.get("driftwood", 0)) == 1, "Water Filter I should cost one driftwood")
	runner._expect(int(WaterFilterUpgrade.resource_cost.get("quartz_glass", 0)) == 1, "Water Filter I should cost one quartz glass")
	runner._expect(WaterFilterUpgrade.description.contains("starter salvage"), "Water Filter I should explain starter-material purpose")
	runner._expect(PredatorWarningUpgrade.required_discovery == "gulper_eel", "Predator Warning I should require Gulper Eel")
	runner._expect(DecoyPulseUpgrade.required_discovery == "gulper_eel", "Decoy Pulse I should require Gulper Eel")
	runner._expect(DecoyPulseUpgrade.required_upgrade == PredatorWarningUpgrade.id, "Decoy Pulse I should require Predator Warning I")
	runner._expect(int(DecoyPulseUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Decoy Pulse I should cost two glow plankton")
	runner._expect(int(DecoyPulseUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Decoy Pulse I should cost one kelp fiber")
	runner._expect(int(DecoyPulseUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Decoy Pulse I should cost one shell fragment")
	runner._expect(SalvageCutterUpgrade.id == "salvage_cutter_1", "Salvage Cutter I should have a stable upgrade id")
	runner._expect(SalvageCutterUpgrade.required_discovery == "salvage_data_cache", "Salvage Cutter I should require recovered salvage-cache evidence")
	runner._expect(SalvageCutterUpgrade.required_upgrade.is_empty(), "Salvage Cutter I should not create a broad prerequisite chain")
	runner._expect(SalvageCutterUpgrade.effect_id == "salvage_cutter_1", "Salvage Cutter I should use a narrow scoped effect id")
	runner._expect(int(SalvageCutterUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Salvage Cutter I should cost one existing kelp fiber")
	runner._expect(int(SalvageCutterUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Salvage Cutter I should cost two existing shell fragments")
	runner._expect(not SalvageCutterUpgrade.resource_cost.has("glow_plankton"), "Salvage Cutter I should avoid a broad material spread")
	runner._expect(SalvageCutterUpgrade.description.contains("Wide Reef"), "Salvage Cutter I should stay tied to Wide Reef")
	runner._expect(not SalvageCutterUpgrade.description.to_lower().contains("all sealed"), "Salvage Cutter I should not imply opening every sealed route")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, OxygenTankUpgrade) == "", "upgrade with no prerequisite should not be locked")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "thermal_vent", "Pressure Seal I prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "wreck_signal_cache", "Signal Lens I prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "wreck_signal_cache", "Echo Lens I discovery prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == SignalLensUpgrade.id, "Echo Lens I upgrade prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, ResonanceKeyUpgrade) == "east_shelf_route_research", "Resonance Key I route-research prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, ResonanceKeyUpgrade) == EchoLensUpgrade.id, "Resonance Key I Echo Lens prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, CargoRackUpgrade) == "", "Cargo Rack I prerequisite should be satisfied by default")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, WaterFilterUpgrade) == "", "Water Filter I prerequisite should be satisfied by default")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "gulper_eel", "Predator Warning I prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == PredatorWarningUpgrade.id, "Decoy Pulse I upgrade prerequisite should start missing")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, SalvageCutterUpgrade) == "salvage_data_cache", "Salvage Cutter I prerequisite should start missing")
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "", "Pressure Seal I prerequisite should be satisfied by Thermal Vent discovery")
	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "", "Signal Lens I prerequisite should be satisfied by Wreck Signal Cache discovery")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "", "Echo Lens I discovery prerequisite should be satisfied by Wreck Signal Cache discovery")
	runner._expect(not UpgradePurchaseScript.purchase(progression, EchoLensUpgrade), "Echo Lens I should not purchase before Signal Lens I")
	progression.purchased_upgrades[SignalLensUpgrade.id] = true
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == "", "Echo Lens I upgrade prerequisite should be satisfied by Signal Lens I")
	progression.purchased_upgrades[EchoLensUpgrade.id] = true
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, ResonanceKeyUpgrade) == "", "Resonance Key I upgrade prerequisite should be satisfied by Echo Lens I")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, ResonanceKeyUpgrade) == "east_shelf_route_research", "Resonance Key I should remain locked until route research is promoted by a later issue")
	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "", "Predator Warning I prerequisite should be satisfied by Gulper Eel discovery")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I discovery prerequisite should be satisfied by Gulper Eel discovery")
	runner._expect(not UpgradePurchaseScript.purchase(progression, DecoyPulseUpgrade), "Decoy Pulse I should not purchase before Predator Warning I")
	progression.purchased_upgrades[PredatorWarningUpgrade.id] = true
	runner._expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I upgrade prerequisite should be satisfied by Predator Warning I")
	progression.add_discovery("salvage_data_cache", "Salvage Data Cache", "Recovered cutter prep.", "Unlocks Salvage Cutter I.")
	runner._expect(UpgradePurchaseScript.missing_discovery(progression, SalvageCutterUpgrade) == "", "Salvage Cutter I prerequisite should be satisfied by recovered cache evidence")

func _test_predator_warning_upgrade_metadata(runner) -> void:
	runner._expect(PredatorWarningUpgrade.id == "predator_warning_1", "Predator Warning I should have a stable upgrade id")
	runner._expect(PredatorWarningUpgrade.effect_id == "predator_warning_range_1", "Predator Warning I should use the warning range effect")
	runner._expect(int(PredatorWarningUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Predator Warning I should cost one kelp fiber")
	runner._expect(int(PredatorWarningUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Predator Warning I should cost two shell fragments")
	runner._expect(int(PredatorWarningUpgrade.resource_cost.get("glow_plankton", 0)) == 1, "Predator Warning I should cost one glow plankton")

	var predator := PredatorScript.new()
	predator.detect_radius = 100.0
	runner._expect(is_equal_approx(predator.warning_radius(), 145.0), "default predator warning radius should stay at the original lead distance")
	predator.set_warning_radius_multiplier(1.8)
	runner._expect(is_equal_approx(predator.warning_radius(), 180.0), "Predator Warning I should widen only the warning radius")
	runner._expect(is_equal_approx(predator.detect_radius, 100.0), "Predator Warning I should not change chase detection radius")
	predator.free()

func _test_predator_warning_effect_isolation(runner) -> void:
	var main := MainScript.new()
	main.max_oxygen = 30.0
	main.oxygen_tank_1_max_oxygen = 40.0
	main.base_cargo_limit = 3
	main.cargo_rack_1_limit = 4
	main.dive_session.reset(30.0)
	main.dive_session.cargo_limit = main.base_cargo_limit
	main.progression_state.purchased_upgrades = {
		PredatorWarningUpgrade.id: true,
	}

	main._apply_upgrade_effect(PredatorWarningUpgrade.effect_id)

	runner._expect(main._current_max_oxygen() == 30.0, "Predator Warning I should not apply Oxygen Tank I max oxygen")
	runner._expect(main._current_cargo_limit() == 3, "Predator Warning I should not apply Cargo Rack I capacity")
	runner._expect(main.dive_session.cargo_limit == 3, "Predator Warning I should not mutate current dive cargo capacity")
	runner._expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Predator Warning I should not grant Pressure Seal I")
	runner._expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Predator Warning I should not grant Signal Lens I")
	main.free()

func _test_decoy_pulse_effect_isolation(runner) -> void:
	var main := MainScript.new()
	main.base_cargo_limit = 3
	main.dive_session.reset(30.0)
	main.dive_session.cargo_limit = main.base_cargo_limit
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.run_predator_contacts = 0
	main.progression_state.purchased_upgrades = {
		PredatorWarningUpgrade.id: true,
		DecoyPulseUpgrade.id: true,
	}

	main._apply_upgrade_effect(DecoyPulseUpgrade.effect_id)

	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Decoy Pulse I purchase should not change dive result state")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Decoy Pulse I purchase should not change carried cargo")
	runner._expect(main.dive_session.cargo_limit == 3, "Decoy Pulse I purchase should not change cargo capacity")
	runner._expect(main.run_predator_contacts == 0, "Decoy Pulse I purchase should not create predator contact")
	runner._expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Decoy Pulse I should not grant Pressure Seal I")
	runner._expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Decoy Pulse I should not grant Signal Lens I")
	main.free()

func _test_echo_lens_effect_isolation(runner) -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.purchased_upgrades = {
		SignalLensUpgrade.id: true,
		EchoLensUpgrade.id: true,
	}

	main._apply_upgrade_effect(EchoLensUpgrade.effect_id)

	runner._expect(main.dive_session.result == DiveSessionScript.Result.READY, "Echo Lens I purchase should not change dive result state")
	runner._expect(main.dive_session.current_cargo == ["kelp_fiber"], "Echo Lens I purchase should not change carried cargo")
	runner._expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Echo Lens I should not grant Pressure Seal I")
	runner._expect(not main.progression_state.has_upgrade(DecoyPulseUpgrade.id), "Echo Lens I should not grant Decoy Pulse I")
	main.free()
