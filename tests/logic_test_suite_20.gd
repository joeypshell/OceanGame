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

func _test_area_01_authoritative_wall_builder(runner) -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 blockout builder should apply source-map wall authority: %s" % builder.last_error)
	if not builder.last_error.is_empty():
		main.free()
		return

	var source_map: Dictionary = runner._load_area01_source_map_for_tests()
	var terrain_domain: Dictionary = source_map.get("terrain_domain", {})
	var playable_water_regions: Array = source_map.get("playable_water_regions", [])
	var source_grid_water_cutouts: Array = source_map.get("source_grid_water_cutouts", [])
	var source_grid_water_edges: Array = source_map.get("source_grid_water_edges", [])
	var solid_terrain: Array = source_map.get("solid_terrain", [])
	var collisions: Array[CollisionPolygon2D] = []

	var terrain_domain_runtime: Dictionary = terrain_domain.get("runtime_generation", {})
	var expected_domain_polygon: PackedVector2Array = runner._points_from_source_map_json(terrain_domain.get("polygon", []))
	var terrain_domain_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(terrain_domain_runtime.get("visible_polygon2d_name", ""))) as Polygon2D
	runner._expect(expected_domain_polygon.size() >= 3, "Area 01 terrain domain should define one continuous source-map polygon")
	runner._expect(terrain_domain_node != null and terrain_domain_node.visible, "Area 01 builder should render the continuous terrain-domain mass")
	if terrain_domain_node != null:
		runner._expect(runner._packed_points_match(terrain_domain_node.polygon, expected_domain_polygon), "Area 01 terrain-domain visual should exactly match the source-map terrain domain")
		runner._expect(terrain_domain_node.texture != null, "Area 01 terrain-domain visual should use the generated reef fill texture")

	var water_cutout_layer := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/RuntimeSourceWaterCutouts") as Node2D
	var water_edge_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceWaterEdges") as Node2D
	var player_rim_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourcePlayerRims") as Node2D
	var cave_wall_art_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceCaveWallSprites") as Node2D
	var carved_water_count := 0
	var art_slice := main.get_node("Area01ArtSlice") as CanvasItem
	var player_visual_root := main.get_node("Player/VisualRoot") as CanvasItem
	var player_visual_z: int = runner._effective_canvas_z(player_visual_root)
	runner._expect(player_visual_z >= 20, "player visual should render in an actor band above world art")
	runner._expect(art_slice.z_index >= 0, "Area 01 art slice should stay above opaque ocean backgrounds so cave walls remain visible")
	runner._expect(runner._effective_canvas_z(art_slice) < player_visual_z, "Area 01 art slice should stay below actors so generated terrain cannot cover the diver")
	if terrain_domain_node != null:
		runner._expect(runner._effective_canvas_z(terrain_domain_node) < player_visual_z, "Area 01 terrain domain should render behind the diver")
	runner._expect(water_cutout_layer != null, "Area 01 builder should create source-owned playable-water cutouts")
	runner._expect(water_edge_layer != null, "Area 01 builder should retain hidden playable-water diagnostic edge nodes")
	runner._expect(player_rim_layer != null, "Area 01 builder should retain the generated rim container for solid terrain")
	runner._expect(cave_wall_art_layer != null, "Area 01 builder should create generated cave-wall sprite art from playable-water source regions")
	if water_cutout_layer != null:
		runner._expect(runner._effective_canvas_z(water_cutout_layer) < player_visual_z, "Area 01 playable-water cutouts should render behind the diver")
		runner._expect(source_grid_water_cutouts.size() > playable_water_regions.size(), "Area 01 runtime should generate source-grid-exact water cutouts instead of only broad review rectangles")
		for cutout_value in source_grid_water_cutouts:
			if typeof(cutout_value) != TYPE_DICTIONARY:
				runner._expect(false, "Area 01 source-grid water cutout should be a dictionary")
				continue
			var cutout_entry := cutout_value as Dictionary
			var cutout_id := String(cutout_entry.get("id", "source_grid_water_cutout"))
			var cutout_runtime_generation: Variant = cutout_entry.get("runtime_generation", {})
			runner._expect(cutout_runtime_generation is Dictionary, "Area 01 source-grid water cutout should define runtime generation metadata: %s" % cutout_id)
			if not cutout_runtime_generation is Dictionary:
				continue
			var cutout_runtime := cutout_runtime_generation as Dictionary
			var generated_cutout := water_cutout_layer.get_node_or_null(String(cutout_runtime.get("visible_polygon2d_name", ""))) as Polygon2D
			var expected_cutout_polygon: PackedVector2Array = runner._points_from_source_map_json(cutout_entry.get("polygon", []))
			runner._expect(generated_cutout != null and generated_cutout.visible, "Area 01 source-grid water cutout should render visibly: %s" % cutout_id)
			if generated_cutout != null:
				runner._expect(runner._packed_points_match(generated_cutout.polygon, expected_cutout_polygon), "Area 01 source-grid water cutout should exactly match generated source-grid geometry: %s" % cutout_id)
	if water_edge_layer != null:
		runner._expect(runner._effective_canvas_z(water_edge_layer) < player_visual_z, "Area 01 hidden water edge diagnostics should stay behind the diver")
		runner._expect(water_edge_layer.find_child("*SpriteRimTrims", true, false) == null, "Area 01 should not scatter generated water-edge sprite trim chunks across cave silhouettes")
	if player_rim_layer != null:
		runner._expect(runner._effective_canvas_z(player_rim_layer) < player_visual_z, "Area 01 generated rim helpers should render behind the diver")
	if cave_wall_art_layer != null:
		runner._expect(runner._effective_canvas_z(cave_wall_art_layer) < player_visual_z, "Area 01 generated cave-wall sprites should render behind the diver")
		runner._expect(not runner._node_tree_contains_collision(cave_wall_art_layer), "Area 01 generated cave-wall sprites should not own collision")
		runner._expect(cave_wall_art_layer.find_children("*", "Line2D", true, false).is_empty(), "Area 01 generated cave-wall sprites should not add visible or hidden Line2D outlines")
		runner._expect(cave_wall_art_layer.find_children("*", "Polygon2D", true, false).is_empty(), "Area 01 generated cave-wall sprite layer should not add rectangular polygon debug boxes")
		runner._expect(source_grid_water_edges.size() >= 20, "Area 01 runtime should generate source-grid water/solid boundary edges for wall art")
		var source_grid_wall_art := cave_wall_art_layer.get_node_or_null("SourceGridWaterBoundaryWallArt") as Node2D
		runner._expect(source_grid_wall_art != null, "Area 01 generated cave-wall art should follow source-grid water/solid boundaries")
		var wall_sprites := cave_wall_art_layer.find_children("*", "Sprite2D", true, false)
		runner._expect(wall_sprites.size() >= 24, "Area 01 generated cave-wall sprite layer should add enough edge art to read primary cave corridors")
		for sprite_node in wall_sprites:
			var sprite := sprite_node as Sprite2D
			runner._expect(sprite != null and sprite.visible and sprite.texture != null, "Area 01 generated cave-wall art should use visible texture sprites")
			if sprite != null:
				runner._expect(absf(absf(sprite.scale.x) - absf(sprite.scale.y)) <= 0.001, "Area 01 generated cave-wall sprites should use uniform scale instead of stretched sprite fragments: %s" % sprite.name)
				runner._expect(absf(sprite.scale.x) <= 0.32 and absf(sprite.scale.y) <= 0.32, "Area 01 generated cave-wall sprites should stay trim-sized rather than becoming stretched wall strips: %s" % sprite.name)
	for water_value in playable_water_regions:
		if typeof(water_value) != TYPE_DICTIONARY:
			runner._expect(false, "Area 01 playable water entry should be a dictionary")
			continue
		var water_entry := water_value as Dictionary
		var water_id := String(water_entry.get("id", "unknown"))
		var runtime_generation: Variant = water_entry.get("runtime_generation", {})
		runner._expect(runtime_generation is Dictionary, "Area 01 playable water should define runtime generation metadata: %s" % water_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		var cutout: Polygon2D = null
		if water_cutout_layer != null:
			cutout = water_cutout_layer.get_node_or_null(String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		var edge: Line2D = null
		if water_edge_layer != null:
			edge = water_edge_layer.get_node_or_null(String(runtime.get("edge_line2d_name", ""))) as Line2D
		var player_rim_group: Node2D = null
		var player_rim_line: Line2D = null
		if player_rim_layer != null:
			player_rim_group = player_rim_layer.get_node_or_null("%sPlayerRimSprites" % String(runtime.get("edge_line2d_name", ""))) as Node2D
			player_rim_line = player_rim_layer.get_node_or_null("%sPlayerRim" % String(runtime.get("edge_line2d_name", ""))) as Line2D
		var cave_wall_art_group: Node2D = null
		if cave_wall_art_layer != null:
			cave_wall_art_group = cave_wall_art_layer.get_node_or_null("%sWallArt" % runner._pascal_case_id(water_id)) as Node2D
		if bool(water_entry.get("carves_collision", false)):
			carved_water_count += 1
			runner._expect(cutout != null and not cutout.visible, "Area 01 broad playable-water review rectangles should stay hidden when source-grid cutouts own visible water: %s" % water_id)
			runner._expect(player_rim_line == null, "Area 01 player-facing rim/lip should not be a Line2D debug outline: %s" % water_id)
			runner._expect(player_rim_group == null, "Area 01 carving playable water should not create separate stretched rim/lip sprite markers: %s" % water_id)
			runner._expect(cave_wall_art_group == null, "Area 01 required-region review rectangles should not receive their own rectangular cave-wall sprite art: %s" % water_id)
		else:
			runner._expect(cutout != null and not cutout.visible, "Area 01 non-carving broad playable-water review rectangle should stay hidden when source-grid cutouts own visible water: %s" % water_id)
			runner._expect(player_rim_group == null, "Area 01 non-carving playable water should not create a player-facing rim/lip sprite group: %s" % water_id)
		runner._expect(edge != null and not edge.visible, "Area 01 playable water diagnostic edge should stay hidden: %s" % water_id)
	runner._expect(carved_water_count >= 6, "Area 01 runtime map should carve traced cave/corridor water from the continuous terrain mass")

	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			runner._expect(false, "Area 01 authoritative wall entry should be a dictionary")
			continue
		var terrain_entry := terrain as Dictionary
		var terrain_id := String(terrain_entry.get("id", "unknown"))
		var expected_polygon: PackedVector2Array = runner._points_from_source_map_json(terrain_entry.get("polygon", []))
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		runner._expect(runtime_generation is Dictionary, "Area 01 authoritative wall entry should define runtime generation metadata: %s" % terrain_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		runner._expect(String(runtime.get("visual_role", "")) == "generated_solid_partition", "Area 01 generated solid entry should be visible and colliding from one partition polygon: %s" % terrain_id)
		var visible := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		var collision := main.get_node_or_null("Area01ArtSlice/RuntimeSourceCollision/%s" % String(runtime.get("collision_polygon2d_name", ""))) as CollisionPolygon2D
		var lip := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/%s" % String(runtime.get("rim_container_name", ""))) as Polygon2D
		runner._expect(expected_polygon.size() >= 3, "Area 01 source-map wall should define an authoritative polygon: %s" % terrain_id)
		runner._expect(visible != null and visible.visible, "Area 01 generated solid partitions should render as visible terrain: %s" % terrain_id)
		runner._expect(collision != null and not collision.disabled, "Area 01 generated wall collision should be enabled: %s" % terrain_id)
		runner._expect(lip != null and lip.visible, "Area 01 generated solid partitions should render matching rim/lip reads: %s" % terrain_id)
		if visible != null:
			runner._expect(runner._packed_points_match(visible.polygon, expected_polygon), "Area 01 wall visual should exactly match source-map polygon: %s" % terrain_id)
		if collision != null:
			runner._expect(runner._packed_points_match(collision.polygon, expected_polygon), "Area 01 wall collision should exactly match source-map polygon: %s" % terrain_id)
			collisions.append(collision)
		if lip != null:
			runner._expect(runner._packed_points_match(lip.polygon, expected_polygon), "Area 01 wall rim/lip should exactly match source-map polygon: %s" % terrain_id)

	var legacy_collision_root := main.get_node("Area01ArtSlice/TerrainCollision") as StaticBody2D
	for child in legacy_collision_root.get_children():
		if child is CollisionPolygon2D:
			runner._expect((child as CollisionPolygon2D).disabled, "legacy Area 01 blockout collision should be disabled after runtime-v3 builder promotion: %s" % child.name)
	var legacy_terrain_root := main.get_node("Area01ArtSlice/TerrainBackWalls") as Node2D
	for child in legacy_terrain_root.get_children():
		if child is Polygon2D:
			runner._expect(not (child as Polygon2D).visible, "legacy Area 01 blockout terrain should be hidden behind runtime-v3 source terrain: %s" % child.name)

	for open_point in [
		Vector2(560.0, 620.0),
		Vector2(1660.0, 620.0),
		Vector2(1900.0, 1240.0),
		Vector2(2920.0, 620.0),
	]:
		runner._expect(not runner._point_inside_any_collision(open_point, collisions), "reported Area 01 open water should not contain a hidden generated blocker: %s" % open_point)

	var background_mid := main.get_node("Area01ArtSlice/BackgroundMid") as Node2D
	var foreground_decor := main.get_node("Area01ArtSlice/ForegroundDecor") as Node2D
	var platform_kit := main.get_node("Area01ArtSlice/TerrainVisualEdges/LeftShelfPlatformKit") as Node2D
	var background_far := main.get_node("Area01ArtSlice/BackgroundFar") as CanvasItem
	var parallax_background := main.get_node("Area01ArtSlice/OceanParallaxBackground") as CanvasItem
	var lighting_stack := main.get_node("Area01ArtSlice/OceanLightingStack") as CanvasItem
	var water_light_shafts := main.get_node("Area01ArtSlice/WaterLightShafts") as CanvasItem
	var wall_dressing_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapWallDressing") as Node2D
	var tile_terrain_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapTileTerrain") as Node2D
	var terrain_accent_layer := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/SourceMapTerrainAccents") as Node2D
	runner._expect(not background_mid.visible, "Area 01 builder should hide old mid-background wall-like shapes during wall-map rescue")
	runner._expect(not foreground_decor.visible, "Area 01 builder should hide foreground dressing during wall-map rescue")
	runner._expect(not platform_kit.visible, "Area 01 builder should hide old decorative platform overlays during wall-map rescue")
	runner._expect(background_far.modulate.a <= 0.13, "Area 01 far background should be demoted below source-map terrain")
	runner._expect(parallax_background.modulate.a <= 0.17, "Area 01 parallax background should not compete with source-map terrain")
	runner._expect(lighting_stack.modulate.a <= 0.29, "Area 01 broad lighting stack should not read as blocking terrain")
	runner._expect(water_light_shafts.modulate.a <= 0.25, "Area 01 light shafts should stay secondary to collision-source terrain")
	runner._expect(wall_dressing_layer == null, "Area 01 builder should not keep the old shape-dressing layer")
	runner._expect(tile_terrain_layer == null, "Area 01 builder should not render rectangular atlas tiles over arbitrary wall polygons")
	if terrain_accent_layer != null:
		runner._expect(not runner._node_tree_contains_collision(terrain_accent_layer), "Area 01 terrain accents should not add collision ownership")
		runner._expect(terrain_accent_layer.find_child("VerticalWallMiddleTrim*", true, false) == null, "Area 01 terrain accents should not auto-place vertical wall trims without semantic source-map segments")
		runner._expect(terrain_accent_layer.find_child("DiagonalSlopeTrim*", true, false) == null, "Area 01 terrain accents should not auto-place slope trims without semantic source-map segments")
	var generated_terrain := main.get_node("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain") as Node2D
	var domain_accent_layer := generated_terrain.get_node_or_null("RuntimeSourceTerrainDomainAccents") as Node2D
	runner._expect(domain_accent_layer != null, "Area 01 generated source-map terrain should add broad visual-only domain accents")
	if domain_accent_layer != null:
		runner._expect(not runner._node_tree_contains_collision(domain_accent_layer), "Area 01 generated terrain domain accents should not add collision ownership")
		runner._expect(domain_accent_layer.get_child_count() >= 6, "Area 01 generated terrain domain accents should include broad strata/shadow/decal treatment")
	var first_generated_wall: Polygon2D = null
	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			continue
		var terrain_entry := terrain as Dictionary
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		first_generated_wall = generated_terrain.get_node_or_null(String(runtime.get("visible_polygon2d_name", ""))) as Polygon2D
		if first_generated_wall != null:
			break
	runner._expect(first_generated_wall != null, "Area 01 generated source-map terrain should include visible generated solid partitions")
	if first_generated_wall != null:
		runner._expect(first_generated_wall.color.a >= 0.9, "Area 01 generated source-map terrain should read as solid wall/floor, not translucent background dressing")
		runner._expect(first_generated_wall.texture != null, "Area 01 generated solid partitions should carry terrain fill texture instead of relying on a flat hidden domain")
		runner._expect(first_generated_wall.visible, "Area 01 generated solid partition should be player-facing terrain")
	main.free()

func _test_area_01_starter_resource_pocket_placement(runner) -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 starter resource placement test should use runtime source-map collision: %s" % builder.last_error)
	var source_map: Dictionary = runner._load_area01_source_map_for_tests()
	var hooks_by_id := {}
	for hook_value in source_map.get("scene_hooks", []):
		if typeof(hook_value) == TYPE_DICTIONARY:
			hooks_by_id[String((hook_value as Dictionary).get("id", ""))] = hook_value

	var collisions: Array[CollisionPolygon2D] = runner._area01_enabled_collision_polygons(main)
	for hook_id in ["starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		runner._expect(hooks_by_id.has(hook_id), "Area 01 generated source map should include starter resource hook: %s" % hook_id)
		if not hooks_by_id.has(hook_id):
			continue
		var hook := hooks_by_id[hook_id] as Dictionary
		runner._expect(String(hook.get("type", "")) == "pickup", "starter resource hook should be typed as pickup: %s" % hook_id)
		runner._expect(not String(hook.get("resource", "")).is_empty(), "starter resource hook should name its resource family: %s" % hook_id)
		var runtime := hook.get("runtime_generation", {}) as Dictionary
		var area := main.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % String(runtime.get("area2d_name", ""))) as Area2D
		runner._expect(area != null, "starter resource hook should build a generated Area2D: %s" % hook_id)
		if area == null:
			continue
		var collision := area.get_node_or_null(String(runtime.get("collision_polygon2d_name", ""))) as CollisionPolygon2D
		runner._expect(collision != null and collision.disabled, "starter resource hook should stay inert/nonblocking until gameplay promotes it: %s" % hook_id)
		var points: PackedVector2Array = runner._points_from_source_map_json(hook.get("points", []))
		runner._expect(points.size() >= 3, "starter resource hook should have generated polygon points: %s" % hook_id)
		if points.size() >= 3:
			var center := Vector2.ZERO
			for point in points:
				center += point
			center /= float(points.size())
			runner._expect(not runner._point_inside_any_collision(center, collisions), "starter resource hook should not sit inside generated Area 01 terrain collision: %s" % hook_id)
	main.free()

func _test_area_01_cave_mouth_affordances(runner) -> void:
	var main := MainScene.instantiate()
	var root := main.get_node("Area01ArtSlice/GameplayObjects/CaveMouthAffordances") as Node2D
	var left_mouth := root.get_node("LeftCaveMouth") as Node2D
	var right_mouth := root.get_node("RightChamberMouth") as Node2D
	var future_seal := root.get_node("LowerBasinFutureSeal") as Node2D
	var left_shadow := left_mouth.get_node("MouthShadow") as Polygon2D
	var left_wash := left_mouth.get_node("EntryWaterWash") as Polygon2D
	var left_rim := left_mouth.get_node("UpperRim") as Polygon2D
	var right_shadow := right_mouth.get_node("MouthShadow") as Polygon2D
	var right_wash := right_mouth.get_node("EntryWaterWash") as Polygon2D
	var future_mouth := future_seal.get_node("SealMouth") as Polygon2D
	var future_veil := future_seal.get_node("PressureVeil") as Polygon2D
	var future_bars := future_seal.get_node("SealBars") as Polygon2D
	var future_glint := future_seal.get_node("FutureGlint") as Polygon2D
	runner._expect(root.find_child("CollisionShape2D", true, false) == null, "Area 01 cave-mouth affordances should not add hidden collision")
	runner._expect(root.find_child("CollisionPolygon2D", true, false) == null, "Area 01 cave-mouth affordances should not add player blockers")
	runner._expect(root.find_child("Label", true, false) == null, "Area 01 cave-mouth affordances should not rely on labels for comprehension")
	runner._expect(left_shadow.color.a >= 0.6 and right_shadow.color.a >= 0.55, "reachable cave mouths should use dark negative space so openings read apart from solid reef")
	runner._expect(left_wash.color.a <= 0.16 and right_wash.color.a <= 0.14, "reachable cave-mouth water washes should stay subtle instead of becoming route arrows")
	runner._expect(left_rim.color.a > left_wash.color.a, "reachable cave-mouth rims should frame the opening more clearly than the water wash")
	runner._expect(future_mouth.color.a < left_shadow.color.a, "future sealed mouth should be quieter than current reachable cave openings")
	runner._expect(future_veil.color.a < left_wash.color.a and future_bars.color.a < left_rim.color.a, "future route promise should stay lower priority than current cave affordances")
	runner._expect(future_glint.color.a < left_rim.color.a, "future glint should invite curiosity without reading as a collectible")
	main.free()
