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

func _test_area_01_source_map_contract(runner) -> void:
	var file := FileAccess.open("res://data/maps/area_01_runtime_geometry.generated.json", FileAccess.READ)
	runner._expect(file != null, "Area 01 generated runtime geometry JSON should exist")
	if file == null:
		return

	var parsed = JSON.parse_string(file.get_as_text())
	runner._expect(typeof(parsed) == TYPE_DICTIONARY, "Area 01 generated runtime geometry should parse as a JSON object")
	if typeof(parsed) != TYPE_DICTIONARY:
		return

	var source_map := parsed as Dictionary
	runner._expect(String(source_map.get("map_id", "")) == "area_01_runtime_geometry_generated", "Area 01 should use the generated runtime geometry revision")
	runner._expect(bool(source_map.get("generated", false)), "Area 01 runtime geometry should be generated")
	runner._expect(String(source_map.get("generated_from", "")) == "data/maps/area_01_source_grid_v1.json", "Area 01 generated runtime geometry should point back to the source grid")
	runner._expect(String(source_map.get("generated_by", "")) == "tools/build-area01-map.mjs", "Area 01 generated runtime geometry should name the deterministic converter")
	runner._expect(not String(source_map.get("source_sha256", "")).is_empty(), "Area 01 generated runtime geometry should preserve the source-grid hash")
	var required_keys := [
		"schema_version",
		"coordinate_space",
		"source_grid",
		"terrain_domain",
		"playable_water_components",
		"playable_water_regions",
		"solid_terrain",
		"scene_hooks",
		"review_points",
		"validation_contract",
	]
	for key in required_keys:
		runner._expect(source_map.has(key), "Area 01 generated runtime geometry should include %s" % key)

	var playable_water_regions: Array = source_map.get("playable_water_regions", [])
	var solid_terrain: Array = source_map.get("solid_terrain", [])
	var scene_hooks: Array = source_map.get("scene_hooks", [])
	var review_points: Array = source_map.get("review_points", [])
	var terrain_domain: Dictionary = source_map.get("terrain_domain", {})
	var validation_contract: Dictionary = source_map.get("validation_contract", {})
	runner._expect(bool(validation_contract.get("generated_geometry_must_not_be_hand_edited", false)), "Area 01 generated runtime geometry should reject hand-tuned terrain polygons")
	runner._expect(bool(validation_contract.get("screenshots_are_confirmation_only", false)), "Area 01 generated runtime geometry should keep screenshots as confirmation only")
	runner._expect((terrain_domain.get("polygon", []) as Array).size() >= 3, "Area 01 runtime source map should define one continuous terrain domain")
	runner._expect(playable_water_regions.size() >= 7, "Area 01 generated runtime geometry should define required playable-water regions")
	var playable_water_ids: Array[String] = []
	for water in playable_water_regions:
		if typeof(water) != TYPE_DICTIONARY:
			continue
		var water_entry := water as Dictionary
		playable_water_ids.append(String(water_entry.get("id", "")))
		runner._expect(water_entry.has("source_rect_cells"), "Area 01 playable water should preserve source-grid cells: %s" % String(water_entry.get("id", "")))
	for required_region_id in ["open_surface_water", "starter_kelp_hole", "shell_reef_route", "thermal_vent_pocket", "blue_chimney_route", "pressure_wreck_branch", "future_deep_exit"]:
		runner._expect(playable_water_ids.has(required_region_id), "Area 01 generated runtime geometry should cover %s" % required_region_id)
	runner._expect(solid_terrain.size() >= 20, "Area 01 runtime source map should define generated visible/colliding solid partitions")
	runner._expect(scene_hooks.size() >= 11, "Area 01 generated runtime geometry should define trigger/debug hooks")
	runner._expect(review_points.size() >= 7, "Area 01 generated runtime geometry should preserve review points")

	var hooks_by_id := {}
	for hook in scene_hooks:
		if typeof(hook) == TYPE_DICTIONARY:
			hooks_by_id[String((hook as Dictionary).get("id", ""))] = hook
	runner._expect(hooks_by_id.has("oxygen_surface"), "Area 01 source grid should define the full-width surface oxygen hook")
	runner._expect(hooks_by_id.has("ship_offload"), "Area 01 source grid should define the separate ship offload hook")
	for required_hook_id in ["player_start", "starter_kelp_fiber", "starter_shell_fragments", "starter_food_supply"]:
		runner._expect(hooks_by_id.has(required_hook_id), "Area 01 generated runtime geometry should include required hook %s" % required_hook_id)
	if hooks_by_id.has("oxygen_surface") and hooks_by_id.has("ship_offload"):
		var oxygen_hook := hooks_by_id["oxygen_surface"] as Dictionary
		var offload_hook := hooks_by_id["ship_offload"] as Dictionary
		runner._expect(String(oxygen_hook.get("type", "")) == "oxygen", "surface hook should be typed as oxygen")
		runner._expect(String(offload_hook.get("type", "")) == "offload", "ship hook should be typed as offload")
		runner._expect(String(oxygen_hook.get("id", "")) != String(offload_hook.get("id", "")), "oxygen refill and ship offload should remain separate hooks")

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 generated runtime geometry should build generated terrain: %s" % builder.last_error)

	var terrain_domain_runtime: Dictionary = terrain_domain.get("runtime_generation", {})
	var terrain_domain_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(terrain_domain_runtime.get("visible_polygon2d_name", "")))
	runner._expect(terrain_domain_node is Polygon2D, "Area 01 source map should build one continuous source-owned terrain domain")
	if terrain_domain_node is Polygon2D:
		var terrain_domain_polygon := terrain_domain_node as Polygon2D
		runner._expect(not terrain_domain_polygon.visible, "Area 01 terrain domain should stay hidden so uncut cave texture does not fill playable water")
		runner._expect(terrain_domain_polygon.texture == null, "Area 01 terrain domain guide should not carry player-facing terrain texture")
	var carved_water_count := 0
	for water in playable_water_regions:
		if typeof(water) != TYPE_DICTIONARY:
			runner._expect(false, "Area 01 playable water entries should be dictionaries")
			continue
		var water_entry := water as Dictionary
		var water_runtime: Dictionary = water_entry.get("runtime_generation", {})
		var water_cutout := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/RuntimeSourceWaterCutouts/%s" % String(water_runtime.get("visible_polygon2d_name", "")))
		var water_edge := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/RuntimeSourceWaterEdges/%s" % String(water_runtime.get("edge_line2d_name", "")))
		runner._expect(water_cutout is Polygon2D, "Area 01 playable water should build a cutout Polygon2D: %s" % String(water_entry.get("id", "")))
		runner._expect(water_edge is Line2D, "Area 01 playable water should build a hidden diagnostic edge Line2D: %s" % String(water_entry.get("id", "")))
		if bool(water_entry.get("carves_collision", false)):
			carved_water_count += 1
			runner._expect(not water_cutout.visible, "Area 01 carving broad water rectangle should stay hidden when source-grid cutouts own visible water: %s" % String(water_entry.get("id", "")))
		else:
			runner._expect(not water_cutout.visible, "Area 01 non-carving broad water rectangle should stay hidden when source-grid cutouts own visible water: %s" % String(water_entry.get("id", "")))
		if water_edge is Line2D:
			runner._expect(not water_edge.visible, "Area 01 water edge Line2D should stay hidden in normal play: %s" % String(water_entry.get("id", "")))
	runner._expect(carved_water_count >= 6, "Area 01 generated runtime geometry should carve cave/pocket water out of the continuous terrain domain")

	var generated_solid_partitions := 0
	for terrain in solid_terrain:
		if typeof(terrain) != TYPE_DICTIONARY:
			runner._expect(false, "Area 01 solid terrain entries should be dictionaries")
			continue
		var terrain_entry := terrain as Dictionary
		var terrain_id := String(terrain_entry.get("id", "unknown"))
		var runtime_generation: Variant = terrain_entry.get("runtime_generation", {})
		runner._expect(runtime_generation is Dictionary, "Area 01 solid terrain should include runtime generation metadata: %s" % terrain_id)
		if not runtime_generation is Dictionary:
			continue
		var runtime := runtime_generation as Dictionary
		runner._expect(String(runtime.get("visual_role", "")) == "generated_solid_partition", "Area 01 solid terrain should be generated visible/colliding partitions: %s" % terrain_id)
		generated_solid_partitions += 1
		var trim_segments: Variant = terrain_entry.get("trim_segments", [])
		if trim_segments is Array:
			for trim_value in trim_segments:
				runner._expect(trim_value is Dictionary, "Area 01 terrain trim segments should be dictionaries: %s" % terrain_id)
				if not trim_value is Dictionary:
					continue
				var trim := trim_value as Dictionary
				runner._expect(trim.has("id"), "Area 01 terrain trim segment should have an id: %s" % terrain_id)
				runner._expect(["top_lip", "underside", "deep_floor_lip", "vertical_wall", "diagonal_slope"].has(String(trim.get("type", ""))), "Area 01 terrain trim segment should have a semantic type: %s" % terrain_id)
				runner._expect(trim.get("start", []) is Array and trim.get("end", []) is Array, "Area 01 terrain trim segment should define explicit start/end points: %s" % terrain_id)
		var collision_node := main.get_node_or_null("Area01ArtSlice/RuntimeSourceCollision/%s" % String(runtime.get("collision_polygon2d_name", "")))
		var visible_node := main.get_node_or_null("Area01ArtSlice/TerrainBackWalls/RuntimeSourceTerrain/%s" % String(runtime.get("visible_polygon2d_name", "")))
		var lip_node := main.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/RuntimeSourceRims/%s" % String(runtime.get("rim_container_name", "")))
		runner._expect(visible_node is Polygon2D, "Area 01 source map visible terrain should exist as Polygon2D: %s" % terrain_id)
		runner._expect(collision_node is CollisionPolygon2D, "Area 01 source map collision should exist as CollisionPolygon2D: %s" % terrain_id)
		runner._expect(lip_node is Polygon2D, "Area 01 source map rim/lip should exist as Polygon2D: %s" % terrain_id)
		var expected_polygon: PackedVector2Array = runner._points_from_source_map_json(terrain_entry.get("polygon", []))
		if visible_node is Polygon2D:
			runner._expect((visible_node as Polygon2D).visible, "Area 01 mapped visible terrain should stay visible: %s" % terrain_id)
			runner._expect(runner._packed_points_match((visible_node as Polygon2D).polygon, expected_polygon), "Area 01 visible terrain should match source-map polygon: %s" % terrain_id)
		if collision_node is CollisionPolygon2D:
			runner._expect(not (collision_node as CollisionPolygon2D).disabled, "Area 01 mapped blocker collision should stay enabled: %s" % terrain_id)
			runner._expect(runner._packed_points_match((collision_node as CollisionPolygon2D).polygon, expected_polygon), "Area 01 blocker collision should match source-map polygon: %s" % terrain_id)
		if lip_node is Polygon2D:
			runner._expect((lip_node as Polygon2D).visible, "Area 01 mapped rim/lip should stay visible: %s" % terrain_id)
			runner._expect(runner._packed_points_match((lip_node as Polygon2D).polygon, expected_polygon), "Area 01 rim/lip should match source-map polygon: %s" % terrain_id)
	runner._expect(generated_solid_partitions == solid_terrain.size(), "Area 01 solid terrain should all be generated visible/colliding partitions from playable water")

	for hook in scene_hooks:
		if typeof(hook) != TYPE_DICTIONARY:
			runner._expect(false, "Area 01 scene hook entries should be dictionaries")
			continue
		var hook_entry := hook as Dictionary
		var hook_runtime: Variant = hook_entry.get("runtime_generation", {})
		runner._expect(hook_runtime is Dictionary, "Area 01 scene hooks should include runtime generation metadata: %s" % String(hook_entry.get("id", "")))
		if not hook_runtime is Dictionary:
			continue
		var hook_runtime_dict := hook_runtime as Dictionary
		var area_node := main.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % String(hook_runtime_dict.get("area2d_name", ""))) as Area2D
		runner._expect(area_node != null, "Area 01 scene hook should create a generated Area2D: %s" % String(hook_entry.get("id", "")))
		if area_node != null:
			runner._expect(not area_node.monitoring and not area_node.monitorable, "Area 01 generated hooks should stay nonblocking/non-behavioral during validation: %s" % String(hook_entry.get("id", "")))
	main.free()

