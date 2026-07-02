class_name MainSceneContext
extends Node2D

const DiveSessionScript := preload("res://scripts/dive_session.gd")
const ProgressionStateScript := preload("res://scripts/progression_state.gd")
const SurvivalStateScript := preload("res://scripts/survival_state.gd")
const UpgradePurchaseScript := preload("res://scripts/upgrade_purchase.gd")
const DiveCapacityServiceScript := preload("res://scripts/services/dive_capacity_service.gd")
const DiveLifecycleServiceScript := preload("res://scripts/services/dive_lifecycle_service.gd")
const DiveToolActionServiceScript := preload("res://scripts/services/dive_tool_action_service.gd")
const DaylightRuntimeServiceScript := preload("res://scripts/services/daylight_runtime_service.gd")
const DebugRuntimeServiceScript := preload("res://scripts/debug/debug_runtime_service.gd")
const ExpeditionSlateServiceScript := preload("res://scripts/services/expedition_slate_service.gd")
const InputActionServiceScript := preload("res://scripts/services/input_action_service.gd")
const MainProcessServiceScript := preload("res://scripts/services/main_process_service.gd")
const MainControllerStateServiceScript := preload("res://scripts/services/main_controller_state_service.gd")
const ScanTargetResolverScript := preload("res://scripts/scan_target_resolver.gd")
const ExpeditionGoalFormatterScript := preload("res://scripts/expedition_goal_formatter.gd")
const ExpeditionConditionScript := preload("res://scripts/expedition_condition.gd")
const RouteInteractionServiceScript := preload("res://scripts/services/route_interaction_service.gd")
const RouteProximityServiceScript := preload("res://scripts/services/route_proximity_service.gd")
const ScanRuntimeServiceScript := preload("res://scripts/services/scan_runtime_service.gd")
const SceneEventServiceScript := preload("res://scripts/services/scene_event_service.gd")
const SurfaceRuntimeServiceScript := preload("res://scripts/services/surface_runtime_service.gd")
const SurvivalControllerServiceScript := preload("res://scripts/services/survival_controller_service.gd")
const Area01VisualDirectorScript := preload("res://scripts/area01_visual_director.gd")
const BlueChimneyVisualStagingServiceScript := preload("res://scripts/debug/blue_chimney_visual_staging_service.gd")
const MobileTouchControlsScript := preload("res://scripts/mobile_touch_controls.gd")
const RunTelemetryResetServiceScript := preload("res://scripts/services/run_telemetry_reset_service.gd")
const ConditionPresenterScript := preload("res://scripts/ui/condition_presenter.gd")
const DaylightTimerHudServiceScript := preload("res://scripts/ui/daylight_timer_hud_service.gd")
const DiscoveryNamePresenterScript := preload("res://scripts/ui/discovery_name_presenter.gd")
const ExpeditionSlateNodeServiceScript := preload("res://scripts/ui/expedition_slate_node_service.gd")
const ExpeditionSlatePresenterScript := preload("res://scripts/ui/expedition_slate_presenter.gd")
const ExpandedRouteVisualStagingServiceScript := preload("res://scripts/debug/expanded_route_visual_staging_service.gd")
const HealthFeedbackPresenterScript := preload("res://scripts/ui/health_feedback_presenter.gd")
const HudPromptPresenterScript := preload("res://scripts/ui/hud_prompt_presenter.gd")
const HudPromptStateServiceScript := preload("res://scripts/ui/hud_prompt_state_service.gd")
const HudPresenterScript := preload("res://scripts/ui/hud_presenter.gd")
const HudLayoutServiceScript := preload("res://scripts/ui/hud_layout_service.gd")
const HudReferenceServiceScript := preload("res://scripts/ui/hud_reference_service.gd")
const CargoSlotPresenterScript := preload("res://scripts/ui/cargo_slot_presenter.gd")
const InventorySummaryPresenterScript := preload("res://scripts/ui/inventory_summary_presenter.gd")
const NightBuildPresenterScript := preload("res://scripts/ui/night_build_presenter.gd")
const ResourcePickupPresentationServiceScript := preload("res://scripts/ui/resource_pickup_presentation_service.gd")
const ResourceSummaryServiceScript := preload("res://scripts/ui/resource_summary_service.gd")
const RecentExpeditionLogServiceScript := preload("res://scripts/ui/recent_expedition_log_service.gd")
const RecentExpeditionPresenterScript := preload("res://scripts/ui/recent_expedition_presenter.gd")
const ScanEffectTextServiceScript := preload("res://scripts/ui/scan_effect_text_service.gd")
const ScanFeedbackPresenterScript := preload("res://scripts/ui/scan_feedback_presenter.gd")
const ScanTargetCardServiceScript := preload("res://scripts/ui/scan_target_card_service.gd")
const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")
const SurfaceResultPresenterScript := preload("res://scripts/ui/surface_result_presenter.gd")
const SurfaceRunSummaryServiceScript := preload("res://scripts/ui/surface_run_summary_service.gd")
const SurvivalSupplyCachePresenterScript := preload("res://scripts/ui/survival_supply_cache_presenter.gd")
const SurvivalSupplyCacheStateServiceScript := preload("res://scripts/ui/survival_supply_cache_state_service.gd")
const ToolBeltPresenterScript := preload("res://scripts/ui/tool_belt_presenter.gd")
const ConditionVisualSyncServiceScript := preload("res://scripts/ui/condition_visual_sync_service.gd")
const DiscoveryRevealSyncServiceScript := preload("res://scripts/ui/discovery_reveal_sync_service.gd")
const RouteGateSyncServiceScript := preload("res://scripts/ui/route_gate_sync_service.gd")
const RoutePayoffSyncServiceScript := preload("res://scripts/ui/route_payoff_sync_service.gd")
const RunPanelLayoutServiceScript := preload("res://scripts/ui/run_panel_layout_service.gd")
const ResearchResultCalloutServiceScript := preload("res://scripts/ui/research_result_callout_service.gd")
const BlackwaterGatePresenterScript := preload("res://scripts/ui/blackwater_gate_presenter.gd")
const SurfaceStatusPresenterScript := preload("res://scripts/ui/surface_status_presenter.gd")
const UpgradeCopyPresenterScript := preload("res://scripts/ui/upgrade_copy_presenter.gd")
const UpgradeStateServiceScript := preload("res://scripts/ui/upgrade_state_service.gd")
const SaveServiceScript := preload("res://scripts/services/save_service.gd")
const MainReadyServiceScript := preload("res://scripts/services/main_ready_service.gd")
const RunPreparationServiceScript := preload("res://scripts/services/run_preparation_service.gd")
const RouteSetupServiceScript := preload("res://scripts/services/route_setup_service.gd")
const ScanActionServiceScript := preload("res://scripts/services/scan_action_service.gd")
const UpgradePurchaseFlowServiceScript := preload("res://scripts/services/upgrade_purchase_flow_service.gd")
const UpgradeEffectServiceScript := preload("res://scripts/services/upgrade_effect_service.gd")
const RoutePresenterScript := preload("res://scripts/ui/route_presenter.gd")
const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")
const HudUpdateServiceScript := preload("res://scripts/ui/hud_update_service.gd")
const VisualSmokeBridgeScript := preload("res://scripts/debug/visual_smoke_bridge.gd")
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
	"prompt": Rect2(Vector2(986.0, 300.0), Vector2(188.0, 16.0)),
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
const LATE_DAY_CARGO_WARNING_RATIO := 0.25

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
var night_health_recovery_used_build_time := false
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
