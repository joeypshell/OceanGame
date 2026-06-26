extends SceneTree

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
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
const ScannableScript := preload("res://scripts/scannable.gd")
const PredatorScript := preload("res://scripts/predator.gd")
const OxygenTankUpgrade := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PressureSealUpgrade := preload("res://resources/upgrades/pressure_seal_1.tres")
const SignalLensUpgrade := preload("res://resources/upgrades/signal_lens_1.tres")
const EchoLensUpgrade := preload("res://resources/upgrades/echo_lens_1.tres")
const CargoRackUpgrade := preload("res://resources/upgrades/cargo_rack_1.tres")
const PredatorWarningUpgrade := preload("res://resources/upgrades/predator_warning_1.tres")
const DecoyPulseUpgrade := preload("res://resources/upgrades/decoy_pulse_1.tres")

class DummyScanTarget:
	extends Node2D

	var discovery_id := ""
	var display_name := ""
	var description := ""

	func set_scan_selected(_selected: bool) -> void:
		pass

var _failures: Array[String] = []
var _passes := 0

func _initialize() -> void:
	_run("cargo limit", _test_cargo_limit)
	_run("upgraded cargo limit", _test_upgraded_cargo_limit)
	_run("extraction requirements", _test_extraction_requirements)
	_run("oxygen failure", _test_oxygen_failure)
	_run("upgrade affordability", _test_upgrade_affordability)
	_run("progression reset", _test_progression_reset)
	_run("save/load behavior", _test_save_load_behavior)
	_run("deterministic seed generation", _test_deterministic_seed_generation)
	_run("expedition condition selection", _test_expedition_condition_selection)
	_run("spawn-point matching", _test_spawn_point_matching)
	_run("spawn selection", _test_spawn_selection)
	_run("condition-weighted spawn selection", _test_condition_weighted_spawn_selection)
	_run("debug review seed and condition helpers", _test_debug_review_helpers)
	_run("scanner target resolver", _test_scanner_target_resolver)
	_run("compact scan marker", _test_compact_scan_marker)
	_run("scan pulse visual helper", _test_scan_pulse_visual_helper)
	_run("sprite-ready scene asset slots", _test_sprite_ready_scene_asset_slots)
	_run("landmark region identity metadata", _test_landmark_region_identity_metadata)
	_run("predator scan target", _test_predator_scan_target)
	_run("discovery prerequisites", _test_discovery_prerequisites)
	_run("predator warning upgrade metadata", _test_predator_warning_upgrade_metadata)
	_run("predator warning effect isolation", _test_predator_warning_effect_isolation)
	_run("decoy pulse effect isolation", _test_decoy_pulse_effect_isolation)
	_run("echo lens effect isolation", _test_echo_lens_effect_isolation)
	_run("expedition prep goals", _test_expedition_prep_goals)
	_run("result progress callouts", _test_result_progress_callouts)
	_run("extraction banking result copy", _test_extraction_banking_result_copy)
	_run("next expedition framing", _test_next_expedition_framing)
	_run("region memory result callout", _test_region_memory_result_callout)
	_run("discovery memory result callout", _test_discovery_memory_result_callout)
	_run("route choice result callout", _test_route_choice_result_callout)
	_run("gulper research result callout", _test_gulper_research_result_callout)
	_run("echo lens result callout", _test_echo_lens_result_callout)
	_run("upgrade bay readability states", _test_upgrade_bay_readability_states)
	_run("result and upgrade copy length guards", _test_result_and_upgrade_copy_length_guards)
	_run("recent expedition log", _test_recent_expedition_log)
	_run("thermal vent scan clue text", _test_thermal_vent_scan_clue_text)
	_run("shell reef scan clue text", _test_shell_reef_scan_clue_text)
	_run("wreck signal cache repeat scan hint", _test_wreck_signal_cache_repeat_scan_hint)
	_run("pressure lock guidance text", _test_pressure_lock_guidance_text)
	_run("surface summary tabs", _test_surface_summary_tabs)
	_run("condition briefing copy", _test_condition_briefing_copy)
	_run("compact dive hud helpers", _test_compact_dive_hud_helpers)
	_run("burst thruster movement helper", _test_burst_thruster_movement_helper)
	_run("player visual facing isolation", _test_player_visual_facing_isolation)
	_run("player idle and thrust visual states", _test_player_idle_and_thrust_visual_states)
	_run("predator decoy pulse helper", _test_predator_decoy_pulse_helper)
	_run("decoy pulse feedback text", _test_decoy_pulse_feedback_text)

	if _failures.is_empty():
		print("Logic tests passed: %d checks." % _passes)
		quit(0)
		return

	for failure in _failures:
		push_error(failure)
	print("Logic tests failed: %d failure(s), %d passed checks." % [_failures.size(), _passes])
	quit(1)

func _run(test_name: String, test_callable: Callable) -> void:
	var failures_before := _failures.size()
	test_callable.call()
	if _failures.size() == failures_before:
		print("PASS: %s" % test_name)

func _test_cargo_limit() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	_expect(session.add_cargo("kelp_fiber"), "first cargo slot should accept an item")
	_expect(session.add_cargo("shell_fragments"), "second cargo slot should accept an item")
	_expect(session.add_cargo("glow_plankton"), "third cargo slot should accept an item")
	_expect(not session.add_cargo("extra_resource"), "cargo should reject items beyond the limit")
	_expect(session.current_cargo.size() == session.cargo_limit, "cargo should stay at the configured limit")

func _test_upgraded_cargo_limit() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.cargo_limit = 4
	session.start()

	_expect(session.add_cargo("kelp_fiber"), "upgraded first cargo slot should accept an item")
	_expect(session.add_cargo("shell_fragments"), "upgraded second cargo slot should accept an item")
	_expect(session.add_cargo("glow_plankton"), "upgraded third cargo slot should accept an item")
	_expect(session.add_cargo("kelp_fiber"), "upgraded fourth cargo slot should accept an item")
	_expect(not session.add_cargo("extra_resource"), "upgraded cargo should reject items beyond four slots")
	session.fail()
	_expect(session.current_cargo.is_empty(), "oxygen failure should still discard upgraded cargo")

func _test_extraction_requirements() -> void:
	var session := DiveSessionScript.new()
	session.reset(30.0)
	session.start()

	_expect(not session.can_extract(true), "player should not extract before leaving base")
	session.has_left_base = true
	_expect(not session.can_extract(false), "player should not extract away from base")
	_expect(session.can_extract(true), "player should extract only after leaving and returning to base")
	session.extract()
	_expect(session.result == DiveSessionScript.Result.EXTRACTED, "extract should set extracted result")

func _test_oxygen_failure() -> void:
	var session := DiveSessionScript.new()
	session.reset(10.0)
	session.start()
	session.add_cargo("kelp_fiber")

	session.drain_oxygen(12.0)

	_expect(session.oxygen == 0.0, "oxygen should clamp to zero")
	_expect(session.result == DiveSessionScript.Result.FAILED, "oxygen depletion should fail the dive")
	_expect(session.current_cargo.is_empty(), "oxygen failure should discard current cargo")

func _test_upgrade_affordability() -> void:
	var progression := ProgressionStateScript.new()

	_expect(not progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should not be affordable without resources")
	progression.banked_resources = {
		"kelp_fiber": 2,
		"shell_fragments": 1,
		"glow_plankton": 1,
	}

	_expect(progression.can_afford(OxygenTankUpgrade.resource_cost), "upgrade should become affordable with exact resources")
	_expect(progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "affordable upgrade should purchase")
	_expect(progression.has_upgrade(OxygenTankUpgrade.id), "purchased upgrade id should be recorded")
	_expect(progression.resource_count("kelp_fiber") == 0, "purchase should spend kelp fiber")
	_expect(progression.resource_count("shell_fragments") == 0, "purchase should spend shell fragments")
	_expect(progression.resource_count("glow_plankton") == 0, "purchase should spend glow plankton")
	_expect(not progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost), "owned upgrade should not purchase again")

func _test_progression_reset() -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)
	progression.advance_run()

	progression.reset()

	_expect(progression.banked_resources.is_empty(), "reset should clear banked resources")
	_expect(progression.purchased_upgrades.is_empty(), "reset should clear purchased upgrades")
	_expect(progression.scan_discoveries.is_empty(), "reset should clear scan discoveries")
	_expect(is_equal_approx(progression.best_depth_reached, 0.0), "reset should clear best depth")
	_expect(progression.current_run_number == 0, "reset should return run counter to pre-expedition state")
	_expect(progression.current_run_seed == 0, "reset should clear current seed")

	progression.advance_run()
	_expect(progression.current_run_number == 1, "first run after reset should be expedition 1")
	_expect(progression.current_run_seed == 8919, "first seed after reset should match expedition 1")

