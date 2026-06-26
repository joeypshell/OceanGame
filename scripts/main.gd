extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradeDefinitionScript := preload("res://scripts/upgrade_definition.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const OXYGEN_TANK_UPGRADE := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PRESSURE_SEAL_UPGRADE := preload("res://resources/upgrades/pressure_seal_1.tres")
const SIGNAL_LENS_UPGRADE := preload("res://resources/upgrades/signal_lens_1.tres")
const CARGO_RACK_UPGRADE := preload("res://resources/upgrades/cargo_rack_1.tres")
const PREDATOR_WARNING_UPGRADE := preload("res://resources/upgrades/predator_warning_1.tres")
const DECOY_PULSE_UPGRADE := preload("res://resources/upgrades/decoy_pulse_1.tres")

const OXYGEN_TANK_UPGRADE_ID := "oxygen_tank_1"
const PRESSURE_SEAL_UPGRADE_ID := "pressure_seal_1"
const SIGNAL_LENS_UPGRADE_ID := "signal_lens_1"
const CARGO_RACK_UPGRADE_ID := "cargo_rack_1"
const PREDATOR_WARNING_UPGRADE_ID := "predator_warning_1"
const DECOY_PULSE_UPGRADE_ID := "decoy_pulse_1"
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
const SURFACE_TAB_RESULT := 0
const SURFACE_TAB_UPGRADES := 1
const SURFACE_TAB_LOG := 2
const SURFACE_TAB_NAMES := ["Result", "Upgrades", "Log"]
const DIVE_STATUS_MAX_CHARS := 92

@export var max_oxygen := 30.0
@export var oxygen_tank_1_max_oxygen := 40.0
@export var base_cargo_limit := 3
@export var cargo_rack_1_limit := 4
@export var oxygen_drain_per_second := 0.95
@export var collect_oxygen_cost := 1.0
@export var scan_oxygen_cost := 2.0
@export var predator_contact_oxygen_cost := 5.0
@export var burst_thruster_oxygen_cost := 4.0
@export var burst_thruster_cooldown_seconds := 4.0
@export var burst_thruster_force := 760.0
@export var decoy_pulse_duration_seconds := 2.5
@export var decoy_pulse_pull_distance := 260.0
@export var predator_warning_1_multiplier := 1.8
@export var scan_range := 120.0
@export var start_position := Vector2(640.0, 190.0)
@export var surface_y := 120.0
@export var pixels_per_meter := 10.0
@export var show_debug_telemetry := false

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var hint_label: Label = $HUD/Hint
@onready var bounds_hint_label: Label = $HUD/BoundsHint
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
@onready var dive_info_panel: Panel = $HUD/DiveInfoPanel
@onready var oxygen_warning_label: Label = $HUD/OxygenWarning
@onready var recent_expedition_log_label: Label = $HUD/RecentExpeditionLog
@onready var run_panel: Panel = $HUD/RunPanel
@onready var surface_tabs_label: Label = $HUD/RunPanel/SurfaceTabs
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
@onready var base_return_column: Polygon2D = $BaseReturnColumn
@onready var base_return_rib_shallow: Polygon2D = $BaseReturnRibShallow
@onready var base_return_rib_midwater: Polygon2D = $BaseReturnRibMidwater
@onready var base_return_rib_deep: Polygon2D = $BaseReturnRibDeep
@onready var base_return_beacon: Polygon2D = $BaseReturnBeacon
@onready var base_return_beacon_rib: Polygon2D = $BaseReturnBeaconRib
@onready var thermal_warm_wash: Polygon2D = $ThermalVentPocket/FallbackGeometry/WarmWash
@onready var thermal_heat_plume: Polygon2D = $ThermalVentPocket/FallbackGeometry/HeatPlume
@onready var thermal_bubble_string_a: Polygon2D = $ThermalVentPocket/FallbackGeometry/BubbleStringA
@onready var thermal_bubble_string_b: Polygon2D = $ThermalVentPocket/FallbackGeometry/BubbleStringB
@onready var thermal_vent_visual: Polygon2D = $Discoveries/ThermalVent/FallbackVisual/Visual
@onready var thermal_vent_bubbles: Polygon2D = $Discoveries/ThermalVent/FallbackVisual/Bubbles
@onready var glow_plankton_visual: Node2D = $ResourcePickups/GlowPlankton/SpriteAnchor
@onready var hidden_glow_plankton: Node = $ResourcePickups/HiddenGlowPlankton
@onready var vent_route_hint: Node2D = $VentRouteHint
@onready var pressure_boundary: Area2D = $PressureLockedWreck/PressureBoundary
@onready var pressure_shimmer: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureShimmer
@onready var pressure_gate_top: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureGateTop
@onready var pressure_gate_bottom: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureGateBottom
@onready var pressure_gate_bar_a: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureGateBarA
@onready var pressure_gate_bar_b: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureGateBarB
@onready var pressure_gate_bar_c: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureGateBarC
@onready var pressure_gate_left_rail: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/GateLeftRail
@onready var pressure_gate_right_rail: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/GateRightRail
@onready var pressure_lock_badge: Polygon2D = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureLockBadge
@onready var pressure_label: Label = $PressureLockedWreck/FallbackGeometry/PressureGateVisuals/PressureLabel
@onready var wreck_signal_hint: Node2D = $WreckSignalHint
@onready var predator_warning: Node2D = $Predators/PredatorWarning
@onready var gulper_eel: Node = $Predators/GulperEel

var dive_session := DiveSessionScript.new()
var progression_state := ProgressionStateScript.new()
var player_in_base := true
var glow_plankton_highlight_timer := 0.0
var resource_scan_highlight_id := ""
var resource_scan_highlight_timer := 0.0
var burst_thruster_cooldown_remaining := 0.0
var decoy_pulse_used_this_run := false
var decoy_pulse_activated_this_scan := false
var last_result_summary := ""
var upgrade_menu_feedback := ""
var current_resource_cluster_pattern := "cautious"
var current_expedition_condition: Dictionary = {}
var current_predator_route_id := "none"
var current_scan_target: Node = null
var selected_upgrade_index := 0
var surface_tab_index := SURFACE_TAB_RESULT
var upgrade_definitions: Array[UpgradeDefinition] = [
	OXYGEN_TANK_UPGRADE,
	PRESSURE_SEAL_UPGRADE,
	SIGNAL_LENS_UPGRADE,
	CARGO_RACK_UPGRADE,
	PREDATOR_WARNING_UPGRADE,
	DECOY_PULSE_UPGRADE,
]
var run_collected_resources: Array[String] = []
var run_completed_scans: Array[String] = []
var run_predator_contacts := 0
var run_failure_cause := "none"
var recent_expedition_log: Array[Dictionary] = []

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	pressure_boundary.body_entered.connect(_on_pressure_boundary_body_entered)
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.collected.connect(_on_resource_pickup_collected)
	for predator in get_tree().get_nodes_in_group("predators"):
		predator.contacted.connect(_on_predator_contacted)
	_load_progression()
	_prepare_next_run()
	_sync_discovery_reveals()
	_update_hud()

func _process(delta: float) -> void:
	_update_depth()
	_update_glow_plankton_highlight(delta)
	_update_resource_scan_highlight(delta)
	_update_burst_thruster_cooldown(delta)
	if dive_session.result != DiveSessionScript.Result.DIVING:
		_update_scan_target_feedback()
		return

	dive_session.drain_oxygen(oxygen_drain_per_second * delta)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		_update_hud()

func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F3:
		_toggle_debug_telemetry()
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F4:
		_cycle_debug_condition()
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F5:
		_cycle_debug_seed()
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F9:
		_reset_local_prototype_save()
	elif Input.is_action_just_pressed("interact"):
		if dive_session.result == DiveSessionScript.Result.READY:
			_start_dive()
		elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
			if surface_tab_index == SURFACE_TAB_UPGRADES:
				_try_purchase_selected_upgrade()
			else:
				surface_tab_index = SURFACE_TAB_UPGRADES
				status_label.text = "Surface view: upgrades."
				_update_hud()
		else:
			_try_extract()
	elif Input.is_action_just_pressed("move_left") and _surface_tabs_enabled():
		_cycle_surface_tab(-1)
	elif Input.is_action_just_pressed("move_right") and _surface_tabs_enabled():
		_cycle_surface_tab(1)
	elif Input.is_action_just_pressed("move_up") and dive_session.result == DiveSessionScript.Result.EXTRACTED and surface_tab_index == SURFACE_TAB_UPGRADES:
		_select_upgrade(-1)
	elif Input.is_action_just_pressed("move_down") and dive_session.result == DiveSessionScript.Result.EXTRACTED and surface_tab_index == SURFACE_TAB_UPGRADES:
		_select_upgrade(1)
	elif Input.is_action_just_pressed("restart_dive"):
		_restart_dive()
	elif Input.is_action_just_pressed("burst_thruster"):
		_try_burst_thruster()
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
	surface_tab_index = SURFACE_TAB_RESULT
	last_result_summary = "%s\nBanked %d resource(s).%s\n%s%s\n%s%s\n%s\n%s\n%s\nBest depth: %dm." % [
		_format_completed_expedition_line("Extraction"),
		extracted_count,
		_format_resource_counts(extracted_cargo),
		_format_region_memory_callout(),
		_format_discovery_memory_callout(),
		_format_route_choice_callout(),
		_format_gulper_research_callout(),
		_format_upgrade_progress_callout(),
		_format_scan_progress_callout("Discoveries recorded"),
		_format_next_expedition_prompt(),
		roundi(progression_state.best_depth_reached)
	]
	upgrade_menu_feedback = "Deposited %d resource(s) into the bank.%s\n%s" % [
		extracted_count,
		_format_resource_counts(extracted_cargo),
		_format_ready_upgrade_callout(),
	]
	_record_recent_expedition("Extracted", extracted_count)
	_save_progression()
	status_label.text = "Dive complete: extracted safely with %d oxygen." % ceili(dive_session.oxygen)
	_update_hud()

func _fail_dive() -> void:
	if run_failure_cause == "none":
		run_failure_cause = "oxygen depleted"
	surface_tab_index = SURFACE_TAB_RESULT
	last_result_summary = "%s\nCarried cargo lost.\nKept banked resources, upgrades, scans, and best depth.\n%s%s\n%s%s\n%s\n%s\nBest depth: %dm." % [
		_format_completed_expedition_line("Failure"),
		_format_region_memory_callout(),
		_format_discovery_memory_callout(),
		_format_route_choice_callout(),
		_format_gulper_research_callout(),
		_format_scan_progress_callout("Scans kept"),
		_format_next_expedition_prompt(),
		roundi(progression_state.best_depth_reached),
	]
	upgrade_menu_feedback = ""
	_record_recent_expedition("Failed", 0)
	_save_progression()
	status_label.text = "Dive failed: oxygen depleted. Cargo lost."
	_update_hud()

func _start_dive() -> void:
	dive_session.start()
	surface_tab_index = SURFACE_TAB_RESULT
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
	surface_tab_index = SURFACE_TAB_RESULT
	_reset_resource_pickups()
	status_label.text = _format_expedition_ready_status()
	_update_hud()

func _reset_local_prototype_save() -> void:
	progression_state.reset()
	_delete_progression_save()
	_prepare_next_run()
	player.global_position = start_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	last_result_summary = ""
	upgrade_menu_feedback = ""
	surface_tab_index = SURFACE_TAB_RESULT
	selected_upgrade_index = 0
	_reset_resource_pickups()
	_sync_discovery_reveals()
	_save_progression()
	status_label.text = "Prototype save reset. Expedition 1 ready."
	_update_hud()

func _prepare_next_run() -> void:
	progression_state.advance_run()
	current_expedition_condition = ExpeditionConditionScript.condition_for_seed(progression_state.current_run_seed)
	dive_session.reset(_current_max_oxygen())
	dive_session.cargo_limit = _current_cargo_limit()
	_reset_run_telemetry()
	burst_thruster_cooldown_remaining = 0.0
	decoy_pulse_used_this_run = false
	_place_starter_resources_for_run()
	_sync_condition_visuals()

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

func _cycle_surface_tab(direction: int) -> void:
	surface_tab_index = posmod(surface_tab_index + direction, SURFACE_TAB_NAMES.size())
	status_label.text = "Surface view: %s." % SURFACE_TAB_NAMES[surface_tab_index].to_lower()
	_update_hud()

func _toggle_debug_telemetry() -> void:
	show_debug_telemetry = not show_debug_telemetry
	status_label.text = "Debug telemetry: %s." % ("shown" if show_debug_telemetry else "hidden")
	_update_hud()

func _cycle_debug_condition() -> void:
	if not show_debug_telemetry:
		return

	current_expedition_condition = _debug_next_condition_from_id(_current_condition_id())
	_place_starter_resources_for_run()
	_sync_condition_visuals()
	_update_hud()
	status_label.text = "Debug condition: %s." % _format_condition_telemetry()

func _cycle_debug_seed() -> void:
	if not show_debug_telemetry:
		return

	progression_state.current_run_seed = _debug_seed_for_delta(progression_state.current_run_seed, 1)
	current_expedition_condition = ExpeditionConditionScript.condition_for_seed(progression_state.current_run_seed)
	_reset_resource_pickups()
	_place_starter_resources_for_run()
	_sync_condition_visuals()
	_sync_discovery_reveals()
	_update_hud()
	status_label.text = "Debug seed: %d | %s | %s." % [
		progression_state.current_run_seed,
		_format_cluster_pattern(current_resource_cluster_pattern),
		_format_condition_telemetry(),
	]

func _debug_next_condition_from_id(current_id: String) -> Dictionary:
	var conditions := ExpeditionConditionScript.all_conditions()
	if conditions.is_empty():
		return {}

	for index in range(conditions.size()):
		if String(conditions[index].get("id", "")) == current_id:
			return conditions[(index + 1) % conditions.size()].duplicate(true)

	return conditions[0].duplicate(true)

func _debug_seed_for_delta(seed: int, delta: int) -> int:
	return maxi(1, seed + delta)

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

	if _upgrade_missing_upgrade(upgrade) != "":
		upgrade_menu_feedback = "Missing upgrade: %s. %s" % [
			_format_upgrade_display_name(upgrade.required_upgrade),
			upgrade.locked_reason
		]
		status_label.text = "%s is locked by an upgrade prerequisite." % upgrade.display_name
		_update_hud()
		return

	if UpgradePurchaseScript.purchase(progression_state, upgrade):
		_apply_upgrade_effect(upgrade.effect_id)
		upgrade_menu_feedback = "Purchased %s. %s" % [upgrade.display_name, upgrade.owned_text]
		_save_progression()
		status_label.text = "Purchased %s." % upgrade.display_name
	else:
		upgrade_menu_feedback = "Still missing: %s\nBanked:%s" % [
			_format_missing_resources_inline(upgrade.resource_cost),
			_format_banked_resources(),
		]
		status_label.text = "%s needs more banked resources." % upgrade.display_name

	_update_hud()

func _try_burst_thruster() -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	if burst_thruster_cooldown_remaining > 0.0:
		status_label.text = "Burst Thruster cooling down: %ds." % ceili(burst_thruster_cooldown_remaining)
		_update_hud()
		return

	if dive_session.oxygen <= burst_thruster_oxygen_cost:
		status_label.text = "Burst Thruster needs more than %d oxygen." % ceili(burst_thruster_oxygen_cost)
		_update_hud()
		return

	var burst_direction: Vector2 = player.get_burst_direction()
	player.burst(burst_direction, burst_thruster_force)
	dive_session.drain_oxygen(burst_thruster_oxygen_cost)
	burst_thruster_cooldown_remaining = burst_thruster_cooldown_seconds
	status_label.text = "Burst Thruster: -%d oxygen. Cooldown started." % ceili(burst_thruster_oxygen_cost)
	_update_hud()

func _apply_upgrade_effect(effect_id: String) -> void:
	match effect_id:
		"max_oxygen_40":
			pass
		"open_pressure_wreck":
			_sync_pressure_lock_state()
		"resource_signal_pulse":
			pass
		"cargo_limit_4":
			dive_session.cargo_limit = _current_cargo_limit()
		"predator_warning_range_1":
			_sync_predator_warning_upgrade_state()
		"decoy_pulse_1":
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
		status_label.text = _compact_dive_status("%s known.%s" % [
			display_name,
			_format_repeat_scan_effect_text(target) + _format_signal_lens_pulse_text(target)
		])
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
		status_label.text = _compact_dive_status("Scanned %s.%s" % [
			display_name,
			_format_repeat_scan_effect_text(target) + _format_first_scan_guidance(target)
		])
		_update_hud()

func _nearest_scan_target() -> Node:
	var candidates: Array[Node] = []
	for target in get_tree().get_nodes_in_group("scan_targets"):
		candidates.append(target)

	return ScanTargetResolverScript.nearest(player.global_position, scan_range, candidates)

func _scan_target_id(target: Node) -> String:
	return ScanTargetResolverScript.target_id(target)

func _scan_target_display_name(target: Node) -> String:
	return ScanTargetResolverScript.display_name(target)

func _scan_target_description(target: Node) -> String:
	return ScanTargetResolverScript.description(target)

func _scan_target_gameplay_fact(target: Node) -> String:
	if target is ResourcePickup:
		return "Depth: %s. Upgrade use: %s. %s" % [
			_format_depth_band(target.definition.depth_band),
			target.definition.upgrade_use,
			_format_resource_upgrade_need(target.definition.id)
		]

	return String(target.get("gameplay_fact"))

func _activate_scan_effect(target: Node) -> void:
	decoy_pulse_activated_this_scan = false
	if target is ResourcePickup:
		resource_scan_highlight_id = target.definition.id
		resource_scan_highlight_timer = 8.0
	elif _scan_target_id(target) == "lantern_fry":
		glow_plankton_highlight_timer = 8.0
	elif _scan_target_id(target) == "thermal_vent":
		_reveal_thermal_vent_route()
	elif _scan_target_id(target) == "pressure_wreck_signal":
		_reveal_pressure_wreck_signal()
	elif _scan_target_id(target) == "gulper_eel":
		_try_trigger_decoy_pulse()

func _try_trigger_decoy_pulse() -> bool:
	if not progression_state.has_upgrade(DECOY_PULSE_UPGRADE_ID):
		return false
	if decoy_pulse_used_this_run:
		return false
	if gulper_eel == null or not gulper_eel.has_method("trigger_decoy_from"):
		return false

	gulper_eel.trigger_decoy_from(player.global_position, decoy_pulse_duration_seconds, decoy_pulse_pull_distance)
	decoy_pulse_used_this_run = true
	decoy_pulse_activated_this_scan = true
	status_label.text = "Decoy Pulse: Gulper Eel distracted briefly."
	return true

func _format_repeat_scan_effect_text(target: Node) -> String:
	if target is ResourcePickup:
		return " Matching %s deposits highlighted." % target.definition.display_name
	elif _scan_target_id(target) == "lantern_fry":
		return " Nearby Glow Plankton pulsed again."
	elif _scan_target_id(target) == "thermal_vent":
		return " Warm clue refreshed; glow route optional."
	elif _scan_target_id(target) == "shell_reef_shelf":
		return " Reef route clue refreshed."
	elif _scan_target_id(target) == "wreck_signal_cache":
		if progression_state.has_upgrade(SIGNAL_LENS_UPGRADE_ID):
			return " Echo trace unresolved: future Echo Lens study may read deeper wreck signals."
		return " Cache clue refreshed for Signal Lens I."
	elif _scan_target_id(target) == "gulper_eel":
		return " %s" % _format_decoy_pulse_scan_feedback()

	return ""

func _format_signal_lens_pulse_text(target: Node) -> String:
	if not progression_state.has_upgrade(SIGNAL_LENS_UPGRADE_ID) or not target is ResourcePickup:
		return ""

	var match_target: ResourcePickup = _nearest_matching_visible_resource(target)
	if match_target == null:
		return " Signal Lens quiet: no matching visible deposits."

	return " Signal Lens pulse leans %s toward another %s." % [
		_format_direction_to(match_target.global_position),
		target.definition.display_name
	]

func _nearest_matching_visible_resource(source: ResourcePickup) -> ResourcePickup:
	var nearest: ResourcePickup = null
	var nearest_distance := INF
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		if pickup == source or not pickup is ResourcePickup:
			continue
		if pickup.definition == null or source.definition == null:
			continue
		if pickup.definition.id != source.definition.id:
			continue
		if pickup.is_collected or not pickup.visible:
			continue

		var distance := source.global_position.distance_to(pickup.global_position)
		if distance < nearest_distance:
			nearest = pickup
			nearest_distance = distance

	return nearest

func _format_direction_to(target_position: Vector2) -> String:
	var delta := target_position - player.global_position
	var horizontal := ""
	if absf(delta.x) > 48.0:
		horizontal = "right" if delta.x > 0.0 else "left"

	var vertical := ""
	if absf(delta.y) > 48.0:
		vertical = "deeper" if delta.y > 0.0 else "up"

	if not horizontal.is_empty() and not vertical.is_empty():
		return "%s-%s" % [vertical, horizontal]
	elif not vertical.is_empty():
		return vertical
	elif not horizontal.is_empty():
		return horizontal

	return "nearby"

func _format_first_scan_guidance(target: Node) -> String:
	if target is ResourcePickup:
		if dive_session.current_cargo.size() >= dive_session.cargo_limit:
			return " Cargo full: return to base to bank before collecting more."
		elif dive_session.current_cargo.size() == dive_session.cargo_limit - 1:
			return " Collect it if it is worth the last slot, then return to base to bank cargo."

		return " Collect it, then return to base to bank cargo."

	match _scan_target_id(target):
		"lantern_fry":
			return " Follow the plankton pulse if oxygen allows, then return to base."
		"thermal_vent":
			return " Warm current marks optional glow; bank Pressure Seal clue."
		"shell_reef_shelf":
			return " Reef marks a safer midwater bank route."
		"pressure_wreck_signal":
			if progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID):
				return " Pressure Seal active: enter and scan cache if oxygen allows."

			return " Locked: buy Pressure Seal I, then return."
		"wreck_signal_cache":
			return " Bank cache clue for future scanner upgrades."
		"gulper_eel":
			return " Time warning current, or return with cargo."
		_:
			return " Use the clue if it helps, then return to base before oxygen runs out."

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

