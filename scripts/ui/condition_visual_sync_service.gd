class_name ConditionVisualSyncService
extends RefCounted

const DiscoveryRevealSyncServiceScript := preload("res://scripts/ui/discovery_reveal_sync_service.gd")

static func sync_condition_visuals(host, condition_id: String, blackwater_signal_visible: bool) -> void:
	var rare_signal := rare_signal_emphasis_visible_for_condition(condition_id)
	_set_visible(_node2d(host, host.rare_signal_emphasis, "RareSignalEmphasis"), rare_signal)
	_set_visible(_node2d(host, host.shelf_glimmer_opportunity, "EastShelfSpur/ShelfGlimmerOpportunity"), shelf_glimmer_visible_for_condition(condition_id))
	_set_visible(_node2d(host, host.blue_chimney_signal_opportunity, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/BlueChimneySignalOpportunity"), blue_chimney_signal_visible_for_condition(condition_id))
	DiscoveryRevealSyncServiceScript.sync_blackwater_signal_opportunity(host, blackwater_signal_visible)
	sync_dusk_trench_condition_nudge(host, condition_id)
	sync_wide_chamber_condition_nudge(host, condition_id)
	sync_mirror_kelp_condition_nudge(host, condition_id)
	_sync_base_return_colors(host, condition_id == "calm_current")
	_sync_thermal_bloom_colors(host, condition_id == "thermal_bloom")
	sync_route_choice_condition_nudge(host, condition_id)

static func sync_route_choice_condition_nudge(host, condition_id: String) -> void:
	var decision_rib := _polygon(host, host.route_choice_decision_rib, "RouteChoiceBand/DecisionRib")
	var safe_bank_lane := _polygon(host, host.route_choice_safe_bank_lane, "RouteChoiceBand/SafeBankLane")
	var research_lane := _polygon(host, host.route_choice_research_lane, "RouteChoiceBand/ResearchLane")
	if decision_rib == null or safe_bank_lane == null or research_lane == null:
		return

	if condition_id == "rare_signal":
		decision_rib.color = Color(0.74, 0.92, 0.86, 0.24)
		safe_bank_lane.color = Color(0.46, 0.92, 0.64, 0.16)
		research_lane.color = Color(0.52, 0.96, 1.0, 0.28)
	else:
		decision_rib.color = Color(0.74, 0.92, 0.86, 0.18)
		safe_bank_lane.color = Color(0.46, 0.92, 0.64, 0.18)
		research_lane.color = Color(0.52, 0.96, 1.0, 0.2)

static func sync_dusk_trench_condition_nudge(host, condition_id: String) -> void:
	var veil := _polygon(host, host.dusk_low_visibility_veil, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/MurkVeil")
	var band := _polygon(host, host.dusk_low_visibility_band, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltPulseBand")
	var rib_a := _polygon(host, host.dusk_low_visibility_rib_a, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibA")
	var rib_b := _polygon(host, host.dusk_low_visibility_rib_b, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/LowVisibilityCue/SiltRibB")
	if veil == null or band == null or rib_a == null or rib_b == null:
		return

	var is_low_visibility := condition_id == "low_visibility"
	veil.color = Color(0.035, 0.055, 0.15, 0.32) if is_low_visibility else Color(0.035, 0.055, 0.15, 0.24)
	band.color = Color(0.12, 0.16, 0.34, 0.24) if is_low_visibility else Color(0.12, 0.16, 0.34, 0.17)
	rib_a.color = Color(0.36, 0.44, 0.78, 0.28) if is_low_visibility else Color(0.36, 0.44, 0.78, 0.2)
	rib_b.color = Color(0.32, 0.38, 0.7, 0.24) if is_low_visibility else Color(0.32, 0.38, 0.7, 0.16)

static func sync_wide_chamber_condition_nudge(host, condition_id: String) -> void:
	var return_main := _polygon(host, host.wide_chamber_return_main, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentBackToHollow")
	var return_far := _polygon(host, host.wide_chamber_return_far, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentFarRib")
	var return_mid := _polygon(host, host.wide_chamber_return_mid, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentMidChain")
	var return_entry := _polygon(host, host.wide_chamber_return_entry, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/ReturnCurrentEntryChain")
	if return_main == null or return_far == null or return_mid == null or return_entry == null:
		return

	var is_calm_current := condition_id == "calm_current"
	return_main.color = Color(0.66, 1.0, 0.88, 0.17) if is_calm_current else Color(0.66, 1.0, 0.88, 0.13)
	return_far.color = Color(0.82, 1.0, 0.92, 0.17) if is_calm_current else Color(0.82, 1.0, 0.92, 0.13)
	return_mid.color = Color(0.58, 1.0, 0.84, 0.14) if is_calm_current else Color(0.58, 1.0, 0.84, 0.1)
	return_entry.color = Color(0.62, 1.0, 0.86, 0.16) if is_calm_current else Color(0.62, 1.0, 0.86, 0.12)

static func sync_mirror_kelp_condition_nudge(host, condition_id: String) -> void:
	var backwater := _polygon(host, host.mirror_kelp_reflective_backwater, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/ReflectiveBackwater")
	var curtain_a := _polygon(host, host.mirror_kelp_curtain_a, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainA")
	var curtain_b := _polygon(host, host.mirror_kelp_curtain_b, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainB")
	var curtain_c := _polygon(host, host.mirror_kelp_curtain_c, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/MirrorKelpCurtainC")
	var wash := _polygon(host, host.mirror_kelp_bloom_approach_wash, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachWash")
	var rib := _polygon(host, host.mirror_kelp_bloom_approach_rib, "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/KelpBloomApproachRib")
	if backwater == null or curtain_a == null or curtain_b == null or curtain_c == null or wash == null or rib == null:
		return

	var is_kelp_bloom := condition_id == "kelp_bloom"
	wash.visible = is_kelp_bloom
	rib.visible = is_kelp_bloom
	backwater.color = Color(0.08, 0.36, 0.42, 0.18) if is_kelp_bloom else Color(0.08, 0.36, 0.42, 0.12)
	curtain_a.color = Color(0.42, 0.94, 0.82, 0.24) if is_kelp_bloom else Color(0.42, 0.94, 0.82, 0.17)
	curtain_b.color = Color(0.72, 0.96, 1.0, 0.21) if is_kelp_bloom else Color(0.72, 0.96, 1.0, 0.15)
	curtain_c.color = Color(0.36, 0.82, 0.72, 0.19) if is_kelp_bloom else Color(0.36, 0.82, 0.72, 0.13)
	wash.color = Color(0.4, 0.92, 0.76, 0.09)
	rib.color = Color(0.82, 1.0, 0.9, 0.12)

static func rare_signal_emphasis_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

static func shelf_glimmer_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

static func blue_chimney_signal_visible_for_condition(condition_id: String) -> bool:
	return condition_id == "rare_signal"

static func _sync_base_return_colors(host, is_calm_current: bool) -> void:
	_set_color(_polygon(host, host.base_return_column, "BaseReturnColumn"), Color(0.38, 1.0, 0.9, 0.18) if is_calm_current else Color(0.38, 1.0, 0.9, 0.14))
	_set_color(_polygon(host, host.base_return_rib_shallow, "BaseReturnRibShallow"), Color(0.62, 1.0, 0.9, 0.22) if is_calm_current else Color(0.62, 1.0, 0.9, 0.18))
	_set_color(_polygon(host, host.base_return_rib_midwater, "BaseReturnRibMidwater"), Color(0.62, 1.0, 0.9, 0.2) if is_calm_current else Color(0.62, 1.0, 0.9, 0.16))
	_set_color(_polygon(host, host.base_return_rib_deep, "BaseReturnRibDeep"), Color(0.62, 1.0, 0.9, 0.19) if is_calm_current else Color(0.62, 1.0, 0.9, 0.15))
	_set_color(_polygon(host, host.base_return_beacon, "BaseReturnBeacon"), Color(0.74, 1.0, 0.9, 0.42) if is_calm_current else Color(0.74, 1.0, 0.9, 0.34))
	_set_color(_polygon(host, host.base_return_beacon_rib, "BaseReturnBeaconRib"), Color(0.62, 1.0, 0.9, 0.26) if is_calm_current else Color(0.62, 1.0, 0.9, 0.2))

static func _sync_thermal_bloom_colors(host, is_thermal_bloom: bool) -> void:
	_set_color(_polygon(host, host.thermal_warm_wash, "ThermalVentPocket/Visuals/FallbackGeometry/WarmWash"), Color(0.98, 0.52, 0.18, 0.26) if is_thermal_bloom else Color(0.92, 0.44, 0.16, 0.18))
	_set_color(_polygon(host, host.thermal_heat_plume, "ThermalVentPocket/Visuals/FallbackGeometry/HeatPlume"), Color(1.0, 0.68, 0.24, 0.38) if is_thermal_bloom else Color(1.0, 0.62, 0.2, 0.28))
	_set_color(_polygon(host, host.thermal_bubble_string_a, "ThermalVentPocket/Visuals/FallbackGeometry/BubbleStringA"), Color(1.0, 1.0, 0.84, 0.46) if is_thermal_bloom else Color(0.96, 1.0, 0.82, 0.34))
	_set_color(_polygon(host, host.thermal_bubble_string_b, "ThermalVentPocket/Visuals/FallbackGeometry/BubbleStringB"), Color(1.0, 1.0, 0.84, 0.4) if is_thermal_bloom else Color(0.96, 1.0, 0.82, 0.28))
	_set_color(_polygon(host, host.thermal_vent_visual, "Discoveries/ThermalVent/FallbackVisual/Visual"), Color(1.0, 0.5, 0.18, 1.0) if is_thermal_bloom else Color(0.96, 0.46, 0.16, 0.9))
	_set_color(_polygon(host, host.thermal_vent_bubbles, "Discoveries/ThermalVent/FallbackVisual/Bubbles"), Color(0.98, 1.0, 0.86, 0.46) if is_thermal_bloom else Color(0.9, 1.0, 0.86, 0.34))

static func _node2d(host, node: Node2D, path: String) -> Node2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Node2D

static func _polygon(host, node: Polygon2D, path: String) -> Polygon2D:
	if node != null:
		return node
	return host.get_node_or_null(path) as Polygon2D

static func _set_visible(node: Node2D, visible: bool) -> void:
	if node != null:
		node.visible = visible

static func _set_color(node: Polygon2D, color: Color) -> void:
	if node != null:
		node.color = color
