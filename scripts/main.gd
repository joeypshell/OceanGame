extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SurvivalStateScript := preload("res://scripts/survival_state.gd")
const SpawnPointScript := preload("res://scripts/spawn_point.gd")
const UpgradeDefinitionScript := preload("res://scripts/upgrade_definition.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const SpawnSelectionScript := preload("res://scripts/spawn_selection.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const Area01VisualDirectorScript := preload("res://scripts/area01_visual_director.gd")
const Area01BlockoutBuilderScript := preload("res://scripts/area01_blockout_builder.gd")
const MobileTouchControlsScript := preload("res://scripts/mobile_touch_controls.gd")
const OXYGEN_TANK_UPGRADE := preload("res://resources/upgrades/oxygen_tank_1.tres")
const PRESSURE_SEAL_UPGRADE := preload("res://resources/upgrades/pressure_seal_1.tres")
const SIGNAL_LENS_UPGRADE := preload("res://resources/upgrades/signal_lens_1.tres")
const ECHO_LENS_UPGRADE := preload("res://resources/upgrades/echo_lens_1.tres")
const RESONANCE_KEY_UPGRADE := preload("res://resources/upgrades/resonance_key_1.tres")
const CARGO_RACK_UPGRADE := preload("res://resources/upgrades/cargo_rack_1.tres")
const WATER_FILTER_UPGRADE := preload("res://resources/upgrades/water_filter_1.tres")
const PREDATOR_WARNING_UPGRADE := preload("res://resources/upgrades/predator_warning_1.tres")
const DECOY_PULSE_UPGRADE := preload("res://resources/upgrades/decoy_pulse_1.tres")
const SALVAGE_CUTTER_UPGRADE := preload("res://resources/upgrades/salvage_cutter_1.tres")

const OXYGEN_TANK_UPGRADE_ID := "oxygen_tank_1"
const PRESSURE_SEAL_UPGRADE_ID := "pressure_seal_1"
const SIGNAL_LENS_UPGRADE_ID := "signal_lens_1"
const ECHO_LENS_UPGRADE_ID := "echo_lens_1"
const RESONANCE_KEY_UPGRADE_ID := "resonance_key_1"
const CARGO_RACK_UPGRADE_ID := "cargo_rack_1"
const WATER_FILTER_UPGRADE_ID := "water_filter_1"
const PREDATOR_WARNING_UPGRADE_ID := "predator_warning_1"
const DECOY_PULSE_UPGRADE_ID := "decoy_pulse_1"
const SALVAGE_CUTTER_UPGRADE_ID := "salvage_cutter_1"
const PROGRESSION_SAVE_PATH := "user://progression_save.json"
const LOW_OXYGEN_RATIO := 0.25
const CRITICAL_OXYGEN_RATIO := 0.10
const STARTER_RESOURCE_PICKUP_NAMES := [
	"KelpFiber",
	"ShellFragments",
	"GlowPlankton",
	"ScrapMetal",
	"Driftwood",
	"QuartzGlass",
	"FoodSupply",
	"WaterSupply",
	"PowerSupply",
]
const RESOURCE_CATEGORY_LABELS := {
	"kelp_fiber": "Research",
	"shell_fragments": "Research",
	"glow_plankton": "Research",
	"scrap_metal": "Building",
	"driftwood": "Building",
	"quartz_glass": "Building",
}
const RESOURCE_CLUSTER_PATTERNS := [
	"cautious",
	"deep_reward",
]
const SURFACE_TAB_RESULT := 0
const SURFACE_TAB_UPGRADES := 1
const SURFACE_TAB_LOG := 2
const SURFACE_TAB_NIGHT := 3
const SURFACE_TAB_NAMES := ["Result", "Upgrades", "Log", "Night"]
const NIGHT_POWER_PATCH_COST := {
	"scrap_metal": 1,
}
const NIGHT_POWER_PATCH_POWER_GAIN := 1
const KEYBOARD_ACTION_LABELS := {
	"interact": "E/Enter",
	"restart_dive": "R",
	"move_left_right": "Left/Right",
	"move_up_down": "Up/Down",
	"scan": "F",
	"expedition_slate": "Tab",
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
const ACTIVE_STATS_RECT := Rect2(Vector2(16.0, 16.0), Vector2(272.0, 154.0))
const CARGO_PANEL_RECT := Rect2(Vector2(516.0, 14.0), Vector2(248.0, 48.0))
const DAYLIGHT_PANEL_RECT := Rect2(Vector2(792.0, 14.0), Vector2(216.0, 48.0))
const SURVIVAL_NEEDS_PANEL_RECT := Rect2(Vector2(1036.0, 16.0), Vector2(228.0, 106.0))
const DIVE_INFO_RECT := Rect2(Vector2(16.0, 184.0), Vector2(292.0, 94.0))
const SCAN_CARD_RECT := Rect2(Vector2(972.0, 236.0), Vector2(220.0, 88.0))
const TOOL_BELT_PANEL_RECT := Rect2(Vector2(486.0, 648.0), Vector2(308.0, 56.0))
const MINIMAP_PANEL_RECT := Rect2(Vector2(1052.0, 548.0), Vector2(188.0, 140.0))
const OXYGEN_WARNING_RECT := Rect2(Vector2(16.0, 594.0), Vector2(230.0, 70.0))
const EXPEDITION_SLATE_RECT := Rect2(Vector2(350.0, 116.0), Vector2(580.0, 386.0))
const EXPEDITION_SLATE_TITLE_RECT := Rect2(Vector2(18.0, 14.0), Vector2(544.0, 22.0))
const EXPEDITION_SLATE_BODY_RECT := Rect2(Vector2(18.0, 48.0), Vector2(544.0, 320.0))
const OXYGEN_ICON_POSITION := Vector2(18.0, 41.0)
const HEALTH_ICON_POSITION := Vector2(18.0, 77.0)
const DEPTH_ICON_POSITION := Vector2(18.0, 113.0)
const ACTIVE_HUD_CONTENT_LEFT := 28.0
const ACTIVE_HUD_CONTENT_RIGHT := 720.0
const HUD_SINGLE_ROW_HEIGHT := 20.0
const ACTIVE_HUD_LABEL_RECTS := {
	"oxygen": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 28.0), Vector2(232.0, HUD_SINGLE_ROW_HEIGHT)),
	"health": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 64.0), Vector2(232.0, HUD_SINGLE_ROW_HEIGHT)),
	"depth": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 100.0), Vector2(232.0, HUD_SINGLE_ROW_HEIGHT)),
	"base": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 128.0), Vector2(232.0, HUD_SINGLE_ROW_HEIGHT)),
	"cargo": Rect2(Vector2(716.0, 38.0), Vector2(40.0, HUD_SINGLE_ROW_HEIGHT)),
	"discoveries": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 146.0), Vector2(232.0, HUD_SINGLE_ROW_HEIGHT)),
	"scan": Rect2(Vector2(986.0, 266.0), Vector2(188.0, HUD_SINGLE_ROW_HEIGHT)),
	"prompt": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 230.0), Vector2(260.0, 18.0)),
	"status": Rect2(Vector2(ACTIVE_HUD_CONTENT_LEFT, 254.0), Vector2(260.0, 18.0)),
}
const DIVE_INFO_LABEL_RECTS := {
	"title": Rect2(Vector2(12.0, 10.0), Vector2(260.0, 18.0)),
	"objective": Rect2(Vector2(12.0, 31.0), Vector2(260.0, 18.0)),
}
const SCAN_CARD_LABEL_RECTS := {
	"title": Rect2(Vector2(986.0, 246.0), Vector2(188.0, 16.0)),
	"meta": Rect2(Vector2(986.0, 286.0), Vector2(188.0, 16.0)),
	"prompt": Rect2(Vector2(986.0, 306.0), Vector2(188.0, 16.0)),
}
const SCAN_RETICLE_SCREEN_MARGIN := 72.0
const SCAN_TARGET_STICKY_RANGE_BUFFER := 28.0
const OXYGEN_BAR_BACK_RECT := Rect2(Vector2(28.0, 52.0), Vector2(232.0, 8.0))
const OXYGEN_BAR_FILL_RECT := Rect2(Vector2(28.0, 52.0), Vector2(232.0, 8.0))
const HEALTH_BAR_BACK_RECT := Rect2(Vector2(28.0, 88.0), Vector2(232.0, 8.0))
const HEALTH_BAR_FILL_RECT := Rect2(Vector2(28.0, 88.0), Vector2(232.0, 8.0))
const DEPTH_BAR_BACK_RECT := Rect2(Vector2(28.0, 120.0), Vector2(232.0, 6.0))
const DEPTH_BAR_FILL_RECT := Rect2(Vector2(28.0, 120.0), Vector2(232.0, 6.0))
const CARGO_SLOT_ACTIVE_POSITION := Vector2(566.0, 32.0)
const DAYLIGHT_LABEL_RECT := Rect2(Vector2(832.0, 20.0), Vector2(136.0, 18.0))
const DAYLIGHT_BAR_BACK_RECT := Rect2(Vector2(832.0, 44.0), Vector2(136.0, 8.0))
const DAYLIGHT_BAR_FILL_RECT := Rect2(Vector2(832.0, 44.0), Vector2(136.0, 8.0))
const DAYLIGHT_SUN_ICON_POSITION := Vector2(814.0, 39.0)
const DAYLIGHT_MOON_ICON_POSITION := Vector2(986.0, 39.0)
const SURFACE_OXYGEN_REFILL_HOOK_PATH := "Area01ArtSlice/RuntimeSourceHooks/SurfaceOxygenRefillZoneArea"
const PLAYER_COLLISION_MASK := 1
const SURVIVAL_NEED_LABEL_RECTS := {
	"food": Rect2(Vector2(1070.0, 28.0), Vector2(140.0, 18.0)),
	"water": Rect2(Vector2(1070.0, 60.0), Vector2(140.0, 18.0)),
	"power": Rect2(Vector2(1070.0, 92.0), Vector2(140.0, 18.0)),
}
const SURVIVAL_NEED_BAR_BACK_RECTS := {
	"food": Rect2(Vector2(1070.0, 48.0), Vector2(136.0, 7.0)),
	"water": Rect2(Vector2(1070.0, 80.0), Vector2(136.0, 7.0)),
	"power": Rect2(Vector2(1070.0, 112.0), Vector2(136.0, 7.0)),
}
const SURVIVAL_NEED_ICON_POSITIONS := {
	"food": Vector2(1048.0, 39.0),
	"water": Vector2(1048.0, 71.0),
	"power": Vector2(1048.0, 103.0),
}
const DEPTH_RAIL_LINE_RECT := Rect2(Vector2(28.0, 304.0), Vector2(2.0, 280.0))
const DEPTH_RAIL_LABEL_RECTS := {
	"0": Rect2(Vector2(16.0, 282.0), Vector2(48.0, 18.0)),
	"50": Rect2(Vector2(16.0, 420.0), Vector2(48.0, 18.0)),
	"100": Rect2(Vector2(16.0, 558.0), Vector2(58.0, 18.0)),
}
const DEPTH_RAIL_MAX_DISPLAY_DEPTH := 120.0
const DIVE_STATUS_MAX_CHARS := 72
const ACTIVE_OBJECTIVE_MAX_CHARS := 46
const SURVIVAL_NEED_BAR_DISPLAY_MAX := 5.0
const TOOL_BELT_TOOL_IDS := ["scanner", "burst", "cutter", "decoy", "reserve"]
const ECHO_LENS_PULSE_DURATION := 1.2
const EAST_SHELF_SURGE_PERIOD_SECONDS := 2.4
const BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS := 2.9
const BLACKWATER_PRESSURE_PERIOD_SECONDS := 3.1
const LANTERN_RAY_TIMING_PERIOD_SECONDS := 2.6
const HOLLOW_REEF_TIMING_PERIOD_SECONDS := 3.4
const GLASSFIN_SWARM_SPACING_PERIOD_SECONDS := 3.0
const SALVAGE_SILT_TIMING_PERIOD_SECONDS := 2.8
const OUTER_SHELF_SLACKWATER_PERIOD_SECONDS := 3.2
const OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD := 0.72
const OUTER_SHELF_SLACKWATER_EASING_THRESHOLD := 0.42
const DUSK_TRENCH_MEMORY_MIN_X := 2700.0
const DUSK_TRENCH_MEMORY_MIN_Y := 2860.0
const DAYLIGHT_NORMAL_COLOR := Color(1.0, 0.78, 0.18, 0.96)
const DAYLIGHT_DUSK_COLOR := Color(0.82, 0.42, 1.0, 0.94)
const LATE_DAY_CARGO_WARNING_RATIO := 0.25
const HEALTH_NORMAL_COLOR := Color(0.42, 1.0, 0.5, 0.94)
const HEALTH_DAMAGED_COLOR := Color(1.0, 0.5, 0.26, 0.96)
const HEALTH_LOW_COLOR := Color(1.0, 0.72, 0.22, 0.96)
const HEALTH_CRITICAL_COLOR := Color(1.0, 0.18, 0.16, 0.98)

@export var max_oxygen := 30.0
@export var max_health := 100.0
@export var oxygen_tank_1_max_oxygen := 40.0
@export var base_cargo_limit := 3
@export var cargo_rack_1_limit := 4
@export var oxygen_drain_per_second := 0.95
@export var thermal_vent_health_damage := 18.0
@export var collect_oxygen_cost := 1.0
@export var scan_oxygen_cost := 2.0
@export var scan_hold_seconds := 1.0
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
@export var daylight_duration_seconds := 420.0
@export var surface_oxygen_refill_per_second := 18.0
@export var surface_oxygen_refill_depth := 200.0
@export var show_debug_telemetry := false

@onready var player: CharacterBody2D = $Player
@onready var base_zone: Area2D = $BaseZone
@onready var hint_label: Label = $HUD/Hint
@onready var bounds_hint_label: Label = $HUD/BoundsHint
@onready var active_stats_panel: Panel = $HUD/ActiveStatsPanel
@onready var cargo_panel: Panel = $HUD/CargoPanel
@onready var daylight_panel: Panel = $HUD/DaylightPanel
@onready var daylight_label: Label = $HUD/DaylightLabel
@onready var daylight_bar_back: ColorRect = $HUD/DaylightBarBack
@onready var daylight_bar_fill: ColorRect = $HUD/DaylightBarFill
@onready var daylight_sun_icon: Polygon2D = $HUD/DaylightSunIcon
@onready var daylight_moon_icon: Polygon2D = $HUD/DaylightMoonIcon
@onready var survival_needs_panel: Panel = $HUD/SurvivalNeedsPanel
@onready var oxygen_icon: Polygon2D = $HUD/OxygenIcon
@onready var health_icon: Polygon2D = $HUD/HealthIcon
@onready var depth_icon: Polygon2D = $HUD/DepthIcon
@onready var oxygen_label: Label = $HUD/Oxygen
@onready var oxygen_bar_back: ColorRect = $HUD/OxygenBarBack
@onready var oxygen_bar_fill: ColorRect = $HUD/OxygenBarFill
@onready var health_label: Label = $HUD/Health
@onready var health_bar_back: ColorRect = $HUD/HealthBarBack
@onready var health_bar_fill: ColorRect = $HUD/HealthBarFill
@onready var depth_label: Label = $HUD/Depth
@onready var depth_bar_back: ColorRect = $HUD/DepthBarBack
@onready var depth_bar_fill: ColorRect = $HUD/DepthBarFill
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
@onready var scan_card_panel: Panel = $HUD/ScanCardPanel
@onready var scan_card_title_label: Label = $HUD/ScanCardTitle
@onready var scan_card_meta_label: Label = $HUD/ScanCardMeta
@onready var scan_card_prompt_label: Label = $HUD/ScanCardPrompt
@onready var scan_reticle_root: Node2D = $HUD/ScanReticleRoot
@onready var dive_info_panel: Panel = $HUD/DiveInfoPanel
@onready var objective_title_label: Label = $HUD/DiveInfoPanel/ObjectiveTitle
@onready var objective_line_label: Label = $HUD/DiveInfoPanel/ObjectiveLine
@onready var oxygen_warning_panel: Panel = $HUD/OxygenWarningPanel
@onready var oxygen_warning_label: Label = $HUD/OxygenWarningPanel/OxygenWarning
@onready var oxygen_warning_icon: Polygon2D = $HUD/OxygenWarningPanel/OxygenWarningIcon
@onready var tool_belt_panel: Panel = $HUD/ToolBeltPanel
@onready var tool_slot_nodes: Array[ColorRect] = [
	$HUD/ToolBeltPanel/ToolSlot1,
	$HUD/ToolBeltPanel/ToolSlot2,
	$HUD/ToolBeltPanel/ToolSlot3,
	$HUD/ToolBeltPanel/ToolSlot4,
	$HUD/ToolBeltPanel/ToolSlot5,
]
@onready var tool_icon_nodes: Array[Polygon2D] = [
	$HUD/ToolBeltPanel/ToolIcon1,
	$HUD/ToolBeltPanel/ToolIcon2,
	$HUD/ToolBeltPanel/ToolIcon3,
	$HUD/ToolBeltPanel/ToolIcon4,
	$HUD/ToolBeltPanel/ToolIcon5,
]
@onready var tool_key_label_nodes: Array[Label] = [
	$HUD/ToolBeltPanel/ToolKey1,
	$HUD/ToolBeltPanel/ToolKey2,
	$HUD/ToolBeltPanel/ToolKey3,
	$HUD/ToolBeltPanel/ToolKey4,
	$HUD/ToolBeltPanel/ToolKey5,
]
@onready var food_need_label: Label = $HUD/FoodNeed
@onready var water_need_label: Label = $HUD/WaterNeed
@onready var power_need_label: Label = $HUD/PowerNeed
@onready var food_need_icon: Polygon2D = $HUD/FoodNeedIcon
@onready var water_need_icon: Polygon2D = $HUD/WaterNeedIcon
@onready var power_need_icon: Polygon2D = $HUD/PowerNeedIcon
@onready var food_need_bar_back: ColorRect = $HUD/FoodNeedBarBack
@onready var food_need_bar_fill: ColorRect = $HUD/FoodNeedBarFill
@onready var water_need_bar_back: ColorRect = $HUD/WaterNeedBarBack
@onready var water_need_bar_fill: ColorRect = $HUD/WaterNeedBarFill
@onready var power_need_bar_back: ColorRect = $HUD/PowerNeedBarBack
@onready var power_need_bar_fill: ColorRect = $HUD/PowerNeedBarFill
@onready var depth_rail_line: ColorRect = $HUD/DepthRailLine
@onready var depth_rail_marker: Polygon2D = $HUD/DepthRailMarker
@onready var depth_rail_labels: Array[Label] = [
	$HUD/DepthRailLabel0,
	$HUD/DepthRailLabel50,
	$HUD/DepthRailLabel100,
]
@onready var minimap_panel: Panel = $HUD/MinimapPanel
@onready var minimap_path: Line2D = $HUD/MinimapPanel/MinimapPath
@onready var minimap_player_marker: Polygon2D = $HUD/MinimapPanel/MinimapPlayerMarker
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
@onready var survival_supply_cache_interact_zone: Area2D = $SurvivalSupplyCache/InteractZone
@onready var survival_supply_cache_halo: Polygon2D = $SurvivalSupplyCache/SupplyHalo
@onready var survival_supply_cache_core: Polygon2D = $SurvivalSupplyCache/SupplyCore
@onready var survival_supply_cache_label: Label = $SurvivalSupplyCache/SupplyLabel
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
@onready var thermal_vent_hazard: Area2D = $Discoveries/ThermalVent
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
@onready var hollow_reef_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone
@onready var hollow_reef_reading_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo
@onready var hollow_reef_reading_shard: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard
@onready var hollow_reef_reading_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark
@onready var hollow_reef_timing_ribbon_upper: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonUpper
@onready var hollow_reef_timing_ribbon_lower: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonLower
@onready var hollow_reef_timing_tick_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickA
@onready var hollow_reef_timing_tick_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickB
@onready var wide_chamber_return_main: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow
@onready var wide_chamber_return_far: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib
@onready var wide_chamber_return_mid: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain
@onready var wide_chamber_return_entry: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain
@onready var salvage_hatch_panel: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SealedHatchPanel
@onready var salvage_lock_bars: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/LockBars
@onready var salvage_glint: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SalvageGlint
@onready var salvage_tool_label: Label = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/FutureCutterPort/ToolLabel
@onready var salvage_promise_label: Label = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/PromiseLabel
@onready var salvage_opened_pocket_lane: Node2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane
@onready var salvage_manifest_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/InteractZone
@onready var salvage_manifest_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestHalo
@onready var salvage_manifest_core: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestCore
@onready var salvage_manifest_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestSpark
@onready var salvage_data_cache_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/InteractZone
@onready var salvage_data_cache_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheHalo
@onready var salvage_data_cache_core: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheCore
@onready var salvage_data_cache_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheSpark
@onready var salvage_silt_wake: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWake
@onready var salvage_silt_window: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWindow
@onready var salvage_silt_tick_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickA
@onready var salvage_silt_tick_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickB
@onready var outer_shelf_slackwater_wake: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTimingWake
@onready var outer_shelf_slackwater_window: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterWindow
@onready var outer_shelf_slackwater_tick_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickA
@onready var outer_shelf_slackwater_tick_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickB
@onready var outer_shelf_survey_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/InteractZone
@onready var outer_shelf_survey_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyHalo
@onready var outer_shelf_survey_core: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyCore
@onready var outer_shelf_survey_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveySpark
@onready var rim_glass_reading_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/InteractZone
@onready var rim_glass_reading_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingHalo
@onready var rim_glass_reading_core: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingCore
@onready var rim_glass_reading_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingSpark
@onready var tideglass_sample_interact_zone: Area2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone
@onready var tideglass_sample_halo: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo
@onready var tideglass_sample_core: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore
@onready var tideglass_sample_spark: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark
@onready var mirror_kelp_reflective_backwater: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater
@onready var mirror_kelp_curtain_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA
@onready var mirror_kelp_curtain_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainB
@onready var mirror_kelp_curtain_c: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainC
@onready var mirror_kelp_bloom_approach_wash: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachWash
@onready var mirror_kelp_bloom_approach_rib: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachRib
@onready var lantern_ray_timing_lane_upper: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingLaneUpper
@onready var lantern_ray_timing_lane_lower: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingLaneLower
@onready var lantern_ray_timing_tick_a: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingTickA
@onready var lantern_ray_timing_tick_b: Polygon2D = $Creatures/LanternRayRoute/TimingLane/TimingTickB
@onready var lantern_ray_route: Node = $Creatures/LanternRayRoute
@onready var glassfin_swarm_spacing_wake: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWake
@onready var glassfin_swarm_spacing_window: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWindowPulse
@onready var glassfin_swarm_spacing_tick_a: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickA
@onready var glassfin_swarm_spacing_tick_b: Polygon2D = $EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickB
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
var survival_state := SurvivalStateScript.new()
var player_in_base := true
var surface_oxygen_refill_zone: Area2D = null
var player_in_surface_oxygen_refill := false
var player_near_survival_supply_cache := false
var player_near_east_shelf_pocket := false
var player_near_lower_connector_echo := false
var player_near_resonance_alcove := false
var player_near_blue_chimney := false
var player_near_lantern_silt_nook := false
var player_near_blackwater_crack := false
var player_near_glass_kelp_ledge := false
var player_near_hollow_reef := false
var player_near_salvage_manifest := false
var player_near_salvage_data_cache := false
var player_near_outer_shelf_survey := false
var player_near_rim_glass_reading := false
var player_near_tideglass_sample := false
var glow_plankton_highlight_timer := 0.0
var resource_scan_highlight_id := ""
var resource_scan_highlight_timer := 0.0
var echo_lens_pulse_timer := 0.0
var east_shelf_current_surge_timer := 0.0
var blue_chimney_draft_timer := 0.0
var blackwater_pressure_timer := 0.0
var lantern_ray_timing_timer := 0.0
var hollow_reef_timing_timer := 0.0
var glassfin_swarm_spacing_timer := 0.0
var salvage_silt_timing_timer := 0.0
var outer_shelf_slackwater_timer := 0.0
var daylight_elapsed_seconds := 0.0
var daylight_nightfall_announced := false
var daylight_nightfall_away_from_ship := false
var daylight_ship_offload_count := 0
var expedition_slate_open := false
var expedition_slate_panel: Panel = null
var expedition_slate_title_label: Label = null
var expedition_slate_body_label: Label = null
var burst_thruster_cooldown_remaining := 0.0
var decoy_pulse_used_this_run := false
var decoy_pulse_activated_this_scan := false
var last_result_summary := ""
var upgrade_menu_feedback := ""
var carried_tomorrow_intention := ""
var night_build_completed_this_surface := false
var current_resource_cluster_pattern := "cautious"
var current_expedition_condition: Dictionary = {}
var current_predator_route_id := "none"
var current_lantern_ray_route_id := "none"
var current_scan_target: Node = null
var scan_charge_target: Node = null
var scan_charge_elapsed := 0.0
var scan_hold_active := false
var selected_upgrade_index := 0
var surface_tab_index := SURFACE_TAB_RESULT
var upgrade_definitions: Array[UpgradeDefinition] = [
	WATER_FILTER_UPGRADE,
	OXYGEN_TANK_UPGRADE,
	PRESSURE_SEAL_UPGRADE,
	SIGNAL_LENS_UPGRADE,
	ECHO_LENS_UPGRADE,
	RESONANCE_KEY_UPGRADE,
	CARGO_RACK_UPGRADE,
	PREDATOR_WARNING_UPGRADE,
	DECOY_PULSE_UPGRADE,
	SALVAGE_CUTTER_UPGRADE,
]
var run_collected_resources: Array[String] = []
var run_collected_survival_supplies: Array[String] = []
var run_banked_survival_supplies: Array[String] = []
var run_completed_scans: Array[String] = []
var run_predator_contacts := 0
var run_health_damage_events := 0
var last_health_damage_source := ""
var last_health_damage_amount := 0.0
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
var run_hollow_reef_reading_recovered := false
var run_salvage_manifest_recovered := false
var run_salvage_data_cache_recovered := false
var run_outer_shelf_survey_recovered := false
var run_rim_glass_reading_recovered := false
var run_tideglass_sample_recovered := false
var run_survival_supply_cache_recovered := false
var last_night_report := ""
var last_completed_survival_day := 0
var debug_wreck_echo_review_staged := false
var visual_smoke_route_stage := ""
var show_area01_source_map_overlay := false
var area01_visual_director: Area01VisualDirector = null
var area01_source_map_overlay: Area01SourceMapOverlay = null
var mobile_touch_controls: CanvasLayer = null
var recent_expedition_log: Array[Dictionary] = []

