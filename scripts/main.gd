extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradeDefinitionScript := preload("res://scripts/upgrade_definition.gd")
const OXYGEN_TANK_UPGRADE := preload("res://resources/upgrades/oxygen_tank_1.tres")

const OXYGEN_TANK_UPGRADE_ID := "oxygen_tank_1"
const PROGRESSION_SAVE_PATH := "user://progression_save.json"
const LOW_OXYGEN_RATIO := 0.25
const CRITICAL_OXYGEN_RATIO := 0.10
const STARTER_RESOURCE_PICKUP_NAMES := [
	"KelpFiber",
	"ShellFragments",
	"GlowPlankton",
]
const RESOURCE_CLUSTER_PATTERNS := [
	"cautious",
	"deep_reward",
]

@export var max_oxygen := 30.0
@export var oxygen_tank_1_max_oxygen := 40.0
@export var oxygen_drain_per_second := 0.95
@export var collect_oxygen_cost := 1.0
@export var scan_oxygen_cost := 2.0
@export var predator_contact_oxygen_cost := 5.0
@export var scan_range := 120.0
@export var start_position := Vector2(640.0, 190.0)
@export var surface_y := 120.0
@export var pixels_per_meter := 10.0

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var depth_label: Label = $HUD/Depth
@onready var base_direction_label: Label = $HUD/BaseDirection
@onready var cargo_label: Label = $HUD/Cargo
@onready var bank_label: Label = $HUD/BankedResources
@onready var upgrade_label: Label = $HUD/Upgrade
@onready var discoveries_label: Label = $HUD/Discoveries
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt
@onready var scan_target_label: Label = $HUD/ScanTarget
@onready var oxygen_warning_label: Label = $HUD/OxygenWarning
@onready var run_panel: Panel = $HUD/RunPanel
@onready var run_title_label: Label = $HUD/RunPanel/RunTitle
@onready var run_summary_label: Label = $HUD/RunPanel/RunSummary
@onready var upgrade_panel: Panel = $HUD/UpgradePanel
@onready var upgrade_menu_title_label: Label = $HUD/UpgradePanel/UpgradeMenuTitle
@onready var upgrade_menu_item_label: Label = $HUD/UpgradePanel/UpgradeMenuItem
@onready var upgrade_menu_cost_label: Label = $HUD/UpgradePanel/UpgradeMenuCost
@onready var upgrade_menu_state_label: Label = $HUD/UpgradePanel/UpgradeMenuState
@onready var upgrade_menu_feedback_label: Label = $HUD/UpgradePanel/UpgradeMenuFeedback
@onready var starter_resource_candidates: Node2D = $StarterResourceCandidates
@onready var creature_route_candidates: Node2D = $CreatureRouteCandidates
@onready var deep_reward_lure: Node2D = $DeepRewardLure
@onready var glow_plankton_visual: Polygon2D = $ResourcePickups/GlowPlankton/Visual
@onready var hidden_glow_plankton: Node = $ResourcePickups/HiddenGlowPlankton
@onready var vent_route_hint: Node2D = $VentRouteHint
@onready var predator_warning: Node2D = $Predators/PredatorWarning
@onready var gulper_eel: Node = $Predators/GulperEel

var dive_session := DiveSessionScript.new()
var progression_state := ProgressionStateScript.new()
var player_in_base := true
var glow_plankton_highlight_timer := 0.0
var resource_scan_highlight_id := ""
var resource_scan_highlight_timer := 0.0
var last_result_summary := ""
var upgrade_menu_feedback := ""
var current_resource_cluster_pattern := "cautious"
var current_predator_route_id := "none"
var current_scan_target: Node = null
var selected_upgrade_index := 0
var upgrade_definitions: Array[UpgradeDefinition] = [
	OXYGEN_TANK_UPGRADE,
]
var run_collected_resources: Array[String] = []
var run_completed_scans: Array[String] = []
var run_predator_contacts := 0
var run_failure_cause := "none"

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.collected.connect(_on_resource_pickup_collected)
	for predator in get_tree().get_nodes_in_group("predators"):
		predator.contacted.connect(_on_predator_contacted)
	_load_progression()
	_prepare_next_run()
	_update_hud()

