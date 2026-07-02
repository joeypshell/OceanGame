class_name RouteTimingCueService
extends RefCounted

const RouteTimingCuePresenterScript := preload("res://scripts/ui/route_timing_cue_presenter.gd")


static func update_east_shelf_current_surge(host, delta: float) -> void:
	host.east_shelf_current_surge_timer = fposmod(host.east_shelf_current_surge_timer + delta, host.EAST_SHELF_SURGE_PERIOD_SECONDS)
	var surge_alpha := RouteTimingCuePresenterScript.east_shelf_current_surge_alpha(host.east_shelf_current_surge_timer, host.EAST_SHELF_SURGE_PERIOD_SECONDS)
	if host.east_shelf_current_surge_lane != null:
		host.east_shelf_current_surge_lane.color = Color(0.66, 0.96, 1.0, surge_alpha)
	if host.east_shelf_current_surge_rib != null:
		host.east_shelf_current_surge_rib.color = Color(0.9, 1.0, 0.94, surge_alpha + 0.06)


static func update_blue_chimney_reverse_draft(host, delta: float) -> void:
	host.blue_chimney_draft_timer = fposmod(host.blue_chimney_draft_timer + delta, host.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)
	if host.blue_chimney_reverse_draft != null:
		host.blue_chimney_reverse_draft.color = Color(
			0.72,
			1.0,
			0.94,
			RouteTimingCuePresenterScript.blue_chimney_reverse_draft_alpha(host.blue_chimney_draft_timer, host.BLUE_CHIMNEY_DRAFT_PERIOD_SECONDS)
		)


static func update_blackwater_pressure_cue(host, delta: float) -> void:
	host.blackwater_pressure_timer = fposmod(host.blackwater_pressure_timer + delta, host.BLACKWATER_PRESSURE_PERIOD_SECONDS)
	var shutter_alpha := RouteTimingCuePresenterScript.blackwater_pressure_cue_alpha(host.blackwater_pressure_timer, host.BLACKWATER_PRESSURE_PERIOD_SECONDS)
	if host.blackwater_pressure_shutter != null:
		host.blackwater_pressure_shutter.color = Color(0.2, 0.12, 0.42, shutter_alpha)
	if host.blackwater_pressure_rib_a != null:
		host.blackwater_pressure_rib_a.color = Color(0.72, 0.52, 1.0, shutter_alpha + 0.04)
	if host.blackwater_pressure_rib_b != null:
		host.blackwater_pressure_rib_b.color = Color(0.72, 0.52, 1.0, shutter_alpha + 0.02)


static func update_lantern_ray_timing_lane(host, delta: float) -> void:
	var upper := _cached_polygon(host, "lantern_ray_timing_lane_upper", "Creatures/LanternRayRoute/TimingLane/TimingLaneUpper")
	var lower := _cached_polygon(host, "lantern_ray_timing_lane_lower", "Creatures/LanternRayRoute/TimingLane/TimingLaneLower")
	var tick_a := _cached_polygon(host, "lantern_ray_timing_tick_a", "Creatures/LanternRayRoute/TimingLane/TimingTickA")
	var tick_b := _cached_polygon(host, "lantern_ray_timing_tick_b", "Creatures/LanternRayRoute/TimingLane/TimingTickB")

	host.lantern_ray_timing_timer = fposmod(host.lantern_ray_timing_timer + delta, host.LANTERN_RAY_TIMING_PERIOD_SECONDS)
	var lane_alpha := RouteTimingCuePresenterScript.lantern_ray_timing_lane_alpha(host.lantern_ray_timing_timer, host.LANTERN_RAY_TIMING_PERIOD_SECONDS)
	var lower_alpha := maxf(0.06, lane_alpha - 0.04)
	var tick_alpha := lane_alpha + 0.06
	if upper != null:
		upper.color = Color(0.9, 0.82, 1.0, lane_alpha)
	if lower != null:
		lower.color = Color(0.9, 0.82, 1.0, lower_alpha)
	if tick_a != null:
		tick_a.color = Color(0.98, 0.94, 1.0, tick_alpha)
	if tick_b != null:
		tick_b.color = Color(0.98, 0.94, 1.0, maxf(0.1, tick_alpha - 0.04))


