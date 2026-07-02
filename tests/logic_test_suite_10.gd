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

func _test_wide_chamber_salvage_pocket_entrance(runner) -> void:
	var root := Node.new()
	runner.root.add_child(root)
	var main := MainScene.instantiate()
	root.add_child(main)
	var chamber := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	var salvage := chamber.get_node("WreckSalvagePocketEntrance") as Node2D
	var pocket_shadow := salvage.get_node("PocketShadow") as Polygon2D
	var hull_rim := salvage.get_node("WreckHullRim") as Polygon2D
	var hatch_panel := salvage.get_node("SealedHatchPanel") as Polygon2D
	var lock_bars := salvage.get_node("LockBars") as Polygon2D
	var salvage_glint := salvage.get_node("SalvageGlint") as Polygon2D
	var future_cutter_port := salvage.get_node("FutureCutterPort") as Node2D
	var cutter_port_plate := salvage.get_node("FutureCutterPort/PortPlate") as Polygon2D
	var cutter_port_socket := salvage.get_node("FutureCutterPort/PortSocket") as Polygon2D
	var cutter_port_label := salvage.get_node("FutureCutterPort/ToolLabel") as Label
	var data_cache := salvage.get_node("DataCache") as Node2D
	var data_cache_halo := salvage.get_node("DataCache/CacheHalo") as Polygon2D
	var data_cache_core := salvage.get_node("DataCache/CacheCore") as Polygon2D
	var data_cache_spark := salvage.get_node("DataCache/CacheSpark") as Polygon2D
	var interact_zone := salvage.get_node("InteractZone") as Area2D
	var promise_label := salvage.get_node("PromiseLabel") as Label
	var opened_lane := salvage.get_node("OpenedPocketLane") as Node2D
	var open_entry_water := salvage.get_node("OpenedPocketLane/EntryWater") as Polygon2D
	var open_return_cue := salvage.get_node("OpenedPocketLane/ReturnCurrentCue") as Polygon2D
	var silt_wake := salvage.get_node("OpenedPocketLane/SiltTimingWake") as Polygon2D
	var silt_window := salvage.get_node("OpenedPocketLane/SiltTimingWindow") as Polygon2D
	var silt_tick := salvage.get_node("OpenedPocketLane/SiltTimingTickA") as Polygon2D
	var open_label := salvage.get_node("OpenedPocketLane/OpenLabel") as Label
	var salvage_manifest := salvage.get_node("OpenedPocketLane/SalvageManifest") as Node2D
	var manifest_halo := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestHalo") as Polygon2D
	var manifest_core := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestCore") as Polygon2D
	var manifest_spark := salvage.get_node("OpenedPocketLane/SalvageManifest/ManifestSpark") as Polygon2D
	var manifest_interact := salvage.get_node("OpenedPocketLane/SalvageManifest/InteractZone") as Area2D
	var salvage_shell_candidate := main.get_node("StarterResourceCandidates/ShellFragments/SalvagePocketA") as SpawnPoint
	var chamber_backwater := chamber.get_node("ChamberBackwater") as Polygon2D
	var upper_chamber_shelf := chamber.get_node("UpperChamberShelf") as Polygon2D
	var lower_chamber_shelf := chamber.get_node("LowerChamberShelf") as Polygon2D
	var glass_rib_span := chamber.get_node("GlassRibSpan") as Polygon2D
	var future_choice_shadow := chamber.get_node("FutureChoiceShadow") as Polygon2D
	var return_current := chamber.get_node("ReturnCurrentBackToHollow") as Polygon2D
	var swarm := chamber.get_node("GlassfinSwarm") as Area2D
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)
	var oxygen_before: float = main.dive_session.oxygen
	var cargo_before: Array = main.dive_session.current_cargo.duplicate()

	runner._expect(salvage.get_parent() == chamber, "salvage pocket entrance should be authored inside the wide chamber")
	runner._expect(salvage.position.x >= 520.0, "salvage pocket entrance should sit on the far side of the wide chamber")
	runner._expect(salvage.position.y < return_current.polygon[0].y - 120.0, "salvage pocket entrance should stay above the lower return-current route")
	runner._expect(salvage.position.x > swarm.position.x, "salvage pocket entrance should not overlap the current Glassfin Swarm lane")
	runner._expect(future_choice_shadow.color.a >= 0.3, "future-choice shadow should still frame the far chamber promise")
	runner._expect(pocket_shadow.color.a >= 0.6, "salvage pocket should read as a deliberate sealed opening")
	runner._expect(hull_rim.color.r > hull_rim.color.g and hull_rim.color.g > hull_rim.color.b, "salvage rim should use muted wreck/rust language")
	runner._expect(hatch_panel.color.b >= hatch_panel.color.g, "sealed hatch panel should read as cold wreck metal, not a resource")
	runner._expect(lock_bars.color.b > lock_bars.color.r and lock_bars.color.a <= 0.28, "salvage lock bars should read as sealed promise language without becoming a reward")
	runner._expect(salvage_glint.color.a <= 0.5, "salvage glint should stay a subtle promise, not a collectable reward")
	runner._expect(future_cutter_port.position.x > data_cache.position.x, "future cutter port should sit beside the cache rather than on top of the knowledge payoff")
	runner._expect(cutter_port_plate.color.r > cutter_port_plate.color.b and cutter_port_plate.color.g > cutter_port_plate.color.b, "future cutter port should use warm salvage-tool language, not pressure/echo blue")
	runner._expect(cutter_port_socket.color.a >= 0.7, "future cutter socket should read as a closed tool interface")
	runner._expect(cutter_port_label.text == "CUTTER NEEDED", "future salvage tool promise should name a compact missing tool")
	runner._expect(not cutter_port_label.text.to_lower().contains("open"), "future salvage tool copy should not imply the route is open")
	runner._expect(not cutter_port_label.text.to_lower().contains("pressure"), "future salvage tool copy should not conflict with Pressure Seal language")
	runner._expect(not cutter_port_label.text.to_lower().contains("echo"), "future salvage tool copy should not conflict with Echo Lens language")
	runner._expect(not cutter_port_label.text.to_lower().contains("key"), "future salvage tool copy should not conflict with Resonance Key language")
	runner._expect(data_cache.position.x >= -10.0 and data_cache.position.x <= 40.0, "salvage data cache should sit inside the sealed pocket mouth")
	runner._expect(data_cache_core.color.a >= 0.7, "salvage data cache should start visibly recoverable")
	runner._expect(data_cache_core.color.b >= data_cache_core.color.r, "salvage data cache should use cool knowledge-payoff color language")
	runner._expect(data_cache_halo.color.a < data_cache_core.color.a, "salvage data cache halo should stay subordinate to the payoff core")
	runner._expect(data_cache_spark.visible and data_cache_spark.color.b >= data_cache_spark.color.r, "salvage data cache spark should read as data, not shell or cargo")
	runner._expect(chamber_backwater.color.a <= 0.42, "Wide Reef Chamber backwater should stay below payoff brightness")
	runner._expect(upper_chamber_shelf.color.a <= 0.34 and lower_chamber_shelf.color.a <= 0.38, "Wide Reef Chamber shelf framing should stay quiet enough for normal play")
	runner._expect(glass_rib_span.color.a <= 0.16, "Wide Reef Chamber rib landmark should not compete with cache or pickup reads")
	runner._expect(return_current.color.a < data_cache_core.color.a, "safe-return current should be quieter than the salvage data cache payoff")
	runner._expect(salvage_shell_candidate.target_id == "shell_fragments", "salvage pocket cargo choice should use existing Shell Fragments")
	runner._expect(salvage_shell_candidate.depth_band == "midwater", "salvage pocket cargo choice should preserve existing shell depth identity")
	runner._expect(salvage_shell_candidate.cluster_pattern == "deep_reward", "salvage pocket cargo choice should stay optional in the deep-reward resource pool")
	runner._expect(salvage_shell_candidate.global_position.distance_to(data_cache.global_position) >= 120.0, "salvage pocket cargo and knowledge targets should not stack on each other")
	runner._expect(salvage_shell_candidate.global_position.y > data_cache.global_position.y, "salvage pocket cargo should sit below the cache so the choice reads as two branches")
	runner._expect(salvage_shell_candidate.global_position.distance_to(salvage.global_position) <= 180.0, "salvage pocket cargo should stay near the sealed pocket decision")
	runner._expect(salvage_shell_candidate.global_position.distance_to(chamber.global_position + return_current.polygon[0]) >= 90.0, "salvage pocket cargo should not block the visible return-current entry")
	runner._expect(interact_zone.collision_layer == 0 and interact_zone.collision_mask == 1, "salvage interact zone should be an explicit player trigger, not route collision")
	runner._expect(promise_label.text == "SALVAGE", "salvage promise label should be compact and honest about current implementation")
	runner._expect(not promise_label.text.to_lower().contains("objective"), "salvage promise label should not imply objective checklist language")
	runner._expect(not promise_label.text.to_lower().contains("map"), "salvage promise label should not imply exact locator UI")
	runner._expect(not promise_label.text.to_lower().contains("pressure"), "salvage promise label should not conflict with pressure-gate copy")
	runner._expect(not promise_label.text.to_lower().contains("echo"), "salvage promise label should not conflict with Echo Lens copy")
	runner._expect(not promise_label.text.to_lower().contains("key"), "salvage promise label should not conflict with Resonance Key copy")
	runner._expect(not opened_lane.visible, "salvage opened lane should stay hidden before Salvage Cutter I")
	runner._expect(salvage.get_node_or_null("Interior") == null, "salvage promise should not add a full interior system")
	runner._expect(salvage.get_node_or_null("ResourcePickup") == null, "salvage promise should not add loot pickup behavior")
	runner._expect(salvage.find_child("LootTable", true, false) == null, "salvage promise should not add a loot table")
	runner._expect(salvage.find_child("HarvestArea", true, false) == null, "salvage promise should not add harvesting")
	runner._expect(salvage.find_child("HealthBar", true, false) == null, "salvage promise should not add combat UI")
	runner._expect(future_cutter_port.find_child("CollisionShape2D", true, false) == null, "future cutter port should not add collision")
	runner._expect(future_cutter_port.get_node_or_null("InteractZone") == null, "future cutter port should not add interaction yet")
	runner._expect(future_cutter_port.get_script() == null, "future cutter port should stay visual-only")
	runner._expect(main.get_node_or_null("ResourcePickups/SalvageShellFragments") == null, "salvage cargo choice should not add an extra active resource pickup")
	runner._expect(main.progression_state.to_save_data() == save_before, "salvage promise should not mutate progression")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "salvage promise should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "salvage promise should not mutate cargo")

	main.progression_state.purchased_upgrades[SalvageCutterUpgrade.id] = true
	var save_before_open_sync: Dictionary = main.progression_state.to_save_data().duplicate(true)
	main.call("_sync_salvage_pocket_open_state")
	runner._expect(opened_lane.visible, "owned Salvage Cutter I should reveal a small opened salvage pocket lane")
	runner._expect(not lock_bars.visible, "owned Salvage Cutter I should visually remove the sealed lock bars")
	runner._expect(hatch_panel.color.a <= 0.24, "opened salvage hatch should read as cut open rather than sealed")
	runner._expect(cutter_port_label.text == "CUTTER READY", "owned cutter should update the port readback")
	runner._expect(not cutter_port_label.visible, "owned cutter should hide redundant world tool copy and leave the HUD prompt to explain interaction")
	runner._expect(promise_label.text == "OPEN", "owned cutter should update the broad pocket state with compact world copy")
	runner._expect(open_label.text.contains("RETURN VIA HOLLOW"), "opened salvage pocket should preserve broad safe-return language")
	runner._expect(not open_label.visible, "opened salvage return label should stay hidden because the HUD and current shape already carry return guidance")
	runner._expect(open_entry_water.color.a <= 0.22, "opened salvage pocket water should be readable but quieter than pickups")
	runner._expect(open_return_cue.color.g > open_return_cue.color.r, "opened salvage return cue should use safe-current color language")
	runner._expect(open_entry_water.color.a < manifest_core.color.a and open_return_cue.color.a < manifest_core.color.a, "opened salvage lane support should stay quieter than the manifest payoff")
	runner._expect(silt_wake.color.b > silt_wake.color.g and silt_window.color.b > silt_window.color.r, "opened salvage silt cue should use pale timing language instead of safe-current green")
	runner._expect(silt_wake.color.a <= 0.13 and silt_window.color.a <= 0.17 and silt_tick.color.a <= 0.23, "opened salvage silt timing should stay subtle beside the payoff")
	runner._expect(silt_window.color.a < manifest_core.color.a, "opened salvage silt timing should not read brighter than the manifest payoff")
	runner._expect(opened_lane.find_child("CollisionShape2D", true, false) == manifest_interact.get_node("CollisionShape2D"), "opened salvage silt timing should not add hidden collision or pressure behavior")
	runner._expect(salvage_manifest.get_parent() == opened_lane, "Salvage Manifest should live inside the opened pocket lane")
	runner._expect(manifest_core.color.a >= 0.7, "Salvage Manifest should start visibly recoverable when the pocket is open")
	runner._expect(manifest_core.color.r > manifest_core.color.b, "Salvage Manifest should use amber document language distinct from cyan data shards")
	runner._expect(manifest_halo.color.a < manifest_core.color.a, "Salvage Manifest halo should stay subordinate to the payoff core")
	runner._expect(manifest_spark.visible, "Salvage Manifest should have a bright recovery spark before interaction")
	runner._expect(manifest_interact.collision_layer == 0 and manifest_interact.collision_mask == 1, "Salvage Manifest hotspot should detect the player without becoming route collision")
	runner._expect(salvage_shell_candidate.global_position.distance_to(salvage_manifest.global_position) >= 90.0, "Salvage Manifest and shell cargo should ask for a local choice instead of stacking")
	runner._expect(salvage_manifest.get_node_or_null("ResourcePickup") == null, "Salvage Manifest should not be cargo or loot behavior")
	runner._expect(salvage_manifest.find_child("LootTable", true, false) == null, "Salvage Manifest should not add a salvage loot table")
	runner._expect(salvage_manifest.find_child("HarvestArea", true, false) == null, "Salvage Manifest should not add harvesting")
	runner._expect(salvage_manifest.get_script() == null, "Salvage Manifest scene node should stay presentation/trigger only")
	runner._expect(main.progression_state.to_save_data() == save_before_open_sync, "opening presentation should not mutate save state beyond owned cutter")
	runner._expect(is_equal_approx(main.dive_session.oxygen, oxygen_before), "opening presentation should not drain oxygen")
	runner._expect(main.dive_session.current_cargo == cargo_before, "opening presentation should not mutate cargo")
	main.queue_free()
	root.queue_free()