func _test_save_load_behavior() -> void:
	var progression := ProgressionStateScript.new()
	progression.banked_resources = {"kelp_fiber": 3, "glow_plankton": 1}
	progression.purchased_upgrades = {OxygenTankUpgrade.id: true}
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	progression.record_depth(144.5)

	var saved: Dictionary = progression.to_save_data()
	_expect(int(saved.get("save_version", -1)) == ProgressionStateScript.CURRENT_SAVE_VERSION, "save should include current save version")

	var loaded := ProgressionStateScript.new()
	loaded.load_save_data(saved)
	_expect(loaded.resource_count("kelp_fiber") == 3, "current save should reload banked resources")
	_expect(loaded.has_upgrade(OxygenTankUpgrade.id), "current save should reload purchased upgrades")
	_expect(loaded.has_discovery("thermal_vent"), "current save should reload scan discoveries")
	_expect(is_equal_approx(loaded.best_depth_reached, 144.5), "current save should reload best depth")

	var legacy_save := saved.duplicate(true)
	legacy_save.erase("save_version")
	var legacy_loaded := ProgressionStateScript.new()
	legacy_loaded.load_save_data(legacy_save)
	_expect(legacy_loaded.loaded_save_version == ProgressionStateScript.LEGACY_SAVE_VERSION, "missing save version should load as legacy")
	_expect(legacy_loaded.has_discovery("thermal_vent"), "legacy save should reload known discovery fields")

	var future_save := saved.duplicate(true)
	future_save["save_version"] = 999
	var future_loaded := ProgressionStateScript.new()
	future_loaded.load_save_data(future_save)
	_expect(future_loaded.loaded_save_version == 999, "unknown future save version should be recorded")
	_expect(future_loaded.has_upgrade(OxygenTankUpgrade.id), "unknown future save should best-effort load known upgrade ids")

func _test_deterministic_seed_generation() -> void:
	var first := ProgressionStateScript.new()
	var second := ProgressionStateScript.new()

	for index in range(5):
		first.advance_run()
		second.advance_run()
		_expect(first.current_run_number == index + 1, "run number should advance deterministically")
		_expect(first.current_run_seed == 1000 + first.current_run_number * 7919, "run seed should follow the documented formula")
		_expect(first.current_run_seed == second.current_run_seed, "two progression states should generate the same seed sequence")

func _test_expedition_condition_selection() -> void:
	var first := ExpeditionConditionScript.condition_for_seed(8919)
	var first_again := ExpeditionConditionScript.condition_for_seed(8919)
	_expect(first.get("id", "") == first_again.get("id", ""), "same seed should select the same expedition condition")
	_expect(not String(first.get("display_name", "")).is_empty(), "condition should include a display name")
	_expect(not String(first.get("briefing", "")).is_empty(), "condition should include a briefing line")
	_expect(first.get("tags", []) is Array, "condition should include tag metadata")

	var ids := {}
	for seed in [8919, 16838, 24757, 32676, 40595]:
		ids[ExpeditionConditionScript.id_for_seed(seed)] = true

	_expect(ids.size() >= 2, "small seed set should produce at least two expedition conditions")
	_expect(ExpeditionConditionScript.id_for_seed(8919) == String(first.get("id", "")), "id_for_seed should match condition_for_seed")

func _test_spawn_point_matching() -> void:
	var point := SpawnPointScript.new()
	point.category = "resource"
	point.target_id = "kelp_fiber"
	point.depth_band = "shallow"
	point.cluster_pattern = "cautious"

	_expect(point.matches("resource", "kelp_fiber"), "spawn point should match category and target id")
	_expect(not point.matches("creature", "kelp_fiber"), "spawn point should reject different categories")
	_expect(not point.matches("resource", "glow_plankton"), "spawn point should reject different target ids")
	_expect(point.depth_band == "shallow", "spawn point should preserve authored depth band")
	_expect(point.cluster_pattern == "cautious", "spawn point should preserve authored cluster pattern")
	point.free()

func _test_spawn_selection() -> void:
	var root := Node2D.new()
	var shallow := _make_spawn_point("a", "resource", "kelp_fiber", "shallow", "any", Vector2(10.0, 20.0))
	var cautious := _make_spawn_point("b", "resource", "kelp_fiber", "shallow", "cautious", Vector2(30.0, 40.0))
	var deep_reward := _make_spawn_point("c", "resource", "kelp_fiber", "shallow", "deep_reward", Vector2(50.0, 60.0))
	root.add_child(shallow)
	root.add_child(cautious)
	root.add_child(deep_reward)

	var positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "kelp_fiber", "cautious")
	_expect(positions.size() == 2, "spawn selection should include any and matching cluster points")
	_expect(positions.has(Vector2(10.0, 20.0)), "spawn selection should include any-cluster point")
	_expect(positions.has(Vector2(30.0, 40.0)), "spawn selection should include matching cautious point")
	_expect(not positions.has(Vector2(50.0, 60.0)), "spawn selection should exclude nonmatching cluster point")
	_expect(SpawnSelectionScript.cluster_pattern_for_seed(1, ["cautious", "deep_reward"]) == "deep_reward", "spawn selection should map seeds to cluster patterns deterministically")
	var shell_reef := _make_spawn_point("reef", "resource", "shell_fragments", "midwater", "any", Vector2(70.0, 80.0))
	root.add_child(shell_reef)
	var shell_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward")
	_expect(shell_positions.size() == 1, "shell reef spawn selection should include one authored shell candidate without adding extra pickups")
	_expect(shell_positions.has(Vector2(70.0, 80.0)), "shell reef spawn selection should include any-pattern reef candidate")
	_expect(shell_reef.depth_band == "midwater", "shell reef spawn point should preserve midwater depth identity")

	var vent_glow := _make_spawn_point("vent", "resource", "glow_plankton", "deep", "deep_reward", Vector2(90.0, 100.0))
	root.add_child(vent_glow)
	var vent_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	_expect(vent_positions.size() == 1, "thermal vent pocket candidates should be selectable authored points without adding extra pickups")
	_expect(vent_positions.has(Vector2(90.0, 100.0)), "thermal vent pocket should expose inspectable glow placement")
	_expect(vent_glow.depth_band == "deep", "thermal vent glow candidates should preserve deep resource identity")
	root.free()

func _test_condition_weighted_spawn_selection() -> void:
	var root := Node2D.new()
	var glow_a := _make_spawn_point("glow_a", "resource", "glow_plankton", "deep", "deep_reward", Vector2(10.0, 100.0))
	var glow_b := _make_spawn_point("glow_b", "resource", "glow_plankton", "deep", "deep_reward", Vector2(20.0, 100.0))
	var vent_glow := _make_spawn_point("vent_glow", "resource", "glow_plankton", "deep", "deep_reward", Vector2(30.0, 100.0), "thermal_bloom")
	var shell := _make_spawn_point("shell", "resource", "shell_fragments", "midwater", "deep_reward", Vector2(40.0, 100.0), "thermal_bloom")
	root.add_child(glow_a)
	root.add_child(glow_b)
	root.add_child(vent_glow)
	root.add_child(shell)

	var unweighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward")
	var calm_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "calm_current")
	var thermal_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var thermal_weighted_repeat := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "glow_plankton", "deep_reward", "thermal_bloom")
	var shell_weighted := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward", "thermal_bloom")

	_expect(unweighted.size() == 3, "unweighted glow selection should keep every authored matching candidate")
	_expect(calm_weighted == unweighted, "unaffected conditions should preserve glow selection behavior")
	_expect(thermal_weighted == thermal_weighted_repeat, "thermal bloom weighting should be deterministic for the same inputs")
	_expect(thermal_weighted.size() == 1, "thermal bloom weighting should not add active glow candidates")
	_expect(thermal_weighted.has(Vector2(30.0, 100.0)), "thermal bloom should prefer the authored vent glow candidate")
	_expect(vent_glow.depth_band == "deep", "condition-preferred glow should preserve deep depth-band identity")
	_expect(shell_weighted.size() == 1, "thermal bloom should not broaden non-glow resource selection")
	_expect(shell_weighted.has(Vector2(40.0, 100.0)), "thermal bloom should leave non-glow target positions intact")
	root.free()

func _test_debug_review_helpers() -> void:
	var main := MainScript.new()
	var next_condition := main._debug_next_condition_from_id("calm_current")
	_expect(next_condition.get("id", "") == "kelp_bloom", "debug condition helper should cycle from the current condition")

	var first_condition := main._debug_next_condition_from_id("unknown_condition")
	_expect(first_condition.get("id", "") == "calm_current", "debug condition helper should fall back to the first condition")
	_expect(main._debug_seed_for_delta(8919, 1) == 8920, "debug seed helper should increment review seed")
	_expect(main._debug_seed_for_delta(1, -10) == 1, "debug seed helper should keep review seed positive")
	main.free()

func _test_scanner_target_resolver() -> void:
	var farther_a := _make_scan_target("alpha", "Alpha", Vector2(10.0, 0.0))
	var farther_b := _make_scan_target("beta", "Beta", Vector2(10.0, 0.0))
	var nearest := _make_scan_target("gamma", "Gamma", Vector2(3.0, 0.0))
	var targets: Array[Node] = [farther_b, nearest, farther_a]

	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	_expect(selected == nearest, "scanner resolver should choose the nearest target")
	_expect(ScanTargetResolverScript.target_id(selected) == "gamma", "scanner resolver should expose target discovery id")
	_expect(ScanTargetResolverScript.display_name(selected) == "Gamma", "scanner resolver should expose target display name")

	targets = [farther_b, farther_a]
	selected = ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, targets)
	_expect(selected == farther_a, "scanner resolver should break equal-distance ties by id")
	_expect(ScanTargetResolverScript.nearest(Vector2.ZERO, 2.0, targets) == null, "scanner resolver should ignore targets outside range")
	farther_a.free()
	farther_b.free()
	nearest.free()

