class_name DepthRailService
extends RefCounted

static func update_rail(host, is_visible: bool) -> void:
	host.depth_rail_line.visible = is_visible
	host.depth_rail_marker.visible = is_visible
	for label in host.depth_rail_labels:
		label.visible = is_visible

	if not is_visible:
		return

	host.depth_rail_labels[0].text = "0m"
	host.depth_rail_labels[1].text = "50m"
	host.depth_rail_labels[2].text = "100m"
	var ratio := clampf(host.dive_session.current_depth / host.DEPTH_RAIL_MAX_DISPLAY_DEPTH, 0.0, 1.0)
	host.depth_rail_marker.position = Vector2(
		host.DEPTH_RAIL_LINE_RECT.position.x + 1.0,
		host.DEPTH_RAIL_LINE_RECT.position.y + host.DEPTH_RAIL_LINE_RECT.size.y * ratio
	)