func _ready() -> void:
	var area01_build := Area01BlockoutBuilderScript.new()
	if not area01_build.build(self):
		push_warning("Area 01 blockout authority failed: %s" % area01_build.last_error)
	_ensure_area01_source_map_overlay()
	_ensure_mobile_touch_controls()
	_wire_surface_oxygen_refill_zone()
	base_zone.body_entered.connect(_on_base_zone_body_entered)
	base_zone.body_exited.connect(_on_base_zone_body_exited)
	survival_supply_cache_interact_zone.body_entered.connect(_on_survival_supply_cache_body_entered)
	survival_supply_cache_interact_zone.body_exited.connect(_on_survival_supply_cache_body_exited)
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
	hollow_reef_interact_zone.body_entered.connect(_on_hollow_reef_body_entered)
	hollow_reef_interact_zone.body_exited.connect(_on_hollow_reef_body_exited)
	salvage_manifest_interact_zone.body_entered.connect(_on_salvage_manifest_body_entered)
	salvage_manifest_interact_zone.body_exited.connect(_on_salvage_manifest_body_exited)
	salvage_data_cache_interact_zone.body_entered.connect(_on_salvage_data_cache_body_entered)
	salvage_data_cache_interact_zone.body_exited.connect(_on_salvage_data_cache_body_exited)
	outer_shelf_survey_interact_zone.body_entered.connect(_on_outer_shelf_survey_body_entered)
	outer_shelf_survey_interact_zone.body_exited.connect(_on_outer_shelf_survey_body_exited)
	rim_glass_reading_interact_zone.body_entered.connect(_on_rim_glass_reading_body_entered)
	rim_glass_reading_interact_zone.body_exited.connect(_on_rim_glass_reading_body_exited)
	tideglass_sample_interact_zone.body_entered.connect(_on_tideglass_sample_body_entered)
	tideglass_sample_interact_zone.body_exited.connect(_on_tideglass_sample_body_exited)
	if thermal_vent_hazard != null:
		thermal_vent_hazard.body_entered.connect(_on_thermal_vent_hazard_body_entered)
	pressure_boundary.body_entered.connect(_on_pressure_boundary_body_entered)
	wreck_echo_clue_trigger.body_entered.connect(_on_wreck_echo_clue_body_entered)
	for pickup in get_tree().get_nodes_in_group("resource_pickups"):
		pickup.collected.connect(_on_resource_pickup_collected)
	_ensure_resource_role_visuals()
	for predator in get_tree().get_nodes_in_group("predators"):
		predator.contacted.connect(_on_predator_contacted)
	_load_progression()
	_prepare_next_run()
	_sync_debug_oxygen_mode()
	_sync_discovery_reveals()
	_sync_salvage_pocket_open_state()
	_sync_area01_source_map_overlay()
	_sync_surface_oxygen_refill_state_from_position()
	_update_hud()

func _ensure_mobile_touch_controls() -> void:
	if mobile_touch_controls != null:
		return
	mobile_touch_controls = MobileTouchControlsScript.new()
	mobile_touch_controls.name = "MobileTouchControls"
	mobile_touch_controls.connect("action_requested", Callable(self, "_on_mobile_touch_action_requested"))
	mobile_touch_controls.connect("action_released", Callable(self, "_on_mobile_touch_action_released"))
	add_child(mobile_touch_controls)

func _on_mobile_touch_action_requested(action: StringName) -> void:
	match action:
		&"interact":
			_handle_interact_action()
		&"restart_dive":
			_restart_dive()
		&"burst_thruster":
			_try_burst_thruster()
		&"scan":
			_begin_scan_charge()

func _on_mobile_touch_action_released(action: StringName) -> void:
	if action == &"scan":
		_cancel_scan_charge("Scan canceled.")

func _wire_surface_oxygen_refill_zone() -> void:
	surface_oxygen_refill_zone = get_node_or_null(SURFACE_OXYGEN_REFILL_HOOK_PATH) as Area2D
	if surface_oxygen_refill_zone == null:
		return

	surface_oxygen_refill_zone.monitoring = true
	surface_oxygen_refill_zone.monitorable = false
	surface_oxygen_refill_zone.collision_layer = 0
	surface_oxygen_refill_zone.collision_mask = PLAYER_COLLISION_MASK
	surface_oxygen_refill_zone.set_meta(&"area01_hook_status", "active_oxygen_refill")
	for child in surface_oxygen_refill_zone.get_children():
		if child is CollisionPolygon2D:
			(child as CollisionPolygon2D).disabled = false
		elif child is CollisionShape2D:
			(child as CollisionShape2D).disabled = false

	var entered_callback := Callable(self, "_on_surface_oxygen_refill_zone_body_entered")
	var exited_callback := Callable(self, "_on_surface_oxygen_refill_zone_body_exited")
	if not surface_oxygen_refill_zone.body_entered.is_connected(entered_callback):
		surface_oxygen_refill_zone.body_entered.connect(entered_callback)
	if not surface_oxygen_refill_zone.body_exited.is_connected(exited_callback):
		surface_oxygen_refill_zone.body_exited.connect(exited_callback)

func _process(delta: float) -> void:
	_consume_visual_smoke_command()
	_update_depth()
	if _expedition_pressure_paused():
		_update_hud()
		return

	_update_glow_plankton_highlight(delta)
	_update_resource_scan_highlight(delta)
	_update_echo_lens_pulse(delta)
	_update_east_shelf_current_surge(delta)
	_update_blue_chimney_reverse_draft(delta)
	_update_blackwater_pressure_cue(delta)
	_update_lantern_ray_timing_lane(delta)
	_update_hollow_reef_timing_current(delta)
	_update_glassfin_swarm_spacing_cue(delta)
	_update_salvage_silt_timing_cue(delta)
	_update_outer_shelf_slackwater_timing_cue(delta)
	_update_lantern_fry_idle()
	_update_burst_thruster_cooldown(delta)
	_update_scan_charge(delta)
	if dive_session.result != DiveSessionScript.Result.DIVING:
		_update_scan_target_feedback()
		return

	_advance_daylight_timer(delta)
	_update_active_dive_oxygen(delta)
	if dive_session.result == DiveSessionScript.Result.FAILED:
		_fail_dive()
	else:
		_update_hud()

func _update_active_dive_oxygen(delta: float) -> void:
	if _is_player_in_surface_oxygen_refill():
		_apply_surface_oxygen_refill(delta)
		return

	dive_session.drain_oxygen(oxygen_drain_per_second * delta)

func _apply_surface_oxygen_refill(delta: float) -> void:
	var oxygen_before := dive_session.oxygen
	dive_session.refill_oxygen(surface_oxygen_refill_per_second * delta)
	if daylight_nightfall_announced or status_label == null:
		return
	if dive_session.oxygen > oxygen_before + 0.01:
		status_label.text = _surface_oxygen_status_text()

func _surface_oxygen_status_text() -> String:
	if player_in_base:
		return "Ship moonpool: O2 full; %s banks cargo." % _action_label("interact")
	if dive_session.oxygen >= dive_session.max_oxygen:
		return "Surface O2 full; ship still banks cargo."
	return "Surface O2 refilling; ship still banks cargo."

func _cargo_full_status_text() -> String:
	return "Cargo full %d/%d: return to ship." % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit,
	]

func _is_player_in_surface_oxygen_refill() -> bool:
	if player == null:
		return player_in_surface_oxygen_refill

	var refill_floor_y := _surface_oxygen_refill_floor_y()
	if player.global_position.y > refill_floor_y + 24.0:
		return false

	return player_in_surface_oxygen_refill or player.global_position.y <= refill_floor_y

func _surface_oxygen_refill_active() -> bool:
	return dive_session.result == DiveSessionScript.Result.DIVING and _is_player_in_surface_oxygen_refill()

func _surface_oxygen_refill_floor_y() -> float:
	return surface_y + surface_oxygen_refill_depth

func _toggle_expedition_slate() -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	_set_expedition_slate_open(not expedition_slate_open)

func _close_expedition_slate() -> void:
	_set_expedition_slate_open(false)

func _set_expedition_slate_open(is_open: bool) -> void:
	if is_open and dive_session.result != DiveSessionScript.Result.DIVING:
		return
	if expedition_slate_open == is_open:
		return

	expedition_slate_open = is_open
	if player != null:
		player.velocity = Vector2.ZERO
		player.set_physics_process(not is_open)
	if is_open:
		_cancel_scan_charge("Expedition slate open: pressure paused.")
		if status_label != null:
			status_label.text = "Expedition slate open: pressure paused."
	else:
		if status_label != null and dive_session.result == DiveSessionScript.Result.DIVING:
			status_label.text = "Expedition slate closed."

	if is_inside_tree():
		_update_hud()

func _has_recent_health_damage() -> bool:
	return dive_session.result == DiveSessionScript.Result.DIVING and run_health_damage_events > 0 and dive_session.health < dive_session.max_health

func _format_health_damage_source_short(source: String = last_health_damage_source) -> String:
	var lowered := source.to_lower()
	if lowered.contains("thermal vent"):
		return "Thermal vent"
	if source.strip_edges().is_empty():
		return "Damage"

	return source.capitalize()

func _format_health_damage_status(source: String, amount: float) -> String:
	return "%s: -%d health. O2 unchanged." % [
		_format_health_damage_source_short(source),
		ceili(amount),
	]

func _expedition_pressure_paused() -> bool:
	return expedition_slate_open and dive_session.result == DiveSessionScript.Result.DIVING

func _ensure_expedition_slate_nodes() -> void:
	if expedition_slate_panel != null and is_instance_valid(expedition_slate_panel):
		return

	var hud := get_node_or_null("HUD")
	if hud == null:
		return

	expedition_slate_panel = Panel.new()
	expedition_slate_panel.name = "ExpeditionSlatePanel"
	expedition_slate_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	expedition_slate_panel.visible = false
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.015, 0.055, 0.075, 0.9)
	panel_style.border_color = Color(0.16, 0.78, 0.9, 0.62)
	panel_style.border_width_left = 2
	panel_style.border_width_top = 2
	panel_style.border_width_right = 2
	panel_style.border_width_bottom = 2
	panel_style.corner_radius_top_left = 6
	panel_style.corner_radius_top_right = 6
	panel_style.corner_radius_bottom_left = 6
	panel_style.corner_radius_bottom_right = 6
	expedition_slate_panel.add_theme_stylebox_override("panel", panel_style)
	hud.add_child(expedition_slate_panel)

	expedition_slate_title_label = Label.new()
	expedition_slate_title_label.name = "Title"
	expedition_slate_title_label.text = "EXPEDITION SLATE"
	expedition_slate_title_label.modulate = Color(0.58, 1.0, 0.96, 0.96)
	expedition_slate_title_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	expedition_slate_panel.add_child(expedition_slate_title_label)

	expedition_slate_body_label = Label.new()
	expedition_slate_body_label.name = "Body"
	expedition_slate_body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	expedition_slate_body_label.clip_text = true
	expedition_slate_body_label.modulate = Color(0.86, 0.96, 1.0, 0.94)
	expedition_slate_body_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	expedition_slate_panel.add_child(expedition_slate_body_label)

func _update_expedition_slate(is_diving: bool) -> void:
	_ensure_expedition_slate_nodes()
	if expedition_slate_panel == null:
		return

	var should_show := is_diving and expedition_slate_open
	expedition_slate_panel.visible = should_show
	_set_control_rect(expedition_slate_panel, EXPEDITION_SLATE_RECT)
	_set_control_rect(expedition_slate_title_label, EXPEDITION_SLATE_TITLE_RECT)
	_set_control_rect(expedition_slate_body_label, EXPEDITION_SLATE_BODY_RECT)
	if expedition_slate_body_label != null:
		expedition_slate_body_label.text = _format_expedition_slate_text()

func _format_expedition_slate_text() -> String:
	var route_goal := ExpeditionGoalFormatterScript.format_goal(progression_state, upgrade_definitions, _current_condition_id(), _latest_recent_route_memory())
	var route_goal_prefix := "Goal: "
	if route_goal.begins_with(route_goal_prefix):
		route_goal = route_goal.substr(route_goal_prefix.length())
	var lines: Array[String] = [
		"%s (%d%% daylight left)" % [_format_daylight_label(), roundi(_daylight_remaining_ratio() * 100.0)],
		"Pressure: O2 %d/%d, health %d/%d, depth %dm." % [
			ceili(dive_session.oxygen),
			ceili(dive_session.max_oxygen),
			ceili(dive_session.health),
			ceili(dive_session.max_health),
			roundi(dive_session.current_depth),
		],
		_format_current_cargo_slate_line(),
		"Base needs: %s" % survival_state.status_line(),
		"Tonight: Food -1, Water -1, Power -1.",
		_format_night_build_choice_line().replace("Build choice:", "Known build:"),
		"Day plan: %s" % _format_current_tomorrow_intention(),
		"Route goal: %s" % route_goal,
		"Decision: surface for O2, ship banks cargo, return before nightfall.",
		"%s closes. Active pressure is paused while open." % _action_label("expedition_slate"),
	]
	return "\n".join(lines)

func _format_current_cargo_slate_line() -> String:
	var cargo_count := dive_session.current_cargo.size()
	if cargo_count <= 0:
		return "Cargo: empty (%d slots open)." % dive_session.cargo_limit

	var parts: Array[String] = []
	for item_id in dive_session.current_cargo:
		parts.append(_short_resource_name(item_id))
	return "Cargo: %d / %d carried - %s." % [
		cargo_count,
		dive_session.cargo_limit,
		", ".join(parts),
	]

func _sync_surface_oxygen_refill_state_from_position() -> void:
	if player == null:
		return

	player_in_surface_oxygen_refill = player.global_position.y <= _surface_oxygen_refill_floor_y()

func _apply_health_damage(amount: float, source: String) -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return
	if amount <= 0.0:
		return

	var health_before := dive_session.health
	dive_session.damage_health(amount)
	if dive_session.health >= health_before:
		return

	run_health_damage_events += 1
	last_health_damage_source = source
	last_health_damage_amount = health_before - dive_session.health
	if dive_session.result == DiveSessionScript.Result.FAILED:
		run_failure_cause = "health depleted by %s" % source
		if is_inside_tree():
			_fail_dive()
		return

	if status_label != null:
		status_label.text = _format_health_damage_status(source, last_health_damage_amount)
	if is_inside_tree():
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
	elif _event is InputEventKey and _event.pressed and not _event.echo and _event.keycode == KEY_F10:
		_toggle_area01_source_map_overlay()
	elif Input.is_action_just_pressed("expedition_slate"):
		_toggle_expedition_slate()
	elif expedition_slate_open:
		return
	elif Input.is_action_just_pressed("interact"):
		_handle_interact_action()
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
		_begin_scan_charge()
	elif Input.is_action_just_released("scan"):
		_cancel_scan_charge("Scan canceled.")

func _handle_interact_action() -> void:
	if expedition_slate_open:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		_start_dive()
	elif dive_session.result == DiveSessionScript.Result.EXTRACTED:
		if surface_tab_index == SURFACE_TAB_NIGHT:
			_try_craft_night_power_patch()
		elif surface_tab_index == SURFACE_TAB_UPGRADES:
			_try_purchase_selected_upgrade()
		else:
			surface_tab_index = SURFACE_TAB_UPGRADES
			status_label.text = "Surface view: upgrades."
			_update_hud()
	else:
		if not _try_survival_supply_cache_interaction() and not _try_outer_shelf_survey_interaction() and not _try_rim_glass_reading_interaction() and not _try_tideglass_sample_interaction() and not _try_salvage_manifest_interaction() and not _try_salvage_data_cache_interaction() and not _try_resonance_alcove_interaction() and not _try_hollow_reef_interaction() and not _try_glass_kelp_ledge_interaction() and not _try_blackwater_crack_interaction() and not _try_lantern_silt_nook_interaction() and not _try_blue_chimney_interaction() and not _try_lower_connector_echo_interaction() and not _try_east_shelf_pocket_interaction():
			if not _try_ship_offload():
				_try_extract()

func _try_ship_offload() -> bool:
	if not _can_ship_offload():
		return false

	var offloaded_cargo := dive_session.current_cargo.duplicate()
	var offloaded_count := offloaded_cargo.size()
	var banked_resources := _bank_extracted_cargo(offloaded_cargo)
	var banked_survival_supplies := _bank_extracted_survival_supplies(offloaded_cargo)
	_remember_banked_survival_supplies(banked_survival_supplies)
	dive_session.clear_cargo()
	dive_session.oxygen = dive_session.max_oxygen
	daylight_ship_offload_count += 1
	upgrade_menu_feedback = "Ship offload banked %d cargo item(s).%s%s\nOxygen full. Daylight continues; dive again when ready." % [
		offloaded_count,
		_format_resource_counts(banked_resources),
		_format_survival_supply_counts(banked_survival_supplies),
	]
	if status_label != null:
		status_label.text = "Ship banked cargo; O2 full. Dive again."
	_save_progression()
	if is_inside_tree():
		_update_hud()
	return true

func _can_ship_offload() -> bool:
	return dive_session.result == DiveSessionScript.Result.DIVING and player_in_base and dive_session.has_left_base and not daylight_nightfall_announced and not dive_session.current_cargo.is_empty()

func _try_extract() -> void:
	if not dive_session.can_extract(player_in_base):
		return

	_close_expedition_slate()
	var extracted_cargo := dive_session.current_cargo.duplicate()
	var extracted_count := extracted_cargo.size()
	dive_session.extract()
	var banked_resources := _bank_extracted_cargo(extracted_cargo)
	var banked_survival_supplies := _bank_extracted_survival_supplies(extracted_cargo)
	_remember_banked_survival_supplies(banked_survival_supplies)
	_record_salvage_data_cache_discovery_if_extracted()
	last_completed_survival_day = survival_state.current_day
	_resolve_night_after_result()
	dive_session.clear_cargo()
	surface_tab_index = SURFACE_TAB_NIGHT
	last_result_summary = _format_extraction_result_summary(extracted_count, banked_resources, banked_survival_supplies)
	upgrade_menu_feedback = "Deposited %d cargo item(s).%s%s\n%s" % [
		extracted_count,
		_format_resource_counts(banked_resources),
		_format_survival_supply_counts(banked_survival_supplies),
		_format_ready_upgrade_callout(),
	]
	_record_recent_expedition("Extracted", extracted_count)
	_save_progression()
	status_label.text = "Night phase: food, water, and power resolved."
	_update_hud()

func _bank_extracted_cargo(extracted_cargo: Array[String]) -> Array[String]:
	var banked_resources: Array[String] = []
	for item_id in extracted_cargo:
		if not survival_state.is_supply_id(item_id):
			banked_resources.append(item_id)
	progression_state.bank_cargo(banked_resources)
	return banked_resources

func _bank_extracted_survival_supplies(extracted_cargo: Array[String]) -> Array[String]:
	var banked_supplies: Array[String] = []
	for item_id in extracted_cargo:
		if survival_state.bank_supply(item_id):
			banked_supplies.append(item_id)
	return banked_supplies

func _remember_banked_survival_supplies(supply_ids: Array[String]) -> void:
	for supply_id in supply_ids:
		run_banked_survival_supplies.append(supply_id)

func _resolve_night_after_result() -> void:
	var night_lines := survival_state.resolve_night(_nightfall_extra_power_cost())
	if _should_report_health_recovery_after_result():
		night_lines.append(_format_health_recovery_line())
	last_night_report = "\n".join(night_lines)
	_refresh_carried_tomorrow_intention()

func _try_craft_night_power_patch() -> bool:
	if dive_session.result != DiveSessionScript.Result.EXTRACTED or surface_tab_index != SURFACE_TAB_NIGHT:
		return false
	if survival_state.chapter_failed:
		_set_night_build_feedback("Night build unavailable: Emergency Week collapsed.")
		return false
	if survival_state.chapter_complete:
		_set_night_build_feedback("Night build unnecessary: base already stabilized.")
		return false
	if night_build_completed_this_surface:
		_set_night_build_feedback("Power Patch already installed for tomorrow.")
		return false
	if not progression_state.spend_resources(NIGHT_POWER_PATCH_COST):
		_set_night_build_feedback("Power Patch needs %s." % _format_missing_resources_inline(NIGHT_POWER_PATCH_COST))
		return false

	for index in range(NIGHT_POWER_PATCH_POWER_GAIN):
		survival_state.bank_supply(SurvivalStateScript.SUPPLY_POWER)
	night_build_completed_this_surface = true
	var result_line := "Night build: Power Patch spent Scrap Metal x1. Power +%d for tomorrow." % NIGHT_POWER_PATCH_POWER_GAIN
	_append_night_report_line(result_line)
	_refresh_carried_tomorrow_intention()
	_set_night_build_feedback(result_line)
	_save_progression()
	return true

func _append_night_report_line(line: String) -> void:
	if last_night_report.is_empty():
		last_night_report = line
	else:
		last_night_report = "%s\n%s" % [last_night_report, line]

func _set_night_build_feedback(message: String) -> void:
	upgrade_menu_feedback = message
	if status_label != null:
		status_label.text = message
	if is_inside_tree():
		_update_hud()

func _nightfall_extra_power_cost() -> int:
	if daylight_nightfall_away_from_ship:
		return 1

	return 0

func _should_report_health_recovery_after_result() -> bool:
	return dive_session.result == DiveSessionScript.Result.EXTRACTED and run_health_damage_events > 0 and dive_session.health < dive_session.max_health

func _format_health_recovery_line() -> String:
	return "Health: %d/%d returned; no surface heal; night med readies tomorrow." % [
		ceili(dive_session.health),
		ceili(dive_session.max_health),
	]

func _fail_dive() -> void:
	_close_expedition_slate()
	if run_failure_cause == "none":
		run_failure_cause = "oxygen depleted"
	surface_tab_index = SURFACE_TAB_RESULT
	upgrade_menu_feedback = ""
	_record_recent_expedition("Failed", 0)
	last_completed_survival_day = survival_state.current_day
	_resolve_night_after_result()
	last_result_summary = "%s\nCause: %s.\nCargo lost. Banked resources, upgrades, scans, and best depth kept.\n%s%s\n%s%s%s\n%s\nBest depth: %dm.\n%s%s" % [
		_format_completed_expedition_line("Failure"),
		_format_failure_cause_for_player(),
		_format_region_memory_callout(),
		_format_discovery_memory_callout(),
		_format_route_choice_callout(),
		_format_gulper_research_callout(),
		_format_echo_lens_research_callout(),
		_format_scan_progress_callout("Scans kept"),
		roundi(progression_state.best_depth_reached),
		_format_night_report_block(),
		_format_next_expedition_prompt(),
	]
	_save_progression()
	status_label.text = "Dive failed: %s. Cargo lost." % _format_failure_cause_for_player()
	_update_hud()

