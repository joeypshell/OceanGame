class_name MainSceneBaseContext
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
