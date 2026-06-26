class_name ExpeditionCondition
extends RefCounted

const CONDITIONS := [
	{
		"id": "calm_current",
		"display_name": "Calm Current",
		"briefing": "Safe routes are easier to read today.",
		"tags": ["current", "return"],
	},
	{
		"id": "kelp_bloom",
		"display_name": "Kelp Bloom",
		"briefing": "Shallow growth is unusually thick.",
		"tags": ["resource", "shallow"],
	},
	{
		"id": "thermal_bloom",
		"display_name": "Thermal Bloom",
		"briefing": "Warm water stirs near the vent field.",
		"tags": ["thermal", "scan"],
	},
	{
		"id": "predator_migration",
		"display_name": "Predator Migration",
		"briefing": "Deep patrols are shifting.",
		"tags": ["predator", "route"],
	},
	{
		"id": "low_visibility",
		"display_name": "Low Visibility",
		"briefing": "Deeper water is harder to read today.",
		"tags": ["visibility", "return"],
	},
	{
		"id": "rare_signal",
		"display_name": "Rare Signal",
		"briefing": "A weak research ping is active below.",
		"tags": ["signal", "wreck"],
	},
	{
		"id": "wreck_shift",
		"display_name": "Wreck Shift",
		"briefing": "Pressure has exposed a different wreck angle.",
		"tags": ["wreck", "pressure"],
	},
]

static func all_conditions() -> Array:
	return CONDITIONS.duplicate(true)

static func condition_for_seed(seed: int) -> Dictionary:
	if CONDITIONS.is_empty():
		return {}

	return CONDITIONS[posmod(seed, CONDITIONS.size())].duplicate(true)

static func id_for_seed(seed: int) -> String:
	return String(condition_for_seed(seed).get("id", ""))