func _format_failure_cause_for_player() -> String:
	if run_failure_cause.contains("health depleted"):
		return "health depleted"
	if run_failure_cause.contains("thermal vent"):
		return "thermal vent damage"
	if run_failure_cause.contains("predator"):
		return "oxygen depleted after predator contact"

	return "oxygen depleted"

func _start_dive() -> void:
	_close_expedition_slate()
	if carried_tomorrow_intention.strip_edges().is_empty():
		_refresh_carried_tomorrow_intention()
	dive_session.start()
	surface_tab_index = SURFACE_TAB_RESULT
	upgrade_menu_feedback = ""
	_sync_surface_oxygen_refill_state_from_position()
	status_label.text = "Dive status: active"
	_update_hud()

func _restart_dive() -> void:
	_close_expedition_slate()
	if survival_state.chapter_failed:
		survival_state.reset_chapter()
		carried_tomorrow_intention = ""
	_prepare_next_run()
	if carried_tomorrow_intention.strip_edges().is_empty():
		_refresh_carried_tomorrow_intention()
	player.global_position = start_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	_sync_surface_oxygen_refill_state_from_position()
	last_result_summary = ""
	last_night_report = ""
	last_completed_survival_day = 0
	upgrade_menu_feedback = ""
	night_build_completed_this_surface = false
	surface_tab_index = SURFACE_TAB_RESULT
	_reset_resource_pickups()
	status_label.text = _format_expedition_ready_status()
	_update_hud()

func _reset_local_prototype_save() -> void:
	_close_expedition_slate()
	progression_state.reset()
	survival_state.reset_chapter()
	_delete_progression_save()
	_prepare_next_run()
	player.global_position = start_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	_sync_surface_oxygen_refill_state_from_position()
	last_result_summary = ""
	last_night_report = ""
	last_completed_survival_day = 0
	upgrade_menu_feedback = ""
	carried_tomorrow_intention = ""
	night_build_completed_this_surface = false
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
	dive_session.reset(_current_max_oxygen(), max_health)
	dive_session.cargo_limit = _current_cargo_limit()
	daylight_elapsed_seconds = 0.0
	daylight_nightfall_announced = false
	daylight_nightfall_away_from_ship = false
	daylight_ship_offload_count = 0
	night_build_completed_this_surface = false
	player_in_surface_oxygen_refill = false
	player_near_survival_supply_cache = false
	player_near_east_shelf_pocket = false
	player_near_lower_connector_echo = false
	player_near_resonance_alcove = false
	player_near_blue_chimney = false
	player_near_lantern_silt_nook = false
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	player_near_hollow_reef = false
	player_near_salvage_manifest = false
	player_near_salvage_data_cache = false
	player_near_outer_shelf_survey = false
	player_near_rim_glass_reading = false
	player_near_tideglass_sample = false
	_reset_run_telemetry()
	burst_thruster_cooldown_remaining = 0.0
	decoy_pulse_used_this_run = false
	_place_starter_resources_for_run()
	_sync_condition_visuals()
	_sync_wreck_echo_state()
	_sync_salvage_pocket_open_state()
	_sync_survival_supply_cache_state()

func _on_survival_supply_cache_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_survival_supply_cache = true
		if status_label != null:
			status_label.text = _format_survival_supply_cache_status_text()
		if is_inside_tree():
			_update_hud()

func _on_survival_supply_cache_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_survival_supply_cache = false
		if is_inside_tree():
			_update_hud()

func _on_base_zone_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_base = true
		_update_hud()

func _on_base_zone_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_base = false
		dive_session.has_left_base = true
		_update_hud()

func _on_surface_oxygen_refill_zone_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_surface_oxygen_refill = true
		if dive_session.result == DiveSessionScript.Result.DIVING and status_label != null:
			status_label.text = _surface_oxygen_status_text()
		if is_inside_tree():
			_update_hud()

func _on_surface_oxygen_refill_zone_body_exited(body: Node2D) -> void:
	if body == player:
		player_in_surface_oxygen_refill = false
		if is_inside_tree():
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
			status_label.text = "Glass Kelp: read kelp."
		if is_inside_tree():
			_update_hud()

func _on_glass_kelp_ledge_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_glass_kelp_ledge = false
		if is_inside_tree():
			_update_hud()

func _on_hollow_reef_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_hollow_reef = true
		if status_label != null:
			status_label.text = "Hollow Reef: read cave."
		if is_inside_tree():
			_update_hud()

func _on_hollow_reef_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_hollow_reef = false
		if is_inside_tree():
			_update_hud()

func _on_salvage_manifest_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_salvage_manifest = true
		if status_label != null and progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID):
			status_label.text = "Salvage: recover manifest."
		if is_inside_tree():
			_update_hud()

func _on_salvage_manifest_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_salvage_manifest = false
		if is_inside_tree():
			_update_hud()

func _on_salvage_data_cache_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_salvage_data_cache = true
		if status_label != null:
			status_label.text = "Salvage: recover data cache."
		if is_inside_tree():
			_update_hud()

func _on_salvage_data_cache_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_salvage_data_cache = false
		if is_inside_tree():
			_update_hud()

func _on_tideglass_sample_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_tideglass_sample = true
		if status_label != null:
			status_label.text = "Mirror Kelp: recover Tideglass."
		if is_inside_tree():
			_update_hud()

func _on_tideglass_sample_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_tideglass_sample = false
		if is_inside_tree():
			_update_hud()

func _on_outer_shelf_survey_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_outer_shelf_survey = true
		if status_label != null:
			status_label.text = _outer_shelf_slackwater_decision_text(outer_shelf_slackwater_timer)
		if is_inside_tree():
			_update_hud()

func _on_outer_shelf_survey_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_outer_shelf_survey = false
		if is_inside_tree():
			_update_hud()

func _on_rim_glass_reading_body_entered(body: Node2D) -> void:
	if body == player:
		player_near_rim_glass_reading = true
		if status_label != null:
			status_label.text = "Glass Rim: recover slackwater reading."
		if is_inside_tree():
			_update_hud()

func _on_rim_glass_reading_body_exited(body: Node2D) -> void:
	if body == player:
		player_near_rim_glass_reading = false
		if is_inside_tree():
			_update_hud()

func _try_survival_supply_cache_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_survival_supply_cache:
		return false

	if run_survival_supply_cache_recovered:
		if status_label != null:
			status_label.text = "Emergency cache already recovered this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	var supply_id: String = survival_state.most_needed_supply_id()
	if not dive_session.add_cargo(supply_id):
		status_label.text = _format_survival_supply_cache_full_status()
		_update_hud()
		return true

	run_survival_supply_cache_recovered = true
	run_collected_survival_supplies.append(supply_id)
	_sync_survival_supply_cache_state()
	status_label.text = _format_survival_supply_cache_recovered_status(supply_id)
	_update_hud()
	return true

func _format_survival_supply_cache_status_text() -> String:
	if survival_state.needs_are_stable():
		return "Emergency cache: base stable backup; uses cargo."
	return "Emergency cache: %s is lowest; uses cargo." % survival_state.short_name_for_supply(survival_state.most_needed_supply_id())

func _format_survival_supply_cache_prompt() -> String:
	if survival_state.needs_are_stable():
		return "Emergency cache: %s backup supply" % _action_label("interact")
	return "Emergency cache: %s recover %s" % [
		_action_label("interact"),
		survival_state.short_name_for_supply(survival_state.most_needed_supply_id()),
	]

func _format_survival_supply_cache_full_status() -> String:
	if survival_state.needs_are_stable():
		return "Cargo full: backup cache needs a slot."
	return "Cargo full: %s cache needs a slot." % survival_state.short_name_for_supply(survival_state.most_needed_supply_id())

func _format_survival_supply_cache_recovered_status(supply_id: String) -> String:
	return "Recovered %s for %s. Ship banks it tonight." % [
		survival_state.display_name_for_supply(supply_id),
		survival_state.short_name_for_supply(supply_id),
	]

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

func _try_hollow_reef_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_hollow_reef:
		return false

	if run_hollow_reef_reading_recovered:
		if status_label != null:
			status_label.text = "Hollow Reef cave reading already recorded this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_hollow_reef_reading_recovered = true
	run_reached_dusk_trench = true
	_sync_hollow_reef_reading_state()
	if status_label != null:
		status_label.text = "Hollow Reef cave reading recorded. Return safely through Dusk and Blackwater to keep the branch note."
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

func _try_salvage_data_cache_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_salvage_data_cache:
		return false

	if run_salvage_data_cache_recovered:
		if status_label != null:
			status_label.text = "Salvage data cache already recovered this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_salvage_data_cache_recovered = true
	run_reached_dusk_trench = true
	_sync_salvage_data_cache_state()
	if status_label != null:
		status_label.text = "Salvage data cache recovered for Salvage Cutter I prep. Return safely through Hollow Reef to keep the wreck note."
	if is_inside_tree():
		_update_hud()
	return true

func _try_salvage_manifest_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_salvage_manifest:
		return false
	if not progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID):
		return false

	if run_salvage_manifest_recovered:
		if status_label != null:
			status_label.text = "Salvage manifest already recovered this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_salvage_manifest_recovered = true
	run_reached_dusk_trench = true
	_sync_salvage_manifest_state()
	if status_label != null:
		status_label.text = "Salvage manifest recovered. Return safely or risk cargo space on nearby shell fragments."
	if is_inside_tree():
		_update_hud()
	return true

func _try_outer_shelf_survey_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_outer_shelf_survey:
		return false

	if run_outer_shelf_survey_recovered:
		if status_label != null:
			status_label.text = "Outer Shelf survey already recorded this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_outer_shelf_survey_recovered = true
	run_reached_dusk_trench = true
	_sync_outer_shelf_survey_state()
	if status_label != null:
		status_label.text = "Outer Shelf survey recorded. Choose nearby Kelp Fiber, return through Mirror/Wide/Hollow, or read the Glass Rim current: %s" % _outer_shelf_slackwater_decision_text(outer_shelf_slackwater_timer)
	if is_inside_tree():
		_update_hud()
	return true

func _try_rim_glass_reading_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_rim_glass_reading:
		return false

	if run_rim_glass_reading_recovered:
		if status_label != null:
			status_label.text = "Glass Rim reading already recovered this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_rim_glass_reading_recovered = true
	run_reached_dusk_trench = true
	_sync_rim_glass_reading_state()
	if status_label != null:
		status_label.text = "Glass Rim reading recovered. Bank it now, or risk nearby Kelp Fiber if oxygen allows."
	if is_inside_tree():
		_update_hud()
	return true

func _try_tideglass_sample_interaction() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING or not player_near_tideglass_sample:
		return false

	if run_tideglass_sample_recovered:
		if status_label != null:
			status_label.text = "Tideglass Sample already recorded this expedition."
		if is_inside_tree():
			_update_hud()
		return true

	run_tideglass_sample_recovered = true
	run_reached_dusk_trench = true
	_sync_tideglass_sample_state()
	if status_label != null:
		status_label.text = "Tideglass Sample recovered. Return safely through Wide Reef and Hollow Reef to keep the Mirror Kelp reading."
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
	_sync_debug_oxygen_mode()
	_sync_area01_source_map_overlay()
	status_label.text = "Debug telemetry: %s%s." % [
		"shown" if show_debug_telemetry else "hidden",
		" | unlimited oxygen" if show_debug_telemetry else "",
	]
	_update_hud()

func _toggle_area01_source_map_overlay() -> void:
	show_area01_source_map_overlay = not show_area01_source_map_overlay
	if show_area01_source_map_overlay:
		show_debug_telemetry = true
	_sync_debug_oxygen_mode()
	_ensure_area01_source_map_overlay()
	_sync_area01_source_map_overlay()
	status_label.text = "Area 01 source map overlay: %s." % ("shown" if show_area01_source_map_overlay else "hidden")
	_update_hud()

func _sync_debug_oxygen_mode() -> void:
	dive_session.unlimited_oxygen = show_debug_telemetry

func _ensure_area01_source_map_overlay() -> void:
	area01_source_map_overlay = _ensure_area01_visual_director().ensure_source_map_overlay(self)

func _ensure_area01_visual_director() -> Area01VisualDirector:
	if area01_visual_director != null and is_instance_valid(area01_visual_director):
		return area01_visual_director

	area01_visual_director = Area01VisualDirectorScript.new()
	add_child(area01_visual_director)
	return area01_visual_director

func _sync_area01_source_map_overlay() -> void:
	area01_source_map_overlay = _ensure_area01_visual_director().sync_source_map_overlay(
		self,
		scan_range,
		show_debug_telemetry,
		show_area01_source_map_overlay,
		_area01_overlay_capture_state(),
		_area01_overlay_camera_state()
	)

func _area01_overlay_capture_state() -> String:
	if not visual_smoke_route_stage.is_empty():
		return visual_smoke_route_stage
	return "day %d %s" % [survival_state.current_day, DiveSessionScript.Result.keys()[dive_session.result].to_lower()]

func _area01_overlay_camera_state() -> String:
	if player == null:
		return "player camera unavailable"
	var camera := player.get_node_or_null("Camera2D") as Camera2D
	if camera == null:
		return "camera unavailable"
	return "pos %.0f,%.0f zoom %.2f" % [camera.global_position.x, camera.global_position.y, camera.zoom.x]

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
	status_label.text = _oxygen_warning_text(_oxygen_state(dive_session.oxygen, dive_session.max_oxygen))
	_update_hud()