func _test_compact_scan_marker() -> void:
	var scannable := ScannableScript.new()
	var marker := Polygon2D.new()
	marker.name = "ScanMarker"
	scannable.add_child(marker)
	scannable._ready()

	_expect(marker.polygon.size() == 8, "compact scan marker should use the standard diamond polygon")
	_expect(marker.polygon == ReadabilityMarkerPatternsScript.scan_marker_polygon(), "compact scan marker should use shared marker pattern data")
	_expect(marker.color.a < 0.3, "compact scan marker should be subtle while idle")
	_expect(scannable.get_node_or_null("ScanFocusBracketA") != null, "compact scan marker should create first focus bracket")
	_expect(scannable.get_node_or_null("ScanFocusBracketB") != null, "compact scan marker should create second focus bracket")

	scannable.set_scan_selected(true)
	_expect(marker.color.a > 0.5, "selected compact scan marker should brighten")
	scannable.free()

func _test_scan_pulse_visual_helper() -> void:
	var idle := ScanPulseVisualScript.idle_modulate()
	var selected := ScanPulseVisualScript.selected_modulate()
	var pulse_a := ScanPulseVisualScript.tactical_highlight_modulate(0)
	var pulse_b := ScanPulseVisualScript.tactical_highlight_modulate(180)

	_expect(idle == Color.WHITE, "scan pulse idle color should be neutral")
	_expect(selected.r > idle.r and selected.g > idle.g, "selected scan pulse color should brighten the pickup")
	_expect(pulse_a != pulse_b, "tactical highlight should pulse instead of becoming a static marker")
	_expect(pulse_a.a == 1.0 and pulse_b.a == 1.0, "tactical highlight should stay a local modulate, not a hidden marker")

func _test_sprite_ready_scene_asset_slots() -> void:
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
		"RareSignalEmphasis/SoftPingWash",
		"RareSignalEmphasis/BrokenEchoArc",
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
		_expect(main.get_node_or_null(path) != null, "main scene should keep sprite-ready slot or behavior node: %s" % path)

	var moonpool_sprite := main.get_node("SurfaceBaseArt/MoonpoolGuide/MoonpoolWaterlineSprite") as Sprite2D
	_expect(moonpool_sprite.texture != null, "Surface moonpool/waterline should use the first exported source asset sprite")

	var shallow_midwater_background := main.get_node("ShallowMidwaterBackgroundStudy") as Sprite2D
	_expect(shallow_midwater_background.texture != null, "Shallow/midwater background study should use its exported source asset")
	_expect(shallow_midwater_background.modulate.a <= 0.5, "Shallow/midwater background study should stay subdued behind gameplay cues")

	var glow_sprite := main.get_node("ResourcePickups/GlowPlankton/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var glow_fallback := main.get_node("ResourcePickups/GlowPlankton/Visuals/FallbackVisual") as Node2D
	_expect(glow_sprite.texture != null, "Glow Plankton should use the first exported source asset sprite")
	_expect(not glow_fallback.visible, "Glow Plankton polygon fallback should be hidden while the sprite asset is active")

	var kelp_sprite := main.get_node("ResourcePickups/KelpFiber/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var kelp_fallback := main.get_node("ResourcePickups/KelpFiber/Visuals/FallbackVisual") as Node2D
	_expect(kelp_sprite.texture != null, "Kelp Fiber should use the first exported source asset sprite")
	_expect(not kelp_fallback.visible, "Kelp Fiber polygon fallback should be hidden while the sprite asset is active")

	var shell_sprite := main.get_node("ResourcePickups/ShellFragments/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_fallback := main.get_node("ResourcePickups/ShellFragments/Visuals/FallbackVisual") as Node2D
	_expect(shell_sprite.texture != null, "Shell Fragments should use the first exported source asset sprite")
	_expect(not shell_fallback.visible, "Shell Fragments polygon fallback should be hidden while the sprite asset is active")

	var lantern_sprite := main.get_node("Creatures/LanternFry/SpriteAnchor/Sprite") as Sprite2D
	var lantern_body_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Visual") as Polygon2D
	var lantern_glow_fallback := main.get_node("Creatures/LanternFry/FallbackVisual/Glow") as Polygon2D
	_expect(lantern_sprite.texture != null, "Lantern Fry should use the first exported source asset sprite")
	_expect(not lantern_body_fallback.visible, "Lantern Fry body polygon should be hidden while the sprite asset is active")
	_expect(lantern_glow_fallback.visible, "Lantern Fry glow fallback should remain available for visual-only idle pulsing")

	var gulper_sprite := main.get_node("Predators/GulperEel/SpriteAnchor/Sprite") as Sprite2D
	var gulper_body_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Body") as Polygon2D
	var gulper_eye_overlay := main.get_node("Predators/GulperEel/FallbackVisual/Eye") as Polygon2D
	_expect(gulper_sprite.texture != null, "Gulper Eel should use the first exported source asset sprite")
	_expect(gulper_body_overlay.visible, "Gulper Eel fallback body should remain available for state tint overlays")
	_expect(gulper_eye_overlay.visible, "Gulper Eel fallback eye should remain available for warning/chase state overlays")

	var thermal_vent_sprite := main.get_node("Discoveries/ThermalVent/SpriteAnchor/Sprite") as Sprite2D
	var thermal_vent_fallback := main.get_node("Discoveries/ThermalVent/FallbackVisual/Visual") as Polygon2D
	var thermal_vent_bubbles := main.get_node("Discoveries/ThermalVent/FallbackVisual/Bubbles") as Polygon2D
	_expect(thermal_vent_sprite.texture != null, "Thermal Vent should use the first exported source asset sprite")
	_expect(thermal_vent_fallback.visible, "Thermal Vent fallback geometry should remain available for optional route readability")
	_expect(thermal_vent_bubbles.visible, "Thermal Vent bubbles should remain available for condition/readability visuals")

	var shell_reef_pocket_sprite := main.get_node("ShellReefPocket/Visuals/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_pocket_fallback := main.get_node("ShellReefPocket/Visuals/FallbackGeometry/ReefShelf") as Polygon2D
	_expect(shell_reef_pocket_sprite.texture != null, "Shell Reef pocket should use the first exported source landmark asset")
	_expect(shell_reef_pocket_fallback.visible, "Shell Reef pocket fallback geometry should remain available for route readability")

	var shell_reef_shelf_sprite := main.get_node("Discoveries/ShellReefShelf/SpriteAnchor/Sprite") as Sprite2D
	var shell_reef_shelf_fallback := main.get_node("Discoveries/ShellReefShelf/FallbackVisual/Visual") as Polygon2D
	_expect(shell_reef_shelf_sprite.texture != null, "Shell Reef Shelf scan target should use the first exported source asset sprite")
	_expect(shell_reef_shelf_fallback.visible, "Shell Reef Shelf fallback should remain available for scan clue readability")

	var wreck_cache_sprite := main.get_node("PressureLockedWreck/WreckSignalCache/SpriteAnchor/Sprite") as Sprite2D
	var wreck_cache_fallback := main.get_node("PressureLockedWreck/WreckSignalCache/FallbackVisual/CacheVisual") as Polygon2D
	var wreck_cache_echo_pulse := main.get_node("PressureLockedWreck/WreckSignalCache/EchoPulse") as Sprite2D
	_expect(wreck_cache_sprite.texture != null, "Wreck Signal Cache should use the first exported source asset sprite")
	_expect(wreck_cache_fallback.visible, "Wreck Signal Cache fallback glow should remain available for scan/mystery readability")
	_expect(wreck_cache_echo_pulse.texture != null, "Wreck Signal Cache should have the scan/echo pulse sprite available for Echo Lens I")
	_expect(not wreck_cache_echo_pulse.visible, "Echo Lens I pulse should start hidden so it reads as temporary local feedback")

	var pressure_wreck_scan_sprite := main.get_node("PressureLockedWreck/OuterScan/SpriteAnchor/Sprite") as Sprite2D
	var pressure_wreck_scan_fallback := main.get_node("PressureLockedWreck/OuterScan/FallbackVisual/ScanVisual") as Polygon2D
	_expect(pressure_wreck_scan_sprite.texture != null, "Pressure-Locked Research Wreck outside scan should use the first exported source asset sprite")
	_expect(pressure_wreck_scan_fallback.visible, "Pressure-Locked Research Wreck outside scan fallback should remain available for pressure clue readability")

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
		_expect(player.get_node_or_null(path) != null, "player scene should keep sprite-ready visual slot or fallback node: %s" % path)

	player.free()

func _test_landmark_region_identity_metadata() -> void:
	var main := MainScene.instantiate()
	var metadata_root := main.get_node("LandmarkMetadata")
	var expected_regions := {
		"SurfaceBase": "Surface Base",
		"ShellReef": "Shell Reef",
		"ThermalVentField": "Thermal Vent Field",
		"WreckShelf": "Wreck Shelf",
		"PressureLockedWreck": "Wreck Shelf",
		"GulperRoute": "Gulper Route",
	}

	for node_name in expected_regions.keys():
		var landmark := metadata_root.get_node(node_name)
		_expect(String(landmark.get("stable_region_name")) == expected_regions[node_name], "landmark should expose stable region name: %s" % node_name)
		_expect(not String(landmark.get("memory_goal")).is_empty(), "landmark should describe its player memory goal: %s" % node_name)

	main.free()

func _test_predator_scan_target() -> void:
	var predator := PredatorScript.new()
	predator.discovery_id = "gulper_eel"
	predator.display_name = "Gulper Eel"
	predator.description = "Predator profile."
	predator.global_position = Vector2(12.0, 0.0)

	_expect(ScanTargetResolverScript.is_valid_target(predator), "visible predator with discovery id should be a scan target")
	_expect(ScanTargetResolverScript.target_id(predator) == "gulper_eel", "predator scan target should expose discovery id")
	_expect(ScanTargetResolverScript.display_name(predator) == "Gulper Eel", "predator scan target should expose display name")
	var selected := ScanTargetResolverScript.nearest(Vector2.ZERO, 20.0, [predator])
	_expect(selected == predator, "scanner resolver should select the predator when it is in range")

	predator.visible = false
	_expect(not ScanTargetResolverScript.is_valid_target(predator), "hidden predator should not be a valid scan target")
	predator.free()

func _test_discovery_prerequisites() -> void:
	var progression := ProgressionStateScript.new()

	_expect(OxygenTankUpgrade.required_discovery.is_empty(), "Oxygen Tank I should not require a discovery")
	_expect(PressureSealUpgrade.required_discovery == "thermal_vent", "Pressure Seal I should require Thermal Vent")
	_expect(SignalLensUpgrade.required_discovery == "wreck_signal_cache", "Signal Lens I should require Wreck Signal Cache")
	_expect(EchoLensUpgrade.required_discovery == "wreck_signal_cache", "Echo Lens I should require Wreck Signal Cache")
	_expect(EchoLensUpgrade.required_upgrade == SignalLensUpgrade.id, "Echo Lens I should require Signal Lens I")
	_expect(EchoLensUpgrade.effect_id == "echo_lens_wreck_echo", "Echo Lens I should use the broad wreck echo effect id")
	_expect(int(EchoLensUpgrade.resource_cost.get("glow_plankton", 0)) == 3, "Echo Lens I should cost three glow plankton")
	_expect(int(EchoLensUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Echo Lens I should cost one kelp fiber")
	_expect(int(EchoLensUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Echo Lens I should cost two shell fragments")
	_expect(CargoRackUpgrade.required_discovery.is_empty(), "Cargo Rack I should not require a discovery")
	_expect(CargoRackUpgrade.effect_id == "cargo_limit_4", "Cargo Rack I should use cargo limit effect")
	_expect(PredatorWarningUpgrade.required_discovery == "gulper_eel", "Predator Warning I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_discovery == "gulper_eel", "Decoy Pulse I should require Gulper Eel")
	_expect(DecoyPulseUpgrade.required_upgrade == PredatorWarningUpgrade.id, "Decoy Pulse I should require Predator Warning I")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("glow_plankton", 0)) == 2, "Decoy Pulse I should cost two glow plankton")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Decoy Pulse I should cost one kelp fiber")
	_expect(int(DecoyPulseUpgrade.resource_cost.get("shell_fragments", 0)) == 1, "Decoy Pulse I should cost one shell fragment")
	_expect(UpgradePurchaseScript.missing_discovery(progression, OxygenTankUpgrade) == "", "upgrade with no prerequisite should not be locked")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "thermal_vent", "Pressure Seal I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "wreck_signal_cache", "Signal Lens I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "wreck_signal_cache", "Echo Lens I discovery prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == SignalLensUpgrade.id, "Echo Lens I upgrade prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, CargoRackUpgrade) == "", "Cargo Rack I prerequisite should be satisfied by default")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "gulper_eel", "Predator Warning I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == PredatorWarningUpgrade.id, "Decoy Pulse I upgrade prerequisite should start missing")
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "", "Pressure Seal I prerequisite should be satisfied by Thermal Vent discovery")
	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "", "Signal Lens I prerequisite should be satisfied by Wreck Signal Cache discovery")
	_expect(UpgradePurchaseScript.missing_discovery(progression, EchoLensUpgrade) == "", "Echo Lens I discovery prerequisite should be satisfied by Wreck Signal Cache discovery")
	_expect(not UpgradePurchaseScript.purchase(progression, EchoLensUpgrade), "Echo Lens I should not purchase before Signal Lens I")
	progression.purchased_upgrades[SignalLensUpgrade.id] = true
	_expect(UpgradePurchaseScript.missing_upgrade(progression, EchoLensUpgrade) == "", "Echo Lens I upgrade prerequisite should be satisfied by Signal Lens I")
	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PredatorWarningUpgrade) == "", "Predator Warning I prerequisite should be satisfied by Gulper Eel discovery")
	_expect(UpgradePurchaseScript.missing_discovery(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I discovery prerequisite should be satisfied by Gulper Eel discovery")
	_expect(not UpgradePurchaseScript.purchase(progression, DecoyPulseUpgrade), "Decoy Pulse I should not purchase before Predator Warning I")
	progression.purchased_upgrades[PredatorWarningUpgrade.id] = true
	_expect(UpgradePurchaseScript.missing_upgrade(progression, DecoyPulseUpgrade) == "", "Decoy Pulse I upgrade prerequisite should be satisfied by Predator Warning I")

func _test_predator_warning_upgrade_metadata() -> void:
	_expect(PredatorWarningUpgrade.id == "predator_warning_1", "Predator Warning I should have a stable upgrade id")
	_expect(PredatorWarningUpgrade.effect_id == "predator_warning_range_1", "Predator Warning I should use the warning range effect")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("kelp_fiber", 0)) == 1, "Predator Warning I should cost one kelp fiber")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("shell_fragments", 0)) == 2, "Predator Warning I should cost two shell fragments")
	_expect(int(PredatorWarningUpgrade.resource_cost.get("glow_plankton", 0)) == 1, "Predator Warning I should cost one glow plankton")

	var predator := PredatorScript.new()
	predator.detect_radius = 100.0
	_expect(is_equal_approx(predator.warning_radius(), 145.0), "default predator warning radius should stay at the original lead distance")
	predator.set_warning_radius_multiplier(1.8)
	_expect(is_equal_approx(predator.warning_radius(), 180.0), "Predator Warning I should widen only the warning radius")
	_expect(is_equal_approx(predator.detect_radius, 100.0), "Predator Warning I should not change chase detection radius")
	predator.free()