func _update_burst_thruster_cooldown(delta: float) -> void:
	if burst_thruster_cooldown_remaining <= 0.0:
		return

	burst_thruster_cooldown_remaining = maxf(0.0, burst_thruster_cooldown_remaining - delta)

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

func _on_pressure_boundary_body_entered(body: Node2D) -> void:
	if body != player or progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID):
		return

	player.global_position.x = minf(player.global_position.x, pressure_boundary.global_position.x - 86.0)
	player.velocity = Vector2(-120.0, -60.0)
	status_label.text = "Pressure route locked: buy Pressure Seal I at the surface, then return."
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
	return SpawnSelectionScript.cluster_pattern_for_seed(seed, RESOURCE_CLUSTER_PATTERNS)

func _spawn_positions_for_target(category: String, target_id: String, cluster_pattern: String) -> Array[Vector2]:
	return SpawnSelectionScript.positions_for_target(starter_resource_candidates, SpawnPointScript, category, target_id, cluster_pattern, _current_condition_id())

func _spawn_routes_for_target(category: String, target_id: String, cluster_pattern: String) -> Dictionary:
	return SpawnSelectionScript.routes_for_target(creature_route_candidates, SpawnPointScript, category, target_id, cluster_pattern)

func _sync_condition_visuals() -> void:
	var condition_id := _current_condition_id()
	var is_thermal_bloom := condition_id == "thermal_bloom"
	var is_calm_current := condition_id == "calm_current"
	base_return_column.color = Color(0.38, 1.0, 0.9, 0.18) if is_calm_current else Color(0.38, 1.0, 0.9, 0.14)
	base_return_rib_shallow.color = Color(0.62, 1.0, 0.9, 0.22) if is_calm_current else Color(0.62, 1.0, 0.9, 0.18)
	base_return_rib_midwater.color = Color(0.62, 1.0, 0.9, 0.2) if is_calm_current else Color(0.62, 1.0, 0.9, 0.16)
	base_return_rib_deep.color = Color(0.62, 1.0, 0.9, 0.19) if is_calm_current else Color(0.62, 1.0, 0.9, 0.15)
	base_return_beacon.color = Color(0.74, 1.0, 0.9, 0.42) if is_calm_current else Color(0.74, 1.0, 0.9, 0.34)
	base_return_beacon_rib.color = Color(0.62, 1.0, 0.9, 0.26) if is_calm_current else Color(0.62, 1.0, 0.9, 0.2)
	thermal_warm_wash.color = Color(0.98, 0.52, 0.18, 0.26) if is_thermal_bloom else Color(0.92, 0.44, 0.16, 0.18)
	thermal_heat_plume.color = Color(1.0, 0.68, 0.24, 0.38) if is_thermal_bloom else Color(1.0, 0.62, 0.2, 0.28)
	thermal_bubble_string_a.color = Color(1.0, 1.0, 0.84, 0.46) if is_thermal_bloom else Color(0.96, 1.0, 0.82, 0.34)
	thermal_bubble_string_b.color = Color(1.0, 1.0, 0.84, 0.4) if is_thermal_bloom else Color(0.96, 1.0, 0.82, 0.28)
	thermal_vent_visual.color = Color(1.0, 0.5, 0.18, 1.0) if is_thermal_bloom else Color(0.96, 0.46, 0.16, 0.9)
	thermal_vent_bubbles.color = Color(0.98, 1.0, 0.86, 0.46) if is_thermal_bloom else Color(0.9, 1.0, 0.86, 0.34)

