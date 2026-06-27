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
const ECHO_LENS_UPGRADE := preload("res://resources/upgrades/echo_lens_1.tres")
const RESONANCE_KEY_UPGRADE := preload("res://resources/upgrades/resonance_key_1.tres")
const CARGO_RACK_UPGRADE := preload("res://resources/upgrades/cargo_rack_1.tres")
const PREDATOR_WARNING_UPGRADE := preload("res://resources/upgrades/predator_warning_1.tres")
const DECOY_PULSE_UPGRADE := preload("res://resources/upgrades/decoy_pulse_1.tres")

const OXYGEN_TANK_UPGRADE_ID := "oxygen_tank_1"
const PRESSURE_SEAL_UPGRADE_ID := "pressure_seal_1"
const SIGNAL_LENS_UPGRADE_ID := "signal_lens_1"
const ECHO_LENS_UPGRADE_ID := "echo_lens_1"
const RESONANCE_KEY_UPGRADE_ID := "resonance_key_1"
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
const KEYBOARD_ACTION_LABELS := {
	"interact": "E/Enter",
	"restart_dive": "R",
	"move_left_right": "Left/Right",
	"move_up_down": "Up/Down",
	"burst_thruster": "Space",
	"decoy_pulse": "F",
}
const DIVE_RESULT_NAMES := {
	DiveSessionScript.Result.READY: "ready",
	DiveSessionScript.Result.DIVING: "diving",
	DiveSessionScript.Result.EXTRACTED: "extracted",
	DiveSessionScript.Result.FAILED: "failed",
}
const RUN_PANEL_COMPACT_RECT := Rect2(Vector2(420.0, 32.0), Vector2(452.0, 330.0))
const RUN_PANEL_TALL_RECT := Rect2(Vector2(44.0, 32.0), Vector2(806.0, 640.0))
const RUN_SUMMARY_COMPACT_BOTTOM := 314.0
const RUN_SUMMARY_TALL_BOTTOM := 624.0
const RUN_PANEL_CONTENT_RIGHT_COMPACT := 442.0
const RUN_PANEL_CONTENT_RIGHT_TALL := 790.0
const DIVE_STATUS_MAX_CHARS := 76
const ECHO_LENS_PULSE_DURATION := 1.2
const EAST_SHELF_SURGE_PERIOD_SECONDS := 2.4
const BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS := 2.9
const BLACKWATER_PRESSURE_PERIOD_SECONDS := 3.1
const LANTERN_RAY_TIMING_PERIOD_SECONDS := 2.6
const DUSK_TRENCH_MEMORY_MIN_X := 2700.0
const DUSK_TRENCH_MEMORY_MIN_Y := 2860.0

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
@export var start_position := Vector2(640.0, 260.0)
@export var surface_y := 120.0
@export var pixels_per_meter := 10.0
@export var show_debug_telemetry := false

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var hint_label: Label = $HUD/Hint
@onready var bounds_hint_label: Label = $HUD/BoundsHint
@onready var active_stats_panel: Panel = $HUD/ActiveStatsPanel
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var depth_label: Label = $HUD/Depth
@onready var base_direction_label: Label = $HUD/BaseDirection
@onready var cargo_label: Label = $HUD/Cargo
@onready var cargo_slots_root: Node2D = $HUD/CargoSlots
@onready var cargo_slot_nodes: Array[ColorRect] = [
	$HUD/CargoSlots/Slot1,
	$HUD/CargoSlots/Slot2,
	$HUD/CargoSlots/Slot3,
	$HUD/CargoSlots/Slot4,
]
@onready var cargo_slot_icon_nodes: Array[Polygon2D] = [
	$HUD/CargoSlots/Icon1,
	$HUD/CargoSlots/Icon2,
	$HUD/CargoSlots/Icon3,
	$HUD/CargoSlots/Icon4,
]
@onready var bank_label: Label = $HUD/BankedResources
@onready var upgrade_label: Label = $HUD/Upgrade
@onready var discoveries_label: Label = $HUD/Discoveries
@onready var status_label: Label = $HUD/Status
@onready var prompt_label: Label = $HUD/ExtractionPrompt
@onready var scan_target_label: Label = $HUD/ScanTarget
@onready var dive_info_panel: Panel = $HUD/DiveInfoPanel
@onready var oxygen_warning_panel: Panel = $HUD/OxygenWarningPanel
@onready var oxygen_warning_label: Label = $HUD/OxygenWarningPanel/OxygenWarning
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
@onready var thermal_warm_wash: Polygon2D = $ThermalVentPocket/Visuals/FallbackGeometry/WarmWash
@onready var thermal_heat_plume: Polygon2D = $ThermalVentPocket/Visuals/FallbackGeometry/HeatPlume
@onready var thermal_bubble_string_a: Polygon2D = $ThermalVentPocket/Visuals/FallbackGeometry/BubbleStringA
@onready var thermal_bubble_string_b: Polygon2D = $ThermalVentPocket/Visuals/FallbackGeometry/BubbleStringB
@onready var thermal_vent_visual: Polygon2D = $Discoveries/ThermalVent/FallbackVisual/Visual
@onready var thermal_vent_bubbles: Polygon2D = $Discoveries/ThermalVent/FallbackVisual/Bubbles
@onready var glow_plankton_visual: Node2D = $ResourcePickups/GlowPlankton/Visuals/SpriteAnchor
@onready var hidden_glow_plankton: Node = $ResourcePickups/HiddenGlowPlankton
@onready var lantern_fry_sprite_anchor: Node2D = $Creatures/LanternFry/SpriteAnchor
@onready var lantern_fry_visual_root: Node2D = $Creatures/LanternFry/FallbackVisual
@onready var lantern_fry_glow: Polygon2D = $Creatures/LanternFry/FallbackVisual/Glow
@onready var vent_route_hint: Node2D = $VentRouteHint
@onready var pressure_boundary: Area2D = $PressureLockedWreck/PressureBoundary
@onready var pressure_shimmer: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureShimmer
@onready var pressure_gate_top: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateTop
@onready var pressure_gate_bottom: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBottom
@onready var pressure_gate_bar_a: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBarA
@onready var pressure_gate_bar_b: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBarB
@onready var pressure_gate_bar_c: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureGateBarC
@onready var pressure_gate_left_rail: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/GateLeftRail
@onready var pressure_gate_right_rail: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/GateRightRail
@onready var pressure_lock_badge: Polygon2D = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLockBadge
@onready var pressure_label: Label = $PressureLockedWreck/Visuals/FallbackGeometry/PressureGateVisuals/PressureLabel
@onready var echo_lens_pulse: Sprite2D = $PressureLockedWreck/WreckSignalCache/EchoPulse
@onready var wreck_signal_hint: Node2D = $WreckSignalHint
@onready var wreck_echo_clue_trigger: Area2D = $WreckEchoDescent/ClueTrigger
@onready var wreck_echo_route_wash: Polygon2D = $WreckEchoDescent/RouteWash
@onready var wreck_echo_rib_a: Polygon2D = $WreckEchoDescent/RibA
@onready var wreck_echo_rib_b: Polygon2D = $WreckEchoDescent/RibB
@onready var wreck_echo_clue_marker_outer: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueMarkerOuter
@onready var wreck_echo_clue_marker_inner: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueMarkerInner
@onready var wreck_echo_clue_marker_facet: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueMarkerFacet
@onready var wreck_echo_clue_marker_arc_a: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueMarkerArcA
@onready var wreck_echo_clue_marker_arc_b: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueMarkerArcB
@onready var wreck_echo_clue_core: Polygon2D = $WreckEchoDescent/ClueTrigger/ClueCore
@onready var rare_signal_emphasis: Node2D = $RareSignalEmphasis
@onready var route_choice_decision_rib: Polygon2D = $RouteChoiceBand/DecisionRib
@onready var route_choice_safe_bank_lane: Polygon2D = $RouteChoiceBand/SafeBankLane
@onready var route_choice_research_lane: Polygon2D = $RouteChoiceBand/ResearchLane
@onready var shelf_glimmer_opportunity: Node2D = $EastShelfSpur/ShelfGlimmerOpportunity
@onready var east_shelf_current_surge_lane: Polygon2D = $EastShelfSpur/CurrentSurgeLane
@onready var east_shelf_current_surge_rib: Polygon2D = $EastShelfSpur/CurrentSurgeRib
@onready var east_shelf_pocket_interact_zone: Area2D = $EastShelfSpur/PocketEntrance/InteractZone
@onready var east_shelf_signal_core_halo: Polygon2D = $EastShelfSpur/PocketEntrance/SignalCore/CoreHalo
@onready var east_shelf_signal_core_gem: Polygon2D = $EastShelfSpur/PocketEntrance/SignalCore/CoreGem
@onready var east_shelf_signal_core_spark: Polygon2D = $EastShelfSpur/PocketEntrance/SignalCore/CoreSpark
@onready var lower_connector_echo_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/DropEchoOpportunity/InteractZone
@onready var resonance_alcove_interact_zone: Area2D = $EastShelfSpur/ResonanceAlcove/InteractZone
@onready var blue_chimney_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/InteractZone
@onready var lantern_silt_nook_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/LanternSiltNook/InteractZone
@onready var blackwater_crack_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/InteractZone
@onready var glass_kelp_ledge_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone
@onready var blue_chimney_signal_opportunity: Node2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity
@onready var blue_chimney_reverse_draft: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/ReverseDraftReturn
@onready var blue_chimney_survey_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyHalo
@onready var blue_chimney_survey_gem: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem
@onready var blue_chimney_survey_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark
@onready var blackwater_crack_mouth: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth
@onready var blackwater_pressure_wash: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash
@onready var blackwater_seal_lip: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip
@onready var blackwater_gate_badge: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge
@onready var blackwater_gate_label: Label = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel
@onready var blackwater_closed_shard: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard
@onready var blackwater_sill: Node2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill
@onready var blackwater_sill_return_current: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue
@onready var blackwater_pressure_shutter: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureShutter
@onready var blackwater_pressure_rib_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibA
@onready var blackwater_pressure_rib_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/PressureRibB
@onready var blackwater_trace_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo
@onready var blackwater_trace_gem: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem
@onready var blackwater_trace_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark
@onready var blackwater_signal_opportunity: Node2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity
@onready var blackwater_signal_wash: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash
@onready var blackwater_signal_fleck: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck
@onready var dusk_low_visibility_veil: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil
@onready var dusk_low_visibility_band: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand
@onready var dusk_low_visibility_rib_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA
@onready var dusk_low_visibility_rib_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibB
@onready var lantern_ray_timing_lane_upper: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingLaneUpper
@onready var lantern_ray_timing_lane_lower: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingLaneLower
@onready var lantern_ray_timing_tick_a: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingTickA
@onready var lantern_ray_timing_tick_b: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingTickB
@onready var glass_kelp_reading_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingHalo
@onready var glass_kelp_reading_shard: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard
@onready var glass_kelp_reading_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark
@onready var sealed_shelf_hatch_echo_shimmer: Polygon2D = $EastShelfSpur/SealedShelfHatch/EchoShimmer
@onready var sealed_shelf_hatch_lock_badge: Polygon2D = $EastShelfSpur/SealedShelfHatch/LockBadge
@onready var sealed_shelf_hatch_lock_label: Label = $EastShelfSpur/SealedShelfHatch/LockLabel
@onready var predator_warning: Node2D = $Predators/PredatorWarning
@onready var gulper_eel: Node = $Predators/GulperEel