func _test_predator_warning_effect_isolation() -> void:
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

	_expect(main._current_max_oxygen() == 30.0, "Predator Warning I should not apply Oxygen Tank I max oxygen")
	_expect(main._current_cargo_limit() == 3, "Predator Warning I should not apply Cargo Rack I capacity")
	_expect(main.dive_session.cargo_limit == 3, "Predator Warning I should not mutate current dive cargo capacity")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Predator Warning I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Predator Warning I should not grant Signal Lens I")
	main.free()

func _test_decoy_pulse_effect_isolation() -> void:
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

	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Decoy Pulse I purchase should not change dive result state")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Decoy Pulse I purchase should not change carried cargo")
	_expect(main.dive_session.cargo_limit == 3, "Decoy Pulse I purchase should not change cargo capacity")
	_expect(main.run_predator_contacts == 0, "Decoy Pulse I purchase should not create predator contact")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Decoy Pulse I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(SignalLensUpgrade.id), "Decoy Pulse I should not grant Signal Lens I")
	main.free()

func _test_echo_lens_effect_isolation() -> void:
	var main := MainScript.new()
	main.dive_session.reset(30.0)
	main.dive_session.current_cargo = ["kelp_fiber"]
	main.progression_state.purchased_upgrades = {
		SignalLensUpgrade.id: true,
		EchoLensUpgrade.id: true,
	}

	main._apply_upgrade_effect(EchoLensUpgrade.effect_id)

	_expect(main.dive_session.result == DiveSessionScript.Result.READY, "Echo Lens I purchase should not change dive result state")
	_expect(main.dive_session.current_cargo == ["kelp_fiber"], "Echo Lens I purchase should not change carried cargo")
	_expect(not main.progression_state.has_upgrade(PressureSealUpgrade.id), "Echo Lens I should not grant Pressure Seal I")
	_expect(not main.progression_state.has_upgrade(DecoyPulseUpgrade.id), "Echo Lens I should not grant Decoy Pulse I")
	main.free()