func _stage_debug_health_damage_visual_review() -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var vent := thermal_vent_hazard
	if vent == null:
		vent = get_node_or_null("Discoveries/ThermalVent") as Area2D
	if vent == null:
		return

	player = staged_player
	player.global_position = vent.global_position + Vector2(96.0, -48.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	player_in_surface_oxygen_refill = false
	dive_session.has_left_base = true
	dive_session.unlimited_oxygen = true
	dive_session.oxygen = dive_session.max_oxygen
	dive_session.health = dive_session.max_health
	visual_smoke_route_stage = "thermal_vent_health_damage"
	_apply_health_damage(thermal_vent_health_damage, "thermal vent heat")
	visual_smoke_route_stage = "thermal_vent_health_damage"
	_update_depth()
	_update_hud()

func _stage_debug_health_damage_extraction_visual_review() -> void:
	if run_health_damage_events == 0 or dive_session.health >= dive_session.max_health:
		_stage_debug_health_damage_visual_review()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	var review_base := base_zone
	if review_base == null:
		review_base = get_node_or_null("BaseZone") as Area2D
	if staged_player == null or review_base == null:
		return

	player = staged_player
	player.global_position = review_base.global_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	player_in_surface_oxygen_refill = true
	dive_session.has_left_base = true
	_try_extract()
	visual_smoke_route_stage = "health_damage_extracted"
	_update_hud()

func _stage_debug_daylight_visual_review(progress_ratio: float, label: String) -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	_set_daylight_progress_for_debug(progress_ratio)
	status_label.text = "Daylight %s: plan the next ship return." % label
	_update_hud()

func _stage_debug_daylight_cargo_warning_visual_review() -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	if dive_session.current_cargo.is_empty():
		dive_session.current_cargo.append("driftwood")
	_set_daylight_progress_for_debug(1.0 - LATE_DAY_CARGO_WARNING_RATIO)
	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player != null:
		player = staged_player
		player.global_position = start_position + Vector2(520.0, 460.0)
		player.velocity = Vector2.ZERO
	player_in_base = false
	player_in_surface_oxygen_refill = false
	dive_session.has_left_base = true
	status_label.text = "Dusk cargo: bank before night."
	visual_smoke_route_stage = "daylight_cargo_warning"
	_update_depth()
	_update_hud()

func _stage_debug_surface_oxygen_refill_visual_review() -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	player = staged_player
	player.global_position = Vector2(1600.0, _surface_oxygen_refill_floor_y() - 44.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	player_in_surface_oxygen_refill = true
	dive_session.has_left_base = true
	dive_session.oxygen = maxf(1.0, dive_session.max_oxygen * 0.18)
	dive_session.current_cargo.clear()
	dive_session.current_cargo.append("driftwood")
	visual_smoke_route_stage = "surface_oxygen_refill"
	status_label.text = _surface_oxygen_status_text()
	_update_depth()
	_update_hud()

func _stage_debug_ship_offload_visual_review() -> void:
	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	player = staged_player
	var review_base := base_zone
	if review_base == null:
		review_base = get_node_or_null("BaseZone") as Area2D
	if review_base == null:
		return

	player.global_position = review_base.global_position
	player.velocity = Vector2.ZERO
	player_in_base = true
	player_in_surface_oxygen_refill = true
	dive_session.has_left_base = true
	dive_session.oxygen = maxf(1.0, dive_session.max_oxygen * 0.22)
	dive_session.current_cargo.clear()
	dive_session.current_cargo.append("driftwood")
	visual_smoke_route_stage = "ship_offload_complete"
	_try_ship_offload()
	visual_smoke_route_stage = "ship_offload_complete"
	_update_depth()
	_update_hud()

func _stage_debug_area01_shell_visual_review(stage: String) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var target_position := Vector2(720.0, 940.0)
	var status := "Debug review: Area 01 central drop staged."
	match stage:
		"surface_entry":
			var supply_cache := get_node_or_null("SurvivalSupplyCache") as Node2D
			if supply_cache != null:
				target_position = supply_cache.global_position + Vector2(220.0, -10.0)
			else:
				target_position = Vector2(714.0, 428.0)
			status = "Debug review: Area 01 surface entry staged."
		"left_shelf_cave":
			var left_cave := get_node_or_null("Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket") as Node2D
			if left_cave != null:
				target_position = left_cave.global_position + Vector2(30.0, -48.0)
			else:
				target_position = Vector2(386.0, 956.0)
			status = "Debug review: Area 01 left shelf and cave pocket staged."
		"right_shelf_pocket":
			var right_shelf := get_node_or_null("Area01ArtSlice/GameplayObjects/RightShelfResourcePocket") as Node2D
			if right_shelf != null:
				target_position = right_shelf.global_position + Vector2(-70.0, -64.0)
			else:
				target_position = Vector2(1014.0, 786.0)
			status = "Debug review: Area 01 right shelf resource pocket staged."
		"west_chamber":
			target_position = Vector2(-360.0, 870.0)
			status = "Debug review: Area 01 west chamber staged."
		"right_chamber":
			var right_chamber := get_node_or_null("Area01ArtSlice/GameplayObjects/RightChamberResourcePocket") as Node2D
			if right_chamber != null:
				target_position = right_chamber.global_position + Vector2(-60.0, -58.0)
			else:
				target_position = Vector2(3000.0, 820.0)
			status = "Debug review: Area 01 far-right chamber staged."
		"deep_spine":
			target_position = _generated_area01_hook_visual_center("BlueChimneyReturnCurrentArea", Vector2(2208.0, 2304.0))
			status = "Debug review: Area 01 deep spine staged."
		"future_exit":
			target_position = _generated_area01_hook_visual_center("FutureDeepExitGateArea", Vector2(5568.0, 3040.0))
			status = "Debug review: Area 01 future exit corridor staged."
		"central_drop":
			target_position = Vector2(720.0, 940.0)
		_:
			return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player = staged_player
	player.global_position = target_position
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	visual_smoke_route_stage = "area01_%s" % stage
	status_label.text = status
	_update_depth()
	_update_hud()

func _generated_area01_hook_visual_center(area_name: String, fallback: Vector2) -> Vector2:
	var area := get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % area_name) as Area2D
	if area == null:
		return fallback
	for child in area.get_children():
		if child is Node2D and String(child.name).ends_with("VisualCue"):
			return (child as Node2D).global_position
	return fallback

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

func _stage_debug_hollow_reef_route_visual_review() -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var hollow_reef := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave") as Node2D
	if hollow_reef == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[RESONANCE_KEY_UPGRADE_ID] = true
	current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	_sync_sealed_shelf_hatch_state()
	_sync_blackwater_crack_gate_state()
	_sync_condition_visuals()
	_update_blackwater_pressure_cue(BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	player = staged_player
	player.global_position = hollow_reef.global_position + Vector2(-132.0, -28.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	player_near_hollow_reef = false
	run_reached_dusk_trench = true
	run_glass_kelp_reading_recovered = false
	run_hollow_reef_reading_recovered = false
	_sync_glass_kelp_reading_state()
	_sync_hollow_reef_reading_state()
	visual_smoke_route_stage = "hollow_reef_route"
	status_label.text = "Debug review: Hollow Reef entrance staged."
	_update_depth()
	_update_hud()

func _stage_debug_hollow_reef_payoff_visual_review(recovered := false) -> void:
	_stage_debug_hollow_reef_route_visual_review()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var hollow_interact := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteractZone") as Area2D
	if hollow_interact == null:
		return

	player.global_position = hollow_interact.global_position
	player.velocity = Vector2.ZERO
	player_near_hollow_reef = true
	run_reached_dusk_trench = true
	if recovered:
		_try_hollow_reef_interaction()
		visual_smoke_route_stage = "hollow_reef_return"
	else:
		run_hollow_reef_reading_recovered = false
		_sync_hollow_reef_reading_state()
		visual_smoke_route_stage = "hollow_reef_payoff"
		status_label.text = "Debug review: Hollow Reef payoff staged."
	_update_depth()
	_update_hud()

func _stage_debug_wide_chamber_visual_review(cutter_owned := false) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var chamber := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber") as Node2D
	if chamber == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	progression_state.purchased_upgrades[ECHO_LENS_UPGRADE_ID] = true
	progression_state.purchased_upgrades[RESONANCE_KEY_UPGRADE_ID] = true
	if cutter_owned:
		progression_state.purchased_upgrades[SALVAGE_CUTTER_UPGRADE_ID] = true
	current_expedition_condition = {
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	}
	_sync_sealed_shelf_hatch_state()
	_sync_blackwater_crack_gate_state()
	_sync_salvage_pocket_open_state()
	_sync_condition_visuals()
	_update_blackwater_pressure_cue(BLACKWATER_PRESSURE_PERIOD_SECONDS * 0.25)

	player = staged_player
	player.global_position = chamber.global_position + (Vector2(456.0, -88.0) if cutter_owned else Vector2(112.0, -18.0))
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	player_near_hollow_reef = false
	player_near_salvage_manifest = false
	player_near_salvage_data_cache = false
	run_reached_dusk_trench = true
	run_glass_kelp_reading_recovered = false
	run_hollow_reef_reading_recovered = true
	run_salvage_manifest_recovered = false
	run_salvage_data_cache_recovered = false
	_sync_glass_kelp_reading_state()
	_sync_hollow_reef_reading_state()
	_sync_salvage_manifest_state()
	_sync_salvage_data_cache_state()
	visual_smoke_route_stage = "wide_reef_salvage_open" if cutter_owned else "wide_reef_chamber"
	status_label.text = "Debug review: Wide Reef salvage pocket opened." if cutter_owned else "Debug review: Wide Reef Chamber staged."
	_update_depth()
	_update_hud()

func _stage_debug_mirror_kelp_visual_review(recovered := false, observed := false) -> void:
	if not OS.has_feature("web") and not show_debug_telemetry:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var mirror_kelp := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass") as Node2D
	if mirror_kelp == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	player = staged_player
	player.global_position = mirror_kelp.global_position + Vector2(118.0, 22.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	player_near_hollow_reef = false
	player_near_salvage_manifest = false
	player_near_salvage_data_cache = false
	player_near_tideglass_sample = false
	run_reached_dusk_trench = true
	run_salvage_manifest_recovered = false
	run_salvage_data_cache_recovered = false
	run_tideglass_sample_recovered = false
	while run_completed_scans.has("mirrorfin_drift"):
		run_completed_scans.erase("mirrorfin_drift")
	_sync_salvage_manifest_state()
	_sync_salvage_data_cache_state()
	_sync_tideglass_sample_state()
	visual_smoke_route_stage = "mirror_kelp_pass"
	if status_label != null:
		status_label.text = "Debug review: Mirror Kelp Pass staged."

	if recovered:
		var sample_zone := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/InteractZone") as Area2D
		if sample_zone != null:
			player.global_position = sample_zone.global_position
			player_near_tideglass_sample = true
			run_tideglass_sample_recovered = true
			run_reached_dusk_trench = true
			_sync_tideglass_sample_state()
			visual_smoke_route_stage = "mirror_kelp_tideglass"
			if status_label != null:
				status_label.text = "Debug review: Mirror Kelp Tideglass payoff staged."
	elif observed:
		var mirrorfin := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorfinDrift") as Node2D
		if mirrorfin != null:
			player.global_position = mirrorfin.global_position + Vector2(-42.0, 0.0)
		run_completed_scans.append("mirrorfin_drift")
		visual_smoke_route_stage = "mirror_kelp_mirrorfin"
		if status_label != null:
			status_label.text = "Debug review: Mirror Kelp Mirrorfin observation staged."

	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	if is_inside_tree() and active_stats_panel != null:
		_update_hud()

func _stage_debug_outer_shelf_visual_review() -> void:
	if not OS.has_feature("web") and not show_debug_telemetry:
		return

	var staged_player := player
	if staged_player == null:
		staged_player = get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var survey_zone := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/InteractZone") as Area2D
	if survey_zone == null:
		return

	if dive_session.result == DiveSessionScript.Result.READY:
		dive_session.start()
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var blackwater_sill := get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill") as Node2D
	if blackwater_sill != null:
		blackwater_sill.visible = true
	player = staged_player
	player.global_position = survey_zone.global_position + Vector2(-92.0, -36.0)
	player.velocity = Vector2.ZERO
	player_in_base = false
	dive_session.has_left_base = true
	dive_session.oxygen = dive_session.max_oxygen
	player_near_blackwater_crack = false
	player_near_glass_kelp_ledge = false
	player_near_hollow_reef = false
	player_near_salvage_manifest = false
	player_near_salvage_data_cache = false
	player_near_tideglass_sample = false
	player_near_outer_shelf_survey = true
	run_reached_dusk_trench = true
	run_glass_kelp_reading_recovered = false
	run_hollow_reef_reading_recovered = true
	run_salvage_manifest_recovered = false
	run_salvage_data_cache_recovered = false
	run_tideglass_sample_recovered = false
	run_outer_shelf_survey_recovered = false
	while run_completed_scans.has("mirrorfin_drift"):
		run_completed_scans.erase("mirrorfin_drift")
	_sync_salvage_manifest_state()
	_sync_salvage_data_cache_state()
	_sync_tideglass_sample_state()
	_sync_outer_shelf_survey_state()
	_update_outer_shelf_slackwater_timing_cue(OUTER_SHELF_SLACKWATER_PERIOD_SECONDS * 0.25)
	visual_smoke_route_stage = "outer_shelf_survey"
	if status_label != null:
		status_label.text = "Debug review: Outer Shelf survey and Glass Rim route staged."

	dive_session.current_depth = maxf(0.0, (player.global_position.y - surface_y) / pixels_per_meter)
	if is_inside_tree() and active_stats_panel != null:
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
		"health_damage":
			_stage_debug_health_damage_visual_review()
		"health_damage_extracted":
			_stage_debug_health_damage_extraction_visual_review()
		"daylight_morning":
			_stage_debug_daylight_visual_review(0.15, "morning")
		"daylight_evening":
			_stage_debug_daylight_visual_review(0.75, "evening")
		"daylight_cargo_warning":
			_stage_debug_daylight_cargo_warning_visual_review()
		"daylight_nightfall":
			_stage_debug_daylight_visual_review(1.0, "nightfall")
		"surface_oxygen_refill":
			_stage_debug_surface_oxygen_refill_visual_review()
		"ship_offload":
			_stage_debug_ship_offload_visual_review()
		"area01_surface_entry":
			_stage_debug_area01_shell_visual_review("surface_entry")
		"area01_left_shelf_cave":
			_stage_debug_area01_shell_visual_review("left_shelf_cave")
		"area01_right_shelf_pocket":
			_stage_debug_area01_shell_visual_review("right_shelf_pocket")
		"area01_west_chamber":
			_stage_debug_area01_shell_visual_review("west_chamber")
		"area01_right_chamber":
			_stage_debug_area01_shell_visual_review("right_chamber")
		"area01_deep_spine":
			_stage_debug_area01_shell_visual_review("deep_spine")
		"area01_future_exit":
			_stage_debug_area01_shell_visual_review("future_exit")
		"area01_central_drop":
			_stage_debug_area01_shell_visual_review("central_drop")
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
		"hollow_reef_route":
			_stage_debug_hollow_reef_route_visual_review()
		"hollow_reef_payoff":
			_stage_debug_hollow_reef_payoff_visual_review(false)
		"hollow_reef_return":
			_stage_debug_hollow_reef_payoff_visual_review(true)
		"wide_reef_chamber":
			_stage_debug_wide_chamber_visual_review()
		"wide_reef_salvage_open":
			_stage_debug_wide_chamber_visual_review(true)
		"mirror_kelp_pass":
			_stage_debug_mirror_kelp_visual_review()
		"mirror_kelp_tideglass":
			_stage_debug_mirror_kelp_visual_review(true)
		"mirror_kelp_mirrorfin":
			_stage_debug_mirror_kelp_visual_review(false, true)
		"outer_shelf_survey":
			_stage_debug_outer_shelf_visual_review()
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
		if surface_tab_index == SURFACE_TAB_NIGHT:
			prompt = _format_night_build_prompt()
		elif _all_upgrades_owned():
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
	elif player_near_survival_supply_cache:
		if run_survival_supply_cache_recovered:
			prompt = "Emergency cache recovered"
		else:
			prompt = _format_survival_supply_cache_prompt()
	elif player_near_resonance_alcove:
		prompt = "Resonance Alcove: %s record hatch echo" % _action_label("interact")
	elif player_near_glass_kelp_ledge:
		if run_glass_kelp_reading_recovered:
			prompt = "Glass Kelp read"
		else:
			prompt = "Glass Kelp: %s" % _action_label("interact")
	elif player_near_hollow_reef:
		if run_hollow_reef_reading_recovered:
			prompt = "Hollow Reef read"
		else:
			prompt = "Hollow Reef: %s" % _action_label("interact")
	elif player_near_salvage_manifest and progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID):
		if run_salvage_manifest_recovered:
			prompt = "Salvage manifest"
		else:
			prompt = "Salvage manifest: %s" % _action_label("interact")
	elif player_near_salvage_data_cache:
		if run_salvage_data_cache_recovered:
			prompt = "Salvage cache"
		else:
			prompt = "Salvage cache: %s" % _action_label("interact")
	elif player_near_tideglass_sample:
		if run_tideglass_sample_recovered:
			prompt = "Tideglass read"
		else:
			prompt = "Tideglass: %s" % _action_label("interact")
	elif player_near_rim_glass_reading:
		if run_rim_glass_reading_recovered:
			prompt = "Glass Rim reading recovered"
		else:
			prompt = "Glass Rim reading: %s" % _action_label("interact")
	elif player_near_outer_shelf_survey:
		if run_outer_shelf_survey_recovered:
			prompt = _outer_shelf_slackwater_decision_prompt(outer_shelf_slackwater_timer)
		else:
			prompt = "Outer Shelf survey: %s" % _action_label("interact")
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
			if _can_ship_offload():
				prompt = "At ship: %s offload cargo %d/%d, O2 full" % [
					_action_label("interact"),
					dive_session.current_cargo.size(),
					dive_session.cargo_limit,
				]
			elif daylight_nightfall_announced:
				if daylight_nightfall_away_from_ship:
					prompt = "At ship: %s start night; late Power -1" % _action_label("interact")
				else:
					prompt = "At ship: %s start night; resolve needs" % _action_label("interact")
			else:
				prompt = "At ship: cargo banked; O2 full; dive again"
		else:
			prompt = "Leave moonpool, then return to bank"
	elif daylight_nightfall_announced:
		if daylight_nightfall_away_from_ship:
			prompt = "Nightfall: return to ship | cargo at risk | late Power -1"
		else:
			prompt = "Nightfall: return to ship"
	elif _should_warn_late_day_cargo_banking():
		prompt = "Bank at ship | Power risk"
	elif _is_player_in_surface_oxygen_refill():
		if dive_session.oxygen >= dive_session.max_oxygen:
			if _has_recent_health_damage():
				prompt = "O2 only; health %d/%d; ship banks" % [
					ceili(dive_session.health),
					ceili(dive_session.max_health),
				]
			else:
				prompt = "O2 full | Cargo %d/%d | Ship banks" % [
					dive_session.current_cargo.size(),
					dive_session.cargo_limit,
				]
		else:
			if _has_recent_health_damage():
				prompt = "O2 only; health %d/%d; ship banks" % [
					ceili(dive_session.health),
					ceili(dive_session.max_health),
				]
			else:
				prompt = "O2 refill | Cargo %d/%d | Ship banks" % [
					dive_session.current_cargo.size(),
					dive_session.cargo_limit,
				]
	else:
		if _has_recent_health_damage():
			prompt = "Surface O2 only; ship banks cargo"
		else:
			prompt = "Explore | Surface for O2 | Ship banks"

	if dive_session.result == DiveSessionScript.Result.DIVING:
		prompt += " | %s" % _format_burst_thruster_prompt()
		var decoy_prompt := _format_decoy_pulse_prompt()
		if not decoy_prompt.is_empty():
			prompt += " | %s" % decoy_prompt

	return prompt

func _format_night_build_prompt() -> String:
	var action := "review"
	if not night_build_completed_this_surface and not survival_state.chapter_failed and not survival_state.chapter_complete:
		action = "craft Power Patch" if progression_state.can_afford(NIGHT_POWER_PATCH_COST) else "check Power Patch"
	return "Night build: %s %s, %s next expedition | %s surface view" % [
		_action_label("interact"),
		action,
		_action_label("restart_dive"),
		_action_label("move_left_right"),
	]

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
		if upgrade.id == SALVAGE_CUTTER_UPGRADE_ID:
			upgrade_menu_feedback = "Missing evidence: Salvage Data Cache. %s" % upgrade.locked_reason
			status_label.text = "%s needs recovered salvage data." % upgrade.display_name
			_update_hud()
			return
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
		_refresh_carried_tomorrow_intention()
		upgrade_menu_feedback = "Purchased %s. Next: %s" % [
			upgrade.display_name,
			_format_current_tomorrow_intention(),
		]
		_save_progression()
		status_label.text = "Purchased %s." % upgrade.display_name
	else:
		var missing_resources := _format_missing_resources_inline(upgrade.resource_cost)
		upgrade_menu_feedback = "Missing %s. Next: bank it for %s." % [
			missing_resources,
			upgrade.display_name,
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

	if not dive_session.unlimited_oxygen and dive_session.oxygen <= burst_thruster_oxygen_cost:
		status_label.text = "Burst Thruster needs more than %d oxygen." % ceili(burst_thruster_oxygen_cost)
		_update_hud()
		return

	var burst_direction: Vector2 = player.get_burst_direction()
	player.burst(burst_direction, burst_thruster_force)
	dive_session.drain_oxygen(burst_thruster_oxygen_cost)
	burst_thruster_cooldown_remaining = burst_thruster_cooldown_seconds
	status_label.text = "Burst Thruster: %s Cooldown started." % ("debug oxygen unchanged." if dive_session.unlimited_oxygen else "-%d oxygen." % ceili(burst_thruster_oxygen_cost))
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
		"water_reserve_1":
			survival_state.water += 1
		"predator_warning_range_1":
			_sync_predator_warning_upgrade_state()
		"decoy_pulse_1":
			pass
		"salvage_cutter_1":
			_sync_salvage_pocket_open_state()
		_:
			push_warning("Unknown upgrade effect: %s" % effect_id)

func _begin_scan_charge() -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var target := _scan_target_candidate()
	if target == null:
		status_label.text = "No scan target nearby."
		_update_hud()
		return

	scan_charge_target = target
	scan_charge_elapsed = 0.0
	scan_hold_active = true
	status_label.text = _format_scan_charge_status(target)
	_update_hud()

func _cancel_scan_charge(message := "") -> void:
	if scan_charge_target == null and not scan_hold_active:
		return
	scan_charge_target = null
	scan_charge_elapsed = 0.0
	scan_hold_active = false
	if not message.is_empty() and dive_session.result == DiveSessionScript.Result.DIVING:
		status_label.text = message
		_update_hud()

func _update_scan_charge(delta: float) -> void:
	if scan_charge_target == null:
		return
	if dive_session.result != DiveSessionScript.Result.DIVING:
		_cancel_scan_charge()
		return
	if not scan_hold_active:
		_cancel_scan_charge("Scan canceled.")
		return
	if not _scan_target_still_selectable(scan_charge_target):
		_cancel_scan_charge("Scan lost: target out of range.")
		return

	scan_charge_elapsed = minf(scan_hold_seconds, scan_charge_elapsed + delta)
	if scan_charge_elapsed >= scan_hold_seconds:
		var completed_target := scan_charge_target
		scan_charge_target = null
		scan_charge_elapsed = 0.0
		scan_hold_active = false
		_try_scan(completed_target)
	else:
		status_label.text = _format_scan_charge_status(scan_charge_target)
		_update_hud()

func _format_scan_charge_status(target: Node) -> String:
	var percent := int(roundf(_scan_charge_ratio() * 100.0))
	return "Scanning %s: %d%%" % [_scan_target_display_name(target), percent]

func _scan_charge_ratio() -> float:
	if scan_hold_seconds <= 0.0:
		return 1.0
	return clampf(scan_charge_elapsed / scan_hold_seconds, 0.0, 1.0)

func _try_scan(requested_target: Node = null) -> void:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return

	var target := requested_target if requested_target != null else _nearest_scan_target()
	if target != null and not _scan_target_still_selectable(target):
		target = null
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
		return "Depth: %s. Role: %s. %s" % [
			_format_depth_band(target.definition.depth_band),
			_resource_role_summary(target.definition.id),
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

func _update_hollow_reef_timing_current(delta: float) -> void:
	var upper := hollow_reef_timing_ribbon_upper
	if upper == null:
		upper = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonUpper") as Polygon2D
		hollow_reef_timing_ribbon_upper = upper
	var lower := hollow_reef_timing_ribbon_lower
	if lower == null:
		lower = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonLower") as Polygon2D
		hollow_reef_timing_ribbon_lower = lower
	var tick_a := hollow_reef_timing_tick_a
	if tick_a == null:
		tick_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickA") as Polygon2D
		hollow_reef_timing_tick_a = tick_a
	var tick_b := hollow_reef_timing_tick_b
	if tick_b == null:
		tick_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickB") as Polygon2D
		hollow_reef_timing_tick_b = tick_b

	hollow_reef_timing_timer = fposmod(hollow_reef_timing_timer + delta, HOLLOW_REEF_TIMING_PERIOD_SECONDS)
	var cue_alpha := _hollow_reef_timing_current_alpha(hollow_reef_timing_timer)
	if upper != null:
		upper.color = Color(0.86, 0.78, 1.0, cue_alpha)
	if lower != null:
		lower.color = Color(0.86, 0.78, 1.0, maxf(0.06, cue_alpha - 0.035))
	if tick_a != null:
		tick_a.color = Color(0.98, 0.94, 1.0, cue_alpha + 0.05)
	if tick_b != null:
		tick_b.color = Color(0.98, 0.94, 1.0, maxf(0.1, cue_alpha + 0.02))

func _hollow_reef_timing_current_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / HOLLOW_REEF_TIMING_PERIOD_SECONDS) * TAU)
	return 0.08 + (phase + 1.0) * 0.035

func _update_glassfin_swarm_spacing_cue(delta: float) -> void:
	var wake := glassfin_swarm_spacing_wake
	if wake == null:
		wake = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWake") as Polygon2D
		glassfin_swarm_spacing_wake = wake
	var window := glassfin_swarm_spacing_window
	if window == null:
		window = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWindowPulse") as Polygon2D
		glassfin_swarm_spacing_window = window
	var tick_a := glassfin_swarm_spacing_tick_a
	if tick_a == null:
		tick_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickA") as Polygon2D
		glassfin_swarm_spacing_tick_a = tick_a
	var tick_b := glassfin_swarm_spacing_tick_b
	if tick_b == null:
		tick_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickB") as Polygon2D
		glassfin_swarm_spacing_tick_b = tick_b

	glassfin_swarm_spacing_timer = fposmod(glassfin_swarm_spacing_timer + delta, GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)
	var cue_alpha := _glassfin_swarm_spacing_alpha(glassfin_swarm_spacing_timer)
	if wake != null:
		wake.color = Color(0.72, 0.86, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.72, 0.74, 1.0, minf(0.18, cue_alpha + 0.025))
	if tick_a != null:
		tick_a.color = Color(0.9, 0.92, 1.0, minf(0.24, cue_alpha + 0.08))
	if tick_b != null:
		tick_b.color = Color(0.9, 0.92, 1.0, minf(0.2, cue_alpha + 0.05))

func _glassfin_swarm_spacing_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / GLASSFIN_SWARM_SPACING_PERIOD_SECONDS) * TAU)
	return 0.08 + (phase + 1.0) * 0.04

func _update_salvage_silt_timing_cue(delta: float) -> void:
	var wake := salvage_silt_wake
	if wake == null:
		wake = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWake") as Polygon2D
		salvage_silt_wake = wake
	var window := salvage_silt_window
	if window == null:
		window = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWindow") as Polygon2D
		salvage_silt_window = window
	var tick_a := salvage_silt_tick_a
	if tick_a == null:
		tick_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickA") as Polygon2D
		salvage_silt_tick_a = tick_a
	var tick_b := salvage_silt_tick_b
	if tick_b == null:
		tick_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickB") as Polygon2D
		salvage_silt_tick_b = tick_b

	salvage_silt_timing_timer = fposmod(salvage_silt_timing_timer + delta, SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	var cue_alpha := _salvage_silt_timing_alpha(salvage_silt_timing_timer)
	if wake != null:
		wake.color = Color(0.74, 0.68, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.92, 0.82, 1.0, minf(0.16, cue_alpha + 0.035))
	if tick_a != null:
		tick_a.color = Color(0.98, 0.9, 1.0, minf(0.22, cue_alpha + 0.075))
	if tick_b != null:
		tick_b.color = Color(0.98, 0.9, 1.0, minf(0.19, cue_alpha + 0.045))

func _salvage_silt_timing_alpha(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / SALVAGE_SILT_TIMING_PERIOD_SECONDS) * TAU)
	return 0.07 + (phase + 1.0) * 0.035

func _update_outer_shelf_slackwater_timing_cue(delta: float) -> void:
	var wake := outer_shelf_slackwater_wake
	if wake == null:
		wake = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTimingWake") as Polygon2D
		outer_shelf_slackwater_wake = wake
	var window := outer_shelf_slackwater_window
	if window == null:
		window = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterWindow") as Polygon2D
		outer_shelf_slackwater_window = window
	var tick_a := outer_shelf_slackwater_tick_a
	if tick_a == null:
		tick_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickA") as Polygon2D
		outer_shelf_slackwater_tick_a = tick_a
	var tick_b := outer_shelf_slackwater_tick_b
	if tick_b == null:
		tick_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickB") as Polygon2D
		outer_shelf_slackwater_tick_b = tick_b

	outer_shelf_slackwater_timer = fposmod(outer_shelf_slackwater_timer + delta, OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var cue_alpha := _outer_shelf_slackwater_alpha(outer_shelf_slackwater_timer)
	var window_ratio := _outer_shelf_slackwater_window_ratio(outer_shelf_slackwater_timer)
	var tick_a_alpha := 0.09 + window_ratio * 0.13
	var tick_b_alpha := 0.22 - window_ratio * 0.08
	if wake != null:
		wake.color = Color(0.7, 0.67 + window_ratio * 0.08, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.9 + window_ratio * 0.08, 0.68 + window_ratio * 0.04, 1.0, minf(0.2, cue_alpha + 0.05))
	if tick_a != null:
		tick_a.color = Color(1.0, 0.84, 0.98, tick_a_alpha)
	if tick_b != null:
		tick_b.color = Color(0.9, 0.78, 1.0, tick_b_alpha)

func _outer_shelf_slackwater_alpha(timer_seconds: float) -> float:
	return 0.065 + _outer_shelf_slackwater_window_ratio(timer_seconds) * 0.08

func _outer_shelf_slackwater_window_ratio(timer_seconds: float) -> float:
	var phase := sin((timer_seconds / OUTER_SHELF_SLACKWATER_PERIOD_SECONDS) * TAU)
	return (phase + 1.0) * 0.5

func _outer_shelf_slackwater_decision_state(timer_seconds: float) -> String:
	var window_ratio := _outer_shelf_slackwater_window_ratio(timer_seconds)
	if window_ratio >= OUTER_SHELF_SLACKWATER_OPEN_THRESHOLD:
		return "open"
	if window_ratio >= OUTER_SHELF_SLACKWATER_EASING_THRESHOLD:
		return "easing"
	return "surging"

func _outer_shelf_slackwater_decision_prompt(timer_seconds: float) -> String:
	match _outer_shelf_slackwater_decision_state(timer_seconds):
		"open":
			return "Glass Rim slackwater: cross now or bank cargo"
		"easing":
			return "Glass Rim current easing: wait, cross, or turn back"
		_:
			return "Glass Rim surge: turn back or spend oxygen waiting"

func _outer_shelf_slackwater_decision_text(timer_seconds: float) -> String:
	match _outer_shelf_slackwater_decision_state(timer_seconds):
		"open":
			return "Glass Rim open: cross now or bank cargo."
		"easing":
			return "Glass Rim easing: wait, cross, or turn back."
		_:
			return "Glass Rim surge: turn back or wait."

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
	elif _scan_target_id(target) == "hollow_reef_skitter":
		return " Hollow Reef Skitter observation refreshed."
	elif _scan_target_id(target) == "glassfin_swarm":
		return " Glassfin Swarm spacing observation refreshed."
	elif _scan_target_id(target) == "mirrorfin_drift":
		return " Mirrorfin reflection observation refreshed."
	elif _scan_target_id(target) == "glass_ray_drifter":
		return " Glass Ray slackwater observation refreshed."
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
		var role_guidance := _resource_collection_guidance(target.definition.id)
		if dive_session.current_cargo.size() >= dive_session.cargo_limit:
			return " Cargo full: return to ship to bank before collecting more."
		elif dive_session.current_cargo.size() == dive_session.cargo_limit - 1:
			return " Last slot: %s Return to ship if this is the right cargo." % role_guidance

		return " %s Return to ship to bank it." % role_guidance

	match _scan_target_id(target):
		"lantern_fry":
			return " Follow the plankton pulse if oxygen allows, then return to base."
		"lantern_ray":
			return " Observe its calm pass, then return through Blackwater."
		"hollow_reef_skitter":
			return " Observe the upper shelf timing, then return through Hollow Reef."
		"glassfin_swarm":
			return " Observe the spacing lane, pass around the swarm, then return through Hollow Reef."
		"mirrorfin_drift":
			return " Observe the reflection break, pass after the shimmer, then return through Wide Reef."
		"glass_ray_drifter":
			return " Observe its turn, cross on slackwater if oxygen allows, or bank cargo."
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
	if survival_state.is_supply_id(resource_id):
		return "Banks into base needs for tonight, not the upgrade-material bank."
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		return "Oxygen Tank I is installed; future upgrades may still use it."

	var needed: int = maxi(0, int(_oxygen_tank_cost().get(resource_id, 0)) - progression_state.resource_count(resource_id))
	if needed > 0:
		return "Need %d more for Oxygen Tank I." % needed

	return "Enough banked for this Oxygen Tank I material."

func _resource_role_summary(resource_id: String) -> String:
	if survival_state.is_supply_id(resource_id):
		return "%s survival supply; %s" % [
			_resource_category_label(resource_id),
			_supply_banking_role(resource_id),
		]
	var category := _resource_category_label(resource_id)
	if category == "Building":
		return "Building material; banks for repairs, crafting, and starter upgrades."
	if category == "Research":
		return "Research material; banks for oxygen, scanner, and pressure upgrades."
	return "%s material; banks for upgrades." % category

func _resource_collection_guidance(resource_id: String) -> String:
	if survival_state.is_supply_id(resource_id):
		return "Collect to %s." % _supply_banking_role(resource_id)
	var category := _resource_category_label(resource_id)
	if category == "Building":
		return "Collect as building material for repairs/upgrades."
	if category == "Research":
		return "Collect as research material for oxygen/scanner upgrades."
	return "Collect as %s material." % category.to_lower()

func _resource_pickup_feedback(resource_id: String) -> String:
	if survival_state.is_supply_id(resource_id):
		return "Cargo %d/%d; ship banks %s reserve" % [
			dive_session.current_cargo.size(),
			dive_session.cargo_limit,
			_resource_category_label(resource_id),
		]
	var category := _resource_category_label(resource_id)
	if category == "Building":
		return "Cargo %d/%d; ship banks building mats" % [
			dive_session.current_cargo.size(),
			dive_session.cargo_limit,
		]
	if category == "Research":
		return "Cargo %d/%d; ship banks research mats" % [
			dive_session.current_cargo.size(),
			dive_session.cargo_limit,
		]
	return "Cargo %d/%d; ship banks %s mats" % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit,
		category.to_lower(),
	]

func _ensure_resource_role_visuals() -> void:
	var pickup_root := get_node_or_null("ResourcePickups")
	if pickup_root == null:
		return
	for pickup_node in pickup_root.get_children():
		var pickup := pickup_node as ResourcePickup
		if pickup == null or pickup.definition == null:
			continue
		_ensure_resource_role_visual(pickup)

func _ensure_resource_role_visual(pickup: ResourcePickup) -> void:
	var role_family := _resource_visual_role_family(pickup.definition.id)
	var role_read := pickup.get_node_or_null("RoleRead") as Node2D
	if role_read == null:
		role_read = Node2D.new()
		role_read.name = "RoleRead"
		pickup.add_child(role_read)
	role_read.visible = true
	role_read.position = Vector2(0.0, -32.0)
	role_read.scale = Vector2(1.35, 1.35)
	role_read.z_index = 28
	role_read.set_meta("role_family", role_family)
	role_read.set_meta("resource_id", pickup.definition.id)
	if role_read.get_child_count() > 0:
		return

	_add_role_polygon(role_read, "BadgeShadow", [
		Vector2(-16.0, -12.0),
		Vector2(16.0, -12.0),
		Vector2(16.0, 12.0),
		Vector2(-16.0, 12.0),
	], Color(0.012, 0.028, 0.036, 0.82))
	_add_role_polygon(role_read, "BadgeRim", [
		Vector2(-13.0, -10.0),
		Vector2(13.0, -10.0),
		Vector2(13.0, 10.0),
		Vector2(-13.0, 10.0),
	], Color(0.88, 1.0, 1.0, 0.28))
	match role_family:
		"supply":
			_add_supply_role_badge(role_read, pickup.definition.id)
		"building":
			_add_building_role_badge(role_read, pickup.definition.id)
		_:
			_add_research_role_badge(role_read, pickup.definition.id)

func _add_supply_role_badge(parent: Node2D, resource_id: String) -> void:
	var accent := _resource_role_accent_color(resource_id)
	_add_role_polygon(parent, "SupplyBadge", [
		Vector2(-10.0, -6.0),
		Vector2(-2.0, -10.0),
		Vector2(9.0, -7.0),
		Vector2(11.0, 2.0),
		Vector2(4.0, 9.0),
		Vector2(-8.0, 7.0),
		Vector2(-12.0, -1.0),
	], Color(0.98, 0.58, 0.13, 0.84))
	_add_role_polygon(parent, "SupplyPip", [
		Vector2(-3.0, -4.0),
		Vector2(5.0, -4.0),
		Vector2(6.0, 4.0),
		Vector2(-4.0, 5.0),
	], accent)

func _add_building_role_badge(parent: Node2D, resource_id: String) -> void:
	var accent := _resource_role_accent_color(resource_id)
	_add_role_polygon(parent, "BuildingBlock", [
		Vector2(-10.0, -8.0),
		Vector2(9.0, -8.0),
		Vector2(11.0, 7.0),
		Vector2(-8.0, 9.0),
	], Color(0.43, 0.50, 0.54, 0.88))
	_add_role_polygon(parent, "BuildingSash", [
		Vector2(-7.0, 1.0),
		Vector2(4.0, -7.0),
		Vector2(8.0, -3.0),
		Vector2(-3.0, 6.0),
	], accent)

func _add_research_role_badge(parent: Node2D, resource_id: String) -> void:
	var accent := _resource_role_accent_color(resource_id)
	_add_role_polygon(parent, "ResearchDiamond", [
		Vector2(0.0, -11.0),
		Vector2(10.0, 0.0),
		Vector2(0.0, 11.0),
		Vector2(-10.0, 0.0),
	], Color(0.20, 0.90, 1.0, 0.78))
	_add_role_polygon(parent, "ResearchCore", [
		Vector2(0.0, -5.0),
		Vector2(5.0, 0.0),
		Vector2(0.0, 5.0),
		Vector2(-5.0, 0.0),
	], accent)

func _add_role_polygon(parent: Node2D, polygon_name: String, points: Array[Vector2], color: Color) -> void:
	var polygon := Polygon2D.new()
	polygon.name = polygon_name
	polygon.polygon = PackedVector2Array(points)
	polygon.color = color
	parent.add_child(polygon)

func _resource_visual_role_family(resource_id: String) -> String:
	if survival_state.is_supply_id(resource_id):
		return "supply"
	if _resource_category_label(resource_id) == "Building":
		return "building"
	return "research"

func _resource_role_accent_color(resource_id: String) -> Color:
	match resource_id:
		"food_supply":
			return Color(1.0, 0.32, 0.08, 0.95)
		"water_supply":
			return Color(0.22, 0.90, 1.0, 0.95)
		"power_supply":
			return Color(1.0, 0.90, 0.16, 0.95)
		"driftwood":
			return Color(0.82, 0.54, 0.26, 0.95)
		"scrap_metal":
			return Color(0.78, 0.86, 0.90, 0.95)
		"quartz_glass":
			return Color(0.55, 0.92, 1.0, 0.95)
		"kelp_fiber":
			return Color(0.34, 1.0, 0.45, 0.95)
		"shell_fragments":
			return Color(1.0, 0.78, 0.58, 0.95)
		"glow_plankton":
			return Color(0.62, 0.50, 1.0, 0.95)
		_:
			return Color(0.92, 1.0, 1.0, 0.95)

func _supply_banking_role(resource_id: String) -> String:
	match resource_id:
		"food_supply":
			return "fill tonight's Food reserve"
		"water_supply":
			return "fill tonight's Water reserve"
		"power_supply":
			return "fill tonight's Power reserve"
		_:
			return "fill a base need"

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
		status_label.text = _cargo_full_status_text()
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
		status_label.text = "Collected %s. %s" % [
			pickup.definition.display_name,
			_resource_pickup_feedback(pickup.definition.id),
		]
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

func _on_thermal_vent_hazard_body_entered(body: Node2D) -> void:
	if body != player:
		return

	_apply_health_damage(thermal_vent_health_damage, "thermal vent heat")

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

	_ensure_resource_role_visuals()
	_place_predator_route_for_run(rng)
	_place_lantern_ray_route_for_run(rng)

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

func _place_lantern_ray_route_for_run(rng: RandomNumberGenerator) -> void:
	var routes := _spawn_routes_for_target("creature", "lantern_ray", current_resource_cluster_pattern)
	if routes.is_empty():
		current_lantern_ray_route_id = "fixed"
		return

	var route_ids := routes.keys()
	route_ids.sort()
	current_lantern_ray_route_id = String(route_ids[rng.randi_range(0, route_ids.size() - 1)])
	var route: Dictionary = routes[current_lantern_ray_route_id]
	if not route.has("start") or not route.has("end"):
		push_warning("Lantern Ray route %s is missing start or end point." % current_lantern_ray_route_id)
		return

	var ray := lantern_ray_route
	if ray == null:
		ray = get_node_or_null("Creatures/LanternRayRoute")
		lantern_ray_route = ray
	if ray != null and ray.has_method("configure_patrol"):
		ray.configure_patrol(route["start"], route["end"])

func _resource_cluster_pattern_for_seed(seed: int) -> String:
	return SpawnSelectionScript.cluster_pattern_for_seed(seed, RESOURCE_CLUSTER_PATTERNS)

func _spawn_positions_for_target(category: String, target_id: String, cluster_pattern: String) -> Array[Vector2]:
	return SpawnSelectionScript.positions_for_target(starter_resource_candidates, SpawnPointScript, category, target_id, cluster_pattern, _current_condition_id())

func _spawn_routes_for_target(category: String, target_id: String, cluster_pattern: String) -> Dictionary:
	return SpawnSelectionScript.routes_for_target(creature_route_candidates, SpawnPointScript, category, target_id, cluster_pattern, _current_condition_id())

func _sync_condition_visuals() -> void:
	var condition_id := _current_condition_id()
	var is_thermal_bloom := condition_id == "thermal_bloom"
	var is_calm_current := condition_id == "calm_current"
	rare_signal_emphasis.visible = _rare_signal_emphasis_visible_for_condition(condition_id)
	shelf_glimmer_opportunity.visible = _shelf_glimmer_visible_for_condition(condition_id)
	blue_chimney_signal_opportunity.visible = _blue_chimney_signal_visible_for_condition(condition_id)
	_sync_blackwater_signal_opportunity(condition_id)
	_sync_dusk_trench_condition_nudge(condition_id)
	_sync_wide_chamber_condition_nudge(condition_id)
	_sync_mirror_kelp_condition_nudge(condition_id)
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
	veil.color = Color(0.035, 0.055, 0.15, 0.32) if is_low_visibility else Color(0.035, 0.055, 0.15, 0.24)
	band.color = Color(0.12, 0.16, 0.34, 0.24) if is_low_visibility else Color(0.12, 0.16, 0.34, 0.17)
	rib_a.color = Color(0.36, 0.44, 0.78, 0.28) if is_low_visibility else Color(0.36, 0.44, 0.78, 0.2)
	rib_b.color = Color(0.32, 0.38, 0.7, 0.24) if is_low_visibility else Color(0.32, 0.38, 0.7, 0.16)

func _sync_wide_chamber_condition_nudge(condition_id: String) -> void:
	var return_main := wide_chamber_return_main
	if return_main == null:
		return_main = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow") as Polygon2D
	var return_far := wide_chamber_return_far
	if return_far == null:
		return_far = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib") as Polygon2D
	var return_mid := wide_chamber_return_mid
	if return_mid == null:
		return_mid = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain") as Polygon2D
	var return_entry := wide_chamber_return_entry
	if return_entry == null:
		return_entry = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain") as Polygon2D
	if return_main == null or return_far == null or return_mid == null or return_entry == null:
		return

	var is_calm_current := condition_id == "calm_current"
	return_main.color = Color(0.66, 1.0, 0.88, 0.17) if is_calm_current else Color(0.66, 1.0, 0.88, 0.13)
	return_far.color = Color(0.82, 1.0, 0.92, 0.17) if is_calm_current else Color(0.82, 1.0, 0.92, 0.13)
	return_mid.color = Color(0.58, 1.0, 0.84, 0.14) if is_calm_current else Color(0.58, 1.0, 0.84, 0.1)
	return_entry.color = Color(0.62, 1.0, 0.86, 0.16) if is_calm_current else Color(0.62, 1.0, 0.86, 0.12)

func _sync_mirror_kelp_condition_nudge(condition_id: String) -> void:
	var backwater := mirror_kelp_reflective_backwater
	if backwater == null:
		backwater = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater") as Polygon2D
	var curtain_a := mirror_kelp_curtain_a
	if curtain_a == null:
		curtain_a = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA") as Polygon2D
	var curtain_b := mirror_kelp_curtain_b
	if curtain_b == null:
		curtain_b = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainB") as Polygon2D
	var curtain_c := mirror_kelp_curtain_c
	if curtain_c == null:
		curtain_c = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainC") as Polygon2D
	var wash := mirror_kelp_bloom_approach_wash
	if wash == null:
		wash = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachWash") as Polygon2D
	var rib := mirror_kelp_bloom_approach_rib
	if rib == null:
		rib = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachRib") as Polygon2D
	if backwater == null or curtain_a == null or curtain_b == null or curtain_c == null or wash == null or rib == null:
		return

	var is_kelp_bloom := condition_id == "kelp_bloom"
	wash.visible = is_kelp_bloom
	rib.visible = is_kelp_bloom
	backwater.color = Color(0.08, 0.36, 0.42, 0.18) if is_kelp_bloom else Color(0.08, 0.36, 0.42, 0.12)
	curtain_a.color = Color(0.42, 0.94, 0.82, 0.24) if is_kelp_bloom else Color(0.42, 0.94, 0.82, 0.17)
	curtain_b.color = Color(0.72, 0.96, 1.0, 0.21) if is_kelp_bloom else Color(0.72, 0.96, 1.0, 0.15)
	curtain_c.color = Color(0.36, 0.82, 0.72, 0.19) if is_kelp_bloom else Color(0.36, 0.82, 0.72, 0.13)
	wash.color = Color(0.4, 0.92, 0.76, 0.09)
	rib.color = Color(0.82, 1.0, 0.9, 0.12)

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
	_sync_outer_shelf_survey_state()

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

func _sync_hollow_reef_reading_state() -> void:
	var halo := hollow_reef_reading_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingHalo") as Polygon2D
	var shard := hollow_reef_reading_shard
	if shard == null:
		shard = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingShard") as Polygon2D
	var spark := hollow_reef_reading_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/CaveReadingCore/ReadingSpark") as Polygon2D
	if halo == null or shard == null or spark == null:
		return

	if run_hollow_reef_reading_recovered:
		halo.color = Color(0.58, 1.0, 0.88, 0.07)
		shard.color = Color(0.88, 1.0, 0.7, 0.16)
		spark.visible = false
	else:
		halo.color = Color(0.58, 1.0, 0.88, 0.36)
		shard.color = Color(0.88, 1.0, 0.7, 0.84)
		spark.color = Color(1.0, 1.0, 0.82, 0.9)
		spark.visible = true

func _sync_salvage_data_cache_state() -> void:
	var halo := salvage_data_cache_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheHalo") as Polygon2D
	var core := salvage_data_cache_core
	if core == null:
		core = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheCore") as Polygon2D
	var spark := salvage_data_cache_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/DataCache/CacheSpark") as Polygon2D
	if halo == null or core == null or spark == null:
		return

	if run_salvage_data_cache_recovered:
		halo.color = Color(0.42, 0.82, 1.0, 0.07)
		core.color = Color(0.72, 0.95, 1.0, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.42, 0.82, 1.0, 0.22)
		core.color = Color(0.72, 0.95, 1.0, 0.88)
		spark.color = Color(0.9, 1.0, 1.0, 0.86)
		spark.visible = true

func _sync_salvage_manifest_state() -> void:
	var halo := salvage_manifest_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestHalo") as Polygon2D
	var core := salvage_manifest_core
	if core == null:
		core = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestCore") as Polygon2D
	var spark := salvage_manifest_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SalvageManifest/ManifestSpark") as Polygon2D
	if halo == null or core == null or spark == null:
		return

	if run_salvage_manifest_recovered:
		halo.color = Color(1.0, 0.68, 0.28, 0.08)
		core.color = Color(1.0, 0.76, 0.34, 0.18)
		spark.visible = false
	else:
		halo.color = Color(1.0, 0.68, 0.28, 0.22)
		core.color = Color(1.0, 0.76, 0.34, 0.86)
		spark.color = Color(1.0, 0.9, 0.5, 0.84)
		spark.visible = true

func _sync_salvage_pocket_open_state() -> void:
	var hatch := salvage_hatch_panel
	if hatch == null:
		hatch = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SealedHatchPanel") as Polygon2D
	var lock_bars := salvage_lock_bars
	if lock_bars == null:
		lock_bars = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/LockBars") as Polygon2D
	var glint := salvage_glint
	if glint == null:
		glint = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SalvageGlint") as Polygon2D
	var tool_label := salvage_tool_label
	if tool_label == null:
		tool_label = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/FutureCutterPort/ToolLabel") as Label
	var promise_label := salvage_promise_label
	if promise_label == null:
		promise_label = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/PromiseLabel") as Label
	var opened_lane := salvage_opened_pocket_lane
	if opened_lane == null:
		opened_lane = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane") as Node2D

	var cutter_owned := progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID)
	if opened_lane != null:
		opened_lane.visible = cutter_owned
	if lock_bars != null:
		lock_bars.visible = not cutter_owned
	if hatch != null:
		hatch.color = Color(0.04, 0.09, 0.095, 0.22) if cutter_owned else Color(0.12, 0.22, 0.25, 0.58)
	if glint != null:
		glint.color = Color(1.0, 0.78, 0.38, 0.48) if cutter_owned else Color(0.86, 0.78, 0.58, 0.28)
	if tool_label != null:
		tool_label.text = "CUTTER READY" if cutter_owned else "CUTTER NEEDED"
		tool_label.visible = not cutter_owned
	if promise_label != null:
		promise_label.text = "OPEN" if cutter_owned else "SALVAGE"
	_sync_salvage_manifest_state()

