class_name Area01VisualStagingService
extends RefCounted

static func stage_shell_visual_review(host, stage: String) -> void:
	if not OS.has_feature("web"):
		return

	var staged_player = host.player
	if staged_player == null:
		staged_player = host.get_node_or_null("Player") as CharacterBody2D
	if staged_player == null:
		return

	var target_position := Vector2(720.0, 940.0)
	var status := player_status_for_stage(stage)
	match stage:
		"surface_entry":
			var supply_cache := host.get_node_or_null("SurvivalSupplyCache") as Node2D
			if supply_cache != null:
				target_position = supply_cache.global_position + Vector2(220.0, -10.0)
			else:
				target_position = Vector2(714.0, 428.0)
		"left_shelf_cave":
			var left_cave := host.get_node_or_null("Area01ArtSlice/GameplayObjects/LeftCaveResourcePocket") as Node2D
			if left_cave != null:
				target_position = left_cave.global_position + Vector2(30.0, -48.0)
			else:
				target_position = Vector2(386.0, 956.0)
		"right_shelf_pocket":
			var right_shelf := host.get_node_or_null("Area01ArtSlice/GameplayObjects/RightShelfResourcePocket") as Node2D
			if right_shelf != null:
				target_position = right_shelf.global_position + Vector2(-70.0, -64.0)
			else:
				target_position = Vector2(1014.0, 786.0)
		"west_chamber":
			target_position = Vector2(-360.0, 870.0)
		"right_chamber":
			var right_chamber := host.get_node_or_null("Area01ArtSlice/GameplayObjects/RightChamberResourcePocket") as Node2D
			if right_chamber != null:
				target_position = right_chamber.global_position + Vector2(-60.0, -58.0)
			else:
				target_position = Vector2(3000.0, 820.0)
		"deep_spine":
			target_position = generated_hook_visual_center(host, "BlueChimneyReturnCurrentArea", Vector2(2208.0, 2304.0))
		"future_exit":
			target_position = generated_hook_visual_center(host, "FutureDeepExitGateArea", Vector2(5568.0, 3040.0))
		"central_drop":
			target_position = Vector2(720.0, 940.0)
		_:
			return

	if host.dive_session.result == host.DiveSessionScript.Result.READY:
		host.dive_session.start()
	if host.dive_session.result != host.DiveSessionScript.Result.DIVING:
		return

	host.player = staged_player
	host.player.global_position = target_position
	host.player.velocity = Vector2.ZERO
	host.player_in_base = false
	host.dive_session.has_left_base = true
	host.dive_session.oxygen = host.dive_session.max_oxygen
	host.visual_smoke_route_stage = "area01_%s" % stage
	host.status_label.text = status
	host._update_depth()
	host._update_hud()

static func player_status_for_stage(stage: String) -> String:
	match stage:
		"surface_entry":
			return "Surface entry: open water above, ship banks cargo."
		"left_shelf_cave":
			return "Left shelf: collect supplies, keep the cave return."
		"right_shelf_pocket":
			return "Right shelf: cargo pocket, watch oxygen."
		"west_chamber":
			return "West chamber: scan or collect, then return."
		"right_chamber":
			return "Right chamber: scan target nearby."
		"deep_spine":
			return "Deep spine: follow return current up-left."
		"future_exit":
			return "Future exit sealed: mark it, return safely."
		"central_drop":
			return "Central drop: descend, save O2 for return."
		_:
			return "Explore Area 01, then return to ship."

static func generated_hook_visual_center(host, area_name: String, fallback: Vector2) -> Vector2:
	var area := host.get_node_or_null("Area01ArtSlice/RuntimeSourceHooks/%s" % area_name) as Area2D
	if area == null:
		return fallback
	for child in area.get_children():
		if child is Node2D and String(child.name).ends_with("VisualCue"):
			return (child as Node2D).global_position
	return fallback