func _test_expedition_prep_goals() -> void:
	var upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]
	var progression := ProgressionStateScript.new()

	var goal := ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Oxygen Tank I"), "fresh prep goal should point at Oxygen Tank I")
	_expect(goal.contains("Kelp Fiber x2"), "fresh prep goal should list missing oxygen tank kelp")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal == "Goal: buy Oxygen Tank I in the upgrade bay after this dive.", "affordable prep goal should point to purchase")

	progression.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Thermal Vent"), "locked pressure seal goal should point at Thermal Vent")
	_expect(goal.contains("Pressure Seal I"), "locked pressure seal goal should name the upgrade")

	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("bank"), "unlocked pressure seal goal should point back to banking")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PressureSealUpgrade.id, PressureSealUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Wreck Signal Cache"), "locked signal lens goal should point at Wreck Signal Cache")

	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(SignalLensUpgrade.id, SignalLensUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Cargo Rack I"), "signal lens ownership should advance goal to Cargo Rack I")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(CargoRackUpgrade.id, CargoRackUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("scan Gulper Eel"), "cargo rack ownership should advance goal to Predator Warning I scan prerequisite")

	progression.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Predator Warning I"), "gulper observation should advance goal to Predator Warning I resources")

	progression.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	progression.purchase_upgrade(PredatorWarningUpgrade.id, PredatorWarningUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal.contains("Decoy Pulse I"), "predator warning ownership should advance goal to Decoy Pulse I")
	_expect(goal.contains("Glow Plankton x2"), "decoy prep goal should show missing planned glow cost")

	progression.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	progression.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	goal = ExpeditionGoalFormatterScript.format_goal(progression, upgrades)
	_expect(goal == "Goal: use Shell Reef to bank Shell Fragments, or push deeper if oxygen allows.", "completed upgrade goals should fall back to the Shell Reef route objective")

func _test_result_progress_callouts() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
		DecoyPulseUpgrade,
	]

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	_expect(main._format_upgrade_progress_callout() == "Upgrade progress: Oxygen Tank I ready to buy.", "result progress should call out ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	_expect(main._format_upgrade_progress_callout().contains("scan Thermal Vent"), "result progress should call out missing scan prerequisites")

	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache"]
	_expect(main._format_scan_progress_callout("Scans kept") == "Scans kept: Thermal Vent, Wreck Signal Cache.", "result progress should name scans kept this dive")

	main.run_completed_scans.clear()
	_expect(main._format_scan_progress_callout("Discoveries recorded") == "Discoveries recorded: none this dive.", "result progress should stay explicit when no scans were recorded")
	main.free()

func _test_extraction_banking_result_copy() -> void:
	var main := MainScript.new()

	var cargo: Array[String] = ["kelp_fiber"]
	_expect(main._format_extraction_banking_line(1, cargo).contains("Banked 1 resource"), "cargo extraction should keep resource banking copy")
	_expect(main._format_extraction_banking_line(1, cargo).contains("Kelp Fiber x1"), "cargo extraction should keep resource counts")

	main.run_completed_scans = ["thermal_vent"]
	var scan_only := main._format_extraction_banking_line(0, [])
	_expect(scan_only.contains("Banked 0 resources"), "scan-only extraction should not imply phantom cargo")
	_expect(scan_only.contains("scan data came home"), "scan-only extraction should read as useful")

	main.run_completed_scans.clear()
	var empty_return := main._format_extraction_banking_line(0, [])
	_expect(empty_return.contains("No cargo or new scans"), "empty extraction should remain clearly low-value")
	main.free()

func _test_next_expedition_framing() -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 3

	var prompt := main._format_next_expedition_prompt()
	_expect(prompt.contains("Expedition 4"), "result prompt should point to the next expedition number")
	_expect(prompt.contains("ocean shifts again"), "result prompt should frame restart as a changed ocean")
	_expect(not prompt.to_lower().contains("restart"), "result prompt should avoid raw restart language")

	main.progression_state.current_run_number = 4
	var ready_status := main._format_expedition_ready_status()
	_expect(ready_status.contains("Expedition 4 ready"), "ready status should name the prepared expedition")
	_expect(ready_status.contains("ocean changed"), "ready status should describe the changed ocean")
	_expect(main._format_expedition_day_title("Ready") == "Expedition Day 4 Ready", "ready title should show expedition day number")
	_expect(main._format_expedition_day_title("Result: Extraction") == "Expedition Day 4 Result: Extraction", "result title should show completed expedition day number")
	_expect(main._format_completed_expedition_line("Failure") == "Expedition Day 4: Failure.", "result summary should name the completed expedition day")
	main.free()

func _test_region_memory_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_region_memory_callout().contains("Surface Base"), "region memory fallback should preserve safe return framing")

	main.run_collected_resources = ["shell_fragments"]
	_expect(main._format_region_memory_callout().contains("Shell Reef"), "shell cargo should remember Shell Reef")

	main.run_completed_scans = ["thermal_vent"]
	_expect(main._format_region_memory_callout().contains("Thermal Vent Field"), "thermal scan should remember Thermal Vent Field over shell cargo")

	main.run_completed_scans = ["pressure_wreck_signal"]
	_expect(main._format_region_memory_callout().contains("Wreck Shelf"), "pressure wreck scan should remember Wreck Shelf")

	main.run_predator_contacts = 1
	_expect(main._format_region_memory_callout().contains("Gulper Route"), "predator evidence should remember Gulper Route as the deepest contested place")
	_expect(not main._format_region_memory_callout().contains(","), "region memory callout should stay compact and not become a checklist")
	main.free()

func _test_discovery_memory_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_discovery_memory_callout() == "", "discovery memory should stay hidden when no first-time major discovery happened")

	main.run_completed_scans = ["shell_reef_shelf"]
	_expect(main._format_discovery_memory_callout().contains("Shell Reef Shelf"), "shell reef first scan should produce discovery memory")

	main.run_completed_scans = ["shell_reef_shelf", "thermal_vent"]
	_expect(main._format_discovery_memory_callout().contains("Thermal Vent"), "thermal first scan should take priority over shell reef")

	main.run_completed_scans = ["thermal_vent", "gulper_eel"]
	_expect(main._format_discovery_memory_callout().contains("Gulper Eel"), "gulper first scan should produce creature research memory")

	main.run_completed_scans = ["pressure_wreck_signal", "wreck_signal_cache", "wreck_signal_cache"]
	var memory := main._format_discovery_memory_callout()
	_expect(memory.contains("Wreck Signal Cache"), "cache first scan should take priority over outside wreck signal")
	_expect(memory.find("Wreck Signal Cache") == memory.rfind("Wreck Signal Cache"), "discovery memory should not duplicate repeated ids")
	_expect(not memory.contains(","), "discovery memory should stay compact and not become a checklist")
	main.free()

func _test_route_choice_result_callout() -> void:
	var main := MainScript.new()

	main.run_collected_resources = ["shell_fragments"]
	_expect(main._format_route_choice_callout().contains("Shell Reef"), "shell cargo should produce a reef banking callout")

	main.current_resource_cluster_pattern = "deep_reward"
	main.run_collected_resources = ["glow_plankton"]
	_expect(main._format_route_choice_callout().contains("deep glow"), "deep reward glow cargo should produce a deep push callout")

	main.run_completed_scans = ["wreck_signal_cache"]
	_expect(main._format_route_choice_callout().contains("pressure-wreck progress"), "wreck cache scan should produce a pressure progress callout")

	main.run_predator_contacts = 1
	_expect(main._format_route_choice_callout().contains("predator route"), "predator contact should take priority in the route callout")

	main.run_predator_contacts = 0
	main.run_completed_scans = ["thermal_vent"]
	main.run_collected_resources = []
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	_expect(main._format_route_choice_callout().contains("Pressure Seal I"), "thermal vent scan should produce a pressure seal route callout")

	main.run_collected_resources = ["glow_plankton"]
	_expect(main._format_route_choice_callout().contains("Thermal Vent clue"), "vent scan plus glow cargo should produce a vent route callout")

	var summary := main._format_run_summary("%s\nCompact result line." % main._format_route_choice_callout(), "extracted")
	_expect(summary.contains("Route choice:"), "player-facing result summary should include the route callout")
	_expect(not summary.contains("Playtest data:"), "result summary should not include debug telemetry unless F3 is enabled")
	_expect(not summary.contains("Predator route:"), "predator route telemetry should stay hidden unless F3 is enabled")
	_expect(not summary.contains("thermal_bloom"), "condition id should stay hidden unless debug telemetry is enabled")

	main.show_debug_telemetry = true
	summary = main._format_run_summary(main._format_route_choice_callout(), "extracted")
	_expect(summary.contains("Playtest data:"), "debug telemetry should appear only when enabled")
	_expect(summary.contains("Condition: Thermal Bloom (thermal_bloom)"), "debug telemetry should include condition display and id")
	main.free()

func _test_gulper_research_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_gulper_research_callout() == "", "Gulper research should stay hidden without evidence")

	main.run_completed_scans = ["gulper_eel"]
	_expect(main._format_gulper_research_callout().contains("Gulper route timing observed"), "Gulper scan should produce a research callout")
	var summary := main._format_run_summary("%s%s" % [main._format_route_choice_callout(), main._format_gulper_research_callout()], "extracted")
	_expect(summary.contains("Research:"), "player-facing summary should include compact creature research when relevant")
	_expect(not summary.contains("Playtest data:"), "creature research should not expose debug telemetry")

	main.run_predator_contacts = 1
	_expect(main._format_gulper_research_callout().contains("warning lane"), "Gulper contact should take priority over scan research")

	main.decoy_pulse_used_this_run = true
	_expect(main._format_gulper_research_callout().contains("Decoy timing"), "Decoy evidence should take priority as a stronger research result")
	main.free()