var dive_session := DiveSessionScript.new()
var progression_state := ProgressionStateScript.new()
var player_in_base := true
var player_near_east_shelf_pocket := false
var player_near_lower_connector_echo := false
var player_near_resonance_alcove := false
var player_near_blue_chimney := false
var player_near_lantern_silt_nook := false
var player_near_blackwater_crack := false
var player_near_glass_kelp_ledge := false
var glow_plankton_highlight_timer := 0.0
var resource_scan_highlight_id := ""
var resource_scan_highlight_timer := 0.0
var echo_lens_pulse_timer := 0.0
var east_shelf_current_surge_timer := 0.0
var blue_chimney_draft_timer := 0.0
var blackwater_pressure_timer := 0.0
var lantern_ray_timing_timer := 0.0
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
	ECHO_LENS_UPGRADE,
	RESONANCE_KEY_UPGRADE,
	CARGO_RACK_UPGRADE,
	PREDATOR_WARNING_UPGRADE,
	DECOY_PULSE_UPGRADE,
]
var run_collected_resources: Array[String] = []
var run_completed_scans: Array[String] = []
var run_predator_contacts := 0
var run_failure_cause := "none"
var run_echo_lens_echo_fired := false
var run_wreck_echo_clue_recovered := false
var run_east_shelf_pocket_ping_recovered := false
var run_lower_connector_echo_recovered := false
var run_resonance_alcove_research_recovered := false
var run_blue_chimney_draft_reading_recovered := false
var run_lantern_silt_sample_recovered := false
var run_blackwater_trace_recovered := false
var run_reached_dusk_trench := false
var run_glass_kelp_reading_recovered := false
var debug_wreck_echo_review_staged := false
var visual_smoke_route_stage := ""
var recent_expedition_log: Array[Dictionary] = []

func _ready() -> void:
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	east_shelf_pocket_interact_zone.body_entered.connect(_on_east_shelf_pocket_body_entered)
	east_shelf_pocket_interact_zone.body_exited.connect(_on_east_shelf_pocket_body_exited)
	lower_connector_echo_interact_zone.body_entered.connect(_on_lower_connector_echo_body_entered)
	lower_connector_echo_interact_zone.body_exited.connect(_on_lower_connector_echo_body_exited)
	resonance_alcove_interact_zone.body_entered.connect(_on_resonance_alcove_body_entered)
	resonance_alcove_interact_zone.body_exited.connect(_on_resonance_alcove_body_exited)
	blue_chimney_interact_zone.body_entered.connect(_on_blue_chimney_body_entered)
	blue_chimney_interact_zone.body_exited.connect(_on_blue_chimney_body_exited)
	lantern_silt_nook_interact_zone.body_entered.connect(_on_lantern_silt_nook_body_entered)
	lantern_silt_nook_interact_zone.body_exited.connect(_on_lantern_silt_nook_body_exited)
	blackwater_crack_interact_zone.body_entered.connect(_on_blackwater_crack_body_entered)
	blackwater_crack_interact_zone.body_exited.connect(_on_blackwater_crack_body_exited)
	glass_kelp_ledge_interact_zone.body_entered.connect(_on_glass_kelp_ledge_body_entered)
	glass_kelp_ledge_interact_zone.body_exited.connect(_on_glass_kelp_ledge_body_exited)
	pressure_boundary.body_entered.connect(_on_pressure_boundary_body_entered)
	wreck_echo_clue_trigger.body_entered.connect(_on_wreck_echo_clue_body_entered)
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.collected.connect(_on_resource_pickup_collected)
	for predator in get_tree().get_nodes_in_group("predators"):
		predator.contacted.connect(_on_predator_contacted)
	_load_progression()
	_prepare_next_run()
	_sync_discovery_reveals()
	_update_hud()

func _process(delta: float) -> void:
	_consume_visual_smoke_command()
	_update_depth()
	_update_glow_plankton_highlight(delta)
	_update_resource_scan_highlight(delta)
	_update_echo_lens_pulse(delta)
	_update_east_shelf_current_surge(delta)
	_update_blue_chimney_reverse_draft(delta)
	_update_blackwater_pressure_cue(delta)
	_update_lantern_ray_timing_lane(delta)
	_update_lantern_fry_idle()
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
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F6:
		_stage_debug_wreck_echo_visual_review()
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F7:
		_stage_debug_oxygen_visual_review(0.20, "low")
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F8:
		_stage_debug_oxygen_visual_review(0.08, "critical")
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
			if not _try_resonance_alcove_interaction() and not _try_glass_kelp_ledge_interaction() and not _try_blackwater_crack_interaction() and not _try_lantern_silt_nook_interaction() and not _try_blue_chimney_interaction() and not _try_lower_connector_echo_interaction() and not _try_east_shelf_pocket_interaction():
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
	last_result_summary = _format_extraction_result_summary(extracted_count, extracted_cargo)
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
	last_result_summary = "%s\nCargo lost. Banked resources, upgrades, scans, and best depth kept.\n%s%s\n%s%s%s\n%s\nBest depth: %dm.\n%s" % [
		_format_completed_expedition_line("Failure"),
		_format_region_memory_callout(),
		_format_discovery_memory_callout(),
		_format_route_choice_callout(),
		_format_gulper_research_callout(),
		_format_echo_lens_research_callout(),
		_format_scan_progress_callout("Scans kept"),
		roundi(progression_state.best_depth_reached),
		_format_next_expedition_prompt(),
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
	player_near_east_shelf_pocket = false
	player_near_lower_connector_echo = false
	player_near_resonance_alcove = false
	player_near_blue_chimney = false
	player_near_lantern_silt_nook = false
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	_reset_run_telemetry()
	burst_thruster_cooldown_remaining = 0.0
	decoy_pulse_used_this_run = false
	_place_starter_resources_for_run()
	_sync_condition_visuals()
	_sync_wreck_echo_state()

func _on_base_zone_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_base = true
		_update_hud()

func _on_base_zone_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_base = false
		dive_session.has_left_base = true
		_update_hud()

func _on_east_shelf_pocket_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_east_shelf_pocket = true
		if status_label != null:
			status_label.text = "East Shelf Pocket: recover the signal core."
		if is_inside_tree():
			_update_hud()

func _on_east_shelf_pocket_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_east_shelf_pocket = false
		if is_inside_tree():
			_update_hud()

func _on_lower_connector_echo_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_lower_connector_echo = true
		if status_label != null:
			status_label.text = "Drop Echo: inspect the lower connector signal."
		if is_inside_tree():
			_update_hud()

func _on_lower_connector_echo_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_lower_connector_echo = false
		if is_inside_tree():
			_update_hud()

func _on_resonance_alcove_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_resonance_alcove = true
		if status_label != null:
			status_label.text = "Resonance Alcove: inspect the tuned hatch echo."
		if is_inside_tree():
			_update_hud()

func _on_resonance_alcove_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_resonance_alcove = false
		if is_inside_tree():
			_update_hud()

func _on_blue_chimney_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_blue_chimney = true
		if status_label != null:
			status_label.text = "Blue Chimney: inspect the reverse draft."
		if is_inside_tree():
			_update_hud()

func _on_blue_chimney_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_blue_chimney = false
		if is_inside_tree():
			_update_hud()

func _on_lantern_silt_nook_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_lantern_silt_nook = true
		if status_label != null:
			status_label.text = "Lantern Silt Nook: collect a silt sample."
		if is_inside_tree():
			_update_hud()

func _on_lantern_silt_nook_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_lantern_silt_nook = false
		if is_inside_tree():
			_update_hud()

func _on_blackwater_crack_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_blackwater_crack = true
		if status_label != null:
			status_label.text = _format_blackwater_gate_status()
		if is_inside_tree():
			_update_hud()

func _on_blackwater_crack_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_blackwater_crack = false
		if is_inside_tree():
			_update_hud()

func _on_glass_kelp_ledge_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_glass_kelp_ledge = true
		if status_label != null:
			status_label.text = "Glass Kelp Ledge: record the kelp reading."
		if is_inside_tree():
			_update_hud()

func _on_glass_kelp_ledge_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_glass_kelp_ledge = false
		if is_inside_tree():
			_update_hud()

func _try_east_shelf_pocket_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_east_shelf_pocket:
		return false

	if run_east_shelf_pocket_ping_recovered:
		if status_label != null:
			status_label.text = "East Shelf signal core already recovered for this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_east_shelf_pocket_ping_recovered = true
	_sync_east_shelf_pocket_payoff_state()
	if status_label != null:
		if progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
			status_label.text = "East Shelf signal core recovered. Echo Lens reads the seal; return to plan a key."
		else:
			status_label.text = "East Shelf signal core recovered. Return safely to keep the route note."
	if is_inside_tree():
		_update_hud()
	return true

func _try_lower_connector_echo_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_lower_connector_echo:
		return false

	if run_lower_connector_echo_recovered:
		if status_label != null:
			status_label.text = "Drop Echo already recorded for this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_lower_connector_echo_recovered = true
	if status_label != null:
		if progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
			status_label.text = "Drop Echo recorded. Return safely; lab can compare hatch resonance."
		else:
			status_label.text = "Drop Echo recorded. Return safely to keep the lower-route note."
	if is_inside_tree():
		_update_hud()
	return true

func _try_resonance_alcove_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_resonance_alcove:
		return false

	if not progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID):
		if status_label != null:
			status_label.text = "Resonance Alcove is behind the sealed hatch."
		if is_inside_tree():
			_update_hud()
		return true

	if run_resonance_alcove_research_recovered:
		if status_label != null:
			status_label.text = "Resonance Alcove echo already recorded this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_resonance_alcove_research_recovered = true
	if status_label != null:
		status_label.text = "Resonance Alcove echo recorded. Return safely to keep the research."
	if is_inside_tree():
		_update_hud()
	return true

func _try_blue_chimney_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_blue_chimney:
		return false

	if run_blue_chimney_draft_reading_recovered:
		if status_label != null:
			status_label.text = "Blue Chimney survey core already recovered this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_blue_chimney_draft_reading_recovered = true
	_sync_blue_chimney_payoff_state()
	if status_label != null:
		status_label.text = "Blue Chimney survey core recovered. Return safely to keep the lower-route reading."
	if is_inside_tree():
		_update_hud()
	return true

func _try_blackwater_crack_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_blackwater_crack:
		return false

	if _blackwater_crack_gate_open():
		if run_blackwater_trace_recovered:
			if status_label != null:
				status_label.text = "Blackwater trace already recorded this expedition."
			if is_inside_tree():
				_update_hud()
			return true

		run_blackwater_trace_recovered = true
		_sync_blackwater_trace_payoff_state()
		if status_label != null:
			status_label.text = "Blackwater trace recorded. Return safely via Silt Vein, Blue Chimney, and Drop Arch to keep the deep-route reading."
		if is_inside_tree():
			_update_hud()
		return true

	if status_label != null:
		status_label.text = _format_blackwater_gate_status()
	if is_inside_tree():
		_update_hud()
	return true