func _process(delta: float) -> void:
	_update_depth()
	_update_glow_plankton_highlight(delta)
	_update_resource_scan_highlight(delta)
	if dive_session.result != DiveSessionScript.Result.DIVING:
		_update_scan_target_feedback()
		return

	dive_session.drain_oxygen(oxygen_drain_per_second * delta)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		_update_hud()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if dive_session.result == DiveSessionScript.Result.READY:
			_start_dive()
		elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
			_try_purchase_selected_upgrade()
		else:
			_try_extract()
	elif Input.is_action_just_pressed("move_up") and dive_session.result == DiveSessionScript.Result.EXTRACTED:
		_select_upgrade(-1)
	elif Input.is_action_just_pressed("move_down") and dive_session.result == DiveSessionScript.Result.EXTRACTED:
		_select_upgrade(1)
	elif Input.is_action_just_pressed("restart_dive"):
		_restart_dive()
	elif Input.is_action_just_pressed("scan"):
		_try_scan()

func _try_extract() -> void:
	if not dive_session.can_extract(player_in_base):
		return

	var extracted_cargo := dive_session.current_cargo.duplicate()
	var extracted_count := extracted_cargo.size()
	dive_session.extract()
	progression_state.bank_cargo(extracted_cargo)
	dive_session.clear_cargo()
	last_result_summary = "Extracted safely.\nBanked %d resource(s).%s\nBest depth: %dm." % [
		extracted_count,
		_format_resource_counts(extracted_cargo),
		roundi(progression_state.best_depth_reached)
	]
	last_result_summary += _format_run_telemetry("extracted")
	upgrade_menu_feedback = "Deposited %d resource(s) into the bank.%s" % [
		extracted_count,
		_format_resource_counts(extracted_cargo)
	]
	_save_progression()
	status_label.text = "Dive complete: extracted safely with %d oxygen." % ceili(dive_session.oxygen)
	_update_hud()

func _fail_dive() -> void:
	if run_failure_cause == "none":
		run_failure_cause = "oxygen depleted"
	last_result_summary = "Dive failed: oxygen depleted.\nCarried cargo lost.\nBanked resources, upgrades, and scans kept.\nBest depth: %dm." % roundi(progression_state.best_depth_reached)
	last_result_summary += _format_run_telemetry("failed")
	upgrade_menu_feedback = ""
	_save_progression()
	status_label.text = "Dive failed: oxygen depleted. Cargo lost."
	_update_hud()

func _start_dive() -> void:
	dive_session.start()
	upgrade_menu_feedback = ""
	status_label.text = "Dive status: active"
	_update_hud()

func _restart_dive() -> void:
	_prepare_next_run()
	player.global_position = start_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	last_result_summary = ""
	upgrade_menu_feedback = ""
	_reset_resource_pickups()
	status_label.text = "Dive ready"
	_update_hud()

func _prepare_next_run() -> void:
	progression_state.advance_run()
	dive_session.reset(_current_max_oxygen())
	_reset_run_telemetry()
	_place_starter_resources_for_run()

func _on_base_zone_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_base = true
		_update_hud()

func _on_base_zone_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_base = false
		dive_session.has_left_base = true
		_update_hud()

func _update_depth() -> void:
	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	progression_state.record_depth(dive_session.current_depth)

func _select_upgrade(direction: int) -> void:
	if upgrade_definitions.is_empty():
		return

	selected_upgrade_index = posmod(selected_upgrade_index + direction, upgrade_definitions.size())
	upgrade_menu_feedback = ""
	_update_hud()

