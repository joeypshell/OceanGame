class_name VisualSmokeBridge
extends RefCounted

const ScanTargetFeedbackServiceScript := preload("res://scripts/ui/scan_target_feedback_service.gd")

static func consume_command(host) -> void:
	if not OS.has_feature("web"):
		return

	var command = JavaScriptBridge.eval("window.__oceangameDebugCommand || ''", true)
	if typeof(command) != TYPE_STRING or String(command).is_empty():
		return

	JavaScriptBridge.eval("window.__oceangameDebugCommand = '';", true)
	match String(command):
		"oxygen_low":
			host._stage_debug_oxygen_visual_review(0.20, "low")
		"oxygen_critical":
			host._stage_debug_oxygen_visual_review(0.08, "critical")
		"health_damage":
			host._stage_debug_health_damage_visual_review()
		"health_damage_extracted":
			host._stage_debug_health_damage_extraction_visual_review()
		"daylight_morning":
			host._stage_debug_daylight_visual_review(0.15, "morning")
		"daylight_evening":
			host._stage_debug_daylight_visual_review(0.75, "evening")
		"daylight_cargo_warning":
			host._stage_debug_daylight_cargo_warning_visual_review()
		"daylight_nightfall":
			host._stage_debug_daylight_visual_review(1.0, "nightfall")
		"surface_oxygen_refill":
			host._stage_debug_surface_oxygen_refill_visual_review()
		"ship_offload":
			host._stage_debug_ship_offload_visual_review()
		"area01_surface_entry":
			host._stage_debug_area01_shell_visual_review("surface_entry")
		"area01_left_shelf_cave":
			host._stage_debug_area01_shell_visual_review("left_shelf_cave")
		"area01_right_shelf_pocket":
			host._stage_debug_area01_shell_visual_review("right_shelf_pocket")
		"area01_west_chamber":
			host._stage_debug_area01_shell_visual_review("west_chamber")
		"area01_right_chamber":
			host._stage_debug_area01_shell_visual_review("right_chamber")
		"area01_deep_spine":
			host._stage_debug_area01_shell_visual_review("deep_spine")
		"area01_future_exit":
			host._stage_debug_area01_shell_visual_review("future_exit")
		"area01_central_drop":
			host._stage_debug_area01_shell_visual_review("central_drop")
		"expanded_east_shelf_route":
			host._stage_debug_expanded_route_visual_review()
		"east_shelf_pocket_ping":
			host._stage_debug_east_shelf_pocket_visual_review()
		"lower_connector":
			host._stage_debug_lower_connector_visual_review()
		"blue_chimney_pocket":
			host._stage_debug_blue_chimney_pocket_visual_review()
		"blue_chimney_payoff":
			host._stage_debug_blue_chimney_payoff_visual_review()
		"silt_vein_fork":
			host._stage_debug_silt_vein_fork_visual_review()
		"blackwater_route":
			host._stage_debug_blackwater_route_visual_review()
		"dusk_trench_route":
			host._stage_debug_dusk_trench_route_visual_review()
		"dusk_trench_payoff":
			host._stage_debug_dusk_trench_payoff_visual_review(false)
		"dusk_trench_payoff_recovered":
			host._stage_debug_dusk_trench_payoff_visual_review(true)
		"hollow_reef_route":
			host._stage_debug_hollow_reef_route_visual_review()
		"hollow_reef_payoff":
			host._stage_debug_hollow_reef_payoff_visual_review(false)
		"hollow_reef_return":
			host._stage_debug_hollow_reef_payoff_visual_review(true)
		"wide_reef_chamber":
			host._stage_debug_wide_chamber_visual_review()
		"wide_reef_salvage_open":
			host._stage_debug_wide_chamber_visual_review(true)
		"mirror_kelp_pass":
			host._stage_debug_mirror_kelp_visual_review()
		"mirror_kelp_tideglass":
			host._stage_debug_mirror_kelp_visual_review(true)
		"mirror_kelp_mirrorfin":
			host._stage_debug_mirror_kelp_visual_review(false, true)
		"outer_shelf_survey":
			host._stage_debug_outer_shelf_visual_review()
		"open_hatch_resonance_alcove":
			host._stage_debug_open_hatch_alcove_visual_review()

