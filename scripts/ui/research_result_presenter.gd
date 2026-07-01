extends RefCounted

class_name ResearchResultPresenter

static func format_gulper_research_callout(state: Dictionary) -> String:
	if _flag(state, "decoy_pulse_used_this_run"):
		return "\nResearch: Decoy timing bent the Gulper route briefly."
	if int(state.get("run_predator_contacts", 0)) > 0:
		return "\nResearch: Gulper strike confirms the warning lane is dangerous."
	if _has_scan(state, "gulper_eel"):
		return "\nResearch: Gulper route timing observed."

	return ""


static func format_echo_lens_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_echo_lens_echo_fired"):
		return "\nResearch: Echo Lens caught a weak wreck echo below the shelf."

	return ""


static func format_wreck_echo_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_wreck_echo_clue_recovered"):
		return "\nResearch: Wreck Echo clue carried a deeper pressure signal below the shelf."

	return ""


static func format_east_shelf_pocket_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_east_shelf_pocket_ping_recovered"):
		return "\nResearch: East Shelf signal core points to a sealed route below the arch."

	return ""


static func format_lower_connector_echo_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_lower_connector_echo_recovered"):
		return "\nResearch: Drop Echo confirms the Shelf Drop Connector continues below East Shelf."

	return ""


static func format_resonance_alcove_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_resonance_alcove_research_recovered"):
		return "\nResearch: Resonance Alcove echo suggests the hatch opens into a small tuned pocket."

	return ""


static func format_blue_chimney_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_blue_chimney_draft_reading_recovered"):
		return "\nResearch: Blue Chimney survey core points toward a deeper side-route below Shelf Drop."

	return ""


static func format_lantern_silt_sample_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_lantern_silt_sample_recovered"):
		return "\nResearch: Lantern Silt Sample confirms the left branch is the safer Silt Vein route."

	return ""


static func format_blackwater_trace_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_blackwater_trace_recovered"):
		return "\nResearch: Blackwater Trace marks the right branch's deeper route signal; return via Silt Vein, Blue Chimney, Drop Arch."

	return ""


static func format_glass_kelp_reading_callout(state: Dictionary) -> String:
	if _flag(state, "run_glass_kelp_reading_recovered"):
		return "\nResearch: Glass Kelp reading confirms the Dusk Trench has a safer ledge route off the main dark water."

	return ""


static func format_hollow_reef_reading_callout(state: Dictionary) -> String:
	if _flag(state, "run_hollow_reef_reading_recovered"):
		return "\nResearch: Hollow Reef cave reading marks a side-cave branch off Dusk Trench; return via Dusk and Blackwater."

	return ""


static func format_salvage_data_cache_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_salvage_data_cache_recovered"):
		return "\nResearch: Salvage data cache gives the lab Salvage Cutter I prep for the sealed wreck pocket."

	return ""


static func format_salvage_manifest_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_salvage_manifest_recovered"):
		return "\nResearch: Salvage Manifest identifies a cut-open wreck pocket; shell cargo is optional if oxygen allows."

	return ""


static func format_tideglass_sample_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_tideglass_sample_recovered"):
		return "\nResearch: Tideglass Sample gives the lab a Mirror Kelp return-current reading."

	return ""


static func format_outer_shelf_survey_research_callout(state: Dictionary) -> String:
	if _flag(state, "run_outer_shelf_survey_recovered"):
		return "\nResearch: Outer Shelf survey compares the Glass Rim Cut timing window against nearby Kelp Fiber cargo."

	return ""


static func format_rim_glass_reading_callout(state: Dictionary) -> String:
	if _flag(state, "run_rim_glass_reading_recovered"):
		return "\nResearch: Glass Rim reading confirms the slackwater crossing; cargo remains optional if oxygen allows."

	return ""


static func format_sealed_shelf_hatch_readiness_callout(state: Dictionary) -> String:
	if not _flag(state, "has_echo_lens_upgrade"):
		return ""
	if not _flag(state, "run_east_shelf_pocket_ping_recovered") and not _flag(state, "run_lower_connector_echo_recovered"):
		return ""

	return "\nLab note: Echo Lens reads the Sealed Shelf Hatch; Resonance Key planning can wait."


static func _flag(state: Dictionary, key: String) -> bool:
	return bool(state.get(key, false))


static func _has_scan(state: Dictionary, scan_id: String) -> bool:
	var scans: Array = state.get("run_completed_scans", [])
	return scans.has(scan_id)