func _try_purchase_selected_upgrade() -> void:
	var upgrade := _selected_upgrade_definition()
	if upgrade == null:
		return

	if progression_state.has_upgrade(upgrade.id):
		upgrade_menu_feedback = "%s is already installed." % upgrade.display_name
		status_label.text = upgrade_menu_feedback
		_update_hud()
		return

	if _upgrade_missing_discovery(upgrade) != "":
		upgrade_menu_feedback = "Missing discovery: %s. %s" % [
			_format_discovery_name(upgrade.required_discovery),
			upgrade.locked_reason
		]
		status_label.text = "%s is locked by missing scan data." % upgrade.display_name
		_update_hud()
		return

	if progression_state.purchase_upgrade(upgrade.id, upgrade.resource_cost):
		_apply_upgrade_effect(upgrade.effect_id)
		upgrade_menu_feedback = "Purchased %s. %s" % [upgrade.display_name, upgrade.owned_text]
		_save_progression()
		status_label.text = "Purchased %s." % upgrade.display_name
	else:
		upgrade_menu_feedback = "Missing resources:%s\nBanked:%s" % [
			_format_missing_resources(upgrade.resource_cost),
			_format_banked_resources(),
		]
		status_label.text = "%s needs more banked resources." % upgrade.display_name

	_update_hud()

func _apply_upgrade_effect(effect_id: String) -> void:
	match effect_id:
		"max_oxygen_40":
			pass
		_:
			push_warning("Unknown upgrade effect: %s" % effect_id)

func _try_scan() -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var target := _nearest_scan_target()
	if target == null:
		status_label.text = "No scan target nearby."
		_update_hud()
		return

	var discovery_id := _scan_target_id(target)
	var display_name := _scan_target_display_name(target)
	if progression_state.has_discovery(discovery_id):
		_activate_scan_effect(target)
		status_label.text = "%s already scanned.%s" % [
			display_name,
			_format_repeat_scan_effect_text(target)
		]
		_update_hud()
		return

	dive_session.drain_oxygen(scan_oxygen_cost)
	progression_state.add_discovery(
		discovery_id,
		display_name,
		_scan_target_description(target),
		_scan_target_gameplay_fact(target)
	)
	run_completed_scans.append(discovery_id)
	_activate_scan_effect(target)

	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		_save_progression()
		status_label.text = "Scanned %s.%s" % [
			display_name,
			_format_repeat_scan_effect_text(target)
		]
		_update_hud()

func _nearest_scan_target() -> Node:
	var candidates: Array[Node] = []
	for target in get_tree().get_nodes_in_group("scan_targets"):
		if not _is_valid_scan_target(target):
			continue
		if player.global_position.distance_to(target.global_position) <= scan_range:
			candidates.append(target)

	candidates.sort_custom(func(a: Node, b: Node) -> bool:
		var distance_a := player.global_position.distance_to(a.global_position)
		var distance_b := player.global_position.distance_to(b.global_position)
		if not is_equal_approx(distance_a, distance_b):
			return distance_a < distance_b
		return _scan_target_id(a) < _scan_target_id(b)
	)

	return null if candidates.is_empty() else candidates[0]

func _is_valid_scan_target(target: Node) -> bool:
	if target is ResourcePickup:
		return not target.is_collected and target.visible and target.definition != null

	return target.has_method("set_scan_selected") and not String(target.get("discovery_id")).is_empty()

func _scan_target_id(target: Node) -> String:
	if target is ResourcePickup:
		return "resource_%s" % target.definition.id

	return String(target.get("discovery_id"))

func _scan_target_display_name(target: Node) -> String:
	if target is ResourcePickup:
		return target.definition.display_name

	return String(target.get("display_name"))

func _scan_target_description(target: Node) -> String:
	if target is ResourcePickup:
		return target.definition.scan_description

	return String(target.get("description"))

func _scan_target_gameplay_fact(target: Node) -> String:
	if target is ResourcePickup:
		return "Depth: %s. Upgrade use: %s. %s" % [
			_format_depth_band(target.definition.depth_band),
			target.definition.upgrade_use,
			_format_resource_upgrade_need(target.definition.id)
		]

	return String(target.get("gameplay_fact"))

func _activate_scan_effect(target: Node) -> void:
	if target is ResourcePickup:
		resource_scan_highlight_id = target.definition.id
		resource_scan_highlight_timer = 8.0
	elif _scan_target_id(target) == "lantern_fry":
		glow_plankton_highlight_timer = 8.0
	elif _scan_target_id(target) == "thermal_vent":
		_reveal_thermal_vent_route()