static func publish_state(host) -> void:
	if not OS.has_feature("web"):
		return

	var state := build_state(host)
	JavaScriptBridge.eval("window.__oceangameVisualState = %s;" % JSON.stringify(state), true)

static func build_state(host) -> Dictionary:
	var state := {
		"result": String(host.DIVE_RESULT_NAMES.get(host.dive_session.result, "unknown")),
		"surface_tab": host.SURFACE_TAB_NAMES[host.surface_tab_index].to_lower(),
		"debug_telemetry": host.show_debug_telemetry,
		"area01_source_map_overlay": host.area01_visual_director != null and host.area01_visual_director.source_map_overlay_visible(),
		"oxygen_state": host.HudPresenterScript.oxygen_state(host.dive_session.oxygen, host.dive_session.max_oxygen),
		"oxygen": ceili(host.dive_session.oxygen),
		"max_oxygen": ceili(host.dive_session.max_oxygen),
		"health_state": host.HudPresenterScript.health_state(host.dive_session.health, host.dive_session.max_health),
		"health": ceili(host.dive_session.health),
		"max_health": ceili(host.dive_session.max_health),
		"health_damage_events": host.run_health_damage_events,
		"last_health_damage_source": host.last_health_damage_source,
		"last_health_damage_amount": ceili(host.last_health_damage_amount),
		"depth_meters": roundi(host.dive_session.current_depth),
		"best_depth_meters": roundi(host.progression_state.best_depth_reached),
		"daylight_visible": host.daylight_panel.visible,
		"daylight_remaining_percent": roundi(host._daylight_remaining_ratio() * 100.0),
		"daylight_remaining_seconds": ceili(host._daylight_remaining_seconds()),
		"ship_offload_count": host.daylight_ship_offload_count,
		"player_in_surface_oxygen_refill": host._is_player_in_surface_oxygen_refill(),
		"surface_oxygen_refill_active": host._surface_oxygen_refill_active(),
		"cargo_count": host.dive_session.current_cargo.size(),
		"cargo_limit": host.dive_session.cargo_limit,
		"player_in_base": host.player_in_base,
		"has_left_base": host.dive_session.has_left_base,
		"run_panel_visible": host.run_panel.visible,
		"upgrade_panel_visible": host.upgrade_panel.visible,
		"active_stats_visible": host.active_stats_panel.visible,
		"status_text": host.status_label.text if host.status_label != null else "",
		"prompt_text": host.prompt_label.text if host.prompt_label != null else "",
		"objective_text": host.objective_line_label.text if host.objective_line_label != null else "",
		"cargo_text": host.cargo_label.text if host.cargo_label != null else "",
		"health_damage_status_visible": host.status_label != null and host.status_label.text.contains("O2 unchanged") and host.status_label.text.contains("health"),
		"health_damage_prompt_visible": host.prompt_label != null and host.prompt_label.text.to_lower().contains("o2 only"),
		"health_damage_objective_visible": host.objective_line_label != null and host.objective_line_label.text.contains("Health hit"),
		"health_recovery_copy_visible": host.run_summary_label != null and host.run_summary_label.text.contains("no surface heal"),
		"late_day_cargo_warning_visible": host._visual_late_day_cargo_warning_visible(),
		"dawn_priority_visible": host.run_summary_label != null and host.run_summary_label.text.contains("Day priority:"),
		"night_build_choice_visible": host.run_summary_label != null and host.run_summary_label.text.contains("Build choice:"),
		"night_tomorrow_plan_visible": host.run_summary_label != null and host.run_summary_label.text.contains("Next: press"),
		"starter_resource_target_visible": host.run_summary_label != null and host.run_summary_label.text.contains("Shell Reef pockets"),
		"recent_survival_memory_visible": host.surface_tab_index == host.SURFACE_TAB_LOG and host.run_summary_label != null and host.run_summary_label.text.contains("survival "),
		"upgrade_feedback_next_plan_visible": host.upgrade_menu_feedback_label != null and host.upgrade_menu_feedback_label.text.contains("Next:"),
		"status_debug_copy": host.status_label != null and host.status_label.text.to_lower().contains("debug"),
		"touch_controls_visible": host.mobile_touch_controls != null and host.mobile_touch_controls.visible,
		"wreck_echo_clue_recovered": host.run_wreck_echo_clue_recovered,
		"east_shelf_pocket_ping_recovered": host.run_east_shelf_pocket_ping_recovered,
		"lower_connector_echo_recovered": host.run_lower_connector_echo_recovered,
		"resonance_alcove_research_recovered": host.run_resonance_alcove_research_recovered,
		"blue_chimney_draft_reading_recovered": host.run_blue_chimney_draft_reading_recovered,
		"lantern_silt_sample_recovered": host.run_lantern_silt_sample_recovered,
		"blackwater_trace_recovered": host.run_blackwater_trace_recovered,
		"dusk_trench_reached": host.run_reached_dusk_trench,
		"glass_kelp_reading_recovered": host.run_glass_kelp_reading_recovered,
		"hollow_reef_reading_recovered": host.run_hollow_reef_reading_recovered,
		"salvage_manifest_recovered": host.run_salvage_manifest_recovered,
		"outer_shelf_survey_recovered": host.run_outer_shelf_survey_recovered,
		"rim_glass_reading_recovered": host.run_rim_glass_reading_recovered,
		"tideglass_sample_recovered": host.run_tideglass_sample_recovered,
		"mirrorfin_drift_observed": host.run_completed_scans.has("mirrorfin_drift"),
		"salvage_pocket_open": host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID),
		"route_stage": host.visual_smoke_route_stage,
	}
	var area01_cue_report: Dictionary = host._ensure_area01_visual_director().cue_debug_report(host, area01_camera_region(host))
	state["area01_cue_family_counts"] = area01_cue_report.get("families", {})
	state["area01_cue_family_warnings"] = area01_cue_report.get("warnings", [])
	state["area01_capture_camera"] = host._area01_overlay_camera_state()
	var player_smoke_state := player_state(host)
	state["player_visual_state"] = player_smoke_state
	state["player_rendered"] = player_rendered(player_smoke_state)
	state["player_on_screen"] = player_on_screen(host, player_smoke_state)
	var area01_wall := host.get_node_or_null("Area01ArtSlice/TerrainBackWalls/BlockoutEastReefMass") as Polygon2D
	var area01_lip := host.get_node_or_null("Area01ArtSlice/TerrainVisualEdges/CollisionReadBoundaries/BlockoutEastReefLip") as Polygon2D
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
	return state