func _try_glass_kelp_ledge_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_glass_kelp_ledge:
		return false

	if run_glass_kelp_reading_recovered:
		if status_label != null:
			status_label.text = "Glass Kelp reading already recorded this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_glass_kelp_reading_recovered = true
	run_reached_dusk_trench = true
	_sync_glass_kelp_reading_state()
	if status_label != null:
		status_label.text = "Glass Kelp reading recorded. Return safely through Blackwater and Silt Vein to keep the ledge note."
	if is_inside_tree():
		_update_hud()
	return true

func _try_lantern_silt_nook_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_lantern_silt_nook:
		return false

	if run_lantern_silt_sample_recovered:
		if status_label != null:
			status_label.text = "Lantern silt sample already stored this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_lantern_silt_sample_recovered = true
	if status_label != null:
		status_label.text = "Lantern silt sample stored. Return safely to keep the fork reading."
	if is_inside_tree():
		_update_hud()
	return true

func _on_wreck_echo_clue_body_entered(body: Node2D) -> void:
	if body != player or dive_session.result != DiveSessionScript.Result.DIVING:
		return
	if not _wreck_echo_route_available():
		return
	if run_wreck_echo_clue_recovered:
		return

	run_wreck_echo_clue_recovered = true
	status_label.text = "Wreck Echo clue recovered: return to base to keep the research."
	_sync_wreck_echo_state()
	_update_hud()

func _update_depth() -> void:
	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	progression_state.record_depth(dive_session.current_depth)
	if player.global_position.x >= DUSK_TRENCH_MEMORY_MIN_X and player.global_position.y >= DUSK_TRENCH_MEMORY_MIN_Y:
		run_reached_dusk_trench = true

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