func _format_repeat_scan_effect_text(target: Node) -> String:
	if target is ResourcePickup:
		return " Matching %s deposits highlighted." % target.definition.display_name
	elif _scan_target_id(target) == "lantern_fry":
		return " Nearby Glow Plankton pulsed again."
	elif _scan_target_id(target) == "thermal_vent":
		return " Current-route hint refreshed."

	return ""

func _format_resource_upgrade_need(resource_id: String) -> String:
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		return "Oxygen Tank I is installed; future upgrades may still use it."

	var needed: int = maxi(0, int(_oxygen_tank_cost().get(resource_id, 0)) - progression_state.resource_count(resource_id))
	if needed > 0:
		return "Need %d more for Oxygen Tank I." % needed

	return "Enough banked for this Oxygen Tank I material."

func _format_depth_band(depth_band: String) -> String:
	match depth_band:
		"shallow":
			return "Shallow"
		"midwater":
			return "Midwater"
		"deep":
			return "Deep"
		_:
			return depth_band

func _update_glow_plankton_highlight(delta: float) -> void:
	if glow_plankton_highlight_timer <= 0.0:
		glow_plankton_visual.scale = Vector2.ONE
		glow_plankton_visual.modulate = Color.WHITE
		return

	glow_plankton_highlight_timer = maxf(0.0, glow_plankton_highlight_timer - delta)
	var pulse := 1.0 + 0.24 * absf(sin(Time.get_ticks_msec() / 120.0))
	glow_plankton_visual.scale = Vector2(pulse, pulse)
	glow_plankton_visual.modulate = Color(1.2, 1.2, 0.7, 1.0)

func _update_resource_scan_highlight(delta: float) -> void:
	if resource_scan_highlight_timer > 0.0:
		resource_scan_highlight_timer = maxf(0.0, resource_scan_highlight_timer - delta)
	elif not resource_scan_highlight_id.is_empty():
		resource_scan_highlight_id = ""

	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		if pickup is ResourcePickup:
			var highlighted: bool = (
				resource_scan_highlight_timer > 0.0
				and pickup.definition != null
				and pickup.definition.id == resource_scan_highlight_id
				and not pickup.is_collected
				and pickup.visible
			)
			pickup.set_tactical_highlight(highlighted)

func _on_resource_pickup_collected(pickup: Node) -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	if not dive_session.add_cargo(pickup.definition.id):
		status_label.text = "Cargo full: return to bank before risking more."
		_update_hud()
		return

	pickup.collect()
	run_collected_resources.append(pickup.definition.id)
	dive_session.drain_oxygen(collect_oxygen_cost)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		run_failure_cause = "oxygen depleted after collecting %s" % pickup.definition.display_name
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		status_label.text = "Collected %s." % pickup.definition.display_name
		_update_hud()

func _on_predator_contacted(predator: Node) -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var knockback_direction: Vector2 = player.global_position - predator.global_position
	if knockback_direction == Vector2.ZERO:
		knockback_direction = Vector2.UP

	player.apply_knockback(knockback_direction, 520.0, 0.55)
	run_predator_contacts += 1
	dive_session.drain_oxygen(predator_contact_oxygen_cost)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		run_failure_cause = "oxygen depleted after predator contact"
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		status_label.text = "Predator strike: oxygen lost, controls disrupted."
		_update_hud()

func _reset_resource_pickups() -> void:
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.reset_pickup()
	_sync_discovery_reveals()

func _place_starter_resources_for_run() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = progression_state.current_run_seed
	current_resource_cluster_pattern = _resource_cluster_pattern_for_seed(progression_state.current_run_seed)
	deep_reward_lure.visible = current_resource_cluster_pattern == "deep_reward"

	for pickup_name in STARTER_RESOURCE_PICKUP_NAMES:
		var pickup := get_node_or_null("ResourcePickups/%s" % pickup_name) as ResourcePickup
		if pickup == null:
			continue
		if pickup.definition == null:
			continue

		var candidates := _spawn_positions_for_target("resource", pickup.definition.id, current_resource_cluster_pattern)
		if candidates.is_empty():
			continue

		pickup.global_position = candidates[rng.randi_range(0, candidates.size() - 1)]

	_place_predator_route_for_run(rng)

