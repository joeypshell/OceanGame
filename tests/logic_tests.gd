extends SceneTree

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const PlayerScript := preload("res://scripts/player.gd")
const OxygenTankUpgrade := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PressureSealUpgrade := preload("res://resources/upgrades/pressure_seal_1.tres")
const SignalLensUpgrade := preload("res://resources/upgrades/signal_lens_1.tres")
const CargoRackUpgrade := preload("res://resources/upgrades/cargo_rack_1.tres")

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
	_run("save/load behavior", _test_save_load_behavior)
	_run("deterministic seed generation", _test_deterministic_seed_generation)
	_run("spawn-point matching", _test_spawn_point_matching)
	_run("spawn selection", _test_spawn_selection)
	_run("scanner target resolver", _test_scanner_target_resolver)
	_run("discovery prerequisites", _test_discovery_prerequisites)
	_run("burst thruster movement helper", _test_burst_thruster_movement_helper)

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
	root.free()

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

func _test_discovery_prerequisites() -> void:
	var progression := ProgressionStateScript.new()

	_expect(OxygenTankUpgrade.required_discovery.is_empty(), "Oxygen Tank I should not require a discovery")
	_expect(PressureSealUpgrade.required_discovery == "thermal_vent", "Pressure Seal I should require Thermal Vent")
	_expect(SignalLensUpgrade.required_discovery == "wreck_signal_cache", "Signal Lens I should require Wreck Signal Cache")
	_expect(CargoRackUpgrade.required_discovery.is_empty(), "Cargo Rack I should not require a discovery")
	_expect(CargoRackUpgrade.effect_id == "cargo_limit_4", "Cargo Rack I should use cargo limit effect")
	_expect(UpgradePurchaseScript.missing_discovery(progression, OxygenTankUpgrade) == "", "upgrade with no prerequisite should not be locked")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "thermal_vent", "Pressure Seal I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "wreck_signal_cache", "Signal Lens I prerequisite should start missing")
	_expect(UpgradePurchaseScript.missing_discovery(progression, CargoRackUpgrade) == "", "Cargo Rack I prerequisite should be satisfied by default")
	progression.add_discovery("thermal_vent", "Thermal Vent", "Hot current.", "Unlocks pressure tuning.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, PressureSealUpgrade) == "", "Pressure Seal I prerequisite should be satisfied by Thermal Vent discovery")
	progression.add_discovery("wreck_signal_cache", "Wreck Signal Cache", "Signal map.", "Unlocks Signal Lens I.")
	_expect(UpgradePurchaseScript.missing_discovery(progression, SignalLensUpgrade) == "", "Signal Lens I prerequisite should be satisfied by Wreck Signal Cache discovery")

func _test_burst_thruster_movement_helper() -> void:
	var player := PlayerScript.new()
	player.burst(Vector2.DOWN, 700.0)
	_expect(player.velocity == Vector2.DOWN * 700.0, "burst should set velocity in the requested direction")

	player.burst(Vector2.ZERO, 500.0)
	_expect(player.velocity == Vector2.RIGHT * 500.0, "burst without input should use the last facing direction")
	player.free()

func _make_spawn_point(spawn_id: String, category: String, target_id: String, depth_band: String, cluster_pattern: String, position: Vector2) -> SpawnPoint:
	var point := SpawnPointScript.new()
	point.spawn_id = spawn_id
	point.category = category
	point.target_id = target_id
	point.depth_band = depth_band
	point.cluster_pattern = cluster_pattern
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