func _sync_tideglass_sample_state() -> void:
	var halo := tideglass_sample_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleHalo") as Polygon2D
	var core := tideglass_sample_core
	if core == null:
		core = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleCore") as Polygon2D
	var spark := tideglass_sample_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/TideglassSample/SampleSpark") as Polygon2D
	if halo == null or core == null or spark == null:
		return

	if run_tideglass_sample_recovered:
		halo.color = Color(0.38, 0.88, 1.0, 0.07)
		core.color = Color(0.72, 0.96, 1.0, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.38, 0.88, 1.0, 0.22)
		core.color = Color(0.72, 0.96, 1.0, 0.88)
		spark.color = Color(0.9, 1.0, 1.0, 0.86)
		spark.visible = true

func _sync_outer_shelf_survey_state() -> void:
	var halo := outer_shelf_survey_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyHalo") as Polygon2D
	var core := outer_shelf_survey_core
	if core == null:
		core = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveyCore") as Polygon2D
	var spark := outer_shelf_survey_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/OuterShelfSurveyCore/SurveySpark") as Polygon2D
	if halo == null or core == null or spark == null:
		return

	if run_outer_shelf_survey_recovered:
		halo.color = Color(0.48, 0.92, 1.0, 0.07)
		core.color = Color(0.78, 1.0, 0.96, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.48, 0.92, 1.0, 0.22)
		core.color = Color(0.78, 1.0, 0.96, 0.86)
		spark.color = Color(0.95, 1.0, 0.9, 0.86)
		spark.visible = true

func _sync_rim_glass_reading_state() -> void:
	var halo := rim_glass_reading_halo
	if halo == null:
		halo = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingHalo") as Polygon2D
	var core := rim_glass_reading_core
	if core == null:
		core = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingCore") as Polygon2D
	var spark := rim_glass_reading_spark
	if spark == null:
		spark = get_node_or_null("EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/RimGlassReading/ReadingSpark") as Polygon2D
	if halo == null or core == null or spark == null:
		return

	if run_rim_glass_reading_recovered:
		halo.color = Color(0.74, 0.78, 1.0, 0.07)
		core.color = Color(0.96, 0.9, 1.0, 0.18)
		spark.visible = false
	else:
		halo.color = Color(0.74, 0.78, 1.0, 0.22)
		core.color = Color(0.96, 0.9, 1.0, 0.86)
		spark.color = Color(1.0, 0.98, 1.0, 0.86)
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
	_apply_active_hud_layout()
	var is_diving := _active_hud_visible_for_result(dive_session.result)
	var has_surface_panel := _surface_hud_visible_for_result(dive_session.result)
	hint_label.visible = false
	bounds_hint_label.visible = false
	active_stats_panel.visible = is_diving
	cargo_panel.visible = is_diving
	daylight_panel.visible = is_diving
	survival_needs_panel.visible = is_diving
	var has_scan_target := is_diving and current_scan_target != null
	scan_card_panel.visible = has_scan_target
	tool_belt_panel.visible = is_diving
	minimap_panel.visible = is_diving
	oxygen_icon.visible = is_diving
	health_icon.visible = is_diving
	depth_icon.visible = is_diving
	oxygen_label.visible = is_diving
	oxygen_bar_back.visible = is_diving
	oxygen_bar_fill.visible = is_diving
	health_label.visible = is_diving
	health_bar_back.visible = is_diving
	health_bar_fill.visible = is_diving
	depth_label.visible = is_diving
	depth_bar_back.visible = is_diving
	depth_bar_fill.visible = is_diving
	base_direction_label.visible = is_diving
	cargo_label.visible = is_diving
	cargo_slots_root.visible = is_diving
	_update_daylight_timer_hud(is_diving)
	oxygen_label.text = _format_oxygen_label(dive_session.oxygen, dive_session.max_oxygen)
	health_label.text = _format_health_label(dive_session.health, dive_session.max_health)
	depth_label.text = "Depth: %dm | Best: %dm" % [
		roundi(dive_session.current_depth),
		roundi(progression_state.best_depth_reached)
	]
	base_direction_label.text = _format_base_direction()
	_update_oxygen_feedback()
	_update_health_feedback()
	cargo_label.text = "%d / %d" % [
		dive_session.current_cargo.size(),
		dive_session.cargo_limit
	]
	_update_cargo_slots()
	_update_instrument_bars()
	_update_survival_needs_panel(is_diving)
	_update_depth_rail(is_diving)
	_update_minimap(is_diving)
	bank_label.text = "Banked:%s" % _format_banked_resources()
	upgrade_label.text = _format_upgrade_status()
	discoveries_label.text = _format_discoveries(true)
	recent_expedition_log_label.text = _format_recent_expedition_log()
	bank_label.visible = false
	upgrade_label.visible = false
	recent_expedition_log_label.visible = false
	discoveries_label.visible = not has_surface_panel
	dive_info_panel.visible = is_diving
	scan_target_label.visible = has_scan_target
	scan_card_title_label.visible = has_scan_target
	scan_card_meta_label.visible = has_scan_target
	scan_card_prompt_label.visible = has_scan_target
	status_label.visible = is_diving
	prompt_label.visible = is_diving
	status_label.text = _compact_dive_status(status_label.text) if is_diving else status_label.text
	if is_diving:
		objective_title_label.text = "SURVIVAL ROUTE"
		objective_line_label.text = _format_active_objective_line()

	prompt_label.text = _compact_dive_status(_format_hud_prompt()) if is_diving else _format_hud_prompt()
	_update_tool_belt(is_diving)
	_update_expedition_slate(is_diving)

	_publish_visual_smoke_state()