func _stage_debug_wreck_echo_visual_review() -> void:
	if not show_debug_telemetry:
		return

	progression_state.purchased_upgrades[SIGNAL_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[PRESSURE_SEAL_UPGRADE_ID] = true
	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	if pressure_boundary != null:
		_sync_pressure_lock_state()
	_sync_wreck_echo_state()

	if dive_session.result != DiveSessionScript.Result.DIVING or not debug_wreck_echo_review_staged:
		if dive_session.result != DiveSessionScript.Result.DIVING:
			dive_session.start()
		var trigger := wreck_echo_clue_trigger
		if trigger == null:
			trigger = get_node_or_null("WreckEchoDescent/ClueTrigger") as Area2D
		if trigger == null:
			return
		var staged_player := player
		if staged_player == null:
			staged_player = get_node_or_null("Player") as CharacterBody2D
		if staged_player == null:
			return
		player = staged_player
		player.global_position = trigger.global_position + Vector2(-95.0, -34.0)
		player.velocity = Vector2.ZERO
		dive_session.has_left_base = true
		debug_wreck_echo_review_staged = true
		if status_label != null:
			status_label.text = "Debug review: Wreck Echo route staged."
		_update_depth()
		if is_inside_tree():
			_update_hud()
		return

	run_wreck_echo_clue_recovered = true
	_sync_wreck_echo_state()
	var review_base := base_zone
	if review_base == null:
		review_base = get_node_or_null("BaseZone") as Area2D
	if player == null:
		player = get_node_or_null("Player") as CharacterBody2D
	if review_base == null or player == null:
		return
	base_zone = review_base
	player.global_position = base_zone.global_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	if not is_inside_tree():
		dive_session.extract()
		last_result_summary = _format_wreck_echo_research_callout()
		return
	_try_extract()

func _stage_debug_oxygen_visual_review(target_ratio: float, label: String) -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING or dive_session.max_oxygen <= 0.0:
		return

	dive_session.oxygen = maxf(1.0, dive_session.max_oxygen * target_ratio)
	status_label.text = "Debug review: %s oxygen staged." % label
	_update_hud()

func _stage_debug_expanded_route_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var pocket_entrance := get_node_or_null("EastShelfSpur/PocketEntrance") as Node2D
	if pocket_entrance == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player = staged_player
	player.global_position = pocket_entrance.global_position + Vector2(-160.0, -150.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	visual_smoke_route_stage = "east_shelf_spur"
	status_label.text = "Debug review: East Shelf route staged."
	_update_depth()
	_update_hud()

func _stage_debug_east_shelf_pocket_visual_review() -> void:
	_stage_debug_expanded_route_visual_review()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player_near_east_shelf_pocket = true
	_try_east_shelf_pocket_interaction()
	visual_smoke_route_stage = "east_shelf_pocket"
	status_label.text = "Debug review: East Shelf signal core payoff staged."
	_update_hud()

func _stage_debug_lower_connector_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var turnback_hint := get_node_or_null("EastShelfSpur/ShelfDropConnector/TurnbackPocketHint") as Polygon2D
	if turnback_hint == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player = staged_player
	var hint_center := Vector2.ZERO
	for point in turnback_hint.polygon:
		hint_center += point
	hint_center /= max(1, turnback_hint.polygon.size())
	player.global_position = turnback_hint.global_position + hint_center + Vector2(-120.0, -90.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	visual_smoke_route_stage = "lower_connector"
	status_label.text = "Debug review: Shelf Drop Connector staged."
	_update_depth()
	_update_hud()

func _stage_debug_blue_chimney_pocket_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var pocket := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket") as Node2D
	if pocket == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	_sync_condition_visuals()

	player = staged_player
	player.global_position = pocket.global_position + Vector2(-34.0, -24.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	visual_smoke_route_stage = "blue_chimney_pocket"
	status_label.text = "Debug review: Blue Chimney Pocket staged."
	_update_depth()
	_update_hud()

func _stage_debug_blue_chimney_payoff_visual_review() -> void:
	_stage_debug_blue_chimney_pocket_visual_review()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player_near_blue_chimney = true
	_try_blue_chimney_interaction()
	visual_smoke_route_stage = "blue_chimney_payoff"
	status_label.text = "Debug review: Blue Chimney draft payoff staged."
	_update_hud()

func _stage_debug_silt_vein_fork_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var fork := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork") as Node2D
	if fork == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player = staged_player
	player.global_position = fork.global_position + Vector2(-16.0, 32.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	visual_smoke_route_stage = "silt_vein_fork"
	status_label.text = "Debug review: Silt Vein Fork staged."
	_update_depth()
	_update_hud()

func _stage_debug_blackwater_route_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var sill := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	if sill == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[RESONANCE_KEY_UPGRADE_ID] = true
	current_expedition_condition = {
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	}
	_sync_sealed_shelf_hatch_state()
	_sync_blackwater_crack_gate_state()
	_sync_condition_visuals()
	_update_blackwater_pressure_cue(BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	player = staged_player
	player.global_position = sill.global_position + Vector2(-20.0, -20.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = true
	visual_smoke_route_stage = "blackwater_route"
	status_label.text = _format_blackwater_gate_status()
	_update_depth()
	_update_hud()

func _stage_debug_dusk_trench_route_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var dusk_trench := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench") as Node2D
	if dusk_trench == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[RESONANCE_KEY_UPGRADE_ID] = true
	current_expedition_condition = {
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	}
	_sync_sealed_shelf_hatch_state()
	_sync_blackwater_crack_gate_state()
	_sync_condition_visuals()
	_update_blackwater_pressure_cue(BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	player = staged_player
	player.global_position = dusk_trench.global_position + Vector2(92.0, 32.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	run_reached_dusk_trench = true
	run_glass_kelp_reading_recovered = false
	_sync_glass_kelp_reading_state()
	visual_smoke_route_stage = "dusk_trench_route"
	status_label.text = "Debug review: Dusk Trench route staged."
	_update_depth()
	_update_hud()

func _stage_debug_dusk_trench_payoff_visual_review(recovered := false) -> void:
	_stage_debug_dusk_trench_route_visual_review()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var ledge_interact := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/InteractZone") as Area2D
	if ledge_interact == null:
		return

	player.global_position = ledge_interact.global_position
	player.velocity = Vector2.ZERO
	player_near_glass_kelp_ledge = true
	run_reached_dusk_trench = true
	if recovered:
		_try_glass_kelp_ledge_interaction()
		visual_smoke_route_stage = "dusk_trench_payoff_recovered"
		status_label.text = "Debug review: Dusk Trench payoff recovered."
	else:
		run_glass_kelp_reading_recovered = false
		_sync_glass_kelp_reading_state()
		visual_smoke_route_stage = "dusk_trench_payoff"
		status_label.text = "Debug review: Dusk Trench payoff staged."
	_update_depth()
	_update_hud()

func _stage_debug_open_hatch_alcove_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var alcove := get_node_or_null("EastShelfSpur/ResonanceAlcove") as Node2D
	if alcove == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[RESONANCE_KEY_UPGRADE_ID] = true
	_sync_sealed_shelf_hatch_state()

	player = staged_player
	player.global_position = alcove.global_position + Vector2(-120.0, -40.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_resonance_alcove = true
	_try_resonance_alcove_interaction()
	visual_smoke_route_stage = "open_hatch_resonance_alcove"
	status_label.text = "Debug review: open hatch and Resonance Alcove staged."
	_update_depth()
	_update_hud()

func _consume_visual_smoke_command() -> void:
	if not OS.has_feature("web"):
		return

	var command = JavaScriptBridge.eval("window.__oceangameDebugCommand || ''", true)
	if typeof(command) != TYPE_STRING or String(command).is_empty():
		return

	JavaScriptBridge.eval("window.__oceangameDebugCommand = '';", true)
	match String(command):
		"oxygen_low":
			_stage_debug_oxygen_visual_review(0.20, "low")
		"oxygen_critical":
			_stage_debug_oxygen_visual_review(0.08, "critical")
		"expanded_east_shelf_route":
			_stage_debug_expanded_route_visual_review()
		"east_shelf_pocket_ping":
			_stage_debug_east_shelf_pocket_visual_review()
		"lower_connector":
			_stage_debug_lower_connector_visual_review()
		"blue_chimney_pocket":
			_stage_debug_blue_chimney_pocket_visual_review()
		"blue_chimney_payoff":
			_stage_debug_blue_chimney_payoff_visual_review()
		"silt_vein_fork":
			_stage_debug_silt_vein_fork_visual_review()
		"blackwater_route":
			_stage_debug_blackwater_route_visual_review()
		"dusk_trench_route":
			_stage_debug_dusk_trench_route_visual_review()
		"dusk_trench_payoff":
			_stage_debug_dusk_trench_payoff_visual_review(false)
		"dusk_trench_payoff_recovered":
			_stage_debug_dusk_trench_payoff_visual_review(true)
		"open_hatch_resonance_alcove":
			_stage_debug_open_hatch_alcove_visual_review()

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

func _action_label(action_id: String) -> String:
	return String(KEYBOARD_ACTION_LABELS.get(action_id, action_id))

func _format_hud_prompt() -> String:
	var prompt := ""
	if dive_session.result == DiveSessionScript.Result.READY:
		prompt = "Press %s to begin the dive" % _action_label("interact").replace("/", " or ")
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		if _all_upgrades_owned():
			prompt = "Extraction complete - press %s for next expedition | %s surface view" % [
				_action_label("restart_dive"),
				_action_label("move_left_right"),
			]
		elif surface_tab_index == SURFACE_TAB_UPGRADES:
			prompt = "Upgrade bay: %s select, %s purchase, %s next expedition | %s surface view" % [
				_action_label("move_up_down"),
				_action_label("interact"),
				_action_label("restart_dive"),
				_action_label("move_left_right"),
			]
		else:
			prompt = "Extraction complete - press %s for upgrades, %s next expedition | %s surface view" % [
				_action_label("interact"),
				_action_label("restart_dive"),
				_action_label("move_left_right"),
			]
	elif dive_session.result == DiveSessionScript.Result.FAILED:
		prompt = "Expedition failed - press %s for next expedition" % _action_label("restart_dive")
	elif player_near_resonance_alcove:
		prompt = "Resonance Alcove: %s record hatch echo" % _action_label("interact")
	elif player_near_glass_kelp_ledge:
		if run_glass_kelp_reading_recovered:
			prompt = "Glass Kelp Ledge: reading recorded - return via Blackwater"
		else:
			prompt = "Glass Kelp Ledge: %s record kelp reading" % _action_label("interact")
	elif player_near_blackwater_crack:
		prompt = _format_blackwater_prompt()
	elif player_near_lantern_silt_nook:
		prompt = "Lantern Silt Nook: %s collect silt sample" % _action_label("interact")
	elif player_near_blue_chimney:
		prompt = "Blue Chimney: %s recover survey core" % _action_label("interact")
	elif player_near_lower_connector_echo:
		prompt = "Drop Echo: %s record lower-route ping" % _action_label("interact")
	elif player_near_east_shelf_pocket:
		prompt = "East Shelf Pocket: %s recover signal core" % _action_label("interact")
	elif player_in_base:
		if dive_session.has_left_base:
			prompt = "At base: %s extract" % _action_label("interact")
		else:
			prompt = "Leave moonpool, then return"
	else:
		prompt = "Explore, bank at base"

	if dive_session.result == DiveSessionScript.Result.DIVING:
		prompt += " | %s" % _format_burst_thruster_prompt()
		var decoy_prompt := _format_decoy_pulse_prompt()
		if not decoy_prompt.is_empty():
			prompt += " | %s" % decoy_prompt

	return prompt

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
			_sync_wreck_echo_state()
		"resource_signal_pulse":
			pass
		"echo_lens_wreck_echo":
			_sync_wreck_echo_state()
			_sync_sealed_shelf_hatch_state()
			_sync_blackwater_crack_gate_state()
		"resonance_key_1":
			_sync_sealed_shelf_hatch_state()
			_sync_blackwater_crack_gate_state()
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
		if discovery_id == "wreck_signal_cache" and progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
			run_echo_lens_echo_fired = true
			_trigger_echo_lens_pulse()
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

func _trigger_echo_lens_pulse() -> void:
	echo_lens_pulse_timer = ECHO_LENS_PULSE_DURATION
	echo_lens_pulse.visible = true
	echo_lens_pulse.scale = Vector2(1.4, 1.4)
	echo_lens_pulse.modulate = Color(1.0, 1.0, 1.0, 0.9)

func _update_echo_lens_pulse(delta: float) -> void:
	if echo_lens_pulse_timer <= 0.0:
		echo_lens_pulse.visible = false
		return

	echo_lens_pulse_timer = maxf(echo_lens_pulse_timer - delta, 0.0)
	var age_ratio := 1.0 - (echo_lens_pulse_timer / ECHO_LENS_PULSE_DURATION)
	var pulse_scale := lerpf(1.4, 2.2, age_ratio)
	echo_lens_pulse.scale = Vector2(pulse_scale, pulse_scale)
	echo_lens_pulse.modulate = Color(1.0, 1.0, 1.0, lerpf(0.9, 0.0, age_ratio))
	if echo_lens_pulse_timer <= 0.0:
		echo_lens_pulse.visible = false

func _update_east_shelf_current_surge(delta: float) -> void:
	east_shelf_current_surge_timer = fposmod(east_shelf_current_surge_timer + delta, EAST_SHELF_SURGE_PERIOD_SECONDS)
	var surge_alpha := _east_shelf_current_surge_alpha(east_shelf_current_surge_timer)
	if east_shelf_current_surge_lane != null:
		east_shelf_current_surge_lane.color = Color(0.66, 0.96, 1.0, surge_alpha)
	if east_shelf_current_surge_rib != null:
		east_shelf_current_surge_rib.color = Color(0.9, 1.0, 0.94, surge_alpha + 0.06)

func _east_shelf_current_surge_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / EAST_SHELF_SURGE_PERIOD_SECONDS) * TAU)
	return 0.08 + (phase + 1.0) * 0.045

func _update_blue_chimney_reverse_draft(delta: float) -> void:
	blue_chimney_draft_timer = fposmod(blue_chimney_draft_timer + delta, BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)
	if blue_chimney_reverse_draft != null:
		blue_chimney_reverse_draft.color = Color(0.72, 1.0, 0.94, _blue_chimney_reverse_draft_alpha(blue_chimney_draft_timer))

func _blue_chimney_reverse_draft_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS) * TAU)
	return 0.07 + (phase + 1.0) * 0.035

func _update_blackwater_pressure_cue(delta: float) -> void:
	blackwater_pressure_timer = fposmod(blackwater_pressure_timer + delta, BLACKWATER_PRESSURE_PERIOD_SECONDS)
	var shutter_alpha := _blackwater_pressure_cue_alpha(blackwater_pressure_timer)
	if blackwater_pressure_shutter != null:
		blackwater_pressure_shutter.color = Color(0.2, 0.12, 0.42, shutter_alpha)
	if blackwater_pressure_rib_a != null:
		blackwater_pressure_rib_a.color = Color(0.72, 0.52, 1.0, shutter_alpha + 0.04)
	if blackwater_pressure_rib_b != null:
		blackwater_pressure_rib_b.color = Color(0.72, 0.52, 1.0, shutter_alpha + 0.02)

func _blackwater_pressure_cue_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / BLACKWATER_PRESSURE_PERIOD_SECONDS) * TAU)
	return 0.1 + (phase + 1.0) * 0.04

func _update_lantern_ray_timing_lane(delta: float) -> void:
	var upper := lantern_ray_timing_lane_upper
	if upper == null:
		upper = get_node_or_null("Creatures/LanternRayRoute/TimingLane/TimingLaneUpper") as Polygon2D
		lantern_ray_timing_lane_upper = upper
	var lower := lantern_ray_timing_lane_lower
	if lower == null:
		lower = get_node_or_null("Creatures/LanternRayRoute/TimingLane/TimingLaneLower") as Polygon2D
		lantern_ray_timing_lane_lower = lower
	var tick_a := lantern_ray_timing_tick_a
	if tick_a == null:
		tick_a = get_node_or_null("Creatures/LanternRayRoute/TimingLane/TimingTickA") as Polygon2D
		lantern_ray_timing_tick_a = tick_a
	var tick_b := lantern_ray_timing_tick_b
	if tick_b == null:
		tick_b = get_node_or_null("Creatures/LanternRayRoute/TimingLane/TimingTickB") as Polygon2D
		lantern_ray_timing_tick_b = tick_b

	lantern_ray_timing_timer = fposmod(lantern_ray_timing_timer + delta, LANTERN_RAY_TIMING_PERIOD_SECONDS)
	var lane_alpha := _lantern_ray_timing_lane_alpha(lantern_ray_timing_timer)
	var lower_alpha := maxf(0.06, lane_alpha - 0.04)
	var tick_alpha := lane_alpha + 0.06
	if upper != null:
		upper.color = Color(0.9, 0.82, 1.0, lane_alpha)
	if lower != null:
		lower.color = Color(0.9, 0.82, 1.0, lower_alpha)
	if tick_a != null:
		tick_a.color = Color(0.98, 0.94, 1.0, tick_alpha)
	if tick_b != null:
		tick_b.color = Color(0.98, 0.94, 1.0, maxf(0.1, tick_alpha - 0.04))

func _lantern_ray_timing_lane_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / LANTERN_RAY_TIMING_PERIOD_SECONDS) * TAU)
	return 0.09 + (phase + 1.0) * 0.035

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
	elif _scan_target_id(target) == "lantern_ray":
		return " Lantern Ray route observation refreshed."
	elif _scan_target_id(target) == "thermal_vent":
		return " Warm clue refreshed; glow route optional."
	elif _scan_target_id(target) == "shell_reef_shelf":
		return " Reef route clue refreshed."
	elif _scan_target_id(target) == "wreck_signal_cache":
		return _format_wreck_cache_repeat_hint()
	elif _scan_target_id(target) == "gulper_eel":
		return " %s" % _format_decoy_pulse_scan_feedback()

	return ""

func _format_wreck_cache_repeat_hint() -> String:
	if progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
		return " Echo Lens: weak wreck echo lingers below the shelf."
	if progression_state.has_upgrade(SIGNAL_LENS_UPGRADE_ID):
		return " Cache echo unresolved: future Echo Lens study may read deeper wreck signals."

	return " Cache clue refreshed for Signal Lens I."

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
		"lantern_ray":
			return " Observe its calm pass, then return through Blackwater."
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

func _update_lantern_fry_idle() -> void:
	var pulse := 0.5 + 0.5 * sin(Time.get_ticks_msec() / 360.0)
	var bob := sin(Time.get_ticks_msec() / 520.0) * 3.0
	var visual_scale := 1.0 + pulse * 0.08
	lantern_fry_sprite_anchor.position.y = bob
	lantern_fry_sprite_anchor.scale = Vector2(visual_scale, visual_scale)
	lantern_fry_visual_root.position.y = bob
	lantern_fry_visual_root.scale = Vector2(visual_scale, visual_scale)
	lantern_fry_glow.color = Color(0.7, 1.0, 0.35, 0.18 + pulse * 0.18)

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
	rare_signal_emphasis.visible = _rare_signal_emphasis_visible_for_condition(condition_id)
	shelf_glimmer_opportunity.visible = _shelf_glimmer_visible_for_condition(condition_id)
	blue_chimney_signal_opportunity.visible = _blue_chimney_signal_visible_for_condition(condition_id)
	_sync_blackwater_signal_opportunity(condition_id)
	_sync_dusk_trench_condition_nudge(condition_id)
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
	_sync_route_choice_condition_nudge(condition_id)

func _sync_route_choice_condition_nudge(condition_id: String) -> void:
	var decision_rib := route_choice_decision_rib
	if decision_rib == null:
		decision_rib = get_node_or_null("RouteChoiceBand/DecisionRib") as Polygon2D
	var safe_bank_lane := route_choice_safe_bank_lane
	if safe_bank_lane == null:
		safe_bank_lane = get_node_or_null("RouteChoiceBand/SafeBankLane") as Polygon2D
	var research_lane := route_choice_research_lane
	if research_lane == null:
		research_lane = get_node_or_null("RouteChoiceBand/ResearchLane") as Polygon2D
	if decision_rib == null or safe_bank_lane == null or research_lane == null:
		return

	if condition_id == "rare_signal":
		decision_rib.color = Color(0.74, 0.92, 0.86, 0.24)
		safe_bank_lane.color = Color(0.46, 0.92, 0.64, 0.16)
		research_lane.color = Color(0.52, 0.96, 1.0, 0.28)
	else:
		decision_rib.color = Color(0.74, 0.92, 0.86, 0.18)
		safe_bank_lane.color = Color(0.46, 0.92, 0.64, 0.18)
		research_lane.color = Color(0.52, 0.96, 1.0, 0.2)

func _sync_dusk_trench_condition_nudge(condition_id: String) -> void:
	var veil := dusk_low_visibility_veil
	if veil == null:
		veil = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil") as Polygon2D
	var band := dusk_low_visibility_band
	if band == null:
		band = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand") as Polygon2D
	var rib_a := dusk_low_visibility_rib_a
	if rib_a == null:
		rib_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA") as Polygon2D
	var rib_b := dusk_low_visibility_rib_b
	if rib_b == null:
		rib_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibB") as Polygon2D
	if veil == null or band == null or rib_a == null or rib_b == null:
		return

	var is_low_visibility := condition_id == "low_visibility"
	veil.color = Color(0.035, 0.055, 0.15, 0.36) if is_low_visibility else Color(0.035, 0.055, 0.15, 0.28)
	band.color = Color(0.12, 0.16, 0.34, 0.3) if is_low_visibility else Color(0.12, 0.16, 0.34, 0.22)
	rib_a.color = Color(0.36, 0.44, 0.78, 0.32) if is_low_visibility else Color(0.36, 0.44, 0.78, 0.24)
	rib_b.color = Color(0.32, 0.38, 0.7, 0.28) if is_low_visibility else Color(0.32, 0.38, 0.7, 0.2)

func _rare_signal_emphasis_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

func _shelf_glimmer_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

func _blue_chimney_signal_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

func _blackwater_signal_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal" and _blackwater_crack_gate_open()

func _sync_blackwater_signal_opportunity(condition_id: String) -> void:
	var opportunity := blackwater_signal_opportunity
	if opportunity == null:
		opportunity = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity") as Node2D
	var wash := blackwater_signal_wash
	if wash == null:
		wash = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash") as Polygon2D
	var fleck := blackwater_signal_fleck
	if fleck == null:
		fleck = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck") as Polygon2D
	if opportunity == null or wash == null or fleck == null:
		return

	opportunity.visible = _blackwater_signal_visible_for_condition(condition_id)
	wash.color = Color(0.54, 0.72, 1.0, 0.08)
	fleck.color = Color(0.82, 0.94, 1.0, 0.32)

func _current_condition_id() -> String:
	return String(current_expedition_condition.get("id", ""))

func _sync_discovery_reveals() -> void:
	_set_hidden_glow_plankton_active(false)

	if progression_state.has_discovery("thermal_vent"):
		_reveal_thermal_vent_route()
	else:
		vent_route_hint.visible = false

	if progression_state.has_discovery("pressure_wreck_signal"):
		_reveal_pressure_wreck_signal()
	else:
		wreck_signal_hint.visible = false

	_sync_pressure_lock_state()
	_sync_predator_warning_upgrade_state()
	_sync_wreck_echo_state()
	_sync_sealed_shelf_hatch_state()
	_sync_blackwater_crack_gate_state()
	_sync_east_shelf_pocket_payoff_state()
	_sync_blue_chimney_payoff_state()

func _sync_east_shelf_pocket_payoff_state() -> void:
	var halo := east_shelf_signal_core_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/PocketEntrance/SignalCore/CoreHalo") as Polygon2D
	var gem := east_shelf_signal_core_gem
	if gem == null:
		gem = get_node_or_null("EastShelfSpur/PocketEntrance/SignalCore/CoreGem") as Polygon2D
	var spark := east_shelf_signal_core_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/PocketEntrance/SignalCore/CoreSpark") as Polygon2D
	if halo == null or gem == null or spark == null:
		return

	if run_east_shelf_pocket_ping_recovered:
		halo.color = Color(0.52, 1.0, 0.84, 0.08)
		gem.color = Color(0.92, 1.0, 0.56, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.52, 1.0, 0.84, 0.34)
		gem.color = Color(0.92, 1.0, 0.56, 0.82)
		spark.color = Color(1.0, 1.0, 0.82, 0.92)
		spark.visible = true

func _sync_blue_chimney_payoff_state() -> void:
	var halo := blue_chimney_survey_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyHalo") as Polygon2D
	var gem := blue_chimney_survey_gem
	if gem == null:
		gem = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveyGem") as Polygon2D
	var spark := blue_chimney_survey_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SurveyCore/SurveySpark") as Polygon2D
	if halo == null or gem == null or spark == null:
		return

	if run_blue_chimney_draft_reading_recovered:
		halo.color = Color(0.46, 0.92, 1.0, 0.08)
		gem.color = Color(0.74, 1.0, 0.96, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.46, 0.92, 1.0, 0.32)
		gem.color = Color(0.74, 1.0, 0.96, 0.78)
		spark.color = Color(1.0, 1.0, 0.82, 0.88)
		spark.visible = true

func _reveal_thermal_vent_route() -> void:
	var route_hint := vent_route_hint
	if route_hint == null:
		route_hint = get_node_or_null("VentRouteHint")
	if route_hint != null:
		route_hint.visible = true

func _set_hidden_glow_plankton_active(active: bool) -> void:
	var glow_pickup := hidden_glow_plankton
	if glow_pickup == null:
		glow_pickup = get_node_or_null("ResourcePickups/HiddenGlowPlankton")
	if glow_pickup == null:
		return

	glow_pickup.visible = active
	glow_pickup.set("monitoring", active)

func _reveal_pressure_wreck_signal() -> void:
	wreck_signal_hint.visible = true

func _sync_pressure_lock_state() -> void:
	var has_pressure_seal := progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID)
	pressure_boundary.monitoring = not has_pressure_seal
	pressure_boundary.monitorable = not has_pressure_seal
	if has_pressure_seal:
		pressure_shimmer.modulate = Color(0.62, 1.0, 0.72, 0.32)
		pressure_gate_top.color = Color(0.62, 1.0, 0.72, 0.24)
		pressure_gate_bottom.color = Color(0.62, 1.0, 0.72, 0.24)
		pressure_gate_bar_a.color = Color(0.62, 1.0, 0.72, 0.12)
		pressure_gate_bar_b.color = Color(0.62, 1.0, 0.72, 0.12)
		pressure_gate_bar_c.color = Color(0.62, 1.0, 0.72, 0.12)
		pressure_gate_left_rail.color = Color(0.32, 0.86, 0.58, 0.18)
		pressure_gate_right_rail.color = Color(0.32, 0.86, 0.58, 0.18)
		pressure_lock_badge.color = Color(0.62, 1.0, 0.72, 0.72)
		pressure_label.text = "OPEN"
	else:
		pressure_shimmer.modulate = Color.WHITE
		pressure_gate_top.color = Color(0.74, 0.86, 1.0, 0.54)
		pressure_gate_bottom.color = Color(0.74, 0.86, 1.0, 0.54)
		pressure_gate_bar_a.color = Color(0.74, 0.86, 1.0, 0.4)
		pressure_gate_bar_b.color = Color(0.74, 0.86, 1.0, 0.4)
		pressure_gate_bar_c.color = Color(0.74, 0.86, 1.0, 0.4)
		pressure_gate_left_rail.color = Color(0.26, 0.48, 0.8, 0.34)
		pressure_gate_right_rail.color = Color(0.26, 0.48, 0.8, 0.34)
		pressure_lock_badge.color = Color(0.74, 0.86, 1.0, 0.72)
		pressure_label.text = "LOCKED"

func _sync_sealed_shelf_hatch_state() -> void:
	var echo_shimmer := sealed_shelf_hatch_echo_shimmer
	if echo_shimmer == null:
		echo_shimmer = get_node_or_null("EastShelfSpur/SealedShelfHatch/EchoShimmer") as Polygon2D
	var lock_badge := sealed_shelf_hatch_lock_badge
	if lock_badge == null:
		lock_badge = get_node_or_null("EastShelfSpur/SealedShelfHatch/LockBadge") as Polygon2D
	var lock_label := sealed_shelf_hatch_lock_label
	if lock_label == null:
		lock_label = get_node_or_null("EastShelfSpur/SealedShelfHatch/LockLabel") as Label
	var seal_bars := get_node_or_null("EastShelfSpur/SealedShelfHatch/SealBars") as Polygon2D
	if echo_shimmer == null or lock_badge == null or lock_label == null:
		return

	var has_resonance_key := progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID)
	var has_echo_lens := progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID)
	if has_resonance_key:
		echo_shimmer.color = Color(0.95, 1.0, 0.72, 0.28)
		lock_badge.color = Color(0.95, 1.0, 0.72, 0.78)
		lock_label.text = "OPEN"
		if seal_bars != null:
			seal_bars.color = Color(0.86, 1.0, 0.72, 0.12)
	elif has_echo_lens:
		echo_shimmer.color = Color(0.62, 1.0, 0.78, 0.22)
		lock_badge.color = Color(0.62, 1.0, 0.72, 0.72)
		lock_label.text = "ECHO PING"
		if seal_bars != null:
			seal_bars.color = Color(0.58, 0.82, 1.0, 0.34)
	else:
		echo_shimmer.color = Color(0.62, 0.94, 1.0, 0.11)
		lock_badge.color = Color(0.74, 0.86, 1.0, 0.74)
		lock_label.text = "ECHO LOCK"
		if seal_bars != null:
			seal_bars.color = Color(0.58, 0.82, 1.0, 0.34)