func _place_predator_route_for_run(rng: RandomNumberGenerator) -> void:
	var routes := _spawn_routes_for_target("creature", "gulper_eel", current_resource_cluster_pattern)
	if routes.is_empty():
		current_predator_route_id = "fixed"
		return

	var route_ids := routes.keys()
	route_ids.sort()
	current_predator_route_id = String(route_ids[rng.randi_range(0, route_ids.size() - 1)])
	var route: Dictionary = routes[current_predator_route_id]
	if not route.has("start") or not route.has("end"):
		push_warning("Predator route %s is missing start or end point." % current_predator_route_id)
		return

	if gulper_eel.has_method("configure_patrol"):
		gulper_eel.configure_patrol(route["start"], route["end"])

	predator_warning.global_position = route.get("warning", (route["start"] + route["end"]) * 0.5)

func _resource_cluster_pattern_for_seed(seed: int) -> String:
	return RESOURCE_CLUSTER_PATTERNS[seed % RESOURCE_CLUSTER_PATTERNS.size()]

func _spawn_positions_for_target(category: String, target_id: String, cluster_pattern: String) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	_collect_spawn_positions(starter_resource_candidates, category, target_id, cluster_pattern, positions)
	return positions

func _spawn_routes_for_target(category: String, target_id: String, cluster_pattern: String) -> Dictionary:
	var points: Array[SpawnPoint] = []
	_collect_spawn_points(creature_route_candidates, category, target_id, cluster_pattern, points)
	var routes := {}
	for point in points:
		if point.route_id.is_empty():
			continue
		if not routes.has(point.route_id):
			routes[point.route_id] = {}
		routes[point.route_id][point.spawn_id] = point.global_position

	return routes

func _collect_spawn_positions(root: Node, category: String, target_id: String, cluster_pattern: String, positions: Array[Vector2]) -> void:
	for child in root.get_children():
		if child.get_script() == SpawnPointScript and child.matches(category, target_id):
			if child.cluster_pattern == "any" or child.cluster_pattern == cluster_pattern:
				positions.append(child.global_position)
		_collect_spawn_positions(child, category, target_id, cluster_pattern, positions)

func _collect_spawn_points(root: Node, category: String, target_id: String, cluster_pattern: String, points: Array[SpawnPoint]) -> void:
	for child in root.get_children():
		if child.get_script() == SpawnPointScript and child.matches(category, target_id):
			if child.cluster_pattern == "any" or child.cluster_pattern == cluster_pattern:
				points.append(child)
		_collect_spawn_points(child, category, target_id, cluster_pattern, points)

func _sync_discovery_reveals() -> void:
	if progression_state.has_discovery("thermal_vent"):
		_reveal_thermal_vent_route()
	else:
		hidden_glow_plankton.visible = false
		hidden_glow_plankton.monitoring = false
		vent_route_hint.visible = false

func _reveal_thermal_vent_route() -> void:
	hidden_glow_plankton.visible = true
	hidden_glow_plankton.monitoring = true
	vent_route_hint.visible = true