func _test_area_01_source_truth_validator(runner) -> void:
	var validator := Area01SourceTruthValidatorScript.new()
	runner._expect(validator.load_source_map(), "Area 01 source truth validator should load the runtime source map: %s" % "\n".join(validator.errors))
	if validator.source_map.is_empty():
		return

	var data_errors: Array[String] = validator.validate_source_map_data()
	runner._expect(data_errors.is_empty(), "Area 01 source truth data validation should pass: %s" % "\n".join(data_errors))

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 runtime source map should build before source truth validation: %s" % builder.last_error)
	var runtime_errors: Array[String] = validator.validate_runtime_scene(main)
	runner._expect(runtime_errors.is_empty(), "Area 01 source truth runtime validation should pass: %s" % "\n".join(runtime_errors))
	main.free()

func _test_area_01_source_truth_validator_catches_drift(runner) -> void:
	var validator := Area01SourceTruthValidatorScript.new()
	runner._expect(validator.load_source_map(), "Area 01 source truth validator should load before broken fixture")
	if validator.source_map.is_empty():
		return

	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 runtime source map should build before broken fixture: %s" % builder.last_error)
	var collision_root := main.get_node("Area01ArtSlice/RuntimeSourceCollision") as StaticBody2D
	var rogue_collision := CollisionPolygon2D.new()
	rogue_collision.name = "UnmappedDriftCollision"
	rogue_collision.polygon = PackedVector2Array([
		Vector2(20.0, 20.0),
		Vector2(80.0, 20.0),
		Vector2(80.0, 80.0),
		Vector2(20.0, 80.0),
	])
	rogue_collision.disabled = false
	collision_root.add_child(rogue_collision)

	var errors: Array[String] = validator.validate_runtime_scene(main)
	var caught_unowned_collision := false
	for error in errors:
		if error.contains("UnmappedDriftCollision"):
			caught_unowned_collision = true
	runner._expect(caught_unowned_collision, "Area 01 source truth validator should catch enabled collision without source-map ownership")
	main.free()

