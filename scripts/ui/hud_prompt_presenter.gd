class_name HudPromptPresenter
extends RefCounted

static func format_prompt(state: Dictionary) -> String:
	var labels: Dictionary = state.get("action_labels", {})
	var result := String(state.get("result", "diving"))
	var prompt := ""

	if result == "ready":
		prompt = "Press %s to begin the dive" % _label(labels, "interact").replace("/", " or ")
	elif result == "extracted":
		var surface_tab := String(state.get("surface_tab", "result"))
		if surface_tab == "night":
			prompt = String(state.get("night_build_prompt", ""))
		elif bool(state.get("all_upgrades_owned", false)):
			prompt = "Extraction complete - press %s for next expedition | %s surface view" % [
				_label(labels, "restart_dive"),
				_label(labels, "move_left_right"),
			]
		elif surface_tab == "upgrades":
			prompt = "Upgrade bay: %s select, %s purchase, %s next expedition | %s surface view" % [
				_label(labels, "move_up_down"),
				_label(labels, "interact"),
				_label(labels, "restart_dive"),
				_label(labels, "move_left_right"),
			]
		else:
			prompt = "Extraction complete - press %s for upgrades, %s next expedition | %s surface view" % [
				_label(labels, "interact"),
				_label(labels, "restart_dive"),
				_label(labels, "move_left_right"),
			]
	elif result == "failed":
		prompt = "Expedition failed - press %s for next expedition" % _label(labels, "restart_dive")
	elif bool(state.get("player_near_survival_supply_cache", false)):
		if bool(state.get("run_survival_supply_cache_recovered", false)):
			prompt = "Emergency cache recovered"
		else:
			prompt = String(state.get("survival_supply_cache_prompt", ""))
	elif bool(state.get("player_near_resonance_alcove", false)):
		prompt = "Resonance Alcove: %s record hatch echo" % _label(labels, "interact")
	elif bool(state.get("player_near_glass_kelp_ledge", false)):
		prompt = "Glass Kelp read" if bool(state.get("run_glass_kelp_reading_recovered", false)) else "Glass Kelp Ledge: %s record kelp reading" % _label(labels, "interact")
	elif bool(state.get("player_near_hollow_reef", false)):
		prompt = "Hollow Reef read" if bool(state.get("run_hollow_reef_reading_recovered", false)) else "Hollow Reef: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_salvage_manifest", false)) and bool(state.get("has_salvage_cutter", false)):
		prompt = "Salvage manifest" if bool(state.get("run_salvage_manifest_recovered", false)) else "Salvage manifest: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_salvage_data_cache", false)):
		prompt = "Salvage cache" if bool(state.get("run_salvage_data_cache_recovered", false)) else "Salvage cache: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_tideglass_sample", false)):
		prompt = "Tideglass read" if bool(state.get("run_tideglass_sample_recovered", false)) else "Tideglass: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_rim_glass_reading", false)):
		prompt = "Glass Rim reading recovered" if bool(state.get("run_rim_glass_reading_recovered", false)) else "Glass Rim reading: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_outer_shelf_survey", false)):
		prompt = String(state.get("outer_shelf_recovered_prompt", "")) if bool(state.get("run_outer_shelf_survey_recovered", false)) else "Outer Shelf survey: %s" % _label(labels, "interact")
	elif bool(state.get("player_near_blackwater_crack", false)):
		prompt = String(state.get("blackwater_prompt", ""))
	elif bool(state.get("player_near_lantern_silt_nook", false)):
		prompt = "Lantern Silt Nook: %s collect silt sample" % _label(labels, "interact")
	elif bool(state.get("player_near_blue_chimney", false)):
		prompt = "Blue Chimney: %s recover survey core" % _label(labels, "interact")
	elif bool(state.get("player_near_lower_connector_echo", false)):
		prompt = "Drop Echo: %s record lower-route ping" % _label(labels, "interact")
	elif bool(state.get("player_near_east_shelf_pocket", false)):
		prompt = "East Shelf Pocket: %s recover signal core" % _label(labels, "interact")
	elif bool(state.get("player_in_base", false)):
		prompt = _format_base_prompt(state, labels)
	elif bool(state.get("daylight_nightfall_announced", false)):
		if bool(state.get("daylight_nightfall_away_from_ship", false)):
			prompt = "Nightfall: return to ship | cargo at risk | late Power -1"
		else:
			prompt = "Nightfall: return to ship"
	elif bool(state.get("should_warn_late_day_cargo_banking", false)):
		prompt = "Bank at ship | Power risk"
	elif bool(state.get("player_in_surface_oxygen_refill", false)):
		prompt = _format_surface_oxygen_prompt(state)
	else:
		prompt = "Surface O2 only; ship banks cargo" if bool(state.get("has_recent_health_damage", false)) else "Explore | Surface for O2 | Ship banks"

	if result == "diving":
		prompt += " | %s" % String(state.get("burst_thruster_prompt", ""))
		var decoy_prompt := String(state.get("decoy_pulse_prompt", ""))
		if not decoy_prompt.is_empty():
			prompt += " | %s" % decoy_prompt

	return prompt

static func _format_base_prompt(state: Dictionary, labels: Dictionary) -> String:
	if bool(state.get("has_left_base", false)):
		if bool(state.get("can_ship_offload", false)):
			return "At ship: %s offload cargo %d/%d, O2 full" % [
				_label(labels, "interact"),
				int(state.get("cargo_count", 0)),
				int(state.get("cargo_limit", 0)),
			]
		if bool(state.get("daylight_nightfall_announced", false)):
			if bool(state.get("daylight_nightfall_away_from_ship", false)):
				return "At ship: %s start night; late Power -1" % _label(labels, "interact")
			return "At ship: %s start night; resolve needs" % _label(labels, "interact")
		return "At ship: cargo banked; O2 full; dive again"

	return "Leave moonpool, then return to bank"

static func _format_surface_oxygen_prompt(state: Dictionary) -> String:
	if bool(state.get("has_recent_health_damage", false)):
		return "O2 only; health %d/%d; ship banks" % [
			ceili(float(state.get("health", 0.0))),
			ceili(float(state.get("max_health", 0.0))),
		]
	if float(state.get("oxygen", 0.0)) >= float(state.get("max_oxygen", 0.0)):
		return "O2 full | Cargo %d/%d | Ship banks" % [
			int(state.get("cargo_count", 0)),
			int(state.get("cargo_limit", 0)),
		]
	return "O2 refill | Cargo %d/%d | Ship banks" % [
		int(state.get("cargo_count", 0)),
		int(state.get("cargo_limit", 0)),
	]

static func _label(labels: Dictionary, action_id: String) -> String:
	return String(labels.get(action_id, action_id))
