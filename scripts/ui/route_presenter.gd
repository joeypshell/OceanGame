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

static func sync_blackwater_trace_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.45, 0.78, 1.0, 0.08),
		Color(0.72, 0.98, 1.0, 0.18),
		Color(0.45, 0.78, 1.0, 0.32),
		Color(0.72, 0.98, 1.0, 0.82),
		Color(1.0, 1.0, 0.82, 0.9)
	)

static func sync_glass_kelp_reading_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.58, 1.0, 0.84, 0.07),
		Color(0.9, 1.0, 0.68, 0.16),
		Color(0.58, 1.0, 0.84, 0.42),
		Color(0.9, 1.0, 0.68, 0.88),
		Color(1.0, 1.0, 0.82, 0.9)
	)

static func sync_hollow_reef_reading_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.58, 1.0, 0.88, 0.07),
		Color(0.88, 1.0, 0.7, 0.16),
		Color(0.58, 1.0, 0.88, 0.36),
		Color(0.88, 1.0, 0.7, 0.84),
		Color(1.0, 1.0, 0.82, 0.9)
	)

static func sync_salvage_data_cache_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.42, 0.82, 1.0, 0.07),
		Color(0.72, 0.95, 1.0, 0.18),
		Color(0.42, 0.82, 1.0, 0.22),
		Color(0.72, 0.95, 1.0, 0.88),
		Color(0.9, 1.0, 1.0, 0.86)
	)

static func sync_salvage_manifest_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(1.0, 0.68, 0.28, 0.08),
		Color(1.0, 0.76, 0.34, 0.18),
		Color(1.0, 0.68, 0.28, 0.22),
		Color(1.0, 0.76, 0.34, 0.86),
		Color(1.0, 0.9, 0.5, 0.84)
	)

static func sync_tideglass_sample_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.38, 0.88, 1.0, 0.07),
		Color(0.72, 0.96, 1.0, 0.18),
		Color(0.38, 0.88, 1.0, 0.22),
		Color(0.72, 0.96, 1.0, 0.88),
		Color(0.9, 1.0, 1.0, 0.86)
	)

static func sync_outer_shelf_survey_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.48, 0.92, 1.0, 0.07),
		Color(0.78, 1.0, 0.96, 0.18),
		Color(0.48, 0.92, 1.0, 0.22),
		Color(0.78, 1.0, 0.96, 0.86),
		Color(0.95, 1.0, 0.9, 0.86)
	)

static func sync_rim_glass_reading_payoff(halo: Polygon2D, core: Polygon2D, spark: Polygon2D, recovered: bool) -> void:
	_sync_payoff_core(
		halo,
		core,
		spark,
		recovered,
		Color(0.74, 0.78, 1.0, 0.07),
		Color(0.96, 0.9, 1.0, 0.18),
		Color(0.74, 0.78, 1.0, 0.22),
		Color(0.96, 0.9, 1.0, 0.86),
		Color(1.0, 0.98, 1.0, 0.86)
	)

static func _sync_payoff_core(
	halo: Polygon2D,
	core: Polygon2D,
	spark: Polygon2D,
	recovered: bool,
	recovered_halo_color: Color,
	recovered_core_color: Color,
	active_halo_color: Color,
	active_core_color: Color,
	active_spark_color: Color
) -> void:
	if halo == null or core == null or spark == null:
		return

	if recovered:
		halo.color = recovered_halo_color
		core.color = recovered_core_color
		spark.visible = false
	else:
		halo.color = active_halo_color
		core.color = active_core_color
		spark.color = active_spark_color
		spark.visible = true
