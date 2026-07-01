class_name MinimapService
extends RefCounted

static func update_minimap(host, is_visible: bool) -> void:
	host.minimap_path.visible = is_visible
	host.minimap_player_marker.visible = is_visible
	if not is_visible:
		return

	var depth_ratio := clampf(host.dive_session.current_depth / host.DEPTH_RAIL_MAX_DISPLAY_DEPTH, 0.0, 1.0)
	var horizontal_ratio := 0.5
	if host.player != null:
		var bounds: Rect2 = host.player.get("world_bounds")
		horizontal_ratio = clampf((host.player.global_position.x - bounds.position.x) / bounds.size.x, 0.0, 1.0)
	host.minimap_player_marker.position = Vector2(94.0 + (horizontal_ratio - 0.5) * 78.0, 34.0 + depth_ratio * 76.0)