func _current_condition_id() -> String:
	return String(current_expedition_condition.get("id", ""))

func _sync_discovery_reveals() -> void:
	if progression_state.has_discovery("thermal_vent"):
		_reveal_thermal_vent_route()
	else:
		hidden_glow_plankton.visible = false
		hidden_glow_plankton.monitoring = false
		vent_route_hint.visible = false

	if progression_state.has_discovery("pressure_wreck_signal"):
		_reveal_pressure_wreck_signal()
	else:
		wreck_signal_hint.visible = false

	_sync_pressure_lock_state()
	_sync_predator_warning_upgrade_state()

func _reveal_thermal_vent_route() -> void:
	hidden_glow_plankton.visible = true
	hidden_glow_plankton.monitoring = true
	vent_route_hint.visible = true

func _reveal_pressure_wreck_signal() -> void:
	wreck_signal_hint.visible = true

func _sync_pressure_lock_state() -> void:
	var has_pressure_seal := progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID)
	pressure_boundary.monitoring = not has_pressure_seal
	pressure_boundary.monitorable = not has_pressure_seal
	if has_pressure_seal:
		pressure_shimmer.modulate = Color(0.62, 1.0, 0.72, 0.38)
		pressure_gate_top.color = Color(0.62, 1.0, 0.72, 0.28)
		pressure_gate_bottom.color = Color(0.62, 1.0, 0.72, 0.28)
		pressure_gate_bar_a.color = Color(0.62, 1.0, 0.72, 0.16)
		pressure_gate_bar_b.color = Color(0.62, 1.0, 0.72, 0.16)
		pressure_gate_bar_c.color = Color(0.62, 1.0, 0.72, 0.16)
		pressure_gate_left_rail.color = Color(0.32, 0.86, 0.58, 0.22)
		pressure_gate_right_rail.color = Color(0.32, 0.86, 0.58, 0.22)
		pressure_lock_badge.color = Color(0.62, 1.0, 0.72, 0.72)
		pressure_label.text = "OPEN"
	else:
		pressure_shimmer.modulate = Color.WHITE
		pressure_gate_top.color = Color(0.74, 0.86, 1.0, 0.72)
		pressure_gate_bottom.color = Color(0.74, 0.86, 1.0, 0.72)
		pressure_gate_bar_a.color = Color(0.74, 0.86, 1.0, 0.62)
		pressure_gate_bar_b.color = Color(0.74, 0.86, 1.0, 0.62)
		pressure_gate_bar_c.color = Color(0.74, 0.86, 1.0, 0.62)
		pressure_gate_left_rail.color = Color(0.26, 0.48, 0.8, 0.5)
		pressure_gate_right_rail.color = Color(0.26, 0.48, 0.8, 0.5)
		pressure_lock_badge.color = Color(0.74, 0.86, 1.0, 0.72)
		pressure_label.text = "LOCKED"

