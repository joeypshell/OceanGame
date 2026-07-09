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

func _test_scan_pulse_visual_helper(runner) -> void:
	var idle := ScanPulseVisualScript.idle_modulate()
	var selected := ScanPulseVisualScript.selected_modulate()
	var pulse_a := ScanPulseVisualScript.tactical_highlight_modulate(0)
	var pulse_b := ScanPulseVisualScript.tactical_highlight_modulate(180)

	runner._expect(idle == Color.WHITE, "scan pulse idle color should be neutral")
	runner._expect(selected.r > idle.r and selected.g > idle.g, "selected scan pulse color should brighten the pickup")
	runner._expect(pulse_a != pulse_b, "tactical highlight should pulse instead of becoming a static marker")
	runner._expect(pulse_a.a == 1.0 and pulse_b.a == 1.0, "tactical highlight should stay a local modulate, not a hidden marker")

func _test_sprite_ready_scene_asset_slots(runner) -> void:
	var main := MainScene.instantiate()
	var required_paths := [
		"ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/KelpFiber/Visuals/FallbackVisual/Visual",
		"ResourcePickups/KelpFiber/CollisionShape2D",
		"ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/ShellFragments/Visuals/FallbackVisual/Visual",
		"ResourcePickups/ShellFragments/CollisionShape2D",
		"ResourcePickups/GlowPlankton/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/GlowPlankton/Visuals/FallbackVisual/Visual",
		"ResourcePickups/HiddenGlowPlankton/Visuals/SpriteAnchor/Sprite",
		"ResourcePickups/DeepGlowPlankton/Visuals/SpriteAnchor/Sprite",
		"Creatures/LanternFry/SpriteAnchor/Sprite",
		"Creatures/LanternFry/FallbackVisual/Visual",
		"Creatures/LanternFry/FallbackVisual/Glow",
		"Creatures/LanternFry/ScanMarker",
		"Creatures/LanternFry/CollisionShape2D",
		"Creatures/LanternRayRoute/RouteLane",
		"Creatures/LanternRayRoute/TimingLane/TimingLaneUpper",
		"Creatures/LanternRayRoute/TimingLane/TimingLaneLower",
		"Creatures/LanternRayRoute/TimingLane/TimingTickA",
		"Creatures/LanternRayRoute/TimingLane/TimingTickB",
		"Creatures/LanternRayRoute/RayBody",
		"Creatures/LanternRayRoute/RayWingLeft",
		"Creatures/LanternRayRoute/EyeFleck",
		"Creatures/LanternRayRoute/ScanMarker",
		"Creatures/LanternRayRoute/CollisionShape2D",
		"Predators/GulperEel/SpriteAnchor/Sprite",
		"Predators/GulperEel/FallbackVisual/Body",
		"Predators/GulperEel/FallbackVisual/Eye",
		"Predators/GulperEel/PatrolHint",
		"Predators/GulperEel/ScanMarker",
		"Predators/GulperEel/CollisionShape2D",
		"ShellReefPocket/Visuals/SpriteAnchor/Sprite",
		"ShellReefPocket/Visuals/FallbackGeometry/ReefShelf",
		"ThermalVentPocket/Visuals/SpriteAnchor/Sprite",
		"ThermalVentPocket/Visuals/FallbackGeometry/WarmWash",
		"PressureLockedWreck/Visuals/SpriteAnchor/Sprite",
		"PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureShimmer",
		"PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLabel",
		"PressureLockedWreck/OuterScan/SpriteAnchor/Sprite",
		"PressureLockedWreck/OuterScan/FallbackVisual/ScanVisual",
		"PressureLockedWreck/OuterScan/ScanMarker",
		"PressureLockedWreck/OuterScan/CollisionShape2D",
		"PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite",
		"PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual",
		"PressureLockedWreck/WreckSignalCache/ScanMarker",
		"PressureLockedWreck/WreckSignalCache/EchoPulse",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/SpriteAnchor/Sprite",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow",
		"EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim",
		"WreckEchoDescent/RouteWash",
		"WreckEchoDescent/RibA",
		"WreckEchoDescent/RibB",
		"WreckEchoDescent/ClueTrigger/ClueCore",
		"WreckEchoDescent/ClueTrigger/EchoRing",
		"WreckEchoDescent/ClueTrigger/CollisionShape2D",
		"RareSignalEmphasis/SoftPingWash",
		"RareSignalEmphasis/BrokenEchoArc",
		"DeepRewardLure/SpriteAnchor/Sprite",
		"DeepRewardLure/RewardCore",
		"ShallowMidwaterBackgroundStudy",
		"SurfaceBaseArt/SpriteAnchor/ResearchBoatSprite",
		"SurfaceBaseArt/MoonpoolGuide/MoonpoolWaterlineSprite",
		"SurfaceBaseArt/MoonpoolGuide/LaunchColumn",
		"SurfaceBaseArt/MoonpoolGuide/WaterlineFoam",
		"SurfaceBaseArt/FallbackGeometry/LabMoonpool",
		"Discoveries/ThermalVent/SpriteAnchor/Sprite",
		"Discoveries/ThermalVent/FallbackVisual/Visual",
		"Discoveries/ThermalVent/ScanMarker",
		"Discoveries/ShellReefShelf/SpriteAnchor/Sprite",
		"Discoveries/ShellReefShelf/FallbackVisual/Visual",
		"Discoveries/ShellReefShelf/ScanMarker",
	]

	for path in required_paths:
		runner._expect(main.get_node_or_null(path) != null, "main scene should keep sprite-ready slot or behavior node: %s" % path)

	var moonpool_sprite := main.get_node("SurfaceBaseArt/MoonpoolGuide/MoonpoolWaterlineSprite") as Sprite2D
	runner._expect(moonpool_sprite.texture != null, "Surface moonpool/waterline should use the first exported source asset sprite")
	var launch_column := main.get_node("SurfaceBaseArt/MoonpoolGuide/LaunchColumn") as Polygon2D
	var base_zone := main.get_node("BaseZone") as Area2D
	var base_core := main.get_node("BaseZone/BaseCore") as Polygon2D
	var dock_rim := main.get_node("BaseZone/DockRim") as Polygon2D
	var scene_player := main.get_node("Player") as CharacterBody2D
	var boat_sprite := main.get_node("SurfaceBaseArt/SpriteAnchor/ResearchBoatSprite") as Sprite2D
	var player_scene := PlayerScene.instantiate()
	runner.root.add_child(player_scene)
	var diver_sprite := player_scene.get_node("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	player_scene.call("_set_swim_sheet_frame", 0)
	runner._expect(diver_sprite.region_rect.position.x == 0.0, "diver swim idle frame should use the first sprite-sheet cell")
	runner._expect(diver_sprite.offset.x < 0.0, "diver swim idle frame should apply a small registration offset")
	player_scene.call("_set_swim_sheet_frame", 5)
	runner._expect(diver_sprite.region_rect.position.x == 5.0 * 362.0, "diver swim final kick frame should use the sixth sprite-sheet cell")
	runner._expect(diver_sprite.offset.x > 35.0, "diver swim kick frame should compensate generated sheet forward/back drift")
	player_scene.call("_set_swim_sheet_frame", 0)
	player_scene.queue_free()
	runner._expect(base_zone.global_position.y > boat_sprite.global_position.y + 150.0, "base zone should sit below the boat hull, not inside the boat sprite")
	runner._expect(scene_player.global_position.y >= base_zone.global_position.y, "player should start in the marked moonpool dock below the boat")
	runner._expect(base_core.visible, "base dock core should be visible as an extraction marker")
	runner._expect(dock_rim.visible, "base dock rim should be visible as a loading-dock affordance")
	runner._expect(base_core.z_index < 0 and dock_rim.z_index < 0, "base dock marker should sit behind the sub, not on top of it")
	runner._expect(launch_column.color.a >= 0.16, "moonpool launch column should be visible enough to mark the dock route")
	var player_contract := PlayerScript.new()
	runner._expect(player_contract.world_bounds.position.y >= 240.0, "player top clamp should keep the sub below the boat hull")
	player_contract.free()

	var shallow_midwater_background := main.get_node("ShallowMidwaterBackgroundStudy") as Sprite2D
	runner._expect(shallow_midwater_background.texture != null, "Shallow/midwater background study should use its exported source asset")
	runner._expect(not shallow_midwater_background.visible, "Shallow/midwater background study should stay hidden during normal play so water does not read as cave texture")
	runner._expect(shallow_midwater_background.modulate.a <= 0.06, "Shallow/midwater background study should stay faint even when enabled for review")

	var glow_sprite := main.get_node("ResourcePickups/GlowPlankton/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var glow_fallback := main.get_node("ResourcePickups/GlowPlankton/Visuals/FallbackVisual") as Node2D
	runner._expect(glow_sprite.texture != null, "Glow Plankton should use the first exported source asset sprite")
	runner._expect(not glow_fallback.visible, "Glow Plankton polygon fallback should be hidden while the sprite asset is active")

	var kelp_sprite := main.get_node("ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var kelp_fallback := main.get_node("ResourcePickups/KelpFiber/Visuals/FallbackVisual") as Node2D
	runner._expect(kelp_sprite.texture != null, "Kelp Fiber should use the first exported source asset sprite")
	runner._expect(not kelp_fallback.visible, "Kelp Fiber polygon fallback should be hidden while the sprite asset is active")

	var shell_sprite := main.get_node("ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_fallback := main.get_node("ResourcePickups/ShellFragments/Visuals/FallbackVisual") as Node2D
	runner._expect(shell_sprite.texture != null, "Shell Fragments should use the first exported source asset sprite")
	runner._expect(not shell_fallback.visible, "Shell Fragments polygon fallback should be hidden while the sprite asset is active")

	var lantern_sprite := main.get_node("Creatures/LanternFry/SpriteAnchor/Sprite") as Sprite2D
	var lantern_body_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Visual") as Polygon2D
	var lantern_glow_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Glow") as Polygon2D
	runner._expect(lantern_sprite.texture != null, "Lantern Fry should use the first exported source asset sprite")
	runner._expect(not lantern_body_fallback.visible, "Lantern Fry body polygon should be hidden while the sprite asset is active")
	runner._expect(lantern_glow_fallback.visible, "Lantern Fry glow fallback should remain available for visual-only idle pulsing")

	var gulper_sprite := main.get_node("Predators/GulperEel/SpriteAnchor/Sprite") as Sprite2D
	var gulper_body_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Body") as Polygon2D
	var gulper_eye_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Eye") as Polygon2D
	runner._expect(gulper_sprite.texture != null, "Gulper Eel should use the first exported source asset sprite")
	runner._expect(gulper_body_overlay.visible, "Gulper Eel fallback body should remain available for state tint overlays")
	runner._expect(gulper_eye_overlay.visible, "Gulper Eel fallback eye should remain available for warning/chase state overlays")

	var thermal_vent_sprite := main.get_node("Discoveries/ThermalVent/SpriteAnchor/Sprite") as Sprite2D
	var thermal_vent_fallback := main.get_node("Discoveries/ThermalVent/FallbackVisual/Visual") as Polygon2D
	var thermal_vent_bubbles := main.get_node("Discoveries/ThermalVent/FallbackVisual/Bubbles") as Polygon2D
	runner._expect(thermal_vent_sprite.texture != null, "Thermal Vent should use the first exported source asset sprite")
	runner._expect(thermal_vent_fallback.visible, "Thermal Vent fallback geometry should remain available for optional route readability")
	runner._expect(thermal_vent_bubbles.visible, "Thermal Vent bubbles should remain available for condition/readability visuals")

	var shell_reef_pocket_sprite := main.get_node("ShellReefPocket/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_pocket_fallback := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefShelf") as Polygon2D
	runner._expect(shell_reef_pocket_sprite.texture != null, "Shell Reef pocket should use the first exported source landmark asset")
	runner._expect(shell_reef_pocket_fallback.visible, "Shell Reef pocket fallback geometry should remain available for route readability")

	var shell_reef_shelf_sprite := main.get_node("Discoveries/ShellReefShelf/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_shelf_fallback := main.get_node("Discoveries/ShellReefShelf/FallbackVisual/Visual") as Polygon2D
	runner._expect(shell_reef_shelf_sprite.texture != null, "Shell Reef Shelf scan target should use the first exported source asset sprite")
	runner._expect(shell_reef_shelf_fallback.visible, "Shell Reef Shelf fallback should remain available for scan clue readability")

	var wreck_cache_sprite := main.get_node("PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite") as Sprite2D
	var wreck_cache_fallback := main.get_node("PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual") as Polygon2D
	var wreck_cache_echo_pulse := main.get_node("PressureLockedWreck/WreckSignalCache/EchoPulse") as Sprite2D
	runner._expect(wreck_cache_sprite.texture != null, "Wreck Signal Cache should use the first exported source asset sprite")
	runner._expect(wreck_cache_fallback.visible, "Wreck Signal Cache fallback glow should remain available for scan/mystery readability")
	runner._expect(wreck_cache_echo_pulse.texture != null, "Wreck Signal Cache should have the scan/echo pulse sprite available for Echo Lens I")
	runner._expect(not wreck_cache_echo_pulse.visible, "Echo Lens I pulse should start hidden so it reads as temporary local feedback")

	var pressure_wreck_scan_sprite := main.get_node("PressureLockedWreck/OuterScan/SpriteAnchor/Sprite") as Sprite2D
	var pressure_wreck_scan_fallback := main.get_node("PressureLockedWreck/OuterScan/FallbackVisual/ScanVisual") as Polygon2D
	runner._expect(pressure_wreck_scan_sprite.texture != null, "Pressure-Locked Research Wreck outside scan should use the first exported source asset sprite")
	runner._expect(pressure_wreck_scan_fallback.visible, "Pressure-Locked Research Wreck outside scan fallback should remain available for pressure clue readability")

	var hollow_reef_sprite := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/SpriteAnchor/Sprite") as Sprite2D
	var hollow_reef_mouth_fallback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveMouthShadow") as Polygon2D
	var hollow_reef_rim_fallback := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/ReefRim") as Polygon2D
	runner._expect(hollow_reef_sprite.texture == null, "Hollow Reef cave source-art slot should not require imported texture metadata yet")
	runner._expect(hollow_reef_sprite.get_meta("source_art_path", "") == "res://assets/source/sprites/landmark_hollow_reef_cave_sprite_v1.svg", "Hollow Reef cave slot should document its editable source path")
	runner._expect(hollow_reef_sprite.get_meta("export_art_path", "") == "res://assets/exports/sprites/landmark_hollow_reef_cave_sprite_v1.svg", "Hollow Reef cave slot should document its runtime export path")
	runner._expect(hollow_reef_sprite.get_meta("provenance_path", "") == "res://assets/licenses/landmark_hollow_reef_cave_sprite_v1.txt", "Hollow Reef cave slot should document its provenance path")
	runner._expect(hollow_reef_sprite.modulate.a <= 0.55, "Hollow Reef cave sprite slot should be ready to support readability without overpowering fallback geometry")
	runner._expect(hollow_reef_mouth_fallback.visible and hollow_reef_mouth_fallback.color.a >= 0.65, "Hollow Reef cave mouth fallback should remain available and readable")
	runner._expect(hollow_reef_rim_fallback.visible, "Hollow Reef rim fallback should remain available for current route readability")

	var midwater_shelf := main.get_node("MidwaterShelf") as Polygon2D
	var midwater_wreck := main.get_node("MidwaterWreckSilhouette") as Polygon2D
	var deep_pressure_haze := main.get_node("DeepPressureHaze") as Polygon2D
	runner._expect(midwater_shelf.color.a <= 0.36, "lower-route shelf wash should stay behind core gameplay signals")
	runner._expect(midwater_wreck.color.a <= 0.24, "lower-route wreck silhouette should not compete with pressure/cache markers")
	runner._expect(deep_pressure_haze.color.a <= 0.06, "deep pressure haze should stay subtle behind route signals")

	var reef_landmark_wash := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/LandmarkWash") as Polygon2D
	var reef_shelf := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefShelf") as Polygon2D
	var reef_fan := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ShellFanA") as Polygon2D
	var reef_current := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefReturnCurrent") as Polygon2D
	runner._expect(reef_landmark_wash.color.a <= 0.14, "Shell Reef landmark wash should stay subdued in the lower-route stack")
	runner._expect(reef_shelf.color.a <= 0.38, "Shell Reef shelf fallback should support the sprite without becoming the loudest shape")
	runner._expect(reef_fan.color.a <= 0.5, "Shell Reef fan fallback should not overpower pressure/cache/reward reads")
	runner._expect(reef_current.color.a <= 0.18, "Shell Reef return current should remain a soft route cue")

	var pressure_shimmer := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureShimmer") as Polygon2D
	var pressure_gate_bar := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBarA") as Polygon2D
	var pressure_badge := main.get_node("PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLockBadge") as Polygon2D
	runner._expect(pressure_shimmer.color.a <= 0.36, "pressure shimmer fill should be quieter than the lock badge")
	runner._expect(pressure_gate_bar.color.a <= 0.42, "pressure gate bars should not create a dominant lower-route wall")
	runner._expect(pressure_badge.color.a >= 0.7, "pressure lock badge should remain the readable blocked-route marker")

	var reward_core := main.get_node("DeepRewardLure/RewardCore") as Polygon2D
	var reward_bloom := main.get_node("DeepRewardLure/DistantBloom") as Polygon2D
	var reward_particles := main.get_node("DeepRewardLure/LureParticles") as Polygon2D
	var reward_sprite := main.get_node("DeepRewardLure/SpriteAnchor/Sprite") as Sprite2D
	runner._expect(reward_sprite.texture != null, "deep reward lure should use the selected exported source asset")
	runner._expect(reward_sprite.modulate.a >= 0.85, "deep reward lure sprite should carry the main reward read")
	runner._expect(reward_core.color.a <= 0.24, "deep reward fallback core should stay subordinate to the source asset")
	runner._expect(reward_bloom.color.a <= 0.08, "deep reward bloom should not wash over Shell Reef and predator signals")
	runner._expect(reward_particles.color.a <= 0.08, "deep reward particles should remain secondary to the reward sprite")

	var cache_visual := main.get_node("PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual") as Polygon2D
	var cache_marker := main.get_node("PressureLockedWreck/WreckSignalCache/ScanMarker") as Polygon2D
	var rare_signal_wash := main.get_node("RareSignalEmphasis/SoftPingWash") as Polygon2D
	runner._expect(cache_visual.color.a <= 0.34, "Wreck Signal Cache fallback should not overpower the cache sprite")
	runner._expect(cache_marker.color.a <= 0.18, "Wreck Signal Cache scan marker should stay compact until selected")
	runner._expect(rare_signal_wash.color.a <= 0.04, "Rare Signal condition wash should be atmospheric, not a route marker")

	var warning_ribs := main.get_node("Predators/PredatorWarning/WarningRibs") as Polygon2D
	var warning_current := main.get_node("Predators/PredatorWarning/WarningCurrent") as Polygon2D
	var warning_marker := main.get_node("Predators/PredatorWarning/WarningMarker") as Polygon2D
	runner._expect(warning_ribs.color.a <= 0.12, "predator warning ribs should frame danger without filling the route")
	runner._expect(warning_current.color.a <= 0.08, "predator warning current should be a soft lane cue")
	runner._expect(warning_marker.color.a >= 0.65, "predator warning marker should remain the primary hazard read")
	runner._expect(gulper_body_overlay.color.a <= 0.46, "Gulper overlay body should tint the sprite without becoming a second opaque predator")
	runner._expect(gulper_eye_overlay.color.a >= 0.78, "Gulper overlay eye should keep the predator state readable")
	runner._expect(PredatorScript.BODY_OVERLAY_ALPHA <= 0.46, "runtime Gulper body overlays should stay translucent across predator states")
	runner._expect(PredatorScript.EYE_OVERLAY_ALPHA >= 0.78, "runtime Gulper eye overlays should stay readable across predator states")
	var camera := main.get_node("Player/Camera2D") as Camera2D
	runner._expect(camera.zoom.x <= 0.75 and camera.zoom.y <= 0.75, "starter diver camera should pull back for more exploration space")

	main.free()

	var player := PlayerScene.instantiate()
	var player_required_paths := [
		"VisualRoot/SubSpriteAnchor/SubSprite",
		"VisualRoot/SubSpriteAnchor/Body",
		"VisualRoot/SubSpriteAnchor/Viewport",
		"VisualRoot/NoseLight",
		"VisualRoot/BubbleTrail",
		"VisualRoot/ThrustFlare",
	]

	for path in player_required_paths:
		runner._expect(player.get_node_or_null(path) != null, "player scene should keep sprite-ready visual slot or fallback node: %s" % path)

	var player_sprite := player.get_node("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	var player_texture_path := player_sprite.texture.resource_path if player_sprite.texture != null else ""
	runner._expect(player_texture_path.ends_with("player_diver_swim_sheet_v1.png"), "starter player sprite should use the preferred animated diver sheet")
	runner._expect(player_sprite.region_enabled, "starter player sprite should read one swim-sheet frame at a time")
	runner._expect(player_sprite.region_rect.size == Vector2(362.0, 724.0), "starter player sprite frame size should match the six-frame sheet")
	runner._expect(player_sprite.scale.x <= 0.24 and player_sprite.scale.y <= 0.24, "starter diver sprite should stay small enough for exploration framing")
	var collision_shape := player.get_node("CollisionShape2D") as CollisionShape2D
	var capsule_shape := collision_shape.shape as CapsuleShape2D
	runner._expect(capsule_shape != null and capsule_shape.radius <= 10.0 and capsule_shape.height <= 30.0, "starter diver collision should be smaller than the old sub body")
	player.free()