func _test_echo_lens_result_callout() -> void:
	var main := MainScript.new()

	_expect(main._format_echo_lens_research_callout() == "", "Echo Lens result line should stay hidden until an echo fires")
	main.run_echo_lens_echo_fired = true
	var callout := main._format_echo_lens_research_callout()
	_expect(callout.contains("Echo Lens"), "Echo Lens result line should name the scanner upgrade")
	_expect(callout.contains("weak wreck echo below the shelf"), "Echo Lens result line should preserve the broad local echo memory")
	_expect_no_echo_lens_locator_language(callout, "Echo Lens result line")
	var summary := main._format_run_summary("%s%s" % [main._format_route_choice_callout(), callout], "extracted")
	_expect(summary.contains("Research:"), "Echo Lens result line should appear as compact research memory")
	_expect(not summary.contains("Playtest data:"), "Echo Lens result line should not expose debug telemetry")
	main.free()

func _test_upgrade_bay_readability_states() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		EchoLensUpgrade,
		CargoRackUpgrade,
		PredatorWarningUpgrade,
	]

	var state := main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Missing resources"), "upgrade bay should label unaffordable upgrades")
	_expect(state.contains("Needs: Glow Plankton x1"), "upgrade bay should show missing resources inline")

	main.progression_state.banked_resources = {
		"glow_plankton": 1,
		"kelp_fiber": 2,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Available now"), "upgrade bay should label affordable upgrades")
	_expect(main._format_ready_upgrade_callout().contains("Oxygen Tank I"), "upgrade bay should call out newly ready upgrades")

	main.progression_state.purchase_upgrade(OxygenTankUpgrade.id, OxygenTankUpgrade.resource_cost)
	state = main._format_upgrade_state(OxygenTankUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label owned upgrades")

	state = main._format_upgrade_state(PressureSealUpgrade)
	_expect(state.begins_with("State: Locked by scan"), "upgrade bay should label scan-locked upgrades")
	_expect(state.contains("Needs scan: Thermal Vent"), "upgrade bay should name missing discoveries")

	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Locked by scan"), "upgrade bay should label Echo Lens I scan-locked before Wreck Signal Cache")
	_expect(state.contains("Role: broad wreck echoes, not material pings."), "Echo Lens I state should distinguish it from Signal Lens I without a tutorial wall")

	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks scanner tuning.")
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label Echo Lens I as upgrade-locked before Signal Lens I")
	_expect(state.contains("Needs upgrade: Signal Lens I"), "upgrade bay should name Signal Lens I as the Echo Lens prerequisite")
	_expect(state.contains("Role: broad wreck echoes, not material pings."), "Echo Lens I locked-upgrade state should keep its compact role hint")

	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Missing resources"), "upgrade bay should label Echo Lens I missing resources after prerequisites are met")
	_expect(state.contains("Needs: Glow Plankton x1"), "Echo Lens I missing-resource state should show only remaining cost")
	_expect(state.contains("Role: broad wreck echoes, not material pings."), "Echo Lens I missing-resource state should keep its compact role hint")

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Available now"), "upgrade bay should label Echo Lens I available after prerequisites and resources are ready")
	_expect(state.contains("Role: broad wreck echoes, not material pings."), "Echo Lens I available state should keep its compact role hint")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	state = main._format_upgrade_state(EchoLensUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label Echo Lens I owned after purchase")
	_expect(state.contains("Role: broad wreck echoes, not material pings."), "Echo Lens I owned state should keep its compact role hint")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Locked by upgrade"), "upgrade bay should label upgrade-locked upgrades")
	_expect(state.contains("Needs upgrade: Predator Warning I"), "upgrade bay should name missing upgrade prerequisites")

	main.progression_state.purchased_upgrades[PredatorWarningUpgrade.id] = true
	main.progression_state.banked_resources = {
		"glow_plankton": 2,
		"kelp_fiber": 1,
		"shell_fragments": 1,
	}
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Available now"), "Decoy Pulse I should become available after discovery, prerequisite upgrade, and resources")

	main.progression_state.purchase_upgrade(DecoyPulseUpgrade.id, DecoyPulseUpgrade.resource_cost)
	state = main._format_upgrade_state(DecoyPulseUpgrade)
	_expect(state.begins_with("State: Owned"), "upgrade bay should label Decoy Pulse I owned after purchase")
	main.free()

func _test_result_and_upgrade_copy_length_guards() -> void:
	var main := MainScript.new()
	main.progression_state.current_run_number = 4
	main.progression_state.current_run_seed = 32676
	main.current_resource_cluster_pattern = "deep_reward"
	main.current_predator_route_id = "lower_predator_gate"
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs.",
	}
	main.run_collected_resources = ["glow_plankton", "shell_fragments", "kelp_fiber"]
	main.run_completed_scans = ["thermal_vent", "wreck_signal_cache", "gulper_eel"]
	main.run_predator_contacts = 1
	main.run_echo_lens_echo_fired = true
	main.decoy_pulse_used_this_run = true

	var compact_result := "\n".join([
		main._format_completed_expedition_line("Extraction"),
		main._format_extraction_banking_line(3, main.run_collected_resources),
		main._format_region_memory_callout(),
		main._format_discovery_memory_callout(),
		main._format_route_choice_callout(),
		main._format_gulper_research_callout(),
		main._format_echo_lens_research_callout(),
		main._format_upgrade_progress_callout(),
		main._format_scan_progress_callout("Discoveries recorded"),
		main._format_next_expedition_prompt(),
	])
	_expect_lines_within(compact_result, 96, "player-facing result summary")
	_expect(not main._format_run_summary(compact_result, "Extraction").contains("Playtest data:"), "result copy length guard should keep debug telemetry gated")

	main.show_debug_telemetry = true
	_expect(main._format_run_summary(compact_result, "Extraction").contains("Playtest data:"), "debug telemetry should remain opt-in for long result checks")
	main.show_debug_telemetry = false

	main.progression_state.banked_resources = {
		"glow_plankton": 3,
		"kelp_fiber": 1,
		"shell_fragments": 2,
	}
	main.progression_state.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal cache.", "Scanner curiosity.")
	var upgrade_states := [
		main._format_upgrade_state(OxygenTankUpgrade),
		main._format_upgrade_state(PressureSealUpgrade),
		main._format_upgrade_state(EchoLensUpgrade),
	]
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	upgrade_states.append(main._format_upgrade_state(EchoLensUpgrade))
	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	upgrade_states.append(main._format_upgrade_state(EchoLensUpgrade))
	for index in range(upgrade_states.size()):
		_expect_lines_within(String(upgrade_states[index]), 88, "upgrade state %d" % index)

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	for label_path in [
		"HUD/UpgradePanel/UpgradeMenuItem",
		"HUD/UpgradePanel/UpgradeMenuCost",
		"HUD/UpgradePanel/UpgradeMenuState",
		"HUD/UpgradePanel/UpgradeMenuFeedback",
	]:
		var label: Label = main_scene.get_node(label_path)
		_expect(label.autowrap_mode != TextServer.AUTOWRAP_OFF, "%s should keep wrapping enabled" % label_path)
	main_scene.queue_free()
	main.free()

func _test_recent_expedition_log() -> void:
	var main := MainScript.new()
	main.current_resource_cluster_pattern = "cautious"

	for run_number in range(1, 5):
		main.progression_state.current_run_number = run_number
		main.progression_state.current_run_seed = 1000 + run_number
		main.progression_state.best_depth_reached = 10.0 * run_number
		main.run_completed_scans.clear()
		if run_number % 2 == 0:
			main.run_completed_scans.append("thermal_vent")
		main.run_predator_contacts = run_number - 1
		main._record_recent_expedition("Extracted", run_number)

	_expect(main.recent_expedition_log.size() == 3, "recent expedition log should keep only the latest three entries")
	var log_text := main._format_recent_expedition_log()
	_expect(not log_text.contains("#1"), "recent expedition log should drop the oldest entry")
	_expect(log_text.contains("#2 Extracted"), "recent expedition log should include the oldest retained entry")
	_expect(log_text.contains("scans Thermal Vent"), "recent expedition log should show readable scan names")
	_expect(log_text.contains("contacts 3"), "recent expedition log should show predator contacts")
	_expect(not log_text.contains("seed"), "recent expedition log should hide seed by default")

	main.show_debug_telemetry = true
	log_text = main._format_recent_expedition_log()
	_expect(log_text.contains("seed 1004"), "recent expedition log should show seed only with debug telemetry")
	_expect(log_text.contains("Cautious shallows"), "recent expedition log should show pattern only with debug telemetry")
	main.free()

func _test_thermal_vent_scan_clue_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "thermal_vent"
	target.display_name = "Thermal Vent"
	target.description = "Warm current."

	var first_guidance := main._format_first_scan_guidance(target)
	_expect(first_guidance.contains("Warm current"), "thermal vent first scan should name the warm-current clue")
	_expect(first_guidance.contains("optional glow"), "thermal vent first scan should keep glow route optional")
	_expect(first_guidance.contains("Pressure Seal clue"), "thermal vent first scan should explain pressure-seal knowledge")
	_expect(main._format_repeat_scan_effect_text(target).contains("glow route optional"), "thermal vent repeat scan should stay concise and optional")
	target.free()
	main.free()

func _test_shell_reef_scan_clue_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "shell_reef_shelf"
	target.display_name = "Shell Reef Shelf"
	target.description = "Reef shelf."

	_expect(main._format_discovery_name("shell_reef_shelf") == "Shell Reef Shelf", "shell reef discovery should have a readable name")
	_expect(main._format_repeat_scan_effect_text(target).contains("Reef route clue refreshed"), "shell reef repeat scan should give compact feedback")
	_expect(main._format_first_scan_guidance(target).contains("midwater bank route"), "shell reef first scan should explain the route decision")
	_expect(main._format_scan_target_type(target) == "environment", "shell reef scan target should be environmental metadata")
	target.free()
	main.free()

func _test_wreck_signal_cache_repeat_scan_hint() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "wreck_signal_cache"
	target.display_name = "Wreck Signal Cache"
	target.description = "Cache ping."

	_expect(main._format_repeat_scan_effect_text(target).contains("Signal Lens I"), "cache repeat scan before Signal Lens I should refresh the current upgrade clue")
	main.progression_state.purchased_upgrades[SignalLensUpgrade.id] = true
	_expect(main._format_wreck_cache_repeat_hint().contains("Cache echo unresolved"), "cache repeat helper should name the unresolved echo")
	var repeat_hint := main._format_repeat_scan_effect_text(target)
	_expect(repeat_hint.contains("Echo Lens"), "cache repeat scan after Signal Lens I should hint at future echo-lens study")
	_expect(repeat_hint.contains("deeper wreck signals"), "cache repeat scan should imply unresolved wreck signals without exact coordinates")
	_expect(not repeat_hint.to_lower().contains("map"), "cache repeat scan should not introduce map UI language")

	main.progression_state.purchased_upgrades[EchoLensUpgrade.id] = true
	repeat_hint = main._format_repeat_scan_effect_text(target)
	_expect(repeat_hint.contains("Echo Lens: weak wreck echo lingers below the shelf"), "Echo Lens I should turn the cache hint into a broad local wreck echo")
	_expect_no_echo_lens_locator_language(repeat_hint, "Echo Lens I repeat scan echo")
	_expect(main._format_signal_lens_pulse_text(target) == "", "Wreck Signal Cache repeat hint should not reuse resource pulse behavior")
	target.free()
	main.free()

func _test_pressure_lock_guidance_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "pressure_wreck_signal"
	target.display_name = "Pressure-Locked Research Wreck"
	target.description = "Pressure lock."

	var locked_guidance := main._format_first_scan_guidance(target)
	_expect(locked_guidance.contains("Locked"), "pressure lock guidance should first say the route is blocked")
	_expect(locked_guidance.contains("buy Pressure Seal I"), "pressure lock guidance should name the surface upgrade step")
	_expect(locked_guidance.contains("then return"), "pressure lock guidance should explain the return loop")

	main.progression_state.purchased_upgrades[PressureSealUpgrade.id] = true
	var open_guidance := main._format_first_scan_guidance(target)
	_expect(open_guidance.contains("if oxygen allows"), "open pressure route guidance should invite entry only if oxygen allows")
	_expect(open_guidance.contains("scan cache"), "open pressure route guidance should name the cache payoff")
	target.free()
	main.free()

func _test_surface_summary_tabs() -> void:
	var main := MainScript.new()

	var ready_summary := main._format_ready_panel_summary()
	_expect(ready_summary.contains("E/Enter begins."), "ready panel should keep the start action visible")
	_expect(not ready_summary.contains("F9"), "ready panel should hide prototype reset copy when debug telemetry is off")
	main.show_debug_telemetry = true
	_expect(main._format_ready_panel_summary().contains("F9 resets prototype save"), "ready panel may expose reset copy when debug telemetry is on")
	main.show_debug_telemetry = false

	_expect(not main._surface_tabs_enabled(), "surface tabs should be hidden before extraction")
	main.dive_session.extract()
	_expect(main._surface_tabs_enabled(), "surface tabs should be available after extraction")
	_expect(main._format_surface_tabs() == "[Result]  Upgrades  Log", "surface tabs should mark the result view by default")
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	_expect(main._format_surface_tabs() == "Result  [Upgrades]  Log", "surface tabs should mark the upgrade view")
	_expect(main._format_upgrade_menu_title(1, 7) == "Upgrade Bay (1/7) - Up/Down select", "upgrade bay title should keep selection controls visible")
	main.surface_tab_index = main.SURFACE_TAB_LOG
	_expect(main._format_surface_tabs() == "Result  Upgrades  [Log]", "surface tabs should mark the log view")
	main.free()

func _test_condition_briefing_copy() -> void:
	var main := MainScript.new()
	main.current_expedition_condition = {
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
		"tags": ["thermal", "scan"],
	}

	var briefing := main._format_condition_briefing()
	_expect(briefing.contains("Today: Thermal Bloom."), "condition briefing should frame the day condition as today's ocean change")
	_expect(briefing.contains("Vent-warmed routes may point toward extra glow."), "thermal briefing should name the implemented vent/glow route cue")
	_expect(not briefing.contains("thermal_bloom"), "condition briefing should not expose raw condition ids")
	_expect(not briefing.to_lower().contains("procedural"), "condition briefing should not imply unimplemented generation systems")

	main.current_expedition_condition = {
		"id": "predator_migration",
		"display_name": "Predator Migration",
		"briefing": "Deep patrols are shifting.",
		"tags": ["predator", "route"],
	}
	briefing = main._format_condition_briefing()
	_expect(briefing.contains("Gulper route"), "predator briefing should point to the existing predator route")
	_expect(briefing.contains("warning cues"), "predator briefing should point to existing readable cues")
	_expect(main.call("_rare_signal_emphasis_visible_for_condition", "rare_signal"), "Rare Signal should enable the subtle signal emphasis")
	_expect(not main.call("_rare_signal_emphasis_visible_for_condition", "wreck_shift"), "Wreck Shift should not enable Rare Signal emphasis")
	_expect(not main.call("_rare_signal_emphasis_visible_for_condition", "thermal_bloom"), "Thermal Bloom should keep Rare Signal emphasis hidden")
	main.free()

func _test_compact_dive_hud_helpers() -> void:
	var main := MainScript.new()
	var cargo: Array[String] = ["glow_plankton", "kelp_fiber", "glow_plankton"]
	var inline_cargo: String = main.call("_format_cargo_counts_inline", cargo)
	_expect(inline_cargo == " - Glow x2, Kelp x1", "active cargo helper should keep carried resources on one line")

	var slot_states: Array = main.call("_cargo_slot_states", cargo, 3, 4)
	_expect(slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "locked"], "cargo slots should show filled slots and lock excess capacity")
	var upgraded_slot_states: Array = main.call("_cargo_slot_states", cargo, 4, 4)
	_expect(upgraded_slot_states == ["glow_plankton", "kelp_fiber", "glow_plankton", "empty"], "cargo slots should reveal the fourth slot after capacity upgrade")
	_expect(main.call("_cargo_slot_color", "empty").a > main.call("_cargo_slot_color", "locked").a, "empty cargo slots should read brighter than locked slots")
	_expect(main.call("_cargo_slot_color", "locked").a >= 0.5, "locked cargo slot should remain visible as disabled capacity")
	_expect(main.call("_cargo_slot_icon_polygon", "kelp_fiber").size() > 0, "kelp cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "shell_fragments").size() > 0, "shell cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "glow_plankton").size() > 0, "glow cargo slots should have a mini-icon polygon")
	_expect(main.call("_cargo_slot_icon_polygon", "empty").is_empty(), "empty cargo slots should not show a resource mini-icon")
	_expect(main.call("_cargo_slot_icon_color", "locked").a == 0.0, "locked cargo slot icon color should stay transparent")

	var compact_discoveries: String = main.call("_format_discoveries", true)
	_expect(compact_discoveries == "Discoveries: 0", "compact discovery helper should show only the count")

	var main_scene := MainScene.instantiate()
	root.add_child(main_scene)
	var active_panel: Panel = main_scene.get_node("HUD/ActiveStatsPanel")
	var discoveries_label: Label = main_scene.get_node("HUD/Discoveries")
	var dive_info_panel: Panel = main_scene.get_node("HUD/DiveInfoPanel")
	var scan_target_label: Label = main_scene.get_node("HUD/ScanTarget")
	var prompt_label: Label = main_scene.get_node("HUD/ExtractionPrompt")
	var status_label: Label = main_scene.get_node("HUD/Status")
	var cargo_slot_4: ColorRect = main_scene.get_node("HUD/CargoSlots/Slot4")
	_expect(discoveries_label.offset_top >= active_panel.offset_top, "active Discoveries label should stay inside the compact stats panel")
	_expect(discoveries_label.offset_bottom <= active_panel.offset_bottom, "active Discoveries label should not spill below the compact stats panel")
	_expect(dive_info_panel.offset_top > active_panel.offset_bottom, "dive info panel should remain below compact stats content")
	_expect(scan_target_label.offset_top >= dive_info_panel.offset_top, "scan target should stay inside the dive info panel")
	_expect(status_label.offset_bottom <= dive_info_panel.offset_bottom, "status text should stay inside the dive info panel")
	_expect(prompt_label.offset_bottom <= status_label.offset_top, "prompt and status should not overlap")
	_expect(cargo_slot_4.visible, "locked fourth cargo slot should remain visible as dim capacity")
	_expect(scan_target_label.text.begins_with("Scan:"), "scan target label should use compact active HUD copy")
	_expect(not active_panel.visible, "surface-ready state should hide active stats clutter")
	_expect(not dive_info_panel.visible, "surface-ready state should hide dive guidance clutter")
	main_scene.queue_free()

	var long_status := "Scanned Thermal Vent.\nWarm current marks optional glow; bank Pressure Seal clue. Return safely before oxygen runs out."
	var compact_status: String = main.call("_compact_dive_status", long_status)
	_expect(not compact_status.contains("\n"), "compact dive status should remove line breaks")
	_expect(compact_status.length() <= 76, "compact dive status should stay within the dive HUD limit")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks decoy.")
	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	var combined_prompt := "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 72, "combined Burst and Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Space: burst"), "combined active prompt should keep the Space command visible")
	_expect(combined_prompt.contains("F: decoy ready"), "combined active prompt should keep the Decoy command compact")
	_expect(not combined_prompt.contains("Playtest data:"), "combined active prompt should not expose debug telemetry")

	main.decoy_pulse_used_this_run = true
	combined_prompt = "Explore, then return to base | %s | %s" % [
		main._format_burst_thruster_prompt(),
		main._format_decoy_pulse_prompt(),
	]
	_expect(combined_prompt.length() <= 68, "spent Decoy active prompt should stay compact")
	_expect(combined_prompt.contains("Decoy spent"), "spent Decoy active prompt should stay compact and explicit")

	_expect(main.call("_oxygen_state", 30.0, 40.0) == "normal", "oxygen helper should treat safe oxygen as normal")
	_expect(main.call("_oxygen_state", 10.0, 40.0) == "low", "oxygen helper should mark 25 percent oxygen as low")
	_expect(main.call("_oxygen_state", 4.0, 40.0) == "critical", "oxygen helper should mark 10 percent oxygen as critical")
	_expect(main.call("_format_oxygen_label", 10.0, 40.0).contains("LOW"), "oxygen label should carry low state inline")
	_expect(main.call("_format_oxygen_label", 40.0, 40.0).begins_with("O2:"), "oxygen label should use compact active HUD copy")
	_expect(main.call("_oxygen_warning_text", "critical").contains("RETURN TO BASE"), "critical warning should emphasize the return route")
	main.free()