func _blackwater_crack_gate_open() -> bool:
	return progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID)

func _format_blackwater_gate_status() -> String:
	if _blackwater_crack_gate_open():
		return "Blackwater: trace sill. Return Silt/Blue/Drop."
	if progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
		return "Blackwater Crack sealed. Resonance Key I preparation needed."

	return "Blackwater Crack sealed. Echo Lens study and Resonance Key I preparation needed."

func _format_blackwater_prompt() -> String:
	if _blackwater_crack_gate_open():
		if run_blackwater_trace_recovered:
			return "Blackwater Sill: trace recorded - return via Silt/Blue"

		return "Blackwater Sill: %s record trace" % _action_label("interact")

	return "Blackwater Crack: %s read Resonance seal" % _action_label("interact")

func _sync_blackwater_trace_payoff_state() -> void:
	var halo := blackwater_trace_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceHalo") as Polygon2D
	var gem := blackwater_trace_gem
	if gem == null:
		gem = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceGem") as Polygon2D
	var spark := blackwater_trace_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/TraceCore/TraceSpark") as Polygon2D
	if halo == null or gem == null or spark == null:
		return

	if run_blackwater_trace_recovered:
		halo.color = Color(0.45, 0.78, 1.0, 0.08)
		gem.color = Color(0.72, 0.98, 1.0, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.45, 0.78, 1.0, 0.32)
		gem.color = Color(0.72, 0.98, 1.0, 0.82)
		spark.color = Color(1.0, 1.0, 0.82, 0.9)
		spark.visible = true

func _sync_glass_kelp_reading_state() -> void:
	var halo := glass_kelp_reading_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingHalo") as Polygon2D
	var shard := glass_kelp_reading_shard
	if shard == null:
		shard = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingShard") as Polygon2D
	var spark := glass_kelp_reading_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/GlassKelpLedge/ReadingCore/ReadingSpark") as Polygon2D
	if halo == null or shard == null or spark == null:
		return

	if run_glass_kelp_reading_recovered:
		halo.color = Color(0.58, 1.0, 0.84, 0.07)
		shard.color = Color(0.9, 1.0, 0.68, 0.16)
		spark.visible = false
	else:
		halo.color = Color(0.58, 1.0, 0.84, 0.42)
		shard.color = Color(0.9, 1.0, 0.68, 0.88)
		spark.color = Color(1.0, 1.0, 0.82, 0.9)
		spark.visible = true

