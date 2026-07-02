class_name DiscoveryNamePresenter
extends RefCounted

static func display_name(progression_state, discovery_id: String) -> String:
	if discovery_id.is_empty():
		return "none"

	var discovery: Dictionary = progression_state.scan_discoveries.get(discovery_id, {})
	if not discovery.is_empty():
		return String(discovery.get("display_name", discovery_id))

	match discovery_id:
		"thermal_vent":
			return "Thermal Vent"
		"shell_reef_shelf":
			return "Shell Reef Shelf"
		"pressure_wreck_signal":
			return "Pressure-Locked Research Wreck"
		"wreck_signal_cache":
			return "Wreck Signal Cache"
		"east_shelf_route_research":
			return "East Shelf or Drop Echo research"
		"salvage_data_cache":
			return "Salvage Data Cache"
		"gulper_eel":
			return "Gulper Eel"
		"lantern_ray":
			return "Lantern Ray"
		"hollow_reef_skitter":
			return "Hollow Reef Skitter"
		"glassfin_swarm":
			return "Glassfin Swarm"
		"mirrorfin_drift":
			return "Mirrorfin Drift"
		"glass_ray_drifter":
			return "Glass Ray Drifter"
		"lantern_fry":
			return "Lantern Fry"
		_:
			return discovery_id