func _update_hud() -> void:
	_update_scan_target_feedback()
	_update_run_panel()
	_update_upgrade_menu()
	oxygen_label.text = "Oxygen: %d / %d" % [ceili(dive_session.oxygen), ceili(dive_session.max_oxygen)]
	depth_label.text = "Depth: %dm | Best: %dm" % [
		roundi(dive_session.current_depth),
		roundi(progression_state.best_depth_reached)
	]
	base_direction_label.text = _format_base_direction()
	_update_oxygen_feedback()
	cargo_label.text = "Cargo: %d / %d%s" % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit,
		_format_resource_counts(dive_session.current_cargo)
	]
	bank_label.text = "Banked:%s" % _format_banked_resources()
	upgrade_label.text = _format_upgrade_status()
	discoveries_label.text = _format_discoveries()

	if dive_session.result == DiveSessionScript.Result.READY:
		prompt_label.text = "Press E or Enter to begin the dive"
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		if _all_upgrades_owned():
			prompt_label.text = "Extraction complete - press R to restart"
		else:
			prompt_label.text = "Extraction complete - upgrade bay open: Up/Down select, E purchase, R restart"
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		prompt_label.text = "Expedition failed - press R to restart"
	elif player_in_base:
		if dive_session.has_left_base:
			prompt_label.text = "Safe base: press E or Enter to extract"
		else:
			prompt_label.text = "Leave the moonpool, then return to extract"
	else:
		prompt_label.text = "Explore, then return to the safe base"

func _update_run_panel() -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		run_panel.visible = true
		run_title_label.text = "Expedition %d Ready" % progression_state.current_run_number
		run_summary_label.text = "Seed: %d\nPattern: %s\nStart with %d oxygen. Collect, scan, or push deeper, then return to bank cargo.\nPress E or Enter to begin." % [
			progression_state.current_run_seed,
			_format_cluster_pattern(current_resource_cluster_pattern),
			ceili(dive_session.max_oxygen)
		]
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		run_panel.visible = true
		run_title_label.text = "Expedition %d Result: Extraction" % progression_state.current_run_number
		run_summary_label.text = "Seed: %d\nPattern: %s\n%s" % [
			progression_state.current_run_seed,
			_format_cluster_pattern(current_resource_cluster_pattern),
			last_result_summary
		]
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		run_panel.visible = true
		run_title_label.text = "Expedition %d Result: Failure" % progression_state.current_run_number
		run_summary_label.text = "Seed: %d\nPattern: %s\n%s" % [
			progression_state.current_run_seed,
			_format_cluster_pattern(current_resource_cluster_pattern),
			last_result_summary
		]
	else:
		run_panel.visible = false

func _update_upgrade_menu() -> void:
	upgrade_panel.visible = dive_session.result == DiveSessionScript.Result.EXTRACTED
	if not upgrade_panel.visible:
		return

	var upgrade := _selected_upgrade_definition()
	if upgrade == null:
		upgrade_menu_title_label.text = "Surface Upgrade Bay"
		upgrade_menu_item_label.text = "No upgrades configured"
		upgrade_menu_cost_label.text = ""
		upgrade_menu_state_label.text = ""
		upgrade_menu_feedback_label.text = upgrade_menu_feedback
		return

	upgrade_menu_title_label.text = "Surface Upgrade Bay (%d/%d)" % [
		selected_upgrade_index + 1,
		upgrade_definitions.size()
	]
	upgrade_menu_item_label.text = "%s\n%s" % [upgrade.display_name, upgrade.description]
	upgrade_menu_cost_label.text = "Cost: %s" % _format_upgrade_cost(upgrade.resource_cost)
	upgrade_menu_state_label.text = _format_upgrade_state(upgrade)

	upgrade_menu_feedback_label.text = upgrade_menu_feedback

func _format_resource_counts(resource_ids: Array[String]) -> String:
	if resource_ids.is_empty():
		return ""

	var counts := {}
	for resource_id in resource_ids:
		counts[resource_id] = int(counts.get(resource_id, 0)) + 1

	var parts: Array[String] = []
	for resource_id in counts.keys():
		parts.append(" %s x%d" % [_display_name_for_resource(resource_id), int(counts[resource_id])])

	return "\n" + "\n".join(parts)

func _format_banked_resources() -> String:
	if progression_state.banked_resources.is_empty():
		return " none"

	var parts: Array[String] = []
	for resource_id in progression_state.banked_resources.keys():
		parts.append(" %s x%d" % [
			_display_name_for_resource(resource_id),
			progression_state.resource_count(resource_id)
		])

	return "\n" + "\n".join(parts)