func _apply_active_hud_layout() -> void:
	_ensure_active_hud_references()
	_set_control_rect(active_stats_panel, ACTIVE_STATS_RECT)
	_set_control_rect(cargo_panel, CARGO_PANEL_RECT)
	_set_control_rect(daylight_panel, DAYLIGHT_PANEL_RECT)
	_set_control_rect(survival_needs_panel, SURVIVAL_NEEDS_PANEL_RECT)
	_set_control_rect(dive_info_panel, DIVE_INFO_RECT)
	_set_control_rect(objective_title_label, DIVE_INFO_LABEL_RECTS["title"])
	_set_control_rect(objective_line_label, DIVE_INFO_LABEL_RECTS["objective"])
	_set_control_rect(scan_card_panel, SCAN_CARD_RECT)
	_set_control_rect(tool_belt_panel, TOOL_BELT_PANEL_RECT)
	_set_control_rect(minimap_panel, MINIMAP_PANEL_RECT)
	_set_control_rect(oxygen_warning_panel, OXYGEN_WARNING_RECT)
	_set_control_rect(oxygen_label, ACTIVE_HUD_LABEL_RECTS["oxygen"])
	_set_control_rect(oxygen_bar_back, OXYGEN_BAR_BACK_RECT)
	_set_control_rect(oxygen_bar_fill, OXYGEN_BAR_FILL_RECT)
	_set_control_rect(health_label, ACTIVE_HUD_LABEL_RECTS["health"])
	_set_control_rect(health_bar_back, HEALTH_BAR_BACK_RECT)
	_set_control_rect(health_bar_fill, HEALTH_BAR_FILL_RECT)
	_set_control_rect(depth_label, ACTIVE_HUD_LABEL_RECTS["depth"])
	_set_control_rect(depth_bar_back, DEPTH_BAR_BACK_RECT)
	_set_control_rect(depth_bar_fill, DEPTH_BAR_FILL_RECT)
	_set_control_rect(base_direction_label, ACTIVE_HUD_LABEL_RECTS["base"])
	_set_control_rect(cargo_label, ACTIVE_HUD_LABEL_RECTS["cargo"])
	_set_control_rect(daylight_label, DAYLIGHT_LABEL_RECT)
	_set_control_rect(daylight_bar_back, DAYLIGHT_BAR_BACK_RECT)
	_set_control_rect(daylight_bar_fill, DAYLIGHT_BAR_FILL_RECT)
	_set_control_rect(discoveries_label, ACTIVE_HUD_LABEL_RECTS["discoveries"])
	_set_control_rect(scan_target_label, ACTIVE_HUD_LABEL_RECTS["scan"])
	_set_control_rect(scan_card_title_label, SCAN_CARD_LABEL_RECTS["title"])
	_set_control_rect(scan_card_meta_label, SCAN_CARD_LABEL_RECTS["meta"])
	_set_control_rect(scan_card_prompt_label, SCAN_CARD_LABEL_RECTS["prompt"])
	_set_control_rect(prompt_label, ACTIVE_HUD_LABEL_RECTS["prompt"])
	_set_control_rect(status_label, ACTIVE_HUD_LABEL_RECTS["status"])
	_set_control_rect(food_need_label, SURVIVAL_NEED_LABEL_RECTS["food"])
	_set_control_rect(water_need_label, SURVIVAL_NEED_LABEL_RECTS["water"])
	_set_control_rect(power_need_label, SURVIVAL_NEED_LABEL_RECTS["power"])
	_set_control_rect(food_need_bar_back, SURVIVAL_NEED_BAR_BACK_RECTS["food"])
	_set_control_rect(water_need_bar_back, SURVIVAL_NEED_BAR_BACK_RECTS["water"])
	_set_control_rect(power_need_bar_back, SURVIVAL_NEED_BAR_BACK_RECTS["power"])
	_set_control_rect(food_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["food"])
	_set_control_rect(water_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["water"])
	_set_control_rect(power_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["power"])
	if food_need_icon != null:
		food_need_icon.position = SURVIVAL_NEED_ICON_POSITIONS["food"]
	if water_need_icon != null:
		water_need_icon.position = SURVIVAL_NEED_ICON_POSITIONS["water"]
	if power_need_icon != null:
		power_need_icon.position = SURVIVAL_NEED_ICON_POSITIONS["power"]
	if oxygen_icon != null:
		oxygen_icon.position = OXYGEN_ICON_POSITION
	if health_icon != null:
		health_icon.position = HEALTH_ICON_POSITION
	if depth_icon != null:
		depth_icon.position = DEPTH_ICON_POSITION
	_set_control_rect(depth_rail_line, DEPTH_RAIL_LINE_RECT)
	if depth_rail_labels.size() >= 3:
		_set_control_rect(depth_rail_labels[0], DEPTH_RAIL_LABEL_RECTS["0"])
		_set_control_rect(depth_rail_labels[1], DEPTH_RAIL_LABEL_RECTS["50"])
		_set_control_rect(depth_rail_labels[2], DEPTH_RAIL_LABEL_RECTS["100"])
	if cargo_slots_root != null:
		cargo_slots_root.position = CARGO_SLOT_ACTIVE_POSITION
	if daylight_sun_icon != null:
		daylight_sun_icon.position = DAYLIGHT_SUN_ICON_POSITION
	if daylight_moon_icon != null:
		daylight_moon_icon.position = DAYLIGHT_MOON_ICON_POSITION

	var bounded_labels: Array[Label] = [
		oxygen_label,
		health_label,
		depth_label,
		base_direction_label,
		cargo_label,
		daylight_label,
		discoveries_label,
		scan_target_label,
		scan_card_title_label,
		scan_card_meta_label,
		scan_card_prompt_label,
		objective_title_label,
		objective_line_label,
		prompt_label,
		status_label,
		food_need_label,
		water_need_label,
		power_need_label,
	]
	for label in depth_rail_labels:
		bounded_labels.append(label)
	for label in bounded_labels:
		if label != null:
			label.autowrap_mode = TextServer.AUTOWRAP_OFF
			label.clip_text = true

func _ensure_active_hud_references() -> void:
	if active_stats_panel == null:
		active_stats_panel = get_node_or_null("HUD/ActiveStatsPanel") as Panel
	if cargo_panel == null:
		cargo_panel = get_node_or_null("HUD/CargoPanel") as Panel
	if daylight_panel == null:
		daylight_panel = get_node_or_null("HUD/DaylightPanel") as Panel
	if daylight_label == null:
		daylight_label = get_node_or_null("HUD/DaylightLabel") as Label
	if daylight_bar_back == null:
		daylight_bar_back = get_node_or_null("HUD/DaylightBarBack") as ColorRect
	if daylight_bar_fill == null:
		daylight_bar_fill = get_node_or_null("HUD/DaylightBarFill") as ColorRect
	if daylight_sun_icon == null:
		daylight_sun_icon = get_node_or_null("HUD/DaylightSunIcon") as Polygon2D
	if daylight_moon_icon == null:
		daylight_moon_icon = get_node_or_null("HUD/DaylightMoonIcon") as Polygon2D
	if survival_needs_panel == null:
		survival_needs_panel = get_node_or_null("HUD/SurvivalNeedsPanel") as Panel
	if dive_info_panel == null:
		dive_info_panel = get_node_or_null("HUD/DiveInfoPanel") as Panel
	if objective_title_label == null:
		objective_title_label = get_node_or_null("HUD/DiveInfoPanel/ObjectiveTitle") as Label
	if objective_line_label == null:
		objective_line_label = get_node_or_null("HUD/DiveInfoPanel/ObjectiveLine") as Label
	if scan_card_panel == null:
		scan_card_panel = get_node_or_null("HUD/ScanCardPanel") as Panel
	if tool_belt_panel == null:
		tool_belt_panel = get_node_or_null("HUD/ToolBeltPanel") as Panel
	if minimap_panel == null:
		minimap_panel = get_node_or_null("HUD/MinimapPanel") as Panel
	if oxygen_warning_panel == null:
		oxygen_warning_panel = get_node_or_null("HUD/OxygenWarningPanel") as Panel
	if oxygen_label == null:
		oxygen_label = get_node_or_null("HUD/Oxygen") as Label
	if oxygen_bar_back == null:
		oxygen_bar_back = get_node_or_null("HUD/OxygenBarBack") as ColorRect
	if oxygen_bar_fill == null:
		oxygen_bar_fill = get_node_or_null("HUD/OxygenBarFill") as ColorRect
	if health_icon == null:
		health_icon = get_node_or_null("HUD/HealthIcon") as Polygon2D
	if health_label == null:
		health_label = get_node_or_null("HUD/Health") as Label
	if health_bar_back == null:
		health_bar_back = get_node_or_null("HUD/HealthBarBack") as ColorRect
	if health_bar_fill == null:
		health_bar_fill = get_node_or_null("HUD/HealthBarFill") as ColorRect
	if depth_label == null:
		depth_label = get_node_or_null("HUD/Depth") as Label
	if depth_bar_back == null:
		depth_bar_back = get_node_or_null("HUD/DepthBarBack") as ColorRect
	if depth_bar_fill == null:
		depth_bar_fill = get_node_or_null("HUD/DepthBarFill") as ColorRect
	if base_direction_label == null:
		base_direction_label = get_node_or_null("HUD/BaseDirection") as Label
	if cargo_label == null:
		cargo_label = get_node_or_null("HUD/Cargo") as Label
	if discoveries_label == null:
		discoveries_label = get_node_or_null("HUD/Discoveries") as Label
	if scan_target_label == null:
		scan_target_label = get_node_or_null("HUD/ScanTarget") as Label
	if scan_card_title_label == null:
		scan_card_title_label = get_node_or_null("HUD/ScanCardTitle") as Label
	if scan_card_meta_label == null:
		scan_card_meta_label = get_node_or_null("HUD/ScanCardMeta") as Label
	if scan_card_prompt_label == null:
		scan_card_prompt_label = get_node_or_null("HUD/ScanCardPrompt") as Label
	if prompt_label == null:
		prompt_label = get_node_or_null("HUD/ExtractionPrompt") as Label
	if status_label == null:
		status_label = get_node_or_null("HUD/Status") as Label
	if food_need_label == null:
		food_need_label = get_node_or_null("HUD/FoodNeed") as Label
	if water_need_label == null:
		water_need_label = get_node_or_null("HUD/WaterNeed") as Label
	if power_need_label == null:
		power_need_label = get_node_or_null("HUD/PowerNeed") as Label
	if food_need_icon == null:
		food_need_icon = get_node_or_null("HUD/FoodNeedIcon") as Polygon2D
	if water_need_icon == null:
		water_need_icon = get_node_or_null("HUD/WaterNeedIcon") as Polygon2D
	if power_need_icon == null:
		power_need_icon = get_node_or_null("HUD/PowerNeedIcon") as Polygon2D
	if food_need_bar_back == null:
		food_need_bar_back = get_node_or_null("HUD/FoodNeedBarBack") as ColorRect
	if water_need_bar_back == null:
		water_need_bar_back = get_node_or_null("HUD/WaterNeedBarBack") as ColorRect
	if power_need_bar_back == null:
		power_need_bar_back = get_node_or_null("HUD/PowerNeedBarBack") as ColorRect
	if food_need_bar_fill == null:
		food_need_bar_fill = get_node_or_null("HUD/FoodNeedBarFill") as ColorRect
	if water_need_bar_fill == null:
		water_need_bar_fill = get_node_or_null("HUD/WaterNeedBarFill") as ColorRect
	if power_need_bar_fill == null:
		power_need_bar_fill = get_node_or_null("HUD/PowerNeedBarFill") as ColorRect
	if depth_rail_line == null:
		depth_rail_line = get_node_or_null("HUD/DepthRailLine") as ColorRect
	if depth_rail_labels.is_empty():
		depth_rail_labels = [
			get_node_or_null("HUD/DepthRailLabel0") as Label,
			get_node_or_null("HUD/DepthRailLabel50") as Label,
			get_node_or_null("HUD/DepthRailLabel100") as Label,
		]
	if cargo_slots_root == null:
		cargo_slots_root = get_node_or_null("HUD/CargoSlots") as Node2D

func _update_instrument_bars() -> void:
	var oxygen_ratio := 0.0
	if dive_session.max_oxygen > 0.0:
		oxygen_ratio = clampf(dive_session.oxygen / dive_session.max_oxygen, 0.0, 1.0)
	_set_bar_fill_width(oxygen_bar_fill, OXYGEN_BAR_FILL_RECT, oxygen_ratio)

	var health_ratio := 0.0
	if dive_session.max_health > 0.0:
		health_ratio = clampf(dive_session.health / dive_session.max_health, 0.0, 1.0)
	_set_bar_fill_width(health_bar_fill, HEALTH_BAR_FILL_RECT, health_ratio)
	if health_bar_fill != null:
		var health_state := _health_state(dive_session.health, dive_session.max_health)
		health_bar_fill.color = HEALTH_DAMAGED_COLOR if health_state == "normal" and _has_recent_health_damage() else _health_state_color(health_state)

	var depth_ratio := clampf(dive_session.current_depth / 200.0, 0.0, 1.0)
	_set_bar_fill_width(depth_bar_fill, DEPTH_BAR_FILL_RECT, depth_ratio)

