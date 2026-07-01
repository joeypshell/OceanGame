extends RefCounted

class_name RouteMemoryPresenter

static func format_route_choice_callout(state: Dictionary) -> String:
	if _flag(state, "run_rim_glass_reading_recovered"):
		return "Route choice: recovered Glass Rim reading beyond the timing branch."
	if _flag(state, "run_outer_shelf_survey_recovered"):
		return "Route choice: Outer Shelf survey marked Glass Rim Cut as a timing branch."
	if _run_has_glass_rim_observation(state):
		return "Route choice: observed Glass Ray slackwater timing near Glass Rim."
	if _flag(state, "run_tideglass_sample_recovered"):
		return "Route choice: Mirror Kelp Pass reading marked a deeper kelp seal."
	if _has_scan(state, "mirrorfin_drift"):
		return "Route choice: observed Mirror Kelp reflection timing."
	if _flag(state, "run_salvage_manifest_recovered"):
		return "Route choice: opened salvage pocket manifest instead of only cargo."
	if _flag(state, "run_salvage_data_cache_recovered"):
		return "Route choice: wide chamber salvage cache marked a sealed pocket."
	if _flag(state, "run_hollow_reef_reading_recovered"):
		return "Route choice: lower-route research push reached Hollow Reef."
	if _run_has_hollow_reef_observation(state):
		return "Route choice: observed Hollow Reef upper-shelf timing."
	if _flag(state, "run_reached_dusk_trench"):
		return "Route choice: lower-route research push reached Dusk Trench."
	if _run_has_glassfin_swarm_observation(state):
		return "Route choice: observed Glassfin Swarm spacing without fighting."
	if _flag(state, "run_blackwater_trace_recovered"):
		return "Route choice: lower-route research push reached Blackwater."
	if _flag(state, "run_blue_chimney_draft_reading_recovered"):
		return "Route choice: lower-route research push reached Blue Chimney."
	if _flag(state, "run_lantern_silt_sample_recovered"):
		return "Route choice: lower-route research push reached Silt Vein."
	if _flag(state, "run_lower_connector_echo_recovered"):
		return "Route choice: lower-route research push reached Shelf Drop."
	if _flag(state, "run_east_shelf_pocket_ping_recovered"):
		return "Route choice: East Shelf research push paid off."
	if int(state.get("run_predator_contacts", 0)) > 0:
		return "Route choice: predator route contested the dive."
	if _has_scan(state, "lantern_ray"):
		return "Route choice: observed Lantern Ray timing without fighting."
	if _has_scan(state, "wreck_signal_cache"):
		return "Route choice: pressure-wreck progress secured."
	if _has_scan(state, "pressure_wreck_signal"):
		return "Route choice: pressure route marked for a future return."
	if _has_scan(state, "thermal_vent") and _has_resource(state, "glow_plankton"):
		return "Route choice: followed Thermal Vent clue toward deep glow."
	if _has_scan(state, "thermal_vent"):
		return "Route choice: banked Thermal Vent clue for Pressure Seal I."
	if _has_resource(state, "glow_plankton") and String(state.get("current_resource_cluster_pattern", "")) == "deep_reward":
		return "Route choice: pushed past the reef toward deep glow."
	if _has_scan(state, "shell_reef_shelf") or _has_resource(state, "shell_fragments"):
		return "Route choice: used Shell Reef as a midwater bank route."
	if _array_from(state.get("run_collected_resources", [])).is_empty():
		return ""

	return "Route choice: banked a cautious resource run."


static func format_recent_route_memory(state: Dictionary) -> String:
	if _flag(state, "run_rim_glass_reading_recovered"):
		return "Glass Rim"
	if _flag(state, "run_outer_shelf_survey_recovered") or _run_has_glass_rim_observation(state):
		return "Outer Shelf"
	if _run_has_mirror_kelp_evidence(state):
		return "Mirror Kelp Pass"
	if _flag(state, "run_salvage_manifest_recovered"):
		return "Salvage Pocket"
	if _flag(state, "run_salvage_data_cache_recovered"):
		return "Wide Reef Chamber"
	if _flag(state, "run_hollow_reef_reading_recovered") or _run_has_hollow_reef_observation(state):
		return "Hollow Reef"
	if _flag(state, "run_reached_dusk_trench"):
		return "Dusk Trench"
	if _run_has_glassfin_swarm_observation(state):
		return "Glassfin Swarm"
	if _flag(state, "run_blackwater_trace_recovered"):
		return "Blackwater"
	if _flag(state, "run_blue_chimney_draft_reading_recovered"):
		return "Blue Chimney"
	if _flag(state, "run_lantern_silt_sample_recovered"):
		return "Silt Vein"
	if _flag(state, "run_lower_connector_echo_recovered"):
		return "Shelf Drop"
	if _flag(state, "run_east_shelf_pocket_ping_recovered"):
		return "East Shelf"
	if int(state.get("run_predator_contacts", 0)) > 0:
		return "Gulper Route"
	if _has_scan(state, "lantern_ray"):
		return "Lantern Ray"
	if _has_scan(state, "wreck_signal_cache") or _has_scan(state, "pressure_wreck_signal"):
		return "Wreck Shelf"
	if _has_scan(state, "thermal_vent") or _has_resource(state, "glow_plankton"):
		return "Thermal Vent"
	if _has_scan(state, "shell_reef_shelf") or _has_resource(state, "shell_fragments"):
		return "Shell Reef"
	if _array_from(state.get("run_collected_resources", [])).is_empty():
		return "none"

	return "Resource Run"


