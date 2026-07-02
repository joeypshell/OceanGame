extends RefCounted

class_name ResearchResultCalloutService

const ResearchResultPresenterScript := preload("res://scripts/ui/research_result_presenter.gd")
const RunMemoryStateServiceScript := preload("res://scripts/ui/run_memory_state_service.gd")

static func format_gulper_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_gulper_research_callout(_research_state(host))

static func format_echo_lens_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_echo_lens_research_callout(_research_state(host))

static func format_wreck_echo_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_wreck_echo_research_callout(_research_state(host))

static func format_east_shelf_pocket_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_east_shelf_pocket_research_callout(_research_state(host))

static func format_lower_connector_echo_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_lower_connector_echo_research_callout(_research_state(host))

static func format_resonance_alcove_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_resonance_alcove_research_callout(_research_state(host))

static func format_blue_chimney_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_blue_chimney_research_callout(_research_state(host))

static func format_lantern_silt_sample_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_lantern_silt_sample_research_callout(_research_state(host))

static func format_blackwater_trace_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_blackwater_trace_research_callout(_research_state(host))

static func format_glass_kelp_reading_callout(host) -> String:
	return ResearchResultPresenterScript.format_glass_kelp_reading_callout(_research_state(host))

static func format_hollow_reef_reading_callout(host) -> String:
	return ResearchResultPresenterScript.format_hollow_reef_reading_callout(_research_state(host))

static func format_salvage_data_cache_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_salvage_data_cache_research_callout(_research_state(host))

static func format_salvage_manifest_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_salvage_manifest_research_callout(_research_state(host))

static func format_tideglass_sample_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_tideglass_sample_research_callout(_research_state(host))

static func format_outer_shelf_survey_research_callout(host) -> String:
	return ResearchResultPresenterScript.format_outer_shelf_survey_research_callout(_research_state(host))

static func format_rim_glass_reading_callout(host) -> String:
	return ResearchResultPresenterScript.format_rim_glass_reading_callout(_research_state(host))

static func format_sealed_shelf_hatch_readiness_callout(host) -> String:
	return ResearchResultPresenterScript.format_sealed_shelf_hatch_readiness_callout(_research_state(host))

static func _research_state(host) -> Dictionary:
	return RunMemoryStateServiceScript.research_result_state(host)