func _display_name_for_resource(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp Fiber"
		"shell_fragments":
			return "Shell Fragments"
		"glow_plankton":
			return "Glow Plankton"
		_:
			return resource_id

func _format_upgrade_status() -> String:
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		return "Upgrade: Oxygen Tank I installed"

	return "Upgrade: Oxygen Tank I costs %s" % _format_upgrade_cost(_oxygen_tank_cost())

func _format_upgrade_cost(cost: Dictionary) -> String:
	if cost.is_empty():
		return "none"

	var parts: Array[String] = []
	for resource_id in cost.keys():
		parts.append("%s x%d" % [_display_name_for_resource(resource_id), int(cost[resource_id])])

	return ", ".join(parts)

func _format_missing_resources(cost: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		var missing: int = int(cost[resource_id]) - progression_state.resource_count(resource_id)
		if missing > 0:
			parts.append(" %s x%d" % [_display_name_for_resource(resource_id), missing])

	return " none" if parts.is_empty() else "\n" + "\n".join(parts)

func _format_upgrade_state(upgrade: UpgradeDefinition) -> String:
	if progression_state.has_upgrade(upgrade.id):
		return upgrade.owned_text

	var missing_discovery := _upgrade_missing_discovery(upgrade)
	if missing_discovery != "":
		return "Locked: %s\nMissing discovery: %s\nMissing resources:%s" % [
			upgrade.locked_reason,
			_format_discovery_name(missing_discovery),
			_format_missing_resources(upgrade.resource_cost)
		]

	if progression_state.can_afford(upgrade.resource_cost):
		return "%s\nEffect: %s" % [upgrade.available_text, upgrade.owned_text]

	return "Unavailable: collect and bank more resources.\nMissing resources:%s\nEffect: %s" % [
		_format_missing_resources(upgrade.resource_cost),
		upgrade.owned_text
	]

func _upgrade_missing_discovery(upgrade: UpgradeDefinition) -> String:
	if upgrade.required_discovery.is_empty():
		return ""

	return "" if progression_state.has_discovery(upgrade.required_discovery) else upgrade.required_discovery

func _format_discovery_name(discovery_id: String) -> String:
	if discovery_id.is_empty():
		return "none"

	var discovery: Dictionary = progression_state.scan_discoveries.get(discovery_id, {})
	if not discovery.is_empty():
		return String(discovery.get("display_name", discovery_id))

	match discovery_id:
		"thermal_vent":
			return "Thermal Vent"
		"lantern_fry":
			return "Lantern Fry"
		_:
			return discovery_id

func _selected_upgrade_definition() -> UpgradeDefinition:
	if upgrade_definitions.is_empty():
		return null

	selected_upgrade_index = clampi(selected_upgrade_index, 0, upgrade_definitions.size() - 1)
	return upgrade_definitions[selected_upgrade_index]

func _all_upgrades_owned() -> bool:
	for upgrade in upgrade_definitions:
		if not progression_state.has_upgrade(upgrade.id):
			return false

	return true

func _oxygen_tank_cost() -> Dictionary:
	return OXYGEN_TANK_UPGRADE.resource_cost

func _format_cluster_pattern(pattern: String) -> String:
	match pattern:
		"cautious":
			return "Cautious shallows"
		"deep_reward":
			return "Deep reward route"
		_:
			return pattern

func _reset_run_telemetry() -> void:
	run_collected_resources.clear()
	run_completed_scans.clear()
	run_predator_contacts = 0
	run_failure_cause = "none"

func _format_run_telemetry(result_name: String) -> String:
	return "\n\nPlaytest data:\nResult: %s\nSeed: %d\nPattern: %s\nPredator route: %s\nCargo collected:%s\nScans: %s\nPredator contacts: %d\nOxygen at result: %d / %d\nFailure cause: %s" % [
		result_name,
		progression_state.current_run_seed,
		_format_cluster_pattern(current_resource_cluster_pattern),
		current_predator_route_id,
		_format_resource_counts(run_collected_resources),
		_format_scan_ids(run_completed_scans),
		run_predator_contacts,
		ceili(dive_session.oxygen),
		ceili(dive_session.max_oxygen),
		run_failure_cause
	]

func _format_scan_ids(scan_ids: Array[String]) -> String:
	if scan_ids.is_empty():
		return "none"

	var parts: Array[String] = []
	for scan_id in scan_ids:
		parts.append(scan_id)

	return ", ".join(parts)

func _format_discoveries() -> String:
	var discoveries := progression_state.scan_discoveries
	var text := "Discoveries: %d" % discoveries.size()
	if discoveries.is_empty():
		return text + "\n???"

	for discovery in discoveries.values():
		text += "\n%s - %s" % [discovery["display_name"], discovery["gameplay_fact"]]

	return text

func _update_scan_target_feedback() -> void:
	var next_target := _nearest_scan_target() if dive_session.result == DiveSessionScript.Result.DIVING else null
	if current_scan_target != next_target:
		if current_scan_target != null and current_scan_target.has_method("set_scan_selected"):
			current_scan_target.set_scan_selected(false)
		current_scan_target = next_target
		if current_scan_target != null and current_scan_target.has_method("set_scan_selected"):
			current_scan_target.set_scan_selected(true)

	if current_scan_target == null:
		scan_target_label.text = "Scan target: none nearby"
	else:
		scan_target_label.text = "Scan target: %s" % _scan_target_display_name(current_scan_target)

func _current_max_oxygen() -> float:
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		return oxygen_tank_1_max_oxygen

	return max_oxygen

func _format_base_direction() -> String:
	var vertical_delta := player.global_position.y - start_position.y
	if absf(vertical_delta) < 48.0:
		return "Base: here"

	if vertical_delta > 0.0:
		return "Base: up %.0fm" % (vertical_delta / pixels_per_meter)

	return "Base: below %.0fm" % (absf(vertical_delta) / pixels_per_meter)

func _update_oxygen_feedback() -> void:
	oxygen_warning_label.visible = false
	oxygen_label.modulate = Color.WHITE
	base_direction_label.modulate = Color.WHITE
	oxygen_label.scale = Vector2.ONE
	base_direction_label.scale = Vector2.ONE

	if dive_session.result != DiveSessionScript.Result.DIVING or dive_session.max_oxygen <= 0.0:
		return

	var oxygen_ratio := dive_session.oxygen / dive_session.max_oxygen
	if oxygen_ratio <= CRITICAL_OXYGEN_RATIO:
		var pulse := 1.0 + 0.08 * absf(sin(Time.get_ticks_msec() / 90.0))
		oxygen_warning_label.visible = true
		oxygen_warning_label.text = "CRITICAL OXYGEN - RETURN TO BASE"
		oxygen_warning_label.modulate = Color(1.0, 0.18, 0.12, 1.0)
		oxygen_label.modulate = Color(1.0, 0.18, 0.12, 1.0)
		base_direction_label.modulate = Color(1.0, 0.22, 0.14, 1.0)
		oxygen_label.scale = Vector2(pulse, pulse)
		base_direction_label.scale = Vector2(pulse, pulse)
	elif oxygen_ratio <= LOW_OXYGEN_RATIO:
		oxygen_warning_label.visible = true
		oxygen_warning_label.text = "LOW OXYGEN - PLAN RETURN"
		oxygen_warning_label.modulate = Color(1.0, 0.76, 0.22, 1.0)
		oxygen_label.modulate = Color(1.0, 0.76, 0.22, 1.0)
		base_direction_label.modulate = Color(1.0, 0.86, 0.36, 1.0)

func _load_progression() -> void:
	if not FileAccess.file_exists(PROGRESSION_SAVE_PATH):
		return

	var file := FileAccess.open(PROGRESSION_SAVE_PATH, FileAccess.READ)
	if file == null:
		push_warning("Could not open progression save.")
		return

	var parsed = JSON.parse_string(file.get_as_text())
	if parsed is Dictionary:
		progression_state.load_save_data(parsed)

func _save_progression() -> void:
	var file := FileAccess.open(PROGRESSION_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_warning("Could not write progression save.")
		return

	file.store_string(JSON.stringify(progression_state.to_save_data(), "\t"))
