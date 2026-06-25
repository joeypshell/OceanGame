extends SceneTree

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const PlayerScript := preload("res://scripts/player.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const MainScript := preload("res://scripts/main.gd")
const PredatorScript := preload("res://scripts/predator.gd")
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
	_run("predator scan target", _test_predator_scan_target)
	_run("discovery prerequisites", _test_discovery_prerequisites)
	_run("expedition prep goals", _test_expedition_prep_goals)
	_run("result progress callouts", _test_result_progress_callouts)
	_run("upgrade bay readability states", _test_upgrade_bay_readability_states)
	_run("recent expedition log", _test_recent_expedition_log)
	_run("shell reef scan clue text", _test_shell_reef_scan_clue_text)
	_run("surface summary tabs", _test_surface_summary_tabs)
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
	var shell_reef := _make_spawn_point("reef", "resource", "shell_fragments", "midwater", "any", Vector2(70.0, 80.0))
	root.add_child(shell_reef)
	var shell_positions := SpawnSelectionScript.positions_for_target(root, SpawnPointScript, "resource", "shell_fragments", "deep_reward")
	_expect(shell_positions.size() == 1, "shell reef spawn selection should include one authored shell candidate without adding extra pickups")
	_expect(shell_positions.has(Vector2(70.0, 80.0)), "shell reef spawn selection should include any-pattern reef candidate")
	_expect(shell_reef.depth_band == "midwater", "shell reef spawn point should preserve midwater depth identity")
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

func _test_expedition_prep_goals() -> void:
	var upgrades: Array[UpgradeDefinition] = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
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
	_expect(goal == "Goal: use Shell Reef to bank Shell Fragments, or push deeper if oxygen allows.", "completed upgrade goals should fall back to the Shell Reef route objective")

func _test_result_progress_callouts() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
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

func _test_upgrade_bay_readability_states() -> void:
	var main := MainScript.new()
	main.upgrade_definitions = [
		OxygenTankUpgrade,
		PressureSealUpgrade,
		SignalLensUpgrade,
		CargoRackUpgrade,
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

func _test_shell_reef_scan_clue_text() -> void:
	var main := MainScript.new()
	var target := DummyScanTarget.new()
	target.discovery_id = "shell_reef_shelf"
	target.display_name = "Shell Reef Shelf"
	target.description = "Reef shelf."

	_expect(main._format_discovery_name("shell_reef_shelf") == "Shell Reef Shelf", "shell reef discovery should have a readable name")
	_expect(main._format_repeat_scan_effect_text(target).contains("Shell Reef route clue refreshed"), "shell reef repeat scan should give compact feedback")
	_expect(main._format_first_scan_guidance(target).contains("midwater bank route"), "shell reef first scan should explain the route decision")
	_expect(main._format_scan_target_type(target) == "environment", "shell reef scan target should be environmental metadata")
	target.free()
	main.free()

func _test_surface_summary_tabs() -> void:
	var main := MainScript.new()

	_expect(not main._surface_tabs_enabled(), "surface tabs should be hidden before extraction")
	main.dive_session.extract()
	_expect(main._surface_tabs_enabled(), "surface tabs should be available after extraction")
	_expect(main._format_surface_tabs() == "[Result]  Upgrades  Log", "surface tabs should mark the result view by default")
	main.surface_tab_index = main.SURFACE_TAB_UPGRADES
	_expect(main._format_surface_tabs() == "Result  [Upgrades]  Log", "surface tabs should mark the upgrade view")
	main.surface_tab_index = main.SURFACE_TAB_LOG
	_expect(main._format_surface_tabs() == "Result  Upgrades  [Log]", "surface tabs should mark the log view")
	main.free()

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