func _sync_predator_warning_upgrade_state() -> void:
	var multiplier := predator_warning_1_multiplier if progression_state.has_upgrade(PREDATOR_WARNING_UPGRADE_ID) else 1.45
	if gulper_eel != null and gulper_eel.has_method("set_warning_radius_multiplier"):
		gulper_eel.set_warning_radius_multiplier(multiplier)

func _update_hud() -> void:
	_update_scan_target_feedback()
	_update_run_panel()
	_update_upgrade_menu()
	var is_diving := dive_session.result == DiveSessionScript.Result.DIVING
	var has_surface_panel := dive_session.result != DiveSessionScript.Result.DIVING
	hint_label.visible = false
	bounds_hint_label.visible = false
	oxygen_label.visible = is_diving
	depth_label.visible = is_diving
	base_direction_label.visible = is_diving
	cargo_label.visible = is_diving
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
		_format_cargo_counts_inline(dive_session.current_cargo)
	]
	bank_label.text = "Banked:%s" % _format_banked_resources()
	upgrade_label.text = _format_upgrade_status()
	discoveries_label.text = _format_discoveries(true)
	recent_expedition_log_label.text = _format_recent_expedition_log()
	bank_label.visible = false
	upgrade_label.visible = false
	recent_expedition_log_label.visible = false
	discoveries_label.visible = not has_surface_panel
	dive_info_panel.visible = is_diving
	scan_target_label.visible = is_diving
	status_label.visible = is_diving
	prompt_label.visible = is_diving
	status_label.text = _compact_dive_status(status_label.text) if is_diving else status_label.text

	if dive_session.result == DiveSessionScript.Result.READY:
		prompt_label.text = "Press E or Enter to begin the dive"
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		if _all_upgrades_owned():
			prompt_label.text = "Extraction complete - press R for next expedition | Left/Right surface view"
		elif surface_tab_index == SURFACE_TAB_UPGRADES:
			prompt_label.text = "Upgrade bay: Up/Down select, E purchase, R next expedition | Left/Right surface view"
		else:
			prompt_label.text = "Extraction complete - press E for upgrades, R next expedition | Left/Right surface view"
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		prompt_label.text = "Expedition failed - press R for next expedition"
	elif player_in_base:
		if dive_session.has_left_base:
			prompt_label.text = "Safe base: press E or Enter to extract"
		else:
			prompt_label.text = "Leave the moonpool, then return to extract"
	else:
		prompt_label.text = "Explore, then return to base"

	if dive_session.result == DiveSessionScript.Result.DIVING:
		prompt_label.text += " | %s" % _format_burst_thruster_prompt()
		var decoy_prompt := _format_decoy_pulse_prompt()
		if not decoy_prompt.is_empty():
			prompt_label.text += " | %s" % decoy_prompt

