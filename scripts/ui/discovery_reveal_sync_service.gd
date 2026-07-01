class_name DiscoveryRevealSyncService
extends RefCounted

static func sync_blackwater_signal_opportunity(host, visible: bool) -> void:
	var opportunity := _node2d(host, host.blackwater_signal_opportunity, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity")
	var wash := _polygon(host, host.blackwater_signal_wash, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalWash")
	var fleck := _polygon(host, host.blackwater_signal_fleck, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/BlackwaterSignalOpportunity/SignalFleck")
	if opportunity == null or wash == null or fleck == null:
		return

	opportunity.visible = visible
	wash.color = Color(0.54, 0.72, 1.0, 0.08)
	fleck.color = Color(0.82, 0.94, 1.0, 0.32)

static func reveal_thermal_vent_route(host) -> void:
	var route_hint := _node2d(host, host.vent_route_hint, "VentRouteHint")
	if route_hint != null:
		route_hint.visible = true

static func set_hidden_glow_plankton_active(host, active: bool) -> void:
	var glow_pickup := _node(host, host.hidden_glow_plankton, "ResourcePickups/HiddenGlowPlankton")
	if glow_pickup == null:
		return

	glow_pickup.visible = active
	glow_pickup.set("monitoring", active)

static func reveal_pressure_wreck_signal(host) -> void:
	var signal_hint := _node2d(host, host.wreck_signal_hint, "WreckSignalHint")
	if signal_hint != null:
		signal_hint.visible = true

static func _node(host, node: Node, path: String) -> Node:
	if node != null:
		return node
	return host.get_node_or_null(path)

static func _node2d(host, node: Node2D, path: String) -> Node2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Node2D

static func _polygon(host, node: Polygon2D, path: String) -> Polygon2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Polygon2D