func _test_area_01_visual_cue_contract_registry(runner) -> void:
	var contracts: Dictionary = Area01VisualCueContractScript.contracts()
	for family_id in Area01VisualCueContractScript.required_family_ids():
		runner._expect(contracts.has(family_id), "Area 01 visual cue contract should register %s" % family_id)
		var contract := contracts.get(family_id, {}) as Dictionary
		for key in [
			"z_index_min",
			"z_index_max",
			"alpha_min",
			"alpha_max",
			"color_family",
			"label_policy",
			"brighter_than",
			"quieter_than",
		]:
			runner._expect(contract.has(key), "Area 01 cue family %s should define %s" % [family_id, key])
		runner._expect(float(contract.get("alpha_min", 0.0)) <= float(contract.get("alpha_max", -1.0)), "Area 01 cue family %s should have a valid alpha range" % family_id)

	var terrain_contract := contracts[Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN] as Dictionary
	var rim_contract := contracts[Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP] as Dictionary
	var pickup_contract := contracts[Area01VisualCueContractScript.FAMILY_RESOURCE_PICKUP] as Dictionary
	runner._expect(float(terrain_contract.get("alpha_min", 0.0)) > float(rim_contract.get("alpha_min", 1.0)), "solid terrain should be visually stronger than rim/lip support")
	runner._expect(float(pickup_contract.get("alpha_min", 0.0)) > float(rim_contract.get("alpha_min", 1.0)), "resource pickups should stay brighter than rim/lip support")