static func player_rendered(player_state: Dictionary) -> bool:
	return (
		bool(player_state.get("available", false))
		and bool(player_state.get("player_visible", false))
		and bool(player_state.get("visual_root_visible", false))
		and bool(player_state.get("sprite_visible", false))
		and bool(player_state.get("sprite_has_texture", false))
		and float(player_state.get("sprite_alpha", 0.0)) > 0.25
	)

static func player_on_screen(host, player_state: Dictionary) -> bool:
	if not player_rendered(player_state):
		return false

	var viewport_size: Vector2 = host.get_viewport_rect().size
	var screen_position := Vector2(
		float(player_state.get("screen_x", -99999.0)),
		float(player_state.get("screen_y", -99999.0))
	)
	return Rect2(Vector2.ZERO, viewport_size).has_point(screen_position)

static func player_state(host) -> Dictionary:
	if host.player == null:
		return {"available": false}

	var visual_root := host.player.get_node_or_null("VisualRoot") as CanvasItem
	var sprite := host.player.get_node_or_null("VisualRoot/SubSpriteAnchor/SubSprite") as Sprite2D
	var screen_position: Vector2 = ScanTargetFeedbackServiceScript.scan_reticle_screen_position(host, host.player.global_position)
	var player_canvas := host.player as CanvasItem
	var sprite_region := Rect2()
	var sprite_alpha := 0.0
	var sprite_has_texture := false
	if sprite != null:
		sprite_region = sprite.region_rect
		sprite_alpha = sprite.modulate.a
		sprite_has_texture = sprite.texture != null

	return {
		"available": true,
		"world_x": roundi(host.player.global_position.x),
		"world_y": roundi(host.player.global_position.y),
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
		"visual_effective_z": host._effective_canvas_z(visual_root),
	}

static func area01_camera_region(host) -> Rect2:
	var visible_rect: Rect2 = host.get_viewport_rect()
	var top_left: Vector2 = host.get_canvas_transform().affine_inverse() * visible_rect.position
	var bottom_right: Vector2 = host.get_canvas_transform().affine_inverse() * visible_rect.end
	return Rect2(top_left, bottom_right - top_left).abs()
