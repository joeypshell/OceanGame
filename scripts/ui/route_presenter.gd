class_name RoutePresenter
extends RefCounted

static func sync_wreck_echo_state(
	trigger: Area2D,
	wash: Polygon2D,
	rib_a: Polygon2D,
	rib_b: Polygon2D,
	clue_core: Polygon2D,
	marker_nodes: Array[Polygon2D],
	route_available: bool,
	clue_recovered: bool
) -> void:
	if trigger != null:
		trigger.visible = route_available
		trigger.monitoring = route_available and not clue_recovered
		trigger.monitorable = route_available
	if wash != null:
		wash.color = Color(0.54, 0.86, 1.0, 0.07 if route_available else 0.035)
	if rib_a != null:
		rib_a.color = Color(0.78, 0.9, 1.0, 0.12 if route_available else 0.055)
	if rib_b != null:
		rib_b.color = Color(0.78, 0.9, 1.0, 0.1 if route_available else 0.05)
	if clue_core != null:
		clue_core.visible = route_available
		clue_core.color = Color(0.82, 0.96, 1.0, 0.06) if clue_recovered else Color(0.82, 0.96, 1.0, 0.1)

	sync_wreck_echo_clue_marker(marker_nodes, route_available, clue_recovered)

static func sync_wreck_echo_clue_marker(marker_nodes: Array[Polygon2D], route_available: bool, clue_recovered: bool) -> void:
	var marker_colors: Array[Color] = [
		Color(0.62, 0.86, 1.0, 0.06) if clue_recovered else Color(0.62, 0.86, 1.0, 0.12),
		Color(0.82, 0.96, 1.0, 0.12) if clue_recovered else Color(0.82, 0.96, 1.0, 0.24),
		Color(0.94, 1.0, 1.0, 0.26) if clue_recovered else Color(0.94, 1.0, 1.0, 0.5),
		Color(0.7, 0.94, 1.0, 0.08) if clue_recovered else Color(0.7, 0.94, 1.0, 0.18),
		Color(0.7, 0.94, 1.0, 0.08) if clue_recovered else Color(0.7, 0.94, 1.0, 0.18),
	]
	for index in marker_nodes.size():
		var marker_node := marker_nodes[index]
		if marker_node != null:
			marker_node.visible = route_available
			marker_node.color = marker_colors[index]