func _test_burst_thruster_movement_helper() -> void:
	var player := PlayerScript.new()
	player.burst(Vector2.DOWN, 700.0)
	_expect(player.velocity == Vector2.DOWN * 700.0, "burst should set velocity in the requested direction")

	player.burst(Vector2.ZERO, 500.0)
	_expect(player.velocity == Vector2.RIGHT * 500.0, "burst without input should use the last facing direction")
	player.free()

func _test_player_visual_facing_isolation() -> void:
	var player := PlayerScene.instantiate()
	root.add_child(player)
	var visual_root: Node2D = player.get_node("VisualRoot")

	player.call("_set_facing_sign", -1.0)
	_expect(player.scale == Vector2.ONE, "facing should not mirror the physics/player root")
	_expect(visual_root.scale.x == -1.0, "facing left should mirror only the visual root")
	player.set("_last_move_direction", Vector2.ZERO)
	_expect(player.get_burst_direction() == Vector2.LEFT, "burst fallback should use the tracked left-facing sign")

	player.call("_set_facing_sign", 1.0)
	_expect(player.scale == Vector2.ONE, "facing right should keep the physics/player root unmirrored")
	_expect(visual_root.scale.x == 1.0, "facing right should restore the visual root")
	player.set("_last_move_direction", Vector2.ZERO)
	_expect(player.get_burst_direction() == Vector2.RIGHT, "burst fallback should use the tracked right-facing sign")

	player.queue_free()