static func format_region_memory_callout(state: Dictionary) -> String:
	if _flag(state, "run_rim_glass_reading_recovered"):
		return "Remembered place: Glass Rim - slackwater crossing beyond Outer Shelf; return through Mirror/Wide/Hollow."
	if _flag(state, "run_outer_shelf_survey_recovered"):
		return "Remembered place: Outer Shelf - wider water beyond Mirror Kelp; return through Mirror/Wide/Hollow."
	if _run_has_glass_rim_observation(state):
		return "Remembered place: Outer Shelf - Glass Ray timing marks the Glass Rim slackwater; return through Mirror/Wide/Hollow."
	if _run_has_mirror_kelp_evidence(state):
		return "Remembered place: Mirror Kelp Pass - reflective branch beyond Wide Reef; return through Hollow Reef."
	if _flag(state, "run_salvage_manifest_recovered"):
		return "Remembered place: Salvage Pocket - cut-open wreck pocket off Wide Reef; return through Hollow Reef."
	if _flag(state, "run_salvage_data_cache_recovered"):
		return "Remembered place: Wide Reef Chamber - salvage pocket off Hollow Reef; return through Dusk."
	if _flag(state, "run_hollow_reef_reading_recovered"):
		return "Remembered place: Hollow Reef - side-cave branch off Dusk; return through Blackwater."
	if _run_has_hollow_reef_observation(state):
		return "Remembered place: Hollow Reef - upper-shelf timing, return through Blackwater."
	if _flag(state, "run_reached_dusk_trench"):
		return "Remembered place: Dusk Trench - return up-left through Blackwater and Silt Vein to Blue Chimney."
	if _run_has_glassfin_swarm_observation(state):
		return "Remembered place: Glassfin Swarm Route - spacing window in the wide chamber; return through Hollow Reef."
	if _has_scan(state, "lantern_ray"):
		return "Remembered place: Lantern Ray Route - watch the timing lane and return through Blackwater."
	if _flag(state, "run_blackwater_trace_recovered"):
		return "Remembered place: Blackwater - right-side pressure branch below Blue Chimney."
	if _flag(state, "run_blue_chimney_draft_reading_recovered"):
		return "Remembered place: Blue Chimney - lower side-route below Shelf Drop."
	if _flag(state, "run_lantern_silt_sample_recovered"):
		return "Remembered place: Silt Vein - left branch before Blackwater pressure."
	if _flag(state, "run_lower_connector_echo_recovered"):
		return "Remembered place: Shelf Drop Connector - deeper route below East Shelf."
	if _flag(state, "run_east_shelf_pocket_ping_recovered"):
		return "Remembered place: East Shelf - pocket signal below the Shell Reef arch."
	if int(state.get("run_predator_contacts", 0)) > 0 or _has_scan(state, "gulper_eel"):
		return "Remembered place: Gulper Route - warning-lane timing matters."
	if _has_scan(state, "wreck_signal_cache") or _has_scan(state, "pressure_wreck_signal"):
		return "Remembered place: Wreck Shelf - pressure-route signals are worth returning to."
	if _has_scan(state, "thermal_vent") or _has_resource(state, "glow_plankton"):
		return "Remembered place: Thermal Vent Field - warm clues can lead toward deeper glow."
	if _has_scan(state, "shell_reef_shelf") or _has_resource(state, "shell_fragments"):
		return "Remembered place: Shell Reef - a safer midwater bank route."

	return "Remembered place: Surface Base - safe return resolves the day."


static func format_discovery_memory_callout(state: Dictionary) -> String:
	if _has_scan(state, "wreck_signal_cache"):
		return "\nDiscovery remembered: Wreck Signal Cache - deeper echoes may be readable later."
	if _has_scan(state, "pressure_wreck_signal"):
		return "\nDiscovery remembered: Pressure-Locked Research Wreck - pressure access can open this route."
	if _has_scan(state, "gulper_eel"):
		return "\nDiscovery remembered: Gulper Eel - warning-lane behavior can be studied."
	if _has_scan(state, "glassfin_swarm"):
		return "\nDiscovery remembered: Glassfin Swarm - spacing can be read without fighting."
	if _has_scan(state, "mirrorfin_drift"):
		return "\nDiscovery remembered: Mirrorfin Drift - reflection breaks can be read without fighting."
	if _has_scan(state, "glass_ray_drifter"):
		return "\nDiscovery remembered: Glass Ray Drifter - Glass Rim slackwater can be read without fighting."
	if _has_scan(state, "lantern_ray"):
		return "\nDiscovery remembered: Lantern Ray - lower-route movement can be observed without fighting."
	if _has_scan(state, "thermal_vent"):
		return "\nDiscovery remembered: Thermal Vent - pressure-seal knowledge is banked."
	if _has_scan(state, "shell_reef_shelf"):
		return "\nDiscovery remembered: Shell Reef Shelf - safer midwater banking route marked."

	return ""


static func _run_has_mirror_kelp_evidence(state: Dictionary) -> bool:
	return _flag(state, "run_tideglass_sample_recovered") or _has_scan(state, "mirrorfin_drift")


static func _run_has_glass_rim_observation(state: Dictionary) -> bool:
	return _has_scan(state, "glass_ray_drifter")


static func _run_has_hollow_reef_observation(state: Dictionary) -> bool:
	return _has_scan(state, "hollow_reef_skitter")


static func _run_has_glassfin_swarm_observation(state: Dictionary) -> bool:
	return _has_scan(state, "glassfin_swarm")


static func _flag(state: Dictionary, key: String) -> bool:
	return bool(state.get(key, false))


static func _has_scan(state: Dictionary, scan_id: String) -> bool:
	return _array_from(state.get("run_completed_scans", [])).has(scan_id)


static func _has_resource(state: Dictionary, resource_id: String) -> bool:
	return _array_from(state.get("run_collected_resources", [])).has(resource_id)


static func _array_from(value: Variant) -> Array:
	if value is Array:
		return value
	return []