func _sync_blackwater_crack_gate_state() -> void:
	var mouth := blackwater_crack_mouth
	if mouth == null:
		mouth = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth") as Polygon2D
	var wash := blackwater_pressure_wash
	if wash == null:
		wash = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash") as Polygon2D
	var seal_lip := blackwater_seal_lip
	if seal_lip == null:
		seal_lip = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip") as Polygon2D
	var gate_badge := blackwater_gate_badge
	if gate_badge == null:
		gate_badge = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge") as Polygon2D
	var gate_label := blackwater_gate_label
	if gate_label == null:
		gate_label = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel") as Label
	var closed_shard := blackwater_closed_shard
	if closed_shard == null:
		closed_shard = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard") as Polygon2D
	var sill := blackwater_sill
	if sill == null:
		sill = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	var sill_return := blackwater_sill_return_current
	if sill_return == null:
		sill_return = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue") as Polygon2D
	if mouth == null or wash == null or seal_lip == null or gate_badge == null or gate_label == null or closed_shard == null:
		return

	if _blackwater_crack_gate_open():
		mouth.color = Color(0.006, 0.028, 0.06, 0.52)
		wash.color = Color(0.12, 0.28, 0.42, 0.16)
		seal_lip.color = Color(0.58, 0.9, 0.8, 0.22)
		gate_badge.color = Color(0.62, 1.0, 0.82, 0.62)
		gate_label.text = "KEY READY"
		closed_shard.color = Color(0.54, 0.78, 0.92, 0.12)
		if sill != null:
			sill.visible = true
		if sill_return != null:
			sill_return.color = Color(0.62, 1.0, 0.9, 0.14)
		_sync_blackwater_trace_payoff_state()
	elif progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
		mouth.color = Color(0.002, 0.01, 0.026, 0.62)
		wash.color = Color(0.08, 0.16, 0.32, 0.2)
		seal_lip.color = Color(0.38, 0.58, 0.74, 0.28)
		gate_badge.color = Color(0.62, 0.86, 1.0, 0.58)
		gate_label.text = "KEY NEEDED"
		closed_shard.color = Color(0.54, 0.78, 0.92, 0.3)
		if sill != null:
			sill.visible = false
		_sync_blackwater_trace_payoff_state()
	else:
		mouth.color = Color(0.002, 0.01, 0.026, 0.64)
		wash.color = Color(0.08, 0.16, 0.32, 0.2)
		seal_lip.color = Color(0.38, 0.58, 0.74, 0.24)
		gate_badge.color = Color(0.38, 0.58, 0.74, 0.5)
		gate_label.text = "RESONANCE SEAL"
		closed_shard.color = Color(0.54, 0.78, 0.92, 0.28)
		if sill != null:
			sill.visible = false
		_sync_blackwater_trace_payoff_state()
	_sync_blackwater_signal_opportunity(_current_condition_id())

func _wreck_echo_route_available() -> bool:
	return progression_state.has_upgrade(PRESSURE_SEAL_UPGRADE_ID) and progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID)

func _sync_wreck_echo_state() -> void:
	var route_available := _wreck_echo_route_available()
	var trigger := wreck_echo_clue_trigger
	if trigger == null:
		trigger = get_node_or_null("WreckEchoDescent/ClueTrigger") as Area2D

	if trigger != null:
		trigger.visible = route_available
		trigger.monitoring = route_available and not run_wreck_echo_clue_recovered
		trigger.monitorable = route_available

	var wash := wreck_echo_route_wash
	if wash == null:
		wash = get_node_or_null("WreckEchoDescent/RouteWash") as Polygon2D
	if wash != null:
		wash.color = Color(0.54, 0.86, 1.0, 0.07 if route_available else 0.035)

	var rib_a := wreck_echo_rib_a
	if rib_a == null:
		rib_a = get_node_or_null("WreckEchoDescent/RibA") as Polygon2D
	if rib_a != null:
		rib_a.color = Color(0.78, 0.9, 1.0, 0.12 if route_available else 0.055)

	var rib_b := wreck_echo_rib_b
	if rib_b == null:
		rib_b = get_node_or_null("WreckEchoDescent/RibB") as Polygon2D
	if rib_b != null:
		rib_b.color = Color(0.78, 0.9, 1.0, 0.1 if route_available else 0.05)

	var clue_core := wreck_echo_clue_core
	if clue_core == null:
		clue_core = get_node_or_null("WreckEchoDescent/ClueTrigger/ClueCore") as Polygon2D
	if clue_core != null:
		clue_core.visible = route_available
		clue_core.color = Color(0.82, 0.96, 1.0, 0.06) if run_wreck_echo_clue_recovered else Color(0.82, 0.96, 1.0, 0.1)

	_sync_wreck_echo_clue_marker(route_available)

func _sync_wreck_echo_clue_marker(route_available: bool) -> void:
	var marker_nodes: Array[Polygon2D] = [
		wreck_echo_clue_marker_outer,
		wreck_echo_clue_marker_inner,
		wreck_echo_clue_marker_facet,
		wreck_echo_clue_marker_arc_a,
		wreck_echo_clue_marker_arc_b,
	]
	var marker_colors: Array[Color] = [
		Color(0.62, 0.86, 1.0, 0.06) if run_wreck_echo_clue_recovered else Color(0.62, 0.86, 1.0, 0.12),
		Color(0.82, 0.96, 1.0, 0.12) if run_wreck_echo_clue_recovered else Color(0.82, 0.96, 1.0, 0.24),
		Color(0.94, 1.0, 1.0, 0.26) if run_wreck_echo_clue_recovered else Color(0.94, 1.0, 1.0, 0.5),
		Color(0.7, 0.94, 1.0, 0.08) if run_wreck_echo_clue_recovered else Color(0.7, 0.94, 1.0, 0.18),
		Color(0.7, 0.94, 1.0, 0.08) if run_wreck_echo_clue_recovered else Color(0.7, 0.94, 1.0, 0.18),
	]
	for index in marker_nodes.size():
		var marker_node := marker_nodes[index]
		if marker_node != null:
			marker_node.visible = route_available
			marker_node.color = marker_colors[index]

func _sync_predator_warning_upgrade_state() -> void:
	var multiplier := predator_warning_1_multiplier if progression_state.has_upgrade(PREDATOR_WARNING_UPGRADE_ID) else 1.45
	if gulper_eel != null and gulper_eel.has_method("set_warning_radius_multiplier"):
		gulper_eel.set_warning_radius_multiplier(multiplier)

func _update_hud() -> void:
	_update_scan_target_feedback()
	_update_run_panel()
	_update_upgrade_menu()
	var is_diving := _active_hud_visible_for_result(dive_session.result)
	var has_surface_panel := _surface_hud_visible_for_result(dive_session.result)
	hint_label.visible = false
	bounds_hint_label.visible = false
	active_stats_panel.visible = is_diving
	oxygen_label.visible = is_diving
	depth_label.visible = is_diving
	base_direction_label.visible = is_diving
	cargo_label.visible = is_diving
	cargo_slots_root.visible = is_diving
	oxygen_label.text = _format_oxygen_label(dive_session.oxygen, dive_session.max_oxygen)
	depth_label.text = "Depth: %dm | Best: %dm" % [
		roundi(dive_session.current_depth),
		roundi(progression_state.best_depth_reached)
	]
	base_direction_label.text = _format_base_direction()
	_update_oxygen_feedback()
	cargo_label.text = "Cargo: %d / %d" % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit
	]
	_update_cargo_slots()
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

	prompt_label.text = _format_hud_prompt()

	_publish_visual_smoke_state()

func _publish_visual_smoke_state() -> void:
	if not OS.has_feature("web"):
		return

	var state := {
		"result": String(DIVE_RESULT_NAMES.get(dive_session.result, "unknown")),
		"surface_tab": SURFACE_TAB_NAMES[surface_tab_index].to_lower(),
		"debug_telemetry": show_debug_telemetry,
		"oxygen_state": _oxygen_state(dive_session.oxygen, dive_session.max_oxygen),
		"oxygen": ceili(dive_session.oxygen),
		"max_oxygen": ceili(dive_session.max_oxygen),
		"depth_meters": roundi(dive_session.current_depth),
		"best_depth_meters": roundi(progression_state.best_depth_reached),
		"cargo_count": dive_session.current_cargo.size(),
		"cargo_limit": dive_session.cargo_limit,
		"player_in_base": player_in_base,
		"has_left_base": dive_session.has_left_base,
		"run_panel_visible": run_panel.visible,
		"upgrade_panel_visible": upgrade_panel.visible,
		"active_stats_visible": active_stats_panel.visible,
		"wreck_echo_clue_recovered": run_wreck_echo_clue_recovered,
		"east_shelf_pocket_ping_recovered": run_east_shelf_pocket_ping_recovered,
		"lower_connector_echo_recovered": run_lower_connector_echo_recovered,
		"resonance_alcove_research_recovered": run_resonance_alcove_research_recovered,
		"blue_chimney_draft_reading_recovered": run_blue_chimney_draft_reading_recovered,
		"lantern_silt_sample_recovered": run_lantern_silt_sample_recovered,
		"blackwater_trace_recovered": run_blackwater_trace_recovered,
		"dusk_trench_reached": run_reached_dusk_trench,
		"glass_kelp_reading_recovered": run_glass_kelp_reading_recovered,
		"route_stage": visual_smoke_route_stage,
	}
	JavaScriptBridge.eval("window.__oceangameVisualState = %s;" % JSON.stringify(state), true)

func _active_hud_visible_for_result(result: int) -> bool:
	return result == DiveSessionScript.Result.DIVING

func _surface_hud_visible_for_result(result: int) -> bool:
	return result != DiveSessionScript.Result.DIVING