func _update_run_panel() -> void:
	surface_tabs_label.visible = _surface_tabs_enabled()
	surface_tabs_label.text = _format_surface_tabs() if surface_tabs_label.visible else ""
	if dive_session.result == DiveSessionScript.Result.READY:
		run_panel.visible = true
		run_title_label.text = _format_expedition_day_title("Ready")
		run_summary_label.text = _format_run_summary("Move with WASD or arrow keys.\nStart with %d oxygen. Collect, scan, or push deeper, then return to bank cargo.\n%s\n%s\nPress E or Enter to begin.\nF9 resets prototype save." % [
			ceili(dive_session.max_oxygen),
			_format_condition_briefing(),
			ExpeditionGoalFormatterScript.format_goal(progression_state, upgrade_definitions),
		], "ready")
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		run_panel.visible = true
		if surface_tab_index == SURFACE_TAB_UPGRADES:
			run_title_label.text = "Surface Upgrade Bay"
			run_summary_label.text = _format_run_summary("Banked:%s\nSelect an upgrade below, then press E or Enter to purchase.\n%s" % [
				_format_banked_resources(),
				_format_next_expedition_prompt(),
			], "extracted")
		elif surface_tab_index == SURFACE_TAB_LOG:
			run_title_label.text = "Recent Expeditions"
			run_summary_label.text = _format_recent_expedition_log()
		else:
			run_title_label.text = _format_expedition_day_title("Result: Extraction")
			run_summary_label.text = _format_run_summary(last_result_summary, "extracted")
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		run_panel.visible = true
		if surface_tab_index == SURFACE_TAB_LOG:
			run_title_label.text = "Recent Expeditions"
			run_summary_label.text = _format_recent_expedition_log()
		else:
			run_title_label.text = _format_expedition_day_title("Result: Failure")
			run_summary_label.text = _format_run_summary(last_result_summary, "failed")
	else:
		run_panel.visible = false

