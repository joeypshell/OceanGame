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

static func sync_sealed_shelf_hatch_state(
	echo_shimmer: Polygon2D,
	lock_badge: Polygon2D,
	lock_label: Label,
	seal_bars: Polygon2D,
	has_resonance_key: bool,
	has_echo_lens: bool
) -> void:
	if echo_shimmer == null or lock_badge == null or lock_label == null:
		return

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

static func sync_salvage_pocket_open_state(
	hatch: Polygon2D,
	lock_bars: Polygon2D,
	glint: Polygon2D,
	tool_label: Label,
	promise_label: Label,
	opened_lane: Node2D,
	cutter_owned: bool
) -> void:
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

static func sync_blackwater_crack_gate_state(
	mouth: Polygon2D,
	wash: Polygon2D,
	seal_lip: Polygon2D,
	gate_badge: Polygon2D,
	gate_label: Label,
	closed_shard: Polygon2D,
	sill: Node2D,
	sill_return: Polygon2D,
	gate_open: bool,
	has_echo_lens: bool
) -> void:
	if mouth == null or wash == null or seal_lip == null or gate_badge == null or gate_label == null or closed_shard == null:
		return

	if gate_open:
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
	elif has_echo_lens:
		mouth.color = Color(0.002, 0.01, 0.026, 0.62)
		wash.color = Color(0.08, 0.16, 0.32, 0.2)
		seal_lip.color = Color(0.38, 0.58, 0.74, 0.28)
		gate_badge.color = Color(0.62, 0.86, 1.0, 0.58)
		gate_label.text = "KEY NEEDED"
		closed_shard.color = Color(0.54, 0.78, 0.92, 0.3)
		if sill != null:
			sill.visible = false
	else:
		mouth.color = Color(0.002, 0.01, 0.026, 0.64)
		wash.color = Color(0.08, 0.16, 0.32, 0.2)
		seal_lip.color = Color(0.38, 0.58, 0.74, 0.24)
		gate_badge.color = Color(0.38, 0.58, 0.74, 0.5)
		gate_label.text = "RESONANCE SEAL"
		closed_shard.color = Color(0.54, 0.78, 0.92, 0.28)
		if sill != null:
			sill.visible = false

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