func _update_run_panel() -> void:
	var use_compact_panel := dive_session.result == DiveSessionScript.Result.EXTRACTED and surface_tab_index == SURFACE_TAB_UPGRADES
	_apply_run_panel_layout(use_compact_panel)
	surface_tabs_label.visible = _surface_tabs_enabled()
	surface_tabs_label.text = _format_surface_tabs() if surface_tabs_label.visible else ""
	if dive_session.result == DiveSessionScript.Result.READY:
		run_panel.visible = true
		run_title_label.text = _format_expedition_day_title("Ready")
		run_summary_label.text = _format_run_summary(_format_ready_panel_summary(), "ready")
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		run_panel.visible = true
		if surface_tab_index == SURFACE_TAB_UPGRADES:
			run_title_label.text = "Surface Upgrade Bay"
			run_summary_label.text = _format_run_summary("Banked:%s\n%s choose; %s buys.\n%s" % [
				_format_banked_resources(),
				_action_label("move_up_down"),
				_action_label("interact"),
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

func _apply_run_panel_layout(use_compact_panel: bool) -> void:
	var rect := RUN_PANEL_COMPACT_RECT if use_compact_panel else RUN_PANEL_TALL_RECT
	run_panel.offset_left = rect.position.x
	run_panel.offset_top = rect.position.y
	run_panel.offset_right = rect.position.x + rect.size.x
	run_panel.offset_bottom = rect.position.y + rect.size.y

	var content_right := RUN_PANEL_CONTENT_RIGHT_COMPACT if use_compact_panel else RUN_PANEL_CONTENT_RIGHT_TALL
	surface_tabs_label.offset_right = content_right
	run_title_label.offset_right = content_right
	run_summary_label.offset_right = content_right
	run_summary_label.offset_bottom = RUN_SUMMARY_COMPACT_BOTTOM if use_compact_panel else RUN_SUMMARY_TALL_BOTTOM

func _update_upgrade_menu() -> void:
	upgrade_panel.visible = dive_session.result == DiveSessionScript.Result.EXTRACTED and surface_tab_index == SURFACE_TAB_UPGRADES
	if not upgrade_panel.visible:
		return

	var upgrade := _selected_upgrade_definition()
	if upgrade == null:
		upgrade_menu_title_label.text = "Upgrade Bay"
		upgrade_menu_item_label.text = "No upgrades configured"
		upgrade_menu_cost_label.text = ""
		upgrade_menu_state_label.text = ""
		upgrade_menu_feedback_label.text = upgrade_menu_feedback
		return

	upgrade_menu_title_label.text = _format_upgrade_menu_title(
		selected_upgrade_index + 1,
		upgrade_definitions.size()
	)
	upgrade_menu_item_label.text = "%s\n%s" % [upgrade.display_name, upgrade.description]
	upgrade_menu_cost_label.text = "Cost: %s" % _format_upgrade_cost(upgrade.resource_cost)
	upgrade_menu_state_label.text = _format_upgrade_state(upgrade)

	upgrade_menu_feedback_label.text = _format_upgrade_panel_feedback(upgrade_menu_feedback)

func _format_upgrade_menu_title(selected_position: int, total_count: int) -> String:
	return "Upgrade Bay (%d/%d) - %s select" % [
		selected_position,
		total_count,
		_action_label("move_up_down"),
	]

func _format_ready_panel_summary() -> String:
	var lines: Array[String] = [
		"Start with %d oxygen." % ceili(dive_session.max_oxygen),
		"Collect, scan, push deeper, then return to bank cargo.",
		_format_condition_briefing(),
		ExpeditionGoalFormatterScript.format_goal(progression_state, upgrade_definitions, _current_condition_id()),
		"%s begins." % _action_label("interact"),
	]
	if show_debug_telemetry:
		lines.append("Debug: F9 resets prototype save.")

	return "\n".join(lines)

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

func _cargo_slot_states(resource_ids: Array[String], capacity: int, visible_slots := 4) -> Array[String]:
	var states: Array[String] = []
	for index in range(visible_slots):
		if index >= capacity:
			states.append("hidden")
		elif index < resource_ids.size():
			states.append(resource_ids[index])
		else:
			states.append("empty")

	return states

func _cargo_slot_color(state: String) -> Color:
	match state:
		"kelp_fiber":
			return Color(0.36, 0.86, 0.5, 0.95)
		"shell_fragments":
			return Color(0.94, 0.76, 0.46, 0.95)
		"glow_plankton":
			return Color(0.84, 0.98, 0.28, 0.95)
		"hidden":
			return Color(0.0, 0.0, 0.0, 0.0)
		"locked":
			return Color(0.012, 0.025, 0.032, 0.5)
		_:
			return Color(0.035, 0.1, 0.13, 0.9)

func _cargo_slot_icon_polygon(state: String) -> PackedVector2Array:
	match state:
		"kelp_fiber":
			return PackedVector2Array([Vector2(-3, 9), Vector2(-8, 4), Vector2(-4, -8), Vector2(0, -10), Vector2(3, 8), Vector2(8, 2), Vector2(6, 8)])
		"shell_fragments":
			return PackedVector2Array([Vector2(-9, 7), Vector2(-5, -5), Vector2(0, -9), Vector2(5, -5), Vector2(9, 7), Vector2(3, 10), Vector2(-3, 10)])
		"glow_plankton":
			return PackedVector2Array([Vector2(0, -9), Vector2(8, 0), Vector2(0, 9), Vector2(-8, 0)])
		_:
			return PackedVector2Array()

func _cargo_slot_icon_color(state: String) -> Color:
	match state:
		"kelp_fiber":
			return Color(0.78, 1.0, 0.74, 0.95)
		"shell_fragments":
			return Color(1.0, 0.96, 0.74, 0.95)
		"glow_plankton":
			return Color(0.98, 1.0, 0.54, 0.98)
		_:
			return Color(1.0, 1.0, 1.0, 0.0)

func _update_cargo_slots() -> void:
	var states := _cargo_slot_states(dive_session.current_cargo, dive_session.cargo_limit, cargo_slot_nodes.size())
	for index in range(cargo_slot_nodes.size()):
		var slot_visible := states[index] != "hidden"
		cargo_slot_nodes[index].color = _cargo_slot_color(states[index])
		cargo_slot_nodes[index].visible = slot_visible
		cargo_slot_icon_nodes[index].polygon = _cargo_slot_icon_polygon(states[index])
		cargo_slot_icon_nodes[index].color = _cargo_slot_icon_color(states[index])
		cargo_slot_icon_nodes[index].visible = slot_visible and cargo_slot_icon_nodes[index].polygon.size() > 0

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
		return "Burst: %ds cooldown" % ceili(burst_thruster_cooldown_remaining)

	return "%s: burst -%d O2" % [_action_label("burst_thruster"), ceili(burst_thruster_oxygen_cost)]

func _format_decoy_pulse_prompt() -> String:
	if progression_state.has_upgrade(DECOY_PULSE_UPGRADE_ID):
		return "Decoy spent" if decoy_pulse_used_this_run else "%s: decoy ready" % _action_label("decoy_pulse")
	if progression_state.has_discovery("gulper_eel"):
		return "Decoy locked"

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
	var effect_summary := _format_upgrade_effect_summary(upgrade)
	if progression_state.has_upgrade(upgrade.id):
		return "State: Owned\n%s" % effect_summary

	if upgrade.id == RESONANCE_KEY_UPGRADE_ID:
		return _format_resonance_key_upgrade_state(effect_summary)

	var missing_discovery := _upgrade_missing_discovery(upgrade)
	if missing_discovery != "":
		return "State: Locked by scan\nScan: %s\n%s" % [
			_format_discovery_name(missing_discovery),
			effect_summary,
		]

	var missing_upgrade := _upgrade_missing_upgrade(upgrade)
	if missing_upgrade != "":
		return "State: Locked by upgrade\nInstall: %s\n%s" % [
			_format_upgrade_display_name(missing_upgrade),
			effect_summary,
		]

	if progression_state.can_afford(upgrade.resource_cost):
		return "State: Available now\n%s: buy\n%s" % [
			_action_label("interact").replace("/", " or "),
			effect_summary,
		]

	return "State: Missing resources\nNeeds: %s\n%s" % [
		_format_missing_resources_inline(upgrade.resource_cost),
		effect_summary,
	]

func _format_resonance_key_upgrade_state(effect_summary: String) -> String:
	var missing_upgrade := _upgrade_missing_upgrade(RESONANCE_KEY_UPGRADE)
	if missing_upgrade != "":
		return "State: Locked by upgrade\nInstall: %s\n%s" % [
			_format_upgrade_display_name(missing_upgrade),
			effect_summary,
		]

	var missing_discovery := _upgrade_missing_discovery(RESONANCE_KEY_UPGRADE)
	if missing_discovery != "":
		return "State: Needs route research\nRecover: East Shelf or Drop Echo\n%s" % effect_summary

	if progression_state.can_afford(RESONANCE_KEY_UPGRADE.resource_cost):
		return "State: Available now\n%s: buy\n%s" % [
			_action_label("interact").replace("/", " or "),
			effect_summary,
		]

	return "State: Missing resources\nNeeds: %s\n%s" % [
		_format_missing_resources_inline(RESONANCE_KEY_UPGRADE.resource_cost),
		effect_summary,
	]

func _format_upgrade_effect_summary(upgrade: UpgradeDefinition) -> String:
	match upgrade.id:
		OXYGEN_TANK_UPGRADE_ID:
			return "Effect: +10 max O2."
		PRESSURE_SEAL_UPGRADE_ID:
			return "Effect: opens first pressure route."
		SIGNAL_LENS_UPGRADE_ID:
			return "Effect: material scan pulse."
		ECHO_LENS_UPGRADE_ID:
			return "Role: broad wreck echoes, not a locator."
		RESONANCE_KEY_UPGRADE_ID:
			return "Effect: opens East Shelf hatch only."
		CARGO_RACK_UPGRADE_ID:
			return "Effect: +1 cargo slot."
		PREDATOR_WARNING_UPGRADE_ID:
			return "Effect: earlier predator warning."
		DECOY_PULSE_UPGRADE_ID:
			return "Effect: one decoy window per expedition."

	return "Effect: %s" % upgrade.owned_text

func _format_upgrade_panel_feedback(feedback: String) -> String:
	if feedback.is_empty():
		return ""

	var compact := feedback
	compact = compact.replace("Deposited", "Banked")
	compact = compact.replace("resource(s) into the bank.", "resource(s).")
	compact = compact.replace("No upgrade ready yet; check missing requirements below.", "No upgrade ready yet.")
	compact = compact.replace("Ready upgrade:", "Ready:")
	compact = compact.replace("Purchased ", "Bought ")
	compact = compact.replace("\nBanked:", " | Banked:")

	var max_chars := 112
	if compact.length() > max_chars:
		return "%s..." % compact.substr(0, max_chars - 3)

	return compact

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

func _format_extraction_banking_line(extracted_count: int, extracted_cargo: Array[String]) -> String:
	if extracted_count > 0:
		return "Banked %d resource(s).%s" % [
			extracted_count,
			_format_resource_counts(extracted_cargo),
		]
	if not run_completed_scans.is_empty():
		return "Banked 0 resources. Useful dive: scan data came home."

	return "Banked 0 resources. No cargo or new scans came home."

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
		RESONANCE_KEY_UPGRADE_ID:
			return "Resonance Key I"
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
		"east_shelf_route_research":
			return "East Shelf or Drop Echo research"
		"gulper_eel":
			return "Gulper Eel"
		"lantern_ray":
			return "Lantern Ray"
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
	run_echo_lens_echo_fired = false
	run_wreck_echo_clue_recovered = false
	run_east_shelf_pocket_ping_recovered = false
	run_lower_connector_echo_recovered = false
	run_resonance_alcove_research_recovered = false
	run_blue_chimney_draft_reading_recovered = false
	run_lantern_silt_sample_recovered = false
	run_blackwater_trace_recovered = false
	run_reached_dusk_trench = false
	run_glass_kelp_reading_recovered = false
	debug_wreck_echo_review_staged = false
	visual_smoke_route_stage = ""
	echo_lens_pulse_timer = 0.0
	blue_chimney_draft_timer = 0.0
	blackwater_pressure_timer = 0.0
	lantern_ray_timing_timer = 0.0
	if echo_lens_pulse != null:
		echo_lens_pulse.visible = false
	_sync_east_shelf_pocket_payoff_state()
	_sync_blue_chimney_payoff_state()
	_sync_blackwater_trace_payoff_state()
	_sync_glass_kelp_reading_state()

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
	return "Next: press %s for Expedition %d; the ocean shifts again." % [
		_action_label("restart_dive"),
		progression_state.current_run_number + 1,
	]

func _format_expedition_ready_status() -> String:
	if _current_condition_id() == "low_visibility":
		return "Expedition %d ready: lower-trench visibility is poor today." % progression_state.current_run_number

	return "Expedition %d ready: the ocean changed overnight." % progression_state.current_run_number

func _format_expedition_day_title(suffix: String) -> String:
	return "Expedition Day %d %s" % [
		progression_state.current_run_number,
		suffix,
	]

func _format_completed_expedition_line(result_name: String) -> String:
	return "Expedition Day %d: %s." % [
		progression_state.current_run_number,
		result_name,
	]

func _format_extraction_result_summary(extracted_count: int, extracted_cargo: Array[String]) -> String:
	return "%s\n%s\n%s%s\n%s%s%s%s%s%s%s%s%s%s%s%s\n%s\n%s\nBest depth: %dm.\n%s" % [
		_format_completed_expedition_line("Extraction"),
		_format_extraction_banking_line(extracted_count, extracted_cargo),
		_format_region_memory_callout(),
		_format_discovery_memory_callout(),
		_format_route_choice_callout(),
		_format_gulper_research_callout(),
		_format_echo_lens_research_callout(),
		_format_wreck_echo_research_callout(),
		_format_east_shelf_pocket_research_callout(),
		_format_lower_connector_echo_research_callout(),
		_format_resonance_alcove_research_callout(),
		_format_blue_chimney_research_callout(),
		_format_lantern_silt_sample_research_callout(),
		_format_blackwater_trace_research_callout(),
		_format_glass_kelp_reading_callout(),
		_format_sealed_shelf_hatch_readiness_callout(),
		_format_upgrade_progress_callout(),
		_format_scan_progress_callout("Discoveries recorded"),
		roundi(progression_state.best_depth_reached),
		_format_next_expedition_prompt()
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
			return "Today: %s.\nLower-trench routes are murkier; bank early if unsure." % display_name
		"rare_signal":
			if progression_state.has_upgrade(RESONANCE_KEY_UPGRADE_ID):
				return "Today: %s.\nEast Shelf, Blue Chimney, or Blackwater pings are worth checking if oxygen allows." % display_name
			return "Today: %s.\nEast Shelf or Blue Chimney pings are worth checking if oxygen allows." % display_name
		"wreck_shift":
			return "Today: %s.\nThe pressure wreck route is the notable landmark today." % display_name

	return "Today: %s.\n%s" % [
		display_name,
		String(current_expedition_condition.get("briefing", "")),
	]

func _format_route_choice_callout() -> String:
	if run_reached_dusk_trench:
		return "Route choice: lower-route research push reached Dusk Trench."
	if run_blackwater_trace_recovered:
		return "Route choice: lower-route research push reached Blackwater."
	if run_blue_chimney_draft_reading_recovered:
		return "Route choice: lower-route research push reached Blue Chimney."
	if run_lantern_silt_sample_recovered:
		return "Route choice: lower-route research push reached Silt Vein."
	if run_lower_connector_echo_recovered:
		return "Route choice: lower-route research push reached Shelf Drop."
	if run_east_shelf_pocket_ping_recovered:
		return "Route choice: East Shelf research push paid off."
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
		return ""

	return "Route choice: banked a cautious resource run."

func _format_recent_route_memory() -> String:
	if run_reached_dusk_trench:
		return "Dusk Trench"
	if run_blackwater_trace_recovered:
		return "Blackwater"
	if run_blue_chimney_draft_reading_recovered:
		return "Blue Chimney"
	if run_lantern_silt_sample_recovered:
		return "Silt Vein"
	if run_lower_connector_echo_recovered:
		return "Shelf Drop"
	if run_east_shelf_pocket_ping_recovered:
		return "East Shelf"
	if run_predator_contacts > 0:
		return "Gulper Route"
	if run_completed_scans.has("wreck_signal_cache") or run_completed_scans.has("pressure_wreck_signal"):
		return "Wreck Shelf"
	if run_completed_scans.has("thermal_vent") or run_collected_resources.has("glow_plankton"):
		return "Thermal Vent"
	if run_completed_scans.has("shell_reef_shelf") or run_collected_resources.has("shell_fragments"):
		return "Shell Reef"
	if run_collected_resources.is_empty():
		return "none"

	return "Resource Run"

func _format_gulper_research_callout() -> String:
	if decoy_pulse_used_this_run:
		return "\nResearch: Decoy timing bent the Gulper route briefly."
	if run_predator_contacts > 0:
		return "\nResearch: Gulper strike confirms the warning lane is dangerous."
	if run_completed_scans.has("gulper_eel"):
		return "\nResearch: Gulper route timing observed."

	return ""

func _format_echo_lens_research_callout() -> String:
	if run_echo_lens_echo_fired:
		return "\nResearch: Echo Lens caught a weak wreck echo below the shelf."

	return ""

func _format_wreck_echo_research_callout() -> String:
	if run_wreck_echo_clue_recovered:
		return "\nResearch: Wreck Echo clue carried a deeper pressure signal below the shelf."

	return ""

func _format_east_shelf_pocket_research_callout() -> String:
	if run_east_shelf_pocket_ping_recovered:
		return "\nResearch: East Shelf signal core points to a sealed route below the arch."

	return ""

func _format_lower_connector_echo_research_callout() -> String:
	if run_lower_connector_echo_recovered:
		return "\nResearch: Drop Echo confirms the Shelf Drop Connector continues below East Shelf."

	return ""

func _format_resonance_alcove_research_callout() -> String:
	if run_resonance_alcove_research_recovered:
		return "\nResearch: Resonance Alcove echo suggests the hatch opens into a small tuned pocket."

	return ""

func _format_blue_chimney_research_callout() -> String:
	if run_blue_chimney_draft_reading_recovered:
		return "\nResearch: Blue Chimney survey core points toward a deeper side-route below Shelf Drop."

	return ""

func _format_lantern_silt_sample_research_callout() -> String:
	if run_lantern_silt_sample_recovered:
		return "\nResearch: Lantern Silt Sample confirms the left branch is the safer Silt Vein route."

	return ""

func _format_blackwater_trace_research_callout() -> String:
	if run_blackwater_trace_recovered:
		return "\nResearch: Blackwater Trace marks the right branch's deeper route signal; return via Silt Vein, Blue Chimney, Drop Arch."

	return ""

func _format_glass_kelp_reading_callout() -> String:
	if run_glass_kelp_reading_recovered:
		return "\nResearch: Glass Kelp reading confirms the Dusk Trench has a safer ledge route off the main dark water."

	return ""

func _format_sealed_shelf_hatch_readiness_callout() -> String:
	if not progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
		return ""
	if not run_east_shelf_pocket_ping_recovered and not run_lower_connector_echo_recovered:
		return ""

	return "\nLab note: Echo Lens reads the Sealed Shelf Hatch; Resonance Key planning can wait."

func _format_region_memory_callout() -> String:
	if run_reached_dusk_trench:
		return "Remembered place: Dusk Trench - return up-left through Blackwater and Silt Vein to Blue Chimney."
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
	if run_completed_scans.has("lantern_ray"):
		return "\nDiscovery remembered: Lantern Ray - lower-route movement can be observed without fighting."
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
		"route_memory": _format_recent_route_memory(),
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
		var line := "#%d %s: banked %d, route %s, scans %s, contacts %d, best %dm" % [
			int(entry.get("run_number", 0)),
			String(entry.get("result", "Unknown")),
			int(entry.get("banked_cargo_count", 0)),
			String(entry.get("route_memory", "none")),
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
		scan_target_label.text = "Scan: none nearby"
	else:
		scan_target_label.text = "Scan: %s [%s %s]" % [
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
		"lantern_ray":
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
	var direction_player := player
	if direction_player == null:
		direction_player = get_node_or_null("Player") as CharacterBody2D
	if direction_player == null:
		return "Base: here"

	var delta := direction_player.global_position - start_position
	if delta.length() < 48.0:
		return "Base: here"

	var directions := PackedStringArray()
	if delta.y > 48.0:
		directions.append("up")
	elif delta.y < -48.0:
		directions.append("below")

	if delta.x > 96.0:
		directions.append("left")
	elif delta.x < -96.0:
		directions.append("right")

	var direction_text := "-".join(directions)
	if direction_text.is_empty():
		direction_text = "nearby"

	var route_hint := ""
	if delta.x > 2100.0 and delta.y > 2400.0:
		route_hint = " via Blackwater/Silt/Blue"
	elif delta.x > 1500.0 and delta.y > 2100.0:
		route_hint = " via Silt/Blue"

	return "Base: %s %.0fm%s" % [direction_text, delta.length() / pixels_per_meter, route_hint]

func _oxygen_state(current_oxygen: float, maximum_oxygen: float) -> String:
	if maximum_oxygen <= 0.0:
		return "normal"

	var oxygen_ratio := current_oxygen / maximum_oxygen
	if oxygen_ratio <= CRITICAL_OXYGEN_RATIO:
		return "critical"
	if oxygen_ratio <= LOW_OXYGEN_RATIO:
		return "low"

	return "normal"

func _format_oxygen_label(current_oxygen: float, maximum_oxygen: float) -> String:
	var state := _oxygen_state(current_oxygen, maximum_oxygen)
	var suffix := ""
	if state == "critical":
		suffix = "  CRITICAL"
	elif state == "low":
		suffix = "  LOW"

	return "O2: %d / %d%s" % [ceili(current_oxygen), ceili(maximum_oxygen), suffix]

func _oxygen_warning_text(state: String) -> String:
	if state == "critical":
		return "O2 CRITICAL\nRETURN TO BASE"
	if state == "low":
		return "O2 LOW\nPLAN RETURN"

	return ""

func _oxygen_state_color(state: String) -> Color:
	if state == "critical":
		return Color(1.0, 0.18, 0.12, 1.0)
	if state == "low":
		return Color(1.0, 0.76, 0.22, 1.0)

	return Color.WHITE

func _update_oxygen_feedback() -> void:
	oxygen_warning_panel.visible = false
	oxygen_label.modulate = Color.WHITE
	base_direction_label.modulate = Color.WHITE
	oxygen_label.scale = Vector2.ONE
	base_direction_label.scale = Vector2.ONE

	if dive_session.result != DiveSessionScript.Result.DIVING or dive_session.max_oxygen <= 0.0:
		return

	var oxygen_state := _oxygen_state(dive_session.oxygen, dive_session.max_oxygen)
	var oxygen_color := _oxygen_state_color(oxygen_state)
	if oxygen_state == "critical":
		var pulse := 1.0 + 0.08 * absf(sin(Time.get_ticks_msec() / 90.0))
		oxygen_warning_panel.visible = true
		oxygen_warning_label.text = _oxygen_warning_text(oxygen_state)
		oxygen_warning_label.modulate = oxygen_color
		oxygen_label.modulate = oxygen_color
		base_direction_label.modulate = Color(1.0, 0.22, 0.14, 1.0)
		oxygen_label.scale = Vector2(pulse, pulse)
		base_direction_label.scale = Vector2(pulse, pulse)
	elif oxygen_state == "low":
		oxygen_warning_panel.visible = true
		oxygen_warning_label.text = _oxygen_warning_text(oxygen_state)
		oxygen_warning_label.modulate = oxygen_color
		oxygen_label.modulate = oxygen_color
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