func _update_upgrade_menu() -> void:
	upgrade_panel.visible = dive_session.result == DiveSessionScript.Result.EXTRACTED and surface_tab_index == SURFACE_TAB_UPGRADES
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

func _format_cargo_counts_inline(resource_ids: Array[String]) -> String:
	if resource_ids.is_empty():
		return ""

	var counts := {}
	for resource_id in resource_ids:
		counts[resource_id] = int(counts.get(resource_id, 0)) + 1

	var parts: Array[String] = []
	for resource_id in counts.keys():
		parts.append("%s x%d" % [_short_resource_name(resource_id), int(counts[resource_id])])

	return " - " + ", ".join(parts)

func _short_resource_name(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp"
		"shell_fragments":
			return "Shell"
		"glow_plankton":
			return "Glow"
		_:
			return resource_id

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
	var owned_count := 0
	for upgrade in upgrade_definitions:
		if progression_state.has_upgrade(upgrade.id):
			owned_count += 1

	return "Upgrades: %d / %d installed" % [owned_count, upgrade_definitions.size()]

func _format_burst_thruster_prompt() -> String:
	if burst_thruster_cooldown_remaining > 0.0:
		return "Burst cooldown: %ds" % ceili(burst_thruster_cooldown_remaining)

	return "Space burst: %d oxygen" % ceili(burst_thruster_oxygen_cost)

func _format_decoy_pulse_prompt() -> String:
	if progression_state.has_upgrade(DECOY_PULSE_UPGRADE_ID):
		return "Decoy: spent" if decoy_pulse_used_this_run else "F on Gulper: Decoy ready"
	if progression_state.has_discovery("gulper_eel"):
		return "Decoy: locked in upgrades"

	return ""

func _format_decoy_pulse_scan_feedback() -> String:
	if not progression_state.has_upgrade(DECOY_PULSE_UPGRADE_ID):
		return "Predator route warning refreshed. Decoy Pulse unavailable."
	if decoy_pulse_activated_this_scan:
		return "Decoy Pulse spent: predator distracted for %ds." % ceili(decoy_pulse_duration_seconds)
	if decoy_pulse_used_this_run:
		return "Predator route warning refreshed. Decoy Pulse already spent this expedition."

	return "Predator route warning refreshed. Decoy Pulse ready on re-scan."

func _surface_tabs_enabled() -> bool:
	return dive_session.result == DiveSessionScript.Result.EXTRACTED

func _format_surface_tabs() -> String:
	var parts: Array[String] = []
	for index in range(SURFACE_TAB_NAMES.size()):
		var tab_name: String = SURFACE_TAB_NAMES[index]
		if index == surface_tab_index:
			parts.append("[%s]" % tab_name)
		else:
			parts.append(tab_name)

	return "  ".join(parts)

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
		return "State: Owned\n%s" % upgrade.owned_text

	var missing_discovery := _upgrade_missing_discovery(upgrade)
	if missing_discovery != "":
		return "State: Locked by scan\nNeeds scan: %s\nMissing resources: %s" % [
			_format_discovery_name(missing_discovery),
			_format_missing_resources_inline(upgrade.resource_cost)
		]

	var missing_upgrade := _upgrade_missing_upgrade(upgrade)
	if missing_upgrade != "":
		return "State: Locked by upgrade\nNeeds upgrade: %s\nMissing resources: %s" % [
			_format_upgrade_display_name(missing_upgrade),
			_format_missing_resources_inline(upgrade.resource_cost)
		]

	if progression_state.can_afford(upgrade.resource_cost):
		return "State: Available now\nAction: press E or Enter to buy\nEffect: %s" % upgrade.owned_text

	return "State: Missing resources\nNeeds: %s\nEffect: %s" % [
		_format_missing_resources_inline(upgrade.resource_cost),
		upgrade.owned_text
	]

func _format_ready_upgrade_callout() -> String:
	var ready: Array[String] = []
	for upgrade in upgrade_definitions:
		if progression_state.has_upgrade(upgrade.id):
			continue
		if _upgrade_missing_discovery(upgrade) != "":
			continue
		if _upgrade_missing_upgrade(upgrade) != "":
			continue
		if progression_state.can_afford(upgrade.resource_cost):
			ready.append(upgrade.display_name)

	if ready.is_empty():
		return "No upgrade ready yet; check missing requirements below."

	return "Ready upgrade: %s." % ", ".join(ready)

func _format_upgrade_progress_callout() -> String:
	for upgrade in upgrade_definitions:
		if progression_state.has_upgrade(upgrade.id):
			continue

		var missing_discovery := _upgrade_missing_discovery(upgrade)
		if missing_discovery != "":
			return "Upgrade progress: scan %s to unlock %s." % [
				_format_discovery_name(missing_discovery),
				upgrade.display_name,
			]

		var missing_upgrade := _upgrade_missing_upgrade(upgrade)
		if missing_upgrade != "":
			return "Upgrade progress: buy %s before %s." % [
				_format_upgrade_display_name(missing_upgrade),
				upgrade.display_name,
			]

		var missing_resources := _format_missing_resources_inline(upgrade.resource_cost)
		if missing_resources == "none":
			return "Upgrade progress: %s ready to buy." % upgrade.display_name

		return "Upgrade progress: %s still needs %s." % [
			upgrade.display_name,
			missing_resources,
		]

	return "Upgrade progress: all current upgrades installed."

func _format_missing_resources_inline(cost: Dictionary) -> String:
	var parts: Array[String] = []
	for resource_id in cost.keys():
		var missing: int = int(cost[resource_id]) - progression_state.resource_count(resource_id)
		if missing > 0:
			parts.append("%s x%d" % [_display_name_for_resource(resource_id), missing])

	return "none" if parts.is_empty() else ", ".join(parts)

func _format_scan_progress_callout(prefix: String) -> String:
	if run_completed_scans.is_empty():
		return "%s: none this dive." % prefix

	var parts: Array[String] = []
	for discovery_id in run_completed_scans:
		parts.append(_format_discovery_name(discovery_id))

	return "%s: %s." % [prefix, ", ".join(parts)]

func _upgrade_missing_discovery(upgrade: UpgradeDefinition) -> String:
	return UpgradePurchaseScript.missing_discovery(progression_state, upgrade)

func _upgrade_missing_upgrade(upgrade: UpgradeDefinition) -> String:
	return UpgradePurchaseScript.missing_upgrade(progression_state, upgrade)

func _format_upgrade_display_name(upgrade_id: String) -> String:
	for upgrade in upgrade_definitions:
		if upgrade.id == upgrade_id:
			return upgrade.display_name

	match upgrade_id:
		PREDATOR_WARNING_UPGRADE_ID:
			return "Predator Warning I"
		DECOY_PULSE_UPGRADE_ID:
			return "Decoy Pulse I"
		_:
			return upgrade_id

func _format_discovery_name(discovery_id: String) -> String:
	if discovery_id.is_empty():
		return "none"

	var discovery: Dictionary = progression_state.scan_discoveries.get(discovery_id, {})
	if not discovery.is_empty():
		return String(discovery.get("display_name", discovery_id))

	match discovery_id:
		"thermal_vent":
			return "Thermal Vent"
		"shell_reef_shelf":
			return "Shell Reef Shelf"
		"pressure_wreck_signal":
			return "Pressure-Locked Research Wreck"
		"wreck_signal_cache":
			return "Wreck Signal Cache"
		"gulper_eel":
			return "Gulper Eel"
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
	return "\n\nPlaytest data:\nResult: %s\nSeed: %d\nPattern: %s\nCondition: %s\nPredator route: %s\nCargo collected:%s\nScans: %s\nPredator contacts: %d\nOxygen at result: %d / %d\nFailure cause: %s" % [
		result_name,
		progression_state.current_run_seed,
		_format_cluster_pattern(current_resource_cluster_pattern),
		_format_condition_telemetry(),
		current_predator_route_id,
		_format_resource_counts(run_collected_resources),
		_format_scan_ids(run_completed_scans),
		run_predator_contacts,
		ceili(dive_session.oxygen),
		ceili(dive_session.max_oxygen),
		run_failure_cause
	]

func _format_condition_telemetry() -> String:
	if current_expedition_condition.is_empty():
		return "none"

	return "%s (%s)" % [
		String(current_expedition_condition.get("display_name", "Unknown")),
		String(current_expedition_condition.get("id", "unknown")),
	]

func _format_run_summary(player_summary: String, result_name: String) -> String:
	if not show_debug_telemetry:
		return player_summary

	return "%s\n%s" % [player_summary, _format_run_telemetry(result_name)]

func _format_next_expedition_prompt() -> String:
	return "Next: press R to prepare Expedition %d; the ocean will shift again." % (progression_state.current_run_number + 1)

func _format_expedition_ready_status() -> String:
	return "Expedition %d ready: the ocean changed overnight." % progression_state.current_run_number

func _format_expedition_day_title(suffix: String) -> String:
	return "Expedition Day %d %s" % [
		progression_state.current_run_number,
		suffix,
	]

func _format_completed_expedition_line(result_name: String) -> String:
	return "Expedition Day %d complete: %s." % [
		progression_state.current_run_number,
		result_name,
	]

func _format_condition_briefing() -> String:
	if current_expedition_condition.is_empty():
		return "Today: no unusual activity."

	var condition_id := _current_condition_id()
	var display_name := String(current_expedition_condition.get("display_name", "Unknown"))
	match condition_id:
		"calm_current":
			return "Today: %s.\nReturn currents are clearer near base." % display_name
		"thermal_bloom":
			return "Today: %s.\nVent-warmed routes may point toward extra glow." % display_name
		"kelp_bloom":
			return "Today: %s.\nShallow growth is thicker; scan and bank what you can see." % display_name
		"predator_migration":
			return "Today: %s.\nExpect the Gulper route to feel active; watch warning cues." % display_name
		"low_visibility":
			return "Today: %s.\nTreat deep routes as harder to read and bank early if unsure." % display_name
		"rare_signal":
			return "Today: %s.\nA weak research ping is worth checking if oxygen allows." % display_name
		"wreck_shift":
			return "Today: %s.\nThe pressure wreck route is the notable landmark today." % display_name

	return "Today: %s.\n%s" % [
		display_name,
		String(current_expedition_condition.get("briefing", "")),
	]

func _format_route_choice_callout() -> String:
	if run_predator_contacts > 0:
		return "Route choice: predator route contested the dive."
	if run_completed_scans.has("wreck_signal_cache"):
		return "Route choice: pressure-wreck progress secured."
	if run_completed_scans.has("pressure_wreck_signal"):
		return "Route choice: pressure route marked for a future return."
	if run_completed_scans.has("thermal_vent") and run_collected_resources.has("glow_plankton"):
		return "Route choice: followed Thermal Vent clue toward deep glow."
	if run_completed_scans.has("thermal_vent"):
		return "Route choice: banked Thermal Vent clue for Pressure Seal I."
	if run_collected_resources.has("glow_plankton") and current_resource_cluster_pattern == "deep_reward":
		return "Route choice: pushed past the reef toward deep glow."
	if run_completed_scans.has("shell_reef_shelf") or run_collected_resources.has("shell_fragments"):
		return "Route choice: used Shell Reef as a midwater bank route."
	if run_collected_resources.is_empty():
		return "Route choice: returned without banking cargo."

	return "Route choice: banked a cautious resource run."

func _format_gulper_research_callout() -> String:
	if decoy_pulse_used_this_run:
		return "\nResearch: Decoy timing bent the Gulper route briefly."
	if run_predator_contacts > 0:
		return "\nResearch: Gulper strike confirms the warning lane is dangerous."
	if run_completed_scans.has("gulper_eel"):
		return "\nResearch: Gulper route timing observed."

	return ""

func _format_region_memory_callout() -> String:
	if run_predator_contacts > 0 or run_completed_scans.has("gulper_eel"):
		return "Remembered place: Gulper Route - warning-lane timing matters."
	if run_completed_scans.has("wreck_signal_cache") or run_completed_scans.has("pressure_wreck_signal"):
		return "Remembered place: Wreck Shelf - pressure-route signals are worth returning to."
	if run_completed_scans.has("thermal_vent") or run_collected_resources.has("glow_plankton"):
		return "Remembered place: Thermal Vent Field - warm clues can lead toward deeper glow."
	if run_completed_scans.has("shell_reef_shelf") or run_collected_resources.has("shell_fragments"):
		return "Remembered place: Shell Reef - a safer midwater bank route."

	return "Remembered place: Surface Base - safe return resolves the day."

func _format_discovery_memory_callout() -> String:
	if run_completed_scans.has("wreck_signal_cache"):
		return "\nDiscovery remembered: Wreck Signal Cache - deeper echoes may be readable later."
	if run_completed_scans.has("pressure_wreck_signal"):
		return "\nDiscovery remembered: Pressure-Locked Research Wreck - pressure access can open this route."
	if run_completed_scans.has("gulper_eel"):
		return "\nDiscovery remembered: Gulper Eel - warning-lane behavior can be studied."
	if run_completed_scans.has("thermal_vent"):
		return "\nDiscovery remembered: Thermal Vent - pressure-seal knowledge is banked."
	if run_completed_scans.has("shell_reef_shelf"):
		return "\nDiscovery remembered: Shell Reef Shelf - safer midwater banking route marked."

	return ""

func _format_scan_ids(scan_ids: Array[String]) -> String:
	if scan_ids.is_empty():
		return "none"

	var parts: Array[String] = []
	for scan_id in scan_ids:
		parts.append(scan_id)

	return ", ".join(parts)

func _record_recent_expedition(result_name: String, banked_cargo_count: int) -> void:
	recent_expedition_log.append({
		"run_number": progression_state.current_run_number,
		"result": result_name,
		"banked_cargo_count": banked_cargo_count,
		"scans": run_completed_scans.duplicate(),
		"predator_contacts": run_predator_contacts,
		"best_depth": roundi(progression_state.best_depth_reached),
		"seed": progression_state.current_run_seed,
		"pattern": _format_cluster_pattern(current_resource_cluster_pattern),
	})

	while recent_expedition_log.size() > 3:
		recent_expedition_log.pop_front()

func _format_recent_expedition_log() -> String:
	if recent_expedition_log.is_empty():
		return "Recent Expeditions\nNone yet."

	var lines: Array[String] = ["Recent Expeditions"]
	for entry in recent_expedition_log:
		var line := "#%d %s: banked %d, scans %s, contacts %d, best %dm" % [
			int(entry.get("run_number", 0)),
			String(entry.get("result", "Unknown")),
			int(entry.get("banked_cargo_count", 0)),
			_format_scan_names_short(_string_array_from(entry.get("scans", []))),
			int(entry.get("predator_contacts", 0)),
			int(entry.get("best_depth", 0)),
		]
		if show_debug_telemetry:
			line += " | seed %d, %s" % [
				int(entry.get("seed", 0)),
				String(entry.get("pattern", "unknown")),
			]
		lines.append(line)

	return "\n".join(lines)

func _format_scan_names_short(scan_ids: Array[String]) -> String:
	if scan_ids.is_empty():
		return "none"

	var parts: Array[String] = []
	for scan_id in scan_ids:
		parts.append(_format_discovery_name(scan_id))

	return "/".join(parts)

func _string_array_from(value: Variant) -> Array[String]:
	var result: Array[String] = []
	if not value is Array:
		return result

	for item in value:
		result.append(String(item))

	return result

func _format_discoveries(compact: bool = false) -> String:
	var discoveries := progression_state.scan_discoveries
	var text := "Discoveries: %d" % discoveries.size()
	if compact:
		return text
	if discoveries.is_empty():
		return text + "\n???"

	for discovery in discoveries.values():
		text += "\n%s - %s" % [discovery["display_name"], discovery["gameplay_fact"]]

	return text

func _compact_dive_status(text: String) -> String:
	var cleaned := text.replace("\n", " ").strip_edges()
	while cleaned.find("  ") != -1:
		cleaned = cleaned.replace("  ", " ")

	if cleaned.length() <= DIVE_STATUS_MAX_CHARS:
		return cleaned

	return cleaned.substr(0, DIVE_STATUS_MAX_CHARS - 3).strip_edges() + "..."

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
		scan_target_label.text = "Scan target: %s [%s %s]" % [
			_scan_target_display_name(current_scan_target),
			_format_scan_target_discovery_state(current_scan_target),
			_format_scan_target_type(current_scan_target)
		]

func _format_scan_target_discovery_state(target: Node) -> String:
	return "known" if progression_state.has_discovery(_scan_target_id(target)) else "new"

func _format_scan_target_type(target: Node) -> String:
	if target is ResourcePickup:
		return "resource"

	match _scan_target_id(target):
		"lantern_fry":
			return "creature"
		"gulper_eel":
			return "creature"
		"thermal_vent":
			return "environment"
		"shell_reef_shelf":
			return "environment"
		"pressure_wreck_signal", "wreck_signal_cache":
			return "wreck signal"
		_:
			return "clue"

func _current_max_oxygen() -> float:
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		return oxygen_tank_1_max_oxygen

	return max_oxygen

func _current_cargo_limit() -> int:
	if progression_state.has_upgrade(CARGO_RACK_UPGRADE_ID):
		return cargo_rack_1_limit

	return base_cargo_limit

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

func _delete_progression_save() -> void:
	if not FileAccess.file_exists(PROGRESSION_SAVE_PATH):
		return

	var save_dir := DirAccess.open("user://")
	if save_dir == null:
		push_warning("Could not open user save directory to reset progression.")
		return

	var error := save_dir.remove("progression_save.json")
	if error != OK:
		push_warning("Could not delete progression save; clean save will be overwritten.")