func _test_player_idle_and_thrust_visual_states() -> void:
	var player := PlayerScene.instantiate()
	root.add_child(player)
	var idle_bubble: Polygon2D = player.get_node("VisualRoot/IdleBubble")
	var thrust_flare: Polygon2D = player.get_node("VisualRoot/ThrustFlare")
	var bubble_trail: Polygon2D = player.get_node("VisualRoot/BubbleTrail")

	player.call("_sync_movement_visuals", 0.1, false)
	_expect(player.scale == Vector2.ONE, "visual motion state should not modify the physics/player root")
	_expect(idle_bubble.visible, "idle state should show the idle bubble treatment")
	_expect(not thrust_flare.visible, "idle state should hide the thrust flare")
	_expect(bubble_trail.color.a < 0.3, "idle state should keep the bubble trail subtle")

	player.call("_set_facing_sign", -1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.scale == Vector2.ONE, "moving visual state should keep the physics/player root unmirrored")
	_expect(player.get_node("VisualRoot").scale.x == -1.0, "moving visual state should work while facing left")
	_expect(not idle_bubble.visible, "moving state should hide the idle bubble treatment")
	_expect(thrust_flare.visible, "moving state should show the thrust flare")
	_expect(bubble_trail.color.a > 0.4, "moving state should strengthen the bubble trail")

	player.call("_set_facing_sign", 1.0)
	player.call("_sync_movement_visuals", 0.1, true)
	_expect(player.get_node("VisualRoot").scale.x == 1.0, "moving visual state should work while facing right")
	_expect(thrust_flare.visible, "right-facing movement should keep thrust flare visible")

	player.queue_free()

func _test_predator_decoy_pulse_helper() -> void:
	var predator := PredatorScript.new()
	predator.global_position = Vector2(100.0, 0.0)
	predator.patrol_start = Vector2.ZERO
	predator.patrol_end = Vector2(200.0, 0.0)

	predator.trigger_decoy_from(Vector2.ZERO, 2.5, 260.0)
	_expect(predator.is_decoy_active(), "decoy pulse should mark predator as distracted")
	_expect(is_equal_approx(predator.decoy_time_remaining(), 2.5), "decoy pulse should preserve configured duration")
	_expect(predator.decoy_target().x > predator.global_position.x, "decoy target should pull predator away from player")
	_expect(predator.decoy_target().distance_to(predator.global_position) > 200.0, "decoy target should create a meaningful route-timing window")
	predator.free()

func _test_decoy_pulse_feedback_text() -> void:
	var main := MainScript.new()
	_expect(main._format_decoy_pulse_prompt() == "", "decoy prompt should stay hidden before Gulper Eel discovery")
	_expect(main._format_decoy_pulse_scan_feedback().contains("unavailable"), "decoy scan feedback should explain unavailable state")

	main.progression_state.add_discovery("gulper_eel", "Gulper Eel", "Predator.", "Unlocks warning tuning.")
	_expect(main._format_decoy_pulse_prompt().contains("locked"), "decoy prompt should show upgrade-locked state after discovery")

	main.progression_state.purchased_upgrades[DecoyPulseUpgrade.id] = true
	_expect(main._format_decoy_pulse_prompt().contains("ready"), "decoy prompt should show ready state when owned and unused")
	main.decoy_pulse_activated_this_scan = true
	_expect(main._format_decoy_pulse_scan_feedback().contains("spent"), "decoy scan feedback should report use")
	_expect(main._format_decoy_pulse_scan_feedback().contains("3s"), "decoy scan feedback should report duration")

	main.decoy_pulse_activated_this_scan = false
	main.decoy_pulse_used_this_run = true
	_expect(main._format_decoy_pulse_prompt().contains("spent"), "decoy prompt should show spent state")
	_expect(main._format_decoy_pulse_scan_feedback().contains("already spent"), "decoy scan feedback should explain repeat denial")
	main.free()

func _make_spawn_point(spawn_id: String, category: String, target_id: String, depth_band: String, cluster_pattern: String, position: Vector2, preferred_condition_id := "") -> SpawnPoint:
	var point := SpawnPointScript.new()
	point.spawn_id = spawn_id
	point.category = category
	point.target_id = target_id
	point.depth_band = depth_band
	point.cluster_pattern = cluster_pattern
	point.preferred_condition_id = preferred_condition_id
	point.global_position = position
	return point

func _make_scan_target(discovery_id: String, display_name: String, position: Vector2) -> DummyScanTarget:
	var target := DummyScanTarget.new()
	target.discovery_id = discovery_id
	target.display_name = display_name
	target.description = "%s description" % display_name
	target.global_position = position
	return target

func _expect(condition: bool, message: String) -> void:
	if condition:
		_passes += 1
		return

	_failures.append(message)

func _expect_lines_within(text: String, max_length: int, context: String) -> void:
	for line in text.split("\n", false):
		_expect(line.length() <= max_length, "%s line should stay within %d characters: %s" % [context, max_length, line])

func _expect_no_echo_lens_locator_language(text: String, context: String) -> void:
	var lowered := text.to_lower()
	for blocked in [
		"coordinate",
		"coords",
		"map",
		"marker",
		"objective",
		"quest",
		"checklist",
		"field guide",
		"field-guide",
		"exact",
		"locator",
		"gps",
	]:
		_expect(not lowered.contains(blocked), "%s should not introduce %s language" % [context, blocked])