func _test_area_01_visual_cue_diagnostic_report(runner) -> void:
	var main := MainScene.instantiate()
	var builder := Area01BlockoutBuilderScript.new()
	runner._expect(builder.build(main), "Area 01 runtime source map should build before visual cue diagnostics: %s" % builder.last_error)
	var report: Dictionary = Area01VisualCueContractScript.debug_report(main, Rect2(Vector2(-900.0, 0.0), Vector2(5500.0, 2600.0)))
	var families: Dictionary = report.get("families", {})
	runner._expect(int(families.get(Area01VisualCueContractScript.FAMILY_SOLID_TERRAIN, 0)) >= 13, "Area 01 cue report should count generated solid terrain nodes")
	runner._expect(int(families.get(Area01VisualCueContractScript.FAMILY_TERRAIN_RIM_LIP, 0)) >= 13, "Area 01 cue report should count generated terrain rim/lip nodes")
	runner._expect(int(families.get(Area01VisualCueContractScript.FAMILY_PASSIVE_BACKGROUND, 0)) >= 1, "Area 01 cue report should count tagged passive background support")

	var cue_parent := Node2D.new()
	main.add_child(cue_parent)
	for index in range(7):
		var bright_cue := Polygon2D.new()
		bright_cue.name = "BrightReturnCurrentFixture%d" % index
		bright_cue.polygon = PackedVector2Array([
			Vector2(0.0, 0.0),
			Vector2(12.0, 0.0),
			Vector2(12.0, 12.0),
			Vector2(0.0, 12.0),
		])
		bright_cue.position = Vector2(120.0 + float(index * 18), 120.0)
		bright_cue.color = Color(0.2, 1.0, 0.7, 0.8)
		Area01VisualCueContractScript.tag_node(bright_cue, Area01VisualCueContractScript.FAMILY_RETURN_CURRENT, "fixture_%d" % index)
		cue_parent.add_child(bright_cue)

	var warning_report: Dictionary = Area01VisualCueContractScript.debug_report(main, Rect2(Vector2(0.0, 0.0), Vector2(400.0, 300.0)))
	var warnings: Array = warning_report.get("warnings", [])
	var caught_bright_cluster := false
	for warning in warnings:
		if String(warning).contains(Area01VisualCueContractScript.FAMILY_RETURN_CURRENT):
			caught_bright_cluster = true
	runner._expect(caught_bright_cluster, "Area 01 cue report should flag too many bright return-current cues in one review region")
	main.free()
