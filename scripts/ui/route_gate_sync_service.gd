class_name RouteGateSyncService
extends RefCounted

const RoutePresenterScript := preload("res://scripts/ui/route_presenter.gd")

static func sync_pressure_lock(host) -> void:
	RoutePresenterScript.sync_pressure_lock_state(
		host.pressure_boundary,
		host.pressure_shimmer,
		host.pressure_gate_top,
		host.pressure_gate_bottom,
		host.pressure_gate_bar_a,
		host.pressure_gate_bar_b,
		host.pressure_gate_bar_c,
		host.pressure_gate_left_rail,
		host.pressure_gate_right_rail,
		host.pressure_lock_badge,
		host.pressure_label,
		host.progression_state.has_upgrade(host.PRESSURE_SEAL_UPGRADE_ID)
	)

static func sync_sealed_shelf_hatch(host) -> void:
	var echo_shimmer := _polygon(host, host.sealed_shelf_hatch_echo_shimmer, "EastShelfSpur/SealedShelfHatch/EchoShimmer")
	var lock_badge := _polygon(host, host.sealed_shelf_hatch_lock_badge, "EastShelfSpur/SealedShelfHatch/LockBadge")
	var lock_label := _label(host, host.sealed_shelf_hatch_lock_label, "EastShelfSpur/SealedShelfHatch/LockLabel")
	var seal_bars := _polygon(host, null, "EastShelfSpur/SealedShelfHatch/SealBars")
	RoutePresenterScript.sync_sealed_shelf_hatch_state(
		echo_shimmer,
		lock_badge,
		lock_label,
		seal_bars,
		host.progression_state.has_upgrade(host.RESONANCE_KEY_UPGRADE_ID),
		host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID)
	)

static func sync_salvage_pocket_open(host) -> void:
	var hatch := _polygon(host, host.salvage_hatch_panel, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SealedHatchPanel")
	var lock_bars := _polygon(host, host.salvage_lock_bars, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/LockBars")
	var glint := _polygon(host, host.salvage_glint, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/SalvageGlint")
	var tool_label := _label(host, host.salvage_tool_label, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/FutureCutterPort/ToolLabel")
	var promise_label := _label(host, host.salvage_promise_label, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/PromiseLabel")
	var opened_lane := _node2d(host, host.salvage_opened_pocket_lane, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane")
	RoutePresenterScript.sync_salvage_pocket_open_state(
		hatch,
		lock_bars,
		glint,
		tool_label,
		promise_label,
		opened_lane,
		host.progression_state.has_upgrade(host.SALVAGE_CUTTER_UPGRADE_ID)
	)

static func sync_blackwater_crack_gate(host) -> void:
	var mouth := _polygon(host, host.blackwater_crack_mouth, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/CrackMouth")
	var wash := _polygon(host, host.blackwater_pressure_wash, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/PressureDarkWash")
	var seal_lip := _polygon(host, host.blackwater_seal_lip, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/SealLip")
	var gate_badge := _polygon(host, host.blackwater_gate_badge, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateBadge")
	var gate_label := _label(host, host.blackwater_gate_label, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/GateLabel")
	var closed_shard := _polygon(host, host.blackwater_closed_shard, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/ClosedShard")
	var sill := _node2d(host, host.blackwater_sill, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill")
	var sill_return := _polygon(host, host.blackwater_sill_return_current, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/ReturnCurrentCue")
	RoutePresenterScript.sync_blackwater_crack_gate_state(
		mouth,
		wash,
		seal_lip,
		gate_badge,
		gate_label,
		closed_shard,
		sill,
		sill_return,
		host._blackwater_crack_gate_open(),
		host.progression_state.has_upgrade(host.ECHO_LENS_UPGRADE_ID)
	)

static func sync_wreck_echo(host) -> void:
	var route_available: bool = host._wreck_echo_route_available()
	var trigger := _area(host, host.wreck_echo_clue_trigger, "WreckEchoDescent/ClueTrigger")
	var wash := _polygon(host, host.wreck_echo_route_wash, "WreckEchoDescent/RouteWash")
	var rib_a := _polygon(host, host.wreck_echo_rib_a, "WreckEchoDescent/RibA")
	var rib_b := _polygon(host, host.wreck_echo_rib_b, "WreckEchoDescent/RibB")
	var clue_core := _polygon(host, host.wreck_echo_clue_core, "WreckEchoDescent/ClueTrigger/ClueCore")
	RoutePresenterScript.sync_wreck_echo_state(
		trigger,
		wash,
		rib_a,
		rib_b,
		clue_core,
		[
			host.wreck_echo_clue_marker_outer,
			host.wreck_echo_clue_marker_inner,
			host.wreck_echo_clue_marker_facet,
			host.wreck_echo_clue_marker_arc_a,
			host.wreck_echo_clue_marker_arc_b,
		],
		route_available,
		host.run_wreck_echo_clue_recovered
	)

static func _polygon(host, node: Polygon2D, path: String) -> Polygon2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Polygon2D

static func _label(host, node: Label, path: String) -> Label:
	if node != null:
		return node
	return host.get_node_or_null(path) as Label

static func _area(host, node: Area2D, path: String) -> Area2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Area2D

static func _node2d(host, node: Node2D, path: String) -> Node2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Node2D