func _test_salvage_data_cache_interaction(runner) -> void:
	var main := MainScene.instantiate()
	main.status_label = Label.new()
	main.dive_session.start()
	main.dive_session.has_left_base = true
	main.player_near_salvage_data_cache = true
	main.dive_session.oxygen = 23.0
	main.dive_session.current_cargo = ["glow_plankton"]
	var cache_halo := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheHalo") as Polygon2D
	var cache_core := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheCore") as Polygon2D
	var cache_spark := main.get_node("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheSpark") as Polygon2D
	RoutePayoffSyncServiceScript.sync_salvage_data_cache_payoff(main)
	runner._expect(cache_core.color.a >= 0.7, "salvage data cache should start visibly recoverable")
	runner._expect(cache_spark.visible, "salvage data cache spark should start visible before recovery")
	var prompt: String = main.call("_format_hud_prompt")
	runner._expect(prompt.contains("Salvage"), "salvage proximity should own the active dive prompt")
	runner._expect(prompt.contains("cache"), "salvage prompt should name the concrete knowledge payoff")
	var save_before: Dictionary = main.progression_state.to_save_data().duplicate(true)

	var handled: bool = main.call("_try_salvage_data_cache_interaction")
	runner._expect(handled, "salvage data cache should handle interact while nearby during a dive")
	runner._expect(main.run_salvage_data_cache_recovered, "salvage data cache interaction should record one run-scoped cache")
	runner._expect(main.run_reached_dusk_trench, "salvage cache recovery should count as meaningful lower-route reach evidence")
	runner._expect(cache_halo.color.a <= 0.08, "salvage data cache halo should visibly dim after recovery")
	runner._expect(cache_core.color.a <= 0.2, "salvage data cache core should visibly dim after recovery")
	runner._expect(not cache_spark.visible, "salvage data cache spark should disappear after recovery")
	runner._expect(is_equal_approx(main.dive_session.oxygen, 23.0), "salvage data cache should not spend oxygen directly")
	runner._expect(main.dive_session.current_cargo == ["glow_plankton"], "salvage data cache should not add or remove cargo")
	var save_after: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_after == save_before, "salvage data cache should not mutate durable progression")
	runner._expect(not save_after.has("salvage_data_cache"), "salvage data cache should not create durable salvage state")
	runner._expect(not save_after.has("salvage_inventory"), "salvage data cache should not create salvage inventory state")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("Return safely"), "salvage data cache interaction should preserve extraction pressure")
		runner._expect(main.status_label.text.contains("data cache"), "salvage status should name the visible payoff")
		runner._expect(main.status_label.text.contains("Salvage Cutter I prep"), "salvage status should frame the cache as a narrow tool prerequisite signal")
		runner._expect(not main.status_label.text.to_lower().contains("buy"), "salvage status should not imply a purchasable tool yet")

	var repeat_handled: bool = main.call("_try_salvage_data_cache_interaction")
	runner._expect(repeat_handled, "salvage data cache should keep handling repeat interact while nearby")
	if main.status_label != null:
		runner._expect(main.status_label.text.contains("already recovered"), "salvage repeat interaction should not duplicate the payoff")

	main.player_near_salvage_data_cache = false
	var not_handled: bool = main.call("_try_salvage_data_cache_interaction")
	runner._expect(not not_handled, "salvage data cache should not consume interact outside its proximity zone")

	var callout: String = ResearchResultCalloutServiceScript.format_salvage_data_cache_research_callout(main)
	runner._expect(callout.contains("Salvage data cache"), "salvage result memory should name the recovered cache")
	runner._expect(callout.contains("sealed wreck pocket"), "salvage result memory should keep the future destination broad")
	runner._expect(callout.contains("Salvage Cutter I prep"), "salvage result memory should connect the cache to the narrow tool prerequisite")
	runner._expect(not callout.to_lower().contains("upgrade bay"), "salvage result memory should not turn into menu instructions")
	runner._expect(not callout.to_lower().contains("craft"), "salvage result memory should not introduce crafting")
	runner._expect_no_echo_lens_locator_language(callout, "salvage data cache result line")
	var empty_cargo: Array[String] = []
	var extraction_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(main, 0, empty_cargo)
	runner._expect(extraction_summary.contains("Salvage data cache"), "salvage extraction summary should include recovered cache memory")
	runner._expect(extraction_summary.contains("Salvage Cutter I prep"), "salvage extraction summary should make the cache useful for tool planning")
	runner._expect(not extraction_summary.to_lower().contains("buy cutter"), "salvage extraction summary should not make the future cutter purchasable")
	runner._expect(not extraction_summary.to_lower().contains("loot table"), "salvage extraction summary should avoid loot-system language")
	runner._expect(not extraction_summary.to_lower().contains("inventory"), "salvage extraction summary should avoid inventory language")
	main.call("_record_salvage_data_cache_discovery_if_extracted")
	runner._expect(main.progression_state.has_discovery("salvage_data_cache"), "safe extraction should convert salvage cache evidence into the normal upgrade prerequisite discovery")
	var save_with_evidence: Dictionary = main.progression_state.to_save_data()
	runner._expect(save_with_evidence.has("scan_discoveries"), "salvage cache evidence should use existing discovery save state")
	runner._expect(not save_with_evidence.has("salvage_inventory"), "salvage cache evidence should not create salvage inventory state")
	main.call("_reset_run_telemetry")
	runner._expect(not main.run_salvage_data_cache_recovered, "salvage cache should reset between expeditions")
	runner._expect(cache_core.color.a >= 0.7, "salvage data cache should become visible again after expedition reset")
	runner._expect(cache_spark.visible, "salvage data cache spark should reset after expedition reset")

	var fresh_main := MainScript.new()
	runner._expect(ResearchResultCalloutServiceScript.format_salvage_data_cache_research_callout(fresh_main) == "", "salvage result line should stay hidden before payoff recovery")
	var fresh_summary: String = SurfaceRunSummaryServiceScript.format_extraction_result_summary(fresh_main, 0, empty_cargo)
	runner._expect(not fresh_summary.contains("Salvage data cache"), "salvage extraction summary should stay hidden before payoff recovery")
	fresh_main.free()
	main.free()