static func update_hollow_reef_timing_current(host, delta: float) -> void:
	var upper := _cached_polygon(host, "hollow_reef_timing_ribbon_upper", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonUpper")
	var lower := _cached_polygon(host, "hollow_reef_timing_ribbon_lower", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingRibbonLower")
	var tick_a := _cached_polygon(host, "hollow_reef_timing_tick_a", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickA")
	var tick_b := _cached_polygon(host, "hollow_reef_timing_tick_b", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/InteriorLane/TimingCurrentCue/TimingTickB")

	host.hollow_reef_timing_timer = fposmod(host.hollow_reef_timing_timer + delta, host.HOLLOW_REEF_TIMING_PERIOD_SECONDS)
	var cue_alpha := RouteTimingCuePresenterScript.hollow_reef_timing_current_alpha(host.hollow_reef_timing_timer, host.HOLLOW_REEF_TIMING_PERIOD_SECONDS)
	if upper != null:
		upper.color = Color(0.86, 0.78, 1.0, cue_alpha)
	if lower != null:
		lower.color = Color(0.86, 0.78, 1.0, maxf(0.06, cue_alpha - 0.035))
	if tick_a != null:
		tick_a.color = Color(0.98, 0.94, 1.0, cue_alpha + 0.05)
	if tick_b != null:
		tick_b.color = Color(0.98, 0.94, 1.0, maxf(0.1, cue_alpha + 0.02))


static func update_glassfin_swarm_spacing_cue(host, delta: float) -> void:
	var wake := _cached_polygon(host, "glassfin_swarm_spacing_wake", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWake")
	var window := _cached_polygon(host, "glassfin_swarm_spacing_window", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingWindowPulse")
	var tick_a := _cached_polygon(host, "glassfin_swarm_spacing_tick_a", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickA")
	var tick_b := _cached_polygon(host, "glassfin_swarm_spacing_tick_b", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/GlassfinSwarm/SpacingTickB")

	host.glassfin_swarm_spacing_timer = fposmod(host.glassfin_swarm_spacing_timer + delta, host.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)
	var cue_alpha := RouteTimingCuePresenterScript.glassfin_swarm_spacing_alpha(host.glassfin_swarm_spacing_timer, host.GLASSFIN_SWARM_SPACING_PERIOD_SECONDS)
	if wake != null:
		wake.color = Color(0.72, 0.86, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.72, 0.74, 1.0, minf(0.18, cue_alpha + 0.025))
	if tick_a != null:
		tick_a.color = Color(0.9, 0.92, 1.0, minf(0.24, cue_alpha + 0.08))
	if tick_b != null:
		tick_b.color = Color(0.9, 0.92, 1.0, minf(0.2, cue_alpha + 0.05))


static func update_salvage_silt_timing_cue(host, delta: float) -> void:
	var wake := _cached_polygon(host, "salvage_silt_wake", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWake")
	var window := _cached_polygon(host, "salvage_silt_window", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingWindow")
	var tick_a := _cached_polygon(host, "salvage_silt_tick_a", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickA")
	var tick_b := _cached_polygon(host, "salvage_silt_tick_b", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/WreckSalvagePocketEntrance/OpenedPocketLane/SiltTimingTickB")

	host.salvage_silt_timing_timer = fposmod(host.salvage_silt_timing_timer + delta, host.SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	var cue_alpha := RouteTimingCuePresenterScript.salvage_silt_timing_alpha(host.salvage_silt_timing_timer, host.SALVAGE_SILT_TIMING_PERIOD_SECONDS)
	if wake != null:
		wake.color = Color(0.74, 0.68, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.92, 0.82, 1.0, minf(0.16, cue_alpha + 0.035))
	if tick_a != null:
		tick_a.color = Color(0.98, 0.9, 1.0, minf(0.22, cue_alpha + 0.075))
	if tick_b != null:
		tick_b.color = Color(0.98, 0.9, 1.0, minf(0.19, cue_alpha + 0.045))


static func update_outer_shelf_slackwater_timing_cue(host, delta: float) -> void:
	var wake := _cached_polygon(host, "outer_shelf_slackwater_wake", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTimingWake")
	var window := _cached_polygon(host, "outer_shelf_slackwater_window", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterWindow")
	var tick_a := _cached_polygon(host, "outer_shelf_slackwater_tick_a", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickA")
	var tick_b := _cached_polygon(host, "outer_shelf_slackwater_tick_b", "EastShelfSpur/ShelfDropConnector/BlueChimneyPocket/SiltVeinFork/BlackwaterCrack/BlackwaterSill/DuskTrench/HollowReefCave/WideReefChamber/MirrorKelpPass/OuterShelfReach/GlassRimCutBranch/SlackwaterTickB")

	host.outer_shelf_slackwater_timer = fposmod(host.outer_shelf_slackwater_timer + delta, host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var cue_alpha := RouteTimingCuePresenterScript.outer_shelf_slackwater_alpha(host.outer_shelf_slackwater_timer, host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var window_ratio := RouteTimingCuePresenterScript.outer_shelf_slackwater_window_ratio(host.outer_shelf_slackwater_timer, host.OUTER_SHELF_SLACKWATER_PERIOD_SECONDS)
	var tick_a_alpha := 0.09 + window_ratio * 0.13
	var tick_b_alpha := 0.22 - window_ratio * 0.08
	if wake != null:
		wake.color = Color(0.7, 0.67 + window_ratio * 0.08, 1.0, cue_alpha)
	if window != null:
		window.color = Color(0.9 + window_ratio * 0.08, 0.68 + window_ratio * 0.04, 1.0, minf(0.2, cue_alpha + 0.05))
	if tick_a != null:
		tick_a.color = Color(1.0, 0.84, 0.98, tick_a_alpha)
	if tick_b != null:
		tick_b.color = Color(0.9, 0.78, 1.0, tick_b_alpha)


static func _cached_polygon(host, property_name: String, path: String) -> Polygon2D:
	var node := host.get(property_name) as Polygon2D
	if node == null:
		node = host.get_node_or_null(path) as Polygon2D
		host.set(property_name, node)
	return node