func _update_survival_needs_panel(is_visible: bool) -> void:
	var need_labels: Array[Label] = [food_need_label, water_need_label, power_need_label]
	var need_icons: Array[Polygon2D] = [food_need_icon, water_need_icon, power_need_icon]
	var need_bars: Array[ColorRect] = [
		food_need_bar_back,
		food_need_bar_fill,
		water_need_bar_back,
		water_need_bar_fill,
		power_need_bar_back,
		power_need_bar_fill,
	]
	for label in need_labels:
		label.visible = is_visible
	for icon in need_icons:
		icon.visible = is_visible
	for bar in need_bars:
		bar.visible = is_visible

	if not is_visible:
		return

	food_need_label.text = "FOOD %d / %d" % [survival_state.food, int(SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	water_need_label.text = "WATER %d / %d" % [survival_state.water, int(SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	power_need_label.text = "POWER %d / %d" % [survival_state.power, int(SURVIVAL_NEED_BAR_DISPLAY_MAX)]
	_set_bar_fill_width(food_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["food"], clampf(float(survival_state.food) / SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))
	_set_bar_fill_width(water_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["water"], clampf(float(survival_state.water) / SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))
	_set_bar_fill_width(power_need_bar_fill, SURVIVAL_NEED_BAR_BACK_RECTS["power"], clampf(float(survival_state.power) / SURVIVAL_NEED_BAR_DISPLAY_MAX, 0.0, 1.0))

func _update_depth_rail(is_visible: bool) -> void:
	depth_rail_line.visible = is_visible
	depth_rail_marker.visible = is_visible
	for label in depth_rail_labels:
		label.visible = is_visible

	if not is_visible:
		return

	depth_rail_labels[0].text = "0m"
	depth_rail_labels[1].text = "50m"
	depth_rail_labels[2].text = "100m"
	var ratio := clampf(dive_session.current_depth / DEPTH_RAIL_MAX_DISPLAY_DEPTH, 0.0, 1.0)
	depth_rail_marker.position = Vector2(
		DEPTH_RAIL_LINE_RECT.position.x + 1.0,
		DEPTH_RAIL_LINE_RECT.position.y + DEPTH_RAIL_LINE_RECT.size.y * ratio
	)

func _update_minimap(is_visible: bool) -> void:
	minimap_path.visible = is_visible
	minimap_player_marker.visible = is_visible
	if not is_visible:
		return

	var depth_ratio := clampf(dive_session.current_depth / DEPTH_RAIL_MAX_DISPLAY_DEPTH, 0.0, 1.0)
	var horizontal_ratio := 0.5
	if player != null:
		var bounds: Rect2 = player.get("world_bounds")
		horizontal_ratio = clampf((player.global_position.x - bounds.position.x) / bounds.size.x, 0.0, 1.0)
	minimap_player_marker.position = Vector2(94.0 + (horizontal_ratio - 0.5) * 78.0, 34.0 + depth_ratio * 76.0)

func _advance_daylight_timer(delta: float) -> void:
	if daylight_duration_seconds <= 0.0 or daylight_nightfall_announced:
		return

	daylight_elapsed_seconds = minf(daylight_duration_seconds, daylight_elapsed_seconds + maxf(delta, 0.0))
	if daylight_elapsed_seconds >= daylight_duration_seconds:
		_handle_daylight_expired()

func _handle_daylight_expired() -> void:
	daylight_nightfall_announced = true
	daylight_elapsed_seconds = maxf(daylight_elapsed_seconds, daylight_duration_seconds)
	daylight_nightfall_away_from_ship = not player_in_base
	if status_label != null:
		if daylight_nightfall_away_from_ship:
			status_label.text = "Nightfall: emergency return. Cargo stays at risk; ship spends extra Power."
		else:
			status_label.text = "Nightfall reached: start night at ship."

func _set_daylight_progress_for_debug(progress_ratio: float) -> void:
	var clamped_progress := clampf(progress_ratio, 0.0, 1.0)
	daylight_elapsed_seconds = maxf(0.0, daylight_duration_seconds) * clamped_progress
	daylight_nightfall_announced = clamped_progress >= 1.0
	daylight_nightfall_away_from_ship = false

func _daylight_remaining_seconds() -> float:
	return maxf(0.0, daylight_duration_seconds - daylight_elapsed_seconds)

func _daylight_remaining_ratio() -> float:
	if daylight_duration_seconds <= 0.0:
		return 0.0

	return clampf(_daylight_remaining_seconds() / daylight_duration_seconds, 0.0, 1.0)

func _should_warn_late_day_cargo_banking() -> bool:
	if dive_session.result != DiveSessionScript.Result.DIVING:
		return false
	if daylight_nightfall_announced:
		return false
	if player_in_base:
		return false
	if dive_session.current_cargo.is_empty():
		return false

	return _daylight_remaining_ratio() <= LATE_DAY_CARGO_WARNING_RATIO

func _visual_late_day_cargo_warning_visible() -> bool:
	var prompt_text := prompt_label.text if prompt_label != null else ""
	var objective_text := objective_line_label.text if objective_line_label != null else ""
	return prompt_text.contains("Power risk") or objective_text.contains("Dusk: bank cargo soon")

func _format_daylight_label() -> String:
	if _daylight_remaining_seconds() <= 0.0:
		return "NIGHTFALL"

	var remaining_seconds := ceili(_daylight_remaining_seconds())
	var minutes := int(remaining_seconds / 60)
	var seconds := remaining_seconds % 60
	return "DAYLIGHT %02d:%02d" % [minutes, seconds]

func _daylight_bar_color(remaining_ratio: float) -> Color:
	if remaining_ratio <= 0.25:
		return DAYLIGHT_DUSK_COLOR

	return DAYLIGHT_NORMAL_COLOR

func _update_daylight_timer_hud(is_visible: bool) -> void:
	if daylight_panel != null:
		daylight_panel.visible = is_visible
	var daylight_nodes: Array[CanvasItem] = [
		daylight_label,
		daylight_bar_back,
		daylight_bar_fill,
		daylight_sun_icon,
		daylight_moon_icon,
	]
	for node in daylight_nodes:
		if node != null:
			node.visible = is_visible

	if not is_visible:
		return

	var remaining_ratio := _daylight_remaining_ratio()
	if daylight_label != null:
		daylight_label.text = _format_daylight_label()
		daylight_label.modulate = _daylight_bar_color(remaining_ratio)
	if daylight_bar_fill != null:
		daylight_bar_fill.color = _daylight_bar_color(remaining_ratio)
		_set_bar_fill_width(daylight_bar_fill, DAYLIGHT_BAR_FILL_RECT, remaining_ratio)
	if daylight_sun_icon != null:
		daylight_sun_icon.color = Color(1.0, 0.82, 0.22, 0.32 + remaining_ratio * 0.62)
	if daylight_moon_icon != null:
		daylight_moon_icon.color = Color(0.72, 0.78, 1.0, 0.34 + (1.0 - remaining_ratio) * 0.58)

func _set_bar_fill_width(fill: ColorRect, base_rect: Rect2, ratio: float) -> void:
	_set_control_rect(fill, base_rect)
	fill.offset_right = fill.offset_left + base_rect.size.x * clampf(ratio, 0.0, 1.0)

func _set_control_rect(control: Control, rect: Rect2) -> void:
	if control == null:
		return

	control.offset_left = rect.position.x
	control.offset_top = rect.position.y
	control.offset_right = rect.position.x + rect.size.x
	control.offset_bottom = rect.position.y + rect.size.y

func _publish_visual_smoke_state() -> void:
	if not OS.has_feature("web"):
		return

	var state := {
		"result": String(DIVE_RESULT_NAMES.get(dive_session.result, "unknown")),
		"surface_tab": SURFACE_TAB_NAMES[surface_tab_index].to_lower(),
		"debug_telemetry": show_debug_telemetry,
		"area01_source_map_overlay": area01_visual_director != null and area01_visual_director.source_map_overlay_visible(),
		"oxygen_state": _oxygen_state(dive_session.oxygen, dive_session.max_oxygen),
		"oxygen": ceili(dive_session.oxygen),
		"max_oxygen": ceili(dive_session.max_oxygen),
		"health_state": _health_state(dive_session.health, dive_session.max_health),
		"health": ceili(dive_session.health),
		"max_health": ceili(dive_session.max_health),
		"health_damage_events": run_health_damage_events,
		"last_health_damage_source": last_health_damage_source,
		"last_health_damage_amount": ceili(last_health_damage_amount),
		"depth_meters": roundi(dive_session.current_depth),
		"best_depth_meters": roundi(progression_state.best_depth_reached),
		"daylight_visible": daylight_panel.visible,
		"daylight_remaining_percent": roundi(_daylight_remaining_ratio() * 100.0),
		"daylight_remaining_seconds": ceili(_daylight_remaining_seconds()),
		"ship_offload_count": daylight_ship_offload_count,
		"player_in_surface_oxygen_refill": _is_player_in_surface_oxygen_refill(),
		"surface_oxygen_refill_active": _surface_oxygen_refill_active(),
		"cargo_count": dive_session.current_cargo.size(),
		"cargo_limit": dive_session.cargo_limit,
		"player_in_base": player_in_base,
		"has_left_base": dive_session.has_left_base,
		"run_panel_visible": run_panel.visible,
		"upgrade_panel_visible": upgrade_panel.visible,
		"active_stats_visible": active_stats_panel.visible,
		"status_text": status_label.text if status_label != null else "",
		"prompt_text": prompt_label.text if prompt_label != null else "",
		"objective_text": objective_line_label.text if objective_line_label != null else "",
		"cargo_text": cargo_label.text if cargo_label != null else "",
		"health_damage_status_visible": status_label != null and status_label.text.contains("O2 unchanged") and status_label.text.contains("health"),
		"health_damage_prompt_visible": prompt_label != null and prompt_label.text.to_lower().contains("o2 only"),
		"health_damage_objective_visible": objective_line_label != null and objective_line_label.text.contains("Health hit"),
		"health_recovery_copy_visible": run_summary_label != null and run_summary_label.text.contains("no surface heal"),
		"late_day_cargo_warning_visible": _visual_late_day_cargo_warning_visible(),
		"dawn_priority_visible": run_summary_label != null and run_summary_label.text.contains("Day priority:"),
		"night_build_choice_visible": run_summary_label != null and run_summary_label.text.contains("Build choice:"),
		"night_tomorrow_plan_visible": run_summary_label != null and run_summary_label.text.contains("Next: press"),
		"starter_resource_target_visible": run_summary_label != null and run_summary_label.text.contains("Shell Reef pockets"),
		"recent_survival_memory_visible": surface_tab_index == SURFACE_TAB_LOG and run_summary_label != null and run_summary_label.text.contains("survival "),
		"upgrade_feedback_next_plan_visible": upgrade_menu_feedback_label != null and upgrade_menu_feedback_label.text.contains("Next:"),
		"status_debug_copy": status_label != null and status_label.text.to_lower().contains("debug"),
		"touch_controls_visible": mobile_touch_controls != null and mobile_touch_controls.visible,
		"wreck_echo_clue_recovered": run_wreck_echo_clue_recovered,
		"east_shelf_pocket_ping_recovered": run_east_shelf_pocket_ping_recovered,
		"lower_connector_echo_recovered": run_lower_connector_echo_recovered,
		"resonance_alcove_research_recovered": run_resonance_alcove_research_recovered,
		"blue_chimney_draft_reading_recovered": run_blue_chimney_draft_reading_recovered,
		"lantern_silt_sample_recovered": run_lantern_silt_sample_recovered,
		"blackwater_trace_recovered": run_blackwater_trace_recovered,
		"dusk_trench_reached": run_reached_dusk_trench,
		"glass_kelp_reading_recovered": run_glass_kelp_reading_recovered,
		"hollow_reef_reading_recovered": run_hollow_reef_reading_recovered,
		"salvage_manifest_recovered": run_salvage_manifest_recovered,
		"outer_shelf_survey_recovered": run_outer_shelf_survey_recovered,
		"rim_glass_reading_recovered": run_rim_glass_reading_recovered,
		"tideglass_sample_recovered": run_tideglass_sample_recovered,
		"mirrorfin_drift_observed": run_completed_scans.has("mirrorfin_drift"),
		"salvage_pocket_open": progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID),
		"route_stage": visual_smoke_route_stage,
	}
	var area01_cue_report: Dictionary = _ensure_area01_visual_director().cue_debug_report(self, _area01_visual_smoke_camera_region())
	state["area01_cue_family_counts"] = area01_cue_report.get("families", {})
	state["area01_cue_family_warnings"] = area01_cue_report.get("warnings", [])
	state["area01_capture_camera"] = _area01_overlay_camera_state()
	var player_smoke_state := _player_visual_smoke_state()
	state["player_visual_state"] = player_smoke_state
	state["player_rendered"] = _player_visual_smoke_rendered(player_smoke_state)
	state["player_on_screen"] = _player_visual_smoke_on_screen(player_smoke_state)
	var area01_wall := get_node_or_null("Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass") as Polygon2D
	var area01_lip := get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip") as Polygon2D
	if area01_wall != null and area01_lip != null:
		state["area01_wall_authority"] = {
			"wall_alpha": area01_wall.color.a,
			"wall_red": area01_wall.color.r,
			"wall_green": area01_wall.color.g,
			"wall_blue": area01_wall.color.b,
			"lip_alpha": area01_lip.color.a,
			"wall_points": area01_wall.polygon.size(),
			"lip_points": area01_lip.polygon.size(),
		}
	JavaScriptBridge.eval("window.__oceangameVisualState = %s;" % JSON.stringify(state), true)

func _player_visual_smoke_rendered(player_state: Dictionary) -> bool:
	return (
		bool(player_state.get("available", false))
		and bool(player_state.get("player_visible", false))
		and bool(player_state.get("visual_root_visible", false))
		and bool(player_state.get("sprite_visible", false))
		and bool(player_state.get("sprite_has_texture", false))
		and float(player_state.get("sprite_alpha", 0.0)) > 0.25
	)

func _player_visual_smoke_on_screen(player_state: Dictionary) -> bool:
	if not _player_visual_smoke_rendered(player_state):
		return false

	var viewport_size := get_viewport_rect().size
	var screen_position := Vector2(
		float(player_state.get("screen_x", -99999.0)),
		float(player_state.get("screen_y", -99999.0))
	)
	return Rect2(Vector2.ZERO, viewport_size).has_point(screen_position)

func _player_visual_smoke_state() -> Dictionary:
	if player == null:
		return {"available": false}

	var visual_root := player.get_node_or_null("VisualRoot") as CanvasItem
	var sprite := player.get_node_or_null("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	var screen_position := _scan_reticle_screen_position(player.global_position)
	var player_canvas := player as CanvasItem
	var sprite_region := Rect2()
	var sprite_alpha := 0.0
	var sprite_has_texture := false
	if sprite != null:
		sprite_region = sprite.region_rect
		sprite_alpha = sprite.modulate.a
		sprite_has_texture = sprite.texture != null

	return {
		"available": true,
		"world_x": roundi(player.global_position.x),
		"world_y": roundi(player.global_position.y),
		"screen_x": roundi(screen_position.x),
		"screen_y": roundi(screen_position.y),
		"player_visible": player_canvas.visible,
		"visual_root_visible": visual_root != null and visual_root.visible,
		"sprite_visible": sprite != null and sprite.visible,
		"sprite_has_texture": sprite_has_texture,
		"sprite_alpha": sprite_alpha,
		"sprite_region_x": roundi(sprite_region.position.x),
		"sprite_region_y": roundi(sprite_region.position.y),
		"sprite_region_width": roundi(sprite_region.size.x),
		"sprite_region_height": roundi(sprite_region.size.y),
		"player_z": player_canvas.z_index,
		"visual_effective_z": _effective_canvas_z(visual_root),
	}

func _area01_visual_smoke_camera_region() -> Rect2:
	var visible_rect := get_viewport_rect()
	var top_left := get_canvas_transform().affine_inverse() * visible_rect.position
	var bottom_right := get_canvas_transform().affine_inverse() * visible_rect.end
	return Rect2(top_left, bottom_right - top_left).abs()

func _effective_canvas_z(node: Node) -> int:
	var effective_z := 0
	var current: Node = node
	var include_parent_z := true
	while current != null:
		if current is CanvasItem:
			var canvas_item := current as CanvasItem
			if include_parent_z:
				effective_z += canvas_item.z_index
				include_parent_z = canvas_item.z_as_relative
			else:
				break
		current = current.get_parent()
	return effective_z

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
		if surface_tab_index == SURFACE_TAB_NIGHT:
			run_title_label.text = _format_expedition_day_title("Night")
			run_summary_label.text = _format_run_summary(_format_night_phase_summary(), "night")
		elif surface_tab_index == SURFACE_TAB_UPGRADES:
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
		survival_state.status_line(),
		survival_state.nightly_pressure_line(),
		survival_state.supply_cache_hint_line(),
		"Dive for supplies, cargo, or knowledge, then extract.",
		_format_condition_briefing(),
		_format_dawn_priority_line(),
		"%s begins." % _action_label("interact"),
	]
	if show_debug_telemetry:
		lines.append("Debug: F9 resets prototype save.")

	return "\n".join(lines)

func _latest_recent_route_memory() -> String:
	if recent_expedition_log.is_empty():
		return ""

	var latest_entry := recent_expedition_log[recent_expedition_log.size() - 1]
	return String(latest_entry.get("route_memory", ""))

func _format_resource_counts(resource_ids: Array[String]) -> String:
	if resource_ids.is_empty():
		return ""

	var counts := {}
	for resource_id in resource_ids:
		counts[resource_id] = int(counts.get(resource_id, 0)) + 1

	var parts: Array[String] = []
	for resource_id in counts.keys():
		parts.append(" %s: %s x%d" % [
			_resource_category_label(resource_id),
			_display_name_for_resource(resource_id),
			int(counts[resource_id]),
		])

	return "\n" + "\n".join(parts)

func _format_survival_supply_counts(supply_ids: Array[String]) -> String:
	if supply_ids.is_empty():
		return ""

	var counts := {}
	for supply_id in supply_ids:
		counts[supply_id] = int(counts.get(supply_id, 0)) + 1

	var parts: Array[String] = []
	for supply_id in counts.keys():
		parts.append(" %s: %s x%d" % [
			_resource_category_label(supply_id),
			survival_state.display_name_for_supply(supply_id),
			int(counts[supply_id]),
		])

	return "\n" + "\n".join(parts)

func _format_survival_banking_line(banked_survival_supplies: Array[String]) -> String:
	if banked_survival_supplies.is_empty():
		return "Survival needs banked: none."

	return "Survival needs banked:%s" % _format_survival_supply_counts(banked_survival_supplies)

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
			return Color(0.14, 0.42, 0.24, 0.72)
		"shell_fragments":
			return Color(0.46, 0.34, 0.16, 0.72)
		"glow_plankton":
			return Color(0.38, 0.52, 0.12, 0.76)
		"scrap_metal":
			return Color(0.28, 0.42, 0.46, 0.72)
		"driftwood":
			return Color(0.45, 0.31, 0.16, 0.72)
		"quartz_glass":
			return Color(0.15, 0.55, 0.66, 0.72)
		"food_supply":
			return Color(0.46, 0.25, 0.1, 0.72)
		"water_supply":
			return Color(0.1, 0.32, 0.46, 0.72)
		"power_supply":
			return Color(0.42, 0.38, 0.1, 0.72)
		"hidden":
			return Color(0.0, 0.0, 0.0, 0.0)
		"locked":
			return Color(0.012, 0.025, 0.032, 0.22)
		_:
			return Color(0.055, 0.16, 0.19, 0.5)

func _cargo_slot_icon_polygon(state: String) -> PackedVector2Array:
	match state:
		"kelp_fiber":
			return PackedVector2Array([Vector2(-3, 9), Vector2(-8, 4), Vector2(-4, -8), Vector2(0, -10), Vector2(3, 8), Vector2(8, 2), Vector2(6, 8)])
		"shell_fragments":
			return PackedVector2Array([Vector2(-9, 7), Vector2(-5, -5), Vector2(0, -9), Vector2(5, -5), Vector2(9, 7), Vector2(3, 10), Vector2(-3, 10)])
		"glow_plankton":
			return PackedVector2Array([Vector2(0, -9), Vector2(8, 0), Vector2(0, 9), Vector2(-8, 0)])
		"scrap_metal":
			return PackedVector2Array([Vector2(-9, -5), Vector2(3, -9), Vector2(10, -2), Vector2(6, 7), Vector2(-7, 9), Vector2(-11, 1)])
		"driftwood":
			return PackedVector2Array([Vector2(-11, 5), Vector2(-4, -8), Vector2(2, -5), Vector2(9, -9), Vector2(5, 7), Vector2(-5, 10)])
		"quartz_glass":
			return PackedVector2Array([Vector2(0, -11), Vector2(8, -3), Vector2(6, 7), Vector2(0, 11), Vector2(-7, 6), Vector2(-8, -4)])
		"food_supply":
			return PackedVector2Array([Vector2(-8, -7), Vector2(8, -7), Vector2(10, 3), Vector2(2, 10), Vector2(-9, 6)])
		"water_supply":
			return PackedVector2Array([Vector2(0, -10), Vector2(8, -1), Vector2(5, 9), Vector2(-5, 9), Vector2(-8, -1)])
		"power_supply":
			return PackedVector2Array([Vector2(-3, -10), Vector2(7, -2), Vector2(1, -1), Vector2(5, 10), Vector2(-7, 0), Vector2(-1, 0)])
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
		"scrap_metal":
			return Color(0.72, 0.92, 0.98, 0.98)
		"driftwood":
			return Color(1.0, 0.72, 0.4, 0.98)
		"quartz_glass":
			return Color(0.6, 1.0, 1.0, 0.98)
		"food_supply":
			return Color(1.0, 0.86, 0.58, 0.98)
		"water_supply":
			return Color(0.74, 0.96, 1.0, 0.98)
		"power_supply":
			return Color(1.0, 1.0, 0.52, 0.98)
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

func _update_tool_belt(is_visible: bool) -> void:
	var tool_keys := ["F", "Space", "2", "3", "5"]
	for index in range(tool_slot_nodes.size()):
		var tool_id: String = TOOL_BELT_TOOL_IDS[index]
		var state := _tool_belt_state(tool_id)
		tool_slot_nodes[index].visible = is_visible
		tool_icon_nodes[index].visible = is_visible
		tool_key_label_nodes[index].visible = is_visible
		tool_slot_nodes[index].color = _tool_slot_color(state)
		tool_icon_nodes[index].polygon = _tool_icon_polygon(tool_id)
		tool_icon_nodes[index].color = _tool_icon_color(tool_id, state)
		tool_key_label_nodes[index].text = tool_keys[index]
		tool_key_label_nodes[index].modulate = _tool_key_color(state)

func _tool_belt_state(tool_id: String) -> String:
	match tool_id:
		"scanner":
			return "active" if current_scan_target != null else "ready"
		"burst":
			if burst_thruster_cooldown_remaining > 0.0:
				return "cooldown"
			return "ready" if dive_session.oxygen > burst_thruster_oxygen_cost else "disabled"
		"cutter":
			return "ready" if progression_state.has_upgrade(SALVAGE_CUTTER_UPGRADE_ID) else "locked"
		"decoy":
			if not progression_state.has_upgrade(DECOY_PULSE_UPGRADE_ID):
				return "locked"
			return "spent" if decoy_pulse_used_this_run else "ready"
		"reserve":
			return "locked"
		_:
			return "disabled"

func _tool_slot_color(state: String) -> Color:
	match state:
		"active":
			return Color(0.06, 0.36, 0.42, 0.68)
		"ready":
			return Color(0.018, 0.075, 0.095, 0.5)
		"cooldown":
			return Color(0.09, 0.08, 0.035, 0.54)
		"spent":
			return Color(0.05, 0.055, 0.065, 0.44)
		"locked":
			return Color(0.012, 0.02, 0.028, 0.34)
		_:
			return Color(0.014, 0.024, 0.032, 0.34)

func _tool_key_color(state: String) -> Color:
	match state:
		"active":
			return Color(0.72, 1.0, 1.0, 1.0)
		"ready":
			return Color(0.88, 0.96, 1.0, 0.96)
		"cooldown":
			return Color(1.0, 0.82, 0.38, 0.92)
		"locked", "spent":
			return Color(0.62, 0.7, 0.74, 0.82)
		_:
			return Color(0.5, 0.55, 0.6, 0.75)

func _tool_icon_color(tool_id: String, state: String) -> Color:
	if state == "locked" or state == "spent":
		return Color(0.45, 0.56, 0.62, 0.72)
	match tool_id:
		"scanner":
			return Color(0.1, 0.92, 1.0, 0.98)
		"burst":
			return Color(0.55, 0.92, 1.0, 0.98)
		"cutter":
			return Color(1.0, 0.82, 0.48, 0.98)
		"decoy":
			return Color(0.45, 0.88, 1.0, 0.98)
		"reserve":
			return Color(1.0, 0.72, 0.58, 0.98)
		_:
			return Color(0.8, 0.9, 1.0, 0.88)

func _tool_icon_polygon(tool_id: String) -> PackedVector2Array:
	match tool_id:
		"scanner":
			return PackedVector2Array([Vector2(-12, -3), Vector2(-4, -12), Vector2(10, -9), Vector2(14, 0), Vector2(8, 10), Vector2(-7, 9), Vector2(-14, 2)])
		"burst":
			return PackedVector2Array([Vector2(-13, 7), Vector2(-2, -12), Vector2(4, -3), Vector2(13, -6), Vector2(3, 12), Vector2(-3, 3)])
		"cutter":
			return PackedVector2Array([Vector2(-12, 9), Vector2(-4, -8), Vector2(3, -11), Vector2(12, -3), Vector2(4, 1), Vector2(0, 11)])
		"decoy":
			return PackedVector2Array([Vector2(0, -13), Vector2(10, -5), Vector2(10, 7), Vector2(0, 13), Vector2(-10, 7), Vector2(-10, -5)])
		"reserve":
			return PackedVector2Array([Vector2(-11, -8), Vector2(11, -8), Vector2(11, 8), Vector2(-11, 8)])
		_:
			return PackedVector2Array()

func _short_resource_name(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp"
		"shell_fragments":
			return "Shell"
		"glow_plankton":
			return "Glow"
		"scrap_metal":
			return "Scrap"
		"driftwood":
			return "Wood"
		"quartz_glass":
			return "Glass"
		"food_supply", "water_supply", "power_supply":
			return survival_state.short_name_for_supply(resource_id)
		_:
			return resource_id

func _format_banked_resources() -> String:
	if progression_state.banked_resources.is_empty():
		return " none"

	var parts: Array[String] = []
	for resource_id in progression_state.banked_resources.keys():
		parts.append(" %s: %s x%d" % [
			_resource_category_label(resource_id),
			_display_name_for_resource(resource_id),
			progression_state.resource_count(resource_id)
		])

	return "\n" + "\n".join(parts)

func _resource_category_label(resource_id: String) -> String:
	if survival_state.is_supply_id(resource_id):
		return survival_state.category_name_for_supply(resource_id)
	return String(RESOURCE_CATEGORY_LABELS.get(resource_id, "Resource"))

func _display_name_for_resource(resource_id: String) -> String:
	match resource_id:
		"kelp_fiber":
			return "Kelp Fiber"
		"shell_fragments":
			return "Shell Fragments"
		"glow_plankton":
			return "Glow Plankton"
		"scrap_metal":
			return "Scrap Metal"
		"driftwood":
			return "Driftwood"
		"quartz_glass":
			return "Quartz Glass"
		"food_supply", "water_supply", "power_supply":
			return survival_state.display_name_for_supply(resource_id)
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

	return "%s burst -%d" % [_action_label("burst_thruster"), ceili(burst_thruster_oxygen_cost)]

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
	if upgrade.id == SALVAGE_CUTTER_UPGRADE_ID:
		return _format_salvage_cutter_upgrade_state(effect_summary)

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

func _format_salvage_cutter_upgrade_state(effect_summary: String) -> String:
	var missing_discovery := _upgrade_missing_discovery(SALVAGE_CUTTER_UPGRADE)
	if missing_discovery != "":
		return "State: Needs salvage data\nRecover: Salvage Data Cache\n%s" % effect_summary

	if progression_state.can_afford(SALVAGE_CUTTER_UPGRADE.resource_cost):
		return "State: Available now\n%s: buy\n%s" % [
			_action_label("interact").replace("/", " or "),
			effect_summary,
		]

	return "State: Missing resources\nNeeds: %s\n%s" % [
		_format_missing_resources_inline(SALVAGE_CUTTER_UPGRADE.resource_cost),
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
		WATER_FILTER_UPGRADE_ID:
			return "Effect: +1 Water reserve now."
		PREDATOR_WARNING_UPGRADE_ID:
			return "Effect: earlier predator warning."
		DECOY_PULSE_UPGRADE_ID:
			return "Effect: one decoy window per expedition."
		SALVAGE_CUTTER_UPGRADE_ID:
			return "Effect: opens the sealed Wide Reef salvage pocket."

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
		compact = "%s..." % compact.substr(0, max_chars - 3)

	return compact

func _format_future_tool_upgrade_promise() -> String:
	return ""

func _has_future_tool_upgrade_context() -> bool:
	return false

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
			return "Upgrade progress: %s %s to unlock %s." % [
				_format_upgrade_prerequisite_action(missing_discovery),
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
		return "Upgrade/build materials banked: %d.%s" % [
			extracted_count,
			_format_resource_counts(extracted_cargo),
		]
	if not run_completed_scans.is_empty():
		return "Banked 0 resources. Useful dive: scan data came home."

	return "Banked 0 resources. No cargo or new scans came home."

func _sync_survival_supply_cache_state() -> void:
	if survival_supply_cache_halo == null or survival_supply_cache_core == null:
		return

	if run_survival_supply_cache_recovered:
		survival_supply_cache_halo.color = Color(0.72, 0.95, 1.0, 0.08)
		survival_supply_cache_core.color = Color(0.96, 0.78, 0.38, 0.18)
		if survival_supply_cache_label != null:
			survival_supply_cache_label.text = "SUPPLY TAKEN"
	else:
		survival_supply_cache_halo.color = Color(0.72, 0.95, 1.0, 0.22)
		survival_supply_cache_core.color = Color(0.96, 0.78, 0.38, 0.72)
		if survival_supply_cache_label != null:
			survival_supply_cache_label.text = "SUPPLY CACHE"

func _record_salvage_data_cache_discovery_if_extracted() -> void:
	if not run_salvage_data_cache_recovered:
		return
	if progression_state.has_discovery("salvage_data_cache"):
		return

	progression_state.add_discovery(
		"salvage_data_cache",
		"Salvage Data Cache",
		"Recovered Wide Reef cutter prep data.",
		"Unlocks Salvage Cutter I for the sealed Wide Reef salvage pocket."
	)

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
		WATER_FILTER_UPGRADE_ID:
			return "Water Filter I"
		SALVAGE_CUTTER_UPGRADE_ID:
			return "Salvage Cutter I"
		_:
			return upgrade_id

func _format_upgrade_prerequisite_action(discovery_id: String) -> String:
	if discovery_id == "salvage_data_cache":
		return "recover"

	return "scan"

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
		"salvage_data_cache":
			return "Salvage Data Cache"
		"gulper_eel":
			return "Gulper Eel"
		"lantern_ray":
			return "Lantern Ray"
		"hollow_reef_skitter":
			return "Hollow Reef Skitter"
		"glassfin_swarm":
			return "Glassfin Swarm"
		"mirrorfin_drift":
			return "Mirrorfin Drift"
		"glass_ray_drifter":
			return "Glass Ray Drifter"
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
	run_collected_survival_supplies.clear()
	run_banked_survival_supplies.clear()
	run_completed_scans.clear()
	run_predator_contacts = 0
	run_health_damage_events = 0
	last_health_damage_source = ""
	last_health_damage_amount = 0.0
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
	run_hollow_reef_reading_recovered = false
	run_salvage_manifest_recovered = false
	run_salvage_data_cache_recovered = false
	run_outer_shelf_survey_recovered = false
	run_rim_glass_reading_recovered = false
	run_tideglass_sample_recovered = false
	run_survival_supply_cache_recovered = false
	last_completed_survival_day = 0
	debug_wreck_echo_review_staged = false
	visual_smoke_route_stage = ""
	current_lantern_ray_route_id = "none"
	echo_lens_pulse_timer = 0.0
	blue_chimney_draft_timer = 0.0
	blackwater_pressure_timer = 0.0
	lantern_ray_timing_timer = 0.0
	hollow_reef_timing_timer = 0.0
	glassfin_swarm_spacing_timer = 0.0
	salvage_silt_timing_timer = 0.0
	outer_shelf_slackwater_timer = 0.0
	if echo_lens_pulse != null:
		echo_lens_pulse.visible = false
	_sync_east_shelf_pocket_payoff_state()
	_sync_blue_chimney_payoff_state()
	_sync_blackwater_trace_payoff_state()
	_sync_glass_kelp_reading_state()
	_sync_hollow_reef_reading_state()
	_sync_salvage_manifest_state()
	_sync_salvage_data_cache_state()
	_sync_outer_shelf_survey_state()
	_sync_rim_glass_reading_state()
	_sync_tideglass_sample_state()
	_sync_survival_supply_cache_state()

func _format_run_telemetry(result_name: String) -> String:
	return "\n\nPlaytest data:\nResult: %s\nSeed: %d\nPattern: %s\nCondition: %s\nPredator route: %s\nLantern Ray route: %s\nCargo collected:%s%s\nScans: %s\nPredator contacts: %d\nHealth damage events: %d\nOxygen at result: %d / %d\nHealth at result: %d / %d\nFailure cause: %s" % [
		result_name,
		progression_state.current_run_seed,
		_format_cluster_pattern(current_resource_cluster_pattern),
		_format_condition_telemetry(),
		current_predator_route_id,
		current_lantern_ray_route_id,
		_format_resource_counts(run_collected_resources),
		_format_survival_supply_counts(run_collected_survival_supplies),
		_format_scan_ids(run_completed_scans),
		run_predator_contacts,
		run_health_damage_events,
		ceili(dive_session.oxygen),
		ceili(dive_session.max_oxygen),
		ceili(dive_session.health),
		ceili(dive_session.max_health),
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
	if survival_state.chapter_failed:
		return "Next: press %s to restart Emergency Week." % _action_label("restart_dive")
	if survival_state.chapter_complete:
		return "Next: press %s for a stabilized expedition." % _action_label("restart_dive")

	return "Next: press %s for Expedition %d; %s" % [
		_action_label("restart_dive"),
		progression_state.current_run_number + 1,
		_format_current_tomorrow_intention(),
	]

func _format_tomorrow_plan() -> String:
	var empty_needs := _base_need_names_at_or_below(0)
	if not empty_needs.is_empty():
		return "bank %s supply first; empty needs cut max oxygen." % _format_need_list(empty_needs)

	var ready_upgrade := _first_ready_upgrade_definition()
	if ready_upgrade != null:
		return "build %s in Upgrades before diving." % ready_upgrade.display_name

	var low_needs := _base_need_names_at_or_below(1)
	if not low_needs.is_empty():
		return "bank %s supply soon to protect tomorrow's oxygen." % _format_need_list(low_needs)

	if run_rim_glass_reading_recovered:
		return "use the Glass Rim reading to choose timing, cargo, or return."
	if run_outer_shelf_survey_recovered:
		return "try Glass Rim timing or bank the Outer Shelf cargo."

	var starter_resource_target := _format_starter_resource_target()
	if not starter_resource_target.is_empty():
		return starter_resource_target

	var broad_goal := ExpeditionGoalFormatterScript.format_goal(progression_state, upgrade_definitions, _current_condition_id(), _latest_recent_route_memory())
	var goal_prefix := "Goal: "
	if broad_goal.begins_with(goal_prefix):
		broad_goal = broad_goal.substr(goal_prefix.length())
	if broad_goal.is_empty():
		return "the ocean shifts again."

	return broad_goal

func _refresh_carried_tomorrow_intention() -> void:
	carried_tomorrow_intention = _format_tomorrow_plan()

func _format_current_tomorrow_intention() -> String:
	var carried := carried_tomorrow_intention.strip_edges()
	if not carried.is_empty():
		return carried

	return _format_tomorrow_plan()

func _format_dawn_priority_line() -> String:
	return "Day priority: %s" % _format_current_tomorrow_intention()

func _format_starter_resource_target() -> String:
	if progression_state.has_upgrade(WATER_FILTER_UPGRADE_ID):
		return ""

	var missing_materials: Array[String] = []
	for resource_id in WATER_FILTER_UPGRADE.resource_cost.keys():
		var missing := int(WATER_FILTER_UPGRADE.resource_cost[resource_id]) - progression_state.resource_count(resource_id)
		if missing > 0:
			missing_materials.append(_display_name_for_resource(resource_id))

	if missing_materials.is_empty():
		return ""

	return "Shell Reef pockets: %s for Water Filter I." % _format_material_need_list(missing_materials)

func _format_material_need_list(materials: Array[String]) -> String:
	if materials.is_empty():
		return "materials"
	if materials.size() == 1:
		return materials[0]
	if materials.size() == 2:
		return "%s/%s" % [materials[0], materials[1]]
	return ", ".join(materials)

func _base_need_names_at_or_below(threshold: int) -> Array[String]:
	var needs: Array[String] = []
	if survival_state.food <= threshold:
		needs.append("Food")
	if survival_state.water <= threshold:
		needs.append("Water")
	if survival_state.power <= threshold:
		needs.append("Power")
	return needs

func _format_need_list(needs: Array[String]) -> String:
	if needs.is_empty():
		return "base"
	if needs.size() == 1:
		return needs[0]
	if needs.size() == 2:
		return "%s/%s" % [needs[0], needs[1]]
	return "%s/%s/%s" % [needs[0], needs[1], needs[2]]

func _format_expedition_ready_status() -> String:
	if survival_state.chapter_complete:
		return "Base stabilized: continue expeditions without nightly collapse."
	if _current_condition_id() == "low_visibility":
		return "Day %d ready: lower-trench visibility is poor today." % survival_state.current_day
	if _current_condition_id() == "kelp_bloom":
		return "Day %d ready: Mirror Kelp approaches are thicker today." % survival_state.current_day

	return "Day %d ready: the ocean changed overnight." % survival_state.current_day

func _format_expedition_day_title(suffix: String) -> String:
	if survival_state.chapter_complete:
		return "Base Stabilized %s" % suffix
	var display_day := last_completed_survival_day if (suffix.begins_with("Result") or suffix == "Night") and last_completed_survival_day > 0 else survival_state.current_day
	return "Emergency Week Day %d/%d %s" % [
		display_day,
		survival_state.max_days,
		suffix,
	]

func _format_completed_expedition_line(result_name: String) -> String:
	if survival_state.chapter_complete:
		return "Base Stabilized: %s." % result_name
	var display_day := last_completed_survival_day if last_completed_survival_day > 0 else survival_state.current_day
	return "Emergency Week Day %d: %s." % [
		display_day,
		result_name,
	]

func _format_extraction_result_summary(extracted_count: int, banked_resources: Array[String], banked_survival_supplies: Array[String] = []) -> String:
	return "%s\n%s\n%s\n%s%s\n%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n%s\n%s\nBest depth: %dm.\n%s%s" % [
		_format_completed_expedition_line("Extraction"),
		_format_extraction_banking_line(banked_resources.size(), banked_resources),
		_format_survival_banking_line(banked_survival_supplies),
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
		_format_hollow_reef_reading_callout(),
		_format_salvage_data_cache_research_callout(),
		_format_salvage_manifest_research_callout(),
		_format_tideglass_sample_research_callout(),
		_format_rim_glass_reading_callout(),
		_format_outer_shelf_survey_research_callout(),
		_format_sealed_shelf_hatch_readiness_callout(),
		_format_upgrade_progress_callout(),
		_format_scan_progress_callout("Discoveries recorded"),
		roundi(progression_state.best_depth_reached),
		_format_night_report_block(),
		_format_next_expedition_prompt()
	]

func _format_night_report_block() -> String:
	if last_night_report.is_empty():
		return ""

	return "Night Report:\n%s\n" % last_night_report

func _format_night_phase_summary() -> String:
	var lines: Array[String] = [
		_format_completed_expedition_line("Night"),
	]
	var report := _format_night_report_block().strip_edges()
	if not report.is_empty():
		lines.append(report)
	lines.append(_format_daylight_closeout_line())
	lines.append(survival_state.status_line())
	lines.append("Banked materials:%s" % _format_banked_resources())
	lines.append(_format_night_build_choice_line())
	lines.append(_format_next_expedition_prompt())
	return "\n".join(lines)

func _format_daylight_closeout_line() -> String:
	if daylight_nightfall_away_from_ship:
		if daylight_ship_offload_count > 0:
			return "Daylight closeout: nightfall caught the diver away from ship after %d ship offload(s); final return banked cargo and cost extra Power." % daylight_ship_offload_count
		return "Daylight closeout: nightfall caught the diver away from ship; final return banked cargo and cost extra Power."

	if daylight_ship_offload_count > 0:
		return "Daylight closeout: %d ship offload(s) banked cargo before night; final return resolved base needs." % daylight_ship_offload_count

	return "Daylight closeout: no ship offload before night; final return resolved base needs."

func _format_night_build_choice_line() -> String:
	if night_build_completed_this_surface:
		return "Build choice: Power Patch installed. Power +%d carries into tomorrow." % NIGHT_POWER_PATCH_POWER_GAIN
	if not survival_state.chapter_failed and not survival_state.chapter_complete and progression_state.can_afford(NIGHT_POWER_PATCH_COST):
		return "Build choice: Power Patch ready (%s craft; Scrap Metal x1 -> Power +%d tomorrow)." % [
			_action_label("interact").replace("/", " or "),
			NIGHT_POWER_PATCH_POWER_GAIN,
		]

	var ready_upgrade := _first_ready_upgrade_definition()
	if ready_upgrade != null:
		return "Build choice: %s ready in Upgrades." % ready_upgrade.display_name

	var progress := _format_upgrade_progress_callout()
	var prefix := "Upgrade progress: "
	if progress.begins_with(prefix):
		progress = progress.substr(prefix.length())
	if not survival_state.chapter_failed and not survival_state.chapter_complete:
		return "Build choice: Power Patch needs %s; %s" % [
			_format_missing_resources_inline(NIGHT_POWER_PATCH_COST),
			progress,
		]
	return "Build choice: %s" % progress

func _first_ready_upgrade_definition() -> UpgradeDefinition:
	for upgrade in upgrade_definitions:
		if progression_state.has_upgrade(upgrade.id):
			continue
		if _upgrade_missing_discovery(upgrade) != "":
			continue
		if _upgrade_missing_upgrade(upgrade) != "":
			continue
		if progression_state.can_afford(upgrade.resource_cost):
			return upgrade
	return null

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
			return "Today: %s.\nMirror Kelp approaches are denser; read the shimmer breaks." % display_name
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
	if run_rim_glass_reading_recovered:
		return "Route choice: recovered Glass Rim reading beyond the timing branch."
	if run_outer_shelf_survey_recovered:
		return "Route choice: Outer Shelf survey marked Glass Rim Cut as a timing branch."
	if _run_has_glass_rim_observation():
		return "Route choice: observed Glass Ray slackwater timing near Glass Rim."
	if run_tideglass_sample_recovered:
		return "Route choice: Mirror Kelp Pass reading marked a deeper kelp seal."
	if run_completed_scans.has("mirrorfin_drift"):
		return "Route choice: observed Mirror Kelp reflection timing."
	if run_salvage_manifest_recovered:
		return "Route choice: opened salvage pocket manifest instead of only cargo."
	if run_salvage_data_cache_recovered:
		return "Route choice: wide chamber salvage cache marked a sealed pocket."
	if run_hollow_reef_reading_recovered:
		return "Route choice: lower-route research push reached Hollow Reef."
	if _run_has_hollow_reef_observation():
		return "Route choice: observed Hollow Reef upper-shelf timing."
	if run_reached_dusk_trench:
		return "Route choice: lower-route research push reached Dusk Trench."
	if _run_has_glassfin_swarm_observation():
		return "Route choice: observed Glassfin Swarm spacing without fighting."
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
	if run_completed_scans.has("lantern_ray"):
		return "Route choice: observed Lantern Ray timing without fighting."
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
	if run_rim_glass_reading_recovered:
		return "Glass Rim"
	if run_outer_shelf_survey_recovered or _run_has_glass_rim_observation():
		return "Outer Shelf"
	if _run_has_mirror_kelp_evidence():
		return "Mirror Kelp Pass"
	if run_salvage_manifest_recovered:
		return "Salvage Pocket"
	if run_salvage_data_cache_recovered:
		return "Wide Reef Chamber"
	if run_hollow_reef_reading_recovered or _run_has_hollow_reef_observation():
		return "Hollow Reef"
	if run_reached_dusk_trench:
		return "Dusk Trench"
	if _run_has_glassfin_swarm_observation():
		return "Glassfin Swarm"
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
	if run_completed_scans.has("lantern_ray"):
		return "Lantern Ray"
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

func _format_hollow_reef_reading_callout() -> String:
	if run_hollow_reef_reading_recovered:
		return "\nResearch: Hollow Reef cave reading marks a side-cave branch off Dusk Trench; return via Dusk and Blackwater."

	return ""

func _format_salvage_data_cache_research_callout() -> String:
	if run_salvage_data_cache_recovered:
		return "\nResearch: Salvage data cache gives the lab Salvage Cutter I prep for the sealed wreck pocket."

	return ""

func _format_salvage_manifest_research_callout() -> String:
	if run_salvage_manifest_recovered:
		return "\nResearch: Salvage Manifest identifies a cut-open wreck pocket; shell cargo is optional if oxygen allows."

	return ""

func _format_tideglass_sample_research_callout() -> String:
	if run_tideglass_sample_recovered:
		return "\nResearch: Tideglass Sample gives the lab a Mirror Kelp return-current reading."

	return ""

func _format_outer_shelf_survey_research_callout() -> String:
	if run_outer_shelf_survey_recovered:
		return "\nResearch: Outer Shelf survey compares the Glass Rim Cut timing window against nearby Kelp Fiber cargo."

	return ""

func _format_rim_glass_reading_callout() -> String:
	if run_rim_glass_reading_recovered:
		return "\nResearch: Glass Rim reading confirms the slackwater crossing; cargo remains optional if oxygen allows."

	return ""

func _format_sealed_shelf_hatch_readiness_callout() -> String:
	if not progression_state.has_upgrade(ECHO_LENS_UPGRADE_ID):
		return ""
	if not run_east_shelf_pocket_ping_recovered and not run_lower_connector_echo_recovered:
		return ""

	return "\nLab note: Echo Lens reads the Sealed Shelf Hatch; Resonance Key planning can wait."

func _format_region_memory_callout() -> String:
	if run_rim_glass_reading_recovered:
		return "Remembered place: Glass Rim - slackwater crossing beyond Outer Shelf; return through Mirror/Wide/Hollow."
	if run_outer_shelf_survey_recovered:
		return "Remembered place: Outer Shelf - wider water beyond Mirror Kelp; return through Mirror/Wide/Hollow."
	if _run_has_glass_rim_observation():
		return "Remembered place: Outer Shelf - Glass Ray timing marks the Glass Rim slackwater; return through Mirror/Wide/Hollow."
	if _run_has_mirror_kelp_evidence():
		return "Remembered place: Mirror Kelp Pass - reflective branch beyond Wide Reef; return through Hollow Reef."
	if run_salvage_manifest_recovered:
		return "Remembered place: Salvage Pocket - cut-open wreck pocket off Wide Reef; return through Hollow Reef."
	if run_salvage_data_cache_recovered:
		return "Remembered place: Wide Reef Chamber - salvage pocket off Hollow Reef; return through Dusk."
	if run_hollow_reef_reading_recovered:
		return "Remembered place: Hollow Reef - side-cave branch off Dusk; return through Blackwater."
	if _run_has_hollow_reef_observation():
		return "Remembered place: Hollow Reef - upper-shelf timing, return through Blackwater."
	if run_reached_dusk_trench:
		return "Remembered place: Dusk Trench - return up-left through Blackwater and Silt Vein to Blue Chimney."
	if _run_has_glassfin_swarm_observation():
		return "Remembered place: Glassfin Swarm Route - spacing window in the wide chamber; return through Hollow Reef."
	if run_completed_scans.has("lantern_ray"):
		return "Remembered place: Lantern Ray Route - watch the timing lane and return through Blackwater."
	if run_predator_contacts > 0 or run_completed_scans.has("gulper_eel"):
		return "Remembered place: Gulper Route - warning-lane timing matters."
	if run_completed_scans.has("wreck_signal_cache") or run_completed_scans.has("pressure_wreck_signal"):
		return "Remembered place: Wreck Shelf - pressure-route signals are worth returning to."
	if run_completed_scans.has("thermal_vent") or run_collected_resources.has("glow_plankton"):
		return "Remembered place: Thermal Vent Field - warm clues can lead toward deeper glow."
	if run_completed_scans.has("shell_reef_shelf") or run_collected_resources.has("shell_fragments"):
		return "Remembered place: Shell Reef - a safer midwater bank route."

	return "Remembered place: Surface Base - safe return resolves the day."

func _run_has_mirror_kelp_evidence() -> bool:
	return run_tideglass_sample_recovered or run_completed_scans.has("mirrorfin_drift")

func _run_has_glass_rim_observation() -> bool:
	return run_completed_scans.has("glass_ray_drifter")

func _format_discovery_memory_callout() -> String:
	if run_completed_scans.has("wreck_signal_cache"):
		return "\nDiscovery remembered: Wreck Signal Cache - deeper echoes may be readable later."
	if run_completed_scans.has("pressure_wreck_signal"):
		return "\nDiscovery remembered: Pressure-Locked Research Wreck - pressure access can open this route."
	if run_completed_scans.has("gulper_eel"):
		return "\nDiscovery remembered: Gulper Eel - warning-lane behavior can be studied."
	if run_completed_scans.has("glassfin_swarm"):
		return "\nDiscovery remembered: Glassfin Swarm - spacing can be read without fighting."
	if run_completed_scans.has("mirrorfin_drift"):
		return "\nDiscovery remembered: Mirrorfin Drift - reflection breaks can be read without fighting."
	if run_completed_scans.has("glass_ray_drifter"):
		return "\nDiscovery remembered: Glass Ray Drifter - Glass Rim slackwater can be read without fighting."
	if run_completed_scans.has("lantern_ray"):
		return "\nDiscovery remembered: Lantern Ray - lower-route movement can be observed without fighting."
	if run_completed_scans.has("thermal_vent"):
		return "\nDiscovery remembered: Thermal Vent - pressure-seal knowledge is banked."
	if run_completed_scans.has("shell_reef_shelf"):
		return "\nDiscovery remembered: Shell Reef Shelf - safer midwater banking route marked."

	return ""

func _run_has_hollow_reef_observation() -> bool:
	return run_completed_scans.has("hollow_reef_skitter")

func _run_has_glassfin_swarm_observation() -> bool:
	return run_completed_scans.has("glassfin_swarm")

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
		"survival_memory": _format_recent_survival_memory(result_name, banked_cargo_count),
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
		var route_memory := String(entry.get("route_memory", "none"))
		var line := "#%d %s: banked %d, route %s, scans %s, contacts %d, best %dm" % [
			int(entry.get("run_number", 0)),
			String(entry.get("result", "Unknown")),
			int(entry.get("banked_cargo_count", 0)),
			route_memory,
			_format_scan_names_short(_string_array_from(entry.get("scans", []))),
			int(entry.get("predator_contacts", 0)),
			int(entry.get("best_depth", 0)),
		]
		var route_tease := _format_recent_route_tease(route_memory)
		if not route_tease.is_empty():
			line += ", next %s" % route_tease
		var survival_memory := String(entry.get("survival_memory", ""))
		if not survival_memory.is_empty():
			line += ", survival %s" % survival_memory
		if show_debug_telemetry:
			line += " | seed %d, %s" % [
				int(entry.get("seed", 0)),
				String(entry.get("pattern", "unknown")),
			]
		lines.append(line)

	return "\n".join(lines)

func _format_recent_survival_memory(result_name: String, banked_cargo_count: int) -> String:
	if run_health_damage_events > 0 and dive_session.health < dive_session.max_health:
		return "health %d/%d; no surface heal" % [
			ceili(dive_session.health),
			ceili(dive_session.max_health),
		]
	if daylight_nightfall_away_from_ship:
		return "late return cost Power -1"
	if not run_banked_survival_supplies.is_empty():
		return "banked %s supply" % _format_supply_names_inline(run_banked_survival_supplies)

	var low_needs := _base_need_names_at_or_below(1)
	if not low_needs.is_empty():
		return "low %s" % _format_need_list(low_needs)

	if result_name == "Extracted" and banked_cargo_count == 0:
		var starter_target := _format_starter_resource_target()
		if not starter_target.is_empty():
			var prefix := "Shell Reef pockets: "
			var suffix := " for Water Filter I."
			if starter_target.begins_with(prefix):
				starter_target = starter_target.substr(prefix.length())
			if starter_target.ends_with(suffix):
				starter_target = starter_target.substr(0, starter_target.length() - suffix.length())
			return "Water Filter needs %s" % starter_target

	return ""

func _format_supply_names_inline(supply_ids: Array[String]) -> String:
	if supply_ids.is_empty():
		return "supply"

	var names: Array[String] = []
	for supply_id in supply_ids:
		var name := survival_state.short_name_for_supply(supply_id)
		if not names.has(name):
			names.append(name)
	return _format_need_list(names)

func _format_recent_route_tease(route_memory: String) -> String:
	match route_memory:
		"Glass Rim":
			return "timing, cargo, or return"
		"Outer Shelf":
			return "Glass Rim timing or cargo"
		_:
			return ""

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

func _format_active_objective_line() -> String:
	var objective := "Find supplies, scan, return"
	if dive_session.current_cargo.size() >= dive_session.cargo_limit:
		objective = "Cargo full: return to bank"
	elif player_in_base and dive_session.has_left_base:
		if _can_ship_offload():
			objective = "At ship: offload, O2 full"
		elif daylight_nightfall_announced:
			if daylight_nightfall_away_from_ship:
				objective = "At ship: start night, Power -1"
			else:
				objective = "At ship: start night"
		else:
			objective = "At ship: dive again"
	elif daylight_nightfall_announced:
		objective = "Nightfall: return to ship"
	elif _should_warn_late_day_cargo_banking():
		objective = "Dusk: bank cargo soon"
	elif player_in_base:
		objective = "Leave moonpool, gather supplies"
	elif _is_player_in_surface_oxygen_refill():
		if _has_recent_health_damage():
			objective = "Surface: O2 only; health stays"
		else:
			objective = "Surface: refill O2; ship banks"
	elif _has_recent_health_damage():
		objective = "Health hit: surface won't heal"
	elif survival_state.food <= 1 or survival_state.water <= 1 or survival_state.power <= 1:
		objective = "Prioritize food, water, power"
	elif dive_session.current_cargo.size() > 0:
		objective = "Cargo %d/%d: ship or push deeper" % [
			dive_session.current_cargo.size(),
			dive_session.cargo_limit,
		]
	elif current_scan_target != null:
		objective = "Scan target or collect cargo"

	if objective.length() <= ACTIVE_OBJECTIVE_MAX_CHARS:
		return objective

	return objective.substr(0, ACTIVE_OBJECTIVE_MAX_CHARS - 3).strip_edges() + "..."

func _update_scan_target_feedback() -> void:
	var next_target := _scan_target_candidate() if dive_session.result == DiveSessionScript.Result.DIVING else null
	if current_scan_target != next_target:
		if current_scan_target != null and current_scan_target.has_method("set_scan_selected"):
			current_scan_target.set_scan_selected(false)
		current_scan_target = next_target
		if current_scan_target != null and current_scan_target.has_method("set_scan_selected"):
			current_scan_target.set_scan_selected(true)

	if current_scan_target == null:
		scan_card_title_label.text = "SCAN TARGET"
		scan_target_label.text = "none nearby"
		scan_card_meta_label.text = "No readable signal"
		scan_card_prompt_label.text = "Hold %s near a target" % _action_label("scan")
		scan_reticle_root.visible = false
	else:
		scan_card_title_label.text = "SCAN TARGET"
		scan_target_label.text = _scan_target_display_name(current_scan_target)
		scan_card_meta_label.text = "%s | %s" % [
			_format_scan_target_discovery_state(current_scan_target).to_upper(),
			_format_scan_target_type(current_scan_target).to_upper()
		]
		if scan_charge_target == current_scan_target:
			scan_card_prompt_label.text = "SCANNING %d%%" % int(roundf(_scan_charge_ratio() * 100.0))
		else:
			scan_card_prompt_label.text = "HOLD %s TO SCAN" % _action_label("scan")
		_update_scan_reticle_position(current_scan_target)

func _scan_target_candidate() -> Node:
	if _scan_target_still_selectable(current_scan_target):
		return current_scan_target

	return _nearest_scan_target()

func _scan_target_still_selectable(target: Node) -> bool:
	if target == null or player == null or not is_instance_valid(target):
		return false
	if not (target is Node2D):
		return false
	if not ScanTargetResolverScript.is_valid_target(target):
		return false

	return player.global_position.distance_to((target as Node2D).global_position) <= scan_range + SCAN_TARGET_STICKY_RANGE_BUFFER

func _update_scan_reticle_position(target: Node) -> void:
	if target == null or not (target is Node2D):
		scan_reticle_root.visible = false
		return

	var viewport_size := get_viewport_rect().size
	var screen_position := _scan_reticle_screen_position((target as Node2D).global_position)

	scan_reticle_root.visible = true
	scan_reticle_root.position = Vector2(
		clampf(screen_position.x, SCAN_RETICLE_SCREEN_MARGIN, viewport_size.x - SCAN_RETICLE_SCREEN_MARGIN),
		clampf(screen_position.y, SCAN_RETICLE_SCREEN_MARGIN, viewport_size.y - SCAN_RETICLE_SCREEN_MARGIN)
	)

func _scan_reticle_screen_position(world_position: Vector2) -> Vector2:
	var viewport_size := get_viewport_rect().size
	var canvas_transform := get_viewport().get_canvas_transform()
	if not canvas_transform.is_equal_approx(Transform2D.IDENTITY):
		return canvas_transform * world_position

	return _scan_reticle_fallback_screen_position(world_position, viewport_size)

func _scan_reticle_fallback_screen_position(world_position: Vector2, viewport_size: Vector2) -> Vector2:
	var screen_position := viewport_size * 0.5
	if player == null:
		return screen_position

	var zoom := Vector2.ONE
	var camera := player.get_node_or_null("Camera2D") as Camera2D
	if camera != null:
		zoom = camera.zoom
	var world_delta := world_position - player.global_position
	return screen_position + Vector2(world_delta.x * maxf(zoom.x, 0.001), world_delta.y * maxf(zoom.y, 0.001))

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
		"hollow_reef_skitter":
			return "creature"
		"glassfin_swarm":
			return "creature"
		"mirrorfin_drift":
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
	var oxygen_max := max_oxygen
	if progression_state.has_upgrade(OXYGEN_TANK_UPGRADE_ID):
		oxygen_max = oxygen_tank_1_max_oxygen

	return maxf(12.0, oxygen_max - survival_state.oxygen_penalty())

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
	if delta.x > 4000.0 and delta.y > 2500.0:
		route_hint = " via Mirror/Wide/Hollow"
	elif delta.x > 3000.0 and delta.y > 2500.0:
		route_hint = " via Hollow/Dusk/Blackwater"
	elif delta.x > 2200.0 and delta.y > 2400.0:
		route_hint = " via Dusk/Blackwater"
	elif delta.x > 2100.0 and delta.y > 2400.0:
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

	return "OXYGEN: %d / %d%s" % [ceili(current_oxygen), ceili(maximum_oxygen), suffix]

func _health_state(current_health: float, maximum_health: float) -> String:
	if maximum_health <= 0.0:
		return "normal"

	var health_ratio := current_health / maximum_health
	if health_ratio <= 0.18:
		return "critical"
	if health_ratio <= 0.35:
		return "low"

	return "normal"

func _format_health_label(current_health: float, maximum_health: float) -> String:
	var state := _health_state(current_health, maximum_health)
	var suffix := ""
	if state == "critical":
		suffix = "  CRITICAL"
	elif state == "low":
		suffix = "  LOW"

	return "HEALTH: %d / %d%s" % [ceili(current_health), ceili(maximum_health), suffix]

func _health_state_color(state: String) -> Color:
	if state == "critical":
		return HEALTH_CRITICAL_COLOR
	if state == "low":
		return HEALTH_LOW_COLOR

	return HEALTH_NORMAL_COLOR

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

func _update_health_feedback() -> void:
	if health_label == null:
		return

	health_label.modulate = Color.WHITE
	health_label.scale = Vector2.ONE
	if health_icon != null:
		health_icon.modulate = Color.WHITE
	if dive_session.result != DiveSessionScript.Result.DIVING or dive_session.max_health <= 0.0:
		return

	var health_state := _health_state(dive_session.health, dive_session.max_health)
	var health_color := _health_state_color(health_state)
	if health_state == "critical":
		var pulse := 1.0 + 0.07 * absf(sin(Time.get_ticks_msec() / 110.0))
		health_label.modulate = health_color
		health_label.scale = Vector2(pulse, pulse)
		if health_icon != null:
			health_icon.modulate = health_color
	elif health_state == "low":
		health_label.modulate = health_color
		if health_icon != null:
			health_icon.modulate = health_color
	elif _has_recent_health_damage():
		health_label.modulate = HEALTH_DAMAGED_COLOR
		if health_icon != null:
			health_icon.modulate = HEALTH_DAMAGED_COLOR

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
		survival_state.load_save_data(parsed.get("survival_state", {}))

func _save_progression() -> void:
	var file := FileAccess.open(PROGRESSION_SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_warning("Could not write progression save.")
		return

	var save_data := progression_state.to_save_data()
	save_data["survival_state"] = survival_state.to_save_data()
	file.store_string(JSON.stringify(save_data, "\t"))

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
